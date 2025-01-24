Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D717C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 05:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbBzi-0003Me-Rb; Fri, 24 Jan 2025 00:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBze-0003M0-0e
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 00:12:34 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBzc-0000Hl-5j
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 00:12:33 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2156e078563so23718035ad.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 21:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737695550; x=1738300350;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eTpw4AwgYNUkCwOt27kW7PR4isG8aZO8Eymx6q5/DGs=;
 b=iUDjs4EkOxuTwEUfyu4QvPLC4VMesRjZrq+sC3/igK8YEp9o331DXNHHqwjnMX6s3Z
 9H9KQ3eWC1xupjPfNxhwz4RXbFlF2cOavnzmjTEjiRBcQbDxULXk3NUBPZ5GNVDCSYA+
 AnL8pdWDSq4wQDnyNDVESo4KhTEiAiJmE+0CManqWaImHX8/lH7Hb35BIAuBBuu/6KEP
 QithG65yFNzE/yVCmyzSrM/XV+X1nVRQH/61Hotr6fFkOuQZy0q0JB5pWGML2nzD9B+A
 5E62CApCRcYnj06DSTjExTN46FHYI/63bzGhoRjgyim5QKS3B05chayT/inXR0gJfNdb
 Qh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737695550; x=1738300350;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eTpw4AwgYNUkCwOt27kW7PR4isG8aZO8Eymx6q5/DGs=;
 b=YCL3HOxbj+fPMhxHrIQQuTDRbM0cAs4zlgwiXfGNysUBtGKcY+vogppsfKpbT6uaqP
 iWxptcii6FbpYPSGC/GW9PQUKl3yaCGqoJaHsgpKq2cZ0+mbVdI47KVIuMEJ2cK95zv+
 9SD3trI9SKJuwYrNtIfyqXDNqDAbTMd8vV9jF9478diBEZMU/MKU2zdrhPE+XVXywsir
 IvIGW3fUSpFjmEbrjmaq+OVdryyT/ULitZ7Mab6U4cj5yTR1uekZsiPorGagWZJM5uw6
 qWVeqRqWAVYOF9IcQPufOqgPMo52PCUSQxYsUYdAgk8k9Rk8dBNZBluTBUfkjwGEI0FV
 cd4w==
X-Gm-Message-State: AOJu0YxmN3e38MfKQAc3fMazfTBsaXTmy2eJ9fgKChocHyrhp6ANTbYg
 m3exc1HR2n6uVsbyyDitIegtmIjDQNKBF+zg9eV+7dp/23AHkm42barM3OIMZpN/3wLYXYoVNrk
 vg7k=
X-Gm-Gg: ASbGncu64fDXA5/AuOMJkIGozDgcVrZlu6dGVWsnt19VUjQFASiMyVCHNI4tfq++pGB
 LrqGo7QJKe73RutSrpdczhEm1n5Nx5zA9L/yAYD/4UI0RmM5AbQ0oTi84KD3IfUdKIxdHTRZ9VM
 ozSvV6Kcq9A9BSlFxWfEbFHmoMnX4XCX5cqeDIEH88z2osMw1i6aDkBw2rxCMIhdBUAHgv1dR12
 ju5vonzYRnuYhTca67Kio1VJbNrhpBiNhabMqKsXN04nn5RM21QPTWDNwl/0EmmxvtF/KYf/vVX
 9Zz8IqBA
X-Google-Smtp-Source: AGHT+IE66H7/8702WeVhGd+qOs8zkORfdtW4FA+mNH2Fsr//gSVGrIE0ep7ydXW869XJaLDYc6RBCw==
X-Received: by 2002:a17:903:234e:b0:216:7d22:f69 with SMTP id
 d9443c01a7336-21c35613b55mr352971935ad.50.1737695550641; 
 Thu, 23 Jan 2025 21:12:30 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21da3ea31cdsm7773195ad.67.2025.01.23.21.12.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2025 21:12:30 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 24 Jan 2025 14:12:07 +0900
Subject: [PATCH v7 4/6] coreaudio: Commit the result of init in the end
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-coreaudio-v7-4-9d9a4d91db37@daynix.com>
References: <20250124-coreaudio-v7-0-9d9a4d91db37@daynix.com>
In-Reply-To: <20250124-coreaudio-v7-0-9d9a4d91db37@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

init_out_device may only commit some part of the result and leave the
state inconsistent when it encounters a fatal error or the device gets
unplugged during the operation, which is expressed by
kAudioHardwareBadObjectError or kAudioHardwareBadDeviceError. Commit the
result in the end of the function so that it commits the result iff it
sees no fatal error and the device remains plugged.

With this change, handle_voice_change can rely on core->outputDeviceID
to know whether the output device is initialized after calling
init_out_device.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 audio/coreaudio.m | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index 6f170a909983b2a5c6abd6fc04c6c3f32828c10c..43a5f837ba4cfe4464eaab8f1693696638e14113 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -357,7 +357,10 @@ static OSStatus out_device_ioproc(
 static OSStatus init_out_device(CoreaudioVoiceOut *core)
 {
     OSStatus status;
+    AudioDeviceID device_id;
     AudioValueRange framerange;
+    UInt32 device_frame_size;
+    AudioDeviceIOProcID ioprocid;
 
     AudioStreamBasicDescription stream_basic_description = {
         .mBitsPerChannel = core->hw.info.bits,
@@ -370,20 +373,19 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
         .mSampleRate = core->hw.info.freq
     };
 
-    status = coreaudio_get_voice_out(&core->device_id);
+    status = coreaudio_get_voice_out(&device_id);
     if (status != kAudioHardwareNoError) {
         coreaudio_playback_logerr(status,
                                   "Could not get default output Device\n");
         return status;
     }
-    if (core->device_id == kAudioDeviceUnknown) {
+    if (device_id == kAudioDeviceUnknown) {
         dolog("Could not initialize playback - Unknown Audiodevice\n");
         return status;
     }
 
     /* get minimum and maximum buffer frame sizes */
-    status = coreaudio_get_out_framesizerange(core->device_id,
-                                              &framerange);
+    status = coreaudio_get_out_framesizerange(device_id, &framerange);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
     }
@@ -394,31 +396,29 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
     }
 
     if (framerange.mMinimum > core->frame_size_setting) {
-        core->device_frame_size = framerange.mMinimum;
+        device_frame_size = framerange.mMinimum;
         dolog("warning: Upsizing Buffer Frames to %f\n", framerange.mMinimum);
     } else if (framerange.mMaximum < core->frame_size_setting) {
-        core->device_frame_size = framerange.mMaximum;
+        device_frame_size = framerange.mMaximum;
         dolog("warning: Downsizing Buffer Frames to %f\n", framerange.mMaximum);
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
                                   "Could not set device buffer frame size %" PRIu32 "\n",
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
@@ -427,10 +427,9 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
                                   "Could not get device buffer frame size\n");
         return status;
     }
-    core->hw.samples = core->buffer_count * core->device_frame_size;
 
     /* set Samplerate */
-    status = coreaudio_set_out_streamformat(core->device_id,
+    status = coreaudio_set_out_streamformat(device_id,
                                             &stream_basic_description);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
@@ -439,7 +438,6 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
         coreaudio_playback_logerr(status,
                                   "Could not set samplerate %lf\n",
                                   stream_basic_description.mSampleRate);
-        core->device_id = kAudioDeviceUnknown;
         return status;
     }
 
@@ -453,20 +451,24 @@ static OSStatus init_out_device(CoreaudioVoiceOut *core)
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
         coreaudio_playback_logerr(status, "Could not set IOProc\n");
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
 
@@ -550,7 +552,9 @@ static OSStatus handle_voice_out_change(
         fini_out_device(core);
     }
 
-    if (!init_out_device(core)) {
+    init_out_device(core);
+
+    if (core->device_id) {
         update_out_device_playback_state(core);
     }
 

-- 
2.48.1


