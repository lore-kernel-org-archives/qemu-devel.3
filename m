Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B7ECD5BB9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY2J-0008SY-Q6; Fri, 22 May 2026 18:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1G-0006k9-Rl
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:05 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1A-0002Xx-8a
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:06:59 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b9fcf7c91bso86479395ad.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487615; x=1780092415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SMNTC+jZ0BqAim5qTslVzFy+EOrMkH7DmeCmY2/hdaI=;
 b=FKpNf2Dn7sVBwk9z17xWTGBjo5DxkOGNuWFccuUdKanuXTxQJLm0cCJfFVAXrgOlBj
 CO1JgRxfpUKOOlbeSOpkfOV33yM1CX6As9RdfRCQvT/mJ2qVvcc0TzzsWdq6F1dfgmP2
 rrph9+fYedB+sEnOpDAx2YrXmYgf7YoLAiCLXpLQp/HnMSsNCx2MZxpNa8iEUloLOfqr
 /eXDlvSNhNzs74N1flCKmKOWhhBfnOe4RE02xRnJSpErF5RRbmkUViSyYv4UR2PrF+Oi
 R3kdcLRC/Vv8BIbGUr5rAmwuG5qHpwybfiQh0yv8qWgi7O5Gdix0cFqr1en3ZGy1qjMf
 Hx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487615; x=1780092415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SMNTC+jZ0BqAim5qTslVzFy+EOrMkH7DmeCmY2/hdaI=;
 b=Jrbm3xIwsUL2g15XWfEkqzgXjI60qEhub8EwxNZNIdvoKvLkCLkIOdVHa3LMCRRPO2
 70YDwCKPS+EPu5MOO5Ipcyy5NCV8b1B7OSltq2LjchkAPf7fSsU8s/mWf+QS3Ou7jon7
 dUFQ7MSFWAd9lPI3JwJy9wAOSXiiMwhqn9T1yiLZ+r7dEEoK6ro1SF6jmsYdQkpSvzdn
 X5cW9R1FiUPlGhlDUq1X5jb3fGgcEblTBza+UfdxzPl0rcS/8HqwmDQvfGqsLYTNprul
 ngWHjIgcwzeGqVwc+E62bHCsdbWoERZcM5YxwxQrabYzOY1Ke6dtBQa4CfadJG/vXGvY
 /HPA==
X-Gm-Message-State: AOJu0YwyjXeiPmJIAKbvSaSyIL89sjrlVGyJYRp/K16bG9beeKmcqWQA
 gJdz91T5+WgHQfvv/EHR5+cVvIasO9q+P14FptJ4XiNpGYDt/g9ZosTy3ytoxkkEvfThIOAHgMg
 rxOeN
X-Gm-Gg: Acq92OG3Q5h0m/x6nV1jXpQ2M60XhKoV1NuSkDFDcwzRG+fOIK4SSJa/E7TkBrHBLCz
 FjzAzQ6uVUJNUM8ioGKyrbyNm0+fw3ikd+Cu9XbMKrpmcss6esVd8bgDde5DLl27HkHyBTdJgDL
 +9R60lLg4XmZSul+KjFii/Wm3LAoYjcAvKSWo0asLXteSCKAggAUfaQXD98XHLo/PfEO3VH0yyQ
 qY+K99W3BPgi7zJWZ705aggvhLRyYfKQcmT2TyZh9ctXPwyranM7rsQFOXoO/M07egy4dE0UvAR
 8LnLWTbH52+tEXugez9ATdJOUjQ9f10KTdi4vtnAG/GurjLdU0LyjgVmkmodJ9+TBuUXpNHhVbA
 YkP3YkiwONGzMLID4jlFiSDjnKuhfHFWBw7/+1gPmwUBF/azJGSimmNT+07Li2+ExbpgZ0Ad65H
 AZf85TmwEzzyL2Hdf2eHCkOePM5n/sIL+bpObqi3M=
X-Received: by 2002:a17:902:d489:b0:2ba:6ca2:bca with SMTP id
 d9443c01a7336-2beb0680e99mr58165305ad.26.1779487614626; 
 Fri, 22 May 2026 15:06:54 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56b7920sm27835745ad.21.2026.05.22.15.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:06:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 49/64] target/arm: Implement FMLALB,
 FMLALT (FP8 to FP16) for SVE
Date: Fri, 22 May 2026 15:02:51 -0700
Message-ID: <20260522220306.235200-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/translate-sve.c | 33 +++++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  7 +++++++
 3 files changed, 45 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index ee20d74164..c0b646415c 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1545,6 +1545,11 @@ static inline bool isar_feature_aa64_sve_b16b16(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, B16B16);
 }
 
+static inline bool isar_feature_aa64_ssve_f8fma(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SF8FMA);
+}
+
 static inline bool isar_feature_aa64_sme_b16b16(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, B16B16);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 2ee5a36c5a..dc2484847e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8354,3 +8354,36 @@ static bool trans_LUTI4_2h(DisasContext *s, arg_LUTI4_2h *a)
     }
     return true;
 }
+
+static bool do_fmla_fp8(DisasContext *s, arg_rxx *a, gen_helper_gvec_3_ptr *fn)
+{
+    bool fp8fma = dc_isar_feature(aa64_f8fma, s);
+    bool ssve_fp8fma = dc_isar_feature(aa64_ssve_f8fma, s);
+    bool ok = false;
+
+    /* Feature detection and enabling are complex here. */
+    if (!(ssve_fp8fma || (fp8fma && dc_isar_feature(aa64_sve2, s)))) {
+        return false;
+    }
+    if (fpmr_access_check(s)) {
+        if (fp8fma) {
+            s->is_nonstreaming = !ssve_fp8fma;
+            ok = sve_access_check(s);
+        } else {
+            ok = sme_sm_enabled_check(s);
+        }
+    }
+
+    if (ok) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, vsz, vsz,
+                           a->idxn | (a->idxm << 2), fn);
+    }
+    return true;
+}
+
+TRANS(FMLAL_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_hb)
+TRANS(FMLAL_idx_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index e2106fc7f5..71ec09393c 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -29,6 +29,7 @@
 %imm9_16_10     16:s6 10:3
 %size_23        23:2
 %dtype_23_13    23:2 13:2
+%index4_19_10   19:2 10:2
 %index3_22_19   22:1 19:2
 %index3_22_17   22:1 17:2
 %index3_22_12   22:2 12:1
@@ -73,6 +74,7 @@
 &rri            rd rn imm
 &rr_dbm         rd rn dbm
 &rrri           rd rn rm imm
+&rxx            rd rn rm idxn idxm
 &rri_esz        rd rn imm esz
 &rrri_esz       rd rn rm imm esz
 &rrr_esz        rd rn rm esz
@@ -1864,6 +1866,8 @@ BFMLALT_zzzw    01100100 11 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_ex esz=2
 BFMLSLB_zzzw    01100100 11 1 ..... 10 1 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFMLSLT_zzzw    01100100 11 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
+FMLAL_hb        01100100 10 1 rm:5 100 idxn:1 10 rn:5 rd:5 &rxx idxm=0
+
 ### SVE2 floating-point dot-product
 FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
@@ -1880,6 +1884,9 @@ BFMLALT_zzxw    01100100 11 1 ..... 0100.1 ..... .....     @rrxr_3a esz=2
 BFMLSLB_zzxw    01100100 11 1 ..... 0110.0 ..... .....     @rrxr_3a esz=2
 BFMLSLT_zzxw    01100100 11 1 ..... 0110.1 ..... .....     @rrxr_3a esz=2
 
+FMLAL_idx_hb    01100100 idxn:1 01 .. rm:3 0101 .. rn:5 rd:5 \
+                &rxx idxm=%index4_19_10
+
 ### SVE2 floating-point dot-product (indexed)
 
 FDOT_zzxz       01100100 00 1 ..... 010000 ..... .....     @rrxr_2 esz=2
-- 
2.43.0


