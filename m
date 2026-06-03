Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6262CD6E6A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcLM-0001h0-46; Tue, 02 Jun 2026 23:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcLK-0001YO-8A
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:32:34 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcLG-0004cn-2U
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:32:33 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2bf36a6905cso27371325ad.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 20:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780457548; x=1781062348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wag/kMq2SOZ4UTghLOZZPUgDGcWCTksKDFfQl0odqRg=;
 b=Ao7hanc8qvVsWfzFlHqBj3P2fUbeINL5wC9GR6EiB1RbWQuEJmHjlrsSG+bnkEP1iI
 MuFimgEQfL6ViMS63w+xZ3Nb1vnJ7qYtN/tccmZqUilBgQizmwjlG9mWHNR81EXdM7aC
 yc4LcUaB2ialka0p8MEsTKiDvtKGupg1QV1B2eE188jYIpwDn1fgc5V3Svpc4svAIcee
 yV+f97RChwQ5H0dpHmYvVMRhVRmQRH6LZWRzGghCGEw/fmvu+t+gVHVTxF6hFlgTuxzb
 Po+Pmie0TCDZBfTvUngIlpL2DwxYA/j72divUYegOFYEoFBKp8y9pfS6XGlzFofSXEKI
 CJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780457548; x=1781062348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wag/kMq2SOZ4UTghLOZZPUgDGcWCTksKDFfQl0odqRg=;
 b=BEIIQxCA2c4inxZNn2FPammxIU2VNpqPrpvyJfYy2xQ9eI7nMHVBZ5yd71N+k2dkYG
 qgmJJisVncZ4BVkfmcG1fMTClcP8nCTQJ0GsVviHL3yH5VB9AhkjFeJpzUdCi2MwCTO8
 bBTSAr4opysSI6IUQBCn1af+68f663TUHdDi3J5UixKlpODiWm/rG3wulhDbBlo9e5Oq
 1YGwmhyDAwcZGnrfVhx8MoAcXMKELwgWfsXPNhRIV7Lmp18nMgwaLW9FYuE/stQaXPp7
 z0wQ8UP4ciyI0nCTdiyuqG+QiwTDnvVNPUUyAdu+QAJ3a1dtFM2wEBuqbAIvUEAV9MLF
 uIqA==
X-Gm-Message-State: AOJu0Ywp7iHV9TPkgUUM+L370jd5+IIqrxiYEIWFxICWOoKnfh7RruT2
 3Sc3TBj7OPk9F0uE18eQhAIpnOMYkTqbhwnNEuRXnNPJNZZJmt6ZBkdud1HPXY6bTG2s81pQYjo
 /mtzTeK0=
X-Gm-Gg: Acq92OGrbLlvrkS5EHS0zTDvlT0LgRju90pYBT3FuJw2mWmyIlTiu6sVu1iLK+RQeQ7
 mvEBH0QGBq3zgucI3MSu/CPzXYVeupRoaDKumGDEgifDazfvBE2R5fYVNrgeWMBV9Wy4+scnbea
 52+DNr8asoXnaQhbQU1AiarfvgkSUN+Orvj8TQ4DVBEjxtEU08H0rtxNOnGHbWZQpio1sHqlOlP
 Z2wiPHMn/Mn9Gz8KKlIr/WYLTtbsOwljeun0OlbUVGEdqGhLcloa0lTnbY6EbR8k9KAWoIYJyJI
 nMY4S/Lx6dpkpDJaZwWprfd0+gDbWqrXesWOAGsCZwqnPKsBPVQHJ0VCqFmtLdvcIuhipCkeT/w
 9TUSJJK3KI8BW0K2RWzLegxeSqu7gupnsbWMHSuL1vsZG9fzUwQ8CdDRlbpo7JtsMmYWjOTj0Ik
 +f8avQf9YDIqbQXBfVRPcMibdCSyiWtZET0nc1Kck=
X-Received: by 2002:a17:902:e746:b0:2bf:2d0:887b with SMTP id
 d9443c01a7336-2c163a30c4cmr16856335ad.9.1780457548456; 
 Tue, 02 Jun 2026 20:32:28 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164fa0236sm7785685ad.33.2026.06.02.20.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:32:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 44/45] target/arm: Implement FMMLA (FP8 to FP16) for SVE
Date: Tue,  2 Jun 2026 20:28:53 -0700
Message-ID: <20260603032855.106930-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603032855.106930-1-richard.henderson@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/cpu-features.h      | 5 +++++
 target/arm/tcg/translate-sve.c | 2 ++
 target/arm/tcg/sve.decode      | 1 +
 3 files changed, 8 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 6d65706186..5a14507682 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1713,6 +1713,11 @@ static inline bool isar_feature_aa64_sve2_f8mm8(const ARMISARegisters *id)
     return isar_feature_aa64_sve2(id) && isar_feature_aa64_f8mm8(id);
 }
 
+static inline bool isar_feature_aa64_sve2_f8mm4(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sve2(id) && isar_feature_aa64_f8mm4(id);
+}
+
 static inline bool
 isar_feature_aa64_sme2_or_sve2_faminmax(const ARMISARegisters *id)
 {
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 1def148f64..9a1bf71577 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8477,3 +8477,5 @@ static bool do_fmmla_fp8(DisasContext *s, arg_rrrr_esz *a,
 
 TRANS_FEAT_NONSTREAMING(FMMLA_sb, aa64_sve2_f8mm8, do_fmmla_fp8, a,
                         gen_helper_gvec_fmmla_sb)
+TRANS_FEAT_NONSTREAMING(FMMLA_hb, aa64_sve2_f8mm4, do_fmmla_fp8, a,
+                        gen_helper_gvec_fmmla_hb)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 6610432528..b53fe6a58f 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1809,6 +1809,7 @@ FMMLA_s         01100100 10 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=2
 FMMLA_d         01100100 11 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=3
 
 FMMLA_sb        01100100 00 1 ..... 111 000 ..... .....  @rda_rn_rm_ex esz=2
+FMMLA_hb        01100100 01 1 ..... 111 000 ..... .....  @rda_rn_rm_ex esz=1
 
 ### SVE2 Memory Gather Load Group
 
-- 
2.43.0


