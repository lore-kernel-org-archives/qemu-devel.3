Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6631C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg84o-0000tx-8h; Thu, 06 Feb 2025 15:02:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83Q-0007Zv-R5
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:00:53 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83M-00016r-Vn
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:00:52 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2f833af7a09so1897119a91.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738872047; x=1739476847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wqce4LkhrqRf4WF12K2oDu33jkJhvXH23DaQ4WyRYrM=;
 b=OkJoPEzUvzJbuBMc9qlDVY2PxXg1utRX6rGFGfsgvpqRGkIVqFNV4hOjC96NIIEi8Z
 wiZg8LvFPDrPlnpDNZxH00L0sHKMMKCiTTHsGSZ89AgMXrQ6oB4/zYHiznyEZycVKdwj
 BwEEk4c+3/km6m0fYnxqYvJUANfEfmsRiJp3zeFDXoHR/IRuhFqOXlxNgjq+c6bqLXhz
 03hxfgw4sbZJkjPWb1DquJXkooFJQn/00LSiMvACkkULpQjlYqrD+ZEilnLShGUU1Y7d
 eJnNq9AS4Si+VQzMVKI4iwGYEKko7NFijkYwu7WLLrxaW8d74SD4fDMCwz9HIZ8anNiE
 N3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738872047; x=1739476847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wqce4LkhrqRf4WF12K2oDu33jkJhvXH23DaQ4WyRYrM=;
 b=HW5k0hnG46qG1KdLsRn4PCXxDgch8nmCL08d9kXU6zQ3C7q8NNyj6SodlolqsAnxR+
 CdqK1U/Sg/MEf95HaY5Hun/WIY9RdtAo9DR8QktzDECWAKTlVUxB5NMQ0IeVkZUHmROt
 s+BRgcL7aMeoiDxk8Y9JXwZuAhAhNeE42T2YNW0idRRXxjEAAND/uGHLd30kGVRElrF0
 WbJrDtTGxi+8uhURIzinBGpk5Y8pyCFGXpStDh5iCeS/5EwZcV91CrdThrCI/0mAz3Y+
 CeHYymsmxv1UbOFOkBfKWSV3xEpphiINEMQXqmhbfLPJhaVbDG32BhOu2QHI78plq2T6
 pHkw==
X-Gm-Message-State: AOJu0YzCt5tUcOrIP8tW2JsIiXaXbimkL52ul77e0A9ZWT/FE4n+fofq
 K3QuUf0tDACwMuTDedES8uaPMLoZQUW9H3YUIBFm6ogWQ/3vUZwhlDi6HohIkOfnpscbk3c3/jp
 Q
X-Gm-Gg: ASbGncuuI6x7gKa2jU07rZzaTeWKlarpDPuawAYik12O8sWDbiExuBHhOayWqmgkda1
 lwj+fUobGy5BXHE+4EHJ9NPIX2xKxRd8OggUdBkiA/+qG9VYXYE04WoZoMxlTFycJK8lDDp93w7
 ky3DBVJhjkz9TeIebuTac2t/wcrO7Mquts9bSqRPVBU0531IiNZR/pDU0JiEoCPcAdX8e7mHlJi
 iZKq9t82/56iFE+SIPwVAgekt9ros7ST/FDlOoQxibExKz6k5pxd8bWJ+E91ukJ00dFGRnyIVug
 WezSPUAFyTm8ot8ZAFCndvlFD5WzQouhm0Ze4ykcPUKXNBo=
X-Google-Smtp-Source: AGHT+IEsvJ0n8M9ADM48+QZE7UPiXBBSzyQXLG9De5cl+MMNGlcJ7+/pz3FDBT2SZnnkWSca35TBSw==
X-Received: by 2002:a17:90b:4fd1:b0:2ee:d7d3:3008 with SMTP id
 98e67ed59e1d1-2fa24064f04mr601030a91.12.1738872047098; 
 Thu, 06 Feb 2025 12:00:47 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09b3ee24sm1808857a91.36.2025.02.06.12.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 12:00:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 40/61] target/arm: Implement SME2 SMLALL, SMLSLL, UMLALL,
 UMLSLL
Date: Thu,  6 Feb 2025 11:56:54 -0800
Message-ID: <20250206195715.2150758-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
 target/arm/tcg/helper-sme.h    |  22 ++++++
 target/arm/tcg/sme_helper.c    |  60 +++++++++++++++
 target/arm/tcg/translate-sme.c |  78 +++++++++++++++++++
 target/arm/tcg/sme.decode      | 135 +++++++++++++++++++++++++++++++++
 4 files changed, 295 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 464877516b..673aa347bc 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -191,3 +191,25 @@ DEF_HELPER_FLAGS_4(sme2_uvdot_idx_4h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(sme2_svdot_idx_2h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme2_uvdot_idx_2h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sme2_smlall_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_smlall_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_smlsll_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_smlsll_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlall_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlall_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlsll_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlsll_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_usmlall_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_usmlall_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sme2_smlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_smlall_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_smlsll_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_smlsll_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlall_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlsll_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_umlsll_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_usmlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme2_usmlall_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 2976c0b33d..6fbf49e77d 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1428,3 +1428,63 @@ DO_VDOT_IDX(sme2_svdot_idx_2h, int32_t, int16_t, int16_t, H4, H2)
 DO_VDOT_IDX(sme2_uvdot_idx_2h, uint32_t, uint16_t, uint16_t, H4, H2)
 
 #undef DO_VDOT_IDX
+
+#define DO_MLALL(NAME, TYPEW, TYPEN, TYPEM, HW, HN, OP) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc) \
+{                                                               \
+    intptr_t elements = simd_oprsz(desc) / sizeof(TYPEW);       \
+    intptr_t sel = extract32(desc, SIMD_DATA_SHIFT, 2);         \
+    TYPEW *d = vd, *a = va; TYPEN *n = vn; TYPEM *m = vm;       \
+    for (intptr_t i = 0; i < elements; ++i) {                   \
+        TYPEW nn = n[HN(i * 4 + sel)];                          \
+        TYPEN mm = m[HN(i * 4 + sel)];                          \
+        d[HW(i)] = a[HW(i)] OP (nn * mm);                       \
+    }                                                           \
+}
+
+DO_MLALL(sme2_smlall_s, int32_t, int8_t, int8_t, H4, H1, +)
+DO_MLALL(sme2_smlall_d, int64_t, int16_t, int16_t, H8, H2, +)
+DO_MLALL(sme2_smlsll_s, int32_t, int8_t, int8_t, H4, H1, -)
+DO_MLALL(sme2_smlsll_d, int64_t, int16_t, int16_t, H8, H2, -)
+
+DO_MLALL(sme2_umlall_s, uint32_t, uint8_t, uint8_t, H4, H1, +)
+DO_MLALL(sme2_umlall_d, uint64_t, uint16_t, uint16_t, H8, H2, +)
+DO_MLALL(sme2_umlsll_s, uint32_t, uint8_t, uint8_t, H4, H1, -)
+DO_MLALL(sme2_umlsll_d, uint64_t, uint16_t, uint16_t, H8, H2, -)
+
+DO_MLALL(sme2_usmlall_s, uint32_t, uint8_t, int8_t, H4, H1, +)
+DO_MLALL(sme2_usmlall_d, uint64_t, uint16_t, int16_t, H8, H2, +)
+
+#undef DO_MLALL
+
+#define DO_MLALL_IDX(NAME, TYPEW, TYPEN, TYPEM, HW, HN, OP) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc) \
+{                                                               \
+    intptr_t elements = simd_oprsz(desc) / sizeof(TYPEW);       \
+    intptr_t eltspersegment = 16 / sizeof(TYPEW);               \
+    intptr_t sel = extract32(desc, SIMD_DATA_SHIFT, 2);         \
+    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 4);     \
+    TYPEW *d = vd, *a = va; TYPEN *n = vn; TYPEM *m = vm;       \
+    for (intptr_t i = 0; i < elements; i += eltspersegment) {   \
+        TYPEW mm = m[HN(i * 4 + idx)];                          \
+        for (intptr_t j = 0; j < eltspersegment; ++j) {         \
+            TYPEN nn = n[HN((i + j) * 4 + sel)];                \
+            d[HW(i + j)] = a[HW(i + j)] OP (nn * mm);           \
+        }                                                       \
+    }                                                           \
+}
+
+DO_MLALL_IDX(sme2_smlall_idx_s, int32_t, int8_t, int8_t, H4, H1, +)
+DO_MLALL_IDX(sme2_smlall_idx_d, int64_t, int16_t, int16_t, H8, H2, +)
+DO_MLALL_IDX(sme2_smlsll_idx_s, int32_t, int8_t, int8_t, H4, H1, -)
+DO_MLALL_IDX(sme2_smlsll_idx_d, int64_t, int16_t, int16_t, H8, H2, -)
+
+DO_MLALL_IDX(sme2_umlall_idx_s, uint32_t, uint8_t, uint8_t, H4, H1, +)
+DO_MLALL_IDX(sme2_umlall_idx_d, uint64_t, uint16_t, uint16_t, H8, H2, +)
+DO_MLALL_IDX(sme2_umlsll_idx_s, uint32_t, uint8_t, uint8_t, H4, H1, -)
+DO_MLALL_IDX(sme2_umlsll_idx_d, uint64_t, uint16_t, uint16_t, H8, H2, -)
+
+DO_MLALL_IDX(sme2_usmlall_idx_s, uint32_t, uint8_t, int8_t, H4, H1, +)
+DO_MLALL_IDX(sme2_usmlall_idx_d, uint64_t, uint16_t, int16_t, H8, H2, +)
+
+#undef DO_MLALL_IDX
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index f43511335f..9c0989baff 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1032,3 +1032,81 @@ TRANS_FEAT(SMLAL_nx, aa64_sme, do_smlal_nx, a, gen_helper_sve2_smlal_idx_s)
 TRANS_FEAT(SMLSL_nx, aa64_sme, do_smlal_nx, a, gen_helper_sve2_smlsl_idx_s)
 TRANS_FEAT(UMLAL_nx, aa64_sme, do_smlal_nx, a, gen_helper_sve2_umlal_idx_s)
 TRANS_FEAT(UMLSL_nx, aa64_sme, do_smlal_nx, a, gen_helper_sve2_umlsl_idx_s)
+
+static bool do_smlall(DisasContext *s, arg_azz_n *a, bool multi,
+                     gen_helper_gvec_4 *fn)
+{
+    return do_azz_acc(s, a->n, 4, a->rv, a->off, a->zn, a->zm,
+                      0, 0, multi, fn);
+}
+
+static void gen_helper_sme2_sumlall_s(TCGv_ptr d, TCGv_ptr n, TCGv_ptr m,
+                                      TCGv_ptr a, TCGv_i32 desc)
+{
+    gen_helper_sme2_usmlall_s(d, m, n, a, desc);
+}
+
+static void gen_helper_sme2_sumlall_d(TCGv_ptr d, TCGv_ptr n, TCGv_ptr m,
+                                      TCGv_ptr a, TCGv_i32 desc)
+{
+    gen_helper_sme2_usmlall_d(d, m, n, a, desc);
+}
+
+TRANS_FEAT(SMLALL_n1_s, aa64_sme, do_smlall, a, false, gen_helper_sme2_smlall_s)
+TRANS_FEAT(SMLSLL_n1_s, aa64_sme, do_smlall, a, false, gen_helper_sme2_smlsll_s)
+TRANS_FEAT(UMLALL_n1_s, aa64_sme, do_smlall, a, false, gen_helper_sme2_umlall_s)
+TRANS_FEAT(UMLSLL_n1_s, aa64_sme, do_smlall, a, false, gen_helper_sme2_umlsll_s)
+TRANS_FEAT(USMLALL_n1_s, aa64_sme, do_smlall, a, false, gen_helper_sme2_usmlall_s)
+TRANS_FEAT(SUMLALL_n1_s, aa64_sme, do_smlall, a, false, gen_helper_sme2_sumlall_s)
+
+TRANS_FEAT(SMLALL_n1_d, aa64_sme_i16i64, do_smlall, a, false, gen_helper_sme2_smlall_d)
+TRANS_FEAT(SMLSLL_n1_d, aa64_sme_i16i64, do_smlall, a, false, gen_helper_sme2_smlsll_d)
+TRANS_FEAT(UMLALL_n1_d, aa64_sme_i16i64, do_smlall, a, false, gen_helper_sme2_umlall_d)
+TRANS_FEAT(UMLSLL_n1_d, aa64_sme_i16i64, do_smlall, a, false, gen_helper_sme2_umlsll_d)
+TRANS_FEAT(USMLALL_n1_d, aa64_sme_i16i64, do_smlall, a, false, gen_helper_sme2_usmlall_d)
+TRANS_FEAT(SUMLALL_n1_d, aa64_sme_i16i64, do_smlall, a, false, gen_helper_sme2_sumlall_d)
+
+TRANS_FEAT(SMLALL_nn_s, aa64_sme, do_smlall, a, true, gen_helper_sme2_smlall_s)
+TRANS_FEAT(SMLSLL_nn_s, aa64_sme, do_smlall, a, true, gen_helper_sme2_smlsll_s)
+TRANS_FEAT(UMLALL_nn_s, aa64_sme, do_smlall, a, true, gen_helper_sme2_umlall_s)
+TRANS_FEAT(UMLSLL_nn_s, aa64_sme, do_smlall, a, true, gen_helper_sme2_umlsll_s)
+TRANS_FEAT(USMLALL_nn_s, aa64_sme, do_smlall, a, true, gen_helper_sme2_usmlall_s)
+
+TRANS_FEAT(SMLALL_nn_d, aa64_sme_i16i64, do_smlall, a, true, gen_helper_sme2_smlall_d)
+TRANS_FEAT(SMLSLL_nn_d, aa64_sme_i16i64, do_smlall, a, true, gen_helper_sme2_smlsll_d)
+TRANS_FEAT(UMLALL_nn_d, aa64_sme_i16i64, do_smlall, a, true, gen_helper_sme2_umlall_d)
+TRANS_FEAT(UMLSLL_nn_d, aa64_sme_i16i64, do_smlall, a, true, gen_helper_sme2_umlsll_d)
+TRANS_FEAT(USMLALL_nn_d, aa64_sme_i16i64, do_smlall, a, true, gen_helper_sme2_usmlall_d)
+
+static bool do_smlall_nx(DisasContext *s, arg_azx_n *a,
+                        gen_helper_gvec_4 *fn)
+{
+    return do_azz_acc(s, a->n, 4, a->rv, a->off, a->zn, a->zm,
+                      a->idx << 2, 0, false, fn);
+}
+
+static void gen_helper_sme2_sumlall_idx_s(TCGv_ptr d, TCGv_ptr n, TCGv_ptr m,
+                                          TCGv_ptr a, TCGv_i32 desc)
+{
+    gen_helper_sme2_usmlall_idx_s(d, m, n, a, desc);
+}
+
+static void gen_helper_sme2_sumlall_idx_d(TCGv_ptr d, TCGv_ptr n, TCGv_ptr m,
+                                          TCGv_ptr a, TCGv_i32 desc)
+{
+    gen_helper_sme2_usmlall_idx_d(d, m, n, a, desc);
+}
+
+TRANS_FEAT(SMLALL_nx_s, aa64_sme, do_smlall_nx, a, gen_helper_sme2_smlall_idx_s)
+TRANS_FEAT(SMLSLL_nx_s, aa64_sme, do_smlall_nx, a, gen_helper_sme2_smlsll_idx_s)
+TRANS_FEAT(UMLALL_nx_s, aa64_sme, do_smlall_nx, a, gen_helper_sme2_umlall_idx_s)
+TRANS_FEAT(UMLSLL_nx_s, aa64_sme, do_smlall_nx, a, gen_helper_sme2_smlsll_idx_s)
+TRANS_FEAT(USMLALL_nx_s, aa64_sme, do_smlall_nx, a, gen_helper_sme2_usmlall_idx_s)
+TRANS_FEAT(SUMLALL_nx_s, aa64_sme, do_smlall_nx, a, gen_helper_sme2_sumlall_idx_s)
+
+TRANS_FEAT(SMLALL_nx_d, aa64_sme_i16i64, do_smlall_nx, a, gen_helper_sme2_smlall_idx_d)
+TRANS_FEAT(SMLSLL_nx_d, aa64_sme_i16i64, do_smlall_nx, a, gen_helper_sme2_smlsll_idx_d)
+TRANS_FEAT(UMLALL_nx_d, aa64_sme_i16i64, do_smlall_nx, a, gen_helper_sme2_umlall_idx_d)
+TRANS_FEAT(UMLSLL_nx_d, aa64_sme_i16i64, do_smlall_nx, a, gen_helper_sme2_smlsll_idx_d)
+TRANS_FEAT(USMLALL_nx_d, aa64_sme_i16i64, do_smlall_nx, a, gen_helper_sme2_usmlall_idx_d)
+TRANS_FEAT(SUMLALL_nx_d, aa64_sme_i16i64, do_smlall_nx, a, gen_helper_sme2_sumlall_idx_d)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index ec011d9382..49a45612fd 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -327,6 +327,52 @@ UMLSL_n1        11000001 011 0 .... 0 .. 011 ..... 11 ...   @azz_nx1_o3x2 n=1
 UMLSL_n1        11000001 011 0 .... 0 .. 010 ..... 110 ..   @azz_nx1_o2x2 n=2
 UMLSL_n1        11000001 011 1 .... 0 .. 010 ..... 110 ..   @azz_nx1_o2x2 n=4
 
+%off2_x4        0:2 !function=times_4
+%off1_x4        0:1 !function=times_4
+
+@azz_nx1_o2x4   ........ ... . zm:4 . .. ... zn:5 ... ..    \
+                &azz_n off=%off2_x4 rv=%mova_rv
+@azz_nx1_o1x4   ........ ... . zm:4 . .. ... zn:5 .... .    \
+                &azz_n off=%off1_x4 rv=%mova_rv
+
+SMLALL_n1_s     11000001 001 0 .... 0 .. 001 ..... 000 ..   @azz_nx1_o2x4 n=1
+SMLALL_n1_d     11000001 011 0 .... 0 .. 001 ..... 000 ..   @azz_nx1_o2x4 n=1
+SMLALL_n1_s     11000001 001 0 .... 0 .. 000 ..... 0000 .   @azz_nx1_o1x4 n=2
+SMLALL_n1_d     11000001 011 0 .... 0 .. 000 ..... 0000 .   @azz_nx1_o1x4 n=2
+SMLALL_n1_s     11000001 001 1 .... 0 .. 000 ..... 0000 .   @azz_nx1_o1x4 n=4
+SMLALL_n1_d     11000001 011 1 .... 0 .. 000 ..... 0000 .   @azz_nx1_o1x4 n=4
+
+SMLSLL_n1_s     11000001 001 0 .... 0 .. 001 ..... 010 ..   @azz_nx1_o2x4 n=1
+SMLSLL_n1_d     11000001 011 0 .... 0 .. 001 ..... 010 ..   @azz_nx1_o2x4 n=1
+SMLSLL_n1_s     11000001 001 0 .... 0 .. 000 ..... 0100 .   @azz_nx1_o1x4 n=2
+SMLSLL_n1_d     11000001 011 0 .... 0 .. 000 ..... 0100 .   @azz_nx1_o1x4 n=2
+SMLSLL_n1_s     11000001 001 1 .... 0 .. 000 ..... 0100 .   @azz_nx1_o1x4 n=4
+SMLSLL_n1_d     11000001 011 1 .... 0 .. 000 ..... 0100 .   @azz_nx1_o1x4 n=4
+
+UMLALL_n1_s     11000001 001 0 .... 0 .. 001 ..... 100 ..   @azz_nx1_o2x4 n=1
+UMLALL_n1_d     11000001 011 0 .... 0 .. 001 ..... 100 ..   @azz_nx1_o2x4 n=1
+UMLALL_n1_s     11000001 001 0 .... 0 .. 000 ..... 1000 .   @azz_nx1_o1x4 n=2
+UMLALL_n1_d     11000001 011 0 .... 0 .. 000 ..... 1000 .   @azz_nx1_o1x4 n=2
+UMLALL_n1_s     11000001 001 1 .... 0 .. 000 ..... 1000 .   @azz_nx1_o1x4 n=4
+UMLALL_n1_d     11000001 011 1 .... 0 .. 000 ..... 1000 .   @azz_nx1_o1x4 n=4
+
+UMLSLL_n1_s     11000001 001 0 .... 0 .. 001 ..... 110 ..   @azz_nx1_o2x4 n=1
+UMLSLL_n1_d     11000001 011 0 .... 0 .. 001 ..... 110 ..   @azz_nx1_o2x4 n=1
+UMLSLL_n1_s     11000001 001 0 .... 0 .. 000 ..... 1100 .   @azz_nx1_o1x4 n=2
+UMLSLL_n1_d     11000001 011 0 .... 0 .. 000 ..... 1100 .   @azz_nx1_o1x4 n=2
+UMLSLL_n1_s     11000001 001 1 .... 0 .. 000 ..... 1100 .   @azz_nx1_o1x4 n=4
+UMLSLL_n1_d     11000001 011 1 .... 0 .. 000 ..... 1100 .   @azz_nx1_o1x4 n=4
+
+USMLALL_n1_s    11000001 001 0 .... 0 .. 000 ..... 0010 .   @azz_nx1_o1x4 n=2
+USMLALL_n1_d    11000001 011 0 .... 0 .. 000 ..... 0010 .   @azz_nx1_o1x4 n=2
+USMLALL_n1_s    11000001 001 1 .... 0 .. 000 ..... 0010 .   @azz_nx1_o1x4 n=4
+USMLALL_n1_d    11000001 011 1 .... 0 .. 000 ..... 0010 .   @azz_nx1_o1x4 n=4
+
+SUMLALL_n1_s    11000001 001 0 .... 0 .. 000 ..... 1010 .   @azz_nx1_o1x4 n=2
+SUMLALL_n1_d    11000001 011 0 .... 0 .. 000 ..... 1010 .   @azz_nx1_o1x4 n=2
+SUMLALL_n1_s    11000001 001 1 .... 0 .. 000 ..... 1010 .   @azz_nx1_o1x4 n=4
+SUMLALL_n1_d    11000001 011 1 .... 0 .. 000 ..... 1010 .   @azz_nx1_o1x4 n=4
+
 ### SME2 Multi-vector Multiple Array Vectors
 
 %zn_ax2         6:4 !function=times_2
@@ -399,6 +445,36 @@ UMLAL_nn        11000001 111 ...01 0 .. 010 ...00 100 ..    @azz_4x4_o2x2
 UMLSL_nn        11000001 111 ....0 0 .. 010 ....0 110 ..    @azz_2x2_o2x2
 UMLSL_nn        11000001 111 ...01 0 .. 010 ...00 110 ..    @azz_4x4_o2x2
 
+@azz_2x2_o1x4   ........ ... ..... . .. ... ..... ... ..    \
+                &azz_n n=2 rv=%mova_rv zn=%zn_ax2 zm=%zm_ax2 off=%off1_x4
+@azz_4x4_o1x4   ........ ... ..... . .. ... ..... ... ..    \
+                &azz_n n=4 rv=%mova_rv zn=%zn_ax4 zm=%zm_ax4 off=%off1_x4
+
+SMLALL_nn_s     11000001 101 ....0 0 .. 000 ....0 0000 .    @azz_2x2_o1x4
+SMLALL_nn_d     11000001 111 ....0 0 .. 000 ....0 0000 .    @azz_2x2_o1x4
+SMLALL_nn_s     11000001 101 ...01 0 .. 000 ...00 0000 .    @azz_4x4_o1x4
+SMLALL_nn_d     11000001 111 ...01 0 .. 000 ...00 0000 .    @azz_4x4_o1x4
+
+SMLSLL_nn_s     11000001 101 ....0 0 .. 000 ....0 0100 .    @azz_2x2_o1x4
+SMLSLL_nn_d     11000001 111 ....0 0 .. 000 ....0 0100 .    @azz_2x2_o1x4
+SMLSLL_nn_s     11000001 101 ...01 0 .. 000 ...00 0100 .    @azz_4x4_o1x4
+SMLSLL_nn_d     11000001 111 ...01 0 .. 000 ...00 0100 .    @azz_4x4_o1x4
+
+UMLALL_nn_s     11000001 101 ....0 0 .. 000 ....0 1000 .    @azz_2x2_o1x4
+UMLALL_nn_d     11000001 111 ....0 0 .. 000 ....0 1000 .    @azz_2x2_o1x4
+UMLALL_nn_s     11000001 101 ...01 0 .. 000 ...00 1000 .    @azz_4x4_o1x4
+UMLALL_nn_d     11000001 111 ...01 0 .. 000 ...00 1000 .    @azz_4x4_o1x4
+
+UMLSLL_nn_s     11000001 101 ....0 0 .. 000 ....0 1100 .    @azz_2x2_o1x4
+UMLSLL_nn_d     11000001 111 ....0 0 .. 000 ....0 1100 .    @azz_2x2_o1x4
+UMLSLL_nn_s     11000001 101 ...01 0 .. 000 ...00 1100 .    @azz_4x4_o1x4
+UMLSLL_nn_d     11000001 111 ...01 0 .. 000 ...00 1100 .    @azz_4x4_o1x4
+
+USMLALL_nn_s    11000001 101 ....0 0 .. 000 ....0 1010 .    @azz_2x2_o1x4
+USMLALL_nn_d    11000001 111 ....0 0 .. 000 ....0 1010 .    @azz_2x2_o1x4
+USMLALL_nn_s    11000001 101 ...01 0 .. 000 ...00 1010 .    @azz_4x4_o1x4
+USMLALL_nn_d    11000001 111 ...01 0 .. 000 ...00 1010 .    @azz_4x4_o1x4
+
 ### SME2 Multi-vector Indexed
 
 &azx_n          n off rv zn zm idx
@@ -493,3 +569,62 @@ UMLAL_nx        11000001 1101 .... 1 .. 1 .. ...00 10 ...   @azx_4x1_o2x2
 UMLSL_nx        11000001 1100 .... . .. 1 .. ..... 11 ...   @azx_1x1_o3x2
 UMLSL_nx        11000001 1101 .... 0 .. 1 .. ....0 11 ...   @azx_2x1_o2x2
 UMLSL_nx        11000001 1101 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_o2x2
+
+%idx4_15_10     15:1 10:3
+%idx4_10_1      10:2 1:2
+%idx3_10_1      10:1 1:2
+
+@azx_1x1_i4_o2  ........ .... zm:4 . .. ... zn:5 ... ..     \
+                &azx_n n=1 rv=%mova_rv off=%off2_x4 idx=%idx4_15_10
+@azx_1x1_i3_o2  ........ .... zm:4 . .. ... zn:5 ... ..     \
+                &azx_n n=1 rv=%mova_rv off=%off2_x4 idx=%idx3_15_10
+@azx_2x1_i4_o1  ........ .... zm:4 . .. ... ..... ... ..     \
+                &azx_n n=2 rv=%mova_rv off=%off1_x4 zn=%zn_ax2 idx=%idx4_10_1
+@azx_2x1_i3_o1  ........ .... zm:4 . .. ... ..... ... ..     \
+                &azx_n n=2 rv=%mova_rv off=%off1_x4 zn=%zn_ax2 idx=%idx3_10_1
+@azx_4x1_i4_o1  ........ .... zm:4 . .. ... ..... ... ..     \
+                &azx_n n=4 rv=%mova_rv off=%off1_x4 zn=%zn_ax4 idx=%idx4_10_1
+@azx_4x1_i3_o1  ........ .... zm:4 . .. ... ..... ... ..     \
+                &azx_n n=4 rv=%mova_rv off=%off1_x4 zn=%zn_ax4 idx=%idx3_10_1
+
+SMLALL_nx_s     11000001 0000 .... . .. ... ..... 000 ..    @azx_1x1_i4_o2
+SMLALL_nx_d     11000001 1000 .... . .. 0.. ..... 000 ..    @azx_1x1_i3_o2
+SMLALL_nx_s     11000001 0001 .... 0 .. 0.. ....0 00 ...    @azx_2x1_i4_o1
+SMLALL_nx_d     11000001 1001 .... 0 .. 00. ....0 00 ...    @azx_2x1_i3_o1
+SMLALL_nx_s     11000001 0001 .... 1 .. 0.. ...00 00 ...    @azx_4x1_i4_o1
+SMLALL_nx_d     11000001 1001 .... 1 .. 00. ...00 00 ...    @azx_4x1_i3_o1
+
+SMLSLL_nx_s     11000001 0000 .... . .. ... ..... 010 ..    @azx_1x1_i4_o2
+SMLSLL_nx_d     11000001 1000 .... . .. 0.. ..... 010 ..    @azx_1x1_i3_o2
+SMLSLL_nx_s     11000001 0001 .... 0 .. 0.. ....0 01 ...    @azx_2x1_i4_o1
+SMLSLL_nx_d     11000001 1001 .... 0 .. 00. ....0 01 ...    @azx_2x1_i3_o1
+SMLSLL_nx_s     11000001 0001 .... 1 .. 0.. ...00 01 ...    @azx_4x1_i4_o1
+SMLSLL_nx_d     11000001 1001 .... 1 .. 00. ...00 01 ...    @azx_4x1_i3_o1
+
+UMLALL_nx_s     11000001 0000 .... . .. ... ..... 100 ..    @azx_1x1_i4_o2
+UMLALL_nx_d     11000001 1000 .... . .. 0.. ..... 100 ..    @azx_1x1_i3_o2
+UMLALL_nx_s     11000001 0001 .... 0 .. 0.. ....0 10 ...    @azx_2x1_i4_o1
+UMLALL_nx_d     11000001 1001 .... 0 .. 00. ....0 10 ...    @azx_2x1_i3_o1
+UMLALL_nx_s     11000001 0001 .... 1 .. 0.. ...00 10 ...    @azx_4x1_i4_o1
+UMLALL_nx_d     11000001 1001 .... 1 .. 00. ...00 10 ...    @azx_4x1_i3_o1
+
+UMLSLL_nx_s     11000001 0000 .... . .. ... ..... 110 ..    @azx_1x1_i4_o2
+UMLSLL_nx_d     11000001 1000 .... . .. 0.. ..... 110 ..    @azx_1x1_i3_o2
+UMLSLL_nx_s     11000001 0001 .... 0 .. 0.. ....0 11 ...    @azx_2x1_i4_o1
+UMLSLL_nx_d     11000001 1001 .... 0 .. 00. ....0 11 ...    @azx_2x1_i3_o1
+UMLSLL_nx_s     11000001 0001 .... 1 .. 0.. ...00 11 ...    @azx_4x1_i4_o1
+UMLSLL_nx_d     11000001 1001 .... 1 .. 00. ...00 11 ...    @azx_4x1_i3_o1
+
+USMLALL_nx_s    11000001 0000 .... . .. ... ..... 001 ..    @azx_1x1_i4_o2
+USMLALL_nx_d    11000001 1000 .... . .. 0.. ..... 001 ..    @azx_1x1_i3_o2
+USMLALL_nx_s    11000001 0001 .... 0 .. 0.. ....1 00 ...    @azx_2x1_i4_o1
+USMLALL_nx_d    11000001 1001 .... 0 .. 00. ....1 00 ...    @azx_2x1_i3_o1
+USMLALL_nx_s    11000001 0001 .... 1 .. 0.. ...01 00 ...    @azx_4x1_i4_o1
+USMLALL_nx_d    11000001 1001 .... 1 .. 00. ...01 00 ...    @azx_4x1_i3_o1
+
+SUMLALL_nx_s    11000001 0000 .... . .. ... ..... 101 ..    @azx_1x1_i4_o2
+SUMLALL_nx_d    11000001 1000 .... . .. 0.. ..... 101 ..    @azx_1x1_i3_o2
+SUMLALL_nx_s    11000001 0001 .... 0 .. 0.. ....1 10 ...    @azx_2x1_i4_o1
+SUMLALL_nx_d    11000001 1001 .... 0 .. 00. ....1 10 ...    @azx_2x1_i3_o1
+SUMLALL_nx_s    11000001 0001 .... 1 .. 0.. ...01 10 ...    @azx_4x1_i4_o1
+SUMLALL_nx_d    11000001 1001 .... 1 .. 00. ...01 10 ...    @azx_4x1_i3_o1
-- 
2.43.0


