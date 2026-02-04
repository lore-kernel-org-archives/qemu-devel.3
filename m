Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655CEE8B39B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVHq-0007aN-Bl; Wed, 04 Feb 2026 00:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHl-0007Yf-VF
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:42 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHk-000828-1P
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:41 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-34be2be4b7cso3396416a91.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770182318; x=1770787118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4xhjFhewDZ8HVtK25LyUvnhiok1WWrm6V2kKzv9k0BU=;
 b=IsB20SgxaLVeKw0u47znyZuDqjajXYMo7cCVQ4Ks+4BgX/TewXRQSiacKkVhKU5/gB
 +xOVbGarM95f38Q7aaSHHK+3YE5YeeDBBT+Kf3xxj4YlmTP8L2d5r1KAbhHVv/YxMmzk
 0Cm+7fQISUQQ2pRJHla+fv0kA1zx1YQkoOoL9wHWepvpbFfGwwZB3QRk2ASFBJSPAvxA
 h2V/5wnnYDL2PLutvIEJ+xHQB0GymB2bQee1s5F2VSSK9MWSJN3oEYfWY5jNb4gellPG
 D0JNAMo29ZEh2v71ZEC/1JILU97ISu8REzM5VFaVtv6JJXn/RMVKgYxucTknIe3HOlhP
 1VjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182318; x=1770787118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4xhjFhewDZ8HVtK25LyUvnhiok1WWrm6V2kKzv9k0BU=;
 b=toBtYdOEyb6+5DIdcansYHWmAF+mPM+43YHmoXsO/pIOqKXCXUtP13AD7rNMiM5afl
 iYjI4SPYFVV4JLiP5RUlMW7r8Izxi3pnWvhBhuhoJuWUg+p4j31fFNXVBUqM4kouZnPX
 zyiDNQhfiYLWxfeiQwIBJl54W2IBAkbnW5S7jFbrSADUo9j80IuUPtiKSfITH+mCsZkN
 bKTSqgHJzd5pPw22u+0t4euuYirQlxwfo28XeBPBSKIaNQxeCf5yyBBrHH0vC/29FbLA
 8sObcN3Az0mK2873qTfVUUL/h2u908hj5/OfC7mreRnQ7XkDff4v5pI7IcJXKNJyaTfb
 3tdA==
X-Gm-Message-State: AOJu0YwZRG9xRELOHsNMIG5Y/P//cBUZ2nUP0AQHHk7l176Z7+MntLtH
 3rkiSmDPF0ASKP36ZgtB+rHzV2YcC4X6Snqh1EMmFJfuoRn9S9YB9aItA+pKiLGHlRNSTYbDGQ6
 sJaZ8wjgn/rHj9z8ohV+2/ekVNhh4hi1yqz6j90rQUnXBLkf8FKpAYdbKSOsFDwvn60sWIdTtXJ
 S09PbRrtwFqBnOXItJguQpOhSDyHB70ByPw16UM2yim8BS
X-Gm-Gg: AZuq6aJIcp+N9IMZlme1mFtlPhb8p8f/aB7o9w+PdUeN9NX4SAry51TSUBQzpGEAwy8
 5DkjEwQLzseRopTsvoewelA1isV23JZnRlCewcanMvW7XXjxjGOK0b5dDSruJv3xt9zqiF6QPDm
 upkN2BbZc8khOoEMWioXy+jDFqn+xQXtSQYPlsb3UliOdVIwlMnIISVvYIxewTwIKy6AZTfJeY3
 IZc3E8W/akK3DFQqKsKXL2UnpfredWZzCEm0msEaqffRqXDKtFE6jGLfDGb3g8ZH7+nRncAAb5a
 Koogt5hV3gH+fXIpcfSWBaStj8NPQ9dHKfGX03ZTvyNzbklTJHgh8t6onD48uuAhnWncJhlbgBV
 e5xHqQpCnq6l9COTeUwmuyITjlgQ+/s4/DwsyTlSWyB57Ts4ADvtvXrI+X8di+zNy3F7DGVri8Z
 ltnhBbrPUGhoVErv8kAOvzONsnfwFwckONOg0FtH5lL4KBgkTiS1bQx/P6yAq6CVfFlIDBE/PMY
 vXa+DbNEP0vzLg=
X-Received: by 2002:a17:90b:5348:b0:340:ec8f:82d8 with SMTP id
 98e67ed59e1d1-354870e9703mr1628842a91.12.1770182318088; 
 Tue, 03 Feb 2026 21:18:38 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35485eb8d90sm1266314a91.12.2026.02.03.21.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:18:37 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 11/19] target/riscv: rvv: Add vfncvtbf16.sat.f.f.w
 instruction for Zvfofp8min extension
Date: Wed,  4 Feb 2026 13:17:47 +0800
Message-ID: <20260204051756.667397-12-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204051756.667397-1-max.chou@sifive.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102e.google.com
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
index a1c4b325e5..137022d7fb 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1219,6 +1219,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_privileged.c.inc"
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
+#include "insn_trans/trans_rvofp8.c.inc"
 #include "decode-xthead.c.inc"
 #include "decode-xmips.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
-- 
2.52.0


