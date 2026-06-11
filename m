Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2907ECD8CB9
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXZIc-00007T-5r; Thu, 11 Jun 2026 02:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wXZIX-00006y-W6
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:53:54 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wXZIW-0007XG-76
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781160833; x=1812696833;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XslrJf12EJ3eRNweZWttn06qZaJHFF63Vau0ofOISDk=;
 b=EiDtO6R+rOmRnGGXKezUoHKR0Qme+YU1leqxa5Sl7xcthwMD9cU25VLu
 1cs54qYMJR9PUnOxmJXKS5ABa8bUlNIERnVK68FRiV25sWFhG/VUPVZ8E
 uGmEVZ/jacB7YqjZIOqgq7/v3hmA2cifSXXfRvwSl4833Ux3aWT+EdHsh
 dAeM7NFhb6zUDDoNvdiWe6uPeUhP8EiWVLIGLx9MmyMeMvRhuNH9eZWx0
 UlG3sKUUuL8nhU5bGw/arrdsqjBQQeHBQVE6yfLdc7PQwOhB3PYSEq0Q7
 k5l4uTyuiRB1bBEtp2KxPLWne99S/e+ZRFYWcbWk3HhrgHcxmZpoo9o08 Q==;
X-CSE-ConnectionGUID: x2QIjn39R2SMUVhkwIv2Dg==
X-CSE-MsgGUID: OOqGuOMxSTGhMM+vsaP1gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85595472"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="85595472"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 23:53:52 -0700
X-CSE-ConnectionGUID: ONMn0cpuST+k+fUZDPrknw==
X-CSE-MsgGUID: VgodT8ZGTN22uX4QGF7vkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="246469799"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 23:53:50 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: jic23@kernel.org
Cc: fan.ni@samsung.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 junjie.cao@intel.com
Subject: [PATCH v2 3/5] hw/cxl: trace HDM decoder write, commit and uncommit
Date: Thu, 11 Jun 2026 14:30:25 +0800
Message-ID: <20260611063027.1166493-4-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611063027.1166493-1-junjie.cao@intel.com>
References: <20260611063027.1166493-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Add trace events for HDM decoder programming in the CXL Type-3 device
model.  These paths control address-decode behaviour and are among the
most frequently debugged during CXL topology bring-up.

Three trace points are added:

  cxl_hdm_decoder_write    - guest write to a decoder CTRL register,
                             with the raw value and commit flag
  cxl_hdm_decoder_commit   - actual commit with decoded base, size,
                             interleave ways (IW) and granularity (IG)
  cxl_hdm_decoder_uncommit - decoder uncommit with index

Base and size are extracted using the same split-register pattern
(ldl_le_p + 0xf0000000 mask) used by cxl_hdm_find_target() in
cxl-host.c, producing architecturally-meaningful addresses.  IW and
IG are extracted from CTRL via FIELD_EX32.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/mem/cxl_type3.c  | 19 ++++++++++++++++++-
 hw/mem/trace-events |  5 +++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4739239da3..c3f7483b70 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -30,6 +30,7 @@
 #include "system/numa.h"
 #include "hw/cxl/cxl.h"
 #include "hw/pci/msix.h"
+#include "trace.h"
 
 /* type3 device private */
 enum CXL_T3_MSIX_VECTOR {
@@ -419,13 +420,24 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
     int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
     ComponentRegisters *cregs = &ct3d->cxl_cstate.crb;
     uint32_t *cache_mem = cregs->cache_mem_registers;
-    uint32_t ctrl;
+    uint32_t ctrl, low, high;
+    uint64_t base, size;
 
     ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc);
     /* TODO: Sanity checks that the decoder is possible */
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
 
+    low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + which * hdm_inc);
+    high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + which * hdm_inc);
+    base = (low & 0xf0000000) | ((uint64_t)high << 32);
+    low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + which * hdm_inc);
+    high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + which * hdm_inc);
+    size = (low & 0xf0000000) | ((uint64_t)high << 32);
+    trace_cxl_hdm_decoder_commit(which, base, size,
+                                 FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW),
+                                 FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG));
+
     stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
 }
 
@@ -436,6 +448,8 @@ static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
     uint32_t *cache_mem = cregs->cache_mem_registers;
     uint32_t ctrl;
 
+    trace_cxl_hdm_decoder_uncommit(which);
+
     ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc);
 
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
@@ -623,6 +637,9 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
     }
 
     stl_le_p((uint8_t *)cache_mem + offset, value);
+    if (which_hdm >= 0) {
+        trace_cxl_hdm_decoder_write(which_hdm, value, should_commit);
+    }
     if (should_commit) {
         hdm_decoder_commit(ct3d, which_hdm);
     } else if (should_uncommit) {
diff --git a/hw/mem/trace-events b/hw/mem/trace-events
index 8b6b02b5bf..07c7315148 100644
--- a/hw/mem/trace-events
+++ b/hw/mem/trace-events
@@ -6,3 +6,8 @@ mhp_pc_dimm_assigned_slot(int slot) "%d"
 memory_device_pre_plug(const char *id, uint64_t addr) "id=%s addr=0x%"PRIx64
 memory_device_plug(const char *id, uint64_t addr) "id=%s addr=0x%"PRIx64
 memory_device_unplug(const char *id, uint64_t addr) "id=%s addr=0x%"PRIx64
+
+# cxl_type3.c
+cxl_hdm_decoder_write(int which, uint32_t value, bool commit) "decoder=%d ctrl=0x%08x commit=%d"
+cxl_hdm_decoder_commit(int which, uint64_t base, uint64_t size, int iw, int ig) "decoder=%d base=0x%"PRIx64" size=0x%"PRIx64" iw=%d ig=%d"
+cxl_hdm_decoder_uncommit(int which) "decoder=%d"
-- 
2.43.0


