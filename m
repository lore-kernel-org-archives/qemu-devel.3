Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B8AC3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPeVr-00025n-LA; Fri, 05 Jul 2024 04:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeVD-00008Q-So
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:14 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeV6-0003G8-F3
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:09 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-58b0dddab63so2217290a12.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720168861; x=1720773661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+3mOXYCWAbpqiQ1tZVqIs8ST0t41HILKCllmhwUlz0=;
 b=VuNa4C+yO8VDHGIIv4NZAVoT52HoQePQYsJdsnkQMoQB94Ju0wp1jpas3qeHjkpvQN
 9uxg80DGy5mrcc7fLZVibqDAySw5Pxjq3MY2XXT4ENEZ17WCu1ma1FZ4t0eB0dbqD514
 3q9Cufmy0GblpyyGlCT/s+jbxQNticVquEjPeouGM68zyLdvLvNmyzfCl1azjAXlmY31
 nEI+orXjWJJThLV36/2PxGBCpdaUIB6eLDqFErtup90eoCzfYxh0IbsmYPmOHSz/uCJ1
 IHxDnKzgNJ2dpNYXHVJUFA4M1dgFcHs7m9vN6RpBfH1+Fy3+55kCPEWzc/nX2dLqwCPC
 LzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168861; x=1720773661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G+3mOXYCWAbpqiQ1tZVqIs8ST0t41HILKCllmhwUlz0=;
 b=C1PlQhUB1T8/xh4Jv8gwWWXyKPlH0iGd8teZI5EP9JoF+oQ4xswLbz9N0JWKRwoyHQ
 cCqD4MF9ng0EMu2k9jOaY+ySEMa1norLJQJ8nT90gLKASqVxTs3Xu0y8SAAqQmTMuO91
 quwHUq6QrabrJvFdvchRfALqyCz04AWZxfM3rv/OGpXFxaOxx6e9iULEP0CKuPEro9NG
 sok+q9mbioI593Qe+72lLAjddpxjKCKEPGUOGihGqYvQc3fWIITDbNZCT8KELaA3P/Yo
 02A4jExScXb7tMFmulwEzxTVJMfCGEc42VWo+CaYVZi8m6iJDpTCy9/89MVk5L2hcqiE
 +lSA==
X-Gm-Message-State: AOJu0YwxJztpu/+JjNAu+oRFCyAX6SuNxdqhf/uL2oIs/EwIMzOH8uup
 J8vmZZ64xOPCghPeQh9rhzOM7Vh9MJ57O/HhWy2HZfMngsS1BS61ipVOxmwMOhg=
X-Google-Smtp-Source: AGHT+IFUk21V9WaKAhy3u46esCrErFQFDlsrV/K8Wyas7k8aBlqWhTjlyGZIuHcKZler4Kxab1gx7g==
X-Received: by 2002:a05:6402:1254:b0:57c:7ed7:897a with SMTP id
 4fb4d7f45d1cf-58e5c824ea4mr2469260a12.27.1720168861392; 
 Fri, 05 Jul 2024 01:41:01 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5903c7ac61csm58765a12.4.2024.07.05.01.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:40:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 487E76211A;
 Fri,  5 Jul 2024 09:40:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 16/40] tests/tcg/arm: Manually register allocate
 half-precision numbers
Date: Fri,  5 Jul 2024 09:40:23 +0100
Message-Id: <20240705084047.857176-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Clang does not allow specifying an integer as the value of a single
precision register.  Explicitly move value from a general register.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
[rth: Use one single inline asm block.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-12-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/arm/fcvt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/arm/fcvt.c b/tests/tcg/arm/fcvt.c
index 157790e679..d8c61cd29f 100644
--- a/tests/tcg/arm/fcvt.c
+++ b/tests/tcg/arm/fcvt.c
@@ -355,7 +355,12 @@ static void convert_half_to_single(void)
 
         print_half_number(i, input);
 #if defined(__arm__)
-        asm("vcvtb.f32.f16 %0, %1" : "=w" (output) : "x" ((uint32_t)input));
+        /*
+         * Clang refuses to allocate an integer to a fp register.
+         * Perform the move from a general register by hand.
+         */
+        asm("vmov %0, %1\n\t"
+            "vcvtb.f32.f16 %0, %0" : "=w" (output) : "r" (input));
 #else
         asm("fcvt %s0, %h1" : "=w" (output) : "w" (input));
 #endif
-- 
2.39.2


