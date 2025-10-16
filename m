Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED45CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9N0P-0007qs-DB; Thu, 16 Oct 2025 08:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Myg-0005JM-9K
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:21:07 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MyX-0000Ri-E9
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:21:05 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4710ff3ae81so2448555e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617250; x=1761222050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X0hecABaafK0vF9x0erCceRCxICG3VqMKXs6qR+pYEQ=;
 b=bIRSWi3mbnHx8ZlaXvII5Qiih9SPWehsQTF65CFgqHkqJ6CK6C4oBe4G5aJCoEXBzL
 1CEfoSrauQXwjAOX5kHOR0Ac9ZpOqpu2WUpVZBO0pJTmWGamPoBzCXhJIGRgHfEDySxj
 iMSBO9MZI+bT0TrL01l1gQZekL5BWLh7GVTNhM6fxy2Lildy/lkUvBbtRWFs39eIfh0B
 t9sMBbrrRazeqzCj+V7JhJQu9IQdqlqX9NAY/rmYdRO5hICw2TFz24sMmpYTWLrXY4C+
 olNR4zKedjPooGX4sy3gucQFfI+05Vq0DKXYc9GjDOLDnKTEoIeHGxzc4+bkN7QNcvME
 v/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617250; x=1761222050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X0hecABaafK0vF9x0erCceRCxICG3VqMKXs6qR+pYEQ=;
 b=NuoksFiMEhUo+oJ4mF0VNbBevgnqHHDRVPVJjR2QOypkolLTRyYD/+GxK5cN7b+0/4
 e9bsuhGZ5g1np2dc6tScsYzmgrj8l+Uq0eZaL7lHPrZujNdgQVfdkutnbwHt9LcxTjRB
 2SIVvzDv6XImkNyDvxSA6YPF2gg/PG+s9/piosMpXvlREXy66nKwqOCvCU6Eqg79oOV9
 Lmw/xQsov1PHGUZwomv2m8nEHKrC0kR3Dcay2/gpXPubIulgjoYLCdP8EwVjhGLhS0Jg
 LUYexPsDl0CW88qXKbkd4Y2fswVnUy4/rITAUthhGnfT1awN0681izaG8tLF4N2qxRKp
 VQlw==
X-Gm-Message-State: AOJu0YynuYkYJbLMjr1UBU4O+0cSW7eF/tVGdZoraprgVQToR2kdIJF3
 hawYoNWG7rILdxRM8uIk3dqDpJ0+S/no1avMmg5eWIuK0fJfV1MkQzB3RRVOrZillfXBzCOTw2M
 RnkQIuBg=
X-Gm-Gg: ASbGnctmNMCjA7e7Pak8T7Pp1MDjL0HFs0yn8WCH76usMz4mzkOishs2jun4OCCcxkm
 AN1zBYunA+G/WxL0CoL6u853x/4RVIMWu8nigfAHP7uD7sTKOOHD++EWjkXCsjjW3tp4Uj8KyZ9
 J30dWVp2mDxeBUqFWCawFx6TPX5ilGlVEHo+cL4ERJenJ079kINDJ3smXhsm4Q7NVqUA/+eD85p
 Hk7rmQpOaCiQAoJkpOsvcuYWRFde9+/y7hkPQ1GKzmfYGbzi/XcJldSBleXdJM0ViRWDX+TLLOr
 5A9tUhcv7BYbwchLS9q2uNzajg1DdJtetcpQwYdJU/RgkaNSjg1V7p2z3XeL88YCdVFoCHXJ7sF
 8aeLGnrYdR/8PSLesv7QvhDTF56ld1KIMCGztoNSS4gMffnJ2B5ZbaDimcrnHw00uXAGv22KomV
 0H+HT8UVIoVVKl00LJL0/Ta6JOAZjv4cIeEYLbtmaH5HrIqWXH75iUCA==
X-Google-Smtp-Source: AGHT+IEjIuut4mWWFz9LqEAmxCDLNPXecBC4UZW6rVxRkNq18Tu8zbGeo+zqy76MBmE+/6wRbZqPUQ==
X-Received: by 2002:a05:600c:3e06:b0:471:d13:5762 with SMTP id
 5b1f17b1804b1-4710d135821mr22285635e9.4.1760617249608; 
 Thu, 16 Oct 2025 05:20:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710cb36e7csm21806765e9.2.2025.10.16.05.20.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:20:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 68/75] target/tricore: Pass DisasContext as first argument
Date: Thu, 16 Oct 2025 14:15:24 +0200
Message-ID: <20251016121532.14042-69-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Unify style, always pass DisasContext as the first argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010052141.42460-11-philmd@linaro.org>
---
 target/tricore/translate.c | 72 ++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index ef3653b8820..62a2d807266 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -226,7 +226,7 @@ static inline void gen_offset_st(DisasContext *ctx, TCGv r1, TCGv r2,
     tcg_gen_qemu_st_i32(r1, temp, ctx->mem_idx, mop);
 }
 
-static void gen_st_2regs_64(TCGv rh, TCGv rl, TCGv address, DisasContext *ctx)
+static void gen_st_2regs_64(DisasContext *ctx, TCGv rh, TCGv rl, TCGv address)
 {
     TCGv_i64 temp = tcg_temp_new_i64();
 
@@ -234,15 +234,15 @@ static void gen_st_2regs_64(TCGv rh, TCGv rl, TCGv address, DisasContext *ctx)
     tcg_gen_qemu_st_i64(temp, address, ctx->mem_idx, MO_LEUQ);
 }
 
-static void gen_offset_st_2regs(TCGv rh, TCGv rl, TCGv base, int16_t con,
-                                DisasContext *ctx)
+static void gen_offset_st_2regs(DisasContext *ctx,
+                                TCGv rh, TCGv rl, TCGv base, int16_t con)
 {
     TCGv temp = tcg_temp_new();
     tcg_gen_addi_i32(temp, base, con);
-    gen_st_2regs_64(rh, rl, temp, ctx);
+    gen_st_2regs_64(ctx, rh, rl, temp);
 }
 
-static void gen_ld_2regs_64(TCGv rh, TCGv rl, TCGv address, DisasContext *ctx)
+static void gen_ld_2regs_64(DisasContext *ctx, TCGv rh, TCGv rl, TCGv address)
 {
     TCGv_i64 temp = tcg_temp_new_i64();
 
@@ -251,12 +251,12 @@ static void gen_ld_2regs_64(TCGv rh, TCGv rl, TCGv address, DisasContext *ctx)
     tcg_gen_extr_i64_i32(rl, rh, temp);
 }
 
-static void gen_offset_ld_2regs(TCGv rh, TCGv rl, TCGv base, int16_t con,
-                                DisasContext *ctx)
+static void gen_offset_ld_2regs(DisasContext *ctx,
+                                TCGv rh, TCGv rl, TCGv base, int16_t con)
 {
     TCGv temp = tcg_temp_new();
     tcg_gen_addi_i32(temp, base, con);
-    gen_ld_2regs_64(rh, rl, temp, ctx);
+    gen_ld_2regs_64(ctx, rh, rl, temp);
 }
 
 static void gen_st_preincr(DisasContext *ctx, TCGv r1, TCGv r2, int16_t off,
@@ -3798,11 +3798,11 @@ static void decode_abs_ldw(DisasContext *ctx)
         break;
     case OPC2_32_ABS_LD_D:
         CHECK_REG_PAIR(r1);
-        gen_ld_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp, ctx);
+        gen_ld_2regs_64(ctx, cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp);
         break;
     case OPC2_32_ABS_LD_DA:
         CHECK_REG_PAIR(r1);
-        gen_ld_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp, ctx);
+        gen_ld_2regs_64(ctx, cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp);
         break;
     case OPC2_32_ABS_LD_W:
         tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_LESL);
@@ -3913,11 +3913,11 @@ static void decode_abs_store(DisasContext *ctx)
         break;
     case OPC2_32_ABS_ST_D:
         CHECK_REG_PAIR(r1);
-        gen_st_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp, ctx);
+        gen_st_2regs_64(ctx, cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp);
         break;
     case OPC2_32_ABS_ST_DA:
         CHECK_REG_PAIR(r1);
-        gen_st_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp, ctx);
+        gen_st_2regs_64(ctx, cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp);
         break;
     case OPC2_32_ABS_ST_W:
         tcg_gen_qemu_st_i32(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_LESL);
@@ -4289,36 +4289,38 @@ static void decode_bo_addrmode_post_pre_base(DisasContext *ctx)
         break;
     case OPC2_32_BO_ST_D_SHORTOFF:
         CHECK_REG_PAIR(r1);
-        gen_offset_st_2regs(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], cpu_gpr_a[r2],
-                            off10, ctx);
+        gen_offset_st_2regs(ctx,
+                            cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], cpu_gpr_a[r2],
+                            off10);
         break;
     case OPC2_32_BO_ST_D_POSTINC:
         CHECK_REG_PAIR(r1);
-        gen_st_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], cpu_gpr_a[r2], ctx);
+        gen_st_2regs_64(ctx, cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], cpu_gpr_a[r2]);
         tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_ST_D_PREINC:
         CHECK_REG_PAIR(r1);
         temp = tcg_temp_new();
         tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
-        gen_st_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp, ctx);
+        gen_st_2regs_64(ctx, cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp);
         tcg_gen_mov_i32(cpu_gpr_a[r2], temp);
         break;
     case OPC2_32_BO_ST_DA_SHORTOFF:
         CHECK_REG_PAIR(r1);
-        gen_offset_st_2regs(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], cpu_gpr_a[r2],
-                            off10, ctx);
+        gen_offset_st_2regs(ctx,
+                            cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], cpu_gpr_a[r2],
+                            off10);
         break;
     case OPC2_32_BO_ST_DA_POSTINC:
         CHECK_REG_PAIR(r1);
-        gen_st_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], cpu_gpr_a[r2], ctx);
+        gen_st_2regs_64(ctx, cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], cpu_gpr_a[r2]);
         tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_ST_DA_PREINC:
         CHECK_REG_PAIR(r1);
         temp = tcg_temp_new();
         tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
-        gen_st_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp, ctx);
+        gen_st_2regs_64(ctx, cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp);
         tcg_gen_mov_i32(cpu_gpr_a[r2], temp);
         break;
     case OPC2_32_BO_ST_H_SHORTOFF:
@@ -4413,7 +4415,7 @@ static void decode_bo_addrmode_bitreverse_circular(DisasContext *ctx)
         break;
     case OPC2_32_BO_ST_D_BR:
         CHECK_REG_PAIR(r1);
-        gen_st_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp2, ctx);
+        gen_st_2regs_64(ctx, cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp2);
         gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_ST_D_CIRC:
@@ -4428,7 +4430,7 @@ static void decode_bo_addrmode_bitreverse_circular(DisasContext *ctx)
         break;
     case OPC2_32_BO_ST_DA_BR:
         CHECK_REG_PAIR(r1);
-        gen_st_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp2, ctx);
+        gen_st_2regs_64(ctx, cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp2);
         gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_ST_DA_CIRC:
@@ -4520,36 +4522,38 @@ static void decode_bo_addrmode_ld_post_pre_base(DisasContext *ctx)
         break;
     case OPC2_32_BO_LD_D_SHORTOFF:
         CHECK_REG_PAIR(r1);
-        gen_offset_ld_2regs(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], cpu_gpr_a[r2],
-                            off10, ctx);
+        gen_offset_ld_2regs(ctx,
+                            cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], cpu_gpr_a[r2],
+                            off10);
         break;
     case OPC2_32_BO_LD_D_POSTINC:
         CHECK_REG_PAIR(r1);
-        gen_ld_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], cpu_gpr_a[r2], ctx);
+        gen_ld_2regs_64(ctx, cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], cpu_gpr_a[r2]);
         tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_LD_D_PREINC:
         CHECK_REG_PAIR(r1);
         temp = tcg_temp_new();
         tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
-        gen_ld_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp, ctx);
+        gen_ld_2regs_64(ctx, cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp);
         tcg_gen_mov_i32(cpu_gpr_a[r2], temp);
         break;
     case OPC2_32_BO_LD_DA_SHORTOFF:
         CHECK_REG_PAIR(r1);
-        gen_offset_ld_2regs(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], cpu_gpr_a[r2],
-                            off10, ctx);
+        gen_offset_ld_2regs(ctx,
+                            cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], cpu_gpr_a[r2],
+                            off10);
         break;
     case OPC2_32_BO_LD_DA_POSTINC:
         CHECK_REG_PAIR(r1);
-        gen_ld_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], cpu_gpr_a[r2], ctx);
+        gen_ld_2regs_64(ctx, cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], cpu_gpr_a[r2]);
         tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_LD_DA_PREINC:
         CHECK_REG_PAIR(r1);
         temp = tcg_temp_new();
         tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
-        gen_ld_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp, ctx);
+        gen_ld_2regs_64(ctx, cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp);
         tcg_gen_mov_i32(cpu_gpr_a[r2], temp);
         break;
     case OPC2_32_BO_LD_H_SHORTOFF:
@@ -4651,7 +4655,7 @@ static void decode_bo_addrmode_ld_bitreverse_circular(DisasContext *ctx)
         break;
     case OPC2_32_BO_LD_D_BR:
         CHECK_REG_PAIR(r1);
-        gen_ld_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp2, ctx);
+        gen_ld_2regs_64(ctx, cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp2);
         gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_LD_D_CIRC:
@@ -4666,7 +4670,7 @@ static void decode_bo_addrmode_ld_bitreverse_circular(DisasContext *ctx)
         break;
     case OPC2_32_BO_LD_DA_BR:
         CHECK_REG_PAIR(r1);
-        gen_ld_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp2, ctx);
+        gen_ld_2regs_64(ctx, cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp2);
         gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_LD_DA_CIRC:
@@ -8377,7 +8381,7 @@ static void tricore_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     tcg_gen_insn_start(ctx->base.pc_next);
 }
 
-static bool insn_crosses_page(CPUTriCoreState *env, DisasContext *ctx)
+static bool insn_crosses_page(DisasContext *ctx, CPUTriCoreState *env)
 {
     /*
      * Return true if the insn at ctx->base.pc_next might cross a page boundary.
@@ -8420,7 +8424,7 @@ static void tricore_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
         if (ctx->base.pc_next - page_start >= TARGET_PAGE_SIZE
             || (ctx->base.pc_next - page_start >= TARGET_PAGE_SIZE - 3
-                && insn_crosses_page(env, ctx))) {
+                && insn_crosses_page(ctx, env))) {
             ctx->base.is_jmp = DISAS_TOO_MANY;
         }
     }
-- 
2.51.0


