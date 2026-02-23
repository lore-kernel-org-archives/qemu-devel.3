Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADE9EA4FC2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWLZ-0006ry-VT; Mon, 23 Feb 2026 08:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWKS-0005oj-CV
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:50:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWKN-0007UX-7T
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:50:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771854620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7y/EYQ+Y5vsg2qiNu5jBHHa59cXGfKBW0/UG4PQ/VuM=;
 b=VPuyVgfZSJxcgHqsjrRD+L4a8lAcVo9bdIiAkhy/Ht6/QNmFPafRDMZ04iC59gWRcfSfau
 E6B4Xqsk6DaC+4+UVucif6tfzO6a6NjabTNJ6uXuJTA6eIf6nvwKhnBDkN5HDen/Hbajhl
 kx4u/g35MMWcL2lWJqrHI3J3gMyu9Ig=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-VHuWnu1AMJSNu-zYfoqsJQ-1; Mon,
 23 Feb 2026 08:50:16 -0500
X-MC-Unique: VHuWnu1AMJSNu-zYfoqsJQ-1
X-Mimecast-MFC-AGG-ID: VHuWnu1AMJSNu-zYfoqsJQ_1771854615
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7722F19560AD; Mon, 23 Feb 2026 13:50:15 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B50021800677; Mon, 23 Feb 2026 13:50:14 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v3 58/85] audio: constify some add_capture() arguments
Date: Mon, 23 Feb 2026 14:46:59 +0100
Message-ID: <20260223134731.2377432-59-marcandre.lureau@redhat.com>
In-Reply-To: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


