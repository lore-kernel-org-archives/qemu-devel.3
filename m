Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FC3CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 10:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNSwM-0007y9-S3; Thu, 14 May 2026 06:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wNSw7-0007s6-24
 for qemu-devel@nongnu.org; Thu, 14 May 2026 06:05:01 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wNSw2-0004S9-Ey
 for qemu-devel@nongnu.org; Thu, 14 May 2026 06:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778753095; x=1810289095;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+BLqURsj/4GVgeflQIwmatoKV0hGhqVWlZAtXVERMfY=;
 b=LVNEGVBn2sk0tvmfhujV/pDs6bL6Fr1MD8ALdDS39wvEv27GQ+VW4mtQ
 1x7jYPG0WJAt8VrYkWL1J8CH0Y79rvj1U4Yvszyoe0nndHow0JwarQmi3
 v7ed19hi7nbNIg8FdmrdGJfgkVEquiNOFS0Eejqb+VmYtI+xe7ZNx2q5k
 IDRYtfK2RPlyvdG7d8XWIGc4sp0MizLY0xWO7+uMHOE/RG8IqLVrKyTE8
 GTxM3/gNc09sbxdkfAOTtLgQYYRY1Ws+0u9S0ehlGP1iYyZNp3D8E01DH
 e5FvikKlpiHadk9Y/JBFI/uu8DFHzr+en9ePxpTEu3lfKTjUDzM+yuPgn A==;
X-CSE-ConnectionGUID: Uufdc/4bSrKYQtHm2PDffA==
X-CSE-MsgGUID: g4XcuYGyRHas7rwo4jzCVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="90796076"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="90796076"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 03:04:54 -0700
X-CSE-ConnectionGUID: x7VEPXeITFOz9wDGSMfR3A==
X-CSE-MsgGUID: ATc2XyCdQt6r1jo14lLPXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="243324922"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by orviesa005-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 03:04:49 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: zhenzhong.duan@intel.com, yi.l.liu@intel.com, philmd@linaro.org,
 mst@redhat.com, jasowang@redhat.com, clement.mathieu--drif@bull.com,
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, farosas@suse.de, lvivier@redhat.com,
 Junjie Cao <junjie.cao@intel.com>
Subject: [PATCH v4 1/2] intel_iommu: fix guest-triggerable abort on oversized
 MMIO access
Date: Fri, 15 May 2026 02:07:02 +0800
Message-ID: <20260514180703.85686-2-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514180703.85686-1-junjie.cao@intel.com>
References: <20260514180703.85686-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

An 8-byte guest access to a 32-bit-only VT-d register hit
assert(size == 4) and aborted QEMU.  Remove all 25 asserts.

All 3 read-side and 18 of 22 write-side asserts are at
non-8-aligned offsets (unreachable, rejected by
memory_region_access_valid()) -- simply deleted.

The remaining 4, all writes at 8-aligned offsets, are
reachable: FECTL 0x38, IECTL 0xa0, IEADDR 0xa8, PECTL 0xe0.
Truncating the high half via vtd_set_long() matches prior
behavior; log under -d guest_errors since the VT-d spec is
silent on oversized accesses to 32-bit registers, and add a
comment so future maintainers don't delete the check as
"harmless".  min_access_size stays 4, so all size-based
branches on 64-bit register pairs are preserved.

Found by generic-fuzz (24 distinct crash seeds, all fixed).

Suggested-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/i386/intel_iommu.c | 74 ++++++++++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 25 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b784c5f10a..17f897177d 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -21,6 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "hw/core/sysbus.h"
@@ -3713,7 +3714,6 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
         break;
 
     case DMAR_RTADDR_REG_HI:
-        assert(size == 4);
         val = vtd_get_quad_raw(s, DMAR_RTADDR_REG) >> 32;
         break;
 
@@ -3728,12 +3728,10 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
         break;
 
     case DMAR_IQA_REG_HI:
-        assert(size == 4);
         val = s->iq >> 32;
         break;
 
     case DMAR_PEUADDR_REG:
-        assert(size == 4);
         val = vtd_get_long_raw(s, DMAR_PEUADDR_REG);
         break;
 
@@ -3779,7 +3777,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_CCMD_REG_HI:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         vtd_handle_ccmd_write(s);
         break;
@@ -3795,13 +3792,11 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
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
 
@@ -3815,27 +3810,35 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
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
+        /*
+         * 32-bit register at an 8-byte-aligned offset: a well-formed
+         * 8-byte guest access reaches this handler.  vtd_set_long()
+         * takes uint32_t and truncates the high half -- undefined per
+         * the VT-d spec but harmless here.  Flag it under
+         * -d guest_errors so the guest-side bug surfaces.
+         */
+        if (size != 4) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: invalid %u-byte access to 32-bit reg "
+                          "addr=0x%" PRIx64 "\n", __func__, size, addr);
+        }
         vtd_set_long(s, addr, val);
         vtd_handle_fectl_write(s);
         break;
 
     /* Fault Event Data Register, 32-bit */
     case DMAR_FEDATA_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
@@ -3854,13 +3857,11 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
 
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
 
@@ -3874,7 +3875,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_RTADDR_REG_HI:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
@@ -3889,7 +3889,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_IQT_REG_HI:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         /* 19:63 of IQT_REG is RsvdZ, do nothing here */
         break;
@@ -3905,39 +3904,57 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
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
+        /*
+         * 32-bit register at an 8-byte-aligned offset: a well-formed
+         * 8-byte guest access reaches this handler.  vtd_set_long()
+         * takes uint32_t and truncates the high half -- undefined per
+         * the VT-d spec but harmless here.  Flag it under
+         * -d guest_errors so the guest-side bug surfaces.
+         */
+        if (size != 4) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: invalid %u-byte access to 32-bit reg "
+                          "addr=0x%" PRIx64 "\n", __func__, size, addr);
+        }
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
+        /*
+         * 32-bit register at an 8-byte-aligned offset: a well-formed
+         * 8-byte guest access reaches this handler.  vtd_set_long()
+         * takes uint32_t and truncates the high half -- undefined per
+         * the VT-d spec but harmless here.  Flag it under
+         * -d guest_errors so the guest-side bug surfaces.
+         */
+        if (size != 4) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: invalid %u-byte access to 32-bit reg "
+                          "addr=0x%" PRIx64 "\n", __func__, size, addr);
+        }
         vtd_set_long(s, addr, val);
         break;
 
     /* Invalidation Event Upper Address Register, 32-bit */
     case DMAR_IEUADDR_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
@@ -3951,7 +3968,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_FRCD_REG_0_1:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
@@ -3966,7 +3982,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_FRCD_REG_0_3:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         /* May clear bit 127 (Fault), update PPF */
         vtd_update_fsts_ppf(s);
@@ -3981,18 +3996,27 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
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
+        /*
+         * 32-bit register at an 8-byte-aligned offset: a well-formed
+         * 8-byte guest access reaches this handler.  vtd_set_long()
+         * takes uint32_t and truncates the high half -- undefined per
+         * the VT-d spec but harmless here.  Flag it under
+         * -d guest_errors so the guest-side bug surfaces.
+         */
+        if (size != 4) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: invalid %u-byte access to 32-bit reg "
+                          "addr=0x%" PRIx64 "\n", __func__, size, addr);
+        }
         vtd_set_long(s, addr, val);
         vtd_handle_pectl_write(s);
         break;
-- 
2.43.0


