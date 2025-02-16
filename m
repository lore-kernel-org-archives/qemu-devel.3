Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0ED6C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnyU-0007wG-Bq; Sun, 16 Feb 2025 18:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwr-0004Xc-32
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:17 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwl-0006UD-LH
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:16 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2fc1843495eso4658445a91.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748067; x=1740352867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3LmqZuFxtG12n8SC4iaqG3NkVLVYLVVy1QDpLVQlRQY=;
 b=mpxAoOAPj7YKXqTsliXW/+6vEkc5T/93NIw/oUaxS+FCzg8msQNO562cGnIOoPwFcb
 0LJavFYq55k5riDnSJMmYY8VdvbUNsMxi1k/pO25uXhs6Fi2I2dX9BUIu6ZckFDs7+3n
 OaqAOPY2B7dUzOCzXVQylgoM+jT5Y6UxNlN94zu7hbNH829Zdj112GP2aiESxAwB1h46
 O33EyLQC0ORvqRYITwhUUXpyXKAoHr0YnuOhxLKcaGV/ZDv5v2lb/hOv6Zo+nTUnEwqN
 zSsGAZuRxsGOmxCibH7Mj+kNl0l6l54DspXtIjNrggkMAUsteMYtUZHzHFtOLxkxV2f8
 rsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748067; x=1740352867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3LmqZuFxtG12n8SC4iaqG3NkVLVYLVVy1QDpLVQlRQY=;
 b=BJnAZk+zeueQc7GXujmVxoES/CUKKsSlV0r/zb4A/b/ByWs7YqS6+aNt+8Kd3XcPZG
 g5uz7zxbveZ8tVFJLiv1RtPEIQzRbbE7/g417DsF1r9SP6elWbodueNkVYcLaSqzqVWg
 gGebpQVjte7iBJ6JY4Rw5qLTU5OBPVh3cUbC9IezdodHmywvpZgFLwPd9srVTgsfuy4w
 tLbnI+aqDNrq1jiqMngpVURQ3Zqiy/u/qIK6c9HURp7WdRTBgCzRrKI4brU9V1NrzWr5
 sD+qMOlMNWUgakD5l9ilVVm2e+Wtaao2f4mBRihfGKnCns29zgN9btmwfa/qrZeNYMBz
 NZDA==
X-Gm-Message-State: AOJu0Yyw6yIB1zty30vLG9yMD0JdjU/JC3YRXRSsL/TlAy0zdpowXgVh
 w4yWUAZj/70K9+d1eeqyJEC5tEEjfuZitlzxwTRwMlQs+YK3f4DiNCVrs37aonKHrD3K/XO8J43
 w
X-Gm-Gg: ASbGnct/zbgalbgA2wbcAqb2l6OO2Xy8D0PNRC6wXSXilourruRVrvA/29tCps2xtRP
 BU1gZzcTSriKlZrCjYqOEJte/ybPaYBl1qMHau2L5BA6Ol5wx6hX5azvuvFtw8sfUNJLL5o0foj
 95otaqfzeOBR5nseW9j/4HnPDCSPQCryONOki8EZfHrAvUIl5UOIg+UnQDdAOdmwODIEqhTMzmA
 ZUlV7yUpDKEpX+uuMW1G/LA1jkiaEAh+xxU0YRFBmosBvI5eZHH9mZcQi+CovpGMo8cct6Sm3oT
 wkTGJ6GGBZF40CZXd9IxXsro8uY6lLEuGTj81amm9VYQEik=
X-Google-Smtp-Source: AGHT+IFxoTkCgtYhiQgb0uP/rEZDKrvcTXjbPsv8EkpaKi15cU1m+SPsSDmzO6JLYpyRhVxDE1+rHQ==
X-Received: by 2002:a17:90b:3e8e:b0:2ea:3f34:f190 with SMTP id
 98e67ed59e1d1-2fc41045052mr10920141a91.25.1739748067065; 
 Sun, 16 Feb 2025 15:21:07 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.21.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:21:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 147/162] tcg/tci: Remove support for add2/sub2
Date: Sun, 16 Feb 2025 15:09:56 -0800
Message-ID: <20250216231012.2808572-148-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci/tcg-target-has.h |  8 ++---
 tcg/tci.c                | 66 +++-------------------------------------
 tcg/tci/tcg-target.c.inc | 28 -----------------
 3 files changed, 9 insertions(+), 93 deletions(-)

diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 6063f32f7b..310d45ba62 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -8,13 +8,13 @@
 #define TCG_TARGET_HAS_H
 
 #define TCG_TARGET_HAS_qemu_st8_i32     0
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_add2_i32         0
+#define TCG_TARGET_HAS_sub2_i32         0
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
 #endif /* TCG_TARGET_REG_BITS == 64 */
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/tci.c b/tcg/tci.c
index d65ff2b8f1..a18478a07a 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -179,17 +179,6 @@ static void tci_args_rrrrrc(uint32_t insn, TCGReg *r0, TCGReg *r1,
     *c5 = extract32(insn, 28, 4);
 }
 
-static void tci_args_rrrrrr(uint32_t insn, TCGReg *r0, TCGReg *r1,
-                            TCGReg *r2, TCGReg *r3, TCGReg *r4, TCGReg *r5)
-{
-    *r0 = extract32(insn, 8, 4);
-    *r1 = extract32(insn, 12, 4);
-    *r2 = extract32(insn, 16, 4);
-    *r3 = extract32(insn, 20, 4);
-    *r4 = extract32(insn, 24, 4);
-    *r5 = extract32(insn, 28, 4);
-}
-
 static bool tci_compare32(uint32_t u0, uint32_t u1, TCGCond condition)
 {
     bool result = false;
@@ -370,13 +359,12 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
     for (;;) {
         uint32_t insn;
         TCGOpcode opc;
-        TCGReg r0, r1, r2, r3, r4, r5;
+        TCGReg r0, r1, r2, r3, r4;
         tcg_target_ulong t1;
         TCGCond condition;
         uint8_t pos, len;
         uint32_t tmp32;
         uint64_t tmp64, taddr;
-        uint64_t T1, T2;
         MemOpIdx oi;
         int32_t ofs;
         void *ptr;
@@ -445,9 +433,9 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 #if TCG_TARGET_REG_BITS == 32
         case INDEX_op_setcond2_i32:
             tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &condition);
-            T1 = tci_uint64(regs[r2], regs[r1]);
-            T2 = tci_uint64(regs[r4], regs[r3]);
-            regs[r0] = tci_compare64(T1, T2, condition);
+            regs[r0] = tci_compare64(tci_uint64(regs[r2], regs[r1]),
+                                     tci_uint64(regs[r4], regs[r3]),
+                                     condition);
             break;
 #elif TCG_TARGET_REG_BITS == 64
         case INDEX_op_setcond:
@@ -717,22 +705,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
                 tb_ptr = ptr;
             }
             break;
-#if TCG_TARGET_REG_BITS == 32 || TCG_TARGET_HAS_add2_i32
-        case INDEX_op_add2_i32:
-            tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
-            T1 = tci_uint64(regs[r3], regs[r2]);
-            T2 = tci_uint64(regs[r5], regs[r4]);
-            tci_write_reg64(regs, r1, r0, T1 + T2);
-            break;
-#endif
-#if TCG_TARGET_REG_BITS == 32 || TCG_TARGET_HAS_sub2_i32
-        case INDEX_op_sub2_i32:
-            tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
-            T1 = tci_uint64(regs[r3], regs[r2]);
-            T2 = tci_uint64(regs[r5], regs[r4]);
-            tci_write_reg64(regs, r1, r0, T1 - T2);
-            break;
-#endif
         case INDEX_op_bswap16:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = bswap16(regs[r1]);
@@ -786,24 +758,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ? ctz64(regs[r1]) : regs[r2];
             break;
-#if TCG_TARGET_HAS_add2_i64
-        case INDEX_op_add2_i64:
-            tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
-            T1 = regs[r2] + regs[r4];
-            T2 = regs[r3] + regs[r5] + (T1 < regs[r2]);
-            regs[r0] = T1;
-            regs[r1] = T2;
-            break;
-#endif
-#if TCG_TARGET_HAS_add2_i64
-        case INDEX_op_sub2_i64:
-            tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
-            T1 = regs[r2] - regs[r4];
-            T2 = regs[r3] - regs[r5] - (regs[r2] < regs[r4]);
-            regs[r0] = T1;
-            regs[r1] = T2;
-            break;
-#endif
 
             /* Shift/rotate operations (64 bit). */
 
@@ -952,7 +906,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     const char *op_name;
     uint32_t insn;
     TCGOpcode op;
-    TCGReg r0, r1, r2, r3, r4, r5;
+    TCGReg r0, r1, r2, r3, r4;
     tcg_target_ulong i1;
     int32_t s2;
     TCGCond c;
@@ -1125,16 +1079,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            str_r(r2), str_r(r3));
         break;
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i32:
-    case INDEX_op_sub2_i64:
-        tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
-        info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s, %s, %s",
-                           op_name, str_r(r0), str_r(r1), str_r(r2),
-                           str_r(r3), str_r(r4), str_r(r5));
-        break;
-
     case INDEX_op_qemu_ld_i64:
     case INDEX_op_qemu_st_i64:
         if (TCG_TARGET_REG_BITS == 32) {
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 947aa1aada..35c0c91f3e 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -66,12 +66,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i32:
-    case INDEX_op_sub2_i64:
-        return C_O2_I4(r, r, r, r, r, r);
-
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, r);
     case INDEX_op_qemu_ld_i64:
@@ -346,22 +340,6 @@ static void tcg_out_op_rrrrrc(TCGContext *s, TCGOpcode op,
     tcg_out32(s, insn);
 }
 
-static void tcg_out_op_rrrrrr(TCGContext *s, TCGOpcode op,
-                              TCGReg r0, TCGReg r1, TCGReg r2,
-                              TCGReg r3, TCGReg r4, TCGReg r5)
-{
-    tcg_insn_unit insn = 0;
-
-    insn = deposit32(insn, 0, 8, op);
-    insn = deposit32(insn, 8, 4, r0);
-    insn = deposit32(insn, 12, 4, r1);
-    insn = deposit32(insn, 16, 4, r2);
-    insn = deposit32(insn, 20, 4, r3);
-    insn = deposit32(insn, 24, 4, r4);
-    insn = deposit32(insn, 28, 4, r5);
-    tcg_out32(s, insn);
-}
-
 static void tcg_out_ldst(TCGContext *s, TCGOpcode op, TCGReg val,
                          TCGReg base, intptr_t offset)
 {
@@ -1182,12 +1160,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, opc, args[0], args[1], args[2]);
         break;
 
-    CASE_32_64(add2)
-    CASE_32_64(sub2)
-        tcg_out_op_rrrrrr(s, opc, args[0], args[1], args[2],
-                          args[3], args[4], args[5]);
-        break;
-
     case INDEX_op_qemu_ld_i64:
     case INDEX_op_qemu_st_i64:
         if (TCG_TARGET_REG_BITS == 32) {
-- 
2.43.0


