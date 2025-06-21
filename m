Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D99C7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT82W-0002do-39; Sat, 21 Jun 2025 19:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82K-00025n-Q6
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:17 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82I-00051F-AG
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:16 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7490cb9a892so1131405b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550053; x=1751154853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Croxoi24OBzjfvFxMgTgJ8IA4W9SbfzKMH+Zp+glJxA=;
 b=RqBDgG6wqLZK9ekYP0u4m1417fR/vHcP+qwz0QRSi0mthuut7dUlitb4xc5YQyKmGJ
 JCN1tkfc5/od41vi/A3LfXcysDw4vpMKdONV/7PxFI4eFGufA1aLcWIRu2Ub7W1ss53k
 Km4RI2qBNb8j5WThF74a9/OIkF2tPIAPlweULhqtTKyTaC9PzSzMGBu9TQMelWaGHbQU
 3081+rN1iPA2XsuT495B7570kp/gS8OGpr5/HegExS+HaTxipcTFsFGds7jCnT1cCqB7
 GeC39ZI+eeb/0nH/mS0GJ9ALQbYKGvDiMO4Dy/1VAxsAWMOEgvDZoQzW0F9ohDtyKUAW
 Acgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550053; x=1751154853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Croxoi24OBzjfvFxMgTgJ8IA4W9SbfzKMH+Zp+glJxA=;
 b=TCVKy9BjiqlrKZ2ztjUBdwtF5Xy79Tc/aUoVhhYz9byO4+gP/sc7WeKdlekPACTCz5
 F+M9P+PclaHJL0UPIiSx//Awd1R+d7tKrAx0N/VFETBVLtCxvAR65iY7ygv3bCF2XUhL
 lh9R/MHaKwbkUjp9cJZ8kRXDx0QchFMlk1vCf9xrwb6ZG4t3s/BV4XBnteeuPFpQl8fb
 BZx1/7v9dL/pIxPc51yi8Lz2gfBpkIEF/7iI5TyIrWVz2LhYhNPnlo98FOIhvmBF1moT
 8ItDOtfHy4tsE3cV19pc+z0O5dDqf2MnYDmgoF+99KfmDcjK2S5wbuDJfSrLI4fZD4m5
 63/w==
X-Gm-Message-State: AOJu0YzeoqL61Inr+wJUHfYgxoRHToal6LKPw45FNQFgudDELF7Ltz/o
 2oOgD2wk9jAd43roJxuW60zZWKfkjbugcwoUpykm9llR92FO1Wh+D6+HY3x2U031U2DD+YLXKGt
 He4mZVDw=
X-Gm-Gg: ASbGncvibF43S8W4hOXNsbFL7ejP2J4R0dOpRwrbB2khUpsrMuBmWunuPP0cSEbGcy7
 3/ocFyztMVc0/TMCEEIgE4/jd0JBqRCWqqCX6pJkKHke4PJx295uZ3ungH+CLco1bA94jWBR9Vx
 HhulJu9E5lbyorn97RLdnn9yLz993I/P5Ytw8zQ5Mv3dKPO5VSfHLnJOYOJ1A/rcgqlMSyEnzsy
 0IFq6TK6DN+srR48t5HKE1tcmJeEZm8KXcpFoyiK6+jhrXfzIf3/KgDQo4qDe+c3fclezBVvVTN
 j32/6LKhcbPVhHkBFOls1FXFewyJrCFIfq1nAbtwYdBKag6HHwZVkkYYaRatP+X57YcMf9fK+IE
 no2p+W38EZ78bP59SSFen
X-Google-Smtp-Source: AGHT+IFSaQFKLXroVkmusRaTnetEq1Yfl3IoA2Nxq1nXioP14Q7LxkxfHtDOoSgpGrOmeYnWzP1ApQ==
X-Received: by 2002:a05:6a00:14cf:b0:749:540:ca72 with SMTP id
 d2e1a72fcca58-7490daedb0fmr12551669b3a.24.1750550052945; 
 Sat, 21 Jun 2025 16:54:12 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 053/101] target/arm: Implement SME2 FCVTZS, FCVTZU
Date: Sat, 21 Jun 2025 16:49:49 -0700
Message-ID: <20250621235037.74091-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 5 +++++
 target/arm/tcg/sme.decode      | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 60ce5b518f..e5694a398d 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1293,3 +1293,8 @@ TRANS_FEAT(FCVT_w, aa64_sme2_f16f16, do_zz_fpst, a, 0,
            FPST_A64_F16, gen_helper_sme2_fcvt_w)
 TRANS_FEAT(FCVTL, aa64_sme2_f16f16, do_zz_fpst, a, 0,
            FPST_A64_F16, gen_helper_sme2_fcvtl)
+
+TRANS_FEAT(FCVTZS, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_gvec_vcvt_rz_fs)
+TRANS_FEAT(FCVTZU, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_gvec_vcvt_rz_fu)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 644794bdc1..bb985f6f61 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -727,6 +727,10 @@ FMLS_nx_d       11000001 1101 .... 1 .. 00. ...00 10 ...    @azx_4x1_i1_o3
                 &zz_n n=1 zn=%zn_ax2
 @zz_2x1         ........ ... ..... ...... zn:5  .....       \
                 &zz_n n=1 zd=%zd_ax2
+@zz_2x2         ........ ... ..... ...... .... . .....      \
+                &zz_n n=2 zd=%zd_ax2 zn=%zn_ax2
+@zz_4x4         ........ ... ..... ...... .... . .....      \
+                &zz_n n=4 zd=%zd_ax4 zn=%zn_ax4
 
 BFCVT           11000001 011 00000 111000 ....0 .....       @zz_1x2
 BFCVTN          11000001 011 00000 111000 ....1 .....       @zz_1x2
@@ -736,3 +740,8 @@ FCVTN           11000001 001 00000 111000 ....1 .....       @zz_1x2
 
 FCVT_w          11000001 101 00000 111000 ..... ....0       @zz_2x1
 FCVTL           11000001 101 00000 111000 ..... ....1       @zz_2x1
+
+FCVTZS          11000001 001 00001 111000 ....0 ....0       @zz_2x2
+FCVTZS          11000001 001 10001 111000 ...00 ...00       @zz_4x4
+FCVTZU          11000001 001 00001 111000 ....1 ....0       @zz_2x2
+FCVTZU          11000001 001 10001 111000 ...01 ...00       @zz_4x4
-- 
2.43.0


