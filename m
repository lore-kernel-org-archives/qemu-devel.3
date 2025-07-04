Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547A9C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEH-0000By-FV; Fri, 04 Jul 2025 12:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEG-0008UP-8s
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:36 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjED-0006CJ-Dn
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:35 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a503d9ef59so767305f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646332; x=1752251132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kzXSPmp4Je9MEvy89AfIdr04Lfhn9GQcJRIOry58+Ks=;
 b=vHdPEcHxJ1JqxfYWBUgf8FxT3sLhH/mVukwOBsjIwu+o49goWAbbEtaR4fl2FpxN0g
 Bx525H7coONAYYQSALiQCGMhq7jt/8c/sQ366lhLlb+BMHB9i7n0CRgykDEKGqzdykm5
 qIm4K2NDT9hw/Mm8vAa9XEBcsb84xx1ehVuajqb/UVlP7Bp2j61c+I1+ciI8cIGQFv09
 QqOPPwebFuJJ7caf4Ue49A188hl3Js6TlI/PHYT74Fd4sad0tGxRt3rYFFPyaa4TSY9O
 hIHmgsN1SQAziiddIPTameT7AeNWzBxt4777lZcSGeMPleao6qoMU2T1g2akFPlDz7HL
 pvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646332; x=1752251132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kzXSPmp4Je9MEvy89AfIdr04Lfhn9GQcJRIOry58+Ks=;
 b=qHhycvGbRtL1KPPvPmRddPU2lkLgqoXFkcW6v47dh/e/3giap/DbCbpJ3A6JU5Rjnf
 z64CgNoE8U0zpHgMsz2vYQ9lxvM9g+9l4EV3tbsQwyf0ZTbv6eTIdyGkU4NkhAwTIVO7
 YQ8zTlyhswoApdMVGN4zJ+bbxgSHUUOpJKwl7+gc8ckHBmq33zziARHPIg+dLzthvh+0
 Rxkq5UpV5bF29D1Tt8VbH+bse/A7aQ9FKeUHISIGisdqfZmHlO4Qm1KkwsTXAcjiFmex
 ZHzj9FJZl8VbkVrw5Q3jDh+Jn+umxQxWU/Y8Fh+Bz88BGvSoLACVoD8MWDt9/eL5viDI
 no2w==
X-Gm-Message-State: AOJu0YwO/sr3/ZoA079ZiFXBq0y2zh+2VSZ1sTGKSAvU+RQJU7FYqsWa
 X6vPUvYvJMP/m3XDqeDjLgdPeNKvf12a60JguD9yUibVo80mWQ472WKLYDRuUtiR13LXm9N4VXn
 FN+71
X-Gm-Gg: ASbGncu2fn1ROOi17KN+g0phgshzarcFo1lp7fx7fR6ZFCCYDQpit6Ch9WKbYqfjGGs
 4naxApktBB6mBOGlr1cH0+fPHyx7O2p26Cdg601fbbg5JwBrTAL6kYfRdpeItYke6Qz8SE7Etum
 E0uqSwB+EJ5S6e+Jvvqoo9K02PL8r3KMpuebjGe2zYeLM3npbsXprxfg/+3K/il38UMuB6xPPNS
 TnZLKGJjTFEytLX6GSIyWsj6AShxMUF/w0HjnSEZwUsNWHdrFRMwllRTeNkyRG04UF0oRseNHDp
 ARCumcBWMI9K7Q0lLg/nZqw45Y/g9TklHmf+/5byf3IXwlp9ZsOGRpc3i3Hu7RtIlm40
X-Google-Smtp-Source: AGHT+IFp5KLwMTRrh+qxmX7Gy7fXqjunxY3ZDmCEmPC0t5Uyx6zcQ+FUYDInl9MK8cPWgYa0Z0AgOA==
X-Received: by 2002:a05:6000:24c9:b0:3a4:e667:922e with SMTP id
 ffacd0b85a97d-3b49700c540mr1925605f8f.4.1751646331809; 
 Fri, 04 Jul 2025 09:25:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 031/119] target/arm: Implement SME2 LDR/STR ZT0
Date: Fri,  4 Jul 2025 17:23:31 +0100
Message-ID: <20250704162501.249138-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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
Message-id: 20250704142112.1018902-20-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      |  6 ++++++
 target/arm/tcg/translate-sme.c | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index dd1f983941a..cef49c3b29b 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -55,6 +55,12 @@ LDST1           1110000 111     st:1 rm:5 v:1 .. pg:3 rn:5 0 za_imm:4  \
 LDR             1110000 100 0 000000 .. 000 ..... 0 ....        @ldstr
 STR             1110000 100 1 000000 .. 000 ..... 0 ....        @ldstr
 
+&ldstzt0        rn
+@ldstzt0        ....... ... . ...... .. ... rn:5  .....         &ldstzt0
+
+LDR_zt0         1110000 100 0 111111 00 000 ..... 00000         @ldstzt0
+STR_zt0         1110000 100 1 111111 00 000 ..... 00000         @ldstzt0
+
 ### SME Add Vector to Array
 
 &adda           zad zn pm pn
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 1dbd0199af0..9f252739926 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -292,6 +292,19 @@ static bool do_ldst_r(DisasContext *s, arg_ldstr *a, GenLdStR *fn)
 TRANS_FEAT(LDR, aa64_sme, do_ldst_r, a, gen_sve_ldr)
 TRANS_FEAT(STR, aa64_sme, do_ldst_r, a, gen_sve_str)
 
+static bool do_ldst_zt0(DisasContext *s, arg_ldstzt0 *a, GenLdStR *fn)
+{
+    if (sme2_zt0_enabled_check(s)) {
+        fn(s, tcg_env, offsetof(CPUARMState, za_state.zt0),
+           sizeof_field(CPUARMState, za_state.zt0), a->rn, 0,
+           s->align_mem ? MO_ALIGN_16 : MO_UNALN);
+    }
+    return true;
+}
+
+TRANS_FEAT(LDR_zt0, aa64_sme2, do_ldst_zt0, a, gen_sve_ldr)
+TRANS_FEAT(STR_zt0, aa64_sme2, do_ldst_zt0, a, gen_sve_str)
+
 static bool do_adda(DisasContext *s, arg_adda *a, MemOp esz,
                     gen_helper_gvec_4 *fn)
 {
-- 
2.43.0


