Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C5AC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmc3H-00079L-Nt; Mon, 24 Feb 2025 12:15:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc34-000755-Fe
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:18 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2z-0005mV-0H
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:15 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-220d398bea9so74158225ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 09:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740417308; x=1741022108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mzQvzV3GwNPTMMqwNQwmxD5F34q8V2N0DYRW/VglmXk=;
 b=EJ/5LaYztoXmDuU5FyJWPpyeSBGZRCIRAiDlvELyciewlCZZOZAI+PbFTJxgY7lvq0
 LCSQ2zpnEMUEol/aAwJadWqKMZXUBYPGxZjbhCMoxmRWbfukgFSMY6KIdPm9+zQS6nPb
 b+mRjB0q5eTeb0NDInMaiPUaT17KM3iP4zlOG6LCOt/3U3kA9EvxvYH3DJk6mYoWs9ke
 9q8Gskbpq4kdr7YNo1pwx71aA2wZCQ3Fcwc5Ai1jnK0LQxB3G1VDbhu4xTUSHeu8BSnO
 Gl4LnWsyAUwiERqAk7gxgzgvC9YT9X6bUNLPYR5jdNIl2J2ZsHYg8Yc9lhcAmcNm2/Fi
 GYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740417308; x=1741022108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mzQvzV3GwNPTMMqwNQwmxD5F34q8V2N0DYRW/VglmXk=;
 b=fPy+kONwu3mdYMdZaRN0w0vpheIok+Nzrut+V1zBp2/c/zMpDtyzp5LESyw+tY11E2
 Mk3nuApmtTR77Jtbtiqs4nxwSAzSBQkaYWoDKDWtTZXS74GPXOpZU8k2ZjjvZnJ4e6Qm
 4hTrBCuBZ2o3/QNjY3gofK2L2wmPSC0Qisxx/Y46SBiZ6uGTI5+gEhfBx1c/XtN3uBTI
 gKnraCO496ZqeRH79cSnYMHANt8e3rEkKCl6EVZQdjLmX8i8UrDkTh+0TU+rXLbAwdwz
 zyZEbjCXAceCDLOPVTtd/LbPhLXcEdxuIbqPFY7sBgXD6PFXtcwQWlfGaAd+Oi0f4FzS
 w1XQ==
X-Gm-Message-State: AOJu0YweWpnrKmZUPMBmefx+bOhD/s7CEkZfJ5YsvKyyPeT0+arAJbox
 AEeqz3yhrdREPBQlu/MChOntM4J0865DiNVYx1Pn/9in6uaoA7DRCbxM9+My/Tps3hrUlfwUHSW
 6
X-Gm-Gg: ASbGncvzkLOErCkGkMvA/fi+B6L1nxPe+ZxKL3BK5eSfZDTv18qwtChejJJyZxQhGUq
 SYFlSfXyDMneagsQWAnJ+q6sgKbKGUpa/42CHSSfn3g0wjjpU82m1m89aRyoYXXKNnFNCD7x3RQ
 njR0NoPF9PJsYOWi5VPxcGPZlRO4vECVU4N/e5omXW8r/TuniPIP1h1jHAdkH8CRMPs9ujYtwOX
 trYrsEHeDU5Tbs31u9caW+ZYnRj60qY5l8sbBZRhuhLlRLhOyZy8thBariZhaNSCQXcHDDWrEP3
 RaR559cEnI8lSpdatCfXlgJthgjkC6djBSk=
X-Google-Smtp-Source: AGHT+IHpZ2kYIC8tFrGlV3XSXmFI4lDUgrm1zisWgY6vW3XSEPqnOKevtlYKI/sUOKsetYjBPoeV0g==
X-Received: by 2002:a17:902:f60a:b0:21f:752f:f2b1 with SMTP id
 d9443c01a7336-221a1102975mr199982895ad.30.1740417308322; 
 Mon, 24 Feb 2025 09:15:08 -0800 (PST)
Received: from stoup.. ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm20580780b3a.9.2025.02.24.09.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 09:15:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 16/24] target/m68k: Remove env argument to gen_ea_mode_fp
Date: Mon, 24 Feb 2025 09:14:36 -0800
Message-ID: <20250224171444.440135-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224171444.440135-1-richard.henderson@linaro.org>
References: <20250224171444.440135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Use the env pointer in DisasContext.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index df1bfe6786..368188ce28 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1012,9 +1012,8 @@ static void gen_ldst_fp(DisasContext *s, int opsize, TCGv addr,
     }
 }
 
-static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
-                          int reg0, int opsize, TCGv_ptr fp, ea_what what,
-                          int index)
+static int gen_ea_mode_fp(DisasContext *s, int mode, int reg0, int opsize,
+                          TCGv_ptr fp, ea_what what, int index)
 {
     TCGv reg, addr, tmp;
     TCGv_i64 t64;
@@ -1059,23 +1058,23 @@ static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
         if (reg0 == 4 && what != EA_STORE) {
             switch (opsize) {
             case OS_BYTE:
-                tmp = tcg_constant_i32((int8_t)read_im8(env, s));
+                tmp = tcg_constant_i32((int8_t)read_im8(s->env, s));
                 gen_helper_exts32(tcg_env, fp, tmp);
                 break;
             case OS_WORD:
-                tmp = tcg_constant_i32((int16_t)read_im16(env, s));
+                tmp = tcg_constant_i32((int16_t)read_im16(s->env, s));
                 gen_helper_exts32(tcg_env, fp, tmp);
                 break;
             case OS_LONG:
-                tmp = tcg_constant_i32(read_im32(env, s));
+                tmp = tcg_constant_i32(read_im32(s->env, s));
                 gen_helper_exts32(tcg_env, fp, tmp);
                 break;
             case OS_SINGLE:
-                tmp = tcg_constant_i32(read_im32(env, s));
+                tmp = tcg_constant_i32(read_im32(s->env, s));
                 gen_helper_extf32(tcg_env, fp, tmp);
                 break;
             case OS_DOUBLE:
-                t64 = tcg_constant_i64(read_im64(env, s));
+                t64 = tcg_constant_i64(read_im64(s->env, s));
                 gen_helper_extf64(tcg_env, fp, t64);
                 break;
             case OS_EXTENDED:
@@ -1083,9 +1082,9 @@ static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
                     gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
                     break;
                 }
-                tmp = tcg_constant_i32(read_im32(env, s) >> 16);
+                tmp = tcg_constant_i32(read_im32(s->env, s) >> 16);
                 tcg_gen_st16_i32(tmp, fp, offsetof(FPReg, l.upper));
-                t64 = tcg_constant_i64(read_im64(env, s));
+                t64 = tcg_constant_i64(read_im64(s->env, s));
                 tcg_gen_st_i64(t64, fp, offsetof(FPReg, l.lower));
                 break;
             case OS_PACKED:
@@ -1122,7 +1121,7 @@ static int gen_ea_fp(CPUM68KState *env, DisasContext *s, uint16_t insn,
 {
     int mode = extract32(insn, 3, 3);
     int reg0 = REG(insn, 0);
-    return gen_ea_mode_fp(env, s, mode, reg0, opsize, fp, what, index);
+    return gen_ea_mode_fp(s, mode, reg0, opsize, fp, what, index);
 }
 
 typedef struct {
-- 
2.43.0


