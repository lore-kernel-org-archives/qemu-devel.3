Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DCBCA5FA0
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksf-0000oC-AQ; Sun, 27 Sep 2026 05:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkri-0003Cx-CB
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:08:10 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrf-0008Ja-7S
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:08:10 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98fso1604250a91.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790500086; x=1791104886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r98gZb0hDnNs2UdoqnKuKBYiAeWz5ktmUNLl7KBNqZY=;
 b=LWENkQnNvTQihMYBCpMjf+/6cLFMqb3WPgTDjXLAaAIHHyVdcJxEFCycfXdoZXrd8e
 R3TXFOPWSRU6XZTKxx+JtcqlktU1Z1eCI1YxHZ08QxLOYKwCmgf7oIcDuApY2m8pgOIx
 n/wkIuh2irRMb3g48jPynF4Qiaje494eiLXomGQNkYkYWC5cnSWCjzmGihmvXAicnTxh
 M6+iIq1Ocj0xDoEr1DQgNWO/kuBUGoXTwFW8mp2AFxGMWmGShASBSdweEvmz33zF9t/2
 f76ymhgWU3Ud0vMGj8gg2fqUKc9bdyShj4bnlpVuuuBVNaHl0y5/SuSYmLPIzjeN66r/
 1/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500086; x=1791104886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=r98gZb0hDnNs2UdoqnKuKBYiAeWz5ktmUNLl7KBNqZY=;
 b=pVSscJEIyA6Ot4Kupwx61GyYxYRKO5fzLqBy834EhcNTKzDqdYLijBk7lhVugcVNNi
 t5fTeLhbtcRQzJ/ZAArBhivyUDubrLeorWyokgfz5yZYKonnXBUwaYaW/KVchVs8/R4L
 ccoq12vDePKhQvMYsqarvO0u5gwqaDmHFdD4dJAeOJugHnqPInkmBVXnvDFWpYRb1VMz
 asYaYfaIyUa6lkK6GzL3c22t7BlTMS4mzTaawy4NA388DWvA2B49P5wwOzYSU6bha/YU
 /CAdJm6gLfvtAzavJYxYVXxLhr5wekpMHbxrTtG+p3Xijug/0tyiB02UamHSEQLbKW5M
 oCOA==
X-Gm-Message-State: AFq9FYLlTsAi9Wn0gpTVi73jqANrnqoSlCe51w7v3CBT9ZbT7bVjC5FV
 0xsJNZ1lxcKSsDAYQwXoypQ/nuGaxt01u8+k+Nykaco0IOaq3w3AaL+vMlQTEuD9UuFDYFCn1YY
 5OTb+
X-Gm-Gg: AYBFou29gpNvRf8OaBvlj5fktp4UusQWDG7Yons5q9vc2E3a14bD55NFoAuD13d5/pm
 CRKfh1gR7FX/wDTXf4tn1MAKdZfJ2R9YFtxdzwAb3NuKotXVRmGuIjLEcd83WYGmLkd7ouOR+qs
 zkQVe0uGwnb6UesBI598QuTAtIIKX41HS+7AMZJJJ1L5MpITEikmybyYFKlQEqEEmEpzOXSMOUL
 zZzPHZEFA7J0UOKfwkN60kt4f1yFTXlvm96PwmLhIEzypezk3D2PIH61lmBbKD1vd49UYSfMUny
 3ej4uQN3761ndX1DYdZIv0DpYUjmDGV8uJEbJLvOENZYI2Am8e76bPhjsWzi0AqOql/qsRKlpI5
 JB82DCEjLKKPexWAkwemoWNiiXtImntVuKMm6DRUWX52RyK4g9+l/zF5urAGsD9BF9+DzoRok5f
 i54aBY2tmtfjGEZ5d7seVUnaHbORiS0r9a1+PseE3kKYiFTSkOAdwL7QPjieaF4QnkobpSMEaHe
 5/A+HkxKxr4YCNp1u2zqXywEyBFpQ==
X-Received: by 2002:a17:90a:a81:b0:3a0:d82b:2390 with SMTP id
 98e67ed59e1d1-3a0d82b27b0mr2261793a91.46.1790500085644; 
 Sun, 27 Sep 2026 02:08:05 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm7144984a91.13.2026.09.27.02.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:08:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 100/101] tcg: Generic expansion of remaining atomic
 operations
Date: Sun, 27 Sep 2026 02:00:10 -0700
Message-ID: <20260927090011.10724-101-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

These are done in bulk because of existing macro magic.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  80 +-------------
 include/tcg/tcg-op-mem.h     |   2 +-
 include/tcg/tcg-op-def.h.inc |  20 ++++
 tcg/tcg-op-ldst.c            | 206 +++++++++++++----------------------
 4 files changed, 102 insertions(+), 206 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9864674f1c2..bc96c02aaea 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -181,89 +181,15 @@ void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, tcg_target_long offset);
 void tcg_gen_qemu_ld_chk_i128(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
 void tcg_gen_qemu_st_chk_i128(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
 
-/* Atomic ops */
-
 void tcg_gen_atomic_cmpxchg_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
                                      TCGv_i128, TCGArg, MemOp, TCGType);
 void tcg_gen_nonatomic_cmpxchg_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
                                         TCGv_i128, TCGArg, MemOp, TCGType);
-
-void tcg_gen_atomic_xchg_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                 TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_xchg_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                 TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_xchg_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
+void tcg_gen_atomic_xchg_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
                                   TCGArg, MemOp, TCGType);
-
-void tcg_gen_atomic_fetch_add_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_add_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_and_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_and_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_or_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                     TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_or_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                     TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_xor_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_xor_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_smin_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
+void tcg_gen_atomic_fetch_and_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
                                        TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_smin_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_umin_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_umin_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_smax_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_smax_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_umax_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_umax_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                       TCGArg, MemOp, TCGType);
-
-void tcg_gen_atomic_add_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_add_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_and_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_and_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_or_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                     TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_or_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                     TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_xor_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_xor_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                      TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_smin_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_smin_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_umin_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_umin_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_smax_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_smax_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_umax_fetch_i32_chk(TCGv_i32, TCGTemp *, TCGv_i32,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_umax_fetch_i64_chk(TCGv_i64, TCGTemp *, TCGv_i64,
-                                       TCGArg, MemOp, TCGType);
-
-void tcg_gen_atomic_fetch_and_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
-                                       TCGArg, MemOp, TCGType);
-void tcg_gen_atomic_fetch_or_i128_chk(TCGv_i128, TCGTemp *, TCGv_i128,
+void tcg_gen_atomic_fetch_or_chk_i128(TCGv_i128, TCGTemp *, TCGv_i128,
                                       TCGArg, MemOp, TCGType);
 
 /* Vector ops */
diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
index 935860f1442..6533704082e 100644
--- a/include/tcg/tcg-op-mem.h
+++ b/include/tcg/tcg-op-mem.h
@@ -67,7 +67,7 @@ tcg_gen_qemu_st_i128(TCGv_i128 v, TCGv_va a, TCGArg i, MemOp m)
 #define DEF_ATOMIC2(N, S)                                               \
     QEMU_ARG_NONNULL static inline void                                 \
     N##_##S(TCGv_##S r, TCGv_va a, TCGv_##S v, TCGArg i, MemOp m)       \
-    { N##_##S##_chk(r, tcgv_va_temp(a), v, i, m, TCG_TYPE_VA); }
+    { N##_chk_##S(r, tcgv_va_temp(a), v, i, m, TCG_TYPE_VA); }
 
 #define DEF_ATOMIC3(N, S)                                               \
     QEMU_ARG_NONNULL static inline void                                 \
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index e0ffd0da678..e694f0e38c4 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -88,3 +88,23 @@ DEF3(xori, TCGV, TCGV, TINT)
 
 DEF7(atomic_cmpxchg_chk, TCGV, TCGTempPtr, TCGV, TCGV, unsigned, MemOp, TCGType)
 DEF7(nonatomic_cmpxchg_chk, TCGV, TCGTempPtr, TCGV, TCGV, unsigned, MemOp, TCGType)
+
+DEF6(atomic_xchg_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+
+DEF6(atomic_fetch_add_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_fetch_and_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_fetch_or_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_fetch_smax_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_fetch_smin_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_fetch_umax_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_fetch_umin_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_fetch_xor_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+
+DEF6(atomic_add_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_and_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_or_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_smax_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_smin_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_umax_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_umin_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
+DEF6(atomic_xor_fetch_chk, TCGV, TCGTempPtr, TCGV, unsigned, MemOp, TCGType)
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index b3143f6311b..77679634cbf 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -877,113 +877,92 @@ void tcg_gen_atomic_cmpxchg_chk_i128(TCGv_i128 retv, TCGTemp *addr,
     tcg_gen_atomic_cmpxchg_int_i128(retv, addr, cmpv, newv, idx, memop);
 }
 
-static void do_nonatomic_op_i32(TCGv_i32 ret, TCGTemp *addr, TCGv_i32 val,
-                                TCGArg idx, MemOp memop, bool new_val,
-                                void (*gen)(TCGv_i32, TCGv_i32, TCGv_i32))
+static void do_nonatomic_op(TCGType type, TCGTemp *ret, TCGTemp *addr,
+                            TCGTemp *val, unsigned idx, MemOp memop,
+                            bool new_val,
+                            void (*gen)(TCGType, TCGTemp *,
+                                        TCGTemp *, TCGTemp *))
 {
-    TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-    TCGv_i32 t2 = tcg_temp_ebb_new_i32();
+    g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+    g_autoptr(TCGTemp) t2 = tcg_temp_new_ebb(type);
 
-    memop = tcg_canonicalize_memop(memop, 0, 0);
+    memop = tcg_canonicalize_memop(memop, type != TCG_TYPE_I32, 0);
 
-    tcg_gen_qemu_ld_int(TCG_TYPE_I32, tcgv_i32_temp(t1), addr, idx, memop);
-    tcg_gen_ext_i32(t2, val, memop);
-    gen(t2, t1, t2);
-    tcg_gen_qemu_st_int(TCG_TYPE_I32, tcgv_i32_temp(t2), addr, idx, memop);
+    tcg_gen_qemu_ld_int(type, t1, addr, idx, memop);
+    tcg_gen_ext(type, t2, val, memop);
+    gen(type, t2, t1, t2);
+    tcg_gen_qemu_st_int(type, t2, addr, idx, memop);
 
-    tcg_gen_ext_i32(ret, (new_val ? t2 : t1), memop);
-    tcg_temp_free_i32(t1);
-    tcg_temp_free_i32(t2);
+    tcg_gen_ext(type, ret, (new_val ? t2 : t1), memop);
 }
 
-static void do_atomic_op_i32(TCGv_i32 ret, TCGTemp *addr, TCGv_i32 val,
-                             TCGArg idx, MemOp memop, void * const table[])
+static void do_atomic_op(TCGType type, TCGTemp *ret, TCGTemp *addr,
+                         TCGTemp *val, unsigned idx, MemOp memop,
+                         void * const table[])
 {
-    gen_atomic_op_i32 gen;
-    TCGv_i64 a64;
+    TCGv_i64 a64 = maybe_extend_addr64(addr);
     MemOpIdx oi;
 
-    memop = tcg_canonicalize_memop(memop, 0, 0);
-
-    gen = table[memop & (MO_SIZE | MO_BSWAP)];
-    tcg_debug_assert(gen != NULL);
-
-    oi = make_memop_idx(memop & ~MO_SIGN, idx);
-    a64 = maybe_extend_addr64(addr);
-    gen(ret, tcg_env, a64, val, tcg_constant_i32(oi));
-    maybe_free_addr64(a64);
-
-    if (memop & MO_SIGN) {
-        tcg_gen_ext_i32(ret, ret, memop);
-    }
-}
-
-static void do_nonatomic_op_i64(TCGv_i64 ret, TCGTemp *addr, TCGv_i64 val,
-                                TCGArg idx, MemOp memop, bool new_val,
-                                void (*gen)(TCGv_i64, TCGv_i64, TCGv_i64))
-{
-    TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-    TCGv_i64 t2 = tcg_temp_ebb_new_i64();
-
-    memop = tcg_canonicalize_memop(memop, 1, 0);
-
-    tcg_gen_qemu_ld_int(TCG_TYPE_I64, tcgv_i64_temp(t1), addr, idx, memop);
-    tcg_gen_ext_i64(t2, val, memop);
-    gen(t2, t1, t2);
-    tcg_gen_qemu_st_int(TCG_TYPE_I64, tcgv_i64_temp(t2), addr, idx, memop);
-
-    tcg_gen_ext_i64(ret, (new_val ? t2 : t1), memop);
-    tcg_temp_free_i64(t1);
-    tcg_temp_free_i64(t2);
-}
-
-static void do_atomic_op_i64(TCGv_i64 ret, TCGTemp *addr, TCGv_i64 val,
-                             TCGArg idx, MemOp memop, void * const table[])
-{
-    memop = tcg_canonicalize_memop(memop, 1, 0);
-
     if ((memop & MO_SIZE) == MO_64) {
         gen_atomic_op_i64 gen = table[memop & (MO_SIZE | MO_BSWAP)];
+        tcg_debug_assert(gen != NULL);
+        tcg_debug_assert(type == TCG_TYPE_I64);
 
-        if (gen) {
-            MemOpIdx oi = make_memop_idx(memop & ~MO_SIGN, idx);
-            TCGv_i64 a64 = maybe_extend_addr64(addr);
-            gen(ret, tcg_env, a64, val, tcg_constant_i32(oi));
-            maybe_free_addr64(a64);
-            return;
+        memop = tcg_canonicalize_memop(memop, 1, 0);
+        oi = make_memop_idx(memop & ~MO_SIGN, idx);
+
+        gen(temp_tcgv_i64(ret), tcg_env, a64,
+            temp_tcgv_i64(val), tcg_constant_i32(oi));
+    } else {
+        g_autoptr(TCGTemp) v32 = NULL;
+        g_autoptr(TCGTemp) r32 = NULL;
+        TCGTemp *ret_orig = ret;
+
+        gen_atomic_op_i32 gen = table[memop & (MO_SIZE | MO_BSWAP)];
+        tcg_debug_assert(gen != NULL);
+
+        if (type == TCG_TYPE_I64) {
+            v32 = tcg_temp_new_ebb(TCG_TYPE_I32);
+            r32 = tcg_temp_new_ebb(TCG_TYPE_I32);
+
+            tcg_gen_extrl(v32, val);
+            val = v32;
+            ret = r32;
         }
 
-        gen_helper_exit_atomic(tcg_env);
-        /* Produce a result, so that we have a well-formed opcode stream
-           with respect to uses of the result in the (dead) code following.  */
-        tcg_gen_movi_i64(ret, 0);
-    } else {
-        TCGv_i32 v32 = tcg_temp_ebb_new_i32();
-        TCGv_i32 r32 = tcg_temp_ebb_new_i32();
+        memop = tcg_canonicalize_memop(memop, 0, 0);
+        oi = make_memop_idx(memop & ~MO_SIGN, idx);
 
-        tcg_gen_extrl_i64_i32(v32, val);
-        do_atomic_op_i32(r32, addr, v32, idx, memop & ~MO_SIGN, table);
-        tcg_temp_free_i32(v32);
-
-        tcg_gen_extu_i32_i64(ret, r32);
-        tcg_temp_free_i32(r32);
+        gen(temp_tcgv_i32(ret), tcg_env, a64,
+            temp_tcgv_i32(val), tcg_constant_i32(oi));
 
         if (memop & MO_SIGN) {
-            tcg_gen_ext_i64(ret, ret, memop);
+            tcg_gen_ext(TCG_TYPE_I32, ret, ret, memop);
+        }
+        if (ret != ret_orig) {
+            if (memop & MO_SIGN) {
+                tcg_gen_exts(ret_orig, ret);
+            } else {
+                 tcg_gen_extu(ret_orig, ret);
+            }
         }
     }
+    maybe_free_addr64(a64);
 }
 
 static void do_nonatomic_op_i128(TCGv_i128 ret, TCGTemp *addr, TCGv_i128 val,
                                  TCGArg idx, MemOp memop, bool new_val,
-                                 void (*gen)(TCGv_i64, TCGv_i64, TCGv_i64))
+                                 void (*gen)(TCGType, TCGTemp *,
+                                             TCGTemp *, TCGTemp *))
 {
     TCGv_i128 t = tcg_temp_ebb_new_i128();
     TCGv_i128 r = tcg_temp_ebb_new_i128();
 
     tcg_gen_qemu_ld_i128_int(r, addr, idx, memop);
-    gen(TCGV128_LOW(t), TCGV128_LOW(r), TCGV128_LOW(val));
-    gen(TCGV128_HIGH(t), TCGV128_HIGH(r), TCGV128_HIGH(val));
+    gen(TCG_TYPE_I64, tcgv_i64_temp(TCGV128_LOW(t)),
+        tcgv_i64_temp(TCGV128_LOW(r)), tcgv_i64_temp(TCGV128_LOW(val)));
+    gen(TCG_TYPE_I64, tcgv_i64_temp(TCGV128_HIGH(t)),
+        tcgv_i64_temp(TCGV128_HIGH(r)), tcgv_i64_temp(TCGV128_HIGH(val)));
     tcg_gen_qemu_st_i128_int(t, addr, idx, memop);
 
     tcg_gen_mov_i128(ret, r);
@@ -1022,33 +1001,21 @@ static void * const table_##NAME[(MO_SIZE | MO_BSWAP) + 1] = {          \
     WITH_ATOMIC128([MO_128 | MO_LE] = gen_helper_atomic_##NAME##o_le)   \
     WITH_ATOMIC128([MO_128 | MO_BE] = gen_helper_atomic_##NAME##o_be)   \
 };                                                                      \
-void tcg_gen_atomic_##NAME##_i32_chk(TCGv_i32 ret, TCGTemp *addr,       \
-                                     TCGv_i32 val, TCGArg idx,          \
-                                     MemOp memop, TCGType addr_type)    \
+void tcg_gen_atomic_##NAME##_chk(TCGType val_type, TCGTemp *ret,        \
+                                 TCGTemp *addr, TCGTemp *val, unsigned idx, \
+                                 MemOp memop, TCGType addr_type)        \
 {                                                                       \
     tcg_debug_assert(addr_type == tcg_ctx->addr_type);                  \
-    tcg_debug_assert((memop & MO_SIZE) <= MO_32);                       \
+    tcg_debug_assert(memop_size(memop) <= tcg_type_size(val_type));     \
+    tcg_debug_assert(idx < NB_MMU_MODES);                               \
     if (tcg_ctx->gen_tb->cflags & CF_PARALLEL) {                        \
-        do_atomic_op_i32(ret, addr, val, idx, memop, table_##NAME);     \
+        do_atomic_op(val_type, ret, addr, val, idx, memop, table_##NAME); \
     } else {                                                            \
-        do_nonatomic_op_i32(ret, addr, val, idx, memop, NEW,            \
-                            tcg_gen_##OP##_i32);                        \
+        do_nonatomic_op(val_type, ret, addr, val, idx, memop, NEW,      \
+                        tcg_gen_##OP);                                  \
     }                                                                   \
 }                                                                       \
-void tcg_gen_atomic_##NAME##_i64_chk(TCGv_i64 ret, TCGTemp *addr,       \
-                                     TCGv_i64 val, TCGArg idx,          \
-                                     MemOp memop, TCGType addr_type)    \
-{                                                                       \
-    tcg_debug_assert(addr_type == tcg_ctx->addr_type);                  \
-    tcg_debug_assert((memop & MO_SIZE) <= MO_64);                       \
-    if (tcg_ctx->gen_tb->cflags & CF_PARALLEL) {                        \
-        do_atomic_op_i64(ret, addr, val, idx, memop, table_##NAME);     \
-    } else {                                                            \
-        do_nonatomic_op_i64(ret, addr, val, idx, memop, NEW,            \
-                            tcg_gen_##OP##_i64);                        \
-    }                                                                   \
-}                                                                       \
-void tcg_gen_atomic_##NAME##_i128_chk(TCGv_i128 ret, TCGTemp *addr,     \
+void tcg_gen_atomic_##NAME##_chk_i128(TCGv_i128 ret, TCGTemp *addr,     \
                                       TCGv_i128 val, TCGArg idx,        \
                                       MemOp memop, TCGType addr_type)   \
 {                                                                       \
@@ -1058,7 +1025,7 @@ void tcg_gen_atomic_##NAME##_i128_chk(TCGv_i128 ret, TCGTemp *addr,     \
         do_atomic_op_i128(ret, addr, val, idx, memop, table_##NAME);    \
     } else {                                                            \
         do_nonatomic_op_i128(ret, addr, val, idx, memop, NEW,           \
-                             tcg_gen_##OP##_i64);                       \
+                             tcg_gen_##OP);                             \
     }                                                                   \
 }
 
@@ -1072,30 +1039,18 @@ static void * const table_##NAME[(MO_SIZE | MO_BSWAP) + 1] = {          \
     [MO_64 | MO_LE] = gen_helper_atomic_##NAME##q_le,                   \
     [MO_64 | MO_BE] = gen_helper_atomic_##NAME##q_be,                   \
 };                                                                      \
-void tcg_gen_atomic_##NAME##_i32_chk(TCGv_i32 ret, TCGTemp *addr,       \
-                                     TCGv_i32 val, TCGArg idx,          \
-                                     MemOp memop, TCGType addr_type)    \
+void tcg_gen_atomic_##NAME##_chk(TCGType val_type, TCGTemp *ret,        \
+                                 TCGTemp *addr, TCGTemp *val, unsigned idx, \
+                                 MemOp memop, TCGType addr_type)        \
 {                                                                       \
     tcg_debug_assert(addr_type == tcg_ctx->addr_type);                  \
-    tcg_debug_assert((memop & MO_SIZE) <= MO_32);                       \
+    tcg_debug_assert(memop_size(memop) <= tcg_type_size(val_type));     \
+    tcg_debug_assert(idx < NB_MMU_MODES);                               \
     if (tcg_ctx->gen_tb->cflags & CF_PARALLEL) {                        \
-        do_atomic_op_i32(ret, addr, val, idx, memop, table_##NAME);     \
+        do_atomic_op(val_type, ret, addr, val, idx, memop, table_##NAME); \
     } else {                                                            \
-        do_nonatomic_op_i32(ret, addr, val, idx, memop, NEW,            \
-                            tcg_gen_##OP##_i32);                        \
-    }                                                                   \
-}                                                                       \
-void tcg_gen_atomic_##NAME##_i64_chk(TCGv_i64 ret, TCGTemp *addr,       \
-                                     TCGv_i64 val, TCGArg idx,          \
-                                     MemOp memop, TCGType addr_type)    \
-{                                                                       \
-    tcg_debug_assert(addr_type == tcg_ctx->addr_type);                  \
-    tcg_debug_assert((memop & MO_SIZE) <= MO_64);                       \
-    if (tcg_ctx->gen_tb->cflags & CF_PARALLEL) {                        \
-        do_atomic_op_i64(ret, addr, val, idx, memop, table_##NAME);     \
-    } else {                                                            \
-        do_nonatomic_op_i64(ret, addr, val, idx, memop, NEW,            \
-                            tcg_gen_##OP##_i64);                        \
+        do_nonatomic_op(val_type, ret, addr, val, idx, memop, NEW,      \
+                        tcg_gen_##OP);                                  \
     }                                                                   \
 }
 
@@ -1117,14 +1072,9 @@ GEN_ATOMIC_HELPER(umin_fetch, umin, 1)
 GEN_ATOMIC_HELPER(smax_fetch, smax, 1)
 GEN_ATOMIC_HELPER(umax_fetch, umax, 1)
 
-static void tcg_gen_mov2_i32(TCGv_i32 r, TCGv_i32 a, TCGv_i32 b)
+static void tcg_gen_mov2(TCGType type, TCGTemp *r, TCGTemp *a, TCGTemp *b)
 {
-    tcg_gen_mov_i32(r, b);
-}
-
-static void tcg_gen_mov2_i64(TCGv_i64 r, TCGv_i64 a, TCGv_i64 b)
-{
-    tcg_gen_mov_i64(r, b);
+    tcg_gen_mov(type, r, b);
 }
 
 GEN_ATOMIC_HELPER128(xchg, mov2, 0)
-- 
2.53.0


