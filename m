Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7DAC44536
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmi3p-0004X4-5I; Wed, 22 Jul 2026 21:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wmi3o-0004Wq-AL; Wed, 22 Jul 2026 21:17:16 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wmi3l-0002x3-Hq; Wed, 22 Jul 2026 21:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784769433; x=1816305433;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=AkFdo61pjFPTuiiOlBTWNsBrgnIuk5IsPynVbmLIz5c=;
 b=YLV4k6MzR4qyqOzVegUM7imTzEtdAc5/UQoxB9HjK9F/i/3U7YTS9d7u
 zq4+JeIQTzYEJk2qcg0Dnu++/e+U/Yiq17MJClhEKpBKVYKbQNqhgXIrm
 BREJoGZibgGVjhaFC+xYEOm03Zs6pn0XZcSRdvde7TgkS9XKGV60N1Tsm
 rsnk8V/7Oyl/PIY9bPugJaNhV5VrbjCh0SjUBPXKYRCco3sk9u65qpxS6
 bcyY+FRp0uh7skB/rPXoKrmIoJBIXf5JmGJKISnF/fBT4G8lWc6qj1jC9
 WPbTq/YRBdKvoMAN9nwYiU5rr0szS4Cst0you+scNIV4McGP23dMdPlcU w==;
X-CSE-ConnectionGUID: q4SkkM61STOAn+JQVnL6Kw==
X-CSE-MsgGUID: fBkUWq+PSCmw9WK4KtTOCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96074825"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; d="scan'208";a="96074825"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 18:17:09 -0700
X-CSE-ConnectionGUID: m2oTjXZpQByCXvY1SkAZwA==
X-CSE-MsgGUID: cyEvTKuQSda4SLmo/SM/iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; d="scan'208";a="251943341"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 18:17:08 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, qemu-stable@nongnu.org
Subject: [PATCH v2 0/6] hw/cxl: fix Type-3 device reset resource leaks and
 convert to three-phase
Date: Thu, 23 Jul 2026 09:16:19 +0800
Message-ID: <20260723011625.1117034-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


The CXL Type-3 device reset path (ct3d_reset) has several issues:

1) Resource leaks:
   - cxl_destroy_cci() never frees the QEMUTimer allocated by
     cxl_init_cci(), leaking a timer on each destroy/reinit cycle.
   - The primary CCI (ct3d->cci) is re-initialized through
     cxl_device_register_init_t3() without being destroyed first,
     leaking the timer and leaving the mutex undestroyed on every
     reset.
   - The secondary CCIs are never destroyed at device exit time,
     leaking their timers and mutexes on device removal.

2) Incomplete state cleanup:
   - Background commands do not survive Conventional Resets (CXL r4.0
     Section 8.2.9.4), yet the in-flight sanitize state is never freed.
   - Scan media results are explicitly invalidated after reset (Section
     8.2.10.9.4.6), yet scan_media_hasrun is never cleared.
   - Event interrupt settings shall be reset to 00b on Conventional
     Reset (Section 8.2.10.2.5), yet irq_enabled is never cleared.
   - When "Injects Persistent Poison" is 0 (the QEMU default), injected
     poison shall be automatically cleared on reset (Table 8-309), yet
     the poison lists are never drained.
   - Stale event records remain in the queues across reset even though
     the Event Status register (Table 8-203) is non-sticky.

3) Deprecated API usage:
   - Uses device_class_set_legacy_reset() instead of the three-phase
     resettable interface, preventing reset-type-aware behavior.

This series fixes the issues incrementally:
  - Patches 1-2: fix resource leaks (deterministic bugs)
  - Patch 3: mechanical conversion to three-phase reset
  - Patches 4-6: clean up device state on reset

The state cleanup in patches 4-6 is gated on reset type:
RESET_TYPE_WAKEUP returns early (patch 5) since a resume from S3 is
not a Conventional or CXL Reset.  The CCI re-initialization and the
in-flight sanitize free run unconditionally regardless of type.

Not addressed here:

  - Committed Feature attributes and alert thresholds (Table 8-276
    Deepest Reset Persistence = None) are not reverted to defaults.
    Factoring the realize-time defaults into a reset helper is left
    for a follow-up.

  - Dynamic Capacity extent lifecycle across reset.

  - The Media Disabled latch after an interrupted Sanitize (Section
    8.2.10.9.5.1); patch 4 addresses only the resource leak.

Tested: per-commit build clean; qtest passes.  Differential
LeakSanitizer (5x system_reset): pre-series leaks 720 B / 15 allocs
in cxl_init_cci -> timer_new_ms; post-series zero.  Poison inject ->
reset -> re-inject same DPAs succeeds (no stale "Overlap" rejection).
20x inject+reset stress cycles with no crash.

Changes since v1:
  - Patch 1: reorder cxl_destroy_cci() teardown to reverse
    cxl_init_cci() order, per Jonathan's review.

v1: https://lore.kernel.org/qemu-devel/20260626062149.1844334-1-junjie.cao@intel.com/

Junjie Cao (6):
  hw/cxl: fix timer leak in cxl_destroy_cci()
  hw/cxl: destroy primary CCI before re-initialization on reset
  hw/cxl: convert cxl-type3 to three-phase reset
  hw/cxl: free in-flight sanitize state on reset
  hw/cxl: clear event logs, scan media and interrupt policy on reset
  hw/cxl: clear poison lists and feature transfer state on reset

 hw/cxl/cxl-mailbox-utils.c  |  2 +
 hw/mem/cxl_type3.c          | 74 ++++++++++++++++++++++++++++++++++---
 include/hw/cxl/cxl_device.h |  2 +
 3 files changed, 73 insertions(+), 5 deletions(-)


base-commit: cbd42e2b75b23953a9bdb073c8531518b1bd6163
-- 
2.43.0


