Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AA4C54ED0
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 16:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJDoT-00026P-SY; Sun, 25 May 2025 12:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJDo4-0001lX-Rm
 for qemu-devel@nongnu.org; Sun, 25 May 2025 12:02:40 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJDo1-000364-L0
 for qemu-devel@nongnu.org; Sun, 25 May 2025 12:02:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so11242485e9.2
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 09:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748188951; x=1748793751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1cFE9Rav7pF61D6b2m7yUgSrF69gORHmAhwRklTnako=;
 b=DUIG2kFx62LkDMkMWAt6EMDexEz/W0PMsu9XrvZaoorpa0YRsornZcCmkG2LFSLU6s
 eQuRk5IWvx+AncJBN4wVqqiKJ580YeStI8FzSosFXoMGa+Mr1/5BB5oW8XngfXAr/w1J
 i5GFFTbSHF3NpDAA+ShhSQWyxEoFo/M7mLNkmGegOc2PbRsEIGFJtG2Zk93bh6APFDnV
 HvMrz+4LTja2Gflu2YnZoMvogfoP2YKodHm9DyWeH3qTtbOzx1do+5Fqdj1zDZN8XLlR
 3mA+gg+6Enqf1HzlBICiRIxT5ge36DYQ8OzSwC/EwE/49A0+fLvAv9hcz5oyCaWDkEDU
 PzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748188951; x=1748793751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1cFE9Rav7pF61D6b2m7yUgSrF69gORHmAhwRklTnako=;
 b=KDsOfbY7WkLe073hRyENdlejDBEkI05VEacF/y0L6E0+GLyWPu3j5QfaemIFDIArTn
 F3If+C+eIc5nhEPWH56rzrQtSn/hoLAJe8jrgJbhNw0+PUB6pBhu5e/UefIkHh4k/Cvt
 V7gxIOv/qnd80X/bW/+AEFFo4R12G2YS469SzNB9vD6f2dtp7sN5L1d4uepjV3DWrnhb
 nBfLhyOcICZN75iWv9JRI+t8+wrtwRqJJJvXuc9/+5dW0bW8aJ5IZP8vWSMHImy5K9E0
 J6DhQXtpiTWYcyCpCYZ8pQQ+QfIF1OKWKs6F/u/mRn4mBhtIQZgNu/1tpyVy0oqCFKqq
 B8Eg==
X-Gm-Message-State: AOJu0YwxTbgi2jZA5CyabtCe7oebxXyjgz9rVWUFDggHEQzJXMWQWlPf
 LTouAdKMkp4XUk6/ZqxNWoyEWHh+ngxYpIHGU6Tnvye9b/1eTgJgXDur/3SZPc4KdCW743ij+5E
 iBOHgQPo=
X-Gm-Gg: ASbGncvxCAIUI+gfZ618ZseGJlmCTBSmqpnqYPYk1Yl8BjA8SHFo+igNC7vL7Syd0i1
 hmtC4rC5nG+qbvyVJP2SlmgkqiXuZEZVHOgc3laHyKjT5grIAeeCmZsRJytV/5qM6mefLkOZVrb
 9Ahwykr5MXsYyZ6v2zJcKbQ7mQhG/0BOErfb9Dvr8aG1/St9HbvC64emF2XAvS2BCDXGLFbV3Og
 Z6WClxVLZk/KZbXO22Cjdo9IrFYu4ZVpz+pnGvyDfC3oPnxigSLOlljZCsH/Cos4u67ry7FKKH8
 Q5/EQqcsZ9FDX+kzcQ5F7OmjR9aHO84rY1pl4AnSiPbC6tE6eCw2RuZW
X-Google-Smtp-Source: AGHT+IGNfUOo6w/+YiPQPgp0SLVJsqKID/+GdsRd8EG3uiqTT+lKMXSz06Y025lWqSkGbYYd8x5FRw==
X-Received: by 2002:a05:600c:a07:b0:448:e8c0:c778 with SMTP id
 5b1f17b1804b1-44c92a5495cmr48683135e9.22.1748188951125; 
 Sun, 25 May 2025 09:02:31 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f73d4a3csm215772545e9.22.2025.05.25.09.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 09:02:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH v2 04/10] target/microblaze: Implement extended address
 load/store out of line
Date: Sun, 25 May 2025 17:02:14 +0100
Message-ID: <20250525160220.222154-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250525160220.222154-1-richard.henderson@linaro.org>
References: <20250525160220.222154-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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


