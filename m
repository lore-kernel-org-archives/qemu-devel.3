Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B07C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 14:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH1pv-0000Q8-5n; Mon, 19 May 2025 10:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH1pt-0000PW-G6
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:51:25 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH1pq-000126-OZ
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:51:25 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so48589505e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747666278; x=1748271078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rLeYSMExit9M+e09aBWpDZdYMYM/Zp11cwRyipN7UwE=;
 b=wKtJneHTpyLwrZBJTH5+ZXz80iwBpTjEsZUYyRziJEMFfve8d+LhemRsV8DTWxXMH2
 rzDviQ54feealtr+cndcQYbkXWWse7p+RMgUopT9ng/N7P/Px5mRvUJMAIxFWZ9v5NP8
 rcImycuW1usLWYRlYec2Q3YRwCX4HbgaqhXlFx1aEcQrzuXWcOHqfC1C55hQjoqkwJGu
 xD0bo71jl5WBAHbgXLJei3+04dAIdIKOI2Q8MAYyJje2gEe5sDhIOP3Dba8gJR8P32pL
 k8t5nmrQKfdoY9u2Pxzdvkheez4Ywcf8f7G5X1lizUPNFAsFwoyDyt1betaZa/flaN9Z
 TqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747666278; x=1748271078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rLeYSMExit9M+e09aBWpDZdYMYM/Zp11cwRyipN7UwE=;
 b=I8YaB5eTGSg2zee5+MCeVizmE6UoGZ4yOAEpEx3fwtWKwDvb/KHxxuY/aZgei4KzoO
 wsHOob1ce5c3Ft5eukhQKOuMZB2jIp4mP0pjahm3ZIX5JKes9psWQR62PMotmi1d++U2
 4m/zpcPMKHsYqFkkBncZeu36UMkVSDFqqm0D5WXtJPboVGEIzxgqguT3ZA9rhkimrNrp
 GIUoA4ZtbYIfNK190O61NBPniH/ES4/I/jg48UWL8+wdK44C1Aw9rEm59SNanJBDWjHD
 SnwSjKFdt/WMw85z6eKvfGpXv9TpSUbhDxEssAAytBtFnXMaLyninXJIjyTEpTbVwLMd
 wB8A==
X-Gm-Message-State: AOJu0YxqNjuSpDE19RD079Fv+te5mKixypILYihgl+Ww3yv34rR0xw72
 8R2ARedSKRJuFtLYiv3n2XfkbmR6r0vV8uH0kJyU6XRS0BvkuO3khvsJg/M0uGppOWOsul8C8Kr
 /ZA+T
X-Gm-Gg: ASbGncv06U9NfX5tzdKQjBeFApmIZG5xemLlMkjsuIadOnpjSWaVHZZjSrv4D5NZ5Yh
 zWjA6llNojo/zGofA5gxWKMWDsLT9hrCgn4cohtY6/cwQZV/JTIr7fL+gUMcYdfqHO5pi9a7/Yv
 gKK4q5bRDF5pbQw0OS4A+uOVUp6uYSnYIvbhfyhErFxgASoclpS2BF3PKlSfYaOX6sRmxN3IhZO
 tsaaKSegb508+MJa7CMkW42INjoZMrwUnS2PJ41Rmn3is1WYvwF3k6AzHoF8FrtMb1L7rkeGkWw
 HIhBag52XiawfR7O9tchM9nZ455Z2h5EekdorHHI2Yfp8xBaKQBXdNhuug==
X-Google-Smtp-Source: AGHT+IHtYZK6pZLdZE0fhDdTE44bP59UvutwMINzbtlcp7w4Twgt5lSdGxc1HMg7MONOOY4kKl1eaQ==
X-Received: by 2002:a05:600c:a012:b0:43c:e70d:44f0 with SMTP id
 5b1f17b1804b1-442fd63bfa4mr115504035e9.19.1747666277757; 
 Mon, 19 May 2025 07:51:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd50b9b2sm145672035e9.12.2025.05.19.07.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 07:51:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 1/4] target/i386: Detect flush-to-zero after rounding
Date: Mon, 19 May 2025 15:51:11 +0100
Message-ID: <20250519145114.2786534-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519145114.2786534-1-peter.maydell@linaro.org>
References: <20250519145114.2786534-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

The Intel SDM section 10.2.3.3 on the MXCSR.FTZ bit says that we
flush outputs to zero when we detect underflow, which is after
rounding.  Set the detect_ftz flag accordingly.

This allows us to enable the test in fma.c which checks this
behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/tcg/fpu_helper.c | 8 ++++----
 tests/tcg/x86_64/fma.c       | 5 -----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 1cbadb14533..9ea67ea76c8 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -189,13 +189,13 @@ void cpu_init_fp_statuses(CPUX86State *env)
     set_float_default_nan_pattern(0b11000000, &env->mmx_status);
     set_float_default_nan_pattern(0b11000000, &env->sse_status);
     /*
-     * TODO: x86 does flush-to-zero detection after rounding (the SDM
+     * x86 does flush-to-zero detection after rounding (the SDM
      * section 10.2.3.3 on the FTZ bit of MXCSR says that we flush
      * when we detect underflow, which x86 does after rounding).
      */
-    set_float_ftz_detection(float_ftz_before_rounding, &env->fp_status);
-    set_float_ftz_detection(float_ftz_before_rounding, &env->mmx_status);
-    set_float_ftz_detection(float_ftz_before_rounding, &env->sse_status);
+    set_float_ftz_detection(float_ftz_after_rounding, &env->fp_status);
+    set_float_ftz_detection(float_ftz_after_rounding, &env->mmx_status);
+    set_float_ftz_detection(float_ftz_after_rounding, &env->sse_status);
 }
 
 static inline uint8_t save_exception_flags(CPUX86State *env)
diff --git a/tests/tcg/x86_64/fma.c b/tests/tcg/x86_64/fma.c
index 09c622ebc00..46f863005ed 100644
--- a/tests/tcg/x86_64/fma.c
+++ b/tests/tcg/x86_64/fma.c
@@ -79,14 +79,9 @@ static testdata tests[] = {
     /*
      * Flushing of denormal outputs to zero should also happen after
      * rounding, so setting FTZ should not affect the result or the flags.
-     * QEMU currently does not emulate this correctly because we do the
-     * flush-to-zero check before rounding, so we incorrectly produce a
-     * zero result and set Underflow as well as Precision.
      */
-#ifdef ENABLE_FAILING_TESTS
     { 0x3fdfffffffffffff, 0x001fffffffffffff, 0x801fffffffffffff, true,
       0x8010000000000000, 0x20 }, /* Enabling FTZ shouldn't change flags */
-#endif
 };
 
 int main(void)
-- 
2.43.0


