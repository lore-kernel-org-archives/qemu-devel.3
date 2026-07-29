Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAF1C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 14:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp5aM-0004a7-3L; Wed, 29 Jul 2026 10:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wp5Zg-0004GX-12; Wed, 29 Jul 2026 10:48:03 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wp5Ze-0000Qq-BI; Wed, 29 Jul 2026 10:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785336478; x=1816872478;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0LPXenqXy+FBHwOhYVrUaTV2tGSOIChI14pMrmNyX60=;
 b=kEMtzvfH/4a/6P3DeoiMWh6GF4oFmSTo9l33dDUidZX4Xud47CZ/jkni
 qEEhzrxwTPsvaVam48PgkKBX/rulSc92ud1JKDk9D9UblBgXRNOKpkIMF
 DC5qApewiWsiNLjxGOYTlI5IBpJ7ZRGR/LsGrIsA0JMlfV11LjjdXRcwo
 RV6tJ+4ItKHG8+Ue8PUivi9dtmRlM00q1zF116jvzk4vkB03feHZgFJ2V
 wai6MzOjkwa/gZ8WQkJUJ9x0TmGm1IFTlJRLUT0cl8IEizg9p4au7g6Me
 BLy2na80V3j9pFaRlvIdBCfy1/N462odG9ckuVFPJ37Tws5sxgnP/A9T4 Q==;
X-CSE-ConnectionGUID: A8WOmvzrQvyFt3PUg8WgpA==
X-CSE-MsgGUID: ayPW1yOYTMSm90PQtL7xPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86133640"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="86133640"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 07:47:56 -0700
X-CSE-ConnectionGUID: 254ZiHc/QHGUWJcThx+Qyw==
X-CSE-MsgGUID: jgAzanGPQ7ylU6UXzgpNiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="258788847"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 07:47:55 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: jic23@kernel.org, linux-cxl@vger.kernel.org, philmd@oss.qualcomm.com,
 qemu-stable@nongnu.org
Subject: [PATCH v3 6/7] hw/cxl: clear event logs,
 scan media and interrupt policy on reset
Date: Wed, 29 Jul 2026 22:46:44 +0800
Message-ID: <20260729144645.1552511-7-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729144645.1552511-1-junjie.cao@intel.com>
References: <20260729144645.1552511-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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
index 3a5eea76f2..2392358071 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1360,6 +1360,23 @@ static void ct3d_reset_hold(Object *obj, ResetType type)
     }
     cxl_initialize_t3_ld_cci(&ct3d->ld0_cci, DEVICE(ct3d), DEVICE(ct3d),
                              512); /* Max payload made up */
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


