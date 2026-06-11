Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08482CD8CB9
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXZIf-00007s-SZ; Thu, 11 Jun 2026 02:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wXZIc-00007k-Vb
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:53:59 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wXZIb-0007XG-6b
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781160838; x=1812696838;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bjCmdxXe78AH05DYv6kC/9KUguuQjGAQp6spxywWFHo=;
 b=PevG2r9Et0pf8/SvRmC1utHbENERXsMY8SR2LOnhahrwriw4FDyrVWk2
 z0iTG6oeOU1Ab5d5G41RHqz3VJJiTbz8EtCGPW7y3sNYbM8Z5TRzN9uVs
 hiuYz5cj13GT3VlqBNnuFi+cKWBEZMU+915XoJ1bGG0IxWBuoqx2JHGx5
 +p44HeW+/rDtoSKCysGYryhviCCioFXbEPKlc0tsCPDn+N77B7QwOT77i
 6ArwazhiOJMJTTTvwDnGpr30sPR245xUva00jDQ0GLgoYVCcsAaTIhs4p
 f/hDANnw/B3kaVnMtXKybBTMVIlzsLzFkqNk6CdX3N0NxfqabLauEQsKS A==;
X-CSE-ConnectionGUID: qVB02jnTT7C7VxDsRYVNyA==
X-CSE-MsgGUID: iSlN7QBLShyxR2T3MiBXTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85595482"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="85595482"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 23:53:57 -0700
X-CSE-ConnectionGUID: Oc6XA8rdTryoyY9ABve7LA==
X-CSE-MsgGUID: NbzhNLcVQpK5YutRdt3wSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="246469819"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 23:53:55 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: jic23@kernel.org
Cc: fan.ni@samsung.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 junjie.cao@intel.com
Subject: [PATCH v2 4/5] hw/cxl: trace event log insertion, overflow and clear
Date: Thu, 11 Jun 2026 14:30:26 +0800
Message-ID: <20260611063027.1166493-5-junjie.cao@intel.com>
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

Add trace events for CXL event log activity.  Event insertion, overflow,
and clearing are exercised on every error injection or dynamic capacity
event, but the interaction with the per-log overflow counter was
previously opaque.

Three trace points are added:

  cxl_event_insert   - successful enqueue, with log type and resulting
                       occupancy (queue depth after insert)
  cxl_event_overflow - overflow threshold hit, event dropped, with
                       cumulative overflow count
  cxl_event_clear    - bulk clear with log type and number of records
                       removed

As a minor optimisation, cache the result of cxl_event_count() in a
local variable so the O(n) queue walk is performed once per insert
rather than twice.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/cxl/cxl-events.c | 13 +++++++++++--
 hw/cxl/trace-events |  5 +++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index 5356dfb5b3..685ef5dc44 100644
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
+    int occupancy;
 
     if (log_type >= CXL_EVENT_TYPE_MAX) {
         return false;
@@ -109,12 +111,15 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
 
     QEMU_LOCK_GUARD(&log->lock);
 
-    if (cxl_event_count(log) >= CXL_TEST_EVENT_OVERFLOW) {
+    occupancy = cxl_event_count(log);
+
+    if (occupancy >= CXL_TEST_EVENT_OVERFLOW) {
         if (log->overflow_err_count == 0) {
             log->first_overflow_timestamp = time;
         }
         log->overflow_err_count++;
         log->last_overflow_timestamp = time;
+        trace_cxl_event_overflow(log_type, log->overflow_err_count);
         return false;
     }
 
@@ -133,8 +138,10 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
     QSIMPLEQ_INSERT_TAIL(&log->events, entry, node);
     cxl_event_set_status(cxlds, log_type, true);
 
+    trace_cxl_event_insert(log_type, occupancy + 1);
+
     /* Count went from 0 to 1 */
-    return cxl_event_count(log) == 1;
+    return occupancy == 0;
 }
 
 void cxl_discard_all_event_records(CXLDeviceState *cxlds)
@@ -234,6 +241,8 @@ CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
         entry = cxl_event_get_head(log);
     }
 
+    trace_cxl_event_clear(log_type, nr);
+
     return CXL_MBOX_SUCCESS;
 }
 
diff --git a/hw/cxl/trace-events b/hw/cxl/trace-events
index 609def2dec..17f9e7059c 100644
--- a/hw/cxl/trace-events
+++ b/hw/cxl/trace-events
@@ -4,3 +4,8 @@
 cxl_mailbox_cmd(uint8_t set, uint8_t cmd, const char *name, size_t len_in) "set=0x%02x cmd=0x%02x [%s] len_in=%zu"
 cxl_mailbox_cmd_done(uint8_t set, uint8_t cmd, int ret, size_t len_out) "set=0x%02x cmd=0x%02x ret=%d len_out=%zu"
 cxl_mailbox_payload_error(uint8_t set, uint8_t cmd, const char *name, size_t len_in) "set=0x%02x cmd=0x%02x [%s] len_in=%zu"
+
+# cxl-events.c
+cxl_event_insert(int log_type, int occupancy) "log_type=%d occupancy=%d"
+cxl_event_overflow(int log_type, uint16_t overflow_count) "log_type=%d overflow_count=%u"
+cxl_event_clear(int log_type, int nr_recs) "log_type=%d nr_recs=%d"
-- 
2.43.0


