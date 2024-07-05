Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F37C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPeVk-0001FC-Us; Fri, 05 Jul 2024 04:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeVA-000079-79
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:09 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeV1-0003EY-QX
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:07 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-58c947a6692so1848524a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720168858; x=1720773658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E9EC0lfXh+UHwj/Mj/Qr0ZvYxRRdaiCBWTot1xCG3AQ=;
 b=loV4adKBgYpJ4yilSrIeWeDN6CUGH/xePzzQUj3ZaZ66SjRTk2BlyyXbrJek9UeW+N
 FDDXu4MhaznDozr2m5+MbFkslJynXmsxSrh0qqpFfH6ayS4j4SCAMA0LzfAUPHrkmngt
 wrpknjpX7osuoKGlCmDFFUQm5Ku3Ds7NifHf5OszstNydP5wHGrgPxSPhttKxKxfR2Yl
 q3pC5rzSpIrXYbbgjczaObNPGdJCycQ5m1GRL2QDMvqIZK+WLrM0LmoibheU/XZCeQAk
 3sN4rDBrkiBhWd9ZOQu/wCaHKN+IeQ5gQooyO8CfAa08DnQ2TbliXAyZawxj7j6jVrps
 EBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168858; x=1720773658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E9EC0lfXh+UHwj/Mj/Qr0ZvYxRRdaiCBWTot1xCG3AQ=;
 b=u1JCmjwARZJ7guwGA6wk9drsV76DRlMOZvteY/wsxrDMEZUqxANcmFAbSIYQL7objM
 gcADfFEEDXbbqQgNWYc8rNl9nbBMA9IUOcnfcGKHHHi1wm4VcxGnpACFFMcoYKKMwfms
 55MEOX+g2Tl+v14kadcqxw+4ELen3zONLY7+jH+6pbrp3SRnnqxRLPyxbK+I+DwmcSmZ
 LX34222hDoeWbmShfie/fifufoO2kBa5L08jmJf8KcEWIFnKYjEgYIDXy6SbZKxTEZNE
 U2zqVgaUJTz9dIPEeplHh5kgeGuhuJEdiAJPWrEo8fG6ubgmcIM74A542jNnFsgIYAqk
 CTCA==
X-Gm-Message-State: AOJu0YxF6N1iBfJBD0T3IyJT2OyVpyQFcMexzp1+rWk/S61/lrSlIbeD
 fa0yYH+iBlSkBhNIA73Lcj+pFCDluIgPIGEeXSSYsPVZF5222CJGnM3DptJ8QfU=
X-Google-Smtp-Source: AGHT+IFPlAe/yeqeeL+QyAkpgE+7BfOeR8amWIqalG4yBuICloPccHsHgl5nfezLRvWbep3j7Ua18g==
X-Received: by 2002:a05:6402:348f:b0:58e:4088:ebd with SMTP id
 4fb4d7f45d1cf-58e5a8e77admr3093639a12.9.1720168857963; 
 Fri, 05 Jul 2024 01:40:57 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58dfd5aeda6sm2152144a12.78.2024.07.05.01.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:40:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BCD8C620FA;
 Fri,  5 Jul 2024 09:40:48 +0100 (BST)
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
Subject: [PATCH v2 11/40] tests/tcg/aarch64: Do not use x constraint
Date: Fri,  5 Jul 2024 09:40:18 +0100
Message-Id: <20240705084047.857176-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

clang version 18.1.6 does not support x constraint for AArch64.
Use w instead.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240627-tcg-v2-5-1690a813348e@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-7-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/arm/fcvt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/tcg/arm/fcvt.c b/tests/tcg/arm/fcvt.c
index 7ac47b564e..f631197287 100644
--- a/tests/tcg/arm/fcvt.c
+++ b/tests/tcg/arm/fcvt.c
@@ -126,7 +126,7 @@ static void convert_single_to_half(void)
         asm("vcvtb.f16.f32 %0, %1" : "=t" (output) : "x" (input));
 #else
         uint16_t output;
-        asm("fcvt %h0, %s1" : "=w" (output) : "x" (input));
+        asm("fcvt %h0, %s1" : "=w" (output) : "w" (input));
 #endif
         print_half_number(i, output);
     }
@@ -149,7 +149,7 @@ static void convert_single_to_double(void)
 #if defined(__arm__)
         asm("vcvt.f64.f32 %P0, %1" : "=w" (output) : "t" (input));
 #else
-        asm("fcvt %d0, %s1" : "=w" (output) : "x" (input));
+        asm("fcvt %d0, %s1" : "=w" (output) : "w" (input));
 #endif
         print_double_number(i, output);
     }
@@ -244,7 +244,7 @@ static void convert_double_to_half(void)
         /* asm("vcvtb.f16.f64 %0, %P1" : "=t" (output) : "x" (input)); */
         output = input;
 #else
-        asm("fcvt %h0, %d1" : "=w" (output) : "x" (input));
+        asm("fcvt %h0, %d1" : "=w" (output) : "w" (input));
 #endif
         print_half_number(i, output);
     }
@@ -267,7 +267,7 @@ static void convert_double_to_single(void)
 #if defined(__arm__)
         asm("vcvt.f32.f64 %0, %P1" : "=w" (output) : "x" (input));
 #else
-        asm("fcvt %s0, %d1" : "=w" (output) : "x" (input));
+        asm("fcvt %s0, %d1" : "=w" (output) : "w" (input));
 #endif
 
         print_single_number(i, output);
@@ -335,7 +335,7 @@ static void convert_half_to_double(void)
         /* asm("vcvtb.f64.f16 %P0, %1" : "=w" (output) : "t" (input)); */
         output = input;
 #else
-        asm("fcvt %d0, %h1" : "=w" (output) : "x" (input));
+        asm("fcvt %d0, %h1" : "=w" (output) : "w" (input));
 #endif
         print_double_number(i, output);
     }
@@ -357,7 +357,7 @@ static void convert_half_to_single(void)
 #if defined(__arm__)
         asm("vcvtb.f32.f16 %0, %1" : "=w" (output) : "x" ((uint32_t)input));
 #else
-        asm("fcvt %s0, %h1" : "=w" (output) : "x" (input));
+        asm("fcvt %s0, %h1" : "=w" (output) : "w" (input));
 #endif
         print_single_number(i, output);
     }
@@ -380,7 +380,7 @@ static void convert_half_to_integer(void)
         /* asm("vcvt.s32.f16 %0, %1" : "=t" (output) : "t" (input)); v8.2*/
         output = input;
 #else
-        asm("fcvt %s0, %h1" : "=w" (output) : "x" (input));
+        asm("fcvt %s0, %h1" : "=w" (output) : "w" (input));
 #endif
         print_int64(i, output);
     }
-- 
2.39.2


