Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605AEC3DA45
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 05:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTEjQ-00050m-0Y; Mon, 15 Jul 2024 01:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTEjO-0004wH-WC
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:58:39 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTEjL-0008TI-W7
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:58:38 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2c8517aab46so3165118a91.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 22:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721023114; x=1721627914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bo/AQ8LDzk/AOqWq7VGMP1dwGD9Dmy3wpy1bY1Rsljs=;
 b=Vvn3SVcxf53+Z3MHgiNQ8grXR8g3kafkpD215q2n3iPwukg//Fx4nL3BIsr4cxxgfo
 vQqCCANYkrhcNWtEx5N874voAGWJ+1EbHVJCOhdKrhpRbZvW5P8PAQ/TXjZ4yC5nVTDG
 oxZx+OeOrGWj6DyBW2oQtmP+fmA3YuJ6bGmFiT3HG5fNelcup/H1RKw59tHl3IuxD19M
 WJZiuq0CWHcNHbdx3yepB6ewFewmgrHzGjXaR3MdvaUmdQ+wlUrvBAb3Y0f+jqx/SKdR
 gpEWpx/svQemta7f/NdU0JCL5XeM/bf+nnJIBJg1zfi44E9LE8Cvw7tfjZdlRZYnZp0D
 ZSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721023114; x=1721627914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bo/AQ8LDzk/AOqWq7VGMP1dwGD9Dmy3wpy1bY1Rsljs=;
 b=eOjaNwSS5y5hh4FGFQ5aXhoSUbHv2nHGIOfHFhsmwQJ1qlyUU0fNZ1Tt3TwNTF/ImI
 ps+X/1zbzTYVHjmDuPLtHvz5tn2+B0JxaR6CdDt66LcrictOTINCufoeQ1lifvg38nHm
 grvCRwRC7pUllqwN2/Fwagu//rCWznA7cCQe6nv79zOh7c67g0dR7JynNFX+2Sl0R195
 jpLN/jpIsc/xq0bANm7rGv70U09mVROXkiZzDXE7j2R/oFyAXPPclfgeaA/+ksrBnMaX
 JBhy0s61sAmGLdl6KrGW2TvJONvGwtxasCCoZ2/KBxce8sAi6Wv0c6p5FFgzL7SxYL8i
 eHDA==
X-Gm-Message-State: AOJu0YyQzBNZvamkeG0+gGBMyR1P4RQgtq+wjaC0rjfFh/Iz0K15YGv+
 qfMDLNeafiULu1x/9MD7V7hy5MjsIPtd/0prX6pr4blesMUCW5MYayFzEzINjHNxPgMjNTczv9C
 duhJ5yw==
X-Google-Smtp-Source: AGHT+IE7Wrs6Be0q71OdWzgH0apo8uC9ZNEhm7xoeVQ4JpqRXJFbJ6zhaRWK/tu0BsBBjMai6yEAIA==
X-Received: by 2002:a17:90a:ca87:b0:2c9:7ae1:8f62 with SMTP id
 98e67ed59e1d1-2ca35d599e0mr13652395a91.46.1721023114241; 
 Sun, 14 Jul 2024 22:58:34 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cacd419af7sm5463589a91.25.2024.07.14.22.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jul 2024 22:58:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: danikhan632@git.sr.ht, qemu-arm@nongnu.org, qemu-stable@nongnu.org,
 Daniyal Khan <danikhan632@gmail.com>
Subject: [PATCH 2/3] target/arm: Use FPST_F16 for SME FMOPA (widening)
Date: Mon, 15 Jul 2024 15:58:19 +1000
Message-ID: <20240715055820.319035-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240715055820.319035-1-richard.henderson@linaro.org>
References: <20240715055820.319035-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reported-by: Daniyal Khan <danikhan632@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2374
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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


