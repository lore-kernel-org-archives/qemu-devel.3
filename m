Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582F5CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGprR-0007Wz-JW; Tue, 13 Oct 2026 23:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGprK-0007JI-MT
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:54 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGprI-0001hA-NU
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:54 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cc1c9879395so1299028a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949251; x=1792554051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2w4PbVTDLPLke88tgeVrGVDCtVHhNNxRQJ/2MKbzQ/4=;
 b=KsmoQLTNClh8sFCg3Xdgsh23/Ns8fflOOm5raE0e8CFZsSF3UjmYFg+9hNgE4TltgA
 4RMDNphFI7VuA7OanHNCAmJ7QEJaNpcrKwsDo4L6+kmFLMgqnmsjGQXmS3gEtZ2XrBFF
 WZZcdx3iIyFgJPygmsb/jDQicDkivlxOAI4LUQ2qAhj6P3GHi5XRIm21ndHMa+dTuA5N
 ovD4xVjoCp28kDaA7wb0GxayUimWbxLcAv7Z2LhEmE6hH0NcKArxg9GWTJ6sym6o0nxe
 Gn2UiCRmap4b1iXctsMYxQDGj40+jr8QtIb8A3qGdmMO6pl7CgWH6WBANXn0eOWkvdoV
 RPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949251; x=1792554051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2w4PbVTDLPLke88tgeVrGVDCtVHhNNxRQJ/2MKbzQ/4=;
 b=KN7lxE9uH/YE3qZX+DF8kBmPms0H/a4HCRJZ+/TtSqJpI7UhVv/frYRlOgwy2mHcne
 HXo/CcAVzG5+lZsDRybYDd2RMs4MASWFqAqJj5y75OxYI59vkMOVMmrlWfQBiSTC3ZXF
 5WJ0sjZVWxx3NmW80tRscEpZfP2wlBgKrRvB/Q2fAMI1cUsM1OU79voxr87+v8tfh935
 rpsqQLoc3BTIB1XrYGEPZAWVIg9/0C2PYo+mKwnGx6UZNx8wzAFdapVXodr82pXmeHHZ
 WWtvrUfFSxunVN3hytGBWT/LxXx8f7Pzu//a6GWqq2RSMgzuKq4o62VdqADfL4RdXwxb
 zMpw==
X-Gm-Message-State: AFq9FYIC8ctjSsrKkm3of9fsVxY2WE6lHhSwXY/0ai9n2bWzFUYptq2N
 uFvIW+ZcrtmG8X1vA8yV3KzIG8nEz6BFuhc85KoHbeIT/n85g9e1TbElC5Oacw==
X-Gm-Gg: AYBFou1wfxoguDHNUkKEd9QnlUF77PJJZVX1LuOtlmF824a5YQL63lWO9Zqlgq5rYDm
 TziM9mMqkk6XAYZDsx1gaL4kIa25TVbWauRU8Sj7/tYWaGlO+wbwTZs+mml8ufob7hLbZb2d0si
 +VWk/u16jACk8B5HwWQVRJn4HIRacfRr57g4aAKORzsRp3AKkXhSfARlVzojEVqUjSxGHge16xz
 VgHzTOdQq4DbYYT7TGvjhsfLxhy04eeZSx2LKlN2ngFdBbjaZqg5fMtv2tVB+ZLj0waRT+29u6X
 e52l2mVWOqfdJaz4MVveTUJhaSwjzJMZAVXSU5DCKqRHvEmLues5VvkJ2i/5WlGJVXd6CJ2avD1
 +hn7KkmvXdetn+UQxcsqPOzVQFbV85US2JElyr4un8qS2cv7xbToWTRTv5z0v706NgaNTyBBOf/
 Rg0r7HRTWmt+zOydbwejd+ss3UATVpSWoSMrfsfKVEwicg/CVBS++oNQWWuLlqt8ynyse0Dp1FA
 hPqxmfac/gBM5ASr4phAUquFdI=
X-Received: by 2002:a17:90a:e70c:b0:39e:6a7e:ee1b with SMTP id
 98e67ed59e1d1-3ab3ad2b1admr10952230a91.39.1791949251283; 
 Tue, 13 Oct 2026 20:40:51 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:40:50 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Nutty Liu <nutty.liu@hotmail.com>
Subject: [PULL 29/52] target/riscv: add dret instruction
Date: Wed, 14 Oct 2026 13:38:44 +1000
Message-ID: <20261014033907.3332383-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Chao Liu <chao.liu.zevorn@gmail.com>

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Add DRET decode/translate and a helper to leave Debug Mode and return
to dpc. Executing DRET outside Debug Mode raises illegal instruction.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20260928195902.2045235-4-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                          |  1 +
 target/riscv/insn32.decode                     |  1 +
 target/riscv/tcg/op_helper.c                   | 18 ++++++++++++++++++
 .../tcg/insn_trans/trans_privileged.c.inc      | 18 ++++++++++++++++++
 4 files changed, 38 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b7acb6fdc9..d7111ff4b2 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -132,6 +132,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
 DEF_HELPER_1(mret, tl, env)
+DEF_HELPER_1(dret, tl, env)
 DEF_HELPER_1(mnret, tl, env)
 DEF_HELPER_1(ctr_clear, void, env)
 DEF_HELPER_1(wfi, void, env)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 288ce8a554..795badc8a7 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -118,6 +118,7 @@ sctrclr     000100000100     00000 000 00000 1110011
 uret        0000000    00010 00000 000 00000 1110011
 sret        0001000    00010 00000 000 00000 1110011
 mret        0011000    00010 00000 000 00000 1110011
+dret        0111101    10010 00000 000 00000 1110011
 wfi         0001000    00101 00000 000 00000 1110011
 sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
 
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index b67c7718db..dbdaa64f5e 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -508,6 +508,24 @@ target_ulong helper_mret(CPURISCVState *env)
     return retpc;
 }
 
+target_ulong helper_dret(CPURISCVState *env)
+{
+#ifdef CONFIG_USER_ONLY
+    riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    return 0;
+#else
+    target_ulong retpc;
+
+    if (!riscv_cpu_cfg(env)->ext_sdext || !env->debug_mode) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
+
+    retpc = env->dpc & get_xepc_mask(env);
+    riscv_cpu_leave_debug_mode(env);
+    return retpc;
+#endif
+}
+
 target_ulong helper_mnret(CPURISCVState *env)
 {
     target_ulong retpc = env->mnepc;
diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
index ebbbb01179..f1a042d57f 100644
--- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
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
-- 
2.55.0


