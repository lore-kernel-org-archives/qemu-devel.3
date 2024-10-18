Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE01D30008
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1muE-0001WZ-Ji; Fri, 18 Oct 2024 09:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1t1mu5-0001Ja-Kw
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:20:32 -0400
Received: from mail-am0eur02on20706.outbound.protection.outlook.com
 ([2a01:111:f403:2606::706]
 helo=EUR02-AM0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1t1mu2-0005wS-I8
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:20:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaddqOJ56vKRmEZXXf+81iYsuOsSmbgIW3xJ9jFA2nKDrxOvxlm0euLvYX4BiRl1Q+VM/vKcgHUvOKnE/QcveoqwBpASqBeMOXBo4iCLEP5859b+LIIEqZx3KwQV3s4QFANiGZplnf7b+N9vrpz+PLX3Lpalwn/pg8QZ/Jnk0j7pprloS++2GSvDytcXA2eszM+rR1aEeqpNFvSRGHuAdeD/8kl2Bsbu+WS4YpfURY+ik/uIbix84DglaAyTlxvXkl52RwmrFB19LJsgqZ3poBf2j1+tbD5bvGP6jQ/2H1CvTqMcFZyxriRyQ0tYn09U6iEM5wXMVl8ghwDLfoBF8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWZaUFDN2EMPrX8J7z8OOZGddFak6s6o1RkUmnsEbNM=;
 b=G4tycvzNUkqh3WcuKwrVMUC/eh4YckLBp/91M7mrzi2wVJN4Psnwn45Gcxu6y3Ti8fHxbMGFb5O8lzmlBCQK0VJaBUo8OcyHoVa1GlAUB68PtgyYUUvUqurgBKZOO6IRJwZij8kVywpkoL6rMtO87DrNBULnCPPXkjY0nmx5px4HPFH+MioAEVwiPERYJuowvRGjKbGl0Wo7eE2zSV2qTplQWYQQeKw5pj9JGFTAzpyocTnivME8tLB5CE/ywxKD/NXnZtN6IZlxpx9KKP6G7wThat72epnJH/vPbbNFAFOGsEGGOYvH+eyUTYjM5AH4/N67hN3CPiwMtbrN2NPLHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWZaUFDN2EMPrX8J7z8OOZGddFak6s6o1RkUmnsEbNM=;
 b=qxNBZeJHFJNG7FhGkZjWyHkrZpYf9ocZOHDltGtfAZX4sEg4uMIDgzAO4LwolhyvZymx4S5SJ/GuQ4lM2k/y1HgI8/LAEISokjCrwVvwvwsAiSQo4SPRXCYjs2qjNDbxrZ2AgDC6obfmz+5F2GabDDRphqdajJpT+EIb8vUIsctmMJPZb5XfeLJfNAmFUTlFG6hJS8kAC1yrG9b3d+de0Yg7zac1EE/TMm77bcp9PtuldSENY/56llWZw8eoHzXQRyEpSsLISIU/niUpOpSVaDNhkbpNZ3Q/vQFlr0jrps+uer+17nJW8DSxAWz9ejdB+CGuHlXhWsQbKfFeIgPXAg==
Received: from AM9PR09MB4851.eurprd09.prod.outlook.com (2603:10a6:20b:2d4::13)
 by DU0PR09MB6635.eurprd09.prod.outlook.com (2603:10a6:10:418::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 13:20:17 +0000
Received: from AM9PR09MB4851.eurprd09.prod.outlook.com
 ([fe80::2fed:370:dd45:13a2]) by AM9PR09MB4851.eurprd09.prod.outlook.com
 ([fe80::2fed:370:dd45:13a2%6]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 13:20:17 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, "cfu@mips.com"
 <cfu@mips.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: [PATCH v2 5/8] Add micromips to P5600
Thread-Topic: [PATCH v2 5/8] Add micromips to P5600
Thread-Index: AQHbIV5bzy+WRZlB2EGcb//eEf0Pww==
Date: Fri, 18 Oct 2024 13:20:17 +0000
Message-ID: <AM9PR09MB4851B248008D8045D466EA0B84402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR09MB4851:EE_|DU0PR09MB6635:EE_
x-ms-office365-filtering-correlation-id: d46e6cdc-1b00-48c2-2809-08dcef779c23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?v7QZpB8Z0Cdp45iHp7vlwj3OaSO2oI1L5F7L3bGLRSIRgVkHZwqFuZ6slA?=
 =?iso-8859-1?Q?Gkbe1E+mxDYgOadYjMlOgZ+Zsz6RPHCOXeSqMMknooNHrBd9AzIY25Ie66?=
 =?iso-8859-1?Q?4N58NyWrQ6YQmh4xTPuv7hOuSMzY6zeGSmcO8QTP1etQ1lMfmXJ+hSdEGn?=
 =?iso-8859-1?Q?+WK7pcO6cfs7O2clT2MYrVsPEWC9WZXPea5d+OEGH6DvxMtFDmuN7vg0fV?=
 =?iso-8859-1?Q?FkSZ2TQQ9OZdl99XwKxLLmBcxNJVnFcG1MCwvLq1m86ehmAWVOn3urRdiR?=
 =?iso-8859-1?Q?4Sod1YkZd0hpVGPASmbrRAS76zzKQDYkyfkZK5rx9Wdvl3Vcq5gC3YdkCF?=
 =?iso-8859-1?Q?xl9hUwAkGu0IjfSLI+44yAFqC+YeuAVHNwHoFzvnA95ovPctx7i86CDhGH?=
 =?iso-8859-1?Q?podxzM3NLiRXmWSNqSzzdxg5cyiQCm2dhScjxJsK0hCAZ2uLkjyvIFMTs7?=
 =?iso-8859-1?Q?2QgpbpoZXOk4i3pjOW0k4s1bigyRjdsosgrk/w6u5tP6oPVzVOAavtFSp6?=
 =?iso-8859-1?Q?LcBFn1woOzBDyhH0AGFPkWkblu4hY7YHtvUSrXFdncMzjz5/8D5cQX48FH?=
 =?iso-8859-1?Q?z/Oc2Bdd+5E0jb0PQu20BbvJUEaTnp6NuHZqMWgxhdUMsyFsXpOX7MAd+i?=
 =?iso-8859-1?Q?FOPhOJ9IhgDdMIdZ7UdD3nSDA5odzP9cFuucyup4SaM9w4FZSwa1m/rFny?=
 =?iso-8859-1?Q?M19tMuXV7i/JXOoXNw6ZanVsmFBeyxDh1yLBOk6JrJgdaiHyRVkQjrIVq2?=
 =?iso-8859-1?Q?uVksYNqo9HFbx7Tap1/nObBts6D7rW66+os3Urigi7pDUOKOaZn4lDISod?=
 =?iso-8859-1?Q?U0aGP9IN13uyo8pn2cM2qrykA1u2EKdAtcda17QET2wL1P6WHRgiu4MNtz?=
 =?iso-8859-1?Q?jkvD1X3iIVA5nMibVXpaV0wPeAonKmaBg/N6AtL4tGvuWQ4E/+cV8dd7XX?=
 =?iso-8859-1?Q?FK2NlPceGXYImXMa8nPNB8aeT+sQ3BrINaHD/FuDdzV5uGZ1qcMWsJILjT?=
 =?iso-8859-1?Q?NZTq9NADVY+E7LXRImug2vFghlbFLeQhdmGLB+wnNsm8r4S5rp7N3WZsJr?=
 =?iso-8859-1?Q?exkRH5bc7mhqKPM6rIqMGztPQAaKvI+Ogp7G6ztqwH6DNfijBjWzk94iNx?=
 =?iso-8859-1?Q?snoZdPstp3Qhtf3Kb5+1FZbrS8JPokKaLOhgqL8Jrzss4WZNS8KnG9eMok?=
 =?iso-8859-1?Q?94UsnOdDVy3Lto+OHGkQVxnJOMopkkJSDdiwgDCnqT3aNUy0ZcQzmU0tVs?=
 =?iso-8859-1?Q?HaCYn0wPOQmKtaIp/RrrXm4Ftdm3hdznMCWa0rrovl24sJlf9vSDh51N/s?=
 =?iso-8859-1?Q?Yf1zioPlIOX6De55h4JiS4Wg/hWH3uQr1EAJJnlR/xperloxWbIQhcMPSI?=
 =?iso-8859-1?Q?9dJdjvnj/vGauoz2lr1kM0A0wj1gJRAQJVgpomlf+7dWwAzQXYK0iQj6mG?=
 =?iso-8859-1?Q?18IlOZigXhgNx4eH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR09MB4851.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?34ZpmIOSPPoCOMRnPiTgOTlQ4pCVk74f6UjgY6SQT8uk5CM65QGVLzbteL?=
 =?iso-8859-1?Q?eLS9PRIXxB1vn6U6TJSBAh2cnBpnV3aC5wmKvwv/1jxRwirO8XQ5fYLIdm?=
 =?iso-8859-1?Q?NKtifYwL1nTAaPHIDd7MDMxVKt7uEoArZaEtNna6+xSBa/hSP/DlSuEVq3?=
 =?iso-8859-1?Q?cOdtqrqnO/c1HLmzTqZgxfpyA0atToqX4/1Gk/YS2rMTGTJpabZPe8W8WG?=
 =?iso-8859-1?Q?Jyy1TmqkH3hAfWkfC25S1TEVRSIQY74L/BdXojNInml1BYZaehznPFBKYZ?=
 =?iso-8859-1?Q?KeO+zAxpw/cV/ojzladSeKJ7id2VSIa/n27mtvzd2Ofxog71yOwWY3kYPj?=
 =?iso-8859-1?Q?+9Av6LjLrtkd+UQ/s6uxATZ8zK+J+wd499uQ567ZLrzk8bQ6fkkMlqHaqH?=
 =?iso-8859-1?Q?3Z0m6HzWXxTCo13RJVIAShsSfLykW6iHs/dS1aMqAigsbJjOxE2D74ZonQ?=
 =?iso-8859-1?Q?ItQMFnoiQtjtm94lMC04WktPoCiilIoqTqfhMiKMrC5XLLHvuHDIiwqllr?=
 =?iso-8859-1?Q?jShC4sqSVv55viHaMZu1oF5IngnrNtxd6GlFtJmiFeub40QZs/ihgMXbdV?=
 =?iso-8859-1?Q?v5NerrBloQTG/IB4I8yUSZ6TisULiy66GEgMUv80JgHj/hHD3aQdPLLyP4?=
 =?iso-8859-1?Q?CzBVhSDbyl6ZOqvtHsBv8xk2Nj9jMXviUn/uCBDlwEjuRQxWyGsucIjOp5?=
 =?iso-8859-1?Q?L8YZtE/cP2yveuUfy6UqIEU410nuFyuGm7s3Y7KGJo4TrvhaiMe0U+oWge?=
 =?iso-8859-1?Q?/pAWyDzgLWZL3yEn8iecc5Db5QUUNu5ceEXjqhiRPvlS+/ucv4jEKyfLR0?=
 =?iso-8859-1?Q?GExxSgF/MIj5pBy+7esTPEqrXmF4z/u0KSH9e87drE23w1n5VPYBU7PUZR?=
 =?iso-8859-1?Q?lsGP9R/awor6k585mun1MO7o/iUZhu8SVjR/etDGhREva/dapAKNsIxwog?=
 =?iso-8859-1?Q?M0P5QCgpZUWBStgukCNTxwtoHvomZAaj3QjGVl+6gckvxBBG+NHxYCPLDA?=
 =?iso-8859-1?Q?z0EdIVwiZ/HCp13jle91ozLx3QMUF4JRJqbEvQI4hIc2UHDvNsIbpIBMWN?=
 =?iso-8859-1?Q?Tki/l5lIsseBh0G0G5nCbtJd19CMh0p+7COHqTFc7cCjyw4wSnnA1luLW0?=
 =?iso-8859-1?Q?RAHApjKD1a7jFvG/tBXRGOjjjj+F4yd4/uZYKKF5IKkfIIwVm+7fgqf7cO?=
 =?iso-8859-1?Q?UhkANdFi8AQa5ibHJLsNq99hECvnpTyJGFrVTOFB/A6MYHG9P9oMBRu2Jc?=
 =?iso-8859-1?Q?Hn9U1eBBQZJBfiociX27fcFiu/qo5lyDjQCc18c7Nd/xTrgIVlM1cX4tns?=
 =?iso-8859-1?Q?zWDLz2l2XgvjX8/q1pVmLKM9+ZGP+vbbq0Tq8BPfVLCNRKraSZYHt/44cv?=
 =?iso-8859-1?Q?/QDnFJ3Xd1vrebXHN06/ekGXCh7e+I6hBOmUMdET8oTHHnyrQFMjYO0+o4?=
 =?iso-8859-1?Q?zk6W5RlQoY68e8900cTuW8Ktf46OAk1GEyO0YA6kFz0smTQdLHFgyD41va?=
 =?iso-8859-1?Q?mAN/iFwsW1uHXyOOgfqZUimTVtbG/4jSa9ETwTWoOhOtWGyLQ7z1W9bDGr?=
 =?iso-8859-1?Q?0GIPtZAE8XtwA8PidSmUzakwWc8Yf/F6A42UctDJc00Zn0IobyOaqb5ABm?=
 =?iso-8859-1?Q?rSfZJbizrpeh1athfTGTR3xDTlMGcpNgsV+HTyM0gclwk4S1ZfBzf6TQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4851.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46e6cdc-1b00-48c2-2809-08dcef779c23
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 13:20:17.9358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xiWd3rzpU/byVpQm2TKsn4Tz8LjALsLh2A8Ms4SuXDFfVE2nZPw2HPhT6SQAV+JaR++hE42sjOh/w367KwWE7KpypH8pHGnACFaaxyTF5dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB6635
Received-SPF: pass client-ip=2a01:111:f403:2606::706;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR02-AM0-obe.outbound.protection.outlook.com
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

Add micromips to P5600.=0A=
=0A=
Cherry-picked d7bf2c2f7f2e03b55c6e9c57eec5c3e6207005a0=0A=
from https://github.com/MIPS/gnutools-qemu=0A=
=0A=
Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>=0A=
Signed-off-by: Matthew Fortune <matthew.fortune@imgtec.com>=0A=
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>=0A=
---=0A=
 target/mips/cpu-defs.c.inc | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc=0A=
index fbf787d8ce..9428ece220 100644=0A=
--- a/target/mips/cpu-defs.c.inc=0A=
+++ b/target/mips/cpu-defs.c.inc=0A=
@@ -462,7 +462,7 @@ const mips_def_t mips_defs[] =3D=0A=
         .CP1_fcr31_rw_bitmask =3D 0xFF83FFFF,=0A=
         .SEGBITS =3D 32,=0A=
         .PABITS =3D 40,=0A=
-        .insn_flags =3D CPU_MIPS32R5,=0A=
+        .insn_flags =3D CPU_MIPS32R5 | ASE_MICROMIPS,=0A=
         .mmu_type =3D MMU_TYPE_R4000,=0A=
     },=0A=
     {=0A=
-- =0A=
2.34.1=

