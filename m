Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2460BC3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 07:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWsoS-0006Bc-TJ; Thu, 25 Jul 2024 03:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1sWsoO-0005xx-Bw
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:22:52 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1sWsoL-0001KE-9w
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721892169; x=1753428169;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w97J4M33cCw9TAhSRTajDSuiBoryiegLBL0geGMjfTo=;
 b=Ogat1gvGyq1Isqz7MF1PNXi/5N/UiLDhN+5sdSiWk5XZs8DZOCkdbFor
 W+avTm3l0whH52wXQtXR13TB12QR3wvTLQBieSyqoVhar5wxzcCPg0IpX
 HfkNVjRMUUQFvs5Yzio1kQLqRxsItcsN7gnrRWxnjhy14xg2CD0tiFlP7
 WFk57/bGWJMwty4w6CU/nhrmGIkw3j+7JS7jcl6bmPSnM4FValLLcdz/i
 5JP9wrE4hEe9CPd2O/HFc6geAxyxLskMmImslgjZsecKAyzEvAXHVwnZh
 ch+2wucrAs1dOsWILU8loC8ehx2mPOBrumbFt4LErCA9SBz8HDCSAcbIE w==;
X-CSE-ConnectionGUID: 4mPfPkaKR9quYbxzKMAAlg==
X-CSE-MsgGUID: kmo65k4sQviT6ppGgW8aEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="30753939"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; d="scan'208";a="30753939"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2024 00:22:46 -0700
X-CSE-ConnectionGUID: trBWNliyQSCF+mniCghpGg==
X-CSE-MsgGUID: Cj11aMxMTk2JVZHfE+JW4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; d="scan'208";a="52858154"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2024 00:22:43 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Edgecombe Rick P <rick.p.edgecombe@intel.com>,
 Wang Wei W <wei.w.wang@intel.com>, Peng Chao P <chao.p.peng@intel.com>,
 Gao Chao <chao.gao@intel.com>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: [RFC PATCH 2/6] guest_memfd: Introduce a helper to notify the
 shared/private state change
Date: Thu, 25 Jul 2024 03:21:11 -0400
Message-ID: <20240725072118.358923-3-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240725072118.358923-1-chenyi.qiang@intel.com>
References: <20240725072118.358923-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Introduce a helper function within RamDiscardManager to efficiently
notify all registered RamDiscardListeners, including VFIO listeners
about the memory conversion events between shared and private in
guest_memfd. The existing VFIO listener can dynamically DMA map/unmap
the shared pages based on the conversion type:
- For conversions from shared to private, the VFIO system ensures the
  discarding of shared mapping from the IOMMU.
- For conversions from private to shared, it triggers the population of
  the shared mapping into the IOMMU.

Additionally, there could be some special conversion requests:
- When a conversion request is made for a page already in the desired
  state (either private or shared), the helper simply returns success.
- For requests involving a range partially in the desired state, only
  the necessary segments are converted, ensuring the entire range
  complies with the request efficiently.
- In scenarios where a conversion request is declined by other systems,
  such as a failure from VFIO during notify_populate(), the helper will
  roll back the request, maintaining consistency.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 include/sysemu/guest-memfd-manager.h |   3 +
 system/guest-memfd-manager.c         | 141 +++++++++++++++++++++++++++
 2 files changed, 144 insertions(+)

diff --git a/include/sysemu/guest-memfd-manager.h b/include/sysemu/guest-memfd-manager.h
index ab8c2ba362..1cce4cde43 100644
--- a/include/sysemu/guest-memfd-manager.h
+++ b/include/sysemu/guest-memfd-manager.h
@@ -43,4 +43,7 @@ struct GuestMemfdManagerClass {
     void (*realize)(Object *gmm, MemoryRegion *mr, uint64_t region_size);
 };
 
+int guest_memfd_state_change(GuestMemfdManager *gmm, uint64_t offset, uint64_t size,
+                             bool shared_to_private);
+
 #endif
diff --git a/system/guest-memfd-manager.c b/system/guest-memfd-manager.c
index 7b90f26859..deb43db90b 100644
--- a/system/guest-memfd-manager.c
+++ b/system/guest-memfd-manager.c
@@ -243,6 +243,147 @@ static void guest_memfd_rdm_replay_discarded(const RamDiscardManager *rdm,
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
+        if (!guest_memfd_rdm_intersect_memory_section(&tmp, offset, size)) {
+            continue;
+        }
+
+        guest_memfd_for_each_populated_range(gmm, &tmp, rdl,
+                                             guest_memfd_notify_discard_cb);
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
+        if (!guest_memfd_rdm_intersect_memory_section(&tmp, offset, size)) {
+            continue;
+        }
+
+        ret = guest_memfd_for_each_discarded_range(gmm, &tmp, rdl,
+                                                   guest_memfd_notify_populate_cb);
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
+            if (!guest_memfd_rdm_intersect_memory_section(&tmp, offset, size)) {
+                continue;
+            }
+
+            guest_memfd_for_each_discarded_range(gmm, &tmp, rdl2,
+                                                 guest_memfd_notify_discard_cb);
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
+    found_bit = find_next_bit(gmm->discard_bitmap, last_bit + 1, first_bit);
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
+    found_bit = find_next_zero_bit(gmm->discard_bitmap, last_bit + 1, first_bit);
+    return found_bit > last_bit;
+}
+
+int guest_memfd_state_change(GuestMemfdManager *gmm, uint64_t offset, uint64_t size,
+                             bool shared_to_private)
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
+        g_assert((first_bit + nbits) <= gmm->discard_bitmap_size);
+
+        if (shared_to_private) {
+            bitmap_set(gmm->discard_bitmap, first_bit, nbits);
+        } else {
+            bitmap_clear(gmm->discard_bitmap, first_bit, nbits);
+        }
+
+        return 0;
+    }
+
+    return ret;
+}
+
 static void guest_memfd_manager_realize(Object *obj, MemoryRegion *mr,
                                         uint64_t region_size)
 {
-- 
2.43.5


