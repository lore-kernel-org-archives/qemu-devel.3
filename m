Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F5CFB44A7
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8Bo-0005mm-3a; Fri, 24 Apr 2026 00:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Bm-0005lK-BB
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:30:50 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Bi-0002YV-Ml
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:30:50 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-40974bf7781so6628432fac.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005045; x=1777609845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pfoV/MjdItCjEdTVv/LcepvEQT5a1+iPXWWZ97UB4oE=;
 b=V5Tm3x+xrn4xpxQN7VXC30Hd6W2JhT33d6I6SFsaQEYFnUtx+OV+Nw9QZAh1Iq1CJc
 8HwAus/PIUVTBtPipuruA10I7gyBWExXU6MyV3RuNg82LGFD3lXT0t7bbyxOuwqfqlPs
 IoUM8sE8GndUxWzh0U7EjpMrmEGWwTHihjdzSPhivBRRCDaLrmfzfVHgyh4BiAE3gmcR
 jz97dDdoZ9qIzVaAZQg+ghlb+u5PsFyEqfdK6P0Tl1p9JHsLYjl7s5NrsK/7ZIxY+zpa
 TCpQTxzXnh9aTvogsDjtX7LDvOXWsKZXq1kOktZlNHOtx8dnJswajPMBAPxs+T05DmW/
 f6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005045; x=1777609845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pfoV/MjdItCjEdTVv/LcepvEQT5a1+iPXWWZ97UB4oE=;
 b=PNgOKxGfmoL12cwLF2OyY0LvTC0BdViFsSLFAsC6c7wh3AOIJVrMcZ7Mfl8Df2/aGL
 Al7xNqum7qPtMgj8cKomodPXjzsnk0hyyUf//+LsJpUyLM7uEmk8mU7OFteiFiisqaQ4
 2pUhEn1RqWH8h560/dzQaoXuomB0KGgLTW8b+k3PgOZ+Fz5Jkdz6Ib6FHL6GtNrHYcCo
 9xKDpmGkLppisDLb2cuRW3u7/CeeevkjxH1M813y6MiR5f2NFny9S5tD3CPZdXZYaE/g
 wrC1+c3TpLXWkg4yUylm1ODF5EH78/YM3FpGXazOuTfuqsQ1pxUSqWxvlzeELqcWav21
 bnkg==
X-Gm-Message-State: AOJu0Yyy1Wx2S5IUwWv9oXer4l0xQNGyotWo9ev+6SFibF+dX4PN3ZS/
 U+SF2u5G+XEt9Yb60tyLqaHjIo3N2e/ehOlsArBouUS4vw8REXVm2pPWtiiHO9n2qnpYLkBXm3o
 P5PUtXmk=
X-Gm-Gg: AeBDiesLNZnxuSSM/ni0XuoWC8HJn8SIelCT/LtkupQXJeaT3j1efOayNzf9/W+I2oB
 TwqjTpEchVHlODcd8RlT4kUDiRf9cabDq3qUECKaG+AIuZBUhdmZFvcs0ht4KwHzFY5fyyPY4Ox
 gIxkl7YzAsl11YE/9M4CfUcg88FrvcSXvnOhUADSJS+FqHH1OK5wcBzPrh7TehT7ucr4xP/AiBp
 1OQok0psh8sdN1JmMnJmTQ28RBVhkyTowUWCZ+bB6RjE7Oh6I+xIBtttkczLKZkriGhDJkaGil3
 YNg3MC2lSbBdaJE5i0sx1UQivOeVogEj3jPO1rWGC9b2sfULgYnRHSiBvBZvEvOF92Kic+Hia1r
 I5HuaRzFH14FrDIjChukZOOTUnr0rzR823CCobq23/ucVSkCUKQV/1IQUDnTkx8uBnpAsX/kZS5
 f2YdRJYwveH3k1aYLsKa+Goh5iLj/zHEkqjNKXg3G2Rh0SklD0p4ZscfqUn/cvgA==
X-Received: by 2002:a05:6870:64a2:b0:423:9751:c1c5 with SMTP id
 586e51a60fabf-42a99adf792mr15782693fac.22.1777005045346; 
 Thu, 23 Apr 2026 21:30:45 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:30:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 05/40] target/arm: Enable FEAT_FAMINMAX for -cpu max
Date: Fri, 24 Apr 2026 14:29:39 +1000
Message-ID: <20260424043014.46305-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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
 target/arm/tcg/cpu64.c        | 4 ++++
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 5 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 84857fb706..343536523a 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1256,6 +1256,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* FEAT_ATS1A */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
+    t = GET_IDREG(isar, ID_AA64ISAR3);
+    t = FIELD_DP64(t, ID_AA64ISAR3, FAMINMAX, 1); /* FEAT_FAMINMAX */
+    SET_IDREG(isar, ID_AA64ISAR3, t);
+
     t = GET_IDREG(isar, ID_AA64PFR0);
     t = FIELD_DP64(t, ID_AA64PFR0, FP, 1);        /* FEAT_FP16 */
     t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);   /* FEAT_FP16 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 7787691853..579df4c47b 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -66,6 +66,7 @@ the following architecture extensions:
 - FEAT_EVT (Enhanced Virtualization Traps)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
 - FEAT_F64MM (Double-precision Matrix Multiplication)
+- FEAT_FAMINMAX (Floating-point maximum and minimum absolute value instructions)
 - FEAT_FCMA (Floating-point complex number instructions)
 - FEAT_FGT (Fine-Grained Traps)
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
-- 
2.43.0


