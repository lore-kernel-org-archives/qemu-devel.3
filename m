Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D57C83F0B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEg-000134-RY; Fri, 04 Jul 2025 12:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEb-0000mh-6N
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:57 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEZ-0006Ok-Hs
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:56 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a525eee2e3so690668f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646354; x=1752251154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BGvcMzw2YbNb+RRs5hQKU9iqoYKiVi3qTy/vHNGYSOo=;
 b=ggDc4wjdwz7lSRXRyf6aO20DziiQgjjHpZn+MRk+YzOlAgsvwXfN83bOs2FdshdNlr
 upQb5SAeY+yHH3If7COaavTEntQBYw/RP6BWikP6ZtwuXyhDf0YlzBZ0XAoKoWKymy7p
 Y98zvDlmb7gioVZ2/dzcn3kGNHKnaFyEWIn105KzHq4ixEPrbDPPrFIeJ4vmZKtdTdAI
 P1+txm2Jf08R9DMGk0gVGdsMlKSofJY7k2sY5nIR9Sfm1mOR9NToecJJ+Xsw16/Evy8p
 Fh0M2GbcLJTI2RdOqhI1W2gmaVca24JuMio1cA8OuY9HKOchb4rqczNk+0Yzib7ujdBf
 EUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646354; x=1752251154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BGvcMzw2YbNb+RRs5hQKU9iqoYKiVi3qTy/vHNGYSOo=;
 b=SBenJaz97fae1oi4Nrl9MnV3biddwLNNlqE8Tm9tRtMY3s42Zw/FZVbrAFcDErPpGl
 p1zggGyz0+x4cqGV/D0iHUcBRUGfHKWRQCAIM9AXEYcHumW6iYZ3syutoH35jXPBnj/E
 6L31i/qlLag5QHNJqCzamct33p7Mtr/gBfwY9AZziqLIyBftkiSDNIFPSnmFX/GxXxJ7
 SmT+xnqYNSY1GvNFIZvmWDMPkZkMCBeXDQSS2zFCgyVYhFMTTbBti9iOvq4ZpcrJlObh
 fBEVvy+3aajBRZZeos1IX8Cq4+n6pQFy4dHkR/P56xla2eJpfVOSd13FAewrGWJpV8u0
 28sQ==
X-Gm-Message-State: AOJu0YyU/HKch41ifHM6EqIkmfPTNPNI7khuKix9q6AHpitBPXbFH4Xn
 4FMRRSk+PKQdKENg1uERnKrFDiebYL5tUrQcKDYqoMISCVrQR/1Y35FcjbpOblE2nXlwRtK1vFJ
 ZBWr+
X-Gm-Gg: ASbGncucVyWZRH5PvXznjbokbbwCFFju/jbVO+fIy3bGewishJn1NN05PmO4UArt0Y0
 2UrzPyRod0wtgIR7PaGd4vZSkoKARL5J9gGkB37PKy6/BScLmmgfn/BGBwcqy8+llt3cUGljBUZ
 24uvaLEJScpEgrEoAPMw28/exmk6eFgX5HMS2RBsiKWgiHubLsNLnM0zmWJUZyzIPDAr0W0jmf4
 Yex8L2xsVynlJkkOZr21TVbB0mdtpuhnppAOkktOR97dEW5zZ2ua3fozBp3HWnrODE+dPT6htcY
 5Fie5MKPvSHrn0vbBZjtyJpt83oQSdBl3WmDYfO18+YBphgn/e0s4/tyUycNHVld1zng
X-Google-Smtp-Source: AGHT+IHqo9LmruOvPVe+kg4ssB7D8ZvFpJW58+fUYzHC/BVgItOM8Iq6mqXwNdcoR/ZLuUjgAH1R5Q==
X-Received: by 2002:a05:6000:2509:b0:3a4:e665:ca5 with SMTP id
 ffacd0b85a97d-3b4964c5f00mr2724873f8f.23.1751646354216; 
 Fri, 04 Jul 2025 09:25:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 055/119] target/arm: Tighten USDOT (vectors) decode
Date: Fri,  4 Jul 2025 17:23:55 +0100
Message-ID: <20250704162501.249138-56-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

Rename to USDOT_zzzz_4s and force size=2 during decode.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-44-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      | 2 +-
 target/arm/tcg/translate-sve.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 51847ea56ee..401c0258527 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1599,7 +1599,7 @@ SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
 
 ## SVE mixed sign dot product
 
-USDOT_zzzz      01000100 .. 0 ..... 011 110 ..... .....  @rda_rn_rm
+USDOT_zzzz_4s   01000100 10 0 ..... 011 110 ..... .....  @rda_rn_rm_ex esz=2
 
 ### SVE2 floating point matrix multiply accumulate
 BFMMLA          01100100 01 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=1
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 56353b3bb4d..c82a0f771db 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7151,8 +7151,8 @@ static gen_helper_gvec_4 * const sqrdcmlah_fns[] = {
 TRANS_FEAT(SQRDCMLAH_zzzz, aa64_sve2, gen_gvec_ool_zzzz,
            sqrdcmlah_fns[a->esz], a->rd, a->rn, a->rm, a->ra, a->rot)
 
-TRANS_FEAT(USDOT_zzzz, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
-           a->esz == 2 ? gen_helper_gvec_usdot_4b : NULL, a, 0)
+TRANS_FEAT(USDOT_zzzz_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
+           gen_helper_gvec_usdot_4b, a, 0)
 
 TRANS_FEAT_NONSTREAMING(AESMC, aa64_sve2_aes, gen_gvec_ool_zz,
                         gen_helper_crypto_aesmc, a->rd, a->rd, 0)
-- 
2.43.0


