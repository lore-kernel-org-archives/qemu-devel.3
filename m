Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B711CD5BCF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 08:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRQXi-0002fL-1g; Mon, 25 May 2026 04:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wRQXe-0002df-Iw
 for qemu-devel@nongnu.org; Mon, 25 May 2026 04:20:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wRQXa-000249-LD
 for qemu-devel@nongnu.org; Mon, 25 May 2026 04:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779697197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qLya9vILGLfXiq6S5473N7V9FKUlPzgsnJrw6iP1TqQ=;
 b=T+f5JBnwfF1d0ORBeQZS47wbbGh5SPtbWntyuLs9jtdykL1+VOz1/nqxzoy10yGoyyD/+p
 71znF0jGHDD5inSr+TMA4fiKUd7hK3GHh6JF489OrA/I6SzPbjVsBpPMKKq55sEYJ68NT1
 hddKVDYCbz0f90Y8/KOZxYvcpUHpWIM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-Q_AwZLWSPWyu0SdtV_bAxA-1; Mon,
 25 May 2026 04:19:54 -0400
X-MC-Unique: Q_AwZLWSPWyu0SdtV_bAxA-1
X-Mimecast-MFC-AGG-ID: Q_AwZLWSPWyu0SdtV_bAxA_1779697194
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC24D195608E
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:19:53 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 75A8A180034E; Mon, 25 May 2026 08:19:51 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] vga: implement text mode character blink
Date: Mon, 25 May 2026 12:19:44 +0400
Message-ID: <20260525081944.1494798-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When bit 3 of the VGA Attribute Mode Control register is set, attribute
bit 7 switches from selecting bright background colors to enabling
character blink.

Implement this by tracking a separate blink phase timer that toggles
every 32 frames (matching real VGA hardware frame counter bit 5 @60hz),
and rendering blinking characters by replacing their foreground with
background during the off phase.

As with cursor, no VMState migration of the fields, as they are
transient display-side states.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1585
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/vga_int.h |  2 ++
 hw/display/vga.c     | 24 +++++++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

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
index 0ac4bf37310..ea01a889f20 100644
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
@@ -1286,6 +1288,13 @@ static void vga_draw_text(VGACommonState *s, int full_update)
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
@@ -1317,8 +1326,17 @@ static void vga_draw_text(VGACommonState *s, int full_update)
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


