Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4A3C982DE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 05:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Wri-0000sH-6X; Mon, 21 Sep 2026 01:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x8WrX-0000r2-RM; Mon, 21 Sep 2026 01:46:48 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x8WrW-000307-4N; Mon, 21 Sep 2026 01:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789969606; x=1821505606;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xCSUpaggvBwRUFlLr6UpPDjFdEpyrwriyO0y25l3RsM=;
 b=iqqY86crmT0G/tCJQ2xZS3kEt2HjxYRP712cp83Md0IpHF9dRzOVM4OH
 HzWaBdUgKxqoqOEwOjUAi6O/N/qxZGGVPV5L4VBp3QMao2ZuI1KOfmRin
 6fyVVYBdEyLnEw1bb6y4Gwc1oegPZ8JByBTmLLQIZ+Lf8dDdN7E2IqDtI
 MZS4iKx8C8eEdpbeiNxfzJSUT3u2rm0wQKo1duxroXZK4xF5EpWujc+ZA
 jwOzc6qidlcls6lFTNkIMcTiEzidBj+GzARhMo3K128tpfbVPSAa9epr0
 ZOAsEN02gCtJyvTi2lFR5xniWP0EL90hXtQ5H06hukDD/JUsT71BVCuSz g==;
X-CSE-ConnectionGUID: IQxkWYg8TJe6Vtyl2QfYsQ==
X-CSE-MsgGUID: s0ITQ2FyRzy8anVPHJ+epQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="94287027"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="94287027"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 22:46:43 -0700
X-CSE-ConnectionGUID: lMRAczBoSr60I0zEPk8i4g==
X-CSE-MsgGUID: FmVE5xMaSuKafZH7WPUbDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3815191"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 22:46:41 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Feifan Qian <bea1e@proton.me>,
 qemu-stable@nongnu.org
Subject: [PATCH 1/4] hw/usb/hcd-xhci: fix interval alignment after MFINDEX
 passes 2^32
Date: Mon, 21 Sep 2026 13:46:29 +0800
Message-ID: <52c9f935428f2cfc65e4dee7e37638fcb965c6b2.1789968699.git.junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789968699.git.junjie.cao@intel.com>
References: <cover.1789968699.git.junjie.cao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=junjie.cao@intel.com;
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

epctx->interval is an unsigned int, so ~(epctx->interval - 1) is a
32-bit mask that is zero-extended when and-ed with the 64-bit microframe
index. Once mfindex no longer fits in 32 bits (2^32 * 125us, about 6.2
days after the controller was started), asap loses its upper half and
always compares below mfindex. Isoch TDs with SIA are then run at once
instead of at the next interval boundary. xhci_calc_intr_kick() has the
same expression.

Use ROUND_UP(), which builds the mask in the type of mfindex. The
interval is always a power of two.

The reporter of #3973 also saw the symptom with UHCI. This change does
not explain that.

Fixes: 3d1396842d ("xhci: iso xfer support")
Fixes: 4d7a81c06f ("xhci: emulate intr endpoint intervals correctly")
Link: https://gitlab.com/qemu-project/qemu/-/issues/3973
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/usb/hcd-xhci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index d342aa2739..ce042e74bd 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1742,8 +1742,7 @@ static int xhci_fire_ctl_transfer(XHCIState *xhci, XHCITransfer *xfer)
 static void xhci_calc_intr_kick(XHCIState *xhci, XHCITransfer *xfer,
                                 XHCIEPContext *epctx, uint64_t mfindex)
 {
-    uint64_t asap = ((mfindex + epctx->interval - 1) &
-                     ~(epctx->interval-1));
+    uint64_t asap = ROUND_UP(mfindex, epctx->interval);
     uint64_t kick = epctx->mfindex_last + epctx->interval;
 
     assert(epctx->interval != 0);
@@ -1754,8 +1753,7 @@ static void xhci_calc_iso_kick(XHCIState *xhci, XHCITransfer *xfer,
                                XHCIEPContext *epctx, uint64_t mfindex)
 {
     if (xfer->trbs[0].control & TRB_TR_SIA) {
-        uint64_t asap = ((mfindex + epctx->interval - 1) &
-                         ~(epctx->interval-1));
+        uint64_t asap = ROUND_UP(mfindex, epctx->interval);
         if (asap >= epctx->mfindex_last &&
             asap <= epctx->mfindex_last + epctx->interval * 4) {
             xfer->mfindex_kick = epctx->mfindex_last + epctx->interval;
-- 
2.43.0


