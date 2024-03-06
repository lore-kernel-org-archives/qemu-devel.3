Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7704CC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhrR3-0000FZ-Qf; Wed, 06 Mar 2024 08:35:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrR1-00008Z-Rw
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:35:51 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrQy-0006AR-N9
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:35:51 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TqYNL3hk6z4wys;
 Thu,  7 Mar 2024 00:35:46 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqYNF235lz4wcF;
 Thu,  7 Mar 2024 00:35:40 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 13/25] memory: Add Error** argument to .log_global_start()
 handler
Date: Wed,  6 Mar 2024 14:34:28 +0100
Message-ID: <20240306133441.2351700-14-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306133441.2351700-1-clg@redhat.com>
References: <20240306133441.2351700-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

Modify all .log_global_start() handlers to take an Error** parameter
and return a bool. Adapt memory_global_dirty_log_start() to interrupt
on the first error the loop on handlers. In such case, a rollback is
performed to stop dirty logging on all listeners where it was
previously enabled.

Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v4:

 - Dropped log_global_stop() and log_global_sync() changes
 - Dropped MEMORY_LISTENER_CALL_LOG_GLOBAL 
 - Modified memory_global_dirty_log_start() to loop on the list of
   listeners and handle errors directly.
 - Introduced memory_global_dirty_log_rollback() to revert operations
   previously done
   
 Changes in v3: 

 - Fixed return value of vfio_listener_log_global_start() and
   vfio_listener_log_global_stop(). Went unnoticed because not tested.
   
 include/exec/memory.h |  5 ++++-
 hw/i386/xen/xen-hvm.c |  3 ++-
 hw/vfio/common.c      |  4 +++-
 hw/virtio/vhost.c     |  3 ++-
 system/memory.c       | 43 +++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 8626a355b310ed7b1a1db7978ba4b394032c2f15..5555567bc4c9fdb53e8f63487f1400980275687d 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -998,8 +998,11 @@ struct MemoryListener {
      * active at that time.
      *
      * @listener: The #MemoryListener.
+     * @errp: pointer to Error*, to store an error if it happens.
+     *
+     * Return: true on success, else false setting @errp with error.
      */
-    void (*log_global_start)(MemoryListener *listener);
+    bool (*log_global_start)(MemoryListener *listener, Error **errp);
 
     /**
      * @log_global_stop:
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index f42621e6742552035122ea58092c91c3458338ff..0608ca99f5166fd6379ee674442484e805eff9c0 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -446,11 +446,12 @@ static void xen_log_sync(MemoryListener *listener, MemoryRegionSection *section)
                           int128_get64(section->size));
 }
 
-static void xen_log_global_start(MemoryListener *listener)
+static bool xen_log_global_start(MemoryListener *listener, Error **errp)
 {
     if (xen_enabled()) {
         xen_in_migration = true;
     }
+    return true;
 }
 
 static void xen_log_global_stop(MemoryListener *listener)
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index ff88c3f31ca660b3c0a790601100fdc6116192a0..800ba0aeac84b8dcc83b042bb70c37b4bf78d3f4 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1075,7 +1075,8 @@ out:
     return ret;
 }
 
-static void vfio_listener_log_global_start(MemoryListener *listener)
+static bool vfio_listener_log_global_start(MemoryListener *listener,
+                                           Error **errp)
 {
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
@@ -1092,6 +1093,7 @@ static void vfio_listener_log_global_start(MemoryListener *listener)
                      ret, strerror(-ret));
         vfio_set_migration_error(ret);
     }
+    return !ret;
 }
 
 static void vfio_listener_log_global_stop(MemoryListener *listener)
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2c9ac794680ea9b65eba6cc22e70cf141e90aa73..030b24db9270fc272024db3ff60a6cc449fba1ca 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1044,7 +1044,7 @@ check_dev_state:
     return r;
 }
 
-static void vhost_log_global_start(MemoryListener *listener)
+static bool vhost_log_global_start(MemoryListener *listener, Error **errp)
 {
     int r;
 
@@ -1052,6 +1052,7 @@ static void vhost_log_global_start(MemoryListener *listener)
     if (r < 0) {
         abort();
     }
+    return true;
 }
 
 static void vhost_log_global_stop(MemoryListener *listener)
diff --git a/system/memory.c b/system/memory.c
index a229a79988fce2aa3cb77e3a130db4c694e8cd49..3600e716149407c10a1f6bf8f0a81c2611cf15ba 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2914,9 +2914,27 @@ static unsigned int postponed_stop_flags;
 static VMChangeStateEntry *vmstate_change;
 static void memory_global_dirty_log_stop_postponed_run(void);
 
+/*
+ * Stop dirty logging on all listeners where it was previously enabled.
+ */
+static void memory_global_dirty_log_rollback(MemoryListener *listener,
+                                             unsigned int flags)
+{
+    global_dirty_tracking &= ~flags;
+    trace_global_dirty_changed(global_dirty_tracking);
+
+    while (listener) {
+        if (listener->log_global_stop) {
+            listener->log_global_stop(listener);
+        }
+        listener = QTAILQ_PREV(listener, link);
+    }
+}
+
 void memory_global_dirty_log_start(unsigned int flags)
 {
     unsigned int old_flags;
+    Error *local_err = NULL;
 
     assert(flags && !(flags & (~GLOBAL_DIRTY_MASK)));
 
@@ -2936,7 +2954,25 @@ void memory_global_dirty_log_start(unsigned int flags)
     trace_global_dirty_changed(global_dirty_tracking);
 
     if (!old_flags) {
-        MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward);
+        MemoryListener *listener;
+        bool ret = true;
+
+        QTAILQ_FOREACH(listener, &memory_listeners, link) {
+            if (listener->log_global_start) {
+                ret = listener->log_global_start(listener, &local_err);
+                if (!ret) {
+                    break;
+                }
+            }
+        }
+
+        if (!ret) {
+            memory_global_dirty_log_rollback(QTAILQ_PREV(listener, link),
+                                             flags);
+            error_report_err(local_err);
+            return;
+        }
+
         memory_region_transaction_begin();
         memory_region_update_pending = true;
         memory_region_transaction_commit();
@@ -3009,13 +3045,16 @@ static void listener_add_address_space(MemoryListener *listener,
 {
     FlatView *view;
     FlatRange *fr;
+    Error *local_err = NULL;
 
     if (listener->begin) {
         listener->begin(listener);
     }
     if (global_dirty_tracking) {
         if (listener->log_global_start) {
-            listener->log_global_start(listener);
+            if (!listener->log_global_start(listener, &local_err)) {
+                error_report_err(local_err);
+            }
         }
     }
 
-- 
2.44.0


