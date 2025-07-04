Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE8FC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFF-0003EW-Rx; Fri, 04 Jul 2025 12:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEn-0001OC-0K
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:09 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEl-0006Vy-BK
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:08 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so793052f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646365; x=1752251165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jOfPUoD/EdZ7exrh2TXwHv4lwM7vPam1pOKiytCEmQ0=;
 b=bBV1nzexd1EA4LHoJNvVE0qwcauw4sPTbaQOnJTNMoSv10QraqIpreHt+1SOgt9pHv
 sW1IOrVIXSPMjhKUwHEYqnnwX6b/ZaBhxevV8Xx5vV74EzR9WgNIHvG6+pi09gtDLB4S
 WoRfDj7Al41jtr2lMMGp19tbM15pOF3Lw/25gCEBKJtFliu+t+WE2vqkf2BQRlzDhcHb
 OyanulOdtBqr7voYOOZngPgLA9Ov9Q1BOE6c6JQiyqQw1jebm26WGEfjjb9I8bi1BXRb
 ilAVTJNTviGelBLNYacaBwE4oRJJyZkZfqiiHvIFwuIVc6yUATF8kj3m3oFES6VQHUzh
 xxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646365; x=1752251165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jOfPUoD/EdZ7exrh2TXwHv4lwM7vPam1pOKiytCEmQ0=;
 b=BvLJ+/X7Ur0yaybtGtE2WJRzla3ensK1c6LxfpwD53VsBaQUzxWO2uC0M92e6MT9rn
 OrJtssUBZGvifoYFrxdR0yuviwCRnUm87xYJsw5EhWM8gBKQlY5BSO13vx9I8AGzPpvL
 SUiPYNy32cQzIEnKPIgUBU/7jTTCBZywn8d5x+QmBQGDxar3Zoy63rrsb/5XXuF03vN0
 fldrFiLhy5x4l6NectLIFvoQ8jQTEOFCPxSguMqLGAWQCMeLvlremTlqTcadFz+coBi6
 chsPjapOSecBjaQ7K1eopVnbUNlXYsLdBYWHcgBUd8PhvBnrBwjpnUVy2AHf5/CnswvA
 NqQw==
X-Gm-Message-State: AOJu0Yydu03Nt3set4PgUV/E/XbrubmpPZHRzElQvz/Oq8MUIvDzRco8
 ilqjiiF546e2S4mf7/9WF68JNp5Hj5PCRfZi4cZUw2uzIuguixkyrzNCkfCD4cFaXNkRr3sOyKe
 FyLS+
X-Gm-Gg: ASbGncul5pgyh14vh/mPx5AEfaiMQIGMonXbyX2vDKPN2FZ+OvHe33m3cVT7d+4Gp1Z
 hMdd/9Www0rgBaNpwRuaqoDkXfxtbYiNawWqgsaVPqsq+hv0SxOk0nqTLpNLSvt4pxiGRby82yM
 nN1ldMfx25PTGbCE8eHw3TDS8dcPQgxKKLK6Ty69uLRAVIhCbwR9vtfXYdRu1tShMLMGglynIVz
 npOdP+RXcGNEsQIHmRBp5QKXCBhdIj6duYFajbfR62RM/jTt0IaN3GpvN6BGqwu2MngcVQ4QUrI
 irxydxa5/6VHaAeOulqxAO0t60dhCSmOmG4tc7IP3GRCrYPFqaZzF9ai2gNEroKNA3OX56q+zs1
 bKEo=
X-Google-Smtp-Source: AGHT+IFkStfrZWsKS/7Z8E1VszPld7nLztXRAamx/GszjkvC9AkU+ZZArR7c6LYX691FFf8SpS0xDA==
X-Received: by 2002:a05:6000:21c3:b0:3a6:d93e:526d with SMTP id
 ffacd0b85a97d-3b49310cdafmr2125457f8f.10.1751646365356; 
 Fri, 04 Jul 2025 09:26:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 066/119] target/arm: Implement SME2 FCVTZS, FCVTZU
Date: Fri,  4 Jul 2025 17:24:06 +0100
Message-ID: <20250704162501.249138-67-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-55-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      | 9 +++++++++
 target/arm/tcg/translate-sme.c | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 5100ebaebad..79df2dcd2b0 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -728,6 +728,10 @@ SUB_aaz_d       11000001 111 000010 .. 111 ...00 11 ...     @az_4x4_o3
                 &zz_n n=1 zn=%zn_ax2
 @zz_2x1         ........ ... ..... ...... zn:5  .....       \
                 &zz_n n=1 zd=%zd_ax2
+@zz_2x2         ........ ... ..... ...... .... . .....      \
+                &zz_n n=2 zd=%zd_ax2 zn=%zn_ax2
+@zz_4x4         ........ ... ..... ...... .... . .....      \
+                &zz_n n=4 zd=%zd_ax4 zn=%zn_ax4
 
 BFCVT           11000001 011 00000 111000 ....0 .....       @zz_1x2
 BFCVTN          11000001 011 00000 111000 ....1 .....       @zz_1x2
@@ -737,3 +741,8 @@ FCVTN           11000001 001 00000 111000 ....1 .....       @zz_1x2
 
 FCVT_w          11000001 101 00000 111000 ..... ....0       @zz_2x1
 FCVTL           11000001 101 00000 111000 ..... ....1       @zz_2x1
+
+FCVTZS          11000001 001 00001 111000 ....0 ....0       @zz_2x2
+FCVTZS          11000001 001 10001 111000 ...00 ...00       @zz_4x4
+FCVTZU          11000001 001 00001 111000 ....1 ....0       @zz_2x2
+FCVTZU          11000001 001 10001 111000 ...01 ...00       @zz_4x4
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index d6167eafe17..3bf2b6935f3 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1365,3 +1365,8 @@ TRANS_FEAT(FCVT_w, aa64_sme_f16f16, do_zz_fpst, a, 0,
            FPST_A64_F16, gen_helper_sme2_fcvt_w)
 TRANS_FEAT(FCVTL, aa64_sme_f16f16, do_zz_fpst, a, 0,
            FPST_A64_F16, gen_helper_sme2_fcvtl)
+
+TRANS_FEAT(FCVTZS, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_gvec_vcvt_rz_fs)
+TRANS_FEAT(FCVTZU, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_gvec_vcvt_rz_fu)
-- 
2.43.0


