Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44F8C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 14:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp5Zu-0004HF-LB; Wed, 29 Jul 2026 10:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wp5ZV-0004E6-7U; Wed, 29 Jul 2026 10:47:49 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wp5ZT-0000Od-10; Wed, 29 Jul 2026 10:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785336467; x=1816872467;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nFqNu0iSMQjFsciEfqn515iB7LjyxAmJ+64HOq2b4Ng=;
 b=PuyVWj1o1D1zuN/eqOvVwvBtsi4I3hYEJuNF/d3ziMOTBcW0OyCv1cOz
 gkdQsxSdx61PqlsNePEgrILj8KSFHwW4YYiJZ+LmMudyHZtyyMVUfRBl3
 EEvb0rNGm0x/0eLoAWV9S3KuhdR1U/yTqPYBkMeEyewVS8sJu/jsdd8ts
 02vayOc45qZZb47EphyQFuC6lJXu8rCdwV+t7PS7OrFAZRRknPeg0FJMC
 TKQ+nBWVICzMu8E+T7pc32S1sNbpXy+sJPm/fUJxNekJKbZH070hkqGDq
 iiJdK5mtXSlBcF3Lamfggd9pNK2w+dVuIkPxjhCGRed6wC9uYdVnxEjN6 Q==;
X-CSE-ConnectionGUID: 49FogfXUSbW314M4EWFmkw==
X-CSE-MsgGUID: syHNVRywStWDf2m6CbZFxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86133599"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="86133599"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 07:47:41 -0700
X-CSE-ConnectionGUID: zvsbSv6hRcWtRhs1R4VQsQ==
X-CSE-MsgGUID: eIFAtXanSSSB9POXZovHyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="258788794"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 07:47:40 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: jic23@kernel.org, linux-cxl@vger.kernel.org, philmd@oss.qualcomm.com,
 qemu-stable@nongnu.org
Subject: [PATCH v3 0/7] hw/cxl: fix Type-3 device reset resource leaks and
 convert to three-phase
Date: Wed, 29 Jul 2026 22:46:38 +0800
Message-ID: <20260729144645.1552511-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
  - Patch 4: factor the primary CCI teardown into a
    cxl_destroy_mailbox_t3() helper pairing cxl_initialize_mailbox_t3()
  - Patches 5-7: clean up device state on reset

The state cleanup in patches 6-7 is gated on reset type:
RESET_TYPE_WAKEUP returns early (patch 6) since a resume from S3 is
not a Conventional or CXL Reset.  The CCI re-initialization and the
in-flight sanitize discard run unconditionally regardless of type.

Not addressed here:

  - Committed Feature attributes and alert thresholds (Table 8-276
    Deepest Reset Persistence = None) are not reverted to defaults.
    Factoring the realize-time defaults into a reset helper is left
    for a follow-up.

  - Dynamic Capacity extent lifecycle across reset.

  - The Media Disabled latch after an interrupted Sanitize (Section
    8.2.10.9.5.1); patch 5 addresses only the resource leak.

Tested: per-commit build clean; cxl qtest passes.  Differential
LeakSanitizer (5x system_reset): pre-series leaks 720 B / 15 allocs
in cxl_init_cci -> timer_new_ms; post-series zero (re-verified on
v3).  Poison inject -> reset -> re-inject same DPAs succeeds (no
stale "Overlap" rejection).  20x inject+reset stress cycles with no
crash.

Changes since v2:
  - New patch 4: factor the primary CCI teardown into
    cxl_destroy_mailbox_t3(), the teardown counterpart of
    cxl_initialize_mailbox_t3(), called from both the reset path and
    ct3_exit(). [Philippe]
  - Patch 5 (was patch 4): discard the in-flight sanitize state from
    cxl_destroy_mailbox_t3() through a helper shared with the
    __do_sanitize() completion path, so the whole media_op_sanitize
    lifecycle stays within cxl-mailbox-utils.c.  This also plugs the
    same leak on device unrealize, which v2 missed. [Philippe]
  - Picked up Philippe's Reviewed-by on patches 1 and 3.

Changes since v1:
  - Patch 1: reorder cxl_destroy_cci() teardown to reverse
    cxl_init_cci() order, per Jonathan's review.

v2: https://lore.kernel.org/qemu-devel/20260723011625.1117034-1-junjie.cao@intel.com/
v1: https://lore.kernel.org/qemu-devel/20260626062149.1844334-1-junjie.cao@intel.com/

Junjie Cao (7):
  hw/cxl: fix timer leak in cxl_destroy_cci()
  hw/cxl: destroy primary CCI before re-initialization on reset
  hw/cxl: convert cxl-type3 to three-phase reset
  hw/cxl: add cxl_destroy_mailbox_t3() as the mailbox teardown
    counterpart
  hw/cxl: discard in-flight sanitize state on mailbox teardown
  hw/cxl: clear event logs, scan media and interrupt policy on reset
  hw/cxl: clear poison lists and feature transfer state on reset

 hw/cxl/cxl-mailbox-utils.c  | 24 +++++++++++++--
 hw/mem/cxl_type3.c          | 60 +++++++++++++++++++++++++++++++++----
 include/hw/cxl/cxl_device.h |  3 ++
 3 files changed, 80 insertions(+), 7 deletions(-)


base-commit: e1705a25aff35635c360bbaba4c2731d019a422a
-- 
2.43.0


