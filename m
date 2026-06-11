Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C94CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXZ26-0002jk-76; Thu, 11 Jun 2026 02:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXZ1t-0002aC-JN; Thu, 11 Jun 2026 02:36:42 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXZ1o-0002au-PW; Thu, 11 Jun 2026 02:36:41 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65B6ZnFL023462
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 11 Jun 2026 15:35:59 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=TsNSJDVyOcGYU6m4gSDD8QifEGATGyEn9yHwhIoM3Hk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1781159759; v=1;
 b=mF2vfbvGeOO/Ykbrjt1i3R4vcxbVYSbV0OnIQec8zJBWWjX7wWOJxkYruRlhNCG0
 lw6OmyX5Ayo1RUwCRQSuACw1cXXACSbFubMa4TaKqBRmG3mMmN/aEpFZ6qX+ejOE
 eOb/EXHg0wT4yqayC8hhse98zv8qOScKsqNOXi4VWauHC4TnO08ac1JSCb4D+CxP
 MR81AmIuB/32sZUoKIVGmA29c3qdASb5xnQe13z/iYkWVPU0rPBpJZTm5e6VGw5h
 DBmzkoFRiKUX35T2YH7m8lJ2j8bb9U2jwp6YRHUUSoRX4+HQRQpHwszYmXG/l7Ff
 B2yy2FOKg40UYobq7dRCIQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 11 Jun 2026 15:35:48 +0900
Subject: [PATCH 1/3] system/physmem: Pass RAMBlock to RAMBlockNotifier
 callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-ram-v1-1-a2dacf699718@rsg.ci.i.u-tokyo.ac.jp>
References: <20260611-ram-v1-0-a2dacf699718@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260611-ram-v1-0-a2dacf699718@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=13441;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=YVHHTk5SH8/bAsYfALAONdD+LB4KNIwybgtMz9gwSg8=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5ZWuNeVUL9NX+q1F+zoZ2y5s1H5cTHztqcn5D8cfvOht
 6/E+kBORykLgxgXg6yYIktK0W5ujejaT4UJ8S0wc1iZQIYwcHEKwERmqDMybHxkdNTdY5/Eaf1D
 z99sk8/If/9KXT5aQub1AoOeRYf0xBn+hwVIW62cGdpYeeC41ONE1elH869M/hIm9mD6pv83Wrb
 +YgUA
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The RAM save/restore code needs the RAMBlock in RAMBlockNotifier
callbacks to decide whether migration must be aborted and to update
RAMBlock state for postcopy. Looking up the RAMBlock inside callbacks is
hazardous: with Xen mapcache it can deadlock, and it also leaves the
callback contract unclear.

Pass the RAMBlock explicitly to RAMBlockNotifier callbacks. The
ram_block_resized callback takes a non-const RAMBlock because it may
modify the RAMBlock, while the other callbacks take const RAMBlock.

Xen mapcache passes NULL because mapcache entries do not have a
one-to-one relationship with RAMBlocks. ram_block_resized() is never
called from Xen mapcache, so its RAMBlock argument is always non-NULL.

Drop redundant parameters from ram_block_resized() because they can be
derived from the RAMBlock. Keep them for the other callbacks because
their RAMBlock argument may be NULL.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/system/ramlist.h    | 18 ++++++++++--------
 block/block-ram-registrar.c |  8 ++++----
 hw/core/numa.c              | 18 ++++++++++--------
 hw/xen/xen-mapcache.c       |  6 +++---
 migration/ram.c             | 12 +++---------
 system/physmem.c            |  7 +++----
 target/i386/nvmm/nvmm-all.c |  4 ++--
 target/i386/sev.c           |  8 ++++----
 util/vfio-helpers.c         |  7 ++++---
 9 files changed, 43 insertions(+), 45 deletions(-)

diff --git a/include/system/ramlist.h b/include/system/ramlist.h
index c7f388f487d7..32157cc84305 100644
--- a/include/system/ramlist.h
+++ b/include/system/ramlist.h
@@ -62,11 +62,11 @@ void qemu_mutex_lock_ramlist(void);
 void qemu_mutex_unlock_ramlist(void);
 
 struct RAMBlockNotifier {
-    void (*ram_block_added)(RAMBlockNotifier *n, void *host, size_t size,
-                            size_t max_size);
-    void (*ram_block_removed)(RAMBlockNotifier *n, void *host, size_t size,
-                              size_t max_size);
-    void (*ram_block_resized)(RAMBlockNotifier *n, void *host, size_t old_size,
+    void (*ram_block_added)(RAMBlockNotifier *n, const RAMBlock *rb,
+                            void *host, size_t size, size_t max_size);
+    void (*ram_block_removed)(RAMBlockNotifier *n, const RAMBlock *rb,
+                              void *host, size_t size, size_t max_size);
+    void (*ram_block_resized)(RAMBlockNotifier *n, RAMBlock *rb,
                               size_t new_size);
     QLIST_ENTRY(RAMBlockNotifier) next;
 };
@@ -77,9 +77,11 @@ int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
 
 void ram_block_notifier_add(RAMBlockNotifier *n);
 void ram_block_notifier_remove(RAMBlockNotifier *n);
-void ram_block_notify_add(void *host, size_t size, size_t max_size);
-void ram_block_notify_remove(void *host, size_t size, size_t max_size);
-void ram_block_notify_resize(void *host, size_t old_size, size_t new_size);
+void ram_block_notify_add(const RAMBlock *rb,
+                          void *host, size_t size, size_t max_size);
+void ram_block_notify_remove(const RAMBlock *rb,
+                             void *host, size_t size, size_t max_size);
+void ram_block_notify_resize(RAMBlock *rb, size_t new_size);
 
 GString *ram_block_format(void);
 
diff --git a/block/block-ram-registrar.c b/block/block-ram-registrar.c
index fcda2b86afb2..5b938de22587 100644
--- a/block/block-ram-registrar.c
+++ b/block/block-ram-registrar.c
@@ -9,8 +9,8 @@
 #include "system/block-ram-registrar.h"
 #include "qapi/error.h"
 
-static void ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
-                            size_t max_size)
+static void ram_block_added(RAMBlockNotifier *n, const RAMBlock *rb,
+                            void *host, size_t size, size_t max_size)
 {
     BlockRAMRegistrar *r = container_of(n, BlockRAMRegistrar, notifier);
     Error *err = NULL;
@@ -26,8 +26,8 @@ static void ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
     }
 }
 
-static void ram_block_removed(RAMBlockNotifier *n, void *host, size_t size,
-                              size_t max_size)
+static void ram_block_removed(RAMBlockNotifier *n, const RAMBlock *rb,
+                              void *host, size_t size, size_t max_size)
 {
     BlockRAMRegistrar *r = container_of(n, BlockRAMRegistrar, notifier);
     blk_unregister_buf(r->blk, host, max_size);
diff --git a/hw/core/numa.c b/hw/core/numa.c
index f462883c87cf..40acb98bdd0b 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -824,7 +824,7 @@ static int ram_block_notify_add_single(RAMBlock *rb, void *opaque)
     RAMBlockNotifier *notifier = opaque;
 
     if (host) {
-        notifier->ram_block_added(notifier, host, size, max_size);
+        notifier->ram_block_added(notifier, rb, host, size, max_size);
     }
     return 0;
 }
@@ -837,7 +837,7 @@ static int ram_block_notify_remove_single(RAMBlock *rb, void *opaque)
     RAMBlockNotifier *notifier = opaque;
 
     if (host) {
-        notifier->ram_block_removed(notifier, host, size, max_size);
+        notifier->ram_block_removed(notifier, rb, host, size, max_size);
     }
     return 0;
 }
@@ -861,38 +861,40 @@ void ram_block_notifier_remove(RAMBlockNotifier *n)
     }
 }
 
-void ram_block_notify_add(void *host, size_t size, size_t max_size)
+void ram_block_notify_add(const RAMBlock *rb,
+                          void *host, size_t size, size_t max_size)
 {
     RAMBlockNotifier *notifier;
     RAMBlockNotifier *next;
 
     QLIST_FOREACH_SAFE(notifier, &ram_list.ramblock_notifiers, next, next) {
         if (notifier->ram_block_added) {
-            notifier->ram_block_added(notifier, host, size, max_size);
+            notifier->ram_block_added(notifier, rb, host, size, max_size);
         }
     }
 }
 
-void ram_block_notify_remove(void *host, size_t size, size_t max_size)
+void ram_block_notify_remove(const RAMBlock *rb,
+                             void *host, size_t size, size_t max_size)
 {
     RAMBlockNotifier *notifier;
     RAMBlockNotifier *next;
 
     QLIST_FOREACH_SAFE(notifier, &ram_list.ramblock_notifiers, next, next) {
         if (notifier->ram_block_removed) {
-            notifier->ram_block_removed(notifier, host, size, max_size);
+            notifier->ram_block_removed(notifier, rb, host, size, max_size);
         }
     }
 }
 
-void ram_block_notify_resize(void *host, size_t old_size, size_t new_size)
+void ram_block_notify_resize(RAMBlock *rb, size_t new_size)
 {
     RAMBlockNotifier *notifier;
     RAMBlockNotifier *next;
 
     QLIST_FOREACH_SAFE(notifier, &ram_list.ramblock_notifiers, next, next) {
         if (notifier->ram_block_resized) {
-            notifier->ram_block_resized(notifier, host, old_size, new_size);
+            notifier->ram_block_resized(notifier, rb, new_size);
         }
     }
 }
diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 85cf0cf359ca..f321c65b630e 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -222,7 +222,7 @@ static void xen_remap_bucket(MapCache *mc,
 
     if (entry->vaddr_base != NULL) {
         if (!(entry->flags & XEN_MAPCACHE_ENTRY_DUMMY)) {
-            ram_block_notify_remove(entry->vaddr_base, entry->size,
+            ram_block_notify_remove(NULL, entry->vaddr_base, entry->size,
                                     entry->size);
         }
 
@@ -308,7 +308,7 @@ static void xen_remap_bucket(MapCache *mc,
     }
 
     if (!(entry->flags & XEN_MAPCACHE_ENTRY_DUMMY)) {
-        ram_block_notify_add(vaddr_base, size, size);
+        ram_block_notify_add(NULL, vaddr_base, size, size);
     }
 
     entry->vaddr_base = vaddr_base;
@@ -601,7 +601,7 @@ static void xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
         return;
     }
 
-    ram_block_notify_remove(entry->vaddr_base, entry->size, entry->size);
+    ram_block_notify_remove(NULL, entry->vaddr_base, entry->size, entry->size);
     if (entry->flags & XEN_MAPCACHE_ENTRY_GRANT) {
         rc = xengnttab_unmap(xen_region_gnttabdev, entry->vaddr_base,
                              entry->size >> mc->bucket_shift);
diff --git a/migration/ram.c b/migration/ram.c
index fc38ffbf8af1..6bc7f705d31a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4699,18 +4699,12 @@ static SaveVMHandlers savevm_ram_handlers = {
     .save_postcopy_prepare = ram_save_postcopy_prepare,
 };
 
-static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
-                                      size_t old_size, size_t new_size)
+static void ram_mig_ram_block_resized(RAMBlockNotifier *n, RAMBlock *rb,
+                                      size_t new_size)
 {
     PostcopyState ps = postcopy_state_get();
-    ram_addr_t offset;
-    RAMBlock *rb = qemu_ram_block_from_host(host, false, &offset);
     Error *err = NULL;
-
-    if (!rb) {
-        error_report("RAM block not found");
-        return;
-    }
+    ram_addr_t old_size = qemu_ram_get_used_length(rb);
 
     if (migrate_ram_is_ignored(rb)) {
         return;
diff --git a/system/physmem.c b/system/physmem.c
index 7bcbf8757361..6d00e99270c7 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2019,7 +2019,6 @@ static int memory_try_enable_merging(void *addr, size_t len)
  */
 int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
 {
-    const ram_addr_t oldsize = block->used_length;
     const ram_addr_t unaligned_size = newsize;
 
     newsize = TARGET_PAGE_ALIGN(newsize);
@@ -2057,7 +2056,7 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
 
     /* Notify before modifying the ram block and touching the bitmaps. */
     if (block->host) {
-        ram_block_notify_resize(block->host, oldsize, newsize);
+        ram_block_notify_resize(block, newsize);
     }
 
     physical_memory_clear_dirty_range(block->offset, block->used_length);
@@ -2283,7 +2282,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             qemu_madvise(new_block->host, new_block->max_length,
                          QEMU_MADV_DONTFORK);
         }
-        ram_block_notify_add(new_block->host, new_block->used_length,
+        ram_block_notify_add(new_block, new_block->host, new_block->used_length,
                              new_block->max_length);
     }
     return;
@@ -2600,7 +2599,7 @@ void qemu_ram_free(RAMBlock *block)
     }
 
     if (block->host) {
-        ram_block_notify_remove(block->host, block->used_length,
+        ram_block_notify_remove(block, block->host, block->used_length,
                                 block->max_length);
     }
 
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 8a1af35ed32b..f29b9c504ea8 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -1134,8 +1134,8 @@ static MemoryListener nvmm_memory_listener = {
 };
 
 static void
-nvmm_ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
-                     size_t max_size)
+nvmm_ram_block_added(RAMBlockNotifier *n, const RAMBlock *rb,
+                     void *host, size_t size, size_t max_size)
 {
     struct nvmm_machine *mach = get_nvmm_mach();
     uintptr_t hva = (uintptr_t)host;
diff --git a/target/i386/sev.c b/target/i386/sev.c
index b44b5a1c2b94..63d8d36b6d41 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -329,8 +329,8 @@ sev_set_guest_state(SevCommonState *sev_common, SevState new_state)
 }
 
 static void
-sev_ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
-                    size_t max_size)
+sev_ram_block_added(RAMBlockNotifier *n, const RAMBlock *rb,
+                    void *host, size_t size, size_t max_size)
 {
     int r;
     struct kvm_enc_region range;
@@ -359,8 +359,8 @@ sev_ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
 }
 
 static void
-sev_ram_block_removed(RAMBlockNotifier *n, void *host, size_t size,
-                      size_t max_size)
+sev_ram_block_removed(RAMBlockNotifier *n, const RAMBlock *rb,
+                      void *host, size_t size, size_t max_size)
 {
     int r;
     struct kvm_enc_region range;
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index aab0bf9d485d..5059ed44b8af 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -465,8 +465,8 @@ fail_container:
     return ret;
 }
 
-static void qemu_vfio_ram_block_added(RAMBlockNotifier *n, void *host,
-                                      size_t size, size_t max_size)
+static void qemu_vfio_ram_block_added(RAMBlockNotifier *n, const RAMBlock *rb,
+                                      void *host, size_t size, size_t max_size)
 {
     QEMUVFIOState *s = container_of(n, QEMUVFIOState, ram_notifier);
     Error *local_err = NULL;
@@ -481,7 +481,8 @@ static void qemu_vfio_ram_block_added(RAMBlockNotifier *n, void *host,
     }
 }
 
-static void qemu_vfio_ram_block_removed(RAMBlockNotifier *n, void *host,
+static void qemu_vfio_ram_block_removed(RAMBlockNotifier *n, const RAMBlock *rb,
+                                        void *host,
                                         size_t size, size_t max_size)
 {
     QEMUVFIOState *s = container_of(n, QEMUVFIOState, ram_notifier);

-- 
2.54.0


