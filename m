Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29EAECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 16:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snhAM-00033V-2m; Mon, 09 Sep 2024 12:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAK-0002vm-7X
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:23:00 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAI-0007kg-5S
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:22:59 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-206bd1c6ccdso40891025ad.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 09:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725898977; x=1726503777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uYdRDnLZvU4DE3wg/K8nC4+74uuwaiaxrla26z+s2ts=;
 b=QmABrV4LFDzP8ViFxO+5gEkf98SZU4zTDblCpQKi01xFJtmt3v3Tf5MIYWAt1jFzhD
 60sk1UR/RyNsWAkFeZbCxBJGCJSjX5SLBlJy6OUd0yau5YzSPxQjJ/cljhfZy65+LrXL
 q1RLUV0mMkXd6ms7oRkpCGsVW+BR2iqn9+nyeCmgt202wtahKnRMjtEmJFJ5FU5Sk+SD
 /VGtN+QI3RrAm1lwLMlhAh2K+bv7OlNxvy6CTmE0wGytpi+cKs/m+qguPSq8/ao2Ft0a
 JPF6XqANfpIm14WFaAWRpYb91+Xo5jiOckH4MoB9lZ1vVrLyD9lifJR7W4Wk77oYQvJi
 aGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725898977; x=1726503777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uYdRDnLZvU4DE3wg/K8nC4+74uuwaiaxrla26z+s2ts=;
 b=T2aduRBs5UOPd8X2mRA7a1pGNUfbN96l/RwwQkotgHR7cJ5acmXlV21QRAu5dYb3UO
 JZhYlSkvcKfbXxf6c+69jkzAtQUxKyntwTTD7JGEEM/zt48v8jJrb9LTvJ4qmsonjxJT
 8x5TzMtWrKrOhKQGX/GMuiPSHeCu86nNFNitVsBKzdmZHG0/ZMafUmXCqfUzeorRUv1G
 YJg3DLS/RarRlC+TQ33cjSQpPnu5m9QWu3YC305IINccWFTLonN69QG1KV8HXmib/u/B
 +v4QbTVQgzCcPoFuYHX8sTyYArxfqotmVTX5EdP00HR5vAKLS9Lae46qWn9t9S1Sg9Hq
 6qyQ==
X-Gm-Message-State: AOJu0YwP/MdGpCqgWW7wcXEYRrpCb3hbFOEG6ljocNXlCOueuBYf5+MV
 AQajqmhJnstPXOGT092NCU3fm89jZ/YrLpTMTMCuVILg03DArw82XShwP3Xn7UnETxhLspu+c/+
 I
X-Google-Smtp-Source: AGHT+IFzHFOA0jZLbIpMUeWiBkNni8u+XHhmk65rg2SH/aw5g6B7JgCG8dXpoW/iUNSTEMb4S5lnbQ==
X-Received: by 2002:a17:902:f60d:b0:205:6a4c:9a20 with SMTP id
 d9443c01a7336-206f053ade0mr132722315ad.34.1725898976773; 
 Mon, 09 Sep 2024 09:22:56 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f35d79sm35753305ad.288.2024.09.09.09.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 09:22:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 16/29] target/arm: Convert handle_vec_simd_shri to
 decodetree
Date: Mon,  9 Sep 2024 09:22:26 -0700
Message-ID: <20240909162240.647173-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909162240.647173-1-richard.henderson@linaro.org>
References: <20240909162240.647173-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

This includes SSHR, USHR, SSRA, USRA, SRSHR, URSHR, SRSRA, URSRA, SRI.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 86 +++++++++++-----------------------
 target/arm/tcg/a64.decode      | 63 ++++++++++++++++++++++++-
 2 files changed, 89 insertions(+), 60 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 032bd33650..5c76cdf101 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6959,6 +6959,28 @@ static bool trans_Vimm(DisasContext *s, arg_Vimm *a)
     return true;
 }
 
+/*
+ * Advanced SIMD Shift by Immediate
+ */
+
+static bool do_vec_shift_imm(DisasContext *s, arg_qrri_e *a, GVecGen2iFn *fn)
+{
+    if (fp_access_check(s)) {
+        gen_gvec_fn2i(s, a->q, a->rd, a->rn, a->imm, fn, a->esz);
+    }
+    return true;
+}
+
+TRANS(SSHR_v, do_vec_shift_imm, a, gen_gvec_sshr)
+TRANS(USHR_v, do_vec_shift_imm, a, gen_gvec_ushr)
+TRANS(SSRA_v, do_vec_shift_imm, a, gen_gvec_ssra)
+TRANS(USRA_v, do_vec_shift_imm, a, gen_gvec_usra)
+TRANS(SRSHR_v, do_vec_shift_imm, a, gen_gvec_srshr)
+TRANS(URSHR_v, do_vec_shift_imm, a, gen_gvec_urshr)
+TRANS(SRSRA_v, do_vec_shift_imm, a, gen_gvec_srsra)
+TRANS(URSRA_v, do_vec_shift_imm, a, gen_gvec_ursra)
+TRANS(SRI_v, do_vec_shift_imm, a, gen_gvec_sri)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -10423,53 +10445,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 }
 
-/* SSHR[RA]/USHR[RA] - Vector shift right (optional rounding/accumulate) */
-static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
-                                 int immh, int immb, int opcode, int rn, int rd)
-{
-    int size = 32 - clz32(immh) - 1;
-    int immhb = immh << 3 | immb;
-    int shift = 2 * (8 << size) - immhb;
-    GVecGen2iFn *gvec_fn;
-
-    if (extract32(immh, 3, 1) && !is_q) {
-        unallocated_encoding(s);
-        return;
-    }
-    tcg_debug_assert(size <= 3);
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    switch (opcode) {
-    case 0x02: /* SSRA / USRA (accumulate) */
-        gvec_fn = is_u ? gen_gvec_usra : gen_gvec_ssra;
-        break;
-
-    case 0x08: /* SRI */
-        gvec_fn = gen_gvec_sri;
-        break;
-
-    case 0x00: /* SSHR / USHR */
-        gvec_fn = is_u ? gen_gvec_ushr : gen_gvec_sshr;
-        break;
-
-    case 0x04: /* SRSHR / URSHR (rounding) */
-        gvec_fn = is_u ? gen_gvec_urshr : gen_gvec_srshr;
-        break;
-
-    case 0x06: /* SRSRA / URSRA (accum + rounding) */
-        gvec_fn = is_u ? gen_gvec_ursra : gen_gvec_srsra;
-        break;
-
-    default:
-        g_assert_not_reached();
-    }
-
-    gen_gvec_fn2i(s, is_q, rd, rn, shift, gvec_fn, size);
-}
-
 /* SHL/SLI - Vector shift left */
 static void handle_vec_simd_shli(DisasContext *s, bool is_q, bool insert,
                                  int immh, int immb, int opcode, int rn, int rd)
@@ -10610,18 +10585,6 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x08: /* SRI */
-        if (!is_u) {
-            unallocated_encoding(s);
-            return;
-        }
-        /* fall through */
-    case 0x00: /* SSHR / USHR */
-    case 0x02: /* SSRA / USRA (accumulate) */
-    case 0x04: /* SRSHR / URSHR (rounding) */
-    case 0x06: /* SRSRA / URSRA (accum + rounding) */
-        handle_vec_simd_shri(s, is_q, is_u, immh, immb, opcode, rn, rd);
-        break;
     case 0x0a: /* SHL / SLI */
         handle_vec_simd_shli(s, is_q, is_u, immh, immb, opcode, rn, rd);
         break;
@@ -10660,6 +10623,11 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
         handle_simd_shift_fpint_conv(s, false, is_q, is_u, immh, immb, rn, rd);
         return;
     default:
+    case 0x00: /* SSHR / USHR */
+    case 0x02: /* SSRA / USRA (accumulate) */
+    case 0x04: /* SRSHR / URSHR (rounding) */
+    case 0x06: /* SRSRA / URSRA (accum + rounding) */
+    case 0x08: /* SRI */
         unallocated_encoding(s);
         return;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 278d7873c2..74ba1fa07c 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -34,6 +34,7 @@
 &rrx_e          rd rn rm idx esz
 &rrrr_e         rd rn rm ra esz
 &qrr_e          q rd rn esz
+&qrri_e         q rd rn imm esz
 &qrrr_e         q rd rn rm esz
 &qrrx_e         q rd rn rm idx esz
 &qrrrr_e        q rd rn rm ra esz
@@ -1185,11 +1186,71 @@ FMINV_s         0110 1110 10 11000 01111 10 ..... .....     @rr_q1e2
 
 FMOVI_s         0001 1110 .. 1 imm:8 100 00000 rd:5         esz=%esz_hsd
 
-# Advanced SIMD Modified Immediate
+# Advanced SIMD Modified Immediate / Shift by Immediate
 
 %abcdefgh       16:3 5:5
 
+# Right shifts are encoded as N - shift, where N is the element size in bits.
+%neon_rshift_i6 16:6 !function=rsub_64
+%neon_rshift_i5 16:5 !function=rsub_32
+%neon_rshift_i4 16:4 !function=rsub_16
+%neon_rshift_i3 16:3 !function=rsub_8
+
+@q_shri_b       . q:1 .. ..... 0001 ... ..... . rn:5 rd:5   \
+                &qrri_e esz=0 imm=%neon_rshift_i3
+@q_shri_h       . q:1 .. ..... 001 .... ..... . rn:5 rd:5   \
+                &qrri_e esz=1 imm=%neon_rshift_i4
+@q_shri_s       . q:1 .. ..... 01 ..... ..... . rn:5 rd:5   \
+                &qrri_e esz=2 imm=%neon_rshift_i5
+@q_shri_d       . 1 .. ..... 1 ...... ..... . rn:5 rd:5     \
+                &qrri_e esz=3 imm=%neon_rshift_i6 q=1
+
 FMOVI_v_h       0 q:1 00 1111 00000 ... 1111 11 ..... rd:5  %abcdefgh
 
 # MOVI, MVNI, ORR, BIC, FMOV are all intermixed via cmode.
 Vimm            0 q:1 op:1 0 1111 00000 ... cmode:4 01 ..... rd:5 %abcdefgh
+
+SSHR_v          0.00 11110 .... ... 00000 1 ..... .....     @q_shri_b
+SSHR_v          0.00 11110 .... ... 00000 1 ..... .....     @q_shri_h
+SSHR_v          0.00 11110 .... ... 00000 1 ..... .....     @q_shri_s
+SSHR_v          0.00 11110 .... ... 00000 1 ..... .....     @q_shri_d
+
+USHR_v          0.10 11110 .... ... 00000 1 ..... .....     @q_shri_b
+USHR_v          0.10 11110 .... ... 00000 1 ..... .....     @q_shri_h
+USHR_v          0.10 11110 .... ... 00000 1 ..... .....     @q_shri_s
+USHR_v          0.10 11110 .... ... 00000 1 ..... .....     @q_shri_d
+
+SSRA_v          0.00 11110 .... ... 00010 1 ..... .....     @q_shri_b
+SSRA_v          0.00 11110 .... ... 00010 1 ..... .....     @q_shri_h
+SSRA_v          0.00 11110 .... ... 00010 1 ..... .....     @q_shri_s
+SSRA_v          0.00 11110 .... ... 00010 1 ..... .....     @q_shri_d
+
+USRA_v          0.10 11110 .... ... 00010 1 ..... .....     @q_shri_b
+USRA_v          0.10 11110 .... ... 00010 1 ..... .....     @q_shri_h
+USRA_v          0.10 11110 .... ... 00010 1 ..... .....     @q_shri_s
+USRA_v          0.10 11110 .... ... 00010 1 ..... .....     @q_shri_d
+
+SRSHR_v         0.00 11110 .... ... 00100 1 ..... .....     @q_shri_b
+SRSHR_v         0.00 11110 .... ... 00100 1 ..... .....     @q_shri_h
+SRSHR_v         0.00 11110 .... ... 00100 1 ..... .....     @q_shri_s
+SRSHR_v         0.00 11110 .... ... 00100 1 ..... .....     @q_shri_d
+
+URSHR_v         0.10 11110 .... ... 00100 1 ..... .....     @q_shri_b
+URSHR_v         0.10 11110 .... ... 00100 1 ..... .....     @q_shri_h
+URSHR_v         0.10 11110 .... ... 00100 1 ..... .....     @q_shri_s
+URSHR_v         0.10 11110 .... ... 00100 1 ..... .....     @q_shri_d
+
+SRSRA_v         0.00 11110 .... ... 00110 1 ..... .....     @q_shri_b
+SRSRA_v         0.00 11110 .... ... 00110 1 ..... .....     @q_shri_h
+SRSRA_v         0.00 11110 .... ... 00110 1 ..... .....     @q_shri_s
+SRSRA_v         0.00 11110 .... ... 00110 1 ..... .....     @q_shri_d
+
+URSRA_v         0.10 11110 .... ... 00110 1 ..... .....     @q_shri_b
+URSRA_v         0.10 11110 .... ... 00110 1 ..... .....     @q_shri_h
+URSRA_v         0.10 11110 .... ... 00110 1 ..... .....     @q_shri_s
+URSRA_v         0.10 11110 .... ... 00110 1 ..... .....     @q_shri_d
+
+SRI_v           0.10 11110 .... ... 01000 1 ..... .....     @q_shri_b
+SRI_v           0.10 11110 .... ... 01000 1 ..... .....     @q_shri_h
+SRI_v           0.10 11110 .... ... 01000 1 ..... .....     @q_shri_s
+SRI_v           0.10 11110 .... ... 01000 1 ..... .....     @q_shri_d
-- 
2.43.0


