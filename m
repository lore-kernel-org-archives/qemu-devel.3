Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B48C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 12:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY2BJ-0007GP-FO; Wed, 15 Jan 2025 07:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tY2BF-0007Fw-Ap
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:07:30 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tY2BA-0001AY-Ks
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:07:28 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2164b1f05caso117842805ad.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 04:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736942843; x=1737547643;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sjZycNOZCaijq9YoZP3XI2Nk/ik0UuNm9ezBnesNXjU=;
 b=cd3/Fm1TQ0WtD91uCgUvJuW68hJkRjaGlDJfDYUTkJnew8JIr+ULnHdRpro+5HGXBz
 Jv/vu2/i/x42/Zeo7sb2jetNvgUw/J4Tg9WAyzPCTbCyKk66vxLnGlQzbPiLO5FSvRiL
 CGio9T3sYZE2YNxpBTkDPFIFhmkZUPMcKQIdAXWFGeOoEAEOL2X2O9IvhgihCSZ+dGYz
 bvTNJW8xrauEEhbZ8ovMkFRFpYbevieTweEPiQOWnGju8tPN+JPFE2e36tZ4zw9Q203U
 XHP/Ie/HZ/Jb3VVktXOxKaOipyxONYxvlWldSeZScXAxwNcLp6NKKgistT87IS79embH
 RJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736942843; x=1737547643;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sjZycNOZCaijq9YoZP3XI2Nk/ik0UuNm9ezBnesNXjU=;
 b=JaVtz1sBOB0YDslKr0psotoyU8ymjUwGsnLjfD28g3dUd9l4F3QvW6rp4CfXGsfUL6
 ge1h3foY0FHsYKPsr7zxWdTpbcMyj0KKPYyypNFU4xUi04XMojkp/oH7wn27ZRFNMN1g
 NkhTnHcMTQEMGF6V+osOPtqYUIC8Ecd+0z5E0XqfWq/kvkVO8PZZSzbnIlv0+dFO7Cgr
 zgO6Apa5lqbgtSbkFYe3UNxvS7nZskswk5FVYz8eAW+ulXbYvYjfAtYqnwcra4ZN9fBV
 gGYd/6UUPGWE3F11v0DDagsbUTSBPOH88UN5wp2yBAzPjrRShB02h/Ajxfs8keRQTc0m
 hwrw==
X-Gm-Message-State: AOJu0YwaANLQu7WezdqFoCjqhWj09O8SX6doS2YlrEZc2Oylyg+VgBvt
 uPpxeb8GAtmiSPnZ30kqESPNrHcu38uH92fchXYAZ8B4ivggFfZsf1l4tGTEp6k=
X-Gm-Gg: ASbGnctESChbE+ISvKt5lgLB5eDWTpdLqJBUwkKDJHqfWxM52Mg2V0AZpCx6Fa5bpsY
 5HW+u0IuZLVx3POWGj90c2Yw0YRVgDFX9WbDns9jYMx5fD3/e4UK7n6IvfowWJmv3OOa98KcAdC
 3vPj4eI4nVDYD03AaAaXfjgyJRAY15jxzZOIgXH3Gu//1UNcz+ZEgqVJqfvJw/sZVJ5U3mEYkwj
 Qmv7lOhcHwIfct8PO3cxry9+Um53fYd/hY03ajIlKVYSsbQ88iEkfVZJJGx
X-Google-Smtp-Source: AGHT+IFl2aARzx/ijR34wnijxvno+8gvE2Wbi6gtzJly4XddNH0gpA7PsCwQ7ywn2zWfX4Tz3Yp5Xw==
X-Received: by 2002:a17:902:d2c5:b0:216:51fb:bb28 with SMTP id
 d9443c01a7336-21a83fe4621mr407310165ad.51.1736942843207; 
 Wed, 15 Jan 2025 04:07:23 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21a9f233836sm80217265ad.207.2025.01.15.04.07.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 04:07:22 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 15 Jan 2025 21:06:55 +0900
Subject: [PATCH v3 1/2] coreaudio: Commit the result of init in the end
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-coreaudio-v3-1-bdb6bcb5bf9f@daynix.com>
References: <20250115-coreaudio-v3-0-bdb6bcb5bf9f@daynix.com>
In-Reply-To: <20250115-coreaudio-v3-0-bdb6bcb5bf9f@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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
state inconsistent when it encounters an error. Commit the result in
the end of the function so that it commits the result iff it sees no
error.

With this change, handle_voice_change can rely on core->outputDeviceID
to know whether the output device is initialized after calling
init_out_device.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 audio/coreaudio.m | 49 +++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index cadd729d5053..b9e1a952ed37 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -355,7 +355,10 @@ static OSStatus audioDeviceIOProc(
 static OSStatus init_out_device(coreaudioVoiceOut *core)
 {
     OSStatus status;
+    AudioDeviceID deviceID;
     AudioValueRange frameRange;
+    UInt32 audioDevicePropertyBufferFrameSize;
+    AudioDeviceIOProcID ioprocid;
 
     AudioStreamBasicDescription streamBasicDescription = {
         .mBitsPerChannel = core->hw.info.bits,
@@ -368,20 +371,19 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
         .mSampleRate = core->hw.info.freq
     };
 
-    status = coreaudio_get_voice(&core->outputDeviceID);
+    status = coreaudio_get_voice(&deviceID);
     if (status != kAudioHardwareNoError) {
         coreaudio_playback_logerr (status,
                                    "Could not get default output Device\n");
         return status;
     }
-    if (core->outputDeviceID == kAudioDeviceUnknown) {
+    if (deviceID == kAudioDeviceUnknown) {
         dolog ("Could not initialize playback - Unknown Audiodevice\n");
         return status;
     }
 
     /* get minimum and maximum buffer frame sizes */
-    status = coreaudio_get_framesizerange(core->outputDeviceID,
-                                          &frameRange);
+    status = coreaudio_get_framesizerange(deviceID, &frameRange);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
     }
@@ -392,31 +394,31 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
     }
 
     if (frameRange.mMinimum > core->frameSizeSetting) {
-        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
+        audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
         dolog ("warning: Upsizing Buffer Frames to %f\n", frameRange.mMinimum);
     } else if (frameRange.mMaximum < core->frameSizeSetting) {
-        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
+        audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
         dolog ("warning: Downsizing Buffer Frames to %f\n", frameRange.mMaximum);
     } else {
-        core->audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
+        audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
     }
 
     /* set Buffer Frame Size */
-    status = coreaudio_set_framesize(core->outputDeviceID,
-                                     &core->audioDevicePropertyBufferFrameSize);
+    status = coreaudio_set_framesize(deviceID,
+                                     &audioDevicePropertyBufferFrameSize);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
     }
     if (status != kAudioHardwareNoError) {
         coreaudio_playback_logerr (status,
                                     "Could not set device buffer frame size %" PRIu32 "\n",
-                                    (uint32_t)core->audioDevicePropertyBufferFrameSize);
+                                    (uint32_t)audioDevicePropertyBufferFrameSize);
         return status;
     }
 
     /* get Buffer Frame Size */
-    status = coreaudio_get_framesize(core->outputDeviceID,
-                                     &core->audioDevicePropertyBufferFrameSize);
+    status = coreaudio_get_framesize(deviceID,
+                                     &audioDevicePropertyBufferFrameSize);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
     }
@@ -425,11 +427,9 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
                                     "Could not get device buffer frame size\n");
         return status;
     }
-    core->hw.samples = core->bufferCount * core->audioDevicePropertyBufferFrameSize;
 
     /* set Samplerate */
-    status = coreaudio_set_streamformat(core->outputDeviceID,
-                                        &streamBasicDescription);
+    status = coreaudio_set_streamformat(deviceID, &streamBasicDescription);
     if (status == kAudioHardwareBadObjectError) {
         return 0;
     }
@@ -437,7 +437,6 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
         coreaudio_playback_logerr (status,
                                    "Could not set samplerate %lf\n",
                                    streamBasicDescription.mSampleRate);
-        core->outputDeviceID = kAudioDeviceUnknown;
         return status;
     }
 
@@ -451,20 +450,24 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
      * Therefore, the specified callback must be designed to avoid a deadlock
      * with the callers of AudioObjectGetPropertyData.
      */
-    core->ioprocid = NULL;
-    status = AudioDeviceCreateIOProcID(core->outputDeviceID,
+    ioprocid = NULL;
+    status = AudioDeviceCreateIOProcID(deviceID,
                                        audioDeviceIOProc,
                                        &core->hw,
-                                       &core->ioprocid);
+                                       &ioprocid);
     if (status == kAudioHardwareBadDeviceError) {
         return 0;
     }
-    if (status != kAudioHardwareNoError || core->ioprocid == NULL) {
+    if (status != kAudioHardwareNoError || ioprocid == NULL) {
         coreaudio_playback_logerr (status, "Could not set IOProc\n");
-        core->outputDeviceID = kAudioDeviceUnknown;
         return status;
     }
 
+    core->outputDeviceID = deviceID;
+    core->audioDevicePropertyBufferFrameSize = audioDevicePropertyBufferFrameSize;
+    core->hw.samples = core->bufferCount * core->audioDevicePropertyBufferFrameSize;
+    core->ioprocid = ioprocid;
+
     return 0;
 }
 
@@ -548,7 +551,9 @@ static OSStatus handle_voice_change(
         fini_out_device(core);
     }
 
-    if (!init_out_device(core)) {
+    init_out_device(core);
+
+    if (core->outputDeviceID) {
         update_device_playback_state(core);
     }
 

-- 
2.47.1


