Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEBBCD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0YY-0004YM-MU; Tue, 23 Jun 2026 08:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YW-0004XO-St
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YO-00070i-B8
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782218915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=26GxW006B57Bmz6auGLFgrKG9QR6nM+fizoWVeQSqnA=;
 b=ETj8XbliZuS7vwfS7XaH2pxTVgiK/kY2DojV0ik2EDPD5pCJG5Zvy9QOyK0kXAluPj6fwQ
 pP8OxxJWUy2ytXmqOAHl66KNZ+1aHArD2OY2HwYFJxtlAAtcSkbquj3V/yhVAK5B2VVVpA
 063KGvjZSE5ABH/SsrIP2Q9nc718WqQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-JMqoi_1hP9WNqfZCMmPkXQ-1; Tue, 23 Jun 2026 08:48:34 -0400
X-MC-Unique: JMqoi_1hP9WNqfZCMmPkXQ-1
X-Mimecast-MFC-AGG-ID: JMqoi_1hP9WNqfZCMmPkXQ_1782218914
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5178aed25baso104500231cf.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 05:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782218914; x=1782823714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26GxW006B57Bmz6auGLFgrKG9QR6nM+fizoWVeQSqnA=;
 b=eGs7MBPPo2BN/w49ZdyEGz2Y9k5QldByBGVzYWuBGpIjBPfFnp1BZD3vUygTEGnRLD
 hLh3rrVBwn/anAy2I3bA+UHAZKIauQICA3XiFekASs+gqoJ/JF8VTVN8KfU9oYArSkin
 kvFQwzCjsx3CeXIvGcXVkUaMgZOWL1qcifOcqr11tkmtrZF6AYyddvU23DnGpMSkFAWd
 a+KQPWerYqhXkdU5DI9gPH6WYxv2XPm82q13FW6lP/uAJ2LqTSYSuYRtabXoIpqNr/Wp
 2w9tj5riBcuVMenDbx8UWfccCC6FbXCds9tOMZM4R4H0C6N/vaYU6EC+JHGrF7msvrnw
 ssug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782218914; x=1782823714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=26GxW006B57Bmz6auGLFgrKG9QR6nM+fizoWVeQSqnA=;
 b=KQRrkiWNzBrSKdToTfIIP5Byxi3iabKleWebcOymNxf4MMQvlp4U+iMsNLiTCsSlFE
 uOpvRd5aht+MWzoct+wLd8mUHChCloOhGg13QLs5ph2DJQ97AtqqBovaMlygg59MZK3j
 tyMbxaecsPzyuJJ4GCPmY+3so521pJKXG03laif8gJ6Dql/TzBOoADo4IVDNq39kL/zW
 iiZqpZhjbtLBaMworcOpXQtVT1x4D3qIgVM1Ro5PR48rvoq3ZdFhF1kbaTBmy7CJsY1w
 pj6GANCR/r98m7r2JXHoxhup5EvRcsRKHT3tSsrXDzFmGt4pwAYUUVeFYePza2o0sCdc
 N3cQ==
X-Gm-Message-State: AOJu0YxsiqOHFg4n0nfbxuEhlP+bag4SYdAK5rtLiCJBxw2zzjewMgOb
 m9J6dDtsi548n4abmgJTqZWT0bDp3rlJXqCqhN7Bg1PDiZCVHi3/hg+xYGvT5Nl3MenMwJlcUXd
 EuP9p+eppVrOPy3EjLg3Ei6ltdhfQjkQPVogPA3YhOFyt4rpNqYK6s0cYh/iKDFTyw+6FM94KCb
 nCuNntvmgv65z4rPLMUl7ZIdF0BBpilz3+AaVMhQ==
X-Gm-Gg: AfdE7cl11q57bRtmuztCLFXGu3DK+S8SuhF92VtOmBVswAFKZ2GqTEbUFLEzbLYFoBt
 Lo/WSAyzrd3KqMFW0g1fFLz7LgHY7nUx0OyAVKg/MqTMXe/MaGwziaE6AuULaMo3oGCa//1ZdBU
 uRdrQB/WmN7Uq7xqS2cz6wfZI4EoeOBB9m4kXtWXlOJZ06O6DY6/WRsBumbDXoApXATInxLH8Qy
 5oLF1zW2SCe3EdbvoUv95iWoyx9VpctJmuLvVnwWE8OOnNg+c3JECKP2AoJR/7yiCOIuqsT09TT
 cYXJytuvZ5kiEIe6zIj/5XVktUN2a+M1NwbHaX0zDiESlWHtv1F5SKJUyiqXinZcew/y441hvr4
 kKQ==
X-Received: by 2002:ac8:5f47:0:b0:517:6b9c:58e4 with SMTP id
 d75a77b69052e-51a548cd7d8mr40713521cf.51.1782218913202; 
 Tue, 23 Jun 2026 05:48:33 -0700 (PDT)
X-Received: by 2002:ac8:5f47:0:b0:517:6b9c:58e4 with SMTP id
 d75a77b69052e-51a548cd7d8mr40712501cf.51.1782218912104; 
 Tue, 23 Jun 2026 05:48:32 -0700 (PDT)
Received: from x1.com ([174.91.117.157]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51106a09sm22288351cf.0.2026.06.23.05.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:48:31 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 09/18] system/memory: move RamDiscardManager to separate
 compilation unit
Date: Tue, 23 Jun 2026 08:47:50 -0400
Message-ID: <20260623124759.125399-10-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623124759.125399-1-peterx@redhat.com>
References: <20260623124759.125399-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Extract RamDiscardManager and RamDiscardSource from system/memory.c into
dedicated a unit.

This reduces coupling and allows code that only needs the
RamDiscardManager interface to avoid pulling in all of memory.h
dependencies.

rust-sys bindings are no longer generated for RamDiscardSourceClass at
this point, thus we drop the unneeded InterfaceClass use.

Reviewed-by: Peter Xu <peterx@redhat.com>
Acked-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260604-rdm5-v5-2-5768e6a0943d@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 MAINTAINERS                          |   2 +
 include/system/memory.h              | 280 +------------------------
 include/system/ram-discard-manager.h | 297 +++++++++++++++++++++++++++
 system/memory.c                      | 221 --------------------
 system/ram-discard-manager.c         | 240 ++++++++++++++++++++++
 rust/bindings/system-sys/lib.rs      |   2 +-
 system/meson.build                   |   1 +
 7 files changed, 542 insertions(+), 501 deletions(-)
 create mode 100644 include/system/ram-discard-manager.h
 create mode 100644 system/ram-discard-manager.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d609692d9a..18b659a44c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3350,6 +3350,7 @@ F: include/system/memory.h
 F: include/system/memory_cached.h
 F: include/system/memory_ldst*
 F: include/system/physmem.h
+F: include/system/ram-discard-manager.h
 F: include/system/ramblock.h
 F: include/system/memory_mapping.h
 F: system/dma-helpers.c
@@ -3360,6 +3361,7 @@ F: system/physmem.c
 F: system/memory_ldst*
 F: system/memory-internal.h
 F: system/ram-block-attributes.c
+F: system/ram-discard-manager.c
 F: scripts/coccinelle/memory-region-housekeeping.cocci
 
 Memory devices
diff --git a/include/system/memory.h b/include/system/memory.h
index ffdf95f2f2..4a700cb657 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -16,6 +16,7 @@
 
 #include "exec/hwaddr.h"
 #include "system/ram_addr.h"
+#include "system/ram-discard-manager.h"
 #include "exec/memattrs.h"
 #include "exec/memop.h"
 #include "qemu/bswap.h"
@@ -45,18 +46,6 @@ typedef struct IOMMUMemoryRegionClass IOMMUMemoryRegionClass;
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
@@ -545,273 +534,6 @@ struct IOMMUMemoryRegionClass {
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
index 0000000000..da55658169
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
index 52946c5e5d..5a598ca58c 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2069,17 +2069,6 @@ RamDiscardManager *memory_region_get_ram_discard_manager(MemoryRegion *mr)
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
@@ -2101,200 +2090,6 @@ void memory_region_del_ram_discard_source(MemoryRegion *mr,
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
@@ -3924,26 +3719,10 @@ static const TypeInfo iommu_memory_region_info = {
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
index 0000000000..3d8c85617d
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
index 022fe65dd8..30adf683c3 100644
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
index 9cdfe1b3e7..cd3193d170 100644
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


