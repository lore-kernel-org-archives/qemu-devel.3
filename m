Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06CACA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraud-0003ys-8u; Thu, 28 Aug 2025 07:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urauJ-0003eC-Ld
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:35:07 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urauH-00060a-14
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:35:07 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45b7d497abaso1454275e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380903; x=1756985703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NDrWJvA3EAPGzXVi7xR+GWIA5VWSXLCvDTDuqmFRPTY=;
 b=iUCypIxg2Lw10HAyz1wOSK5Eh+dWZKuhX6woR/KOzWY4oX92Ux7L0d5HG5wdYQdCqB
 uEQry88UwH9HkXUmLDrollabNIj0l5xAjeKafEQBqwHJOcESeAY5/K35AlrrYjnWU+kp
 cTJ5tmP/UPqo40umvcj7r9ryH5Qhl2O4gzDQA/f6DBt14gkuBSbMC6nuSWinlgjTHBnq
 SXuXs0aLXjyXYaqpUAcIzRx/SbRS/gtC9UAIhf/MkPXNXCoAfwFUP6X5rhIvwvLmkZ4j
 0KlMGjVUPUsYfeEtzM7HV/FiP3SPUkMGMhwPAqbpMSHYf4mdWWNs2JanMkPcQIs8N0dh
 M92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380903; x=1756985703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NDrWJvA3EAPGzXVi7xR+GWIA5VWSXLCvDTDuqmFRPTY=;
 b=I19O2DNfAACpNAmjYsKKq+BeGeN/knxD3BT3zzhQtln2TbGpXb1FxUyHZBR7A/07MJ
 h4oxmHxN9gG9cCPXQJ+gfJuKNUexrnsgktuhBEWrV5o4gw/KIuEvHyQCFlNJ8gyGYbmJ
 1/53emeznzRUpNK4vvHOdI47lsesMPbPQI1IsU2whiDmpqkSDAEpRNLz2jK6dytT826j
 nx4+am0Wj1SJMn/9hikcn2sgAHyiam8AQRjnqF7qzArMGIdTx6nCaqRb34LBudFkbmSn
 PqQ7sZjNM+RBM3OWwft2XY4MnlgTikcCde7+HfZwjq0LDXbv79mcMYsepEN665nOYGlC
 Fgwg==
X-Gm-Message-State: AOJu0Yzn1k/6wEKj3PdHXVWRY9CWjINZQfp2MR7txGByF4DJ6Iiser84
 e0AiLTnr8JxIWp5q2UWfrP503/hi16sVMfhy1jx0W9+MgZvtr4YiqOxZxD6uRhx+3WrEaRoGPrL
 RHPPa
X-Gm-Gg: ASbGncvf05hKn4fPEK5M9shU6bPDmQtQrv9oH3shYjtyDcHmMpMZ6MRuXCSZVnu+YVn
 kwaWElVuVGtZJzpr957CAK4RjI1EP2JHHy9XBqLHckrRpH/6GUxCt9KWoa6NxOoNGbTxy6EaVWO
 mIF4RQy+2C/cXMROvJs9pHlbld3N2Jl8f10BFLQ0kBi3FYs69H1sA0E0jOElAI0baON9IecwNyT
 ZTvF5ajVITKcWnUY2HkQMTK3adwdUbIjzfbzHX88KhFDPnAayHn+K3Z6vXlyNcv/DJa93/n4Eob
 h8chH85YQrIQj6hC3YxSQmhMIBYyoiciInttbHACITvuJlbqT4TDQ0VIIIzymYlZ1I8NxN8ZC7P
 DLGdjZav7vn1loP9TtRKGTkIH4NzNagwcmXIyJrw=
X-Google-Smtp-Source: AGHT+IHgDUzdg4CzTC1ePEopt0QAwabmmV1/SOMuhhuUa/ZY150/Ltkjw5CTDLED6o22eP/5DsXckQ==
X-Received: by 2002:a05:600c:1c0c:b0:458:bda4:43df with SMTP id
 5b1f17b1804b1-45b727a2c43mr50191875e9.17.1756380903208; 
 Thu, 28 Aug 2025 04:35:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.35.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:35:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/32] tcg: Add tcg_gen_atomic_{xchg,fetch_and,fetch_or}_i128
Date: Thu, 28 Aug 2025 12:34:25 +0100
Message-ID: <20250828113430.3214314-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250815122653.701782-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/tcg/tcg-runtime.h       | 12 +++++
 include/tcg/tcg-op-common.h   |  7 +++
 include/tcg/tcg-op.h          |  3 ++
 tcg/tcg-op-ldst.c             | 97 +++++++++++++++++++++++++++++++++--
 accel/tcg/atomic_common.c.inc |  9 ++++
 5 files changed, 125 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index c23b5e66c46..8436599b9f1 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -63,6 +63,18 @@ DEF_HELPER_FLAGS_5(atomic_cmpxchgo_be, TCG_CALL_NO_WG,
                    i128, env, i64, i128, i128, i32)
 DEF_HELPER_FLAGS_5(atomic_cmpxchgo_le, TCG_CALL_NO_WG,
                    i128, env, i64, i128, i128, i32)
+DEF_HELPER_FLAGS_4(atomic_xchgo_be, TCG_CALL_NO_WG,
+                   i128, env, i64, i128, i32)
+DEF_HELPER_FLAGS_4(atomic_xchgo_le, TCG_CALL_NO_WG,
+                   i128, env, i64, i128, i32)
+DEF_HELPER_FLAGS_4(atomic_fetch_ando_be, TCG_CALL_NO_WG,
+                   i128, env, i64, i128, i32)
+DEF_HELPER_FLAGS_4(atomic_fetch_ando_le, TCG_CALL_NO_WG,
+                   i128, env, i64, i128, i32)
+DEF_HELPER_FLAGS_4(atomic_fetch_oro_be, TCG_CALL_NO_WG,
+                   i128, env, i64, i128, i32)
+DEF_HELPER_FLAGS_4(atomic_fetch_oro_le, TCG_CALL_NO_WG,
+                   i128, env, i64, i128, i32)
 #endif
 
 DEF_HELPER_FLAGS_5(nonatomic_cmpxchgo, TCG_CALL_NO_WG,
diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e1071adebf2..f752ef440b2 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -344,6 +344,8 @@ void tcg_gen_atomic_xchg_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
                                  TCGArg, MemOp, TCGType);
 void tcg_gen_atomic_xchg_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
                                  TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_xchg_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
+                                  TCGArg, MemOp, TCGType);
 
 void tcg_gen_atomic_fetch_add_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
                                       TCGArg, MemOp, TCGType);
@@ -411,6 +413,11 @@ void tcg_gen_atomic_umax_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
 void tcg_gen_atomic_umax_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
                                        TCGArg, MemOp, TCGType);
 
+void tcg_gen_atomic_fetch_and_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
+                                       TCGArg, MemOp, TCGType);
+void tcg_gen_atomic_fetch_or_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
+                                      TCGArg, MemOp, TCGType);
+
 /* Vector ops */
 
 void tcg_gen_mov_vec(TCGv_vec, TCGv_vec);
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index c912578fdd2..232733cb718 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -134,13 +134,16 @@ DEF_ATOMIC3(tcg_gen_nonatomic_cmpxchg, i128)
 
 DEF_ATOMIC2(tcg_gen_atomic_xchg, i32)
 DEF_ATOMIC2(tcg_gen_atomic_xchg, i64)
+DEF_ATOMIC2(tcg_gen_atomic_xchg, i128)
 
 DEF_ATOMIC2(tcg_gen_atomic_fetch_add, i32)
 DEF_ATOMIC2(tcg_gen_atomic_fetch_add, i64)
 DEF_ATOMIC2(tcg_gen_atomic_fetch_and, i32)
 DEF_ATOMIC2(tcg_gen_atomic_fetch_and, i64)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_and, i128)
 DEF_ATOMIC2(tcg_gen_atomic_fetch_or, i32)
 DEF_ATOMIC2(tcg_gen_atomic_fetch_or, i64)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_or, i128)
 DEF_ATOMIC2(tcg_gen_atomic_fetch_xor, i32)
 DEF_ATOMIC2(tcg_gen_atomic_fetch_xor, i64)
 DEF_ATOMIC2(tcg_gen_atomic_fetch_smin, i32)
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 548496002d7..67c15fd4d0d 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -801,6 +801,8 @@ typedef void (*gen_atomic_op_i32)(TCGv_i32, TCGv_env, TCGv_i64,
                                   TCGv_i32, TCGv_i32);
 typedef void (*gen_atomic_op_i64)(TCGv_i64, TCGv_env, TCGv_i64,
                                   TCGv_i64, TCGv_i32);
+typedef void (*gen_atomic_op_i128)(TCGv_i128, TCGv_env, TCGv_i64,
+                                   TCGv_i128, TCGv_i32);
 
 #ifdef CONFIG_ATOMIC64
 # define WITH_ATOMIC64(X) X,
@@ -1201,6 +1203,94 @@ static void do_atomic_op_i64(TCGv_i64 ret, TCGTemp *addr, TCGv_i64 val,
     }
 }
 
+static void do_nonatomic_op_i128(TCGv_i128 ret, TCGTemp *addr, TCGv_i128 val,
+                                 TCGArg idx, MemOp memop, bool new_val,
+                                 void (*gen)(TCGv_i64, TCGv_i64, TCGv_i64))
+{
+    TCGv_i128 t = tcg_temp_ebb_new_i128();
+    TCGv_i128 r = tcg_temp_ebb_new_i128();
+
+    tcg_gen_qemu_ld_i128_int(r, addr, idx, memop);
+    gen(TCGV128_LOW(t), TCGV128_LOW(r), TCGV128_LOW(val));
+    gen(TCGV128_HIGH(t), TCGV128_HIGH(r), TCGV128_HIGH(val));
+    tcg_gen_qemu_st_i128_int(t, addr, idx, memop);
+
+    tcg_gen_mov_i128(ret, r);
+    tcg_temp_free_i128(t);
+    tcg_temp_free_i128(r);
+}
+
+static void do_atomic_op_i128(TCGv_i128 ret, TCGTemp *addr, TCGv_i128 val,
+                              TCGArg idx, MemOp memop, void * const table[])
+{
+    gen_atomic_op_i128 gen = table[memop & (MO_SIZE | MO_BSWAP)];
+
+    if (gen) {
+        MemOpIdx oi = make_memop_idx(memop & ~MO_SIGN, idx);
+        TCGv_i64 a64 = maybe_extend_addr64(addr);
+        gen(ret, tcg_env, a64, val, tcg_constant_i32(oi));
+        maybe_free_addr64(a64);
+        return;
+    }
+
+    gen_helper_exit_atomic(tcg_env);
+    /* Produce a result */
+    tcg_gen_movi_i64(TCGV128_LOW(ret), 0);
+    tcg_gen_movi_i64(TCGV128_HIGH(ret), 0);
+}
+
+#define GEN_ATOMIC_HELPER128(NAME, OP, NEW)                             \
+static void * const table_##NAME[(MO_SIZE | MO_BSWAP) + 1] = {          \
+    [MO_8] = gen_helper_atomic_##NAME##b,                               \
+    [MO_16 | MO_LE] = gen_helper_atomic_##NAME##w_le,                   \
+    [MO_16 | MO_BE] = gen_helper_atomic_##NAME##w_be,                   \
+    [MO_32 | MO_LE] = gen_helper_atomic_##NAME##l_le,                   \
+    [MO_32 | MO_BE] = gen_helper_atomic_##NAME##l_be,                   \
+    WITH_ATOMIC64([MO_64 | MO_LE] = gen_helper_atomic_##NAME##q_le)     \
+    WITH_ATOMIC64([MO_64 | MO_BE] = gen_helper_atomic_##NAME##q_be)     \
+    WITH_ATOMIC128([MO_128 | MO_LE] = gen_helper_atomic_##NAME##o_le)   \
+    WITH_ATOMIC128([MO_128 | MO_BE] = gen_helper_atomic_##NAME##o_be)   \
+};                                                                      \
+void tcg_gen_atomic_##NAME##_i32_chk(TCGv_i32 ret, TCGTemp *addr,       \
+                                     TCGv_i32 val, TCGArg idx,          \
+                                     MemOp memop, TCGType addr_type)    \
+{                                                                       \
+    tcg_debug_assert(addr_type == tcg_ctx->addr_type);                  \
+    tcg_debug_assert((memop & MO_SIZE) <= MO_32);                       \
+    if (tcg_ctx->gen_tb->cflags & CF_PARALLEL) {                        \
+        do_atomic_op_i32(ret, addr, val, idx, memop, table_##NAME);     \
+    } else {                                                            \
+        do_nonatomic_op_i32(ret, addr, val, idx, memop, NEW,            \
+                            tcg_gen_##OP##_i32);                        \
+    }                                                                   \
+}                                                                       \
+void tcg_gen_atomic_##NAME##_i64_chk(TCGv_i64 ret, TCGTemp *addr,       \
+                                     TCGv_i64 val, TCGArg idx,          \
+                                     MemOp memop, TCGType addr_type)    \
+{                                                                       \
+    tcg_debug_assert(addr_type == tcg_ctx->addr_type);                  \
+    tcg_debug_assert((memop & MO_SIZE) <= MO_64);                       \
+    if (tcg_ctx->gen_tb->cflags & CF_PARALLEL) {                        \
+        do_atomic_op_i64(ret, addr, val, idx, memop, table_##NAME);     \
+    } else {                                                            \
+        do_nonatomic_op_i64(ret, addr, val, idx, memop, NEW,            \
+                            tcg_gen_##OP##_i64);                        \
+    }                                                                   \
+}                                                                       \
+void tcg_gen_atomic_##NAME##_i128_chk(TCGv_i128 ret, TCGTemp *addr,     \
+                                      TCGv_i128 val, TCGArg idx,        \
+                                      MemOp memop, TCGType addr_type)   \
+{                                                                       \
+    tcg_debug_assert(addr_type == tcg_ctx->addr_type);                  \
+    tcg_debug_assert((memop & MO_SIZE) == MO_128);                      \
+    if (tcg_ctx->gen_tb->cflags & CF_PARALLEL) {                        \
+        do_atomic_op_i128(ret, addr, val, idx, memop, table_##NAME);    \
+    } else {                                                            \
+        do_nonatomic_op_i128(ret, addr, val, idx, memop, NEW,           \
+                             tcg_gen_##OP##_i64);                       \
+    }                                                                   \
+}
+
 #define GEN_ATOMIC_HELPER(NAME, OP, NEW)                                \
 static void * const table_##NAME[(MO_SIZE | MO_BSWAP) + 1] = {          \
     [MO_8] = gen_helper_atomic_##NAME##b,                               \
@@ -1239,8 +1329,8 @@ void tcg_gen_atomic_##NAME##_i64_chk(TCGv_i64 ret, TCGTemp *addr,       \
 }
 
 GEN_ATOMIC_HELPER(fetch_add, add, 0)
-GEN_ATOMIC_HELPER(fetch_and, and, 0)
-GEN_ATOMIC_HELPER(fetch_or, or, 0)
+GEN_ATOMIC_HELPER128(fetch_and, and, 0)
+GEN_ATOMIC_HELPER128(fetch_or, or, 0)
 GEN_ATOMIC_HELPER(fetch_xor, xor, 0)
 GEN_ATOMIC_HELPER(fetch_smin, smin, 0)
 GEN_ATOMIC_HELPER(fetch_umin, umin, 0)
@@ -1266,6 +1356,7 @@ static void tcg_gen_mov2_i64(TCGv_i64 r, TCGv_i64 a, TCGv_i64 b)
     tcg_gen_mov_i64(r, b);
 }
 
-GEN_ATOMIC_HELPER(xchg, mov2, 0)
+GEN_ATOMIC_HELPER128(xchg, mov2, 0)
 
 #undef GEN_ATOMIC_HELPER
+#undef GEN_ATOMIC_HELPER128
diff --git a/accel/tcg/atomic_common.c.inc b/accel/tcg/atomic_common.c.inc
index 6056598c23d..bca93a0ac49 100644
--- a/accel/tcg/atomic_common.c.inc
+++ b/accel/tcg/atomic_common.c.inc
@@ -122,5 +122,14 @@ GEN_ATOMIC_HELPERS(umax_fetch)
 
 GEN_ATOMIC_HELPERS(xchg)
 
+#if HAVE_CMPXCHG128
+ATOMIC_HELPER(xchgo_be, Int128)
+ATOMIC_HELPER(xchgo_le, Int128)
+ATOMIC_HELPER(fetch_ando_be, Int128)
+ATOMIC_HELPER(fetch_ando_le, Int128)
+ATOMIC_HELPER(fetch_oro_be, Int128)
+ATOMIC_HELPER(fetch_oro_le, Int128)
+#endif
+
 #undef ATOMIC_HELPER
 #undef GEN_ATOMIC_HELPERS
-- 
2.43.0


