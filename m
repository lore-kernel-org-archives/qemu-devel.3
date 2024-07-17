Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30580C3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 17:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU8G3-0001NV-RM; Wed, 17 Jul 2024 13:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sU8G1-0001N0-W4
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 13:16:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sU8G0-0003Df-F3
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 13:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721236559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lNqo3c2saj2lEl7hILnKmOV1thF0dC3z927c8z7qK3I=;
 b=PHRmdIsdv6CqLYd2aN/M8cBfGfZawvanU1awtlZYwErIS5n7VOIpPL4xzl7+f1SmDq2S+w
 cDbzXITDdSM6apr0i3PMDcG0f8zc2S2Vjya7kLPE9c06ZESZHSe7su/e048mBrjgkH83LD
 AZPBd0Om/9d5fni5tirz0mLN5xR542I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-ejRv5BUBNVi3hI6eIO9Iog-1; Wed,
 17 Jul 2024 13:15:54 -0400
X-MC-Unique: ejRv5BUBNVi3hI6eIO9Iog-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99AD71955D47; Wed, 17 Jul 2024 17:15:52 +0000 (UTC)
Received: from localhost (unknown [10.39.208.20])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E0A2B19560B2; Wed, 17 Jul 2024 17:15:50 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 1/4] ui: add more tracing for dbus
Date: Wed, 17 Jul 2024 21:15:37 +0400
Message-ID: <20240717171541.201525-2-marcandre.lureau@redhat.com>
In-Reply-To: <20240717171541.201525-1-marcandre.lureau@redhat.com>
References: <20240717171541.201525-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/dbusaudio.c   | 2 +-
 ui/dbus-clipboard.c | 4 ++++
 audio/trace-events  | 2 +-
 ui/trace-events     | 2 ++
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index 60fcf643ec..095e739382 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -105,7 +105,7 @@ static size_t dbus_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size)
     assert(buf == vo->buf + vo->buf_pos && vo->buf_pos + size <= vo->buf_size);
     vo->buf_pos += size;
 
-    trace_dbus_audio_put_buffer_out(size);
+    trace_dbus_audio_put_buffer_out(vo->buf_pos, vo->buf_size);
 
     if (vo->buf_pos < vo->buf_size) {
         return size;
diff --git a/ui/dbus-clipboard.c b/ui/dbus-clipboard.c
index fe7fcdecb6..fbb043abca 100644
--- a/ui/dbus-clipboard.c
+++ b/ui/dbus-clipboard.c
@@ -141,6 +141,8 @@ dbus_clipboard_qemu_request(QemuClipboardInfo *info,
     const char *mimes[] = { MIME_TEXT_PLAIN_UTF8, NULL };
     size_t n;
 
+    trace_dbus_clipboard_qemu_request(type);
+
     if (type != QEMU_CLIPBOARD_TYPE_TEXT) {
         /* unsupported atm */
         return;
@@ -305,6 +307,8 @@ dbus_clipboard_grab(
         return DBUS_METHOD_INVOCATION_HANDLED;
     }
 
+    trace_dbus_clipboard_grab(arg_selection, arg_serial);
+
     if (s >= QEMU_CLIPBOARD_SELECTION__COUNT) {
         g_dbus_method_invocation_return_error(
             invocation,
diff --git a/audio/trace-events b/audio/trace-events
index ab04f020ce..7e3f1593c8 100644
--- a/audio/trace-events
+++ b/audio/trace-events
@@ -15,7 +15,7 @@ oss_version(int version) "OSS version = 0x%x"
 
 # dbusaudio.c
 dbus_audio_register(const char *s, const char *dir) "sender = %s, dir = %s"
-dbus_audio_put_buffer_out(size_t len) "len = %zu"
+dbus_audio_put_buffer_out(size_t pos, size_t size) "buf_pos = %zu, buf_size = %zu"
 dbus_audio_read(size_t len) "len = %zu"
 
 # pwaudio.c
diff --git a/ui/trace-events b/ui/trace-events
index 69ff22955d..07eb494246 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -157,7 +157,9 @@ dbus_mouse_rel_motion(int dx, int dy) "dx=%d, dy=%d"
 dbus_touch_send_event(unsigned int kind, uint32_t num_slot, uint32_t x, uint32_t y) "kind=%u, num_slot=%u, x=%d, y=%d"
 dbus_update(int x, int y, int w, int h) "x=%d, y=%d, w=%d, h=%d"
 dbus_update_gl(int x, int y, int w, int h) "x=%d, y=%d, w=%d, h=%d"
+dbus_clipboard_grab(int selection, unsigned int serial) "selection=%d serial=%u"
 dbus_clipboard_grab_failed(void) ""
+dbus_clipboard_qemu_request(int type) "type=%d"
 dbus_clipboard_register(const char *bus_name) "peer %s"
 dbus_clipboard_unregister(const char *bus_name) "peer %s"
 dbus_scanout_texture(uint32_t tex_id, bool backing_y_0_top, uint32_t backing_width, uint32_t backing_height, uint32_t x, uint32_t y, uint32_t w, uint32_t h) "tex_id:%u y0top:%d back:%ux%u %u+%u-%ux%u"
-- 
2.45.2.827.g557ae147e6


