Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33F4C44536
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmi3s-0004Xv-QA; Wed, 22 Jul 2026 21:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wmi3q-0004XO-Ap; Wed, 22 Jul 2026 21:17:18 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wmi3o-0002xF-Ni; Wed, 22 Jul 2026 21:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784769436; x=1816305436;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bUy4y8HW0wfdIIGwFykmmFvUk5kLIyAYGJ6OVufZCcQ=;
 b=R4+H8p8Z7k3OMBns6NGX0mgiytTvBGp4RQsB+Tn9UAI9UVKf4gDfAOW9
 b8UIGP1cahP8rsK3gKUbbj3SlbIawrF1EoUpdLhUrolYj7rRDqRWtFnbZ
 /SE89P/EgL2eg35Rukiid+g19BQQKYP0trriLvaMLAWf4M8/ib0Q9ALzU
 DWNH4V0oMU6ntHw9DjalWX3Uks8D9tzO6+u4rRM8iWySCSfjIj2KnRsVw
 o4rSbLZd3vfXcJwZoa6tpGkHJn2pNrDy4pNSWU9wMtAw+ckkRyyQtl/t8
 0lQAc8FzU+HeVWJHmGcAGhfnZPSEBYBbRG2HytRHb3nDI5wi7JruFDsAV A==;
X-CSE-ConnectionGUID: 6E/9qsR/TQmg3+Isu1fYnA==
X-CSE-MsgGUID: AZ2kEZdyRNewKC38W2BsYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96074831"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; d="scan'208";a="96074831"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 18:17:14 -0700
X-CSE-ConnectionGUID: WBJjti8ISJmASN3vb3+jRg==
X-CSE-MsgGUID: 6/5Q7KSLR2+GFgXFsMn6SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; d="scan'208";a="251943345"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 18:17:13 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, qemu-stable@nongnu.org
Subject: [PATCH v2 1/6] hw/cxl: fix timer leak in cxl_destroy_cci()
Date: Thu, 23 Jul 2026 09:16:20 +0800
Message-ID: <20260723011625.1117034-2-junjie.cao@intel.com>
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

cxl_init_cci() allocates a QEMUTimer via timer_new_ms() but
cxl_destroy_cci() never frees it.  This leaks a timer object on every
device exit path and, more critically, on every device reset cycle since
the secondary CCIs (vdm_fm_owned_ld_mctp_cci, ld0_cci) are destroyed
and re-initialized each time ct3d_reset() runs.

Tear the CCI down in the reverse of cxl_init_cci()'s setup order:
destroy the mutex, then free the timer.  timer_free() cancels any
pending expiry via timer_del() internally and tolerates a NULL pointer;
clear the field afterwards so that a repeated timer_free() on the same
CCI is a safe no-op.
(The function as a whole is still not idempotent: qemu_mutex_destroy()
asserts on an already-destroyed mutex.  Callers must not invoke
cxl_destroy_cci() twice; the .initialized guard added in the next patch
enforces that.)

Fixes: 98cbac128f1c ("hw/cxl: Support aborting background commands")
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/cxl/cxl-mailbox-utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 20e0b7e476..a1b9f0243b 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -4771,6 +4771,8 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
 void cxl_destroy_cci(CXLCCI *cci)
 {
     qemu_mutex_destroy(&cci->bg.lock);
+    timer_free(cci->bg.timer);
+    cci->bg.timer = NULL;
     cci->initialized = false;
 }
 
-- 
2.43.0


