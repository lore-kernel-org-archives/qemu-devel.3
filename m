Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321BCC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 19:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80w-00008b-SO; Thu, 06 Feb 2025 14:58:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80U-0007NH-5n
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:50 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80Q-0000dN-Qh
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:49 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21f2f09865bso25156655ad.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871865; x=1739476665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6/tdzP/1NK2OO1fCXB1FLEtWDKKhvFaIgpA+NYsKXok=;
 b=kMceZCnO7n+mBmMYPWz026ctWpSU7k7sSyWiQbPmkDibC5xR01W83olTZsI8yKHEK4
 jMN7Q2mdllSVmorg4VG7J6VmCZhikNToe9diScB8wlh/ff05hiPIf/EeaMGs3GPZzWwA
 5H3POK4vJVLnjwj7jHgkMpA5rGILLobS9qzoGZ4f9/GP5atnbQ5DEHUJ+pD3z+L/357x
 wynSwpZRcWefhbCR4Miy35bEwiot3GxH47RMDatwnuHtzNmGf6/TEIqVnXsGy/LS62fV
 o3CqPE3iJnRTS6xcQaeTXmBgyDnlUhqZFHutqWRIXGWEWCMcuuDkxknDsPCDFddcaJML
 VY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871865; x=1739476665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6/tdzP/1NK2OO1fCXB1FLEtWDKKhvFaIgpA+NYsKXok=;
 b=Daj/mXN03l5Eci8G7pFeOEdqbR0RmF5LzO9T1WA4fXVBUWqMgxkwtkBW8HDj3uwjMW
 y50SQkpRuYWYp+RMKgymuC6YgX9TLGI9DOHHn8SysFx4f/ZrFuNDnjqB7AlQHpRmudi4
 NToHa6Tk35BAwWoEnyVyFQkcQW89/eaM7J/dyiLyrkR7vtQG/d3njRXzIlOVXCuKFHbV
 6PoLeUiUEqSd+/QBmyo9FCuval6MyFAT9Q40HTWKYbTflxdivCT1b1k8WFIwMv8V2Msy
 M7gIYegEagMXdUIY8jkfKPnFv+n+yvK5GIBALNUSw9CnHYNhNYWw/O9POG9IzvLXcjEa
 Clhw==
X-Gm-Message-State: AOJu0Yzm+luFcjmkIwDQ9pfpQlHmUI32V2DfSUNXK01c63tpgAWRh6nk
 Hm+fxwy1glcHAtg4ghYijTB9UtVU+XH4dX5VS58Yg81giJm9HAqRIkjvyJTL9QzeogJAUNW2A3f
 S
X-Gm-Gg: ASbGnctCVTGAlhapxI8O7aRlx8UzfVGYmwH+Lc5Tm2wG58UvZuyvOfzd+RAXdCo/aN1
 yXG4IiuclL3KYfkpiCukIQoTmwJEw+gwjXEAWDxGphN33F6kRIEr43KnbsDKlu2Ed1pf4m/DAD1
 jliN+n0fLsoRnpGWpHW/6cmorQNaFlEGjdIbCG79Ulwgwasx0gyfSfS6w+qOH4FijXOPIH9wTjW
 Lxil/j8+rgb86p0sm3maqYejLufjGArVpPVWALoV9yZkMqt5R9+VgXranzQr9ChlVM26LlQXBIi
 5WlI/2FlM/5+JCMdRnoNDKV0k0d2ru6OYwJe605Jvnn+bb8=
X-Google-Smtp-Source: AGHT+IE7ZbO3Ba4yxj0w3PzINvckV+9GU5807Tlej7vw2tL3KnTdYeXXvloV6gb91JX/DR4KWJ43gA==
X-Received: by 2002:a05:6a00:c86:b0:72f:c0af:7328 with SMTP id
 d2e1a72fcca58-7305e39eb0fmr333331b3a.3.1738871864986; 
 Thu, 06 Feb 2025 11:57:44 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 38/61] target/arm: Implement SME2 SVDOT, UVDOT, SUVDOT, USVDOT
Date: Thu,  6 Feb 2025 11:56:52 -0800
Message-ID: <20250206195715.2150758-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/tcg/helper-sme.h    | 11 +++++++++
 target/arm/tcg/sme_helper.c    | 42 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 23 +++++++++++++++++++
 target/arm/tcg/sme.decode      | 11 +++++++++
 4 files changed, 87 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 8f5a1b3c90..464877516b 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -180,3 +180,14 @@ DEF_HELPER_FLAGS_6(sme2_fdot_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_6(sme2_fvdot_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(sme2_svdot_idx_4b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_uvdot_idx_4b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_suvdot_idx_4b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_usvdot_idx_4b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sme2_svdot_idx_4h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_uvdot_idx_4h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sme2_svdot_idx_2h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_uvdot_idx_2h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 6fb7e6b306..2976c0b33d 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1386,3 +1386,45 @@ DEF_IMOP_16x2_32(umopa2_s, uint16_t, uint16_t)
 
 DEF_IMOPH(sme2, smopa2, s)
 DEF_IMOPH(sme2, umopa2, s)
+
+#define DO_VDOT_IDX(NAME, TYPED, TYPEN, TYPEM, HD, HN) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)            \
+{                                                                         \
+    intptr_t svl = simd_oprsz(desc);                                      \
+    intptr_t elements = svl / sizeof(TYPED);                              \
+    intptr_t eltperseg = 16 / sizeof(TYPED);                              \
+    intptr_t vstride = (svl / 4) * sizeof(ARMVectorReg);                  \
+    intptr_t zstride = sizeof(ARMVectorReg) / sizeof(TYPEN);              \
+    intptr_t nreg = sizeof(TYPED) / sizeof(TYPEN);                        \
+    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT, 2);                   \
+    TYPEN *n = vn;                                                        \
+    TYPEM *m = vm;                                                        \
+    for (intptr_t r = 0; r < nreg; r++) {                                 \
+        TYPED *d = vd + r * vstride;                                      \
+        for (intptr_t seg = 0; seg < elements; seg += eltperseg) {        \
+            intptr_t s = seg + idx;                                       \
+            for (intptr_t e = seg; e < seg + eltperseg; e++) {            \
+                TYPED sum = d[HD(e)];                                     \
+                for (intptr_t i = 0; i < nreg; i++) {                     \
+                    TYPED nn = n[i * zstride + HN(nreg * e + r)];         \
+                    TYPED mm = m[HN(nreg * s + i)];                       \
+                    sum += nn * mm;                                       \
+                }                                                         \
+                d[HD(e)] = sum;                                           \
+            }                                                             \
+        }                                                                 \
+    }                                                                     \
+}
+
+DO_VDOT_IDX(sme2_svdot_idx_4b, int32_t, int8_t, int8_t, H4, H1)
+DO_VDOT_IDX(sme2_uvdot_idx_4b, uint32_t, uint8_t, uint8_t, H4, H1)
+DO_VDOT_IDX(sme2_suvdot_idx_4b, int32_t, int8_t, uint8_t, H4, H1)
+DO_VDOT_IDX(sme2_usvdot_idx_4b, int32_t, uint8_t, int8_t, H4, H1)
+
+DO_VDOT_IDX(sme2_svdot_idx_4h, int64_t, int16_t, int16_t, H8, H2)
+DO_VDOT_IDX(sme2_uvdot_idx_4h, uint64_t, uint16_t, uint16_t, H8, H2)
+
+DO_VDOT_IDX(sme2_svdot_idx_2h, int32_t, int16_t, int16_t, H4, H2)
+DO_VDOT_IDX(sme2_uvdot_idx_2h, uint32_t, uint16_t, uint16_t, H4, H2)
+
+#undef DO_VDOT_IDX
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index d859910f93..492933d42d 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -980,3 +980,26 @@ TRANS_FEAT(SDOT_nx_4b, aa64_sme, do_dot_nx, a, gen_helper_gvec_sdot_idx_4b)
 TRANS_FEAT(UDOT_nx_4b, aa64_sme, do_dot_nx, a, gen_helper_gvec_udot_idx_4b)
 TRANS_FEAT(SDOT_nx_4h, aa64_sme2_i16i64, do_dot_nx, a, gen_helper_gvec_sdot_idx_4h)
 TRANS_FEAT(UDOT_nx_4h, aa64_sme2_i16i64, do_dot_nx, a, gen_helper_gvec_udot_idx_4h)
+
+static bool do_vdot_nx(DisasContext *s, arg_azx_n *a, gen_helper_gvec_3 *fn)
+{
+    if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        fn(get_zarray(s, a->rv, a->off, a->n),
+           vec_full_reg_ptr(s, a->zn),
+           vec_full_reg_ptr(s, a->zm),
+           tcg_constant_i32(simd_desc(svl, svl, a->idx)));
+    }
+    return true;
+}
+
+TRANS_FEAT(SVDOT_nx_2h, aa64_sme, do_vdot_nx, a, gen_helper_sme2_svdot_idx_2h)
+TRANS_FEAT(SVDOT_nx_4b, aa64_sme, do_vdot_nx, a, gen_helper_sme2_svdot_idx_4b)
+TRANS_FEAT(SVDOT_nx_4h, aa64_sme, do_vdot_nx, a, gen_helper_sme2_svdot_idx_4h)
+
+TRANS_FEAT(UVDOT_nx_2h, aa64_sme, do_vdot_nx, a, gen_helper_sme2_uvdot_idx_2h)
+TRANS_FEAT(UVDOT_nx_4b, aa64_sme, do_vdot_nx, a, gen_helper_sme2_uvdot_idx_4b)
+TRANS_FEAT(UVDOT_nx_4h, aa64_sme, do_vdot_nx, a, gen_helper_sme2_uvdot_idx_4h)
+
+TRANS_FEAT(SUVDOT_nx_4b, aa64_sme, do_vdot_nx, a, gen_helper_sme2_suvdot_idx_4b)
+TRANS_FEAT(USVDOT_nx_4b, aa64_sme, do_vdot_nx, a, gen_helper_sme2_usvdot_idx_4b)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 338637decd..4146744a46 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -438,3 +438,14 @@ USDOT_nx        11000001 0101 .... 1 .. 1 .. ...01 01 ...   @azx_4x1_i2_o3
 
 SUDOT_nx        11000001 0101 .... 0 .. 1 .. ....1 11 ...   @azx_2x1_i2_o3
 SUDOT_nx        11000001 0101 .... 1 .. 1 .. ...01 11 ...   @azx_4x1_i2_o3
+
+SVDOT_nx_2h     11000001 0101 .... 0 .. 0 .. ....1 00 ...   @azx_2x1_i2_o3
+SVDOT_nx_4b     11000001 0101 .... 1 .. 0 .. ...01 00 ...   @azx_4x1_i2_o3
+SVDOT_nx_4h     11000001 1101 .... 1 .. 01 . ...00 01 ...   @azx_4x1_i1_o3
+
+UVDOT_nx_2h     11000001 0101 .... 0 .. 0 .. ....1 10 ...   @azx_2x1_i2_o3
+UVDOT_nx_4b     11000001 0101 .... 1 .. 0 .. ...01 10 ...   @azx_4x1_i2_o3
+UVDOT_nx_4h     11000001 1101 .... 1 .. 01 . ...00 11 ...   @azx_4x1_i1_o3
+
+SUVDOT_nx_4b    11000001 0101 .... 1 .. 0 .. ...01 11 ...   @azx_4x1_i2_o3
+USVDOT_nx_4b    11000001 0101 .... 1 .. 0 .. ...01 01 ...   @azx_4x1_i2_o3
-- 
2.43.0


