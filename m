Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4F3CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 21:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v99D6-0003c0-8r; Wed, 15 Oct 2025 17:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v99Cx-0003Zq-Ve
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:39:00 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v99Cu-0004zm-7w
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:38:55 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2698384978dso503965ad.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 14:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760564329; x=1761169129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SqCRsRggw+NmDtKLMVf8Mr9OjYm8BzUFUWvu2nTrVOA=;
 b=eDsOL46b69KSGgqsix4okHrwLsn9cK7m7zyFB0gJJ7Q/YAwfIXcj4caw1KP2yYG0lj
 jj4WkRGzFUpsayL//ye3bH+ICqTldl2hP9ftuNNJ9p7riDfVaPUtkbyCx1YtX0pG6hlz
 P8ZwVu+snoqaziJvuy+OKNwGGhZ0YxKweL661MyTVNve8DD7an7FfwJp7UvmK92cundJ
 O9efFuSYGdDOp234p17lfQyAUj2wTnazeLuId3Ysybp3sY0n43I5VUyWpmw/63GyN9ZI
 pJqojtpsh9k1DidRHLNlwJFHzOqlgiFgUmUSXfs1/Wu/bYiFspJTQVHkiDggDnQiMW/e
 5xCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760564329; x=1761169129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SqCRsRggw+NmDtKLMVf8Mr9OjYm8BzUFUWvu2nTrVOA=;
 b=nsMAIlt4K0AA1MoIi/jdXF7PFpy3qptpUVxCkm3ccnoisKgP5DTpcNy2lBDcugXBdq
 MIlIwBeDMpGx6UfStNWHz2jmjilUHMaWLftylzmv+8lCkDnDWBDL6W/2TANSChvyhZoB
 L8suyGShQBNO6WAqG1z1gg3t/43EP9h6BeTH0XGzRBu9wFt2yfphV5AjpxNg3KzpQwda
 wnYcdNlycNBeD50jAPwqaMuPf8bkxVkvKj2HRo2i0ZGV360oeGZTZU1dp5vFU+6DSPXM
 TDVpX8LSHQvuee4gUhnMd+67j4bXGZ5WJb6D/2FdX8klM63E7rCPAHcklH7De6IRyE/U
 RjUA==
X-Gm-Message-State: AOJu0Yz4VLXfR3pRq5bud+PwoCepzOeZhbNLYV3ccDfBG6hmTnvovjpE
 qB87VtkGH3JhAkJgJ3CsbZ6p0IFa2VRQhnzCIk7Rb8Plhf9ZQc9WLuYi6ODu0/x6DP7u26OfR/g
 zhcdSbpk=
X-Gm-Gg: ASbGncvN8wy6wTzA3toB9GrbcdNO3Zzc3bzlutof84aOVjO7WnjRGQGAH8RQeBfzSwR
 6UE7VuFE+41Obt4DMfGfTHYBqUcm2ExM7hyneUBs3CGcLqqBdAE8JZBwZ9uCtAjqsikgqukGVKr
 vnmc9QwKk9dLJnG7+sbAO7KuS1pnsSzjxSfh8jZW1yfm6OmtMT5FNcL9sew/HMkq/dcga8o1E5Q
 bkKQ+yHqoDfLaRAicshKQERi9ptLPm/mtxgnZeNduZSmdg93PtzNM7xS8AwtZ/xwxr3Vpv+wNdC
 Qb5EJiPVCofsOw9WT5nNL/OhiAmUMpPxQEJvYcleTZVSLBexYNtpC0xrW2mkGkpuv5H14G1Smoy
 HBjgyzAgI0VZ0Nma8I71xlJnaXh3AibWCAw4sltCYU8Mg5XPoSKwlmhDzQXeo2MZiNm+tguU2cx
 ffzB3LYskwOpj8LJQUZZNb
X-Google-Smtp-Source: AGHT+IFJrfnNEmvDmpCudCPxWh6WDb9J7WfmCY5e9aJXlOyf+eEfhE4J1W1QM0sDgpVgicvg6S6dOg==
X-Received: by 2002:a17:903:3c2c:b0:270:b6d5:f001 with SMTP id
 d9443c01a7336-2902723faa2mr342518875ad.23.1760564329189; 
 Wed, 15 Oct 2025 14:38:49 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7d1bbsm6247085ad.65.2025.10.15.14.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 14:38:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v2 6/9] tcg/mips: Remove ALIAS_PADD, ALIAS_PADDI
Date: Wed, 15 Oct 2025 14:38:40 -0700
Message-ID: <20251015213843.14277-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015213843.14277-1-richard.henderson@linaro.org>
References: <20251015213843.14277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

These aliases existed to simplify code for O32 and N32.
Now that the 64-bit abi is the only one supported, we
can use the DADD* instructions directly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.c.inc | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 8e7c0ea33f..83bf65d5ca 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -340,10 +340,6 @@ typedef enum {
     OPC_SYNC_ACQUIRE = OPC_SYNC | 0x11 << 6,
     OPC_SYNC_RELEASE = OPC_SYNC | 0x12 << 6,
     OPC_SYNC_RMB     = OPC_SYNC | 0x13 << 6,
-
-    /* Aliases for convenience.  */
-    ALIAS_PADD     = sizeof(void *) == 4 ? OPC_ADDU : OPC_DADDU,
-    ALIAS_PADDI    = sizeof(void *) == 4 ? OPC_ADDIU : OPC_DADDIU,
 } MIPSInsn;
 
 /*
@@ -700,7 +696,7 @@ static void tcg_out_ldst(TCGContext *s, MIPSInsn opc, TCGReg data,
     if (ofs != lo) {
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_TMP0, ofs - lo);
         if (addr != TCG_REG_ZERO) {
-            tcg_out_opc_reg(s, ALIAS_PADD, TCG_TMP0, TCG_TMP0, addr);
+            tcg_out_opc_reg(s, OPC_DADDU, TCG_TMP0, TCG_TMP0, addr);
         }
         addr = TCG_TMP0;
     }
@@ -1109,7 +1105,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out_opc_reg(s, OPC_AND, TCG_TMP3, TCG_TMP3, TCG_TMP0);
 
         /* Add the tlb_table pointer, creating the CPUTLBEntry address.  */
-        tcg_out_opc_reg(s, ALIAS_PADD, TCG_TMP3, TCG_TMP3, TCG_TMP1);
+        tcg_out_opc_reg(s, OPC_DADDU, TCG_TMP3, TCG_TMP3, TCG_TMP1);
 
         /* Load the tlb comparator.  */
         if (addr_type == TCG_TYPE_I32) {
@@ -1148,7 +1144,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
         /* delay slot */
         base = TCG_TMP3;
-        tcg_out_opc_reg(s, ALIAS_PADD, base, TCG_TMP3, addr);
+        tcg_out_opc_reg(s, OPC_DADDU, base, TCG_TMP3, addr);
     } else {
         if (a_mask && (use_mips32r6_instructions || a_bits != s_bits)) {
             ldst = new_ldst_label(s);
@@ -1177,9 +1173,9 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         }
         if (guest_base) {
             if (guest_base == (int16_t)guest_base) {
-                tcg_out_opc_imm(s, ALIAS_PADDI, TCG_REG_A0, base, guest_base);
+                tcg_out_opc_imm(s, OPC_DADDIU, TCG_REG_A0, base, guest_base);
             } else {
-                tcg_out_opc_reg(s, ALIAS_PADD, TCG_REG_A0, base,
+                tcg_out_opc_reg(s, OPC_DADDU, TCG_REG_A0, base,
                                 TCG_GUEST_BASE_REG);
             }
             base = TCG_REG_A0;
@@ -1417,7 +1413,7 @@ static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
         } else {
             base = TCG_REG_V0;
             tcg_out_movi(s, TCG_TYPE_PTR, base, ofs - lo);
-            tcg_out_opc_reg(s, ALIAS_PADD, base, base, TCG_REG_TB);
+            tcg_out_opc_reg(s, OPC_DADDU, base, base, TCG_REG_TB);
         }
     }
     if (!tcg_out_opc_jmp(s, OPC_J, tb_ret_addr)) {
@@ -1425,7 +1421,7 @@ static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
         tcg_out_opc_reg(s, OPC_JR, 0, TCG_TMP0, 0);
     }
     /* delay slot */
-    tcg_out_opc_imm(s, ALIAS_PADDI, TCG_REG_V0, base, lo);
+    tcg_out_opc_imm(s, OPC_DADDIU, TCG_REG_V0, base, lo);
 }
 
 static void tcg_out_goto_tb(TCGContext *s, int which)
@@ -1444,7 +1440,7 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
 
     set_jmp_reset_offset(s, which);
     /* For the unlinked case, need to reset TCG_REG_TB. */
-    tcg_out_ldst(s, ALIAS_PADDI, TCG_REG_TB, TCG_REG_TB,
+    tcg_out_ldst(s, OPC_DADDIU, TCG_REG_TB, TCG_REG_TB,
                  -tcg_current_code_size(s));
 }
 
@@ -2366,7 +2362,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_set_frame(s, TCG_REG_SP, TCG_STATIC_CALL_ARGS_SIZE, TEMP_SIZE);
 
     /* TB prologue */
-    tcg_out_opc_imm(s, ALIAS_PADDI, TCG_REG_SP, TCG_REG_SP, -FRAME_SIZE);
+    tcg_out_opc_imm(s, OPC_DADDIU, TCG_REG_SP, TCG_REG_SP, -FRAME_SIZE);
     for (i = 0; i < ARRAY_SIZE(tcg_target_callee_save_regs); i++) {
         tcg_out_st(s, TCG_TYPE_REG, tcg_target_callee_save_regs[i],
                    TCG_REG_SP, SAVE_OFS + i * REG_SIZE);
@@ -2409,7 +2405,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 
     tcg_out_opc_reg(s, OPC_JR, 0, TCG_REG_RA, 0);
     /* delay slot */
-    tcg_out_opc_imm(s, ALIAS_PADDI, TCG_REG_SP, TCG_REG_SP, FRAME_SIZE);
+    tcg_out_opc_imm(s, OPC_DADDIU, TCG_REG_SP, TCG_REG_SP, FRAME_SIZE);
 
     if (use_mips32r2_instructions) {
         return;
-- 
2.43.0


