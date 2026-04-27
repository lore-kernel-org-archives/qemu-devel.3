Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAB0FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHFAX-00061c-Bc; Mon, 27 Apr 2026 02:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wHFAL-0005XS-9K
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:09:59 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wHFAJ-0000tb-FM
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:09:56 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-358ed696623so4327965a91.0
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 23:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777270194; x=1777874994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WkmRPpZi05j+i+tKq5//n/+335dDi6qLXvoGPu5RWTU=;
 b=JaldVvF9RRV4kM+xD4v94CnfSbRWYgImu9adG+K2hnXTIN9uLnv5iJCaiKhmfpZncA
 A3fblxNK0B4XvzhM/cZCbiekZEdxAB8r7kPcrWR3dp7PIZnWngS1VdnK55tr/n6Ex8Rb
 SyvnVXjBcF/tLT3V606YQcGGguYp0caTixY7OS/U8Y42z8Ni6sKHMkwjPKqRR1gRVjUr
 4kOYMxIqJifDJ5U3XfqC1WWL6tll4b3Yo3WNo8xwcYXgtdsZd9n7mkiBW4hD/9wSXMgG
 1cDR/q937btEesmKW3+5qYBo/0wdRutxhtyaLWyT0abPOqNhvA2XG0tjqYZDQWv5g540
 JQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777270194; x=1777874994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WkmRPpZi05j+i+tKq5//n/+335dDi6qLXvoGPu5RWTU=;
 b=fXfD0oVdXuRnWocjjFS5O69hwaDLBvkFMkiZo2NgxHqc57CBjzhFnTB+kwKwfecLC2
 dtbawm6oR/pehEPjOu2hipSg+9EgDvnIQusY+jZVDO7hAG8S5PUt0k9ai4s6j/nkjV4i
 iEj8scft8MJFg3c3EdEyDx5kccFJWOWewPlNnWeUc0aftwSZDjk/zDHYnAjW1LHejvwk
 s0RkKh3afC+jknS5BhLhB5wMQhvRTzkRwwcnVQsYIKL8QbntriYLgPj29zkBz3MobDbj
 UeebIRVQ7rgA7RO7y1ab9quNChaVnA1CK+ZWXjjdRyx9Tq9iwDGsZPGrXduLvh7XCc0L
 izQQ==
X-Gm-Message-State: AOJu0YxzOU1fZoIcSVe88qF8BDuBvHRKIsbJkU5ZwbdHP09YM+tyP7an
 bBO9DKbiHtMNvlIRGgCQx41b1r3ZJ6XJ5oF/Y++/9ONgpmyG9GRvluoC/6qqJVKdevXXxf+Td+r
 1uZhNrsKSmZ+1oy3fM3qco+I2j5BFj6BaACGGFjxyJpNbg7CTI629qn1/Ui0vlIrq8UUr92xrwM
 U3Kk/eD3+t1jQvjSKU9hntC7AJ/4eGF7ILDpvO5HY=
X-Gm-Gg: AeBDievh3KXZZ5Xsbd8ZjAJ33xDKlCqkP9FAiz2add8yNnWEblPVIRS/ztYI+biJSUY
 QTjS38ukmG6NF1r8Vj4OxhlAb/ARoIndH4BbrIeZqMqYjTxpCBCAS6DIq2Ob/UwHAhpKZhtBoK6
 rfw7lPGtwKhSknE6q6kAdGpWl7dtUKt+4NwPEuHA3DGWK/dtZrKfC0u138G18AtudycP+SRVNTl
 TwgLuVL7Vdi/yL2nRB5L0ZKiIwzKJ27dSprsXspxZv9OUommniLLfThqJn0VMU4sGpjqpHylyCo
 q+NQvwQOXP0/q+x8/3RHQ0pILuO+KIYdSwe2EPX6IP+Lnlru7QzJWkipF6zIAHi56kozR1D8C8X
 OhRge9dYTi+AkDUkt6btlE6nYmRBVQghVo67c61aZrSqCh5Ba/JC2Yf1cNR/eI/zxpbQPY4DOEp
 nLehpqFpDkRDKp+5RHbzU6EVjzcPWnX2uKBtAdNJVO0PIwXiXleOHt+QG55k9jFPNKnbh+9nXMA
 NTVpKqXcRtVLHA1zXoSgsWzlVODb8VW60gTew==
X-Received: by 2002:a17:90b:4a0a:b0:35e:58d3:3284 with SMTP id
 98e67ed59e1d1-361403e083bmr41767194a91.9.1777270193852; 
 Sun, 26 Apr 2026 23:09:53 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410bac6dsm30290710a91.14.2026.04.26.23.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 23:09:53 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 6/9] target/riscv: rvv: Add vfncvtbf16.sat.f.f.w
 instruction for Zvfofp8min extension
Date: Mon, 27 Apr 2026 14:09:25 +0800
Message-ID: <20260427060928.2322570-7-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427060928.2322570-1-max.chou@sifive.com>
References: <20260427060928.2322570-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102b.google.com
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
index 81087e0a5d..88d6efbc80 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1220,6 +1220,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_privileged.c.inc"
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
+#include "insn_trans/trans_rvofp8.c.inc"
 #include "decode-xthead.c.inc"
 #include "decode-xmips.c.inc"
 #include "decode-xlrbr.c.inc"
-- 
2.52.0


