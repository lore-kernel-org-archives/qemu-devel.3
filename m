Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8465C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm5Q-0006Im-6w; Wed, 07 May 2025 17:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm50-0006DH-0Y
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:26 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4y-0006G8-3A
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:25 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-736bfa487c3so337715b3a.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652402; x=1747257202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0K1kpS9Htj6z3HAzF9QsC5YDT8+QFA6cpqx/eSHe4Hw=;
 b=UJd4qdzv9/YFzDuHa59HQYQ8iehjxNsYEwjzik+PTVeziIQNn7+/U2byXaNN2OqePZ
 rHLGxNoK3QVDvQypV7fmehzJ98R9N/PwNTGoyVASo0BagamBIm0QxKgbrO9fqWIzuyKp
 q6V4TW8CckqRkeu3l3pgT1JQOWVbQFJu4oJRoAE8Vg+SEM7N8LSLvO4r/3BG/UHo26G6
 3m6IOtGjo4RlMuyh/co8BwuxJFB5iuQyOQ9mUBuAQMgsS0qtb3+y80SYzuZ6NbH7tBYM
 JBpDbahaswlmmgf+jP8znqgsuHnXNnsyeQeH1IMjGa7LipS9a5sUOop/LtvwzUX/LEBm
 vwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652402; x=1747257202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0K1kpS9Htj6z3HAzF9QsC5YDT8+QFA6cpqx/eSHe4Hw=;
 b=Un9/Lx07MERB/WYCEE6Sww6H1mP+3LwByu473tfJtofofsF8w05nWr+tYKat/YFoCY
 bGzpC6BvZ0hGb45dHcCTXQf6uSEStU1njagqjgRr4erE1GtXwhBEz+V7AMG4X15vWpTw
 BOiDgoj8+K1JP406tLRvWKVedbI8DwbeezLDuFkUjtSPg8FKq9EGvDtMNiYM8Cequ7ef
 QxAcZUe1aKjS0piWujpWLb/ynFXz2uM/8ulWVyTRXJHr/737TqcBtfvt9HHLelLqSmsd
 L5FQBFl8lx9Vgxvnd3v6/HH29jDFltU52ojTr8AcBddCqrgA8gfjt2u0lVl4SQzGfJek
 aP7Q==
X-Gm-Message-State: AOJu0YxJse9r/O6we98f374A5av9psRwZ9pr4XSMt8irQTZR3/wGvRiP
 gc6bBXgbdXspVOG1g+PEqXZ6pg3ADCYi84esMVo7s2qkP+090iHc2H3XOl3nK9oGPmF88wIZez9
 F
X-Gm-Gg: ASbGncvByHdVzfwg28mepfz3BJFG01HAIBQWS/poWiDNp2F625i+tDNhELivw6P9M5h
 QBX8b7QcmWlmYMenfwSFrqocr08GauXoL585fgmcFvTQ1IApbMluNig/eXveS3khhYdyZ/WaD9t
 t8ujmFDroRUT9SjXYkrZxQNNi9GWUwZ7ZVRbkoxa8qu7UXDkQY/ViDIroaLRsElPa4ZyCKZSGyW
 uYjGsL/mxgBlzpmgLNOmD5emB63v5hi4++Y2S7TIDWEDd+DExC3kdgX8qxWX6h9adyKurEMplB5
 vHMtL51kYfVezNxAoOcFGTAT0O7bGfsO6e9qmFNLaKyAOTkCojiYCyh7Ik5SXOMbmTl2g1md3hY
 =
X-Google-Smtp-Source: AGHT+IHYYa5RqBCEhr0OPjusLveMSjne/iz0AOt1sJY7gX0G1E5w7Jn2tBodZQNFQ3YbF2xKm5CFrw==
X-Received: by 2002:a05:6a00:9096:b0:736:4d05:2e2e with SMTP id
 d2e1a72fcca58-7409cf46a40mr6978165b3a.6.1746652402613; 
 Wed, 07 May 2025 14:13:22 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 24/24] target/m68k: Implement FPIAR
Date: Wed,  7 May 2025 14:12:59 -0700
Message-ID: <20250507211300.9735-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
References: <20250507211300.9735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

So far, this is only read-as-written.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2497
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.h       |  1 +
 target/m68k/cpu.c       | 23 ++++++++++++++++++++++-
 target/m68k/helper.c    | 14 ++++++++------
 target/m68k/translate.c |  3 ++-
 4 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 8c23d772e4..1b0bb17905 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -110,6 +110,7 @@ typedef struct CPUArchState {
     uint32_t fpsr;
     bool fpsr_inex1;  /* live only with an in-flight decimal operand */
     float_status fp_status;
+    uint32_t fpiar;
 
     uint64_t mactmp;
     /*
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index fe53572542..00cba4d963 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -470,6 +470,23 @@ static const VMStateDescription vmstate_freg = {
     }
 };
 
+static bool fpu_fpiar_needed(void *opaque)
+{
+    M68kCPU *s = opaque;
+    return s->env.fpiar != 0;
+}
+
+static const VMStateDescription vmstate_fpiar = {
+    .name = "cpu/fpu/fpiar",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = fpu_fpiar_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(env.fpiar, M68kCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static int fpu_post_load(void *opaque, int version)
 {
     M68kCPU *s = opaque;
@@ -490,7 +507,11 @@ static const VMStateDescription vmstate_fpu = {
         VMSTATE_STRUCT_ARRAY(env.fregs, M68kCPU, 8, 0, vmstate_freg, FPReg),
         VMSTATE_STRUCT(env.fp_result, M68kCPU, 0, vmstate_freg, FPReg),
         VMSTATE_END_OF_LIST()
-    }
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_fpiar,
+        NULL
+    },
 };
 
 static bool cf_spregs_needed(void *opaque)
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index b50ef6dec3..818c0dd057 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -47,8 +47,8 @@ static int cf_fpu_gdb_get_reg(CPUState *cs, GByteArray *mem_buf, int n)
         return gdb_get_reg32(mem_buf, env->fpcr);
     case 9: /* fpstatus */
         return gdb_get_reg32(mem_buf, env->fpsr);
-    case 10: /* fpiar, not implemented */
-        return gdb_get_reg32(mem_buf, 0);
+    case 10: /* fpiar */
+        return gdb_get_reg32(mem_buf, env->fpiar);
     }
     return 0;
 }
@@ -71,7 +71,8 @@ static int cf_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
     case 9: /* fpstatus */
         env->fpsr = ldl_be_p(mem_buf);
         return 4;
-    case 10: /* fpiar, not implemented */
+    case 10: /* fpiar */
+        env->fpiar = ldl_be_p(mem_buf);
         return 4;
     }
     return 0;
@@ -93,8 +94,8 @@ static int m68k_fpu_gdb_get_reg(CPUState *cs, GByteArray *mem_buf, int n)
         return gdb_get_reg32(mem_buf, env->fpcr);
     case 9: /* fpstatus */
         return gdb_get_reg32(mem_buf, env->fpsr);
-    case 10: /* fpiar, not implemented */
-        return gdb_get_reg32(mem_buf, 0);
+    case 10: /* fpiar */
+        return gdb_get_reg32(mem_buf, env->fpiar);
     }
     return 0;
 }
@@ -116,7 +117,8 @@ static int m68k_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
     case 9: /* fpstatus */
         env->fpsr = ldl_be_p(mem_buf);
         return 4;
-    case 10: /* fpiar, not implemented */
+    case 10: /* fpiar */
+        env->fpiar = ldl_be_p(mem_buf);
         return 4;
     }
     return 0;
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 44c1b3c0cf..aa60480f95 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4674,7 +4674,7 @@ static void gen_load_fcr(DisasContext *s, TCGv res, int reg)
 {
     switch (reg) {
     case M68K_FPIAR:
-        tcg_gen_movi_i32(res, 0);
+        tcg_gen_ld_i32(res, tcg_env, offsetof(CPUM68KState, fpiar));
         break;
     case M68K_FPSR:
         tcg_gen_ld_i32(res, tcg_env, offsetof(CPUM68KState, fpsr));
@@ -4689,6 +4689,7 @@ static void gen_store_fcr(DisasContext *s, TCGv val, int reg)
 {
     switch (reg) {
     case M68K_FPIAR:
+        tcg_gen_st_i32(val, tcg_env, offsetof(CPUM68KState, fpiar));
         break;
     case M68K_FPSR:
         tcg_gen_st_i32(val, tcg_env, offsetof(CPUM68KState, fpsr));
-- 
2.43.0


