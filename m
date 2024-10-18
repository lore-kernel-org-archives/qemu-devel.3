Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64EDD30009
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1mwy-0004og-Bv; Fri, 18 Oct 2024 09:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1t1mww-0004oP-2a
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:23:26 -0400
Received: from mail-am7eur03on2103.outbound.protection.outlook.com
 ([40.107.105.103] helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1t1mwu-0006Ia-3I
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:23:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjyMzQpW6Aa3nN+x1kldc3neVBAAv4U89rfH74cinD6vupb3NjQCYyvNYkyKQkGtiyyZr2EymeWnluqGNq/C8IKCeZyJ1Ocicu6rC9iBeA/xcDUWUathYWVRf2cIdXuUJazySQx7kfJTWROIT6I/e/Yn5qmYc889d2iqLGe16bxeoRIqbKke7H8M38xKi+OiPDaStuiNMkfkKDdvxl7hUMfFk1VqFsNhJL6ZmDOg11JtwFUT3wNEXdi5e7gGhSHfs2Agld5wn40Z0hmmtQFK0WpThctiwAyJomO1KW1vEKzMBoqOj3I692AOLqXinhHnUF+K3a/g5aIeGx8Y2u4c9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lm03zBfvAiCdRLFJgni1FL/+iYm4bLa2ps93u1DUdFs=;
 b=WVbtpRtnOvgdu3sZErlgqkBMgidDWOBUUNYQeUmuQBzFk/JZ5M3PXgu9bxMCfsIkEa/xAU4XfgBIfjISH+9dAzK29vlfqDRTyNOtmjPN2KxwJVKLkIBlrniHO+R9ATfod1ia7txmb/6Cqd2gsBZZI2yM99NtY7VDdgmiBXyMpTCyhhv5TOnmrj3T4dYUUAu65AaCjeROAfmedl0xK42/q5BNL2MVlbuiHxLes6DDgBkxPqhcQxJAMeczCNCMVKfzcgcW+x3RkXEXrmRwQs9XPfn36zUxX4vRFKfbkQFrD1X4tlhYqD2y54EN0wBQVdXsWgJxkbACBnE9MbDyxIaRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lm03zBfvAiCdRLFJgni1FL/+iYm4bLa2ps93u1DUdFs=;
 b=W+U06JZ8/QE6l+gq8OZrBJHnBWvLqC/xC0RzKbnP2t80jc+0S/OtcD+W4g4iJ6q2Jo5WMo6OEuueglvMUV/krwIG1qxyt881wDQQgV6RrMfkfVr1hKjPqsc8lSFfYL2cxXljfI38dUV+lntTRTmuchCOdjov9F1YksLgC7wl1yXUhpE5hyD8+TAzJ1iLDb7WyEY7a/DZaE6tcOarRaIpfV15sPdUq5LrW7iGsJlvHBm3b8MYABQ3Rr6w+eumDvgAvWjh4WS2WKu2aBK7LiQAPauQrn6O6M1rLkQgZQWh9NDLhf5IBn7Le1SHa0RJe7n1SOEm51rff7uxQmRT84Ee1Q==
Received: from AM9PR09MB4851.eurprd09.prod.outlook.com (2603:10a6:20b:2d4::13)
 by DU0PR09MB6298.eurprd09.prod.outlook.com (2603:10a6:10:415::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Fri, 18 Oct
 2024 13:18:15 +0000
Received: from AM9PR09MB4851.eurprd09.prod.outlook.com
 ([fe80::2fed:370:dd45:13a2]) by AM9PR09MB4851.eurprd09.prod.outlook.com
 ([fe80::2fed:370:dd45:13a2%6]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 13:18:15 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Djordje Todorovic <djordje.todorovic@htecgroup.com>, "cfu@mips.com"
 <cfu@mips.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: [PATCH v2 0/8] Introduce MIPS64r6 target
Thread-Topic: [PATCH v2 0/8] Introduce MIPS64r6 target
Thread-Index: AQHbIVukb0ThX22GYEKK+nK9KMRFUQ==
Date: Fri, 18 Oct 2024 13:18:15 +0000
Message-ID: <AM9PR09MB48517A4B3BE0FDC18920247884402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR09MB4851:EE_|DU0PR09MB6298:EE_
x-ms-office365-filtering-correlation-id: 264f9405-5c3e-4856-fdac-08dcef7752f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?EoRdhhK+RK4K/JqdnEMYTkbQay3ZQIyNXtd63zBH8pYMd3zFtHf+Oueu6G?=
 =?iso-8859-1?Q?4hKkEYtlKmUOdq3DIBezM3jdnjOMHmbb6VMSFbpM6Qa83tHy4ICVL6Og7M?=
 =?iso-8859-1?Q?YU1UDBuXtrkjLPZMTLpYSdj54+iBkNpNOYb4y3VGEH5ECRn6UY9Lo9wO4X?=
 =?iso-8859-1?Q?8G/Toho3/IXoqdg1qB7dyYQfds3AbENVKI0/a/CcP2Lhf1BNEl6uTjT3sa?=
 =?iso-8859-1?Q?OmF+tYG1YvR+9KHs/ygn1MOeHk9oKcoAlqUnl82OiuEsyJ1vqQLBOy9jff?=
 =?iso-8859-1?Q?HvNl5KPhHyTHv3hpCE4Q+6lSqwIGdje92xSk3fkGwkLAbU7dbr3CeCiR5z?=
 =?iso-8859-1?Q?QMV6/7Ob4D1I3W8vQGixpn9ofkduetvZO3FGDap4a4j00ZyyBd/K4YXj2a?=
 =?iso-8859-1?Q?CrtW02UDBoXX++2dFrXEC+XSx4xCLr6TX0JH9VoGEqSFosaSjCA3ep6cRK?=
 =?iso-8859-1?Q?tzoONmn++RIqT4Z46EseOcr88l+uaeGD/IGbT4Qo4PaypO93LbNqZ+uvSr?=
 =?iso-8859-1?Q?+wTlpekWZSIaGPyzxzQpJndnLv0UaTuS8fCd7tRc3UWJH+1HERXrThD2bf?=
 =?iso-8859-1?Q?/csOiE0hr/hGvl//Y3oWfIqnYMv7FcIfwnIxzePCPlZ96YAEK9jpeFyKfQ?=
 =?iso-8859-1?Q?sLsFz29rXcWhYyMOwvLm4mJnzwhSRqMjp+HrAFXRg7A/XV5Fz5a41Od9Qw?=
 =?iso-8859-1?Q?nZGP9hPWnBzNjPUVYtuxZCwvyQHV5dkSseoJ670rda2nFpzbfDbVftSW/F?=
 =?iso-8859-1?Q?/GB69utegmCPizyeJPPklvU2wISttfYZ82Retk0mZLVF6UyoAbO4U8CY0s?=
 =?iso-8859-1?Q?KwgBl16kJDJitvkn+aLwDsPR7Lod2vS2lkBEB+N+HG8UaevOj49fa4XUIK?=
 =?iso-8859-1?Q?TQtQe49ep2L3AWfy5p9tm+RbPUlWnjRYZBEK+A9i5jOv58VJb9MYGOM8Ue?=
 =?iso-8859-1?Q?pJuM+DtLWDoeYuNA2V68PC4OXmoe2pMB7VoXdgZr8EPTRzG0W1/o3MNK3w?=
 =?iso-8859-1?Q?3GDlwTbwARr5AvL0b7K7vSNDUc9QvBE0dxppvOj8yJbZpV/Fb3p8DgdCT/?=
 =?iso-8859-1?Q?NfaJv7o684yvcxOfTq5xUaelQNbTgrzMCnoxx2aDdWlVVYKNxD47CYjDP2?=
 =?iso-8859-1?Q?rg4B5Jmxb1bXP430FqpGJoMKZIM+QudPRoedBVo1KOTPTeFn5WqZPcm59t?=
 =?iso-8859-1?Q?6S+nPgrXWMSLMHDHhaNakRuDGquolppkwPgbtFwtlL8BVjneMItRr+2HtX?=
 =?iso-8859-1?Q?uZfy65c4m4d3PG6G5ygTetb8huZGF621ppjz1c7zs0hvR5uHP2S2uLt4m3?=
 =?iso-8859-1?Q?HXX+LFoj5RL0NY+JxlgvCpQejnA2PRZMjWQf1ILwz7j1sANKc6/ibNAv3e?=
 =?iso-8859-1?Q?KQOGRHM9TVvso72GjC6PAisUAzXIuas3Sl3sW++6wdhQLd/lysr8yD3nYN?=
 =?iso-8859-1?Q?qzRzu4AJAy0sduig?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR09MB4851.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b00T9Oc9MlJDFE/rJV8AAu5I1fiQBmb+tHWU8oW+SsSGQHr7gFttCJO5tw?=
 =?iso-8859-1?Q?MnZYIvg104bwz3xmppekC7Ni1cnXKjVFXJsaDGG51+zHWteVqRvkaAeP+P?=
 =?iso-8859-1?Q?c5u1T6VimFe2QB9rZKEJhD+THTKZV4tVmRirSvt/++5cWNHwYziZvqb7ez?=
 =?iso-8859-1?Q?iHwQ23iJAkhZ77YZaGOM2EPDZ8mpsC6gudFpBemEU/O6usxxRKGtVB7I7F?=
 =?iso-8859-1?Q?8j1lOiLp1d/iXsGT7EEF9EZLxeQE8/GVNkHNlQWrt7Ng3UF1X8Fq3Am9k6?=
 =?iso-8859-1?Q?+z/uFCFFt0hvpl+5uRz3E/qyxFYOwgnzJ7zmI/jd+Gfw/DcHARznRKBnSt?=
 =?iso-8859-1?Q?Sv83R2a/xqqUHonwOk3ttEB79Pc8WCStsu+YAeYOg2Ds1ww15duNDlGG31?=
 =?iso-8859-1?Q?BZQgmuCOcA1q+kkE6/vf3fgYz/O+8nDoBZdcy6bOUbNDVseNE37Seij4CN?=
 =?iso-8859-1?Q?04DEj6bMX796sRdEOBzjYnG3F9DAh0Xpq6/XhzCIqj33zse5bb6S/JYGc9?=
 =?iso-8859-1?Q?NzbVlpZiq9GxqbBmVAO52mGxqMNFbpEt9kJy5Q+tY3CFwoin1W0q892ViZ?=
 =?iso-8859-1?Q?3WrqwpDdO8noletAlvMK6XWbJ/nlsW3OYPOLpGqR2EEOgDZ62b6S/9LHYb?=
 =?iso-8859-1?Q?NJ+6rsd6P2CNfBus04hEpfpAX7gI9uH+Ol41ZlKAVNTr7ol5E3oiHcKEal?=
 =?iso-8859-1?Q?V/UC6VLgdjG3B68kARG4OP74TZCbU8XHB/Ve+jba8rsAaqNNilUGo4gx64?=
 =?iso-8859-1?Q?lDxjSo8ccUaeIhegi5J1/BpEroUczfftiNJSGTyVMjHlQtYb51V4YL2rPf?=
 =?iso-8859-1?Q?PxXRp3BYgKg3zxVgf8x5a7Hnw+ve8gHfbesNErkWzpyjJ4G08s4IBWwXmG?=
 =?iso-8859-1?Q?9jWLvOLJV2RvbgL0nVSEh9SxNkOZ+HpB7KI9NjySPyQh62GeahBKyslvmD?=
 =?iso-8859-1?Q?hnvSGmoZFVQUenYQ7NJ2DFYYt1hsYCikoFHtozYd1NrW6MYieJe3gLN4Hg?=
 =?iso-8859-1?Q?pM1CwBhFwaKOGozInAResuRDgx1iPx5ppBJFlltVdLKkc+YHPofoOfQY2s?=
 =?iso-8859-1?Q?RFHuyCN30NGm6Y5X+pCeDEraEpus4eKZiy24b59nMr30PNLB9PDkn+zV5E?=
 =?iso-8859-1?Q?dJLKy7GgPb6V59Muxmff0DUJ8Sii/nkpl38nkDB5bOBO5L3hGyQgXnHl2R?=
 =?iso-8859-1?Q?W5fcPdKtDkpqiwOCHf5QPHVAZGPeJTee87lPA2svNv+6clC66DNY3bn6G3?=
 =?iso-8859-1?Q?mpjiMuICO6yU/j7vEfehn+n0TJz1lMzIvEeMk94utK9FOcpL5ibbMBlTgd?=
 =?iso-8859-1?Q?s8qdQ2SDAcnPIBKrhWxwUvuCtD6UVeF4qN40Ude+PBtqOCNRPOHHqKbeLB?=
 =?iso-8859-1?Q?gyac+loFQJ4Sso4Ez2M+Hrot2v6R4KuAJkaNrV3+lsR54aY0AEY2kHZtaY?=
 =?iso-8859-1?Q?WbyBVukuTl2NnO/ZSlEtOlbQjvVXiG4LPAct5I0Kt7LjYYRnCwSs7adJdK?=
 =?iso-8859-1?Q?/i9AP9HdsczPz/3LNqUgOcVTVLc4uGx/swJwFNnZzHvFk4+HikMJvWEAm1?=
 =?iso-8859-1?Q?q4a8hebFjEV8bdj97oMzQHJXVG4noiZOptdblnjx9nmJ0oIfM/T6kyJLoB?=
 =?iso-8859-1?Q?7vkS+0GieMHz0L9N/gtg0TSR6FPHQ3bHVHEChRoYnjGuAiQUYemPcb5Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4851.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 264f9405-5c3e-4856-fdac-08dcef7752f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 13:18:15.1340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7KXTfwGJMk0mcGG8P59tfNOrkyDVdxiQ7Zygk8TDrVi6E8YQvrTfKUygxRNFkHKEezZicI+hA1+s2ILfW8dnDB+z9k+Eofhb2BWUqRf1NWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB6298
Received-SPF: pass client-ip=40.107.105.103;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.249,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch series introduces support for the MIPS64r6 target in QEMU,=0A=
bringing the latest architecture features and improvements to the MIPS=0A=
target. In addition to the new target, this series also includes=0A=
several bug fixes that have been in use internally for years within=0A=
the MIPS ecosystem.=0A=
 =0A=
These patches are cherry-picked from the branch mips_rel/4_1_0/master on=0A=
the MIPS' repository: https://github.com/MIPS/gnutools-qemu/=0A=
Further details on individual changes are included in the respective=0A=
patches. An instance of a pipeline of QEMU CI jobs run with input=0A=
variable QEMU_CI=3D1 for this patch series is available here:=0A=
https://gitlab.com/rakicaleksandar1999/qemu/-/pipelines/1470628690=0A=
and for the master branch is available here:=0A=
https://gitlab.com/rakicaleksandar1999/qemu/-/pipelines/1462140373=

