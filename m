Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABD0CD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 03:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKSo9-0005tr-01; Tue, 05 May 2026 23:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wKSo6-0005sB-Or
 for qemu-devel@nongnu.org; Tue, 05 May 2026 23:20:18 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wKSo4-0002XZ-Ny
 for qemu-devel@nongnu.org; Tue, 05 May 2026 23:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778037617; x=1809573617;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=V6Ii8lkI9IFtDYkoeVnwfuw2DIQo0enE6R+AMNGXNSA=;
 b=mcljC2R6Hz96Ug3DqBi5iIGTthbjejxgxC+cJQkhDsQNNhXXMHCXRgy4
 XsMFgdr655RJaMFMeMMoHJN31UOS6YUYWR0mTVvCdBxplKuPbzPur2I/g
 aEf9HmGX2dZlLDryfX66Sqo4ZEK0YTYyDHniV7uMOFes6hH+KvWvIU0FS
 rbAp793tgpdExH026S1kli3mJ6swr5+qcPYPFAdetIUfYFXjtdtD7ksD7
 hUJ6sTYJHr0OuA8fAt6iqsjzb4O4F/ILxQ8FArM+KPf1ShNDEL0yN/h0l
 G1kTvrwydX3EwKd2/WdFw9IGUTn8pbjObjSAA55lF3Lc/iTRPrFlkvI2q g==;
X-CSE-ConnectionGUID: 8+zgk3TSTNG/peLFDDopxA==
X-CSE-MsgGUID: oin4y7CkQI6cs4LXCJaCVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78783049"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; d="scan'208";a="78783049"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 20:20:16 -0700
X-CSE-ConnectionGUID: QecsSR/lQfmUTVlf5GVaXg==
X-CSE-MsgGUID: vdAQ3pj9SD6OvAX52kXLsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; d="scan'208";a="231417005"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 20:20:12 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: junjie.cao@intel.com, zhenzhong.duan@intel.com, philmd@linaro.org,
 mst@redhat.com, jasowang@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@bull.com, marcel.apfelbaum@gmail.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, farosas@suse.de,
 lvivier@redhat.com
Subject: [PATCH v3 1/2] intel_iommu: fix guest-triggerable abort on oversized
 MMIO access
Date: Wed,  6 May 2026 11:19:41 +0800
Message-ID: <20260506031942.251335-2-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DS4PPF93A1BBECDC498B677FE8B259BCEAD92352@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
References: <DS4PPF93A1BBECDC498B677FE8B259BCEAD92352@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

21 sit at non-8-byte-aligned offsets and are rejected by
memory_region_access_valid() before reaching the handler -- dead
code, simply deleted.

The remaining 4 guard 8-byte-aligned 32-bit registers reachable
by a well-formed 8-byte access (FECTL 0x38, IECTL 0xa0, IEADDR
0xa8, PECTL 0xe0).  Writes fall through to vtd_set_long(), which
takes uint32_t and implicitly truncates, and log a guest error.
Reads fall through to the default vtd_get_quad() -- equivalent
to two 4-byte reads and therefore harmless, no warn needed.
min_access_size stays 4, so all size-based branches on 64-bit
register pairs are preserved.

Found by generic-fuzz (24 distinct crash seeds, all fixed).

Suggested-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/i386/intel_iommu.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f395fa248c..0fb89332f9 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3713,7 +3713,6 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
         break;
 
     case DMAR_RTADDR_REG_HI:
-        assert(size == 4);
         val = vtd_get_quad_raw(s, DMAR_RTADDR_REG) >> 32;
         break;
 
@@ -3728,12 +3727,10 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
         break;
 
     case DMAR_IQA_REG_HI:
-        assert(size == 4);
         val = s->iq >> 32;
         break;
 
     case DMAR_PEUADDR_REG:
-        assert(size == 4);
         val = vtd_get_long_raw(s, DMAR_PEUADDR_REG);
         break;
 
@@ -3779,7 +3776,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_CCMD_REG_HI:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         vtd_handle_ccmd_write(s);
         break;
@@ -3795,13 +3791,11 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
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
 
@@ -3815,27 +3809,27 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
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
+        if (size != 4) {
+            error_report_once("%s: invalid %u-byte access to 32-bit reg "
+                              "addr=0x%" PRIx64, __func__, size, addr);
+        }
         vtd_set_long(s, addr, val);
         vtd_handle_fectl_write(s);
         break;
 
     /* Fault Event Data Register, 32-bit */
     case DMAR_FEDATA_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
@@ -3854,13 +3848,11 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
 
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
 
@@ -3874,7 +3866,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_RTADDR_REG_HI:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
@@ -3889,7 +3880,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_IQT_REG_HI:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         /* 19:63 of IQT_REG is RsvdZ, do nothing here */
         break;
@@ -3905,39 +3895,41 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
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
+        if (size != 4) {
+            error_report_once("%s: invalid %u-byte access to 32-bit reg "
+                              "addr=0x%" PRIx64, __func__, size, addr);
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
+        if (size != 4) {
+            error_report_once("%s: invalid %u-byte access to 32-bit reg "
+                              "addr=0x%" PRIx64, __func__, size, addr);
+        }
         vtd_set_long(s, addr, val);
         break;
 
     /* Invalidation Event Upper Address Register, 32-bit */
     case DMAR_IEUADDR_REG:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
@@ -3951,7 +3943,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_FRCD_REG_0_1:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
@@ -3966,7 +3957,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_FRCD_REG_0_3:
-        assert(size == 4);
         vtd_set_long(s, addr, val);
         /* May clear bit 127 (Fault), update PPF */
         vtd_update_fsts_ppf(s);
@@ -3981,18 +3971,19 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
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
+        if (size != 4) {
+            error_report_once("%s: invalid %u-byte access to 32-bit reg "
+                              "addr=0x%" PRIx64, __func__, size, addr);
+        }
         vtd_set_long(s, addr, val);
         vtd_handle_pectl_write(s);
         break;
-- 
2.43.0


