Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAC8C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 14:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYRVR-0002d4-SS; Fri, 09 Feb 2024 09:05:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVP-0002ac-Bl
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:05:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVN-0004FU-Oa
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:05:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707487525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=59s3VRSA6AJJC3CBzqVZ7uJT8l4H2XwxYERxSuEO6nk=;
 b=RTh/5rsrORHwereVTUwKGEtgIvaR4We/dB6gAw0S1W3MIeIiFNUcMl6nqePOGjniz3FWlE
 0OhBnIRCZMLdIlUooJhtS0cgqdU4jEdsbsBQKdHUmNXlhJFZhO53Zp4Tgz8VeLfiGZOFYI
 Vggxd4X/mweW7x7nea7z1/eFTp2aqVA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-9lw5ee3qNkO7IBCqS0VpEw-1; Fri, 09 Feb 2024 09:05:20 -0500
X-MC-Unique: 9lw5ee3qNkO7IBCqS0VpEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E7FB8F9205;
 Fri,  9 Feb 2024 14:05:19 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F10F111FF;
 Fri,  9 Feb 2024 14:05:17 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 04/17] ui: drop VNC feature _MASK constants
Date: Fri,  9 Feb 2024 14:04:52 +0000
Message-ID: <20240209140505.2536635-5-berrange@redhat.com>
In-Reply-To: <20240209140505.2536635-1-berrange@redhat.com>
References: <20240209140505.2536635-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Each VNC feature enum entry has a corresponding _MASK constant
which is the bit-shifted value. It is very easy for contributors
to accidentally use the _MASK constant, instead of the non-_MASK
constant, or the reverse. No compiler warning is possible and
it'll just silently do the wrong thing at runtime.

By introducing the vnc_set_feature helper method, we can drop
all the _MASK constants and thus prevent any future accidents.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/vnc.c | 34 +++++++++++++++++-----------------
 ui/vnc.h | 22 +++++-----------------
 2 files changed, 22 insertions(+), 34 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 4f23a0fa79..3db87fd89c 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2144,16 +2144,16 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
             vs->vnc_encoding = enc;
             break;
         case VNC_ENCODING_HEXTILE:
-            vs->features |= VNC_FEATURE_HEXTILE_MASK;
+            vnc_set_feature(vs, VNC_FEATURE_HEXTILE);
             vs->vnc_encoding = enc;
             break;
         case VNC_ENCODING_TIGHT:
-            vs->features |= VNC_FEATURE_TIGHT_MASK;
+            vnc_set_feature(vs, VNC_FEATURE_TIGHT);
             vs->vnc_encoding = enc;
             break;
 #ifdef CONFIG_PNG
         case VNC_ENCODING_TIGHT_PNG:
-            vs->features |= VNC_FEATURE_TIGHT_PNG_MASK;
+            vnc_set_feature(vs, VNC_FEATURE_TIGHT_PNG);
             vs->vnc_encoding = enc;
             break;
 #endif
@@ -2163,57 +2163,57 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
              * So prioritize ZRLE, even if the client hints that it prefers
              * ZLIB.
              */
-            if ((vs->features & VNC_FEATURE_ZRLE_MASK) == 0) {
-                vs->features |= VNC_FEATURE_ZLIB_MASK;
+            if (!vnc_has_feature(vs, VNC_FEATURE_ZRLE)) {
+                vnc_set_feature(vs, VNC_FEATURE_ZLIB);
                 vs->vnc_encoding = enc;
             }
             break;
         case VNC_ENCODING_ZRLE:
-            vs->features |= VNC_FEATURE_ZRLE_MASK;
+            vnc_set_feature(vs, VNC_FEATURE_ZRLE);
             vs->vnc_encoding = enc;
             break;
         case VNC_ENCODING_ZYWRLE:
-            vs->features |= VNC_FEATURE_ZYWRLE_MASK;
+            vnc_set_feature(vs, VNC_FEATURE_ZYWRLE);
             vs->vnc_encoding = enc;
             break;
         case VNC_ENCODING_DESKTOPRESIZE:
-            vs->features |= VNC_FEATURE_RESIZE_MASK;
+            vnc_set_feature(vs, VNC_FEATURE_RESIZE);
             break;
         case VNC_ENCODING_DESKTOP_RESIZE_EXT:
-            vs->features |= VNC_FEATURE_RESIZE_EXT_MASK;
+            vnc_set_feature(vs, VNC_FEATURE_RESIZE_EXT);
             break;
         case VNC_ENCODING_POINTER_TYPE_CHANGE:
-            vs->features |= VNC_FEATURE_POINTER_TYPE_CHANGE_MASK;
+            vnc_set_feature(vs, VNC_FEATURE_POINTER_TYPE_CHANGE);
             break;
         case VNC_ENCODING_RICH_CURSOR:
-            vs->features |= VNC_FEATURE_RICH_CURSOR_MASK;
+            vnc_set_feature(vs, VNC_FEATURE_RICH_CURSOR);
             break;
         case VNC_ENCODING_ALPHA_CURSOR:
-            vs->features |= VNC_FEATURE_ALPHA_CURSOR_MASK;
+            vnc_set_feature(vs, VNC_FEATURE_ALPHA_CURSOR);
             break;
         case VNC_ENCODING_EXT_KEY_EVENT:
             send_ext_key_event_ack(vs);
             break;
         case VNC_ENCODING_AUDIO:
             if (vs->vd->audio_state) {
-                vs->features |= VNC_FEATURE_AUDIO_MASK;
+                vnc_set_feature(vs, VNC_FEATURE_AUDIO);
                 send_ext_audio_ack(vs);
             }
             break;
         case VNC_ENCODING_WMVi:
-            vs->features |= VNC_FEATURE_WMVI_MASK;
+            vnc_set_feature(vs, VNC_FEATURE_WMVI);
             break;
         case VNC_ENCODING_LED_STATE:
-            vs->features |= VNC_FEATURE_LED_STATE_MASK;
+            vnc_set_feature(vs, VNC_FEATURE_LED_STATE);
             break;
         case VNC_ENCODING_XVP:
             if (vs->vd->power_control) {
-                vs->features |= VNC_FEATURE_XVP_MASK;
+                vnc_set_feature(vs, VNC_FEATURE_XVP);
                 send_xvp_message(vs, VNC_XVP_CODE_INIT);
             }
             break;
         case VNC_ENCODING_CLIPBOARD_EXT:
-            vs->features |= VNC_FEATURE_CLIPBOARD_EXT_MASK;
+            vnc_set_feature(vs, VNC_FEATURE_CLIPBOARD_EXT);
             vnc_server_cut_text_caps(vs);
             break;
         case VNC_ENCODING_COMPRESSLEVEL0 ... VNC_ENCODING_COMPRESSLEVEL0 + 9:
diff --git a/ui/vnc.h b/ui/vnc.h
index 96d19dce19..4521dc88f7 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -467,23 +467,6 @@ enum VncFeatures {
     VNC_FEATURE_AUDIO,
 };
 
-#define VNC_FEATURE_RESIZE_MASK              (1 << VNC_FEATURE_RESIZE)
-#define VNC_FEATURE_RESIZE_EXT_MASK          (1 << VNC_FEATURE_RESIZE_EXT)
-#define VNC_FEATURE_HEXTILE_MASK             (1 << VNC_FEATURE_HEXTILE)
-#define VNC_FEATURE_POINTER_TYPE_CHANGE_MASK (1 << VNC_FEATURE_POINTER_TYPE_CHANGE)
-#define VNC_FEATURE_WMVI_MASK                (1 << VNC_FEATURE_WMVI)
-#define VNC_FEATURE_TIGHT_MASK               (1 << VNC_FEATURE_TIGHT)
-#define VNC_FEATURE_ZLIB_MASK                (1 << VNC_FEATURE_ZLIB)
-#define VNC_FEATURE_RICH_CURSOR_MASK         (1 << VNC_FEATURE_RICH_CURSOR)
-#define VNC_FEATURE_ALPHA_CURSOR_MASK        (1 << VNC_FEATURE_ALPHA_CURSOR)
-#define VNC_FEATURE_TIGHT_PNG_MASK           (1 << VNC_FEATURE_TIGHT_PNG)
-#define VNC_FEATURE_ZRLE_MASK                (1 << VNC_FEATURE_ZRLE)
-#define VNC_FEATURE_ZYWRLE_MASK              (1 << VNC_FEATURE_ZYWRLE)
-#define VNC_FEATURE_LED_STATE_MASK           (1 << VNC_FEATURE_LED_STATE)
-#define VNC_FEATURE_XVP_MASK                 (1 << VNC_FEATURE_XVP)
-#define VNC_FEATURE_CLIPBOARD_EXT_MASK       (1 <<  VNC_FEATURE_CLIPBOARD_EXT)
-#define VNC_FEATURE_AUDIO_MASK               (1 <<  VNC_FEATURE_AUDIO)
-
 
 /* Client -> Server message IDs */
 #define VNC_MSG_CLIENT_SET_PIXEL_FORMAT           0
@@ -599,6 +582,11 @@ static inline uint32_t vnc_has_feature(VncState *vs, int feature) {
     return (vs->features & (1 << feature));
 }
 
+static inline void vnc_set_feature(VncState *vs, enum VncFeatures feature)
+{
+    vs->features |= (1 << feature);
+}
+
 /* Framebuffer */
 void vnc_framebuffer_update(VncState *vs, int x, int y, int w, int h,
                             int32_t encoding);
-- 
2.43.0


