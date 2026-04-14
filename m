Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E005F9D0CD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCdsk-0006KQ-Nl; Tue, 14 Apr 2026 09:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wCdse-0006K4-IG; Tue, 14 Apr 2026 09:32:40 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wCdsa-0004cu-Tt; Tue, 14 Apr 2026 09:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776173557; x=1807709557;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aVLd6fAzNsrg8HssHvbjJoomKlJxcy2FIXt/dMBZIMo=;
 b=OZD95Wm6F9sO5RK8JmdvmPGCGY/ajpq3F2ZGZzq9vulTxWSsE1YJ3wji
 3rKMa6D6iMnM4ft8m2XrcL8je5EFzpeHa7u2eW9O2trRuD7xRo+KCCNkX
 HxFo3r/gJSAbTkaiYdC5idEE3IIIJn+rwaIZRq7hioNBetj2xPGcxJlek
 tdoz7N6bwgL06KubhHryRAJTiEplM7j8BuDdkJWfbkB93OH9bSjdOb1/K
 JneW+1gkP63OfBSVcpdRpU63ivH0wUTUbUGrEsLq87bdNBpcqavtv7zcA
 RfkvTDcKLbM5Dibi++u6AKAX4VFsuz1JCoVWTmJOq24YzrC8LvvFm9Q94 g==;
X-CSE-ConnectionGUID: 9rOChN1+QaWfsgKmftp6zA==
X-CSE-MsgGUID: zAd5NtvpRDalFICQsL+3Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77201411"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="77201411"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2026 06:32:34 -0700
X-CSE-ConnectionGUID: Ko4ALbkaSQiHtRTIZ07LZg==
X-CSE-MsgGUID: tLsSbyNbT3m6529gryJCOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="227447816"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by fmviesa008-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 06:32:32 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chad Jablonski <chad@jablonski.xyz>, qemu-stable@nongnu.org,
 junjie.cao@intel.com
Subject: [PATCH v2 1/2] ati-vga: fix unsigned integer overflow in cursor
 bounds checks
Date: Wed, 15 Apr 2026 05:35:22 +0800
Message-ID: <20260414213523.1125859-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.54, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The cursor bounds checks compare (srcoff + N) against vram_size, but
both sides are uint32_t so the addition can wrap past UINT32_MAX when
srcoff underflows from the cur_hv_offs subtraction, causing the check
to be bypassed.

Rewrite the checks as (srcoff > vram_size - N) to avoid the
overflow-prone addition, matching the style already used in
ati_mm_read() and ati_mm_write().

Fixes: 2f1fbe6ee9b5 ("ati-vga: Make sure hardware cursor data is within vram")
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
Found while running local QEMU fuzz testing.

v2: Collected Reviewed-by, added patch 2/2 to mask out the lock bit
    as suggested by BALATON Zoltan.

 hw/display/ati.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 88a5bbbf07..0489995d00 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -149,7 +149,7 @@ static void ati_cursor_define(ATIVGAState *s)
     /* FIXME handle cur_hv_offs correctly */
     srcoff = s->regs.cur_offset - (s->regs.cur_hv_offs >> 16) -
              (s->regs.cur_hv_offs & 0xffff) * 16;
-    if (srcoff + 64 * 16 > s->vga.vram_size) {
+    if (srcoff > s->vga.vram_size - 64 * 16) {
         return;
     }
     for (int i = 0; i < 64; i++, srcoff += 16) {
@@ -206,7 +206,7 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
     }
     /* FIXME handle cur_hv_offs correctly */
     srcoff = s->cursor_offset + (scr_y - vga->hw_cursor_y) * 16;
-    if (srcoff + 16 > s->vga.vram_size) {
+    if (srcoff > s->vga.vram_size - 16) {
         return;
     }
     dp = &dp[vga->hw_cursor_x];
-- 
2.43.0


