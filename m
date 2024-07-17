Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30C1C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTxk6-0005M1-0S; Wed, 17 Jul 2024 02:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxk4-0005Ei-6W
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:02:20 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxjx-0001Gp-Ps
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:02:19 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fc4fccdd78so1216785ad.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 23:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721196126; x=1721800926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+fHVJ4bchQHH074Xsji85kfYExDlNqpEjXJOFYCoInA=;
 b=gPsEuXWdrW1kd9/4nFH4A3ujkZQ3HcJ5IAsz81prqPIBnPii8RlsUThBUykWZ1hUKq
 tOu/zDDBq3tG1SGNckSdyQOpIfV4rd6hNoW/gHKviqB7/oNh6WNsur4AFw++HnIgZlwT
 VS39bItr374+3MtLk3E2Um5iIf3JO9TvVKgMut7rPdjnOwAmQfUXuf0QFo5TeS6PT/tE
 QbscxxuiMT+x9J+C/DKWjm4ZwJLexLoq7t/PyZ/DO3A3Awa0F0LeUL5b9SRv8sE3xQkl
 uSKowh3KP14+6GZDeB2mMgwWxVT/16cIqSOGYhpBezy7FGYn8G/5E2MgdX7iMZZIknKM
 Cglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721196126; x=1721800926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+fHVJ4bchQHH074Xsji85kfYExDlNqpEjXJOFYCoInA=;
 b=o4ovIuA0qhbekWaejL+8G67cGIpVgt0uquBW0iebmVKdmXgsfkYZBcsuOaGcKdLK8y
 Sxk59YuflxFr0G1GQnJQkfOPofBNxZgImgHJa/lmLxRwk5ThAn0vzDjQt2+25LAR5jaJ
 FCuCGPmCJNxsTp31jBFTqvMccWzBuwPVc2XghLSATmet7nX/NchC04HEDTBWyKyMmaRB
 4Gb2pnuqCHPrlNE0L6v0H1gLihH8BiQjWTUaYAobQ2pq/VtbB5ynrVt8SWRJvXI4WT4M
 MgMWN4EwU7wCdd4eO7+xNi6h1MhzYe72B1XQS/Puzk2VdsfTlekvBwuTNmNteqU7OKM+
 SQ6Q==
X-Gm-Message-State: AOJu0Yy4XjCXaX4E2VywGfW24x5iX661LAYDGvR4/npdkdfTLv/opjeJ
 ULAMjaZN+qrL+R9WwvkfEIAmtq8BHinv+anMFQyPB1tSj5v2TnMUW7ADcKTWCkYKGpgBoUjH/ss
 EesQ=
X-Google-Smtp-Source: AGHT+IHloEcoHmPyJTxsEy5PdELtfT0z9Q14b0Ns4Sth6QMQ8m/gEBxlZ+J1zx3QeyhT+X0/aZySeA==
X-Received: by 2002:a17:902:ec8a:b0:1fa:fc74:4c04 with SMTP id
 d9443c01a7336-1fc4e16d778mr5882285ad.35.1721196125858; 
 Tue, 16 Jul 2024 23:02:05 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bc27383sm68131575ad.140.2024.07.16.23.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 23:02:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org,
 Daniyal Khan <danikhan632@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 2/3] target/arm: Use FPST_F16 for SME FMOPA (widening)
Date: Wed, 17 Jul 2024 16:01:48 +1000
Message-ID: <20240717060149.204788-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717060149.204788-1-richard.henderson@linaro.org>
References: <20240717060149.204788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: 16
X-Spam_score: 1.6
X-Spam_bar: +
X-Spam_report: (1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This operation has float16 inputs and thus must use
the FZ16 control not the FZ control.

Cc: qemu-stable@nongnu.org
Fixes: 3916841ac75 ("target/arm: Implement FMOPA, FMOPS (widening)")
Reported-by: Daniyal Khan <danikhan632@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2374
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/translate-sme.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 46c7fce8b4..185a8a917b 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -304,6 +304,7 @@ static bool do_outprod(DisasContext *s, arg_op *a, MemOp esz,
 }
 
 static bool do_outprod_fpst(DisasContext *s, arg_op *a, MemOp esz,
+                            ARMFPStatusFlavour e_fpst,
                             gen_helper_gvec_5_ptr *fn)
 {
     int svl = streaming_vec_reg_size(s);
@@ -319,15 +320,18 @@ static bool do_outprod_fpst(DisasContext *s, arg_op *a, MemOp esz,
     zm = vec_full_reg_ptr(s, a->zm);
     pn = pred_full_reg_ptr(s, a->pn);
     pm = pred_full_reg_ptr(s, a->pm);
-    fpst = fpstatus_ptr(FPST_FPCR);
+    fpst = fpstatus_ptr(e_fpst);
 
     fn(za, zn, zm, pn, pm, fpst, tcg_constant_i32(desc));
     return true;
 }
 
-TRANS_FEAT(FMOPA_h, aa64_sme, do_outprod_fpst, a, MO_32, gen_helper_sme_fmopa_h)
-TRANS_FEAT(FMOPA_s, aa64_sme, do_outprod_fpst, a, MO_32, gen_helper_sme_fmopa_s)
-TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a, MO_64, gen_helper_sme_fmopa_d)
+TRANS_FEAT(FMOPA_h, aa64_sme, do_outprod_fpst, a,
+           MO_32, FPST_FPCR_F16, gen_helper_sme_fmopa_h)
+TRANS_FEAT(FMOPA_s, aa64_sme, do_outprod_fpst, a,
+           MO_32, FPST_FPCR, gen_helper_sme_fmopa_s)
+TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a,
+           MO_64, FPST_FPCR, gen_helper_sme_fmopa_d)
 
 /* TODO: FEAT_EBF16 */
 TRANS_FEAT(BFMOPA, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_bfmopa)
-- 
2.43.0


