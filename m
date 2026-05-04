Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC66FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 12:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJsS1-000117-Fo; Mon, 04 May 2026 08:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJsRd-0000ps-TO
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:30:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJsRX-0006aS-Kg
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777897834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kmBVLQRvX9Sfjg3rCQu8GUJMo2LWoKGX23qzv4xfYFc=;
 b=FdKre43McAk6yfYkka8BBmC9Hw4bM+wbgnSB7pi1UvM9nOf/lQkZlgu3dnken/5Irr6ryR
 dXyaJT6K88f8/mEfIHwUtcZYPXdDyrq9TDGfPmQXPXBH+D/kSrQe8CMx7VRMrVTase5gbh
 J/d0rYxV6NvR7zAT1eLI88NWdaapTEI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-tJrPpXddMlOU8aweZe8UYw-1; Mon,
 04 May 2026 08:30:30 -0400
X-MC-Unique: tJrPpXddMlOU8aweZe8UYw-1
X-Mimecast-MFC-AGG-ID: tJrPpXddMlOU8aweZe8UYw_1777897830
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCD771955E7E
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 12:30:29 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7FE3A1800480; Mon,  4 May 2026 12:30:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 16:30:07 +0400
Subject: [PATCH v4 01/13] system/memory: split RamDiscardManager into
 source and manager
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-rdm5-v4-1-bdf61e57c1e1@redhat.com>
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
In-Reply-To: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=50871;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3k+/GbDe4/jr/NSVrz9nlKdX1cQ6WL3WL65sDPTIKIc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+JFYRw2KxaVVGQ/TT4bYVYxHRXmJgJAcXMtu/
 AObTJ6GfpuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiRWAAKCRDa6OEJdZac
 5X4GD/0eJzQOrXwO39cPAN98Gu3olaz5cYVDUXKBw1lzIRc5fED/MpHiIr97QbsjD/+YGI7zWRh
 SgOH0cEm11aE+9w8SJZiQRfBUxjj6ay2FAkZaUBLth1tqQFU1y4fXMIS6S80WofEJvhRNOUsSZi
 KDy84KdA+fyuvVJAvB6kwFrk03POgULDVTlhgTk4NzihGj6ehzapXNS+xT7xrh8yZe8EkXoOr+J
 +uHRSZR8zEj1oMesGY/0GzPwCefI/KlTBSnJ3I3cfodJ2C4W8OwNh9lX4/TUOCcmbdt1XRCqTzK
 ajeqdvDNXZGdBL+aJtrb20NraFMJKZDEA7wSjZNasVbykhirYJJJCSMsOjaG2Cin/aB895i65Bv
 B4Y0t00Jf64SZ20YXeWXdSwCZPCRVS7jggcsYPo8tjK6jr3Je85+DyBaEfbWn3D8iBOGMN5U5K4
 vRT4NlTDOgCX1i9oyczio6452GG7Z9+nknCm0gJBIw/2m6Vx8IVeoi8JynOalfWCRj/+K1jHRnR
 RCqsqOajHzhH+JckZssqQ8VlAdA/Xh+cHSSmFEDPG5x8CK3d+Q1S4FCO5JvNqlHPtosAmldLdr6
 8kfVA5DiKZ6CggDSCqpvDrt3sgHDU6phFfuXecuDuu3KgeuLp4qmnI4PNtRlgQaAiunlNA9mbGf
 OAhGyrNAwqmL/8Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Refactor the RamDiscardManager interface into two distinct components:
- RamDiscardSource: An interface that state providers (virtio-mem,
  RamBlockAttributes) implement to provide discard state information
  (granularity, populated/discarded ranges, replay callbacks).
- RamDiscardManager: A concrete QOM object that wraps a source, owns
  the listener list, and handles listener registration/unregistration
  and notifications.

This separation moves the listener management logic from individual
source implementations into the central RamDiscardManager, reducing
code duplication between virtio-mem and RamBlockAttributes.

The change prepares for future work where a RamDiscardManager could
aggregate multiple sources.

Note, the original virtio-mem code had conditions before discard:
  if (vmem->size) {
      rdl->notify_discard(rdl, rdl->section);
  }
however, the new code calls discard unconditionally. This is considered
safe, since the populate/discard of sections are already asymmetrical
(unplug & unregister all listener section unconditionally).

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-mem.h |   3 -
 include/system/memory.h        | 197 +++++++++++++++++++++----------------
 include/system/ramblock.h      |   3 +-
 hw/virtio/virtio-mem.c         | 163 ++++++------------------------
 system/memory.c                | 218 ++++++++++++++++++++++++++++++++++++-----
 system/ram-block-attributes.c  | 171 ++++++++++----------------------
 6 files changed, 386 insertions(+), 369 deletions(-)

diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.h
index 221cfd76bf9..5d1d19c6bec 100644
--- a/include/hw/virtio/virtio-mem.h
+++ b/include/hw/virtio/virtio-mem.h
@@ -118,9 +118,6 @@ struct VirtIOMEM {
     /* notifiers to notify when "size" changes */
     NotifierList size_change_notifiers;
 
-    /* listeners to notify on plug/unplug activity. */
-    QLIST_HEAD(, RamDiscardListener) rdl_list;
-
     /* Catch system resets -> qemu_devices_reset() only. */
     VirtioMemSystemReset *system_reset;
 };
diff --git a/include/system/memory.h b/include/system/memory.h
index 1417132f6d9..a37d320293a 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -54,6 +54,12 @@ typedef struct RamDiscardManager RamDiscardManager;
 DECLARE_OBJ_CHECKERS(RamDiscardManager, RamDiscardManagerClass,
                      RAM_DISCARD_MANAGER, TYPE_RAM_DISCARD_MANAGER);
 
+#define TYPE_RAM_DISCARD_SOURCE "ram-discard-source"
+typedef struct RamDiscardSourceClass RamDiscardSourceClass;
+typedef struct RamDiscardSource RamDiscardSource;
+DECLARE_OBJ_CHECKERS(RamDiscardSource, RamDiscardSourceClass,
+                     RAM_DISCARD_SOURCE, TYPE_RAM_DISCARD_SOURCE);
+
 #ifdef CONFIG_FUZZ
 void fuzz_dma_read_cb(size_t addr,
                       size_t len,
@@ -595,8 +601,8 @@ static inline void ram_discard_listener_init(RamDiscardListener *rdl,
 /**
  * typedef ReplayRamDiscardState:
  *
- * The callback handler for #RamDiscardManagerClass.replay_populated/
- * #RamDiscardManagerClass.replay_discarded to invoke on populated/discarded
+ * The callback handler for #RamDiscardSourceClass.replay_populated/
+ * #RamDiscardSourceClass.replay_discarded to invoke on populated/discarded
  * parts.
  *
  * @section: the #MemoryRegionSection of populated/discarded part
@@ -608,40 +614,17 @@ typedef int (*ReplayRamDiscardState)(MemoryRegionSection *section,
                                      void *opaque);
 
 /*
- * RamDiscardManagerClass:
- *
- * A #RamDiscardManager coordinates which parts of specific RAM #MemoryRegion
- * regions are currently populated to be used/accessed by the VM, notifying
- * after parts were discarded (freeing up memory) and before parts will be
- * populated (consuming memory), to be used/accessed by the VM.
+ * RamDiscardSourceClass:
  *
- * A #RamDiscardManager can only be set for a RAM #MemoryRegion while the
- * #MemoryRegion isn't mapped into an address space yet (either directly
- * or via an alias); it cannot change while the #MemoryRegion is
- * mapped into an address space.
+ * A #RamDiscardSource provides information about which parts of a specific
+ * RAM #MemoryRegion are currently populated (accessible) vs discarded.
  *
- * The #RamDiscardManager is intended to be used by technologies that are
- * incompatible with discarding of RAM (e.g., VFIO, which may pin all
- * memory inside a #MemoryRegion), and require proper coordination to only
- * map the currently populated parts, to hinder parts that are expected to
- * remain discarded from silently getting populated and consuming memory.
- * Technologies that support discarding of RAM don't have to bother and can
- * simply map the whole #MemoryRegion.
- *
- * An example #RamDiscardManager is virtio-mem, which logically (un)plugs
- * memory within an assigned RAM #MemoryRegion, coordinated with the VM.
- * Logically unplugging memory consists of discarding RAM. The VM agreed to not
- * access unplugged (discarded) memory - especially via DMA. virtio-mem will
- * properly coordinate with listeners before memory is plugged (populated),
- * and after memory is unplugged (discarded).
- *
- * Listeners are called in multiples of the minimum granularity (unless it
- * would exceed the registered range) and changes are aligned to the minimum
- * granularity within the #MemoryRegion. Listeners have to prepare for memory
- * becoming discarded in a different granularity than it was populated and the
- * other way around.
+ * This is an interface that state providers (like virtio-mem or
+ * RamBlockAttributes) implement to provide discard state information. A
+ * #RamDiscardManager wraps sources and manages listener registrations and
+ * notifications.
  */
-struct RamDiscardManagerClass {
+struct RamDiscardSourceClass {
     /* private */
     InterfaceClass parent_class;
 
@@ -651,47 +634,47 @@ struct RamDiscardManagerClass {
      * @get_min_granularity:
      *
      * Get the minimum granularity in which listeners will get notified
-     * about changes within the #MemoryRegion via the #RamDiscardManager.
+     * about changes within the #MemoryRegion via the #RamDiscardSource.
      *
-     * @rdm: the #RamDiscardManager
+     * @rds: the #RamDiscardSource
      * @mr: the #MemoryRegion
      *
      * Returns the minimum granularity.
      */
-    uint64_t (*get_min_granularity)(const RamDiscardManager *rdm,
+    uint64_t (*get_min_granularity)(const RamDiscardSource *rds,
                                     const MemoryRegion *mr);
 
     /**
      * @is_populated:
      *
      * Check whether the given #MemoryRegionSection is completely populated
-     * (i.e., no parts are currently discarded) via the #RamDiscardManager.
+     * (i.e., no parts are currently discarded) via the #RamDiscardSource.
      * There are no alignment requirements.
      *
-     * @rdm: the #RamDiscardManager
+     * @rds: the #RamDiscardSource
      * @section: the #MemoryRegionSection
      *
      * Returns whether the given range is completely populated.
      */
-    bool (*is_populated)(const RamDiscardManager *rdm,
+    bool (*is_populated)(const RamDiscardSource *rds,
                          const MemoryRegionSection *section);
 
     /**
      * @replay_populated:
      *
      * Call the #ReplayRamDiscardState callback for all populated parts within
-     * the #MemoryRegionSection via the #RamDiscardManager.
+     * the #MemoryRegionSection via the #RamDiscardSource.
      *
      * In case any call fails, no further calls are made.
      *
-     * @rdm: the #RamDiscardManager
+     * @rds: the #RamDiscardSource
      * @section: the #MemoryRegionSection
      * @replay_fn: the #ReplayRamDiscardState callback
      * @opaque: pointer to forward to the callback
      *
      * Returns 0 on success, or a negative error if any notification failed.
      */
-    int (*replay_populated)(const RamDiscardManager *rdm,
+    int (*replay_populated)(const RamDiscardSource *rds,
                             MemoryRegionSection *section,
                             ReplayRamDiscardState replay_fn, void *opaque);
 
@@ -699,50 +682,60 @@ struct RamDiscardManagerClass {
      * @replay_discarded:
      *
      * Call the #ReplayRamDiscardState callback for all discarded parts within
-     * the #MemoryRegionSection via the #RamDiscardManager.
+     * the #MemoryRegionSection via the #RamDiscardSource.
      *
-     * @rdm: the #RamDiscardManager
+     * @rds: the #RamDiscardSource
      * @section: the #MemoryRegionSection
      * @replay_fn: the #ReplayRamDiscardState callback
      * @opaque: pointer to forward to the callback
      *
      * Returns 0 on success, or a negative error if any notification failed.
      */
-    int (*replay_discarded)(const RamDiscardManager *rdm,
+    int (*replay_discarded)(const RamDiscardSource *rds,
                             MemoryRegionSection *section,
                             ReplayRamDiscardState replay_fn, void *opaque);
+};
 
-    /**
-     * @register_listener:
-     *
-     * Register a #RamDiscardListener for the given #MemoryRegionSection and
-     * immediately notify the #RamDiscardListener about all populated parts
-     * within the #MemoryRegionSection via the #RamDiscardManager.
-     *
-     * In case any notification fails, no further notifications are triggered
-     * and an error is logged.
-     *
-     * @rdm: the #RamDiscardManager
-     * @rdl: the #RamDiscardListener
-     * @section: the #MemoryRegionSection
-     */
-    void (*register_listener)(RamDiscardManager *rdm,
-                              RamDiscardListener *rdl,
-                              MemoryRegionSection *section);
+/**
+ * RamDiscardManager:
+ *
+ * A #RamDiscardManager coordinates which parts of specific RAM #MemoryRegion
+ * regions are currently populated to be used/accessed by the VM, notifying
+ * after parts were discarded (freeing up memory) and before parts will be
+ * populated (consuming memory), to be used/accessed by the VM.
+ *
+ * A #RamDiscardManager can only be set for a RAM #MemoryRegion while the
+ * #MemoryRegion isn't mapped into an address space yet (either directly
+ * or via an alias); it cannot change while the #MemoryRegion is
+ * mapped into an address space.
+ *
+ * The #RamDiscardManager is intended to be used by technologies that are
+ * incompatible with discarding of RAM (e.g., VFIO, which may pin all
+ * memory inside a #MemoryRegion), and require proper coordination to only
+ * map the currently populated parts, to hinder parts that are expected to
+ * remain discarded from silently getting populated and consuming memory.
+ * Technologies that support discarding of RAM don't have to bother and can
+ * simply map the whole #MemoryRegion.
+ *
+ * An example #RamDiscardSource is virtio-mem, which logically (un)plugs
+ * memory within an assigned RAM #MemoryRegion, coordinated with the VM.
+ * Logically unplugging memory consists of discarding RAM. The VM agreed to not
+ * access unplugged (discarded) memory - especially via DMA. virtio-mem will
+ * properly coordinate with listeners before memory is plugged (populated),
+ * and after memory is unplugged (discarded).
+ *
+ * Listeners are called in multiples of the minimum granularity (unless it
+ * would exceed the registered range) and changes are aligned to the minimum
+ * granularity within the #MemoryRegion. Listeners have to prepare for memory
+ * becoming discarded in a different granularity than it was populated and the
+ * other way around.
+ */
+struct RamDiscardManager {
+    Object parent;
 
-    /**
-     * @unregister_listener:
-     *
-     * Unregister a previously registered #RamDiscardListener via the
-     * #RamDiscardManager after notifying the #RamDiscardListener about all
-     * populated parts becoming unpopulated within the registered
-     * #MemoryRegionSection.
-     *
-     * @rdm: the #RamDiscardManager
-     * @rdl: the #RamDiscardListener
-     */
-    void (*unregister_listener)(RamDiscardManager *rdm,
-                                RamDiscardListener *rdl);
+    RamDiscardSource *rds;
+    MemoryRegion *mr;
+    QLIST_HEAD(, RamDiscardListener) rdl_list;
 };
 
 uint64_t ram_discard_manager_get_min_granularity(const RamDiscardManager *rdm,
@@ -754,8 +747,8 @@ bool ram_discard_manager_is_populated(const RamDiscardManager *rdm,
 /**
  * ram_discard_manager_replay_populated:
  *
- * A wrapper to call the #RamDiscardManagerClass.replay_populated callback
- * of the #RamDiscardManager.
+ * A wrapper to call the #RamDiscardSourceClass.replay_populated callback
+ * of the #RamDiscardSource sources.
  *
  * @rdm: the #RamDiscardManager
  * @section: the #MemoryRegionSection
@@ -772,8 +765,8 @@ int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
 /**
  * ram_discard_manager_replay_discarded:
  *
- * A wrapper to call the #RamDiscardManagerClass.replay_discarded callback
- * of the #RamDiscardManager.
+ * A wrapper to call the #RamDiscardSourceClass.replay_discarded callback
+ * of the #RamDiscardSource sources.
  *
  * @rdm: the #RamDiscardManager
  * @section: the #MemoryRegionSection
@@ -794,6 +787,34 @@ void ram_discard_manager_register_listener(RamDiscardManager *rdm,
 void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
                                              RamDiscardListener *rdl);
 
+/*
+ * Note: later refactoring should take the source into account and the manager
+ *       should be able to aggregate multiple sources.
+ */
+int ram_discard_manager_notify_populate(RamDiscardManager *rdm,
+                                        uint64_t offset, uint64_t size);
+
+ /*
+  * Note: later refactoring should take the source into account and the manager
+  *       should be able to aggregate multiple sources.
+  */
+void ram_discard_manager_notify_discard(RamDiscardManager *rdm,
+                                        uint64_t offset, uint64_t size);
+
+/*
+ * Note: later refactoring should take the source into account and the manager
+ *       should be able to aggregate multiple sources.
+ */
+void ram_discard_manager_notify_discard_all(RamDiscardManager *rdm);
+
+/*
+ * Replay populated sections to all registered listeners.
+ *
+ * Note: later refactoring should take the source into account and the manager
+ *       should be able to aggregate multiple sources.
+ */
+int ram_discard_manager_replay_populated_to_listeners(RamDiscardManager *rdm);
+
 /**
  * memory_translate_iotlb: Extract addresses from a TLB entry.
  *                         Called with rcu_read_lock held.
@@ -2486,18 +2507,22 @@ static inline bool memory_region_has_ram_discard_manager(MemoryRegion *mr)
 }
 
 /**
- * memory_region_set_ram_discard_manager: set the #RamDiscardManager for a
+ * memory_region_add_ram_discard_source: add a #RamDiscardSource for a
  * #MemoryRegion
  *
- * This function must not be called for a mapped #MemoryRegion, a #MemoryRegion
- * that does not cover RAM, or a #MemoryRegion that already has a
- * #RamDiscardManager assigned. Return 0 if the rdm is set successfully.
+ * @mr: the #MemoryRegion
+ * @source: #RamDiscardSource to add
+ */
+int memory_region_add_ram_discard_source(MemoryRegion *mr, RamDiscardSource *source);
+
+/**
+ * memory_region_del_ram_discard_source: remove a #RamDiscardSource for a
+ * #MemoryRegion
  *
  * @mr: the #MemoryRegion
- * @rdm: #RamDiscardManager to set
+ * @source: #RamDiscardSource to remove
  */
-int memory_region_set_ram_discard_manager(MemoryRegion *mr,
-                                          RamDiscardManager *rdm);
+void memory_region_del_ram_discard_source(MemoryRegion *mr, RamDiscardSource *source);
 
 /**
  * memory_region_find: translate an address/size relative to a
diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 4435f8d55fe..f0b557af416 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -99,11 +99,10 @@ struct RamBlockAttributes {
     /* 1-setting of the bitmap represents ram is populated (shared) */
     unsigned bitmap_size;
     unsigned long *bitmap;
-
-    QLIST_HEAD(, RamDiscardListener) rdl_list;
 };
 
 /* @offset: the offset within the RAMBlock */
+
 int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length);
 /* @offset: the offset within the RAMBlock */
 int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t offset,
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index a4b71974a1c..be149ee9441 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -16,6 +16,7 @@
 #include "qemu/error-report.h"
 #include "qemu/units.h"
 #include "qemu/target-info-qapi.h"
+#include "system/memory.h"
 #include "system/numa.h"
 #include "system/system.h"
 #include "system/ramblock.h"
@@ -324,74 +325,31 @@ static int virtio_mem_for_each_unplugged_section(const VirtIOMEM *vmem,
     return ret;
 }
 
-static int virtio_mem_notify_populate_cb(MemoryRegionSection *s, void *arg)
-{
-    RamDiscardListener *rdl = arg;
-
-    return rdl->notify_populate(rdl, s);
-}
-
 static void virtio_mem_notify_unplug(VirtIOMEM *vmem, uint64_t offset,
                                      uint64_t size)
 {
-    RamDiscardListener *rdl;
+    RamDiscardManager *rdm = memory_region_get_ram_discard_manager(&vmem->memdev->mr);
 
-    QLIST_FOREACH(rdl, &vmem->rdl_list, next) {
-        MemoryRegionSection tmp = *rdl->section;
-
-        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
-            continue;
-        }
-        rdl->notify_discard(rdl, &tmp);
-    }
+    ram_discard_manager_notify_discard(rdm, offset, size);
 }
 
 static int virtio_mem_notify_plug(VirtIOMEM *vmem, uint64_t offset,
                                   uint64_t size)
 {
-    RamDiscardListener *rdl, *rdl2;
-    int ret = 0;
-
-    QLIST_FOREACH(rdl, &vmem->rdl_list, next) {
-        MemoryRegionSection tmp = *rdl->section;
+    RamDiscardManager *rdm = memory_region_get_ram_discard_manager(&vmem->memdev->mr);
 
-        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
-            continue;
-        }
-        ret = rdl->notify_populate(rdl, &tmp);
-        if (ret) {
-            break;
-        }
-    }
-
-    if (ret) {
-        /* Notify all already-notified listeners. */
-        QLIST_FOREACH(rdl2, &vmem->rdl_list, next) {
-            MemoryRegionSection tmp = *rdl2->section;
-
-            if (rdl2 == rdl) {
-                break;
-            }
-            if (!memory_region_section_intersect_range(&tmp, offset, size)) {
-                continue;
-            }
-            rdl2->notify_discard(rdl2, &tmp);
-        }
-    }
-    return ret;
+    return ram_discard_manager_notify_populate(rdm, offset, size);
 }
 
 static void virtio_mem_notify_unplug_all(VirtIOMEM *vmem)
 {
-    RamDiscardListener *rdl;
+    RamDiscardManager *rdm = memory_region_get_ram_discard_manager(&vmem->memdev->mr);
 
     if (!vmem->size) {
         return;
     }
 
-    QLIST_FOREACH(rdl, &vmem->rdl_list, next) {
-        rdl->notify_discard(rdl, rdl->section);
-    }
+    ram_discard_manager_notify_discard_all(rdm);
 }
 
 static bool virtio_mem_is_range_plugged(const VirtIOMEM *vmem,
@@ -1037,13 +995,9 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    /*
-     * Set ourselves as RamDiscardManager before the plug handler maps the
-     * memory region and exposes it via an address space.
-     */
-    if (memory_region_set_ram_discard_manager(&vmem->memdev->mr,
-                                              RAM_DISCARD_MANAGER(vmem))) {
-        error_setg(errp, "Failed to set RamDiscardManager");
+    if (memory_region_add_ram_discard_source(&vmem->memdev->mr,
+                                             RAM_DISCARD_SOURCE(vmem))) {
+        error_setg(errp, "Failed to add RAM discard source");
         ram_block_coordinated_discard_require(false);
         return;
     }
@@ -1062,7 +1016,8 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
         ret = ram_block_discard_range(rb, 0, qemu_ram_get_used_length(rb));
         if (ret) {
             error_setg_errno(errp, -ret, "Unexpected error discarding RAM");
-            memory_region_set_ram_discard_manager(&vmem->memdev->mr, NULL);
+            memory_region_del_ram_discard_source(&vmem->memdev->mr,
+                                                 RAM_DISCARD_SOURCE(vmem));
             ram_block_coordinated_discard_require(false);
             return;
         }
@@ -1147,7 +1102,7 @@ static void virtio_mem_device_unrealize(DeviceState *dev)
      * The unplug handler unmapped the memory region, it cannot be
      * found via an address space anymore. Unset ourselves.
      */
-    memory_region_set_ram_discard_manager(&vmem->memdev->mr, NULL);
+    memory_region_del_ram_discard_source(&vmem->memdev->mr, RAM_DISCARD_SOURCE(vmem));
     ram_block_coordinated_discard_require(false);
 }
 
@@ -1175,9 +1130,7 @@ static int virtio_mem_activate_memslot_range_cb(VirtIOMEM *vmem, void *arg,
 
 static int virtio_mem_post_load_bitmap(VirtIOMEM *vmem)
 {
-    RamDiscardListener *rdl;
-    int ret;
-
+    RamDiscardManager *rdm = memory_region_get_ram_discard_manager(&vmem->memdev->mr);
     /*
      * We restored the bitmap and updated the requested size; activate all
      * memslots (so listeners register) before notifying about plugged blocks.
@@ -1195,14 +1148,7 @@ static int virtio_mem_post_load_bitmap(VirtIOMEM *vmem)
      * We started out with all memory discarded and our memory region is mapped
      * into an address space. Replay, now that we updated the bitmap.
      */
-    QLIST_FOREACH(rdl, &vmem->rdl_list, next) {
-        ret = virtio_mem_for_each_plugged_section(vmem, rdl->section, rdl,
-                                                 virtio_mem_notify_populate_cb);
-        if (ret) {
-            return ret;
-        }
-    }
-    return 0;
+    return ram_discard_manager_replay_populated_to_listeners(rdm);
 }
 
 static int virtio_mem_post_load(void *opaque, int version_id)
@@ -1650,7 +1596,6 @@ static void virtio_mem_instance_init(Object *obj)
     VirtIOMEM *vmem = VIRTIO_MEM(obj);
 
     notifier_list_init(&vmem->size_change_notifiers);
-    QLIST_INIT(&vmem->rdl_list);
 
     object_property_add(obj, VIRTIO_MEM_SIZE_PROP, "size", virtio_mem_get_size,
                         NULL, NULL, NULL);
@@ -1694,19 +1639,19 @@ static const Property virtio_mem_legacy_guests_properties[] = {
                             unplugged_inaccessible, ON_OFF_AUTO_ON),
 };
 
-static uint64_t virtio_mem_rdm_get_min_granularity(const RamDiscardManager *rdm,
+static uint64_t virtio_mem_rds_get_min_granularity(const RamDiscardSource *rds,
                                                    const MemoryRegion *mr)
 {
-    const VirtIOMEM *vmem = VIRTIO_MEM(rdm);
+    const VirtIOMEM *vmem = VIRTIO_MEM(rds);
 
     g_assert(mr == &vmem->memdev->mr);
     return vmem->block_size;
 }
 
-static bool virtio_mem_rdm_is_populated(const RamDiscardManager *rdm,
+static bool virtio_mem_rds_is_populated(const RamDiscardSource *rds,
                                         const MemoryRegionSection *s)
 {
-    const VirtIOMEM *vmem = VIRTIO_MEM(rdm);
+    const VirtIOMEM *vmem = VIRTIO_MEM(rds);
     uint64_t start_gpa = vmem->addr + s->offset_within_region;
     uint64_t end_gpa = start_gpa + int128_get64(s->size);
 
@@ -1727,19 +1672,19 @@ struct VirtIOMEMReplayData {
     void *opaque;
 };
 
-static int virtio_mem_rdm_replay_populated_cb(MemoryRegionSection *s, void *arg)
+static int virtio_mem_rds_replay_cb(MemoryRegionSection *s, void *arg)
 {
     struct VirtIOMEMReplayData *data = arg;
 
     return data->fn(s, data->opaque);
 }
 
-static int virtio_mem_rdm_replay_populated(const RamDiscardManager *rdm,
+static int virtio_mem_rds_replay_populated(const RamDiscardSource *rds,
                                            MemoryRegionSection *s,
                                            ReplayRamDiscardState replay_fn,
                                            void *opaque)
 {
-    const VirtIOMEM *vmem = VIRTIO_MEM(rdm);
+    const VirtIOMEM *vmem = VIRTIO_MEM(rds);
     struct VirtIOMEMReplayData data = {
         .fn = replay_fn,
         .opaque = opaque,
@@ -1747,23 +1692,15 @@ static int virtio_mem_rdm_replay_populated(const RamDiscardManager *rdm,
 
     g_assert(s->mr == &vmem->memdev->mr);
     return virtio_mem_for_each_plugged_section(vmem, s, &data,
-                                            virtio_mem_rdm_replay_populated_cb);
-}
-
-static int virtio_mem_rdm_replay_discarded_cb(MemoryRegionSection *s,
-                                              void *arg)
-{
-    struct VirtIOMEMReplayData *data = arg;
-
-    return data->fn(s, data->opaque);
+                                            virtio_mem_rds_replay_cb);
 }
 
-static int virtio_mem_rdm_replay_discarded(const RamDiscardManager *rdm,
+static int virtio_mem_rds_replay_discarded(const RamDiscardSource *rds,
                                            MemoryRegionSection *s,
                                            ReplayRamDiscardState replay_fn,
                                            void *opaque)
 {
-    const VirtIOMEM *vmem = VIRTIO_MEM(rdm);
+    const VirtIOMEM *vmem = VIRTIO_MEM(rds);
     struct VirtIOMEMReplayData data = {
         .fn = replay_fn,
         .opaque = opaque,
@@ -1771,41 +1708,7 @@ static int virtio_mem_rdm_replay_discarded(const RamDiscardManager *rdm,
 
     g_assert(s->mr == &vmem->memdev->mr);
     return virtio_mem_for_each_unplugged_section(vmem, s, &data,
-                                                 virtio_mem_rdm_replay_discarded_cb);
-}
-
-static void virtio_mem_rdm_register_listener(RamDiscardManager *rdm,
-                                             RamDiscardListener *rdl,
-                                             MemoryRegionSection *s)
-{
-    VirtIOMEM *vmem = VIRTIO_MEM(rdm);
-    int ret;
-
-    g_assert(s->mr == &vmem->memdev->mr);
-    rdl->section = memory_region_section_new_copy(s);
-
-    QLIST_INSERT_HEAD(&vmem->rdl_list, rdl, next);
-    ret = virtio_mem_for_each_plugged_section(vmem, rdl->section, rdl,
-                                              virtio_mem_notify_populate_cb);
-    if (ret) {
-        error_report("%s: Replaying plugged ranges failed: %s", __func__,
-                     strerror(-ret));
-    }
-}
-
-static void virtio_mem_rdm_unregister_listener(RamDiscardManager *rdm,
-                                               RamDiscardListener *rdl)
-{
-    VirtIOMEM *vmem = VIRTIO_MEM(rdm);
-
-    g_assert(rdl->section->mr == &vmem->memdev->mr);
-    if (vmem->size) {
-        rdl->notify_discard(rdl, rdl->section);
-    }
-
-    memory_region_section_free_copy(rdl->section);
-    rdl->section = NULL;
-    QLIST_REMOVE(rdl, next);
+                                                 virtio_mem_rds_replay_cb);
 }
 
 static void virtio_mem_unplug_request_check(VirtIOMEM *vmem, Error **errp)
@@ -1837,7 +1740,7 @@ static void virtio_mem_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
     VirtIOMEMClass *vmc = VIRTIO_MEM_CLASS(klass);
-    RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_CLASS(klass);
+    RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_CLASS(klass);
 
     device_class_set_props(dc, virtio_mem_properties);
     if (virtio_mem_has_legacy_guests()) {
@@ -1861,12 +1764,10 @@ static void virtio_mem_class_init(ObjectClass *klass, const void *data)
     vmc->remove_size_change_notifier = virtio_mem_remove_size_change_notifier;
     vmc->unplug_request_check = virtio_mem_unplug_request_check;
 
-    rdmc->get_min_granularity = virtio_mem_rdm_get_min_granularity;
-    rdmc->is_populated = virtio_mem_rdm_is_populated;
-    rdmc->replay_populated = virtio_mem_rdm_replay_populated;
-    rdmc->replay_discarded = virtio_mem_rdm_replay_discarded;
-    rdmc->register_listener = virtio_mem_rdm_register_listener;
-    rdmc->unregister_listener = virtio_mem_rdm_unregister_listener;
+    rdsc->get_min_granularity = virtio_mem_rds_get_min_granularity;
+    rdsc->is_populated = virtio_mem_rds_is_populated;
+    rdsc->replay_populated = virtio_mem_rds_replay_populated;
+    rdsc->replay_discarded = virtio_mem_rds_replay_discarded;
 }
 
 static const TypeInfo virtio_mem_info = {
@@ -1878,7 +1779,7 @@ static const TypeInfo virtio_mem_info = {
     .class_init = virtio_mem_class_init,
     .class_size = sizeof(VirtIOMEMClass),
     .interfaces = (const InterfaceInfo[]) {
-        { TYPE_RAM_DISCARD_MANAGER },
+        { TYPE_RAM_DISCARD_SOURCE },
         { }
     },
 };
diff --git a/system/memory.c b/system/memory.c
index 225bbe38c32..77966513113 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2042,34 +2042,88 @@ RamDiscardManager *memory_region_get_ram_discard_manager(MemoryRegion *mr)
     return mr->rdm;
 }
 
-int memory_region_set_ram_discard_manager(MemoryRegion *mr,
-                                          RamDiscardManager *rdm)
+static RamDiscardManager *ram_discard_manager_new(MemoryRegion *mr,
+                                                  RamDiscardSource *rds)
+{
+    RamDiscardManager *rdm = RAM_DISCARD_MANAGER(object_new(TYPE_RAM_DISCARD_MANAGER));
+
+    rdm->rds = rds;
+    rdm->mr = mr;
+    QLIST_INIT(&rdm->rdl_list);
+    return rdm;
+}
+
+int memory_region_add_ram_discard_source(MemoryRegion *mr,
+                                         RamDiscardSource *source)
 {
     g_assert(memory_region_is_ram(mr));
-    if (mr->rdm && rdm) {
+    if (mr->rdm) {
         return -EBUSY;
     }
 
-    mr->rdm = rdm;
+    mr->rdm = ram_discard_manager_new(mr, RAM_DISCARD_SOURCE(source));
     return 0;
 }
 
+void memory_region_del_ram_discard_source(MemoryRegion *mr,
+                                          RamDiscardSource *source)
+{
+    g_assert(mr->rdm->rds == source);
+
+    object_unref(mr->rdm);
+    mr->rdm = NULL;
+}
+
+static uint64_t ram_discard_source_get_min_granularity(const RamDiscardSource *rds,
+                                                       const MemoryRegion *mr)
+{
+    RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_GET_CLASS(rds);
+
+    g_assert(rdsc->get_min_granularity);
+    return rdsc->get_min_granularity(rds, mr);
+}
+
+static bool ram_discard_source_is_populated(const RamDiscardSource *rds,
+                                            const MemoryRegionSection *section)
+{
+    RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_GET_CLASS(rds);
+
+    g_assert(rdsc->is_populated);
+    return rdsc->is_populated(rds, section);
+}
+
+static int ram_discard_source_replay_populated(const RamDiscardSource *rds,
+                                               MemoryRegionSection *section,
+                                               ReplayRamDiscardState replay_fn,
+                                               void *opaque)
+{
+    RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_GET_CLASS(rds);
+
+    g_assert(rdsc->replay_populated);
+    return rdsc->replay_populated(rds, section, replay_fn, opaque);
+}
+
+static int ram_discard_source_replay_discarded(const RamDiscardSource *rds,
+                                               MemoryRegionSection *section,
+                                               ReplayRamDiscardState replay_fn,
+                                               void *opaque)
+{
+    RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_GET_CLASS(rds);
+
+    g_assert(rdsc->replay_discarded);
+    return rdsc->replay_discarded(rds, section, replay_fn, opaque);
+}
+
 uint64_t ram_discard_manager_get_min_granularity(const RamDiscardManager *rdm,
                                                  const MemoryRegion *mr)
 {
-    RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_GET_CLASS(rdm);
-
-    g_assert(rdmc->get_min_granularity);
-    return rdmc->get_min_granularity(rdm, mr);
+    return ram_discard_source_get_min_granularity(rdm->rds, mr);
 }
 
 bool ram_discard_manager_is_populated(const RamDiscardManager *rdm,
                                       const MemoryRegionSection *section)
 {
-    RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_GET_CLASS(rdm);
-
-    g_assert(rdmc->is_populated);
-    return rdmc->is_populated(rdm, section);
+    return ram_discard_source_is_populated(rdm->rds, section);
 }
 
 int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
@@ -2077,10 +2131,7 @@ int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
                                          ReplayRamDiscardState replay_fn,
                                          void *opaque)
 {
-    RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_GET_CLASS(rdm);
-
-    g_assert(rdmc->replay_populated);
-    return rdmc->replay_populated(rdm, section, replay_fn, opaque);
+    return ram_discard_source_replay_populated(rdm->rds, section, replay_fn, opaque);
 }
 
 int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
@@ -2088,29 +2139,133 @@ int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
                                          ReplayRamDiscardState replay_fn,
                                          void *opaque)
 {
-    RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_GET_CLASS(rdm);
+    return ram_discard_source_replay_discarded(rdm->rds, section, replay_fn, opaque);
+}
+
+static void ram_discard_manager_initfn(Object *obj)
+{
+    RamDiscardManager *rdm = RAM_DISCARD_MANAGER(obj);
+
+    QLIST_INIT(&rdm->rdl_list);
+}
+
+static void ram_discard_manager_finalize(Object *obj)
+{
+    RamDiscardManager *rdm = RAM_DISCARD_MANAGER(obj);
 
-    g_assert(rdmc->replay_discarded);
-    return rdmc->replay_discarded(rdm, section, replay_fn, opaque);
+    g_assert(QLIST_EMPTY(&rdm->rdl_list));
+}
+
+int ram_discard_manager_notify_populate(RamDiscardManager *rdm,
+                                        uint64_t offset, uint64_t size)
+{
+    RamDiscardListener *rdl, *rdl2;
+    int ret = 0;
+
+    QLIST_FOREACH(rdl, &rdm->rdl_list, next) {
+        MemoryRegionSection tmp = *rdl->section;
+
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+            continue;
+        }
+        ret = rdl->notify_populate(rdl, &tmp);
+        if (ret) {
+            break;
+        }
+    }
+
+    if (ret) {
+        /* Notify all already-notified listeners about discard. */
+        QLIST_FOREACH(rdl2, &rdm->rdl_list, next) {
+            MemoryRegionSection tmp = *rdl2->section;
+
+            if (rdl2 == rdl) {
+                break;
+            }
+            if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+                continue;
+            }
+            rdl2->notify_discard(rdl2, &tmp);
+        }
+    }
+    return ret;
+}
+
+void ram_discard_manager_notify_discard(RamDiscardManager *rdm,
+                                        uint64_t offset, uint64_t size)
+{
+    RamDiscardListener *rdl;
+
+    QLIST_FOREACH(rdl, &rdm->rdl_list, next) {
+        MemoryRegionSection tmp = *rdl->section;
+
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+            continue;
+        }
+        rdl->notify_discard(rdl, &tmp);
+    }
+}
+
+void ram_discard_manager_notify_discard_all(RamDiscardManager *rdm)
+{
+    RamDiscardListener *rdl;
+
+    QLIST_FOREACH(rdl, &rdm->rdl_list, next) {
+        rdl->notify_discard(rdl, rdl->section);
+    }
+}
+
+static int rdm_populate_cb(MemoryRegionSection *section, void *opaque)
+{
+    RamDiscardListener *rdl = opaque;
+
+    return rdl->notify_populate(rdl, section);
 }
 
 void ram_discard_manager_register_listener(RamDiscardManager *rdm,
                                            RamDiscardListener *rdl,
                                            MemoryRegionSection *section)
 {
-    RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_GET_CLASS(rdm);
+    int ret;
+
+    g_assert(section->mr == rdm->mr);
+
+    rdl->section = memory_region_section_new_copy(section);
+    QLIST_INSERT_HEAD(&rdm->rdl_list, rdl, next);
 
-    g_assert(rdmc->register_listener);
-    rdmc->register_listener(rdm, rdl, section);
+    ret = ram_discard_source_replay_populated(rdm->rds, rdl->section,
+                                              rdm_populate_cb, rdl);
+    if (ret) {
+        error_report("%s: Replaying populated ranges failed: %s", __func__,
+                     strerror(-ret));
+    }
 }
 
 void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
                                              RamDiscardListener *rdl)
 {
-    RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_GET_CLASS(rdm);
+    g_assert(rdl->section);
+    g_assert(rdl->section->mr == rdm->mr);
+
+    rdl->notify_discard(rdl, rdl->section);
+    memory_region_section_free_copy(rdl->section);
+    rdl->section = NULL;
+    QLIST_REMOVE(rdl, next);
+}
+
+int ram_discard_manager_replay_populated_to_listeners(RamDiscardManager *rdm)
+{
+    RamDiscardListener *rdl;
+    int ret = 0;
 
-    g_assert(rdmc->unregister_listener);
-    rdmc->unregister_listener(rdm, rdl);
+    QLIST_FOREACH(rdl, &rdm->rdl_list, next) {
+        ret = ram_discard_source_replay_populated(rdm->rds, rdl->section,
+                                                  rdm_populate_cb, rdl);
+        if (ret) {
+            break;
+        }
+    }
+    return ret;
 }
 
 /* Called with rcu_read_lock held.  */
@@ -3743,9 +3898,17 @@ static const TypeInfo iommu_memory_region_info = {
 };
 
 static const TypeInfo ram_discard_manager_info = {
-    .parent             = TYPE_INTERFACE,
+    .parent             = TYPE_OBJECT,
     .name               = TYPE_RAM_DISCARD_MANAGER,
-    .class_size         = sizeof(RamDiscardManagerClass),
+    .instance_size      = sizeof(RamDiscardManager),
+    .instance_init      = ram_discard_manager_initfn,
+    .instance_finalize  = ram_discard_manager_finalize,
+};
+
+static const TypeInfo ram_discard_source_info = {
+    .parent             = TYPE_INTERFACE,
+    .name               = TYPE_RAM_DISCARD_SOURCE,
+    .class_size         = sizeof(RamDiscardSourceClass),
 };
 
 static void memory_register_types(void)
@@ -3753,6 +3916,7 @@ static void memory_register_types(void)
     type_register_static(&memory_region_info);
     type_register_static(&iommu_memory_region_info);
     type_register_static(&ram_discard_manager_info);
+    type_register_static(&ram_discard_source_info);
 }
 
 type_init(memory_register_types)
diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
index 630b0fda126..a72924eea7d 100644
--- a/system/ram-block-attributes.c
+++ b/system/ram-block-attributes.c
@@ -18,7 +18,7 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RamBlockAttributes,
                                           ram_block_attributes,
                                           RAM_BLOCK_ATTRIBUTES,
                                           OBJECT,
-                                          { TYPE_RAM_DISCARD_MANAGER },
+                                          { TYPE_RAM_DISCARD_SOURCE },
                                           { })
 
 static size_t
@@ -32,35 +32,9 @@ ram_block_attributes_get_block_size(void)
     return qemu_real_host_page_size();
 }
 
-
-static bool
-ram_block_attributes_rdm_is_populated(const RamDiscardManager *rdm,
-                                      const MemoryRegionSection *section)
-{
-    const RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
-    const size_t block_size = ram_block_attributes_get_block_size();
-    const uint64_t first_bit = section->offset_within_region / block_size;
-    const uint64_t last_bit =
-        first_bit + int128_get64(section->size) / block_size - 1;
-    unsigned long first_discarded_bit;
-
-    first_discarded_bit = find_next_zero_bit(attr->bitmap, last_bit + 1,
-                                           first_bit);
-    return first_discarded_bit > last_bit;
-}
-
 typedef int (*ram_block_attributes_section_cb)(MemoryRegionSection *s,
                                                void *arg);
 
-static int
-ram_block_attributes_notify_populate_cb(MemoryRegionSection *section,
-                                        void *arg)
-{
-    RamDiscardListener *rdl = arg;
-
-    return rdl->notify_populate(rdl, section);
-}
-
 static int
 ram_block_attributes_for_each_populated_section(const RamBlockAttributes *attr,
                                                 MemoryRegionSection *section,
@@ -144,93 +118,73 @@ ram_block_attributes_for_each_discarded_section(const RamBlockAttributes *attr,
     return ret;
 }
 
-static uint64_t
-ram_block_attributes_rdm_get_min_granularity(const RamDiscardManager *rdm,
-                                             const MemoryRegion *mr)
-{
-    const RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
 
-    g_assert(mr == attr->ram_block->mr);
-    return ram_block_attributes_get_block_size();
-}
+typedef struct RamBlockAttributesReplayData {
+    ReplayRamDiscardState fn;
+    void *opaque;
+} RamBlockAttributesReplayData;
 
-static void
-ram_block_attributes_rdm_register_listener(RamDiscardManager *rdm,
-                                           RamDiscardListener *rdl,
-                                           MemoryRegionSection *section)
+static int ram_block_attributes_rds_replay_cb(MemoryRegionSection *section,
+                                              void *arg)
 {
-    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
-    int ret;
-
-    g_assert(section->mr == attr->ram_block->mr);
-    rdl->section = memory_region_section_new_copy(section);
-
-    QLIST_INSERT_HEAD(&attr->rdl_list, rdl, next);
+    RamBlockAttributesReplayData *data = arg;
 
-    ret = ram_block_attributes_for_each_populated_section(attr, section, rdl,
-                                    ram_block_attributes_notify_populate_cb);
-    if (ret) {
-        error_report("%s: Failed to register RAM discard listener: %s",
-                     __func__, strerror(-ret));
-        exit(1);
-    }
+    return data->fn(section, data->opaque);
 }
 
-static void
-ram_block_attributes_rdm_unregister_listener(RamDiscardManager *rdm,
-                                             RamDiscardListener *rdl)
+/* RamDiscardSource interface implementation */
+static uint64_t
+ram_block_attributes_rds_get_min_granularity(const RamDiscardSource *rds,
+                                             const MemoryRegion *mr)
 {
-    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
+    const RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rds);
 
-    g_assert(rdl->section);
-    g_assert(rdl->section->mr == attr->ram_block->mr);
-
-    rdl->notify_discard(rdl, rdl->section);
-
-    memory_region_section_free_copy(rdl->section);
-    rdl->section = NULL;
-    QLIST_REMOVE(rdl, next);
+    g_assert(mr == attr->ram_block->mr);
+    return ram_block_attributes_get_block_size();
 }
 
-typedef struct RamBlockAttributesReplayData {
-    ReplayRamDiscardState fn;
-    void *opaque;
-} RamBlockAttributesReplayData;
-
-static int ram_block_attributes_rdm_replay_cb(MemoryRegionSection *section,
-                                              void *arg)
+static bool
+ram_block_attributes_rds_is_populated(const RamDiscardSource *rds,
+                                      const MemoryRegionSection *section)
 {
-    RamBlockAttributesReplayData *data = arg;
+    const RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rds);
+    const size_t block_size = ram_block_attributes_get_block_size();
+    const uint64_t first_bit = section->offset_within_region / block_size;
+    const uint64_t last_bit =
+        first_bit + int128_get64(section->size) / block_size - 1;
+    unsigned long first_discarded_bit;
 
-    return data->fn(section, data->opaque);
+    first_discarded_bit = find_next_zero_bit(attr->bitmap, last_bit + 1,
+                                           first_bit);
+    return first_discarded_bit > last_bit;
 }
 
 static int
-ram_block_attributes_rdm_replay_populated(const RamDiscardManager *rdm,
+ram_block_attributes_rds_replay_populated(const RamDiscardSource *rds,
                                           MemoryRegionSection *section,
                                           ReplayRamDiscardState replay_fn,
                                           void *opaque)
 {
-    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
+    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rds);
     RamBlockAttributesReplayData data = { .fn = replay_fn, .opaque = opaque };
 
     g_assert(section->mr == attr->ram_block->mr);
     return ram_block_attributes_for_each_populated_section(attr, section, &data,
-                                            ram_block_attributes_rdm_replay_cb);
+        ram_block_attributes_rds_replay_cb);
 }
 
 static int
-ram_block_attributes_rdm_replay_discarded(const RamDiscardManager *rdm,
+ram_block_attributes_rds_replay_discarded(const RamDiscardSource *rds,
                                           MemoryRegionSection *section,
                                           ReplayRamDiscardState replay_fn,
                                           void *opaque)
 {
-    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rdm);
+    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rds);
     RamBlockAttributesReplayData data = { .fn = replay_fn, .opaque = opaque };
 
     g_assert(section->mr == attr->ram_block->mr);
     return ram_block_attributes_for_each_discarded_section(attr, section, &data,
-                                            ram_block_attributes_rdm_replay_cb);
+        ram_block_attributes_rds_replay_cb);
 }
 
 static bool
@@ -257,42 +211,23 @@ ram_block_attributes_is_valid_range(RamBlockAttributes *attr, uint64_t offset,
     return true;
 }
 
-static void ram_block_attributes_notify_discard(RamBlockAttributes *attr,
-                                                uint64_t offset,
-                                                uint64_t size)
+static void
+ram_block_attributes_notify_discard(RamBlockAttributes *attr,
+                                    uint64_t offset,
+                                    uint64_t size)
 {
-    RamDiscardListener *rdl;
+    RamDiscardManager *rdm = memory_region_get_ram_discard_manager(attr->ram_block->mr);
 
-    QLIST_FOREACH(rdl, &attr->rdl_list, next) {
-        MemoryRegionSection tmp = *rdl->section;
-
-        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
-            continue;
-        }
-        rdl->notify_discard(rdl, &tmp);
-    }
+    ram_discard_manager_notify_discard(rdm, offset, size);
 }
 
 static int
 ram_block_attributes_notify_populate(RamBlockAttributes *attr,
                                      uint64_t offset, uint64_t size)
 {
-    RamDiscardListener *rdl;
-    int ret = 0;
-
-    QLIST_FOREACH(rdl, &attr->rdl_list, next) {
-        MemoryRegionSection tmp = *rdl->section;
-
-        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
-            continue;
-        }
-        ret = rdl->notify_populate(rdl, &tmp);
-        if (ret) {
-            break;
-        }
-    }
+    RamDiscardManager *rdm = memory_region_get_ram_discard_manager(attr->ram_block->mr);
 
-    return ret;
+    return ram_discard_manager_notify_populate(rdm, offset, size);
 }
 
 int ram_block_attributes_state_change(RamBlockAttributes *attr,
@@ -376,7 +311,8 @@ RamBlockAttributes *ram_block_attributes_create(RAMBlock *ram_block)
     attr = RAM_BLOCK_ATTRIBUTES(object_new(TYPE_RAM_BLOCK_ATTRIBUTES));
 
     attr->ram_block = ram_block;
-    if (memory_region_set_ram_discard_manager(mr, RAM_DISCARD_MANAGER(attr))) {
+
+    if (memory_region_add_ram_discard_source(mr, RAM_DISCARD_SOURCE(attr))) {
         object_unref(OBJECT(attr));
         return NULL;
     }
@@ -391,15 +327,12 @@ void ram_block_attributes_destroy(RamBlockAttributes *attr)
     g_assert(attr);
 
     g_free(attr->bitmap);
-    memory_region_set_ram_discard_manager(attr->ram_block->mr, NULL);
+    memory_region_del_ram_discard_source(attr->ram_block->mr, RAM_DISCARD_SOURCE(attr));
     object_unref(OBJECT(attr));
 }
 
 static void ram_block_attributes_init(Object *obj)
 {
-    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(obj);
-
-    QLIST_INIT(&attr->rdl_list);
 }
 
 static void ram_block_attributes_finalize(Object *obj)
@@ -409,12 +342,10 @@ static void ram_block_attributes_finalize(Object *obj)
 static void ram_block_attributes_class_init(ObjectClass *klass,
                                             const void *data)
 {
-    RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_CLASS(klass);
-
-    rdmc->get_min_granularity = ram_block_attributes_rdm_get_min_granularity;
-    rdmc->register_listener = ram_block_attributes_rdm_register_listener;
-    rdmc->unregister_listener = ram_block_attributes_rdm_unregister_listener;
-    rdmc->is_populated = ram_block_attributes_rdm_is_populated;
-    rdmc->replay_populated = ram_block_attributes_rdm_replay_populated;
-    rdmc->replay_discarded = ram_block_attributes_rdm_replay_discarded;
+    RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_CLASS(klass);
+
+    rdsc->get_min_granularity = ram_block_attributes_rds_get_min_granularity;
+    rdsc->is_populated = ram_block_attributes_rds_is_populated;
+    rdsc->replay_populated = ram_block_attributes_rds_replay_populated;
+    rdsc->replay_discarded = ram_block_attributes_rds_replay_discarded;
 }

-- 
2.54.0


