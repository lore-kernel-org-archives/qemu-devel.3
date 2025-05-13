Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6B7C3ABD9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmYq-0000vh-Bi; Tue, 13 May 2025 06:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEmYo-0000s4-MN
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:08:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEmYm-0007w6-Es
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747130907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZUSMweSqLYmiILgrECbaPfCTGxuVsnyfUaa8kHY29E=;
 b=QrYER3/l+lYlR0xeJXScqJbP5T9SuxduZOCTRkDB4HyITklHaou6J7JmuQaLkYZCEz4q+z
 uZFiMA6qHMzaP+Nmzs0wKcm+g0JM0v+1J7LzbkXoUgVWt6oahlovC1msVbooZ4s4hHLJX6
 RO56I4lI2TBwQTrkO/o1tzDjZRDrBRs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-EIofWRUAMQW6VMszJFpaNg-1; Tue,
 13 May 2025 06:08:26 -0400
X-MC-Unique: EIofWRUAMQW6VMszJFpaNg-1
X-Mimecast-MFC-AGG-ID: EIofWRUAMQW6VMszJFpaNg_1747130905
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E7BF19560AD
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:08:25 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.110])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE0C219560AB; Tue, 13 May 2025 10:08:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/3] ui/vnc.c: replace big endian flag with byte order value
Date: Tue, 13 May 2025 11:08:17 +0100
Message-ID: <20250513100819.1179249-2-berrange@redhat.com>
In-Reply-To: <20250513100819.1179249-1-berrange@redhat.com>
References: <20250513100819.1179249-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

From: Daniel P. Berrangé <berrange@redhat.com>

It will make it easier to do certain comparisons in future if we
store G_BIG_ENDIAN/G_LITTLE_ENDIAN directly, instead of a boolean
flag.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/vnc-enc-tight.c | 2 +-
 ui/vnc-enc-zrle.c  | 2 +-
 ui/vnc-jobs.c      | 2 +-
 ui/vnc.c           | 6 +++---
 ui/vnc.h           | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index 41f559eb83..f51f618e46 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -150,7 +150,7 @@ tight_detect_smooth_image24(VncState *vs, int w, int h)
      * If client is big-endian, color samples begin from the second
      * byte (offset 1) of a 32-bit pixel value.
      */
-    off = vs->client_be;
+    off = vs->client_bo == G_BIG_ENDIAN ? 1 : 0;
 
     memset(stats, 0, sizeof (stats));
 
diff --git a/ui/vnc-enc-zrle.c b/ui/vnc-enc-zrle.c
index bd33b89063..9032e82ee5 100644
--- a/ui/vnc-enc-zrle.c
+++ b/ui/vnc-enc-zrle.c
@@ -255,7 +255,7 @@ static void zrle_write_u8(VncState *vs, uint8_t value)
 static int zrle_send_framebuffer_update(VncState *vs, int x, int y,
                                         int w, int h)
 {
-    bool be = vs->client_be;
+    bool be = vs->client_bo == G_BIG_ENDIAN;
     size_t bytes;
     int zywrle_level;
 
diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index fcca7ec632..fd019e0a35 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -188,7 +188,7 @@ static void vnc_async_encoding_start(VncState *orig, VncState *local)
     local->lossy_rect = orig->lossy_rect;
     local->write_pixels = orig->write_pixels;
     local->client_pf = orig->client_pf;
-    local->client_be = orig->client_be;
+    local->client_bo = orig->client_bo;
     local->tight = orig->tight;
     local->zlib = orig->zlib;
     local->hextile = orig->hextile;
diff --git a/ui/vnc.c b/ui/vnc.c
index 9e097dc4b4..2c640d8be4 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -891,7 +891,7 @@ void vnc_convert_pixel(VncState *vs, uint8_t *buf, uint32_t v)
         buf[0] = v;
         break;
     case 2:
-        if (vs->client_be) {
+        if (vs->client_bo == G_BIG_ENDIAN) {
             buf[0] = v >> 8;
             buf[1] = v;
         } else {
@@ -901,7 +901,7 @@ void vnc_convert_pixel(VncState *vs, uint8_t *buf, uint32_t v)
         break;
     default:
     case 4:
-        if (vs->client_be) {
+        if (vs->client_bo == G_BIG_ENDIAN) {
             buf[0] = v >> 24;
             buf[1] = v >> 16;
             buf[2] = v >> 8;
@@ -2312,7 +2312,7 @@ static void set_pixel_format(VncState *vs, int bits_per_pixel,
     vs->client_pf.bits_per_pixel = bits_per_pixel;
     vs->client_pf.bytes_per_pixel = bits_per_pixel / 8;
     vs->client_pf.depth = bits_per_pixel == 32 ? 24 : bits_per_pixel;
-    vs->client_be = big_endian_flag;
+    vs->client_bo = big_endian_flag ? G_BIG_ENDIAN : G_LITTLE_ENDIAN;
 
     if (!true_color_flag) {
         send_color_map(vs);
diff --git a/ui/vnc.h b/ui/vnc.h
index acc53a2cc1..f2a627dcdf 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -323,7 +323,7 @@ struct VncState
     VncWritePixels *write_pixels;
     PixelFormat client_pf;
     pixman_format_code_t client_format;
-    bool client_be;
+    int client_bo; /* G_LITTLE_ENDIAN or G_BIG_ENDIAN */
 
     CaptureVoiceOut *audio_cap;
     struct audsettings as;
-- 
2.49.0


