Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3E1EF8FE7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmTp-0007sH-FI; Wed, 04 Mar 2026 08:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmSu-00076R-5s
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:43 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmSs-0005HU-9t
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:39 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-82748095963so3457388b3a.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772631636; x=1773236436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TfVuIY4SlpIjzs9W+EVASWSnAdZ3f5gnOncDfXWWIHI=;
 b=CQMjEz4Ko7byqBwqhwX+d4fs/hbVNBeXyFPtuWysBL4Iq74o1+YUMatZHmphTTiv7A
 moJeYdhti+kWEDx7y0h3hDjyHt0KWLImrVXv4jkhQprIlx/v8lU4t6od59Ypr+SErIGb
 MkQUT48ZzoPjF/3M9t9W+jwc7gBPSmaCNbek/FXUsWPsozZofw+S7pkmVICLj3obIP7x
 l7vUqfOTZ3tgDbAVO3OzRZXmTPX3DIO9i+Rb+O8O2hdalVzo5MZw4sohE8eApa47KGYx
 lKCyt2J8psilrzjt94WyXpwZGGnM5bJQl/CLStp4GcxDni2dNzBI4fx232z9qAhYDb2m
 Ni0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772631636; x=1773236436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TfVuIY4SlpIjzs9W+EVASWSnAdZ3f5gnOncDfXWWIHI=;
 b=u/OQhiEqrHpjrWwjQQY56rJiwzcTJvuGe5hBD+MysEthCmRwB15vlhFLWdr7U5NAXe
 L5SBAyAhs3qnNjtR6Knn1Gl1dhGshygMtlQxKW+OQTrypM3hjozuJOqqOEe6iGrztcYs
 aPmoYcyK2GkbOKk8RlWq1tEgY68pvJZrwqBRlLtHZkRRoDqUQOtgvroa6HYoepDJ1UV4
 dTfy20yvcsTk8FuPumqZUzghYq2FJtnClxo4J+utE2owkUO35HXIlewme2JSyrEsbctm
 Wj4MlivqJKdgjsqPC1VM2TGlOlRuoaMJLgMNLp4ZdU8xFG7m4m2F/8+dmS0bKfWIQxsO
 SvnQ==
X-Gm-Message-State: AOJu0YxStV8mFZHKv24DEabYu+A+Si7M7X1dblVimncX3r9Sv8jwPvuT
 uUxmSkt9FsvXAtInt0PCkujTfNtDLD1LfKFUXoilIAeEPuEc2DvE2vF/CDHq0+r0IMwx/KY+F3u
 rlyMGqacS1+yMwypuff79bFa1kbIUKKimin6XdxKSNh1pulR5LzKQKc7KsHnWIrUh6BxQc+NR/C
 RhZGZvhyBmapftobG+lZFrEHk8BY27ZBgC6+A+fgNidw==
X-Gm-Gg: ATEYQzxb+zSZvxlnMGiDa5fFJb/dlCFu1YB3juym58ty35yp40rcUw1KWsfy4CcELJk
 2vl95OrrzToIjsa9z/7TvItH1G5uY9RqY0r30PqMRvJ6xQ+XWIf71ovV49+bz0/4GRvtHuPpcO+
 DAUHFAzIFp009PIJ/mujsyMOY8DyyW+NOHdGDO9UYvfSnR35vtvPMHGeEoOeOKRDqIh4juUzIeb
 eBpbP6K/1sCY1lHuUDgxwX8tWjlCo32iOEgL49HNZaLT6N3doPnwlHVZPW5GXDqTpv81uKchPCf
 FaaiYQ1CJZXmLolr70BJW6aUiqG5FtZQmf8THSqkTNCGimPuDO1GyBQ64nNe7XGLStIqURCGPzC
 MP0bJ0m8bOnREA/KAdFlEXNQ5kVa9gLpvLpVqA52opf3YoS7aTf1P2I4cA+l9fJvE9H0gokuEQx
 w+1jKqZRvf5M2QPnWRjr5Db0f1EZNhScGbxktdZ8qefdJt5OatGU7DK9a3JFbIpnIcOtqWN/WyG
 hKijJNCcLoFV9YEHzuOTUAna6k=
X-Received: by 2002:a05:6a00:12de:b0:827:32dd:59d8 with SMTP id
 d2e1a72fcca58-82972bbdf35mr1706713b3a.16.1772631636366; 
 Wed, 04 Mar 2026 05:40:36 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8297e11bf5dsm251921b3a.28.2026.03.04.05.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:40:35 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 06/14] target/riscv: rvv: Add vfncvtbf16.sat.f.f.w
 instruction for Zvfofp8min extension
Date: Wed,  4 Mar 2026 21:39:58 +0800
Message-ID: <20260304134006.2908449-7-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304134006.2908449-1-max.chou@sifive.com>
References: <20260304134006.2908449-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x435.google.com
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
 target/riscv/insn32.decode                 |  3 ++
 target/riscv/insn_trans/trans_rvofp8.c.inc | 42 ++++++++++++++++++++++
 target/riscv/translate.c                   |  1 +
 3 files changed, 46 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvofp8.c.inc

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6e35c4b1e6..49201c0c20 100644
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
diff --git a/target/riscv/insn_trans/trans_rvofp8.c.inc b/target/riscv/insn_trans/trans_rvofp8.c.inc
new file mode 100644
index 0000000000..d28f92e050
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvofp8.c.inc
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
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index d9df6a35ca..0c546a3aff 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1220,6 +1220,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_privileged.c.inc"
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
+#include "insn_trans/trans_rvofp8.c.inc"
 #include "decode-xthead.c.inc"
 #include "decode-xmips.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
-- 
2.52.0


