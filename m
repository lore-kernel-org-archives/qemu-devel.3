Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8538C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 07:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLznq-0007Xt-TN; Fri, 13 Dec 2024 02:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tLzno-0007XL-R9
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 02:09:32 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tLznl-00071G-SG
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 02:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734073770; x=1765609770;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=clDYu4irPfldg6nv/XSDBXCk/lCoW+l/KtnHIqDPmow=;
 b=fQn7c7LZQEHjIOax0hv72p6AfHsw/eJqRA9D8vL3GuwiUd4Xl+996ppQ
 +sR/tCYO50CKD9NmUn1eB7gW+aoHYRN9if67KZd/lOLp0MCoqeuj2dDL0
 AFe+z+QptQS4jo9+UnkM9sWs2giq/gBfc+i47x4AZWj5hxgmA0aWx0j/R
 r+m31vyXlPosJwbxv68sakZ7H4aY7td54LPeQJ3MSGtWLEdDk0DF17X7m
 zCOCJf6sC+igw/IiAn9VkvV24YvSVMeUfjCuKw6kCk3Ez4vHAkwk+B+O2
 McHck/tIN/zqfxw/rCbaMnXZeI0okxZVul+FM7ZaCJh6jpkwRV4ikygC5 A==;
X-CSE-ConnectionGUID: XZdl0D/iSP6eX9jZPRGKHw==
X-CSE-MsgGUID: yeCXu7oiQticRlBhZoUmQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="51937082"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; d="scan'208";a="51937082"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 23:09:26 -0800
X-CSE-ConnectionGUID: /kKuGrECQ462TJEg+6+ouA==
X-CSE-MsgGUID: TZBRwFL4T86Wddo0G1L9Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; d="scan'208";a="96365557"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 23:09:22 -0800
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 3/7] guest_memfd: Introduce a callback to notify the
 shared/private state change
Date: Fri, 13 Dec 2024 15:08:45 +0800
Message-ID: <20241213070852.106092-4-chenyi.qiang@intel.com>
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

Introduce a new state_change() callback in GuestMemfdManagerClass to
efficiently notify all registered RamDiscardListeners, including VFIO
listeners about the memory conversion events in guest_memfd. The
existing VFIO listener can dynamically DMA map/unmap the shared pages
based on conversion types:
- For conversions from shared to private, the VFIO system ensures the
  discarding of shared mapping from the IOMMU.
- For conversions from private to shared, it triggers the population of
  the shared mapping into the IOMMU.

Additionally, there could be some special conversion requests:
- When a conversion request is made for a page already in the desired
  state, the helper simply returns success.
- For requests involving a range partially in the desired state, only
  the necessary segments are converted, ensuring the entire range
  complies with the request efficiently.
- In scenarios where a conversion request is declined by other systems,
  such as a failure from VFIO during notify_populate(), the helper will
  roll back the request, maintaining consistency.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 include/sysemu/guest-memfd-manager.h |   3 +
 system/guest-memfd-manager.c         | 144 +++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)

diff --git a/include/sysemu/guest-memfd-manager.h b/include/sysemu/guest-memfd-manager.h
index ba4a99b614..f4b175529b 100644
--- a/include/sysemu/guest-memfd-manager.h
+++ b/include/sysemu/guest-memfd-manager.h
@@ -41,6 +41,9 @@ struct GuestMemfdManager {
 
 struct GuestMemfdManagerClass {
     ObjectClass parent_class;
+
+    int (*state_change)(GuestMemfdManager *gmm, uint64_t offset, uint64_t size,
+                        bool shared_to_private);
 };
 
 #endif
diff --git a/system/guest-memfd-manager.c b/system/guest-memfd-manager.c
index d7e105fead..6601df5f3f 100644
--- a/system/guest-memfd-manager.c
+++ b/system/guest-memfd-manager.c
@@ -225,6 +225,147 @@ static void guest_memfd_rdm_replay_discarded(const RamDiscardManager *rdm,
                                            guest_memfd_rdm_replay_discarded_cb);
 }
 
+static bool guest_memfd_is_valid_range(GuestMemfdManager *gmm,
+                                       uint64_t offset, uint64_t size)
+{
+    MemoryRegion *mr = gmm->mr;
+
+    g_assert(mr);
+
+    uint64_t region_size = memory_region_size(mr);
+    if (!QEMU_IS_ALIGNED(offset, gmm->block_size)) {
+        return false;
+    }
+    if (offset + size < offset || !size) {
+        return false;
+    }
+    if (offset >= region_size || offset + size > region_size) {
+        return false;
+    }
+    return true;
+}
+
+static void guest_memfd_notify_discard(GuestMemfdManager *gmm,
+                                       uint64_t offset, uint64_t size)
+{
+    RamDiscardListener *rdl;
+
+    QLIST_FOREACH(rdl, &gmm->rdl_list, next) {
+        MemoryRegionSection tmp = *rdl->section;
+
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+            continue;
+        }
+
+        guest_memfd_for_each_populated_section(gmm, &tmp, rdl,
+                                               guest_memfd_notify_discard_cb);
+    }
+}
+
+
+static int guest_memfd_notify_populate(GuestMemfdManager *gmm,
+                                       uint64_t offset, uint64_t size)
+{
+    RamDiscardListener *rdl, *rdl2;
+    int ret = 0;
+
+    QLIST_FOREACH(rdl, &gmm->rdl_list, next) {
+        MemoryRegionSection tmp = *rdl->section;
+
+        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+            continue;
+        }
+
+        ret = guest_memfd_for_each_discarded_section(gmm, &tmp, rdl,
+                                                     guest_memfd_notify_populate_cb);
+        if (ret) {
+            break;
+        }
+    }
+
+    if (ret) {
+        /* Notify all already-notified listeners. */
+        QLIST_FOREACH(rdl2, &gmm->rdl_list, next) {
+            MemoryRegionSection tmp = *rdl2->section;
+
+            if (rdl2 == rdl) {
+                break;
+            }
+            if (!memory_region_section_intersect_range(&tmp, offset, size)) {
+                continue;
+            }
+
+            guest_memfd_for_each_discarded_section(gmm, &tmp, rdl2,
+                                                   guest_memfd_notify_discard_cb);
+        }
+    }
+    return ret;
+}
+
+static bool guest_memfd_is_range_populated(GuestMemfdManager *gmm,
+                                           uint64_t offset, uint64_t size)
+{
+    const unsigned long first_bit = offset / gmm->block_size;
+    const unsigned long last_bit = first_bit + (size / gmm->block_size) - 1;
+    unsigned long found_bit;
+
+    /* We fake a shorter bitmap to avoid searching too far. */
+    found_bit = find_next_zero_bit(gmm->bitmap, last_bit + 1, first_bit);
+    return found_bit > last_bit;
+}
+
+static bool guest_memfd_is_range_discarded(GuestMemfdManager *gmm,
+                                           uint64_t offset, uint64_t size)
+{
+    const unsigned long first_bit = offset / gmm->block_size;
+    const unsigned long last_bit = first_bit + (size / gmm->block_size) - 1;
+    unsigned long found_bit;
+
+    /* We fake a shorter bitmap to avoid searching too far. */
+    found_bit = find_next_bit(gmm->bitmap, last_bit + 1, first_bit);
+    return found_bit > last_bit;
+}
+
+static int guest_memfd_state_change(GuestMemfdManager *gmm, uint64_t offset,
+                                    uint64_t size, bool shared_to_private)
+{
+    int ret = 0;
+
+    if (!guest_memfd_is_valid_range(gmm, offset, size)) {
+        error_report("%s, invalid range: offset 0x%lx, size 0x%lx",
+                     __func__, offset, size);
+        return -1;
+    }
+
+    if ((shared_to_private && guest_memfd_is_range_discarded(gmm, offset, size)) ||
+        (!shared_to_private && guest_memfd_is_range_populated(gmm, offset, size))) {
+        return 0;
+    }
+
+    if (shared_to_private) {
+        guest_memfd_notify_discard(gmm, offset, size);
+    } else {
+        ret = guest_memfd_notify_populate(gmm, offset, size);
+    }
+
+    if (!ret) {
+        unsigned long first_bit = offset / gmm->block_size;
+        unsigned long nbits = size / gmm->block_size;
+
+        g_assert((first_bit + nbits) <= gmm->bitmap_size);
+
+        if (shared_to_private) {
+            bitmap_clear(gmm->bitmap, first_bit, nbits);
+        } else {
+            bitmap_set(gmm->bitmap, first_bit, nbits);
+        }
+
+        return 0;
+    }
+
+    return ret;
+}
+
 static void guest_memfd_manager_init(Object *obj)
 {
     GuestMemfdManager *gmm = GUEST_MEMFD_MANAGER(obj);
@@ -239,8 +380,11 @@ static void guest_memfd_manager_finalize(Object *obj)
 
 static void guest_memfd_manager_class_init(ObjectClass *oc, void *data)
 {
+    GuestMemfdManagerClass *gmmc = GUEST_MEMFD_MANAGER_CLASS(oc);
     RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_CLASS(oc);
 
+    gmmc->state_change = guest_memfd_state_change;
+
     rdmc->get_min_granularity = guest_memfd_rdm_get_min_granularity;
     rdmc->register_listener = guest_memfd_rdm_register_listener;
     rdmc->unregister_listener = guest_memfd_rdm_unregister_listener;
-- 
2.43.5


