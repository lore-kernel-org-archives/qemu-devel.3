Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BD2C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMVv-0007A9-5N; Tue, 20 May 2025 08:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMVE-00050x-Q1; Tue, 20 May 2025 08:55:32 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMV7-0001LT-L4; Tue, 20 May 2025 08:55:28 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-30e8feb1830so3375184a91.0; 
 Tue, 20 May 2025 05:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745717; x=1748350517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pjfIs5gITyjRMKLD5/LED/i/qyf7Ai8DnNu3qgZkijk=;
 b=RKI+4I0q4EOlQkt2gIQGujUhIc2MQHMTAqfr71jJZpLYXByZMjX1Jfmf3LJ3dB9LMi
 relHILGb5bsFjVbTyFgoZ9rPElnBNIYC48as0iZl4gsfk0iei/8UemCLQ9cbSlKmup42
 ldltbRjs5f+3fLN4sueQ0PCqoeOG7mErqpu0E/O9RlXadtS05uFoZoik3Bqc9apUQfd/
 OT7Rf1V7BfvCX5R+YqNj7rmOJZRlRqCHjQDSiFZAUkWEy/4pg8PKTQSmvKEhClTy5NZ6
 0k2stGAIL5ME2lf3SYtMgzIuy8MLP+PVSCsK0hTnsS9F0KYvMLer1hpnquspcqmhIZoo
 e8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745717; x=1748350517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pjfIs5gITyjRMKLD5/LED/i/qyf7Ai8DnNu3qgZkijk=;
 b=ZDe/9IR3zTn2cz5fryq9dHfA4C71YugLDogks7Ka1litIZG+y/b+dBAM9Y4idAKK5U
 6sobzvpp0ungbRHb1IIF7c7xVAukWpTthzuBZ7UQ3ca9Azp9pSa3LK6cy1AFA9aEpZVe
 Xy39ZlZrreTTfa2irn0H60IiOhacm3emdX7vDMmyrklslqII8/GxT13gfcaiSc0PKQzz
 ZeysXSgWGn9n9RgfAo17SJS1KDwOpKEAX/6HLmrVOWvw4AnMlL2Y2aMJcHrhQJZsiRtW
 nAUfZPvcMNWDkMyZCcrP0lYwncrD7qtYlMGLR71QWq1xnZTw3EnruN033sVld23GeTLd
 +OwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2UbVfyN3nZLJV4o7Ekv5bfRL8Ws62TC21E/cA9k/ct8MOQ6O8ueCZk4WP4EUA55zM9YBuWioCS3jB2Q==@nongnu.org,
 AJvYcCXjhTufwYSrX23UaLZ0MCSphFKCkqC9sqe21A5XAvLphyWf8KMKyUt6iAZhVlCcYonZQ9sTyrehbg==@nongnu.org
X-Gm-Message-State: AOJu0YzqfS6MLqk6mJvDTs1YDNCceWI75/r5Xyc5gjboEKa1lSDNacr4
 ktjovmy5CPQR8lzJ2y0hAj104HPg3uJ0NE/T0TXnKVsHXh8XMm+R6vpNGjyExryw
X-Gm-Gg: ASbGnctGv4KiZ+PXvjtDGCK3tr96PKJrmQbN0aD+YsjR/Ps5UCg94qxLyl4AJvPTyX5
 lMBMxtf3nkGFFxlOVf7IVBarIHHFpWMyIRMErPwfXUTnNdqARkYoVqC+ammYStmLmDq1r2d77A5
 qpdbfMvccmXckrvbEt4yJSawHHs3Ts2pyyhHkahQZ2RzIrFxfYsQpO8KQpLbzBQhYB0ozfz1/t0
 jBKLb0xvdAeGh/axd4sNscYaxKCEcsebp19kGGDejzhav2ZhDsIchu3O1rhT7Ha8IZzuFc0tNQL
 q3ZyMJUcs4jA2gnoJrt1RG2WNNvi/1JIFegrhUABCZMsncvoo7danmu0Oh8+CQ==
X-Google-Smtp-Source: AGHT+IFctWoCBwXZjWVIzlvOeAGpN4yYvW8TpdBxj/ko0x2Fmf9rUlfVzBwaYGHdhUFZEuZxeGUt7Q==
X-Received: by 2002:a17:90b:3505:b0:305:2d27:7c9f with SMTP id
 98e67ed59e1d1-30e7d555aadmr28951571a91.16.1747745716767; 
 Tue, 20 May 2025 05:55:16 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:55:16 -0700 (PDT)
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
Subject: [PATCH 32/33] meson: Propagate optimization flag for linking on
 Emscripten
Date: Tue, 20 May 2025 21:51:34 +0900
Message-ID: <8d969f197a9b3785fd6bca4ec57e3a42afdf62c0.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747744132.git.ktokunaga.mail@gmail.com>
References: <cover.1747744132.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Emscripten uses the optimization flag at link time to enable optimizations
via Binaryen [1]. While meson.build currently recognizes the -Doptimization
option, it does not propagate it to the linking. This commit updates
meson.build to propagate the optimization flag to the linking when targeting
WebAssembly.

[1] https://emscripten.org/docs/optimizing/Optimizing-Code.html#how-emscripten-optimizes

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 meson.build | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/meson.build b/meson.build
index f6ed867819..91e182092d 100644
--- a/meson.build
+++ b/meson.build
@@ -869,6 +869,10 @@ elif host_os == 'openbsd'
     # Disable OpenBSD W^X if available
     emulator_link_args = cc.get_supported_link_arguments('-Wl,-z,wxneeded')
   endif
+elif host_os == 'emscripten'
+  if get_option('optimization') != 'plain'
+    emulator_link_args += ['-O' + get_option('optimization')]
+  endif
 endif
 
 ###############################################
-- 
2.43.0


