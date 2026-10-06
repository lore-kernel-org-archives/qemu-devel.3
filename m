Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80E7CA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN6b-0000qj-Hc; Wed, 07 Oct 2026 04:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEHvD-0007mc-Qi; Tue, 06 Oct 2026 23:02:43 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEHv5-0006Sj-FL; Tue, 06 Oct 2026 23:02:18 -0400
Received: from SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) by
 KUZPR02MB9164.apcprd02.prod.outlook.com (2603:1096:d10:61::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Tue, 6 Oct 2026 20:56:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XN6f8D53IBh26k57oc397Qta3oMsBirlfFaLUS5z2DmOAofTq4mSE5HhgPmcevpk/eWka3N/9nfFSyg12QPdk6RXuCrdoZ5lx7nWKXZz+b1nev335SvvEE3szJwmthe/VYICVyB8bvrNpRQVV04nNyc3SHjOqLhcXY5jFTRWpLpAEuT5JwY0PSYgZ7KWN0S7W6fhKXEGuMyTS/E890ey11+f5YZY093AGI/AwCUzEqNzKelRZ11McZ2WSlqZWxURAe1K45uNNzyHYX5xzg+5quCQ1vc22I5oDBhYTdR/y6neNDzF3GYUirn+Fz/n9Jo2VguIvL1P3zwIgtWK5V4arQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tt0x2zYyzdTv18d9nzyJ5Qy4RJwAgqXh86gM8PWAEg=;
 b=bRCFa32obHK1XmlpRiIjJTzKXD3MTBoE2qXwfgbYhUty4r/4pL4RagQCURBcpE5SP/3fuTsq8J2YnmZhRJeTeQZmKEzIDmTnDFdBVuC6EmVy6L1XgR65HPEGG/ZGZ56QVr0aOamJj59xtim2EqN9NRgHOqLdSIKZZdscv6wrUqh4Ag5p6HP8NtDgxExsAhNtQJ0+evRgOsx7PquH/d3UR6Hch9i2XeIr1gjruwJdZdmHnTiEck2Itka8L+uzigszDxDjlE6BWQpM4UxpqmbFVMAchGbh2qY9qhNuRFrHEVp1X9oN1u034AftUGv3oiz+tuHs81zUHPm4CkKNnxQa6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tt0x2zYyzdTv18d9nzyJ5Qy4RJwAgqXh86gM8PWAEg=;
 b=gNgPgH72ZJmQNf5jQJrLo7gWTtEeXbDo9VQlwmDWiTQIwpuIbrjtAw4D+h00PrFDsja+ffefIl/F2BFFMYOXK+YZnryPe2fuczFlV2OdYHtC5Mdeu+X8nZ7ZfK9vvc2TqJhln1xiGu2wN5LNIXulKhAKNrjxILXK+qUqHIERJQNWsUFvHPT0I4XuhGIFL5QgGN9EZoaDByE5ApyBY0HMnHEZhLHtLcmuah7aMNDw1dTgEpBTijsXh61vy+aYrgu+pbo2zH3Yy/t5ijvpPLoXFHYLTBYLoy73M1O8HYg3Pgu9sBjaqXU2NaQBlkiWyQIyn1/2++kXxtWwvhXtcea27g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:50:33 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:50:33 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH 10/17] target/ppc: Register PWRMGTCR0 on e6500
Date: Tue,  6 Oct 2026 17:49:05 +0800
Message-ID: <20261006094921.110871-11-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006094921.110871-1-bin.meng@processmission.com>
References: <20261006094921.110871-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|SI3PR02MB9388:EE_|KUZPR02MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: ecaff2ae-8980-4aa6-3fd5-08df238f4375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: ZKlWXYQpqTThVc5KZuRqFR1m2n3Vh6U+IoH5MqhqzewqZ4zTf9GXW9lWdQ4DK6yrLH/fgyyxcWgLTSuFH26XkOH+JKT9CEaVIx3a7lRocerGG+IUaHR50RUrDjQafHpQ/btiUKRebyXDDvgTUQuVO/Q9y19Opn2SIa7bu0G1h9jSIsIplxz3jbAiPouR7kCdzW/J41+G46OTJ8175ZaMdKpGUHZaRHqb+yARzsVT7UX0Km3pUQHsZ8c1MwZkiXSbY2AIgUg5CyV8sbhdghvWKAx+J/KTQZU5cuYNg0tmZ8q1TAX9OkYfH99Suuj0ek7k1U4zYO9+RcAOl3yCYq9Q8XNxDVoUhsSsVYPkJIXkJuxuwURsJxygK/6fLPm4wezKAZyIr3t1v3x5bMSHTUnWiXOwvr0xxDWmJ+M9xdBMMkgHCwDXZbHPkRLPGm0lFJfXjwKVnmZE8p3kDHWB4pqMCOu23wwX+j4EAyeItwKWwNMvpMAHd8NCQ3fpit/JBFhV23sadOThGq1Lrdr7ufXhHSY9q4ThUi0AScFus6oUp4d+KQiK4dDN8gsWY5swt7dGBLlPMbiyHRBwRcE2toIISIehotjTe4x1ZhcNBbNTvXz6GW1bz1JoX3FxT+8jIB5OtQR/mXtmdowZz92aHPoxq70paMHfdtmD+1T2kiFaEIY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jn3WgxZ/dCW0Ib4IgIHuaH3dlZLdz9MhcauTgqunVBCY41HvXVxOG21t97zP?=
 =?us-ascii?Q?1Xly/qcAX3BgZds3kaO3ZqcoCFW1GZ7HSOXrkyPjG2LzFLzo30gUyS+e9bN6?=
 =?us-ascii?Q?uvKk4pqgVQMTPipUwYljRRF8xoIxTrIUuzKjGBzuA3Herz3DDaq1nppWen83?=
 =?us-ascii?Q?huP7gFP4lXY5nWE2MPY4KzNKGdFQg+fAUNH+b1iiM/NEcJXqbxo9zIHBopqR?=
 =?us-ascii?Q?X4HV20Joy7odpII9AGRFQgVL0Y0gFdLwsjfF9H93Fm3cn8mmU/RY4Cj3k6lc?=
 =?us-ascii?Q?oal06kTg6dt26e0g3fNzIrWWy05Qu6NTalJsZrAi8k+/u1p7gTmS4kjhTpQW?=
 =?us-ascii?Q?XOaniBSpyYY+pm4eES1sGdfSsSRFdUZqeCkInV0jktGMWiVBQj4oq71sWcmG?=
 =?us-ascii?Q?svCSOg5m6TboL2AxudZ3RSET7wiEV1h4EljwQz/fx+vqwn8A+UvvmxyymWSi?=
 =?us-ascii?Q?PI/BCYYNPXcgTLW5OsZ8n1aPeDkaG1wXepLZ38izYXtpUEof4ciJTzK8Ockl?=
 =?us-ascii?Q?nypFWYEGcSIe4uZGnEcjsVFiIXsnFHPty2WJ6fdZGuF7vut4vFqLkAq/PegD?=
 =?us-ascii?Q?7Y9zWE+mVEB6s4PoZi+uG684gwZTM5IrdMe2cKOo7nPs5QItO4dTGzhclrTL?=
 =?us-ascii?Q?3/PUXRCSdeiDaPRuZlnHrKv5jbSgzM2l9FaUroTIJ0Z3LoCQ0VbD4RyxvQ+6?=
 =?us-ascii?Q?Z+rOdU3VQTI8sMTbBCONtAw3f7WUu3xLYEbuKWCY7HTicV/qBEV4r5yyjIJJ?=
 =?us-ascii?Q?dsQvJlD+vlpVAWO+5zC/r87cRTXzB7+mqnpKCKf5OYCz++jZ3z3n8NCI4Xhh?=
 =?us-ascii?Q?3bFHvUo6Hh6oUNAB5wqAAQJe/cGQc+gjNaSNAnG1aXXNdEMv6pxMWLMa9rgR?=
 =?us-ascii?Q?70wpoZCzOrHeNX8v6rIX2PiqNJVYv8wGlvjlAbfLSWLLxxajhvJDXik9qkmQ?=
 =?us-ascii?Q?Iv5/4zFZBPXcErpCpHYlgn1ia2egBCMnaOq3QzHZX4qciejamZ1J/5UemOnH?=
 =?us-ascii?Q?uueHdj/7L/+GkI9jWaLEnZaRl/IEUsPlnQHh+/4TjZ0S3W0SoE/9m9J0DDp3?=
 =?us-ascii?Q?vgBWAGpSnmSolZRnoQbeeB9PmPwtgXiZ5awgtcb/dlz9A0ZSg+I7YGL973c5?=
 =?us-ascii?Q?Qzk/obIELXbfhwc56HehZGbjGMv245655ysb66yDkLz/4bRqsXosBQ0q+hs+?=
 =?us-ascii?Q?uGXxlbrs1+plXhNotxLuDCC3KhxgWIkwpp60J7ccJV+JsFxglWWXrh81uzKi?=
 =?us-ascii?Q?OifTObYHsItMiut9H8SRpBa+nqUQzOOM9BKAo7sblxUy5oHWbkt7yj5iaHcx?=
 =?us-ascii?Q?6lwX5ddDqGNrBg0IrIS7JAnbSV8ZYU3b6PLmUvtoHyrRkzATpemJVURrF1ZU?=
 =?us-ascii?Q?91EMDZ/V+V7wpXIZeaUYRnmc+irZXi+cYhzrTxRRvyBOafm+qbmVK0/eeL+D?=
 =?us-ascii?Q?tmxGIIJIOHuHm0Q1+1LahLH+dHl2o0cj21zn9XCzJZcYzWnPONgIcTPcCa/2?=
 =?us-ascii?Q?Z/6bjowUrbfrrcqJ8+FrjIC0Ya68OD0SSpDA/glymmUEoCoad31vvssosrk4?=
 =?us-ascii?Q?/hk7Nkr9ZWTxNBqvh1Y7EMGXFcYQGMxJrgsoWMmhxb0BXiylTn+FRjT5i8EB?=
 =?us-ascii?Q?2/CwwvuGXcY/wVZYLzzwI4NSoAqhKOvc9lvbt2UlIBm8o2G1FGM93FVWKQ9O?=
 =?us-ascii?Q?RCXTu5ecE3KUnvVYoiKk5E3CogxSilE9fZSppwOiBYOhYeBOsrkj3SFJacuD?=
 =?us-ascii?Q?Waldw1a0JWdT1J0fCxdY3kl3YjtsZ88=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ecaff2ae-8980-4aa6-3fd5-08df238f4375
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:50:32.9775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPIkgCq0iueVsjiYJwM05Kk1m88UcK/ASUnrEjjtOtd4fjKYA1cbSItbk5raoQo1X8QuK1ddkvhisGtDTIKmoWoTlY0F+0Yy6QTV1onLBpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR02MB9388
X-OriginatorOrg: processmission.com
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The e6500 core manual defines PWRMGTCR0 as SPR 1019 (0x3fb). QorIQ
U-Boot and kernel access its fields during processor power setup.

Define and register PWRMGTCR0 using the existing 32-bit SPR storage
to retain the programmed control fields.

Reference: E6500RM (Rev.0), section 2.7.7
https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 target/ppc/cpu.h      | 1 +
 target/ppc/cpu_init.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 9d3d27be91..b716ccf540 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2346,6 +2346,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_Exxx_L2CSR1       (0x3FA)
 #define SPR_ICTC              (0x3FB)
 #define SPR_40x_ICCR          (0x3FB)
+#define SPR_Exxx_PWRMGTCR0    (0x3FB)
 #define SPR_THRM1             (0x3FC)
 #define SPR_403_PBL1          (0x3FC)
 #define SPR_SP                (0x3FD)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 032b8b606e..4d12152659 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -3026,6 +3026,9 @@ static void init_proc_e500(CPUPPCState *env, int version)
     }
 
     if (version == fsl_e6500) {
+        spr_register(env, SPR_Exxx_PWRMGTCR0, "PWRMGTCR0",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic32, 0);
         /* Thread identification */
         spr_register(env, SPR_TIR, "TIR",
                      SPR_NOACCESS, SPR_NOACCESS,
-- 
2.53.0


