Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A5AF3ED4A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 02:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBkS3-0004EQ-Ds; Sat, 11 Apr 2026 22:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wBkS0-0004Do-4k
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 22:21:28 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wBkRy-0008Nb-C1
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 22:21:27 -0400
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-8a00566c11bso42519136d6.2
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 19:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775960485; x=1776565285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKkxfjFo9HpAG1vOAa+x6hJo3pEzWJI2rZ+qLPR4jgw=;
 b=Z9QXLuY06EAYf24uvR+y3zAJO1ndYbmgWFR/4Cu7CfyQBTzidowpwXQFJCNjo77gLw
 uPYgH83tMcd54e09oIyQBOYjnuyvsOBZDJNcRIdtsS2l22xTP6wmU3W6LO4yOGxAeZI0
 pyGpODtgU/syoMtDXQ4SeQymHs+wxJWHdUjX6kJF8Xhya5h6aAq3tRgocnjv/VYzLMB9
 ec3mahrzjac6VgEknmdYsihWMirJot93nCK0Kd6K+V6aXsEv1HZcEAUEjJ3OqCTIGQqv
 wM4l91kUZ+MWtSFLaikrVwZJRw2ZNpG74Ce8ebuRjWELegu7MiHFHzflJnwx6OtXN7Ed
 JZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775960485; x=1776565285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CKkxfjFo9HpAG1vOAa+x6hJo3pEzWJI2rZ+qLPR4jgw=;
 b=F+HloFWeCALnsMaZXAi3nnC7rv7Q8MgRxV/oOTTfel0ye58ond8orRl7nyAhUbaiMC
 RfYfAi5R1bqaDLQDFtG5fUTkEBwv6fDBgYjMO7XrSWRoVmH/ICn7wJe7LHPrJ82tZRvH
 mVR01PgmG1syuTkRpV81ULzdvXv2uQyRsAA9PYI0qPTiCGCqX9ZaUsfkD1857YQd8GL0
 a/NmKJGEd3Xsr6ZNiPJVJxj1dskPijXrelHz3wgsxwxWRCDsyosREcPopkAW3inVH7Za
 SkOmcZ3gob3hnkwCCwFpITJUcr3LE8Z082iNjXy4eytdgpNfmikgaMtb1MO6lDLUbQqR
 e81A==
X-Gm-Message-State: AOJu0Yxyt+E9ObO3EFnBWpgrLgbsjxf7+9Zk3u0h5I2vvgbIvavjoYG+
 qJSz9WdEz0osB39LWO+TDrLdfdzkJAlEUot9mgq9P5gnH3MmHSVwaNTJSqk+hh7iUVaQn9ac
X-Gm-Gg: AeBDiesJQg+gFPLl3UFxnTaJ6rVP8ODxZT2AenqzRF5Y6Z7nvBpyJsOonrk30V9+SOR
 fmHP7moIDiwt0q8lKmHezuZ2fkt+HjFTiEG7ESQmwogcW14NPYlFF9gTzM13x+V6Cq+RAok9BRa
 NUixVa+N3Gi+jbcY7tckuDr3BNVQnHZ1XSAUDCQHdyhsDUQPFwc6cTyqbJosm40m9hlA205cloQ
 kFroAnYzaoXW+215RCZHFyHcTCaz+uSSmAOC8vD+4i7/nU7lLNzRmYFyxXoQwMiKcWFw4Kw1b48
 L90sft1gDs8nylOVbTh5nlSnEeHQ781W23oO5yPQ/7vpDEO56LLih23PZ7tsCOd7+YSvfgEiP2s
 +TmrVy+zoOjVAc48VHkWg1hQrpu58l3gqBbFwLx8RBJFFLNj08LnQNA+RVwyQe5dgdgARaHsf0u
 IcDHaAYCo+6m5JhqUp30n/1kFikIHrgvkETB05srUvppHKL8AdAgQoBc++CUcI/HRZGjg4
X-Received: by 2002:ad4:5949:0:b0:89c:c75a:e83b with SMTP id
 6a1803df08f44-8ac86319c15mr138327616d6.54.1775960485459; 
 Sat, 11 Apr 2026 19:21:25 -0700 (PDT)
Received: from ZEVORN-PC.bbrouter ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8aca05592ecsm15455576d6.29.2026.04.11.19.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 19:21:25 -0700 (PDT)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org, tangtao1634@phytium.com.cn, devel@lists.libvirt.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v6 4/7] target/riscv: add dret instruction
Date: Sun, 12 Apr 2026 10:20:21 +0800
Message-ID: <279d8e6c4bb55ae831f929c105a20c3372de636b.1775959096.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775959096.git.chao.liu.zevorn@gmail.com>
References: <cover.1775959096.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f43;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qv1-xf43.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Add DRET decode/translate and a helper to leave Debug Mode and return
to dpc. Executing DRET outside Debug Mode raises illegal instruction.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 target/riscv/helper.h                          |  1 +
 target/riscv/insn32.decode                     |  1 +
 target/riscv/insn_trans/trans_privileged.c.inc | 18 ++++++++++++++++++
 target/riscv/op_helper.c                       | 16 ++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 54d2331966..c8e76eb116 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -133,6 +133,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
 DEF_HELPER_1(mret, tl, env)
+DEF_HELPER_1(dret, tl, env)
 DEF_HELPER_1(mnret, tl, env)
 DEF_HELPER_1(ctr_clear, void, env)
 DEF_HELPER_1(wfi, void, env)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6e35c4b1e6..4db842d5d9 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -118,6 +118,7 @@ sctrclr     000100000100     00000 000 00000 1110011
 uret        0000000    00010 00000 000 00000 1110011
 sret        0001000    00010 00000 000 00000 1110011
 mret        0011000    00010 00000 000 00000 1110011
+dret        0111101    10010 00000 000 00000 1110011
 wfi         0001000    00101 00000 000 00000 1110011
 sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
 
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 8a62b4cfcd..f8641b1977 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -125,6 +125,24 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a)
 #endif
 }
 
+static bool trans_dret(DisasContext *ctx, arg_dret *a)
+{
+#ifndef CONFIG_USER_ONLY
+    if (!ctx->cfg_ptr->ext_sdext) {
+        return false;
+    }
+    decode_save_opc(ctx, 0);
+    translator_io_start(&ctx->base);
+    gen_update_pc(ctx, 0);
+    gen_helper_dret(cpu_pc, tcg_env);
+    exit_tb(ctx); /* no chaining */
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+#else
+    return false;
+#endif
+}
+
 static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
 {
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index dde40a5549..ce68ee5959 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -440,6 +440,22 @@ target_ulong helper_mret(CPURISCVState *env)
     return retpc;
 }
 
+target_ulong helper_dret(CPURISCVState *env)
+{
+    uintptr_t ra = GETPC();
+#ifdef CONFIG_USER_ONLY
+    riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
+    return 0;
+#else
+    if (!riscv_cpu_cfg(env)->ext_sdext || !env->debug_mode) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
+    }
+    target_ulong retpc = env->dpc & get_xepc_mask(env);
+    riscv_cpu_leave_debug_mode(env);
+    return retpc;
+#endif
+}
+
 target_ulong helper_mnret(CPURISCVState *env)
 {
     target_ulong retpc = env->mnepc;
-- 
2.53.0


