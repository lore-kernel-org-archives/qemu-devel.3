Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D08AC3ABCA
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm4l-000697-8K; Wed, 07 May 2025 17:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4j-000680-0w
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:09 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4g-0006Bp-Mb
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:08 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7376e311086so487283b3a.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652385; x=1747257185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8nCjOAsJJrs0cOllpEn8wbCHdD6i2qsocFmc3YVZlU4=;
 b=rBQXb/SKG095ORWymdIrSUEWAnvSAamVyARVgWSdD4Z8SaSWdVkcQhTLEd/1gACQTG
 d9R/5+cz2XmvH2NDvNoRSZaaDOSBAGgNJLR0c0pYRGm6cX4SCaEo5i54GEgmsfNwAwVY
 fcv18F5SkzMRZsutQgim8vpQKfY2edbnxWX7Sde6p8CrYrLg0YrUNkVH+ecgiZkgGlyr
 H7bBkQ5HZSW0Kn6s5yXp/3K4z96kruG4NlfHq/Z2cr4uhvYT+wL2hLJxUwDZ0unveA9l
 LUQYKCWGi/z8ue3743g1St35j6ZS+bQsphNXxgax8QgXTAWoIUk3ArkgKSuBADHZynvZ
 OgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652385; x=1747257185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8nCjOAsJJrs0cOllpEn8wbCHdD6i2qsocFmc3YVZlU4=;
 b=UaCGqUPhf0gbqps/fwFsPhGsmmZMrXZcnwFsn7IvTgoAHMhmn/K1fatyly/hXxLBAt
 oDHroYzjwov+sim+5hk3qhvqPUDGVdU6DEFg4IZt6fDb1VzZQz2hDil2Jrd9fF+D9yHh
 tqZiux0NKS1c42h/jZdOAanYFwaWOzkyg44NOCdBNfG4LKby1njENsmXbD3vIzW7YqI2
 FiDd91p/hU4LmRlITTp5jCTPK4NI+iAvBl8q4KQ9DPK8WpPxUGYR6R/KNFJ39e554X/o
 rtIeFzuvYqbrJzbtiEIcfCEiCZdTYVG3fguWQ+xMXLXJid/TjgmI9kf+C+P4AQqjMhwO
 ytxw==
X-Gm-Message-State: AOJu0YymB7wl+XYP8r4Worz82leLfIDKc+jTmdjTnKxgyGBlM/GD3lnG
 T4SJitX4YFP5T8K6e9LJDJPfJ1H9IxZROlmxI37v9bsi/s9M9X4tnfyVg4vYOLSQnzTRZVn0Sth
 T
X-Gm-Gg: ASbGncuk1xH2unslXRIJK4GIorwbbv2i8PFQ4GstznOqtFuSgkrkRXG+6uoyjw4ufKa
 eC5+hvk1Atwk7tGT7kfDc2ZidFjk06+3IGC+60/GrVtTvgFGn2dlF0onkouOUY5Wi5vkYstfHet
 /v9IxWIMapegnJWxnycMKUa8wlYDfPgZ0q2xUc42YQvTtyhDRkWxhk2adEa3fnxKoEZaas3OH1h
 e5keOi+ZiitBUVgzfRPs8xyIdVr5SmotJ0wW/ElW6/nbDoMsHmDK9BOrPafpwzuPCXP7GTF/gHS
 Xs22QUIwB2lNR5WjErP8SFRsvSNhpBgLWs5wEHOKWBOYym9iceQKI7Vgl3KXm3zkQffPwEMtbCw
 =
X-Google-Smtp-Source: AGHT+IHTzonh8eSgk6q1pRaJELm4DYlU5OdW8XraetzZOQh1nH23qQskmRAYYgzeKdvZ7kMW2igfhQ==
X-Received: by 2002:a05:6a00:448a:b0:736:692e:129 with SMTP id
 d2e1a72fcca58-740a9a7205fmr1277948b3a.24.1746652385336; 
 Wed, 07 May 2025 14:13:05 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 04/24] target/m68k: Update FPSR.EXC
Date: Wed,  7 May 2025 14:12:39 -0700
Message-ID: <20250507211300.9735-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
References: <20250507211300.9735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

So far we've only been updating the AEXC byte.
Update the EXC byte as well.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/fpu_helper.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 195281f118..deae94b0ee 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -168,26 +168,28 @@ static void update_fpsr(CPUM68KState *env, int cc)
     uint32_t fpsr = env->fpsr;
     int flags = get_float_exception_flags(&env->fp_status);
 
-    fpsr &= ~FPSR_CC_MASK;
+    fpsr &= ~(FPSR_CC_MASK | FPSR_EXC_MASK);
     fpsr |= cc;
 
     if (flags) {
         set_float_exception_flags(0, &env->fp_status);
 
-        if (flags & float_flag_invalid) {
-            fpsr |= FPSR_AEXP_IOP;
+        if (flags & float_flag_invalid_snan) {
+            fpsr |= FPSR_EXC_SNAN | FPSR_AEXP_IOP;
+        } else if (flags & float_flag_invalid) {
+            fpsr |= FPSR_EXC_OPERR | FPSR_AEXP_IOP;
         }
         if (flags & float_flag_overflow) {
-            fpsr |= FPSR_AEXP_OVFL;
+            fpsr |= FPSR_EXC_OVFL | FPSR_AEXP_OVFL;
         }
         if (flags & (float_flag_underflow | float_flag_output_denormal_flushed)) {
-            fpsr |= FPSR_AEXP_UNFL;
+            fpsr |= FPSR_EXC_UNFL | FPSR_AEXP_UNFL;
         }
         if (flags & float_flag_divbyzero) {
-            fpsr |= FPSR_AEXP_DZ;
+            fpsr |= FPSR_EXC_DZ | FPSR_AEXP_DZ;
         }
         if (flags & float_flag_inexact) {
-            fpsr |= FPSR_AEXC_INEX;
+            fpsr |= FPSR_EXC_INEX2 | FPSR_AEXC_INEX;
         }
     }
     env->fpsr = fpsr;
-- 
2.43.0


