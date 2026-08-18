Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D3AC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCw-0007kV-WB; Tue, 18 Aug 2026 13:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCv-0007jn-E2
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:37 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCt-0004sV-KT
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:37 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cbedf433a99so8360a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072554; x=1787677354; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jZJOaKZTusHHUoW9ISiY/6WK3cLRzqtf2hDDRWECaC4=;
 b=NcxRT4mHTMvfwG+iSeyrscrjF3rm6VmyjLHACxuFh00aNq6qhEQeypF8eFzw5OhJvK
 YvVvylia2KyTWGIZaPYabaD4z5TB1WdeO4GdDY9b7Isj2arw4hkdf6iCLRel/hKLEJkK
 ryPGdeiAaGsBJB+1FCFZIqCM3hVNIYoPUFB4yHAhmRGqevkRPcr4D6hisF+CMD/7fOaz
 96xYicmM0VNRRAr+TG2R+jH/SzXz9QYFgc4YDmfg0gv09VK1pY2rUpu+Y+AORH9d+hVd
 FGEHvIR67fja1vL/5/6UXgJRbid4H11OJiPkv+twF3mR56IM02T2eM9DI/D4yKjYOIjC
 K6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072554; x=1787677354;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jZJOaKZTusHHUoW9ISiY/6WK3cLRzqtf2hDDRWECaC4=;
 b=ZCYy+Fpl4K/RRrex8kcA7dX43SfWt+VJRnaAtnIyKEmY+Ye+zaBQjgtuSxXFJl0qiE
 CBdMbJADZ4DVoAeo1sEtaf8AwbOdFNbOVhHPTHOOwOAXwCgM0XP4mtX3ggrISpTePwSy
 LG7q2/I5qH6Ix3KbJhxo8J4qz3q6yXex/6kil46cRzceXsiBQi+tW1nHBnV/jecJfmhj
 XxpeFZYvsB3+SDwC6lXXVarqRGiUPfCp1wVZIm52LU3XhtXcInhzac3fgTZt/laxY99j
 HqWO6aciddN5cyvq9IFszvlBu1eB4DlRgsbFaQxNbaJ3hrebD4g5EqGG32eO2/9tHFUU
 Kfkg==
X-Gm-Message-State: AOJu0YzvWkqPIzFWxb+WKmctB0tEJwiicAKB2lTkocuo3A0ddZDfZhmV
 zt1tOaqNNQRbW9ER7SGyT2n6HBlFfn8P62uFRIL2EKaHjJyJVAd0X4Ajplo4BnZPbl1mHHtn79p
 H27foCuA=
X-Gm-Gg: AR+sD12GYX9rgMsHAUxb8R2MoaZpsjTZp9yydpyaCKX+nq7+0BnNGnQ/oDHJ/DqdeEe
 SmcvKDZT5tGoEVx6nzImG0IAWjMvBqH2HrYb53i5Vdyr6tOEKr755jGyNuLwZE+N8C6Mko3e94B
 VMIa6cE0lTVPU2XW4I/OOB6N1rZ4x6SGZAhDT6ODCdjE4/yHkhoUCoQ2VK6i+qiI+YVoqSD4mr0
 trjhZljzPEW63caus6wXKrnaIXcuJxLrA6f+xADgl6ml883NZVerPJYqY+rPhPmgJnHUGdoLrjA
 yxG/8yRfZ5U8NYkdPg049t7FVTac5JxDFSwyxMgcKFtpKx8KoCvkSiSbgv1j3/UL6LsVKJG7vtP
 sIxhQlC1ofLiQt4YIi65v7NCplM1lh6E4tt1WoWXEYixgfmWQUnTS9q48edmoAqz3XeVn+cgweC
 0SIfeaBYYO7aUreeCKMhdXp3fqVyBBrmqS8RwHGGjejM2q279pNaby15+pvLJbAceaAC98MZ95H
 ZgOQx7DvPWRlnznYmhCpOAH/Y5IqyMJK7db9cr7xtMexA==
X-Received: by 2002:a05:6a00:2392:b0:848:56d4:3288 with SMTP id
 d2e1a72fcca58-84fddf92abamr36908931b3a.4.1787072554185; 
 Tue, 18 Aug 2026 10:02:34 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 32/38] target/riscv: Enable disassembly via capstone
Date: Tue, 18 Aug 2026 10:01:49 -0700
Message-ID: <20260818170155.1907006-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

In capstone v5, riscv support is spare, but v6 is pretty good.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/capstone.h | 34 +++++++++++++++++
 disas/capstone.c         | 19 ++++++++++
 target/riscv/cpu.c       | 81 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/include/disas/capstone.h b/include/disas/capstone.h
index c43033f7f6..5c78824da2 100644
--- a/include/disas/capstone.h
+++ b/include/disas/capstone.h
@@ -11,6 +11,8 @@
 
 /* Just enough to allow backends to init without ifdefs.  */
 
+#define CS_API_MAJOR     0
+
 #define CS_ARCH_ARM     -1
 #define CS_ARCH_ARM64   -1
 #define CS_ARCH_MIPS    -1
@@ -37,4 +39,36 @@
 #define CS_MODE_MIPS64           0
 
 #endif /* CONFIG_CAPSTONE */
+
+#if CS_API_MAJOR < 5
+#define CS_ARCH_RISCV           -1
+#define CS_MODE_RISCV32          0
+#define CS_MODE_RISCV64          0
+#define CS_MODE_RISCV_C          0
+#elif CS_API_MAJOR == 5
+/* The C symbol name changed between v5 and v6 */
+#define CS_MODE_RISCV_C          CS_MODE_RISCVC
+#endif
+#if CS_API_MAJOR < 6
+#define CS_MODE_RISCV_FD         0
+#define CS_MODE_RISCV_V          0
+#define CS_MODE_RISCV_ZFINX      0
+#define CS_MODE_RISCV_ZCMP_ZCMT_ZCE  0
+#define CS_MODE_RISCV_ZICFISS    0
+#define CS_MODE_RISCV_E          0
+#define CS_MODE_RISCV_A          0
+#define CS_MODE_RISCV_COREV      0
+#define CS_MODE_RISCV_THEAD      0
+#define CS_MODE_RISCV_SIFIVE     0
+#define CS_MODE_RISCV_BITMANIP   0
+#define CS_MODE_RISCV_ZBA        0
+#define CS_MODE_RISCV_ZBB        0
+#define CS_MODE_RISCV_ZBC        0
+#define CS_MODE_RISCV_ZBKB       0
+#define CS_MODE_RISCV_ZBKC       0
+#define CS_MODE_RISCV_ZBKX       0
+#define CS_MODE_RISCV_ZBS        0
+#define CS_MODE_RISCV_VENTANA    0
+#endif
+
 #endif /* QEMU_CAPSTONE_H */
diff --git a/disas/capstone.c b/disas/capstone.c
index 8fb8d0724c..78062339d0 100644
--- a/disas/capstone.c
+++ b/disas/capstone.c
@@ -49,6 +49,20 @@ static const cs_opt_skipdata cap_skipdata_s390x = {
     .callback = cap_skipdata_s390x_cb
 };
 
+/* Similarly for RISCV */
+static size_t CAPSTONE_API
+cap_skipdata_riscv_cb(const uint8_t *code, size_t code_size,
+                      size_t offset, void *user_data)
+{
+    /* See insn_len() from target/riscv/internals.h */
+    return (code[offset] & 3) == 3 ? 4 : 2;
+}
+
+static const cs_opt_skipdata cap_skipdata_riscv = {
+    .mnemonic = ".byte",
+    .callback = cap_skipdata_riscv_cb
+};
+
 /*
  * Initialize the Capstone library.
  *
@@ -76,6 +90,11 @@ static cs_err cap_disas_start(disassemble_info *info, csh *handle)
     cs_option(*handle, CS_OPT_SKIPDATA, CS_OPT_ON);
 
     switch (info->cap_arch) {
+    case CS_ARCH_RISCV:
+        cs_option(*handle, CS_OPT_SKIPDATA_SETUP,
+                  (uintptr_t)&cap_skipdata_riscv);
+        break;
+
     case CS_ARCH_SYSZ:
         cs_option(*handle, CS_OPT_SKIPDATA_SETUP,
                   (uintptr_t)&cap_skipdata_s390x);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 23b5023dd3..e73ff53159 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -39,6 +39,7 @@
 #include "system/tcg.h"
 #include "kvm/kvm_riscv.h"
 #include "tcg/tcg-cpu.h"
+#include "disas/capstone.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "target/riscv/tcg/debug.h"
 #endif
@@ -1099,6 +1100,7 @@ static void riscv_cpu_disas_set_info(const CPUState *s, disassemble_info *info)
 {
     const RISCVCPU *cpu = RISCV_CPU(s);
     const CPURISCVState *env = &cpu->env;
+    int cap_mode;
 
     info->target_info = &cpu->cfg;
 
@@ -1111,16 +1113,93 @@ static void riscv_cpu_disas_set_info(const CPUState *s, disassemble_info *info)
     switch (env->xl) {
     case MXL_RV32:
         info->print_insn = print_insn_riscv32;
+        cap_mode = CS_MODE_RISCV32;
         break;
     case MXL_RV64:
         info->print_insn = print_insn_riscv64;
+        cap_mode = CS_MODE_RISCV64;
         break;
     case MXL_RV128:
         info->print_insn = print_insn_riscv128;
-        break;
+        /* capstone v6 doesn't support RV128 */
+        return;
     default:
         g_assert_not_reached();
     }
+
+    info->cap_arch = CS_ARCH_RISCV;
+    info->cap_insn_unit = 4;
+    info->cap_insn_split = 4;
+
+    /*
+     * Capstone compresses some features together. See RISCV_getFeatureBits,
+     * which maps LLVM feature bits to capstone bits.
+     */
+    if (riscv_has_ext(env, RVC) || cpu->cfg.ext_zca) {
+        cap_mode |= CS_MODE_RISCV_C;
+    }
+    if (riscv_has_ext(env, RVF)) {
+        cap_mode |= CS_MODE_RISCV_FD;
+    }
+    if (riscv_has_ext(env, RVV)) {
+        cap_mode |= CS_MODE_RISCV_V;
+    }
+    if (cpu->cfg.ext_zfinx || cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinx) {
+        cap_mode |= CS_MODE_RISCV_ZFINX;
+    }
+    if (cpu->cfg.ext_zcmp || cpu->cfg.ext_zcmt || cpu->cfg.ext_zce) {
+        cap_mode |= CS_MODE_RISCV_ZCMP_ZCMT_ZCE;
+    }
+    if (cpu->cfg.ext_zicfiss) {
+        cap_mode |= CS_MODE_RISCV_ZICFISS;
+    }
+    if (riscv_has_ext(env, RVE)) {
+        cap_mode |= CS_MODE_RISCV_E;
+    }
+    if (riscv_has_ext(env, RVA)) {
+        cap_mode |= CS_MODE_RISCV_A;
+    }
+    if (cpu->cfg.ext_xlrbr) {
+        cap_mode |= CS_MODE_RISCV_BITMANIP;
+    }
+    if (cpu->cfg.ext_zba) {
+        cap_mode |= CS_MODE_RISCV_ZBA;
+    }
+    if (cpu->cfg.ext_zbb) {
+        cap_mode |= CS_MODE_RISCV_ZBB;
+    }
+    if (cpu->cfg.ext_zbc) {
+        cap_mode |= CS_MODE_RISCV_ZBC;
+    }
+    if (cpu->cfg.ext_zbkb) {
+        cap_mode |= CS_MODE_RISCV_ZBKB;
+    }
+    if (cpu->cfg.ext_zbkc) {
+        cap_mode |= CS_MODE_RISCV_ZBKC;
+    }
+    if (cpu->cfg.ext_zbkx) {
+        cap_mode |= CS_MODE_RISCV_ZBKX;
+    }
+    if (cpu->cfg.ext_zbs) {
+        cap_mode |= CS_MODE_RISCV_ZBS;
+    }
+    if (cpu->cfg.ext_xtheadba ||
+        cpu->cfg.ext_xtheadbb ||
+        cpu->cfg.ext_xtheadbs ||
+        cpu->cfg.ext_xtheadcmo ||
+        cpu->cfg.ext_xtheadcondmov ||
+        cpu->cfg.ext_xtheadfmemidx ||
+        cpu->cfg.ext_xtheadfmv ||
+        cpu->cfg.ext_xtheadmac ||
+        cpu->cfg.ext_xtheadmemidx ||
+        cpu->cfg.ext_xtheadmempair ||
+        cpu->cfg.ext_xtheadsync) {
+        cap_mode |= CS_MODE_RISCV_THEAD;
+    }
+    if (cpu->cfg.ext_XVentanaCondOps) {
+        cap_mode |= CS_MODE_RISCV_VENTANA;
+    }
+    info->cap_mode = cap_mode;
 }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.43.0


