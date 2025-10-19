Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C78CCD1A5
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 18:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAY99-0005B6-7J; Sun, 19 Oct 2025 14:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vAY96-00059J-Fl
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 14:28:44 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vAY93-0000Zc-QF
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 14:28:44 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-290c2b6a6c2so30700875ad.1
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 11:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760898520; x=1761503320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FHn1R3ZF55YJWZfpnAUbmLtJwg62Lau4AKHNQr6hxkg=;
 b=oemWtCMdLv3ofmBMJkLsLK2ucXAdXLW5FyxRGq3zy9e2Gy1rq40O3A94ChiQJO7klu
 5fZ7kNSFx1q0I7RfBe6fQp2m2lMSUjdbQOUIL9diK4vunKsq73LXDR14q2CUYg//oVk6
 JsXzcCoffCpoFNuEqN0wFEfVdpVXkBqhbQpXX2LExlJBt5OLzQjzugcog8QCNVBGboBz
 GQ4u9H2+Aj8xKyjOxPtzHx+LCGXFvP+R+6F+BdsGCFlLHBceF8g5LDuaaaUxaHfeBg/F
 deNTotcoajH21+R8hyZMLaBYQt2adR9apDCsSv4hzeDITS1DYym3jeW3MkQIP3b/s1lV
 PISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760898520; x=1761503320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FHn1R3ZF55YJWZfpnAUbmLtJwg62Lau4AKHNQr6hxkg=;
 b=mBOP58l/rw6T9cWpg4sG9gMab6JUeHk3W7D9ROJkWYx3Z2yDXKHbqHa4Z4ZfGDhr3Y
 rkaPznPvdvaDGUjKKf3CBPV9aXwSVC8TbEYaVVXM/2kpcCYmE4K7RdBkKufOYLuXyskd
 lvXWXuCrMLw9NsPZ1TdsH7C9ky2e7pdbRBl4ZhyXOTh07BvRvB73dXbemveb+HiVE4ur
 EBpQFEYxDd6vOCgS+00Id1nGf/wU9Nqfvr8aNF+crxPIweAUNZp27j9WirFhlm95eBID
 63/NzUbjgdY4ImrtaDIO8U49opJVR+eCmGG0ApcV0EtdDkPGFn5JKS6soakrsUpU+DXD
 +CJA==
X-Gm-Message-State: AOJu0YzhKd1CkpgGxBgrwR34k3KFsoOfoBwazqtKPzEW6TwvjLW77eMO
 +O4KEr12es3Wz/YNLWROCcQnl7dVRbBbVH+o2Ip2RY+KFC/kViah0XHs8qZzo5Q21XnDhw+J6ca
 6A2+22+c=
X-Gm-Gg: ASbGncuVcCkRBbd2140YwCnc4Ek+zGw820IzZLd+Wp3q16onuvWHBtJXtjdZ0axBYEZ
 xYW+1B4qQHYlRUTwUuUjvyKovSel4EcRFGZ+ZEbUpRWbfGCZzsTECMG7tjmnjcMKc2WAmRk/zwk
 ovaNxhEFegN0Y54tlZcaG7WuWChuLG6/HRFdhw6a5853rHOA1LamBkzSjCW5B8+3JBehT2/UBDF
 HPSMuD2hagdZEH6f1Cng2sYVtWF7fMiqUJ5qsRqVgj+XEDenXt/zoBl7RF5D6HcHvuUpEUR0nuv
 WaUKUWGauASq4LHUigFMpmwmzuIDZBieLAQE8nkr+UpTFpStK+ZvKIeVXS1WttdYdcMkedRonHn
 MEDm9j+mGdWoN/nbsSoW5IXvYU7M4cP9Zc6WSCf4ln8rIeN2GSHQO/wJmwwHxq3Ye4xJHWI2xQh
 m5X6Wzog==
X-Google-Smtp-Source: AGHT+IFzfINuDZJtChvPqsJiYrGE3UAZhvBoEbANvvkD3gx+OozwLX0k5sId5W4w5t6Sd/5IlvebOw==
X-Received: by 2002:a17:902:ce0e:b0:264:befb:829c with SMTP id
 d9443c01a7336-290c9c8a738mr128099595ad.9.1760898520318; 
 Sun, 19 Oct 2025 11:28:40 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246ebccf3sm58985775ad.1.2025.10.19.11.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 11:28:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 6/9] tcg/mips: Remove ALIAS_PADD, ALIAS_PADDI
Date: Sun, 19 Oct 2025 11:28:31 -0700
Message-ID: <20251019182834.481541-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251019182834.481541-1-richard.henderson@linaro.org>
References: <20251019182834.481541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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


