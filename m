Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F331FCAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 10:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uweo1-0006nD-M2; Thu, 11 Sep 2025 06:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1uweny-0006mq-93; Thu, 11 Sep 2025 06:45:30 -0400
Received: from mail-bn8nam11on20618.outbound.protection.outlook.com
 ([2a01:111:f403:2414::618]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1uwens-0003eY-J8; Thu, 11 Sep 2025 06:45:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUSP6mABJyPpFw3H7USSmqH//g/LATMSnE4hxa7Jyw94CLXPfxbsxN5V4vpO35I2M50pPyZKzJABXKX2LUu1gl0M1z9cXaxUtJzIP092T693fsEIp5SGx/ZBuy3vUFAyGoQH2jHvQirukvA7PKsd5DAW7pImX9M66iQ8TLBayqCd55ShnI47r8SKaK/Nob/g9rXFEfP8p8hoqogn7BgC0BveZ2K8wE6Y68530DRNAGvu4Gw8jRKqSGDNqmazNA1rAs60KcUJU8EhfJPGOfP9un7sCE4mmP9NuOIvP9ycNbvd2tFVXKXinRErsL6MtwYFpLbIhqlqBVrf2PY6JZ6LRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmdSAizFCpGTSlG370hxPWE0NLqXKXLkkPYYrh68KRQ=;
 b=djTexx+6yFLOloI5BQL3sa1jhwSUN5DdSw5jVNdQ4vVK8xZGW1jEMqTWyRupG1vDF3x0Seeqxw6nOsx59v4FBRVH65T7ygJrHRogKt56YsGL/8pNFjhM54cMmjP98I8oZ6at0EPm9KPlbatE0r7PyuEW98bIOoYQByac70QEHb1D/XRhwqX+hAX2dBJEksLd2OA+zFPtEwfwK7HsNd+Fk+4K9qWVVbWSLepWGqOAg+L/o1bgq93I/TJrH5BheqQrmJqKa1imarZbTEUU5KxfOB29+V6x1tUc3jPEjjdsEYMMdffjYXRKdFj9vh5ErItH4mHn7QFBW85SXAYDpNioDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmdSAizFCpGTSlG370hxPWE0NLqXKXLkkPYYrh68KRQ=;
 b=MFjOzlTFSwrqWIbvnJRbZ5IB+/0UAegOBM5b8NCiCrEYT0IIaD5dRZy4beiPyWI0yfVBQlmBVJ3idxJP5VdenxQ8gmHZSYuAsFurTKoc79XdTacA53Oa5AIlj+WHC1HSq0VqbsFgYcBQl9ng2WDBd1vGRxl0XPDzSZaxXNXQdLQ=
Received: from DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) by
 BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 10:45:14 +0000
Received: from DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::4a06:1053:ead5:ef39]) by DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::4a06:1053:ead5:ef39%6]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 10:45:14 +0000
From: "Boddu, Sai Pavan" <sai.pavan.boddu@amd.com>
To: "Michel, Luc" <Luc.Michel@amd.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: Francisco Iglesias <francisco.iglesias@xilinx.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Iglesias, Francisco"
 <francisco.iglesias@amd.com>, "Iglesias, Edgar" <Edgar.Iglesias@amd.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Alistair
 Francis <alistair@alistair23.me>, "Konrad, Frederic"
 <Frederic.Konrad@amd.com>, "Michel, Luc" <Luc.Michel@amd.com>
Subject: RE: [PATCH v4 23/47] hw/intc/arm_gicv3: Introduce a 'first-cpu-index'
 property
Thread-Topic: [PATCH v4 23/47] hw/intc/arm_gicv3: Introduce a
 'first-cpu-index' property
Thread-Index: AQHcE3fbbmIstmoUJUO+P43zFSAp27SN6vtA
Date: Thu, 11 Sep 2025 10:45:14 +0000
Message-ID: <DS7PR12MB574141AED6AD94F017004511B609A@DS7PR12MB5741.namprd12.prod.outlook.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
 <20250822151614.187856-24-luc.michel@amd.com>
In-Reply-To: <20250822151614.187856-24-luc.michel@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-11T10:43:50.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5741:EE_|BY5PR12MB4324:EE_
x-ms-office365-filtering-correlation-id: 58b706d7-9b6f-4b3f-ce5e-08ddf1204a52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?inWFxDsTF2oG8jisbdCHH7ALt+c/RSl2Btn1iIv5Takzk3SjAiAMSbuEmc?=
 =?iso-8859-1?Q?3iXaBo8tKkSgOF6pYKUJMe2mhYOkcYXgzDL7n/W7KVXhA6ST1dx9+EEv4H?=
 =?iso-8859-1?Q?wBayYxBhJg5cLlF8tQ9AEP8zQaaYHAIZI1CrIVlq0vUDY0EMnrinZqhpAo?=
 =?iso-8859-1?Q?IqNE+sWYBZkyGsRNCcUJzEf6//HWkNQRQ0hNuALhoBCxP+zNTTtRU380z8?=
 =?iso-8859-1?Q?nHrLn0E6cyJ0zh/IbJNstp4sBLaazQJdu8rSCDwBJpbmbGxk/whjnIYwXl?=
 =?iso-8859-1?Q?ME6GaZpLmVwKu0fQZ46a4qWptxF3E8ZTiIHrTQFMNwCfqi2+yoPuvbV02V?=
 =?iso-8859-1?Q?AekEkimRCofQgc9wFLoyDfpfAtYsf703OsP3gtE+byXYX+ahe2OXYgh0Tf?=
 =?iso-8859-1?Q?f78e8uxBI2V7PWYeEnidyAUrXZlq4rsMQD7173zds2Rn24/JUvxlZhG6BV?=
 =?iso-8859-1?Q?NDKCM5nXPk7so1p15MS3yPatXl/IX7yPGAtB7x1XXJsMd/Xbulok6pLWUS?=
 =?iso-8859-1?Q?JYXBcDVcsgT+3ibD4s2ZC+YFilLaVRT+Wv2+F5+5+JqXkmprkJwGe05FYe?=
 =?iso-8859-1?Q?uyGUQqrWCXd8Sq17hHh7yt3Rdpn6HkA/zhCWS2VA6r+64oqb5ea11pYmRd?=
 =?iso-8859-1?Q?Cfs2QhwNBTb7X8r0Vj+0kpDKntzYsHuKl2PJRM2Y8fM9LPAChYrf1FBe81?=
 =?iso-8859-1?Q?4wemfclrz7jaiOSAj3VdX/fZt3bs4AMVZEpRb2LCbpg2E5FfrwSznBWwyL?=
 =?iso-8859-1?Q?ScQMrqaaXvwwb68owlv+4Pn6UOnpDS4kxSYAZQHRJAWnlNKamLG/CXSajh?=
 =?iso-8859-1?Q?UxCTAMY7itiUo7JWZqCnqdvh/kxResFahJgsZy8ZVCD4DUYvPkwXy59VVd?=
 =?iso-8859-1?Q?3J4v7cbUvw4/gu7QOUaGPr5Vf9V7JZe1UWEkePc2mU3QoqVKeDFnG3ZGrR?=
 =?iso-8859-1?Q?kCfxbV7UUigWSEm2/YkTrvwywOROoEJ7v8Ha99av+lV25mOY1a4CP8+Ory?=
 =?iso-8859-1?Q?OnxK0SuMOkkDn8yj2hiQE2YSG/S7gWLAAVOlQSrdePVq0IG9VIksQR+b2G?=
 =?iso-8859-1?Q?88PRgL9nqBWnD+tINHITGgonKmTYOuUjUVJtIYPrDh1S0jezkc/357H4x3?=
 =?iso-8859-1?Q?9NAL9KZ51wwWUlmFcEBFdR/jherh9z/x88LaGzgZQXCcpB7ktdcWd7YiZR?=
 =?iso-8859-1?Q?gPDIUSfjpec+vAa/qCuPHb4NkmZFLriNOKYTotBjL088wvRuelKpyuYED6?=
 =?iso-8859-1?Q?fnjG7oLZjlIlkYyGBILHmhg0kuU9a48on8/Mn1Jmi0OYNsJIhRpeXCVKpz?=
 =?iso-8859-1?Q?execgU0vHP8zpkzvvFkGaatKt6Cx1PmqisDUOjjdqh60sGwNwkLzHVtm+J?=
 =?iso-8859-1?Q?SbjxgFm7DwzkDMVby4rdkA2BKPI6Wx5JA4dPX2t782cgrA9HMeop9sse1J?=
 =?iso-8859-1?Q?bYIts7g4TAcFqSUi7q91d6YaPRPB2hP4zWRrp9KLvF6U5mLWnBQDSZSHa/?=
 =?iso-8859-1?Q?tBgHkP5JNSdr7fOi4/pdtVtUWhZIzTDntA3TKktCFqLgPT7cXtx5cROUgW?=
 =?iso-8859-1?Q?eUq17PY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5741.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QE2vdnXda8sfKsYMoLt+p8tMYel7BtaZ6gbljGNYSh8MI+/QN+5V3EUi0/?=
 =?iso-8859-1?Q?L48+pN/Mtd/QUjJeBp5oRBj5VcRlES6+28AcXtVGqL37ciiEvchCpNcBfd?=
 =?iso-8859-1?Q?DnC7RayZ4xCF+9GmwY+IZ6RZX0P8mA8qvNeE+vgaCWQzy6EkPhzvL73sby?=
 =?iso-8859-1?Q?MidmoHWcOTgWsS1G6mi3YicujqpU2kupagfaSu/UO2MdfkN7Asr2toYIuh?=
 =?iso-8859-1?Q?a13LgRFmlY6D+tIwjJj/dRQhlmtcIS+41+fiQ4ei2UIt0S1r36GYdft5Mb?=
 =?iso-8859-1?Q?OtotC3BTaOIKza/96uEBxzERcmWkdBrsgDglrVAr9oPaYpxdRzKj4RGtvl?=
 =?iso-8859-1?Q?a9EMFVF/o4jQGeShONIGwB1nVche9HaGP0Z7ueO4ke0FmDPtPmJpT2GXS0?=
 =?iso-8859-1?Q?Yjp2AqF0mhcREXiwWjekdviam42H4IDjDGunDlaD5bII30epsj1lA+Huu3?=
 =?iso-8859-1?Q?HitBC1zPjDfm3DzAakTTnw+rsrWY9Q+Q0Xwo0ir4BFnLmgMI+x/uFTgLDU?=
 =?iso-8859-1?Q?YNBO+ZzeKqrFKfn5KdVJ80xBR/Gtli7mJnHqsDrmD9H2GAUlawwGowzy6p?=
 =?iso-8859-1?Q?635ZcMrBd8X3gKigQsji3VnZu9z8Xwlh20iqekVVyQSjjBATcKCZ2xY8f9?=
 =?iso-8859-1?Q?YgFl/6FKIVKTsRf6/+Gx1e98sr/UdauBhuETVLykJGRDcB1Lkk6YbSgK47?=
 =?iso-8859-1?Q?NRK7tq/jg2TsOGpiEFiINF35bXkEmyzMYOxHDMnQFh20tC/4s88WXDt6B8?=
 =?iso-8859-1?Q?iBqz6icSCO2T4pwo0IQDRxVQVg1KOCARBpGmxbiJ4zRAPEQp1mmuV9//75?=
 =?iso-8859-1?Q?T1VUXHvdklfiC/B1p1dEAVoTR6DQWafp58Ghm5YSlYbFN/KXWrmMTIYSK6?=
 =?iso-8859-1?Q?jLP08lCkoOn+WdR7cbE+FOnK5v0EmQZ5T1sq3F0kn2oBCY83WdL+vvOJ+A?=
 =?iso-8859-1?Q?sKaYMc9mshggpQSB4frfzULWhFVLVEL2QUYxoXfS/sheAN2sphKS2vUtVS?=
 =?iso-8859-1?Q?crWUfTFh+fKmN0c4yBr4/WOZq8oEAskBVoAkbsbdo5py0oVguWBJ4rcv7y?=
 =?iso-8859-1?Q?sIbdY0qp/5m8Eour6C3qaNelZTKcpvpnM2vd1wzuBlGzeZeNW3YjxI34b/?=
 =?iso-8859-1?Q?WznwnexhZIfhYhxnjAVUnzH5aselwYB32mYS1veTl8f7tcAJxIXMzP6IPb?=
 =?iso-8859-1?Q?02OO5Tb0nHJyCpa1qQlJHbvRVFK618j+tOP/f54nK6oL/0z/lazr0LQYFQ?=
 =?iso-8859-1?Q?5A7f7wfLnRVNmdlr3CINUBT/iE4UqRZUA1lpT7hs2bQaiCt3TDhkWeak6f?=
 =?iso-8859-1?Q?hoigAISRvUGfEv07+kcnnZv2Z94dhjEfhkAiXiyCohf7bN0iLRrcKDnqo/?=
 =?iso-8859-1?Q?QC8LWNnHHZA4eomDaKL2bwFkmcimWgFYXb1TX0ir8w1v7GsY8Lty8Yh4Wq?=
 =?iso-8859-1?Q?3dFTQ+92tplW7vd3uhYZTpW0cI0yOaY+TUUL6b0ZuIZkwr9QyWLqc17Iev?=
 =?iso-8859-1?Q?JkmklaJCFVoa/ATjNOy1qxlFRcQWIZqCldb7i4t4LTBSXPVxWCfY5433En?=
 =?iso-8859-1?Q?za2j3jvcU0U+qQ/O4UTLXHumUIJPxwnRR60D1wsW+S+41BDGnvP5xSE/E4?=
 =?iso-8859-1?Q?PAWznEoo0KmEk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5741.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b706d7-9b6f-4b3f-ce5e-08ddf1204a52
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 10:45:14.4499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0n4aKCs+DRKwoQ3PD/45V9ES+/j83z+Ph4Dz2igKw9x0wgyvmqvsdXIr/Bf4WJy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324
Received-SPF: permerror client-ip=2a01:111:f403:2414::618;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Luc,

Looks good for me.

>-----Original Message-----
>From: Luc Michel <luc.michel@amd.com>
>Sent: Friday, August 22, 2025 8:46 PM
>To: qemu-devel@nongnu.org; qemu-arm@nongnu.org
>Cc: Francisco Iglesias <francisco.iglesias@xilinx.com>; Peter Maydell
><peter.maydell@linaro.org>; Iglesias, Francisco <francisco.iglesias@amd.co=
m>;
>Iglesias, Edgar <Edgar.Iglesias@amd.com>; Philippe Mathieu-Daud=E9
><philmd@linaro.org>; Alistair Francis <alistair@alistair23.me>; Konrad, Fr=
ederic
><Frederic.Konrad@amd.com>; Boddu, Sai Pavan <sai.pavan.boddu@amd.com>;
>Michel, Luc <Luc.Michel@amd.com>
>Subject: [PATCH v4 23/47] hw/intc/arm_gicv3: Introduce a 'first-cpu-index'=
 property
>
>From: Francisco Iglesias <francisco.iglesias@xilinx.com>
>
>Introduce a 'first-cpu-index' property for specifying the first QEMU CPU c=
onnected to
>the GICv3. This makes it possible to have multiple instances of the GICv3
>connected to different CPU clusters.
>
>For KVM, mark this property has unsupported. It probably does not make muc=
h
>sense as it is intented to be used to model non-SMP systems.

Reviewed-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com

Regards,
Sai Pavan
>
>Signed-off-by: Luc Michel <luc.michel@amd.com>
>Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
>---
> include/hw/intc/arm_gicv3_common.h | 1 +
> hw/intc/arm_gicv3_common.c         | 3 ++-
> hw/intc/arm_gicv3_cpuif.c          | 2 +-
> hw/intc/arm_gicv3_kvm.c            | 6 ++++++
> 4 files changed, 10 insertions(+), 2 deletions(-)
>
>diff --git a/include/hw/intc/arm_gicv3_common.h
>b/include/hw/intc/arm_gicv3_common.h
>index c18503869f9..3c2ed30de71 100644
>--- a/include/hw/intc/arm_gicv3_common.h
>+++ b/include/hw/intc/arm_gicv3_common.h
>@@ -226,10 +226,11 @@ struct GICv3State {
>     MemoryRegion iomem_dist; /* Distributor */
>     GICv3RedistRegion *redist_regions; /* Redistributor Regions */
>     uint32_t *redist_region_count; /* redistributor count within each reg=
ion */
>     uint32_t nb_redist_regions; /* number of redist regions */
>
>+    uint32_t first_cpu_idx;
>     uint32_t num_cpu;
>     uint32_t num_irq;
>     uint32_t revision;
>     uint32_t maint_irq;
>     bool lpi_enable;
>diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c index
>e438d8c042d..2d0df6da86c 100644
>--- a/hw/intc/arm_gicv3_common.c
>+++ b/hw/intc/arm_gicv3_common.c
>@@ -434,11 +434,11 @@ static void arm_gicv3_common_realize(DeviceState *de=
v,
>Error **errp)
>     }
>
>     s->cpu =3D g_new0(GICv3CPUState, s->num_cpu);
>
>     for (i =3D 0; i < s->num_cpu; i++) {
>-        CPUState *cpu =3D qemu_get_cpu(i);
>+        CPUState *cpu =3D qemu_get_cpu(s->first_cpu_idx + i);
>         uint64_t cpu_affid;
>
>         s->cpu[i].cpu =3D cpu;
>         s->cpu[i].gic =3D s;
>         /* Store GICv3CPUState in CPUARMState gicv3state pointer */ @@ -6=
20,10
>+620,11 @@ static const Property arm_gicv3_common_properties[] =3D {
>     DEFINE_PROP_BOOL("force-8-bit-prio", GICv3State, force_8bit_prio, 0),
>     DEFINE_PROP_ARRAY("redist-region-count", GICv3State, nb_redist_region=
s,
>                       redist_region_count, qdev_prop_uint32, uint32_t),
>     DEFINE_PROP_LINK("sysmem", GICv3State, dma,
>TYPE_MEMORY_REGION,
>                      MemoryRegion *),
>+    DEFINE_PROP_UINT32("first-cpu-index", GICv3State, first_cpu_idx,
>+ 0),
> };
>
> static void arm_gicv3_common_class_init(ObjectClass *klass, const void *d=
ata)  {
>     DeviceClass *dc =3D DEVICE_CLASS(klass); diff --git a/hw/intc/arm_gic=
v3_cpuif.c
>b/hw/intc/arm_gicv3_cpuif.c index 4b4cf091570..1af7690b958 100644
>--- a/hw/intc/arm_gicv3_cpuif.c
>+++ b/hw/intc/arm_gicv3_cpuif.c
>@@ -3022,11 +3022,11 @@ void gicv3_init_cpuif(GICv3State *s)
>      * registers with the CPU
>      */
>     int i;
>
>     for (i =3D 0; i < s->num_cpu; i++) {
>-        ARMCPU *cpu =3D ARM_CPU(qemu_get_cpu(i));
>+        ARMCPU *cpu =3D ARM_CPU(qemu_get_cpu(s->first_cpu_idx + i));
>         GICv3CPUState *cs =3D &s->cpu[i];
>
>         /*
>          * If the CPU doesn't define a GICv3 configuration, probably beca=
use
>          * in real hardware it doesn't have one, then we use default valu=
es diff --git
>a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c index
>6166283cd1a..e6a09c9b7d0 100644
>--- a/hw/intc/arm_gicv3_kvm.c
>+++ b/hw/intc/arm_gicv3_kvm.c
>@@ -807,10 +807,16 @@ static void kvm_arm_gicv3_realize(DeviceState *dev,
>Error **errp)
>     if (s->nmi_support) {
>         error_setg(errp, "NMI is not supported with the in-kernel GIC");
>         return;
>     }
>
>+    if (s->first_cpu_idx !=3D 0) {
>+        error_setg(errp, "Non-zero first-cpu-idx is unsupported with the =
"
>+                   "in-kernel GIC");
>+        return;
>+    }
>+
>     gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL);
>
>     for (i =3D 0; i < s->num_cpu; i++) {
>         ARMCPU *cpu =3D ARM_CPU(qemu_get_cpu(i));
>
>--
>2.50.1


