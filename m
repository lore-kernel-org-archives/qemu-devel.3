Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070EEC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 06:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmply-0002Er-5k; Wed, 20 Mar 2024 02:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmplw-0002EX-BS
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:50:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmplu-0001WP-IB
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710917398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YdM+8DlBSfQGNojw2NWBbBFEkSwJYFiGvC2NciZ76U0=;
 b=LZI++9fZXhaLOckpwJh7w8/l3JoY2cXyvbsswbBOkKU3pJHN3UN0ZMU/0cHJvKhkndIAkG
 aZywoGOmem5SD4Y9p5AfhliD2qEThKgAVkDjKynE8BwA9yrQyVA0hU8t5pfIFbtLanjANj
 we0mecQr+7QJCMebhkUoWJFCuJ6ZkXs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-erG_ZhkbPw68buUwpoSCoA-1; Wed,
 20 Mar 2024 02:49:53 -0400
X-MC-Unique: erG_ZhkbPw68buUwpoSCoA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 963471C06901;
 Wed, 20 Mar 2024 06:49:52 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E851A1C060A6;
 Wed, 20 Mar 2024 06:49:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Avihai Horon <avihaih@nvidia.com>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>, xen-devel@lists.xenproject.org
Subject: [PATCH for-9.1 v5 09/14] memory: Add Error** argument to
 .log_global_start() handler
Date: Wed, 20 Mar 2024 07:49:05 +0100
Message-ID: <20240320064911.545001-10-clg@redhat.com>
In-Reply-To: <20240320064911.545001-1-clg@redhat.com>
References: <20240320064911.545001-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

 Changes in v5:

 - Removed memory_global_dirty_log_rollback
 - Introduced memory_global_dirty_log_do_start() to call
   .log_global_start() handlers and do the rollback in case of error.
 - Kept modification of the global_dirty_tracking flag within
   memory_global_dirty_log_start()  
 - Added an assert on error of a .log_global_start() handler in
   listener_add_address_space()

 include/exec/memory.h |  5 ++++-
 hw/i386/xen/xen-hvm.c |  3 ++-
 hw/vfio/common.c      |  4 +++-
 hw/virtio/vhost.c     |  3 ++-
 system/memory.c       | 37 +++++++++++++++++++++++++++++++++++--
 5 files changed, 46 insertions(+), 6 deletions(-)

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
index 7745cb39631ea423aeb6e5d3eb7f7bcbe27ec6fa..f6e9a1bc86491783077b5cb5aafdb19ab294e392 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -457,11 +457,12 @@ static void xen_log_sync(MemoryListener *listener, MemoryRegionSection *section)
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
index 011ceaab89433de4496dffadc737286e053f321d..8f9cbdc0264044ce587877a7d19d14b28527291b 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1066,7 +1066,8 @@ out:
     return ret;
 }
 
-static void vfio_listener_log_global_start(MemoryListener *listener)
+static bool vfio_listener_log_global_start(MemoryListener *listener,
+                                           Error **errp)
 {
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
@@ -1083,6 +1084,7 @@ static void vfio_listener_log_global_start(MemoryListener *listener)
                      ret, strerror(-ret));
         vfio_set_migration_error(ret);
     }
+    return !ret;
 }
 
 static void vfio_listener_log_global_stop(MemoryListener *listener)
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2e4e040db87acf45166da86d268077f54511d82c..d405f03caf2fd3a5ea23bdc0392f4c6c072bc10b 100644
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
index a229a79988fce2aa3cb77e3a130db4c694e8cd49..ca4d91484fb3d06f4b902486fea49dba86dc141b 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2914,9 +2914,33 @@ static unsigned int postponed_stop_flags;
 static VMChangeStateEntry *vmstate_change;
 static void memory_global_dirty_log_stop_postponed_run(void);
 
+static bool memory_global_dirty_log_do_start(Error **errp)
+{
+    MemoryListener *listener;
+
+    QTAILQ_FOREACH(listener, &memory_listeners, link) {
+        if (listener->log_global_start) {
+            if (!listener->log_global_start(listener, errp)) {
+                goto err;
+            }
+        }
+    }
+    return true;
+
+err:
+    while ((listener = QTAILQ_PREV(listener, link)) != NULL) {
+        if (listener->log_global_stop) {
+            listener->log_global_stop(listener);
+        }
+    }
+
+    return false;
+}
+
 void memory_global_dirty_log_start(unsigned int flags)
 {
     unsigned int old_flags;
+    Error *local_err = NULL;
 
     assert(flags && !(flags & (~GLOBAL_DIRTY_MASK)));
 
@@ -2936,7 +2960,13 @@ void memory_global_dirty_log_start(unsigned int flags)
     trace_global_dirty_changed(global_dirty_tracking);
 
     if (!old_flags) {
-        MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward);
+        if (!memory_global_dirty_log_do_start(&local_err)) {
+            global_dirty_tracking &= ~flags;
+            trace_global_dirty_changed(global_dirty_tracking);
+            error_report_err(local_err);
+            return;
+        }
+
         memory_region_transaction_begin();
         memory_region_update_pending = true;
         memory_region_transaction_commit();
@@ -3014,8 +3044,11 @@ static void listener_add_address_space(MemoryListener *listener,
         listener->begin(listener);
     }
     if (global_dirty_tracking) {
+        /*
+         * Migration has already started. Assert on any error.
+         */
         if (listener->log_global_start) {
-            listener->log_global_start(listener);
+            listener->log_global_start(listener, &error_abort);
         }
     }
 
-- 
2.44.0


