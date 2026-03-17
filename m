Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63513FED9F0
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Y6S-0003Y8-UE; Tue, 17 Mar 2026 13:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y6O-000386-98
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:21:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y6M-0005gm-Ku
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773768065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y2PTYZWW6vbjY5W/qWBPJmkO1oYa5RgHvvZ9XEiRBXM=;
 b=XSFtwpgux2OBTvKSXsh+rmHcqo8sn+/USRXcC3CH7hsFx9A+ps3PO9eLG4I9FvJfroKbkJ
 plcLoe07mTJyOoZKj/kf1pJywXWEfs00w+FEAqK46Uu3EeG//0QflFeDWIiFrvYi2e1jwm
 h0VTVihQo56zPWiz8i/jL2IAVz+SBiI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-2CIyk4whO2KuXuKp7B1djg-1; Tue,
 17 Mar 2026 13:21:02 -0400
X-MC-Unique: 2CIyk4whO2KuXuKp7B1djg-1
X-Mimecast-MFC-AGG-ID: 2CIyk4whO2KuXuKp7B1djg_1773768061
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB24D19560B9; Tue, 17 Mar 2026 17:21:00 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5366E18001FE; Tue, 17 Mar 2026 17:20:58 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 15/16] audio: Add functions to initialize buffers
Date: Tue, 17 Mar 2026 21:19:15 +0400
Message-ID: <20260317171916.438575-16-marcandre.lureau@redhat.com>
In-Reply-To: <20260317171916.438575-1-marcandre.lureau@redhat.com>
References: <20260317171916.438575-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

These functions can be used to re-initialize buffers when hardware
parameters change due to device hotplug, for example.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260304-coreaudio-v8-5-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
---
 audio/audio_int.h       |  2 ++
 audio/audio-mixeng-be.c | 24 ++++++++++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 06f79ade6b0..290cf373b49 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -141,9 +141,11 @@ static inline void *advance(void *p, size_t incr)
 int wav_start_capture(AudioBackend *state, CaptureState *s, const char *path,
                       int freq, int bits, int nchannels);
 
+void audio_generic_initialize_buffer_in(HWVoiceIn *hw);
 void audio_generic_run_buffer_in(HWVoiceIn *hw);
 void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
 void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size);
+void audio_generic_initialize_buffer_out(HWVoiceOut *hw);
 void audio_generic_run_buffer_out(HWVoiceOut *hw);
 size_t audio_generic_buffer_get_free(HWVoiceOut *hw);
 void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size);
diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index 5878b23e04e..f7d73d85608 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -1187,14 +1187,20 @@ void audio_run(AudioMixengBackend *s, const char *msg)
     }
 }
 
+void audio_generic_initialize_buffer_in(HWVoiceIn *hw)
+{
+    g_free(hw->buf_emul);
+    hw->size_emul = hw->samples * hw->info.bytes_per_frame;
+    hw->buf_emul = g_malloc(hw->size_emul);
+    hw->pos_emul = hw->pending_emul = 0;
+}
+
 void audio_generic_run_buffer_in(HWVoiceIn *hw)
 {
     AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(hw->s);
 
     if (unlikely(!hw->buf_emul)) {
-        hw->size_emul = hw->samples * hw->info.bytes_per_frame;
-        hw->buf_emul = g_malloc(hw->size_emul);
-        hw->pos_emul = hw->pending_emul = 0;
+        audio_generic_initialize_buffer_in(hw);
     }
 
     while (hw->pending_emul < hw->size_emul) {
@@ -1227,6 +1233,14 @@ void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
     hw->pending_emul -= size;
 }
 
+void audio_generic_initialize_buffer_out(HWVoiceOut *hw)
+{
+    g_free(hw->buf_emul);
+    hw->size_emul = hw->samples * hw->info.bytes_per_frame;
+    hw->buf_emul = g_malloc(hw->size_emul);
+    hw->pos_emul = hw->pending_emul = 0;
+}
+
 size_t audio_generic_buffer_get_free(HWVoiceOut *hw)
 {
     if (hw->buf_emul) {
@@ -1260,9 +1274,7 @@ void audio_generic_run_buffer_out(HWVoiceOut *hw)
 void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)
 {
     if (unlikely(!hw->buf_emul)) {
-        hw->size_emul = hw->samples * hw->info.bytes_per_frame;
-        hw->buf_emul = g_malloc(hw->size_emul);
-        hw->pos_emul = hw->pending_emul = 0;
+        audio_generic_initialize_buffer_out(hw);
     }
 
     *size = MIN(hw->size_emul - hw->pending_emul,
-- 
2.53.0


