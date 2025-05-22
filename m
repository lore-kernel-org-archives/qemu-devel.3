Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9B6C54ED1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 10:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI3BG-0002z6-KG; Thu, 22 May 2025 06:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3BD-0002yY-KK
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:29:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3BB-0006MT-OZ
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747909776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8jfTVts1uQnnQOq04ScY/y3ND2kZkyWDQrlQ9FP3OdE=;
 b=J7iGG1qem7Y76g5VWiLyp909usdKG3PvuDKgQTq8ZPs8NFm/u4A5zJY7giL59Bow3zZSpA
 7WWQwA2rcq0p0BFdlnG+ozuiD+KcP3eaBaDtwHS1W/F6vBN0/fow4QZjx2BVpgs8vnK1Zo
 VA39Rlfyrcs7eccqWIm+DF29+0JQJus=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-T5fhH__9P_2qdCk-8Tgg3Q-1; Thu,
 22 May 2025 06:29:33 -0400
X-MC-Unique: T5fhH__9P_2qdCk-8Tgg3Q-1
X-Mimecast-MFC-AGG-ID: T5fhH__9P_2qdCk-8Tgg3Q_1747909772
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F7411956080; Thu, 22 May 2025 10:29:32 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.179])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 32A7C1958014; Thu, 22 May 2025 10:29:28 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 01/23] ui/vnc.c: replace big endian flag with byte order value
Date: Thu, 22 May 2025 11:29:01 +0100
Message-ID: <20250522102923.309452-2-berrange@redhat.com>
In-Reply-To: <20250522102923.309452-1-berrange@redhat.com>
References: <20250522102923.309452-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

It will make it easier to do certain comparisons in future if we
store G_BIG_ENDIAN/G_LITTLE_ENDIAN directly, instead of a boolean
flag, as we can then compare directly to the G_BYTE_ORDER constant.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/vnc-enc-tight.c | 2 +-
 ui/vnc-enc-zrle.c  | 2 +-
 ui/vnc-jobs.c      | 2 +-
 ui/vnc.c           | 6 +++---
 ui/vnc.h           | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

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
index 9e097dc4b4..ab18172c4d 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -891,7 +891,7 @@ void vnc_convert_pixel(VncState *vs, uint8_t *buf, uint32_t v)
         buf[0] = v;
         break;
     case 2:
-        if (vs->client_be) {
+        if (vs->client_endian == G_BIG_ENDIAN) {
             buf[0] = v >> 8;
             buf[1] = v;
         } else {
@@ -901,7 +901,7 @@ void vnc_convert_pixel(VncState *vs, uint8_t *buf, uint32_t v)
         break;
     default:
     case 4:
-        if (vs->client_be) {
+        if (vs->client_endian == G_BIG_ENDIAN) {
             buf[0] = v >> 24;
             buf[1] = v >> 16;
             buf[2] = v >> 8;
@@ -2312,7 +2312,7 @@ static void set_pixel_format(VncState *vs, int bits_per_pixel,
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
2.49.0


