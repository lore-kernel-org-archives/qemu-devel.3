Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B0AC021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 22:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKo1-0006mB-09; Wed, 12 Feb 2025 17:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKny-0006l2-SJ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:02:02 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKnw-0004S5-Lz
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:02:02 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21f49837d36so1904725ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 14:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739397719; x=1740002519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYm6yE7hZRuV0xmNrggaqiwHwyUyPJzftvmjuRCP7S4=;
 b=rjvo12Z5Iel87j9vtjDuvDaadDHd5eAFjv95n75dG09VKDITic1iYFQJx2CqULw2ZQ
 KZaFqbsdQPKby5TA1s/9vqCri9835kIgZMom80yZt9Y/FGgIG7LywIf6/vtu9PRGduCD
 SHdHpNvfjPAZtKQ2CpZFAiFoblHwgpWgcL7ACOMCGEtwAUnTpcC75hlCbTz3XEIqXOLG
 xcWc6UtUH3AnzlxKiNy7gI2ImVO1UeCaT0D86k9HYQ0GpooYoxuMbu6yKdiK7kE1b2G3
 nG7qtAPwxaQXH2wZ/zEIxZYbWX0UliftYogyZzXSfgqSnKMIpgpc7M2av8oSz8kvNmJJ
 9FtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739397719; x=1740002519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BYm6yE7hZRuV0xmNrggaqiwHwyUyPJzftvmjuRCP7S4=;
 b=W9gPKr55vSb4w9wsz0pXVjTsIVSGbEUksUlp3YKH/CVwG7poJY5Z+1hyDLXXwalN7D
 iONGz9dZ4CR64JZTsqHHizFbo1wDbLCyLbFMlqmECSUdmU90aCzbePf+18qYjEiK3swX
 064gGWAfgpYNDdSATrB4uj+vGWUW+PSfbSyFLuUOmf5clBnkbDNmJnAQMXtSjEsW47YP
 dzmvQ5NUd7Lsrn0mu4qte5SNJ9ENQhNs9KDyPgv4rZtu+oIBvONKRi6Je8XGXNGafjP8
 /kfkh6fcyD+zAv6l+ADH390C/O7PaTBo7QJWWji55OAATrnspxN2t2CPm3XsihdPGdog
 fygA==
X-Gm-Message-State: AOJu0YzbMGPIFKLtEMcnV7keCqVA5k7Etc47nUrk08kqPglBakU6h0hq
 RjSUk4PVBytnSC4yX86Yk5I6UMBVr0OzGjV31yYELAGe5YRf28ooEmPp0ZzrGm2szjwyIyKxJiY
 s
X-Gm-Gg: ASbGncuQMySYaSE5nSMWZd8ZEToh74qKSvRf7Jb1JjHjOiNhr1jEITRDoFDub/85iOB
 VxGGhWLK/wRHJBrCUDX0eozFK5txlmFY4oADWGcZpVcHHSyKBZRCpyJ90fyTnl88Pr/E0OlAwbs
 At+CdWnoanty3SCgZK/yJwaylW+4yCRftmyaWSH67DJPFHSKva/AH4czGib9ZxrgRviBdrfGtDo
 cFudISGGc8kanl8yv/6liL1NSkYyDCb9jMrJFioTzK0H7ZPx1iEohTIYQO5HBFLyEPVXlxNKOVq
 U1VdzsShsuJzyTjj3V+tK+jiw6FXq8fuTb0xAyRTRG61S6o=
X-Google-Smtp-Source: AGHT+IE75qEysW+CxVmVPkxWEKMVpA19U3APVNVdqb39MqwZRLCCEbQl+97/YeuX+PdxUEQlx8zchw==
X-Received: by 2002:a17:902:fc8e:b0:21d:ccec:b321 with SMTP id
 d9443c01a7336-220d2110d0amr13183225ad.34.1739397719163; 
 Wed, 12 Feb 2025 14:01:59 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98b4c52sm1964837a91.4.2025.02.12.14.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:01:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH 3/9] target/microblaze: Implement extended address load/store
 out of line
Date: Wed, 12 Feb 2025 14:01:49 -0800
Message-ID: <20250212220155.1147144-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212220155.1147144-1-richard.henderson@linaro.org>
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Use helpers and address_space_ld/st instead of inline
loads and stores.  This allows us to perform operations
on physical addresses wider than virtual addresses.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/helper.h    | 16 ++++--
 target/microblaze/op_helper.c | 99 +++++++++++++++++++++++++++++++++++
 target/microblaze/translate.c | 42 ++++++++++-----
 3 files changed, 140 insertions(+), 17 deletions(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index f740835fcb..f3ef5a3150 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -20,12 +20,18 @@ DEF_HELPER_FLAGS_3(fcmp_ne, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(fcmp_ge, TCG_CALL_NO_WG, i32, env, i32, i32)
 
 DEF_HELPER_FLAGS_2(pcmpbf, TCG_CALL_NO_RWG_SE, i32, i32, i32)
-#if !defined(CONFIG_USER_ONLY)
-DEF_HELPER_FLAGS_3(mmu_read, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_4(mmu_write, TCG_CALL_NO_RWG, void, env, i32, i32, i32)
-#endif
-
 DEF_HELPER_FLAGS_2(stackprot, TCG_CALL_NO_WG, void, env, tl)
 
 DEF_HELPER_FLAGS_2(get, TCG_CALL_NO_RWG, i32, i32, i32)
 DEF_HELPER_FLAGS_3(put, TCG_CALL_NO_RWG, void, i32, i32, i32)
+
+#if !defined(CONFIG_USER_ONLY)
+DEF_HELPER_FLAGS_3(mmu_read, TCG_CALL_NO_RWG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_4(mmu_write, TCG_CALL_NO_RWG, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_2(lbuea, TCG_CALL_NO_WG, i32, env, i64)
+DEF_HELPER_FLAGS_2(lhuea, TCG_CALL_NO_WG, i32, env, i64)
+DEF_HELPER_FLAGS_2(lwea, TCG_CALL_NO_WG, i32, env, i64)
+DEF_HELPER_FLAGS_3(sbea, TCG_CALL_NO_WG, void, env, i32, i64)
+DEF_HELPER_FLAGS_3(shea, TCG_CALL_NO_WG, void, env, i32, i64)
+DEF_HELPER_FLAGS_3(swea, TCG_CALL_NO_WG, void, env, i32, i64)
+#endif
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 6019c5b2eb..722810cb9c 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -25,6 +25,7 @@
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
+#include "exec/memory.h"
 #include "fpu/softfloat.h"
 
 void helper_put(uint32_t id, uint32_t ctrl, uint32_t data)
@@ -442,4 +443,102 @@ void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
     mb_transaction_failed_internal(cs, physaddr, addr, size,
                                    access_type, retaddr);
 }
+
+uint32_t HELPER(lbuea)(CPUMBState *env, uint64_t ea)
+{
+    CPUState *cs = env_cpu(env);
+    uintptr_t ra = GETPC();
+    MemTxResult txres;
+    uint8_t ret;
+
+    ret = address_space_ldub(cs->as, ea, MEMTXATTRS_UNSPECIFIED, &txres);
+    if (unlikely(txres != MEMTX_OK)) {
+        mb_transaction_failed_internal(cs, ea, ea, 1, MMU_DATA_LOAD, ra);
+    }
+    return ret;
+}
+
+uint32_t HELPER(lhuea)(CPUMBState *env, uint64_t ea)
+{
+    CPUState *cs = env_cpu(env);
+    uintptr_t ra = GETPC();
+    MemTxResult txres;
+    uint16_t ret;
+
+    if (unlikely(ea & 1)
+        && (env->msr & MSR_EE)
+        && env_archcpu(env)->cfg.unaligned_exceptions) {
+        mb_unaligned_access_internal(cs, ea, MMU_DATA_LOAD, ra);
+    }
+    ret = address_space_lduw(cs->as, ea, MEMTXATTRS_UNSPECIFIED, &txres);
+    if (unlikely(txres != MEMTX_OK)) {
+        mb_transaction_failed_internal(cs, ea, ea, 2, MMU_DATA_LOAD, ra);
+    }
+    return ret;
+}
+
+uint32_t HELPER(lwea)(CPUMBState *env, uint64_t ea)
+{
+    CPUState *cs = env_cpu(env);
+    uintptr_t ra = GETPC();
+    MemTxResult txres;
+    uint32_t ret;
+
+    if (unlikely(ea & 3)
+        && (env->msr & MSR_EE)
+        && env_archcpu(env)->cfg.unaligned_exceptions) {
+        mb_unaligned_access_internal(cs, ea, MMU_DATA_LOAD, ra);
+    }
+    ret = address_space_ldl(cs->as, ea, MEMTXATTRS_UNSPECIFIED, &txres);
+    if (unlikely(txres != MEMTX_OK)) {
+        mb_transaction_failed_internal(cs, ea, ea, 4, MMU_DATA_LOAD, ra);
+    }
+    return ret;
+}
+
+void HELPER(sbea)(CPUMBState *env, uint32_t data, uint64_t ea)
+{
+    CPUState *cs = env_cpu(env);
+    uintptr_t ra = GETPC();
+    MemTxResult txres;
+
+    address_space_stb(cs->as, ea, data, MEMTXATTRS_UNSPECIFIED, &txres);
+    if (unlikely(txres != MEMTX_OK)) {
+        mb_transaction_failed_internal(cs, ea, ea, 1, MMU_DATA_STORE, ra);
+    }
+}
+
+void HELPER(shea)(CPUMBState *env, uint32_t data, uint64_t ea)
+{
+    CPUState *cs = env_cpu(env);
+    uintptr_t ra = GETPC();
+    MemTxResult txres;
+
+    if (unlikely(ea & 1)
+        && (env->msr & MSR_EE)
+        && env_archcpu(env)->cfg.unaligned_exceptions) {
+        mb_unaligned_access_internal(cs, ea, MMU_DATA_STORE, ra);
+    }
+    address_space_stw(cs->as, ea, data, MEMTXATTRS_UNSPECIFIED, &txres);
+    if (unlikely(txres != MEMTX_OK)) {
+        mb_transaction_failed_internal(cs, ea, ea, 2, MMU_DATA_STORE, ra);
+    }
+}
+
+void HELPER(swea)(CPUMBState *env, uint32_t data, uint64_t ea)
+{
+    CPUState *cs = env_cpu(env);
+    uintptr_t ra = GETPC();
+    MemTxResult txres;
+
+    if (unlikely(ea & 3)
+        && (env->msr & MSR_EE)
+        && env_archcpu(env)->cfg.unaligned_exceptions) {
+        mb_unaligned_access_internal(cs, ea, MMU_DATA_STORE, ra);
+    }
+    address_space_stl(cs->as, ea, data, MEMTXATTRS_UNSPECIFIED, &txres);
+    if (unlikely(txres != MEMTX_OK)) {
+        mb_transaction_failed_internal(cs, ea, ea, 4, MMU_DATA_STORE, ra);
+    }
+}
 #endif
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 24005f05b2..d5c5e650e0 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -764,10 +764,11 @@ static bool trans_lbuea(DisasContext *dc, arg_typea *arg)
         return true;
     }
 #ifdef CONFIG_USER_ONLY
-    return true;
+    g_assert_not_reached();
 #else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_UB, MMU_NOMMU_IDX, false);
+    gen_helper_lbuea(reg_for_write(dc, arg->rd), tcg_env, addr);
+    return true;
 #endif
 }
 
@@ -795,10 +796,14 @@ static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
         return true;
     }
 #ifdef CONFIG_USER_ONLY
-    return true;
+    g_assert_not_reached();
 #else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_TEUW, MMU_NOMMU_IDX, false);
+    if ((dc->tb_flags & MSR_EE) && dc->cfg->unaligned_exceptions) {
+        record_unaligned_ess(dc, arg->rd, MO_16, false);
+    }
+    gen_helper_lhuea(reg_for_write(dc, arg->rd), tcg_env, addr);
+    return true;
 #endif
 }
 
@@ -826,10 +831,14 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
         return true;
     }
 #ifdef CONFIG_USER_ONLY
-    return true;
+    g_assert_not_reached();
 #else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_TEUL, MMU_NOMMU_IDX, false);
+    if ((dc->tb_flags & MSR_EE) && dc->cfg->unaligned_exceptions) {
+        record_unaligned_ess(dc, arg->rd, MO_32, false);
+    }
+    gen_helper_lwea(reg_for_write(dc, arg->rd), tcg_env, addr);
+    return true;
 #endif
 }
 
@@ -914,10 +923,11 @@ static bool trans_sbea(DisasContext *dc, arg_typea *arg)
         return true;
     }
 #ifdef CONFIG_USER_ONLY
-    return true;
+    g_assert_not_reached();
 #else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_UB, MMU_NOMMU_IDX, false);
+    gen_helper_sbea(tcg_env, reg_for_read(dc, arg->rd), addr);
+    return true;
 #endif
 }
 
@@ -945,10 +955,14 @@ static bool trans_shea(DisasContext *dc, arg_typea *arg)
         return true;
     }
 #ifdef CONFIG_USER_ONLY
-    return true;
+    g_assert_not_reached();
 #else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_TEUW, MMU_NOMMU_IDX, false);
+    if ((dc->tb_flags & MSR_EE) && dc->cfg->unaligned_exceptions) {
+        record_unaligned_ess(dc, arg->rd, MO_16, true);
+    }
+    gen_helper_shea(tcg_env, reg_for_read(dc, arg->rd), addr);
+    return true;
 #endif
 }
 
@@ -976,10 +990,14 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
         return true;
     }
 #ifdef CONFIG_USER_ONLY
-    return true;
+    g_assert_not_reached();
 #else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_TEUL, MMU_NOMMU_IDX, false);
+    if ((dc->tb_flags & MSR_EE) && dc->cfg->unaligned_exceptions) {
+        record_unaligned_ess(dc, arg->rd, MO_32, true);
+    }
+    gen_helper_swea(tcg_env, reg_for_read(dc, arg->rd), addr);
+    return true;
 #endif
 }
 
-- 
2.43.0


