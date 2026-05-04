Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3313BFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 12:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJsS8-00016C-61; Mon, 04 May 2026 08:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJsRi-0000qH-8T
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:30:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJsRd-0006by-MG
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777897839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PYKJA053qYnUN8ozAMQDDu46qchgad8B32EvRqi6BDY=;
 b=L+e8mgl6WAmxkaiMK9rlFl8NPy0fjpJ5Nvs9ZdjYzHOGDyDBNYZAHhr4HqnHoKRr2gSkU0
 MJqj/PBoeQVK7C5JqGFkiPr2YYRmyoyl93etMOwwuwEAnUwo22sPyK+V3oki12pwoxYfUx
 VPFnEKphnp/ZwILoek4pJVFT/+JdbG0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-X5kE4ZJmNkO5Ui3M-A-tPg-1; Mon,
 04 May 2026 08:30:37 -0400
X-MC-Unique: X5kE4ZJmNkO5Ui3M-A-tPg-1
X-Mimecast-MFC-AGG-ID: X5kE4ZJmNkO5Ui3M-A-tPg_1777897836
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 908FA19560A1
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 12:30:36 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2FD9D1955D84; Mon,  4 May 2026 12:30:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 16:30:08 +0400
Subject: [PATCH v4 02/13] system/memory: move RamDiscardManager to separate
 compilation unit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-rdm5-v4-2-bdf61e57c1e1@redhat.com>
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
In-Reply-To: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=43668;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=zakDckneQSERbblOoRJs3br7WPNOwAwW/x+8l8m4Ibo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+JFYYvEdNS0BRDY9uRThOyMCzfXkqEGkM9PWk
 ZopXet+CiWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiRWAAKCRDa6OEJdZac
 5ZbDEACPDA8LiBCDldKDxvS2d6YDrtKboRyfBVYAOR/VEAEBwUTPFQDTu+lcBuQzY7Iycvq3DHb
 csfEVn41XCFsouOtr+pY46bNKoBXmR/zDp6lVSxefL5tpphVcjDu28uMa4Ft1tiZnYjibLI94QM
 rDlEe7CHxGJ+z1i9MC8bG3I7BkJDeaL3KGrPdPJdIW1eB+w4I9KwG/S1rxdDS9KUBozhbMzijae
 AK/p/gCD4QJblIf6xseEXJH1JnQznH+w4nWArOlWf2iq+mC5Zewy8qBvlBdKPB5GQAugpPlrVf2
 DKIrAuFFvEMw2natVaC6rJ10h7NbKWmOZPN1JUuLCrZdfddfEnUbDdrq62hLxFLUU1OmB3lnS1T
 MRq9wGt3yhy7MA3R17ZdWvOiXwyJ5pHRbQ84Cj+oDX2VUpl+33GRwuepl2rOb28/kqMBCfgfVn3
 Iryfam/Q5DiVfEq79WWJdPLImZydmdPclcX7NX1smzg8RlcYny1PPFdBxPfapxNYOeb2DBvt2IK
 kCgQLNFDZMAlAnd/ItHlwI/hryWZ7bMscMSZ3HsDd7jv6JRpBjYphOSX5gQ2qcMJpHOcEoL5CQ2
 Emo11tFN8AWr0gIgmM2wdzdL+puAwqP7Ps/62wQdXXus7HQI3rxfXdqUqHYAjmvxCzCurderTNl
 QlDT7+DaPqIZEEw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Extract RamDiscardManager and RamDiscardSource from system/memory.c into
dedicated a unit.

This reduces coupling and allows code that only needs the
RamDiscardManager interface to avoid pulling in all of memory.h
dependencies.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS                          |   2 +
 include/system/memory.h              | 280 +--------------------------------
 include/system/ram-discard-manager.h | 297 +++++++++++++++++++++++++++++++++++
 system/memory.c                      | 221 --------------------------
 system/ram-discard-manager.c         | 240 ++++++++++++++++++++++++++++
 rust/bindings/system-sys/lib.rs      |   2 +-
 system/meson.build                   |   1 +
 7 files changed, 542 insertions(+), 501 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index afa178c5cce..239218bc1f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3315,6 +3315,7 @@ F: include/system/memory.h
 F: include/system/memory_cached.h
 F: include/system/memory_ldst*
 F: include/system/physmem.h
+F: include/system/ram-discard-manager.h
 F: include/system/ramblock.h
 F: include/system/memory_mapping.h
 F: system/dma-helpers.c
@@ -3325,6 +3326,7 @@ F: system/physmem.c
 F: system/memory_ldst*
 F: system/memory-internal.h
 F: system/ram-block-attributes.c
+F: system/ram-discard-manager.c
 F: scripts/coccinelle/memory-region-housekeeping.cocci
 
 Memory devices
diff --git a/include/system/memory.h b/include/system/memory.h
index a37d320293a..28a75dac4ae 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -16,6 +16,7 @@
 
 #include "exec/hwaddr.h"
 #include "system/ram_addr.h"
+#include "system/ram-discard-manager.h"
 #include "exec/memattrs.h"
 #include "exec/memop.h"
 #include "qemu/bswap.h"
@@ -48,18 +49,6 @@ typedef struct IOMMUMemoryRegionClass IOMMUMemoryRegionClass;
 DECLARE_OBJ_CHECKERS(IOMMUMemoryRegion, IOMMUMemoryRegionClass,
                      IOMMU_MEMORY_REGION, TYPE_IOMMU_MEMORY_REGION)
 
-#define TYPE_RAM_DISCARD_MANAGER "ram-discard-manager"
-typedef struct RamDiscardManagerClass RamDiscardManagerClass;
-typedef struct RamDiscardManager RamDiscardManager;
-DECLARE_OBJ_CHECKERS(RamDiscardManager, RamDiscardManagerClass,
-                     RAM_DISCARD_MANAGER, TYPE_RAM_DISCARD_MANAGER);
-
-#define TYPE_RAM_DISCARD_SOURCE "ram-discard-source"
-typedef struct RamDiscardSourceClass RamDiscardSourceClass;
-typedef struct RamDiscardSource RamDiscardSource;
-DECLARE_OBJ_CHECKERS(RamDiscardSource, RamDiscardSourceClass,
-                     RAM_DISCARD_SOURCE, TYPE_RAM_DISCARD_SOURCE);
-
 #ifdef CONFIG_FUZZ
 void fuzz_dma_read_cb(size_t addr,
                       size_t len,
@@ -548,273 +537,6 @@ struct IOMMUMemoryRegionClass {
     int (*num_indexes)(IOMMUMemoryRegion *iommu);
 };
 
-typedef struct RamDiscardListener RamDiscardListener;
-typedef int (*NotifyRamPopulate)(RamDiscardListener *rdl,
-                                 MemoryRegionSection *section);
-typedef void (*NotifyRamDiscard)(RamDiscardListener *rdl,
-                                 MemoryRegionSection *section);
-
-struct RamDiscardListener {
-    /*
-     * @notify_populate:
-     *
-     * Notification that previously discarded memory is about to get populated.
-     * Listeners are able to object. If any listener objects, already
-     * successfully notified listeners are notified about a discard again.
-     *
-     * @rdl: the #RamDiscardListener getting notified
-     * @section: the #MemoryRegionSection to get populated. The section
-     *           is aligned within the memory region to the minimum granularity
-     *           unless it would exceed the registered section.
-     *
-     * Returns 0 on success. If the notification is rejected by the listener,
-     * an error is returned.
-     */
-    NotifyRamPopulate notify_populate;
-
-    /*
-     * @notify_discard:
-     *
-     * Notification that previously populated memory was discarded successfully
-     * and listeners should drop all references to such memory and prevent
-     * new population (e.g., unmap).
-     *
-     * @rdl: the #RamDiscardListener getting notified
-     * @section: the #MemoryRegionSection to get discarded. The section
-     *           is aligned within the memory region to the minimum granularity
-     *           unless it would exceed the registered section.
-     */
-    NotifyRamDiscard notify_discard;
-
-    MemoryRegionSection *section;
-    QLIST_ENTRY(RamDiscardListener) next;
-};
-
-static inline void ram_discard_listener_init(RamDiscardListener *rdl,
-                                             NotifyRamPopulate populate_fn,
-                                             NotifyRamDiscard discard_fn)
-{
-    rdl->notify_populate = populate_fn;
-    rdl->notify_discard = discard_fn;
-}
-
-/**
- * typedef ReplayRamDiscardState:
- *
- * The callback handler for #RamDiscardSourceClass.replay_populated/
- * #RamDiscardSourceClass.replay_discarded to invoke on populated/discarded
- * parts.
- *
- * @section: the #MemoryRegionSection of populated/discarded part
- * @opaque: pointer to forward to the callback
- *
- * Returns 0 on success, or a negative error if failed.
- */
-typedef int (*ReplayRamDiscardState)(MemoryRegionSection *section,
-                                     void *opaque);
-
-/*
- * RamDiscardSourceClass:
- *
- * A #RamDiscardSource provides information about which parts of a specific
- * RAM #MemoryRegion are currently populated (accessible) vs discarded.
- *
- * This is an interface that state providers (like virtio-mem or
- * RamBlockAttributes) implement to provide discard state information. A
- * #RamDiscardManager wraps sources and manages listener registrations and
- * notifications.
- */
-struct RamDiscardSourceClass {
-    /* private */
-    InterfaceClass parent_class;
-
-    /* public */
-
-    /**
-     * @get_min_granularity:
-     *
-     * Get the minimum granularity in which listeners will get notified
-     * about changes within the #MemoryRegion via the #RamDiscardSource.
-     *
-     * @rds: the #RamDiscardSource
-     * @mr: the #MemoryRegion
-     *
-     * Returns the minimum granularity.
-     */
-    uint64_t (*get_min_granularity)(const RamDiscardSource *rds,
-                                    const MemoryRegion *mr);
-
-    /**
-     * @is_populated:
-     *
-     * Check whether the given #MemoryRegionSection is completely populated
-     * (i.e., no parts are currently discarded) via the #RamDiscardSource.
-     * There are no alignment requirements.
-     *
-     * @rds: the #RamDiscardSource
-     * @section: the #MemoryRegionSection
-     *
-     * Returns whether the given range is completely populated.
-     */
-    bool (*is_populated)(const RamDiscardSource *rds,
-                         const MemoryRegionSection *section);
-
-    /**
-     * @replay_populated:
-     *
-     * Call the #ReplayRamDiscardState callback for all populated parts within
-     * the #MemoryRegionSection via the #RamDiscardSource.
-     *
-     * In case any call fails, no further calls are made.
-     *
-     * @rds: the #RamDiscardSource
-     * @section: the #MemoryRegionSection
-     * @replay_fn: the #ReplayRamDiscardState callback
-     * @opaque: pointer to forward to the callback
-     *
-     * Returns 0 on success, or a negative error if any notification failed.
-     */
-    int (*replay_populated)(const RamDiscardSource *rds,
-                            MemoryRegionSection *section,
-                            ReplayRamDiscardState replay_fn, void *opaque);
-
-    /**
-     * @replay_discarded:
-     *
-     * Call the #ReplayRamDiscardState callback for all discarded parts within
-     * the #MemoryRegionSection via the #RamDiscardSource.
-     *
-     * @rds: the #RamDiscardSource
-     * @section: the #MemoryRegionSection
-     * @replay_fn: the #ReplayRamDiscardState callback
-     * @opaque: pointer to forward to the callback
-     *
-     * Returns 0 on success, or a negative error if any notification failed.
-     */
-    int (*replay_discarded)(const RamDiscardSource *rds,
-                            MemoryRegionSection *section,
-                            ReplayRamDiscardState replay_fn, void *opaque);
-};
-
-/**
- * RamDiscardManager:
- *
- * A #RamDiscardManager coordinates which parts of specific RAM #MemoryRegion
- * regions are currently populated to be used/accessed by the VM, notifying
- * after parts were discarded (freeing up memory) and before parts will be
- * populated (consuming memory), to be used/accessed by the VM.
- *
- * A #RamDiscardManager can only be set for a RAM #MemoryRegion while the
- * #MemoryRegion isn't mapped into an address space yet (either directly
- * or via an alias); it cannot change while the #MemoryRegion is
- * mapped into an address space.
- *
- * The #RamDiscardManager is intended to be used by technologies that are
- * incompatible with discarding of RAM (e.g., VFIO, which may pin all
- * memory inside a #MemoryRegion), and require proper coordination to only
- * map the currently populated parts, to hinder parts that are expected to
- * remain discarded from silently getting populated and consuming memory.
- * Technologies that support discarding of RAM don't have to bother and can
- * simply map the whole #MemoryRegion.
- *
- * An example #RamDiscardSource is virtio-mem, which logically (un)plugs
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
- */
-struct RamDiscardManager {
-    Object parent;
-
-    RamDiscardSource *rds;
-    MemoryRegion *mr;
-    QLIST_HEAD(, RamDiscardListener) rdl_list;
-};
-
-uint64_t ram_discard_manager_get_min_granularity(const RamDiscardManager *rdm,
-                                                 const MemoryRegion *mr);
-
-bool ram_discard_manager_is_populated(const RamDiscardManager *rdm,
-                                      const MemoryRegionSection *section);
-
-/**
- * ram_discard_manager_replay_populated:
- *
- * A wrapper to call the #RamDiscardSourceClass.replay_populated callback
- * of the #RamDiscardSource sources.
- *
- * @rdm: the #RamDiscardManager
- * @section: the #MemoryRegionSection
- * @replay_fn: the #ReplayRamDiscardState callback
- * @opaque: pointer to forward to the callback
- *
- * Returns 0 on success, or a negative error if any notification failed.
- */
-int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
-                                         MemoryRegionSection *section,
-                                         ReplayRamDiscardState replay_fn,
-                                         void *opaque);
-
-/**
- * ram_discard_manager_replay_discarded:
- *
- * A wrapper to call the #RamDiscardSourceClass.replay_discarded callback
- * of the #RamDiscardSource sources.
- *
- * @rdm: the #RamDiscardManager
- * @section: the #MemoryRegionSection
- * @replay_fn: the #ReplayRamDiscardState callback
- * @opaque: pointer to forward to the callback
- *
- * Returns 0 on success, or a negative error if any notification failed.
- */
-int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
-                                         MemoryRegionSection *section,
-                                         ReplayRamDiscardState replay_fn,
-                                         void *opaque);
-
-void ram_discard_manager_register_listener(RamDiscardManager *rdm,
-                                           RamDiscardListener *rdl,
-                                           MemoryRegionSection *section);
-
-void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
-                                             RamDiscardListener *rdl);
-
-/*
- * Note: later refactoring should take the source into account and the manager
- *       should be able to aggregate multiple sources.
- */
-int ram_discard_manager_notify_populate(RamDiscardManager *rdm,
-                                        uint64_t offset, uint64_t size);
-
- /*
-  * Note: later refactoring should take the source into account and the manager
-  *       should be able to aggregate multiple sources.
-  */
-void ram_discard_manager_notify_discard(RamDiscardManager *rdm,
-                                        uint64_t offset, uint64_t size);
-
-/*
- * Note: later refactoring should take the source into account and the manager
- *       should be able to aggregate multiple sources.
- */
-void ram_discard_manager_notify_discard_all(RamDiscardManager *rdm);
-
-/*
- * Replay populated sections to all registered listeners.
- *
- * Note: later refactoring should take the source into account and the manager
- *       should be able to aggregate multiple sources.
- */
-int ram_discard_manager_replay_populated_to_listeners(RamDiscardManager *rdm);
-
 /**
  * memory_translate_iotlb: Extract addresses from a TLB entry.
  *                         Called with rcu_read_lock held.
diff --git a/include/system/ram-discard-manager.h b/include/system/ram-discard-manager.h
new file mode 100644
index 00000000000..da55658169f
--- /dev/null
+++ b/include/system/ram-discard-manager.h
@@ -0,0 +1,297 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * RAM Discard Manager
+ *
+ * Copyright Red Hat, Inc. 2026
+ */
+
+#ifndef RAM_DISCARD_MANAGER_H
+#define RAM_DISCARD_MANAGER_H
+
+#include "qemu/typedefs.h"
+#include "qom/object.h"
+#include "qemu/queue.h"
+
+#define TYPE_RAM_DISCARD_MANAGER "ram-discard-manager"
+typedef struct RamDiscardManagerClass RamDiscardManagerClass;
+typedef struct RamDiscardManager RamDiscardManager;
+DECLARE_OBJ_CHECKERS(RamDiscardManager, RamDiscardManagerClass,
+                     RAM_DISCARD_MANAGER, TYPE_RAM_DISCARD_MANAGER);
+
+#define TYPE_RAM_DISCARD_SOURCE "ram-discard-source"
+typedef struct RamDiscardSourceClass RamDiscardSourceClass;
+typedef struct RamDiscardSource RamDiscardSource;
+DECLARE_OBJ_CHECKERS(RamDiscardSource, RamDiscardSourceClass,
+                     RAM_DISCARD_SOURCE, TYPE_RAM_DISCARD_SOURCE);
+
+typedef struct RamDiscardListener RamDiscardListener;
+typedef int (*NotifyRamPopulate)(RamDiscardListener *rdl,
+                                 MemoryRegionSection *section);
+typedef void (*NotifyRamDiscard)(RamDiscardListener *rdl,
+                                 MemoryRegionSection *section);
+
+struct RamDiscardListener {
+    /*
+     * @notify_populate:
+     *
+     * Notification that previously discarded memory is about to get populated.
+     * Listeners are able to object. If any listener objects, already
+     * successfully notified listeners are notified about a discard again.
+     *
+     * @rdl: the #RamDiscardListener getting notified
+     * @section: the #MemoryRegionSection to get populated. The section
+     *           is aligned within the memory region to the minimum granularity
+     *           unless it would exceed the registered section.
+     *
+     * Returns 0 on success. If the notification is rejected by the listener,
+     * an error is returned.
+     */
+    NotifyRamPopulate notify_populate;
+
+    /*
+     * @notify_discard:
+     *
+     * Notification that previously populated memory was discarded successfully
+     * and listeners should drop all references to such memory and prevent
+     * new population (e.g., unmap).
+     *
+     * @rdl: the #RamDiscardListener getting notified
+     * @section: the #MemoryRegionSection to get discarded. The section
+     *           is aligned within the memory region to the minimum granularity
+     *           unless it would exceed the registered section.
+     */
+    NotifyRamDiscard notify_discard;
+
+    MemoryRegionSection *section;
+    QLIST_ENTRY(RamDiscardListener) next;
+};
+
+static inline void ram_discard_listener_init(RamDiscardListener *rdl,
+                                             NotifyRamPopulate populate_fn,
+                                             NotifyRamDiscard discard_fn)
+{
+    rdl->notify_populate = populate_fn;
+    rdl->notify_discard = discard_fn;
+}
+
+/**
+ * typedef ReplayRamDiscardState:
+ *
+ * The callback handler for #RamDiscardSourceClass.replay_populated/
+ * #RamDiscardSourceClass.replay_discarded to invoke on populated/discarded
+ * parts.
+ *
+ * @section: the #MemoryRegionSection of populated/discarded part
+ * @opaque: pointer to forward to the callback
+ *
+ * Returns 0 on success, or a negative error if failed.
+ */
+typedef int (*ReplayRamDiscardState)(MemoryRegionSection *section,
+                                     void *opaque);
+
+/*
+ * RamDiscardSourceClass:
+ *
+ * A #RamDiscardSource provides information about which parts of a specific
+ * RAM #MemoryRegion are currently populated (accessible) vs discarded.
+ *
+ * This is an interface that state providers (like virtio-mem or
+ * RamBlockAttributes) implement to provide discard state information. A
+ * #RamDiscardManager wraps sources and manages listener registrations and
+ * notifications.
+ */
+struct RamDiscardSourceClass {
+    /* private */
+    InterfaceClass parent_class;
+
+    /* public */
+
+    /**
+     * @get_min_granularity:
+     *
+     * Get the minimum granularity in which listeners will get notified
+     * about changes within the #MemoryRegion via the #RamDiscardSource.
+     *
+     * @rds: the #RamDiscardSource
+     * @mr: the #MemoryRegion
+     *
+     * Returns the minimum granularity.
+     */
+    uint64_t (*get_min_granularity)(const RamDiscardSource *rds,
+                                    const MemoryRegion *mr);
+
+    /**
+     * @is_populated:
+     *
+     * Check whether the given #MemoryRegionSection is completely populated
+     * (i.e., no parts are currently discarded) via the #RamDiscardSource.
+     * There are no alignment requirements.
+     *
+     * @rds: the #RamDiscardSource
+     * @section: the #MemoryRegionSection
+     *
+     * Returns whether the given range is completely populated.
+     */
+    bool (*is_populated)(const RamDiscardSource *rds,
+                         const MemoryRegionSection *section);
+
+    /**
+     * @replay_populated:
+     *
+     * Call the #ReplayRamDiscardState callback for all populated parts within
+     * the #MemoryRegionSection via the #RamDiscardSource.
+     *
+     * In case any call fails, no further calls are made.
+     *
+     * @rds: the #RamDiscardSource
+     * @section: the #MemoryRegionSection
+     * @replay_fn: the #ReplayRamDiscardState callback
+     * @opaque: pointer to forward to the callback
+     *
+     * Returns 0 on success, or a negative error if any notification failed.
+     */
+    int (*replay_populated)(const RamDiscardSource *rds,
+                            MemoryRegionSection *section,
+                            ReplayRamDiscardState replay_fn, void *opaque);
+
+    /**
+     * @replay_discarded:
+     *
+     * Call the #ReplayRamDiscardState callback for all discarded parts within
+     * the #MemoryRegionSection via the #RamDiscardSource.
+     *
+     * @rds: the #RamDiscardSource
+     * @section: the #MemoryRegionSection
+     * @replay_fn: the #ReplayRamDiscardState callback
+     * @opaque: pointer to forward to the callback
+     *
+     * Returns 0 on success, or a negative error if any notification failed.
+     */
+    int (*replay_discarded)(const RamDiscardSource *rds,
+                            MemoryRegionSection *section,
+                            ReplayRamDiscardState replay_fn, void *opaque);
+};
+
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
+
+    RamDiscardSource *rds;
+    MemoryRegion *mr;
+    QLIST_HEAD(, RamDiscardListener) rdl_list;
+};
+
+RamDiscardManager *ram_discard_manager_new(MemoryRegion *mr,
+                                           RamDiscardSource *rds);
+
+uint64_t ram_discard_manager_get_min_granularity(const RamDiscardManager *rdm,
+                                                 const MemoryRegion *mr);
+
+bool ram_discard_manager_is_populated(const RamDiscardManager *rdm,
+                                      const MemoryRegionSection *section);
+
+/**
+ * ram_discard_manager_replay_populated:
+ *
+ * A wrapper to call the #RamDiscardSourceClass.replay_populated callback
+ * of the #RamDiscardSource sources.
+ *
+ * @rdm: the #RamDiscardManager
+ * @section: the #MemoryRegionSection
+ * @replay_fn: the #ReplayRamDiscardState callback
+ * @opaque: pointer to forward to the callback
+ *
+ * Returns 0 on success, or a negative error if any notification failed.
+ */
+int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
+                                         MemoryRegionSection *section,
+                                         ReplayRamDiscardState replay_fn,
+                                         void *opaque);
+
+/**
+ * ram_discard_manager_replay_discarded:
+ *
+ * A wrapper to call the #RamDiscardSourceClass.replay_discarded callback
+ * of the #RamDiscardSource sources.
+ *
+ * @rdm: the #RamDiscardManager
+ * @section: the #MemoryRegionSection
+ * @replay_fn: the #ReplayRamDiscardState callback
+ * @opaque: pointer to forward to the callback
+ *
+ * Returns 0 on success, or a negative error if any notification failed.
+ */
+int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
+                                         MemoryRegionSection *section,
+                                         ReplayRamDiscardState replay_fn,
+                                         void *opaque);
+
+void ram_discard_manager_register_listener(RamDiscardManager *rdm,
+                                           RamDiscardListener *rdl,
+                                           MemoryRegionSection *section);
+
+void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
+                                             RamDiscardListener *rdl);
+
+/*
+ * Note: later refactoring should take the source into account and the manager
+ *       should be able to aggregate multiple sources.
+ */
+int ram_discard_manager_notify_populate(RamDiscardManager *rdm,
+                                        uint64_t offset, uint64_t size);
+
+/*
+ * Note: later refactoring should take the source into account and the manager
+ *       should be able to aggregate multiple sources.
+ */
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
+#endif /* RAM_DISCARD_MANAGER_H */
diff --git a/system/memory.c b/system/memory.c
index 77966513113..97695a253e6 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2042,17 +2042,6 @@ RamDiscardManager *memory_region_get_ram_discard_manager(MemoryRegion *mr)
     return mr->rdm;
 }
 
-static RamDiscardManager *ram_discard_manager_new(MemoryRegion *mr,
-                                                  RamDiscardSource *rds)
-{
-    RamDiscardManager *rdm = RAM_DISCARD_MANAGER(object_new(TYPE_RAM_DISCARD_MANAGER));
-
-    rdm->rds = rds;
-    rdm->mr = mr;
-    QLIST_INIT(&rdm->rdl_list);
-    return rdm;
-}
-
 int memory_region_add_ram_discard_source(MemoryRegion *mr,
                                          RamDiscardSource *source)
 {
@@ -2074,200 +2063,6 @@ void memory_region_del_ram_discard_source(MemoryRegion *mr,
     mr->rdm = NULL;
 }
 
-static uint64_t ram_discard_source_get_min_granularity(const RamDiscardSource *rds,
-                                                       const MemoryRegion *mr)
-{
-    RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_GET_CLASS(rds);
-
-    g_assert(rdsc->get_min_granularity);
-    return rdsc->get_min_granularity(rds, mr);
-}
-
-static bool ram_discard_source_is_populated(const RamDiscardSource *rds,
-                                            const MemoryRegionSection *section)
-{
-    RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_GET_CLASS(rds);
-
-    g_assert(rdsc->is_populated);
-    return rdsc->is_populated(rds, section);
-}
-
-static int ram_discard_source_replay_populated(const RamDiscardSource *rds,
-                                               MemoryRegionSection *section,
-                                               ReplayRamDiscardState replay_fn,
-                                               void *opaque)
-{
-    RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_GET_CLASS(rds);
-
-    g_assert(rdsc->replay_populated);
-    return rdsc->replay_populated(rds, section, replay_fn, opaque);
-}
-
-static int ram_discard_source_replay_discarded(const RamDiscardSource *rds,
-                                               MemoryRegionSection *section,
-                                               ReplayRamDiscardState replay_fn,
-                                               void *opaque)
-{
-    RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_GET_CLASS(rds);
-
-    g_assert(rdsc->replay_discarded);
-    return rdsc->replay_discarded(rds, section, replay_fn, opaque);
-}
-
-uint64_t ram_discard_manager_get_min_granularity(const RamDiscardManager *rdm,
-                                                 const MemoryRegion *mr)
-{
-    return ram_discard_source_get_min_granularity(rdm->rds, mr);
-}
-
-bool ram_discard_manager_is_populated(const RamDiscardManager *rdm,
-                                      const MemoryRegionSection *section)
-{
-    return ram_discard_source_is_populated(rdm->rds, section);
-}
-
-int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
-                                         MemoryRegionSection *section,
-                                         ReplayRamDiscardState replay_fn,
-                                         void *opaque)
-{
-    return ram_discard_source_replay_populated(rdm->rds, section, replay_fn, opaque);
-}
-
-int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
-                                         MemoryRegionSection *section,
-                                         ReplayRamDiscardState replay_fn,
-                                         void *opaque)
-{
-    return ram_discard_source_replay_discarded(rdm->rds, section, replay_fn, opaque);
-}
-
-static void ram_discard_manager_initfn(Object *obj)
-{
-    RamDiscardManager *rdm = RAM_DISCARD_MANAGER(obj);
-
-    QLIST_INIT(&rdm->rdl_list);
-}
-
-static void ram_discard_manager_finalize(Object *obj)
-{
-    RamDiscardManager *rdm = RAM_DISCARD_MANAGER(obj);
-
-    g_assert(QLIST_EMPTY(&rdm->rdl_list));
-}
-
-int ram_discard_manager_notify_populate(RamDiscardManager *rdm,
-                                        uint64_t offset, uint64_t size)
-{
-    RamDiscardListener *rdl, *rdl2;
-    int ret = 0;
-
-    QLIST_FOREACH(rdl, &rdm->rdl_list, next) {
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
-
-    if (ret) {
-        /* Notify all already-notified listeners about discard. */
-        QLIST_FOREACH(rdl2, &rdm->rdl_list, next) {
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
-}
-
-void ram_discard_manager_notify_discard(RamDiscardManager *rdm,
-                                        uint64_t offset, uint64_t size)
-{
-    RamDiscardListener *rdl;
-
-    QLIST_FOREACH(rdl, &rdm->rdl_list, next) {
-        MemoryRegionSection tmp = *rdl->section;
-
-        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
-            continue;
-        }
-        rdl->notify_discard(rdl, &tmp);
-    }
-}
-
-void ram_discard_manager_notify_discard_all(RamDiscardManager *rdm)
-{
-    RamDiscardListener *rdl;
-
-    QLIST_FOREACH(rdl, &rdm->rdl_list, next) {
-        rdl->notify_discard(rdl, rdl->section);
-    }
-}
-
-static int rdm_populate_cb(MemoryRegionSection *section, void *opaque)
-{
-    RamDiscardListener *rdl = opaque;
-
-    return rdl->notify_populate(rdl, section);
-}
-
-void ram_discard_manager_register_listener(RamDiscardManager *rdm,
-                                           RamDiscardListener *rdl,
-                                           MemoryRegionSection *section)
-{
-    int ret;
-
-    g_assert(section->mr == rdm->mr);
-
-    rdl->section = memory_region_section_new_copy(section);
-    QLIST_INSERT_HEAD(&rdm->rdl_list, rdl, next);
-
-    ret = ram_discard_source_replay_populated(rdm->rds, rdl->section,
-                                              rdm_populate_cb, rdl);
-    if (ret) {
-        error_report("%s: Replaying populated ranges failed: %s", __func__,
-                     strerror(-ret));
-    }
-}
-
-void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
-                                             RamDiscardListener *rdl)
-{
-    g_assert(rdl->section);
-    g_assert(rdl->section->mr == rdm->mr);
-
-    rdl->notify_discard(rdl, rdl->section);
-    memory_region_section_free_copy(rdl->section);
-    rdl->section = NULL;
-    QLIST_REMOVE(rdl, next);
-}
-
-int ram_discard_manager_replay_populated_to_listeners(RamDiscardManager *rdm)
-{
-    RamDiscardListener *rdl;
-    int ret = 0;
-
-    QLIST_FOREACH(rdl, &rdm->rdl_list, next) {
-        ret = ram_discard_source_replay_populated(rdm->rds, rdl->section,
-                                                  rdm_populate_cb, rdl);
-        if (ret) {
-            break;
-        }
-    }
-    return ret;
-}
-
 /* Called with rcu_read_lock held.  */
 MemoryRegion *memory_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
                                      Error **errp)
@@ -3897,26 +3692,10 @@ static const TypeInfo iommu_memory_region_info = {
     .abstract           = true,
 };
 
-static const TypeInfo ram_discard_manager_info = {
-    .parent             = TYPE_OBJECT,
-    .name               = TYPE_RAM_DISCARD_MANAGER,
-    .instance_size      = sizeof(RamDiscardManager),
-    .instance_init      = ram_discard_manager_initfn,
-    .instance_finalize  = ram_discard_manager_finalize,
-};
-
-static const TypeInfo ram_discard_source_info = {
-    .parent             = TYPE_INTERFACE,
-    .name               = TYPE_RAM_DISCARD_SOURCE,
-    .class_size         = sizeof(RamDiscardSourceClass),
-};
-
 static void memory_register_types(void)
 {
     type_register_static(&memory_region_info);
     type_register_static(&iommu_memory_region_info);
-    type_register_static(&ram_discard_manager_info);
-    type_register_static(&ram_discard_source_info);
 }
 
 type_init(memory_register_types)
diff --git a/system/ram-discard-manager.c b/system/ram-discard-manager.c
new file mode 100644
index 00000000000..3d8c85617d7
--- /dev/null
+++ b/system/ram-discard-manager.c
@@ -0,0 +1,240 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * RAM Discard Manager
+ *
+ * Copyright Red Hat, Inc. 2026
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "system/memory.h"
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
+RamDiscardManager *ram_discard_manager_new(MemoryRegion *mr,
+                                           RamDiscardSource *rds)
+{
+    RamDiscardManager *rdm;
+
+    rdm = RAM_DISCARD_MANAGER(object_new(TYPE_RAM_DISCARD_MANAGER));
+    rdm->rds = rds;
+    rdm->mr = mr;
+    QLIST_INIT(&rdm->rdl_list);
+    return rdm;
+}
+
+uint64_t ram_discard_manager_get_min_granularity(const RamDiscardManager *rdm,
+                                                 const MemoryRegion *mr)
+{
+    return ram_discard_source_get_min_granularity(rdm->rds, mr);
+}
+
+bool ram_discard_manager_is_populated(const RamDiscardManager *rdm,
+                                      const MemoryRegionSection *section)
+{
+    return ram_discard_source_is_populated(rdm->rds, section);
+}
+
+int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
+                                         MemoryRegionSection *section,
+                                         ReplayRamDiscardState replay_fn,
+                                         void *opaque)
+{
+    return ram_discard_source_replay_populated(rdm->rds, section,
+                                               replay_fn, opaque);
+}
+
+int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
+                                         MemoryRegionSection *section,
+                                         ReplayRamDiscardState replay_fn,
+                                         void *opaque)
+{
+    return ram_discard_source_replay_discarded(rdm->rds, section,
+                                               replay_fn, opaque);
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
+
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
+}
+
+void ram_discard_manager_register_listener(RamDiscardManager *rdm,
+                                           RamDiscardListener *rdl,
+                                           MemoryRegionSection *section)
+{
+    int ret;
+
+    g_assert(section->mr == rdm->mr);
+
+    rdl->section = memory_region_section_new_copy(section);
+    QLIST_INSERT_HEAD(&rdm->rdl_list, rdl, next);
+
+    ret = ram_discard_source_replay_populated(rdm->rds, rdl->section,
+                                              rdm_populate_cb, rdl);
+    if (ret) {
+        error_report("%s: Replaying populated ranges failed: %s", __func__,
+                     strerror(-ret));
+    }
+}
+
+void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
+                                             RamDiscardListener *rdl)
+{
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
+
+    QLIST_FOREACH(rdl, &rdm->rdl_list, next) {
+        ret = ram_discard_source_replay_populated(rdm->rds, rdl->section,
+                                                  rdm_populate_cb, rdl);
+        if (ret) {
+            break;
+        }
+    }
+    return ret;
+}
+
+static const TypeInfo ram_discard_manager_info = {
+    .parent             = TYPE_OBJECT,
+    .name               = TYPE_RAM_DISCARD_MANAGER,
+    .instance_size      = sizeof(RamDiscardManager),
+    .instance_init      = ram_discard_manager_initfn,
+    .instance_finalize  = ram_discard_manager_finalize,
+};
+
+static const TypeInfo ram_discard_source_info = {
+    .parent             = TYPE_INTERFACE,
+    .name               = TYPE_RAM_DISCARD_SOURCE,
+    .class_size         = sizeof(RamDiscardSourceClass),
+};
+
+static void ram_discard_manager_register_types(void)
+{
+    type_register_static(&ram_discard_manager_info);
+    type_register_static(&ram_discard_source_info);
+}
+
+type_init(ram_discard_manager_register_types)
diff --git a/rust/bindings/system-sys/lib.rs b/rust/bindings/system-sys/lib.rs
index 022fe65dd83..30adf683c35 100644
--- a/rust/bindings/system-sys/lib.rs
+++ b/rust/bindings/system-sys/lib.rs
@@ -20,7 +20,7 @@
 
 use common::Zeroable;
 use hwcore_sys::{qemu_irq, DeviceClass, DeviceState};
-use qom_sys::{InterfaceClass, Object, ObjectClass};
+use qom_sys::{Object, ObjectClass};
 use util_sys::{Error, EventNotifier, QEMUBH};
 
 #[cfg(MESON)]
diff --git a/system/meson.build b/system/meson.build
index 9cdfe1b3e75..cd3193d170b 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -14,6 +14,7 @@ system_ss.add(files(
   'globals.c',
   'ioport.c',
   'ram-block-attributes.c',
+  'ram-discard-manager.c',
   'memory_mapping.c',
   'memory.c',
   'physmem.c',

-- 
2.54.0


