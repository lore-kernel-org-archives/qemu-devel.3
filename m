Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0F1C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x974h-0004z5-Br; Tue, 22 Sep 2026 16:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x972N-0001Ks-Fj
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:26 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x972L-0000ag-6o
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790108661; x=1821644661;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=YyqRli4H608p1b8QxUUSqcO1vhTHgaeHPORppEXci70=;
 b=elOzSlwJchgkhm1HvaJflAMhR8Ismg4q8Y0omaw4snGmJ7tB3er9P/gv
 IILvrYIL/wTfrWVOvfJktX5UEwzAC/rioIVpv21fNLwyVo3TsPlWTb8Is
 56zP61/UdyKqW7r4P46DiQAlYHMY331+Nuw8bP5a4DZtG38tHbtatf7cK
 h5mcti3FA0KTMAHqMiCLYpa1byqOh6rPI4SGvolttTmaU9z98H08weMg2
 slIsTCNFsYe8sH8nzZSFVtWrWGYOh5IJ3+ePWSYsK4iUdg+3rvLlTs4Ug
 78Ho5JG5gIdl8Uy+so3tYbmyjqzXFkxzGpAapQ3tdVvkHp/Q8W78M30oB A==;
X-CSE-ConnectionGUID: Rf6esumvSKKjR/fE0S4u1g==
X-CSE-MsgGUID: P5DyqKevTr6aizMLNDA5ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90619546"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; d="scan'208";a="90619546"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 13:24:13 -0700
X-CSE-ConnectionGUID: HgTZd+/ERFmFbTC+KZ1Zlg==
X-CSE-MsgGUID: RKtwJdw2S/W5LgY7k+Hvww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; d="scan'208";a="272487006"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.80.113.172])
 by fmviesa010.fm.intel.com with ESMTP; 22 Sep 2026 13:24:13 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/usb/hcd-xhci: Clamp overshot isochronous kick time
Date: Wed, 12 Aug 2026 03:43:10 -0700
Message-Id: <20260812104310.38292-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: "Chew, Tong Liang" <tong.liang.chew@intel.com>

When an isochronous transfer's Frame ID is reconstructed from the current
MFINDEX epoch, a delayed I/O thread can make the selected frame appear to
be in the past. The existing recovery advances the kick by one MFINDEX
epoch, which can place the transfer roughly two seconds in the future.

The xHCI specification allows a Frame ID to be scheduled only up to
895 ms (0x1BF8 microframes) ahead of the current MFINDEX. Clamp an
epoch-adjusted kick beyond that range to the current MFINDEX so the
missed transfer is dispatched immediately instead of waiting for the
kick timer.

Signed-off-by: Tong Liang Chew <tong.liang.chew@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 hw/usb/hcd-xhci.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index d342aa2739..0642b5dc4f 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1763,12 +1763,30 @@ static void xhci_calc_iso_kick(XHCIState *xhci, XHCITransfer *xfer,
             xfer->mfindex_kick = asap;
         }
     } else {
-        xfer->mfindex_kick = ((xfer->trbs[0].control >> TRB_TR_FRAMEID_SHIFT)
-                              & TRB_TR_FRAMEID_MASK) << 3;
+        uint32_t frame_id = (xfer->trbs[0].control >> TRB_TR_FRAMEID_SHIFT)
+                            & TRB_TR_FRAMEID_MASK;
+        xfer->mfindex_kick = (uint64_t)frame_id << 3;
         xfer->mfindex_kick |= mfindex & ~0x3fff;
         if (xfer->mfindex_kick + 0x100 < mfindex) {
             xfer->mfindex_kick += 0x4000;
         }
+        /*
+         * Guard against epoch-advance overshoot: when the IO thread is briefly
+         * delayed, mfindex can advance past frame_kick by more than the 0x100
+         * lookahead threshold above. Adding 0x4000 then places mfindex_kick
+         * ~2 seconds into the future, stalling all isochronous transfers until
+         * the kick timer fires (observed as periodic ~2.1 s USB audio/video
+         * stalls).
+         *
+         * Per xHCI specification section 4.11.2.5, a Frame ID is valid only
+         * up to 895 ms (0x1BF8 microframes) ahead of the current MFINDEX. If
+         * epoch reconstruction places the kick beyond that range, clamp it
+         * to the current MFINDEX so the missed transfer is dispatched
+         * immediately instead of stalling.
+         */
+        if (xfer->mfindex_kick > mfindex + 0x1BF8) {
+            xfer->mfindex_kick = mfindex;
+        }
     }
 }
 
@@ -1776,8 +1794,9 @@ static void xhci_check_intr_iso_kick(XHCIState *xhci, XHCITransfer *xfer,
                                      XHCIEPContext *epctx, uint64_t mfindex)
 {
     if (xfer->mfindex_kick > mfindex) {
+        uint64_t delay_mf = xfer->mfindex_kick - mfindex;
         timer_mod(epctx->kick_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-                       (xfer->mfindex_kick - mfindex) * 125000);
+                       delay_mf * 125000);
         xfer->running_retry = 1;
     } else {
         epctx->mfindex_last = xfer->mfindex_kick;
-- 
2.43.0


