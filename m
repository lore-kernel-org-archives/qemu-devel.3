Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FC6C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 07:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdmF9-00029F-QL; Tue, 13 Aug 2024 03:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sdmF7-00028A-Ly
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 03:46:57 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sdmF5-0008Jo-TH
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 03:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723535216; x=1755071216;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IbOawFK9+LygvYERH9KQtidNUO1NdPUtZtJ8NRMQ4SU=;
 b=a+mcT+KioRH7ejOL/OB4QRdSjBdMw+A3n/G6oURfetV0JVDqevbWtOHW
 wU4FasspcqPo+UAeIAnGDRfFahxAUqS268FonyBw3XKu/QpYH7ZDGbIdo
 FLK434zuE3Hb34vDjcq8cpOnfJFjpO41CYFIAwL1vlEpOgRsQu7xKn26T
 lIvWiTRjUMzckBIn2uC/BgfjXtKsznnxRvsE6sdh4XbcaD7J9Hs4QpE6u
 x37CkPSkF5gLONKprdJWep4MGn0JpZiPSHtS6jSsTXU8jHU1FM1MICkP5
 iTXH7yJrLIlxx280Npd0qVE9v9PC7mktz2PwtiB6Rr4yO7cXRyX4HO0QD g==;
X-CSE-ConnectionGUID: P8h93cPzR8Ci0YHa1mWDdQ==
X-CSE-MsgGUID: 0iFYjeBjRhyyaakqNTcRYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="12980982"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="12980982"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 00:46:54 -0700
X-CSE-ConnectionGUID: us9jUICLTvWerIX09L5qqQ==
X-CSE-MsgGUID: EedKB2PcQOerPYBpnGebBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="59146265"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 00:46:52 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 1/2] intel_iommu: Fix invalidation descriptor type field
Date: Tue, 13 Aug 2024 15:44:09 +0800
Message-Id: <20240813074410.2571369-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813074410.2571369-1-zhenzhong.duan@intel.com>
References: <20240813074410.2571369-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

According to spec, invalidation descriptor type is 7bits which is
concatenation of bits[11:9] and bits[3:0] of invalidation descriptor.

Currently we only pick bits[3:0] as the invalidation type and treat
bits[11:9] as reserved zero. This is not a problem for now as bits[11:9]
is zero for all current invalidation types. But it will break if newer
type occupies bits[11:9].

Fix it by taking bits[11:9] into type and make reserved bits check accurate.

Suggested-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu_internal.h | 11 ++++++-----
 hw/i386/intel_iommu.c          |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 5f32c36943..13d5d129ae 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -356,7 +356,8 @@ union VTDInvDesc {
 typedef union VTDInvDesc VTDInvDesc;
 
 /* Masks for struct VTDInvDesc */
-#define VTD_INV_DESC_TYPE               0xf
+#define VTD_INV_DESC_TYPE(val)          ((((val) >> 5) & 0x70ULL) | \
+                                         ((val) & 0xfULL))
 #define VTD_INV_DESC_CC                 0x1 /* Context-cache Invalidate Desc */
 #define VTD_INV_DESC_IOTLB              0x2
 #define VTD_INV_DESC_DEVICE             0x3
@@ -372,7 +373,7 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_WAIT_IF            (1ULL << 4)
 #define VTD_INV_DESC_WAIT_FN            (1ULL << 6)
 #define VTD_INV_DESC_WAIT_DATA_SHIFT    32
-#define VTD_INV_DESC_WAIT_RSVD_LO       0Xffffff80ULL
+#define VTD_INV_DESC_WAIT_RSVD_LO       0Xfffff180ULL
 #define VTD_INV_DESC_WAIT_RSVD_HI       3ULL
 
 /* Masks for Context-cache Invalidation Descriptor */
@@ -383,7 +384,7 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_CC_DID(val)        (((val) >> 16) & VTD_DOMAIN_ID_MASK)
 #define VTD_INV_DESC_CC_SID(val)        (((val) >> 32) & 0xffffUL)
 #define VTD_INV_DESC_CC_FM(val)         (((val) >> 48) & 3UL)
-#define VTD_INV_DESC_CC_RSVD            0xfffc00000000ffc0ULL
+#define VTD_INV_DESC_CC_RSVD            0xfffc00000000f1c0ULL
 
 /* Masks for IOTLB Invalidate Descriptor */
 #define VTD_INV_DESC_IOTLB_G            (3ULL << 4)
@@ -393,7 +394,7 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_IOTLB_DID(val)     (((val) >> 16) & VTD_DOMAIN_ID_MASK)
 #define VTD_INV_DESC_IOTLB_ADDR(val)    ((val) & ~0xfffULL)
 #define VTD_INV_DESC_IOTLB_AM(val)      ((val) & 0x3fULL)
-#define VTD_INV_DESC_IOTLB_RSVD_LO      0xffffffff0000ff00ULL
+#define VTD_INV_DESC_IOTLB_RSVD_LO      0xffffffff0000f100ULL
 #define VTD_INV_DESC_IOTLB_RSVD_HI      0xf80ULL
 #define VTD_INV_DESC_IOTLB_PASID_PASID  (2ULL << 4)
 #define VTD_INV_DESC_IOTLB_PASID_PAGE   (3ULL << 4)
@@ -406,7 +407,7 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_DEVICE_IOTLB_SIZE(val) ((val) & 0x1)
 #define VTD_INV_DESC_DEVICE_IOTLB_SID(val) (((val) >> 32) & 0xFFFFULL)
 #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI 0xffeULL
-#define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0fff8
+#define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0f1f0
 
 /* Rsvd field masks for spte */
 #define VTD_SPTE_SNP 0x800ULL
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 16d2885fcc..68cb72a481 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2744,7 +2744,7 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         return false;
     }
 
-    desc_type = inv_desc.lo & VTD_INV_DESC_TYPE;
+    desc_type = VTD_INV_DESC_TYPE(inv_desc.lo);
     /* FIXME: should update at first or at last? */
     s->iq_last_desc_type = desc_type;
 
-- 
2.34.1


