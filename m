Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631EECD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 06:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN3Uo-0002Tz-FY; Wed, 13 May 2026 02:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN3Un-0002Tc-T3
 for qemu-devel@nongnu.org; Wed, 13 May 2026 02:55:05 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN3Ul-0003CB-AW
 for qemu-devel@nongnu.org; Wed, 13 May 2026 02:55:05 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-449d6c68ed8so5448723f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 23:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778655301; x=1779260101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yBbv/+eHBcJpfhxrbNsVNbeCA22jBDQvgzFDX2g7zEg=;
 b=Ze/DXBysuTvOZCeDGg/ZsKFFbJMhY2iNG78xrFakiZ9HEoeY6VRFRvanBcMxpnB35l
 lZdy2GOzZOU5AXD3VYWY3kyAsWKtAjMgfNsGNGm7M/Euo82I74q5Z1N/Us0q9wR/1pPa
 TuDQslY7dYK5uyaFIN1sXAy3du7CQjnePjmIWrieAWTxmzOgG+kJUvTJfzJZkrkHkyMM
 6nzJYEXhR9RwFnlrTSb9S6weeYqksNOeR7H5QhEz6Kktul8Pd4iBbMNc8lo6+6Bj5VbS
 b8UeR71CI7gfJ4TcVL+8H41/V/xUtkyUoNuDbzQelXwE6L5OgqFx0xx51G5MlXz5mNAY
 nE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778655301; x=1779260101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yBbv/+eHBcJpfhxrbNsVNbeCA22jBDQvgzFDX2g7zEg=;
 b=WiTgP/iWA+gVmVecsH+UFILBZi/HZ6xUtiRgCM143P/XpoVH4mxKYa/SH53BSwF1l0
 Lta4Mo1dV1XvzxxmessATvF6F3DZYkV6/SscbqFE435PpGV3GGEFmqu/tMKHNEh2zGzl
 ATlUm1mecds60jrB47GFrEC6aTBOaXf+N0ryZAdUDlvnrpcri2JJ6SPKSjtHVHKgj0a+
 RiqSCkgM8dmRlvY999c1GhZlq+6DnitEfc1fqkyZaPdmPlWXE6CigmyWSbCg9BtVygbt
 rq3lJSSI7AUwS+0Q/mHpkKzFB+Gtid/kxKmpDaxKa9xbRCaqb1g7LTQ7k2i59Bjs/S4/
 SqRA==
X-Gm-Message-State: AOJu0Yywm+CKhr/B6pkXkljo/sO+G87VBGNhmSpdhJIYYDo79YA6xxe6
 0rrBdIDT3A7PVbzQ/c/v8oesiWLHtbxjEmna9dmkoL5o6sN9So54rWdxsUEQRXhHad9LLm/CssU
 teTdIWz0=
X-Gm-Gg: Acq92OGhmeaJa9obgFZOgNsqnD4qh35O4xYX9YiFgVovRY09mOFP8YuOnAJZFd1n9eA
 Fc5Vtq+qRArqyHoBMylWd8d4773WU8QyNBVUEoXZpTIbyzjrn5ZfP+gQm1r24F/uKkedgrgkWnk
 vbnUSfmg6Z1G8kZ+EXCuD5iXtP3bTwL9tu+RFaU/sIUv43+23v6RPCdYdkI5Cky6ikm/bJRLuPG
 z5gF//BaqFJG8C28UWhzyfYKFRjlBckTE+kSEhrmNQvLNL7AzyJnlHSQMtEwMGja8C455GJQCPa
 fwHwfA8s930kV8v0ItxV5EBMeSV+Mz267n/Vw7N+aCf+bAr5xKFPygbrxMrD0/cjYpDXuj1WIJc
 vSWNA7cvoqDRZndDZyDBj0bxpPK3iRplv49Vo89C4HDNonAMV0sPZW2+h8O6HPgIpmiphYybwNA
 jy+ZhogG5OzM/j7QK0va/p9xhSy6RruDX+gROzoylrfKcmg7g3nipIT27clvF6MszsmYekseAD
X-Received: by 2002:a05:6000:240d:b0:44a:247e:67b1 with SMTP id
 ffacd0b85a97d-45c57edf923mr2786956f8f.5.1778655301275; 
 Tue, 12 May 2026 23:55:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45c7f27762csm2940603f8f.31.2026.05.12.23.55.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 May 2026 23:55:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] target/sh4: Inline UNALIGN() macro
Date: Wed, 13 May 2026 08:54:37 +0200
Message-ID: <20260513065438.8680-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513065438.8680-1-philmd@linaro.org>
References: <20260513065438.8680-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Directly access DisasContext::mo_align in place.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/translate.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 5957f294c22..dfe7330d95d 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -52,10 +52,8 @@ typedef struct DisasContext {
 
 #if defined(CONFIG_USER_ONLY)
 #define IS_USER(ctx) 1
-#define UNALIGN(C)   ctx->mo_align
 #else
 #define IS_USER(ctx) (!(ctx->tbflags & (1u << SR_MD)))
-#define UNALIGN(C)   ctx->mo_align
 #endif
 
 /* Target-specific values for ctx->base.is_jmp.  */
@@ -496,7 +494,7 @@ static void _decode_opc(DisasContext * ctx)
             TCGv addr = tcg_temp_new();
             tcg_gen_addi_i32(addr, REG(B11_8), B3_0 * 4);
             tcg_gen_qemu_st_i32(REG(B7_4), addr, ctx->memidx,
-                                MO_TEUL | UNALIGN(ctx));
+                                MO_TEUL | ctx->mo_align);
         }
         return;
     case 0x5000: /* mov.l @(disp,Rm),Rn */
@@ -504,7 +502,7 @@ static void _decode_opc(DisasContext * ctx)
             TCGv addr = tcg_temp_new();
             tcg_gen_addi_i32(addr, REG(B7_4), B3_0 * 4);
             tcg_gen_qemu_ld_i32(REG(B11_8), addr, ctx->memidx,
-                                MO_TESL | UNALIGN(ctx));
+                                MO_TESL | ctx->mo_align);
         }
         return;
     case 0xe000: /* mov #imm,Rn */
@@ -564,22 +562,22 @@ static void _decode_opc(DisasContext * ctx)
         return;
     case 0x2001: /* mov.w Rm,@Rn */
         tcg_gen_qemu_st_i32(REG(B7_4), REG(B11_8), ctx->memidx,
-                            MO_TEUW | UNALIGN(ctx));
+                            MO_TEUW | ctx->mo_align);
         return;
     case 0x2002: /* mov.l Rm,@Rn */
         tcg_gen_qemu_st_i32(REG(B7_4), REG(B11_8), ctx->memidx,
-                            MO_TEUL | UNALIGN(ctx));
+                            MO_TEUL | ctx->mo_align);
         return;
     case 0x6000: /* mov.b @Rm,Rn */
         tcg_gen_qemu_ld_i32(REG(B11_8), REG(B7_4), ctx->memidx, MO_SB);
         return;
     case 0x6001: /* mov.w @Rm,Rn */
         tcg_gen_qemu_ld_i32(REG(B11_8), REG(B7_4), ctx->memidx,
-                            MO_TESW | UNALIGN(ctx));
+                            MO_TESW | ctx->mo_align);
         return;
     case 0x6002: /* mov.l @Rm,Rn */
         tcg_gen_qemu_ld_i32(REG(B11_8), REG(B7_4), ctx->memidx,
-                            MO_TESL | UNALIGN(ctx));
+                            MO_TESL | ctx->mo_align);
         return;
     case 0x2004: /* mov.b Rm,@-Rn */
         {
@@ -595,7 +593,7 @@ static void _decode_opc(DisasContext * ctx)
             TCGv addr = tcg_temp_new();
             tcg_gen_subi_i32(addr, REG(B11_8), 2);
             tcg_gen_qemu_st_i32(REG(B7_4), addr, ctx->memidx,
-                                MO_TEUW | UNALIGN(ctx));
+                                MO_TEUW | ctx->mo_align);
             tcg_gen_mov_i32(REG(B11_8), addr);
         }
         return;
@@ -604,7 +602,7 @@ static void _decode_opc(DisasContext * ctx)
             TCGv addr = tcg_temp_new();
             tcg_gen_subi_i32(addr, REG(B11_8), 4);
             tcg_gen_qemu_st_i32(REG(B7_4), addr, ctx->memidx,
-                                MO_TEUL | UNALIGN(ctx));
+                                MO_TEUL | ctx->mo_align);
             tcg_gen_mov_i32(REG(B11_8), addr);
         }
         return;
@@ -615,13 +613,13 @@ static void _decode_opc(DisasContext * ctx)
         return;
     case 0x6005: /* mov.w @Rm+,Rn */
         tcg_gen_qemu_ld_i32(REG(B11_8), REG(B7_4), ctx->memidx,
-                            MO_TESW | UNALIGN(ctx));
+                            MO_TESW | ctx->mo_align);
         if ( B11_8 != B7_4 )
                 tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 2);
         return;
     case 0x6006: /* mov.l @Rm+,Rn */
         tcg_gen_qemu_ld_i32(REG(B11_8), REG(B7_4), ctx->memidx,
-                            MO_TESL | UNALIGN(ctx));
+                            MO_TESL | ctx->mo_align);
         if ( B11_8 != B7_4 )
                 tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 4);
         return;
@@ -637,7 +635,7 @@ static void _decode_opc(DisasContext * ctx)
             TCGv addr = tcg_temp_new();
             tcg_gen_add_i32(addr, REG(B11_8), REG(0));
             tcg_gen_qemu_st_i32(REG(B7_4), addr, ctx->memidx,
-                                MO_TEUW | UNALIGN(ctx));
+                                MO_TEUW | ctx->mo_align);
         }
         return;
     case 0x0006: /* mov.l Rm,@(R0,Rn) */
@@ -645,7 +643,7 @@ static void _decode_opc(DisasContext * ctx)
             TCGv addr = tcg_temp_new();
             tcg_gen_add_i32(addr, REG(B11_8), REG(0));
             tcg_gen_qemu_st_i32(REG(B7_4), addr, ctx->memidx,
-                                MO_TEUL | UNALIGN(ctx));
+                                MO_TEUL | ctx->mo_align);
         }
         return;
     case 0x000c: /* mov.b @(R0,Rm),Rn */
@@ -660,7 +658,7 @@ static void _decode_opc(DisasContext * ctx)
             TCGv addr = tcg_temp_new();
             tcg_gen_add_i32(addr, REG(B7_4), REG(0));
             tcg_gen_qemu_ld_i32(REG(B11_8), addr, ctx->memidx,
-                                MO_TESW | UNALIGN(ctx));
+                                MO_TESW | ctx->mo_align);
         }
         return;
     case 0x000e: /* mov.l @(R0,Rm),Rn */
@@ -668,7 +666,7 @@ static void _decode_opc(DisasContext * ctx)
             TCGv addr = tcg_temp_new();
             tcg_gen_add_i32(addr, REG(B7_4), REG(0));
             tcg_gen_qemu_ld_i32(REG(B11_8), addr, ctx->memidx,
-                                MO_TESL | UNALIGN(ctx));
+                                MO_TESL | ctx->mo_align);
         }
         return;
     case 0x6008: /* swap.b Rm,Rn */
@@ -1222,7 +1220,7 @@ static void _decode_opc(DisasContext * ctx)
             TCGv addr = tcg_temp_new();
             tcg_gen_addi_i32(addr, REG(B7_4), B3_0 * 2);
             tcg_gen_qemu_st_i32(REG(0), addr, ctx->memidx,
-                                MO_TEUW | UNALIGN(ctx));
+                                MO_TEUW | ctx->mo_align);
         }
         return;
     case 0x8400: /* mov.b @(disp,Rn),R0 */
@@ -1237,7 +1235,7 @@ static void _decode_opc(DisasContext * ctx)
             TCGv addr = tcg_temp_new();
             tcg_gen_addi_i32(addr, REG(B7_4), B3_0 * 2);
             tcg_gen_qemu_ld_i32(REG(0), addr, ctx->memidx,
-                                MO_TESW | UNALIGN(ctx));
+                                MO_TESW | ctx->mo_align);
         }
         return;
     case 0xc700: /* mova @(disp,PC),R0 */
-- 
2.53.0


