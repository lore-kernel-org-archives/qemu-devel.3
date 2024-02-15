Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA79C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 14:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rackM-000583-Et; Thu, 15 Feb 2024 09:29:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rackK-000571-Tk
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:29:52 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rackJ-0001us-4J
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:29:52 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbHRc754hz67ZyK;
 Thu, 15 Feb 2024 22:26:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 61A48141D69;
 Thu, 15 Feb 2024 22:29:49 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 14:29:49 +0000
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, David
 Hildenbrand <david@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, <qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>
Subject: [PATCH 3/3] physmem: Fix wrong MR in large
 address_space_read/write_cached_slow()
Date: Thu, 15 Feb 2024 14:28:17 +0000
Message-ID: <20240215142817.1904-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215142817.1904-1-Jonathan.Cameron@huawei.com>
References: <20240215142817.1904-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If the access is bigger than the MemoryRegion supports,
flatview_read/write_continue() will attempt to update the Memory Region.
but the address passed to flatview_translate() is relative to the cache, not
to the FlatView.

On arm/virt with interleaved CXL memory emulation and virtio-blk-pci this
lead to the first part of descriptor being read from the CXL memory and the
second part from PA 0x8 which happens to be a blank region
of a flash chip and all ffs on this particular configuration.
Note this test requires the out of tree ARM support for CXL, but
the problem is more general.

Avoid this by adding new address_space_read_continue_cached()
and address_space_write_continue_cached() which share all the logic
with the flatview versions except for the MemoryRegion lookup.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 system/physmem.c | 78 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 6 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 74f92bb3b8..43b37942cf 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3377,6 +3377,72 @@ static inline MemoryRegion *address_space_translate_cached(
     return section.mr;
 }
 
+/* Called within RCU critical section.  */
+static MemTxResult address_space_write_continue_cached(MemoryRegionCache *cache,
+                                                       hwaddr addr,
+                                                       MemTxAttrs attrs,
+                                                       const void *ptr,
+                                                       hwaddr len, hwaddr addr1,
+                                                       hwaddr l,
+                                                       MemoryRegion *mr)
+{
+    MemTxResult result = MEMTX_OK;
+    const uint8_t *buf = ptr;
+
+    for (;;) {
+
+        result |= flatview_write_continue_step(addr, attrs, buf, len, addr1, &l,
+                                               mr);
+
+        len -= l;
+        buf += l;
+        addr += l;
+
+        if (!len) {
+            break;
+        }
+
+        l = len;
+
+        mr = address_space_translate_cached(cache, addr, &addr1, &l, true,
+                                            attrs);
+    }
+
+    return result;
+}
+
+/* Called within RCU critical section.  */
+static MemTxResult address_space_read_continue_cached(MemoryRegionCache *cache,
+                                                      hwaddr addr,
+                                                      MemTxAttrs attrs,
+                                                      void *ptr, hwaddr len,
+                                                      hwaddr addr1, hwaddr l,
+                                                      MemoryRegion *mr)
+{
+    MemTxResult result = MEMTX_OK;
+    uint8_t *buf = ptr;
+
+    fuzz_dma_read_cb(addr, len, mr);
+    for (;;) {
+
+        result |= flatview_read_continue_step(addr, attrs, buf, len, addr1,
+                                              &l, mr);
+        len -= l;
+        buf += l;
+        addr += l;
+
+        if (!len) {
+            break;
+        }
+        l = len;
+
+        mr = address_space_translate_cached(cache, addr, &addr1, &l, false,
+                                            attrs);
+    }
+
+    return result;
+}
+
 /* Called from RCU critical section. address_space_read_cached uses this
  * out of line function when the target is an MMIO or IOMMU region.
  */
@@ -3390,9 +3456,9 @@ address_space_read_cached_slow(MemoryRegionCache *cache, hwaddr addr,
     l = len;
     mr = address_space_translate_cached(cache, addr, &addr1, &l, false,
                                         MEMTXATTRS_UNSPECIFIED);
-    return flatview_read_continue(cache->fv,
-                                  addr, MEMTXATTRS_UNSPECIFIED, buf, len,
-                                  addr1, l, mr);
+    return address_space_read_continue_cached(cache, addr,
+                                              MEMTXATTRS_UNSPECIFIED, buf, len,
+                                              addr1, l, mr);
 }
 
 /* Called from RCU critical section. address_space_write_cached uses this
@@ -3408,9 +3474,9 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
     l = len;
     mr = address_space_translate_cached(cache, addr, &addr1, &l, true,
                                         MEMTXATTRS_UNSPECIFIED);
-    return flatview_write_continue(cache->fv,
-                                   addr, MEMTXATTRS_UNSPECIFIED, buf, len,
-                                   addr1, l, mr);
+    return address_space_write_continue_cached(cache, addr,
+                                               MEMTXATTRS_UNSPECIFIED,
+                                               buf, len, addr1, l, mr);
 }
 
 #define ARG1_DECL                MemoryRegionCache *cache
-- 
2.39.2


