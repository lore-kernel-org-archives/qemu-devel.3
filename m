Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D0DC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEv-0001cG-E4; Fri, 04 Jul 2025 12:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEX-0000iG-6P
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:53 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEV-0006JW-BA
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:52 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so678999f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646350; x=1752251150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JEfw+hU25YNEGVmIvwv1xtY9QXngB3p4FY9Sf3xuo6Y=;
 b=jHmPAQvxCY4nkyhvzrapfz3QDMRnmRgQ4x5cosiC4sNHUT2lp7oM+TX2keT1Pu9r9v
 8rf1+jFMNVJasi/HyAQF2ZNJ3grPRlWVKsfTrCev1FzBxeWAggXToC/JVna6Op4rnaLJ
 9KTAuggE+IoKhBFC6QY/hvPd2My4rNHQxZCPtZxFzWlTe217KTR2FQ08srP5B2VYjKCd
 7twiTgND/5/c0yVbnGQPtoI+QsE3z6hszjsWJS7l5T9tni35/ttWAV75TyeoZvB3AzVp
 NWqG63gt9rRbSBwOdgce5u23+L1RQ1RlzwbCMzqqHgpY8PoXxE1z2Y4VZPcBSJcy3Jj6
 TF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646350; x=1752251150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JEfw+hU25YNEGVmIvwv1xtY9QXngB3p4FY9Sf3xuo6Y=;
 b=GI4K8NiNbINoMZaPswwVn2qPJ9lXsGUAmdz6AuYHnp6yVtZAhGIIPXXdtSc/Dl3067
 lpkfTjqy5HlTe/6uEzmZ6+nA32AnfvJLXaBtsKNuNz88gRpDcfbc/fPz4ZQeS6iVbXZE
 nosKjgbMpH4keDUUI+sjVelQnuIXg6HxGzEVF7kGxsiHrr3DOaKp5QSQBeNJ/u9ZvEwj
 qTSY5aZtjJ9x+SRjO/FZlciA9V5RSFIM/9kfrLXJMqTivK0uJCectA6j5noFNBGWB/Fs
 5xwpO7r+EP1Don+8LhRhIKFzes0WP0m3H3vpOiHOavP3N/m8nRefdX4MPqPzfBS1M3j2
 CmaQ==
X-Gm-Message-State: AOJu0YxMtHSigpQ/EYfXA0RnRMLBHG+5kuqnv0ojcFBscC48w2I6mzoM
 WfSfIQk7la1TuQv0yfKZweUOnUFA+wbCy6bicOYxapMVcvup30SOe6lMwXelwx+gG5DkCAqtJtO
 JUIgD
X-Gm-Gg: ASbGncush3chFUo7iQ/sugNAYqQJah/DK2IbA2sEvJ6hxnqd8sZtj/ax80SWC1wSeHJ
 zrrjzTmx6fgkGlAaatCFWSoqEpw6OoDH5u8dYnmPMSGsusfDOt9SW31pzQskXlw3PZZl4Zognoo
 9odCgBNYEDJvl+0tiQJCn69hn/fbjLyuY4OH95XQQY26QppgMuS2sZLztHiw7gC2RTKcGOc1qKD
 y/bGiNqoPURrlmGzd0rbJ1tSL5CDz5O9WWTg9SABkP4jNqrylY/8XaxWjhC3k6mLKm+XbfQbyH0
 rc4QSYmGM/L58RGAC/M+cB8GSQTc2Xw8aR0KQmYV5ATa7L32RsETnVK89XnzYR2dLVkt
X-Google-Smtp-Source: AGHT+IEWdJY0lkgwGoPg3oe1lP1VLeStJ0MBJJkCppg9r1ZzmBuMPM3W5lp5Xn9ji1iGmn+iN79ymQ==
X-Received: by 2002:a05:6000:208a:b0:3a4:d939:62fc with SMTP id
 ffacd0b85a97d-3b4964c1522mr2324305f8f.22.1751646349864; 
 Fri, 04 Jul 2025 09:25:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 051/119] target/arm: Implement SME2 FVDOT, BFVDOT
Date: Fri,  4 Jul 2025 17:23:51 +0100
Message-ID: <20250704162501.249138-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
Message-id: 20250704142112.1018902-40-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  2 ++
 target/arm/tcg/helper.h        |  2 ++
 target/arm/tcg/sme.decode      |  3 +++
 target/arm/tcg/sme_helper.c    | 30 ++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 24 +++++++++++++++++++++
 target/arm/tcg/vec_helper.c    | 39 ++++++++++++++++++++++++++++++++++
 6 files changed, 100 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index ec93ff57ff3..8f5a1b3c908 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -178,3 +178,5 @@ DEF_HELPER_FLAGS_6(sme2_fdot_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_6(sme2_fdot_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(sme2_fvdot_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index a05b63380cb..d8d389af2b9 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -1089,6 +1089,8 @@ DEF_HELPER_FLAGS_6(gvec_bfdot, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_6(gvec_bfdot_idx, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(sme2_bfvdot_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_6(gvec_bfmmla, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 18e625605fb..7c057bcad20 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -374,3 +374,6 @@ FDOT_nx         11000001 0101 .... 1 .. 1 .. ...00 01 ...   @azx_4x1_i2_o3
 
 BFDOT_nx        11000001 0101 .... 0 .. 1 .. ....0 11 ...   @azx_2x1_i2_o3
 BFDOT_nx        11000001 0101 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_i2_o3
+
+FVDOT           11000001 0101 .... 0 .. 0 .. ....0 01 ...   @azx_2x1_i2_o3
+BFVDOT          11000001 0101 .... 0 .. 0 .. ....0 11 ...   @azx_2x1_i2_o3
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 60322be3d0b..8b458654612 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1196,6 +1196,36 @@ void HELPER(sme2_fdot_idx_h)(void *vd, void *vn, void *vm, void *va,
     }
 }
 
+void HELPER(sme2_fvdot_idx_h)(void *vd, void *vn, void *vm, void *va,
+                              CPUARMState *env, uint32_t desc)
+{
+    intptr_t i, j, oprsz = simd_maxsz(desc);
+    intptr_t elements = oprsz / sizeof(float32);
+    intptr_t eltspersegment = MIN(4, elements);
+    int idx = extract32(desc, SIMD_DATA_SHIFT, 2);
+    int sel = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    float_status fpst_odd, *fpst_std, *fpst_f16;
+    float32 *d = vd, *a = va;
+    uint16_t *n0 = vn;
+    uint16_t *n1 = vn + sizeof(ARMVectorReg);
+    uint32_t *m = (uint32_t *)vm + H4(idx);
+
+    fpst_std = &env->vfp.fp_status[FPST_ZA];
+    fpst_f16 = &env->vfp.fp_status[FPST_ZA_F16];
+    fpst_odd = *fpst_std;
+    set_float_rounding_mode(float_round_to_odd, &fpst_odd);
+
+    for (i = 0; i < elements; i += eltspersegment) {
+        uint32_t mm = m[i];
+        for (j = 0; j < eltspersegment; ++j) {
+            uint32_t nn = (n0[H2(2 * (i + j) + sel)])
+                        | (n1[H2(2 * (i + j) + sel)] << 16);
+            d[i + H4(j)] = f16_dotadd(a[i + H4(j)], nn, mm,
+                                      fpst_f16, fpst_std, &fpst_odd);
+        }
+    }
+}
+
 void HELPER(sme_bfmopa)(void *vza, void *vzn, void *vzm,
                         void *vpn, void *vpm, CPUARMState *env, uint32_t desc)
 {
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 965a49465e4..410a8d037c0 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -938,3 +938,27 @@ static bool do_bfdot_nx(DisasContext *s, arg_azx_n *a)
 }
 
 TRANS_FEAT(BFDOT_nx, aa64_sme2, do_bfdot_nx, a)
+
+static bool do_vdot(DisasContext *s, arg_azx_n *a, gen_helper_gvec_4_ptr *fn)
+{
+    if (sme_smza_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int vstride = svl / 2;
+        TCGv_ptr t_za = get_zarray(s, a->rv, a->off, 2, 1);
+        TCGv_ptr t_zn = vec_full_reg_ptr(s, a->zn);
+        TCGv_ptr t_zm = vec_full_reg_ptr(s, a->zm);
+        TCGv_ptr t = tcg_temp_new_ptr();
+
+        for (int i = 0; i < 2; ++i) {
+            int o_za = i * vstride * sizeof(ARMVectorReg);
+            int desc = simd_desc(svl, svl, a->idx | (i << 2));
+
+            tcg_gen_addi_ptr(t, t_za, o_za);
+            fn(t, t_zn, t_zm, t, tcg_env, tcg_constant_i32(desc));
+        }
+    }
+    return true;
+}
+
+TRANS_FEAT(FVDOT, aa64_sme, do_vdot, a, gen_helper_sme2_fvdot_idx_h)
+TRANS_FEAT(BFVDOT, aa64_sme, do_vdot, a, gen_helper_sme2_bfvdot_idx)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 5dcd6f9282d..616f4050e47 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -3110,6 +3110,45 @@ void HELPER(gvec_bfdot_idx)(void *vd, void *vn, void *vm,
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(sme2_bfvdot_idx)(void *vd, void *vn, void *vm,
+                             void *va, CPUARMState *env, uint32_t desc)
+{
+    intptr_t i, j, opr_sz = simd_oprsz(desc);
+    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT, 2);
+    intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    intptr_t elements = opr_sz / 4;
+    intptr_t eltspersegment = MIN(16 / 4, elements);
+    float32 *d = vd, *a = va;
+    uint16_t *n0 = vn;
+    uint16_t *n1 = vn + sizeof(ARMVectorReg);
+    uint32_t *m = vm;
+    float_status fpst, fpst_odd;
+
+    if (is_ebf(env, &fpst, &fpst_odd)) {
+        for (i = 0; i < elements; i += eltspersegment) {
+            uint32_t m_idx = m[i + H4(idx)];
+
+            for (j = 0; j < eltspersegment; j++) {
+                uint32_t nn = (n0[H2(2 * (i + j) + sel)])
+                            | (n1[H2(2 * (i + j) + sel)] << 16);
+                d[i + H4(j)] = bfdotadd_ebf(a[i + H4(j)], nn, m_idx,
+                                            &fpst, &fpst_odd);
+            }
+        }
+    } else {
+        for (i = 0; i < elements; i += eltspersegment) {
+            uint32_t m_idx = m[i + H4(idx)];
+
+            for (j = 0; j < eltspersegment; j++) {
+                uint32_t nn = (n0[H2(2 * (i + j) + sel)])
+                            | (n1[H2(2 * (i + j) + sel)] << 16);
+                d[i + H4(j)] = bfdotadd(a[i + H4(j)], nn, m_idx, &fpst);
+            }
+        }
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
 void HELPER(gvec_bfmmla)(void *vd, void *vn, void *vm, void *va,
                          CPUARMState *env, uint32_t desc)
 {
-- 
2.43.0


