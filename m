Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA09C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm5U-0006Vk-Nk; Wed, 07 May 2025 17:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4z-0006D8-0p
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:26 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4q-0006F1-U7
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:24 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso441887b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652395; x=1747257195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bxfiiPxt49JXkREiZvO4xdKZkNdecV2hsS2X2asILJM=;
 b=rmlosf/RYP++w51tbJy77dzK27AU2u/lgJr8B+YucWiCQvs8kFQKLEaOlX1gICPFp6
 7DPWMFM/WLXUd25RlDr9VAwMuHcFUWtBVXHWelLCapTybDrVbg+mLZ7CoYZ1i0YZLZ8y
 FmnEoi/GHUR6bWy4HlDK42BKUJunxri0W0WgED9ESuiHs4LyqkZ1J2M/mIsoZWjHHHq/
 Ut/ivgEkOrVYwJsUfpsH/dD5A1cLAoHvSoeyvZ9dJh83lMxoE2CQPAeq1h+bSjxCrtQe
 Ukqn0dYiGDJYy2/RkPCdmH792x+7x1qIxRtjemOpgeo0y58h2jQ2xH8qfFA4TKhpdCNU
 iHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652395; x=1747257195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bxfiiPxt49JXkREiZvO4xdKZkNdecV2hsS2X2asILJM=;
 b=uMMWtA0mPaH7Vi70jpmVubb3sEO/ftizpn38fX/nVbXv4PiHoVMkVSSdurXfCtqiAk
 sJPwIq5ULDMhuFFsjC7wnZEHSGF27Ei5+cWqQW5oGXQ2E4eoFFbNZPqjx75gcVWhP87Q
 EoX4dfF5u+IqkT1D62jjuzl7uARW1v8/Wq01R3r217uPVqunW0y+rlANB0C+QC5pwAeB
 4GvFIoDWFQ1ZG8robfF3PV6c0ODo/95R57SEe8DInnqU0IgVfmFrIrOCZR/TMp93biMz
 7cxFfmPkzEhFIsii4VejNgl3gdjO6UZqqvWJcexfz75rjW2XG6GwsMW0YTfsInyUyT9y
 zLmQ==
X-Gm-Message-State: AOJu0YzFbtbXqkuwRHzy7sWQxQvtFiRFZDBgP+gWCX9yLGeSdkHbn0sp
 vALXLMXnO6WMV/OC+wsOvpRfYpETQrRta9LzWH+rx2BGNiAGWY0H6GKNf82dzuLJaD6JD9hBE/v
 5
X-Gm-Gg: ASbGnct4UEmJNmRm5/5/eUyN4R27WjoEPXrmIe/RjbGSP0W6SF+bzvR7fYgjSPZMwmf
 HaHUbUdGpJeFafLaS6B1Ruh/bpS5lRtvP7eiibncT0gOlUk9HObyavQ4lA40OOvBV3P2CutgDfJ
 t7oma+UB1llnSO49Nt7CGkxdAjuIFzN6P6mw7Mx2m9u4/jBXiNvXHQWUJmq8dnGXYc6vebMPlzc
 VqAhCjz0VcbxBGZ2zD8HGONsLTOykRX9ShEh9vxqxit1cNiXcXTkPorlmFi85TiALVZj7RWTGB8
 s9eva4xVzcPbMbHOk4yOkLOQW1QdE/zKVqH91wqudRqR8jG3dkUZw3fJJ6af+jxyWj/any8yZM4
 =
X-Google-Smtp-Source: AGHT+IEd7N1B6qrU2+CLfQRPFjwsqvf0srGoyGovvm2b5kYQz3kwlKVP5fw9064D49q+X1+4naHxMQ==
X-Received: by 2002:a05:6a00:2985:b0:736:8c0f:7758 with SMTP id
 d2e1a72fcca58-7409cefdfb0mr6689320b3a.10.1746652395370; 
 Wed, 07 May 2025 14:13:15 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 16/24] target/m68k: Remove env argument to gen_ea_mode_fp
Date: Wed,  7 May 2025 14:12:51 -0700
Message-ID: <20250507211300.9735-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
References: <20250507211300.9735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Use the env pointer in DisasContext.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index dba415acf1..2694620375 100644
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


