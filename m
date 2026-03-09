Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FBFF41808
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcxB-0000o8-Ek; Mon, 09 Mar 2026 11:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcwK-0007qj-Jy
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:54:44 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcwI-0000OQ-I7
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:54:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so10334655e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071676; x=1773676476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7lJ49HVs4Gy01kmm0B1/+3vVeTk1ijRg1tNGB25SQmQ=;
 b=jwUflGDYk5rNzdew7hWNoEzV2Llyct+ICVKC2cCjSHRzdU11bg8Jt77S39uCC4Du6c
 R5e5PbwcOmx1RUAqr1eGK+FcPGPpW5VFJICiQoly6wYCpfqACIpdgD6K7glBH36geA8H
 8hjUogQ30zUG+7/YBh4ZCIaisefi/2yO9EbAXBtzz5NzK0acrJQzrAlN16CRbO+MnZnM
 Rjpkk9efEuom07C3V2Febqmd/48vWMNJBznI16eX4ger6oZLvFDIJe65sihhB4bAOe10
 VbJdArJibi7tx6db+Lc1qLqMexLdwLw+Fd5gk+R0EqdY+3+ecZpkBHTIc9RVE7tfMuuf
 n7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071676; x=1773676476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7lJ49HVs4Gy01kmm0B1/+3vVeTk1ijRg1tNGB25SQmQ=;
 b=jogmp+ZH4xp9qQaauOHwCblmX6s8kxPeSmUl6rDUfdsEvg1RcbCi6FZ+RbaTHzeFSa
 ZZAGAobT5mkWIBzGM7V6o4yV4AUwBeX1uCxx3TwFNcWWK8tLkShiiSlv2BlO7sul/WnF
 QfkBda7tLCQGC1NA6N1rv8992GaYXAFQ/HRPVHd5XyJCDm7Ppjh6iIQhyDNfx6J947Qq
 baO2CAS7S0ZnKhvMD0voddi7MGrXd4E3JaGovR2IU/8oDY+Q5Li/kmLql0O9jm6NntR5
 oLruELzTFOj7n+hph5tcbGrj0BMFNdRp1m6OjuD/NkDHcBaPBbrGlB3e1v7DHR+ndl/+
 sTUA==
X-Gm-Message-State: AOJu0YxrVH87b07OgYvIHSVjwLSxn7Ka31wnWVtXVOMHpJHUdow3a6Tj
 nbMKqsANmUG6jRS466g+zt7/QHRP0zBqr+nkaIAKwSZmmCWv+NVM/hvkGub6TetND3dNxBenGpR
 UZ//bFfg=
X-Gm-Gg: ATEYQzz8yCbUXjG67tZtlDu7A1a0O1ESAH/Uk5ubZBi3gO+KwzhjYAdFghyRRt53zlc
 hVTvIE1brJ+hbF1R4zYDTLhkXIlavqMw/+CBi42GzwvXPZzDzax9ZeN46FRiEKNYd+CfmlCixDu
 iVtP22hScQG3LSzxwX8YZHb9gGx6udQuUuSGFbOLd+0e12q0rjvXKJSJlUczKZ0t3nLo1CSpnlD
 k6w9ZmcTBIfo5keor7IHbH0cId2VvrGz6QgCG9ApwSSFIWP3oZLGFC1qxN+2QvgjJ7lNK50+5Zn
 u5Yu+3hgZnT6t2zCjKsvsNv9+F/K8t6icXtCyRdke/nRMXcGMZ6NHtma0NZ0G+ALUt3RcHn1ubF
 F+UKwZx4PKF/PrMtRVBM1axRDjEj2OOFjFIrqzTnF2h9Cwts+ESP7Xvj3Tu/QYQVYt81hM+fyNQ
 vRe552kp0odTj25dANB/6m/xpZOVCvHgsgJ0S0KA64h6L8GlYjlyFANUJCmAJV5zdOobU4tKJy
X-Received: by 2002:a05:600c:1c0d:b0:485:39d4:2dd9 with SMTP id
 5b1f17b1804b1-48539d42ea2mr87280135e9.33.1773071675728; 
 Mon, 09 Mar 2026 08:54:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae483desm26243502f8f.34.2026.03.09.08.54.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:54:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/49] coreaudio: Remove unnecessary explicit casts
Date: Mon,  9 Mar 2026 16:51:50 +0100
Message-ID: <20260309155219.62400-21-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

coreaudio had unnecessary explicit casts and they had extra whitespaces
around them so remove them.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260304-coreaudio-v8-1-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 audio/coreaudio.m | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index a28fa77d73f..cbda4f14369 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -310,7 +310,7 @@ static OSStatus audioDeviceIOProc(
     UInt32 frameCount, pending_frames;
     void *out = outOutputData->mBuffers[0].mData;
     HWVoiceOut *hw = hwptr;
-    coreaudioVoiceOut *core = (coreaudioVoiceOut *) hwptr;
+    coreaudioVoiceOut *core = hwptr;
     size_t len;
 
     if (coreaudio_buf_lock (core, "audioDeviceIOProc")) {
@@ -394,11 +394,11 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
     }
 
     if (frameRange.mMinimum > core->frameSizeSetting) {
-        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
+        core->audioDevicePropertyBufferFrameSize = frameRange.mMinimum;
         warn_report("coreaudio: Upsizing buffer frames to %f",
                     frameRange.mMinimum);
     } else if (frameRange.mMaximum < core->frameSizeSetting) {
-        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
+        core->audioDevicePropertyBufferFrameSize = frameRange.mMaximum;
         warn_report("coreaudio: Downsizing buffer frames to %f",
                     frameRange.mMaximum);
     } else {
-- 
2.53.0


