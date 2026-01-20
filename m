Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516CAD2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 08:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi72Q-0005VT-SX; Tue, 20 Jan 2026 03:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vi72O-0005QY-ME
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:24:32 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vi72M-00034V-Vh
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:24:32 -0500
Received: by mail-pg1-x541.google.com with SMTP id
 41be03b00d2f7-c551edc745eso2158816a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 00:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768897469; x=1769502269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i1r38n5/smozxAk3MfAzmduskm1/QEC2/wzUy2JGan4=;
 b=QGR3kgRYmQZh7nGWbs5zjaxM3qBSv1e+c6ZSoEtiwvp3lUMqPO7Mp/TbpyMrH0mYtj
 vdC6b6hQa6JevoJ7MAcP7Paa9JImS4e+p/7gfJHk2DktrA+2P9EX4T85sbLBXrYrH2qt
 61oQVkoT6B8gq05YqIc0TU5stYVRU+L29gdKrWlb8Ycd+n0GVZHeAP0BxxeewbUHNeIu
 GoaGwSHd2PrPvMXZJ8+H6tTtwb5cbExqM5sR0QBxs2brlOpG2z4i47d9JtddA0LoqTHL
 6DxjbWwVJ0VmIY3vJpfY4JrZjiJBJa5UK8RH+mTb5BPDbCqokp3CZrH8dGB4NFhVn4fK
 ekGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768897469; x=1769502269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i1r38n5/smozxAk3MfAzmduskm1/QEC2/wzUy2JGan4=;
 b=wFtRXtY0/Yeq/ERbWacliRa3V113SR5CD3b8tJTCeIY5fR/Ylv1HMgCM4iPt9Eu8wU
 6iqgFXVwDVK3Y9NTRA39MXOOO7y1tlcBhvSODSIHUzzAfzwg0/7WQCmQGb4pvsdPAzLh
 drdhWvTFrsZNPuuuGUJvmlBcwz2lMXwP7L/t1i2TOnANMtTK1sHTJo12+bnfZxksmdXv
 SS1PHF2dmg9e400jo2LR3HxBpu8xlYB5mFjzX2x0X/8jyvmd6RcQlzaxFfftCJhDIxyT
 ajVwg20mhlHt0MhE+mUO9eAQ0lijcDaQAPdQMGJfRbtFEiPFKSlB8LTFyajQIPbY8HJo
 T5yA==
X-Gm-Message-State: AOJu0YxZ5VYYe+JoLRvSaPkLUyEyR4pXwpxJqWFtWCo8hmJ7Di6QwXUu
 sSnKo6lgapvM+sShbaVkOGMuOJ78YTcokMktj4wTnQy5MdEv7QzxVp9w
X-Gm-Gg: AZuq6aKtK/Nht+I1pTRmRLcXU9MP4m9jDh3Ef6OoK/Ih6SgRY8A92a05e+y1Cg1g//C
 5wAWGh4obXu2Lf9DdjWop+nx7FKWp/J/MNZqK2hwlLjpoMHdyfre+S5+Pr0lKTlbnlKmKUJhe5e
 Ce89CK3fSwXl0reF7+3DJi6SZvuc7fKfNRwxO8MsfpOzIUwwNt5EoIo888VJfJeeQDK+jUW8my5
 bZMDSUHywQGoMx6h+FbMT/oJL0Xu1vpRZY5gKiK0grGhL3Dv2hSknHhJAVHy9RDV6R+p2WppGaA
 F/lGm99Cd5fAt2Iipxv6fUFcwbN3HTXifpFFJmVmbv8PpaWsKDgwhKUOTr0xpaYVU80yRCcW+Zt
 TdWTJnFCWguZTiZIbH5eHA2PibdY4Tbe2VNDVRknKXrB8ASH5GwaArdjdg7Na9l6FFebwvzWeyv
 EOGt/IIzXKgenMUOEOXIncoKWsJAUuZrCxdSrTGUyRDllANfmAJ1qQI4ZDhA==
X-Received: by 2002:a17:90a:d88b:b0:32e:a8b7:e9c with SMTP id
 98e67ed59e1d1-352c40533cbmr1053201a91.29.1768897469525; 
 Tue, 20 Jan 2026 00:24:29 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.21.37])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35274573a7esm4273592a91.11.2026.01.20.00.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 00:24:29 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v2 4/7] target/riscv: add dret instruction
Date: Tue, 20 Jan 2026 16:24:00 +0800
Message-ID: <a91f8e4fc722d0e65bae7342ba467b716b9ae4e0.1768892407.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768892407.git.chao.liu.zevorn@gmail.com>
References: <cover.1768892407.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pg1-x541.google.com
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
index 162303fb6c..af6f3f4fd5 100644
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
index c58223ebd8..d04b192ad2 100644
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


