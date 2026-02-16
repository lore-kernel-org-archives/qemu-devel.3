Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67770E7BD9D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfR-00078N-PL; Mon, 16 Feb 2026 06:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwcc-0006rw-Ot
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwcY-0008FY-Fy
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YN4DJG0Py/cRgpapumSpUdL2yVxH+gWGCGJxHSN+2zE=;
 b=DwePrjy01C/PcMXtUg2VqyWV8sGTQDoiihw9zElUNYc1jCW7F1B0ZVDB47rIdQWJnEsd8r
 xnxiR/dhFxkvaUYBStkTKQCPR+IiqBD4I10rvxEWYZyl4GyrtCetvy3jPmddVBfbRoJsbj
 3B6/zZ0385dY6FR9gmrSd+inPPpcZqc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-4Mdc60m7N4qGHae_LRbnYA-1; Mon,
 16 Feb 2026 06:18:24 -0500
X-MC-Unique: 4Mdc60m7N4qGHae_LRbnYA-1
X-Mimecast-MFC-AGG-ID: 4Mdc60m7N4qGHae_LRbnYA_1771240702
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14DB918003F5; Mon, 16 Feb 2026 11:18:22 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CACD719560AD; Mon, 16 Feb 2026 11:18:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:47 +0100
Subject: [PATCH 58/85] audio: constify some add_capture() arguments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-58-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3590;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2WNGqq2fzWN/830O7ChQYzY+xt6tqSyBcFbWMnGS2jY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxR7PS+Liz5OHdTZgYxmGunCMhPI1sIv7R83
 2gdpHSlZyWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UQAKCRDa6OEJdZac
 5ZArEACI8UXpWfYt6lXaTLbKyhcdsQuvBXmmFu01HPZByLx2siMY2TlqLfT9E+TReN+4UcmrUGp
 k5v9RZqDTOAN3HTf05sN8RD5KuEjxFL47DU+lVLc725MD3Q18niFkz3pu5aQlZ/glEobjGuKYdl
 Cpij8jPqjfhY/g4mJaXcSerdEjAfJoop/jEtjicYw69SuWQuN3w1iDL8DbFpjzWwz2+CUrOyUCe
 AKxB4CYC6WDT1ZI3uoVfmf3zY/cVekQYhwbxugghgpbquUEFjlMTFfTYmcwwAhLsFuP7zD2Jcsp
 Avi4wOSyizumftwoYEpWqtqyi5F3grTAAgAIOtfs0A9ea8g+bB9H0QJj1lVlFN8c54lhZtcbYu1
 eB+usxnAeMUL0TRWaIyCVF/yu4WBsW3cL4tpSqNhJcwTmVAOpr7kYv7e609DVa6oEBf++I9VPnE
 9OaMYdPSqLMFU4pRhuyoXhhRNhWmwxTU52sHo/mZ9r5H9Ss91yaf0jm2jvUZrqBKKZDLI8yG1kX
 BPZ57e027Fc8wxeYqopZMnAYr+WcAdUipfXgAVSHMSrliOlL4QfsA0WDJuBTeeQXXNhWpOa2IEs
 hrGCYEil/B7jjCV7tQV7y61ODdazEjuyY6j/CApH1fHA6tTscMVyYjeASkIBpDiua2uAO7EEpNP
 XmY2cNhK9RL/GAQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qemu/audio-capture.h |  4 ++--
 include/qemu/audio.h         |  4 ++--
 audio/audio-be.c             |  4 ++--
 audio/audio-mixeng-be.c      | 10 +++++-----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/qemu/audio-capture.h b/include/qemu/audio-capture.h
index d7998232243..f1319c90020 100644
--- a/include/qemu/audio-capture.h
+++ b/include/qemu/audio-capture.h
@@ -21,8 +21,8 @@ typedef struct CaptureState {
 
 CaptureVoiceOut *audio_be_add_capture(
     AudioBackend *be,
-    struct audsettings *as,
-    struct audio_capture_ops *ops,
+    const struct audsettings *as,
+    const struct audio_capture_ops *ops,
     void *opaque);
 
 void audio_be_del_capture(
diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index dfe247ab8c4..b6b6ee9b560 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -96,8 +96,8 @@ typedef struct AudioBackendClass {
     size_t (*read)(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size);
     int (*get_buffer_size_out)(AudioBackend *be, SWVoiceOut *sw);
     CaptureVoiceOut *(*add_capture)(AudioBackend *be,
-                                    struct audsettings *as,
-                                    struct audio_capture_ops *ops,
+                                    const struct audsettings *as,
+                                    const struct audio_capture_ops *ops,
                                     void *cb_opaque);
     void (*del_capture)(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque);
 
diff --git a/audio/audio-be.c b/audio/audio-be.c
index 8094a3196c7..ee065fa4968 100644
--- a/audio/audio-be.c
+++ b/audio/audio-be.c
@@ -182,8 +182,8 @@ void audio_be_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
 
 CaptureVoiceOut *audio_be_add_capture(
     AudioBackend *be,
-    struct audsettings *as,
-    struct audio_capture_ops *ops,
+    const struct audsettings *as,
+    const struct audio_capture_ops *ops,
     void *cb_opaque)
 {
     AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index 17301ec80e7..d02cfe3c509 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -314,7 +314,7 @@ void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len)
  * Capture
  */
 static CaptureVoiceOut *audio_pcm_capture_find_specific(AudioMixengBackend *s,
-                                                        struct audsettings *as)
+                                                        const struct audsettings *as)
 {
     CaptureVoiceOut *cap;
 
@@ -1585,8 +1585,8 @@ static const char *audio_mixeng_backend_get_id(AudioBackend *be)
 
 static CaptureVoiceOut *audio_mixeng_backend_add_capture(
     AudioBackend *be,
-    struct audsettings *as,
-    struct audio_capture_ops *ops,
+    const struct audsettings *as,
+    const struct audio_capture_ops *ops,
     void *cb_opaque);
 
 static void audio_mixeng_backend_del_capture(
@@ -1710,8 +1710,8 @@ static const VMStateDescription vmstate_audio = {
 
 static CaptureVoiceOut *audio_mixeng_backend_add_capture(
     AudioBackend *be,
-    struct audsettings *as,
-    struct audio_capture_ops *ops,
+    const struct audsettings *as,
+    const struct audio_capture_ops *ops,
     void *cb_opaque)
 {
     AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(be);

-- 
2.53.0


