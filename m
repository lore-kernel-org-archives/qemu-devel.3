Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F846E98E11
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuSa4-00028m-64; Mon, 23 Feb 2026 04:50:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSZd-0001jg-3P
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:49:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSZb-000779-Hf
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771840190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7y/EYQ+Y5vsg2qiNu5jBHHa59cXGfKBW0/UG4PQ/VuM=;
 b=IsDihYS/ZsQZ6OOEiwtjuexf6ATarxi1WI7jnOXqQwyGI549ZmDPr6kJIK0pfnpDx2u1CZ
 gYJHZ3a2ogh6i+9OsgACrSgfkboDF5yqZ3iwjbGaKijKy1Nhkmk7nbZPjmOA/FYbESrNX1
 +c9hjzpHqbfRUUW95mKqWcyZj0w7SoQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-klK-wGS7NQuf4_nXeOB4JA-1; Mon,
 23 Feb 2026 04:49:48 -0500
X-MC-Unique: klK-wGS7NQuf4_nXeOB4JA-1
X-Mimecast-MFC-AGG-ID: klK-wGS7NQuf4_nXeOB4JA_1771840187
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D2A81800378; Mon, 23 Feb 2026 09:49:47 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 647A21955D71; Mon, 23 Feb 2026 09:49:46 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v2 58/85] audio: constify some add_capture() arguments
Date: Mon, 23 Feb 2026 10:46:16 +0100
Message-ID: <20260223094649.2005118-59-marcandre.lureau@redhat.com>
In-Reply-To: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
References: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
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


