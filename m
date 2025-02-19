Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79738C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 08:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkfQr-0006br-ME; Wed, 19 Feb 2025 03:27:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfQg-00066W-QD
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:27:41 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfQe-0004ge-VL
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739953657; x=1771489657;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Dh29gxAI0UuaBsVzjJ/FGrKdWjQRK2XyNd4DnP/LCxE=;
 b=Ibk4kxka8y8BbrXv3yWlWulcrgk5TkIQ6IvLTv8vI6sZ02wbxaWvhQt6
 wAhgqVNpKrdWF7xQC9UB65yjfBkN+Rc2TXiJq7R0sGhpr1LtMM6lEZi99
 7+GVdcmVpXldM/EM6kAOZTu89gJkFhn1T0QnSOZW/V0SqN5ENgW/jjutj
 OQdOaHDkdluRFLFzxRi1LBm+FwlR0LPRAviD+AZgavOE68bBIA2fd7W3q
 OQ8AOpeqXC2FsgT6PFAnQcf/2ohCTXVF8Fs2NDGlmzf2doXjArA/efoJq
 DkVZL9FjQdGDny3t6Vr1jDFB1jV7BvQoE4IRvn281IFmytUtbHdNjFU3/ w==;
X-CSE-ConnectionGUID: Q5tAOMqXQh2Gz99MCtnFcg==
X-CSE-MsgGUID: My3WnW/2SUO3iwnLclp3xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40544313"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="40544313"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:27:35 -0800
X-CSE-ConnectionGUID: fTxj8ptnTo+W/tUYy5wWkg==
X-CSE-MsgGUID: 1OcJ0nzZSoaYoFplt1NM1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119851437"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:27:30 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH rfcv2 18/20] intel_iommu: Refresh pasid bind when either SRTP
 or TE bit is changed
Date: Wed, 19 Feb 2025 16:22:26 +0800
Message-Id: <20250219082228.3303163-19-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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

From: Yi Liu <yi.l.liu@intel.com>

When either 'Set Root Table Pointer' or 'Translation Enable' bit is changed,
the pasid bindings on host side become stale and need to be updated.

Introduce a helper function vtd_refresh_pasid_bind() for that purpose.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 8f7fb473f5..225e332132 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -89,6 +89,7 @@ struct vtd_iotlb_key {
 
 static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
+static void vtd_refresh_pasid_bind(IntelIOMMUState *s);
 
 static void vtd_pasid_cache_reset(IntelIOMMUState *s);
 static void vtd_pasid_cache_sync(IntelIOMMUState *s,
@@ -3366,6 +3367,7 @@ static void vtd_handle_gcmd_srtp(IntelIOMMUState *s)
     vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_RTPS);
     vtd_reset_caches(s);
     vtd_address_space_refresh_all(s);
+    vtd_refresh_pasid_bind(s);
 }
 
 /* Set Interrupt Remap Table Pointer */
@@ -3400,6 +3402,7 @@ static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
 
     vtd_reset_caches(s);
     vtd_address_space_refresh_all(s);
+    vtd_refresh_pasid_bind(s);
 }
 
 /* Handle Interrupt Remap Enable/Disable */
@@ -4109,6 +4112,28 @@ static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
     }
 }
 
+static void vtd_refresh_pasid_bind(IntelIOMMUState *s)
+{
+    VTDPASIDCacheInfo pc_info = { .error_happened = false,
+                                  .type = VTD_PASID_CACHE_GLOBAL_INV };
+
+    /*
+     * Only when dmar is enabled, should pasid bindings replayed,
+     * otherwise no need to replay.
+     */
+    if (!s->dmar_enabled) {
+        return;
+    }
+
+    if (!s->flts || !s->root_scalable) {
+        return;
+    }
+
+    vtd_iommu_lock(s);
+    vtd_replay_guest_pasid_bindings(s, &pc_info);
+    vtd_iommu_unlock(s);
+}
+
 /*
  * This function syncs the pasid bindings between guest and host.
  * It includes updating the pasid cache in vIOMMU and updating the
-- 
2.34.1


