Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB2BC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMd3-0007IX-Fn; Fri, 24 Jan 2025 11:33:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYt-0005Na-2V
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:39 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYr-0005gq-E6
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:38 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-436202dd730so16570955e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736176; x=1738340976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZZv9bq0gc1TNRBfKcXqBREv5BnIPhNP5omygXi9vvRM=;
 b=ASqzPj/BA8OepH9orNPRg/HTSQo6M19PpYJ7SjVTMv8Ly4ZQEQh2Q8Ruou1N0GRb0J
 vItcbGSc4SYL7C8x6mtUlxaPv981Rx9HZ5Gi59FtjYUS023fgIePs0pA1aPJexGa7ML/
 pUp5UUMS5PleWIP6edXXsfdn4q2ws9191gz+OlRXuillTJ83FahByoBQWufEA2YAXooQ
 v+xn9MBdX3fEIZmVjH/YndtjtAascE4Exh+VDHCNBuABuE2g4jgKTdVnbN2GDZRsks4C
 42Si+c6WCx0AmgcJRvaDlo6A3OvBdYgwF08G21SWBHObIb1zAcbpfn6PV30nsHWR0sSu
 4eWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736176; x=1738340976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZZv9bq0gc1TNRBfKcXqBREv5BnIPhNP5omygXi9vvRM=;
 b=kQt+rbve4UUEU8w5n22K6SyKWdppB1agLBzraoKP6nq5S4BBnLrdX/7uJAubMPjCGa
 FPYMtIqeN2YIaA+vm6EvPXtX3923XBUgs97/PEJ6tMrshMbKNhI/w5azC40u5hX4LgDm
 ZqRXtQyt+h7fiM8fBckGy/XLvcipCHIncTFUDrpzjz7Ydl8XQ64ECt4PbWnIlv0KFxDQ
 uKQ0t1XkiHhwLVVq1a3mqMcFqBITeogJYQlNAJZij2sZ6f0mgwc2jRgxe+v5250mW7Ab
 OxKQM1skbI5hWIyIF4ZLc1Hc8KFt8C+zQ8xAhGGCCzLUV4txO0x6RkwmcGKvCNWRuiSh
 tA/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7RlpqVz6t5+KwRT5BV3dP1Ltc4ZH0owncdRA1FKZdo8D/kVFxFOyIURwwNGFtL3BgM0fdzkLfOkZ4@nongnu.org
X-Gm-Message-State: AOJu0YyTDPq7yIR+PqKCfmXkpzf/Zgh2mxqgevZN0sxZ7GD8PhOKzf9u
 1z0V8Cll00yCyUs/J+k/KT1+79sGHHl/wSH5E2qbaDhTKpljzqu9K/TsiPCZ8UM=
X-Gm-Gg: ASbGnctOmf9Z9j8dr8yC2nXo7xG7GP6fSSN9B/olkthjc56HVdJxZsgBLc+ZvZ0D37X
 2ZlncUAsPPEQ30H9e90JsnFS0cwkVvv1TfVqgIdIFO+ra+c1bpvTO4O5elEXsNedAKxOknuwGkN
 +hMKBFiI5M5DR32OHvf44ZIl/FAs9Izb+wQ6ZSvV9b5QU2m/M0ybX+OUCaF+rTOmO8q9+pI1KtZ
 kbwHzc+dJfL0xTJFEZurg4yYcK72AB8HqgLhbocHHZg8Ksxdmqb9Iczm9zPiomhg1QTlLa2pSj9
 oPuPczgEKyI=
X-Google-Smtp-Source: AGHT+IE+0PVcJirL06dqo8tIXoAVT8YSK1PJgjgabw+NUEwBI9QQaHFcyn0XythQjNCCNIqhjgVEOw==
X-Received: by 2002:a05:600c:1d1d:b0:434:faa9:5266 with SMTP id
 5b1f17b1804b1-438913e79e2mr281283135e9.13.1737736175953; 
 Fri, 24 Jan 2025 08:29:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 47/76] target/arm: Implement FPCR.AH semantics for FMAXV and
 FMINV
Date: Fri, 24 Jan 2025 16:28:07 +0000
Message-Id: <20250124162836.2332150-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Implement the FPCR.AH semantics for FMAXV and FMINV.  These are the
"recursively reduce all lanes of a vector to a scalar result" insns;
we just need to use the _ah_ helper for the reduction step when
FPCR.AH == 1.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 330336f0828..c07e22bad31 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7029,27 +7029,35 @@ static TCGv_i32 do_reduction_op(DisasContext *s, int rn, MemOp esz,
 }
 
 static bool do_fp_reduction(DisasContext *s, arg_qrr_e *a,
-                              NeonGenTwoSingleOpFn *fn)
+                            NeonGenTwoSingleOpFn *fnormal,
+                            NeonGenTwoSingleOpFn *fah)
 {
     if (fp_access_check(s)) {
         MemOp esz = a->esz;
         int elts = (a->q ? 16 : 8) >> esz;
         TCGv_ptr fpst = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
-        TCGv_i32 res = do_reduction_op(s, a->rn, esz, 0, elts, fpst, fn);
+        TCGv_i32 res = do_reduction_op(s, a->rn, esz, 0, elts, fpst,
+                                       s->fpcr_ah ? fah : fnormal);
         write_fp_sreg(s, a->rd, res);
     }
     return true;
 }
 
-TRANS_FEAT(FMAXNMV_h, aa64_fp16, do_fp_reduction, a, gen_helper_vfp_maxnumh)
-TRANS_FEAT(FMINNMV_h, aa64_fp16, do_fp_reduction, a, gen_helper_vfp_minnumh)
-TRANS_FEAT(FMAXV_h, aa64_fp16, do_fp_reduction, a, gen_helper_vfp_maxh)
-TRANS_FEAT(FMINV_h, aa64_fp16, do_fp_reduction, a, gen_helper_vfp_minh)
+TRANS_FEAT(FMAXNMV_h, aa64_fp16, do_fp_reduction, a,
+           gen_helper_vfp_maxnumh, gen_helper_vfp_maxnumh)
+TRANS_FEAT(FMINNMV_h, aa64_fp16, do_fp_reduction, a,
+           gen_helper_vfp_minnumh, gen_helper_vfp_minnumh)
+TRANS_FEAT(FMAXV_h, aa64_fp16, do_fp_reduction, a,
+           gen_helper_vfp_maxh, gen_helper_vfp_ah_maxh)
+TRANS_FEAT(FMINV_h, aa64_fp16, do_fp_reduction, a,
+           gen_helper_vfp_minh, gen_helper_vfp_ah_minh)
 
-TRANS(FMAXNMV_s, do_fp_reduction, a, gen_helper_vfp_maxnums)
-TRANS(FMINNMV_s, do_fp_reduction, a, gen_helper_vfp_minnums)
-TRANS(FMAXV_s, do_fp_reduction, a, gen_helper_vfp_maxs)
-TRANS(FMINV_s, do_fp_reduction, a, gen_helper_vfp_mins)
+TRANS(FMAXNMV_s, do_fp_reduction, a,
+      gen_helper_vfp_maxnums, gen_helper_vfp_maxnums)
+TRANS(FMINNMV_s, do_fp_reduction, a,
+      gen_helper_vfp_minnums, gen_helper_vfp_minnums)
+TRANS(FMAXV_s, do_fp_reduction, a, gen_helper_vfp_maxs, gen_helper_vfp_ah_maxs)
+TRANS(FMINV_s, do_fp_reduction, a, gen_helper_vfp_mins, gen_helper_vfp_ah_mins)
 
 /*
  * Floating-point Immediate
-- 
2.34.1


