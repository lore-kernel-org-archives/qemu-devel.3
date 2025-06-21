Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8F3C7115D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT85k-00060G-Ls; Sat, 21 Jun 2025 19:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85X-0004l1-MT
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:36 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85U-0006aY-Of
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:35 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b31cd61b2a9so2038886a12.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550251; x=1751155051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zEu0B/j+btRkLVT4XQqxQ0UUVHmJKW/EQ4UFYcVZTNE=;
 b=L0GqNDOHZZKTzLKW2cNLgH+z0SABeRtpr10FZJ0WLeO9bnXl9QGusAIpXMbuJr07WT
 Hx6BSGpg0WE/S7QdSo/AQjfBPCDdwyFHCG/m85164GZTzy/Xh+bdyc1/BzUvouKGST2g
 0VBj2Nq6fTeLnaVdYggUJUe46LgN7xtZmEpsjSotIxkmR5CyvXl0E6rB5CcVdQyAIELB
 iUKbh+fRGqoc8m9SFTek3FrPtLf3UdKlPlSaeqKkJU3MEt02s9IxxEapSvs03yyTnT7u
 Me+ztG63wzzf8a8dwrqF3BPV+e/aHzbcjAKWebDc5qGBK1+U3zccW8maGlSVRj41X1Ts
 6LAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550251; x=1751155051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zEu0B/j+btRkLVT4XQqxQ0UUVHmJKW/EQ4UFYcVZTNE=;
 b=uPBQaYg7ptQVVv3A8LDxLUOy3vI9Heyz/QDUU7NgXtpOyYHrzcgAY5yfncA9Cj+6zp
 kEHSGLGW8uVHKOEL0pX5DA8Z2HmbXZDvsCtpyMmRv89KQJnQ1uDZsVMRs/1QaUoqdL7a
 p7btEiWeTHJOq7XG8Ij9he8IihFUGfTRWcy4wtW5rE/VY6RaQ+z86sQ8B0mOOug9SDlc
 xfGPta7Dpv1gcPkFH/NKkHLz6fFMp5yD8e2HnHidwypsXEWnwitMBn8AEnAWJ8qmNwLM
 CRkp2QvKnAQHBOzJQLJ13uANkrVmWP3kBhFHHrgc21CYWuacb/7VHvR+BpnQJ4Oo6GHx
 UnCw==
X-Gm-Message-State: AOJu0Yyx0WhvrRVZvtUaCMiL2gcao8Ndo81Z8qkNkIQpd9aKfEGOvmE/
 Znop6PUIpE0mUCvLooxzL3W1h4Vt3SaCoLWwRo3joF3ekdaNmOezEkffFLE+1j0KXfRL0S60NbM
 IGWebLi4=
X-Gm-Gg: ASbGncvklAEgLN/P0uRRbCRsrc8a8xOYjqiHcXOdCBqRGNLAC+j7XSR9cWwBDyRnMJh
 nMT7oXrmWh1ZnpzjSXCpvlEKOWlPJdrwrBqaNRC5pdvcJKwBO62h/ZDedteepwa3wNNRMRByK8V
 AxU8JkNqTPHoKhvP29WtfjyToEvmqHjF5Lk4+uJIevsReB3C9ynXiGPUHX6KyAWCNBogYDibxSz
 A0DM8B5CN1NUyHHkGqITKLNfr//QR3+FAKQl0L//q/esFMtvFSzjega/OZK9PTkHUgE0a5/kV56
 kQy598I/h9V/79cLcMKlua7RYRNNV+3QvqGOCGB6ACMbe2cLN9/PsjtSRE3G1YHOLLQ0AlP9DWs
 b4S/tOQXTku8EanTSzlkqBwsoqnKbl84=
X-Google-Smtp-Source: AGHT+IFFK2XuToLO+Eb7BGuT6wnFmwdWOdQNRdINjNKVhuMsMUWbzl4FiSqiWxGRwANinMp1Qt3u2A==
X-Received: by 2002:a05:6a21:9987:b0:21f:8d4f:9e3b with SMTP id
 adf61e73a8af0-22026e60126mr12123464637.7.1750550250991; 
 Sat, 21 Jun 2025 16:57:30 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12584cbsm4551790a12.55.2025.06.21.16.57.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:57:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 082/101] target/arm: Implement ANDQV, ORQV, EORQV for SVE2p1
Date: Sat, 21 Jun 2025 16:50:18 -0700
Message-ID: <20250621235037.74091-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 15 ++++++++++++
 target/arm/tcg/sve_helper.c    | 42 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c |  3 +++
 target/arm/tcg/sve.decode      |  5 ++++
 4 files changed, 65 insertions(+)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index ec82d0a4e7..9758613b2d 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -2955,3 +2955,18 @@ DEF_HELPER_FLAGS_4(sve2p1_uminqv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2p1_uminqv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_3(pext, TCG_CALL_NO_RWG, void, ptr, i32, i32)
+
+DEF_HELPER_FLAGS_4(sve2p1_orqv_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_orqv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_orqv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_orqv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2p1_eorqv_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_eorqv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_eorqv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_eorqv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2p1_andqv_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_andqv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_andqv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_andqv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index eaf9363c0a..ebe4862784 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -123,6 +123,11 @@ static inline uint64_t expand_pred_s(uint8_t byte)
     return word[byte & 0x11];
 }
 
+static inline uint64_t expand_pred_d(uint8_t byte)
+{
+    return -(uint64_t)(byte & 1);
+}
+
 #define LOGICAL_PPPP(NAME, FUNC) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc)  \
 {                                                                         \
@@ -206,6 +211,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc) \
 #define DO_EOR(N, M)  (N ^ M)
 #define DO_ORR(N, M)  (N | M)
 #define DO_BIC(N, M)  (N & ~M)
+#define DO_ORC(N, M)  (N | ~M)
 #define DO_ADD(N, M)  (N + M)
 #define DO_SUB(N, M)  (N - M)
 #define DO_MAX(N, M)  ((N) >= (M) ? (N) : (M))
@@ -1900,10 +1906,46 @@ DO_ZZI(sve_umini_d, uint64_t, DO_MIN)
 
 #undef DO_ZZI
 
+#define DO_LOGIC_QV(NAME, SUFF, INIT, VOP, POP)                         \
+void HELPER(NAME ## _ ## SUFF)(void *vd, void *vn, void *vg, uint32_t desc) \
+{                                                                       \
+    unsigned seg = simd_oprsz(desc) / 16;                               \
+    uint64_t r0 = INIT, r1 = INIT;                                      \
+    for (unsigned s = 0; s < seg; s++) {                                \
+        uint64_t p0 = expand_pred_##SUFF(*(uint8_t *)(vg + H1(s * 2))); \
+        uint64_t p1 = expand_pred_##SUFF(*(uint8_t *)(vg + H1(s * 2 + 1))); \
+        uint64_t v0 = *(uint64_t *)(vn + s * 16);                       \
+        uint64_t v1 = *(uint64_t *)(vn + s * 16 + 8);                   \
+        v0 = POP(v0, p0), v1 = POP(v1, p1);                             \
+        r0 = VOP(r0, v0), r1 = VOP(r1, v1);                             \
+    }                                                                   \
+    *(uint64_t *)(vd + 0) = r0;                                         \
+    *(uint64_t *)(vd + 8) = r1;                                         \
+    clear_tail(vd, 16, simd_maxsz(desc));                               \
+}
+
+DO_LOGIC_QV(sve2p1_orqv, b, 0, DO_ORR, DO_AND)
+DO_LOGIC_QV(sve2p1_orqv, h, 0, DO_ORR, DO_AND)
+DO_LOGIC_QV(sve2p1_orqv, s, 0, DO_ORR, DO_AND)
+DO_LOGIC_QV(sve2p1_orqv, d, 0, DO_ORR, DO_AND)
+
+DO_LOGIC_QV(sve2p1_eorqv, b, 0, DO_EOR, DO_AND)
+DO_LOGIC_QV(sve2p1_eorqv, h, 0, DO_EOR, DO_AND)
+DO_LOGIC_QV(sve2p1_eorqv, s, 0, DO_EOR, DO_AND)
+DO_LOGIC_QV(sve2p1_eorqv, d, 0, DO_EOR, DO_AND)
+
+DO_LOGIC_QV(sve2p1_andqv, b, -1, DO_AND, DO_ORC)
+DO_LOGIC_QV(sve2p1_andqv, h, -1, DO_AND, DO_ORC)
+DO_LOGIC_QV(sve2p1_andqv, s, -1, DO_AND, DO_ORC)
+DO_LOGIC_QV(sve2p1_andqv, d, -1, DO_AND, DO_ORC)
+
+#undef DO_LOGIC_QV
+
 #undef DO_AND
 #undef DO_ORR
 #undef DO_EOR
 #undef DO_BIC
+#undef DO_ORC
 #undef DO_ADD
 #undef DO_SUB
 #undef DO_MAX
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 98799298ba..6aca2e3dec 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -778,6 +778,9 @@ DO_ZPZ(NOT_zpz, aa64_sve, sve_not_zpz)
 DO_ZPZ(ABS, aa64_sve, sve_abs)
 DO_ZPZ(NEG, aa64_sve, sve_neg)
 DO_ZPZ(RBIT, aa64_sve, sve_rbit)
+DO_ZPZ(ORQV, aa64_sme2p1_or_sve2p1, sve2p1_orqv)
+DO_ZPZ(EORQV, aa64_sme2p1_or_sve2p1, sve2p1_eorqv)
+DO_ZPZ(ANDQV, aa64_sme2p1_or_sve2p1, sve2p1_andqv)
 
 static gen_helper_gvec_3 * const fabs_fns[4] = {
     NULL,                  gen_helper_sve_fabs_h,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 39d7a29c06..a6541353ce 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -326,6 +326,11 @@ ORV             00000100 .. 011 000 001 ... ..... .....         @rd_pg_rn
 EORV            00000100 .. 011 001 001 ... ..... .....         @rd_pg_rn
 ANDV            00000100 .. 011 010 001 ... ..... .....         @rd_pg_rn
 
+# SVE2.1 bitwise logical reduction (quadwords)
+ORQV            00000100 .. 011 100 001 ... ..... .....         @rd_pg_rn
+EORQV           00000100 .. 011 101 001 ... ..... .....         @rd_pg_rn
+ANDQV           00000100 .. 011 110 001 ... ..... .....         @rd_pg_rn
+
 # SVE constructive prefix (predicated)
 MOVPRFX_z       00000100 .. 010 000 001 ... ..... .....         @rd_pg_rn
 MOVPRFX_m       00000100 .. 010 001 001 ... ..... .....         @rd_pg_rn
-- 
2.43.0


