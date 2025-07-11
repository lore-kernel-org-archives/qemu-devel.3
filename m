Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCDAC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua96F-0002mb-W5; Fri, 11 Jul 2025 04:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8xY-0004bl-EO; Fri, 11 Jul 2025 04:18:20 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8xW-00041C-7X; Fri, 11 Jul 2025 04:18:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9BB271356D3;
 Fri, 11 Jul 2025 11:17:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 91C9523FA48;
 Fri, 11 Jul 2025 11:17:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 08/39] ui/vnc.c: replace big endian flag with byte
 order value
Date: Fri, 11 Jul 2025 11:16:04 +0300
Message-ID: <20250711081745.1785806-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

It will make it easier to do certain comparisons in future if we
store G_BIG_ENDIAN/G_LITTLE_ENDIAN directly, instead of a boolean
flag, as we can then compare directly to the G_BYTE_ORDER constant.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit 7ed96710e82c385c6cfc3d064eec7dde20f0f3fd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index 41f559eb83..f8aaa8f346 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -150,7 +150,7 @@ tight_detect_smooth_image24(VncState *vs, int w, int h)
      * If client is big-endian, color samples begin from the second
      * byte (offset 1) of a 32-bit pixel value.
      */
-    off = vs->client_be;
+    off = vs->client_endian == G_BIG_ENDIAN ? 1 : 0;
 
     memset(stats, 0, sizeof (stats));
 
diff --git a/ui/vnc-enc-zrle.c b/ui/vnc-enc-zrle.c
index bd33b89063..97ec6c7119 100644
--- a/ui/vnc-enc-zrle.c
+++ b/ui/vnc-enc-zrle.c
@@ -255,7 +255,7 @@ static void zrle_write_u8(VncState *vs, uint8_t value)
 static int zrle_send_framebuffer_update(VncState *vs, int x, int y,
                                         int w, int h)
 {
-    bool be = vs->client_be;
+    bool be = vs->client_endian == G_BIG_ENDIAN;
     size_t bytes;
     int zywrle_level;
 
diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index fcca7ec632..d3486af9e2 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -188,7 +188,7 @@ static void vnc_async_encoding_start(VncState *orig, VncState *local)
     local->lossy_rect = orig->lossy_rect;
     local->write_pixels = orig->write_pixels;
     local->client_pf = orig->client_pf;
-    local->client_be = orig->client_be;
+    local->client_endian = orig->client_endian;
     local->tight = orig->tight;
     local->zlib = orig->zlib;
     local->hextile = orig->hextile;
diff --git a/ui/vnc.c b/ui/vnc.c
index 9241caaad9..d47879f579 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -893,7 +893,7 @@ void vnc_convert_pixel(VncState *vs, uint8_t *buf, uint32_t v)
         buf[0] = v;
         break;
     case 2:
-        if (vs->client_be) {
+        if (vs->client_endian == G_BIG_ENDIAN) {
             buf[0] = v >> 8;
             buf[1] = v;
         } else {
@@ -903,7 +903,7 @@ void vnc_convert_pixel(VncState *vs, uint8_t *buf, uint32_t v)
         break;
     default:
     case 4:
-        if (vs->client_be) {
+        if (vs->client_endian == G_BIG_ENDIAN) {
             buf[0] = v >> 24;
             buf[1] = v >> 16;
             buf[2] = v >> 8;
@@ -2314,7 +2314,7 @@ static void set_pixel_format(VncState *vs, int bits_per_pixel,
     vs->client_pf.bits_per_pixel = bits_per_pixel;
     vs->client_pf.bytes_per_pixel = bits_per_pixel / 8;
     vs->client_pf.depth = bits_per_pixel == 32 ? 24 : bits_per_pixel;
-    vs->client_be = big_endian_flag;
+    vs->client_endian = big_endian_flag ? G_BIG_ENDIAN : G_LITTLE_ENDIAN;
 
     if (!true_color_flag) {
         send_color_map(vs);
diff --git a/ui/vnc.h b/ui/vnc.h
index acc53a2cc1..02613aa63a 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -323,7 +323,7 @@ struct VncState
     VncWritePixels *write_pixels;
     PixelFormat client_pf;
     pixman_format_code_t client_format;
-    bool client_be;
+    int client_endian; /* G_LITTLE_ENDIAN or G_BIG_ENDIAN */
 
     CaptureVoiceOut *audio_cap;
     struct audsettings as;
-- 
2.47.2


