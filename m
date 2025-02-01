Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F90C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGYM-0006b8-65; Sat, 01 Feb 2025 11:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYK-0006Za-JP
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:04 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYI-0001DS-Tv
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:04 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43618283d48so22477795e9.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428061; x=1739032861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vFohraiwXEBOdts8mKG4T4078t7+REeqcOBZpOMeFtQ=;
 b=IAZWP2bT4pGShjWiiFuoGa4WDAvVq8Ptr/ABH2ki6O9aNPgjiHNgPM/be/QGUZoYc6
 mDiOl5HMIhIpYoniAvKGPxk5+WomQ4Mfcn5ISJHa6IFzBUlb8z1yW3atoa/MDQ3kiPX+
 Mpqh1TxtYtUhR02nNBUyZEkkUFX0xsZJ2mxMRx9S5DQHL+zkuUYmPMFL8/rumaLeG3st
 nyABERq5smxWzpc93eo1mtLakayjad9vdMGJg1AXdlPobQjeWNC2KY5J+2k+SZST1zlq
 qXzH8i7KB96bBoeme5tqG+qY1A7xZggNHEVbSOXCnpq971dF83MdQNm+LdxSUoOzH1BW
 QLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428061; x=1739032861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vFohraiwXEBOdts8mKG4T4078t7+REeqcOBZpOMeFtQ=;
 b=d/7/CmcXrlD6UM46mFth4RPLR/T3Bgslu1qJzjYg63SYrZ+1sW9dGVX6p2Z3ikGq0v
 huOxdQiUeORzF6bdH4roTpLjBRL3u/ciUf9EDWyNr8blctLEvVDAr7+gj2Oyn6FCmtRM
 ZaUrwrPoO94gD4OeaHI7AX89lFAP63AndVInC1mgrhKcLq1CtIapbyamGoiGuQ8RjDjf
 cOptbnp/yD77q2DgWsfl9p6qHnhLBY14HLmSMRwc26DM+oJ2FELR13KXQye+E1rSS4lf
 g7F3A1oVRDgZVaGi8XH9Y7+tQHTrvFsixo3mOmc5ncdc0XefulZyLRoKDDqnOP164rbx
 dNfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURFOfCzfP2qBuJCKMANHpNTUapbyDOI8dVyRFAVU+S3yHoOGOQOWF32B3dQ8P4gSe+s4Xct4WH7Ezm@nongnu.org
X-Gm-Message-State: AOJu0YwLXaq3L/l4MyvZq4r4F4tHOBC3cgReV0P+VSoz+NyTiFhSyDG5
 yGQPrzFLofw06X+5xVaDuA0HUAvsjJNcdXPt+Wpl5bn3AasFjfsJMuUG+VJCDDElzXobu6Rt9/2
 3
X-Gm-Gg: ASbGncsVD+918a1rCNZfgUgWC3wBa2gIT29fpEgpj87JOoHEvePv2TdGUqknYSM2xZ6
 Ps3S9u19cM9XE5k8f4Sp+PsQyySSvy/qwaEHiQrB9NPhWskHMnmSZ3Z/ziqkTJ4fa2st4MYQ1a8
 Rng+8mLNrwHs9bdQjsgkcOCzuR16UNF1FSJZ4U4P3d7RJt33HvGFktcyjklIMgjt+ybw9w8iTQ9
 F35Wv6/E9dF2KDo8o/tTR+F6DMIHs+jBzA0NZnh6kXI18+ddDTKg0twIx89i3lBD2CsVSTs1Dan
 CEBhWUHZkqD42/0AmMGT
X-Google-Smtp-Source: AGHT+IHjy2Ql0iuL5NHHCIkV1Yzqa0tev+3EsD6R64FronkXGFv/6bqOIjVM2XimdmpWZNsWX8SYrw==
X-Received: by 2002:a5d:4aca:0:b0:38c:3fd1:6162 with SMTP id
 ffacd0b85a97d-38c520af863mr9999142f8f.50.1738428061438; 
 Sat, 01 Feb 2025 08:41:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 34/69] target/arm: Handle FPCR.AH in SVE FNEG
Date: Sat,  1 Feb 2025 16:39:37 +0000
Message-Id: <20250201164012.1660228-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Make SVE FNEG honour the FPCR.AH "don't negate the sign of a NaN"
semantics.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 4 ++++
 target/arm/tcg/sve_helper.c    | 8 ++++++++
 target/arm/tcg/translate-sve.c | 7 ++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 918f2e61b7e..867a6d96e04 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -545,6 +545,10 @@ DEF_HELPER_FLAGS_4(sve_fneg_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_fneg_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_fneg_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve_ah_fneg_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_ah_fneg_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_ah_fneg_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sve_not_zpz_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_not_zpz_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_not_zpz_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index a688b98d284..976f3be44e0 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -885,6 +885,14 @@ DO_ZPZ(sve_fneg_h, uint16_t, H1_2, DO_FNEG)
 DO_ZPZ(sve_fneg_s, uint32_t, H1_4, DO_FNEG)
 DO_ZPZ_D(sve_fneg_d, uint64_t, DO_FNEG)
 
+#define DO_AH_FNEG_H(N) (float16_is_any_nan(N) ? (N) : DO_FNEG(N))
+#define DO_AH_FNEG_S(N) (float32_is_any_nan(N) ? (N) : DO_FNEG(N))
+#define DO_AH_FNEG_D(N) (float64_is_any_nan(N) ? (N) : DO_FNEG(N))
+
+DO_ZPZ(sve_ah_fneg_h, uint16_t, H1_2, DO_AH_FNEG_H)
+DO_ZPZ(sve_ah_fneg_s, uint32_t, H1_4, DO_AH_FNEG_S)
+DO_ZPZ_D(sve_ah_fneg_d, uint64_t, DO_AH_FNEG_D)
+
 #define DO_NOT(N)    (~N)
 
 DO_ZPZ(sve_not_zpz_b, uint8_t, H1, DO_NOT)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 2813e5f4871..4d5de2004f0 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -789,7 +789,12 @@ static gen_helper_gvec_3 * const fneg_fns[4] = {
     NULL,                  gen_helper_sve_fneg_h,
     gen_helper_sve_fneg_s, gen_helper_sve_fneg_d,
 };
-TRANS_FEAT(FNEG, aa64_sve, gen_gvec_ool_arg_zpz, fneg_fns[a->esz], a, 0)
+static gen_helper_gvec_3 * const fneg_ah_fns[4] = {
+    NULL,                  gen_helper_sve_ah_fneg_h,
+    gen_helper_sve_ah_fneg_s, gen_helper_sve_ah_fneg_d,
+};
+TRANS_FEAT(FNEG, aa64_sve, gen_gvec_ool_arg_zpz,
+           s->fpcr_ah ? fneg_ah_fns[a->esz] : fneg_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const sxtb_fns[4] = {
     NULL,                  gen_helper_sve_sxtb_h,
-- 
2.34.1


