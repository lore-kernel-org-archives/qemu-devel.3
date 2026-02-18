Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E4CE9A03E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdV4-00052h-GM; Wed, 18 Feb 2026 04:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdV0-0004XX-5i
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:05:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdUx-0000XT-I1
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gk8z/yPZc780qIB6Fxp7tinO/ilEaeihoI2LilPTyNQ=;
 b=c5ER92gzf/PclvWOY3atREW3UtnNryWO2dKFJAQ3lq7j1kfyDqP6h8UICgQGfePEb3tNA0
 HWLmr9Ewvp7jb6xd4mDyAz3VsPOluabh+ijbYNE592ZQ+MDqPJRLyv3r8bFZGY73C3hOrU
 1GeWpjDIHHNqpGTQRoHaN4qTXn5XirM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-kzZlMSl0OjWRac8OEs0Gng-1; Wed,
 18 Feb 2026 04:05:29 -0500
X-MC-Unique: kzZlMSl0OjWRac8OEs0Gng-1
X-Mimecast-MFC-AGG-ID: kzZlMSl0OjWRac8OEs0Gng_1771405528
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC64E1955BC4; Wed, 18 Feb 2026 09:05:28 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED9AD19560AD; Wed, 18 Feb 2026 09:05:27 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 38/85] audio-be: add common pre-conditions
Date: Wed, 18 Feb 2026 10:02:38 +0100
Message-ID: <20260218090330.1476169-39-marcandre.lureau@redhat.com>
In-Reply-To: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

assert() on valid values, and handle acceptable NULL arguments
gracefully.

Note audio_driver_write() and audio_driver_read() used to return
size (with a "XXX: Consider options") when sw was NULL. Imho, it is more
correct to not pretend to have read/written anything by default in the
AudioBackend base abstract class.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio-be.c         | 61 ++++++++++++++++++++++++++++++++++++++++
 tests/audio/test-audio.c |  8 ++----
 2 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/audio/audio-be.c b/audio/audio-be.c
index 4d3b1e2bafd..719dd8cac12 100644
--- a/audio/audio-be.c
+++ b/audio/audio-be.c
@@ -29,6 +29,10 @@ SWVoiceIn *audio_be_open_in(
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
+    assert(name != NULL);
+    assert(callback_fn != NULL);
+    assert(as != NULL);
+
     return klass->open_in(be, sw, name, callback_opaque, callback_fn, as);
 }
 
@@ -42,6 +46,10 @@ SWVoiceOut *audio_be_open_out(
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
+    assert(name != NULL);
+    assert(callback_fn != NULL);
+    assert(as != NULL);
+
     return klass->open_out(be, sw, name, callback_opaque, callback_fn, as);
 }
 
@@ -49,6 +57,10 @@ void audio_be_close_out(AudioBackend *be, SWVoiceOut *sw)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
+    if (!sw) {
+        return;
+    }
+
     return klass->close_out(be, sw);
 }
 
@@ -56,6 +68,10 @@ void audio_be_close_in(AudioBackend *be, SWVoiceIn *sw)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
+    if (!sw) {
+        return;
+    }
+
     return klass->close_in(be, sw);
 }
 
@@ -63,6 +79,10 @@ bool audio_be_is_active_out(AudioBackend *be, SWVoiceOut *sw)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
+    if (!sw) {
+        return false;
+    }
+
     return klass->is_active_out(be, sw);
 }
 
@@ -70,6 +90,10 @@ bool audio_be_is_active_in(AudioBackend *be, SWVoiceIn *sw)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
+    if (!sw) {
+        return false;
+    }
+
     return klass->is_active_in(be, sw);
 }
 
@@ -77,6 +101,10 @@ size_t audio_be_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
+    if (!sw) {
+        return 0;
+    }
+
     return klass->write(be, sw, buf, size);
 }
 
@@ -84,6 +112,10 @@ size_t audio_be_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
+    if (!sw) {
+        return 0;
+    }
+
     return klass->read(be, sw, buf, size);
 }
 
@@ -91,6 +123,10 @@ int audio_be_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
+    if (!sw) {
+        return 0;
+    }
+
     return klass->get_buffer_size_out(be, sw);
 }
 
@@ -98,6 +134,10 @@ void audio_be_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
+    if (!sw) {
+        return;
+    }
+
     return klass->set_active_out(be, sw, on);
 }
 
@@ -105,6 +145,10 @@ void audio_be_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
+    if (!sw) {
+        return;
+    }
+
     return klass->set_active_in(be, sw, on);
 }
 
@@ -112,6 +156,10 @@ void audio_be_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
+    if (!sw) {
+        return;
+    }
+
     klass->set_volume_out(be, sw, vol);
 }
 
@@ -119,6 +167,10 @@ void audio_be_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
+    if (!sw) {
+        return;
+    }
+
     klass->set_volume_in(be, sw, vol);
 }
 
@@ -130,6 +182,9 @@ CaptureVoiceOut *audio_be_add_capture(
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
+    assert(as != NULL);
+    assert(ops != NULL);
+
     return klass->add_capture(be, as, ops, cb_opaque);
 }
 
@@ -137,6 +192,10 @@ void audio_be_del_capture(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaqu
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
+    if (!cap) {
+        return;
+    }
+
     klass->del_capture(be, cap, cb_opaque);
 }
 
@@ -155,6 +214,8 @@ bool audio_be_set_dbus_server(AudioBackend *be,
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
+    assert(server != NULL);
+
     if (!audio_be_can_set_dbus_server(be)) {
         error_setg(errp, "Audiodev '%s' is not compatible with DBus",
                    audio_be_get_id(be));
diff --git a/tests/audio/test-audio.c b/tests/audio/test-audio.c
index 1827c084ac8..90d96ae0575 100644
--- a/tests/audio/test-audio.c
+++ b/tests/audio/test-audio.c
@@ -493,11 +493,9 @@ static void test_audio_null_handling(void)
     /* audio_be_get_buffer_size_out(NULL) should return 0 */
     g_assert_cmpint(audio_be_get_buffer_size_out(be, NULL), ==, 0);
 
-    /* audio_be_write/read(NULL, ...) should return size (no-op) */
-    g_assert_cmpuint(audio_be_write(be, NULL, buffer, sizeof(buffer)), ==,
-                     sizeof(buffer));
-    g_assert_cmpuint(audio_be_read(be, NULL, buffer, sizeof(buffer)), ==,
-                     sizeof(buffer));
+    /* audio_be_write/read(NULL, ...) should return 0 */
+    g_assert_cmpuint(audio_be_write(be, NULL, buffer, sizeof(buffer)), ==, 0);
+    g_assert_cmpuint(audio_be_read(be, NULL, buffer, sizeof(buffer)), ==, 0);
 
     /* These should not crash */
     audio_be_set_active_out(be, NULL, true);
-- 
2.53.0


