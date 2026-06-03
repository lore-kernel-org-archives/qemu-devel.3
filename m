Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94327CD6E5D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUali-0006pI-Aq; Tue, 02 Jun 2026 21:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wUale-0006nw-Ic
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 21:51:38 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wUalc-0003hJ-SA
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 21:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780451497; x=1811987497;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=K+ZENMPAAlpFnRl8nibHs82pKxliDSm2Xg1qQbBqXN8=;
 b=hPUQDZ+LwIhuOmJvaSHy62iHN0tCtkpw8WGQ+3DPhYFkjcmmISzCv34F
 xs5Kc5C3ogvf+wjpyXL4u5vLCmoNQRDzjSEmqj2RltMDb/T4BSl+z3FOh
 CUReRDMh95MZknJIv+fhp2E6ZY3J+PQzTZ3U1n9EvqKYN++Qdep5wrT5r
 fpBqn1OtdBtouDy/bpbN8XIgpfXEL2lcHauimvqddhQpeh/KSxWZKslwm
 5KgHyfRhC9NbO17GDt/A6tIpEBD/iK2xJ4JHfUfD01PTps/NCKxBG3GqH
 I/txg6XFvUG1ZXuRnSD72XjTWIkH/zTt6x5V4Qinayw+mKgDVDQpAL+j2 A==;
X-CSE-ConnectionGUID: pX/nyWHsRFmIjq0yULu8IQ==
X-CSE-MsgGUID: 3KppM4JKTCq5nLt/dYOksQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="84875630"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="84875630"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 18:51:36 -0700
X-CSE-ConnectionGUID: 5STRzDt2RwOGyo1NGInZgQ==
X-CSE-MsgGUID: xW+CvSI8SiCXa+dSmJIojg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="248387790"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 18:51:34 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: jonathan.cameron@huawei.com
Cc: fan.ni@samsung.com,
	qemu-devel@nongnu.org,
	junjie.cao@intel.com
Subject: [PATCH 2/3] hw/cxl: trace HDM decoder commit and CDAT load
Date: Wed,  3 Jun 2026 09:34:19 +0800
Message-ID: <20260603013420.904749-3-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603013420.904749-1-junjie.cao@intel.com>
References: <20260603013420.904749-1-junjie.cao@intel.com>
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

HDM decoder programming and CDAT table ingestion are two
debugging-prone paths in the CXL stack: the former drives
address-decoding behaviour, the latter is parsed before any guest
interaction so wrong inputs surface late.

Add four trace points:

  * cxl_hdm_decoder_write    - guest write to a decoder CTRL register,
                               capturing the raw value and whether a
                               commit is being requested
  * cxl_hdm_decoder_commit   - actual commit, with the resolved base,
                               size, IW and IG fields
  * cxl_cdat_init            - CDAT initialisation, distinguishing the
                               file-backed vs built-in source
  * cxl_cdat_loaded          - successful file load with size and
                               number of entries parsed

The hw/mem/cxl_type3.c trace points are declared in the existing
hw/mem/trace-events. The cxl_ prefix keeps the namespace unified for
filtering with -trace 'cxl_*'.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/cxl/cxl-cdat.c   |  3 +++
 hw/cxl/trace-events |  4 ++++
 hw/mem/cxl_type3.c  | 17 ++++++++++++++++-
 hw/mem/trace-events |  4 ++++
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
index 959a55518e..5274ac8c12 100644
--- a/hw/cxl/cxl-cdat.c
+++ b/hw/cxl/cxl-cdat.c
@@ -12,6 +12,7 @@
 #include "hw/cxl/cxl.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "trace.h"
 
 static void cdat_len_check(CDATSubHeader *hdr, Error **errp)
 {
@@ -186,6 +187,7 @@ static bool ct3_load_cdat(CDATObject *cdat, Error **errp)
     cdat->entry_len = num_ent;
     cdat->entry = g_steal_pointer(&cdat_st);
     cdat->buf = g_steal_pointer(&buf);
+    trace_cxl_cdat_loaded(cdat->filename, file_size, num_ent);
     return true;
 }
 
@@ -193,6 +195,7 @@ bool cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp)
 {
     CDATObject *cdat = &cxl_cstate->cdat;
 
+    trace_cxl_cdat_init(cdat->filename ?: "<built-in>");
     if (cdat->filename) {
         return ct3_load_cdat(cdat, errp);
     } else {
diff --git a/hw/cxl/trace-events b/hw/cxl/trace-events
index abca116ed3..15977dce6e 100644
--- a/hw/cxl/trace-events
+++ b/hw/cxl/trace-events
@@ -6,3 +6,7 @@
 cxl_mailbox_command(uint16_t opcode, size_t len_in) "opcode=0x%04x len_in=%zu"
 cxl_mailbox_invalid_payload(uint16_t opcode, size_t len_in, size_t expected) "opcode=0x%04x len_in=%zu expected=%zu"
 cxl_mailbox_handler_return(uint16_t opcode, int ret, size_t len_out) "opcode=0x%04x ret=%d len_out=%zu"
+
+# cxl-cdat.c
+cxl_cdat_init(const char *source) "source=%s"
+cxl_cdat_loaded(const char *filename, size_t length, int num_entries) "filename=%s length=%zu entries=%d"
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4739239da3..8130abeb37 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -30,6 +30,7 @@
 #include "system/numa.h"
 #include "hw/cxl/cxl.h"
 #include "hw/pci/msix.h"
+#include "trace.h"
 
 /* type3 device private */
 enum CXL_T3_MSIX_VECTOR {
@@ -419,9 +420,20 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
     int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
     ComponentRegisters *cregs = &ct3d->cxl_cstate.crb;
     uint32_t *cache_mem = cregs->cache_mem_registers;
-    uint32_t ctrl;
+    uint32_t ctrl, low, high;
+    uint64_t base, size;
 
     ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc);
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
     /* TODO: Sanity checks that the decoder is possible */
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
@@ -623,6 +635,9 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
     }
 
     stl_le_p((uint8_t *)cache_mem + offset, value);
+    if (which_hdm >= 0) {
+        trace_cxl_hdm_decoder_write(which_hdm, value, should_commit);
+    }
     if (should_commit) {
         hdm_decoder_commit(ct3d, which_hdm);
     } else if (should_uncommit) {
diff --git a/hw/mem/trace-events b/hw/mem/trace-events
index 8b6b02b5bf..770831f701 100644
--- a/hw/mem/trace-events
+++ b/hw/mem/trace-events
@@ -6,3 +6,7 @@ mhp_pc_dimm_assigned_slot(int slot) "%d"
 memory_device_pre_plug(const char *id, uint64_t addr) "id=%s addr=0x%"PRIx64
 memory_device_plug(const char *id, uint64_t addr) "id=%s addr=0x%"PRIx64
 memory_device_unplug(const char *id, uint64_t addr) "id=%s addr=0x%"PRIx64
+
+# cxl_type3.c
+cxl_hdm_decoder_write(int which, uint32_t value, bool commit) "decoder=%d ctrl=0x%08x commit=%d"
+cxl_hdm_decoder_commit(int which, uint64_t base, uint64_t size, uint32_t iw_enc, uint32_t ig_enc) "decoder=%d base=0x%"PRIx64" size=0x%"PRIx64" iw_enc=0x%x ig_enc=0x%x"
-- 
2.43.0


