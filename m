Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E6AC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXhb-0008IH-60; Thu, 13 Aug 2026 11:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhZ-0008I4-Js; Thu, 13 Aug 2026 11:50:41 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wuXhW-0001rl-JF; Thu, 13 Aug 2026 11:50:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDytenMuPFe2lgTRWvZeYpBRMFG4rqK4ISW7H2p1bF9Leh9Me6h/3ev2cjzUsuoLZxWxzYigsC2wmUqJRCLClJwGEyMNI5MxVhRBdFBEDIxhVZ5ndhA56STXTsyk6JX8FnmG+t2DxpwBaGFF3m9vq/8/P7bPQMiVEnO++RWRfLB48+XslN7Utq5CJzlIQyGOITp/2wvPHvWr/Lx5JtcWLnSPGUz63Wlc/Df2sg6zsoiMdqMrKBzP4Hz5zrNtkvjWWafOXFBanqSOdPXlzK0CqUFLosJn8ofJmCLDOHH5zQLVhJxjC5K7aMsuQ7E8jrT3VX5YeFgQdTiV+C85mmMWWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69+/qvXgw+ev8PHydR3sI6ZXDYC0WgmYP8scvizzU/s=;
 b=RFsLrq9G03M6d/4NrZeA15Fkhg8Ozv4YF9p5h+oEeNpMnJgkWeF7w7DL7AGUUzCzCxAryeodmrd/7xwnbIJ2VVquYFdSsSEtY491TwiaXfNG0SeQXEOiVCDXWX6yJph0VaFbATP+VpR5bVtnOk4oTP+my1S6K5WskxSo8AE7rRntS4wbRv7MrU5D5KTbkF2RRgKZ6z43dDNJGXp8BPgBu0NnZfqU0MLXePEBZ287ijyKmWwRlzSUVbE2wggtfYrbS2fBASWEX7VApAhQSGBp9uzx4ULsJRsICjx0nQGlBHHlHaMQLUw5UwsP2iUuvedbJoITZjPhopAHgDRH62T/AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69+/qvXgw+ev8PHydR3sI6ZXDYC0WgmYP8scvizzU/s=;
 b=moJkRO54WoVSndLGaR/9VXX12cUIrhDDQZ/z3X7U+rl8s/oi28dnS2THWaclJfFihj5tmwH9x07UOynfmudMURlt0WRDRT97+ZWP2XCj1nrHyiyshG1JgopXo2wYAQM2eMr77ofHCTfC6/ucMYwf9RPfRJu3v7Tr9Y2EezayvhANlmix/c1F/Do13jTytsi5fNRv56kypQ5lCLTlbfK0iBT0W59MFTzke5qPJtLzn0AlOJJg9x53nqLqM8/lgCRjk75PaQF9HXvePw0o1RmVmJbOWl2mm+OEdCOm9UhEAcOkFqJ3uk2LncRRmy60XraRLNOKl4IwtWQQe+57MbLeXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SI2PR02MB5490.apcprd02.prod.outlook.com (2603:1096:4:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 15:50:30 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:50:30 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 08/20] hw/arm: imx8mm-evk: Store boot info in the machine state
Date: Thu, 13 Aug 2026 23:48:56 +0800
Message-ID: <20260813154918.996812-9-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 68eed20d-2dc6-40ce-2c86-08def9529a75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jK6rNDtRfMHf76GW02WHB88LzReJLJlczOELj+Nj80tjpT6QCBRW7VYr+UHaHj+bA7cBG694gd6qmXXw+BhV/DtEhTlBTv63kuUsnbzwvDlZ1HMRwEbc7ErUmv3ly4sDy22DdjK0ylCx5nj4RsAW1Z0nAVeWD47baysaGuyAPG+FaMWpgcj7FQU1ZigPOk66J984uaXnyaX06weL1EYTUOBEDP4ANHpbrvSLVaxIp731S3+pzZdIL95Uc8bIXqqVrjb6Wk/5XuIPe60EgANT9W5CPaqkpGsrGXel1A9JJA6yYGClhO7/H376kzWcVn7CM5N+vGhamTbTQYGYTf9X75koMWl4s/TL6kiu6mxQVERmt8XtI5GxABrHBHUqDz26Aox0OF7QhL3yEtWZhcuu3c4pNwK2jIxqL+OoQVLPZa45cTTaOgV5Uq1tr4v+DOyBgY61enL2MohGuokuWt7h82VPQuJ8P+GJ+au7dx0kKgLYOIKprBFRXK38G3Hv5NlTb4oiY4mlpC6tp/+ojKg+rfs0yuj57SRuKSPVRhM4efmP3Lmg2uO2happWor4w0dH+3cmrL/Qfvs/EDiyjN+SpsO0UTdTgqmofrOZFW0Wf5qwpDbHxUMv6aWjhKKKk6k7b0qe6OhfXm0cUlpm4e6K/bsDwDG3YMch2z4hoLrZvgM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lJnxZ/uFhQ5cVkSlEv88RYrX8btUUp0dZ7wth4CiO4UhXC/QgQ4etgtj8k87?=
 =?us-ascii?Q?OlV9Q/yBJ4qreY6Osz4o6gPOk21xCRjKQGv/04tZfB8ZF7Z6GVnFPv1VpxKu?=
 =?us-ascii?Q?lGNgM7LyFQgi0RpeVRxk29Ui6c2iCFxUtoBombSebluw55Y6syXtWI6gyjhJ?=
 =?us-ascii?Q?Tmm5JHTpSCUzTYagpemzPC2LwWca8CTm++xJRFYTNR8l43hJt6yBUdjLEC1d?=
 =?us-ascii?Q?oDlbALBLAmBkqwM4KsQqrXYUaB2BJAHLAzn+myPC3E2xAQwdP9H79tIwk26e?=
 =?us-ascii?Q?0a/z+sepqylyruQTsWqVy1pK/yfAuZrJMUdSzrzNB+2vmgN2OFqPQFFMFxkj?=
 =?us-ascii?Q?+cMm3CmLYqGbNwVkbU//a48FR3agEebc68JS7joNCDOh8GRIjbtxQSPqxcMj?=
 =?us-ascii?Q?U33Q/VtTgOIopMwGbBrrZa+LG0H79ouKfYqWUKzhShBgUdYgpTNiBEunYgFC?=
 =?us-ascii?Q?3B/CmwQ0zSXBlhITq6Nc5aG+yvKM8PTpIpvY/sWNDBVKSvpCg1QrYYWnFcfD?=
 =?us-ascii?Q?El1CTy6Pjr5sRRMKhgt/cOlJa3FtLheqEBN2/ZrlhUjVc1bRzushtdjzOP9o?=
 =?us-ascii?Q?Ac+pSuCkzKeDbXcoiMi6T4+74Gr5YebBoH9wgfuhg2K9BUFVHyxYFKiEW04z?=
 =?us-ascii?Q?ZulQ43diO0Clp+9P2J/9xREZxSK9PZUS6XEdv+d56qSHE+fM+BIJ7zOfKKR+?=
 =?us-ascii?Q?5NfW5m5IlDg0bkDPBBYkLxlDlZorM+eAnxkXTCYjP6JU0keeOgGwDcKeZ3Sa?=
 =?us-ascii?Q?K/RiB2I+7N1CXUnd1hvt3lYTFEEVMMj42yis6ce07VvoWp8jtvYCGbVwBXx0?=
 =?us-ascii?Q?TK+yj8pv74I+C/RsuNAUr8Ry1Xcl7NuszzeEVgQISn8rN1lEjo0S1Q1X6lmK?=
 =?us-ascii?Q?XIo+kQOWXMvR0y36u7X8ZlZZsqva3ADu98hhzCaywsrjVd053UH0ydaSzpbF?=
 =?us-ascii?Q?0QjQi3lOapeMnAzfkcOuac8skF0PwXXjXO6u77NSxAWUdFs5+XdgM5GD3daZ?=
 =?us-ascii?Q?T7+61bw7oIGhxiPWXZvLyEGsZvli4wqety+z+7uMAhMsA+d7xeDPValyXqhK?=
 =?us-ascii?Q?wJbzO7DuChLSUAKqDeAOJ+4wl8RgbeQfmjp88LfxjN9/ntEk+IZl9dwZ6GEJ?=
 =?us-ascii?Q?4s4tR+Z3r3wYUXSs60y94zKtIWtPcE+ZDkqgwXbxwQKnVjRa5dfFth0IGZk+?=
 =?us-ascii?Q?iQttxevBozzAmmnL/cryT0dBznMcxGFDQ3DgAdSbpzZH6TNHEAXxg1Gk+MfJ?=
 =?us-ascii?Q?jrZabz7di1iUQtPmJsyehKkujnPJo9+8mlYkK/cbXXg9Eydi8An/XXTAa2Al?=
 =?us-ascii?Q?RRb7Sttfo3SGqSLgAbRRxI5X7qlIlDgGlX2AYyv9rLwiBOANznQKgZjPqjrG?=
 =?us-ascii?Q?jkbHTC6eq8y3tjbK4DCTlL5aIXfC/5YrJBWr1i4QCzRYou9b7ShSIAZM4pBN?=
 =?us-ascii?Q?XpHfndWYJ7DsniayXi+sDpne4QXxJd3xLntIQCfUAy3r8LZU4G6guN3AkObf?=
 =?us-ascii?Q?9QjXQuhW5swmsGUqSpZU2526sak4Wgmd0W2TuO1pvJYE4JNYy5b2vaGl4Q0K?=
 =?us-ascii?Q?P7a1qvtwViFuv87O32sVfvgi54AlArNYd6eXqBOu/RkCcNCHj3JeS7oUH+dG?=
 =?us-ascii?Q?StVkTl1W3k+HNYq/BoW22mnYhxHqX9zfvK4mG8JL5ioDrKszt3ENMoBDV2Bn?=
 =?us-ascii?Q?dZlA3pUA3I25wMCySph31wOQxFMh0YPuPNpGuFoOacMaG+kMIpV+MRTIVDe0?=
 =?us-ascii?Q?kH2aZYKu+JFGPDq9pUEnDDh4Ge80ukM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68eed20d-2dc6-40ce-2c86-08def9529a75
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:50:30.8218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5M67CU18IDxLs30a2nMjiCOhiYApM4CKRldPT1XyaClEnNADowUH/L1iIar9w1MXEedKqfpXig2Ny6mmtjm/+0/3JNo2RcPMAJZh9/ZykSI=
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
rather than to a function scoped static object.

Move it into a new Imx8mmEvkMachineState and register the machine type
explicitly instead of through the DEFINE_MACHINE_AARCH64 macro.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/arm/imx8mm-evk.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index 6b7774d3e2..cbab8e4307 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -20,6 +20,15 @@
 #include "qapi/error.h"
 #include <libfdt.h>
 
+#define TYPE_IMX8MM_EVK_MACHINE MACHINE_TYPE_NAME("imx8mm-evk")
+OBJECT_DECLARE_SIMPLE_TYPE(Imx8mmEvkMachineState, IMX8MM_EVK_MACHINE)
+
+struct Imx8mmEvkMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
+};
+
 static void imx8mm_evk_modify_dtb(const struct arm_boot_info *info, void *fdt)
 {
     int i, offset;
@@ -60,7 +69,7 @@ static void imx8mm_evk_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
 static void imx8mm_evk_init(MachineState *machine)
 {
-    static struct arm_boot_info boot_info;
+    Imx8mmEvkMachineState *ims = IMX8MM_EVK_MACHINE(machine);
     FslImx8mmState *s;
 
     if (machine->ram_size > FSL_IMX8MM_RAM_SIZE_MAX) {
@@ -69,7 +78,7 @@ static void imx8mm_evk_init(MachineState *machine)
         exit(1);
     }
 
-    boot_info = (struct arm_boot_info) {
+    ims->bootinfo = (struct arm_boot_info) {
         .loader_start = FSL_IMX8MM_RAM_START,
         .board_id = -1,
         .ram_size = machine->ram_size,
@@ -103,7 +112,7 @@ static void imx8mm_evk_init(MachineState *machine)
     }
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->cpu[0], machine, &boot_info);
+        arm_load_kernel(&s->cpu[0], machine, &ims->bootinfo);
     }
 }
 
@@ -116,8 +125,10 @@ static const char *imx8mm_evk_get_default_cpu_type(const MachineState *ms)
     return ARM_CPU_TYPE_NAME("cortex-a53");
 }
 
-static void imx8mm_evk_machine_init(MachineClass *mc)
+static void imx8mm_evk_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "NXP i.MX 8MM EVK Board";
     mc->init = imx8mm_evk_init;
     mc->max_cpus = FSL_IMX8MM_NUM_CPUS;
@@ -127,4 +138,17 @@ static void imx8mm_evk_machine_init(MachineClass *mc)
     mc->get_default_cpu_type = imx8mm_evk_get_default_cpu_type;
 }
 
-DEFINE_MACHINE_AARCH64("imx8mm-evk", imx8mm_evk_machine_init)
+static const TypeInfo imx8mm_evk_machine_typeinfo = {
+    .name = TYPE_IMX8MM_EVK_MACHINE,
+    .parent = TYPE_MACHINE,
+    .class_init = imx8mm_evk_machine_class_init,
+    .instance_size = sizeof(Imx8mmEvkMachineState),
+    .interfaces = aarch64_machine_interfaces,
+};
+
+static void imx8mm_evk_machine_register_types(void)
+{
+    type_register_static(&imx8mm_evk_machine_typeinfo);
+}
+
+type_init(imx8mm_evk_machine_register_types)
-- 
2.53.0


