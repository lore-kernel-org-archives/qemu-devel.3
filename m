Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE3BC47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 08:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUMni-00038j-Bh; Mon, 29 Jan 2024 03:15:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUMnc-00037l-BJ; Mon, 29 Jan 2024 03:15:25 -0500
Received: from mail-bjschn02on2061e.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::61e]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUMnU-0007by-TX; Mon, 29 Jan 2024 03:15:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGpgg/2lM81m5z6gUINozqVgZswqRfp/VZzxtPb+dI02/a13EMFOzuh9nky79IOcVmJrTfwc1vv6Ouk9uCofYnTQIAMe7ZEHSewIO1s5s9YKvsiAo8LXzjAiK+XiLJ0NmnrFsCjFWzGJx9N8G1jRv92UIdbgrS6iakePmwrAOAz8P7upfaO9dKsREDm1iwjI0bDQ+gyJhuZjse2IOJJ54l2QJje3StYaqvNfYlk5zauJ+1yEn84GqPr9r2GlR4gZ8Z2woD7YLZW4Undeob7+1ctL2KFcjrzl87N25hzZdcfBLxilnWFjC4os2YFiSAtpkvoKly9QEbZ27BQE6ijehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7VCP15G1BvqWTdQRPP3FfBZvOzet9rpsAoH/InIbt8=;
 b=d8L/YazOB1UpuXAncQrSmQYJg83MLYzmsArIxQuuEFTx5ZUwQEwLYGxo1Akn4AzRnIund/U0uvrTqQa8see84DDPPs8Yimo9joNJfCpYnrkpPo19o12rjt7lqAr2GiwVXDpQ22FhpftQlZP4kW3MGUIwR+Ke9t2JbYcJXsCETIeGpVB3db3wH//IRZGjdicifiB8ZsAA6U55TwiOuX2QbNVjj/0nTyFdBFhyfP9YGR/0ngEOxP3+leqJXQyVlRzwrkYMDX1BhiNmYEEW17eSmp5yXMXsL4+tBRqBi30BNaZ6RKOLORcbH6Jhkfgwa/rQSJ2h+c/nSdt5AQzyq057nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0721.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 08:14:52 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 08:14:52 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, jeeheng.sia@starfivetech.com,
 peter.maydell@linaro.org, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [RFC v1 2/3] hw/riscv/virt-acpi-build.c: Generate PPTT table
Date: Mon, 29 Jan 2024 00:14:22 -0800
Message-Id: <20240129081423.116615-3-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129081423.116615-1-jeeheng.sia@starfivetech.com>
References: <20240129081423.116615-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::26) To BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0561:EE_|BJSPR01MB0721:EE_
X-MS-Office365-Filtering-Correlation-Id: 947971c7-38d4-4226-b192-08dc20a25e95
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1q03tYDLfiGcHFOKInCDsyyIrx7wJES32aqNmhfg9Y867n0rAHsbmj+ecvIPVB423XQPMWMBkcPh+tUW2xY0aaIlJfQs1NHdo5dvzzrGm0clRdRdNHaD7L8YQaWBbG+l8YLPYUbdpZITdtKtNySTL6HYvnsS/nzPO9MQUM9sHM4Cj5OW9qZFPnmsMlgtEMkVM4ORpJmuGzjd44Pgc0oqj8Y9786FMxS158KsMrsy1CXijn0JLjxdWVoWje/iYh2wXtP638UpWCMiNv/0he59J7odLhtPVK07tjueIAozrJCv2CyFTeUmJ/5v50326ajYG38MuXWzOjMmKjCgR/e5lSm6wvyDN+X6xHTgcy/ugKTVPIUTnu613ekhtz6zfyms2iPXN9lzFBPiU9nR9vU3GJ8cN1qyoR8FK3dGkQozyAKDcn7GI5ylJ4ec5aPVL+Iy2gKQXnNLadPFSWFXZpWthDgZOZGchx1es3AODlI9t07hDthiPM5YRH5SdKONjJgnTlBpOLVLG7KaoXjPe02fk5iRGyPE87e/KvNiI2gElXWcFI1ySpK4D+SPkxGRVru
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(346002)(39830400003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41320700001)(38100700002)(2906002)(36756003)(41300700001)(83380400001)(1076003)(2616005)(6666004)(26005)(40160700002)(508600001)(52116002)(40180700001)(66476007)(66556008)(66946007)(38350700005)(8676002)(8936002)(4326008)(86362001)(7416002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qzwHpw2XuV+5Kg5/TNp5uTCMwp5SVvY+bdUTwUhWwN8LnR2wk0Cwe8PXp9FS?=
 =?us-ascii?Q?UTvTfaUUIZJogz0CMr3PXpPRXDU2NKQFSsWPCfBuG8VhsxhMESt0qihQWRHK?=
 =?us-ascii?Q?JxeUlX00dEs/wWWebxBjwx43YbmVLNVe1NfH2aExwmrfQ0eL2cNXpulobWcb?=
 =?us-ascii?Q?dPZ7IWAbN2BeBrfF/IxGfQyGAKJvCU0HV1qN/BnhJ3R8jfYnLi/qvXAB9+Z8?=
 =?us-ascii?Q?sEtSNj5q+Sz7PZzy7xi6K7RtpJHnU3f/VTDoX1ztvPxnRsem3USLHSGLdhg4?=
 =?us-ascii?Q?9Aiqa7nDk5nhuwh5sdAchv5hLJPKb46YqgrYKme8UDdXC/FBaSO93buF+wdY?=
 =?us-ascii?Q?xjVoqWaYQx2fKJp6AmDiWRxckwxF/lkW/jmxY/V5Gc4VXvSZ5MAodhBUo7v3?=
 =?us-ascii?Q?B25f/8dDLrdyhqp32Kze0wPu2KJf1BulRwQRSVlF9EgmJ/quaadoGQZUlX5R?=
 =?us-ascii?Q?Ln3MdIi7XpnI19UVPF0JG2/dm9S0Niddz/k1XdByUdTz9B/T+V8SqEB4vNl9?=
 =?us-ascii?Q?aVmfFOIzjdTyL1c66HROfcpy7ycPd4J8w5JRSfXugEt+4NfQ+UknLyIcOeKw?=
 =?us-ascii?Q?k0Xsn90up65sYVbj7MBfuEc9Ftn/y6XAPCrKcYhS+oi9WMgfU9xk9aasX7L9?=
 =?us-ascii?Q?KyyIIV5YA62oAfZREIgDBbqlG8IJ3fzFL6faRIpaoIjlQ96+Yye3SP1oORkc?=
 =?us-ascii?Q?RR3wRntu6yLK4MMFZ9+1LThmbdr66ba8mBqqpGGhDaRNW+A+G/Yf8arTCaG1?=
 =?us-ascii?Q?fEmDfxhqNzzYAl9C9MF2eqJFh+dRwyOy/is0fnXxaB+fvouLqxiihjbugPec?=
 =?us-ascii?Q?a5Hsi2pz4qmkcyrDFEDgeTzxTPqI/16gXva8Z0V0Fs8h9+0Xsvc2THOsC8wd?=
 =?us-ascii?Q?P2YrHu/cupMmanutwoO57gWJ1WMBesUhN62gfkodYGCU8XbbX0FN+t9vX+eg?=
 =?us-ascii?Q?7O3qGzDRz9MA6WD4VpqFTtGdgtufJae3hAzKx/ux8XBLaqPTcbByJ3mLbE/g?=
 =?us-ascii?Q?Iuxtsk/6koqnTaShYxyTm+D81N1IIMeTmw9QDDvHHyLwaz3gYe6Tf+qwfJPG?=
 =?us-ascii?Q?MHUSBt+9yyz1ZNu9ElxdLVSmZVHw6ehsc85UQOgchpW4UL7vBKWvNySB6Qm/?=
 =?us-ascii?Q?rX3IzUw7jk3mMU8L/cLqja1j4slKd6UwCc8XBKkVKcWx9CftlAPMiY4wfqqV?=
 =?us-ascii?Q?5i0qtc3qVo/vqR9JHaBU6ofSstRmgNPgrHPNyVJK8C7fX4HKV9qKq2NpHoK+?=
 =?us-ascii?Q?ljauUcTextduLfSPLc623gXslJEJ79BJgz0Efy7MMiyqSSGo1Yikqxw0w3ga?=
 =?us-ascii?Q?nAZVAVvVLD+q6ZTARCOcl9Ggha5qyIWAZLCwiU/RDT48rPK4/QAXGNbQJErl?=
 =?us-ascii?Q?5fC6ux/v+2REAov6BDA367DjqmrwHVDKyva2oJuMcAoKw+3k4tp8v6hZCw4o?=
 =?us-ascii?Q?66ZVt85SLyFnzCIED7rpZUBJ6XqAA2uC9EhuELbqUa+YuDJCE0XvZycwbVSQ?=
 =?us-ascii?Q?UBsY6PA7HdoE5iD9hAoRPdcPuTJH495UsxjNqNrdVkJjM5Ea9pGMUFyOJAbe?=
 =?us-ascii?Q?3f3RCpfDP78I1IZ/JlcMNH/ZeDrIJnbr68dzYH236FyjaKM+65xf4zWLt4Vm?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947971c7-38d4-4226-b192-08dc20a25e95
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 08:14:52.6273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2r3szqQr9txzb8Bf0SNtwhoBJ/YQdMnyNLm2WnPAqlWEIY7WgjylopA498tC/6LPs662aHiVq+e3Cdi8J6e7+dOmnV1031SZ+FrTpxuB6/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0721
Received-SPF: pass client-ip=2406:e500:4440:2::61e;
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

Generate the Processor Properties Topology Table (PPTT) with a
cache type 1 structure for RISC-V virtual machine. A 3-layer
cache topology is used.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
---
 hw/riscv/virt-acpi-build.c | 49 +++++++++++++++++++++++++++++++++++++-
 hw/riscv/virt.c            |  1 +
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 26c7e4482d..d95ae1cf01 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -38,6 +38,7 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/units.h"
 #include "sysemu/reset.h"
 
 #define ACPI_BUILD_TABLE_SIZE             0x20000
@@ -528,12 +529,54 @@ static void build_madt(GArray *table_data,
     acpi_table_end(linker, &table);
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
 static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
 {
     GArray *table_offsets;
     unsigned dsdt, xsdt;
     GArray *tables_blob = tables->table_data;
-
+    MachineState *ms = MACHINE(s);
     table_offsets = g_array_new(false, true,
                                 sizeof(uint32_t));
 
@@ -555,6 +598,10 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
     acpi_add_table(table_offsets, tables_blob);
     build_rhct(tables_blob, tables->linker, s);
 
+    acpi_add_table(table_offsets, tables_blob);
+    pptt_setup(tables_blob, tables->linker, ms,
+               s->oem_id, s->oem_table_id);
+
     acpi_add_table(table_offsets, tables_blob);
     {
         AcpiMcfgInfo mcfg = {
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index f9fd1341fc..a6f468fc22 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1710,6 +1710,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
     mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;
     mc->numa_mem_supported = true;
+    mc->smp_props.clusters_supported = true;
     /* platform instead of architectural choice */
     mc->cpu_cluster_has_numa_boundary = true;
     mc->default_ram_id = "riscv_virt_board.ram";
-- 
2.34.1


