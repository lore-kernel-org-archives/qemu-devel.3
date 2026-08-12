Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0948C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuATt-0005hx-SM; Wed, 12 Aug 2026 11:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAS8-0004OP-Im; Wed, 12 Aug 2026 11:01:17 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAS6-0002Ci-EC; Wed, 12 Aug 2026 11:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546233; bh=2inuG5gGi4ikqltWX8WtERlQinccMgT3+4ibIZhFZfE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DUVYzU6L4d8Z8IPXi6A2qn5X4UylDE6etnMK75WrVjxpZju6JbOE6vdH8WHbge/yl
 o1cY9DO4oGcofBLQpFNkrCZxJAoEP2NCyaTAltAgG5C4NjzGs/urVX/iXi16aRIFhj
 lWNfcvDBLvOzJgQTVSODoKyg+KZqkY63+wG8dl1YVsJoipKLOukkUfFs6MIx+Nb8mx
 4CUT5WuIjmr9lIQ4c/4Gy1Lz88U745Mu4wBKfQRVt7R00LsykKhY/8GjvGIoOFa23u
 4ff7vWD+zIQhTqzVZojT7gthL3RhRVYGtjk4WwFVTUdhCIGOH3mSC873fqPsK/JX5s
 ZdGSqHf9aFFpw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BAA261CA66D;
 Wed, 12 Aug 2026 17:50:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 216E6409DB2;
 Wed, 12 Aug 2026 17:50:45 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7DFBA2FA35; Wed, 12 Aug 2026 17:50:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Warisjeet Singh <sinxx198@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 105/120] hw/display/vga: fix panning_buf OOB after
 text/graphics switch
Date: Wed, 12 Aug 2026 17:49:28 +0300
Message-ID: <20260812144955.649205-105-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The fields last_width and last_height serve two purposes: the text
renderer counts in characters, the graphics renderer in pixels.
panning_buf reallocation is guarded by geometry-change check, so the
unit mismatch can trick it into thinking nothing changed when the
resolution actually grew.

A guest can trigger this by switching graphics -> text -> graphics:

  1. Enter graphics mode with a small width (CR01=0x00, 8 pixels).
     The predicate fires and panning_buf is allocated for that width.

  2. Switch to text mode with a large width (CR01=0xFF, 256 chars).
     The text renderer stores 256 into last_width. The text path
     never touches panning_buf.

  3. Switch back to graphics with a width that happens to equal 256
     in pixels (CR01=0x1F, 32*8 = 256). The predicate sees
     256 == 256 and skips the realloc. With horizontal pel panning
     enabled, vga_draw_line4() then writes a full 256-pixel scanline
     into the buffer still sized for 8 pixels -- a 960-byte heap
     overflow on every scanline, every refresh.

Fix it by reallocating unconditionally panning_buf on
vga_draw_graphic().

Fixes: CVE-2026-17516
Fixes: 973a724eb006 ("vga: implement horizontal pel panning in graphics modes")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4085
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Warisjeet Singh <sinxx198@gmail.com>
[ Marc- André - drop realloc() resize condition & commit message ]
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260728151456.3704099-1-marcandre.lureau@redhat.com>
(cherry picked from commit 95687639e647ec917226e6d3a6713a2b373e1ffe)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/vga.c b/hw/display/vga.c
index ee7d97b5c21..f9f3d054f61 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1630,11 +1630,12 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         s->last_line_offset = s->params.line_offset;
         s->last_depth = depth;
         s->last_byteswap = byteswap;
-        /* 16 extra pixels are needed for double-width planar modes.  */
-        s->panning_buf = g_realloc(s->panning_buf,
-                                   (disp_width + 16) * sizeof(uint32_t));
         full_update = 1;
     }
+
+    /* 16 extra pixels are needed for double-width planar modes. */
+    s->panning_buf = g_realloc(s->panning_buf,
+                               (disp_width + 16) * sizeof(uint32_t));
     if (surface_data(surface) != s->vram_ptr + (s->params.start_addr * 4)
         && !surface_is_allocated(surface)) {
         /* base address changed (page flip) -> shared display surfaces
-- 
2.47.3


