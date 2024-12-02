Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2A9D7831B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6P7-0003j5-AQ; Mon, 02 Dec 2024 08:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gb-0002LQ-UU
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:16 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GQ-0003Qj-SW
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:09 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385dbf79881so1912459f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145283; x=1733750083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TSWsGbiJd5nUa8W+i0kSSd0cIwA3gG9T6rGPFTmCLJc=;
 b=WnjytF3NooAy6XpfmW7L2oLdbLXngZbkxTBTDzsTFiQ9KHcf0FG1TL9cUcamg7ERFF
 3CK44fQMvE3c0ggWYjzCCJ9LeNcIW2Aht2r5814oStVZvWc0HuZsTTMl9S2ZIPIHIW+S
 pa/wwYO9Zn88mxZ26/c7I1IJlrzbl2DxZFpWHoCOxcrjQNFjkmCJzjHBayUcyWhF4QhK
 NZqPSFEyZnJZSdA6Y0BufzPDSktA+Kr7GSiWap4Tk10fGZ74XgahgvHUmA+pVh7cbJKP
 40Bn7qscr8euYwGBiXGw/pdFqASeD6biQQ54gp/GCPBdnFC9fjpAwpd422T/VaOdw7IX
 /Qcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145283; x=1733750083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TSWsGbiJd5nUa8W+i0kSSd0cIwA3gG9T6rGPFTmCLJc=;
 b=LAC7LZ59npCq92Bp8fCMKLcsakzIJ8/3eIRSOggq09rHvhHWjgDWsnQKdf6LfZoIG6
 /pOHorCBN8qlBoukSc2BLEzLj8TK85R8AG3scSdn2nL8GfyzuzS/TLvbC9Ol8KRjDG2D
 bdmE65LrKvUYviXvSA6EbOQ7Do5kAufJzwJ7WvPYesokBHy/7m9FG1FTsvzKgrlhEyMn
 gVjzT20F/29PiHsFF+scN+nBCV905EmzPpo7Zz0EJpttgkKJ51CudnfJQhSbWt2o8qjK
 wNIb18HwFfop9xQmoVkzI3mPkjwtd8qusy1hExdKkP70S0WSFzvESbw7LSq4VM0Piw5i
 Wquw==
X-Gm-Message-State: AOJu0Yx4+redSRBU/jV2FPU7h+MU/VUCMeumpE04CDsqJY5AkOc9X/sL
 KSIx3bx0LugQrNxcBGc2x8FH7czGNjQZvepsJe7oCUEzGJqf/lAMRXryzO3RFgFqcz62xjDJ/un
 N
X-Gm-Gg: ASbGncv2GkhF4kbOSMBefu0VB/nXysL7yIlPfpNNwW6ZnGyV0RmrrPJDRCMjRCK84en
 jhRn6ev0OGhJzY8Wa/sWWNEopU7d6EkMprZHTDq2LlmJ9B2kOJUt4Kn2tKjbcBMF7D4rWKwBP0f
 J1JBLzdFHxTBtNTeNm/2APf7ep70v2QbHXb7Pq2voBuhe3/TyDwmbP8eCKCMOlXsX5pk3FnaoUg
 jGXRsoWwqlOTxdh9KP5iO35dJLPEqzvDWpwZlkaO/gH7qyjocwTBwo=
X-Google-Smtp-Source: AGHT+IHzTpNXZ1PtLUb9+17YAW4kTnA3P4qTzfTKsM34d7nTquK7UvQdp/L/vYqNNTGHVlb3JeXnhA==
X-Received: by 2002:a5d:5f92:0:b0:385:e90a:b7de with SMTP id
 ffacd0b85a97d-385e90abc06mr6148162f8f.5.1733145283390; 
 Mon, 02 Dec 2024 05:14:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 37/54] target/i386: Set default NaN pattern
 explicitly
Date: Mon,  2 Dec 2024 13:13:30 +0000
Message-Id: <20241202131347.498124-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Set the default NaN pattern explicitly, and remove the ifdef from
parts64_default_nan().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/i386/tcg/fpu_helper.c   | 4 ++++
 fpu/softfloat-specialize.c.inc | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index c8bc5b7cfb3..e788fcd1b25 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -181,6 +181,10 @@ void cpu_init_fp_statuses(CPUX86State *env)
      */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->sse_status);
     set_float_3nan_prop_rule(float_3nan_prop_abc, &env->sse_status);
+    /* Default NaN: sign bit set, most significant frac bit set */
+    set_float_default_nan_pattern(0b11000000, &env->fp_status);
+    set_float_default_nan_pattern(0b11000000, &env->mmx_status);
+    set_float_default_nan_pattern(0b11000000, &env->sse_status);
 }
 
 static inline uint8_t save_exception_flags(CPUX86State *env)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index d77404f0c47..452fe378cd2 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -139,9 +139,6 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
 #if defined(TARGET_SPARC) || defined(TARGET_M68K)
         /* Sign bit clear, all frac bits set */
         dnan_pattern = 0b01111111;
-#elif defined(TARGET_I386) || defined(TARGET_X86_64)
-        /* Sign bit set, most significant frac bit set */
-        dnan_pattern = 0b11000000;
 #elif defined(TARGET_HPPA)
         /* Sign bit clear, msb-1 frac bit set */
         dnan_pattern = 0b00100000;
-- 
2.34.1


