Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC44C7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT868-0000Wl-E6; Sat, 21 Jun 2025 19:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85f-0005it-3X
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:44 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85c-0006cg-O4
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:42 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-742c7a52e97so2413602b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550259; x=1751155059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cOUr08W+SNGnhfq/OGv+VySWrr4JKZUGPAS+GZzZerU=;
 b=cZGXfUvEHzoH+D3o3PlX/PK4hHIRtmBqbjcoa95jCdlkpD+8gvRlVO4yIQEWkOrzmE
 VTW5XY3bZi/buTST/zu0lKGP7wvVEYZQDduyp6omuJxEbCubSgvpa7BL1lDnQ2y8ZvQi
 2ilpvfvqLBb8DDA12LxQZ7b34rm7HJNLY0OIJQK+MSUKVn5NjAgAfaeAJQotZrojZGib
 pdmfqDvh0Ba4pSoQUyTfxWKGeCfdmzoIS1ZzIXGScuhomhoqZY40ShTfCJvHTqrZ5ckP
 UEhRFm3Gc4MiIOs2xzU17nhSgyghkkJHAaY3s8oKKAkPlczIY2D3oYWkpPlU+XLAQcJB
 DRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550259; x=1751155059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cOUr08W+SNGnhfq/OGv+VySWrr4JKZUGPAS+GZzZerU=;
 b=QmkdcTvtUMrhfH7yufUMscAFMKRcbNHZfXeWyiZQdfFnoNu+gc6mEqhApXXdII8/Xf
 e9caFQXVN3+z3522ivRf3Ft9iyeVBtTpZYiFGoGfys+Yl7P9gQcjRU6C69zgFMJQ1t1E
 ArfR1JDal17kISC4eNO8WZg40LPp1y+2BC/sr94lQs4yJRYzGN4Ej6Ald+hZRNq6ozTi
 YPYE7XOZ5VvcltIh9CBJ4aFuxtG0iL7EwaaAzoTW+XBh1g8sXBluPGKcnA0InkWzS8mG
 sEfeMU0WoxlP65/c1voAQKYV4kikiOhdUET3sQyNqL+ywLKatfngb1e+AjtQFWZbfcmU
 29Ug==
X-Gm-Message-State: AOJu0YwcxHlOXpq+klNvdHzD+GbA5atNh5aYOoSEbO3pfrjOknF9+KOR
 JK+7vVBa+k9tlG3aE9nCYDnaA8yX8Sr9874cezdSQoOljI1Jin569NBCv8Dl6fKdIRB06Vh49bT
 PmFuMOis=
X-Gm-Gg: ASbGnctZwwRMWoQrz5RUircwPQtc6qADd66jBbnOOzyryiSeP3/vpWmf851h5I1Xkim
 z1BOBgIUXYXL4o7JE8bORSLbVlYCN1KoaAM8ZtV3o5HzTbZMk2sPCkISaYdV09v2ZWxTXjlWv5M
 E23jFOuaXkIPbb3elC0cxGuAxKq7rHRcxnHOmmPhxSqfx2ijBOzp3qXzf2fjjCOHVQUv8zxN7L6
 mCxKEeDB1C4wdLz68OY4zhEJXnjNRXfMtPhLpgm9zEl7Hn7sP8UQnkdJfw+Uk2Vc/NyUClXJcxR
 mmKtiwvQyTVByxLU3XRH0ZnEGpaRF8AH/8hRlKl/cmgDO7THxd0IQOdbJodbhffeWfGHS9c+/1U
 Dz2+jtXdcNgwZNMFli9D3
X-Google-Smtp-Source: AGHT+IHYELGFHdTvVK+faNaLxg/a4480+e9Hu3k4yWESS5Q0PV5+dXezfbAi3J8GgO/bZs3NalRJkA==
X-Received: by 2002:a05:6a20:144f:b0:1f5:97c3:41b9 with SMTP id
 adf61e73a8af0-22026e6113amr10573591637.5.1750550259213; 
 Sat, 21 Jun 2025 16:57:39 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12584cbsm4551790a12.55.2025.06.21.16.57.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:57:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 094/101] target/arm: Move ld1qq and st1qq primitives to
 sve_ldst_internal.h
Date: Sat, 21 Jun 2025 16:50:30 -0700
Message-ID: <20250621235037.74091-95-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Move from sme_helper.c to the shared header.
Add a comment noting the lack of atomicity.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_ldst_internal.h | 63 ++++++++++++++++++++++++++++++
 target/arm/tcg/sme_helper.c        | 44 +++------------------
 2 files changed, 69 insertions(+), 38 deletions(-)

diff --git a/target/arm/tcg/sve_ldst_internal.h b/target/arm/tcg/sve_ldst_internal.h
index e87beba435..c67cda9d3b 100644
--- a/target/arm/tcg/sve_ldst_internal.h
+++ b/target/arm/tcg/sve_ldst_internal.h
@@ -141,6 +141,69 @@ DO_LD_PRIM_3(ld1dqu_le, ld1dd_le)
 #define sve_st1dq_be_tlb   sve_st1dd_be_tlb
 #define sve_st1dq_le_tlb   sve_st1dd_le_tlb
 
+/*
+ * The ARMVectorReg elements are stored in host-endian 64-bit units.
+ * For 128-bit quantities, the sequence defined by the Elem[] pseudocode
+ * corresponds to storing the two 64-bit pieces in little-endian order.
+ */
+/* FIXME: Nothing in this file makes any effort at atomicity. */
+
+static inline void sve_ld1qq_be_host(void *vd, intptr_t reg_off, void *host)
+{
+    sve_ld1dd_be_host(vd, reg_off + 8, host);
+    sve_ld1dd_be_host(vd, reg_off, host + 8);
+}
+
+static inline void sve_ld1qq_le_host(void *vd, intptr_t reg_off, void *host)
+{
+    sve_ld1dd_le_host(vd, reg_off, host);
+    sve_ld1dd_le_host(vd, reg_off + 8, host + 8);
+}
+
+static inline void
+sve_ld1qq_be_tlb(CPUARMState *env, void *vd, intptr_t reg_off,
+                 target_ulong addr, uintptr_t ra)
+{
+    sve_ld1dd_be_tlb(env, vd, reg_off + 8, addr, ra);
+    sve_ld1dd_be_tlb(env, vd, reg_off, addr + 8, ra);
+}
+
+static inline void
+sve_ld1qq_le_tlb(CPUARMState *env, void *vd, intptr_t reg_off,
+                 target_ulong addr, uintptr_t ra)
+{
+    sve_ld1dd_le_tlb(env, vd, reg_off, addr, ra);
+    sve_ld1dd_le_tlb(env, vd, reg_off + 8, addr + 8, ra);
+}
+
+static inline void sve_st1qq_be_host(void *vd, intptr_t reg_off, void *host)
+{
+    sve_st1dd_be_host(vd, reg_off + 8, host);
+    sve_st1dd_be_host(vd, reg_off, host + 8);
+}
+
+static inline void sve_st1qq_le_host(void *vd, intptr_t reg_off, void *host)
+{
+    sve_st1dd_le_host(vd, reg_off, host);
+    sve_st1dd_le_host(vd, reg_off + 8, host + 8);
+}
+
+static inline void
+sve_st1qq_be_tlb(CPUARMState *env, void *vd, intptr_t reg_off,
+                 target_ulong addr, uintptr_t ra)
+{
+    sve_st1dd_be_tlb(env, vd, reg_off + 8, addr, ra);
+    sve_st1dd_be_tlb(env, vd, reg_off, addr + 8, ra);
+}
+
+static inline void
+sve_st1qq_le_tlb(CPUARMState *env, void *vd, intptr_t reg_off,
+                 target_ulong addr, uintptr_t ra)
+{
+    sve_st1dd_le_tlb(env, vd, reg_off, addr, ra);
+    sve_st1dd_le_tlb(env, vd, reg_off + 8, addr + 8, ra);
+}
+
 #undef DO_LD_TLB
 #undef DO_ST_TLB
 #undef DO_LD_HOST
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index c8e6a56600..807b160c90 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -408,54 +408,22 @@ static inline void sme_##NAME##_v_tlb(CPUARMState *env, void *za,           \
     TLB(env, useronly_clean_ptr(addr), val, ra);                            \
 }
 
-/*
- * The ARMVectorReg elements are stored in host-endian 64-bit units.
- * For 128-bit quantities, the sequence defined by the Elem[] pseudocode
- * corresponds to storing the two 64-bit pieces in little-endian order.
- */
-#define DO_LDQ(HNAME, VNAME, BE, HOST, TLB)                                 \
-static inline void HNAME##_host(void *za, intptr_t off, void *host)         \
-{                                                                           \
-    uint64_t val0 = HOST(host), val1 = HOST(host + 8);                      \
-    uint64_t *ptr = za + off;                                               \
-    ptr[0] = BE ? val1 : val0, ptr[1] = BE ? val0 : val1;                   \
-}                                                                           \
+#define DO_LDQ(HNAME, VNAME) \
 static inline void VNAME##_v_host(void *za, intptr_t off, void *host)       \
 {                                                                           \
     HNAME##_host(za, tile_vslice_offset(off), host);                        \
 }                                                                           \
-static inline void HNAME##_tlb(CPUARMState *env, void *za, intptr_t off,    \
-                               target_ulong addr, uintptr_t ra)             \
-{                                                                           \
-    uint64_t val0 = TLB(env, useronly_clean_ptr(addr), ra);                 \
-    uint64_t val1 = TLB(env, useronly_clean_ptr(addr + 8), ra);             \
-    uint64_t *ptr = za + off;                                               \
-    ptr[0] = BE ? val1 : val0, ptr[1] = BE ? val0 : val1;                   \
-}                                                                           \
 static inline void VNAME##_v_tlb(CPUARMState *env, void *za, intptr_t off,  \
                                target_ulong addr, uintptr_t ra)             \
 {                                                                           \
     HNAME##_tlb(env, za, tile_vslice_offset(off), addr, ra);                \
 }
 
-#define DO_STQ(HNAME, VNAME, BE, HOST, TLB)                                 \
-static inline void HNAME##_host(void *za, intptr_t off, void *host)         \
-{                                                                           \
-    uint64_t *ptr = za + off;                                               \
-    HOST(host, ptr[BE]);                                                    \
-    HOST(host + 8, ptr[!BE]);                                               \
-}                                                                           \
+#define DO_STQ(HNAME, VNAME) \
 static inline void VNAME##_v_host(void *za, intptr_t off, void *host)       \
 {                                                                           \
     HNAME##_host(za, tile_vslice_offset(off), host);                        \
 }                                                                           \
-static inline void HNAME##_tlb(CPUARMState *env, void *za, intptr_t off,    \
-                               target_ulong addr, uintptr_t ra)             \
-{                                                                           \
-    uint64_t *ptr = za + off;                                               \
-    TLB(env, useronly_clean_ptr(addr), ptr[BE], ra);                        \
-    TLB(env, useronly_clean_ptr(addr + 8), ptr[!BE], ra);                   \
-}                                                                           \
 static inline void VNAME##_v_tlb(CPUARMState *env, void *za, intptr_t off,  \
                                target_ulong addr, uintptr_t ra)             \
 {                                                                           \
@@ -470,8 +438,8 @@ DO_LD(ld1s_le, uint32_t, ldl_le_p, cpu_ldl_le_data_ra)
 DO_LD(ld1d_be, uint64_t, ldq_be_p, cpu_ldq_be_data_ra)
 DO_LD(ld1d_le, uint64_t, ldq_le_p, cpu_ldq_le_data_ra)
 
-DO_LDQ(sve_ld1qq_be, sme_ld1q_be, 1, ldq_be_p, cpu_ldq_be_data_ra)
-DO_LDQ(sve_ld1qq_le, sme_ld1q_le, 0, ldq_le_p, cpu_ldq_le_data_ra)
+DO_LDQ(sve_ld1qq_be, sme_ld1q_be)
+DO_LDQ(sve_ld1qq_le, sme_ld1q_le)
 
 DO_ST(st1b, uint8_t, stb_p, cpu_stb_data_ra)
 DO_ST(st1h_be, uint16_t, stw_be_p, cpu_stw_be_data_ra)
@@ -481,8 +449,8 @@ DO_ST(st1s_le, uint32_t, stl_le_p, cpu_stl_le_data_ra)
 DO_ST(st1d_be, uint64_t, stq_be_p, cpu_stq_be_data_ra)
 DO_ST(st1d_le, uint64_t, stq_le_p, cpu_stq_le_data_ra)
 
-DO_STQ(sve_st1qq_be, sme_st1q_be, 1, stq_be_p, cpu_stq_be_data_ra)
-DO_STQ(sve_st1qq_le, sme_st1q_le, 0, stq_le_p, cpu_stq_le_data_ra)
+DO_STQ(sve_st1qq_be, sme_st1q_be)
+DO_STQ(sve_st1qq_le, sme_st1q_le)
 
 #undef DO_LD
 #undef DO_ST
-- 
2.43.0


