Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80CCE7BD9B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrweQ-0004LD-LP; Mon, 16 Feb 2026 06:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbb-0005ki-61
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbZ-0007zb-Et
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=14KtznUlIjxeUhZQ3HJFjn608eAk9OXV5ZTi/HQfe2w=;
 b=BAj+uHrClYAJ+ZmOfuCWgYg2SMrWNHDiHXw1KiQ6o8/Usapkjn392xNwN1vdMKgFoEsxLK
 4+1Xtu+5s1yuqMKAIwgW6nGAmn7eyJltWPbUCvUzndqBIsUm/DQkPVnwm9LFPBqPnyQ1l3
 3D2+YBMOYzdvRnZKJA+2QjhLZVLXVcE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-9uq7PT2NMZmkYNLkkLBUlQ-1; Mon,
 16 Feb 2026 06:17:26 -0500
X-MC-Unique: 9uq7PT2NMZmkYNLkkLBUlQ-1
X-Mimecast-MFC-AGG-ID: 9uq7PT2NMZmkYNLkkLBUlQ_1771240644
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8791F1956058; Mon, 16 Feb 2026 11:17:24 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F3671800464; Mon, 16 Feb 2026 11:17:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:27 +0100
Subject: [PATCH 38/85] audio-be: add common pre-conditions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-38-e676662e4514@redhat.com>
References: <20260216-audio-v1-0-e676662e4514@redhat.com>
In-Reply-To: <20260216-audio-v1-0-e676662e4514@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6032;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=zXuDMfkjGAD2e+OunENZs2O7GncbAFbykUUyFo44jys=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxQfwdZmV+cpyVDheiWV5K7XQjwx6FCLGFQC
 ngi9xRbxFeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UAAKCRDa6OEJdZac
 5XQMD/9v89KN9GZbrcrzh/XCa9j3+bB/YHhyc1rytSaKDjw/9NGnAfu2vKs1T9J4AeFR3k+CbK7
 ZnvyKqL/1i0VxFQJtcqU22rw7hb77VVmLG1KLRghlneMYUohOsnVgQ7iSic5WbHViL84g+/GCc7
 QkhwiAadUNhTmWCqjRJG/zCKlDWcDop1wxuDPoODEjyi8OAQsIL/7kszvpXahKHrPVJ0eyo41Sv
 2EHUSC6nEyjsBAudwJB8OQ26x4OTaLl+suBuA2xVhQBVNrHfd8Tl1AOjHGCmXZM/i0qWwudR9Bv
 b8wmkpVOO874YP0rZDJlBPAvcMf9XJLtOucDTiVdI7N+ySroCv3eLfS98dDb88Kvn/a5IUeQWi6
 Hh/U9Y/Ts3XyekcJVnUJwVfpSbeDI4UG2DkCIGhWFIF7D0ieN8DYFB/HzVwRqbuVSlhR0JSLRtc
 AHVAow7SR0j0VILmj5lXCYDC8805xpRfl8uJsr0UfiPvvMr7m05k+UO3qzg5I35cSOaC8zIf9Yn
 76l1QJ4a/fbKg1PNzNYUGJBpMrlx/+Q2V/q2do/OF0tSkG7x6ppADgb9ZCePJgUugoua/KedDbw
 jdX6eNSNcdQmOZ66omCUyaZJnGRDxQouXQT4Sy5CuYjCnpRO/ZQsCkEYyZcmEpB1E7mCTyNd9AO
 gHRmv1iBh/OhCcg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

assert() on valid values, and handle acceptable NULL arguments
gracefully.

Note audio_driver_write() and audio_driver_read() used to return
size (with a "XXX: Consider options") when sw was NULL. Imho, it is more
correct to not pretend to have read/written anything by default in the
AudioBackend base abstract class.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/audio-be.c         | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/audio/test-audio.c |  8 +++----
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


