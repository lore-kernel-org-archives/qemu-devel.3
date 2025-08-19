Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D02CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoR2f-0005ps-Q5; Tue, 19 Aug 2025 14:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR1x-0002zh-0C; Tue, 19 Aug 2025 14:25:58 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoR1u-0004lj-VD; Tue, 19 Aug 2025 14:25:56 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2445818eb6eso42558305ad.2; 
 Tue, 19 Aug 2025 11:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627952; x=1756232752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oCoav4mrpfqHaiFY4ajN/hsX2ml/OjgBByRUO4LMbYo=;
 b=GGoLiNSncVJcDMR7UE+Jm88FmOoJi77G/YpeEGT66uMR8appXuBl98sqhlPRwO/exD
 6mdaLt2ZaWtZturCNwitsonbWvRd6WZlo8qeTaWTp8yp3OVTSvb1o9vLuyP1OglHvJVT
 CFJEKN2+DonkEgkpITuoiEvEqubovfyHeGjaiRtRqR+mrNtJxKFaMhdjsXpzcTTaGvL1
 8AfB1DzOviWGEoVbI6HylJZSFF6tOKDwvjZWdMohC5O7QN+5mWId06R94Ek4pHECAlJu
 t3rjBHVg5ucJaGaUh3jIi00/e9GPNCLHZ8WaC6IkdKFZ/h08iSYDoaY0DQKtRo0SQC5p
 Ii8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627952; x=1756232752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oCoav4mrpfqHaiFY4ajN/hsX2ml/OjgBByRUO4LMbYo=;
 b=nJYjatmNlaezB14vTi4u6uqJys9sDqlyA1Z9vzvKcGAD0WOmAcTUHQEiXvjY156IaC
 cJ2vN70xMmBDjN2jL4H5vWPojtTcKSNiAgCtcixuC67V7ufifI4yemuO7cjAdHOgTs8i
 NJD5nZXPHePfpQJ81KJatMbnkJMkGmTHLW0k1CX4KsbX5AfiT4n3AkyLAitGUQYQkRhP
 ZjndJtsLbJI9rPo+3RmdhMCBr2sj0jvl0Kc4V/w1YKp7qdHSr5zdcx8eZnUKZNiE2KOa
 u+XmUt1DomKWe1LmWxnQCObq8oA0FUmhdUZfi7nOtYrZiZizJtLxaou4CRCeBn+gUVzv
 RpdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj6bMWn99vXSEMtReT989Yh8/9QvXV406Fl4lStPdhv8sWLWHZmPTjLBTKZeKTQSToBxEfKiK/1I6R7A==@nongnu.org,
 AJvYcCXm87ouYvru5n0EfBPU9adahD6IJRAAZ4j0XFepcVc2jdpH6NUZhGaxPf0EUYwFoKDVT+737b81Rg==@nongnu.org
X-Gm-Message-State: AOJu0Yyg/ghGg3dy42trlPaGC1v4k9B4g6I4NGS+QujY1MrBs/M2y3V2
 HhT8yLmfwtRCDQnb/4TYZLNsmvrjzjsdzjdRy1gZ5XTya+TT0+4l0Ga4O4bhxw==
X-Gm-Gg: ASbGnctaYwUfzuOhHLyLCHECTVi5VaAgPfhvil/lN0d2Onx8b8zgtsR6snig4gu0vk8
 +brCtEw5XIlympSe06TDNCt2Bg3RueHcF54tQwCEEEPxYPW5ZCFnJ1saYHq7ynZzod8vzCefoOf
 uKSEafzLiTF5sx2HpG7ysVcgpV9uxTCm8nOzI6K9m0lcWqRJBQbWPYAKunNEghKGczblH4CraH7
 eN0ddXdUgDxbOTCiebKvpOb+rDzxuX2tfoFUMsll/j13G+N4BBWl1gdWlAu20ucmMXh+AvR03jF
 HLitf4GN47WUVgjwT22o3yKFcX6TfDbBQT83AEiNW5DYPcnHsCXypYMl20Kt4ovOqU+NYwhGAs6
 QRXsbNwLzru8bC3v50ZbWwYnXLFkq8xYa
X-Google-Smtp-Source: AGHT+IEWycNXEqEmopq8EixwTWTn4xWQBkQoJhPpo4jeqVAyWKapU2YM8AiI4lexRcfYoxOBYQS0dQ==
X-Received: by 2002:a17:903:37cd:b0:234:c8ec:51b5 with SMTP id
 d9443c01a7336-245e04c8f3cmr41111305ad.53.1755627952428; 
 Tue, 19 Aug 2025 11:25:52 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:25:51 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH 35/35] .gitlab-ci.d: build wasm backend in CI
Date: Wed, 20 Aug 2025 03:22:04 +0900
Message-ID: <a5f6cae8c1ef674c0c96ab51af63a1b21e1f306a.1755623522.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x630.google.com
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

This commit adds the build tests for the wasm backend.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 .gitlab-ci.d/buildtest.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index a97bb89714..16a3322277 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -803,7 +803,7 @@ build-wasm64-64bit:
     job: wasm64-64bit-emsdk-cross-container
   variables:
     IMAGE: emsdk-wasm64-64bit-cross
-    CONFIGURE_ARGS: --static --cpu=wasm64 --disable-tools --enable-debug --enable-tcg-interpreter
+    CONFIGURE_ARGS: --static --cpu=wasm64 --disable-tools --enable-debug
 
 build-wasm64-32bit:
   extends: .wasm_build_job_template
@@ -812,4 +812,4 @@ build-wasm64-32bit:
     job: wasm64-32bit-emsdk-cross-container
   variables:
     IMAGE: emsdk-wasm64-32bit-cross
-    CONFIGURE_ARGS: --static --cpu=wasm64 --enable-wasm64-32bit-address-limit --disable-tools --enable-debug --enable-tcg-interpreter
+    CONFIGURE_ARGS: --static --cpu=wasm64 --enable-wasm64-32bit-address-limit --disable-tools --enable-debug
-- 
2.43.0


