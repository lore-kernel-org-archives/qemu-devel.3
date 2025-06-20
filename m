Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470E4C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 15:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSdRu-0002xy-5h; Fri, 20 Jun 2025 11:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSdRs-0002xc-Da
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 11:14:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSdRq-00064A-D0
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 11:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750432473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QdxDQMLiWOI1rD7XFcnc1+WLEfQpGucZy1QFxreYjgk=;
 b=I69D2yGpZgpFPG2ytwt5iqeOLFc4HYp33e1pWcO6dsCKJcPCx7/DkcqbTfr4DyGEOWO9F8
 yI4TRH0gcn1TiWHKCGjIGvWlJxs/xbk/V5IawHZa8Gxd0+56ojgnfjAwHuLq3p3YGLPR47
 F9J+Ar2qnKWq5ShRnw/lGTWaamvrfto=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-n6FwMvkDPLiSlBS7hIRMsg-1; Fri,
 20 Jun 2025 11:14:30 -0400
X-MC-Unique: n6FwMvkDPLiSlBS7hIRMsg-1
X-Mimecast-MFC-AGG-ID: n6FwMvkDPLiSlBS7hIRMsg_1750432469
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA8FB18089B5; Fri, 20 Jun 2025 15:14:28 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7ACCB1956094; Fri, 20 Jun 2025 15:14:25 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, mst@redhat.com, anisinha@redhat.com,
 elena.ufimtseva@oracle.com, jag.raman@oracle.com, pbonzini@redhat.com,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org
Subject: [PATCH 1/3] memory: reintroduce BQL-free fine-grained PIO/MMIO
Date: Fri, 20 Jun 2025 17:14:16 +0200
Message-ID: <20250620151418.1166195-2-imammedo@redhat.com>
In-Reply-To: <20250620151418.1166195-1-imammedo@redhat.com>
References: <20250620151418.1166195-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch brings back Jan's idea [1] of BQL-free IO access,
with a twist that whitelist read access only.

(as BQL-free write access in [1] used to cause issues [2]
and still does (Windows crash) if write path is not lock protected)

However with limiting it read path only, guest boots without issues.
This will let us make read access ACPI PM/HPET timers cheaper,
and prevent guest VCPUs BQL contention in case of workload
that heavily uses the timers.

2) 196ea13104f (memory: Add global-locking property to memory regions)
   ... de7ea885c539 (kvm: Switch to unlocked MMIO)
3) https://bugzilla.redhat.com/show_bug.cgi?id=1322713
   1beb99f787 (Revert "acpi: mark PMTIMER as unlocked")

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/system/memory.h   | 10 +++++++++-
 hw/remote/vfio-user-obj.c |  2 +-
 system/memory.c           |  5 +++++
 system/memory_ldst.c.inc  | 18 +++++++++---------
 system/physmem.c          |  9 +++++----
 5 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index fc35a0dcad..1afabf2d94 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -775,6 +775,7 @@ struct MemoryRegion {
     bool nonvolatile;
     bool rom_device;
     bool flush_coalesced_mmio;
+    bool lockless_ro_io;
     bool unmergeable;
     uint8_t dirty_log_mask;
     bool is_iommu;
@@ -2253,6 +2254,13 @@ void memory_region_set_flush_coalesced(MemoryRegion *mr);
  */
 void memory_region_clear_flush_coalesced(MemoryRegion *mr);
 
+/**
+ * memory_region_enable_lockless_ro_io: Enable lockless (BQL) read-only acceess.
+ *
+ * Enable BQL-free readonly access for devices with fine-grained locking.
+ */
+void memory_region_enable_lockless_ro_io(MemoryRegion *mr);
+
 /**
  * memory_region_add_eventfd: Request an eventfd to be triggered when a word
  *                            is written to a location.
@@ -3002,7 +3010,7 @@ MemTxResult address_space_write_cached_slow(MemoryRegionCache *cache,
                                             hwaddr len);
 
 int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr);
-bool prepare_mmio_access(MemoryRegion *mr);
+bool prepare_mmio_access(MemoryRegion *mr, bool read);
 
 static inline bool memory_region_supports_direct_access(MemoryRegion *mr)
 {
diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index ea6165ebdc..936a9befd4 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -381,7 +381,7 @@ static int vfu_object_mr_rw(MemoryRegion *mr, uint8_t *buf, hwaddr offset,
          * The read/write logic used below is similar to the ones in
          * flatview_read/write_continue()
          */
-        release_lock = prepare_mmio_access(mr);
+        release_lock = prepare_mmio_access(mr, !is_write);
 
         access_size = memory_access_size(mr, size, offset);
 
diff --git a/system/memory.c b/system/memory.c
index 63b983efcd..5192195473 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2558,6 +2558,11 @@ void memory_region_clear_flush_coalesced(MemoryRegion *mr)
     }
 }
 
+void memory_region_enable_lockless_ro_io(MemoryRegion *mr)
+{
+    mr->lockless_ro_io = true;
+}
+
 void memory_region_add_eventfd(MemoryRegion *mr,
                                hwaddr addr,
                                unsigned size,
diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index 7f32d3d9ff..919357578c 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -35,7 +35,7 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, false, attrs);
     if (l < 4 || !memory_access_is_direct(mr, false, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
+        release_lock |= prepare_mmio_access(mr, true);
 
         /* I/O case */
         r = memory_region_dispatch_read(mr, addr1, &val,
@@ -104,7 +104,7 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, false, attrs);
     if (l < 8 || !memory_access_is_direct(mr, false, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
+        release_lock |= prepare_mmio_access(mr, true);
 
         /* I/O case */
         r = memory_region_dispatch_read(mr, addr1, &val,
@@ -171,7 +171,7 @@ uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, false, attrs);
     if (!memory_access_is_direct(mr, false, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
+        release_lock |= prepare_mmio_access(mr, true);
 
         /* I/O case */
         r = memory_region_dispatch_read(mr, addr1, &val, MO_8, attrs);
@@ -208,7 +208,7 @@ static inline uint16_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, false, attrs);
     if (l < 2 || !memory_access_is_direct(mr, false, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
+        release_lock |= prepare_mmio_access(mr, true);
 
         /* I/O case */
         r = memory_region_dispatch_read(mr, addr1, &val,
@@ -278,7 +278,7 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (l < 4 || !memory_access_is_direct(mr, true, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
+        release_lock |= prepare_mmio_access(mr, false);
 
         r = memory_region_dispatch_write(mr, addr1, val, MO_32, attrs);
     } else {
@@ -315,7 +315,7 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (l < 4 || !memory_access_is_direct(mr, true, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
+        release_lock |= prepare_mmio_access(mr, false);
         r = memory_region_dispatch_write(mr, addr1, val,
                                          MO_32 | devend_memop(endian), attrs);
     } else {
@@ -378,7 +378,7 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL,
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (!memory_access_is_direct(mr, true, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
+        release_lock |= prepare_mmio_access(mr, false);
         r = memory_region_dispatch_write(mr, addr1, val, MO_8, attrs);
     } else {
         /* RAM case */
@@ -411,7 +411,7 @@ static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (l < 2 || !memory_access_is_direct(mr, true, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
+        release_lock |= prepare_mmio_access(mr, false);
         r = memory_region_dispatch_write(mr, addr1, val,
                                          MO_16 | devend_memop(endian), attrs);
     } else {
@@ -475,7 +475,7 @@ static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
     RCU_READ_LOCK();
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (l < 8 || !memory_access_is_direct(mr, true, attrs)) {
-        release_lock |= prepare_mmio_access(mr);
+        release_lock |= prepare_mmio_access(mr, false);
         r = memory_region_dispatch_write(mr, addr1, val,
                                          MO_64 | devend_memop(endian), attrs);
     } else {
diff --git a/system/physmem.c b/system/physmem.c
index a8a9ca309e..60e330de99 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2881,11 +2881,12 @@ int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
     return l;
 }
 
-bool prepare_mmio_access(MemoryRegion *mr)
+bool prepare_mmio_access(MemoryRegion *mr, bool read)
 {
     bool release_lock = false;
 
-    if (!bql_locked()) {
+    if (!bql_locked() &&
+        !(read && mr->lockless_ro_io == true)) {
         bql_lock();
         release_lock = true;
     }
@@ -2935,7 +2936,7 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
     if (!memory_access_is_direct(mr, true, attrs)) {
         uint64_t val;
         MemTxResult result;
-        bool release_lock = prepare_mmio_access(mr);
+        bool release_lock = prepare_mmio_access(mr, false);
 
         *l = memory_access_size(mr, *l, mr_addr);
         /*
@@ -3032,7 +3033,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
         /* I/O case */
         uint64_t val;
         MemTxResult result;
-        bool release_lock = prepare_mmio_access(mr);
+        bool release_lock = prepare_mmio_access(mr, true);
 
         *l = memory_access_size(mr, *l, mr_addr);
         result = memory_region_dispatch_read(mr, mr_addr, &val, size_memop(*l),
-- 
2.43.5


