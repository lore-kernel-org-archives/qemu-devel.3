Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D49FED9F1
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Y6Q-000385-AV; Tue, 17 Mar 2026 13:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y6L-0002tO-PI
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:21:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y6I-0005gG-F0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773768059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PfyPiJZx/YlqBt4/ld65PGZ0fAYl2eWxoZXvWxzVJ5Q=;
 b=LKnSVHudA+u0MCg8oDY0IFNG7+xAazt0HCfjB4K5hDpxNYGgiMq89d/5U1g7fV/05Nbllu
 Dnzxn3LkaP7gID4bc5NkAoCgCLffnQa5qDnsqmC7/5Zv0KzO/R5UAnRzXiwFcFsvOle7qS
 EKrurPFJhlfZ/12Gx7j7RSQo9uGWTvM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-pmGc-Y9ENjmsKi1sVzrhDQ-1; Tue,
 17 Mar 2026 13:20:56 -0400
X-MC-Unique: pmGc-Y9ENjmsKi1sVzrhDQ-1
X-Mimecast-MFC-AGG-ID: pmGc-Y9ENjmsKi1sVzrhDQ_1773768054
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6BE1180061F; Tue, 17 Mar 2026 17:20:54 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2487D19560AB; Tue, 17 Mar 2026 17:20:52 +0000 (UTC)
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
Subject: [PULL 14/16] coreaudio: Commit the result of init in the end
Date: Tue, 17 Mar 2026 21:19:14 +0400
Message-ID: <20260317171916.438575-15-marcandre.lureau@redhat.com>
In-Reply-To: <20260317171916.438575-1-marcandre.lureau@redhat.com>
References: <20260317171916.438575-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

init_out_device may only commit some part of the result and leave the
state inconsistent when it encounters a fatal error or the device gets
unplugged during the operation, which is expressed by
kAudioHardwareBadObjectError or kAudioHardwareBadDeviceError. Commit the
result in the end of the function so that it commits the result iff it
sees no fatal error and the device remains plugged.

With this change, handle_voice_change can rely on core->outputDeviceID
to know whether the output device is initialized after calling
init_out_device.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260304-coreaudio-v8-4-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
---
 audio/coreaudio.m | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index 736227eb2b7..23c3d1f80ac 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -357,8 +357,11 @@ static OSStatus out_device_ioproc(
 
 static OSStatus init_out_device(CoreaudioVoiceOut *core)
 {
+    AudioDeviceID device_id;
+    AudioDeviceIOProcID ioprocid;
     AudioValueRange value_range;
     OSStatus status;
+    UInt32 device_frame_size;
 
     AudioStreamBasicDescription stream_basic_description = {
         .mBitsPerChannel = audio_format_bits(core->hw.info.af),
@@ -371,20 +374,20 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
         .mSampleRate = core->hw.info.freq
     };
 
-    status = coreaudio_get_voice_out(&core->device_id);
+    status = coreaudio_get_voice_out(&device_id);
     if (status != kAudioHardwareNoError) {
         coreaudio_playback_logerr(status,
                                   "Could not get default output device");
         return status;
     }
-    if (core->device_id == kAudioDeviceUnknown) {
+    if (device_id == kAudioDeviceUnknown) {
         error_report("coreaudio: Could not initialize playback: "
                      "Unknown audio device");
         return status;
     }
 
     /* get minimum and maximum buffer frame sizes */
-    status = coreaudio_get_out_framesizerange(core->device_id, &value_range);
+    status = coreaudio_get_out_framesizerange(device_id, &value_range);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
     }
@@ -395,33 +398,31 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
     }
 
     if (value_range.mMinimum > core->frame_size_setting) {
-        core->device_frame_size = value_range.mMinimum;
+        device_frame_size = value_range.mMinimum;
         warn_report("coreaudio: Upsizing buffer frames to %f",
                     value_range.mMinimum);
     } else if (value_range.mMaximum < core->frame_size_setting) {
-        core->device_frame_size = value_range.mMaximum;
+        device_frame_size = value_range.mMaximum;
         warn_report("coreaudio: Downsizing buffer frames to %f",
                     value_range.mMaximum);
     } else {
-        core->device_frame_size = core->frame_size_setting;
+        device_frame_size = core->frame_size_setting;
     }
 
     /* set Buffer Frame Size */
-    status = coreaudio_set_out_framesize(core->device_id,
-                                         &core->device_frame_size);
+    status = coreaudio_set_out_framesize(device_id, &device_frame_size);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
     }
     if (status != kAudioHardwareNoError) {
         coreaudio_playback_logerr(status,
                                   "Could not set device buffer frame size %" PRIu32,
-                                  (uint32_t)core->device_frame_size);
+                                  (uint32_t)device_frame_size);
         return status;
     }
 
     /* get Buffer Frame Size */
-    status = coreaudio_get_out_framesize(core->device_id,
-                                         &core->device_frame_size);
+    status = coreaudio_get_out_framesize(device_id, &device_frame_size);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
     }
@@ -430,10 +431,9 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
                                   "Could not get device buffer frame size");
         return status;
     }
-    core->hw.samples = core->buffer_count * core->device_frame_size;
 
     /* set Samplerate */
-    status = coreaudio_set_out_streamformat(core->device_id,
+    status = coreaudio_set_out_streamformat(device_id,
                                             &stream_basic_description);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
@@ -442,7 +442,6 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
         coreaudio_playback_logerr(status,
                                   "Could not set samplerate %lf",
                                   stream_basic_description.mSampleRate);
-        core->device_id = kAudioDeviceUnknown;
         return status;
     }
 
@@ -456,20 +455,24 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
      * Therefore, the specified callback must be designed to avoid a deadlock
      * with the callers of AudioObjectGetPropertyData.
      */
-    core->ioprocid = NULL;
-    status = AudioDeviceCreateIOProcID(core->device_id,
+    ioprocid = NULL;
+    status = AudioDeviceCreateIOProcID(device_id,
                                        out_device_ioproc,
                                        &core->hw,
-                                       &core->ioprocid);
+                                       &ioprocid);
     if (status == kAudioHardwareBadDeviceError) {
         return 0;
     }
-    if (status != kAudioHardwareNoError || core->ioprocid == NULL) {
+    if (status != kAudioHardwareNoError || ioprocid == NULL) {
         coreaudio_playback_logerr(status, "Could not set IOProc");
-        core->device_id = kAudioDeviceUnknown;
         return status;
     }
 
+    core->device_id = device_id;
+    core->device_frame_size = device_frame_size;
+    core->hw.samples = core->buffer_count * core->device_frame_size;
+    core->ioprocid = ioprocid;
+
     return 0;
 }
 
@@ -553,7 +556,9 @@ static OSStatus handle_voice_out_change(
         fini_out_device(core);
     }
 
-    if (!init_out_device(core)) {
+    init_out_device(core);
+
+    if (core->device_id) {
         update_out_device_playback_state(core);
     }
 
@@ -650,7 +655,7 @@ static void audio_coreaudio_class_init(ObjectClass *klass, const void *data)
 
     k->max_voices_out = 1;
     k->max_voices_in = 0;
-    k->voice_size_out = sizeof(coreaudioVoiceOut);
+    k->voice_size_out = sizeof(CoreaudioVoiceOut);
     k->voice_size_in = 0;
 
     k->init_out = coreaudio_init_out;
-- 
2.53.0


