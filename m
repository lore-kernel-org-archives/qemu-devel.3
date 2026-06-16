Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782D0CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZFM-0006Gw-Q4; Tue, 16 Jun 2026 15:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8W-0004jC-GC
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:51 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8R-0001CE-TY
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:48 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4619990ca5fso1663946f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636859; x=1782241659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5uyUfjoY4WfX9Ygr06+TwtDiXD3NaYulNpaMCXE18co=;
 b=OnXquPiEhbbZqE1TVBXXH6k+xinvK8jtAwBkgSSj2piz0lqT1aZkeIxoR6an2JLTtD
 zx8VAKPjkfavzbuggBsGnWOIiPgKfBPGPeyyb9Ax1ofyCDaswHu5wI6Z/IVKaDFEGrU8
 y3uknT33TPbrxb+BhU37JSjl+1RQWZb3QqqITG9ulIbNdrPreRCFMVE9tAuzO3z0AQmL
 YC2DmiLnwgnOnn0mMEjh6+8CZpcCeUt+9hEMVX9cJ5DvLlroixG/LVU20Yvpx8UBvh6P
 hJCoaF0+Pxl8zjXf1A1BslywvNB+N28X8GUIWZuFBl6QenWHLod3GRDcfw0SnXWydgAT
 dn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636859; x=1782241659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5uyUfjoY4WfX9Ygr06+TwtDiXD3NaYulNpaMCXE18co=;
 b=nultd3/ri3Zn3lKwH56Ps5g0vC9Lyf5Kp9z4Ir7wKQyOZJz5vfTX8b5TsoBDhPX+kD
 HqWx82DroGrWVQXivEd4mK1XY+MaHwNHVCgQdF/saFO9NwN3gGFqRfzf6K0Xru8Q2xi8
 S4X23GRAmrG0lFaJa/Gg3xt9NCyIUIqInmOduqodl9dAc585OBt2sGHYi4gMoWOjMsRD
 H7Ps0p6Ml3KgcWDszcJ034DCCVEOEg1i+diVPEA3YxpUlj8g1nRHZVTuwCgaUQ2z2NQm
 vEWjfRhsYxmAf+J9ze7MuXwSFNSGaL+aVk9GPt/7tg0STmmC44r6ebH/cNsBjnw1yWhu
 b/dg==
X-Gm-Message-State: AOJu0Yygnh4iyYp0Qjzsp/1P2u1gx6Evar+X7PzZrWymyQLbQm7lcq1X
 H/6uxRCKMNAzl5O0u3vj+ye6UJfR2lkKeti86bfKsQApygyL9Mugn5TDNj4WcSqFCmXLReaQEnl
 BjTm5
X-Gm-Gg: Acq92OFDztFa5hBu6vsmc0EsU7GNClLC4zlgz0ln5lfjhFfd+tUR8OfHyNPutzGnEd6
 ACajm8mFdWrqS3NfLqcy1IWYmLo5Yon64IXmGIzDZyyeBoXcrTBaG+j45Qep5D0Hq8e+1OSPfBj
 zUO2cMZJWRrqZvpcGrGNvwJxFDnuUoA+TclhbSQhGIxt0c9NBOwbczc54qRXpxl5ozN+sg+3E98
 0xq76zj+043SuceHCv5fhzlpxdwy5tcoMATCoSqkATkvYFeRiVAkBaS/Re/v6z2CfjH2mFTFkhF
 HXGyK1s5BZz8sFWL34EtOlOrZIPiEY+Rgqo+EG/TWYnPiOScAfq23feXA7mJlezuRxoiHCf7DJp
 4iZ82Zh5Y6WtKen8VFAUuwFwSjaO1grqaSr8cfiTFN8nzYINQszUtncZkMwPfaH9hooVTP4va0e
 SlqvL/wLZOO0B7KTOfqao6faUvPkP/J+izZwfXUXY7+iw9d0l32qwIPGXfOpMbCBNEjGBTvR2kG
 +WJ2zimDr2WZie713hK9fmio/5OcaO0
X-Received: by 2002:adf:ea48:0:b0:45f:f142:d563 with SMTP id
 ffacd0b85a97d-4623646201dmr1105300f8f.16.1781636859080; 
 Tue, 16 Jun 2026 12:07:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 52/61] target/arm: Implement SVE2 integer unary operations
 (predicated, zeroing)
Date: Tue, 16 Jun 2026 20:06:29 +0100
Message-ID: <20260616190639.3462006-53-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

This includes URECPE, URSQRTE, SQABS, SQNEG.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260604234852.573178-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      | 5 +++++
 target/arm/tcg/translate-sve.c | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 45f8633fd3..f1cf7a628d 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1545,6 +1545,11 @@ URSQRTE_m       01000100 .. 000 001 101 ... ..... .....  @rd_pg_rn
 SQABS_m         01000100 .. 001 000 101 ... ..... .....  @rd_pg_rn
 SQNEG_m         01000100 .. 001 001 101 ... ..... .....  @rd_pg_rn
 
+URECPE_z        01000100 .. 000 010 101 ... ..... .....  @rd_pg_rn
+URSQRTE_z       01000100 .. 000 011 101 ... ..... .....  @rd_pg_rn
+SQABS_z         01000100 .. 001 010 101 ... ..... .....  @rd_pg_rn
+SQNEG_z         01000100 .. 001 011 101 ... ..... .....  @rd_pg_rn
+
 ### SVE2 saturating/rounding bitwise shift left (predicated)
 
 SRSHL           01000100 .. 000 010 100 ... ..... .....  @rdn_pg_rm
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 6a29c1e43e..fe78e4dda1 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -6791,21 +6791,27 @@ TRANS_FEAT(UADALP_zpzz, aa64_sme_or_sve2, gen_gvec_ool_arg_zpzz,
 
 TRANS_FEAT(URECPE_m, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz,
            a->esz == 2 ? gen_helper_sve2_urecpe_s : NULL, a, 0)
+TRANS_FEAT(URECPE_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
+           a->esz == 2 ? gen_helper_sve2_urecpe_s : NULL, a, 1)
 
 TRANS_FEAT(URSQRTE_m, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz,
            a->esz == 2 ? gen_helper_sve2_ursqrte_s : NULL, a, 0)
+TRANS_FEAT(URSQRTE_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
+           a->esz == 2 ? gen_helper_sve2_ursqrte_s : NULL, a, 1)
 
 static gen_helper_gvec_3 * const sqabs_fns[4] = {
     gen_helper_sve2_sqabs_b, gen_helper_sve2_sqabs_h,
     gen_helper_sve2_sqabs_s, gen_helper_sve2_sqabs_d,
 };
 TRANS_FEAT(SQABS_m, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz, sqabs_fns[a->esz], a, 0)
+TRANS_FEAT(SQABS_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz, sqabs_fns[a->esz], a, 1)
 
 static gen_helper_gvec_3 * const sqneg_fns[4] = {
     gen_helper_sve2_sqneg_b, gen_helper_sve2_sqneg_h,
     gen_helper_sve2_sqneg_s, gen_helper_sve2_sqneg_d,
 };
 TRANS_FEAT(SQNEG_m, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz, sqneg_fns[a->esz], a, 0)
+TRANS_FEAT(SQNEG_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz, sqneg_fns[a->esz], a, 1)
 
 DO_ZPZZ(SQSHL, aa64_sme_or_sve2, sve2_sqshl)
 DO_ZPZZ(SQRSHL, aa64_sme_or_sve2, sve2_sqrshl)
-- 
2.43.0


