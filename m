Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3F8CDB471
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM2D-0008PI-66; Wed, 24 Jun 2026 07:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM2A-0008Bu-6P
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:44:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM28-0008R7-EA
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cw37MLYe4JL3eomyC5TftfpblK/jJOsSIUjzz8Hwoj4=;
 b=EdHjXnGBhSK1a2dSJ0Y7C2rvkO44n15O/B3KPZZWgElvW0pxXl9RcV4zwLqPnb9WeSmGu0
 gSk/sx8q4Z1Hrl8m17pTIKqdsj+NNvWzZCqpqORptm2FxPgeYz2dUEm3TIAB6dPyJnMcay
 66O9KWW5WcP8U2DQMIh5fkj6fIaZ0FY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-eHMedxbGOjCpKL4LZ4_axw-1; Wed,
 24 Jun 2026 07:44:42 -0400
X-MC-Unique: eHMedxbGOjCpKL4LZ4_axw-1
X-Mimecast-MFC-AGG-ID: eHMedxbGOjCpKL4LZ4_axw_1782301481
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85DE91800841
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:44:41 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 52EE2180058F; Wed, 24 Jun 2026 11:44:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:57 +0400
Subject: [GIT PULL 35/35] vga: implement text mode character blink
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-35-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3736;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=jPlHF8uxSTi/iiSrhf6Uyjsrv1BONf9nTUXGshN9O7w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8JpxZPRzuqkwqi/+gaCk8CQyFbTW6qW9Ugc2
 la8ehCqf16JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCaQAKCRDa6OEJdZac
 5UVwD/4w/ix5NeiEbc5ACoGVMdVdrGqQ6+yEY/EqQBgxuPK7mr5n5olSug2C8JV5pvuK6H3dFOs
 vJq2D22aiOffpZBPts9iKUr5qkrJ75DNoS4CqsiMMg/fhd1jDx4xOb1kMJtcfoDiOWoKMok17PM
 m85TG8kj4Oty/yCNjHySL5Kq6BLtDnzneEeGIafn3v9pFjVrh10S2hrTBosdcxjV3+x0eO/WX8C
 rkGbzOwOhtFDbRQFA+bkN/FmI/yeQaIvD66Mx1i88GN3yhOsHv96p6lPg6uFUw7BtUBGTHCnIl0
 pUiOwinYa8gAhbdQt/ORt++6o4WRaepiE8nDkTD52KqUwi+Skn1AxpVgk5ivtj6vPZvfzSRhUyi
 r2yi1zD7ENzX/C1AT+GnMO+GjpyyprZwgaBSP+YmVwP4bzHMRXTthQbHJV6RZ/KLG9Hufj14psQ
 L1rxZC6Lg7BHEsXbFebk20FxdOBIHNdZ99LMcPfHDfVFFelnmiyH2dAMWFfSiMshI5cK1rBrXiu
 fD2tL1pWOqCHx9881URpJc6zhhelzg1mKS8g0OmWIdkyBIcwYct/Ia61GpdLatdHeocZN6OGvDC
 QzIej96NG+ivKtbbFNj00Mlb746jYH21Axq9SK6bgycbymFrjIIRXG6Rn7UhOTqLL8MFqxq5DMR
 wF17vmYyJ6CdBVw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When bit 3 of the VGA Attribute Mode Control register is set, attribute
bit 7 switches from selecting bright background colors to enabling
character blink.

Implement this by tracking a separate blink phase timer that toggles
every 32 frames (matching real VGA hardware frame counter bit 5 @60hz),
and rendering blinking characters by replacing their foreground with
background during the off phase.

As with cursor, no VMState migration of the fields, as they are
transient display-side states.

Related to: https://gitlab.com/qemu-project/qemu/-/work_items/1585
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260525081944.1494798-1-marcandre.lureau@redhat.com>
---
 hw/display/vga_int.h |  2 ++
 hw/display/vga.c     | 25 +++++++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index 747b5cc6cf8..5664317ecd6 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -130,6 +130,8 @@ typedef struct VGACommonState {
     uint8_t cursor_start, cursor_end;
     bool cursor_visible_phase;
     int64_t cursor_blink_time;
+    bool blink_visible_phase;
+    int64_t blink_time;
     uint32_t cursor_offset;
     const GraphicHwOps *hw_ops;
     bool full_update_text;
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 3ea20d7b0f8..abe3f8e0775 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -45,8 +45,10 @@
 
 bool have_vga = true;
 
-/* 16 state changes per vertical frame @60 Hz */
+/* frame counter bit 4: cursor blink toggles every 16 frames @60 Hz */
 #define VGA_TEXT_CURSOR_PERIOD_MS       (1000 * 2 * 16 / 60)
+/* frame counter bit 5: character blink toggles every 32 frames @60 Hz */
+#define VGA_TEXT_BLINK_PERIOD_MS        (1000 * 2 * 32 / 60)
 
 /* Address mask for non-VESA modes.  */
 #define VGA_VRAM_SIZE                   (256 * KiB)
@@ -1190,7 +1192,6 @@ static void vga_get_text_resolution(VGACommonState *s, int *pwidth, int *pheight
  * - double scan
  * - double width
  * - underline
- * - flashing
  */
 static void vga_draw_text(VGACommonState *s, int full_update)
 {
@@ -1286,6 +1287,13 @@ static void vga_draw_text(VGACommonState *s, int full_update)
         s->cursor_blink_time = now + VGA_TEXT_CURSOR_PERIOD_MS / 2;
         s->cursor_visible_phase = !s->cursor_visible_phase;
     }
+    if (now >= s->blink_time) {
+        s->blink_time = now + VGA_TEXT_BLINK_PERIOD_MS / 2;
+        s->blink_visible_phase = !s->blink_visible_phase;
+        if (s->ar[VGA_ATC_MODE] & 0x08) {
+            full_update = 1;
+        }
+    }
 
     dest = surface_data(surface);
     linesize = surface_stride(surface);
@@ -1317,8 +1325,17 @@ static void vga_draw_text(VGACommonState *s, int full_update)
 #endif
                 font_ptr = font_base[(cattr >> 3) & 1];
                 font_ptr += 32 * 4 * ch;
-                bgcol = palette[cattr >> 4];
-                fgcol = palette[cattr & 0x0f];
+                if (s->ar[VGA_ATC_MODE] & 0x08) {
+                    bgcol = palette[(cattr >> 4) & 0x07];
+                    if ((cattr & 0x80) && !s->blink_visible_phase) {
+                        fgcol = bgcol;
+                    } else {
+                        fgcol = palette[cattr & 0x0f];
+                    }
+                } else {
+                    bgcol = palette[cattr >> 4];
+                    fgcol = palette[cattr & 0x0f];
+                }
                 if (cw == 16) {
                     vga_draw_glyph16(d1, linesize,
                                      font_ptr, cheight, fgcol, bgcol);

-- 
2.54.0


