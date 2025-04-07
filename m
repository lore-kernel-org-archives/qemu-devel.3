Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27630C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 07:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1hFV-0001Ja-4N; Mon, 07 Apr 2025 03:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u1hFC-0001HG-By
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:50:11 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u1hFA-0005Q2-Ag
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744012209; x=1775548209;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4/NxRHGIa82bpN+zenGnUIFub5qv8ngu3vJ4kD8YLHE=;
 b=noXWiMVNqBzW93t9khdNwPsAYDrq8qvbkKYUBrvQ4f8jYzYNmzzdJxrZ
 jNrNiDC5/rNllXewgtbP3Y12z8449LC218QvoiaX3y1m7zzlWRduvZX3T
 PsBg5Z2oER9l2YL0RDzAzvVmtRrWCNOS1/CSWIoyJXHLNoAm9btvoY8qE
 NLwnv46IPlt1BU+3XvW2TYwdh9ynw+ig7DVVGcaUnKzp7qJ9RBaYvKALy
 3FkBksmIpaC/CVQ4RkKSiGnXBvBLXBAIGRbPgPYsvld+0JIIOfNWs3/XR
 CW6MYfOw7k0J07G6bvLzRrW8jZWJIQKTjlZbWVi91rT8JSXwOvC3JIJAJ A==;
X-CSE-ConnectionGUID: UoJxzmw9QyShIz+q/ogvnw==
X-CSE-MsgGUID: vEopJQ3PT4Ofavpvq4lQVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="67857542"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; d="scan'208";a="67857542"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 00:50:07 -0700
X-CSE-ConnectionGUID: yBqCn659QIiBIBvFTDzYEQ==
X-CSE-MsgGUID: dQEPRNaGTPGDAItE1bRttw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; d="scan'208";a="128405591"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 00:50:03 -0700
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
Subject: [PATCH v4 05/13] memory: Introduce PrivateSharedManager Interface as
 child of GenericStateManager
Date: Mon,  7 Apr 2025 15:49:25 +0800
Message-ID: <20250407074939.18657-6-chenyi.qiang@intel.com>
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

To manage the private and shared RAM states in confidential VMs,
introduce a new class of PrivateShareManager as a child of
GenericStateManager, which inherits the six interface callbacks. With a
different interface type, it can be distinguished from the
RamDiscardManager object and provide the flexibility for addressing
specific requirements of confidential VMs in the future.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
Changes in v4:
    - Newly added.
---
 include/exec/memory.h | 44 +++++++++++++++++++++++++++++++++++++++++--
 system/memory.c       | 17 +++++++++++++++++
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 30e5838d02..08f25e5e84 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -55,6 +55,12 @@ typedef struct RamDiscardManager RamDiscardManager;
 DECLARE_OBJ_CHECKERS(RamDiscardManager, RamDiscardManagerClass,
                      RAM_DISCARD_MANAGER, TYPE_RAM_DISCARD_MANAGER);
 
+#define TYPE_PRIVATE_SHARED_MANAGER "private-shared-manager"
+typedef struct PrivateSharedManagerClass PrivateSharedManagerClass;
+typedef struct PrivateSharedManager PrivateSharedManager;
+DECLARE_OBJ_CHECKERS(PrivateSharedManager, PrivateSharedManagerClass,
+                     PRIVATE_SHARED_MANAGER, TYPE_PRIVATE_SHARED_MANAGER)
+
 #ifdef CONFIG_FUZZ
 void fuzz_dma_read_cb(size_t addr,
                       size_t len,
@@ -692,6 +698,14 @@ void generic_state_manager_register_listener(GenericStateManager *gsm,
 void generic_state_manager_unregister_listener(GenericStateManager *gsm,
                                                StateChangeListener *scl);
 
+static inline void state_change_listener_init(StateChangeListener *scl,
+                                              NotifyStateSet state_set_fn,
+                                              NotifyStateClear state_clear_fn)
+{
+    scl->notify_to_state_set = state_set_fn;
+    scl->notify_to_state_clear = state_clear_fn;
+}
+
 typedef struct RamDiscardListener RamDiscardListener;
 
 struct RamDiscardListener {
@@ -713,8 +727,7 @@ static inline void ram_discard_listener_init(RamDiscardListener *rdl,
                                              NotifyStateClear discard_fn,
                                              bool double_discard_supported)
 {
-    rdl->scl.notify_to_state_set = populate_fn;
-    rdl->scl.notify_to_state_clear = discard_fn;
+    state_change_listener_init(&rdl->scl, populate_fn, discard_fn);
     rdl->double_discard_supported = double_discard_supported;
 }
 
@@ -757,6 +770,25 @@ struct RamDiscardManagerClass {
     GenericStateManagerClass parent_class;
 };
 
+typedef struct PrivateSharedListener PrivateSharedListener;
+struct PrivateSharedListener {
+    struct StateChangeListener scl;
+
+    QLIST_ENTRY(PrivateSharedListener) next;
+};
+
+struct PrivateSharedManagerClass {
+    /* private */
+    GenericStateManagerClass parent_class;
+};
+
+static inline void private_shared_listener_init(PrivateSharedListener *psl,
+                                                NotifyStateSet populate_fn,
+                                                NotifyStateClear discard_fn)
+{
+    state_change_listener_init(&psl->scl, populate_fn, discard_fn);
+}
+
 /**
  * memory_get_xlat_addr: Extract addresses from a TLB entry
  *
@@ -2521,6 +2553,14 @@ int memory_region_set_generic_state_manager(MemoryRegion *mr,
  */
 bool memory_region_has_ram_discard_manager(MemoryRegion *mr);
 
+/**
+ * memory_region_has_private_shared_manager: check whether a #MemoryRegion has a
+ * #PrivateSharedManager assigned
+ *
+ * @mr: the #MemoryRegion
+ */
+bool memory_region_has_private_shared_manager(MemoryRegion *mr);
+
 /**
  * memory_region_find: translate an address/size relative to a
  * MemoryRegion into a #MemoryRegionSection.
diff --git a/system/memory.c b/system/memory.c
index 7b921c66a6..e6e944d9c0 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2137,6 +2137,16 @@ bool memory_region_has_ram_discard_manager(MemoryRegion *mr)
     return true;
 }
 
+bool memory_region_has_private_shared_manager(MemoryRegion *mr)
+{
+    if (!memory_region_is_ram(mr) ||
+        !object_dynamic_cast(OBJECT(mr->gsm), TYPE_PRIVATE_SHARED_MANAGER)) {
+        return false;
+    }
+
+    return true;
+}
+
 uint64_t generic_state_manager_get_min_granularity(const GenericStateManager *gsm,
                                                    const MemoryRegion *mr)
 {
@@ -3837,12 +3847,19 @@ static const TypeInfo ram_discard_manager_info = {
     .class_size         = sizeof(RamDiscardManagerClass),
 };
 
+static const TypeInfo private_shared_manager_info = {
+    .parent             = TYPE_GENERIC_STATE_MANAGER,
+    .name               = TYPE_PRIVATE_SHARED_MANAGER,
+    .class_size         = sizeof(PrivateSharedManagerClass),
+};
+
 static void memory_register_types(void)
 {
     type_register_static(&memory_region_info);
     type_register_static(&iommu_memory_region_info);
     type_register_static(&generic_state_manager_info);
     type_register_static(&ram_discard_manager_info);
+    type_register_static(&private_shared_manager_info);
 }
 
 type_init(memory_register_types)
-- 
2.43.5


