Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F46D30007
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1mug-00031p-BH; Fri, 18 Oct 2024 09:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1t1mue-00031G-2R
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:21:04 -0400
Received: from mail-vi1eur05on2071c.outbound.protection.outlook.com
 ([2a01:111:f403:2613::71c]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1t1muc-00060p-HU
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:21:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JX+TV+rltCSkh/PQLp5B5BBD4BdR2oRMqkNRpz70QatoSmSaT3lA43fymxBvxfEUOZ8DV6ySbJzT9rMrg3vTIINAIaBz9tUiBqgDjF0gCsLXof9VgbOfhjvtOjg4CWTKAU+BmThDD70EX2RHW+chCMiNe9in51lPpXAFTwPAAJA+Xp0vQf+iO8h8BrbT+otr1bZoq/SkWEuFyDsN0gb5FvGhe9gzsfIqqOU+G1byY9GlS6XfeN8qydyxPu25YZoIYO6vSnx098VAY9dTbyNVuYc2lX64bEYErpx2Gut1NTcDvBmdPfwVgP1flx42h/DPE/+NGYlcubcF6G91dMVJjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBGRnPfD3gtId2VRztEJ34xFzHCJyAOS2x/qN5OX2vw=;
 b=Nj7Cdh3jmO9Xq/ddyxTw588oYLj9l+9hN2B0g61eNa2I3MjbTGlIC+/Au97czp61Zh+O3RhHLFxZ7Tep9TvmXVYia1iydHMPBP8oUUZunGFeQLx8mcrzjNzPYtzqMIaTJRzj6UC5bwCklA+9jJgt6yHWRnLZ3Tskb91JptkRanUADSsmfhziAvefP04IZsZHyIUuzIyKrrGvJYZZ5w+xyrTzldoeJ8XQCqXI8b0yZdOwA7/75BfqAJmh2/0+K3xvNAND8GjxFqWMusJShLgFV51QKWKs77q76dzjI0XhHzZ8Hl5v6qD5w8VtY/ddBPjzfMdEl8TtKUmwLo0bL8nY3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBGRnPfD3gtId2VRztEJ34xFzHCJyAOS2x/qN5OX2vw=;
 b=cjEo5jnsrKoXxL1uek+dn/ykdZtyRqvBDe/7NNucyVB2etePP2+DDVVZHZH+mXPvZk6jQ3rpXruyy6H4pMYuxZNSnpU2tbNnpRn70UhB47BmM47aFZR6siF2Lh1ct7FtR+Ysb89uHyouql4hrtBHDaCO5F7vID29ZBvsf3Mslw4fs0zZZV7AA24i4nedLXkXKgJ4mNlgaodZViex4HlKn91UInZUshAddTvd1Y/XiuNUnhRzc4oX8FA4/Hnrk5a1MDa1akLTFbG6LNIXxj9A4HLz9jXBF+L08wXe21/B9SBcM/hhC2O2Koi18lJh3Yr91wGcDAX4R1Q8bmOYFSqajQ==
Received: from AM9PR09MB4851.eurprd09.prod.outlook.com (2603:10a6:20b:2d4::13)
 by AS8PR09MB6210.eurprd09.prod.outlook.com (2603:10a6:20b:5b8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Fri, 18 Oct
 2024 13:20:58 +0000
Received: from AM9PR09MB4851.eurprd09.prod.outlook.com
 ([fe80::2fed:370:dd45:13a2]) by AM9PR09MB4851.eurprd09.prod.outlook.com
 ([fe80::2fed:370:dd45:13a2%6]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 13:20:58 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, "cfu@mips.com"
 <cfu@mips.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: [PATCH v2 7/8] target/mips: Enable MSA ASE for mips32r6-generic
Thread-Topic: [PATCH v2 7/8] target/mips: Enable MSA ASE for mips32r6-generic
Thread-Index: AQHbIV6ZcJEdOYNeb0KRrafnu7qlXg==
Date: Fri, 18 Oct 2024 13:20:58 +0000
Message-ID: <AM9PR09MB485153B7CB706E188DED763484402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR09MB4851:EE_|AS8PR09MB6210:EE_
x-ms-office365-filtering-correlation-id: 21df66e0-cdea-4275-00e7-08dcef77b472
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?19tTkFkexNmD4abPmvTDAmoHoXn/sbPxHGewdoTXatj3OcVvVmP4Awztx0?=
 =?iso-8859-1?Q?+JZFER0sduQndIAPzRs8+ACalMG4oVXba7CI1c8BqGqQ9sn1myMD0nC1oW?=
 =?iso-8859-1?Q?ID1rjMQYo5LsktdiPDkb5Lzu4YEk6TcNoMxqpQXdqQVTMvYmBvHLnOiNf3?=
 =?iso-8859-1?Q?OU+cGw93cebzjnu0yWWXCeZqsU6OLVuCAYEUTxpN4FnyD/XU7Vuy7z1Qp2?=
 =?iso-8859-1?Q?ht8yCUCH2fhHhg/agjMyFxOZGr4ZVnJj/rJQCyNOBM9DEpac43ktUhinw9?=
 =?iso-8859-1?Q?RyJ273xLyoEmEJJEjXuGVB/5LcuDflfBEb2PWINHeOTBs04WaIdukcV6Xm?=
 =?iso-8859-1?Q?rfYgpSvNfvZszmvXWgxQG4wdaAG2iTcCt2FhmztbQjOue/s1k6HHuFQOhm?=
 =?iso-8859-1?Q?sZncWte1O2PaPJbHGNS8nIRrq/BbzouUSBAyIxDMC53rP3xg8FnMr6zuVG?=
 =?iso-8859-1?Q?QQslJ6+YD0+YWwafAF4WwVyo9G9tDZmvXEUTvB6O4SMBQHT7I6X98yd2vI?=
 =?iso-8859-1?Q?rycDGvAG9nOATGcTIYBPWzZO15zbxOba12BLNUZ/T0/MI7praqxWGXdACT?=
 =?iso-8859-1?Q?7Sq9bA7mdK4Fql16Pb05SZYEwOnowx29z/epd9CT9UFTCRTyOzGSKaZ3pG?=
 =?iso-8859-1?Q?UIqV6kK4Uqc/hEuBaE9PLtsep7bICbNOHWeK12mqipVkZJjGzMsdhKm8Hd?=
 =?iso-8859-1?Q?DTE0utrQ7hagloJCpzjzi1Nu6bCkC83NW1k0c9/l0Vax9JNWa7YtvkesY/?=
 =?iso-8859-1?Q?Vmhu5jbU8lDamzFQkQdqlHt1yswlIqSXS/fBb+uTS46qvSjkyjwhfUsbKh?=
 =?iso-8859-1?Q?Eo2J9RQ+m/1urGE7CyiEJSs7wG0TYnhQbIUbO7bT2p9thwiwPb8WlEe8ZB?=
 =?iso-8859-1?Q?DQ79kJm+sCFVYYlzaqQXbIJ4PPzzZ1kEa0/uQhF0Sm3wiwqJJqA8LqqOj/?=
 =?iso-8859-1?Q?Wk3b9wWj/M1pu12VBkmzw4mTx5W4V+08YgRHnPJge8dOxwkfw1y7Y7h1X8?=
 =?iso-8859-1?Q?AjA6dwjjnTTf+4siCfTHlA5vjM0OgfZJrCHW2jCojUcDmLYg6UzDrg8AmE?=
 =?iso-8859-1?Q?tLSn3uaAbB2RQ48Q6+l69TTI/BnN0/xUbap3QCaV/UDlGnt9rTGpzna+u2?=
 =?iso-8859-1?Q?N5plJr3CyVlRC+R1M54gz7UaXsIDIjw268uIrLDfFeZsQD480cG5dDSHRZ?=
 =?iso-8859-1?Q?jYdaLkMivvD6uePkIVMGbtGq7Av2fE/wGsQ/4Xx33QBNeXYeAwL2784Fqg?=
 =?iso-8859-1?Q?PN9i4OGnvB4SM+TaG7ORnPoT//wL9vjp9X7rIroYee7NP9xfj2feVwn7mn?=
 =?iso-8859-1?Q?zGorBZ0tiMcRzCDwbS/CvmSy+X7+SOZ91YURdWRXEesuabxpBNxEKmW/tJ?=
 =?iso-8859-1?Q?oA/5VSC6ry0KAwG1+MxibUworNZmYMmEtldQjbFJ8uvDTrPMl22mRivqNc?=
 =?iso-8859-1?Q?wbX2pW8pQ+I4oXWg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR09MB4851.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?icUVsB+1GqOlmby/4v0a9teENG2IdtvAdTZqj8ALKXq1PXgjOJJxbFNvUU?=
 =?iso-8859-1?Q?CcFgK8rEnSse8lUlJrJgVREnZLgRWIbvgXr+gmBzAHimL4anmRWH1HiLV3?=
 =?iso-8859-1?Q?PspiHnA9id/+LfpTQDFx0ZnIqirqwW2EhkoFrE7MdBPg1FQj14MJvHQcin?=
 =?iso-8859-1?Q?MYZ1o9i33dtabuJqnHm5nCDGi8Fq8Ftqf5Dp6OxER4bYmh9hd6eUwyKeD0?=
 =?iso-8859-1?Q?/yeI3ALOFPjc+GCVbAVwB8HQkbrMK2bXzQg00GpgsPEJgxPpa1jipVPdv9?=
 =?iso-8859-1?Q?QgXdNs1YF/ATkWFdEWGkKG+J0M6DfJ3jY/d6mDRtoqsflxTPMTjC8dM8GU?=
 =?iso-8859-1?Q?rJnMp0gKMXCtQ9dABg0Xxqk9izn+zjeZwz0a35ZM+ZlTBSLLH8vyS0Gyax?=
 =?iso-8859-1?Q?Fogggh13Fo4pWkkCmWTF9HS4HBKQ0O/HVBM4YU+nNkDu6kqUQsOwy5++NJ?=
 =?iso-8859-1?Q?cV/Yd4VqE9ez9OMQqWPrs36A4p20MwKZai30ncPlXM9+EzQB9heRuLeskY?=
 =?iso-8859-1?Q?rSYuJQU27GSbhEhSui9Ub+Dveu12wDS/jbZMXhf8ZhrKaz51VzeL85seFY?=
 =?iso-8859-1?Q?K/7Km/JDL3oPKUtRZoQoF1d1Z4w3MvjO0VUhyJH6EYR7epIKX2Y1fRsP9T?=
 =?iso-8859-1?Q?KD6J2Z4RkJ47Ou+Tr/iUslq3ogfTE0NRMFXVvEp2dqkA1DQD6XFfKvAr1l?=
 =?iso-8859-1?Q?cMjuwmWtmfq2fd/dgBKOOEDrYOGze/dUVS8O+L1sBqlqTBmbBibAoEdp37?=
 =?iso-8859-1?Q?T8V/7GhvZyZA4C+GBCrrqe52q+B/q2tevfYL7Q3Jxau0Ez+OEeLwKegC8I?=
 =?iso-8859-1?Q?lq3NcezX51kr/rMnLKJtkYUauBgevZdvBaOl3GLF7EkvQrPiiFiktNDOiz?=
 =?iso-8859-1?Q?OVkm1zkYSAMfA5wYbrj5erfqrXBSvdpsa32jQDss7qgsNtNzeBLDqWUo9J?=
 =?iso-8859-1?Q?fG+cw2aqNsAP6F6yrrkfMPYDeC9MLVxyZKr9qfZANGq5N+8R7UFA9IwfdU?=
 =?iso-8859-1?Q?SEpiE3m8dQoMFUUdslWZHYQEYn7eF0iglCFjqA9FSm8iqLzg5/Rde611XB?=
 =?iso-8859-1?Q?ru2kuvAJP6rq9FKlI2LP/HUJqIhtH+x660jyKRcpJdVza4+tfpP5dIeFkg?=
 =?iso-8859-1?Q?WEdfVkeBr5RmCmYd2SnjLe272/aRcOxF5avHB/vc/hhdeVboVsZEQ6wxAr?=
 =?iso-8859-1?Q?syNAB3SHNgCaR9w0F3DomLYFrYx06y0BT93vVfPbpOlipemrLSss6dovKm?=
 =?iso-8859-1?Q?EU/Q/cAw6VfFvQYMw39xx8P2wR2bgw5QNVpYOz8GMpvGAF+Aa5jhghs65h?=
 =?iso-8859-1?Q?2dDmt/mv2FJU6LZdNgG75YYsceuaZKujAo6MOjyHGYv9oVpI5+SbI3hFo9?=
 =?iso-8859-1?Q?/8P/CfsV5591opry7IVZKLmnr9mhXRsaGa1OVY7Xx5tZOg+VNCL4Zt6RkL?=
 =?iso-8859-1?Q?bMNzk7LSdxaMpMWYf2fvV20i533dWz+hdV4bnhICMFt6fQv69utO6hwDIN?=
 =?iso-8859-1?Q?8W9WenBUOhwCdM2V+aHbcQt1y5wRwNCscl4klp7gIac84WG9dAEYK2BjNP?=
 =?iso-8859-1?Q?U4lCWQ5qkn3FRM2Ev144K9J1HzNCCXuxLeXPhz7QiGdKRj2NN9q4Yn9o47?=
 =?iso-8859-1?Q?6Mi9YAiXQGZ+1PJEYCLqZt6yoqeDbLphbZxVlBiHT/ehoGhFcvoEnSeA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4851.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21df66e0-cdea-4275-00e7-08dcef77b472
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 13:20:58.6961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0YLswJNd05MFS189Zvb1r7xuRS0oOud7GBk0u1siwuWk6pKlFuezL72LjNcFeIWdx41BLF32k9lBt6+UGibSqiP29r4wwofuu2qotmBS+Co=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB6210
Received-SPF: pass client-ip=2a01:111:f403:2613::71c;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
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

Enable MSA ASE for mips32r6-generic CPU.=0A=
=0A=
Cherry-picked 0186e83a0613e90aff6d4c12c91cdb080d695d37=0A=
from https://github.com/MIPS/gnutools-qemu=0A=
=0A=
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>=0A=
Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>=0A=
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>=0A=
---=0A=
 target/mips/cpu-defs.c.inc | 8 +++++---=0A=
 1 file changed, 5 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc=0A=
index 9428ece220..19e2abac82 100644=0A=
--- a/target/mips/cpu-defs.c.inc=0A=
+++ b/target/mips/cpu-defs.c.inc=0A=
@@ -478,14 +478,15 @@ const mips_def_t mips_defs[] =3D=0A=
                        (2 << CP0C1_DS) | (4 << CP0C1_DL) | (3 << CP0C1_DA)=
 |=0A=
                        (0 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP)=
,=0A=
         .CP0_Config2 =3D MIPS_CONFIG2,=0A=
-        .CP0_Config3 =3D MIPS_CONFIG3 | (1 << CP0C3_BP) | (1 << CP0C3_BI) =
|=0A=
+        .CP0_Config3 =3D MIPS_CONFIG3 | (1 << CP0C3_MSAP) |=0A=
+                       (1 << CP0C3_BP) | (1 << CP0C3_BI) |=0A=
                        (2 << CP0C3_ISA) | (1 << CP0C3_ULRI) |=0A=
                        (1 << CP0C3_RXI) | (1U << CP0C3_M),=0A=
         .CP0_Config4 =3D MIPS_CONFIG4 | (0xfc << CP0C4_KScrExist) |=0A=
                        (3 << CP0C4_IE) | (1U << CP0C4_M),=0A=
         .CP0_Config5 =3D MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_LLB=
),=0A=
-        .CP0_Config5_rw_bitmask =3D (1 << CP0C5_SBRI) | (1 << CP0C5_FRE) |=
=0A=
-                                  (1 << CP0C5_UFE),=0A=
+        .CP0_Config5_rw_bitmask =3D (1 << CP0C5_MSAEn) | (1 << CP0C5_UFE) =
|=0A=
+                                  (1 << CP0C5_FRE) | (1 << CP0C5_SBRI),=0A=
         .CP0_LLAddr_rw_bitmask =3D 0,=0A=
         .CP0_LLAddr_shift =3D 0,=0A=
         .SYNCI_Step =3D 32,=0A=
@@ -499,6 +500,7 @@ const mips_def_t mips_defs[] =3D=0A=
                     (1 << FCR0_S) | (0x00 << FCR0_PRID) | (0x0 << FCR0_REV=
),=0A=
         .CP1_fcr31 =3D (1 << FCR31_ABS2008) | (1 << FCR31_NAN2008),=0A=
         .CP1_fcr31_rw_bitmask =3D 0x0103FFFF,=0A=
+        .MSAIR =3D 0x03 << MSAIR_ProcID,=0A=
         .SEGBITS =3D 32,=0A=
         .PABITS =3D 32,=0A=
         .insn_flags =3D CPU_MIPS32R6 | ASE_MICROMIPS,=0A=
-- =0A=
2.34.1=

