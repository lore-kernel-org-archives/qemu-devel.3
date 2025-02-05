Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81CEC02199
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 11:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfdRZ-0004WG-0T; Wed, 05 Feb 2025 06:19:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tfdRR-0004R4-U5
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 06:19:37 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tfdRN-0003yS-1n
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 06:19:36 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-436249df846so45605235e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 03:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738754371; x=1739359171;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ai4agSLdl5RDY3L88ffT/Pu+BD6feT1wu/OKxzbYuzI=;
 b=Ay4WD9tV8oI5zObxXlbDThLE+JveW5TejSVUpDXwcKBGlogwViPA+8u3vsbJsH7/fU
 LlL1Qpi3xafGPkUZCKq0HbITNy5WuylDANLsps4hGzlp0YCdB/1UGFOOAJxNlyg7rXJ+
 cJbvKJ8G40d9FNhF4w881Ety0TyNQpBz/9KAoKr5cI/+H+n0fsmmqiHiAO0lyNnhduAU
 +rHqLToVx0ZDgozEZtc5ap0z+5j0T5kh3liYqfjua/aAgKecDSslqYcP3PJJQk2nxXRm
 E1q4GGQGqDeb0JJ59uCNUfnTrJQmyy907F6R5g9MCM7rjvPejwQEP6Ije/QwwCxH1DVI
 C6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738754371; x=1739359171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ai4agSLdl5RDY3L88ffT/Pu+BD6feT1wu/OKxzbYuzI=;
 b=sQ5TvIS+mSluCwkgA5srY0uvKqhnDluUn/xlUSq8ms3HI+8PEABBZ4DAdChfq7M+ld
 M+BpGevV0//I6GaewKgStccmSdQteji897d8WUARiJ7D53Z472S9UXRAcYZkX/1fQnYQ
 aHFQQJga32/pM9BYkrbtayw93txNrFMK9krZrQZYICd6ixWEjvKt4WHDPCnKqY4lAg30
 EKBFAI5SmxvdcCv5jt2V5Xyd9Zby8A7UDpNKKvXImsp56xGtLCbKT8Ieo9EDMsg9/1rz
 CttEierx3tfJL2hVvBtFyp6rUMlmecexNIaysBTSv6RtCXeWvdHC9IAb+3riza81rHYU
 ZiSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGDX9moA/HM0+gTyMDgqs3aScqadqryclQdEw3JlvWlXzU61O4Ww8f/JJGP022t0jXIXikM5YNjDyf@nongnu.org
X-Gm-Message-State: AOJu0YxOUiO11E7gSpKxVB7sF+w2tuSU6TCmmXyILZM+ZHXNWhzcFlYB
 DJbbWxoaN6a0cHK9Xq4dnJ1qFBLM9aUCa9X0QDykQQLvk51QPYWXZ2kFCEa6zQ0=
X-Gm-Gg: ASbGncuRZdTm59a/gKYnuze2tscP2lUly7iVy27+jewhgMRwd9684J0bNdNqHdGkrqV
 RN/1JAVDEFvT2zUju9F8aSfENeBhQeAtUHX9RFh3UDY8QzaEnC3ocg6Wd9BhK1PWVH36mP9YudP
 YThmTYLagxxPfkCDmQsCoo5+MrzszMzhpqDG2PpwVj9aAwYmPOXRWof++r4p0pQ/+NfdvPvmxYf
 Y2cz5Zjy4k75wuPXutV5Vl0G2Y9wqWMgt00evPZn9BQlyOqmbyPbAULzatkqXwn6G5AcZo+ev0S
 +uBFXDYdFgxP1QZtJng7bZSl+mA=
X-Google-Smtp-Source: AGHT+IFquJhrAdmXzv7fm0X72m75aXxUW7uVS3zuDOGAEooYpVlelgEOzE2/cMjy+nvdiszfcbn7hQ==
X-Received: by 2002:a05:600c:1d0f:b0:434:a525:7257 with SMTP id
 5b1f17b1804b1-4390d591ad1mr14352615e9.21.1738754371270; 
 Wed, 05 Feb 2025 03:19:31 -0800 (PST)
Received: from localhost.localdomain ([51.52.155.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d93382dsm18256575e9.4.2025.02.05.03.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 03:19:31 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, rkanwal@rivosinc.com,
 beeman@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com,
 richard.henderson@linaro.org, bmeng.cn@gmail.com
Subject: [PATCH v6 5/7] target/riscv: Add CTR sctrclr instruction.
Date: Wed,  5 Feb 2025 11:18:49 +0000
Message-Id: <20250205-b4-ctr_upstream_v6-v6-5-439d8e06c8ef@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205-b4-ctr_upstream_v6-v6-0-439d8e06c8ef@rivosinc.com>
References: <20250205-b4-ctr_upstream_v6-v6-0-439d8e06c8ef@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

CTR extension adds a new instruction sctrclr to quickly
clear the recorded entries buffer.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h                             |  1 +
 target/riscv/cpu_helper.c                      |  7 +++++++
 target/riscv/helper.h                          |  1 +
 target/riscv/insn32.decode                     |  1 +
 target/riscv/insn_trans/trans_privileged.c.inc | 11 ++++++++++
 target/riscv/op_helper.c                       | 29 ++++++++++++++++++++++++++
 6 files changed, 50 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2d8212e2fefe21defb4ca007d894f02592ed3c89..88d47f6b4f19efe74afa51bdd1494706ac382b7b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -618,6 +618,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en);
 
 void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
     enum CTRType type, target_ulong prev_priv, bool prev_virt);
+void riscv_ctr_clear(CPURISCVState *env);
 
 void riscv_translate_init(void);
 void riscv_translate_code(CPUState *cs, TranslationBlock *tb,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index afecc822ae7d07a0904f1ec8c223845bbac92523..6225d42a5688f84eb2229a852f34f4a89b0de9fa 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -887,6 +887,13 @@ static void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask,
     }
 }
 
+void riscv_ctr_clear(CPURISCVState *env)
+{
+    memset(env->ctr_src, 0x0, sizeof(env->ctr_src));
+    memset(env->ctr_dst, 0x0, sizeof(env->ctr_dst));
+    memset(env->ctr_data, 0x0, sizeof(env->ctr_data));
+}
+
 static uint64_t riscv_ctr_priv_to_mask(target_ulong priv, bool virt)
 {
     switch (priv) {
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 163121ade599f5ec2682ecea25a59b664593fba3..85d73e492d77f839613ecb6dd73cf1ec2a8f1567 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -132,6 +132,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 DEF_HELPER_1(sret, tl, env)
 DEF_HELPER_1(mret, tl, env)
 DEF_HELPER_1(mnret, tl, env)
+DEF_HELPER_1(ctr_clear, void, env)
 DEF_HELPER_1(wfi, void, env)
 DEF_HELPER_1(wrs_nto, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index a98dab02057648d9dae28eaf9f9ddb00079211e2..6d1a13c82603e47b7c5153389888ceffd13773c9 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -114,6 +114,7 @@
 # *** Privileged Instructions ***
 ecall       000000000000     00000 000 00000 1110011
 ebreak      000000000001     00000 000 00000 1110011
+sctrclr     000100000100     00000 000 00000 1110011
 uret        0000000    00010 00000 000 00000 1110011
 sret        0001000    00010 00000 000 00000 1110011
 mret        0011000    00010 00000 000 00000 1110011
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index ca52405d7da411907f1d52234df955940efdc25d..8a62b4cfcd9f9859bc24fbe4594e79d066df5df8 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -75,6 +75,17 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     return true;
 }
 
+static bool trans_sctrclr(DisasContext *ctx, arg_sctrclr *a)
+{
+#ifndef CONFIG_USER_ONLY
+    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
+        gen_helper_ctr_clear(tcg_env);
+        return true;
+    }
+#endif
+    return false;
+}
+
 static bool trans_uret(DisasContext *ctx, arg_uret *a)
 {
     return false;
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 5a99c47b128caf847df76cd1b534f9fdf15a28a8..f156bfab12da6cb4c1e55a4e94592c1d2d0e0e7c 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -485,6 +485,35 @@ void helper_ctr_add_entry(CPURISCVState *env, target_ulong src,
                         env->priv, env->virt_enabled);
 }
 
+void helper_ctr_clear(CPURISCVState *env)
+{
+    /*
+     * It's safe to call smstateen_acc_ok() for umode access regardless of the
+     * state of bit 54 (CTR bit in case of m/hstateen) of sstateen. If the bit
+     * is zero, smstateen_acc_ok() will return the correct exception code and
+     * if it's one, smstateen_acc_ok() will return RISCV_EXCP_NONE. In that
+     * scenario the U-mode check below will handle that case.
+     */
+    RISCVException ret = smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
+    if (ret != RISCV_EXCP_NONE) {
+        riscv_raise_exception(env, ret, GETPC());
+    }
+
+    if (env->priv == PRV_U) {
+        /*
+         * One corner case is when sctrclr is executed from VU-mode and
+         * mstateen.CTR = 0, in which case we are supposed to raise
+         * RISCV_EXCP_ILLEGAL_INST. This case is already handled in
+         * smstateen_acc_ok().
+         */
+        uint32_t excep = env->virt_enabled ? RISCV_EXCP_VIRT_INSTRUCTION_FAULT :
+            RISCV_EXCP_ILLEGAL_INST;
+        riscv_raise_exception(env, excep, GETPC());
+    }
+
+    riscv_ctr_clear(env);
+}
+
 void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);

-- 
2.34.1


