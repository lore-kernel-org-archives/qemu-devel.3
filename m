Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F0CC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb68-0005iW-DO; Mon, 29 Jan 2024 18:31:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5o-0005Sk-94
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:22 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5l-00051m-VV
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:07 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6de2e24ea87so869034b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571064; x=1707175864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/S1vigBU1gXfX4oI3MWHNHDSQjD4iR9o36lTMrKyJs=;
 b=qi3Z7YOztZneygiaGQC076dOHhEHosSjFBdhJyMcncynnDHcWqauN3yIEvsQ4/lI8w
 onhqDvxt2vJZmTLhQAf5EFvNpCcrQYkp6AGrQMiIy67R0Ae+KAXKrmuHYwfUudyYPWgM
 rM16JSG5sPWzfyItoHW6kxyONCtB7Cjh0xD6yGCU+29fsJNm0xLWJIqEn5/NtBbob1KT
 79Q8nOa8SZOkIv3dl7ZadVZetNM4lTeiaj1g2s4GzBd8WrGORE0xSKwp8zgeRCA7aF5j
 Ve6zSAibFSE9tjHy4fCQEZxOOX6goRApBLuiE12M/GxBm1AAlocOtE0S0REvm0Q76U5/
 0sEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571064; x=1707175864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3/S1vigBU1gXfX4oI3MWHNHDSQjD4iR9o36lTMrKyJs=;
 b=NHjOQLiFwtBS2lPlB4RHm4e5+RIx5lcEU1Px9D+kDQrdEek8cLqpIujc3zG/8aK69G
 ASgV/TdacxSan3NyLy7umHd3c4nCg0AfJzJrmHV9PSvK2/3jO2QFAUESY1cGSjcBuSUI
 /LNB8U4SjRD+wN0bf60ZOuuEmv5AyuzWZXT2sE5wXl4ndxmRqBB20XON+0l00w6SIbKg
 Sh80TaeGZ23zFxmA+nBuobfseXvXiSliusVG2LQM4bxLp1NqGzNuXAn8Nw07Qr71KHsS
 vDgKMtdjer4BhYEyiObChxnE1Ikz83FHH4UMQtf4NWKqtxVjc2VljThGTe5PLQlRZdn9
 I7gg==
X-Gm-Message-State: AOJu0YwlkEBzbEGAXvMGPch+YuTnDRMOZM4g40TKqzWij/yaogdHF3Yr
 bmjkUgZNbeH7kRd+4tkaQ7UWkcOnraOGbaPozTqLsEFMGiEK8Ae83bMSCHRoAJcmxxiN0ooHkTZ
 IJYU=
X-Google-Smtp-Source: AGHT+IEhDqRs+HMgxvwZwIs1Z4XoRIAm5ZwFITPjDkzak3YmyAz8MXfGsj61mowBBY+UFDi9Unfjdg==
X-Received: by 2002:a17:902:684e:b0:1d8:ee41:de7d with SMTP id
 f14-20020a170902684e00b001d8ee41de7dmr2322775pln.111.1706571063996; 
 Mon, 29 Jan 2024 15:31:03 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 07/33] target/cris: Cache mem_index in DisasContext
Date: Tue, 30 Jan 2024 09:30:17 +1000
Message-Id: <20240129233043.34558-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Compute this value once for each translation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/cris/translate.c         | 14 +++++---------
 target/cris/translate_v10.c.inc |  6 ++----
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index ee1402a9a3..7acea29a01 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -94,6 +94,7 @@ typedef struct DisasContext {
 
     CRISCPU *cpu;
     target_ulong pc, ppc;
+    int mem_index;
 
     /* Decoder.  */
         unsigned int (*decoder)(CPUCRISState *env, struct DisasContext *dc);
@@ -1008,37 +1009,31 @@ static inline void cris_prepare_jmp (DisasContext *dc, unsigned int type)
 
 static void gen_load64(DisasContext *dc, TCGv_i64 dst, TCGv addr)
 {
-    int mem_index = cpu_mmu_index(&dc->cpu->env, false);
-
     /* If we get a fault on a delayslot we must keep the jmp state in
        the cpu-state to be able to re-execute the jmp.  */
     if (dc->delayed_branch == 1) {
         cris_store_direct_jmp(dc);
     }
 
-    tcg_gen_qemu_ld_i64(dst, addr, mem_index, MO_TEUQ);
+    tcg_gen_qemu_ld_i64(dst, addr, dc->mem_index, MO_TEUQ);
 }
 
 static void gen_load(DisasContext *dc, TCGv dst, TCGv addr, 
              unsigned int size, int sign)
 {
-    int mem_index = cpu_mmu_index(&dc->cpu->env, false);
-
     /* If we get a fault on a delayslot we must keep the jmp state in
        the cpu-state to be able to re-execute the jmp.  */
     if (dc->delayed_branch == 1) {
         cris_store_direct_jmp(dc);
     }
 
-    tcg_gen_qemu_ld_tl(dst, addr, mem_index,
+    tcg_gen_qemu_ld_tl(dst, addr, dc->mem_index,
                        MO_TE + ctz32(size) + (sign ? MO_SIGN : 0));
 }
 
 static void gen_store (DisasContext *dc, TCGv addr, TCGv val,
                unsigned int size)
 {
-    int mem_index = cpu_mmu_index(&dc->cpu->env, false);
-
     /* If we get a fault on a delayslot we must keep the jmp state in
        the cpu-state to be able to re-execute the jmp.  */
     if (dc->delayed_branch == 1) {
@@ -1055,7 +1050,7 @@ static void gen_store (DisasContext *dc, TCGv addr, TCGv val,
         return;
     }
 
-    tcg_gen_qemu_st_tl(val, addr, mem_index, MO_TE + ctz32(size));
+    tcg_gen_qemu_st_tl(val, addr, dc->mem_index, MO_TE + ctz32(size));
 
     if (dc->flags_x) {
         cris_evaluate_flags(dc);
@@ -2971,6 +2966,7 @@ static void cris_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     dc->cpu = env_archcpu(env);
     dc->ppc = pc_start;
     dc->pc = pc_start;
+    dc->mem_index = cpu_mmu_index(env, false);
     dc->flags_uptodate = 1;
     dc->flags_x = tb_flags & X_FLAG;
     dc->cc_x_uptodate = 0;
diff --git a/target/cris/translate_v10.c.inc b/target/cris/translate_v10.c.inc
index 6df599fdce..73fc27c15d 100644
--- a/target/cris/translate_v10.c.inc
+++ b/target/cris/translate_v10.c.inc
@@ -91,8 +91,6 @@ static void gen_store_v10_conditional(DisasContext *dc, TCGv addr, TCGv val,
 static void gen_store_v10(DisasContext *dc, TCGv addr, TCGv val,
                        unsigned int size)
 {
-    int mem_index = cpu_mmu_index(&dc->cpu->env, false);
-
     /* If we get a fault on a delayslot we must keep the jmp state in
        the cpu-state to be able to re-execute the jmp.  */
     if (dc->delayed_branch == 1) {
@@ -101,11 +99,11 @@ static void gen_store_v10(DisasContext *dc, TCGv addr, TCGv val,
 
     /* Conditional writes. */
     if (dc->flags_x) {
-        gen_store_v10_conditional(dc, addr, val, size, mem_index);
+        gen_store_v10_conditional(dc, addr, val, size, dc->mem_index);
         return;
     }
 
-    tcg_gen_qemu_st_tl(val, addr, mem_index, ctz32(size) | MO_TE);
+    tcg_gen_qemu_st_tl(val, addr, dc->mem_index, ctz32(size) | MO_TE);
 }
 
 
-- 
2.34.1


