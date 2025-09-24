Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021EACAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Le7-0003e3-DY; Wed, 24 Sep 2025 05:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1Le1-0003dP-25; Wed, 24 Sep 2025 05:18:37 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1Ldu-0002zm-6w; Wed, 24 Sep 2025 05:18:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyNO+c22VdE+t9thNtGHDqGhwv3TXvU3r8GZNI1igQIKFb1KAHxRIKhMaUVit28x271uU6V11Ntuqba3VZ8BW4Up3IOD9GrnPJ/niJjIeucyZ6TEPJohSuBcKCp95dk68BxwmCBObjJjZ4GBxaz43gtZkDrT7IdgKZ0mtUOZ8h4dFjdmpifOzfZ/CyafjKSJ1RgdwOliEeCYSMtv2SUSwmCBvBMa1vrnOrsPrbDSFt6CJjU3rvXNOSPaKecmgP2Gud/3jIfVmQHL+T7m1Z0FtQWs/5yobgZXoVW6YT7RdGduFuaojAb84zBnUa/Uum8E5ukvhdAsw7lFEQc4UUC1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHK93Iwh+s1A0A4qNtCIpg9vgwYTCbQ6AL7FlgVPqdw=;
 b=HkUdx5TsPyv7zuki8dnpmKVk8+DSTNhHsHxhBgTrX1sRPVjGGrJ1bOx0ajW5DWacrDXWHCavD/awYdkZHVqfrXOgp75NQLHtweS5ACrA9Q5fBqY4P+bimRrDdPt+J2PIgmvWED9O1Aj1UoAPK7bMj2BHeLGxdjI+B+dNLg2SGn+SqZzCE2lPDydldRpXvC2y0WWZQhWGr6pmD/4HZGgzNv3QZKHdwo5+qbhOqw4ks26UZp4ev0sDjL+A+izaiI4z1MflGVL7EKWMhjpDQ5e8Xiejzo3z65H7USQ7F3MAZfAdikNZ06Zl8lAboFvU5re1rnM8AxvODMwW9evBFgehEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHK93Iwh+s1A0A4qNtCIpg9vgwYTCbQ6AL7FlgVPqdw=;
 b=upBekzC97R2RzKUmG9EBe2rrv9aaFhzxCC2OXSdaZIDYWoGLJxl/URQRMKtp2m5mQDdknukWwsTngKp7S3qXOp0o3rjVLNsLI7X6q1nioe1MqWly0X6dTIM10txovopvNsWgB4dvGJrX6GY+ujks1AUVHlTAB44mh2QTXFyEi+SGUV30amoatvDEqj+zTcpNFE4tAFU94ewzF4mous2mdwxYoDxLSTbV4FnkMRBY9HRIuRNTlAy0LNE6ZWvUzQ4Hge4K1E2g5iuj9ZsnSe86R38GluivHxyjuhE/mf4iDbCuEHGf77Cxa5rhNq7mz048CJpWXOHSOHiBJEZWOzBDOA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI0PR09MB7826.eurprd09.prod.outlook.com (2603:10a6:800:21b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 09:18:14 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:18:14 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v8 01/14] hw/intc: Allow gaps in hartids for aclint and aplic
Thread-Topic: [PATCH v8 01/14] hw/intc: Allow gaps in hartids for aclint and
 aplic
Thread-Index: AQHcLTQnmJc4xZ0naEaKLbM7DB6LEA==
Date: Wed, 24 Sep 2025 09:18:13 +0000
Message-ID: <20250924091746.1882125-2-djordje.todorovic@htecgroup.com>
References: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI0PR09MB7826:EE_
x-ms-office365-filtering-correlation-id: befb64fd-6a28-4838-2fcd-08ddfb4b4a4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?DgNSsCj2lRK8EgtsdwiKhA6CSgYlDY2eKRD8lASRhhaLvDxXIiVIm2mkoB?=
 =?iso-8859-1?Q?jJ9VDGdNiyH5y1AJf0ySi0OReguago+NlGdGFrLLVcVdW32Zgm4NKmmoJO?=
 =?iso-8859-1?Q?8LjAlGPdnDO7YAd9GzChkmwDMme8AsBfrGGl4hO4Up7HSyC50M+pNx5SQb?=
 =?iso-8859-1?Q?OEyO6oNc7m0T2GaEvY+4wOhstTwlukSRXNhd6BNrNK5vz7QYRLR1tlcX8i?=
 =?iso-8859-1?Q?xLKbA5DOqxiEjHqujZt6D2aVIvoCO054zg62LG7pcSwyNP50idCcsQlOE7?=
 =?iso-8859-1?Q?QsbexCLzf6BGZCjem8dHg+fkHghwGtoEeQU65EkFPkBQ61OpEf4otCwJq/?=
 =?iso-8859-1?Q?buYRTAJPFTMsZULKR4Uql/Ehs8dPhOEdI3Bkke64c0Uwoh3HOeboKThEa2?=
 =?iso-8859-1?Q?NS05BV45biyABbbIMeDIDnV//1JhtZmaV0fnGcfOEPgSReY3hwxHWTlnNF?=
 =?iso-8859-1?Q?whOD4jvFOlu2Qfi04HnfaHPN/5rCxBKF68XXx08MWwarsO2X9hpOVJHmh9?=
 =?iso-8859-1?Q?RVsVlTphJRftOBu8y5LT5I/5yUTrbmLgeLVogw5q9n29rEBZjSXUGGJCGW?=
 =?iso-8859-1?Q?M8zebDYv7/vNvZsdBI9F5jYvgkWEFJp3drom/GfQMI4ochdL0jP8siq1nY?=
 =?iso-8859-1?Q?pozY4YCDxyyNk8yDpo2/Uy12FsQQotBtjDxs1xcX6AiJl1516xWwsrhy4p?=
 =?iso-8859-1?Q?WFchbIEUtxAYViC4iQYxQrDQSMPgprmVLHST81h0IHkCkqcZXGUwk+10/u?=
 =?iso-8859-1?Q?WFYRpUdGmZRetiPAwzWWdKggTEBkfanz50421GDoQQtsr3ZFbacS/GU3bI?=
 =?iso-8859-1?Q?4KJ+bqmBL1fqNdDfg9dxKc0DuCIDSGNwHOueH+J/wanRvRysIIfbHdl0LQ?=
 =?iso-8859-1?Q?A+ZG7NPtt7SrPCawdPaj2eRr+7rcPIjk4Tjq2U6b8Omrz2V3VoLamXEiVs?=
 =?iso-8859-1?Q?guKhvWMVG44ZNqxqhGbcENBOfpdZYxyo+8p8M9RnWdbcT7mZ7sbgJDrt2p?=
 =?iso-8859-1?Q?ugaYdZTOLsuT1SCgmChTYWUYLVhaY90Ig93LXITF0YEhjjDOqWN/LerOU9?=
 =?iso-8859-1?Q?CsJdK3nQ75j8uBoboIV7sgrGsFmwOcnIaSuvLR0ZFsfd5fea67XMkQPmMM?=
 =?iso-8859-1?Q?rhoQMlVnC4qHOxizUmnzBGSoyBmm55i5q+ZqUxTUjlh0hzle3iAdcStl5o?=
 =?iso-8859-1?Q?ktEMV6+jGIRRFT5UZLWkoCkcuJeqInXQ8x7+0g0sdn181hoIgWiGf6gufk?=
 =?iso-8859-1?Q?IdS5lxd0GCoO4CKSKS29FQfmCe70UWaPfSb9jf+ZIPwvgJOfF4Enf4Xaly?=
 =?iso-8859-1?Q?Q7l6EfQzpPcuQzkjMQpqPmzIT2UmVRA+uiEwzcBIHNCPQaHc76/tJG3z9w?=
 =?iso-8859-1?Q?XjYRyCE83dknU9swUq6zMm5dRxHDFIQCRGUa/bb4qsJuVYYjlArvMWE8SI?=
 =?iso-8859-1?Q?lNxZ1/fKtYx1XbAIgyJIx9VoY5+y+HYgriKdtO0zOOGcVa/pzCbFcuzQY6?=
 =?iso-8859-1?Q?Ii7mYXhuYnC7w2jSkJH65Yfbm7ZwQWAa5ovCHQzruaTw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zctDCfkfal3HeLcBXxga2a3sasi+VEeRw3hOCnDXgSD3VfIxGf3sUydzTt?=
 =?iso-8859-1?Q?dwTd/vonvUE++f+BMxQviazW0hvAfQLoG3GgyDcreuLvUHgvyxFYoN+WMb?=
 =?iso-8859-1?Q?3JeFfIwOsI4tOztrJ0FhUCkFbr9fqwt/ARtmISaVM94e8EmZ+xUwjYgWrE?=
 =?iso-8859-1?Q?6Cr3aJ294pPYOL5nxCewwJGkqz87tLti/5IoLnejrjFtk+B2RkxjJZ5QCA?=
 =?iso-8859-1?Q?0JW0gm2dB/u8oLipyBBrwa7NhSyhAZTt4DglZgYWsdoelCQn2Ucm8a8YJJ?=
 =?iso-8859-1?Q?0sf6mgUT4zt6/j8ODkIzvd8Io4N+E5aR/jB++OMklhY8+uolMKL/ZiJLRY?=
 =?iso-8859-1?Q?a7TgGxXBJ/vk8KV18xXe0PsuttgstZZKL4tlbyUCEToxuznMTBvGr4nV/V?=
 =?iso-8859-1?Q?TM4ISHrrFMPTzTkz0aJvJaRvUt1iQ9+FX7qWPaHtNuGjbLi/8iDxyGQ/8F?=
 =?iso-8859-1?Q?OaA/wlLo+CBd1B7lHfRCgOXLw5iNeWOb7Or75SBmhzoii7AJX2hCbeLEgG?=
 =?iso-8859-1?Q?3QHJ/ZNhKnNtb3xI2ycGV2Og4JgQFJ9N1+mvE7X89qz/+mVuzzHPHuLCZR?=
 =?iso-8859-1?Q?KdTpPj9acxb4BJsEZlyTK7oS41eAqHYp7w0+3ktCJJBb8bF+XwTWCsYqHA?=
 =?iso-8859-1?Q?REsEGOtX757XxYC6NYovH9335Jh0k0EBYVZK7NfdlMoV66JRtlRHz51yVQ?=
 =?iso-8859-1?Q?wErFVmX5y34imbGZq0mKYZ9HLiHzIJFJ63jqEQPXc4C9EmDWeXU0RsQ+Mz?=
 =?iso-8859-1?Q?d15wz0k0DCP3582n6x4SlEvWbOKZRrIS172VU9pWQPAmBqyWhs6f7tO9/H?=
 =?iso-8859-1?Q?lxvVopxTd10YMWCgpVCiKRHMpUZkzlU/azozD/QzcDb+lrmC8IBwM/oYcl?=
 =?iso-8859-1?Q?/tJKMbHCONa5dM5UTngVXiLTT/HbDjzyWKahJUE45RG0t/PGOoR/SScZ/X?=
 =?iso-8859-1?Q?kIEtkQnDZuFBit+7j4bh7hVDarZR4gQQOhNtwlXUm6GIXXEy37lJf6VgwC?=
 =?iso-8859-1?Q?pqcctwV2FTuMPyoQScivD8L3+/qP6r0h451wIFAMb/jEfowTQavvCndGrk?=
 =?iso-8859-1?Q?Qvufs2AhTQ5nXJ1eFv0qefLsRMQkV0BTmpLJM7/yz1bv6kC+jvGULQZLpa?=
 =?iso-8859-1?Q?QyHcJDwAY+qeDMUYyPSm8Unibj7LXTa+GsopbeJZZ4qCsP8n336deZmYoQ?=
 =?iso-8859-1?Q?Oqo4/ukwK0Gqkxq0Vje3vLSPhRIxiaeXbbC4TMXIjLp7sDJR6PTX7ecgUE?=
 =?iso-8859-1?Q?QPno0GZ4x66mRVFf01cPe+fWAIZEmaE6UcXIonC3uKpQ6frrdsfrR7ecFZ?=
 =?iso-8859-1?Q?5hSVVlqhbRbaY40ww4tLw792AGH2emCPLzWMqD5Da3K76M0bs0FAcPZxll?=
 =?iso-8859-1?Q?TOUtn1sNUzcYsC/pxt8RkrKu5JAiRLqSpfQeXN2fz5o5SuV0Beug/VhObg?=
 =?iso-8859-1?Q?vXtRHvy7OLGIfxwbPqOomN/rLG1+5v2tcEV8Pyl/BRLg5zRYQgKgSigYph?=
 =?iso-8859-1?Q?o4hO3MrRbruuEHDaBGExTPFN9AsOtDRcrUMPwV9d7EBKMMaoCmRw/zIoY4?=
 =?iso-8859-1?Q?d411iTjPLYJS61sAiigoGon++bma9wVXhSC1l18Nt2k/hs0Mcojd1yoSDB?=
 =?iso-8859-1?Q?wOzdsJoUqnTaQC0EHfWe5YoehR2SQdxM97Eo8SbJ2wMXNi2S9V+z8GSGkf?=
 =?iso-8859-1?Q?D/mronBooCcXxZb+Erc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: befb64fd-6a28-4838-2fcd-08ddfb4b4a4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 09:18:13.4649 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /5tuBqK8ijm+Xrwsbnmb1NS1Ie5NsT9uInw4qMHe1gnE7+Fm+80QPRepshS7PpUdpdTQk9e3yCm1vILUmCt9DJJfMiqLo7rV2cdCHRl5H/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7826
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This is needed for riscv based CPUs by MIPS since those may have
sparse hart-ID layouts. ACLINT and APLIC still assume a dense
range, and if a hart is missing, this causes NULL derefs.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/intc/riscv_aclint.c | 18 ++++++++++++++++--
 hw/intc/riscv_aplic.c  | 13 ++++++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 4623cfa029..e3e019e605 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -297,7 +297,12 @@ static void riscv_aclint_mtimer_realize(DeviceState *d=
ev, Error **errp)
     s->timecmp =3D g_new0(uint64_t, s->num_harts);
     /* Claim timer interrupt bits */
     for (i =3D 0; i < s->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
+        CPUState *cpu_by_hartid =3D cpu_by_arch_id(s->hartid_base + i);
+        if (cpu_by_hartid =3D=3D NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_hartid);
         if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
             error_report("MTIP already claimed");
             exit(1);
@@ -486,7 +491,12 @@ static void riscv_aclint_swi_realize(DeviceState *dev,=
 Error **errp)
=20
     /* Claim software interrupt bits */
     for (i =3D 0; i < swi->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(qemu_get_cpu(swi->hartid_base + i));
+        CPUState *cpu_by_hartid =3D cpu_by_arch_id(swi->hartid_base + i);
+        if (cpu_by_hartid =3D=3D NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_hartid);
         /* We don't claim mip.SSIP because it is writable by software */
         if (riscv_cpu_claim_interrupts(cpu, swi->sswi ? 0 : MIP_MSIP) < 0)=
 {
             error_report("MSIP already claimed");
@@ -550,6 +560,10 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint=
32_t hartid_base,
=20
     for (i =3D 0; i < num_harts; i++) {
         CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+        if (cpu =3D=3D NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
         RISCVCPU *rvcpu =3D RISCV_CPU(cpu);
=20
         qdev_connect_gpio_out(dev, i,
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index a1d9fa5085..77cec8ece9 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -903,9 +903,12 @@ static void riscv_aplic_realize(DeviceState *dev, Erro=
r **errp)
         if (!aplic->msimode) {
             /* Claim the CPU interrupt to be triggered by this APLIC */
             for (i =3D 0; i < aplic->num_harts; i++) {
-                RISCVCPU *cpu;
-
-                cpu =3D RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i));
+                CPUState *temp =3D cpu_by_arch_id(aplic->hartid_base + i);
+                if (temp =3D=3D NULL) {
+                    /* Valid for sparse hart layouts - skip this hart ID *=
/
+                    continue;
+                }
+                RISCVCPU *cpu =3D RISCV_CPU(temp);
                 if (riscv_cpu_claim_interrupts(cpu,
                     (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
                     error_report("%s already claimed",
@@ -1088,6 +1091,10 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr =
size,
         if (!msimode) {
             for (i =3D 0; i < num_harts; i++) {
                 CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+                if (cpu =3D=3D NULL) {
+                    /* Valid for sparse hart layouts - skip this hart ID *=
/
+                    continue;
+                }
=20
                 qdev_connect_gpio_out_named(dev, NULL, i,
                                             qdev_get_gpio_in(DEVICE(cpu),
--=20
2.34.1

