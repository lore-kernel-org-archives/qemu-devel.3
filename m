Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46D7F557E9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 09:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEkWk-0007rd-LZ; Mon, 20 Apr 2026 05:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wEkWe-0007r4-0G
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 05:02:41 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wEkWZ-0002DP-N0
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 05:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776675756; x=1808211756;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0/HFh7EksONO9l1F5lm06dR81poht8axcQuF/OzYr88=;
 b=LkwaXP7rURWaoKbHvA6LKLZ9bO4z6v/xrb84k+XCXrnRVa9u4KJYsKnE
 71KDhdc9mIi4rZQ7QFohl1TtRWPZApH4QIwrWMRyXcTUiDH2cr/iyH9QV
 gFvpJcOiGJztBoCGRiEjcui8BqvgB99knlbk9KBQ6L7yJp78gCayGd54J
 SlFQEbkK/VheAnS8+jhK+pAAI28znh/YQEI7rlaNzPRRYCj0jS1eZZVZT
 XxERgdBUFKrMpciG3GiZi1M4qKhIV0GBwzR83aZbiy2gROa2wBGCjSKy0
 XaQNN942e4XI2F2ADA4pSVEUvxY4l3p2RjVhTHxTSWbWdGnaHNIVJtCdV Q==;
X-CSE-ConnectionGUID: 9zco6mcaR6KrWuNYn685ug==
X-CSE-MsgGUID: UIdU9xv2TreE1ZQfIxmNUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="81457562"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="81457562"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 02:02:31 -0700
X-CSE-ConnectionGUID: ZcQUMxpYS+uK7HbEclFNEw==
X-CSE-MsgGUID: KFqBIiwXRfydilCMWAd/Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="262049195"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by orviesa002-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 02:02:28 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 yi.l.liu@intel.com,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, farosas@suse.de, lvivier@redhat.com,
 junjie.cao@intel.com
Subject: [PATCH 1/2] intel_iommu: Replace assert(size == 4) with guest error
 in MMIO handlers
Date: Tue, 21 Apr 2026 01:05:22 +0800
Message-ID: <20260420170523.17908-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=junjie.cao@intel.com;
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

vtd_mem_read() and vtd_mem_write() use assert(size == 4) for
32-bit-only VT-d registers. Since MemoryRegionOps .valid/.impl
accepts sizes 4 through 8, an 8-byte guest access passes framework
validation and reaches the handler, where the assertion aborts QEMU.

Narrowing .impl.max_access_size to 4 is not viable because VT-d has
64-bit registers (e.g. DMAR_CCMD_REG, DMAR_IQA_REG) that require
atomic 8-byte access to trigger command execution.

Replace all 22 asserts in vtd_mem_write() and 3 in vtd_mem_read()
with a size check that logs via qemu_log_mask(LOG_GUEST_ERROR) and
returns without performing the register access. The asymmetry
(22 vs 3) is because vtd_mem_read() handles most registers through
its default branch, so only three explicit cases carried an assert.

Found by fuzzing with QEMU's generic-fuzz framework; crashes
reproduced at DMAR_FECTL_REG, DMAR_IECTL_REG, DMAR_IEADDR_REG
and DMAR_PECTL_REG; all 25 sites share the same root cause.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/i386/intel_iommu.c | 114 +++++++++++++++++++++++++++++++++---------
 1 file changed, 89 insertions(+), 25 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f395fa248c..1b91055eef 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -21,6 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "hw/core/sysbus.h"
@@ -3713,7 +3714,9 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
         break;
 
     case DMAR_RTADDR_REG_HI:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         val = vtd_get_quad_raw(s, DMAR_RTADDR_REG) >> 32;
         break;
 
@@ -3728,12 +3731,16 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
         break;
 
     case DMAR_IQA_REG_HI:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         val = s->iq >> 32;
         break;
 
     case DMAR_PEUADDR_REG:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         val = vtd_get_long_raw(s, DMAR_PEUADDR_REG);
         break;
 
@@ -3746,6 +3753,12 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
     }
 
     return val;
+
+err_width:
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: invalid read size %u at offset 0x%" PRIx64 "\n",
+                  __func__, size, addr);
+    return (uint64_t)-1;
 }
 
 static void vtd_mem_write(void *opaque, hwaddr addr,
@@ -3779,7 +3792,9 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_CCMD_REG_HI:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         vtd_set_long(s, addr, val);
         vtd_handle_ccmd_write(s);
         break;
@@ -3795,13 +3810,17 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_IOTLB_REG_HI:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         vtd_set_long(s, addr, val);
         vtd_handle_iotlb_write(s);
         break;
 
     case DMAR_PEUADDR_REG:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         vtd_set_long(s, addr, val);
         break;
 
@@ -3815,27 +3834,35 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_IVA_REG_HI:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         vtd_set_long(s, addr, val);
         break;
 
     /* Fault Status Register, 32-bit */
     case DMAR_FSTS_REG:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         vtd_set_long(s, addr, val);
         vtd_handle_fsts_write(s);
         break;
 
     /* Fault Event Control Register, 32-bit */
     case DMAR_FECTL_REG:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         vtd_set_long(s, addr, val);
         vtd_handle_fectl_write(s);
         break;
 
     /* Fault Event Data Register, 32-bit */
     case DMAR_FEDATA_REG:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         vtd_set_long(s, addr, val);
         break;
 
@@ -3854,13 +3881,17 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
 
     /* Fault Event Upper Address Register, 32-bit */
     case DMAR_FEUADDR_REG:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         vtd_set_long(s, addr, val);
         break;
 
     /* Protected Memory Enable Register, 32-bit */
     case DMAR_PMEN_REG:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         vtd_set_long(s, addr, val);
         break;
 
@@ -3874,7 +3905,9 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_RTADDR_REG_HI:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         vtd_set_long(s, addr, val);
         break;
 
@@ -3889,7 +3922,9 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_IQT_REG_HI:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         vtd_set_long(s, addr, val);
         /* 19:63 of IQT_REG is RsvdZ, do nothing here */
         break;
@@ -3905,39 +3940,51 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_IQA_REG_HI:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         vtd_set_long(s, addr, val);
         break;
 
     /* Invalidation Completion Status Register, 32-bit */
     case DMAR_ICS_REG:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         vtd_set_long(s, addr, val);
         vtd_handle_ics_write(s);
         break;
 
     /* Invalidation Event Control Register, 32-bit */
     case DMAR_IECTL_REG:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         vtd_set_long(s, addr, val);
         vtd_handle_iectl_write(s);
         break;
 
     /* Invalidation Event Data Register, 32-bit */
     case DMAR_IEDATA_REG:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         vtd_set_long(s, addr, val);
         break;
 
     /* Invalidation Event Address Register, 32-bit */
     case DMAR_IEADDR_REG:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         vtd_set_long(s, addr, val);
         break;
 
     /* Invalidation Event Upper Address Register, 32-bit */
     case DMAR_IEUADDR_REG:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         vtd_set_long(s, addr, val);
         break;
 
@@ -3951,7 +3998,9 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_FRCD_REG_0_1:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         vtd_set_long(s, addr, val);
         break;
 
@@ -3966,7 +4015,9 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_FRCD_REG_0_3:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         vtd_set_long(s, addr, val);
         /* May clear bit 127 (Fault), update PPF */
         vtd_update_fsts_ppf(s);
@@ -3981,18 +4032,24 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_IRTA_REG_HI:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         vtd_set_long(s, addr, val);
         break;
 
     case DMAR_PRS_REG:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         vtd_set_long(s, addr, val);
         vtd_handle_prs_write(s);
         break;
 
     case DMAR_PECTL_REG:
-        assert(size == 4);
+        if (size != 4) {
+            goto err_width;
+        }
         vtd_set_long(s, addr, val);
         vtd_handle_pectl_write(s);
         break;
@@ -4004,6 +4061,13 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
             vtd_set_quad(s, addr, val);
         }
     }
+
+    return;
+
+err_width:
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: invalid write size %u at offset 0x%" PRIx64 "\n",
+                  __func__, size, addr);
 }
 
 static void vtd_prepare_identity_entry(hwaddr addr, IOMMUAccessFlags perm,
-- 
2.43.0


