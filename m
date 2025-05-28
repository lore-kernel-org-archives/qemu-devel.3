Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D204C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKByM-0002h9-Cb; Wed, 28 May 2025 04:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvw-00080I-4P
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:46 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvn-0005GP-7W
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:37 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a374f727dbso1821064f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420073; x=1749024873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=feI5pdxTCTZSnDAvHS8LiwX6Kp1+v892kak6sYgi20Q=;
 b=kKwELBzSwDQCM9A/daomcAGdNWKJFgTTbWIKSlKcFc//1VJS2p+iqYVdc2dpjXkHJO
 1ANqkFA9ToX61Djph7gxlD/O3kadM8EVi+eRLqWySFchygjjMh9pEcfbpyG7lWth0XwR
 8hp7wtfAs1zLKE+us96menIXuhzAZfDewUf6SyECcaErreF2Vb5Rs2+9DH76eaBFSnzw
 q9kqZTvbzT37fw81eT7dkOXPOITTBJQt+RbRwrH5JQkEqNxmgEVbGO3+4UySuRLokf0S
 9Mt3/fwyhYZOQWU38wxbMOsGLSNSSwYSj1ppjPdq/nEdf0Dnor6CFJCebRbV6LlxvAXV
 pu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420073; x=1749024873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=feI5pdxTCTZSnDAvHS8LiwX6Kp1+v892kak6sYgi20Q=;
 b=dAmympz9ZdyzIqbozOIHP8y7p9+uA0Ff+5mMmz05I3+YDn0StmBhlnriujgsvRYTgs
 kOtbagUbczkvQI9xLLrENeq8b3UNYVsZOtM3YvqUQEcSNpEb03M69ymvu2egG7CoR5ZJ
 G/7tQEWYTp/Y6ckjKPX4vdeChYushUjr70wvDomcli6jp0XApD0Sg021kRL0dBJgbAFe
 SxxF8knaeGByHl3oggW3nWCILHeZlBWhv+iaH+Pqa968eJFxTW1HU6le4w0xYeJXlfsg
 as2VtY6b0xRaM4765L1SIVPn+CLqf/XEOAu1azoE5vXPmxeo8oqFfQI4k6knMd1UutkR
 Evbw==
X-Gm-Message-State: AOJu0YyOwr+K1DAxCIAbN3hIFhLoi8UFFZS3CcrEJc6Q3V8MJXcJzfkc
 CIlDYSe+G6dK9ocEjtbVM0fMZCvIiKsXHigIi+LSWYbIBdhn5sfQD9wB7c8UyulZnWEbSc9Ccl0
 rZHC3Ou59yg==
X-Gm-Gg: ASbGncsR1QOmlA1j2RbZFve2DlavZnE+2bgIS5tVe3Re8WotdYdm/FKzkRbG6MVqWwH
 0bA4HslIg26kfbAd/NXvwWnGJUUh0GVD6LXcWOzpy4tJV4mCP0cjzXc0L5htcKGD4XtDJwEPA5B
 DXKr5ymMs6D6rdTV1vkdNb8b7ij1gUzR9+CEsXAzd02W1Acv0J6aCP55retK+VtFss3XkXk3pXv
 8D1X1iLmwxAC1rv/cT4JOFS7FUyacQubj6lCn9QYiekQO0SvbypmytmRkGsgYKG8y+yBSeESVSw
 k6jzdnHB+qUj52an21bRGOM42tXwDNWwSNyNznMW3cH8N0OGMrAzH8Q2
X-Google-Smtp-Source: AGHT+IHw8mEYfYxQRYqt8B1LJ45q/Itm4I0uT5FbzNrkdeAdijDSULW4UMmCi0JuXWKNRSUaYSn4Xw==
X-Received: by 2002:a05:6000:250f:b0:3a4:eb0c:409d with SMTP id
 ffacd0b85a97d-3a4eb0c41a4mr689283f8f.13.1748420072791; 
 Wed, 28 May 2025 01:14:32 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/28] tcg: Drop TCGContext.page_{mask,bits}
Date: Wed, 28 May 2025 09:13:57 +0100
Message-ID: <20250528081410.157251-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use exec/target_page.h instead of independent variables.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h                |  3 ---
 accel/tcg/translate-all.c        |  4 ----
 tcg/perf.c                       |  2 +-
 tcg/tcg-op-ldst.c                |  3 ++-
 tcg/tcg.c                        |  1 +
 tcg/aarch64/tcg-target.c.inc     |  4 ++--
 tcg/arm/tcg-target.c.inc         | 10 +++++-----
 tcg/i386/tcg-target.c.inc        |  4 ++--
 tcg/loongarch64/tcg-target.c.inc |  4 ++--
 tcg/mips/tcg-target.c.inc        |  6 +++---
 tcg/ppc/tcg-target.c.inc         | 14 +++++++-------
 tcg/riscv/tcg-target.c.inc       |  4 ++--
 tcg/s390x/tcg-target.c.inc       |  4 ++--
 tcg/sparc64/tcg-target.c.inc     |  4 ++--
 14 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index e440c889c8..125323f153 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -365,9 +365,6 @@ struct TCGContext {
     int nb_indirects;
     int nb_ops;
     TCGType addr_type;            /* TCG_TYPE_I32 or TCG_TYPE_I64 */
-
-    int page_mask;
-    uint8_t page_bits;
     TCGBar guest_mo;
 
     TCGRegSet reserved_regs;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 6735a40ade..d468667b0d 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -312,10 +312,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
 
     tcg_ctx->gen_tb = tb;
     tcg_ctx->addr_type = target_long_bits() == 32 ? TCG_TYPE_I32 : TCG_TYPE_I64;
-#ifdef CONFIG_SOFTMMU
-    tcg_ctx->page_bits = TARGET_PAGE_BITS;
-    tcg_ctx->page_mask = TARGET_PAGE_MASK;
-#endif
     tcg_ctx->guest_mo = cpu->cc->tcg_ops->guest_default_memory_order;
 
  restart_translate:
diff --git a/tcg/perf.c b/tcg/perf.c
index 4e8d2c1bee..8fa5fa9991 100644
--- a/tcg/perf.c
+++ b/tcg/perf.c
@@ -334,7 +334,7 @@ void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
         /* FIXME: This replicates the restore_state_to_opc() logic. */
         q[insn].address = gen_insn_data[insn * INSN_START_WORDS + 0];
         if (tb_cflags(tb) & CF_PCREL) {
-            q[insn].address |= (guest_pc & qemu_target_page_mask());
+            q[insn].address |= guest_pc & TARGET_PAGE_MASK;
         }
         q[insn].flags = DEBUGINFO_SYMBOL | (jitdump ? DEBUGINFO_LINE : 0);
     }
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index fa9e52277b..548496002d 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -27,6 +27,7 @@
 #include "tcg/tcg-temp-internal.h"
 #include "tcg/tcg-op-common.h"
 #include "tcg/tcg-mo.h"
+#include "exec/target_page.h"
 #include "exec/translation-block.h"
 #include "exec/plugin-gen.h"
 #include "tcg-internal.h"
@@ -40,7 +41,7 @@ static void check_max_alignment(unsigned a_bits)
      * FIXME: Must keep the count up-to-date with "exec/tlb-flags.h".
      */
     if (tcg_use_softmmu) {
-        tcg_debug_assert(a_bits + 5 <= tcg_ctx->page_bits);
+        tcg_debug_assert(a_bits + 5 <= TARGET_PAGE_BITS);
     }
 }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ae27a2607d..d714ae2889 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -34,6 +34,7 @@
 #include "qemu/cacheflush.h"
 #include "qemu/cacheinfo.h"
 #include "qemu/timer.h"
+#include "exec/target_page.h"
 #include "exec/translation-block.h"
 #include "exec/tlb-common.h"
 #include "tcg/startup.h"
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 6356a81c2a..3b088b7bd9 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1677,7 +1677,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         /* Extract the TLB index from the address into X0.  */
         tcg_out_insn(s, 3502S, AND_LSR, TCG_TYPE_I64,
                      TCG_REG_TMP0, TCG_REG_TMP0, addr_reg,
-                     s->page_bits - CPU_TLB_ENTRY_BITS);
+                     TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
 
         /* Add the tlb_table pointer, forming the CPUTLBEntry address. */
         tcg_out_insn(s, 3502, ADD, 1, TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_TMP0);
@@ -1703,7 +1703,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             tcg_out_insn(s, 3401, ADDI, addr_type,
                          addr_adj, addr_reg, s_mask - a_mask);
         }
-        compare_mask = (uint64_t)s->page_mask | a_mask;
+        compare_mask = (uint64_t)TARGET_PAGE_MASK | a_mask;
 
         /* Store the page mask part of the address into TMP2.  */
         tcg_out_logicali(s, I3404_ANDI, addr_type, TCG_REG_TMP2,
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 447e43583e..836894b16a 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1427,7 +1427,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
         /* Extract the tlb index from the address into R0.  */
         tcg_out_dat_reg(s, COND_AL, ARITH_AND, TCG_REG_R0, TCG_REG_R0, addr,
-                        SHIFT_IMM_LSR(s->page_bits - CPU_TLB_ENTRY_BITS));
+                        SHIFT_IMM_LSR(TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS));
 
         /*
          * Add the tlb_table pointer, creating the CPUTLBEntry address in R1.
@@ -1463,8 +1463,8 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             tcg_out_dat_imm(s, COND_AL, ARITH_ADD, t_addr,
                             addr, s_mask - a_mask);
         }
-        if (use_armv7_instructions && s->page_bits <= 16) {
-            tcg_out_movi32(s, COND_AL, TCG_REG_TMP, ~(s->page_mask | a_mask));
+        if (use_armv7_instructions && TARGET_PAGE_BITS <= 16) {
+            tcg_out_movi32(s, COND_AL, TCG_REG_TMP, ~(TARGET_PAGE_MASK | a_mask));
             tcg_out_dat_reg(s, COND_AL, ARITH_BIC, TCG_REG_TMP,
                             t_addr, TCG_REG_TMP, 0);
             tcg_out_dat_reg(s, COND_AL, ARITH_CMP, 0,
@@ -1475,10 +1475,10 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                 tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, addr, a_mask);
             }
             tcg_out_dat_reg(s, COND_AL, ARITH_MOV, TCG_REG_TMP, 0, t_addr,
-                            SHIFT_IMM_LSR(s->page_bits));
+                            SHIFT_IMM_LSR(TARGET_PAGE_BITS));
             tcg_out_dat_reg(s, (a_mask ? COND_EQ : COND_AL), ARITH_CMP,
                             0, TCG_REG_R2, TCG_REG_TMP,
-                            SHIFT_IMM_LSL(s->page_bits));
+                            SHIFT_IMM_LSL(TARGET_PAGE_BITS));
         }
     } else if (a_mask) {
         ldst = new_ldst_label(s);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 2990912080..088c6c9264 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2206,7 +2206,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
         tcg_out_mov(s, tlbtype, TCG_REG_L0, addr);
         tcg_out_shifti(s, SHIFT_SHR + tlbrexw, TCG_REG_L0,
-                       s->page_bits - CPU_TLB_ENTRY_BITS);
+                       TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
 
         tcg_out_modrm_offset(s, OPC_AND_GvEv + trexw, TCG_REG_L0, TCG_AREG0,
                              fast_ofs + offsetof(CPUTLBDescFast, mask));
@@ -2225,7 +2225,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             tcg_out_modrm_offset(s, OPC_LEA + trexw, TCG_REG_L1,
                                  addr, s_mask - a_mask);
         }
-        tlb_mask = s->page_mask | a_mask;
+        tlb_mask = TARGET_PAGE_MASK | a_mask;
         tgen_arithi(s, ARITH_AND + trexw, TCG_REG_L1, tlb_mask, 0);
 
         /* cmp 0(TCG_REG_L0), TCG_REG_L1 */
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index e5580d69a8..10c69211ac 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1065,7 +1065,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_AREG0, table_ofs);
 
         tcg_out_opc_srli_d(s, TCG_REG_TMP2, addr_reg,
-                           s->page_bits - CPU_TLB_ENTRY_BITS);
+                           TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
         tcg_out_opc_and(s, TCG_REG_TMP2, TCG_REG_TMP2, TCG_REG_TMP0);
         tcg_out_opc_add_d(s, TCG_REG_TMP2, TCG_REG_TMP2, TCG_REG_TMP1);
 
@@ -1091,7 +1091,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             tcg_out_mov(s, addr_type, TCG_REG_TMP1, addr_reg);
         }
         tcg_out_opc_bstrins_d(s, TCG_REG_TMP1, TCG_REG_ZERO,
-                              a_bits, s->page_bits - 1);
+                              a_bits, TARGET_PAGE_BITS - 1);
 
         /* Compare masked address with the TLB entry.  */
         ldst->label_ptr[0] = s->code_ptr;
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 2c0457e588..400eafbab4 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1199,9 +1199,9 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         /* Extract the TLB index from the address into TMP3.  */
         if (TCG_TARGET_REG_BITS == 32 || addr_type == TCG_TYPE_I32) {
             tcg_out_opc_sa(s, OPC_SRL, TCG_TMP3, addr,
-                           s->page_bits - CPU_TLB_ENTRY_BITS);
+                           TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
         } else {
-            tcg_out_dsrl(s, TCG_TMP3, addr, s->page_bits - CPU_TLB_ENTRY_BITS);
+            tcg_out_dsrl(s, TCG_TMP3, addr, TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
         }
         tcg_out_opc_reg(s, OPC_AND, TCG_TMP3, TCG_TMP3, TCG_TMP0);
 
@@ -1224,7 +1224,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
          * For unaligned accesses, compare against the end of the access to
          * verify that it does not cross a page boundary.
          */
-        tcg_out_movi(s, addr_type, TCG_TMP1, s->page_mask | a_mask);
+        tcg_out_movi(s, addr_type, TCG_TMP1, TARGET_PAGE_MASK | a_mask);
         if (a_mask < s_mask) {
             tcg_out_opc_imm(s, (TCG_TARGET_REG_BITS == 32
                                 || addr_type == TCG_TYPE_I32
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 2e94778104..b8b23d44d5 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2440,10 +2440,10 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         /* Extract the page index, shifted into place for tlb index.  */
         if (TCG_TARGET_REG_BITS == 32) {
             tcg_out_shri32(s, TCG_REG_R0, addr,
-                           s->page_bits - CPU_TLB_ENTRY_BITS);
+                           TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
         } else {
             tcg_out_shri64(s, TCG_REG_R0, addr,
-                           s->page_bits - CPU_TLB_ENTRY_BITS);
+                           TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
         }
         tcg_out32(s, AND | SAB(TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_R0));
 
@@ -2480,7 +2480,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                 a_bits = s_bits;
             }
             tcg_out_rlw(s, RLWINM, TCG_REG_R0, addr, 0,
-                        (32 - a_bits) & 31, 31 - s->page_bits);
+                        (32 - a_bits) & 31, 31 - TARGET_PAGE_BITS);
         } else {
             TCGReg t = addr;
 
@@ -2501,13 +2501,13 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             /* Mask the address for the requested alignment.  */
             if (addr_type == TCG_TYPE_I32) {
                 tcg_out_rlw(s, RLWINM, TCG_REG_R0, t, 0,
-                            (32 - a_bits) & 31, 31 - s->page_bits);
+                            (32 - a_bits) & 31, 31 - TARGET_PAGE_BITS);
             } else if (a_bits == 0) {
-                tcg_out_rld(s, RLDICR, TCG_REG_R0, t, 0, 63 - s->page_bits);
+                tcg_out_rld(s, RLDICR, TCG_REG_R0, t, 0, 63 - TARGET_PAGE_BITS);
             } else {
                 tcg_out_rld(s, RLDICL, TCG_REG_R0, t,
-                            64 - s->page_bits, s->page_bits - a_bits);
-                tcg_out_rld(s, RLDICL, TCG_REG_R0, TCG_REG_R0, s->page_bits, 0);
+                            64 - TARGET_PAGE_BITS, TARGET_PAGE_BITS - a_bits);
+                tcg_out_rld(s, RLDICL, TCG_REG_R0, TCG_REG_R0, TARGET_PAGE_BITS, 0);
             }
         }
 
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index f9417d15f7..1800fd5077 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1706,7 +1706,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_AREG0, table_ofs);
 
         tcg_out_opc_imm(s, OPC_SRLI, TCG_REG_TMP2, addr_reg,
-                        s->page_bits - CPU_TLB_ENTRY_BITS);
+                        TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
         tcg_out_opc_reg(s, OPC_AND, TCG_REG_TMP2, TCG_REG_TMP2, TCG_REG_TMP0);
         tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP2, TCG_REG_TMP2, TCG_REG_TMP1);
 
@@ -1722,7 +1722,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
             tcg_out_opc_imm(s, addr_type == TCG_TYPE_I32 ? OPC_ADDIW : OPC_ADDI,
                             addr_adj, addr_reg, s_mask - a_mask);
         }
-        compare_mask = s->page_mask | a_mask;
+        compare_mask = TARGET_PAGE_MASK | a_mask;
         if (compare_mask == sextreg(compare_mask, 0, 12)) {
             tcg_out_opc_imm(s, OPC_ANDI, TCG_REG_TMP1, addr_adj, compare_mask);
         } else {
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 7ca0071f24..84a9e73a46 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2004,7 +2004,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst->addr_reg = addr_reg;
 
         tcg_out_sh64(s, RSY_SRLG, TCG_TMP0, addr_reg, TCG_REG_NONE,
-                     s->page_bits - CPU_TLB_ENTRY_BITS);
+                     TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
 
         tcg_out_insn(s, RXY, NG, TCG_TMP0, TCG_AREG0, TCG_REG_NONE, mask_off);
         tcg_out_insn(s, RXY, AG, TCG_TMP0, TCG_AREG0, TCG_REG_NONE, table_off);
@@ -2016,7 +2016,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
          * byte of the access.
          */
         a_off = (a_mask >= s_mask ? 0 : s_mask - a_mask);
-        tlb_mask = (uint64_t)s->page_mask | a_mask;
+        tlb_mask = (uint64_t)TARGET_PAGE_MASK | a_mask;
         if (a_off == 0) {
             tgen_andi_risbg(s, TCG_REG_R0, addr_reg, tlb_mask);
         } else {
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 9e004fb511..5e5c3f1cda 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1120,7 +1120,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
     /* Extract the page index, shifted into place for tlb index.  */
     tcg_out_arithi(s, TCG_REG_T1, addr_reg,
-                   s->page_bits - CPU_TLB_ENTRY_BITS, SHIFT_SRL);
+                   TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS, SHIFT_SRL);
     tcg_out_arith(s, TCG_REG_T1, TCG_REG_T1, TCG_REG_T2, ARITH_AND);
 
     /* Add the tlb_table pointer, creating the CPUTLBEntry address into R2.  */
@@ -1136,7 +1136,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     h->base = TCG_REG_T1;
 
     /* Mask out the page offset, except for the required alignment. */
-    compare_mask = s->page_mask | a_mask;
+    compare_mask = TARGET_PAGE_MASK | a_mask;
     if (check_fit_tl(compare_mask, 13)) {
         tcg_out_arithi(s, TCG_REG_T3, addr_reg, compare_mask, ARITH_AND);
     } else {
-- 
2.43.0


