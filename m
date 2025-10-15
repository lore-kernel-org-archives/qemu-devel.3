Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E56CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 12:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v909Q-0007PV-1p; Wed, 15 Oct 2025 07:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v909N-0007Oo-Vl; Wed, 15 Oct 2025 07:58:38 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v909B-0007nK-R2; Wed, 15 Oct 2025 07:58:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+AnldOhnWiJOXuepu/WfIrcJBO6ASCf7zVQHtB7G9elw5V1gXln1ZW5UNPTwkobb4JwzzcYnxIWnk6CtQR9dL/gsVkzed7I58QKzkgQKIzy0yRJm7UlhcEW3ajhsvVIrp9vwK6/DQdeWGjq2305X9D66zrSdSPIL3S6PuONQw+hN43yBVnohPw7unbO5vNtWAoqYi9qi3EeJBVQDw1pB5rYBIDM/dffxRYtDVlhIZqhynJ2Z7juAj9jeFv93sMr3/evGstZ+2EMs0OiSGnmxpcV2mT04PaVBMQH15tBmgAIzDygc2JLYX8uTTD1mbHGL/X8kwsDtWK+U1pM9nFyAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4KBazVfEid2gaSPREfx/zq16YcEM1woDFNWp9mRo40=;
 b=arYcuylgOoAN6vapFRvnLGROmGcpZofXvQwgdiKUx/ZxkdjP+dJdQAtgdZVXzvjBL4RTi8BQJsZPOp93cElBMwP/9P8wfaXPAtf5m6PoOELn2kQHgjhSX47EqdoZv7ZkZEZdDxlONibSJ03wjmiRxi1nkpaKB9K4cDiFItHqsYfWpTvHWHjbt5GuZ1dog0tui7zx/8qmNv7Ta5RYqzBib3lbjNNlrvgH5puH3nfSE4zNo51I6MpNYNRMbpPibOQAwqIa9AsqLYxCbrs5DjDhoIxnfYovZ9BDKhtLTXC6rBTt7nnM2bywppe977lHMk8h0iyy990lTasFBMZsmKE8WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4KBazVfEid2gaSPREfx/zq16YcEM1woDFNWp9mRo40=;
 b=NzIE2zArm/wRRHqGsmWLeVyjs19ysvn39FZJMt1F69xfNQqYfqJLgYCDrvSYRAt4b7C3rZBXUdysegAifYuY9I3Y7SYjhuDdIe1C5Jl7tBumpmb5dNl2N9ioCjatqa2kjfiYM/XzK609NlViNXIoZKWuRNYtovga5uRsmQSDZDz5aBfdIsIkpjd7RRxYHd09r51ONnfm5TckQkTILQ0pZjn7Y+m2mYUg4BPPPN6gifj2FELDpYndq8d6fIxY2wlmubKnlmEI9xx1yTYgb6fKop7JTjeMoXE2CRVqS28x7yd6PBzDIPgvHTqzkuuYsfhBu17TYo5xZRwSBX6LEenoQQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AS1PR09MB5739.eurprd09.prod.outlook.com (2603:10a6:20b:477::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 11:58:16 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 11:58:16 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v11 03/13] target/riscv: Add MIPS P8700 CPU
Thread-Topic: [PATCH v11 03/13] target/riscv: Add MIPS P8700 CPU
Thread-Index: AQHcPcr9OW6Nvc5TOEqSyqdh+Usgww==
Date: Wed, 15 Oct 2025 11:58:15 +0000
Message-ID: <20251015115743.487361-4-djordje.todorovic@htecgroup.com>
References: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AS1PR09MB5739:EE_
x-ms-office365-filtering-correlation-id: 3c2cba39-d34a-4663-b712-08de0be22055
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?EtQWm13qMZ+oiCuxUghXt0K3E80GHOderDbvh9Un92apIxqv3JLzCtaLzh?=
 =?iso-8859-1?Q?wLMEDDjKCm5RD4FCMCj9kgIu9jXvzNN9p5GnV41GaB/iY7r6ZmE0FG/jLr?=
 =?iso-8859-1?Q?ImQueXbTbdXsKTwSncV5oKvkd+ehzryI5w5efWX0tPmp4qCVX41Y34XlSx?=
 =?iso-8859-1?Q?SO9hrNfUAGA0YqN73aFj7iJmB8x4M++bKZjDWKAS9IDNrNtRyhcwjaUbdA?=
 =?iso-8859-1?Q?CG2l7YHWDM0f8f3JJg/YBSgh5QBhLZ37bbTJ946MqBVNTVUDy0OlOuyOiE?=
 =?iso-8859-1?Q?B7whe0mRRjl9wzYVuluYuZssc4EVh/SVExvBBWx846HX27CQ3wALI54UWj?=
 =?iso-8859-1?Q?w43m//TmpCepkv+iUoZEfWDr8bh5gA8Z0g8mUpSKtMNwas/JwRH8YYbjQg?=
 =?iso-8859-1?Q?xNkQUwURan+p4G/mgXsRrhGmJFV4IrEUQaKQexDGNG2rpvbDF+Ciseg21k?=
 =?iso-8859-1?Q?oUlSZ5bFkqFp1UY/gFnCGzNDH6okQCNSUGrNeBjirxfEyB59G6kDnF297J?=
 =?iso-8859-1?Q?8LDccsmEN3Lm3URBkNx/UTc0PS3srZwJbz3pnIdT8i2cYoQaK7NjQZ51qG?=
 =?iso-8859-1?Q?GPSR/36KffI9Hr/ZjVRSteAIhlRjAMrslBmDH8nWRuiGmdy7b4yMsTJwzR?=
 =?iso-8859-1?Q?F+YtYCBxSGeJXWtcvU3chGX8RLu/e8717Y0+0Pr69182hLp7bQc78k3hjC?=
 =?iso-8859-1?Q?K3rqSy22AytYfwRd4lCo0sVb3gnZPFtuVSo00ZsBMP8FhThg+tB/d42Yld?=
 =?iso-8859-1?Q?fqccTgD3qlwpicmeZhdmBVa7JX7YuUXGLJ76T1/s3V/oHasHFAGrruh09j?=
 =?iso-8859-1?Q?leaqcnMgG5ofVlXu0o7skqzehoyOErqD6ebphASw5wEUl5VtyImrPleiUZ?=
 =?iso-8859-1?Q?iZh442eUuuuSzYc30f2oZTEILk/UIDhD/ilZ6Hbr4h5iWPnnXxPfgZ1RcJ?=
 =?iso-8859-1?Q?ZIA21kDeJlST5KICbftVvNhmaObqlNe2i5jVvcRZtlgYlcDyrv/ZyOMlUS?=
 =?iso-8859-1?Q?1Y4jzsuRJjpk9R1F8RC2xtWawaLdxDeFCi8uBUhTjs0Md9RqlefR4EQ3z7?=
 =?iso-8859-1?Q?Efpkw6AAWCQ7Jl18+cHrIty9Ts0YZUd0Ky6h5bg884+zDWAV6juGDzsMwp?=
 =?iso-8859-1?Q?8MDCkolRm475jJyPXOp8J4cVSYm+jWhqNliFwG6ytGDgXhmA1fyYcVuBJ0?=
 =?iso-8859-1?Q?tBL1i5Zfri6SpKwAx5xw1h3adFvDx/4IMg3t0WwHL+40ImcB6JxF9avNqN?=
 =?iso-8859-1?Q?TLkVMXT8SHvJ2i3rTfWjlide4VCiFFPwFYI9WBaeJTH8RdheeS5GD4snkB?=
 =?iso-8859-1?Q?yaLuKHH1O+lVX+GjO/5yKqeXlatTJ59RC7YrV9W2J7cWK9yWArdzHRk5uQ?=
 =?iso-8859-1?Q?3RaRKdeamFrXRaMuDf92t01VlKwelZ2lViMti3EixRPNYVPWeiaYfbH/W8?=
 =?iso-8859-1?Q?DmWODhNjE+25/rFnFAORbXyGdhnELYWhqgyLyZnPrer/oh5DAsKiM2Acep?=
 =?iso-8859-1?Q?+sP3ix/vCD7CnNE/e0lnp272o7p6GhKCfwkXO9q8vA3XDRzmLZK+CfAmnc?=
 =?iso-8859-1?Q?TJ6gXDMDfgbvRuqTZmwU7XKvMMz/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z0M3bir0+xjq8BAxoA92zb+OmTQjvzikp2p7+OGE5phN8tpQH63RQbzJKI?=
 =?iso-8859-1?Q?eU0Qnwf6e8QRvOHnrHwZ6btmmC8jsKfMJHn5NqqpsDhRmq5I1uzoX8KwH+?=
 =?iso-8859-1?Q?4SWvj1WLKF8jAXshU3O377TmyeuYsVjGuXeWaVnn42gPjWTEhKjpQO25VJ?=
 =?iso-8859-1?Q?pFZaVZwjGmxQXYxmEKQdHna6OgRQsR8s4j3ju6hzcbxmhEGP0YISe7BBWl?=
 =?iso-8859-1?Q?CyWTW8Dm5MYyQMhLPuD03LIClXTPYrG4f/k7tThuZzkRC2sNs7Xok8Yweq?=
 =?iso-8859-1?Q?O6UigXZVtAn/TKbck4bSAXHVOWXnVH2xU7tBKpjkRdHp50yF+3IwuWrwCP?=
 =?iso-8859-1?Q?pbbsjVpiQ6EDgXakJ0nmcf/XobynwPMD4K5kGJdM+e7gTKsJEEtv+8VhbK?=
 =?iso-8859-1?Q?BTEfBQL39jVb01MDG1hc3UI4KPC1CCd0VEGGlUD1KxjdmoU3xml16oDvO/?=
 =?iso-8859-1?Q?UNy7EBCRzd4q3bHmgkC4fhJMPnHPNPneKWVZzXrcvFky/eZY3pJJqrqNi1?=
 =?iso-8859-1?Q?61Vep/8eQuQWJe4n0VnK/unKvarwDtc6aUshNhPCL0kpM6KYmwySSFRkSs?=
 =?iso-8859-1?Q?MRs1wVJQ5Ew1JgMM5xp//vayvTf9zORMRFtY8gwRuxc7fEdR+qXLjqKgO4?=
 =?iso-8859-1?Q?ekF3gnBSXzTG8/FTot0PCuMyDua1h07icKA1Qg864ReZ1HPU0GDOUfXxoG?=
 =?iso-8859-1?Q?NTexY0b3iVmgLB2XkVjhYMQJCMoSBMgLMHEbK4ZvnsK7xErrHZDa0dzxOD?=
 =?iso-8859-1?Q?3jvYwYMb0C+muBfS4Dy3unPhfdaQ2A/XT85By3NflozOVKmW7bHJ2hlQTm?=
 =?iso-8859-1?Q?Jo5HFSLXStpQTtCbY4lVezppV/Fyh201fR4sIgkfvJVkefXb+RcDidFexr?=
 =?iso-8859-1?Q?oMO9fdXd1AqLE/5F5nzxpLmFHEl/T3383tzanicQHaTj9H9CmTS7sWRzs+?=
 =?iso-8859-1?Q?K6ilwjAa0wleyqGFGEuiPRaNt3810ZZjsX6l4Njs/syLeSQtHgGBMb6jxq?=
 =?iso-8859-1?Q?RXTdRxx9MBg3XAMkvPo12ZwKgD4uUIE/4uLAcDt5Evl7R15PzjFfNfTKzA?=
 =?iso-8859-1?Q?0C7nuIkKsEZ/Cr22ENFX3cgbcQFyRP8u1Rglb1/YcwdGB4kXFsaTx+pa43?=
 =?iso-8859-1?Q?fRsST/mfC1gsG8IOoIqEUJlBNC2tUWbh2Cd9+b8bcSuHzWKnxyBAe4Ljvu?=
 =?iso-8859-1?Q?XEFL36ACc+q5oDCmcHZXTGJKdVArrRvSJ56nhF8SHIC7O2dcRVRxJdW14a?=
 =?iso-8859-1?Q?eH44LyR4kKosnEpOaKNz6/ZZp0/rrbMtXw8A639WZmUO9o0sCrnJQRfaBO?=
 =?iso-8859-1?Q?IN+QZqofsxwzYhhFToOdTFBd0E1I7L+RrwDhiztddf32qZyOJoExUX5wTP?=
 =?iso-8859-1?Q?IASJkwrw01/znIc38AYZBjZYFBV/yvRTJdaW/iJWDTENMaIzpMCm/qAJU6?=
 =?iso-8859-1?Q?fcDYvfYCkWhy3vrYL5nVMbO7z68uOmROPfTmZZufbGVkyfsSfnQj36DrKR?=
 =?iso-8859-1?Q?t05r63TU9iCdOBMYEUX+hDnSZmaWptuVLeFpkuQBvpgwT1F4ODXRRgAPGo?=
 =?iso-8859-1?Q?Rcqy4rDcYSb4DVpJXGqTQ5wHy4Lc3IezuNSNa/SQ3ZFuzaJPLkhCKZmH85?=
 =?iso-8859-1?Q?Fpp3UY6dCkaYr/lS6cp3HrY+usyz/RAqf25kF/9PXx+HAn8wQKDzAxNFNk?=
 =?iso-8859-1?Q?VhcMLDqTbK1Xrj3qwuU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2cba39-d34a-4663-b712-08de0be22055
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 11:58:15.7819 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ABY6FjxjwCoLfLYnNh7mybb0lHcp2IkyrmUWDc0H8xdP8y0uxYcEk6os8sEg3bUooFxWy6XMr1M+fovhDmzU3pnbWSPw3kSCZaMBErSIkKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR09MB5739
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce P8700 CPU by MIPS.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu-qom.h      |  1 +
 target/riscv/cpu.c          | 16 ++++++++++++++++
 target/riscv/cpu_vendorid.h |  1 +
 3 files changed, 18 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 75f4e43408..30dcdcfaae 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -56,6 +56,7 @@
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nan=
hu")
 #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kun=
minghu")
+#define TYPE_RISCV_CPU_MIPS_P8700       RISCV_CPU_TYPE_NAME("mips-p8700")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
=20
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7932ba6873..cd4e442bdb 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3283,6 +3283,22 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.max_satp_mode =3D VM_1_10_SV48,
     ),
=20
+    /* https://mips.com/products/hardware/p8700/ */
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max =3D MXL_RV64,
+        .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
+        .priv_spec =3D PRIV_VERSION_1_12_0,
+        .cfg.max_satp_mode =3D VM_1_10_SV48,
+        .cfg.ext_zifencei =3D true,
+        .cfg.ext_zicsr =3D true,
+        .cfg.mmu =3D true,
+        .cfg.pmp =3D true,
+        .cfg.ext_zba =3D true,
+        .cfg.ext_zbb =3D true,
+        .cfg.marchid =3D 0x8000000000000201,
+        .cfg.mvendorid =3D MIPS_VENDOR_ID,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode =3D VM_1_10_SV57,
diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index 96b6b9c2cb..28f0ce9370 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -2,6 +2,7 @@
 #define TARGET_RISCV_CPU_VENDORID_H
=20
 #define THEAD_VENDOR_ID         0x5b7
+#define MIPS_VENDOR_ID          0x722
=20
 #define VEYRON_V1_MARCHID       0x8000000000010000
 #define VEYRON_V1_MIMPID        0x111
--=20
2.34.1

