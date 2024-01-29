Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCCEC48285
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 08:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUMnd-00037g-GZ; Mon, 29 Jan 2024 03:15:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUMnS-00036d-Az; Mon, 29 Jan 2024 03:15:17 -0500
Received: from mail-bjschn02on2061e.outbound.protection.partner.outlook.cn
 ([2406:e500:4440:2::61e]
 helo=CHN02-BJS-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1rUMnG-0007by-N8; Mon, 29 Jan 2024 03:15:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=De4/mWmTR9ZpZ7i+SMGPPYOt3HjAfZiJ7nLZ+iHhzkSw58yVWSF13F+dU72nYUtH8RVrnnEyOhnMQOwYB1gm86qqCHk92ndPkf9itGmV4zq9ZmuzSYcyUHF8PmHpmLDBdW8t39uix47O36Fs45fqtTSmVIV5O8zjr0kIaVEI0AkBmpSxKAvzVyeSCF5pV41NLnfw1jX1JcbQ1gN1+wPBrrLtCejdXr7xDvbXignd+xz1xMuIQ/xOwXoFx+gXZNpWT1DAxhhmJ1yybWm6wBdaDyQSIVUUm69bExpIBGoI19XWcugB2IBhDalW5blcnaBa2HJpZ0BFi6DNdDAdAF6iVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOK+QbeIBvZavTgQ44cMGtn8EZ+i/+q2X8/r7Te9k1w=;
 b=SYbBJIzL5bPQv1WbC5Xh4LEMZRQSxE+cu7ZEolJaSXwvQYkowsCYSAzUORkn9rT6xwHk95X0QyeGg3erJZPo44iafYDSfu5JfNfVspLIvVLgQfjJXDT4V3nhOzGja/n55Wu1XsD8kc9OMZM+58EriFHED4hmjDJt+k/091Ug242HJZ8SS4lF6TEHkSgOCzTNkFxfccJCkKaXXbw9Hl6/rFQF7PtHbMZ3ypzwt0tCWYs5X4kfaK/svtFuCpQ5cAOZzD+GOiI9dQHWRj+lnYrd9JzvCK8kaQoEanVKZWk3oJ4soFxXjbA/eD6qyZrL6USxWfjWg1KElsCH1BaqLPbIGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0721.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 08:14:46 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 08:14:46 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, jeeheng.sia@starfivetech.com,
 peter.maydell@linaro.org, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [RFC v1 1/3] hw/acpi/aml-build: Add cache structure table creation
 for PPTT table
Date: Mon, 29 Jan 2024 00:14:21 -0800
Message-Id: <20240129081423.116615-2-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129081423.116615-1-jeeheng.sia@starfivetech.com>
References: <20240129081423.116615-1-jeeheng.sia@starfivetech.com>
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHXPR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::26) To BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0561:EE_|BJSPR01MB0721:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc0f81a-ef34-4614-29ef-08dc20a25aef
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anNnbCYFk2lvQo1a+KPvhKSITDp6seaPwWv2Yxn8xial4R57ROKGUUlOgbb8gRBwAjtXtr/fgGvZwhI60h+PO2ATn7X4nsg9wcL+1J1hLBd/5cM7sgPEFbQX9gKSIeErbkYm2FAvfmIUX4mv/YfjnzwY/NkbDqUg4HpRBLFInUViTwuXq9cTbwrULpRYI+HIVTY2eziilkIyuZ77xdFSgNWVzTyzM+9lCnd290VwZPGHgP5CQ0KLYN7goz8rU6kskwvxWYrqpH8QtX1hA+Smj/z1TRuvquwbj4tf08xl1oxBa1DvU792I7Zdu5XDn0esMudO17Y3kCi0MUGWbnbN6Lgk6fU4LFIRhR4oQGllaRqClIFWYi69B84PkapFda/RzDaC/dC9wmijIy8XINY/sNz/r4BMFxyWK1ug0P7K0KVyMEF6dV/w5JbQLs8mQA6SocVNUapJ62Gr9Yd/KF7bAMVJ/NEvff8mvGDAOmXYuMWWBnt1Rjd25xMEu1+LeZGYOrSMzuFYhWucq1zlDaNxQP0L1nSrBTnxwTP9peCqlcdPf9LTbi6vnRJkC4oTsBZG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(346002)(39830400003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41320700001)(38100700002)(2906002)(36756003)(41300700001)(83380400001)(1076003)(2616005)(6666004)(26005)(40160700002)(508600001)(52116002)(40180700001)(66476007)(66556008)(66946007)(38350700005)(8676002)(8936002)(4326008)(86362001)(7416002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eRhswpvqpSD/mUanzdnkACQQJlTnIkc78Muq3xXfA5BYzljSJHAjFRmML71O?=
 =?us-ascii?Q?TxxN/D170nPwVlMG7sJzYECKGSoQaYRqQ+Lw3BIZlND4+YfE9kRffDWyO0PO?=
 =?us-ascii?Q?JqZW8oQUDzxyVDuVnP8cF5oi3B+spCcR21CHUGD0WjMRfFRFM0v/8mY04rHP?=
 =?us-ascii?Q?Y+usXGbmOyTyVSUE+MLytQDZ/geWN8joMroNsBMzSRcDCvbXTSMuyVJZ9Wvt?=
 =?us-ascii?Q?fMpPS7/qSfkDHsnoIG+M91OnOw6zcZ6EnAUigATpooozxQGJe0DSJgrGpOvI?=
 =?us-ascii?Q?6JCzCeFIoW7UwGeTEzAwgNCF8mNGXIk4JP9w7j6AuShDrIyQyfT8CWVwz64V?=
 =?us-ascii?Q?eQw1L7cZX17ZwORCAqOtMtWiPHjY6ROOZ4ENnN5i08htmGx1nFkDBO1hsTng?=
 =?us-ascii?Q?ygnolIlveO/mk+9nkMyUmaOepUH8U/Tg9ldrqYS7NqwPjauLUZGQYhma623M?=
 =?us-ascii?Q?J52HSaik/L9I/dy4xJwEMXCszNPp56dQgDqM5vq0mjGfEvUXizq4vZDgkixd?=
 =?us-ascii?Q?Qje9Xd5D34eTPj0It0GaBmGNLD0DbFil4lxs60dyNI8Iy6wARTHr7grY+OPD?=
 =?us-ascii?Q?h98rS6DSP0zWJljKnRq+wBztTkkFLoKjGNG7g4V1zy9vgXVji2XQxOwXJ2pr?=
 =?us-ascii?Q?gYEnmIdp4xNZlnMqfoNXUUc78+pIfWdA+jd5+i/F7eJQUr1PBbZ5Y3H1jqGj?=
 =?us-ascii?Q?91e5ktO5ZuHdsDHOk0tr4gg00Z4cJukjVCeZC9K1Nocyje9XIOnA73FDfs5V?=
 =?us-ascii?Q?t9GH9ZrqM24v/YHfmxaYCnYKyIByG2Ti6LjO9yT+CkthTDP/l7xgvH07BcMI?=
 =?us-ascii?Q?xkP4V6ppE3kUX8ZXST4ojgKDZCPlinb96Fl9guTbk6mG80mm3ixfxMtiI0fH?=
 =?us-ascii?Q?UUf85YlppMqxZG9W/fIJxmQnU6tVa3zgShoBE2zPItorSFg1mmWsAgUWYEix?=
 =?us-ascii?Q?veH2l6e4huxw8OaHXQD8STvU/j7mV/nQcDFZde66E4e/XSvLKbSyLFN1FXIs?=
 =?us-ascii?Q?qk5ZS9n90CCfo/ZMdHC/eD/NWDo5VUWTJ0ggB+GiFsSZADjfg9rFFb1E9THI?=
 =?us-ascii?Q?clhq7odWE3BhuwO9+0bbHaOdTzPRZos13nevVghDovGn3jKClPDtzKP89dx6?=
 =?us-ascii?Q?GxkPjOzEBo0QGtyuFNRdpr91nke60NBOfTw0M6yVVzT2rNkXrBCpvPvOTHV1?=
 =?us-ascii?Q?hBuCkAJMsLcXdxnC+7y1hkXlQc3K8F+6Zz4TESwF1P4eFLV0F/PgPS2dYMke?=
 =?us-ascii?Q?aE8u/Qqj3YhSP/kc9yJ5LfUwkabUzGQFAzR1JkGtionIZfe6IkN9IWKz15/a?=
 =?us-ascii?Q?CDGBkxkS50MFSKxbmXUtsOOmf7nengO/wVMGYzzOOTomb/Xc5i6G2xXTCEo2?=
 =?us-ascii?Q?67yrT5+wfYWRNqj/1K3evbpj2CIp+bLTFPbEW0zt/uzRRO6DYlxXjVnG3Pa3?=
 =?us-ascii?Q?4zqgYXa69oF8z7NItLIcMY1Hwa5oXaXXDD7GGcXthk3/l7xjyKKdFffy+oys?=
 =?us-ascii?Q?0hcYIrRQCplnai6249Nqs/JuSqSHRZ7DTJschBq/Y7pgM5jDhjUhTgWRFBsC?=
 =?us-ascii?Q?6vqgpJ5RcXLPUyZA4Fza406tYjwux7dGLiZVvMdhVqchbk4JVW2qSLFOL25Q?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc0f81a-ef34-4614-29ef-08dc20a25aef
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 08:14:46.5113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDpKBunIt8gKwRpZpYx6n5q3TNWYmc/JpB5LN6YSvFfQCbYzuEZ0ooz6m/pkAMXV+eSBAJQa54hdVt3bMeAZ6qqXFlAEZqUqRBb1C3hH/yo=
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
index af66bde0f5..416275fdcc 100644
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
+    /* 1 – Cache type structure */
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


