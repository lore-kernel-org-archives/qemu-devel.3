Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C11C5B549
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBwd-0008WO-3l; Wed, 28 May 2025 04:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBve-0007uu-R4
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:28 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvb-0005Dq-Py
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:25 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-450caff6336so960705e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420062; x=1749024862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wMNNlloO/+QlHEs++wI6omAZXNBlNB0k76QUNt8qkaQ=;
 b=kwXvjEl/S8XoigbLOZMFnx8AaOIqwtLTb2NPjQwxzYAgPNUDMag6cjJCycm4M37BoF
 wGM0z1fMDrBraiKMyvr2niwW9srb1FTvTEQvAAcfhlBwzar224pYnwwc5msiEYrQV/FU
 C1cOOAXE8UFRxUXOcaQ6RZP1uflqm0vqPxwt+l1+Z0O2wtydxgBZms1jHkAY20lbLib0
 mNer8t35XBQj/jMmTCjB82QOVTVthjgvMIm9zVw1CNOaVEYfAUfj6XYCfCKTOtOCqAiz
 W2DID0AyrxPQIevIu9LIZNCj5BR5WxkKVhFrFsgNg2iDp77eUFrEN/cvV6wvMUsukgI8
 3l+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420062; x=1749024862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wMNNlloO/+QlHEs++wI6omAZXNBlNB0k76QUNt8qkaQ=;
 b=fXW904Km2csa09aQx+ZhS7/hjqQoOOR0uu6wdf0AyM95982KERjEXtIMtSyEvmXYpj
 DmrvPD7xcZMQxZ3oLLwtM4l5ao/DiCiHnOJNHPB2E/VYU+R/R1nj6RUs+JKhCVZg62sB
 KndHsYXqFmDAUWuFkMc38igj14s9q+mZmlulHmdY87TvVVSRsG1t8GTgCSDXMFCEe/0P
 mQJ8uzCpXaX7lHNJ0JGm74PCEsl9Uh5nQp1Ir24suQC+WCYzFbjpmb6P/782RnrMT9Hp
 9u1/LFvSvtr7sQs3/uH9fwq61ygIfdmGK1xMM7ty654iy8l7bwMP1aNQO1Y6m6QwMkNE
 eQ0w==
X-Gm-Message-State: AOJu0YwKqOxe24zmAyyJyw2RkxrN7/8Nbdo3MdvTPszArAZ0pw+db2wW
 bYkOQoyhY+PG+ThAbBgr42FL28LASgjetcoLKF8THkYVk5ZJxzR7ZaN7vpqaZg2bS45gagEavJY
 dJqNWxGFItg==
X-Gm-Gg: ASbGncv5ajKEWPFH/+eYuJBKGdknayvS2pUGjlRlb55Fk5FnRDATJQLo2nf/DaYOPf0
 CbkTjYVBx2KQzduwM9CLgxH3PdvuMKq5lkTTtJCMIw32ruGwpUj5C8d9XPF1hjaX8de/rffPCLn
 H83577irlHehQ2zWDZKr+dZPFF3N8BpokB1C2v6kc9dI7ZpyR+Yz3DQh4AdrgLataCg2kx9fLij
 ki4KLFbfuWtHvN9y9J2iBIpEdOHgEoF3t5jrZEV2tuwY1xT3GemH0O/5vqMe8tNk6zzftxkn420
 D/IxA/136loYMS4jAmfzxMr3vX3pkhoMA0cwu1IRtLTl3f+Vjdtz/hgS
X-Google-Smtp-Source: AGHT+IG21ElnjW2nIij5BIYi9TfCZj6LP+JzgEKqMO+wQwf/QAptETxu3tqTk1wgLu1FwwCWmmKwGg==
X-Received: by 2002:a05:600c:1e1c:b0:441:d438:4ea5 with SMTP id
 5b1f17b1804b1-44c9493e6b1mr122788855e9.20.1748420062216; 
 Wed, 28 May 2025 01:14:22 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 07/28] target/microblaze: Implement extended address load/store
 out of line
Date: Wed, 28 May 2025 09:13:49 +0100
Message-ID: <20250528081410.157251-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/helper.h    | 10 +++++++
 target/microblaze/op_helper.c | 40 +++++++++++++++++++++++++++
 target/microblaze/translate.c | 52 +++++++++++++++++++++++++++--------
 3 files changed, 90 insertions(+), 12 deletions(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 41f56a5601..ef4fad9b91 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -28,4 +28,14 @@ DEF_HELPER_FLAGS_3(put, TCG_CALL_NO_RWG, void, i32, i32, i32)
 DEF_HELPER_FLAGS_3(mmu_read, TCG_CALL_NO_RWG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_4(mmu_write, TCG_CALL_NO_RWG, void, env, i32, i32, i32)
 DEF_HELPER_FLAGS_2(unaligned_access, TCG_CALL_NO_WG, noreturn, env, i64)
+DEF_HELPER_FLAGS_2(lbuea, TCG_CALL_NO_WG, i32, env, i64)
+DEF_HELPER_FLAGS_2(lhuea_be, TCG_CALL_NO_WG, i32, env, i64)
+DEF_HELPER_FLAGS_2(lhuea_le, TCG_CALL_NO_WG, i32, env, i64)
+DEF_HELPER_FLAGS_2(lwea_be, TCG_CALL_NO_WG, i32, env, i64)
+DEF_HELPER_FLAGS_2(lwea_le, TCG_CALL_NO_WG, i32, env, i64)
+DEF_HELPER_FLAGS_3(sbea, TCG_CALL_NO_WG, void, env, i32, i64)
+DEF_HELPER_FLAGS_3(shea_be, TCG_CALL_NO_WG, void, env, i32, i64)
+DEF_HELPER_FLAGS_3(shea_le, TCG_CALL_NO_WG, void, env, i32, i64)
+DEF_HELPER_FLAGS_3(swea_be, TCG_CALL_NO_WG, void, env, i32, i64)
+DEF_HELPER_FLAGS_3(swea_le, TCG_CALL_NO_WG, void, env, i32, i64)
 #endif
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 4c39207a55..b8365b3b1d 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -382,6 +382,8 @@ void helper_stackprot(CPUMBState *env, target_ulong addr)
 }
 
 #if !defined(CONFIG_USER_ONLY)
+#include "system/memory.h"
+
 /* Writes/reads to the MMU's special regs end up here.  */
 uint32_t helper_mmu_read(CPUMBState *env, uint32_t ext, uint32_t rn)
 {
@@ -441,4 +443,42 @@ void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
     mb_transaction_failed_internal(cs, physaddr, addr, size,
                                    access_type, retaddr);
 }
+
+#define LD_EA(NAME, TYPE, FUNC) \
+uint32_t HELPER(NAME)(CPUMBState *env, uint64_t ea)                     \
+{                                                                       \
+    CPUState *cs = env_cpu(env);                                        \
+    MemTxResult txres;                                                  \
+    TYPE ret = FUNC(cs->as, ea, MEMTXATTRS_UNSPECIFIED, &txres);        \
+    if (unlikely(txres != MEMTX_OK)) {                                  \
+        mb_transaction_failed_internal(cs, ea, ea, sizeof(TYPE),        \
+                                       MMU_DATA_LOAD, GETPC());         \
+    }                                                                   \
+    return ret;                                                         \
+}
+
+LD_EA(lbuea, uint8_t, address_space_ldub)
+LD_EA(lhuea_be, uint16_t, address_space_lduw_be)
+LD_EA(lhuea_le, uint16_t, address_space_lduw_le)
+LD_EA(lwea_be, uint32_t, address_space_ldl_be)
+LD_EA(lwea_le, uint32_t, address_space_ldl_le)
+
+#define ST_EA(NAME, TYPE, FUNC) \
+void HELPER(NAME)(CPUMBState *env, uint32_t data, uint64_t ea)          \
+{                                                                       \
+    CPUState *cs = env_cpu(env);                                        \
+    MemTxResult txres;                                                  \
+    FUNC(cs->as, ea, data, MEMTXATTRS_UNSPECIFIED, &txres);             \
+    if (unlikely(txres != MEMTX_OK)) {                                  \
+        mb_transaction_failed_internal(cs, ea, ea, sizeof(TYPE),        \
+                                       MMU_DATA_STORE, GETPC());        \
+    }                                                                   \
+}
+
+ST_EA(sbea, uint8_t, address_space_stb)
+ST_EA(shea_be, uint16_t, address_space_stw_be)
+ST_EA(shea_le, uint16_t, address_space_stw_le)
+ST_EA(swea_be, uint32_t, address_space_stl_be)
+ST_EA(swea_le, uint32_t, address_space_stl_le)
+
 #endif
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 671b1ae4db..3d9756391e 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -700,6 +700,20 @@ static void record_unaligned_ess(DisasContext *dc, int rd,
 
     tcg_set_insn_start_param(dc->base.insn_start, 1, iflags);
 }
+
+static void gen_alignment_check_ea(DisasContext *dc, TCGv_i64 ea, int rb,
+                                   int rd, MemOp size, bool store)
+{
+    if (rb && (dc->tb_flags & MSR_EE) && dc->cfg->unaligned_exceptions) {
+        TCGLabel *over = gen_new_label();
+
+        record_unaligned_ess(dc, rd, size, store);
+
+        tcg_gen_brcondi_i64(TCG_COND_TSTEQ, ea, (1 << size) - 1, over);
+        gen_helper_unaligned_access(tcg_env, ea);
+        gen_set_label(over);
+    }
+}
 #endif
 
 static inline MemOp mo_endian(DisasContext *dc)
@@ -765,10 +779,11 @@ static bool trans_lbuea(DisasContext *dc, arg_typea *arg)
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
 
@@ -796,10 +811,13 @@ static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
         return true;
     }
 #ifdef CONFIG_USER_ONLY
-    return true;
+    g_assert_not_reached();
 #else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_UW, MMU_NOMMU_IDX, false);
+    gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_16, false);
+    (mo_endian(dc) == MO_BE ? gen_helper_lhuea_be : gen_helper_lhuea_le)
+        (reg_for_write(dc, arg->rd), tcg_env, addr);
+    return true;
 #endif
 }
 
@@ -827,10 +845,13 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
         return true;
     }
 #ifdef CONFIG_USER_ONLY
-    return true;
+    g_assert_not_reached();
 #else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, MO_UL, MMU_NOMMU_IDX, false);
+    gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_32, false);
+    (mo_endian(dc) == MO_BE ? gen_helper_lwea_be : gen_helper_lwea_le)
+        (reg_for_write(dc, arg->rd), tcg_env, addr);
+    return true;
 #endif
 }
 
@@ -918,10 +939,11 @@ static bool trans_sbea(DisasContext *dc, arg_typea *arg)
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
 
@@ -949,10 +971,13 @@ static bool trans_shea(DisasContext *dc, arg_typea *arg)
         return true;
     }
 #ifdef CONFIG_USER_ONLY
-    return true;
+    g_assert_not_reached();
 #else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_UW, MMU_NOMMU_IDX, false);
+    gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_16, true);
+    (mo_endian(dc) == MO_BE ? gen_helper_shea_be : gen_helper_shea_le)
+        (tcg_env, reg_for_read(dc, arg->rd), addr);
+    return true;
 #endif
 }
 
@@ -980,10 +1005,13 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
         return true;
     }
 #ifdef CONFIG_USER_ONLY
-    return true;
+    g_assert_not_reached();
 #else
     TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, MO_UL, MMU_NOMMU_IDX, false);
+    gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_32, true);
+    (mo_endian(dc) == MO_BE ? gen_helper_swea_be : gen_helper_swea_le)
+        (tcg_env, reg_for_read(dc, arg->rd), addr);
+    return true;
 #endif
 }
 
-- 
2.43.0


