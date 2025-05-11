Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2342C3ABCB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDPG-0003d9-1M; Sun, 11 May 2025 16:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDP8-0003c8-UP
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:11 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDP6-0006Nb-L1
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:10 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b24f986674fso1688804a12.0
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995767; x=1747600567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eB0y8IYFZ8K+Qjx0npmrme5ZHhfgZxp81sJx7OrLsFA=;
 b=FAhLoc43yuZNHeE7skAzN8hibF7GVtWeTZmEGBsv9iNVArlZ5msf/CJMapc6gbrfLs
 OLIkupA7PctBAgHfBLE5u9+wRO8i+mUFA7uupppjzSpImQ0vO/0K5htTgERTQCZL09LA
 72lKIGeNIpGjuwFxkYas9dy3FPFOYDyDSe2WKbIZWTdmuNLM9GusSVEXLU97+sVPYVpF
 F69XlAdGcj+HFsdKSH0j4Ji4wVNpmt/5L7r+b8EFItHEarhgTYL5sn/kbDv2DLKhYLWL
 3RuHzmCumkq40IxdoLGuZbLsRRqxxHfH3lUT6n24GYYzaMkaauV4mzAqMlSE0X1tYrYa
 ohEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995767; x=1747600567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eB0y8IYFZ8K+Qjx0npmrme5ZHhfgZxp81sJx7OrLsFA=;
 b=Z47yB9KEv2Naz0zt935NPehEGHopqKipBALdZvW1MM+wps/wjMlmpLCVpee2H2Qy4+
 CU2pNY1YkQj10Wbj4gafxs2/ZlAqAGceU6CcN689G5kPmN5ki8Ccm3BQ+f524S1ptGAz
 +D7u913JhfUQKR2d0ckgk8TDphQQkA5ZNOGHV2kYuSR9I4zCAZwosyPF757/Grzqn4gw
 +Vzznw3wTys5dIce/pHc2uMTYk55r1uqWDXvh6fZqqyDqFWl4hHTU93P8ehdkUEkydvW
 JX+iXXwZQX8E1C1xaJySjcRQdJo7k+tIBMYSZ44k6yUnl4akYMFlljAE6oaLzSKmtVMy
 Q6rA==
X-Gm-Message-State: AOJu0Ywb2Wif8uMJw+oKCrFmWe7jqBsaEQe4iFz5cSitmGsjljn3BeCN
 rfvjSlDh6U0X3p6haGMO8aVjc0hZSCKLiF+liwUtzSR+tyvstH1QhSkglwcObW/KOaWUiqP4rdu
 Z
X-Gm-Gg: ASbGncs6nwYNwzZvfXYFiDIrjWPcZUDzrVkwRV8a+Im2tvMytvn79rD9ut8Ws6veufw
 HL3r1S2be841OXqfVGL1WNiSIbpmdnB5SZ8O9XXk4yyjX4rPLdr4xudagj2JbIFj06hnqAylZMe
 6D4Oi07gqRz9ECcQVPcGYO8fxMECgcCKIVAT0guy4zPrXcH9RwGtY8rhoK46ZTC4xSl7djxDR+M
 nyWxJIG9uQYVb5SMBKqLqNTKuCv1P+Vdwuaj1A9AdTdKthjh1EFfn7Tux2f8pQMqwwd6LfbhoTX
 psK6yFnTIJtHJ5ufdDbSEaQifNsCQfGimwhZbsc0wV+f4Qnp0TOIvIjcyhhvoUydYiGw+jrYsEw
 cZpxQ6y7yTg==
X-Google-Smtp-Source: AGHT+IHSlxmLAgrIxgVc2cz7g3EhJYeKU9Y9s2D5Tna4+io4Rj+ZFpkyMjiKoD23UxwTIqdWhqJ7vQ==
X-Received: by 2002:a17:902:da83:b0:22e:4b74:5f68 with SMTP id
 d9443c01a7336-22e84790b02mr234446875ad.19.1746995767379; 
 Sun, 11 May 2025 13:36:07 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:36:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, schwab@linux-m68k.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 24/24] target/m68k: Implement FPIAR
Date: Sun, 11 May 2025 13:35:46 -0700
Message-ID: <20250511203546.139788-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511203546.139788-1-richard.henderson@linaro.org>
References: <20250511203546.139788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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
index 77ed496ab4..baa2e035a4 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -110,6 +110,7 @@ typedef struct CPUArchState {
     uint32_t fpsr;
     uint32_t fpsr_pdr; /* live only with a packed decimal real operand */
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
index 49c9d4e870..07d1812deb 100644
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


