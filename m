Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2496BFE5215
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 12:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGFSH-0002YH-Ge; Fri, 24 Apr 2026 08:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wGFS2-0002WH-4I
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 08:16:08 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wGFRz-0002Cx-6T
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 08:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777032963; x=1808568963;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=I2CalveJmINak9hL6z6R/gQ3HHeQaE7OTNeBaf8Pqdg=;
 b=WNz6ooTHhc4staxJTMtPxjBXyHypzJEolarGlg2/iWrswNcbhghdC8L0
 xGyf2QOfuriT7fwgUggHvsouFAjVU5PWoPw8a9eD0ryueY5W3U/qNDk2p
 rxGbAhDHKfujqRdVxexpuza9EuWKGFGAzt6M5o2LyPx4wqe07wOKvF84z
 FC4/jFnlwvOvOu5KwSiW6x+U8hDfVQSxk2Ju95usmdb7Em5HLdy9hHxMP
 souBdEawQbHUA4D4wZ6uwBGhbC8+T946+aR70Jcg0FRGjZRTKhEJR7Gbx
 tcTRH7cjdMNM0wDFe6SQ3TpqmAFFTn/EEyoFNNcOABQF4dI7i5Pq18si4 w==;
X-CSE-ConnectionGUID: ymxTPIy3R2u5yhWU/z6bvQ==
X-CSE-MsgGUID: ZoWdkWlDQYmg0XZSD+EzWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="78029979"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; d="scan'208";a="78029979"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2026 05:16:01 -0700
X-CSE-ConnectionGUID: bdy9EzsnTOOaBwPgITz7uw==
X-CSE-MsgGUID: V8fKUnEjQAmvP3Nnrd4CFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; d="scan'208";a="237935768"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by fmviesa005-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 05:15:59 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: junjie.cao@intel.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@bull.com, philmd@linaro.org,
 zhenzhong.duan@intel.com
Subject: [PATCH v2 1/2] intel_iommu: widen impl.min_access_size to 8 to fix
 MMIO abort
Date: Sat, 25 Apr 2026 04:18:41 +0800
Message-ID: <20260424201842.176953-2-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424201842.176953-1-junjie.cao@intel.com>
References: <20260424201842.176953-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Raise .impl.min_access_size from 4 to 8 in vtd_mem_ops so the memory
subsystem always widens guest accesses to 8 bytes before calling the
handler.  This eliminates all 25 assert(size == 4) sites that crashed
QEMU on an 8-byte access to a 32-bit-only register.

With size always 8, the if/else branches for 64-bit register pairs
collapse.  A zero-extended 4-byte write to the low half is safe:
wmask protects read-only upper bits, and trigger functions re-read
the register file and guard on their action bits.

The entry bounds check is relaxed to `addr >= DMAR_REG_SIZE` since
the widened size no longer reflects the guest access width; the
framework guarantees addr stays within the MemoryRegion.  Default
branches fall back to vtd_get/set_long() when addr + 8 would exceed
the register file.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/i386/intel_iommu.c | 121 ++++++++----------------------------------
 1 file changed, 23 insertions(+), 98 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f395fa248c..4b25907778 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3697,7 +3697,7 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
 
     trace_vtd_reg_read(addr, size);
 
-    if (addr + size > DMAR_REG_SIZE) {
+    if (addr >= DMAR_REG_SIZE) {
         error_report_once("%s: MMIO over range: addr=0x%" PRIx64
                           " size=0x%x", __func__, addr, size);
         return (uint64_t)-1;
@@ -3707,13 +3707,9 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
     /* Root Table Address Register, 64-bit */
     case DMAR_RTADDR_REG:
         val = vtd_get_quad_raw(s, DMAR_RTADDR_REG);
-        if (size == 4) {
-            val = val & ((1ULL << 32) - 1);
-        }
         break;
 
     case DMAR_RTADDR_REG_HI:
-        assert(size == 4);
         val = vtd_get_quad_raw(s, DMAR_RTADDR_REG) >> 32;
         break;
 
@@ -3722,26 +3718,21 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
         val = s->iq |
               (vtd_get_quad(s, DMAR_IQA_REG) &
               (VTD_IQA_QS | VTD_IQA_DW_MASK));
-        if (size == 4) {
-            val = val & ((1ULL << 32) - 1);
-        }
         break;
 
     case DMAR_IQA_REG_HI:
-        assert(size == 4);
         val = s->iq >> 32;
         break;
 
     case DMAR_PEUADDR_REG:
-        assert(size == 4);
         val = vtd_get_long_raw(s, DMAR_PEUADDR_REG);
         break;
 
     default:
-        if (size == 4) {
-            val = vtd_get_long(s, addr);
-        } else {
+        if (addr + 8 <= DMAR_REG_SIZE) {
             val = vtd_get_quad(s, addr);
+        } else {
+            val = vtd_get_long(s, addr);
         }
     }
 
@@ -3755,7 +3746,7 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
 
     trace_vtd_reg_write(addr, size, val);
 
-    if (addr + size > DMAR_REG_SIZE) {
+    if (addr >= DMAR_REG_SIZE) {
         error_report_once("%s: MMIO over range: addr=0x%" PRIx64
                           " size=0x%x", __func__, addr, size);
         return;
@@ -3770,238 +3761,172 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
 
     /* Context Command Register, 64-bit */
     case DMAR_CCMD_REG:
-        if (size == 4) {
-            vtd_set_long(s, addr, val);
-        } else {
-            vtd_set_quad(s, addr, val);
-            vtd_handle_ccmd_write(s);
-        }
+        vtd_set_quad(s, addr, val);
+        vtd_handle_ccmd_write(s);
         break;
 
     case DMAR_CCMD_REG_HI:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         vtd_handle_ccmd_write(s);
         break;
 
     /* IOTLB Invalidation Register, 64-bit */
     case DMAR_IOTLB_REG:
-        if (size == 4) {
-            vtd_set_long(s, addr, val);
-        } else {
-            vtd_set_quad(s, addr, val);
-            vtd_handle_iotlb_write(s);
-        }
+        vtd_set_quad(s, addr, val);
+        vtd_handle_iotlb_write(s);
         break;
 
     case DMAR_IOTLB_REG_HI:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         vtd_handle_iotlb_write(s);
         break;
 
     case DMAR_PEUADDR_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Invalidate Address Register, 64-bit */
     case DMAR_IVA_REG:
-        if (size == 4) {
-            vtd_set_long(s, addr, val);
-        } else {
-            vtd_set_quad(s, addr, val);
-        }
+        vtd_set_quad(s, addr, val);
         break;
 
     case DMAR_IVA_REG_HI:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Fault Status Register, 32-bit */
     case DMAR_FSTS_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         vtd_handle_fsts_write(s);
         break;
 
     /* Fault Event Control Register, 32-bit */
     case DMAR_FECTL_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         vtd_handle_fectl_write(s);
         break;
 
     /* Fault Event Data Register, 32-bit */
     case DMAR_FEDATA_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Fault Event Address Register, 32-bit */
     case DMAR_FEADDR_REG:
-        if (size == 4) {
-            vtd_set_long(s, addr, val);
-        } else {
-            /*
-             * While the register is 32-bit only, some guests (Xen...) write to
-             * it with 64-bit.
-             */
-            vtd_set_quad(s, addr, val);
-        }
+        vtd_set_quad(s, addr, val);
         break;
 
     /* Fault Event Upper Address Register, 32-bit */
     case DMAR_FEUADDR_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Protected Memory Enable Register, 32-bit */
     case DMAR_PMEN_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Root Table Address Register, 64-bit */
     case DMAR_RTADDR_REG:
-        if (size == 4) {
-            vtd_set_long(s, addr, val);
-        } else {
-            vtd_set_quad(s, addr, val);
-        }
+        vtd_set_quad(s, addr, val);
         break;
 
     case DMAR_RTADDR_REG_HI:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Invalidation Queue Tail Register, 64-bit */
     case DMAR_IQT_REG:
-        if (size == 4) {
-            vtd_set_long(s, addr, val);
-        } else {
-            vtd_set_quad(s, addr, val);
-        }
+        vtd_set_quad(s, addr, val);
         vtd_handle_iqt_write(s);
         break;
 
     case DMAR_IQT_REG_HI:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         /* 19:63 of IQT_REG is RsvdZ, do nothing here */
         break;
 
     /* Invalidation Queue Address Register, 64-bit */
     case DMAR_IQA_REG:
-        if (size == 4) {
-            vtd_set_long(s, addr, val);
-        } else {
-            vtd_set_quad(s, addr, val);
-        }
+        vtd_set_quad(s, addr, val);
         vtd_update_iq_dw(s);
         break;
 
     case DMAR_IQA_REG_HI:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Invalidation Completion Status Register, 32-bit */
     case DMAR_ICS_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         vtd_handle_ics_write(s);
         break;
 
     /* Invalidation Event Control Register, 32-bit */
     case DMAR_IECTL_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         vtd_handle_iectl_write(s);
         break;
 
     /* Invalidation Event Data Register, 32-bit */
     case DMAR_IEDATA_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Invalidation Event Address Register, 32-bit */
     case DMAR_IEADDR_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Invalidation Event Upper Address Register, 32-bit */
     case DMAR_IEUADDR_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Fault Recording Registers, 128-bit */
     case DMAR_FRCD_REG_0_0:
-        if (size == 4) {
-            vtd_set_long(s, addr, val);
-        } else {
-            vtd_set_quad(s, addr, val);
-        }
+        vtd_set_quad(s, addr, val);
         break;
 
     case DMAR_FRCD_REG_0_1:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     case DMAR_FRCD_REG_0_2:
-        if (size == 4) {
-            vtd_set_long(s, addr, val);
-        } else {
-            vtd_set_quad(s, addr, val);
-            /* May clear bit 127 (Fault), update PPF */
-            vtd_update_fsts_ppf(s);
-        }
+        vtd_set_quad(s, addr, val);
+        /* May clear bit 127 (Fault), update PPF */
+        vtd_update_fsts_ppf(s);
         break;
 
     case DMAR_FRCD_REG_0_3:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         /* May clear bit 127 (Fault), update PPF */
         vtd_update_fsts_ppf(s);
         break;
 
     case DMAR_IRTA_REG:
-        if (size == 4) {
-            vtd_set_long(s, addr, val);
-        } else {
-            vtd_set_quad(s, addr, val);
-        }
+        vtd_set_quad(s, addr, val);
         break;
 
     case DMAR_IRTA_REG_HI:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     case DMAR_PRS_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         vtd_handle_prs_write(s);
         break;
 
     case DMAR_PECTL_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         vtd_handle_pectl_write(s);
         break;
 
     default:
-        if (size == 4) {
-            vtd_set_long(s, addr, val);
-        } else {
+        if (addr + 8 <= DMAR_REG_SIZE) {
             vtd_set_quad(s, addr, val);
+        } else {
+            vtd_set_long(s, addr, val);
         }
     }
 }
@@ -4184,7 +4109,7 @@ static const MemoryRegionOps vtd_mem_ops = {
     .write = vtd_mem_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
-        .min_access_size = 4,
+        .min_access_size = 8,
         .max_access_size = 8,
     },
     .valid = {
-- 
2.43.0


