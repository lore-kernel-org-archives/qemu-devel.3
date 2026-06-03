Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBF1CD6E68
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUalm-0006qB-18; Tue, 02 Jun 2026 21:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wUalj-0006pl-Do
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 21:51:43 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wUalg-0003hJ-S9
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 21:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780451501; x=1811987501;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Cq7ErH4MSIS+C45bt5c1XKFHsLZIgDdp+F5QQ24AWEM=;
 b=fwCyQOIq3hGlB4DPSdj1oVl50LzDbwlH8SAZ5hjCRy4lH1WofkHI1PJB
 5ANV9vPAN9Ydzekep7rHPH6aIUBo5+QP/8ScH+Ba0QYWPNj3fEctWCJNo
 4loX0TsUGgxFfAyfUJUE83rYCaqkt1t44HbK0JzhG8oFb+oEPKAvV5aIT
 17YWUtvkNYeQynqXqegvh+yWDb+R98dVPlXjlSE5d/E8zbY5TuTj/+k71
 RPQXiWAay18ZoePtshO/c2zb2V9IhcpAmYaIusO2IIu4PcLB2Lq1ioHbV
 7muOrciY1EtbWxGZ+KydwB7+IYEJr5uZQnxPj2ARrmm6dGIN65EAhk+Tn Q==;
X-CSE-ConnectionGUID: YYMWj4ZDQMCVFWeu1lJYrg==
X-CSE-MsgGUID: Ws3rGhnuTi+DhsWoXvBowQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="84875650"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="84875650"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 18:51:40 -0700
X-CSE-ConnectionGUID: C4cahR4xSkGiHZVHikZWSA==
X-CSE-MsgGUID: aAhqvTc7QuiCykNgY0JLlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="248387835"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 18:51:37 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: jonathan.cameron@huawei.com
Cc: fan.ni@samsung.com,
	qemu-devel@nongnu.org,
	junjie.cao@intel.com
Subject: [PATCH 3/3] hw/cxl: trace event log activity and CFMWS address
 decoding
Date: Wed,  3 Jun 2026 09:34:20 +0800
Message-ID: <20260603013420.904749-4-junjie.cao@intel.com>
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

Two more debug-prone paths benefit from trace coverage. Event log
insertion and clearing are exercised on every error injection or
dynamic capacity event, but their interaction with the per-log
overflow counter is currently opaque. CFMWS address decoding
translates a host physical address through up to two HDM decoder
lookups (host bridge and optional switch USP).

Add five trace points:

  * cxl_event_insert            - successful enqueue, log type and
                                  resulting depth
  * cxl_event_overflow          - the artificial overflow threshold
                                  was hit; an event was dropped
  * cxl_event_clear             - bulk clear, log type and request size

  * cxl_cfmws_lookup            - entry to address decoding, with
                                  the resolved fixed-window index
  * cxl_cfmws_target_resolved   - HDM decoder produced a target index
                                  (fires for both the host-bridge and
                                  switch USP lookups)

In non-passthrough topologies, a cxl_cfmws_lookup without a following
cxl_cfmws_target_resolved indicates the host-bridge HDM decode
failed. In passthrough mode the lookup resolves via
pcie_find_port_first() without an HDM target step, so no
target_resolved event is expected.

In cxl_event_insert(), cxl_event_count() is hoisted into a local
variable so its O(n) queue walk is performed once per insert rather
than twice (once for the trace point, once for the existing return-
value comparison).

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/cxl/cxl-events.c | 8 +++++++-
 hw/cxl/cxl-host.c   | 4 ++++
 hw/cxl/trace-events | 9 +++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index 5356dfb5b3..f4aa419953 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -13,6 +13,7 @@
 #include "hw/pci/msix.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_events.h"
+#include "trace.h"
 
 /* Artificial limit on the number of events a log can hold */
 #define CXL_TEST_EVENT_OVERFLOW 8
@@ -98,6 +99,7 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
     uint64_t time;
     CXLEventLog *log;
     CXLEvent *entry;
+    int depth;
 
     if (log_type >= CXL_EVENT_TYPE_MAX) {
         return false;
@@ -115,6 +117,7 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
         }
         log->overflow_err_count++;
         log->last_overflow_timestamp = time;
+        trace_cxl_event_overflow(log_type, log->overflow_err_count);
         return false;
     }
 
@@ -133,8 +136,10 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
     QSIMPLEQ_INSERT_TAIL(&log->events, entry, node);
     cxl_event_set_status(cxlds, log_type, true);
 
+    depth = cxl_event_count(log);
+    trace_cxl_event_insert(log_type, depth);
     /* Count went from 0 to 1 */
-    return cxl_event_count(log) == 1;
+    return depth == 1;
 }
 
 void cxl_discard_all_event_records(CXLDeviceState *cxlds)
@@ -234,6 +239,7 @@ CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
         entry = cxl_event_get_head(log);
     }
 
+    trace_cxl_event_clear(log_type, pl->nr_recs);
     return CXL_MBOX_SUCCESS;
 }
 
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index a94b893e99..4157377a95 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -21,6 +21,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/pci-bridge/pci_expander_bridge.h"
+#include "trace.h"
 
 static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
                                            int index, Error **errp)
@@ -168,6 +169,7 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
     bool target_found;
     PCIDevice *rp, *d;
 
+    trace_cxl_cfmws_lookup(addr, fw->index);
     rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
     hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
     if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
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
index 15977dce6e..e5f196787d 100644
--- a/hw/cxl/trace-events
+++ b/hw/cxl/trace-events
@@ -10,3 +10,12 @@ cxl_mailbox_handler_return(uint16_t opcode, int ret, size_t len_out) "opcode=0x%
 # cxl-cdat.c
 cxl_cdat_init(const char *source) "source=%s"
 cxl_cdat_loaded(const char *filename, size_t length, int num_entries) "filename=%s length=%zu entries=%d"
+
+# cxl-events.c
+cxl_event_insert(int log_type, int depth) "log_type=%d depth=%d"
+cxl_event_overflow(int log_type, uint16_t overflow_err_count) "log_type=%d overflow_err_count=%u"
+cxl_event_clear(int log_type, int nr_recs) "log_type=%d nr_recs=%d"
+
+# cxl-host.c
+cxl_cfmws_lookup(uint64_t addr, int fw_index) "addr=0x%"PRIx64" fw=%d"
+cxl_cfmws_target_resolved(uint64_t addr, uint8_t target) "addr=0x%"PRIx64" target=0x%02x"
-- 
2.43.0


