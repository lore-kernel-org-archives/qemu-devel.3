Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4F5C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjGn-00007Y-To; Fri, 04 Jul 2025 12:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFF-0003Ep-NU
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:37 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFD-0006sv-Oa
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:37 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so12232255e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646394; x=1752251194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Iq44g23aFUWCk1V9aSX7ATwN3BZ7KkbwTaT+imfmP1c=;
 b=q/vbt2T7oD6CRo3nZpkDOIloHYHtmWuGZ49vcBn1V1u3brCaXhEzbjx7ciiKXzUxz1
 NtNDdhCA1+Xkudv2qyjlpgXqZEuR5mUQYzyyhFmbbBKj95Bnlm/eVGsroYI3UyeSSfAv
 5uGSQfIaalp/krLnM3ZqJPa1WTCN0mXg3g/bUEZczcBSnSLYfSOItiF0hV+NIo1QhQB0
 YcWK52pxU3Y4fBIKgJ6y4ulYAlcJxRoFnm6/yXZpLlyD53YySbPeUVgXaovQFLWIqeyQ
 jAzHmTP/Q2uIgpuiCygiezL5Oug8dH2gDF+S72Agp92lhq11UawEaz5UCTcc/h8LTmM1
 p1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646394; x=1752251194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iq44g23aFUWCk1V9aSX7ATwN3BZ7KkbwTaT+imfmP1c=;
 b=u6yWD7lEnRd/WLWCpjCUQcCAKp7zJxwG3u3Q7gLJxrPxZZg4LA/8K9YUIEA4uXWOY0
 oRBzum6On/jeg97xOziVno7CB2rcISYxglFDlYTr2WC64fpLrxem/5o5MQnR+/KAMIvq
 3h8s2eDoSqp+0ExgMr2CyU0DvvPOFJIlSpfTlFiCTdi42kxYVAVjOzTTCzppaE1BEsZm
 sDK4p078gGELIawkgbNDXw8Z8UG5MHRa17Hv868LZVZmzjjHgYP+q21Afof7G6E2+m2B
 9Tk8yEwobq72Di0VuqW8IxV1ezZ0ciKvxTanYtO3DSAUOmbfeFnRqRwcnN2bDn2Gybqh
 M9ew==
X-Gm-Message-State: AOJu0YzAzRkRR7K3ja0RrpjltTbskdO63ntWlCo3zjQgsRN9pCRdP5at
 s+fjZh/Zy1vuOF4jo1lwKooC5mpkk34rbj+3OqECzONG5hecvz9HU2DHkzObpdX1jeFr2e97eEL
 k/Y6L
X-Gm-Gg: ASbGncsp9DoIFT6S75U/3PH10xu60E0kHPEjpqfrrcfN5GNaypFMQe3AeP9i2l7Mt06
 gwJBbGAmCTiUaHwAr5tZ71HW2UeBx6lH8G5YFnpe3SSCHpTYKDkKurEoFgKQ3Tvttlq/HjTdkID
 er2Pi3KpYapwj2nEaEUgNL5OxsGi68nKdorsBz2GAcIl9DBW2oQvrCgVCQ7uK44iHnF7UYkXi0k
 Hx5OYxg/HQvmowbdNK9t/iQzu72reLXHOs3H5CpFZ8E8LnD7Je+QsXThxGfcvdupAkVfm2Ak2RK
 pexhCtw8L5kSOZ1gqIcT1VbjFsh+ojmAPC49WjPOnTCDmMda7jL3rpz7cjBMPzRAaJSB
X-Google-Smtp-Source: AGHT+IExMpNrGDNdfJZ7XhjWWD8eHVFdXMDhDEN7Vh1ed46ZX+JTO6bVe6vBoEijnJj6RAPEUKhkrg==
X-Received: by 2002:a05:600c:4689:b0:439:643a:c8d5 with SMTP id
 5b1f17b1804b1-454b819befdmr17032405e9.0.1751646394365; 
 Fri, 04 Jul 2025 09:26:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 096/119] target/arm: Implement ANDQV, ORQV, EORQV for SVE2p1
Date: Fri,  4 Jul 2025 17:24:36 +0100
Message-ID: <20250704162501.249138-97-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-85-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 15 ++++++++++++
 target/arm/tcg/sve.decode      |  5 ++++
 target/arm/tcg/sve_helper.c    | 42 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c |  3 +++
 4 files changed, 65 insertions(+)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index ec82d0a4e74..9758613b2d8 100644
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
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index b7622577594..ff740f7b40b 100644
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
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 866f85ba306..f47e719fbe1 100644
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
index 6ad4d1e289c..2114b2ecca1 100644
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
-- 
2.43.0


