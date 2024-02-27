Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5532C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 22:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf62q-00053T-QV; Tue, 27 Feb 2024 17:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1rf62o-000532-Ju
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:35:26 -0500
Received: from mail-dm6nam10on2061d.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::61d]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1rf62k-0002ei-V0
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:35:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1S1sjBhiM7bJBJDtFmiSTQ/7lPtEithNeKofzjUB8d3g4qV3Q3tUjyzKRVWTgvN2C1A0fsat30hDOLs8CxP5HgL49rnB/8Lg7dYPTv7vYf3coDAGealuMoAZY93MfH0iuj6Ob6FflwS9ca4gOHbO2mwG8z1JPKjsU/GYg9gt96ad+CdtqhABZ/Y+xsjpf2ufOZw8xv4q9V1/1o508o/DNCozgWcmmgcLJB68Af5Kcc0teOTFyzIBwkU9oC2+JqZYjfxyShikXlyXB0ua0MAAeaWKtp8XFWH9fdP63x2vPrxwKRPBC9nw+FxOs9koRKE69iWqCFwxiSQp4uYCgox9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1QzC5vDgSKXrI0HfdZnlWXN7B5thdeKKFtT2A5OhKE=;
 b=CUFrjrUdfVg1zzD24qqnsoSAyS1zoNdX9q8SExKanivg5zAH3kr+fSW/vzsfX2q1YxHaIuRqhfB75Bh4eiMFVETzo2r5ShmoB9yCVz8juwZhzp2SFfi/GSziJc1upqtajURQ/sb+W8Et3NmnR+OsLIsKKxkyWqxAWiGsNZ5zcETD+x3BKt+bWbNv18m+Vit9VKSjEq114S9KMHPudY4qfFyNK1Cv9Q+DtUz1sv7T1MrylGBsiWEag/athwLdggib2pEVkeoIynkYFovOvzAg+OXcEIgxWQA5ashJS1a0mSMCXtDUzT8Ftht6Dq7LAytskmz8k4CIh0BoSDIg6tPtyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1QzC5vDgSKXrI0HfdZnlWXN7B5thdeKKFtT2A5OhKE=;
 b=xkQpaO1AXYaLGiT9bXrG9ghLTWl6O1IUr9yFQbT8aj7FXqSLGK9nA4UBMliyQMkt8h9LaLrmGjg+OO8AlMwwKSzB01PcA5W3lvKYLtT9LU8eP5t8ZBWUXPkEXJrVpYHjuT08EH/bHcOR0OBsxxOYa+BfKSyrxPR0B6N6twhYTEM=
Received: from DM5PR08CA0057.namprd08.prod.outlook.com (2603:10b6:4:60::46) by
 BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.39; Tue, 27 Feb 2024 22:35:19 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:4:60:cafe::13) by DM5PR08CA0057.outlook.office365.com
 (2603:10b6:4:60::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Tue, 27 Feb 2024 22:35:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 22:35:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 16:35:10 -0600
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 16:35:10 -0600
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, <jgross@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, "David
 Hildenbrand" <david@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: [QEMU][PATCH v3 5/7] memory: add MemoryRegion map and unmap callbacks
Date: Tue, 27 Feb 2024 14:34:59 -0800
Message-ID: <20240227223501.28475-6-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240227223501.28475-1-vikram.garhwal@amd.com>
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: vikram.garhwal@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: 208e9e81-035a-4f38-15e2-08dc37e460d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B20JP0tAmarNwuRUPIsjqFe2v9eniO86AmrqdBCpJYbUyBqGt4Z9B0tx5xN7rxk0XDOx0WOqQuOHdDqAvxKH2KnElJOzcZGLAudLQsqCBzyPStdmkP9H//9jJ4DaQFO7bAC8NQ+glyNEzQ8l6ckPNLgJm6WvRnwtAHfa70EnKGvJ+8Xe17i06o/GlCdsQBWJjSrPYa/RWCtmfedHal+EsGe3DkrXEoUcjWOUiJWiasV+r9u5nA3LL7MBfSf7H+baS0d2yhZUOD2O62xy2ygz9WRNUKccWLMYytExRwOerJwxxlMa/Lso87/8CVNmuHbfDJX30+JAkqmqdHq46v7DoFl5KPSGLY9ipbSrynNLns37lllaIBlDwuhi7iOmeAQnmZ+iGnTV/Cj4Eiw+43YKNdpiq6qKHY4hlmceupBbv8svgb7ZpbCI+P3tErCQuT61Esm4ejwqPBmetXWaZUG6YPfUdSkOvv1dxcMBsesE9tNaXF6MJeRWQ8SboDqNtjuzE2YbpgTXWGHdEoiP3EyaQbw4yQV5nSlmJCpmXue9L7pVqxzAWbMQQYoJsgDJBk93n6cvV4ApFvh81jiLNGaLWTEIZpX/F2eSoUvozbfqeFxEW6gj8qmd6RkZYhHiNSq7VP3MTM+YmrnCpw9wiuYm5j42ADNqa1Gc2RxXiZUUufOiXHKdd3Og+QHmhpLnPTpm5kIpJ+eSGbG7z2n68/uT8o7D1e7xrWRgZhAgQXfKTusGyiBSrtFptkMXdh+U5J8n
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 22:35:19.4904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 208e9e81-035a-4f38-15e2-08dc37e460d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
Received-SPF: softfail client-ip=2a01:111:f400:7e88::61d;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Juergen Gross <jgross@suse.com>

In order to support mapping and unmapping guest memory dynamically to
and from qemu during address_space_[un]map() operations add the map()
and unmap() callbacks to MemoryRegionOps.

Those will be used e.g. for Xen grant mappings when performing guest
I/Os.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
---
 include/exec/memory.h | 21 ++++++++++++++++++
 system/physmem.c      | 50 +++++++++++++++++++++++++++++++++----------
 2 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 8626a355b3..9f7dfe59c7 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -282,6 +282,27 @@ struct MemoryRegionOps {
                                     unsigned size,
                                     MemTxAttrs attrs);
 
+    /*
+     * Dynamically create mapping. @addr is the guest address to map; @plen
+     * is the pointer to the usable length of the buffer.
+     * @mr contents can be changed in case a new memory region is created for
+     * the mapping.
+     * Returns the buffer address for accessing the data.
+     */
+    void *(*map)(MemoryRegion **mr,
+                 hwaddr addr,
+                 hwaddr *plen,
+                 bool is_write,
+                 MemTxAttrs attrs);
+
+    /* Unmap an area obtained via map() before. */
+    void (*unmap)(MemoryRegion *mr,
+                  void *buffer,
+                  ram_addr_t addr,
+                  hwaddr len,
+                  bool is_write,
+                  hwaddr access_len);
+
     enum device_endian endianness;
     /* Guest-visible constraints: */
     struct {
diff --git a/system/physmem.c b/system/physmem.c
index 949dcb20ba..d989e9fc1f 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3141,6 +3141,7 @@ void *address_space_map(AddressSpace *as,
     hwaddr len = *plen;
     hwaddr l, xlat;
     MemoryRegion *mr;
+    void *ptr = NULL;
     FlatView *fv;
 
     if (len == 0) {
@@ -3174,12 +3175,20 @@ void *address_space_map(AddressSpace *as,
         return bounce.buffer;
     }
 
-
     memory_region_ref(mr);
+
+    if (mr->ops && mr->ops->map) {
+        ptr = mr->ops->map(&mr, addr, plen, is_write, attrs);
+    }
+
     *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
                                         l, is_write, attrs);
     fuzz_dma_read_cb(addr, *plen, mr);
-    return qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
+    if (ptr == NULL) {
+        ptr = qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
+    }
+
+    return ptr;
 }
 
 /* Unmaps a memory region previously mapped by address_space_map().
@@ -3195,11 +3204,16 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
 
         mr = memory_region_from_host(buffer, &addr1);
         assert(mr != NULL);
-        if (is_write) {
-            invalidate_and_set_dirty(mr, addr1, access_len);
-        }
-        if (xen_enabled()) {
-            xen_invalidate_map_cache_entry(buffer);
+
+        if (mr->ops && mr->ops->unmap) {
+            mr->ops->unmap(mr, buffer, addr1, len, is_write, access_len);
+        } else {
+            if (is_write) {
+                invalidate_and_set_dirty(mr, addr1, access_len);
+            }
+            if (xen_enabled()) {
+                xen_invalidate_map_cache_entry(buffer);
+            }
         }
         memory_region_unref(mr);
         return;
@@ -3272,10 +3286,18 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
          * doing this if we found actual RAM, which behaves the same
          * regardless of attributes; so UNSPECIFIED is fine.
          */
+        if (mr->ops && mr->ops->map) {
+            cache->ptr = mr->ops->map(&mr, addr, &l, is_write,
+                                      MEMTXATTRS_UNSPECIFIED);
+        }
+
         l = flatview_extend_translation(cache->fv, addr, len, mr,
                                         cache->xlat, l, is_write,
                                         MEMTXATTRS_UNSPECIFIED);
-        cache->ptr = qemu_ram_ptr_length(mr->ram_block, cache->xlat, &l, true);
+        if (!cache->ptr) {
+            cache->ptr = qemu_ram_ptr_length(mr->ram_block, cache->xlat, &l,
+                                             true);
+        }
     } else {
         cache->ptr = NULL;
     }
@@ -3297,14 +3319,20 @@ void address_space_cache_invalidate(MemoryRegionCache *cache,
 
 void address_space_cache_destroy(MemoryRegionCache *cache)
 {
-    if (!cache->mrs.mr) {
+    MemoryRegion *mr = cache->mrs.mr;
+
+    if (!mr) {
         return;
     }
 
-    if (xen_enabled()) {
+    if (mr->ops && mr->ops->unmap) {
+            mr->ops->unmap(mr, cache->ptr, cache->xlat, cache->len,
+                           cache->is_write, cache->len);
+    } else if (xen_enabled()) {
         xen_invalidate_map_cache_entry(cache->ptr);
     }
-    memory_region_unref(cache->mrs.mr);
+
+    memory_region_unref(mr);
     flatview_unref(cache->fv);
     cache->mrs.mr = NULL;
     cache->fv = NULL;
-- 
2.17.1


