Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C870CC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYg8Z-0002tx-8x; Fri, 17 Jan 2025 01:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYg8X-0002tU-Qp
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 01:47:21 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYg8W-00055h-3X
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 01:47:21 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21634338cfdso43680265ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 22:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737096438; x=1737701238;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8flhO7OFgjJStUozbkecdgxyph0L237eJ5zpIYSa2Sg=;
 b=DPN33yAKGBMW399gIsW2D+kd3TuFyt7Nl3SIt2IjRccYxGrWuC7ElNUfXIcV8Z5yNo
 bQGbKR4RNcs04jLq4r6P0c1WN+5spoWaeR0C8dd9skCrf+bw22iRD3Czp/k4J4K6ZaDC
 VpNqD4jX2pL8ixyTGNy4P7DbrPVrFGKOBslIFR4LnqV2+OiHuj837CQkjmmsLbQlL2qa
 fB3FjmzGQZsSOy0NSu1eMzp204vwMXZrPUxd0bAFRjLHetxwyhxNeISKmVjrhJGTwl5U
 tG+DxOs7YcM8qeNiSQULdLYZwDcYOChFqXSE5SpYECwVl4sJRtTQ98EHOpoSKHnqIH/j
 iQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737096438; x=1737701238;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8flhO7OFgjJStUozbkecdgxyph0L237eJ5zpIYSa2Sg=;
 b=aA+7kdHxVuG973T/156iX77CaMDXkh6jn6vhnZONU5/yJoQtVS8DcXNLXomZ7oyfzv
 wA9QPYAQ0xNvZ48/InjwnfTrMz/Dw5MJOvZP0R4HercF6LeT1UJtDwAtyzm9+wB3x8ST
 /C1lIwClVzUPsSO8hrNZY7osDr/2bXiq5hS+lV3+Rky99sUKaNp3mHUDw8u8uDCnlrDV
 i2myhLo9Z9+Vr69KLz8rfWIatieEY0TvhIT4YzXe0lEEeMRXxW1/aJgH4u9n65SBdiKb
 081s99CkK/J7qe/0OzxpZdICuPl7IblUpETT3AN40pAkpSlUL8Rc+sefyWgi9w31lkvc
 aTnA==
X-Gm-Message-State: AOJu0Yz/IvBC8p3QdpwwYhq8biHx2lEyPmPBhP0iQZ5SFJOyAzGMS0DU
 Qc6Q2jItpeGVIrFJYvdTVxPaFnuU5wNxqWcdbQVUxP0ALQo/YVwhgEM43SqORVJpw/8r0dlZwBB
 1lfU=
X-Gm-Gg: ASbGncsGeLe5Gt2Cr74DtgO/ZAp4c8q3OrD387Buu663LAHxzua2fGnAPyaeL18whmI
 1gq0Mrz7B0inwDecQ0CEw5tAP31q8xTccfpAhHcfilKSOxDo06ZwzxciKxbxl6i1LQF7XLQJfrW
 FOnAMvSuY4cadi+0BQ3uAUtpULr+wvrBGqObBryIT2jwqZxYVjbKS9YT1htlwrjQ9dOlwvLnxs8
 IucRqY7nwfmGnRX6sQrLLdbBnI1zSLLZOmt/f2NPVN4c05J5vy2m7qRFc0=
X-Google-Smtp-Source: AGHT+IHV5dMaPbzQuZ146GM/a7AvsMUpDkmdomN1PPjW4v9cqR9c7OLKfYUD5VzW2DtIK4aze7KMcQ==
X-Received: by 2002:a17:903:32cf:b0:216:5af7:5a8e with SMTP id
 d9443c01a7336-21c355ec9c0mr24055655ad.26.1737096438591; 
 Thu, 16 Jan 2025 22:47:18 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21c2d4027e3sm9309305ad.222.2025.01.16.22.47.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 22:47:18 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 17 Jan 2025 15:47:00 +0900
Subject: [PATCH v4 1/3] coreaudio: Commit the result of init in the end
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-coreaudio-v4-1-f8d4fa4cb5f4@daynix.com>
References: <20250117-coreaudio-v4-0-f8d4fa4cb5f4@daynix.com>
In-Reply-To: <20250117-coreaudio-v4-0-f8d4fa4cb5f4@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
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


