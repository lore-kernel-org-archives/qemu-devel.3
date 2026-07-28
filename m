Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A571C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojWb-0005lE-G9; Tue, 28 Jul 2026 11:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wojWZ-0005kX-Sr
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:15:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wojWY-0006iP-6w
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785251717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BPm4CyG+riu4Sz9s7BSPdkcJ7J5P8LchGv0ARF026jk=;
 b=HOJvpysSPSumBLi3jp3iMi6ckRdS5DGztiZElbHkIe/CaOEKNp3OrGRI4Yv48/tgArjBDf
 HH46ylt80VfhDQmtrl2UTmt8tHdhnCrvyNi/njPM/dbIMn3lXh+hFEFulwc1eB9qoRc5hp
 6aLUUa9A68zx/cZkX9qYhbJ6V0wzb8Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-jmoJEd-JP1ef_8RAGg7NIg-1; Tue,
 28 Jul 2026 11:15:15 -0400
X-MC-Unique: jmoJEd-JP1ef_8RAGg7NIg-1
X-Mimecast-MFC-AGG-ID: jmoJEd-JP1ef_8RAGg7NIg_1785251714
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 110121800345; Tue, 28 Jul 2026 15:15:14 +0000 (UTC)
Received: from localhost (unknown [10.44.24.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EDF7F300019F; Tue, 28 Jul 2026 15:15:10 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Warisjeet Singh <sinxx198@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] hw/display/vga: fix panning_buf OOB after text/graphics switch
Date: Tue, 28 Jul 2026 19:14:56 +0400
Message-ID: <20260728151456.3704099-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/vga.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index abe3f8e07758..da0c331486eb 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1647,11 +1647,12 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
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
2.55.0


