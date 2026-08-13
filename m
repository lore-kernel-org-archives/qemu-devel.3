Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE46C5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXhP-0008EY-B2; Thu, 13 Aug 2026 11:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhK-0008Dj-64; Thu, 13 Aug 2026 11:50:26 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhI-0001rl-8Q; Thu, 13 Aug 2026 11:50:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCqRlCbTWFQGNKkQoL8zcSf3Y5ZwzW3QIYlM7rHV8PF3z5cwuuzZMwTs1Ih61SRtpUY02uApNKkVzgH8gOMehWpxQzr6RhA3tZHS8Xjst8mXmuMLgtU0G4J6ffmelFdW2+rG9Eis8PZKc1FgO6KPflPZq4YpX+AmhvqduNlQHkgV0Rt9sl/Woju2LkvzO5ztclUM2K/e2rSNZNjS9fKcMti8PGwF+46wEuhrzjQ6mEV32B0HIY6Q6L3br3LPq49M19EstJQno6e9PWe6vV2A2NnP3w18cGo1Jen3ZD7jfv7PfJ3UkSHgb5kAqLEFiwrMVfImUS21vUwbdQBSLFO0Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4NfL0LxMbffGyg0xp4lOmX9ve3/FIikUEAgtxvo5bg=;
 b=HJgf/udNfcRE3Dn2MwwMns0hO+RAi8dq40wOOO5tTnZfyoQIwLMrgQNPkeUdO78WpSlNa0E9oVnppc8yt/WQGzp2QKtECHrZU81zvH0wk/tByBQpXiSxO1ydt7SRTQCUKih2KSX5Zomzzb8dXe1n39eThbppqwhzbfW48SQH+v7lqYaJKBzLXREUu16+YNpYP22+tXatXmT7m0+tDtBjykZiBGDUL0iCoBVqbsBjQn9K6FK5YkUf5TvDErBniYbbCrkkv7x9pFesqiuHj9WhtHycwnUP2grGrIyeHQFAqnzLoOOzys3i7RE7QCXx7EAj5PF4vjZDDBuNPwd0lWCOcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4NfL0LxMbffGyg0xp4lOmX9ve3/FIikUEAgtxvo5bg=;
 b=TYisPFh/zsMuDUirEAHARG4IqKTncZ30KBiA8c6bZmK5PAYJ/NSrAR223nFWv+XQkWyMuNoE8Xni7RVLR/8rrh7ekUbrXgthfa/2VZRGU0PjV9X18DEbbK0L3mbpXo1edih9AjWqB4kQX5Bn22ixrNU2tvukdbRAuvQZ5aDKhR3NLdjKWJ2d4Y5OeHCQWkBgs9GE4bj1+HK9kNLZbHXRhVjJyGkZkhEUZrxyaYyRxYbOA+Wzq+Wvkvwm4M5mLcM/QO9h2qSM1EoZJC0D73L8utNYBdMGSxpD183oBYr70SU4wXOrPAdN2FB+12fk3LuwSxD4M2n/YMW3fFUQtByrCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SI2PR02MB5490.apcprd02.prod.outlook.com (2603:1096:4:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 15:50:18 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:50:18 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH 05/20] hw/arm: cubieboard: Store boot info in the machine state
Date: Thu, 13 Aug 2026 23:48:53 +0800
Message-ID: <20260813154918.996812-6-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813154918.996812-1-bin.meng@processmission.com>
References: <20260813154918.996812-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU6P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::11) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SI2PR02MB5490:EE_
X-MS-Office365-Filtering-Correlation-Id: 30258186-8596-4718-6ce9-08def9529334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tN16AYXB+/8Ju70MFNrQ7QEWwBInmoGZkUBFDu//MqA9SCZ6HQCvHDT8cx6TlmwjJgmzBTBz6G605GWK8Ds+4T0r4cSWblgWz+Jiz2h6QLus7PJ/om/pBAux4+7ukdIjJFqxwsJfz3A+y9izAYT/FELds3Sq1HFpZjJlgZmNjQbRnFjOgu7dZH2y6hsauwrXp4lmzAjZc/j3jWID3IVaZNwPREtIE57VZ8U+SvnGPZJxb8Hsn0Ufj5yhEkbQKvySUK+oJVYrj6HX2HggPnx2Z8gIAjC4+/HFXRrCqae3rNJktKkMqDnQnRccwSvcE3bsoTdIiz7gWbzWWOqHEvhZfm3dOoiyGd59NcD+3VPhlrSS5YtjeQr2JA0Ya6mR1BspDZaA0pgIZZqY/3Jj1lT0aJrn5PHN+NpjgeuJ+6xbiPF3JjgV+8t6M+xpqYSL8rGQ/IAiyvHcW9r5wx7u+7NFagubwisa8HE67q+ZmHrIfV0xlxmtbAbXFATYEthVBTudwFUwNH3KwtRDnyy0nT9gWJOTvFX6KNPtIx+u7+PucXLKetXKCgKIIYBpNSveQuOawRyMpjvlIwtfxoxG5+kfXL6//LasIRSldwbe03BX4zw0arWC87A50sGo+xmrM6fgmdEUI7OLPlrA1bUJ1ih9Aeeu0CtmXNqQTnnRBXllmuo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xk3lPAxG7kHwQTmryFtrf0C3P0WTMEdr7fOizcc9HfR2OPG59l5e0F8e8Dcz?=
 =?us-ascii?Q?cu/8TXMpHIOuZyNf9z7Rz0t190o3sW6rq2LR4D87YmLqpja9Q4vppM+fbT6L?=
 =?us-ascii?Q?tf4tgF8tOKUrDGCcwa0jJouBNMEzK+neeWqPhPIHDMOprWfd3rPLztuJIhtC?=
 =?us-ascii?Q?hfQah0L5F0qNk29QSY4NtmDx/q+rEpelIItOlhLodrls5GpuF0gf7KvpR3l9?=
 =?us-ascii?Q?fxdnvhmjBFvgqhWoofkQ1CNWcM6NdQ29xJCJGXWJonVv5Rnm67cSGrYZOXTI?=
 =?us-ascii?Q?6vzRT/jHMiO2xmdwHyCZO2C5vpVVFxbUq5wIx37lRqffsWv+Q0HGBZrApgOB?=
 =?us-ascii?Q?e81IJoCkSXi5oTggrnghqChkWHBCHPCiR0m0YYlcVeeMubsk/DqpeMhKneq5?=
 =?us-ascii?Q?Ff1zEY2uO3HD/FIvBKGpGttEPRt8+QnHfHJyg+PEDL9u1D4CCVuSSCqUgUfX?=
 =?us-ascii?Q?xbvjpcg2dbDeReFTsUbGaDjd2RNjHyP6IQgXnLmC1cr2L+hrvWkV3GseG8VX?=
 =?us-ascii?Q?Hcm7Z9lJCL0Xc49NJfq+XQnoLyof4INlmEqhIM+RFeNSJUjSUzbRojmhk9p4?=
 =?us-ascii?Q?NW6ewqkEchPz1HFS2j2rif6SK1gDIOePS26/u84vcO29Z14NBMTGi05fqOa8?=
 =?us-ascii?Q?8WYGbw/qix09vGCK3t5cpbKFH8T5QPQMW4NBuvV8HzEhaRj1Q2V9AtaR1XVb?=
 =?us-ascii?Q?B/OKjsD/acfgiesM0SHOyOvGJzE2R6V9cT3+0/S88uk0gn6YLQKL+mI+2cb+?=
 =?us-ascii?Q?JkyfFcqL3hr4VTjiNO2DG7Ut6w2IvvbTKN5qhl7XH4v9R8RVirIRV0kcU3HT?=
 =?us-ascii?Q?xuumxpCzaYUPs4xMWIZi6FhhNQhQZoy0rPmlkwHNCh0C7R1/Tom1u3uostl2?=
 =?us-ascii?Q?aeecxh9OlbjCYfGBDOV5ifqDcZE4hQU1eBZ6JN5jneKLOZxlU+k7EpW/Mywa?=
 =?us-ascii?Q?nQyWy246lXY+ozOwNqP7mpCnYUc71oDW2FjZnjmpdRKQ9OJHaMs7ZEz9nObS?=
 =?us-ascii?Q?4k2hIwQBJak62k3tN8eWaOcSQ/0hNMdDfY5capwI9hh3D3aqAmxrHTfP7KiG?=
 =?us-ascii?Q?YVVGaA8WaoAnfqMB7GbYFI/zGdU83Q4KFa49zCA1tDy1lyZi8Ko8AgJEEZwB?=
 =?us-ascii?Q?u6OQJAyzHe7s7ebbN5uHCbaiD1NgvZrSzq6SzgtVFTS/w8NRJt1M15g0yUr2?=
 =?us-ascii?Q?L4AUIlKW+u3t8Wln53A90SLWBIfTltswr30yzu4m+aiV3f8X2s5PYLcm72UK?=
 =?us-ascii?Q?k+W4DSyez10rdQpGJbfhFOj5/G4pqH91H0iiDbS17B/4lMr5DJuSyqZCvF7+?=
 =?us-ascii?Q?vto4ssohs7UAmrTkeAzZYDEa781v6Fx5ZhWQQ6sZ55XSlUF8tlUi+WB23qWA?=
 =?us-ascii?Q?4yURj/CB1rbds+ihjr9hTlzV6+nLQWL9JhVLjqOGOiejqwXRyYSaqT0ym5VY?=
 =?us-ascii?Q?ncDC10/L+b8z68ofYnqoQiglcgVmY4g95maZbyhWp4Qv5bdpdBy5KxRZbwmv?=
 =?us-ascii?Q?xARE6tkp0js5it33OKtD95xXSIjQF6t6aqX+o5JLDRtxfzVwiQCIse5xn5y+?=
 =?us-ascii?Q?x7v7BESUXRomhLxetnRXhnvp4r2dNvpz/8q8YkZ8ft8JinI0Gslbl8tVOJ1P?=
 =?us-ascii?Q?7wnuqafcZ65t8+vxT+UF0oQnhAjUoWEVMTIVppY2UyZOCI8+imClnHRW7m1j?=
 =?us-ascii?Q?BbGqQLLuJNV/HItGyupuQ4mtZypdAPHlYgF+CRGjZZDo6RupUwt3kVGApDbl?=
 =?us-ascii?Q?sE4M0NlW5aLoYb5botAt1kmgfdhEcuE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30258186-8596-4718-6ce9-08def9529334
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:50:18.6531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipySL4OqsSnhfBwZQlBfkLzclEzrnPI6Rqn+c9EyO0zQ5EBeMUgJJn7ha1Z9Lqxha4gIQRCFPAzi4pRjW3+MaBJnR4sM5hVJtowdRH328Z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5490
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

arm_load_kernel() keeps a pointer to the boot info struct for the
lifetime of the VM, so the struct logically belongs to the machine
rather than to a file scoped static object.

Move it into a new CubieboardMachineState and register the machine
type explicitly instead of through the DEFINE_MACHINE_ARM macro.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/cubieboard.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index a643ae4e27..45099747ba 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -25,13 +25,18 @@
 #include "hw/arm/machines-qom.h"
 #include "hw/i2c/i2c.h"
 
-static struct arm_boot_info cubieboard_binfo = {
-    .loader_start = AW_A10_SDRAM_BASE,
-    .board_id = 0x1008,
+#define TYPE_CUBIEBOARD_MACHINE MACHINE_TYPE_NAME("cubieboard")
+OBJECT_DECLARE_SIMPLE_TYPE(CubieboardMachineState, CUBIEBOARD_MACHINE)
+
+struct CubieboardMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
 };
 
 static void cubieboard_init(MachineState *machine)
 {
+    CubieboardMachineState *cbs = CUBIEBOARD_MACHINE(machine);
     AwA10State *a10;
     Error *err = NULL;
     DriveInfo *di;
@@ -103,12 +108,18 @@ static void cubieboard_init(MachineState *machine)
     }
     /* TODO create and connect IDE devices for ide_drive_get() */
 
-    cubieboard_binfo.ram_size = machine->ram_size;
-    arm_load_kernel(&a10->cpu, machine, &cubieboard_binfo);
+    cbs->bootinfo = (struct arm_boot_info) {
+        .loader_start = AW_A10_SDRAM_BASE,
+        .board_id = 0x1008,
+        .ram_size = machine->ram_size,
+    };
+    arm_load_kernel(&a10->cpu, machine, &cbs->bootinfo);
 }
 
-static void cubieboard_machine_init(MachineClass *mc)
+static void cubieboard_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-a8"),
         NULL
@@ -126,4 +137,17 @@ static void cubieboard_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("cubieboard", cubieboard_machine_init)
+static const TypeInfo cubieboard_machine_typeinfo = {
+    .name = TYPE_CUBIEBOARD_MACHINE,
+    .parent = TYPE_MACHINE,
+    .class_init = cubieboard_machine_class_init,
+    .instance_size = sizeof(CubieboardMachineState),
+    .interfaces = arm_machine_interfaces,
+};
+
+static void cubieboard_machine_register_types(void)
+{
+    type_register_static(&cubieboard_machine_typeinfo);
+}
+
+type_init(cubieboard_machine_register_types)
-- 
2.53.0


