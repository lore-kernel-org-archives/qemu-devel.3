Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041DECCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 16:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9nNO-0004oR-G8; Fri, 17 Oct 2025 12:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9nNL-0004nD-SI
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 12:32:20 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9nNH-0001CE-J7
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 12:32:19 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b63148d25c3so1340430a12.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 09:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760718732; x=1761323532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FHn1R3ZF55YJWZfpnAUbmLtJwg62Lau4AKHNQr6hxkg=;
 b=fE5CbdCohi7tuBupENPeezwHRZyNP12vFvolqJdYGz3zSIQxC9J/lzZwjrjb7peR3d
 qbFrWOqnNN+gSTNqmLrZ9aRLcbQanSkov84LBirG5Xw1wXrUoPOpbEt0Pms0OIh7sUds
 rJkx1O03mdl+BfjCrZlRRp+w7zEsHn8bRjdehsKOFlpauSSv+UFHFTBYUD9AWZ+IzYJq
 PMChnpi1zxtLv7hOcXJEmjMVfVCCOooPr4PIKBqzATH0XZszhG6yTTxq21KdEMnmCNW1
 qxHClZ5bTzfUIPB2HHiQLskXaZO1EUIGaEQb/YSwJQUUWBBjxrFFXtWyguJKz/Dlqzn7
 uQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760718732; x=1761323532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FHn1R3ZF55YJWZfpnAUbmLtJwg62Lau4AKHNQr6hxkg=;
 b=EwuWANDBhNM6EW9LJSaphOBshfJZii32pDAU+sjtZ8WiJ7poszAT1vKm23ZUBtb0+/
 s80BTgb8oFwisGFHyjwQV7+rEq+VmHHjNUD6+ucv4JTbqbA8r8ttEIbpYo+/hpHzvLjj
 jLYTNnmNIRGzg+KW7JZNpDf27hfe7kZorKVeLVgIbmDWZ22G9dyaauM14YSPu41wvHaf
 /teLvYw44UlXQEvgC/H9QnPPNn1BiSQbmPrtmgXvOYzXGzt3SKgaQEVDdp8zFazv74M9
 28Sqk5mAZIPfvmHSDawRiOC10x9X0Q2lx3+pzbOtHjhgP9jeD8nJK4WMd/cKCq0UEwxV
 iO6g==
X-Gm-Message-State: AOJu0YzeMtk1QZjqvqZ6Uc5rY49iaMEW6nQjRHPww32rDpUHJ5/q9r0p
 AfLrAm9Odb9hAPP/nIUn/hg430CdfyCxu+6zyzi6EDkwrqTx/i1Udrea5PzZ0AzEcO5F7aUpP4i
 kqaU0nm8=
X-Gm-Gg: ASbGncsQqcTUHlEcPlHo85DTQN2E9ohJQ+rJQZqraEmwheVCI8nYPR7oohF6vQbIkH7
 WyLp7X3GjBrDFGK9CFLbvT+SZjmLBsHSC5CDskhicZO0KiwRqNVJEmfrjd5ZDzL+Y9DJHrcIsii
 esFkPkbWlrnVlfZ6JDA2RN9LNc6hNiV63lwNWpB6aWI8ReNkJRmbHlnf3citNxKo5Dhx5CpVNGd
 XHKa4/0sK0HX4m/tzxNKAHV1//1sGKuGJ3I3xFriWuzebP/MBvkLHRAQKiKmtkRmlK/5jtQkJyu
 ga90UDOYJ8E/YjC9mDulk5KZl/CBK9+zhmtWoresV9INo+1KUlpVfGS+n0lSojXyYZ0huQVcq7a
 fBfAyWaX26TAbx1kCM0AS/tyfQm3trPUSGSjuyRrQcS0++rMwUlWbyBaplUfqEpZI4+dveRGawm
 +i/D7drg==
X-Google-Smtp-Source: AGHT+IGB4OHVsTbbtIvSAJm2DmdaR7mMAaZkUfolzypTULyKyARfRO9Od6XvPY/nWLNW4D7HFb410A==
X-Received: by 2002:a17:902:d58d:b0:265:b60f:d18 with SMTP id
 d9443c01a7336-290c66d9f6amr47420635ad.1.1760718732371; 
 Fri, 17 Oct 2025 09:32:12 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7d1bbsm68667715ad.65.2025.10.17.09.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 09:32:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 6/9] tcg/mips: Remove ALIAS_PADD, ALIAS_PADDI
Date: Fri, 17 Oct 2025 09:32:03 -0700
Message-ID: <20251017163206.344542-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017163206.344542-1-richard.henderson@linaro.org>
References: <20251017163206.344542-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.c.inc | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 51a15705cb..60c703a093 100644
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
@@ -1103,7 +1099,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out_opc_reg(s, OPC_AND, TCG_TMP3, TCG_TMP3, TCG_TMP0);
 
         /* Add the tlb_table pointer, creating the CPUTLBEntry address.  */
-        tcg_out_opc_reg(s, ALIAS_PADD, TCG_TMP3, TCG_TMP3, TCG_TMP1);
+        tcg_out_opc_reg(s, OPC_DADDU, TCG_TMP3, TCG_TMP3, TCG_TMP1);
 
         /* Load the tlb comparator.  */
         if (addr_type == TCG_TYPE_I32) {
@@ -1142,7 +1138,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
         /* delay slot */
         base = TCG_TMP3;
-        tcg_out_opc_reg(s, ALIAS_PADD, base, TCG_TMP3, addr);
+        tcg_out_opc_reg(s, OPC_DADDU, base, TCG_TMP3, addr);
     } else {
         if (a_mask && (use_mips32r6_instructions || a_bits != s_bits)) {
             ldst = new_ldst_label(s);
@@ -1171,9 +1167,9 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
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
@@ -1411,7 +1407,7 @@ static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
         } else {
             base = TCG_REG_V0;
             tcg_out_movi(s, TCG_TYPE_PTR, base, ofs - lo);
-            tcg_out_opc_reg(s, ALIAS_PADD, base, base, TCG_REG_TB);
+            tcg_out_opc_reg(s, OPC_DADDU, base, base, TCG_REG_TB);
         }
     }
     if (!tcg_out_opc_jmp(s, OPC_J, tb_ret_addr)) {
@@ -1419,7 +1415,7 @@ static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
         tcg_out_opc_reg(s, OPC_JR, 0, TCG_TMP0, 0);
     }
     /* delay slot */
-    tcg_out_opc_imm(s, ALIAS_PADDI, TCG_REG_V0, base, lo);
+    tcg_out_opc_imm(s, OPC_DADDIU, TCG_REG_V0, base, lo);
 }
 
 static void tcg_out_goto_tb(TCGContext *s, int which)
@@ -1438,7 +1434,7 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
 
     set_jmp_reset_offset(s, which);
     /* For the unlinked case, need to reset TCG_REG_TB. */
-    tcg_out_ldst(s, ALIAS_PADDI, TCG_REG_TB, TCG_REG_TB,
+    tcg_out_ldst(s, OPC_DADDIU, TCG_REG_TB, TCG_REG_TB,
                  -tcg_current_code_size(s));
 }
 
@@ -2360,7 +2356,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_set_frame(s, TCG_REG_SP, TCG_STATIC_CALL_ARGS_SIZE, TEMP_SIZE);
 
     /* TB prologue */
-    tcg_out_opc_imm(s, ALIAS_PADDI, TCG_REG_SP, TCG_REG_SP, -FRAME_SIZE);
+    tcg_out_opc_imm(s, OPC_DADDIU, TCG_REG_SP, TCG_REG_SP, -FRAME_SIZE);
     for (i = 0; i < ARRAY_SIZE(tcg_target_callee_save_regs); i++) {
         tcg_out_st(s, TCG_TYPE_REG, tcg_target_callee_save_regs[i],
                    TCG_REG_SP, SAVE_OFS + i * REG_SIZE);
@@ -2403,7 +2399,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 
     tcg_out_opc_reg(s, OPC_JR, 0, TCG_REG_RA, 0);
     /* delay slot */
-    tcg_out_opc_imm(s, ALIAS_PADDI, TCG_REG_SP, TCG_REG_SP, FRAME_SIZE);
+    tcg_out_opc_imm(s, OPC_DADDIU, TCG_REG_SP, TCG_REG_SP, FRAME_SIZE);
 
     if (use_mips32r2_instructions) {
         return;
-- 
2.43.0


