Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D25F433D0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 23:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD9oD-00037W-Ub; Wed, 15 Apr 2026 19:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wD9oC-000378-Du
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 19:38:12 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wD9o9-0003a6-2S
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 19:38:12 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2b2503753efso64593305ad.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 16:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776296287; x=1776901087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dnq+0tXS4eFr2sdhjjScGLl4PxiJMF49NMAjxhNB8Xw=;
 b=Yv40ksUM0I72HZL87Oyxtu3UPaA0+NUNfxgYBPpFHjQhgKrMvHd8Kr0dUlqj3w4t+g
 2sophxWUwMVHZhjupOjfhL7APW1RfV9lkHWn2sJ/e7tKFjlUplG+HMbC5PPCKeEXH3Yh
 GE2bCrvTv8kQpObRsWN65I4GFPb98FPDZu1O7Vb8qsCk0ycbMCvlc6egIz+ZHJx7rTaW
 fvmW611wW8B2N5jO3kcgk1t5j0O8PO98euJxRKSwUdxNIqAo9i6UHVxJwydFGXP7UjFx
 biGTS08F4eRVJo2m9g5eYe/XtHG4IDix+1tYqYrgkbpooNWFN7nrd0FRfgL8t1nrIraQ
 1Nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776296287; x=1776901087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dnq+0tXS4eFr2sdhjjScGLl4PxiJMF49NMAjxhNB8Xw=;
 b=W9wPPRU6cUIxMBVvKm3PZMZl1tOJjzf1Oe1X1bdp1BGKxoN5/dA/j0vIkqhYeKzDEu
 QiLVF2w4DVmU5VLPKCPKH5sg58wvJ53MabOwfJErYDVPuRe2hfTUDjV8/4ESy8srtb+x
 ikmj4MF2j1zqOQrgqhJqYgPQgds9A4y2gBhbE3deIsZjgD2xfwrRP8uUYPTRKfLjdFj5
 G72IEpnGYNrsBnduajO69o1GKzaPiWI8wA6yxBiP8VraXoVjDftwgAlapyHD6o/3g/X4
 +VFKG8/8tpu5Gm1JSLwA1BWo9JDCRri8bLdb0Q+41n1/uKudxLXHXpoHmbyqW3MDiA9b
 ia5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9CQgeyT4DIJQOiQ/5YI3rLwz3zFakp5fzCTEaiIwwqfCyectod/CUjnW7E/21PYJB08PyuHRpnmlVD@nongnu.org
X-Gm-Message-State: AOJu0YzzrhhPMQwKpOnHnRknbyBKuJjper3dyJ/B2mnZhq7YNlmlwdCR
 EtvYuQfRIyd1yM71/R6o8CEvvCaEYDkF1gjlgKK7nFZ9j6V9KuM+8h67
X-Gm-Gg: AeBDieuqt+Nq0RnJYrTJyX60uxAGUg/AP5vTQz/LnDECmbzeZvaEL/s4WthlE9PZOZO
 Fglbp4eeVCDz7WFWQ8lidgH439WKvA/M/nPDloOF8/SaoO36zXgdXUX4skHF9QCLN7Ro2VV7GmT
 E29m+twqvRjAEWieWEOaKj49Il6yF9P/NaxvnYP40tX2fv8QJumV1YfHRPz2rnY2ARB987LHpxm
 sum9mIIRq+E/uPb+Ni0UXMvAIOTl2JdHRddYetJN5Bwa+rkEkrn7fL+GaOuMB5vMnGKqR508Y1l
 WYgHyrDqkBpUxB7xgxEe1KFwHfBaPJDn8Chy/VSbxTPfplWZCdBtVpu8/YyIe5tpuWHr9llNAmf
 flA5yRqVv+cWjXhkCKCdenaiy7L6ZfDX7eoZj1W6JF1qLg/FDWjudXv16ABY4GbuI+JSjqwUIaH
 Z0YIUFUG0dYbOrbs6AVg02fDELflUpWedvfwuJZiXT
X-Received: by 2002:a17:902:76c3:b0:2b0:52b7:e82 with SMTP id
 d9443c01a7336-2b2d59a49fbmr183354235ad.16.1776296287400; 
 Wed, 15 Apr 2026 16:38:07 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b47826ea53sm32341675ad.52.2026.04.15.16.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 16:38:06 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 1/4] target/riscv: Generate access fault if sc comparison
 fails
Date: Thu, 16 Apr 2026 09:37:37 +1000
Message-ID: <20260415233740.3027321-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415233740.3027321-1-alistair.francis@wdc.com>
References: <20260415233740.3027321-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alistair Francis <alistair.francis@wdc.com>

The RISC-V spec states:

"For the purposes of memory protection, a failed SC.W may be treated
like a store."

So if the comparison in sc.w fails we should still check for alignment
and do a probe access to check permissions.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3323
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3136
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/helper.h                   |  3 +++
 target/riscv/op_helper.c                | 14 ++++++++++++++
 target/riscv/insn_trans/trans_rva.c.inc |  6 ++++++
 3 files changed, 23 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b785456ee0..fa16ab2b82 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1289,3 +1289,6 @@ DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(ssamoswap_disabled, void, env)
 #endif
+
+/* Zalrsc SC write probe */
+DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 6ccc127c30..b569366369 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -281,6 +281,20 @@ void helper_cbo_inval(CPURISCVState *env, target_ulong address)
     /* We don't emulate the cache-hierarchy, so we're done. */
 }
 
+void helper_sc_probe_write(CPURISCVState *env, target_ulong addr,
+                           target_ulong size)
+{
+    uintptr_t ra = GETPC();
+    int mmu_idx = riscv_env_mmu_index(env, false);
+
+    if (addr & (size - 1)) {
+        env->badaddr = addr;
+        riscv_raise_exception(env, RISCV_EXCP_STORE_AMO_ADDR_MIS, ra);
+    }
+
+    probe_write(env, addr, size, mmu_idx, ra);
+}
+
 #ifndef CONFIG_USER_ONLY
 
 target_ulong helper_sret(CPURISCVState *env)
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index a7a3278d24..62c0fe673d 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -90,6 +90,12 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
      */
     TCGBar bar_strl = (ctx->ztso || a->rl) ? TCG_BAR_STRL : 0;
     tcg_gen_mb(TCG_MO_ALL + a->aq * TCG_BAR_LDAQ + bar_strl);
+    /*
+     * "For the purposes of memory protection, a failed SC.W may be treated
+     * like a store." so let's check the write access permissions
+     */
+    gen_helper_sc_probe_write(tcg_env, src1,
+                              tcg_constant_tl(memop_size(mop)));
     gen_set_gpr(ctx, a->rd, tcg_constant_tl(1));
 
     gen_set_label(l2);
-- 
2.53.0


