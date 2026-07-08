Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41445C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whUzk-000181-J3; Wed, 08 Jul 2026 12:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1whUzi-000179-Ps
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:19:30 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1whUzh-00073W-7A
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:19:30 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2caf228a910so6508165ad.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 09:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783527568; x=1784132368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ig97WpfeXz/888YzMr7xwpyDzcUHfi9CfPRuEEEpI08=;
 b=XQ7cCFCr0Fsu32VuPi/A5f5rjAesY1ZZdmhlx6mosTlc9OwTQMaglVna5OsMeVMdrZ
 dSQf8IDUj9oD0KECJrupslbyeKuz9+PuMCGQs+jJ+h4WbXqqN5Ivc8J653uOvRJMeeFq
 PFA0GBRIx9I8wFEUkEmG2mAehndcSNQhAJJnnfI5xrWe2RSzPqCKtaoF4plZemnnzmuU
 bI6gviWMNInDUN85Xw4SU9qFCrPok+u6Dsfetdfw6+4aIgGCIuWTX5G0D5ptffz/eSjV
 52Y1FMZ8urr5PFtZrqIPw4H2TP/FG2DNwuqzwQJLBMS1wWvl9vM95Cf5j4bEmFkI0jJV
 yNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783527568; x=1784132368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ig97WpfeXz/888YzMr7xwpyDzcUHfi9CfPRuEEEpI08=;
 b=aCtMJAIJeTjsciD+2gYwcqGpbdCzoI15xQ6fHyIMI5f8sNSfGUFZY5/plsIyH873zx
 W8Fzn+sQT5YTXzrNQVrDNuLrpdCvAAIuLZLtU1gN/pn8Fi8ikUytogHobbsmYDAOm4Bc
 5KLRfw+iXGQrakKAh4UouOXN6tZXJ/gWHyTJ+avJeImg/FjlIXc5+yeKwbckf2Mt3hVW
 5VFos3XkOal9Aiv7AEHVFRLn0U8p5EaJGFqo6meLvZNCXvHbblNWcCr046+d2fSAxf6D
 nVqu3IHmUmCdkM8qoEKKLL81RQmNAkncM2fTBhC9JLKJ59v9eU1Qwy7sVMG9H2d06Vdk
 Xv8Q==
X-Gm-Message-State: AOJu0YxO1tp8oYKFkQiWxtxzqSXeOz0+xssEh/XA/ZBz2kTCpLTTLgyN
 bN01m47mH0q9M6XDxgmryXPF6k7P5/CPPP28FzJOWP+mK4LnX0EUR60kG6GHPvIVW2hiPIkRkHJ
 dFDqQpIuySfZ2QMVHZkkhGrGlK988KDsnYiTdvf0MwlaiiSOy037C26+LX/zN6y8MLBiz4lFZBp
 oLT4qs+8B/2inL/tO9yohA0Qlj6MWKYxZP5p+5K9o=
X-Gm-Gg: AfdE7ck9ptbyuStaduAewIUUaBlHMnhwg6IPYa93NqaGTNn4f4ur3mqWnClQfi+LCuC
 3Qhp8ULISKvYMgOPoGr4z7BM1KFnPQLiZCNakSmuqqsQbmcF79ELYxDYSVj9+STSTP9ES4YHTVm
 +HR+wfOzMCQx7/f1/txEnb5Y+YIik5eJpjaGvmmUEoKNEdqetgwxeNYxRVWyP3xDxofihsy7nBf
 SfuXS2xk9tYr/B1N/LcuLGGIEFmrEUgMXLACas67U4AZ+6Edci+RQNqcdPr/S0dmUAExNP3rVXR
 5ABeWfVT1kqx+HAc4cQbkvX3Dc7OS26zxXoeS6AwIVqdX4KHbIT0mYUGi/zWynwjQMCPoB/HlCD
 vCW8R5hdBv2IuMUHjhJTVy0LRkVuMvrvdAmRrNVI1aBTTxXBiQOsAZFY04yrQbwbInsk8NRElQM
 Yr21YR+linEL18vAoyxxYfZQygW+MXle4OQNZa3hlw65Qf9PLfvICLvRDKJvZSCiORKPEip+sd2
 kHIbC5M92Oz44gT
X-Received: by 2002:a17:902:db04:b0:2c9:97a7:3278 with SMTP id
 d9443c01a7336-2ccea483c06mr32743835ad.41.1783527567651; 
 Wed, 08 Jul 2026 09:19:27 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdb56fsm30789265ad.15.2026.07.08.09.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 09:19:27 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 7/9] target/riscv: rvv: Add vfncvtbf16.sat.f.f.w
 instruction for Zvfofp8min extension
Date: Thu,  9 Jul 2026 00:18:57 +0800
Message-ID: <20260708161859.1124848-8-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708161859.1124848-1-max.chou@sifive.com>
References: <20260708161859.1124848-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The vfncvtbf16.sat.f.f.w instruction converts a vector of 16-bit
floating-point numbers to a vector of 8-bit floating-point numbers with
saturation.
The VTYPE.altfmt field is used to select the format of the 8-bit floating-point
numbers.
* altfmt = 0: BF16 to OFP8.e4m3
* altfmt = 1: BF16 to OFP8.e5m2

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn32.decode                    |  3 ++
 .../riscv/tcg/insn_trans/trans_rvofp8.c.inc   | 42 +++++++++++++++++++
 target/riscv/tcg/translate.c                  |  1 +
 3 files changed, 46 insertions(+)
 create mode 100644 target/riscv/tcg/insn_trans/trans_rvofp8.c.inc

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 21272fdb50..d690dc3bc1 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -973,6 +973,9 @@ vfwcvtbf16_f_f_v  010010 . ..... 01101 001 ..... 1010111 @r2_vm
 vfwmaccbf16_vv    111011 . ..... ..... 001 ..... 1010111 @r_vm
 vfwmaccbf16_vf    111011 . ..... ..... 101 ..... 1010111 @r_vm
 
+# *** Zvfofp8min Extension ***
+vfncvtbf16_sat_f_f_w  010010 . ..... 11111 001 ..... 1010111 @r2_vm
+
 # *** Zvbc vector crypto extension ***
 vclmul_vv   001100 . ..... ..... 010 ..... 1010111 @r_vm
 vclmul_vx   001100 . ..... ..... 110 ..... 1010111 @r_vm
diff --git a/target/riscv/tcg/insn_trans/trans_rvofp8.c.inc b/target/riscv/tcg/insn_trans/trans_rvofp8.c.inc
new file mode 100644
index 0000000000..d28f92e050
--- /dev/null
+++ b/target/riscv/tcg/insn_trans/trans_rvofp8.c.inc
@@ -0,0 +1,42 @@
+/*
+ * RISC-V translation routines for the OFP8 Standard Extensions.
+ *
+ * Copyright (C) 2025 SiFive, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define REQUIRE_ZVFOFP8MIN(ctx) do {        \
+    if (!ctx->cfg_ptr->ext_zvfofp8min) {    \
+        return false;                       \
+    }                                       \
+} while (0)
+
+
+static bool trans_vfncvtbf16_sat_f_f_w(DisasContext *ctx, arg_rmr *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_ZVFOFP8MIN(ctx);
+
+    if (opfv_narrow_check(ctx, a) && ctx->sew == MO_8) {
+        gen_helper_gvec_3_ptr *fn;
+        uint32_t data = 0;
+
+        fn = ctx->altfmt ? gen_helper_vfncvtbf16_sat_f_f_w_ofp8e5m2 :
+                           gen_helper_vfncvtbf16_sat_f_f_w_ofp8e4m3;
+
+        gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
+
+        data = FIELD_DP32(data, VDATA, VM, a->vm);
+        data = FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, ctx->vta);
+        data = FIELD_DP32(data, VDATA, VMA, ctx->vma);
+        tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
+                           vreg_ofs(ctx, a->rs2), tcg_env,
+                           ctx->cfg_ptr->vlenb,
+                           ctx->cfg_ptr->vlenb, data, fn);
+        finalize_rvv_inst(ctx);
+        return true;
+    }
+    return false;
+}
diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index 9684dbe752..aa96316a38 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -1213,6 +1213,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_privileged.c.inc"
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
+#include "insn_trans/trans_rvofp8.c.inc"
 #include "decode-xthead.c.inc"
 #include "decode-xmips.c.inc"
 #include "decode-xlrbr.c.inc"
-- 
2.55.0


