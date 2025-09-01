Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DB8CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut33x-000745-Fv; Mon, 01 Sep 2025 07:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut31v-0004Cu-1k; Mon, 01 Sep 2025 07:48:59 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut31o-0001xI-I0; Mon, 01 Sep 2025 07:48:58 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-24abf0215e8so8982865ad.1; 
 Mon, 01 Sep 2025 04:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727323; x=1757332123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oCoav4mrpfqHaiFY4ajN/hsX2ml/OjgBByRUO4LMbYo=;
 b=WT70pG7X7/DRAKFq3fnlIsfRev1wDgayeN4HVVpACNY5WWQMCAp7FG0Mvvy3LoVAO9
 qZ6BL3FliVQH9Z49TZEsKO9A2OexydyJx1sSmhXDBpt3OZpc7r++PebCdfLmuxvEzJ+U
 yjWPQ8ZBxZZ6oLRJTyq4t+oUCRJVA2FqF7eNtQXSpqfqz3PiU3J38fduAA+W451ot12+
 o55P5Gs7BRk9Bg1tY8FxTuv6c2n+MgEv8OaX8tzLLkn0tI+13AwKXmlCMALT9TTi/Xxe
 sEo3niZYTWTZA5GfG450akzeMclf8Vjqa8ZKoZboQfdxPlBIspL6eUQ+nN8d6LJHAFm/
 wTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727323; x=1757332123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oCoav4mrpfqHaiFY4ajN/hsX2ml/OjgBByRUO4LMbYo=;
 b=ZiSzv9Ca7J1TGzjOvAgUbFhbGvM1wOn6ft4SmVIJcJRY66PZ56wgxjdiWQ1YT/dXdp
 HEL5GUHuKDhpxUBs2Qk+B+9dmgVAzycs85L/cHN0Vro5VD042MBh8+8f5G3ol4INy18d
 gQ/9KUxO+HS2TmPFLOyoP/Z0qEVVGXATGhCBhhPOgklwASVeV/P6KA0uCIIrIZzrgq0X
 Khh16bclMZhb5Q+wf1nNVy2NWsnztW4UO7Eo7hrARfWxdqT7qcBAhAWOEhSYLhvuDhwx
 5pQ1D9/lxAWgUjjAegsbVcqO0IamGsf6arMNSB3VOx9ANmcq4f8cX/PJqz3rlp8x0u3T
 406w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoN3PGf4DQGFNVG56yhPulBMd5qLuQfE07IUOQAz8sWbveUq/kPRHmSgpzgDWanrIUKvg3HG78pZc/Qg==@nongnu.org,
 AJvYcCWx533ojmyOqj+5wUVGuhh2M2WvgimZUQBRAApUxj0RH6tZ2x/mqsqXuq8BzqhizmD6nWTRyp+BSg==@nongnu.org
X-Gm-Message-State: AOJu0YwXDp14Vbj4c0fpfmLAbVkBG/v6Q3BjTMwwMcD70GSjBjkx6kjr
 woLncn6ZD6B8uJ0io57qlRF0eVHoakLmUlYvL3GiikJCEQ3V0koboVpSrnId+A==
X-Gm-Gg: ASbGnctOqX40vbWwSdBJk7C51lLW2WjxHdHcraG/jqeOgrFQAqOPlTb8Vev7eQjAcEw
 lxaTgMYQvbUvyVXKSLhNLTGz0HcJNml55u97WlLMdzecri3U0CbN6PqGepIJwMoD5jRuiMD174l
 IuihoQ3KpQX8eEkrj58FYd7zIBqFdniz653Prf270biCgc9vcj9WUUvpjHILmOnqqE9jLHmxlxj
 Mg5sjJhWngZcH6hty0SC/HdUiFmk0U/HwXuAvekxrIg8cCjuzMfsUe8vQ2NyMAGPmrczH7+QSSQ
 A8ckUfafpQVuhCajbIYuphu0MS9Oq/lAdrpN/WSuwmPw4CLjmnTTmmVMhTG1dGKP4Ehqh3NClWr
 5QgNQLyWv2OKCs6AqQD7kJA==
X-Google-Smtp-Source: AGHT+IGBuKo7oc8jEgSjGF83e8jdS2ypBE6voQc1b4u6zfd+jYJdQPYmrsSnDAf6fCCLCxvmT9JGqA==
X-Received: by 2002:a17:903:2c0e:b0:246:92f5:1c07 with SMTP id
 d9443c01a7336-24944b01822mr81547615ad.51.1756727323340; 
 Mon, 01 Sep 2025 04:48:43 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:48:42 -0700 (PDT)
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
Subject: [PATCH v3 35/35] .gitlab-ci.d: build wasm backend in CI
Date: Mon,  1 Sep 2025 20:44:37 +0900
Message-ID: <cfa10fb5386f161cdf136ec0aa1e0360e429ad47.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62a.google.com
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


