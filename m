Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0B0C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 10:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUP5D-0003zm-Bl; Mon, 29 Jan 2024 05:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUP5C-0003zR-AV; Mon, 29 Jan 2024 05:41:42 -0500
Received: from mail-bjschn02on20616.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::616]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUP58-0005iY-4H; Mon, 29 Jan 2024 05:41:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3tNGGXhVfExlwdiSll8IabJ3DiAzDepOpYqyIUVk7b7HmmM0BwO64+bFsMjrkHQACzZVW1QcBB27lbIjthR9B2i0z9dKiTgTnRvp10mdejz5MpBGBOL901YSk+VOMvrOZvgKMUDetpq6naqZkj5qQfVRI7+KcRAAzAnQhXz08Kl6cp3PLA0fxWSdJ5+8iS1ND8QMxiBxLEhAImkLwI28mKMflSh3CBvTCAczmOn/RQI37zIuJHzglbBLXETUHWtNlchU74psZjb+TvUZqTvIGnBvlKm34zrKkKZRdIor3uZqwmD20Z/GCTQVBhpH0hGg9iKy+cdXaMRjcIhMsyA6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oR6oZhoEfVAJa/pd6hmVtB00Ch1tHWdIwMXgWaVHi4Y=;
 b=JDBq9TYEfuSy8KNE4w7S107meeGWZISnINI0nbLSJDFpy9F9Bb1c/zruTDIFMEpQc5yHZxXnts+5SEKntB4Gxxn/cTZDqoImz+MWFwINGZCgnN7vahgfz4GzGkOsuNw2YYxkJN/AmyBjMjTqb6uDO/nR8hbhPz2nUIb+tlnm79QaNwQMchj42EK86KoJwvL3lQPF7UpRRnN7e6PTS+eJk2ilUjQXeIwMztjlUbzVlaloBSd738ofLixFgUwXgk4ahaGP90xa9MXOHdD7tOOULz8dVsddum9l7aY89i54pPIUwBG6Yq1adHw8oUyp/M1Atrt8Cq6FTI5anI6sJUdPFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0594.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 10:41:12 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 10:41:12 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, jeeheng.sia@starfivetech.com,
 peter.maydell@linaro.org, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [RESEND RFC 3/3] hw/arm/virt-acpi-build.c: Enable CPU cache topology
Date: Mon, 29 Jan 2024 02:40:39 -0800
Message-Id: <20240129104039.117671-4-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129104039.117671-1-jeeheng.sia@starfivetech.com>
References: <20240129104039.117671-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0004.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::16) To BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0561:EE_|BJSPR01MB0594:EE_
X-MS-Office365-Filtering-Correlation-Id: 48926e21-ddb1-4c35-dcc1-08dc20b6cf98
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVHKS/WfyQn6t+RlTLbmU8Qpit1iCk/SX7SSZwvp+HeLYRfYGywWFshWS7Q2Bzq9t0u1/wO5mjg89c8NRBc/Q334W5CZeXfTfhvtGAPrkaZ2EcwaKuS1YmqkkadTLw92klnJ+nkmZRzJF6jK2IS9af/i66XqOUywByrreNwJavL3rJv1ob3M1R0hmmYvAKvBhR7f639yTbh3YfP0OZUyGMGQ1jbn4PCJ0ADf/6JM1GP9eecalo7Se6vYDSqU2W+ucD3XOkkMIVMc8kdazr/YIMuBeXLlqyqm9B6zZm422klLJ157DwjbiPcpBoykUpFG8lANAhUZePTsUjkezsBiCBC+GDXElN1DFMTN7p3/ZUwqJ30RnuP7IOT4WbirNQFQinZazDa6hNNtagpTrJFL5Z/Tbcc5nXJK4uB8FI1oRa48YWk6G9Wfz+xlssja2r0QwEIMr72+bXqiabBz4I4RombKLFFype8wYVOQRrPDEXC6OAmZkghmqLKWX+ovMuYAUAYBDQnum8IyP6TjzI3+0pAc3x312Iay3A3egOGi/zQk5ezarxlQ1JsrhyUyT/Ys
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(366004)(136003)(346002)(396003)(39830400003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38350700005)(41320700001)(2616005)(2906002)(52116002)(5660300002)(6666004)(7416002)(66946007)(66556008)(4326008)(26005)(1076003)(66476007)(8676002)(8936002)(38100700002)(83380400001)(508600001)(41300700001)(40180700001)(86362001)(40160700002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ovdp45Z/ek7alqIGCiuKL/Apqfe5eSZUa+f8MVX/KlMrSv7Kv8C21K5W2p8B?=
 =?us-ascii?Q?jb34YLPM2h7Yi5cDsgUAIwSTus3pM/Zd9Lj5zcIGuM8/6gWFzQ/D5X9Ckq8r?=
 =?us-ascii?Q?5npon7FQzg+amFS6xWl0CPcZ6q/XaSWDNipVQcOQahbSrOtLMOGwOina+Bta?=
 =?us-ascii?Q?0o6bXsBT1fzgT6XpsHNYsj+FyKRB25XTPwNUdeNTNcVZXfjEEwy3J6aZFvwZ?=
 =?us-ascii?Q?Mc6vkrTLfKnWNNATNZI18PtJQgBx2iB9rV8M7xUU23DrV2wbBguuaWlN6uJ7?=
 =?us-ascii?Q?wRF852M39A5fTv9xan8lUIgldAGxZTkAbXqISzJX9PSLpvL2HKaxl6E2Q2JB?=
 =?us-ascii?Q?rrLFqsqAYlvs2Y6MPJcQOWAkwdk4+1dtecgQa6C8Pql2DeMEpESi1ti+alks?=
 =?us-ascii?Q?jtAv8xu5SdxwNTSRq7Qsuz7hGy4gdazouzM3NqZk1sH3AO4n/ofY5SPLHdM3?=
 =?us-ascii?Q?DuSvh+qOh0O2eHWEEl+bFtpfEbh1mF20JCp4UUDOTCysWbNrS8/ZbBuJjC/l?=
 =?us-ascii?Q?HPsiTDTAobtYc4bwnd4DOkoBLUgeo3ihCryhglToKgmCeWmmRF0h/OYVinko?=
 =?us-ascii?Q?0f8HeiensxgOvX2y64jLeqOpToH/PC/QF5kf7uSLwATKutipD+A0w3oYLXaA?=
 =?us-ascii?Q?P8++uiASYWHSLsOOmhlT+6X4OdYzKOq5QjTA/06eRVgTNYW9lu5hru9Ct8f1?=
 =?us-ascii?Q?gGT6jb8gJz41cm4ym3c1VTt36GQffsJxX3kt3O2eeqKyqSEPiqC4njauQ943?=
 =?us-ascii?Q?vLO+XOqEzzgr30bSOJJEVr3SBn1MQ4V6eOwLftbNkVIQwipPkSkDN0V/8y1K?=
 =?us-ascii?Q?8vVJSd+S2YptqisYVW/OpTgVCvNSVvF/XL8ZVQ4mALTE3/EnhCFX7Gk0PsOs?=
 =?us-ascii?Q?ANuSs2mAoAfKV2dkCyeAOGSjOoN1xhkKoYLOMuOAC3mttnsGeqqJRlQRfltd?=
 =?us-ascii?Q?iDLFd3AVZD1X1edzpVrCV8P1tcsAx3zajBoNg34ol6m7bVrimfdv2QU5TKYO?=
 =?us-ascii?Q?MQKS5vHAZn21koAacPZkik8S0VeGdPTad36Ekanzvdgm6FO1H4c7nPD0SAAn?=
 =?us-ascii?Q?GmpyHCf4jWYHBWFHFJPR8r0SFZN0f3JkJMC86RXLG1xSVgh7bzHlMIH+eJSU?=
 =?us-ascii?Q?qLNA68hDxmKk15ajABNXNyIP+spWDtow+xDkYdhGJZvEj17kqXZhdGwVtoEk?=
 =?us-ascii?Q?ooESOTrh9wz9F0Iqqz9GbfUtOQy0o3tEzmZmeTi+B6LHeZIlq9F98HuC1jdS?=
 =?us-ascii?Q?uDw7uzXBkIkj/tIvWd2Ac1pjqZo24gO1RatMGhbV1We2ASagz38edOhZOSU7?=
 =?us-ascii?Q?OKmi6nzji87jkIOYPTiHT5SCE1SnVRpJzt3PQYY+M3kUIXBL6Uynu+Nn7Ki/?=
 =?us-ascii?Q?AQv7BBdtaCL3KNqh9hIh9kqaUBj+b14gSqbOffiR2Kl9EZZbime6txsn2vjy?=
 =?us-ascii?Q?JJRo5kJV+s5DIBAOqxyaPG6n8sWRl8B4UrC1BtW3MsItoYNUkJqteKyL0yRS?=
 =?us-ascii?Q?N/LihBvPryNsEEmAy2sg1QOOQKdKsOAHA7iesrpUe72kSZZ3brDMInt/YGmU?=
 =?us-ascii?Q?W5Ud53Rf+HSgwTbDfg/Wzai738+LjbWJ/G105PqgbCX/vLwIHdxZsbHbJBzp?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48926e21-ddb1-4c35-dcc1-08dc20b6cf98
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 10:41:12.2059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LtqeuRVR2IUxQBxpsFOhShzog/yY7EsI2tPlzHTu4+8D0zwG9lP5v+QJaCQGoBGo+s/y5KSVwoyb6zCUNH2JD8A/yNe31adIBuapjbBXOPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0594
Received-SPF: pass client-ip=2406:e500:4440:2::616;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Introduced a 3-layer cache for the ARM virtual machine.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
---
 hw/arm/virt-acpi-build.c | 44 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 17aeec7a6f..c57067cd63 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -426,6 +426,48 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     g_array_free(its_idmaps, true);
 }
 
+static void pptt_setup(GArray *table_data, BIOSLinker *linker, MachineState *ms,
+                       const char *oem_id, const char *oem_table_id)
+{
+    CPUCaches default_cache_info = {
+        .l1d_cache = &(CPUCacheInfo) {
+            .type = DATA_CACHE,
+            .size = 64 * KiB,
+            .line_size = 64,
+            .associativity = 4,
+            .sets = 256,
+            .attributes = 0x02,
+        },
+        .l1i_cache = &(CPUCacheInfo) {
+            .type = INSTRUCTION_CACHE,
+            .size = 64 * KiB,
+            .line_size = 64,
+            .associativity = 4,
+            .sets = 256,
+            .attributes = 0x04,
+        },
+        .l2_cache = &(CPUCacheInfo) {
+            .type = UNIFIED_CACHE,
+            .size = 2048 * KiB,
+            .line_size = 64,
+            .associativity = 8,
+            .sets = 4096,
+            .attributes = 0x0a,
+        },
+        .l3_cache = &(CPUCacheInfo) {
+            .type = UNIFIED_CACHE,
+            .size = 4096 * KiB,
+            .line_size = 64,
+            .associativity = 8,
+            .sets = 8192,
+            .attributes = 0x0a,
+        },
+    };
+
+    build_pptt(table_data, linker, ms, oem_id, oem_table_id,
+               &default_cache_info);
+}
+
 /*
  * Serial Port Console Redirection Table (SPCR)
  * Rev: 1.07
@@ -912,7 +954,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 
     if (!vmc->no_cpu_topology) {
         acpi_add_table(table_offsets, tables_blob);
-        build_pptt(tables_blob, tables->linker, ms,
+        pptt_setup(tables_blob, tables->linker, ms,
                    vms->oem_id, vms->oem_table_id);
     }
 
-- 
2.34.1


