Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A5ACD98F9
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 04:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa4A4-0005UO-J9; Thu, 18 Jun 2026 00:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa4A2-0005SO-9m
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:15:26 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa4A0-0005Zw-65
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:15:26 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2c6c101aeafso3230685ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 21:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781756123; x=1782360923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9sEmumsrzFhe2d+S3+ete9LhgUVrB8VbLgQyKIiI5rI=;
 b=L6idbvx0PTem2mo6wbpt0EkaETninPWdjit0nWwF9E7c60yxo6oa9siJSff0AbCiFB
 d5YfxNm/myju3xwRXZ5G1oWoZZMjw8feYQKi0clyoquX74+N35VMMJ9m5gMMT9BA1xez
 jUJSM2x3Pdvo0cznUEhkjUWsFmzCZL2xoAgAl4aN8nUvMA/JczuDIKFkuPrsgjoFalID
 YT7HKhpMPwkvUdzc5XVmr21QoPGND2LAm/2Rmbchmw1ooeucps5GTJbl/c/fovVqwkMc
 ybAFng+ljkfgG9n+8NCTiSwH8/RcPmUOGcRt2jplzudauqn2A51TQ5QnafXWcYWpq5gb
 tbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781756123; x=1782360923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9sEmumsrzFhe2d+S3+ete9LhgUVrB8VbLgQyKIiI5rI=;
 b=oPmiHBw7oaNKECFqMRvd5r7rt2AXosTW0/OVJruSVhY8PQDQ3UvA8Ew7xZQyUuEJp0
 IhUxBD2xaCcER1Fm0rZnjQJjBqb440NS/lAZTrS/WGcUnyr1vIOZ6oIqIJi9q99ar9sk
 9aZplwtirr4TFH9LxwsZRZsTczR+wdwGE+UclkXMy9VXaMZh2+D31qNtMZND3JCkwq3o
 ZcBJo4NQgAWiSltqPFVFbBz/Rireqjm8AlS6ae/xCCisDj+orI0bq7VIFi6QIUbXFIAM
 Q37BRc78IHvcbsuhcQ7uTDxKxIHPDwV6YXj5+kcHa2+0YhT5bUbR/rh6HxSzb7EwXh+p
 GMxg==
X-Gm-Message-State: AOJu0YzXWB8WWcE44yUa/iM1PP71Oq+CLy6Li/Xe4pvJOGmyFEWCeNan
 PrYo9Oo0sPkK3encPQ4JACKIOPCwHWkb1CCj3vDL/xkVbi2ei+cfCK5SDheFYGs2e4kOF10EWEv
 fmi/Q
X-Gm-Gg: AfdE7ckLnLDF5H2T3QhoZgHKHwKd4JOvNh2hkIR/55ik8zaOpujUYiH3j1MipioSBcz
 P2RFf8qSM1qi07OGnoXU95CnebnumcyfV/fgJb50tGTea6QubxJf+eH6RdzmHFlCU/AfI+d1ldX
 3fC88vV27wDRtS9y62SdKod6WXzNEOWtgR8WppoIEft3J75pEfM4/Z9DTyKdMvmVH5gDTplobWk
 6hyg3sJZTNOaW2x/oIwkdCUG9Wt11/osqxAPghdB9iQZ6WXq23kjUQ88spvkAjE0I6H3/QzolSf
 lC4k7wbsfxbbyt8z9VOjKIEuhNwO7IXuFxITESAsDDAIo5QHhE1yVVO+aYdY6cEnQp3Y4HLxaY2
 TQDjSdipbHox1T5KlLdghKStSPr+vuIuGMBx6OzS/wJ+gnRSCrWetuab+8aJ7jtZAfu39+P4Hwh
 RQZe84a/xMPY76b2aO8wHJf026qvluFnvLPewy4W3HFLZSxGMcr/Cn4g05pwjL
X-Received: by 2002:a17:903:19e7:b0:2c0:ab82:6bb8 with SMTP id
 d9443c01a7336-2c6e52b7ea4mr21474025ad.27.1781756122588; 
 Wed, 17 Jun 2026 21:15:22 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f2e535csm173905935ad.6.2026.06.17.21.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 21:15:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 02/10] target/arm: Implement FMOPA (widening,
 4-way fp8 to fp32)
Date: Wed, 17 Jun 2026 21:15:09 -0700
Message-ID: <20260618041517.573469-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618041517.573469-1-richard.henderson@linaro.org>
References: <20260618041517.573469-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/fp8_helper.c      | 35 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   | 19 +++++++++++++++++
 target/arm/tcg/sme.decode        |  2 ++
 5 files changed, 63 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index c07bcb0a73..45213f71ab 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1600,6 +1600,11 @@ static inline bool isar_feature_aa64_sme_b16b16(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, B16B16);
 }
 
+static inline bool isar_feature_aa64_sme_f8f32(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, F8F32);
+}
+
 static inline bool isar_feature_aa64_sme_f16f16(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, F16F16);
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index e942308af4..7c090ccad6 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -38,3 +38,5 @@ DEF_HELPER_FLAGS_5(gvec_fdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env,
 
 DEF_HELPER_FLAGS_5(gvec_fmmla_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fmmla_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_7(sme_fmopa_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index bd0877071b..08e04364fa 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -857,3 +857,38 @@ void HELPER(gvec_fmmla_hb)(void *vd, void *vn, void *vm,
 
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(sme_fmopa_sb)(void *vza, void *vzn, void *vzm, void *vpn,
+                          void *vpm, CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, -1);
+    intptr_t oprsz = simd_maxsz(desc);
+    uint16_t *pn = vpn, *pm = vpm;
+
+    for (intptr_t row = 0; row < oprsz; ) {
+        uint16_t prow = pn[H2(row >> 4)];
+        do {
+            void *vza_row = vza + tile_vslice_offset(row);
+            uint32_t n = *(uint32_t *)(vzn + H1_4(row));
+
+            n &= expand_pred_b(prow & 0xf);
+
+            for (intptr_t col = 0; col < oprsz; ) {
+                uint16_t pcol = pm[H2(col >> 4)];
+                do {
+                    if (prow & pcol & 0xf) {
+                        uint32_t *a = vza_row + H1_4(col);
+                        uint32_t m = *(uint32_t *)(vzm + H1_4(col));
+
+                        m &= expand_pred_b(pcol & 0xf);
+                        *a = f8dotadd_s(n, m, 4, *a, &ctx);
+                    }
+                    col += 4;
+                    pcol >>= 4;
+                } while (col & 15);
+            }
+            row += 4;
+            prow >>= 4;
+        } while (row & 15);
+    }
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 98d3d18791..63c6e2c9b1 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -616,6 +616,25 @@ TRANS_FEAT(BFMOPA_w, aa64_sme, do_outprod_env, a, MO_32,
            : !s->fpcr_ah ? gen_helper_sme_bfmops_w
            : gen_helper_sme_ah_bfmops_w)
 
+static bool trans_FMOPA_sb(DisasContext *s, arg_op *a)
+{
+    if (!dc_isar_feature(aa64_sme_f8f32, s)) {
+        return false;
+    }
+    if (fpmr_access_check(s) && sme_smza_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        uint32_t desc = simd_desc(svl, svl, 0);
+
+        gen_helper_sme_fmopa_sb(get_tile(s, MO_32, a->zad),
+                                vec_full_reg_ptr(s, a->zn),
+                                vec_full_reg_ptr(s, a->zm),
+                                pred_full_reg_ptr(s, a->pn),
+                                pred_full_reg_ptr(s, a->pm),
+                                tcg_env, tcg_constant_i32(desc));
+    }
+    return true;
+}
+
 TRANS_FEAT(SMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_smopa_s)
 TRANS_FEAT(UMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_umopa_s)
 TRANS_FEAT(SUMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_sumopa_s)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 495330aed7..e668293efd 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -198,6 +198,8 @@ BFMOPA          10000001 101 ..... ... ... ..... . 100 .        @op_16
 BFMOPA_w        10000001 100 ..... ... ... ..... . 00 ..        @op_32
 FMOPA_w_h       10000001 101 ..... ... ... ..... . 00 ..        @op_32
 
+FMOPA_sb        10000000 101 zm:5 pm:3 pn:3 zn:5 0 00 zad:2     &op sub=0
+
 SMOPA_s         1010000 0 10 0 ..... ... ... ..... . 00 ..      @op_32
 SUMOPA_s        1010000 0 10 1 ..... ... ... ..... . 00 ..      @op_32
 USMOPA_s        1010000 1 10 0 ..... ... ... ..... . 00 ..      @op_32
-- 
2.43.0


