Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81069C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 04:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbBbg-0002Dg-NT; Thu, 23 Jan 2025 23:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBbf-0002DQ-Br
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 23:47:47 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBbd-0004aj-Gv
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 23:47:47 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so53293805ad.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 20:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737694064; x=1738298864;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lRSdohQfLb761s33NJwI3rtsR7FUzyHNb2eLwHUAZsw=;
 b=Gsw2/LdDRjG29WoF8EWbrI/p4e5vAqBNiCB99JGLzu1C7xrHPt06UhTum0CRAFQp5U
 Ok1fJkKxGwJCvGnfjoEWAdepyjmjAam4sKtxqM5S32rcfWd1Lacezpgvv2nJX707JJ6X
 HST50gEE3XAaXA7ck4q3L67ohsdzDFP4mJC52ddNX1nJG4BGyvQNpalLGO9DEWw19EBr
 7MPfUs1Y1q3GWGeu9MYx0rKuaxxQfon9VErNRXdoQR/EadXxBV79RQB70S4o8LREAyuq
 6Pd2x1A16hkxZQDhItULEXZOBylTYFO0CqNcH8a/e7H8EMDibwTVC8FXRND66xRcflr2
 kdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737694064; x=1738298864;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lRSdohQfLb761s33NJwI3rtsR7FUzyHNb2eLwHUAZsw=;
 b=hULNCk445q4Y9vDj0+bJQwzRBmmtMOnmsIzL29AU2xLdNG8aPJ+SecHxepL5/aZFF2
 Q9NHTQBWyVc8I9LPEMWGVPGYxR5ZIDLxyJm5j9D3MGJ5FvsoBIIDvas6tYE8VSMdKfV7
 76XdpVyqBJdmUVJWMoF52uBUjYfZn9HS4JNXf2RTM3G+CIHuZAwI/cuw76z5qQ935+wY
 ELrxACUtL7fr7EiMNOrluJL9A4zNSJsaZDwOnlZiXBbeMmLUjidCj81+JpVQetS8BSHU
 7yMxTx2PCOlQrx0Jdhsm1MMXiLRLoZri/h+EfXFOxxYcY4xdVjnOEIGTms3v3sjTS35z
 46sA==
X-Gm-Message-State: AOJu0YyG/uwljHmJ1JHj3iGBjK+x7J1yHvsWSfwU+/NKpBF8VTQitTca
 sMccKtkfDcmNbIfyToglQqmyzrAX6m9evkVnq8Dn4TEBC4yAPcXXoMg88KFv9ME=
X-Gm-Gg: ASbGncuxuzbx8MdMZ7E4Xe/jUSFHVtTHydtc7mMWBsrxqF5qOzuT7yuYaT69m8L40nQ
 hfq8Sjdmy0tXGAYluKv1KfFfCFqMHykKTzV7FH8+ClF9k9/O6z7JbkYdrWFITSc8dBxLdiJHPx1
 ayAqAQDb7A3ECiwbetCq6c8sgvzBUeMUO9x4n0ANSYldG4tS8jQCpbekdAL58fjjYG0jtc1s6sf
 XGgbga/N3vlaqPR89GHjfZdqGqcEM8Z/5G7PgKxYaFOYdsG/e8GDe4onPMpNvS27b5guLIvbmtL
 rpKFqBtt
X-Google-Smtp-Source: AGHT+IFaSpCQ9bWxknYT0k3+h24wh4djgMb0e0qAbKWwEsunVTl+948nBkPWMS4v1PrwFdDDdA4dZA==
X-Received: by 2002:a05:6a21:158d:b0:1e1:a449:ff71 with SMTP id
 adf61e73a8af0-1eb6968a845mr10039499637.1.1737694064224; 
 Thu, 23 Jan 2025 20:47:44 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-ac48e84e199sm721025a12.11.2025.01.23.20.47.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2025 20:47:43 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 24 Jan 2025 13:47:13 +0900
Subject: [PATCH v6 3/5] coreaudio: Commit the result of init in the end
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-coreaudio-v6-3-11fbcb6c47cf@daynix.com>
References: <20250124-coreaudio-v6-0-11fbcb6c47cf@daynix.com>
In-Reply-To: <20250124-coreaudio-v6-0-11fbcb6c47cf@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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
index c3ede586bbee1711d6a798175995b8db7dc89398..aff2b37b12aca723849645297c04f30ed365b8f8 100644
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
         coreaudio_playback_logerr (status,
                                    "Could not get default output Device\n");
         return status;
     }
-    if (core->device_id == kAudioDeviceUnknown) {
+    if (device_id == kAudioDeviceUnknown) {
         dolog ("Could not initialize playback - Unknown Audiodevice\n");
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
         dolog ("warning: Upsizing Buffer Frames to %f\n", framerange.mMinimum);
     } else if (framerange.mMaximum < core->frame_size_setting) {
-        core->device_frame_size = framerange.mMaximum;
+        device_frame_size = framerange.mMaximum;
         dolog ("warning: Downsizing Buffer Frames to %f\n", framerange.mMaximum);
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
         coreaudio_playback_logerr (status,
                                     "Could not set device buffer frame size %" PRIu32 "\n",
-                                    (uint32_t)core->device_frame_size);
+                                    (uint32_t)device_frame_size);
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
         coreaudio_playback_logerr (status,
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
         coreaudio_playback_logerr (status, "Could not set IOProc\n");
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


