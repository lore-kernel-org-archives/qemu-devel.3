Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC9DC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYg9L-0003J3-7s; Fri, 17 Jan 2025 01:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYg8p-0002xZ-Ni
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 01:47:39 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYg8j-000577-3Y
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 01:47:38 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21a7ed0155cso26807335ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 22:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737096448; x=1737701248;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oD5ynekI1pncuUsoZ3D40zipNa+S5IKwwfMz+sh95pQ=;
 b=BMbL2T5saP7+FA3BYW4rhDSk94WtvQNVcs5Qr4IYyMrSEUoGlqIcml46DxJkIzC6md
 +rKhbwrTwTSfcus7XcbCDYzvWpNbuHl2+dH4XmX0KvvGHSUfprEYk8cmbLPAAr19bSJS
 FstrGaxxB9UMG8OPL7Fx9ZJutf+YJM9P9E6Sob8sEq2zTt9YLVRDtbEqqU9MC/REMTSs
 /sFz1if07knVLzyR5js6hlfIgC7KgW5zxBWvYAkLfeDu4ILOOdkZ7FLBhlIFTfM72teY
 Png3Ld5JuyeeyBzWRBDgdTojXxtrJv85bCcg3L3IGx92gS/MMky6rFjA4GGOUNQJTXz9
 or/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737096448; x=1737701248;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oD5ynekI1pncuUsoZ3D40zipNa+S5IKwwfMz+sh95pQ=;
 b=XQ4I2pFE1ZdzeUVt9HNAjDcQlVptLT/ehYd6iGKMJaKuop2+stWMFTi+ZEqL4IfTpH
 aiic9LJ7P5/fecoVChtvdTfolNxUyeZY/HUwm4CVqeQW39sxCsQ66R+vKY6d2+hPneYu
 YpKtgDEQkUT020Tqxcmsi7VdxL6pwXf8DmpRaohchZ35onlhTUj99uOGtQwdZtXxPf1B
 dseNAWVvTjw2XUIwdHmIch18NoBe3FvEuGZmeAnTD9IhgHKzBufSrTMSx8jugUPsrK5w
 ACeLKKoGuqisaZAEsphblrZG7wpZ4LV8WBKO83Vy3IcemeGDC8iKcjAb/I8fPp6Cj1jL
 Bc1Q==
X-Gm-Message-State: AOJu0Yw6ah/jPqmnb7ZWtZoXpSBy0GLtXSTuCX82Id+oAVB/GznYfdVW
 wjmQfxBbnuFqFcCkUtTagj0USXuniXTCG9+DaRF5kHRn02eyfwXeFy8pcEwBVsw=
X-Gm-Gg: ASbGncvhgP3eYq8jf8JBlqY2CAX91VZjbS0gKorLTQDWqNIJIWpL0W3F2xWtg7/Jma1
 eRf+ta9wNsvJsaKi7YmSskKY5sLzDWUUthL14XebOmf9dUkBBY/lpcQgqn57H5KZkjaQsYmchLF
 mJtEyKz9gl46avuhzxF8jM6NvnFCW0nsnoLBkcv3m7PYaUjO3BczStsPwuI/fPsrHet/39Bf8lu
 XiL2VE13nnFXwJtPjdwJ6HtCfg1UKoPtIXH2JnQUInus8McbIyALMUOgvc=
X-Google-Smtp-Source: AGHT+IFTUgQOgRUIYM0TAKwq8GsySnUp6unfk8UgsYsGr4Vu6buAMgsowUdvcJ3PeVkGjgu4NeHGrA==
X-Received: by 2002:a17:903:2b06:b0:216:1367:7e48 with SMTP id
 d9443c01a7336-21c34cd5e4emr26690545ad.0.1737096448329; 
 Thu, 16 Jan 2025 22:47:28 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21c2cea07b6sm9617865ad.35.2025.01.16.22.47.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 22:47:28 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 17 Jan 2025 15:47:02 +0900
Subject: [PATCH v4 3/3] coreaudio: Initialize the buffer for device change
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-coreaudio-v4-3-f8d4fa4cb5f4@daynix.com>
References: <20250117-coreaudio-v4-0-f8d4fa4cb5f4@daynix.com>
In-Reply-To: <20250117-coreaudio-v4-0-f8d4fa4cb5f4@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
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

Reallocate buffers when the active device change as the required buffer
size may differ.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 audio/coreaudio.m | 1 +
 1 file changed, 1 insertion(+)

diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index b9e1a952ed37..72a6df0f75ee 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -466,6 +466,7 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
     core->outputDeviceID = deviceID;
     core->audioDevicePropertyBufferFrameSize = audioDevicePropertyBufferFrameSize;
     core->hw.samples = core->bufferCount * core->audioDevicePropertyBufferFrameSize;
+    audio_generic_initialize_buffer_out(&core->hw);
     core->ioprocid = ioprocid;
 
     return 0;

-- 
2.47.1


