Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55B1C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMVt-00071O-7j; Tue, 20 May 2025 08:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMVI-00052Q-RX; Tue, 20 May 2025 08:55:36 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMVC-0001MT-0b; Tue, 20 May 2025 08:55:30 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-73bf5aa95e7so5065026b3a.1; 
 Tue, 20 May 2025 05:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745721; x=1748350521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=byOBE0LXqcmVn/uVzQGaT6uRuP0TTdALhSny48CvJBE=;
 b=k87iyALfdwYYmqYrDFFXJcoJ4RHkHvoojJanFB5HuK84xlM4rWYgw2bW/XbXOl+kgk
 KxFApBpZB/vMCzslCNQO9UHgLZkGMwc3gaLL0JMiKiAtPvr2HaOZipSxR4bVNM7D2SIX
 oV1jaCqeTq7Q+ytn0S0xzyo43roCorxI+XWTdPb3i6CmLen/CiQoNWyzmAOcno5G70yI
 yrKorVEdPGDKWlYoG3KeTq0ApQiRjHFyJIztYB0/xyZF8s8WWtaR8Fikfy4fsp3d3gPN
 PtorremaRNUFHy8rXlKO9udD3/BG5/9ZfnNHLexi0C974ohVwitbnwmx7IxkD3o5RuAi
 ot7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745721; x=1748350521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=byOBE0LXqcmVn/uVzQGaT6uRuP0TTdALhSny48CvJBE=;
 b=uEHrjFL6qhJs8CKZGKpQ/rwPWCErdAVABQhrM8/jZx0aKRlMvzmn+gMm/m4qS+/isH
 pcF6hZKSVecpbUq+L85nPda6ZbljY9W9ADzRCKN/oc0fdp+r2Le+ekZYvtxAs4Gy5LAm
 UoyJuiVDKxh/d9aXZtcV1igAw85fRaYEeuu/rX5AlxJlgBnK6l4ENgojMv7UVZQ71hsw
 WVjtmKr6AtlrL8tTVxXYLMA/OnayMULhuoPxHJ1hYWvcQwSgBJIrGfG7DJ/MZ26gjA3b
 5PLiX+Gtqyi2/kVDScCa1xGB4OjaLRIdY2mn0P09XGo0oHrM2aLTLMj2jS0PbW2oj0A/
 1SjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7gSn5jK/Zm0LsO1mTs2ql3rbaeBCiK5TKenWZ0Lu5Amp9M2fRBRELhDg+mHrj/5G4/4UEcg1nSA==@nongnu.org,
 AJvYcCVOw5X3wB7HhpqMkdCpltv5RMgoV1ISx99V+CEMx3Y6ZnlIlV8vOmB6OT1q4a9DvZqGn3J6iyUpzx0vnw==@nongnu.org
X-Gm-Message-State: AOJu0YzMeO/r15mnH7geoBznFj94CEOxCTc/yldILrIIe9uJc8nA1HOj
 zd3tFNZHWi05kn8NvOgWc8mT5VLYoCfrFOwf7o/u+vs2QzgDcOJlcKA4Am7oq0SC
X-Gm-Gg: ASbGncuSkkuzy0cKDbbWizBopawh3o0bN+5KbHflD6VUg5UqdPBjOAfhKCN00M5oT2i
 fNT4boPMULXoLjhYKTu3qZX5EKdvhhCQYxLTokKs4PD3vvRSA83rG0T2BDBQE40XQ0Z1FyMATRJ
 mBofMjj+IvUs3+046Bg5djO16uwV5cSAd8/qZdC1SA3MBPe3cl0UI6g/Vxl1yLMMpnhTtY1lBJh
 2ZuQCkNXf5MjgATG3vKaCjXx2stB49H0mMEoP7Tuui3dcoKWw8k0pVmRwvUWnK9K5kXsN2k432p
 FTOZpOqOWTHW9sEYuCvUmyle1gNh9zdKabqwihBQdJx4L5ABC3Y=
X-Google-Smtp-Source: AGHT+IHCNeXOoJTyXF78Adx/1Dxrax03p01KnXN3FbNUlv+jV9FjmGCEvba2dD4sWsgzbjHjN7ba3Q==
X-Received: by 2002:a17:90b:1c05:b0:2ff:5ec1:6c6a with SMTP id
 98e67ed59e1d1-30e7d55ba27mr27946322a91.18.1747745721589; 
 Tue, 20 May 2025 05:55:21 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:55:21 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 33/33] .gitlab-ci.d: build wasm backend in CI
Date: Tue, 20 May 2025 21:51:35 +0900
Message-ID: <36a7f4334e9e08691d7496809a5d06b23de22e26.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Check if wasm backend can be built in CI.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 .gitlab-ci.d/buildtest.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 248aaed137..fc42de231a 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -800,4 +800,4 @@ build-wasm:
     job: wasm-emsdk-cross-container
   variables:
     IMAGE: emsdk-wasm32-cross
-    CONFIGURE_ARGS: --static --disable-tools --enable-debug --enable-tcg-interpreter
+    CONFIGURE_ARGS: --static --disable-tools --enable-debug
-- 
2.43.0


