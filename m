Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6030FCDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 06:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd0Tv-0008Om-Pq; Fri, 26 Jun 2026 02:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wd0Tu-0008Nd-8y; Fri, 26 Jun 2026 02:56:06 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wd0Ts-0007vL-H1; Fri, 26 Jun 2026 02:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782456965; x=1813992965;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KBu100xg1Txpv8RJacu5T0T7HrIl9c2cdIu5LTVA4PE=;
 b=DMlTfPCNkLH0D6sGqLKdx9iqplVDnGxOFK8JAonmymxrcynGj4pIyz98
 hp0HvzhwbLKuMUJP959+xiq0G4TsBqbPII/zCpzNShJw3AN9wJTJ01k4z
 hJy2hmNHvHU3Ay0cHrrxk/9pw93f/bB2PgfBwTNEJa4I/iXo+jdtUTqZt
 TrkNqXAeOEbATI8kE9oHWd4LPDxxCSmUjX+aKjdCaTivkQqvCC6BUdJaK
 8caVpizP5HZrjaqg2C0gmNE74T0L51Mzrdneq2iHybFevBiZ7UJnhoxSS
 Gk99VBNfdwC3SkofPqHQmeQ/rPP+NvPylBTMrLplKHXSDmZJLfVKVKRs+ g==;
X-CSE-ConnectionGUID: HffyPbHeSA+sss1n+ky1pQ==
X-CSE-MsgGUID: s33ghX1FSfGrxrd08zfTLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="85802330"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="85802330"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 23:56:02 -0700
X-CSE-ConnectionGUID: Anq9gpsGSSiR2V1+eDjgnQ==
X-CSE-MsgGUID: 4iJqnzP2T7WXbdJTS1ZPRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="244865870"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 23:56:00 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org,
 junjie.cao@intel.com, qemu-stable@nongnu.org
Subject: [PATCH 1/6] hw/cxl: fix timer leak in cxl_destroy_cci()
Date: Fri, 26 Jun 2026 14:21:44 +0800
Message-ID: <20260626062149.1844334-2-junjie.cao@intel.com>
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

cxl_init_cci() allocates a QEMUTimer via timer_new_ms() but
cxl_destroy_cci() never frees it.  This leaks a timer object on every
device exit path and, more critically, on every device reset cycle since
the secondary CCIs (vdm_fm_owned_ld_mctp_cci, ld0_cci) are destroyed
and re-initialized each time ct3d_reset() runs.

Free the timer with timer_free(), which cancels any pending expiry via
timer_del() internally and tolerates a NULL pointer, then clear the
field so that a repeated timer_free() on the same CCI is a safe no-op.
(The function as a whole is not idempotent: it also calls
qemu_mutex_destroy(), which asserts on an already-destroyed mutex.
Callers must not invoke cxl_destroy_cci() twice; the .initialized guard
added in the next patch enforces that.)

Fixes: 98cbac128f1c ("hw/cxl: Support aborting background commands")
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/cxl/cxl-mailbox-utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 20e0b7e476..18a455e89c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -4770,6 +4770,8 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
 
 void cxl_destroy_cci(CXLCCI *cci)
 {
+    timer_free(cci->bg.timer);
+    cci->bg.timer = NULL;
     qemu_mutex_destroy(&cci->bg.lock);
     cci->initialized = false;
 }
-- 
2.43.0


