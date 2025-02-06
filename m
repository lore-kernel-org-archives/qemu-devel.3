Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C16C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg84c-0000RX-QY; Thu, 06 Feb 2025 15:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83f-0007qZ-2d
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:12 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83T-00019G-WB
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:01 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21f3c119fe6so23548925ad.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738872053; x=1739476853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XuYzYniVS4NXI7g4Z8SivOPJBHJ3QPNfhDXKzXys9Mk=;
 b=B52bNsxk/UP8l7YFdBxsG0hjqQO+V0VLfUCdKkmCzecSp/s4jA+YzTaUQMykpKP7ai
 tMjt16pAGOv0Y+MA2lOs4z47iyBo5m5ncR0GKx1Vcq9kDIQaqheZ2euhK8QNWwoj5+lZ
 dJkgb/axJb5yGOGcp8Af8gv888EAo/uGQsK7byjRbjsOUl31ugxjb5E/PXz7l+5N1atK
 RcDb4vhuLSA5Qok7ClctO370RVFn+pn+qMEi8HZYylGsBH4+Dw03KA5D1YTLhIdBeJRS
 R1RBEMvNmn3nlbXhtVgh9xf+j2GKJWdyQrZ5/YsMVyf0uvPtnk9WGSDcFMcrKVSDsQTb
 TFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738872053; x=1739476853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XuYzYniVS4NXI7g4Z8SivOPJBHJ3QPNfhDXKzXys9Mk=;
 b=OacGdY2H4GsBi3fjrzXoyqOK9vWgnizY/Nq31VEX1zW+dEfrRkiwjg07McnalKS7iy
 GkhVoRDq6u7UotnyvpHKuB3sJqrtAJGvj8VfGV6ajGVPY/8gH98dvG9XeNF/yg6PimcM
 uALD7bQ1UweNH59J0GMPpZUexgslZtI+kv56lsLverJeqGSq2WKGHZ+jH5CBjLdqhwfC
 rYukm+JLqDaPfNFJ26xHggQWjnxHD5U+ocmjTf4CzKwF8SfJoQypQChpM7oTOgkUXtiK
 b1lazSfIu8T4A8ywv+GCqyI13t+7dllAPrQanOrTe16McGl9Iju9rYkRVdiuHK3FsIBf
 9qEQ==
X-Gm-Message-State: AOJu0Yze+/ZZJQkIKqaxeV9FPTcTUV2mLeZJkoLexzizvLQqs7o9xK+R
 ek3DY1h2Ctp86nrTbTMrbiv01FBXcSs284urfAxU/gjUrfH0NvWE0aXBmyC1TYef7NBpZAE8Rh2
 8
X-Gm-Gg: ASbGncu96t4feFEFxMLbJOeWCMPyCUQrWfHH9cwafj/Lp4Qh3xvWLYyMsQiBTKkXMsm
 y0fSw8PdQ0LRUEX0Zqgc1lUf3s5SfJ9j+1ZYrRux/tZsYHKhUynY6gp5uM/Vl+07t9vl1tBSwS8
 7X4J9Y/r1M4XAgOeTRY4eJXAVboErMBBOLwK6BQ9q/RIWN7Awr6yG4zzfLo64kI1HZUrhxgnNau
 hilRsT4CWM8Gf0P+kE9JMDw51uXsUitqmaHsN7KytgGm7IFnS8zz/RnTs1XV9TS7BS4UVMKJuQm
 F/ze242zmCvA7PBy7Ac5IvFvy05OF7sxDTSLYXlyoTIEB4c=
X-Google-Smtp-Source: AGHT+IF4GUrIg1wHGVDXSs7SLt9FDayKeAVDugX1OvX0t0dznd38OPpE4d9UuGdcQuXbs5nZDi010g==
X-Received: by 2002:a17:902:e5d1:b0:21f:3a7b:f4eb with SMTP id
 d9443c01a7336-21f4e6c8a1dmr7096585ad.22.1738872053121; 
 Thu, 06 Feb 2025 12:00:53 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09b3ee24sm1808857a91.36.2025.02.06.12.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 12:00:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 48/61] target/arm: Implement SME2 FCVTZS, FCVTZU
Date: Thu,  6 Feb 2025 11:57:02 -0800
Message-ID: <20250206195715.2150758-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
index 2b45244e23..4b45459e77 100644
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


