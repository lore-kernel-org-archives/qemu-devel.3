Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE1BCD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 06:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd0UB-0008Rc-4V; Fri, 26 Jun 2026 02:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wd0UA-0008RT-Gd
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 02:56:22 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wd0U8-0007vz-Ub
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 02:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782456981; x=1813992981;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LFZDeluVb0jYrFBCNzRihUZyA/8sIedwSTGxxS78Gns=;
 b=hfxUme5r6748hnqci+D158gDWHlh87s27xFtXbNI4ixYyobejJucwCq0
 M44tQE15PxVEtiAyHIPW3dWGZO9nOX9cUBmZU9IvSYUu4aoB86hMv2s4c
 2OP18mPlNEQW0X2Raz8IMeODbEaiZSWRQyCxZlc9JTJV2Jd8BhcvlmgTe
 /fm9yeK3tG/aqg+CmoX5uRFLoKLcn2h0eyR9koJyYwd0whwzNJUf0evyn
 ifcgzJ4JT4w9kr8bFws8WEh780YpITJDMmpT4M2E9L1urrEWUxLquB5I6
 39l7zm6EldLfSw3SdPfrUXKtGHFNHWlkfVB/KASwiWgEAKyaoWPtJU04c w==;
X-CSE-ConnectionGUID: 17KyRSkXQw6pjZ//4Kc7Dg==
X-CSE-MsgGUID: xQhcrnp7SFamS70Lf2GmXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="85802355"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="85802355"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 23:56:20 -0700
X-CSE-ConnectionGUID: ZsEt5uf4TjWAgb5WATCW/g==
X-CSE-MsgGUID: xxUVM1IpSFaUxXRvE21K9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="244865896"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 23:56:18 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org,
 junjie.cao@intel.com
Subject: [PATCH 5/6] hw/cxl: clear event logs,
 scan media and interrupt policy on reset
Date: Fri, 26 Jun 2026 14:21:48 +0800
Message-ID: <20260626062149.1844334-6-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626062149.1844334-1-junjie.cao@intel.com>
References: <20260626062149.1844334-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=junjie.cao@intel.com;
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

Event records, scan media results and event interrupt settings are
device-internal dynamic state that should not survive a device reset.

Per CXL r4.0 Section 8.2.10.9.4.6 (Get Scan Media Results), "If the
Scan Media command has not been called since the last Conventional
Reset, the device shall return the Unsupported return code."  This
explicitly invalidates scan media results across reset, so clear the
scan_media_hasrun flag.

Per CXL r4.0 Section 8.2.10.2.5 (Set Event Interrupt Policy), "All
event log interrupt settings shall be reset to 00b (No Interrupts) by
the device on Conventional Reset."  Clear irq_enabled for every event
log accordingly.

For the event records there is no direct spec mandate to drop the
stored records on reset; the Event Status register (Table 8-203) is
non-sticky and resets to zero per Section 9.7, and no reset flavor
requires the already-reported records to persist.  Draining the queues
is therefore a reasonable modelling choice that keeps the records
consistent with the freshly-reset status register, rather than a spec
requirement.  Call the existing cxl_discard_all_event_records() helper
to drain all event queues.  The event log infrastructure itself
(mutexes, IRQ vectors) remains intact as it is initialized once during
device realize.

This is also where reset-type gating begins: a wakeup from suspend-to-RAM
(RESET_TYPE_WAKEUP) is not a Conventional or CXL Reset and must retain
device-internal state, so the hold phase returns early for that type
before discarding any records.  This mirrors the RESET_TYPE_WAKEUP
shortcut in virtio-mem and virtio-balloon.  Only the unconditional
mailbox interface re-initialization and the in-flight sanitize free
(whose backing timer was already destroyed) run on a wakeup.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/mem/cxl_type3.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index a5e6df3033..5bf0cffb72 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1371,6 +1371,23 @@ static void ct3d_reset_hold(Object *obj, ResetType type)
      */
     g_free(ct3d->media_op_sanitize);
     ct3d->media_op_sanitize = NULL;
+
+    /*
+     * A wakeup from suspend-to-RAM is not a Conventional or CXL Reset.  The
+     * device-internal dynamic state cleared below (event logs, scan media
+     * results, and the poison/feature-transfer state cleared in subsequent
+     * patches) must be preserved across resume, so stop here for a wakeup.
+     * virtio-mem and virtio-balloon take the same RESET_TYPE_WAKEUP shortcut.
+     */
+    if (type == RESET_TYPE_WAKEUP) {
+        return;
+    }
+
+    cxl_discard_all_event_records(&ct3d->cxl_dstate);
+    for (int i = 0; i < CXL_EVENT_TYPE_MAX; i++) {
+        ct3d->cxl_dstate.event_logs[i].irq_enabled = false;
+    }
+    ct3d->scan_media_hasrun = false;
 }
 
 static const Property ct3_props[] = {
-- 
2.43.0


