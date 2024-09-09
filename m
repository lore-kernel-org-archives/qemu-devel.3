Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74097ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 16:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snhAG-0002ep-Eh; Mon, 09 Sep 2024 12:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAF-0002ZM-4p
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:22:55 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAD-0007if-4A
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:22:54 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2055a3f80a4so32820995ad.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 09:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725898972; x=1726503772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AiXgo5C5iMvrCSwZrTjjoeF1dyYuwPhkfLCjH211bC8=;
 b=q9WPR4YiuEow/bl5o5W61v928XA1xc42K/ALfHltpgTuEBqq1NPlKXvq+0b1zMmhjS
 upb7Ym3Pv6ytJbarPu9UEwfTCN8I9/2Gc4gJRlC/zPvENsB0u5sDNXa5MvrKdzhBqNIU
 wLXQaV1JtHFPG6egEzpQEhDk7S/AgibeFTvllJ64C2o4o9rkjyUnndq8awqTWGvWOGQF
 lYIIpjhP2undbGeJtWI1MuIEwhE/oBSW82P5uEEEMoYZ7fF6euCysyHkyCzIzooC3+NJ
 /2p8KMn36LHmQW950VMHgVvqJsFL/J51JN8FnpvbkEFPndezNxQl6Cw2xlzHVQnSReku
 A1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725898972; x=1726503772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AiXgo5C5iMvrCSwZrTjjoeF1dyYuwPhkfLCjH211bC8=;
 b=Ag3djOKWioD5QCWYZCbPcfTMhNfnai8SMcmHp095VEWTL2553vRIzDcXeIWEvzaCqk
 rTuCeyYDfW/urcxMk4JT6oIsDvX3gSag+oujnmNS4LuzBqT/es4qgAE8WKrMVLpbtmYx
 DnCNNXSPGLQliCobtDARj5vP5O2giM2C+tSoHtKG/ODakOoN9dY8jY/WL78F51RCXtnA
 UTyQbzet43ujy+phTkfmCgRfk0gO897XiCSuYePeh1177Bpz++qbREtWRA09DMuSUMQv
 +6//AQ1sjIu8MLaCvIr6mOi4kq5IlUtBQeFOTa3gLCYfqp0J9ulLDcDFlII2oZk3UyQj
 Y7Bw==
X-Gm-Message-State: AOJu0Ywj949hFK3CXI3a5kv2EUvauwNizhYQuL6OBvASuLwT10GsEMyU
 Bdu+sCY1Ctin+51lRYx0nRMdX4F3bxmaliBvL+8n8x50KTHNXZjBWlXBdMIA9XEWieI0JNXvsSv
 d
X-Google-Smtp-Source: AGHT+IGIllnN+DV3ZRGt8wY+VSYZBJwOJnCh7O3y2kKibv9PIVv5MQukwJJBdUozekgM22fvLSk9GQ==
X-Received: by 2002:a17:902:dac9:b0:206:998d:6ea0 with SMTP id
 d9443c01a7336-206f057c0c9mr180735265ad.33.1725898971617; 
 Mon, 09 Sep 2024 09:22:51 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f35d79sm35753305ad.288.2024.09.09.09.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 09:22:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 10/29] target/arm: Convert ADDV, *ADDLV, *MAXV,
 *MINV to decodetree
Date: Mon,  9 Sep 2024 09:22:20 -0700
Message-ID: <20240909162240.647173-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909162240.647173-1-richard.henderson@linaro.org>
References: <20240909162240.647173-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 140 ++++++++++++---------------------
 target/arm/tcg/a64.decode      |  12 +++
 2 files changed, 61 insertions(+), 91 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 74efb35164..593a1774d8 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6794,6 +6794,47 @@ TRANS(FNMADD, do_fmadd, a, true, true)
 TRANS(FMSUB, do_fmadd, a, false, true)
 TRANS(FNMSUB, do_fmadd, a, true, false)
 
+/*
+ * Advanced SIMD Across Lanes
+ */
+
+static bool do_int_reduction(DisasContext *s, arg_qrr_e *a, bool widen,
+                             MemOp src_sign, NeonGenTwo64OpFn *fn)
+{
+    TCGv_i64 tcg_res, tcg_elt;
+    MemOp src_mop = a->esz | src_sign;
+    int elements = (a->q ? 16 : 8) >> a->esz;
+
+    /* Reject MO_64, and MO_32 without Q: a minimum of 4 elements. */
+    if (elements < 4) {
+        return false;
+    }
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    tcg_res = tcg_temp_new_i64();
+    tcg_elt = tcg_temp_new_i64();
+
+    read_vec_element(s, tcg_res, a->rn, 0, src_mop);
+    for (int i = 1; i < elements; i++) {
+        read_vec_element(s, tcg_elt, a->rn, i, src_mop);
+        fn(tcg_res, tcg_res, tcg_elt);
+    }
+
+    tcg_gen_ext_i64(tcg_res, tcg_res, a->esz + widen);
+    write_fp_dreg(s, a->rd, tcg_res);
+    return true;
+}
+
+TRANS(ADDV, do_int_reduction, a, false, 0, tcg_gen_add_i64)
+TRANS(SADDLV, do_int_reduction, a, true, MO_SIGN, tcg_gen_add_i64)
+TRANS(UADDLV, do_int_reduction, a, true, 0, tcg_gen_add_i64)
+TRANS(SMAXV, do_int_reduction, a, false, MO_SIGN, tcg_gen_smax_i64)
+TRANS(UMAXV, do_int_reduction, a, false, 0, tcg_gen_umax_i64)
+TRANS(SMINV, do_int_reduction, a, false, MO_SIGN, tcg_gen_smin_i64)
+TRANS(UMINV, do_int_reduction, a, false, 0, tcg_gen_umin_i64)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -9092,27 +9133,10 @@ static void disas_simd_across_lanes(DisasContext *s, uint32_t insn)
     int opcode = extract32(insn, 12, 5);
     bool is_q = extract32(insn, 30, 1);
     bool is_u = extract32(insn, 29, 1);
-    bool is_fp = false;
     bool is_min = false;
     int elements;
-    int i;
-    TCGv_i64 tcg_res, tcg_elt;
 
     switch (opcode) {
-    case 0x1b: /* ADDV */
-        if (is_u) {
-            unallocated_encoding(s);
-            return;
-        }
-        /* fall through */
-    case 0x3: /* SADDLV, UADDLV */
-    case 0xa: /* SMAXV, UMAXV */
-    case 0x1a: /* SMINV, UMINV */
-        if (size == 3 || (size == 2 && !is_q)) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
     case 0xc: /* FMAXNMV, FMINNMV */
     case 0xf: /* FMAXV, FMINV */
         /* Bit 1 of size field encodes min vs max and the actual size
@@ -9121,7 +9145,6 @@ static void disas_simd_across_lanes(DisasContext *s, uint32_t insn)
          * precision.
          */
         is_min = extract32(size, 1, 1);
-        is_fp = true;
         if (!is_u && dc_isar_feature(aa64_fp16, s)) {
             size = 1;
         } else if (!is_u || !is_q || extract32(size, 0, 1)) {
@@ -9132,6 +9155,10 @@ static void disas_simd_across_lanes(DisasContext *s, uint32_t insn)
         }
         break;
     default:
+    case 0x3: /* SADDLV, UADDLV */
+    case 0xa: /* SMAXV, UMAXV */
+    case 0x1a: /* SMINV, UMINV */
+    case 0x1b: /* ADDV */
         unallocated_encoding(s);
         return;
     }
@@ -9142,52 +9169,7 @@ static void disas_simd_across_lanes(DisasContext *s, uint32_t insn)
 
     elements = (is_q ? 16 : 8) >> size;
 
-    tcg_res = tcg_temp_new_i64();
-    tcg_elt = tcg_temp_new_i64();
-
-    /* These instructions operate across all lanes of a vector
-     * to produce a single result. We can guarantee that a 64
-     * bit intermediate is sufficient:
-     *  + for [US]ADDLV the maximum element size is 32 bits, and
-     *    the result type is 64 bits
-     *  + for FMAX*V, FMIN*V, ADDV the intermediate type is the
-     *    same as the element size, which is 32 bits at most
-     * For the integer operations we can choose to work at 64
-     * or 32 bits and truncate at the end; for simplicity
-     * we use 64 bits always. The floating point
-     * ops do require 32 bit intermediates, though.
-     */
-    if (!is_fp) {
-        read_vec_element(s, tcg_res, rn, 0, size | (is_u ? 0 : MO_SIGN));
-
-        for (i = 1; i < elements; i++) {
-            read_vec_element(s, tcg_elt, rn, i, size | (is_u ? 0 : MO_SIGN));
-
-            switch (opcode) {
-            case 0x03: /* SADDLV / UADDLV */
-            case 0x1b: /* ADDV */
-                tcg_gen_add_i64(tcg_res, tcg_res, tcg_elt);
-                break;
-            case 0x0a: /* SMAXV / UMAXV */
-                if (is_u) {
-                    tcg_gen_umax_i64(tcg_res, tcg_res, tcg_elt);
-                } else {
-                    tcg_gen_smax_i64(tcg_res, tcg_res, tcg_elt);
-                }
-                break;
-            case 0x1a: /* SMINV / UMINV */
-                if (is_u) {
-                    tcg_gen_umin_i64(tcg_res, tcg_res, tcg_elt);
-                } else {
-                    tcg_gen_smin_i64(tcg_res, tcg_res, tcg_elt);
-                }
-                break;
-            default:
-                g_assert_not_reached();
-            }
-
-        }
-    } else {
+    {
         /* Floating point vector reduction ops which work across 32
          * bit (single) or 16 bit (half-precision) intermediates.
          * Note that correct NaN propagation requires that we do these
@@ -9195,34 +9177,10 @@ static void disas_simd_across_lanes(DisasContext *s, uint32_t insn)
          */
         TCGv_ptr fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
         int fpopcode = opcode | is_min << 4 | is_u << 5;
-        TCGv_i32 tcg_res32 = do_reduction_op(s, fpopcode, rn, size,
-                                             0, elements, fpst);
-        tcg_gen_extu_i32_i64(tcg_res, tcg_res32);
+        TCGv_i32 tcg_res = do_reduction_op(s, fpopcode, rn, size,
+                                           0, elements, fpst);
+        write_fp_sreg(s, rd, tcg_res);
     }
-
-    /* Now truncate the result to the width required for the final output */
-    if (opcode == 0x03) {
-        /* SADDLV, UADDLV: result is 2*esize */
-        size++;
-    }
-
-    switch (size) {
-    case 0:
-        tcg_gen_ext8u_i64(tcg_res, tcg_res);
-        break;
-    case 1:
-        tcg_gen_ext16u_i64(tcg_res, tcg_res);
-        break;
-    case 2:
-        tcg_gen_ext32u_i64(tcg_res, tcg_res);
-        break;
-    case 3:
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    write_fp_dreg(s, rd, tcg_res);
 }
 
 /* AdvSIMD modified immediate
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 7f71c56f83..5ab4b11781 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -59,6 +59,8 @@
 @rrr_q1e3       ........ ... rm:5 ...... rn:5 rd:5      &qrrr_e q=1 esz=3
 @rrrr_q1e3      ........ ... rm:5 . ra:5 rn:5 rd:5      &qrrrr_e q=1 esz=3
 
+@qrr_e          . q:1 ...... esz:2 ...... ...... rn:5 rd:5  &qrr_e
+
 @qrrr_b         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=0
 @qrrr_h         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=1
 @qrrr_s         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=2
@@ -1154,3 +1156,13 @@ TRN1            0.00 1110 .. 0 ..... 0 010 10 ..... .....   @qrrr_e
 TRN2            0.00 1110 .. 0 ..... 0 110 10 ..... .....   @qrrr_e
 ZIP1            0.00 1110 .. 0 ..... 0 011 10 ..... .....   @qrrr_e
 ZIP2            0.00 1110 .. 0 ..... 0 111 10 ..... .....   @qrrr_e
+
+# Advanced SIMD Across Lanes
+
+ADDV            0.00 1110 .. 11000 11011 10 ..... .....     @qrr_e
+SADDLV          0.00 1110 .. 11000 00011 10 ..... .....     @qrr_e
+UADDLV          0.10 1110 .. 11000 00011 10 ..... .....     @qrr_e
+SMAXV           0.00 1110 .. 11000 01010 10 ..... .....     @qrr_e
+UMAXV           0.10 1110 .. 11000 01010 10 ..... .....     @qrr_e
+SMINV           0.00 1110 .. 11000 11010 10 ..... .....     @qrr_e
+UMINV           0.10 1110 .. 11000 11010 10 ..... .....     @qrr_e
-- 
2.43.0


