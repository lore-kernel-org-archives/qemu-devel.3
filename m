Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A48ACD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYV-0002iX-Nl; Wed, 10 Jun 2026 12:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYS-0002a4-2r
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:24 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYQ-0006D9-CN
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:23 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso3865733f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781108001; x=1781712801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mHuUwIa66SwAKYo8Ttl90Ny8vI4sUhjV8wDyLb1A2os=;
 b=qVpBUlsIf3F2aCcPYvyNpkrepoUZkHaTpjD5tqmdTG24bYgYVV3+X1ryIfLK/e4mnU
 DmXkzbEtbCAD30StnqRVKFmQo8rjarr5X0PHN039OkNMEiqCp7AaMshBKt0tE1fuc1W9
 zepYbHSH3vzMAAamSM1puczrq0/Xod7xxTjnhYv6tBPmvebFbIJlqCLuKGK3oJM6OjGM
 4r9asAm/jOuAT62Jp1zXzwhfpoFLh9Gn7H9YVoFMFewzGilqKOf1Qkz9/8BfVbNSChL5
 05bHL4a6IG14/N3eaHXogF0dAPB6D7cmPZ8LuwdIRUNAgyqh5Gti7lEnqzWjBulVtGjS
 bbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781108001; x=1781712801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mHuUwIa66SwAKYo8Ttl90Ny8vI4sUhjV8wDyLb1A2os=;
 b=g8Sfi5LwnzOx2dONztn7nsytrj8nsAAj66psrBNOKvzgFcli70YocUARfwPFVZJ0L/
 x8gVblHu2uznMpBEzun1zFEA2cfS1lYKypHoauzeymwFEFJMasSkHS8QDESMyEtpdb+d
 nrZiS4FaCux3kWvYUM5QqMOR8RlJMPUc6BEpYo0ixNaFRyONXdSXeea4ofQFjFEl3dq7
 gqcg9/J+2EM1MHiwWHi/hZdxn7FpTEPYY2JL5DWXwUWw92PaO3OIxJtRAv5clKH3sjw8
 bcuKjm1Q0u61+GGrv0tX72dgNdvWmws3t4ShN+3G9i72zWK2E05qDQ3sAWXfWsjLm/Za
 TVGg==
X-Gm-Message-State: AOJu0YxTow32vCmgt5BUiPHzIcKZ7HzgJXI22lWR2CYM+RGtPLzoCUZc
 6gkOEAN2sCHQHjxQm2dfTQJX1f3MUt1zIfosOjYcZoQBSY70bpvsDj6BLPkWhKgU1f3iocYN2CX
 Dpo/j
X-Gm-Gg: Acq92OErqtYjAoO4Yy0FWQY6mtaGItqfq1eT1ElJ06BOnGrGbdf/eLzbFE7oeEFnp3d
 W9rubpG4a/20nyyVnqvLXffSNX3rPJtlYjs2Bc7xl0pixdi8nhaOdB2nx7xTlHnezcarOSj5sJF
 J4QBdhyG9SQFMpx8lqD2ZscJ3/AG4SQHFthpzXPdgiOZOzrVUEUmOUXEpiLjhtALz1Er+KA31B8
 B+KWBp82D2BjBuwaV203mhhZ5mYV2ExASnJEbMnFGL0N/omOUMJd7sFxFR59lxnYcQ6lohZLdv0
 Al8lCBZLPF5mHCforrTJvW5jj6gJHiBD9wLWwGcwrW8ColgH5LrclTKthQaFjH3DITq6HakBpQJ
 CP5WxL771PDUE7iZs6jQv64XYf7oKr4fa98Uee/MxKs46jwWHgCbee44OIJ+CtG8aqKILtwOLCp
 iCMmZVpUZsANzkDu8w/b2L3j/smqI0ESSxILQesqI71mc+fF8+xsgeg5k4b3vktY7toTGlTDYZy
 FQMlxI/0VlOzLlMPqITwfrHq4KLkcsew3B9ooCoLxw=
X-Received: by 2002:adf:f8ce:0:b0:45e:f25a:9716 with SMTP id
 ffacd0b85a97d-460304fda8emr32904798f8f.18.1781108000995; 
 Wed, 10 Jun 2026 09:13:20 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 56/71] target/arm: Implement FMLALB,
 FMLALT (FP8 to FP16) for SVE
Date: Wed, 10 Jun 2026 17:11:47 +0100
Message-ID: <20260610161202.2235298-57-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-31-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/sve.decode      |  7 +++++++
 target/arm/tcg/translate-sve.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index b905ec1bdc..9af4ab239c 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1570,6 +1570,11 @@ static inline bool isar_feature_aa64_sve_b16b16(const ARMISARegisters *id)
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
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 0e0bc4cbfe..453bae3a0e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8355,3 +8355,36 @@ static bool trans_LUTI4_2h(DisasContext *s, arg_LUTI4_2h *a)
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
-- 
2.43.0


