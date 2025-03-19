Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29E2C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 08:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuoPj-0000Mt-2I; Wed, 19 Mar 2025 04:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuoP4-00085m-Jr
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:03:56 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuoP2-0004Uc-Jz
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:03:54 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-300f92661fcso6882062a91.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 01:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742371431; x=1742976231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRFeyxnlx7B6/bhH6tCMKsSu+jXikzi9UZmWl9GXpsY=;
 b=HR/WPBNJfx1oxTLrvnOK8BxBnNt+rSA8JkHYVw3Y/AkxBJ6KJ56yW1dTehdvUaPpS6
 iE6NE7fxGEh8jTsJE2NPQzfmvO/mNfIA0ZedDv4RYKIr4jyhbVc2trKE9KUTd5C6ITnV
 IULT5izP/wNzFZwDPmzCi5RNAF+WYjCziQ24Hg1IKr7Q3EHa3AVM/cxQ5P4/Xbrw+UbX
 PxJxn9IKqApXRVu4SptTByXcxYRSZJz/vfFUVCuJARjh5qHRDSmeocEFXQiT029CoLhj
 zKBwktIQgd1+yrBEiER+RI1sC54FBol2pufNBVnNJ9mon9QeURG5DHwlla8ylwwOkMqz
 riCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742371431; x=1742976231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IRFeyxnlx7B6/bhH6tCMKsSu+jXikzi9UZmWl9GXpsY=;
 b=bLlPqZ7IlV0URyP1CYU7aqPkN0UlD6Vtjbn9Hf6Xdsz71sPQ3IejZ9UhPWn7HGSPq4
 flc41P8fyz/7jtuLFLBmWjklhK8aTN9KxIU5ME36P65LaaQJCYSbhjoK6apRyx7UXTGF
 D4Yt6T8MI3Qz0lJT3b+eFStZXOATg3GrpGOu1hs4cZ3DJPV7bY8/BwCofLE/HbTtNedM
 XK9zl8KIb3PnBrAURYldMVEX6fCZ3U7gopH74gmCMT58UXYmfyarg83EC28DwXCT0+kh
 aGaU7l4qrMxgcAafNTJP8Mahj6V34mfpmzMRpouW8AOBDLT4/LEZ+s4yDBB8rXZbQqry
 RqtA==
X-Gm-Message-State: AOJu0YxKxoDFtVvCrl5rMMwWQNfqzjKQlixmCFDdK/Z52wd7llnqJeav
 hoa0zYJdpl/kiJvgX6bZxjnfepByTi3vOyGJDXE5QJC3pbCxPfFnsTcVKg==
X-Gm-Gg: ASbGncvl5CWoCCBV3c6kvccDuLYpjJ2vuxQXnXTzazFO9VDELWhgTMzdGxbVAr1Y04/
 CzSyOm6WaX2xDr4n58ddF5GBzmd2TZxxgyNVpUVOXzoWN7DL6oDMxxVWof4Xy+tL1i09sbML9C/
 mzpOhCBQamLOgcDiPmw+P2tCmhjYVtA9915m34OIJNZpGEuWc+VGFWa/O6enl7juB7RC7gZBzMK
 O3nBufQpZNCNhdmiwgKlv17z+k8qpMo6EMaO05RElH6CVarqjMkFspL85tnd7QebHCvpa4ZprQ0
 URk6uvY9EXBI3vCfKP53i+9bpz4NKJjSz5Lcn6SNgeWwLiPBFiLMrrPRHfWQ1bJw5PV9rdMKhew
 KcCBR6OL5SOMHiev9vx2Or5mIh+tWCDYTTcBt/bqCFS2seHnQ
X-Google-Smtp-Source: AGHT+IHzBLNjgxLLSvuWhv1/uuaTros0JCIJbc2zJOzc5842bJYU8qY2h58gEhbs3pC6xVx9UpCVlQ==
X-Received: by 2002:a17:90b:4fc4:b0:301:1c29:a1d9 with SMTP id
 98e67ed59e1d1-301be0925b9mr2790860a91.21.1742371430658; 
 Wed, 19 Mar 2025 01:03:50 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6c8dsm107725255ad.156.2025.03.19.01.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 01:03:50 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yu-Ming Chang <yumin686@andestech.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/10] target/riscv: Add check for 16-bit aligned PC for
 different priv versions.
Date: Wed, 19 Mar 2025 18:03:08 +1000
Message-ID: <20250319080308.609520-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319080308.609520-1-alistair.francis@wdc.com>
References: <20250319080308.609520-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
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

From: Yu-Ming Chang <yumin686@andestech.com>

For privilege version 1.12 or newer, C always implies Zca. We can only
check ext_zca to allow 16-bit aligned PC addresses. For older privilege
versions, we only check C.

Signed-off-by: Yu-Ming Chang <yumin686@andestech.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <174184718265.10540.10120024221661781046-0@git.sr.ht>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h                      | 12 ++++++++++++
 target/riscv/op_helper.c                |  8 ++++++--
 target/riscv/translate.c                |  4 +++-
 target/riscv/insn_trans/trans_rvi.c.inc |  8 ++++++--
 4 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7de19b4183..51e49e03de 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -765,6 +765,18 @@ static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
 }
 #endif
 
+static inline bool riscv_cpu_allow_16bit_insn(const RISCVCPUConfig *cfg,
+                                              target_long priv_ver,
+                                              uint32_t misa_ext)
+{
+    /* In priv spec version 1.12 or newer, C always implies Zca */
+    if (priv_ver >= PRIV_VERSION_1_12_0) {
+        return cfg->ext_zca;
+    } else {
+        return misa_ext & RVC;
+    }
+}
+
 /*
  * Encode LMUL to lmul as follows:
  *     LMUL    vlmul    lmul
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 0d4220ba93..72dc48e58d 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -279,7 +279,9 @@ target_ulong helper_sret(CPURISCVState *env)
     }
 
     target_ulong retpc = env->sepc;
-    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
+    if (!riscv_cpu_allow_16bit_insn(&env_archcpu(env)->cfg,
+                                    env->priv_ver,
+                                    env->misa_ext) && (retpc & 0x3)) {
         riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
     }
 
@@ -357,7 +359,9 @@ static void check_ret_from_m_mode(CPURISCVState *env, target_ulong retpc,
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 
-    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
+    if (!riscv_cpu_allow_16bit_insn(&env_archcpu(env)->cfg,
+                                    env->priv_ver,
+                                    env->misa_ext) && (retpc & 0x3)) {
         riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
     }
 
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index eaa5d86eae..d6651f244f 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -606,7 +606,9 @@ static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
     TCGv succ_pc = dest_gpr(ctx, rd);
 
     /* check misaligned: */
-    if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca) {
+    if (!riscv_cpu_allow_16bit_insn(ctx->cfg_ptr,
+                                    ctx->priv_ver,
+                                    ctx->misa_ext)) {
         if ((imm & 0x3) != 0) {
             TCGv target_pc = tcg_temp_new();
             gen_pc_plus_diff(target_pc, ctx, imm);
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index b55f56a5eb..b9c7160468 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -151,7 +151,9 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
         tcg_gen_ext32s_tl(target_pc, target_pc);
     }
 
-    if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca) {
+    if (!riscv_cpu_allow_16bit_insn(ctx->cfg_ptr,
+                                    ctx->priv_ver,
+                                    ctx->misa_ext)) {
         TCGv t0 = tcg_temp_new();
 
         misaligned = gen_new_label();
@@ -300,7 +302,9 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
 
     gen_set_label(l); /* branch taken */
 
-    if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca &&
+    if (!riscv_cpu_allow_16bit_insn(ctx->cfg_ptr,
+                                    ctx->priv_ver,
+                                    ctx->misa_ext) &&
         (a->imm & 0x3)) {
         /* misaligned */
         TCGv target_pc = tcg_temp_new();
-- 
2.48.1


