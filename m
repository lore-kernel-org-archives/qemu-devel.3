Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E493C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 07:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1hFk-0001OS-1m; Mon, 07 Apr 2025 03:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u1hFc-0001M1-80
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:50:36 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u1hFa-0005SK-3Y
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744012234; x=1775548234;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NXIbQZGPX/IetC+2ATda7+FulTolZHjLHw2CKq3GgXI=;
 b=BNcMIuzd+yRJxjeLkEjz/vO0Rn+N9wtxdDw3N/z2YXaD1PviepbgRrL0
 S1FEoz+hW3UXxU7IPAEKawAmISGf4iBrzI9FNgD+KW9jwduzvZeoAyKhf
 Z4C3DV9bYY2xNNdoj3Cf5w/+7BS3TG1WLaRobLcBKfoZNFPS8LuzntnOD
 H5stAF0qLzWbSlHLcJB5aqIGnMSWyfSg5JPtG9o+mWHMjeI6kkOJKlQnA
 E6MiibRX/W7s+vuzzm8c9/Nn6rl1tWn/pJAiGd9CJlZDDWVF2+9HMItVD
 y1ON2FuxYhTz3lIFIloxJWuiW3X5zPReHUMpWxyGhcnwhofWpZDqQrXsZ w==;
X-CSE-ConnectionGUID: cVkvzhCrTzyhZVN9nVO/lQ==
X-CSE-MsgGUID: lKOZngXvTOWvx1410Zh5bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="67857609"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; d="scan'208";a="67857609"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 00:50:34 -0700
X-CSE-ConnectionGUID: 7njJYSf+TOOQowEGtCZrXg==
X-CSE-MsgGUID: Hvft6m07QiGM8/baoKcQdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; d="scan'208";a="128405702"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 00:50:30 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v4 12/13] ram-block-attribute: Add priority listener support
 for PrivateSharedListener
Date: Mon,  7 Apr 2025 15:49:32 +0800
Message-ID: <20250407074939.18657-13-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250407074939.18657-1-chenyi.qiang@intel.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=chenyi.qiang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

In-place page conversion requires operations to follow a specific
sequence: unmap-before-conversion-to-private and
map-after-conversion-to-shared. Currently, both attribute changes and
VFIO DMA map/unmap operations are handled by PrivateSharedListeners,
they need to be invoked in a specific order.

For private to shared conversion:
- Change attribute to shared.
- VFIO populates the shared mappings into the IOMMU.
- Restore attribute if the operation fails.

For shared to private conversion:
- VFIO discards shared mapping from the IOMMU.
- Change attribute to private.

To faciliate this sequence, priority support is added to
PrivateSharedListener so that listeners are stored in a determined
order based on priority. A tail queue is used to store listeners,
allowing traversal in either direction.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
Changes in v4:
    - Newly added.
---
 accel/kvm/kvm-all.c          |  3 ++-
 hw/vfio/common.c             |  3 ++-
 include/exec/memory.h        | 19 +++++++++++++++++--
 include/exec/ramblock.h      |  2 +-
 system/ram-block-attribute.c | 23 +++++++++++++++++------
 5 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index aec64d559b..879c61b391 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1745,7 +1745,8 @@ static void kvm_region_add(MemoryListener *listener,
     psl = &cpsl->listener;
     QLIST_INSERT_HEAD(&cgs->cvm_private_shared_list, cpsl, next);
     private_shared_listener_init(psl, kvm_private_shared_notify_to_shared,
-                                 kvm_private_shared_notify_to_private);
+                                 kvm_private_shared_notify_to_private,
+                                 PRIVATE_SHARED_LISTENER_PRIORITY_MIN);
     generic_state_manager_register_listener(gsm, &psl->scl, section);
 }
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 6e49ae597d..a8aacae26c 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -515,7 +515,8 @@ static void vfio_register_private_shared_listener(VFIOContainerBase *bcontainer,
 
     psl = &vpsl->listener;
     private_shared_listener_init(psl, vfio_private_shared_notify_to_shared,
-                                 vfio_private_shared_notify_to_private);
+                                 vfio_private_shared_notify_to_private,
+                                 PRIVATE_SHARED_LISTENER_PRIORITY_COMMON);
     generic_state_manager_register_listener(gsm, &psl->scl, section);
     QLIST_INSERT_HEAD(&bcontainer->vpsl_list, vpsl, next);
 }
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9472d9e9b4..3d06cc04a0 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -770,11 +770,24 @@ struct RamDiscardManagerClass {
     GenericStateManagerClass parent_class;
 };
 
+#define PRIVATE_SHARED_LISTENER_PRIORITY_MIN       0
+#define PRIVATE_SHARED_LISTENER_PRIORITY_COMMON    10
+
 typedef struct PrivateSharedListener PrivateSharedListener;
 struct PrivateSharedListener {
     struct StateChangeListener scl;
 
-    QLIST_ENTRY(PrivateSharedListener) next;
+    /*
+     * @priority:
+     *
+     * Govern the order in which ram discard listeners are invoked. Lower priorities
+     * are invoked earlier.
+     * The listener priority can help to undo the effects of previous listeners in
+     * a reverse order in case of a failure callback.
+     */
+    int priority;
+
+    QTAILQ_ENTRY(PrivateSharedListener) next;
 };
 
 struct PrivateSharedManagerClass {
@@ -787,9 +800,11 @@ struct PrivateSharedManagerClass {
 
 static inline void private_shared_listener_init(PrivateSharedListener *psl,
                                                 NotifyStateSet populate_fn,
-                                                NotifyStateClear discard_fn)
+                                                NotifyStateClear discard_fn,
+                                                int priority)
 {
     state_change_listener_init(&psl->scl, populate_fn, discard_fn);
+    psl->priority = priority;
 }
 
 int private_shared_manager_state_change(PrivateSharedManager *mgr,
diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 78eb031819..7a3dd709bb 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -105,7 +105,7 @@ struct RamBlockAttribute {
     unsigned shared_bitmap_size;
     unsigned long *shared_bitmap;
 
-    QLIST_HEAD(, PrivateSharedListener) psl_list;
+    QTAILQ_HEAD(, PrivateSharedListener) psl_list;
 };
 
 struct RamBlockAttributeClass {
diff --git a/system/ram-block-attribute.c b/system/ram-block-attribute.c
index 15c9aebd09..fd041148c7 100644
--- a/system/ram-block-attribute.c
+++ b/system/ram-block-attribute.c
@@ -158,12 +158,23 @@ static void ram_block_attribute_psm_register_listener(GenericStateManager *gsm,
 {
     RamBlockAttribute *attr = RAM_BLOCK_ATTRIBUTE(gsm);
     PrivateSharedListener *psl = container_of(scl, PrivateSharedListener, scl);
+    PrivateSharedListener *other = NULL;
     int ret;
 
     g_assert(section->mr == attr->mr);
     scl->section = memory_region_section_new_copy(section);
 
-    QLIST_INSERT_HEAD(&attr->psl_list, psl, next);
+    if (QTAILQ_EMPTY(&attr->psl_list) ||
+        psl->priority >= QTAILQ_LAST(&attr->psl_list)->priority) {
+        QTAILQ_INSERT_TAIL(&attr->psl_list, psl, next);
+    } else {
+        QTAILQ_FOREACH(other, &attr->psl_list, next) {
+            if (psl->priority < other->priority) {
+                break;
+            }
+        }
+        QTAILQ_INSERT_BEFORE(other, psl, next);
+    }
 
     ret = ram_block_attribute_for_each_shared_section(attr, section, scl,
                                                       ram_block_attribute_notify_shared_cb);
@@ -192,7 +203,7 @@ static void ram_block_attribute_psm_unregister_listener(GenericStateManager *gsm
 
     memory_region_section_free_copy(scl->section);
     scl->section = NULL;
-    QLIST_REMOVE(psl, next);
+    QTAILQ_REMOVE(&attr->psl_list, psl, next);
 }
 
 typedef struct RamBlockAttributeReplayData {
@@ -261,7 +272,7 @@ static void ram_block_attribute_notify_to_private(RamBlockAttribute *attr,
     PrivateSharedListener *psl;
     int ret;
 
-    QLIST_FOREACH(psl, &attr->psl_list, next) {
+    QTAILQ_FOREACH_REVERSE(psl, &attr->psl_list, next) {
         StateChangeListener *scl = &psl->scl;
         MemoryRegionSection tmp = *scl->section;
 
@@ -283,7 +294,7 @@ static int ram_block_attribute_notify_to_shared(RamBlockAttribute *attr,
     PrivateSharedListener *psl, *psl2;
     int ret = 0, ret2 = 0;
 
-    QLIST_FOREACH(psl, &attr->psl_list, next) {
+    QTAILQ_FOREACH(psl, &attr->psl_list, next) {
         StateChangeListener *scl = &psl->scl;
         MemoryRegionSection tmp = *scl->section;
 
@@ -298,7 +309,7 @@ static int ram_block_attribute_notify_to_shared(RamBlockAttribute *attr,
 
     if (ret) {
         /* Notify all already-notified listeners. */
-        QLIST_FOREACH(psl2, &attr->psl_list, next) {
+        QTAILQ_FOREACH(psl2, &attr->psl_list, next) {
             StateChangeListener *scl2 = &psl2->scl;
             MemoryRegionSection tmp = *scl2->section;
 
@@ -462,7 +473,7 @@ static void ram_block_attribute_init(Object *obj)
 {
     RamBlockAttribute *attr = RAM_BLOCK_ATTRIBUTE(obj);
 
-    QLIST_INIT(&attr->psl_list);
+    QTAILQ_INIT(&attr->psl_list);
 }
 
 static void ram_block_attribute_finalize(Object *obj)
-- 
2.43.5


