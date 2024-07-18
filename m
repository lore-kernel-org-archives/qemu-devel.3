Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE1DC3DA63
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR48-0001kP-EV; Thu, 18 Jul 2024 09:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3t-00004r-Dk
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:46 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3q-0004WP-R2
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:45 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4266fd39527so2761195e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308841; x=1721913641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gacol05z2j4g3ezomPw5aWtTptIdBc2mH3bQ/0FLyGY=;
 b=tdXlTC6AYiD0x8+Du6jTgVJoFHZdwwpzpajsGimWfe3Evxm3Fk1YEP6QIWVi3LWwEZ
 YYBcMzlhVMQY+WYnZBYUYWmfJeHyWcSYo+x3z1jBTq1KLQ53R1cqpiEMdX0iUvJCKHbW
 bCDbWo3AmrxC2ZdL7L5mCGKcBle+pFnm4Jy0+UJxwA0JZfzEE6ukDoUUCVMJr/6LfjBE
 dXw+goUMCk3g3TgdVKRQX3o6ya0oTRJ5rHGuqtGUCmQSS2BlqT1SUJZUyc3rIuLrLtRL
 p18v7wVci1BEnnBByRyD95vXjh2RH8TLOgRfXIg2yso3ezKttMuI7bQV/m4r7ID6+r2o
 ck3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308841; x=1721913641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gacol05z2j4g3ezomPw5aWtTptIdBc2mH3bQ/0FLyGY=;
 b=cwtjuMM0PDsul1sGsBzmXBdOsJftKF+LaagKlGjofG5zmBlp1grFDqoveJRwc8PtMw
 Qtjq7eJfKIrcEwLuO4HLhbwwbc0gWJYqlcSce9QxtRna4ATNzzXY8zVONihaYFEeyLZX
 /Z3ha6KOwx0yD1hK7XkzocmMkwu3t7QmA0IyzBwPu9NcsgzDJ26VpII6Tw4RDbrokevm
 U1+yLORMU22s0OFRRnwnJg9dSgH4x7ZOkeNuxH2iGsQ1X8iF88ghXYx9CR4v4ejmUaw1
 WDqiLWzthWlyLiqx0hXZ8qte3Xcr08fs2pTOhhstdwDWrNQyN8CHSlCBv79tpR/W2OQZ
 jbXQ==
X-Gm-Message-State: AOJu0YwUV5x7h/2jHTO84AbE0Un1/TBgNBylxcksvEQfS33fqhm40WCc
 xSu8r+8JzxjEly1c7v5XgwyqcvAf/9Ndac6S1QpZf+9QJroEBqGQAJDeu6l5qvGZnjykHfp9SZN
 o
X-Google-Smtp-Source: AGHT+IG60+CeDbPIpSsoEVVgQbHc+U3TRS3HC00dJ+L3HlHL1DZgcTnPcWTixIXcwWd8MPQOIM6Kvg==
X-Received: by 2002:a05:600c:3553:b0:426:6455:f11c with SMTP id
 5b1f17b1804b1-427c2cfc33fmr36642255e9.25.1721308841276; 
 Thu, 18 Jul 2024 06:20:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/26] target/arm: Use FPST_F16 for SME FMOPA (widening)
Date: Thu, 18 Jul 2024 14:20:25 +0100
Message-Id: <20240718132028.697927-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Richard Henderson <richard.henderson@linaro.org>

This operation has float16 inputs and thus must use
the FZ16 control not the FZ control.

Cc: qemu-stable@nongnu.org
Fixes: 3916841ac75 ("target/arm: Implement FMOPA, FMOPS (widening)")
Reported-by: Daniyal Khan <danikhan632@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20240717060149.204788-3-richard.henderson@linaro.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2374
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sme.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 46c7fce8b4e..185a8a917b0 100644
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
2.34.1


