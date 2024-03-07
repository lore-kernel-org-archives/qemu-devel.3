Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC083C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 15:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riFpX-0003iW-Pm; Thu, 07 Mar 2024 10:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riFpV-0003hO-GN
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 10:38:45 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riFpT-0001uV-0l
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 10:38:45 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TrCy56q9Xz6K5nJ;
 Thu,  7 Mar 2024 23:33:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 16F5C14058E;
 Thu,  7 Mar 2024 23:38:40 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 15:38:39 +0000
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, David
 Hildenbrand <david@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, <qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>
Subject: [PATCH v2 3/4] physmem: Factor out body of
 flatview_read/write_continue() loop
Date: Thu, 7 Mar 2024 15:37:09 +0000
Message-ID: <20240307153710.30907-4-Jonathan.Cameron@huawei.com>
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
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

This code will be reused for the address_space_cached accessors
shortly.

Also reduce scope of result variable now we aren't directly
calling this in the loop.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2: Thanks to Peter Xu
- Fix alignment of code.
- Drop unused addr parameter.
- Carry through new mr_addr parameter name.
- RB not picked up as not sure what Peter will think wrt to
  resulting parameter ordering.
---
 system/physmem.c | 169 +++++++++++++++++++++++++++--------------------
 1 file changed, 99 insertions(+), 70 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index a64a96a3e5..1264eab24b 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2681,6 +2681,56 @@ static bool flatview_access_allowed(MemoryRegion *mr, MemTxAttrs attrs,
     return false;
 }
 
+static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
+                                                const uint8_t *buf,
+                                                hwaddr len, hwaddr mr_addr,
+                                                hwaddr *l, MemoryRegion *mr)
+{
+    if (!flatview_access_allowed(mr, attrs, mr_addr, *l)) {
+        return MEMTX_ACCESS_ERROR;
+    }
+
+    if (!memory_access_is_direct(mr, true)) {
+        uint64_t val;
+        MemTxResult result;
+        bool release_lock = prepare_mmio_access(mr);
+
+        *l = memory_access_size(mr, *l, mr_addr);
+        /*
+         * XXX: could force current_cpu to NULL to avoid
+         * potential bugs
+         */
+
+        /*
+         * Assure Coverity (and ourselves) that we are not going to OVERRUN
+         * the buffer by following ldn_he_p().
+         */
+#ifdef QEMU_STATIC_ANALYSIS
+        assert((*l == 1 && len >= 1) ||
+               (*l == 2 && len >= 2) ||
+               (*l == 4 && len >= 4) ||
+               (*l == 8 && len >= 8));
+#endif
+        val = ldn_he_p(buf, *l);
+        result = memory_region_dispatch_write(mr, mr_addr, val,
+                                              size_memop(*l), attrs);
+        if (release_lock) {
+            bql_unlock();
+        }
+
+        return result;
+    } else {
+        /* RAM case */
+        uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
+                                               false);
+
+        memmove(ram_ptr, buf, *l);
+        invalidate_and_set_dirty(mr, mr_addr, *l);
+
+        return MEMTX_OK;
+    }
+}
+
 /* Called within RCU critical section.  */
 static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
                                            MemTxAttrs attrs,
@@ -2692,44 +2742,8 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
     const uint8_t *buf = ptr;
 
     for (;;) {
-        if (!flatview_access_allowed(mr, attrs, mr_addr, l)) {
-            result |= MEMTX_ACCESS_ERROR;
-            /* Keep going. */
-        } else if (!memory_access_is_direct(mr, true)) {
-            uint64_t val;
-            bool release_lock = prepare_mmio_access(mr);
-
-            l = memory_access_size(mr, l, mr_addr);
-            /* XXX: could force current_cpu to NULL to avoid
-               potential bugs */
-
-            /*
-             * Assure Coverity (and ourselves) that we are not going to OVERRUN
-             * the buffer by following ldn_he_p().
-             */
-#ifdef QEMU_STATIC_ANALYSIS
-            assert((l == 1 && len >= 1) ||
-                   (l == 2 && len >= 2) ||
-                   (l == 4 && len >= 4) ||
-                   (l == 8 && len >= 8));
-#endif
-            val = ldn_he_p(buf, l);
-            result |= memory_region_dispatch_write(mr, mr_addr, val,
-                                                   size_memop(l), attrs);
-            if (release_lock) {
-                bql_unlock();
-            }
-
-
-        } else {
-            /* RAM case */
-
-            uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, &l,
-                                                   false);
-
-            memmove(ram_ptr, buf, l);
-            invalidate_and_set_dirty(mr, mr_addr, l);
-        }
+        result |= flatview_write_continue_step(attrs, buf, len, mr_addr, &l,
+                                               mr);
 
         len -= l;
         buf += l;
@@ -2763,6 +2777,52 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
                                    mr_addr, l, mr);
 }
 
+static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
+                                               hwaddr len, hwaddr mr_addr,
+                                               hwaddr *l,
+                                               MemoryRegion *mr)
+{
+    if (!flatview_access_allowed(mr, attrs, mr_addr, *l)) {
+        return MEMTX_ACCESS_ERROR;
+    }
+
+    if (!memory_access_is_direct(mr, false)) {
+        /* I/O case */
+        uint64_t val;
+        MemTxResult result;
+        bool release_lock = prepare_mmio_access(mr);
+
+        *l = memory_access_size(mr, *l, mr_addr);
+        result = memory_region_dispatch_read(mr, mr_addr, &val, size_memop(*l),
+                                             attrs);
+
+        /*
+         * Assure Coverity (and ourselves) that we are not going to OVERRUN
+         * the buffer by following stn_he_p().
+         */
+#ifdef QEMU_STATIC_ANALYSIS
+        assert((*l == 1 && len >= 1) ||
+               (*l == 2 && len >= 2) ||
+               (*l == 4 && len >= 4) ||
+               (*l == 8 && len >= 8));
+#endif
+        stn_he_p(buf, *l, val);
+
+        if (release_lock) {
+            bql_unlock();
+        }
+        return result;
+    } else {
+        /* RAM case */
+        uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
+                                               false);
+
+        memcpy(buf, ram_ptr, *l);
+
+        return MEMTX_OK;
+    }
+}
+
 /* Called within RCU critical section.  */
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemTxAttrs attrs, void *ptr,
@@ -2774,38 +2834,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
 
     fuzz_dma_read_cb(addr, len, mr);
     for (;;) {
-        if (!flatview_access_allowed(mr, attrs, mr_addr, l)) {
-            result |= MEMTX_ACCESS_ERROR;
-            /* Keep going. */
-        } else if (!memory_access_is_direct(mr, false)) {
-            /* I/O case */
-            uint64_t val;
-            bool release_lock = prepare_mmio_access(mr);
-
-            l = memory_access_size(mr, l, mr_addr);
-            result |= memory_region_dispatch_read(mr, mr_addr, &val,
-                                                  size_memop(l), attrs);
-
-            /*
-             * Assure Coverity (and ourselves) that we are not going to OVERRUN
-             * the buffer by following stn_he_p().
-             */
-#ifdef QEMU_STATIC_ANALYSIS
-            assert((l == 1 && len >= 1) ||
-                   (l == 2 && len >= 2) ||
-                   (l == 4 && len >= 4) ||
-                   (l == 8 && len >= 8));
-#endif
-            stn_he_p(buf, l, val);
-            if (release_lock) {
-                bql_unlock();
-            }
-        } else {
-            /* RAM case */
-            uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, &l,
-                                                   false);
-            memcpy(buf, ram_ptr, l);
-        }
+        result |= flatview_read_continue_step(attrs, buf, len, mr_addr, &l, mr);
 
         len -= l;
         buf += l;
-- 
2.39.2


