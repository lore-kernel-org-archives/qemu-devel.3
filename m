Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176A3C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 10:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUP56-0003y4-Cd; Mon, 29 Jan 2024 05:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUP4q-0003v3-Mr; Mon, 29 Jan 2024 05:41:22 -0500
Received: from mail-bjschn02on20616.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::616]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUP4m-0005iY-3b; Mon, 29 Jan 2024 05:41:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXXV8g1XseaqQB/75iEEVaLF/U1w/9c0SGI+kr5T9N5mT+eL9KUrhxHKhksTK/oY11CQmgyk09edjXAXv/DQxDOgaiNsJxVPwyB/ksP/NcZ50etRGe2SDo2ybheN0FPH3rJXspnPNkSwkN4lW1/8HGvcb+Di4gLEtZkqigj88kXBX9n0NIZAAj/XUcmpKdUIL14h/C2pZ5IlfF2aid9i0wGnnA30Mscw8Labgk3UBkPrS7vzOlfQXkegUHAydH8ff+5lD8E7Go4kM4jdBs9QMagQsCqy+FUpHyn+iZsv22UZD9NkRRlMAcffa00JQq/5YP38LenYpl7v0QXLYkwdMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7VCP15G1BvqWTdQRPP3FfBZvOzet9rpsAoH/InIbt8=;
 b=RRNAFGsHZ1Zv/VV3IQm7TucH+GiK1PRW6WxdPd4iaCPvGzobo7B4tofWxLy0dFZlzhKbxhjHCResZR2sQ9rlHhn5CNtJk8dkyM1/Uk3thkKgwmmptK2IdNPK/qU25fxxWvfjGxhjhZeIWKyCwBl0NcwHKRYGg8XiTUjA4aIP5y4hoPD5Hf0UUp2DhZgMqfT+chEZQctA/YOC88wvci7nW8II5Tk75tQ+RWSQkDxYW/SrV4lHQJqESxzUOAySRg+5jgfpseOTsQFlpfE3wVZSJgSFqJELt3q1yNscAftFQUhQRt9BdKnEzMD1lT5kaZNTMk06kSIiYRcqW4hbz/3vmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0594.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 10:41:06 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 10:41:06 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, jeeheng.sia@starfivetech.com,
 peter.maydell@linaro.org, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [RESEND RFC 2/3] hw/riscv/virt-acpi-build.c: Generate PPTT table
Date: Mon, 29 Jan 2024 02:40:38 -0800
Message-Id: <20240129104039.117671-3-jeeheng.sia@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9ef9589a-0228-4d00-9edd-08dc20b6cc3e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQGDoRwvyRYOpb9lR9RsX9n0/lVBNRKIlyQtREe5n9gkb6xR9aG+cvuXOeTrw8tK2Yobb7iP4TMotVrR0yT99ii8InBe/zKg8nz5g8VKuN2M1NzR4XueCgj/q8adYEkJd/sP48k3Vze5YaJu6DwENII2R1FK6+8qUKK7pLQPmgr7E7Wadw7nFyu3k/9jkac9xpiRflQ8dOIHNzwQAPCurBf+uVcE2KZr2W+4cZTcjDNDsg9DvJekfE8UlygB/2bqwb4Gyf00Q90FuRkfBpZspj82YMCz14rnXxHMJtw/fTfusrIQg7oW5at4xBNyhHl99KBB8NeJvDYMPKMKcVZuDIsAztjrj72aVQsMzvlUqWS98G9YPjdET3qx0uRwGJ/1Ib1avNHYovIDnNYZjLEwYBI1pMnatLJmTb5ZcbZLd3XxWE+huWJfNTfIFHUPOi6jmhaKV4wXcsMBlfF3IqjX+UvVQTyvfynXGIv+TnBc8+NF6QWYrk94PK9d0M9PihqjavsyVlU08KInw+kFDrtbu3dXrOkMxXpp19iqc2gXnJ3qu68CRLZcfYlTnykr0hSf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(366004)(136003)(346002)(396003)(39830400003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38350700005)(41320700001)(2616005)(2906002)(52116002)(5660300002)(6666004)(7416002)(66946007)(66556008)(4326008)(26005)(1076003)(66476007)(8676002)(8936002)(38100700002)(83380400001)(508600001)(41300700001)(40180700001)(86362001)(40160700002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fmYyUEZkAyx95G1afj6YhupAyyFNeDmgEanGKNFXZKi2QvM5dYKwv6YgIRVe?=
 =?us-ascii?Q?UkWT86t5wP7kS0UNUgYtGTVIL1UAemE8Y3bOPYYoxD9cKkwA1okPStasj20Q?=
 =?us-ascii?Q?9T4aTfAJUxNjpQtacBz2rcc55uQQxJPYV7rsCuQZ+uy4cjF0JSwksx3Kqtig?=
 =?us-ascii?Q?8oqjmFlp6EA8T1Wo/gfwGfkfV6W7Ax060kGCwdN5yHyLBOOTEXOnJV1W9TD4?=
 =?us-ascii?Q?/TQ+MoUajzdfMvsEsf1Y4w/+rxk0Ym8FMgUe6dQMdP5EMFZnm36Nok4kxLbL?=
 =?us-ascii?Q?TX8loUFZytr5Vx3tb2Kt8C1GcmKD7VA5TXrAFAtelR4oKII4KJe+Cz6zB0Vy?=
 =?us-ascii?Q?1YNcxiSLQbmIhe60j1632xbV3O9D7p9ykx6O8I4Rp6la/964v0vNl9jGY19f?=
 =?us-ascii?Q?sLgQX2OakgTss2fhNBLA/Rsd9/Xkl2KGK4mRfJRWYX7CmEzPCa3fFRFP0AOq?=
 =?us-ascii?Q?T9kA/RQbdlRIttaq9Dlm7Sxv3f7Nla+aaXKFzaWaF9TetkmaRhS40rl7b8dC?=
 =?us-ascii?Q?uWDky04jrxVaQvpMer6zg8qq4PAQ6CG0oiCG8gzlqfnBikjFLFQOlYeAIute?=
 =?us-ascii?Q?wBVFlfW0MQdPxLKYZ4Zg5AuFbqdPyb9pm0anPR+uL5a0EqQIuJSP7+rUWFrB?=
 =?us-ascii?Q?lzqOLvQyjJvg6UXyY/DEUXY0K1SGlbRmtEHj5OuXJtO/W/YirYCG18dwP9d2?=
 =?us-ascii?Q?gwt2DBhc6Q0DGuTH/hQF1eEdgQeDIDaaBym/WT3ebZJnmnYu3YXJTOgATAxx?=
 =?us-ascii?Q?zCTMZl4iIHHSpHiZYRxj7CdbKBfZ3DYeouCFy82rTHubVKAxPOFu3q4VvPqH?=
 =?us-ascii?Q?BzRPRK3pH1RUWdxxxuCGB/rEkdYb8fJ3ZydtQRW2iqUI4xu0x3tX+gBOxQRC?=
 =?us-ascii?Q?itxJ9GHCddxAtaZ9bFQlbpu9670vuMtNMMmHUavBDSeioXPipFw2VnKdTnWv?=
 =?us-ascii?Q?yzstHc51XiD9sw2hwgg20atav02Pc/Oafhi9+MMJfjxX0re64fFxQQJ7rq6G?=
 =?us-ascii?Q?iO18MIfxmFwtDHBrtdp8VARFVzE2N6BfJQ9yVRtMYLiN7JXnRDQ5lb3eZKtv?=
 =?us-ascii?Q?+IAONULpuPBPTFBQHmmElT0IzrNLumgy2VQRidrPy7J279KWPE2wl65JMxRd?=
 =?us-ascii?Q?J6TPYU2LNpg3mzC+mJSYWMVpnfuQ3NSkBbfPird2ep1B5eET+HxKhcsIfc5O?=
 =?us-ascii?Q?hVKEnyZAP2i0T2pHvBbFoj70zXTB1fm63mX8e5ysjyJFe3VtfkXwK+dZvB/X?=
 =?us-ascii?Q?t6C9l4IxmvaZficH5e3OZv0Kk/O2e/SqGyC8+UyaxkpKOssMHCE8HdUpvwgB?=
 =?us-ascii?Q?cGVJr+3ieDjUAYn/kqnecCbj1MSZZbki5zGpgfNLfl2D9k/3Mn2Dl7qGL3x7?=
 =?us-ascii?Q?JpUYmtrcug41EsbKMECGr5BCOYrBEhhUgW6a0wotO+MveY7hEEFNbBVWlFYI?=
 =?us-ascii?Q?WWjqTtzpkfjqXQ2fEbrkn5mgcMfSij2Lln9HMybyOgVDwwQ6mVtGqg7KqxYT?=
 =?us-ascii?Q?36rTV4gA/hxnIBeoMKlkU7PmIPEAvVJOK843dbJNmiIYi9lxTyWWOz8f+Yzc?=
 =?us-ascii?Q?orWEGH2wIFz9TlIKxq3WS9uDjAcr/QOG/sx/AAXz56W2cyIwFj6uP6aK4yuq?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef9589a-0228-4d00-9edd-08dc20b6cc3e
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 10:41:06.5652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvFX3C1K0rXLTcIiMkm0of+3og/Sl3cJtmEkxF1E9zf21jfYP8kWCL5/rdaYGPjvHa1H7SNRnFEHwKqqX+lrrMQQlE3Hw3byzswr7odBNUI=
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


