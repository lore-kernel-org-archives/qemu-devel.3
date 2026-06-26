Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8EBCD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 06:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd0U8-0008RE-Q4; Fri, 26 Jun 2026 02:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wd0U6-0008Qw-RI
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 02:56:18 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wd0U5-0007vz-0h
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 02:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782456977; x=1813992977;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=msD/IOsgmuLyQHdlEUt3k5JKbV4W8J9VzDhB5nHKV2I=;
 b=BC8XyDXRLZHuOB22Zm26yBr5KGbghObsZynVPgsahEa/F9q+Mg3a6dtr
 raVYNBwdl3i5JE3ux+I68O760vQ5Y/r/nabVocdJn9gIrCDlAxFYtlG8+
 n9QSXwGH2BtA669BO5Qc0MCuJyYWwo9+VujitSiCpeOwn163v56R8pNr8
 YjW3r0Rbhid4nfHDG2N4qjEHH3uQIIBNK7Mx//WPQzJ8Bu6gKKor2fX8m
 LbIgGcBvy1qOZlKxuBhI1rOwVuLuMSSYhYj+FyyUd2uqoYqVxCJG/3PbQ
 24pIZDquk1HEvUNCnQn5zT4VgtznKUcod9+AIkrS69ubJQdiFRXHhNGaV A==;
X-CSE-ConnectionGUID: V+E72utuQhqE4SGtAmmYWg==
X-CSE-MsgGUID: w7sJWFztQWeKJTnOnwsDCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="85802345"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="85802345"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 23:56:17 -0700
X-CSE-ConnectionGUID: RE1eX4R+QEm8ZMh339y7FA==
X-CSE-MsgGUID: pYhZOP3aTlmyINgEoZUj/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="244865887"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 23:56:15 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org,
 junjie.cao@intel.com
Subject: [PATCH 4/6] hw/cxl: free in-flight sanitize state on reset
Date: Fri, 26 Jun 2026 14:21:47 +0800
Message-ID: <20260626062149.1844334-5-junjie.cao@intel.com>
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

Per CXL r4.0 Section 8.2.9.4, "Background commands do not continue to
execute across Conventional Resets."  If a sanitize or media operation
is in progress when the device is reset, the background timer is already
cancelled and freed via cxl_destroy_cci(), but the per-operation state
(media_op_sanitize) is heap-allocated separately and would otherwise be
leaked.

Free it unconditionally at the end of the reset hold phase.  The timer
that advances the operation lives in the CCI that was just destroyed and
re-initialized, so the operation can never complete after a reset of any
type; preserving the heap state across reset has no benefit and would
leak it the next time media_op_sanitize is assigned.

Note that Section 8.2.10.9.5.1 additionally requires a device whose
Sanitize was interrupted by reset to remain in the Media Disabled state
until a successful Sanitize completes.  That latch is not modelled here
(reset re-enables media via memdev_reg_init_common()) and is left for
future work; this patch only addresses the resource leak.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/mem/cxl_type3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b842e71c66..a5e6df3033 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1361,6 +1361,16 @@ static void ct3d_reset_hold(Object *obj, ResetType type)
     }
     cxl_initialize_t3_ld_cci(&ct3d->ld0_cci, DEVICE(ct3d), DEVICE(ct3d),
                              512); /* Max payload made up */
+
+    /*
+     * Free any in-flight sanitize state unconditionally.  The background
+     * timer that would advance it lives in the CCI just torn down and
+     * re-initialized above, so the operation can never complete after this
+     * point regardless of the reset type; keeping the heap state would only
+     * leak it on the next allocation.
+     */
+    g_free(ct3d->media_op_sanitize);
+    ct3d->media_op_sanitize = NULL;
 }
 
 static const Property ct3_props[] = {
-- 
2.43.0


