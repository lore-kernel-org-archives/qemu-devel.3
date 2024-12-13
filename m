Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1ADE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 07:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLzns-0007YG-MF; Fri, 13 Dec 2024 02:09:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tLznr-0007Y8-Fw
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 02:09:35 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tLzno-00071K-Du
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 02:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734073773; x=1765609773;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A4w+xUWPFzrHzwWGCwJC81L1HqXdufeFhGlIL1EjnJc=;
 b=SKvXKByHb42oHeJF9t2NRFnVn2+EOuyPzWekYj6L0cpDUfX2TEd8hpqV
 qu0mpi3WkaL7Qun0hVIDM0qIt0MycTXMCd5MD9kjM71GPfG+AP5iUQ1Ct
 puTUw4/KgT/9o4SJFN7FY1Cf9RnXhO2zlptb9+sLkl/KJ2Hbh74Fn00tv
 LSjsJ4T/3Zh17z3EvRuq/OUyEhwgj0HlJHZYnxs+mcsUivlsviYCa6Scl
 vSXB3aql2KDFY3pRNNbsj/EC8sGoGB0C7+8dr8BcD81Jcz1Tb+MPO5Saz
 qMb4l3VpV+Ox/fjz57iinXgsGnwH99N1kYeufYz1MHOEbXu7jTD93yZgS g==;
X-CSE-ConnectionGUID: uvdmKt2dTRC7B9QR/RobXg==
X-CSE-MsgGUID: HWKgLmvJRqm3bDNQ+fh4Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="51937093"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; d="scan'208";a="51937093"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 23:09:32 -0800
X-CSE-ConnectionGUID: XvVkZrwWTDSpO5tbYZGm3Q==
X-CSE-MsgGUID: WI9Kr5bxSjiT/r1psnF6jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; d="scan'208";a="96365574"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 23:09:29 -0800
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 5/7] memory: Register the RamDiscardManager instance upon
 guest_memfd creation
Date: Fri, 13 Dec 2024 15:08:47 +0800
Message-ID: <20241213070852.106092-6-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241213070852.106092-1-chenyi.qiang@intel.com>
References: <20241213070852.106092-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Introduce the realize()/unrealize() callbacks to initialize/uninitialize
the new guest_memfd_manager object and register/unregister it in the
target MemoryRegion.

Guest_memfd was initially set to shared until the commit bd3bcf6962
("kvm/memory: Make memory type private by default if it has guest memfd
backend"). To align with this change, the default state in
guest_memfd_manager is set to private. (The bitmap is cleared to 0).
Additionally, setting the default to private can also reduce the
overhead of mapping shared pages into IOMMU by VFIO during the bootup stage.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 include/sysemu/guest-memfd-manager.h | 27 +++++++++++++++++++++++++++
 system/guest-memfd-manager.c         | 28 +++++++++++++++++++++++++++-
 system/physmem.c                     |  7 +++++++
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/guest-memfd-manager.h b/include/sysemu/guest-memfd-manager.h
index 9dc4e0346d..d1e7f698e8 100644
--- a/include/sysemu/guest-memfd-manager.h
+++ b/include/sysemu/guest-memfd-manager.h
@@ -42,6 +42,8 @@ struct GuestMemfdManager {
 struct GuestMemfdManagerClass {
     ObjectClass parent_class;
 
+    void (*realize)(GuestMemfdManager *gmm, MemoryRegion *mr, uint64_t region_size);
+    void (*unrealize)(GuestMemfdManager *gmm);
     int (*state_change)(GuestMemfdManager *gmm, uint64_t offset, uint64_t size,
                         bool shared_to_private);
 };
@@ -61,4 +63,29 @@ static inline int guest_memfd_manager_state_change(GuestMemfdManager *gmm, uint6
     return 0;
 }
 
+static inline void guest_memfd_manager_realize(GuestMemfdManager *gmm,
+                                              MemoryRegion *mr, uint64_t region_size)
+{
+    GuestMemfdManagerClass *klass;
+
+    g_assert(gmm);
+    klass = GUEST_MEMFD_MANAGER_GET_CLASS(gmm);
+
+    if (klass->realize) {
+        klass->realize(gmm, mr, region_size);
+    }
+}
+
+static inline void guest_memfd_manager_unrealize(GuestMemfdManager *gmm)
+{
+    GuestMemfdManagerClass *klass;
+
+    g_assert(gmm);
+    klass = GUEST_MEMFD_MANAGER_GET_CLASS(gmm);
+
+    if (klass->unrealize) {
+        klass->unrealize(gmm);
+    }
+}
+
 #endif
diff --git a/system/guest-memfd-manager.c b/system/guest-memfd-manager.c
index 6601df5f3f..b6a32f0bfb 100644
--- a/system/guest-memfd-manager.c
+++ b/system/guest-memfd-manager.c
@@ -366,6 +366,31 @@ static int guest_memfd_state_change(GuestMemfdManager *gmm, uint64_t offset,
     return ret;
 }
 
+static void guest_memfd_manager_realizefn(GuestMemfdManager *gmm, MemoryRegion *mr,
+                                          uint64_t region_size)
+{
+    uint64_t bitmap_size;
+
+    gmm->block_size = qemu_real_host_page_size();
+    bitmap_size = ROUND_UP(region_size, gmm->block_size) / gmm->block_size;
+
+    gmm->mr = mr;
+    gmm->bitmap_size = bitmap_size;
+    gmm->bitmap = bitmap_new(bitmap_size);
+
+    memory_region_set_ram_discard_manager(gmm->mr, RAM_DISCARD_MANAGER(gmm));
+}
+
+static void guest_memfd_manager_unrealizefn(GuestMemfdManager *gmm)
+{
+    memory_region_set_ram_discard_manager(gmm->mr, NULL);
+
+    g_free(gmm->bitmap);
+    gmm->bitmap = NULL;
+    gmm->bitmap_size = 0;
+    gmm->mr = NULL;
+}
+
 static void guest_memfd_manager_init(Object *obj)
 {
     GuestMemfdManager *gmm = GUEST_MEMFD_MANAGER(obj);
@@ -375,7 +400,6 @@ static void guest_memfd_manager_init(Object *obj)
 
 static void guest_memfd_manager_finalize(Object *obj)
 {
-    g_free(GUEST_MEMFD_MANAGER(obj)->bitmap);
 }
 
 static void guest_memfd_manager_class_init(ObjectClass *oc, void *data)
@@ -384,6 +408,8 @@ static void guest_memfd_manager_class_init(ObjectClass *oc, void *data)
     RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_CLASS(oc);
 
     gmmc->state_change = guest_memfd_state_change;
+    gmmc->realize = guest_memfd_manager_realizefn;
+    gmmc->unrealize = guest_memfd_manager_unrealizefn;
 
     rdmc->get_min_granularity = guest_memfd_rdm_get_min_granularity;
     rdmc->register_listener = guest_memfd_rdm_register_listener;
diff --git a/system/physmem.c b/system/physmem.c
index dc1db3a384..532182a6dd 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -53,6 +53,7 @@
 #include "sysemu/hostmem.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/xen-mapcache.h"
+#include "sysemu/guest-memfd-manager.h"
 #include "trace.h"
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
@@ -1885,6 +1886,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             qemu_mutex_unlock_ramlist();
             goto out_free;
         }
+
+        GuestMemfdManager *gmm = GUEST_MEMFD_MANAGER(object_new(TYPE_GUEST_MEMFD_MANAGER));
+        guest_memfd_manager_realize(gmm, new_block->mr, new_block->mr->size);
     }
 
     ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
@@ -2139,6 +2143,9 @@ static void reclaim_ramblock(RAMBlock *block)
 
     if (block->guest_memfd >= 0) {
         close(block->guest_memfd);
+        GuestMemfdManager *gmm = GUEST_MEMFD_MANAGER(block->mr->rdm);
+        guest_memfd_manager_unrealize(gmm);
+        object_unref(OBJECT(gmm));
         ram_block_discard_require(false);
     }
 
-- 
2.43.5


