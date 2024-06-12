Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39266C27C75
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 21:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHVXv-0001aY-BW; Wed, 12 Jun 2024 17:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefano.stabellini@amd.com>)
 id 1sHVXr-0001Tv-RM
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 17:30:17 -0400
Received: from mail-bn8nam12on20621.outbound.protection.outlook.com
 ([2a01:111:f403:2418::621]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefano.stabellini@amd.com>)
 id 1sHVXp-0002oN-3Q
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 17:30:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5JVm2Q4fbxL61dIGUq0HECnSoZEdAc/dt+zPqPgWWjrHjUeDHfT5jaik0xHslOPF5er5uoScMG7r2d1bEdUH5z6xJsk89KOYwz7gZlMGVWlsDyAR4VYUqpZHrhuzxZ9JDaHL7ngkeOKWgnoFup1O4EXOANb7+/q0xjcMyANtoXL0f91qP6UtmyCrqsz3LOfcpYnPcjLSaG0VFFzt3/23IS0zm59/Y7MOO4cWfPpaq/g4OZ5XuGy51ZUlaePhX35JBOH4GIWdFRlWy9c8QrHvCi8kOf4EvSpwBke9q7H0wvV816GYHz3ACj8xR707JJfVMRf214K55jNV1BlMXM7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mJ+jql/EDqUybJTnjb/85JYlMFA6jZ7hOjOjsOzvs8=;
 b=Sscn61tOa1TTOltVUnQxFjdcwo7s8q6kZLbdqmXTeaoarqL6OHxt/5LpbIfvjMKyv5/8RqtCC9IrJJOW9z0jvFa63t4vNFv6f6PpWb6RvA8U4/Hv8nvXbWi7aK9ZxO4qL19FRWPhLtfkFtpGEknZxyL4Ts1SPce4FPQ/1mRl0pqTTYIRAYS69nlMykkJayNDbr+hsVZvk0r1XzvqlMT10WbSofeYbqq7oaHBXA8dD04UbNs96CS2ZM8AeEtIhZQ/NK170vu70uBL3Q9MkDFfgsnqrnJtsB6Z7mlLYykMIBTqE7SHBUy4qYbmGY7fmfQxu58qzEShnj10wzTdkF9n4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mJ+jql/EDqUybJTnjb/85JYlMFA6jZ7hOjOjsOzvs8=;
 b=pNdYgATeHKFi1Yp8QqDLXMoq11IB1seHvah7purc7hUJW0N6VY+AMv06bSGY6UtpXGwxUfhUJXLdfVnjTfzqXkQHdj2sZNAmW1AU66j0lYYBjl4TTBX21jW44bFMIGTsgOFOb6BMZu2u4bKKYm9WRZ5zh+NyKghD8A5QsYXpW8E=
Received: from DM6PR21CA0014.namprd21.prod.outlook.com (2603:10b6:5:174::24)
 by CH3PR12MB7499.namprd12.prod.outlook.com (2603:10b6:610:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 12 Jun
 2024 21:30:01 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::41) by DM6PR21CA0014.outlook.office365.com
 (2603:10b6:5:174::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Wed, 12 Jun 2024 21:30:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 21:30:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 16:29:59 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 12 Jun 2024 16:29:53 -0500
From: Stefano Stabellini <stefano.stabellini@amd.com>
To: <qemu-devel@nongnu.org>
CC: <stefanha@redhat.com>, <peter.maydell@linaro.org>,
 <sstabellini@kernel.org>, <Edgar.Iglesias@amd.com>, "Edgar E. Iglesias"
 <edgar.iglesias@amd.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/5] xen: mapcache: Pass the ram_addr offset to xen_map_cache()
Date: Wed, 12 Jun 2024 16:29:38 -0500
Message-ID: <20240612212940.2178248-3-stefano.stabellini@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <alpine.DEB.2.22.394.2406121625590.1328433@ubuntu-linux-20-04-desktop>
References: <alpine.DEB.2.22.394.2406121625590.1328433@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: stefano.stabellini@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|CH3PR12MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 945c847c-f031-464d-f621-08dc8b26d143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230034|376008|1800799018|82310400020|36860700007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0lYSjB2VHV6N0xEZ3EwcDVZUHV4b1BHVFFRQlBXTTdBeVBycHE4RUhhZExh?=
 =?utf-8?B?MUw1N2N3MWF4TjRXdm0yRmc2U1pueWQ3aFZKbVRHWkZnY0VSb3luVjg1RjNY?=
 =?utf-8?B?bHVVeThpelBha1dWU090eWIxdkRDanVIRFVzNzFiQTdTUzROcjN3aGdUYUNm?=
 =?utf-8?B?cWVhTE9OU0Q5M1R0MVNtdlBZQWx5aDd4RVY2Vjh5cGlpNDBhNU1tRjhYQzQ1?=
 =?utf-8?B?ODBnc3NKanljZU5vbFBCcXJkYWdHRTNFVEVlbEUySER4VkNDN0p4VVJqc0xo?=
 =?utf-8?B?dmN1WWx3Y0RLblhBN2g2OTRnN1NrUElvT3gvQlZ4czZGbmVZRmlrTTF0eTFN?=
 =?utf-8?B?aEFmSzBUVTBXQmxrK3A0dEhaRjh5eXdkQy8zbzczWjVuU1FyY3B0dUU1LzRT?=
 =?utf-8?B?SHlxbm84U0VlR1JGd3pleVFBdFhmL24zSytobVRrejR5QXEwbkIxMzdTVHRv?=
 =?utf-8?B?OVhZcEVpeGUrR3drbkloM1lYdDhVQ2RyWGtkQzRkTURYSzNuN3U4bVRRQ1pt?=
 =?utf-8?B?OG42eTBkWUdBc0c1b29RTEpITFk3UTBSd04rNnYxQXVJTmdOQXYxQVJtYXhJ?=
 =?utf-8?B?c0k0SnlleTFYSzBOWmc4Wloxd29kTkFrdFk5Tm5GaGFKSGxGNkM4R2R5K0JI?=
 =?utf-8?B?RVFmRFlEYWllNUQ4bXdxYktNelVSbG45b0pUMitNT1Q0V2hWbGtvK25saVEr?=
 =?utf-8?B?OFU3VlBQSUxSS2g4UGRlN1NoS3JnVmk1Ym8zVlQ5TFFLdWNxTE5CZGtJZ2s2?=
 =?utf-8?B?Z1B5Y01Ua0VIWG0zRzMyNkF5a0VtYUJYRkF5d1BJV0p6cnl6Y2RoUVBwNmhx?=
 =?utf-8?B?NmgwRTlFeXUxQ05EaGZLYzllN0h4bGRTQis4dXh0UERZRkhuQzlyYk1vUGlC?=
 =?utf-8?B?Wk9uZDUwdGkvVXdCd1kwN0JMb0xaQzltUngzSjZ2WFRYT1ovZ1gxdU5lTmRM?=
 =?utf-8?B?L29EbFRiNGg2YnVHZ2t0MSt0TnRSMmlVMFM5c0ZCbTZLN1k4MzYxU0VxQmVy?=
 =?utf-8?B?VHk5SS9XZzQ4MEQvNzBzQTYzSkV3RHd2TmxHRlMxaCtqZ0w1MllEdTJpY0Vs?=
 =?utf-8?B?OVBKN3gwRTYySnZlMEF4M3ZGK2J1TWFRa0NhTURNQSsrajNtRGZocmJXL1Fw?=
 =?utf-8?B?eUY5ZzdzN1dYdUQ0eDVDTUFEMFhMYlluZkxROVhzQ0ZnbVpjL0x6bFpIV09P?=
 =?utf-8?B?M2x4RURXd0Yyc3dDRHdhZnRFTndyVGFZTlJIUHJZeHVCNjFnNEoxUi9RNktI?=
 =?utf-8?B?RHJJazJya1R4bGo5NjlaYnFCcXQ1bk02ejhUNkVQV015a3crczU3N0ZLdmR3?=
 =?utf-8?B?eEN2NXlQNUExUHhDWWE3MWNpMWVoUWhLeVlTS3JJUWVKYlYydW00NFJFUTdE?=
 =?utf-8?B?VG9FWjhWV2J0dEpSMmM2eWQra0FBRm9tWnE2M0Z2K1lrZWhKWXVtRkF4SnRI?=
 =?utf-8?B?ejZ1N1d6enBlTWFwME5zK1o5dk5RbG44NkFHcEJ4ZTlLU0ZJcndNdEd2S3E2?=
 =?utf-8?B?MThhTllYREk3N2pTcEZyMXlQWlNMaDlqRi9iaHYvQzVidkNVZlF4SFVFbmpv?=
 =?utf-8?B?OTNVQ1RnbzdpZENFeklMZTdXWDNGdkhjMCtZUVNXRklkMjdRRHJoaEM5TTFp?=
 =?utf-8?B?M0Y1b09kNmdlbEVVcnhJN0dFNTYrMkRVd1V6MVFKVHFDY3c2eDZXNXBUQlNL?=
 =?utf-8?B?ZUVUa0N1YWVneE8wT0orazVxdmdCUGxJMzYrK2xYQmNnSXhmOXIwMnRFbTk4?=
 =?utf-8?B?Yk5TdHo0c2JGbjUycStpdkdnUnBPMWY0ZmRHa2tUWkVnSFBORTlUS0hEY0ph?=
 =?utf-8?B?bXBYdHc5YURlRU5rL1hUWW4wcFBCMTBpY29LVmlvU2I4dFBsWk44ak51WUpr?=
 =?utf-8?B?SkhjTjVabHNlaVV3dmt4TlZGeVRRcXQ1dGpWTE1IRmJWWkE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 21:30:01.2709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 945c847c-f031-464d-f621-08dc8b26d143
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7499
Received-SPF: permerror client-ip=2a01:111:f403:2418::621;
 envelope-from=stefano.stabellini@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Pass the ram_addr offset to xen_map_cache.
This is in preparation for adding grant mappings that need
to compute the address within the RAMBlock.

No functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xen/xen-mapcache.c         | 16 +++++++++++-----
 include/sysemu/xen-mapcache.h |  2 ++
 system/physmem.c              |  9 +++++----
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index ec95445696..a07c47b0b1 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -167,7 +167,8 @@ static void xen_remap_bucket(MapCache *mc,
                              void *vaddr,
                              hwaddr size,
                              hwaddr address_index,
-                             bool dummy)
+                             bool dummy,
+                             ram_addr_t ram_offset)
 {
     uint8_t *vaddr_base;
     xen_pfn_t *pfns;
@@ -266,6 +267,7 @@ static void xen_remap_bucket(MapCache *mc,
 
 static uint8_t *xen_map_cache_unlocked(MapCache *mc,
                                        hwaddr phys_addr, hwaddr size,
+                                       ram_addr_t ram_offset,
                                        uint8_t lock, bool dma, bool is_write)
 {
     MapCacheEntry *entry, *pentry = NULL,
@@ -337,14 +339,16 @@ tryagain:
     if (!entry) {
         entry = g_new0(MapCacheEntry, 1);
         pentry->next = entry;
-        xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy);
+        xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy,
+                         ram_offset);
     } else if (!entry->lock) {
         if (!entry->vaddr_base || entry->paddr_index != address_index ||
                 entry->size != cache_size ||
                 !test_bits(address_offset >> XC_PAGE_SHIFT,
                     test_bit_size >> XC_PAGE_SHIFT,
                     entry->valid_mapping)) {
-            xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy);
+            xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy,
+                             ram_offset);
         }
     }
 
@@ -391,13 +395,15 @@ tryagain:
 
 uint8_t *xen_map_cache(MemoryRegion *mr,
                        hwaddr phys_addr, hwaddr size,
+                       ram_addr_t ram_addr_offset,
                        uint8_t lock, bool dma,
                        bool is_write)
 {
     uint8_t *p;
 
     mapcache_lock(mapcache);
-    p = xen_map_cache_unlocked(mapcache, phys_addr, size, lock, dma, is_write);
+    p = xen_map_cache_unlocked(mapcache, phys_addr, size, ram_addr_offset,
+                               lock, dma, is_write);
     mapcache_unlock(mapcache);
     return p;
 }
@@ -632,7 +638,7 @@ static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
     trace_xen_replace_cache_entry_dummy(old_phys_addr, new_phys_addr);
 
     xen_remap_bucket(mc, entry, entry->vaddr_base,
-                     cache_size, address_index, false);
+                     cache_size, address_index, false, old_phys_addr);
     if (!test_bits(address_offset >> XC_PAGE_SHIFT,
                 test_bit_size >> XC_PAGE_SHIFT,
                 entry->valid_mapping)) {
diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache.h
index 1ec9e66752..b5e3ea1bc0 100644
--- a/include/sysemu/xen-mapcache.h
+++ b/include/sysemu/xen-mapcache.h
@@ -19,6 +19,7 @@ typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
 void xen_map_cache_init(phys_offset_to_gaddr_t f,
                         void *opaque);
 uint8_t *xen_map_cache(MemoryRegion *mr, hwaddr phys_addr, hwaddr size,
+                       ram_addr_t ram_addr_offset,
                        uint8_t lock, bool dma,
                        bool is_write);
 ram_addr_t xen_ram_addr_from_mapcache(void *ptr);
@@ -37,6 +38,7 @@ static inline void xen_map_cache_init(phys_offset_to_gaddr_t f,
 static inline uint8_t *xen_map_cache(MemoryRegion *mr,
                                      hwaddr phys_addr,
                                      hwaddr size,
+                                     ram_addr_t ram_addr_offset,
                                      uint8_t lock,
                                      bool dma,
                                      bool is_write)
diff --git a/system/physmem.c b/system/physmem.c
index b7847db1a2..33d09f7571 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2231,13 +2231,14 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
          */
         if (xen_mr_is_memory(block->mr)) {
             return xen_map_cache(block->mr, block->offset + addr,
-                                 len, lock, lock,
-                                 is_write);
+                                 len, block->offset,
+                                 lock, lock, is_write);
         }
 
         block->host = xen_map_cache(block->mr, block->offset,
-                                    block->max_length, 1,
-                                    lock, is_write);
+                                    block->max_length,
+                                    block->offset,
+                                    1, lock, is_write);
     }
 
     return ramblock_ptr(block, addr);
-- 
2.25.1


