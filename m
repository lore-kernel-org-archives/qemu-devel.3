Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207F4D73EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 06:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlhZM-0004bY-Ig; Fri, 30 Jan 2026 01:01:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vlhZJ-0004Vo-P6
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 01:01:21 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vlhZG-0000ni-U7
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 01:01:21 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2a7a94c6d4fso8534335ad.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 22:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769752877; x=1770357677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mm/3dAQBor5aHsIKTr1YNKoYJvIqXNWkdCE6WmE7HoA=;
 b=gBEIrmsxYlTB7WTQaj18uujApfux026QTevSS6j3zF/dm2NRArRIGOwHvpc5yRQZYI
 tj6pBFj6OqOYRv1zXPz0Yc46sz0z7hNKNOaA0Lm5VA5bhlvMwrTZJrkZBmd23zO5uDAU
 H04VEm5zItHfNRJJPYzHwVmMFr4X72Ibd6ZY/CRMIhUzueTQcpHkIDDL2symRffMK0Sh
 OfoFjiBfEj9GFjDyRhKzUHsxzs+505Y7OzeC4/50cgTdFmoJob7CF5XKBJUC3KVr8iQw
 fVejT2woBbtTz0fqNYEbgCEkV8GsoPbmtfEjfz7IeKSrmYeI6UPh33KxG9jUfQFkVg7d
 XkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769752877; x=1770357677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mm/3dAQBor5aHsIKTr1YNKoYJvIqXNWkdCE6WmE7HoA=;
 b=YbhGWFc9B7b58pVcM/NetyFtiTzCvez0PiCwAa+F3QVKueg7umlsUpnAdVeBm9YOqm
 KNaH1BEFDPty5E+WVBhADYbu0ub6C8VANTcu/dOG3+9VLpZfVTXnOKbHz6O/O24UH7iz
 Z4p982/WuqAXqoIyOfX3qtUOL+hbFJYIjCcmob3rTRs4AT/J1+OApKENVOk4tYCwMyCA
 rTGr7VsU9wwb/ywldKSXLqFJflfe/7LJZE/o3/tKrHA7LiWSwxgLTMX2xhRKi3cYL0bi
 vg6VxAu+eoZCE0UbhjpNJCpaX7qtdN3PTJ1214Jp0JOg1eY/j7RNPX2hejBwSVNTudH7
 a/kw==
X-Gm-Message-State: AOJu0YwKfYSsPSmSa7OqObk5otERVls7Qyy7lVZaI/S3xRjpo4EnI6m8
 A9nygqHwL/j8bAs/OIytiEIqb3E+Nvjv5g43JGm0grY3OdK/2VHnoPCA
X-Gm-Gg: AZuq6aKJGjXr0TsFdxtKunf/p0w67yb62NKXKtXMCJsRS0crINz2/KNKe/wJfx2IopN
 jNT+476640d0Q8/l9okThzc3DMERGs63AjvSse1taAuTKxB6uV1mx/+XjqY+kpSuHLqqT3zHwYe
 pwMD/LqEyfJOjDrzj2u/z30hlb/6Gmo2u7Oz5jBGQ5WGbt1+zEgQtElpcOKS/8ufkTa7LX5vYtL
 MbPQm9DKY9sEDHDOoKUXPD25Bsori5fVFMIGG+RYTYLVeErE9ZzaMPOxw0GB2yce1+fMn42UOT0
 QkShFpaBQHarRru/yy0DZsJamaE0hs81pTEy5VpmmumPOHb14E99SmEdLr1Bk9ll9g/gvGAWP6D
 zBBbLFEwA6dPNaClS4ea/R+KlXjzBsHg7WCw5UpL8jiIWQPGMFCDQoyHugGVJbou6mhBMOynTD7
 I3cl+mZcQMLovndTNzVoWq26vxXHyVba4lMS5gUHUPbEScJwYHuZAt0ivw6QW2TmL9hwe7Vg==
X-Received: by 2002:a17:902:9008:b0:2a2:ecb6:545b with SMTP id
 d9443c01a7336-2a8d959c48emr13022385ad.2.1769752876894; 
 Thu, 29 Jan 2026 22:01:16 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.20.181])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b3f6d77sm66274585ad.2.2026.01.29.22.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 22:01:16 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, wangjingwei@iscas.ac.cn,
 devel@lists.libvirt.org, Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v4 4/7] target/riscv: add dret instruction
Date: Fri, 30 Jan 2026 14:00:03 +0800
Message-ID: <e9303b71b70db0669acff4a0dc625285c8ee0a4d.1769751489.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769751489.git.chao.liu.zevorn@gmail.com>
References: <cover.1769751489.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x644.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Add DRET decode/translate and a helper to leave Debug Mode and return
to dpc. Executing DRET outside Debug Mode raises illegal instruction.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/helper.h                          |  1 +
 target/riscv/insn32.decode                     |  1 +
 target/riscv/insn_trans/trans_privileged.c.inc | 18 ++++++++++++++++++
 target/riscv/op_helper.c                       | 16 ++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b785456ee0..6140b6340d 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -131,6 +131,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
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
index 6ccc127c30..99736bbebb 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -454,6 +454,22 @@ target_ulong helper_mret(CPURISCVState *env)
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
2.52.0


