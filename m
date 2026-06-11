Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C8ACD8CB9
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXZIq-0000Jj-Bx; Thu, 11 Jun 2026 02:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wXZIi-00009o-6w
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:54:07 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wXZIg-0007XG-MF
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781160843; x=1812696843;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qup0vXFsbeVo8wh1KUc1tA872Gp1A1fyFRgp6CLCQlk=;
 b=MVDgaTHJmqdB3ddjE0humyidC8J4nE1Jvsgdfpj4feBI52reBl9lXyDn
 2svfb50v0InJe6TtFKlrimX9OhBEgj2M3Oa3cpVf6qwVAtxCNx1jFOeYp
 nVom7H38ymQuwbeuAnxO2kn9GjIkOkH/MMaDdja2Elp/67qdR9PdkCyOM
 XeCksjxv4Po97bfXFLH5p1jEztb9ybofq6RJYfFgpEyGfPfhcBHdtnMUx
 NQrNMyiWMqHA3vWCJn11fqxoWAz/d1EbbeZQXugstfY0tnh1U0U2ZSwQI
 2qUawLmUtu0D5uSMK2T3RBCRZF3+tFcNGNjHv48ClXcXhbMVpZuDzw7/+ A==;
X-CSE-ConnectionGUID: 3iIzpM5xRlGus8CFGsGDlw==
X-CSE-MsgGUID: 4lqWaND4SECKXndd2rB7Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85595499"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="85595499"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 23:54:02 -0700
X-CSE-ConnectionGUID: Yt3EXWXKSPOSxTY3+4RcFg==
X-CSE-MsgGUID: XIhIlnedRmmRiXMD1Z5BfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="246469849"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 23:54:00 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: jic23@kernel.org
Cc: fan.ni@samsung.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 junjie.cao@intel.com
Subject: [PATCH v2 5/5] hw/cxl: trace CFMWS address-to-device routing
Date: Thu, 11 Jun 2026 14:30:27 +0800
Message-ID: <20260611063027.1166493-6-junjie.cao@intel.com>
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

Add trace events for the CXL Fixed Memory Window address routing path.
This translates a host physical address through interleave granularity
calculation and up to two levels of HDM decoder lookups (host-bridge
and optional switch USP).

Two trace points are added:

  cxl_cfmws_lookup          - entry to CFMWS decode with the computed
                              root-bus interleave index
  cxl_cfmws_target_resolved - HDM decoder produced a port target (fires
                              for both host-bridge and switch USP lookups)

In non-passthrough topologies, a cxl_cfmws_lookup without a following
cxl_cfmws_target_resolved indicates the host-bridge HDM decode failed.
Passthrough-mode routing goes through pcie_find_port_first() without
HDM decoding, so no target_resolved event is expected in that case.
A dedicated passthrough-mode trace event is deferred pending upstream
passthrough topology support.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/cxl/cxl-host.c   | 4 ++++
 hw/cxl/trace-events | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index a94b893e99..0efdfcdfa7 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -21,6 +21,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/pci-bridge/pci_expander_bridge.h"
+#include "trace.h"
 
 static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
                                            int index, Error **errp)
@@ -169,6 +170,7 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
     PCIDevice *rp, *d;
 
     rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
+    trace_cxl_cfmws_lookup(addr, rb_index);
     hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
     if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
         return NULL;
@@ -191,6 +193,7 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
         if (!target_found) {
             return NULL;
         }
+        trace_cxl_cfmws_target_resolved(addr, target);
 
         rp = pcie_find_port_by_pn(hb->bus, target);
         if (!rp) {
@@ -227,6 +230,7 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
     if (!target_found) {
         return NULL;
     }
+    trace_cxl_cfmws_target_resolved(addr, target);
 
     d = pcie_find_port_by_pn(&PCI_BRIDGE(d)->sec_bus, target);
     if (!d) {
diff --git a/hw/cxl/trace-events b/hw/cxl/trace-events
index 17f9e7059c..0cfaa0c128 100644
--- a/hw/cxl/trace-events
+++ b/hw/cxl/trace-events
@@ -9,3 +9,7 @@ cxl_mailbox_payload_error(uint8_t set, uint8_t cmd, const char *name, size_t len
 cxl_event_insert(int log_type, int occupancy) "log_type=%d occupancy=%d"
 cxl_event_overflow(int log_type, uint16_t overflow_count) "log_type=%d overflow_count=%u"
 cxl_event_clear(int log_type, int nr_recs) "log_type=%d nr_recs=%d"
+
+# cxl-host.c
+cxl_cfmws_lookup(uint64_t addr, int rb_index) "addr=0x%"PRIx64" rb_index=%d"
+cxl_cfmws_target_resolved(uint64_t addr, uint8_t target) "addr=0x%"PRIx64" target=0x%02x"
-- 
2.43.0


