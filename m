Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A6ACD4F54
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSre-0000XD-QK; Sat, 30 May 2026 19:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrc-0000Vp-NM
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:13:08 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSra-0007ed-SU
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:13:08 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c857d04cc99so497005a12.0
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182785; x=1780787585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jcUdpMLyTWJf5Zy34vFVIdzyaHCSAKrz+Dcw2eeWrsQ=;
 b=YrN67H9zSkY/k1IVJiEyK/5dhZMgp1sue28U+yXHuWO/2weuSRjsvOktNKfWKegMdP
 QyFq5cfrsfxt9EjpI4xlI5vXkrqGsW6jgjLEnjWP2GDqG8T3kMow/9fXOfTOGc23Te6Z
 UQnHhhS8JNS+DwgxuhCrBY9Rgb6+hF6tnRuxg2sMRk5GcXHd0yFh087MP7uasDoPKOWT
 tgh6TBFPNek3NovTzKhBT8aH9QCB+MFDP+zYQoP43kAt38xLzZmwwA21NPfLPupHVQC8
 LM+B/zVekhE87bhVJihnyBvZXCfG8YclpRVE1lP8KAktGKwduA0MVnkVsqhCVB9nFejf
 xFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182785; x=1780787585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jcUdpMLyTWJf5Zy34vFVIdzyaHCSAKrz+Dcw2eeWrsQ=;
 b=QA1lu8QcqEagcf2/65yYoqwqOCBTrTDiiNV89J+5Sts0wYBsV/qUWCFcIMBUI+0pfQ
 Q4JG+N50rgTmgIaeoY/YfCGH1TXcecCHo/8pNi/dfIXUjpBAf0+CimvY8NxLnhVsA8n5
 wDYsiRmbnwzRZ1TJW2R/amiLrYu3Zb8DpYgQirOoFMCLaTDk9gew2cTvdESf7xhCjBv3
 Wzg/TpuVnZo9wEvsC+Oqps/vNkpyzak4D2pyQ06rZy7rAaHbxflDfxd+bKoiAHVS2yV3
 Xnv6fiywbgFY/6+i755rnYAbP+9P9jT/mRDJ02PMBcLROykI/rdbHbLuYH27Ut5eONyw
 ig3A==
X-Gm-Message-State: AOJu0YzWqlgmLu22bo3cgKPkJgDkcbMwCJiOlpPX8y+hicAJ3AV+e61/
 fgl4nZgoRipuNqUeMpJAV9Iyvl0cbVd56/75zDvboLjluNxao5Obj/5TRy332eb3koNPq5J6wHC
 MHDAaDrc=
X-Gm-Gg: Acq92OGi3oCCSW1jdThLCL62lKi9imP5s9gpiWcdEh/vMgmW19ZCgNjIyqYq5SDIEar
 6eS/Xy2gkjo5bKTThTBkfvDHTWNJTEqoXllIxOlEPsT2tpCSPs5Uo9hw56dP/CsWGjYHkkrZZhs
 PmIuFbxiaDSrGNYJpzSz3UBF/xra9EGrLz/NcPyfPfC/d0jGo9KsSJ+tnqOgQ9+rGuTsy23fPd7
 lQlWGaeYIH4E/FYevYGV9sTl+UtYsjmyWYJ8VEAZ8Hac8orJwasxbDG604SQ9arEql4L8yJnEPo
 NDv+z/0gX+5RymJ91kPC6HdYcrXPwr+dxoOjhaTs4VXuCBKkxk0As8sd5GVnWQ9Fjog3EZCE4Q3
 gf7Ry9lUhX9ZDOWTd4aMspcwYw0DjrGsLD4fNqplGUH85npWhecro86V2g3XR9DU1A4bExz4CAY
 mg3yhtw2qwLNVdljt5J9nHLRw2ijUHdj7F1S+7NWM=
X-Received: by 2002:a05:6a21:4d0f:b0:3a1:90fd:dcdc with SMTP id
 adf61e73a8af0-3b40fb3903emr8202281637.6.1780182785356; 
 Sat, 30 May 2026 16:13:05 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:13:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 39/41] target/arm: Implement FMMLA (FP8 to FP16) for AdvSIMD
Date: Sat, 30 May 2026 16:12:27 -0700
Message-ID: <20260530231229.400441-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/fp8_helper.c      | 25 +++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  1 +
 target/arm/tcg/a64.decode        |  1 +
 5 files changed, 33 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 2b1d1034c0..6d65706186 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1635,6 +1635,11 @@ static inline bool isar_feature_aa64_f8mm8(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8MM8);
 }
 
+static inline bool isar_feature_aa64_f8mm4(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8MM4);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 3c74f02022..e942308af4 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -37,3 +37,4 @@ DEF_HELPER_FLAGS_5(gvec_fdot_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fmmla_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_fmmla_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 9db4ff4c2f..8365da9893 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -831,3 +831,28 @@ void HELPER(gvec_fmmla_sb)(void *vd, void *vn, void *vm,
 
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_fmmla_hb)(void *vd, void *vn, void *vm,
+                           CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, 0xf);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nseg = oprsz / 8;
+    uint32_t *n = vn;
+    uint32_t *m = vm;
+    float16 *d = vd;
+
+    for (size_t seg = 0; seg < nseg; seg++, d += 4, n += 2, m += 2) {
+        float16 d0 = f8dotadd_h(n[H4(0)], m[H4(0)], 4, d[H2(0)], &ctx);
+        float16 d1 = f8dotadd_h(n[H4(0)], m[H4(1)], 4, d[H2(1)], &ctx);
+        float16 d2 = f8dotadd_h(n[H4(1)], m[H4(0)], 4, d[H2(2)], &ctx);
+        float16 d3 = f8dotadd_h(n[H4(1)], m[H4(1)], 4, d[H2(3)], &ctx);
+
+        d[H2(0)] = d0;
+        d[H2(1)] = d1;
+        d[H2(2)] = d2;
+        d[H2(3)] = d3;
+    }
+
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 367f87f05d..126b7b44b8 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7502,6 +7502,7 @@ static bool do_f8dot(DisasContext *s, arg_qrrr_e *a,
 TRANS_FEAT(FDOT_sb_v, aa64_f8dp4, do_f8dot, a, gen_helper_gvec_fdot_sb)
 TRANS_FEAT(FDOT_hb_v, aa64_f8dp2, do_f8dot, a, gen_helper_gvec_fdot_hb)
 TRANS_FEAT(FMMLA_sb, aa64_f8mm8, do_f8dot, a, gen_helper_gvec_fmmla_sb)
+TRANS_FEAT(FMMLA_hb, aa64_f8mm4, do_f8dot, a, gen_helper_gvec_fmmla_hb)
 
 static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
                          gen_helper_gvec_3_ptr *fn)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 6922e91010..28cd1faf61 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1228,6 +1228,7 @@ FDOT_sb_v       0.00 1110 000 ..... 11111 1 ..... ..... @qrrr_s
 FDOT_hb_v       0.00 1110 010 ..... 11111 1 ..... ..... @qrrr_h
 
 FMMLA_sb        0110 1110 100 ..... 11101 1 ..... ..... @rrr_q1e0
+FMMLA_hb        0110 1110 000 ..... 11101 1 ..... ..... @rrr_q1e0
 
 ### Advanced SIMD scalar x indexed element
 
-- 
2.43.0


