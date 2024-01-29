Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283DFC47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 10:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUP55-0003x3-M0; Mon, 29 Jan 2024 05:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUP4k-0003ud-Tz; Mon, 29 Jan 2024 05:41:16 -0500
Received: from mail-bjschn02on20616.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::616]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUP4h-0005iY-IR; Mon, 29 Jan 2024 05:41:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQu7nleGqbR1nD+hC+xGopo4nljNRHglAIEOPUaWRIV8H3wbdgLMcIYKnqiYC3y+7R7CX+pejFFOxLZrXL+/EErQT0DmRhDO4StL8ctfRT5tmoLe3//s/NjnO5iU3JeuKwXxRFgxW/bkxTTcoVhkD763M6e9E2MlUxr2lZh6eJdCpH6VtSUn+mNU9N9hREmRtggj7T2MC+rlrJB4y0P8rKO0sALgcAG3gwo4LEgY7XBRgw3v9amaR/a6318IUYFUzdiawGYDiTplpCWYKbOQG0hd/IKxbCQSL67hSZsxPX1G63VlSCHXvePVlJMm0P2YudTm541JIilHCDCfjNpAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LogpkUc815GghXysrVzaK5/BneHojt10kmiqRXhKgEM=;
 b=Irjnel5AOseBKhbfnlphF7oW6NrmJJJRyoP2DPjtG9ipPZDqZEhw/e3To2gJJcYIBp4fLABlk0DZjgQn3LZ5yFDdS53tycDVn9ZpDTSWIWvJJpb5sQvaAXzLf8PtIExyyeL75V02jHecctl4EGtfbcgCmb8wj8rXe4/VLYf5mcJlmIeQtxj9uTiG8oHBbibGIdg2zOTPewlNiPgAASV6U9Taa/wnaoE7lPmXd2Ye+BXFBZtYXzaKPHGWHIOSCC5JPWpncURV2lk5jgoaekZSZIfNQzi37zuZlfvB8GSPhizOWwfwwvJuuQWUByEcich+yzdrd1EYt7M7CJR1AKxfxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0594.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 10:41:01 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 10:41:00 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, jeeheng.sia@starfivetech.com,
 peter.maydell@linaro.org, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [RESEND RFC 1/3] hw/acpi/aml-build: Add cache structure table
 creation for PPTT table
Date: Mon, 29 Jan 2024 02:40:37 -0800
Message-Id: <20240129104039.117671-2-jeeheng.sia@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 24989447-b928-4309-259c-08dc20b6c8e9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EiTWurddeozz1WKLYaYWjvUo7t8bvLDERP5fD2ncKAEaz2lslwZgVbNFAjl1qFMKJ7T/XC37GrvIvmz++ikp1j+var6VQOLH6RlC/WCW6ury4aAdx4DGI+q8mTPpAlYKltZ6sbOsVmejyRtVvmaHE+51TGvCrY2annuUkJ9ALEc59aGbwmOsX5tCdPaY9Puh36JgnP9yhmBEKY/azVtR2I5AyCGBFR5jBHhymRWunZwjosmGXY7XdAo2aEstlL4pFhPmFPj6/gsx6HtjeP+9tcc4CftVMxDCOwhnrAR0rGSIdiosTUeS6OxAZBONhs2xlTwPwAyd5M6LiGvFWRjo8LFz+JIlZzKYB6sD5rVKP2e+9ShPbRnDXlG6e6FSjmlyiam/+0xXjzI+CLttjB/PfqhxhOb/Gj1Y1ReF6oQYwegtaQX3WsdHpngWLO/uB7HKRmKNWzaTJZyIgWlXnSNkNqjgoPHvL+g5OSMjLv4GM9v8Q9mjPjH5/iObmz935hsfOLLfvscC9skgUBlh0o+/AOJ/rk+lp1Gxijq2ntS0xozgrQwzw7uQXH4Mi384HuRM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(366004)(136003)(346002)(396003)(39830400003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38350700005)(41320700001)(2616005)(2906002)(52116002)(5660300002)(6666004)(7416002)(66946007)(66556008)(4326008)(26005)(1076003)(66476007)(8676002)(8936002)(38100700002)(83380400001)(508600001)(41300700001)(40180700001)(86362001)(40160700002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ajig6hKmXjKb4OKusRDgMGo4nK8eFbhVkrG2YoDLfKc2f9pcC2YIDGVISJtk?=
 =?us-ascii?Q?VjnOPxk05hV9Dk2L5sQ5dcu2kgd9kMF8sHsgs5IwHeXa1kBD1c+2XLoYc3yx?=
 =?us-ascii?Q?9vvd/58u0w/RaPUj8N2j7PlTp8zdrutkyYJME6ucr9XHLN+AMfDmG0wWKcse?=
 =?us-ascii?Q?TT9V6dvtieOrt3Ywa7I+ElnZwG5IwS9iln4RP+RkeX2I9KhP5d4Tr7YTmE0d?=
 =?us-ascii?Q?fq+oumBBkmETKdbBYH8q2qCmxd4HC9TTqodk+zfVnzJ8SR5bxszy7UBahn4u?=
 =?us-ascii?Q?TBNNIhQDyXNx59tVwq26J91xb3XFx6oIIo1NqQFCfJraJCUkpKYRyY6uLdvG?=
 =?us-ascii?Q?zCvCStBYkLDZduZAlLP+EN/zpb+wSFffUYo21hZiTRxHEUNbCICkz+esaP1D?=
 =?us-ascii?Q?9ij53AZuA2wBwe+7XYF2loxLeW2zmiE+I4pwB6KNbyeDM7ENvlsgHIMA52i9?=
 =?us-ascii?Q?iJtOYinff0AWnOUkAd5vNhtCiwyPZ+at2ElwG9iaBGnBUu38Jfnhhkq74/Pd?=
 =?us-ascii?Q?nOjnFWasYe6M58HReoTwj4SVXRyHd+54VsUkz8xaoekWWNCV17RVm3ANRWAG?=
 =?us-ascii?Q?5wSTI33ks472fmMbNSGDW1iQMhg5LMo7L2B5Abq65m56kQLM3Vumo+T/3bsV?=
 =?us-ascii?Q?KUFTDTCOdOmLzStYvl3fiq2oXvjYCAruHNxaPYFam5MA4D+2j6JCFgD69vHY?=
 =?us-ascii?Q?UMIMM++ZImoIDU8pN/XgyInGjjHjRjKzQWeqMAKV5JSGVEpsZO6FhyHzXll5?=
 =?us-ascii?Q?jxckIDW5cOm46mtc5nycs1Xfuy0BL/uDDPr1fpyS872q+UHHDTdEUWg5JrYL?=
 =?us-ascii?Q?zLaXSKUr007sCOkGShC7DxQX6svlMgkOnO1qWAOVYmJ/vfV3yME7J5l9UCk+?=
 =?us-ascii?Q?Vp7smF7Zz/cYWe6i8FeSdQXxER1/FtSFRbjpdCuvCWkAWeF9VTFQCfBDNPQY?=
 =?us-ascii?Q?T99s0/68Ob2qJZpy+jvk6FDlftQy8HJpiY6GfXTxtSXhj4WbmezGWLEygf3R?=
 =?us-ascii?Q?pmsOnXfwIRWwEIhq9SPfb1psmpChZtkiMqq2jxBOl4oNQla7NRWq+z2TTHoh?=
 =?us-ascii?Q?YGfJFCTOz1NcOenI2bCTv2wOfny0q8lhF+l6umotJaEgEHGUFKgDZnVNDx4T?=
 =?us-ascii?Q?98egLkrSpmb2P1lhUwUxXnu6gXqNJSoZDHOOibQqK+bqWUZj23PIe4xxLbE4?=
 =?us-ascii?Q?/Btt1/jWxSGWmoa3oVkEFUoSb8bjuy4WRXULrJ9fCeSLRea8fPeavj6CprQR?=
 =?us-ascii?Q?xOwm7ncdTkeb2e3VUjKlDgi/qGOXDaxywrHV/t8p9SslSXA6+kKvz5jf20oS?=
 =?us-ascii?Q?526YoT/JnBviVitpA8cLhNtFhKq0HDOw7napCjUwZvz0asJxRPAMefhx/uP+?=
 =?us-ascii?Q?1QvJo0vrRFwITsOkAJG8ClRnxBNMTwofJcuQ8LmKekPxh4JyZRv47mlXWpI/?=
 =?us-ascii?Q?Jh0mmaSXbe01PddyVEQ9s3/BssZLajUe3FaCBYuUBxb5QVmuGnsbmWdvYR2J?=
 =?us-ascii?Q?GtbO9Juginepmwm6F83a6i+lyaOie5bCNLMJ+vXYb1tjodfI2XjwWGdccgUa?=
 =?us-ascii?Q?rOWRH4RSUGmQPDhWZnWE31s0jDrsME01gvqdDiVja9q67tkWctoY9/DDxx46?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24989447-b928-4309-259c-08dc20b6c8e9
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 10:41:00.9539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1RU65YzG8jUF0zhp9kK6qlWoqsrHHF7CW1ubYA6wBgOEtj7c1O2cmAlHzuhkDfu6ROpEqPZF3uT6Pakjj5L33k2pU+rlsizfI6c7Wxm7BA=
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

Adds cache structure table generation for the Processor Properties
Topology Table (PPTT) to describe cache hierarchy information for
ACPI guests.

A 3-level cache topology is employed here, referring to the type 1 cache
structure according to ACPI spec v6.3. The L1 cache and L2 cache are
private resources for the core, while the L3 cache is the private
resource for the cluster.

In the absence of cluster values in the QEMU command, a 2-layer cache is
expected. The default cache value should be passed in from the
architecture code.

Examples:
3-layer: -smp 4,sockets=1,clusters=2,cores=2,threads=1
2-layer: -smp 4,sockets=1,cores=2,threads=2

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
---
 hw/acpi/aml-build.c         | 65 ++++++++++++++++++++++++++++++++++---
 include/hw/acpi/aml-build.h | 26 ++++++++++++++-
 2 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index af66bde0f5..3bbfce962b 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1994,18 +1994,48 @@ static void build_processor_hierarchy_node(GArray *tbl, uint32_t flags,
     }
 }
 
+/* ACPI spec, Revision 6.3 Cache type structure (Type 1) */
+static void build_cache_structure(GArray *tbl,
+                                  uint32_t next_level,
+                                  CPUCacheInfo *cache_info)
+{
+    /* Cache type structure */
+    build_append_byte(tbl, 1);
+    /* Length */
+    build_append_byte(tbl, 24);
+    /* Reserved */
+    build_append_int_noprefix(tbl, 0, 2);
+    /* Flags */
+    build_append_int_noprefix(tbl, 0x7f, 4);
+    /* Next level cache */
+    build_append_int_noprefix(tbl, next_level, 4);
+    /* Size */
+    build_append_int_noprefix(tbl, cache_info->size, 4);
+    /* Number of sets */
+    build_append_int_noprefix(tbl, cache_info->sets, 4);
+    /* Associativity */
+    build_append_byte(tbl, cache_info->associativity);
+    /* Attributes */
+    build_append_byte(tbl, cache_info->attributes);
+    /* Line size */
+    build_append_int_noprefix(tbl, cache_info->line_size, 2);
+}
+
 /*
  * ACPI spec, Revision 6.3
  * 5.2.29 Processor Properties Topology Table (PPTT)
  */
 void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
-                const char *oem_id, const char *oem_table_id)
+                const char *oem_id, const char *oem_table_id,
+                const CPUCaches *CPUCaches)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     CPUArchIdList *cpus = ms->possible_cpus;
     int64_t socket_id = -1, cluster_id = -1, core_id = -1;
     uint32_t socket_offset = 0, cluster_offset = 0, core_offset = 0;
     uint32_t pptt_start = table_data->len;
+    uint32_t l3_offset = 0, priv_num = 0;
+    uint32_t priv_rsrc[3] = {0};
     int n;
     AcpiTable table = { .sig = "PPTT", .rev = 2,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
@@ -2024,10 +2054,11 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
             socket_id = cpus->cpus[n].props.socket_id;
             cluster_id = -1;
             core_id = -1;
+            priv_num = 0;
             socket_offset = table_data->len - pptt_start;
             build_processor_hierarchy_node(table_data,
                 (1 << 0), /* Physical package */
-                0, socket_id, NULL, 0);
+                0, socket_id, NULL, priv_num);
         }
 
         if (mc->smp_props.clusters_supported && mc->smp_props.has_clusters) {
@@ -2035,20 +2066,44 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 assert(cpus->cpus[n].props.cluster_id > cluster_id);
                 cluster_id = cpus->cpus[n].props.cluster_id;
                 core_id = -1;
+                priv_num = 0;
+                l3_offset = table_data->len - pptt_start;
+                /* L3 cache type structure */
+                if (CPUCaches && CPUCaches->l3_cache) {
+                    priv_num = 1;
+                    build_cache_structure(table_data, 0, CPUCaches->l3_cache);
+                }
                 cluster_offset = table_data->len - pptt_start;
                 build_processor_hierarchy_node(table_data,
                     (0 << 0), /* Not a physical package */
-                    socket_offset, cluster_id, NULL, 0);
+                    socket_offset, cluster_id, &l3_offset, priv_num);
             }
         } else {
             cluster_offset = socket_offset;
         }
 
+        if (CPUCaches) {
+            /* L2 cache type structure */
+            priv_rsrc[0] = table_data->len - pptt_start;
+            build_cache_structure(table_data, 0, CPUCaches->l2_cache);
+
+            /* L1d cache type structure */
+            priv_rsrc[1] = table_data->len - pptt_start;
+            build_cache_structure(table_data, priv_rsrc[0],
+                                  CPUCaches->l1d_cache);
+
+            /* L1i cache type structure */
+            priv_rsrc[2] = table_data->len - pptt_start;
+            build_cache_structure(table_data, priv_rsrc[0],
+                                  CPUCaches->l1i_cache);
+
+            priv_num = 3;
+        }
         if (ms->smp.threads == 1) {
             build_processor_hierarchy_node(table_data,
                 (1 << 1) | /* ACPI Processor ID valid */
                 (1 << 3),  /* Node is a Leaf */
-                cluster_offset, n, NULL, 0);
+                cluster_offset, n, priv_rsrc, priv_num);
         } else {
             if (cpus->cpus[n].props.core_id != core_id) {
                 assert(cpus->cpus[n].props.core_id > core_id);
@@ -2063,7 +2118,7 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 (1 << 1) | /* ACPI Processor ID valid */
                 (1 << 2) | /* Processor is a Thread */
                 (1 << 3),  /* Node is a Leaf */
-                core_offset, n, NULL, 0);
+                core_offset, n, priv_rsrc, priv_num);
         }
     }
 
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index ff2a310270..2dd949f41e 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -234,6 +234,29 @@ struct CrsRangeSet {
     GPtrArray *mem_64bit_ranges;
 } CrsRangeSet;
 
+enum CacheType {
+    DATA_CACHE,
+    INSTRUCTION_CACHE,
+    UNIFIED_CACHE
+};
+
+typedef
+struct CPUCacheInfo {
+    enum CacheType type;      /* Cache Type*/
+    uint32_t size;            /* Size of the cache in bytes */
+    uint32_t sets;            /* Number of sets in the cache */
+    uint8_t associativity;    /* Cache associativity */
+    uint8_t attributes;       /* Cache attributes */
+    uint16_t line_size;       /* Line size in bytes */
+} CPUCacheInfo;
+
+typedef
+struct CPUCaches {
+        CPUCacheInfo *l1d_cache;
+        CPUCacheInfo *l1i_cache;
+        CPUCacheInfo *l2_cache;
+        CPUCacheInfo *l3_cache;
+} CPUCaches;
 
 /*
  * ACPI 5.0: 6.4.3.8.2 Serial Bus Connection Descriptors
@@ -490,7 +513,8 @@ void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 const char *oem_id, const char *oem_table_id);
 
 void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
-                const char *oem_id, const char *oem_table_id);
+                const char *oem_id, const char *oem_table_id,
+                const CPUCaches *CPUCaches);
 
 void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
                 const char *oem_id, const char *oem_table_id);
-- 
2.34.1


