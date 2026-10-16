Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF51CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWOv-0003ta-U7; Thu, 15 Oct 2026 21:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWMZ-0000iQ-3s
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:01 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWMW-0004KU-VE
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:58 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2e985106c0cso1405445ad.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112635; x=1792717435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IqNmWdUfumJmHLtkIRhAJG61sz9D44uSgTbKusf7GiY=;
 b=jzhLYhtlxOKxaxZVzqEWTablAHeb0r0bbaX81uVhYZxJHa0jTk1aSZH+afEZgUUQa4
 Z/hm2gNibTnTCCOAU0KnheF+sESm0nQHumWCsbUeAKpfpcLOgEsF8Qv7KE/3sUg23KGo
 rnN4tNF2HqNVcM6WpCkwAQCG66HAcwo6zoSX3dgvzY1cjauZ1Q6hzZkKjPkZWOrYiRp7
 8Tq0JTw0Hj065mf+bg/PjUMYFosa/K3UJgx86pjWMRW+DDDdLbw0yAY8qwa2/slQwd6/
 C7E2cKwdLfTivYpq7ZDGQGle3g1D51SCYAjtTM+QLozzXNGGKxSI35fE0mw0dcw/sJAr
 nkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112635; x=1792717435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IqNmWdUfumJmHLtkIRhAJG61sz9D44uSgTbKusf7GiY=;
 b=dbVX/a+yrdotZP5lRh/PyVWvGK5hMsVWUPbFoa3PWH4dG0MWQhVFutDfl50nfpMBLs
 NTliqt0NA+2c+Ugpw3qbkprEdbT5UTGMTOxTCWQ23CKCNa2hltzRvL1xQh2NafIxaz0a
 ZmVeTFCUHGtD3vghNZRh25h0LcuP3QCSJObqnvUIXUE5ZiY4QwJl6+OqVFjEUZ3EsUYK
 UNBiVaLv4I6UL+FRgKNA+eB25R8iLH46Op5PN0EVy20DqIJd1bSGS5H0exkrZFk+LtQ8
 CxcbKZmmcDRna63rXPgpD3zPlnf10rlcLgfU3DGoHN9J/KNUsrz/tAeAk8RvvQJb4+Cb
 wohw==
X-Gm-Message-State: AFq9FYJlPuAUzWCngz9YLHUSsCJw/2XGIOcOCKMx2nq30pT/n38093ph
 Ny3U7GUm12BrYOhuYW5ton79cjC0JgOld86GP4wQ8sMh+ShpqArlOVJ/dJ745Q==
X-Gm-Gg: AYBFou2mIdVTXjSbdKSY0UCMMpzK15eyGJEGj3wAXtbR9O5TW8b3DrbshKYJvTU460I
 w105HU1q2SvNmpIGXYGlmBg8x/XjL3Nk9pliK0v1XAeqII4U8bdiBIBVw6WIycEUJ6PmHVSrG0F
 6asuUJQBLriTCZSv+qU/E/arUFg1W6lgRUBxPL+MLOpL1zsnED7XK+QSKOtKzBba2zIxk+904vm
 Q+UAu1aYwtHRVZGmDpAglovMxFGg6Lg8bdGQDXhT3po/b3d0kFNXJP93Sei9Xw3H2KPfpD4Zql8
 h7QvqczcD7TkJnRjf8SXfj69lTCA1a0i9ISXoVUf6Kn0xY5IwOiFGZEGLEDdVEJmlqsAk0W38hE
 mfNkaC1eBuVsLMwqp9ggL2qcjDNhzuQlDQplkxY2ndgN2WI/6nIFw2lHD1Rf+HrjM3EE/NrqtbN
 XC8EqtUh4ExZncltfcHbSY/L58SjOdD6bY6EZPLNIL3JUPVyNnk/VSD14/MIqzAuxXyeL+P9phH
 Knu2sWlei4QVWdh
X-Received: by 2002:a17:902:d506:b0:2df:aed3:2ac0 with SMTP id
 d9443c01a7336-2e842aa680dmr204742845ad.10.1792112635362; 
 Thu, 15 Oct 2026 18:03:55 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:03:54 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Nutty Liu <nutty.liu@hotmail.com>
Subject: [PULL v2 24/50] target/riscv: add dret instruction
Date: Fri, 16 Oct 2026 11:02:11 +1000
Message-ID: <20261016010237.1102834-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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
index aab92bf132..a790595b40 100644
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
index aa02dae3c9..46b00411ff 100644
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


