Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA17C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 15:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riFon-0001xK-QJ; Thu, 07 Mar 2024 10:38:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riFok-0001tL-0c
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 10:37:59 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riFoT-0001Xh-45
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 10:37:56 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TrCxw6qWMz6K7GH;
 Thu,  7 Mar 2024 23:33:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 31A0A140B18;
 Thu,  7 Mar 2024 23:37:39 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 15:37:38 +0000
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, David
 Hildenbrand <david@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, <qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>
Subject: [PATCH v2 1/4] physmem: Rename addr1 to more informative mr_addr in
 flatview_read/write() and similar
Date: Thu, 7 Mar 2024 15:37:07 +0000
Message-ID: <20240307153710.30907-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307153710.30907-1-Jonathan.Cameron@huawei.com>
References: <20240307153710.30907-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

The calls to flatview_read/write[_continue]() have parameters addr and
addr1 but the names give no indication of what they are addresses of.
Rename addr1 to mr_addr to reflect that it is the translated address
offset within the MemoryRegion returned by flatview_translate().
Similarly rename the parameter in address_space_read/write_cached_slow()

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v2: New patch.
- I have kept the renames to only the code I'm touching later in this
  series, but they could be applied much more widely.
---
 system/physmem.c | 50 ++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 05997a7ca7..2704b780f6 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2685,7 +2685,7 @@ static bool flatview_access_allowed(MemoryRegion *mr, MemTxAttrs attrs,
 static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
                                            MemTxAttrs attrs,
                                            const void *ptr,
-                                           hwaddr len, hwaddr addr1,
+                                           hwaddr len, hwaddr mr_addr,
                                            hwaddr l, MemoryRegion *mr)
 {
     uint8_t *ram_ptr;
@@ -2695,12 +2695,12 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
     const uint8_t *buf = ptr;
 
     for (;;) {
-        if (!flatview_access_allowed(mr, attrs, addr1, l)) {
+        if (!flatview_access_allowed(mr, attrs, mr_addr, l)) {
             result |= MEMTX_ACCESS_ERROR;
             /* Keep going. */
         } else if (!memory_access_is_direct(mr, true)) {
             release_lock |= prepare_mmio_access(mr);
-            l = memory_access_size(mr, l, addr1);
+            l = memory_access_size(mr, l, mr_addr);
             /* XXX: could force current_cpu to NULL to avoid
                potential bugs */
 
@@ -2715,13 +2715,13 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
                    (l == 8 && len >= 8));
 #endif
             val = ldn_he_p(buf, l);
-            result |= memory_region_dispatch_write(mr, addr1, val,
+            result |= memory_region_dispatch_write(mr, mr_addr, val,
                                                    size_memop(l), attrs);
         } else {
             /* RAM case */
-            ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
+            ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, &l, false);
             memmove(ram_ptr, buf, l);
-            invalidate_and_set_dirty(mr, addr1, l);
+            invalidate_and_set_dirty(mr, mr_addr, l);
         }
 
         if (release_lock) {
@@ -2738,7 +2738,7 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
         }
 
         l = len;
-        mr = flatview_translate(fv, addr, &addr1, &l, true, attrs);
+        mr = flatview_translate(fv, addr, &mr_addr, &l, true, attrs);
     }
 
     return result;
@@ -2749,22 +2749,22 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
                                   const void *buf, hwaddr len)
 {
     hwaddr l;
-    hwaddr addr1;
+    hwaddr mr_addr;
     MemoryRegion *mr;
 
     l = len;
-    mr = flatview_translate(fv, addr, &addr1, &l, true, attrs);
+    mr = flatview_translate(fv, addr, &mr_addr, &l, true, attrs);
     if (!flatview_access_allowed(mr, attrs, addr, len)) {
         return MEMTX_ACCESS_ERROR;
     }
     return flatview_write_continue(fv, addr, attrs, buf, len,
-                                   addr1, l, mr);
+                                   mr_addr, l, mr);
 }
 
 /* Called within RCU critical section.  */
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemTxAttrs attrs, void *ptr,
-                                   hwaddr len, hwaddr addr1, hwaddr l,
+                                   hwaddr len, hwaddr mr_addr, hwaddr l,
                                    MemoryRegion *mr)
 {
     uint8_t *ram_ptr;
@@ -2775,14 +2775,14 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
 
     fuzz_dma_read_cb(addr, len, mr);
     for (;;) {
-        if (!flatview_access_allowed(mr, attrs, addr1, l)) {
+        if (!flatview_access_allowed(mr, attrs, mr_addr, l)) {
             result |= MEMTX_ACCESS_ERROR;
             /* Keep going. */
         } else if (!memory_access_is_direct(mr, false)) {
             /* I/O case */
             release_lock |= prepare_mmio_access(mr);
-            l = memory_access_size(mr, l, addr1);
-            result |= memory_region_dispatch_read(mr, addr1, &val,
+            l = memory_access_size(mr, l, mr_addr);
+            result |= memory_region_dispatch_read(mr, mr_addr, &val,
                                                   size_memop(l), attrs);
 
             /*
@@ -2798,7 +2798,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
             stn_he_p(buf, l, val);
         } else {
             /* RAM case */
-            ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
+            ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, &l, false);
             memcpy(buf, ram_ptr, l);
         }
 
@@ -2816,7 +2816,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
         }
 
         l = len;
-        mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
+        mr = flatview_translate(fv, addr, &mr_addr, &l, false, attrs);
     }
 
     return result;
@@ -2827,16 +2827,16 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
                                  MemTxAttrs attrs, void *buf, hwaddr len)
 {
     hwaddr l;
-    hwaddr addr1;
+    hwaddr mr_addr;
     MemoryRegion *mr;
 
     l = len;
-    mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
+    mr = flatview_translate(fv, addr, &mr_addr, &l, false, attrs);
     if (!flatview_access_allowed(mr, attrs, addr, len)) {
         return MEMTX_ACCESS_ERROR;
     }
     return flatview_read_continue(fv, addr, attrs, buf, len,
-                                  addr1, l, mr);
+                                  mr_addr, l, mr);
 }
 
 MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
@@ -3359,15 +3359,15 @@ MemTxResult
 address_space_read_cached_slow(MemoryRegionCache *cache, hwaddr addr,
                                    void *buf, hwaddr len)
 {
-    hwaddr addr1, l;
+    hwaddr mr_addr, l;
     MemoryRegion *mr;
 
     l = len;
-    mr = address_space_translate_cached(cache, addr, &addr1, &l, false,
+    mr = address_space_translate_cached(cache, addr, &mr_addr, &l, false,
                                         MEMTXATTRS_UNSPECIFIED);
     return flatview_read_continue(cache->fv,
                                   addr, MEMTXATTRS_UNSPECIFIED, buf, len,
-                                  addr1, l, mr);
+                                  mr_addr, l, mr);
 }
 
 /* Called from RCU critical section. address_space_write_cached uses this
@@ -3377,15 +3377,15 @@ MemTxResult
 address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
                                     const void *buf, hwaddr len)
 {
-    hwaddr addr1, l;
+    hwaddr mr_addr, l;
     MemoryRegion *mr;
 
     l = len;
-    mr = address_space_translate_cached(cache, addr, &addr1, &l, true,
+    mr = address_space_translate_cached(cache, addr, &mr_addr, &l, true,
                                         MEMTXATTRS_UNSPECIFIED);
     return flatview_write_continue(cache->fv,
                                    addr, MEMTXATTRS_UNSPECIFIED, buf, len,
-                                   addr1, l, mr);
+                                   mr_addr, l, mr);
 }
 
 #define ARG1_DECL                MemoryRegionCache *cache
-- 
2.39.2


