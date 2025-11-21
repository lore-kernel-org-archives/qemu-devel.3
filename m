Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D57CF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdFv-0005yz-Ox; Fri, 21 Nov 2025 21:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdFn-0005o5-BB; Fri, 21 Nov 2025 21:21:36 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdEi-0004DK-55; Fri, 21 Nov 2025 21:21:32 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E918C16C6FC;
 Fri, 21 Nov 2025 16:51:56 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4A544321999;
 Fri, 21 Nov 2025 16:52:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Farrah Chen <farrah.chen@intel.com>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 36/76] ram-block-attributes: fix interaction with
 hugetlb memory backends
Date: Fri, 21 Nov 2025 16:51:14 +0300
Message-ID: <20251121135201.1114964-36-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Chenyi Qiang <chenyi.qiang@intel.com>

Currently, CoCo VMs can perform conversion at the base page granularity,
which is the granularity that has to be tracked. In relevant setups, the
target page size is assumed to be equal to the host page size, thus
fixing the block size to the host page size.

However, since private memory and shared memory have different backend
at present, users can specify shared memory with a hugetlbfs backend
while private memory with guest_memfd backend only supports 4K page
size. In this scenario, ram_block->page_size is different from the host
page size which will trigger an assertion when retrieving the block
size.

To address this, return the host page size directly to relax the
restriction. This changes fixes a regression of using hugetlbfs backend
for shared memory within CoCo VMs, with or without VFIO devices' presence.

Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
Link: https://lore.kernel.org/r/20251023095526.48365-2-chenyi.qiang@intel.com
[peterx: fix subject, per david]
Cc: qemu-stable <qemu-stable@nongnu.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 8922a758b29251d9009ec509e7f580b76509ab3d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
index 68e8a02703..a7579de5b4 100644
--- a/system/ram-block-attributes.c
+++ b/system/ram-block-attributes.c
@@ -22,16 +22,14 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RamBlockAttributes,
                                           { })
 
 static size_t
-ram_block_attributes_get_block_size(const RamBlockAttributes *attr)
+ram_block_attributes_get_block_size(void)
 {
     /*
      * Because page conversion could be manipulated in the size of at least 4K
      * or 4K aligned, Use the host page size as the granularity to track the
      * memory attribute.
      */
-    g_assert(attr && attr->ram_block);
-    g_assert(attr->ram_block->page_size == qemu_real_host_page_size());
-    return attr->ram_block->page_size;
+    return qemu_real_host_page_size();
 }
 
 
@@ -40,7 +38,7 @@ ram_block_attributes_rdm_is_populated(const RamDiscardManager *rdm,
                                       const MemoryRegionSection *section)
 {
     const RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
-    const size_t block_size = ram_block_attributes_get_block_size(attr);
+    const size_t block_size = ram_block_attributes_get_block_size();
     const uint64_t first_bit = section->offset_within_region / block_size;
     const uint64_t last_bit =
         first_bit + int128_get64(section->size) / block_size - 1;
@@ -81,7 +79,7 @@ ram_block_attributes_for_each_populated_section(const RamBlockAttributes *attr,
 {
     unsigned long first_bit, last_bit;
     uint64_t offset, size;
-    const size_t block_size = ram_block_attributes_get_block_size(attr);
+    const size_t block_size = ram_block_attributes_get_block_size();
     int ret = 0;
 
     first_bit = section->offset_within_region / block_size;
@@ -122,7 +120,7 @@ ram_block_attributes_for_each_discarded_section(const RamBlockAttributes *attr,
 {
     unsigned long first_bit, last_bit;
     uint64_t offset, size;
-    const size_t block_size = ram_block_attributes_get_block_size(attr);
+    const size_t block_size = ram_block_attributes_get_block_size();
     int ret = 0;
 
     first_bit = section->offset_within_region / block_size;
@@ -163,7 +161,7 @@ ram_block_attributes_rdm_get_min_granularity(const RamDiscardManager *rdm,
     const RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
 
     g_assert(mr == attr->ram_block->mr);
-    return ram_block_attributes_get_block_size(attr);
+    return ram_block_attributes_get_block_size();
 }
 
 static void
@@ -265,7 +263,7 @@ ram_block_attributes_is_valid_range(RamBlockAttributes *attr, uint64_t offset,
     g_assert(mr);
 
     uint64_t region_size = memory_region_size(mr);
-    const size_t block_size = ram_block_attributes_get_block_size(attr);
+    const size_t block_size = ram_block_attributes_get_block_size();
 
     if (!QEMU_IS_ALIGNED(offset, block_size) ||
         !QEMU_IS_ALIGNED(size, block_size)) {
@@ -322,7 +320,7 @@ int ram_block_attributes_state_change(RamBlockAttributes *attr,
                                       uint64_t offset, uint64_t size,
                                       bool to_discard)
 {
-    const size_t block_size = ram_block_attributes_get_block_size(attr);
+    const size_t block_size = ram_block_attributes_get_block_size();
     const unsigned long first_bit = offset / block_size;
     const unsigned long nbits = size / block_size;
     const unsigned long last_bit = first_bit + nbits - 1;
-- 
2.47.3


