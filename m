Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD37C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 05:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbBzS-0003KZ-8h; Fri, 24 Jan 2025 00:12:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBzP-0003KQ-Op
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 00:12:19 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbBzO-0000G5-1Y
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 00:12:19 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2f43da61ba9so2468866a91.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 21:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737695536; x=1738300336;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fWOg7aqqH8nu4hr/5SdBWnNPemUm1VuYD9oCJuZW3aE=;
 b=VC5srrpXmTmiRocFYx9LwhoK9ZBUM6/oC9S/Ro/eMn9+Pykl0HGJdAAcVFJkneT+im
 3s0im+W+yL2L2HPbldSoH3az6K1/JdNn+f8iEnzdlhDP2Rvb8wYHeVx+g1hTG9tGgTo6
 7DMb4fvkA1znr3i6dlMGMf5DvKZmYMefHgFdJjRUtX9Jpc2JNt6isbqyIaUaE5J5h1qh
 7+6DSR0mvuD97RVQcvWp6y6Gc+ZPqEkEfp22J+FkyTWINsmsJlkdFXvulFwhp2lO9Rp6
 3u4726u8ql5uqPhAyXk/P/0bd5zyYtS9/n6IlEms+AV8EYz724DmHojpc7AsFc+hkg/+
 UM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737695536; x=1738300336;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fWOg7aqqH8nu4hr/5SdBWnNPemUm1VuYD9oCJuZW3aE=;
 b=FSAuGcReOtxAO8DRXoLqcVuNt8mKlCk0lRs0ZbU7xxW3LyLTOcB9FSI3sooSWV5b6U
 6yAPS02GZkRZYzKLvP274R+pf1XaRvTZjG0t/IY6/s5vKp1c3BhYbiKf8ftk38r73w2j
 11TjCboiyyi9J5aQZwsklQIhUA5blm0eBRD1pm8e2EP3xu/err0GZoahZEXBNeNsPnmq
 pG63dBRTHmG66/9hMytwmpgcvvWbeKRjcOcyt+Cg3aHO5Eh6B0LxVBbS+D41EVvU+ZdO
 +F8px8VTuAlUy7UVBHP3y4YVmdpqWCtPgTNd5ok6MmPaz6TLN5On8Z3tmfSEAzFarNKs
 TqdA==
X-Gm-Message-State: AOJu0Yxi/2Na93ThBNK7pFGxD4yju9QL+6b5nsRZUxensNvyzBrhFLX1
 9y3WFOfzol50jY0LO5/eH8LdUsnF0ypyYSJ9s23+iF/lfXnvx6yl34IHhTW1ZkO2PJwfSZBnsyn
 wKpc=
X-Gm-Gg: ASbGnctY8BYZQlLMOV0ai6QupxiW7hIlz+WSPjbQ29+TCMysLoS4dDSWPr0ifalSgBX
 SurLLEstjlny+Kh31sJzJINZsSBjL3zSBva+3XuNMOuMVHlHsek6NcMGCmJqBI0Bi5tlTp2ZsvG
 b7hLHo21cLjm6QNrdVbGmpXT/vW/Gx62/p0wT9Um5cjxwNmIbcPKbhgigp1rxGbqHE1XB3WYVi3
 QxRQY5L7gBH6/wtD2PcVKmwm5HngaGtH0JYyD43K79mv8FqHfBabgoTTX4goWimktj9iWllX1pg
 ugeFt81M
X-Google-Smtp-Source: AGHT+IFQR7veNA3427gt+Q1w9A+lism8AIZBq4q+JA7zi4tFaNSM/5PO93Rt1wA1bp1Tt4TDxdZ1hQ==
X-Received: by 2002:a17:90b:2809:b0:2ea:a9ac:eee1 with SMTP id
 98e67ed59e1d1-2f782c92bd9mr44061452a91.10.1737695536404; 
 Thu, 23 Jan 2025 21:12:16 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f7ffa44cc3sm667189a91.10.2025.01.23.21.12.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2025 21:12:16 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 24 Jan 2025 14:12:04 +0900
Subject: [PATCH v7 1/6] coreaudio: Remove unnecessary explicit casts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-coreaudio-v7-1-9d9a4d91db37@daynix.com>
References: <20250124-coreaudio-v7-0-9d9a4d91db37@daynix.com>
In-Reply-To: <20250124-coreaudio-v7-0-9d9a4d91db37@daynix.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1030.google.com
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

coreaudio had unnecessary explicit casts and they had extra whitespaces
around them so remove them.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 audio/coreaudio.m | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index cadd729d50537850d81718b9284efed5877d9185..0b67347ad7e8c43a77af308a1a3a654dd7084083 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -309,7 +309,7 @@ static OSStatus audioDeviceIOProc(
     UInt32 frameCount, pending_frames;
     void *out = outOutputData->mBuffers[0].mData;
     HWVoiceOut *hw = hwptr;
-    coreaudioVoiceOut *core = (coreaudioVoiceOut *) hwptr;
+    coreaudioVoiceOut *core = hwptr;
     size_t len;
 
     if (coreaudio_buf_lock (core, "audioDeviceIOProc")) {
@@ -392,10 +392,10 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
     }
 
     if (frameRange.mMinimum > core->frameSizeSetting) {
-        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
+        core->audioDevicePropertyBufferFrameSize = frameRange.mMinimum;
         dolog ("warning: Upsizing Buffer Frames to %f\n", frameRange.mMinimum);
     } else if (frameRange.mMaximum < core->frameSizeSetting) {
-        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
+        core->audioDevicePropertyBufferFrameSize = frameRange.mMaximum;
         dolog ("warning: Downsizing Buffer Frames to %f\n", frameRange.mMaximum);
     } else {
         core->audioDevicePropertyBufferFrameSize = core->frameSizeSetting;

-- 
2.48.1


