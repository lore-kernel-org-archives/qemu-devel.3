Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A06CC48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkFA-0002HB-Mr; Sun, 04 Feb 2024 16:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkF9-0002Fq-CA
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:39 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkF7-0003Xv-Fn
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:39 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d94323d547so29785395ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082896; x=1707687696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQnugvxaaCXEKXnek38clmLInE+uwIUEavcKHzwPd5o=;
 b=sdpon5on07/DQB7g2xT3+qsGNZXQnETwiABUpvcp1Kmuf4Ivl9YjEzm2fn0CT/GLeu
 CNZ0LR+v78E1cW0EFNTb2ul8VGWpXK04fSJy7LDkHPVIMEN2IaWacTClafEIUTfbCaNh
 dY1wzsXF4+KTth9JdQ6ye3jlTUf5ntGvl/G61DocaW45Gl8P0sLleK1Vs/1frXkt2+Rk
 IBa4nS2SO5uPVkNK+mLdh93aR1ybnJBcmjVPA251mvHYR0yxHOvrDVNBMHvdO/gRvwBu
 P8MjqKXR7cjwAqVZVQVi8Beydn/Xk7MWXio6c1kBCLgDkXO+fc1iVyS37Hk07cnVFMwa
 P6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082896; x=1707687696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qQnugvxaaCXEKXnek38clmLInE+uwIUEavcKHzwPd5o=;
 b=XbO2P8KveIBQMvGGB/4y2RtGBlySnZ0/1Zjsi9VemBOzMMcUiV6AfKIpV369hAtmKm
 W57SugPyVxJZwngAMBfcVlIldNnnQ0O2M8MKgldRzx6Y7fDgzLTxDBVsLqlnNkR48hGS
 VIszAyqVvKqq6KLbc1uNR/06Zh16v1O6AeY4Vl73TivH9G33zFSBUNRTonXu2Oh10pgd
 cMsvXlYAtRQ/g9yAW71l+xwHOEN9iMyT7jQvYAYbzKObXkl6Z9H/6mOFJu4/0dFyLen6
 oqzMxCnhwKZhgvwwDTRxEpAaxOmfDQzVT1AbA6T3J5IhPC70ORH6WLISfLajRPt4ZLVM
 LhHw==
X-Gm-Message-State: AOJu0YwSIz3PEdjOmmY5sD7ksda/l5/HgMAnzbrfFE49E7ON/Ic2MdKH
 G/0C09sNAlM09qp++Je13SYtWvfBDJRy9FjKcoCjIHc7rzSRx3UJaDQDGDkWxT5a/+6BwL6XT+m
 cTfw=
X-Google-Smtp-Source: AGHT+IGi6UXwhHVyEIk0dfyipmx5/XPgq2FOAPyf/ZBtXbrUb2gMALc203xPnQGcTB0Uvs2LcLl6nA==
X-Received: by 2002:a17:902:c412:b0:1d9:a868:ec66 with SMTP id
 k18-20020a170902c41200b001d9a868ec66mr1826473plk.43.1707082896317; 
 Sun, 04 Feb 2024 13:41:36 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/39] tcg/aarch64: Generate TBZ, TBNZ
Date: Mon,  5 Feb 2024 07:40:32 +1000
Message-Id: <20240204214052.5639-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Test the sign bit for LT/GE vs 0, and TSTNE/EQ vs a power of 2.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240119224737.48943-2-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 74 ++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 12 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index a19158f4ea..36fc46ae93 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -105,6 +105,18 @@ static bool reloc_pc19(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
     return false;
 }
 
+static bool reloc_pc14(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
+{
+    const tcg_insn_unit *src_rx = tcg_splitwx_to_rx(src_rw);
+    ptrdiff_t offset = target - src_rx;
+
+    if (offset == sextract64(offset, 0, 14)) {
+        *src_rw = deposit32(*src_rw, 5, 14, offset);
+        return true;
+    }
+    return false;
+}
+
 static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -115,6 +127,8 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
         return reloc_pc26(code_ptr, (const tcg_insn_unit *)value);
     case R_AARCH64_CONDBR19:
         return reloc_pc19(code_ptr, (const tcg_insn_unit *)value);
+    case R_AARCH64_TSTBR14:
+        return reloc_pc14(code_ptr, (const tcg_insn_unit *)value);
     default:
         g_assert_not_reached();
     }
@@ -380,6 +394,10 @@ typedef enum {
     /* Conditional branch (immediate).  */
     I3202_B_C       = 0x54000000,
 
+    /* Test and branch (immediate).  */
+    I3205_TBZ       = 0x36000000,
+    I3205_TBNZ      = 0x37000000,
+
     /* Unconditional branch (immediate).  */
     I3206_B         = 0x14000000,
     I3206_BL        = 0x94000000,
@@ -660,6 +678,14 @@ static void tcg_out_insn_3202(TCGContext *s, AArch64Insn insn,
     tcg_out32(s, insn | tcg_cond_to_aarch64[c] | (imm19 & 0x7ffff) << 5);
 }
 
+static void tcg_out_insn_3205(TCGContext *s, AArch64Insn insn,
+                              TCGReg rt, int imm6, int imm14)
+{
+    insn |= (imm6 & 0x20) << (31 - 5);
+    insn |= (imm6 & 0x1f) << 19;
+    tcg_out32(s, insn | (imm14 & 0x3fff) << 5 | rt);
+}
+
 static void tcg_out_insn_3206(TCGContext *s, AArch64Insn insn, int imm26)
 {
     tcg_out32(s, insn | (imm26 & 0x03ffffff));
@@ -1415,41 +1441,65 @@ static inline void tcg_out_goto_label(TCGContext *s, TCGLabel *l)
 static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
                            TCGArg b, bool b_const, TCGLabel *l)
 {
-    intptr_t offset;
+    int tbit = -1;
     bool need_cmp = true;
 
     switch (c) {
     case TCG_COND_EQ:
     case TCG_COND_NE:
+        /* cmp xN,0; b.ne L -> cbnz xN,L */
         if (b_const && b == 0) {
             need_cmp = false;
         }
         break;
+    case TCG_COND_LT:
+    case TCG_COND_GE:
+        /* cmp xN,0; b.mi L -> tbnz xN,63,L */
+        if (b_const && b == 0) {
+            c = (c == TCG_COND_LT ? TCG_COND_TSTNE : TCG_COND_TSTEQ);
+            tbit = ext ? 63 : 31;
+            need_cmp = false;
+        }
+        break;
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        /* tst xN,1<<B; b.ne L -> tbnz xN,B,L */
+        if (b_const && is_power_of_2(b)) {
+            tbit = ctz64(b);
+            need_cmp = false;
+        }
+        break;
     default:
         break;
     }
 
     if (need_cmp) {
         tcg_out_cmp(s, ext, c, a, b, b_const);
-    }
-
-    if (!l->has_value) {
         tcg_out_reloc(s, s->code_ptr, R_AARCH64_CONDBR19, l, 0);
-        offset = tcg_in32(s) >> 5;
-    } else {
-        offset = tcg_pcrel_diff(s, l->u.value_ptr) >> 2;
-        tcg_debug_assert(offset == sextract64(offset, 0, 19));
+        tcg_out_insn(s, 3202, B_C, c, 0);
+        return;
     }
 
-    if (need_cmp) {
-        tcg_out_insn(s, 3202, B_C, c, offset);
+    if (tbit >= 0) {
+        tcg_out_reloc(s, s->code_ptr, R_AARCH64_TSTBR14, l, 0);
+        switch (c) {
+        case TCG_COND_TSTEQ:
+            tcg_out_insn(s, 3205, TBZ, a, tbit, 0);
+            break;
+        case TCG_COND_TSTNE:
+            tcg_out_insn(s, 3205, TBNZ, a, tbit, 0);
+            break;
+        default:
+            g_assert_not_reached();
+        }
     } else {
+        tcg_out_reloc(s, s->code_ptr, R_AARCH64_CONDBR19, l, 0);
         switch (c) {
         case TCG_COND_EQ:
-            tcg_out_insn(s, 3201, CBZ, ext, a, offset);
+            tcg_out_insn(s, 3201, CBZ, ext, a, 0);
             break;
         case TCG_COND_NE:
-            tcg_out_insn(s, 3201, CBNZ, ext, a, offset);
+            tcg_out_insn(s, 3201, CBNZ, ext, a, 0);
             break;
         default:
             g_assert_not_reached();
-- 
2.34.1


