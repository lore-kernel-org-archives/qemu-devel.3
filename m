Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90561C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg85A-0001Q8-IS; Thu, 06 Feb 2025 15:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83Z-0007pJ-Bs
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:12 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83R-00018W-4z
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:00:56 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2f9d5e0e365so2022224a91.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738872052; x=1739476852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HTDKbSYnfKQHdxYGjNbr3KxMOfwa8l2dyg4OJnjGl0s=;
 b=pxctCy/ungBOwcwZ3hLizVI+2J8v/SrcmLEqD0gNn9MUDZL8I4y9Rp2snFBSUPpO3Q
 osJRsmp+erg89EpG7fbQpwTizdQBKOSRuapr7sRCL7VRZJ4fSvxbTZeFa0Wlvx9/ngLV
 pG//B1M2u3LAsb+5Tw84X6wG4MxRvB9xFFS7RcS3iqN5lEhpnaD2CAYfucRxuXf8J4C1
 OCAt00EVxiS2ykx4hENSgrXZxs84eWO+sSJzWO54QDnBzW6DrGRCeuvD72rWCsLjNRtv
 7MhwnMeEnFes+PFfxlZb6hKif4BtQgSD2UfnitxIluDE6oR8et7Xux+ieFFq+Sr/P42f
 jW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738872052; x=1739476852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HTDKbSYnfKQHdxYGjNbr3KxMOfwa8l2dyg4OJnjGl0s=;
 b=ZFF/ZmDlTR+4jO1Zf1LFHG6zwihVLsaSD3kMUgonrksQIAPeWixl/lplmYRJcyZ9CZ
 wa3I5xxcllRPIGeHFSPHfrxS3q9GFhYx+uy0jyL6HnQuQsUK4XySCYT5M8ax2kSLQDBf
 K57AMnSiGtq+zxVYrcHSbUu1Ivr5MCCASacXqmnRl2YIUP3NJKXhotpFk8bCyu4e1wZ4
 Z978K6P7zbW3TzTP0T9fHUySxiysMZmyMddyo1hCSiOfqZJ4XBfkYKos7+tPF6MNDggM
 HLxW9SaH4xv3QxjcOp2iRBGaTYuKXGwrF3HSigjDyfYC6bFGXPU/5EJR37t4BIqTujea
 yJtw==
X-Gm-Message-State: AOJu0Yz/a8KnJ8hXOK5HIk6Q/yzLgxAbPB8L+lXpLGtJj4vpyQSgcgG6
 w3wAKJ8Y3+1ikiECcxA4imPJuVL7y05nOsFfaCrRUI2hFkQY9LmG1slfymOs0iZ181Kpvxuq24W
 T
X-Gm-Gg: ASbGncv6RXGuhrdpt51KDPiU4qsAAyzSHwNSfzHLttO7xpodHiWypxBZyXsWSvnx1kq
 RUd/pXOhz1nziIFPKaTHV4km1CUe0/QW5cE4qxAMh/6kJSe6wkol2U+7nTKldkO+3XuvxvKhWVT
 CZ3aiEl3lv1i2iTstXJZyVMneEy76QHObKqYDgtoX39FgsDVYUpUzXeItz77JmjC12seAmG2/dX
 lo7rub1LKza39yKBlbOd5DMmXNOdmcyrrFhKv43kbwqKd/Id1kx0csQO49rn63aHE8BHvfu0ovE
 pCefJ1T+4BJmgfyltel0gXX9DTLdGFfB3bmgZ6pGp3K2PD8=
X-Google-Smtp-Source: AGHT+IG2RwCwQSz/uN8GDfjQlAXxklCm9GvcAs1ZwB7M+4E9swdIT6oxznF8cB9kE4+hTLuLLqib2Q==
X-Received: by 2002:a17:90a:f94e:b0:2eb:140d:f6df with SMTP id
 98e67ed59e1d1-2fa23f41df4mr515171a91.1.1738872051521; 
 Thu, 06 Feb 2025 12:00:51 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09b3ee24sm1808857a91.36.2025.02.06.12.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 12:00:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 46/61] target/arm: Implement SME2 BFCVT, BFCVTN, FCVT, FCVTN
Date: Thu,  6 Feb 2025 11:57:00 -0800
Message-ID: <20250206195715.2150758-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
 target/arm/tcg/helper-sme.h    |  5 +++
 target/arm/tcg/sme_helper.c    | 74 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 25 ++++++++++++
 target/arm/tcg/sme.decode      | 12 ++++++
 4 files changed, 116 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 673aa347bc..cb81f89fb3 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -213,3 +213,8 @@ DEF_HELPER_FLAGS_5(sme2_umlsll_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr,
 DEF_HELPER_FLAGS_5(sme2_umlsll_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme2_usmlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme2_usmlall_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sme2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_bfcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvt_n, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 6fbf49e77d..6d2b83d26a 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1488,3 +1488,77 @@ DO_MLALL_IDX(sme2_usmlall_idx_s, uint32_t, uint8_t, int8_t, H4, H1, +)
 DO_MLALL_IDX(sme2_usmlall_idx_d, uint64_t, uint16_t, int16_t, H8, H2, +)
 
 #undef DO_MLALL_IDX
+
+/* Convert and compress */
+void HELPER(sme2_bfcvt)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    ARMVectorReg scratch __attribute__((uninitialized));
+    size_t oprsz = simd_oprsz(desc);
+    size_t i, n = oprsz / 4;
+    float32 *s0 = vs;
+    float32 *s1 = vs + sizeof(ARMVectorReg);
+    bfloat16 *d = vd;
+
+    if (vd == s1) {
+        s1 = memcpy(&scratch, s1, oprsz);
+    }
+
+    for (i = 0; i < n; ++i) {
+        d[H2(i)] = float32_to_bfloat16(s0[H4(i)], fpst);
+    }
+    for (i = 0; i < n; ++i) {
+        d[H2(i) + n] = float32_to_bfloat16(s1[H4(i)], fpst);
+    }
+}
+
+void HELPER(sme2_fcvt_n)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    ARMVectorReg scratch __attribute__((uninitialized));
+    size_t oprsz = simd_oprsz(desc);
+    size_t i, n = oprsz / 4;
+    float32 *s0 = vs;
+    float32 *s1 = vs + sizeof(ARMVectorReg);
+    float16 *d = vd;
+
+    if (vd == s1) {
+        s1 = memcpy(&scratch, s1, oprsz);
+    }
+
+    for (i = 0; i < n; ++i) {
+        d[H2(i)] = float32_to_float16(s0[H4(i)], true, fpst);
+    }
+    for (i = 0; i < n; ++i) {
+        d[H2(i) + n] = float32_to_float16(s1[H4(i)], true, fpst);
+    }
+}
+
+/* Convert and interleave */
+void HELPER(sme2_bfcvtn)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    size_t i, n = simd_oprsz(desc) / 4;
+    float32 *s0 = vs;
+    float32 *s1 = vs + sizeof(ARMVectorReg);
+    bfloat16 *d = vd;
+
+    for (i = 0; i < n; ++i) {
+        bfloat16 d0 = float32_to_bfloat16(s0[H4(i)], fpst);
+        bfloat16 d1 = float32_to_bfloat16(s1[H4(i)], fpst);
+        d[H2(i * 2 + 0)] = d0;
+        d[H2(i * 2 + 1)] = d1;
+    }
+}
+
+void HELPER(sme2_fcvtn)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    size_t i, n = simd_oprsz(desc) / 4;
+    float32 *s0 = vs;
+    float32 *s1 = vs + sizeof(ARMVectorReg);
+    bfloat16 *d = vd;
+
+    for (i = 0; i < n; ++i) {
+        bfloat16 d0 = float32_to_float16(s0[H4(i)], true, fpst);
+        bfloat16 d1 = float32_to_float16(s1[H4(i)], true, fpst);
+        d[H2(i * 2 + 0)] = d0;
+        d[H2(i * 2 + 1)] = d1;
+    }
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index f41b4343e4..777ea15a80 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1263,3 +1263,28 @@ TRANS_FEAT(UMLALL_nx_d, aa64_sme_i16i64, do_smlall_nx, a, gen_helper_sme2_umlall
 TRANS_FEAT(UMLSLL_nx_d, aa64_sme_i16i64, do_smlall_nx, a, gen_helper_sme2_smlsll_idx_d)
 TRANS_FEAT(USMLALL_nx_d, aa64_sme_i16i64, do_smlall_nx, a, gen_helper_sme2_usmlall_idx_d)
 TRANS_FEAT(SUMLALL_nx_d, aa64_sme_i16i64, do_smlall_nx, a, gen_helper_sme2_sumlall_idx_d)
+
+static bool do_zz_fpst(DisasContext *s, arg_zz_n *a, int data,
+                       ARMFPStatusFlavour type, gen_helper_gvec_2_ptr *fn)
+{
+    if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        TCGv_ptr fpst = fpstatus_ptr(type);
+
+        for (int i = 0, n = a->n; i < n; ++i) {
+            tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, a->zd + i),
+                               vec_full_reg_offset(s, a->zn + i),
+                               fpst, svl, svl, data, fn);
+        }
+    }
+    return true;
+}
+
+TRANS_FEAT(BFCVT, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_bfcvt)
+TRANS_FEAT(BFCVTN, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_bfcvtn)
+TRANS_FEAT(FCVT_n, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_fcvt_n)
+TRANS_FEAT(FCVTN, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_fcvtn)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 91df2068cf..8cca7d0d46 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -719,3 +719,15 @@ BFMLS_nx        11000001 0001 .... 1 .. 1.. ...01 1 ....    @azx_4x1_i3_o3
 FMLS_nx_h       11000001 0001 .... 1 .. 1.. ...00 1 ....    @azx_4x1_i3_o3
 FMLS_nx_s       11000001 0101 .... 1 .. 0.. ...00 10 ...    @azx_4x1_i2_o3
 FMLS_nx_d       11000001 1101 .... 1 .. 00. ...00 10 ...    @azx_4x1_i1_o3
+
+### SME2 Multi-vector SVE Constructive Unary
+
+&zz_n           zd zn n
+@zz_1x2         ........ ... ..... ...... ..... zd:5        \
+                &zz_n n=1 zn=%zn_ax2
+
+BFCVT           11000001 011 00000 111000 ....0 .....       @zz_1x2
+BFCVTN          11000001 011 00000 111000 ....1 .....       @zz_1x2
+
+FCVT_n          11000001 001 00000 111000 ....0 .....       @zz_1x2
+FCVTN           11000001 001 00000 111000 ....1 .....       @zz_1x2
-- 
2.43.0


