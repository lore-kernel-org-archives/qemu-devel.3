Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B810C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmSG-0001DN-Fn; Fri, 02 Feb 2024 00:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSE-0001Cu-Ok
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:10 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSC-0001iJ-VH
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:10 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6dfc321c677so1288317b3a.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853067; x=1707457867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RnZ4z27JEwUmWsta9h8D7ESSdJL0MTSBNlDpkb4+YYg=;
 b=w2b6fwvy2N2HepF4d2jx/bQiNQH4RXRm5SMFpgFrfbbvSlT6VarHBLEBsmFsELt0ks
 6xRJ8aUPlPgNjtLTgx4cH14mcAGkD9/2Ji8G4CXx1gAKQw9l/UmwF2q1J55p4n2GIKGv
 LobTArNHn+kGnm7huoR0gC12KVhijblPrg09FLviKN/NjZOfsv0NDivlq2FunA07Y6FN
 ltU7HzWWH66su+AT+H8TvO+IbIj89BBqTnI3+AnY6aaMcCWgrmKfN1xj8QqXnkcTNaB9
 BquBU2ys7kuz2ifsBuTb31obsxr6KGIAwEzw75ewt1cJD8PzbOFebzBiY7Kyf1NUZyJa
 OhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853067; x=1707457867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RnZ4z27JEwUmWsta9h8D7ESSdJL0MTSBNlDpkb4+YYg=;
 b=uO97eO4IBgJtDT7FbPN7SwmyFF64wFxLKTrlL8hi2MQBa13tcqIoYjIMbgPOFPk3Lp
 Pq4dzMzjfvbt2dsOKlcJ+0HF1YY38oHgnUV4VJU16V7qQfeoy3ulZdtYAlNNwA/78jiH
 mdEoDwDd7mQSlrMXPhS9q8A57rHS55ChhvIHaoVMnmKaz67sWzwr6ywHGHHfKjr/HgHm
 70XcQpif2q8ocgJyDN7q4GonMZR/M/ONZcT3W4R72+cWwV3drGiNisObNRSqQD6WQtgV
 ekFAb6QHPjV4mnjpTIZE4KXch+kbEtN3aGhvp1fUhofQqsdk4fzLmsL3/t4ki/EjwGr6
 rqDA==
X-Gm-Message-State: AOJu0YywlbPWosRZk742zs+5ZMyAsFeWgT4J8MqM+wPft22lKQd73t+U
 yu3exNSzPn+PcEqOJHmMx5byOYA8VLMEtx75mIwb+wNZHH6a+KXSVUJHSsrVoreVjEgBkQf1GTH
 +cTA=
X-Google-Smtp-Source: AGHT+IGxhQIgc72bx7QdzDED5VEYIXtelv1gx6eKgmlS55EKFPreYPXuBDrZUO9suVobJPDRgxOZAw==
X-Received: by 2002:a05:6a00:1491:b0:6dd:892f:e2a6 with SMTP id
 v17-20020a056a00149100b006dd892fe2a6mr1821005pfu.23.1706853067761; 
 Thu, 01 Feb 2024 21:51:07 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/57] target/loongarch: Rename MMU_IDX_*
Date: Fri,  2 Feb 2024 15:49:51 +1000
Message-Id: <20240202055036.684176-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The expected form is MMU_FOO_IDX, not MMU_IDX_FOO.
Rename to match generic code.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/cpu.h                                 | 8 ++++----
 target/loongarch/cpu.c                                 | 2 +-
 target/loongarch/tcg/tlb_helper.c                      | 4 ++--
 target/loongarch/tcg/translate.c                       | 2 +-
 target/loongarch/tcg/insn_trans/trans_privileged.c.inc | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 5dfcfeb3a4..47fd110e81 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -404,15 +404,15 @@ struct LoongArchCPUClass {
  */
 #define MMU_PLV_KERNEL   0
 #define MMU_PLV_USER     3
-#define MMU_IDX_KERNEL   MMU_PLV_KERNEL
-#define MMU_IDX_USER     MMU_PLV_USER
-#define MMU_IDX_DA       4
+#define MMU_KERNEL_IDX   MMU_PLV_KERNEL
+#define MMU_USER_IDX     MMU_PLV_USER
+#define MMU_DA_IDX       4
 
 int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch);
 static inline int cpu_mmu_index(CPULoongArchState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
-    return MMU_IDX_USER;
+    return MMU_USER_IDX;
 #else
     return loongarch_cpu_mmu_index(env_cpu(env), ifetch);
 #endif
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index cbecc63213..139acfe373 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -382,7 +382,7 @@ int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
     if (FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG)) {
         return FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
     }
-    return MMU_IDX_DA;
+    return MMU_DA_IDX;
 }
 
 static void loongarch_la464_initfn(Object *obj)
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 449043c68b..65ffbef08e 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -188,8 +188,8 @@ static int get_physical_address(CPULoongArchState *env, hwaddr *physical,
                                 int *prot, target_ulong address,
                                 MMUAccessType access_type, int mmu_idx)
 {
-    int user_mode = mmu_idx == MMU_IDX_USER;
-    int kernel_mode = mmu_idx == MMU_IDX_KERNEL;
+    int user_mode = mmu_idx == MMU_USER_IDX;
+    int kernel_mode = mmu_idx == MMU_KERNEL_IDX;
     uint32_t plv, base_c, base_v;
     int64_t addr_high;
     uint8_t da = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, DA);
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 235515c629..58674cb268 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -125,7 +125,7 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
     if (ctx->base.tb->flags & HW_FLAGS_CRMD_PG) {
         ctx->mem_idx = ctx->plv;
     } else {
-        ctx->mem_idx = MMU_IDX_DA;
+        ctx->mem_idx = MMU_DA_IDX;
     }
 
     /* Bound the number of insns to execute to those left on the page.  */
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 01d457212b..7e4ec93edb 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -323,7 +323,7 @@ TRANS(iocsrwr_d, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_d)
 
 static void check_mmu_idx(DisasContext *ctx)
 {
-    if (ctx->mem_idx != MMU_IDX_DA) {
+    if (ctx->mem_idx != MMU_DA_IDX) {
         tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next + 4);
         ctx->base.is_jmp = DISAS_EXIT;
     }
-- 
2.34.1


