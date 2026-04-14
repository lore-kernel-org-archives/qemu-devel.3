Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E212F9D0D1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCdsw-0006MV-CC; Tue, 14 Apr 2026 09:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wCdst-0006Ln-Ev; Tue, 14 Apr 2026 09:32:55 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wCdsr-0004dq-Tv; Tue, 14 Apr 2026 09:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776173574; x=1807709574;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ol2Im+QdI5af/C0v0OW53VBVcDkWA8XbSwTicgQ7LLk=;
 b=SD89Gb1JGdOe1Te3lgCpP40DwtJ12BNDkSXdGax82kYZzjd+JBV0c7m0
 Y5/vNutGdRrzUgU1OKXOGtcGyUxBw69q98M/FTGZYDO8e2E9Qm4bq0Gd2
 97o+FvdAWGWWyVGRZ5zVthvrCc+FXhtGopA3awNl/7nhxr9doLiIsi+R1
 abOJHJ/MXwJndYDqL9Es1TVY/cirLm0tKHaCXTYk3T1e5e9ox/GxAkRBJ
 INS+nkLhWDTJUD7C3h8ASMZZCmhLwzxLt87NM5JfmmJdaxs+egtEJSVcY
 hL4Q+9DMNnLsVNqkJoHmpVBsH3WxucKOtiXSTuBqxJuJdOjGdUM5kYkUg g==;
X-CSE-ConnectionGUID: f9vv/CHWSGKOEHTIm9W3nA==
X-CSE-MsgGUID: 8I6bM1esT3+ritE41HzPyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77201467"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="77201467"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2026 06:32:52 -0700
X-CSE-ConnectionGUID: Oq6X1b+eQqSVijzdWNGFtA==
X-CSE-MsgGUID: gW91qacwROSGWN6ZWun+og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="227448001"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by fmviesa008-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 06:32:50 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chad Jablonski <chad@jablonski.xyz>, qemu-stable@nongnu.org,
 junjie.cao@intel.com
Subject: [PATCH v2 2/2] ati-vga: mask out lock bit from CUR_OFFSET in cursor
 offset calculation
Date: Wed, 15 Apr 2026 05:35:23 +0800
Message-ID: <20260414213523.1125859-2-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414213523.1125859-1-junjie.cao@intel.com>
References: <20260414213523.1125859-1-junjie.cao@intel.com>
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

Bit 31 of CUR_OFFSET is the cursor lock bit, not part of the actual
cursor address (bits 26:4).  Although the callers already check for the
lock bit and return early, mask it out with 0x07fffff0 when computing
the cursor source offset so the calculation only uses the address bits.

Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 hw/display/ati.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 0489995d00..3a7d45a882 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -147,7 +147,7 @@ static void ati_cursor_define(ATIVGAState *s)
         return; /* Do not update cursor if locked or rendered by guest */
     }
     /* FIXME handle cur_hv_offs correctly */
-    srcoff = s->regs.cur_offset - (s->regs.cur_hv_offs >> 16) -
+    srcoff = (s->regs.cur_offset & 0x07fffff0) - (s->regs.cur_hv_offs >> 16) -
              (s->regs.cur_hv_offs & 0xffff) * 16;
     if (srcoff > s->vga.vram_size - 64 * 16) {
         return;
@@ -176,13 +176,15 @@ static void ati_cursor_invalidate(VGACommonState *vga)
     if (s->cursor_size != size ||
         vga->hw_cursor_x != s->regs.cur_hv_pos >> 16 ||
         vga->hw_cursor_y != (s->regs.cur_hv_pos & 0xffff) ||
-        s->cursor_offset != s->regs.cur_offset - (s->regs.cur_hv_offs >> 16) -
+        s->cursor_offset != (s->regs.cur_offset & 0x07fffff0) -
+        (s->regs.cur_hv_offs >> 16) -
         (s->regs.cur_hv_offs & 0xffff) * 16) {
         /* Remove old cursor then update and show new one if needed */
         vga_invalidate_scanlines(vga, vga->hw_cursor_y, vga->hw_cursor_y + 63);
         vga->hw_cursor_x = s->regs.cur_hv_pos >> 16;
         vga->hw_cursor_y = s->regs.cur_hv_pos & 0xffff;
-        s->cursor_offset = s->regs.cur_offset - (s->regs.cur_hv_offs >> 16) -
+        s->cursor_offset = (s->regs.cur_offset & 0x07fffff0) -
+                           (s->regs.cur_hv_offs >> 16) -
                            (s->regs.cur_hv_offs & 0xffff) * 16;
         s->cursor_size = size;
         if (size) {
-- 
2.43.0


