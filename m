Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B88C28B24
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdWG-000104-Cr; Fri, 07 Mar 2025 14:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdVh-0000ui-C5
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:37:38 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdVf-0007WP-5w
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:37:29 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2239f8646f6so43849805ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741376245; x=1741981045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sfg9fp/d1PdwCXS3veKjw2zFmzOBBZVU57mmT0JR/f0=;
 b=hqH7arRW4yYYMk1/mUJX3CSyj/Ut11kwCZPDqBhCUzTWLnKGH0Ai7phDLHBzvBtw+/
 oK16mkBFOrf4uJdvNU+1gRFtGLTvn5qiCq01WBvryZzJ8ywWKeH0onuDhLk2yZ8QKWPA
 hBuItB6CrGdPmuGe/Tcigj/5ZqSNDuOffe4+6ITmuKdhxculsUiUgRNJkER7ahXJOi0V
 wM82xWz65ZRkwVobI30UfTF7IC3kLnKuAOj8jMEmnO+3fHWYakTIKKE38E5QiwENruuN
 hsHW0MzGvRSX6RG7Y+7L6QOgku8IPO/K84kI/5U9Zpb7RHUT0LKpeQNcXeZ9vRN/vPo3
 FfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741376245; x=1741981045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sfg9fp/d1PdwCXS3veKjw2zFmzOBBZVU57mmT0JR/f0=;
 b=EFvuNBcCiSIkbpfDH98YOFBev8/xFiZZhtIUwBol6w0Kvx27yDMFsuVoRlOIRo0y4e
 9oWDW8UfdBLBo3nEBOWaRekNZ9e0qSR46fHlVnVKFnq0l3hEeg5fGp6azkAtmPmHWDwk
 XMpQ+7DedpvbfqrzJLuWMZEJn5InJYIv8FvjRUQ1vF+yt8Af7PAtdmz/EB1S68UdqTyC
 vaz3QGG7Z42Y+0ecEVyL4a1MqXH731gkmFrY29YWmhCynujjqVV+ztBCWkoDaZPlo84Y
 ONvhg2yWvqOtraTLF1X/xzb9yqhKB0NvtJJNoltmEGVACKONlIPWckqde2DUCJkgggr8
 eYPA==
X-Gm-Message-State: AOJu0YxrzixsUrzl5oDztgQ1uJ4u3PcK2m+8tbiqom4y1BCdL88ApEvv
 PulSWVSEtlwX80HLQs/u31Z3qd9YpI0lZ8VaQOUqLpqWVRU+YhVh2Lo28t3rBcypRyMvoJWaGta
 y
X-Gm-Gg: ASbGncsuUo/l59GXEaHyIv17sfK97KPBTcDYSCq7natbETXnmhN8YWuRqeMCrDGh6Ig
 M+Q+crEFLTht3dRFZwnTsQsnDzmy5we+JUsk6YfKGW0QIoMDyMR+LeQIL/yN9/F19D1vd+N7v8s
 tIdP6vcQqo0kWoMhRyKlO8KfWb/bLv/ER3ZKCZOHJ0uByVktnsSIvLsTyKel7un/ltr3pWeZDRe
 +JeVFWl9R5NzKQHDwOgdOPRQ6HDTmnj3gWqEzlQ0VTbZYTZeHY6D85qZ4RsdNOAyCixRZe9+ASk
 3B787yHNqmrbyUdzxzlxNt4mhwJVL6u6YstratLmh8v/
X-Google-Smtp-Source: AGHT+IG/Cs/7jguUQxnpsh7chCHttVnF2BIWXPHq+mbdcgvzPmEQkaG/XQxPrsdd/q4ZyMSNtVdLIQ==
X-Received: by 2002:a17:903:192:b0:21f:507b:9ad7 with SMTP id
 d9443c01a7336-22428a89081mr74798445ad.25.1741376245255; 
 Fri, 07 Mar 2025 11:37:25 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693739ecsm3821757a91.26.2025.03.07.11.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 11:37:24 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, kvm@vger.kernel.org,
 richard.henderson@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, manos.pitsidianakis@linaro.org,
 pierrick.bouvier@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v3 3/7] hw/hyperv/vmbus: common compilation unit
Date: Fri,  7 Mar 2025 11:37:08 -0800
Message-Id: <20250307193712.261415-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307193712.261415-1-pierrick.bouvier@linaro.org>
References: <20250307193712.261415-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace TARGET_PAGE.* by runtime calls.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/hyperv/vmbus.c     | 50 +++++++++++++++++++++----------------------
 hw/hyperv/meson.build |  2 +-
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 12a7dc43128..109ac319caf 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -18,7 +18,7 @@
 #include "hw/hyperv/vmbus.h"
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/sysbus.h"
-#include "cpu.h"
+#include "exec/target_page.h"
 #include "trace.h"
 
 enum {
@@ -309,7 +309,7 @@ void vmbus_put_gpadl(VMBusGpadl *gpadl)
 
 uint32_t vmbus_gpadl_len(VMBusGpadl *gpadl)
 {
-    return gpadl->num_gfns * TARGET_PAGE_SIZE;
+    return gpadl->num_gfns * qemu_target_page_size();
 }
 
 static void gpadl_iter_init(GpadlIter *iter, VMBusGpadl *gpadl,
@@ -323,14 +323,14 @@ static void gpadl_iter_init(GpadlIter *iter, VMBusGpadl *gpadl,
 
 static inline void gpadl_iter_cache_unmap(GpadlIter *iter)
 {
-    uint32_t map_start_in_page = (uintptr_t)iter->map & ~TARGET_PAGE_MASK;
-    uint32_t io_end_in_page = ((iter->last_off - 1) & ~TARGET_PAGE_MASK) + 1;
+    uint32_t map_start_in_page = (uintptr_t)iter->map & ~qemu_target_page_mask();
+    uint32_t io_end_in_page = ((iter->last_off - 1) & ~qemu_target_page_mask()) + 1;
 
     /* mapping is only done to do non-zero amount of i/o */
     assert(iter->last_off > 0);
     assert(map_start_in_page < io_end_in_page);
 
-    dma_memory_unmap(iter->as, iter->map, TARGET_PAGE_SIZE - map_start_in_page,
+    dma_memory_unmap(iter->as, iter->map, qemu_target_page_size() - map_start_in_page,
                      iter->dir, io_end_in_page - map_start_in_page);
 }
 
@@ -348,17 +348,17 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *buf, uint32_t len)
     assert(iter->active);
 
     while (len) {
-        uint32_t off_in_page = iter->off & ~TARGET_PAGE_MASK;
-        uint32_t pgleft = TARGET_PAGE_SIZE - off_in_page;
+        uint32_t off_in_page = iter->off & ~qemu_target_page_mask();
+        uint32_t pgleft = qemu_target_page_size() - off_in_page;
         uint32_t cplen = MIN(pgleft, len);
         void *p;
 
         /* try to reuse the cached mapping */
         if (iter->map) {
             uint32_t map_start_in_page =
-                (uintptr_t)iter->map & ~TARGET_PAGE_MASK;
-            uint32_t off_base = iter->off & ~TARGET_PAGE_MASK;
-            uint32_t mapped_base = (iter->last_off - 1) & ~TARGET_PAGE_MASK;
+                (uintptr_t)iter->map & ~qemu_target_page_mask();
+            uint32_t off_base = iter->off & ~qemu_target_page_mask();
+            uint32_t mapped_base = (iter->last_off - 1) & ~qemu_target_page_mask();
             if (off_base != mapped_base || off_in_page < map_start_in_page) {
                 gpadl_iter_cache_unmap(iter);
                 iter->map = NULL;
@@ -368,10 +368,10 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *buf, uint32_t len)
         if (!iter->map) {
             dma_addr_t maddr;
             dma_addr_t mlen = pgleft;
-            uint32_t idx = iter->off >> TARGET_PAGE_BITS;
+            uint32_t idx = iter->off >> qemu_target_page_bits();
             assert(idx < iter->gpadl->num_gfns);
 
-            maddr = (iter->gpadl->gfns[idx] << TARGET_PAGE_BITS) | off_in_page;
+            maddr = (iter->gpadl->gfns[idx] << qemu_target_page_bits()) | off_in_page;
 
             iter->map = dma_memory_map(iter->as, maddr, &mlen, iter->dir,
                                        MEMTXATTRS_UNSPECIFIED);
@@ -382,7 +382,7 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *buf, uint32_t len)
             }
         }
 
-        p = (void *)(uintptr_t)(((uintptr_t)iter->map & TARGET_PAGE_MASK) |
+        p = (void *)(uintptr_t)(((uintptr_t)iter->map & qemu_target_page_mask()) |
                 off_in_page);
         if (iter->dir == DMA_DIRECTION_FROM_DEVICE) {
             memcpy(p, buf, cplen);
@@ -591,9 +591,9 @@ static void ringbuf_init_common(VMBusRingBufCommon *ringbuf, VMBusGpadl *gpadl,
                                 uint32_t begin, uint32_t end)
 {
     ringbuf->as = as;
-    ringbuf->rb_addr = gpadl->gfns[begin] << TARGET_PAGE_BITS;
-    ringbuf->base = (begin + 1) << TARGET_PAGE_BITS;
-    ringbuf->len = (end - begin - 1) << TARGET_PAGE_BITS;
+    ringbuf->rb_addr = gpadl->gfns[begin] << qemu_target_page_bits();
+    ringbuf->base = (begin + 1) << qemu_target_page_bits();
+    ringbuf->len = (end - begin - 1) << qemu_target_page_bits();
     gpadl_iter_init(&ringbuf->iter, gpadl, as, dir);
 }
 
@@ -734,7 +734,7 @@ static int vmbus_channel_notify_guest(VMBusChannel *chan)
     unsigned long *int_map, mask;
     unsigned idx;
     hwaddr addr = chan->vmbus->int_page_gpa;
-    hwaddr len = TARGET_PAGE_SIZE / 2, dirty = 0;
+    hwaddr len = qemu_target_page_size() / 2, dirty = 0;
 
     trace_vmbus_channel_notify_guest(chan->id);
 
@@ -743,7 +743,7 @@ static int vmbus_channel_notify_guest(VMBusChannel *chan)
     }
 
     int_map = cpu_physical_memory_map(addr, &len, 1);
-    if (len != TARGET_PAGE_SIZE / 2) {
+    if (len != qemu_target_page_size() / 2) {
         res = -ENXIO;
         goto unmap;
     }
@@ -1038,14 +1038,14 @@ static int sgl_from_gpa_ranges(QEMUSGList *sgl, VMBusDevice *dev,
         }
         len -= sizeof(range);
 
-        if (range.byte_offset & TARGET_PAGE_MASK) {
+        if (range.byte_offset & qemu_target_page_mask()) {
             goto eio;
         }
 
         for (; range.byte_count; range.byte_offset = 0) {
             uint64_t paddr;
             uint32_t plen = MIN(range.byte_count,
-                                TARGET_PAGE_SIZE - range.byte_offset);
+                                qemu_target_page_size() - range.byte_offset);
 
             if (len < sizeof(uint64_t)) {
                 goto eio;
@@ -1055,7 +1055,7 @@ static int sgl_from_gpa_ranges(QEMUSGList *sgl, VMBusDevice *dev,
                 goto err;
             }
             len -= sizeof(uint64_t);
-            paddr <<= TARGET_PAGE_BITS;
+            paddr <<= qemu_target_page_bits();
             paddr |= range.byte_offset;
             range.byte_count -= plen;
 
@@ -1804,7 +1804,7 @@ static void handle_gpadl_header(VMBus *vmbus, vmbus_message_gpadl_header *msg,
      * anything else and simplify things greatly.
      */
     if (msg->rangecount != 1 || msg->range[0].byte_offset ||
-        (msg->range[0].byte_count != (num_gfns << TARGET_PAGE_BITS))) {
+        (msg->range[0].byte_count != (num_gfns << qemu_target_page_bits()))) {
         return;
     }
 
@@ -2240,10 +2240,10 @@ static void vmbus_signal_event(EventNotifier *e)
         return;
     }
 
-    addr = vmbus->int_page_gpa + TARGET_PAGE_SIZE / 2;
-    len = TARGET_PAGE_SIZE / 2;
+    addr = vmbus->int_page_gpa + qemu_target_page_size() / 2;
+    len = qemu_target_page_size() / 2;
     int_map = cpu_physical_memory_map(addr, &len, 1);
-    if (len != TARGET_PAGE_SIZE / 2) {
+    if (len != qemu_target_page_size() / 2) {
         goto unmap;
     }
 
diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index f4aa0a5ada9..c855fdcf04c 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -1,6 +1,6 @@
 specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
 specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
-specific_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
+system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 specific_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
 specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
 system_ss.add(when: 'CONFIG_HV_BALLOON', if_false: files('hv-balloon-stub.c'))
-- 
2.39.5


