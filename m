Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D41C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2TL-00051V-NB; Wed, 17 Jul 2024 07:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2SO-0000WS-E2
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:29 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2SM-0006zL-RI
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:24 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id 81C2F37965C; Mon, 15 Jul 2024 23:07:38 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de,
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 akihiko.odaki@daynix.com, phil@philjordan.eu, lists@philjordan.eu
Subject: [PATCH 26/26] hw/display/apple-gfx: Removes UI pointer support check
Date: Mon, 15 Jul 2024 23:07:05 +0200
Message-Id: <20240715210705.32365-27-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240715210705.32365-1-phil@philjordan.eu>
References: <20240715210705.32365-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=89.104.8.17; envelope-from=phil@intel-mbp.local;
 helo=intel-mbp.local
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, KHOP_HELO_FCRDNS=0.261,
 NO_DNS_FOR_FROM=0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The dpy_cursor_define_supported() check is destined for removal
when the last UI frontend without cursor support (cocoa) gains
cursor integration. This patch is required to reconcile with
that change.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/display/apple-gfx.m | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index e0ad784022..a4789be275 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -175,25 +175,6 @@ static void apple_gfx_render_frame_completed(AppleGFXState *s, void *vram,
         g_free(vram);
     } else {
         copy_mtl_texture_to_surface_mem(texture, vram);
-
-        /* Need to render cursor manually if not supported by backend */
-        if (!dpy_cursor_define_supported(s->con) && s->cursor && s->cursor_show) {
-            pixman_image_t *image =
-                pixman_image_create_bits(PIXMAN_a8r8g8b8,
-                                         s->cursor->width,
-                                         s->cursor->height,
-                                         (uint32_t *)s->cursor->data,
-                                         s->cursor->width * 4);
-
-            pixman_image_composite(PIXMAN_OP_OVER,
-                                   image, NULL, s->surface->image,
-                                   0, 0, 0, 0, s->pgdisp.cursorPosition.x,
-                                   s->pgdisp.cursorPosition.y, s->cursor->width,
-                                   s->cursor->height);
-
-            pixman_image_unref(image);
-        }
-
         if (s->gfx_update_requested) {
             s->gfx_update_requested = false;
             dpy_gfx_update_full(s->con);
@@ -234,11 +215,6 @@ static void update_cursor(AppleGFXState *s)
 {
     dpy_mouse_set(s->con, s->pgdisp.cursorPosition.x,
                   s->pgdisp.cursorPosition.y, s->cursor_show);
-
-    /* Need to render manually if cursor is not natively supported */
-    if (!dpy_cursor_define_supported(s->con)) {
-        s->new_frame = true;
-    }
 }
 
 static void set_mode(AppleGFXState *s, uint32_t width, uint32_t height)
-- 
2.39.3 (Apple Git-146)


