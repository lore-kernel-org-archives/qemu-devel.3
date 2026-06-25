Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887A8CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 01:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcZGC-0004ps-SP; Wed, 24 Jun 2026 21:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcZGB-0004od-2g
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:52:07 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcZG9-0008Rk-DA
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:52:06 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2c0b9328c4aso9621455ad.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 18:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782352324; x=1782957124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uhQjgUZ4wEXX+w1LARBO37AImF6ObWFM7kPnocwBdvc=;
 b=rqklORS22tDupVfuHOIqGtpsUUd5rqI4TYUHMYG2EFr6g1qNFaqBQGoEpuQNoxE6Xq
 GI5HEHHzD+Xu28lNxsRkWroIBsGPFjgX6co+JV0jeFcJtqkRgJGMOVtUWB255tz4OCSp
 6KraC092sxYdD96M2+7qE4w8Nk+zssLLghg+1qqCgqTPfK1oNt7rkEVHkgZWAwTdJZ5J
 RFMTRsFIFFoqlfyB4bd1LaVYmwKD7hFPzvEuZVEkw6oHcZD1s9Wdv+F/dltzV6AGk21Y
 vAZB0WeXJLOdkoRrcL/S+3k/Cl6ZY9KNJCsIYutHA7TxL45nsGQwrJs3O37F89uLAv1U
 JIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782352324; x=1782957124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uhQjgUZ4wEXX+w1LARBO37AImF6ObWFM7kPnocwBdvc=;
 b=GTKxgqws4VGwosSUHVtrTyG7pkUbaqIM6mQi2RCeuKbKqBxR5CdmTjlfzLORfRG3iX
 aDa0YJZqwt5JJhaOSp8PCSCZLsi18aNS25dFJRQDzvCMlp8XeS+09Sfpv8GCS0GY94kn
 MKSJ2DoZN0MlqTaXXGTT4BBCYjELBDE4yPvkHuNO5cuf5TY6mr4Uj0bj8gMcerAoercw
 CVEWA5lZfSKXV4IJw5wqnX+Ne8vqp7GKfpWtKzdZCqtl4CntiERpSca119Lj65vA+Hd1
 HfrEsfF/s4NWJL4+MqJlcydpRmagdhJTQcFrkugirrVCkkhVRMV7uOM0hif5G6RpflI6
 U32A==
X-Gm-Message-State: AOJu0YzAvKpWAzgG1dBsqjssjBukaFYBbuAwr4vCgrrduX0aJhpPyWyv
 Mibblmc3omexbKCXAc3sE0+iAtW2KeGD3Q6Al+oc5Y/xi7hFXmOy+J8cScksaVAADIy52Wfs3hA
 phO2G
X-Gm-Gg: AfdE7ckmCMaklWs/J4+CQ96ciW4+OOgoaFi/Jm3BYx2qaE1bWzR6KgdhsXvhZ+jniah
 CHBY5ubKRgUkA3dqZmKZ22ZAMC7p973Kx/g2R/oAR0hSBwABtYpC+PDc4pvxnHFdJ08pRwXymLe
 AZlKjfL0dAMXcriItKd4W/30tB7T0StHAWx0wkeXXrweL2EtZIM5pspcrGnqaq2GhjSiVPxWJZQ
 luC8tY58DiZLIZ5dHesQMCsSV7GZhjbSWNL5dFwoZ3FQyaHm+ivvWdbxXoKXNR/kRBOErxbpMoH
 zKBnyoXH/v/dMeQuPoUVFaI9LNRXSYfvsY+sAwYXA1YMX/mPH4M7vg/jWes3ny+uwqTHCl/h9ZY
 QWiZXv6z/ZsLgC0Cjyl6sh6sSU3F42ma/frbOFr4C6f69ycyynRJJF2Dyl3f8ayEBwzmLtUqXhF
 umzXZpuyaHvIzI+VBs9GzPtdQ7ZXl6r86Tq3m1y2K3J/GmGZAI7Q==
X-Received: by 2002:a17:902:e744:b0:2c7:9b17:6676 with SMTP id
 d9443c01a7336-2c7fc75a664mr7204515ad.23.1782352323612; 
 Wed, 24 Jun 2026 18:52:03 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f5ac8908sm9060635ad.8.2026.06.24.18.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 18:52:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 04/10] target/arm: Implement FMLAL (multiple and indexed,
 FP8 to FP16)
Date: Wed, 24 Jun 2026 18:51:52 -0700
Message-ID: <20260625015159.719300-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625015159.719300-1-richard.henderson@linaro.org>
References: <20260625015159.719300-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 target/arm/tcg/translate-sme.c |  4 ++++
 target/arm/tcg/sme.decode      | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 7cb7b71e74..98f6eb0b70 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1140,6 +1140,10 @@ static bool do_fmlal_nx(DisasContext *s, arg_azx_n *a, bool sub)
 TRANS_FEAT(FMLAL_nx_sh, aa64_sme2, do_fmlal_nx, a, false)
 TRANS_FEAT(FMLSL_nx_sh, aa64_sme2, do_fmlal_nx, a, true)
 
+TRANS_FEAT(FMLAL_nx_hb, aa64_sme_f8f16, do_azz_acc_fp8,
+           a->n, 2, a->rv, a->off, a->zn, a->zm,
+           a->idx << 2, 0, false, gen_helper_gvec_fmla_idx_hb)
+
 static bool do_bfmlal(DisasContext *s, arg_azz_n *a, bool sub, bool multi)
 {
     return do_azz_acc_fp(s, a->n, 2, a->rv, a->off, a->zn, a->zm,
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index b735f3de82..c6e22c4999 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -791,6 +791,19 @@ FMLALL_nx_b     11000001 0001 .... 1 .. 0.. ...10 00.. .    @azx_4x1_i4_o1
 FDOT_nx_b       11000001 0101 .... 0 .. 0.. ....1 11 ...    @azx_2x1_i2_o3
 FDOT_nx_b       11000001 0101 .... 1 .. 0.. ...00 01 ...    @azx_4x1_i2_o3
 
+%idx4_15_10_3   15:1 10:2 3:1
+%idx4_10_2      10:2 2:2
+@azx_1x1_i4_o3x2 ........ .... zm:4 . .. . .. zn:5 .. ...    \
+                 &azx_n n=1 rv=%mova_rv off=%off3_x2 idx=%idx4_15_10_3
+@azx_2x2_i4_o3x2 ........ .... zm:4 . .. . .. .... .. .. ..  \
+                 &azx_n n=2 rv=%mova_rv zn=%zn_ax2 off=%off2_x2 idx=%idx4_10_2
+@azx_4x4_i4_o3x2 ........ .... zm:4 . .. . .. ... ... .. ..  \
+                 &azx_n n=4 rv=%mova_rv zn=%zn_ax4 off=%off2_x2 idx=%idx4_10_2
+
+FMLAL_nx_hb     11000001 1100 .... . .. 0.. ..... 0. ...    @azx_1x1_i4_o3x2
+FMLAL_nx_hb     11000001 1001 .... 0 .. 1.. ....1 1.. ..    @azx_2x2_i4_o3x2
+FMLAL_nx_hb     11000001 1001 .... 1 .. 1.. ...01 0.. ..    @azx_4x4_i4_o3x2
+
 %idx2_10_3      10:1 3:1
 @azx_4x2_i2_o3  ........ .... zm:4 . .. ... .... ... off:3 \
                 &azx_n n=4 rv=%mova_rv zn=%zn_ax2 idx=%idx2_10_3
-- 
2.43.0


