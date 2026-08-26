Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E17C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHdx-00006L-Hl; Wed, 26 Aug 2026 13:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdv-00005M-LX
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:31 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdt-0004nl-I1
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:31 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c9b373d5af0so948519a12.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787766148; x=1788370948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hkosmYx4+JdHDSjtlLYkep2quIxdGFu2Wlih9AWq7P0=;
 b=oVQCDiQHcgr0QJ+C/tZy0/byWB3hzom7wW2quNQ/ncFWfbaie99qwPKi6E+iA/wKFs
 I8imr/hyqlLsAqXpaYbk48jJvu3MAIH+vE3TfWO7OiY4/lEtZ4ZMRLeFcqOWxbJ0iasf
 dPSXQb+eNA8FjeGpoUmMN/C7gL0dLdy2tSlxaZ17GtBIO5+NsviIf68mdaTzsprSZwi6
 CsR4ukMJFHTgeO2FQNbBMo7Kf7wjOUgBMl2mTkJBsOTKgiZP4DzaN4g5sX+z/39KmwlC
 cUYHmKl9EtfDsKV2mo/QTx6EpRE5D1bDgN5JuAs19XjWTTIMfABmzwkqBJIjLRGX8JyX
 wXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766148; x=1788370948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hkosmYx4+JdHDSjtlLYkep2quIxdGFu2Wlih9AWq7P0=;
 b=VR/KiRp2xdWQKYQTCe+IpXGRQCyhrMKQXPRqKeyCUcbImQyeCvEHdg+6ejt/bbyNqU
 YHWC6WlaDV4r2VhvERytB618MpQHjV9d3LFFhVZTpJUkw12p7FmqjBjMQsTi/Ff490wk
 2TTTBdmWghxMo/pUs674WvP6rLoxFJ2Uuaf0GSsKYXv/cqv9tbMCUOHtC50cMxZ/t3ab
 fWXfAe/AZIxZufPjJf8lJNM0nwmJfZER3kIeDtloXSr25YSr6kfa1B/Jm1i985B5PCFv
 JL1FGjYmqSab1pqlCLEfSE6gWBNcKPks8zQvFFuOPJ0sGN53MUeWfTwY6zSlnO85yaGh
 S2HQ==
X-Gm-Message-State: AFuF++kr3+7yunsULdik67nNH+FpT1y9Qm/lgQAIE6u4++i/sDsRBoBR
 sYb7FVn5K1REAekdbhJh6BvZBKej40dilFHJpuuIk6cq3Vy2+adj844/P7Gz+2daF6r2XWrzStH
 vYOSCKVE=
X-Gm-Gg: AR+sD12pbkmJAGNbvjBvUMiDw05Bfzi7z/ooUeX7A1+CADgipfdInxkZDjQlrMqXgJl
 DQ2ob9HIuPqSFEyc9DMvneloSKtAlvTKYQBZrR6WHNXY2G9RC2BRYMPWvOm0Dl6FWnW+N3fZYfD
 Sd6XrhOxM7tGt00uBxcOsijcnobWrYxKtf18RfcKIU03pjY+P0qY978mkXiXal8zrzi39CsxMFJ
 MJeqbkHWPtrX+4C6iXi+jyRaxMvMt9XcDf+2Y4O5m6z0pPyqiPdw74MnVY4+rOBjHXjTz2JGVK0
 PumHYtADrnl/ZSx6VGJNfRRBsEdXNRjvtEupilcl8mav/dkF96qOaCk2a2kaiovcwq0xX5Tobzw
 qNjp27ZS7iWw4rd+r6ObaKE6JsvOJtHbbdczTzmmg1T4l5cES3V5oxX+tQoY5SGW3EpoKrZMBc7
 +WwCLEAvIclKZ+mqDzUNrI5UOdQK1Ast2CV2HfEmlNHTjund97wVd3FSPsGVePopCn9vcGuzOf+
 bYujFLwTJts8pVUiUqMQ1kE/yiulA==
X-Received: by 2002:a05:6a21:2212:b0:3d0:ba81:79b1 with SMTP id
 adf61e73a8af0-3d0ba817b48mr5650967637.0.1787766148082; 
 Wed, 26 Aug 2026 10:42:28 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1bec66020sm1260072a12.21.2026.08.26.10.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:42:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 11/25] target/arm: Implement SVE BFSCALE
Date: Wed, 26 Aug 2026 10:41:58 -0700
Message-ID: <20260826174213.614571-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826174213.614571-1-richard.henderson@linaro.org>
References: <20260826174213.614571-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h        | 5 +++++
 target/arm/tcg/helper-sve-defs.h | 2 ++
 target/arm/tcg/sve_helper.c      | 1 +
 target/arm/tcg/translate-sve.c   | 2 ++
 target/arm/tcg/sve.decode        | 5 ++++-
 5 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index e444397a478..76859c1f745 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1580,6 +1580,11 @@ static inline bool isar_feature_aa64_sve_b16b16(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, B16B16);
 }
 
+static inline bool isar_feature_aa64_sve_bfscale(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64ZFR0, B16B16) >= 2;
+}
+
 static inline bool isar_feature_aa64_ssve_fexpa(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SFEXPA);
diff --git a/target/arm/tcg/helper-sve-defs.h b/target/arm/tcg/helper-sve-defs.h
index 19bd936f6ef..f78e77662de 100644
--- a/target/arm/tcg/helper-sve-defs.h
+++ b/target/arm/tcg/helper-sve-defs.h
@@ -1303,6 +1303,8 @@ DEF_HELPER_FLAGS_6(sve_ah_fabd_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve_ah_fabd_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_6(sve_fscalbn_b16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fscalbn_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fscalbn_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index ac96b18784f..8389dce6299 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4827,6 +4827,7 @@ DO_ZPZZ_FP(sve_ah_fabd_h, uint16_t, H1_2, ah_abd_h)
 DO_ZPZZ_FP(sve_ah_fabd_s, uint32_t, H1_4, ah_abd_s)
 DO_ZPZZ_FP(sve_ah_fabd_d, uint64_t, H1_8, ah_abd_d)
 
+DO_ZPZZ_FP(sve_fscalbn_b16, int16_t, H1_2, bfloat16_scalbn)
 DO_ZPZZ_FP(sve_fscalbn_h, int16_t, H1_2, float16_scalbn)
 DO_ZPZZ_FP(sve_fscalbn_s, int32_t, H1_4, float32_scalbn)
 DO_ZPZZ_FP(sve_fscalbn_d, int64_t, H1_8, scalbn_d)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 0ad0aff0504..37875b6b366 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4515,6 +4515,8 @@ static gen_helper_gvec_4_ptr * const sve_fscalbn_zpzz_fns[4] = {
 };
 TRANS_FEAT(FSCALE, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
            sve_fscalbn_zpzz_fns[a->esz], a)
+TRANS_FEAT(BFSCALE, aa64_sve_bfscale, gen_gvec_fpst_arg_zpzz,
+           gen_helper_sve_fscalbn_b16, a)
 
 static gen_helper_gvec_4_ptr * const sve_fdiv_zpzz_fns[4] = {
     NULL,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 07dac681acf..ed19ae237f4 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1196,7 +1196,10 @@ FSUB_zpzz       01100101 .. 00 0011 100 ... ..... .....    @rdm_pg_rn # FSUBR
   FMIN_zpzz     01100101 .. 00 0111 100 ... ..... .....    @rdn_pg_rm
 }
 FABD            01100101 .. 00 1000 100 ... ..... .....    @rdn_pg_rm
-FSCALE          01100101 .. 00 1001 100 ... ..... .....    @rdn_pg_rm
+{
+  BFSCALE       01100101 00 00 1001 100 ... ..... .....    @rdn_pg_rm_e0
+  FSCALE        01100101 .. 00 1001 100 ... ..... .....    @rdn_pg_rm
+}
 FMULX           01100101 .. 00 1010 100 ... ..... .....    @rdn_pg_rm
 FDIV            01100101 .. 00 1100 100 ... ..... .....    @rdm_pg_rn # FDIVR
 FDIV            01100101 .. 00 1101 100 ... ..... .....    @rdn_pg_rm
-- 
2.53.0


