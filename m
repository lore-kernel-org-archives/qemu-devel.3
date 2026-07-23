Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D20C44532
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmi4G-0004dc-UF; Wed, 22 Jul 2026 21:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wmi44-0004a0-Hu; Wed, 22 Jul 2026 21:17:32 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wmi41-0002y5-MP; Wed, 22 Jul 2026 21:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784769449; x=1816305449;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=msD/IOsgmuLyQHdlEUt3k5JKbV4W8J9VzDhB5nHKV2I=;
 b=OwOqotLwrxt3w3B8Av9bqhCMJFwoDXZIuLt4Xb5BlLJY2EDeLgvcFTYo
 8Xw9iT2x604FwPVAB+me5N5+a5WXiablxdrn1V/MWvRAjkqhME/Sy9kKx
 ofOPpcoVREsPBuD6xg866+AR/wB6CO7kmaC1BxzctjGxpRLuKEPhiQCa9
 LFkQR8VyelDkegYayeb+gfeq18VT5ZWMmNGyuX0Evon/9LIynhUJf2uVF
 Kra/nuIpjakgvKmmb0OO/PQPxc4NMSpONPbc2Qtdp10gzfBDVSNlBxI1z
 P0dgfyPfTT1WHSzlImv2UTYSsXuqBAjkJQYKfHJUH2DSfEq3/foLoNOqM Q==;
X-CSE-ConnectionGUID: MPaX3SlEQtKYarrp1OCUhA==
X-CSE-MsgGUID: d3VdFXcMQmuTp1fwqidGxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96074849"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; d="scan'208";a="96074849"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 18:17:27 -0700
X-CSE-ConnectionGUID: Dl9Y9zC2RNaOcTDehEnZWA==
X-CSE-MsgGUID: OvRJj6M5RqWgR14rnKSHsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; d="scan'208";a="251943358"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 18:17:26 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, qemu-stable@nongnu.org
Subject: [PATCH v2 4/6] hw/cxl: free in-flight sanitize state on reset
Date: Thu, 23 Jul 2026 09:16:23 +0800
Message-ID: <20260723011625.1117034-5-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723011625.1117034-1-junjie.cao@intel.com>
References: <20260723011625.1117034-1-junjie.cao@intel.com>
MIME-Version: 1.0
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


