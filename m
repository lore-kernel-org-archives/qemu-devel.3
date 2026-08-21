Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE29C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN0T-0006EV-DC; Fri, 21 Aug 2026 07:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0S-0006Dk-DZ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0P-0007IT-Eq
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:52 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-499b6c02b02so3964315e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310108; x=1787914908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vbcnA1Pbydjons+rScmFXwTETxcAdC1r1qoNQHm1JNM=;
 b=LFG2GmFxEJqqm5QoDir/58mTKCk6PZdL3dOPEn4Y0iGOJBMFVC0/8+4MbGKpTXb+tx
 5L9QP1dTpVl2ZHT3tpjqXfXgK3bpManGn1JeXjnGpkrfpVJtYLCmifO1GLGutBjNXwu0
 DhHDc/8elp/g3PiBsDCGjBsias+dmvcJ+YVfavzVT51Vu+gQfY7o+ATGtn0DxDJanYMc
 BELAuEkYLRgx/9UUPzobNg0tsp3WrGjw95+3eiI69C4RXmLd5MRlKcT36LRi5UmgXMMH
 xY7zqTz44LJZj4OIoxXibpR9z2jB4XlbTkl1mQSKHi1SUnDDkIYjnFs3tmnN2IFQMEUi
 wH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310108; x=1787914908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vbcnA1Pbydjons+rScmFXwTETxcAdC1r1qoNQHm1JNM=;
 b=Rd66X+5ZkhOhJB4JUIgTywYKd2IBm4uqiObwcL8SD+7HmtpFrF8V/xnMO5qW3FsMJ8
 jIM/I+IVnInJX1rYoGm3badRmBIaA/9GFcj1802pJEMU9KBnJPKllW7Mq9JLHHC1+aqT
 0M2+PoOaDeb02EMkekCJf6L4WJic+L5MsHiNKApafL3rLJ0oTNSc5h3WZNmE8rFuHSEl
 yHuUKcbkIYLks80q9cnGQoMDBXHgcphPK3FTCT1x0mlDe8bWj7bZ/IelvwCdjgwn0HfX
 dkWUv4SwVhmhRmE8GXlHr5GjwBkxZ0V5m/dmgWEq39fkqXZ88JKuxuQdkqa9u1u0fxo9
 72cA==
X-Gm-Message-State: AOJu0YzB2957qFGZtFDH2GEKT/WAnxEfgD15QPWOu7x9bPifdo58Ik2L
 /SO8aefeMj2KeXk2Ba0cHNKJxbDwA1PNIpbE2bkobK29iK7UvJQwTnEN8BlN9AI1xHmKNIKszyq
 x+ti7
X-Gm-Gg: AR+sD13/LgqVIkTeCWhONkQIU+FGs+AKTzNLNCHMs6/7C4ytDYzJGMTcSiK2N2rVI50
 mKxI1ID588HdjqhEDTcfkZeZqva+xAPUCE2/ORmg8zMSlYdqk3FxQeOwPx00Kl8adErrYTOzn+m
 FGyW9yHNQjqI14F+CI6FuSy5spp96Px0tdutO/sZeF71zjjCFP8RwS8cXp5pc4f/hK0jVkO1tJS
 7iA2Roe5DwTfdJkhicvIx0DITLAICAOwNou938XPlnHl6EFvgytJ4/bP0GzJyg8VyxoJ5sVGemj
 6cAWJKmEu9hiMEMxMxi0TIpWbK7niQd988kk+IjMkO2juXd0bIbiaCyOp1tOTeIWOWrC2cOK7wu
 /XEHHZTClISYA1rhZoulp6AOAmoFZqw0EYhL5qwcPvW7pEzr3rbvwiFvoVDfMIm7osYG+/B8Ez5
 bJ99Rp5vZe64UkmDvDbPt7rKHHl7PHX7pLrd8ZAcxsxrHymYaniGmswAK3A8bCy6KG9fCIQMi2O
 eAd0KBCqpYowls45aJkCyjUMCSRSNdyBA7hULA09y4undyD2ESL+js=
X-Received: by 2002:a05:600c:c08f:b0:499:be9e:49c8 with SMTP id
 5b1f17b1804b1-499be9e4a32mr11082695e9.13.1787310107115; 
 Fri, 21 Aug 2026 04:01:47 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.01.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:01:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/43] target/arm: Annotate arch revisions in
 aarch64_max_tcg_initfn
Date: Fri, 21 Aug 2026 12:00:28 +0100
Message-ID: <20260821110101.3971391-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Annotate the minimum revion from which each feature is OPTIONAL.
Modulo some sorting of properties at the end, comment changes
only.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260812204435.295067-10-richard.henderson@linaro.org
[PMM: fixed two minor comment issues]

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu64.c | 303 +++++++++++++++++++++--------------------
 1 file changed, 159 insertions(+), 144 deletions(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 5649b853a7f..9ce514dda81 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1226,199 +1226,202 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, CTR_EL0, DIC, 1);
     cpu->ctr = t;
 
+    /*
+     * Below, note the revision from which the feature is OPTIONAL.
+     */
     t = GET_IDREG(isar, ID_AA64ISAR0);
-    t = FIELD_DP64(t, ID_AA64ISAR0, AES, 2);      /* FEAT_PMULL */
-    t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);     /* FEAT_SHA1 */
-    t = FIELD_DP64(t, ID_AA64ISAR0, SHA2, 2);     /* FEAT_SHA512 */
-    t = FIELD_DP64(t, ID_AA64ISAR0, CRC32, 1);    /* FEAT_CRC32 */
-    t = FIELD_DP64(t, ID_AA64ISAR0, ATOMIC, 3);   /* FEAT_LSE, FEAT_LSE128 */
-    t = FIELD_DP64(t, ID_AA64ISAR0, RDM, 1);      /* FEAT_RDM */
-    t = FIELD_DP64(t, ID_AA64ISAR0, SHA3, 1);     /* FEAT_SHA3 */
-    t = FIELD_DP64(t, ID_AA64ISAR0, SM3, 1);      /* FEAT_SM3 */
-    t = FIELD_DP64(t, ID_AA64ISAR0, SM4, 1);      /* FEAT_SM4 */
-    t = FIELD_DP64(t, ID_AA64ISAR0, DP, 1);       /* FEAT_DotProd */
-    t = FIELD_DP64(t, ID_AA64ISAR0, FHM, 1);      /* FEAT_FHM */
-    t = FIELD_DP64(t, ID_AA64ISAR0, TS, 2);       /* FEAT_FlagM2 */
-    t = FIELD_DP64(t, ID_AA64ISAR0, TLB, 2);      /* FEAT_TLBIRANGE */
-    t = FIELD_DP64(t, ID_AA64ISAR0, RNDR, 1);     /* FEAT_RNG */
+    t = FIELD_DP64(t, ID_AA64ISAR0, AES, 2);      /* v8.0: FEAT_PMULL */
+    t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);     /* v8.0: FEAT_SHA1 */
+    t = FIELD_DP64(t, ID_AA64ISAR0, SHA2, 2);     /* v8.1: FEAT_SHA512 */
+    t = FIELD_DP64(t, ID_AA64ISAR0, CRC32, 1);    /* v8.0: FEAT_CRC32 */
+    t = FIELD_DP64(t, ID_AA64ISAR0, ATOMIC, 3);   /* v9.3: FEAT_LSE128 */
+    t = FIELD_DP64(t, ID_AA64ISAR0, RDM, 1);      /* v8.0: FEAT_RDM */
+    t = FIELD_DP64(t, ID_AA64ISAR0, SHA3, 1);     /* v8.1: FEAT_SHA3 */
+    t = FIELD_DP64(t, ID_AA64ISAR0, SM3, 1);      /* v8.1: FEAT_SM3 */
+    t = FIELD_DP64(t, ID_AA64ISAR0, SM4, 1);      /* v8.1: FEAT_SM4 */
+    t = FIELD_DP64(t, ID_AA64ISAR0, DP, 1);       /* v8.1: FEAT_DotProd */
+    t = FIELD_DP64(t, ID_AA64ISAR0, FHM, 1);      /* v8.1: FEAT_FHM */
+    t = FIELD_DP64(t, ID_AA64ISAR0, TS, 2);       /* v8.4: FEAT_FlagM2 */
+    t = FIELD_DP64(t, ID_AA64ISAR0, TLB, 2);      /* v8.3: FEAT_TLBIRANGE */
+    t = FIELD_DP64(t, ID_AA64ISAR0, RNDR, 1);     /* v8.4: FEAT_RNG */
     SET_IDREG(isar, ID_AA64ISAR0, t);
 
     t = GET_IDREG(isar, ID_AA64ISAR1);
-    t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);      /* FEAT_DPB2 */
-    t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_FPACCOMBINED);
+    t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);      /* v8.1: FEAT_DPB2 */
+    t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_FPACCOMBINED); /* v8.2 */
     t = FIELD_DP64(t, ID_AA64ISAR1, API, 1);
-    t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);    /* FEAT_JSCVT */
-    t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);     /* FEAT_FCMA */
-    t = FIELD_DP64(t, ID_AA64ISAR1, LRCPC, 2);    /* FEAT_LRCPC2 */
-    t = FIELD_DP64(t, ID_AA64ISAR1, FRINTTS, 1);  /* FEAT_FRINTTS */
-    t = FIELD_DP64(t, ID_AA64ISAR1, SB, 1);       /* FEAT_SB */
-    t = FIELD_DP64(t, ID_AA64ISAR1, SPECRES, 1);  /* FEAT_SPECRES */
-    t = FIELD_DP64(t, ID_AA64ISAR1, BF16, 2);     /* FEAT_BF16, FEAT_EBF16 */
-    t = FIELD_DP64(t, ID_AA64ISAR1, DGH, 1);      /* FEAT_DGH */
-    t = FIELD_DP64(t, ID_AA64ISAR1, I8MM, 1);     /* FEAT_I8MM */
-    t = FIELD_DP64(t, ID_AA64ISAR1, XS, 1);       /* FEAT_XS */
+    t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);    /* v8.2: FEAT_JSCVT */
+    t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);     /* v8.2: FEAT_FCMA */
+    t = FIELD_DP64(t, ID_AA64ISAR1, LRCPC, 2);    /* v8.2: FEAT_LRCPC2 */
+    t = FIELD_DP64(t, ID_AA64ISAR1, FRINTTS, 1);  /* v8.4: FEAT_FRINTTS */
+    t = FIELD_DP64(t, ID_AA64ISAR1, SB, 1);       /* v8.0: FEAT_SB */
+    t = FIELD_DP64(t, ID_AA64ISAR1, SPECRES, 1);  /* v8.0: FEAT_SPECRES */
+    t = FIELD_DP64(t, ID_AA64ISAR1, BF16, 2);     /* v8.2: FEAT_EBF16 */
+    t = FIELD_DP64(t, ID_AA64ISAR1, DGH, 1);      /* v8.0: FEAT_DGH */
+    t = FIELD_DP64(t, ID_AA64ISAR1, I8MM, 1);     /* v8.1: FEAT_I8MM */
+    t = FIELD_DP64(t, ID_AA64ISAR1, XS, 1);       /* v8.6: FEAT_XS */
     SET_IDREG(isar, ID_AA64ISAR1, t);
 
     t = GET_IDREG(isar, ID_AA64ISAR2);
-    t = FIELD_DP64(t, ID_AA64ISAR2, RPRES, 1);    /* FEAT_RPRES */
-    t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
-    t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
-    t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
-    t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 2);     /* FEAT_CSSC, FEAT_CMPBR */
-    t = FIELD_DP64(t, ID_AA64ISAR2, LUT, 1);      /* FEAT_LUT */
-    t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* FEAT_ATS1A */
+    t = FIELD_DP64(t, ID_AA64ISAR2, RPRES, 1);    /* v8.6: FEAT_RPRES */
+    t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* v8.7: FEAT_MOPS */
+    t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* v8.7: FEAT_HBC */
+    t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* v8.6: FEAT_WFxT */
+    t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 2);     /* v9.3: FEAT_CMPBR */
+    t = FIELD_DP64(t, ID_AA64ISAR2, LUT, 1);      /* v9.2: FEAT_LUT */
+    t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* v8.8: FEAT_ATS1A */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
     t = GET_IDREG(isar, ID_AA64ISAR3);
-    t = FIELD_DP64(t, ID_AA64ISAR3, FAMINMAX, 1); /* FEAT_FAMINMAX */
-    t = FIELD_DP64(t, ID_AA64ISAR3, FPRCVT, 1);   /* FEAT_FPRCVT */
+    t = FIELD_DP64(t, ID_AA64ISAR3, FAMINMAX, 1); /* v9.2: FEAT_FAMINMAX */
+    t = FIELD_DP64(t, ID_AA64ISAR3, FPRCVT, 1);   /* v9.5: FEAT_FPRCVT */
     SET_IDREG(isar, ID_AA64ISAR3, t);
 
     t = GET_IDREG(isar, ID_AA64PFR0);
-    t = FIELD_DP64(t, ID_AA64PFR0, FP, 1);        /* FEAT_FP16 */
-    t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);   /* FEAT_FP16 */
-    t = FIELD_DP64(t, ID_AA64PFR0, RAS, 2);       /* FEAT_RASv1p1 + FEAT_DoubleFault */
-    t = FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
-    t = FIELD_DP64(t, ID_AA64PFR0, SEL2, 1);      /* FEAT_SEL2 */
-    t = FIELD_DP64(t, ID_AA64PFR0, DIT, 1);       /* FEAT_DIT */
-    t = FIELD_DP64(t, ID_AA64PFR0, CSV2, 3);      /* FEAT_CSV2_3 */
-    t = FIELD_DP64(t, ID_AA64PFR0, CSV3, 1);      /* FEAT_CSV3 */
+    t = FIELD_DP64(t, ID_AA64PFR0, FP, 1);        /* v8.2: FEAT_FP16 */
+    t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);   /* v8.2: FEAT_FP16 */
+    t = FIELD_DP64(t, ID_AA64PFR0, RAS, 2);       /* v8.3: FEAT_DoubleFault */
+    t = FIELD_DP64(t, ID_AA64PFR0, SVE, 1);       /* v8.2: FEAT_SVE */
+    t = FIELD_DP64(t, ID_AA64PFR0, SEL2, 1);      /* v8.3: FEAT_SEL2 */
+    t = FIELD_DP64(t, ID_AA64PFR0, DIT, 1);       /* v8.3: FEAT_DIT */
+    t = FIELD_DP64(t, ID_AA64PFR0, CSV2, 3);      /* v8.0: FEAT_CSV2_3 */
+    t = FIELD_DP64(t, ID_AA64PFR0, CSV3, 1);      /* v8.0: FEAT_CSV3 */
     SET_IDREG(isar, ID_AA64PFR0, t);
 
     t = GET_IDREG(isar, ID_AA64PFR1);
-    t = FIELD_DP64(t, ID_AA64PFR1, BT, 1);        /* FEAT_BTI */
-    t = FIELD_DP64(t, ID_AA64PFR1, SSBS, 2);      /* FEAT_SSBS2 */
+    t = FIELD_DP64(t, ID_AA64PFR1, BT, 1);        /* v8.4: FEAT_BTI */
+    t = FIELD_DP64(t, ID_AA64PFR1, SSBS, 2);      /* v8.0: FEAT_SSBS2 */
     /*
      * Begin with full support for MTE. This will be downgraded to MTE=0
      * during realize if the board provides no tag memory, much like
      * we do for EL2 with the virtualization=on property.
      */
-    t = FIELD_DP64(t, ID_AA64PFR1, MTE, 3);       /* FEAT_MTE3 */
-    t = FIELD_DP64(t, ID_AA64PFR1, RAS_FRAC, 0);  /* FEAT_RASv1p1 + FEAT_DoubleFault */
-    t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* FEAT_SME2 */
-    t = FIELD_DP64(t, ID_AA64PFR1, RNDR_TRAP, 1); /* FEAT_RNG_TRAP */
-    t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
-    t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
-    t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
-    /* FEAT_MTE_NO_ADDRESS_TAGS + FEAT_MTE_CANONICAL_TAGS */
+    t = FIELD_DP64(t, ID_AA64PFR1, MTE, 3);       /* v8.5: FEAT_MTE3 */
+    t = FIELD_DP64(t, ID_AA64PFR1, RAS_FRAC, 0);  /* v8.3: FEAT_DoubleFault */
+    t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* v9.2: FEAT_SME2 */
+    t = FIELD_DP64(t, ID_AA64PFR1, RNDR_TRAP, 1); /* v8.4: FEAT_RNG_TRAP */
+    t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* v8.0: FEAT_CSV2_3 */
+    t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* v8.7: FEAT_NMI */
+    t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* v9.3: FEAT_GCS */
+    /* v8.7: FEAT_MTE_NO_ADDRESS_TAGS + FEAT_MTE_CANONICAL_TAGS */
     t = FIELD_DP64(t, ID_AA64PFR1, MTEX, 1);
     SET_IDREG(isar, ID_AA64PFR1, t);
 
     t = GET_IDREG(isar, ID_AA64PFR2);
-    t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* FEAT_FPMR */
-    t = FIELD_DP64(t, ID_AA64PFR2, MTEFAR, 1);    /* FEAT_MTE_TAGGED_FAR */
-    t = FIELD_DP64(t, ID_AA64PFR2, MTESTOREONLY, 1);   /* FEAT_MTE_STORE_ONLY */
-    t = FIELD_DP64(t, ID_AA64PFR2, MTEPERM, 1);    /* FEAT_MTE_PERM */
+    t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* v9.2: FEAT_FPMR */
+    t = FIELD_DP64(t, ID_AA64PFR2, MTEFAR, 1);    /* v8.7: FEAT_MTE_TAGGED_FAR */
+    t = FIELD_DP64(t, ID_AA64PFR2, MTESTOREONLY, 1); /* v8.7: FEAT_MTE_STORE_ONLY */
+    t = FIELD_DP64(t, ID_AA64PFR2, MTEPERM, 1);   /* v8.7: FEAT_MTE_PERM */
     SET_IDREG(isar, ID_AA64PFR2, t);
 
     t = GET_IDREG(isar, ID_AA64MMFR0);
-    t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6); /* FEAT_LPA: 52 bits */
-    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 1);   /* 16k pages supported */
-    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16_2, 2); /* 16k stage2 supported */
-    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN64_2, 2); /* 64k stage2 supported */
-    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN4_2, 2);  /*  4k stage2 supported */
-    t = FIELD_DP64(t, ID_AA64MMFR0, FGT, 1);       /* FEAT_FGT */
-    t = FIELD_DP64(t, ID_AA64MMFR0, ECV, 2);       /* FEAT_ECV */
+    t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6);  /* v8.1: FEAT_LPA: 52 bits */
+    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 1);   /* v8.0: FEAT_TGran16K */
+    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16_2, 2); /* v8.0: FEAT_S2TGran16K */
+    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN64_2, 2); /* v8.0: FEAT_S2TGran64K */
+    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN4_2, 2);  /* v8.0: FEAT_S2TGran4K */
+    t = FIELD_DP64(t, ID_AA64MMFR0, FGT, 1);      /* v8.5: FEAT_FGT */
+    t = FIELD_DP64(t, ID_AA64MMFR0, ECV, 2);      /* v8.5: FEAT_ECV_POFF */
     SET_IDREG(isar, ID_AA64MMFR0, t);
 
     t = GET_IDREG(isar, ID_AA64MMFR1);
-    t = FIELD_DP64(t, ID_AA64MMFR1, HAFDBS, 2);   /* FEAT_HAFDBS */
-    t = FIELD_DP64(t, ID_AA64MMFR1, VMIDBITS, 2); /* FEAT_VMID16 */
-    t = FIELD_DP64(t, ID_AA64MMFR1, VH, 1);       /* FEAT_VHE */
-    t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 2);     /* FEAT_HPDS2 */
-    t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);       /* FEAT_LOR */
-    t = FIELD_DP64(t, ID_AA64MMFR1, PAN, 3);      /* FEAT_PAN3 */
-    t = FIELD_DP64(t, ID_AA64MMFR1, XNX, 1);      /* FEAT_XNX */
-    t = FIELD_DP64(t, ID_AA64MMFR1, ETS, 2);      /* FEAT_ETS2 */
-    t = FIELD_DP64(t, ID_AA64MMFR1, HCX, 1);      /* FEAT_HCX */
-    t = FIELD_DP64(t, ID_AA64MMFR1, AFP, 1);      /* FEAT_AFP */
-    t = FIELD_DP64(t, ID_AA64MMFR1, TIDCP1, 1);   /* FEAT_TIDCP1 */
-    t = FIELD_DP64(t, ID_AA64MMFR1, CMOW, 1);     /* FEAT_CMOW */
+    t = FIELD_DP64(t, ID_AA64MMFR1, HAFDBS, 2);   /* v8.0: FEAT_HAFDBS */
+    t = FIELD_DP64(t, ID_AA64MMFR1, VMIDBITS, 2); /* v8.0: FEAT_VMID16 */
+    t = FIELD_DP64(t, ID_AA64MMFR1, VH, 1);       /* v8.0: FEAT_VHE */
+    t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 2);     /* v8.1: FEAT_HPDS2 */
+    t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);       /* v8.0: FEAT_LOR */
+    t = FIELD_DP64(t, ID_AA64MMFR1, PAN, 3);      /* v8.1: FEAT_PAN3 */
+    t = FIELD_DP64(t, ID_AA64MMFR1, XNX, 1);      /* v8.1: FEAT_XNX */
+    t = FIELD_DP64(t, ID_AA64MMFR1, ETS, 2);      /* v8.0: FEAT_ETS2 */
+    t = FIELD_DP64(t, ID_AA64MMFR1, HCX, 1);      /* v8.6: FEAT_HCX */
+    t = FIELD_DP64(t, ID_AA64MMFR1, AFP, 1);      /* v8.6: FEAT_AFP */
+    t = FIELD_DP64(t, ID_AA64MMFR1, TIDCP1, 1);   /* v8.7: FEAT_TIDCP1 */
+    t = FIELD_DP64(t, ID_AA64MMFR1, CMOW, 1);     /* v8.7: FEAT_CMOW */
     SET_IDREG(isar, ID_AA64MMFR1, t);
 
     t = GET_IDREG(isar, ID_AA64MMFR2);
-    t = FIELD_DP64(t, ID_AA64MMFR2, CNP, 1);      /* FEAT_TTCNP */
-    t = FIELD_DP64(t, ID_AA64MMFR2, UAO, 1);      /* FEAT_UAO */
-    t = FIELD_DP64(t, ID_AA64MMFR2, IESB, 1);     /* FEAT_IESB */
-    t = FIELD_DP64(t, ID_AA64MMFR2, VARANGE, 1);  /* FEAT_LVA */
-    t = FIELD_DP64(t, ID_AA64MMFR2, NV, 2);       /* FEAT_NV2 */
-    t = FIELD_DP64(t, ID_AA64MMFR2, ST, 1);       /* FEAT_TTST */
-    t = FIELD_DP64(t, ID_AA64MMFR2, AT, 1);       /* FEAT_LSE2 */
-    t = FIELD_DP64(t, ID_AA64MMFR2, IDS, 1);      /* FEAT_IDST */
-    t = FIELD_DP64(t, ID_AA64MMFR2, FWB, 1);      /* FEAT_S2FWB */
-    t = FIELD_DP64(t, ID_AA64MMFR2, TTL, 1);      /* FEAT_TTL */
-    t = FIELD_DP64(t, ID_AA64MMFR2, BBM, 2);      /* FEAT_BBM at level 2 */
-    t = FIELD_DP64(t, ID_AA64MMFR2, EVT, 2);      /* FEAT_EVT */
-    t = FIELD_DP64(t, ID_AA64MMFR2, E0PD, 1);     /* FEAT_E0PD */
+    t = FIELD_DP64(t, ID_AA64MMFR2, CNP, 1);      /* v8.1: FEAT_TTCNP */
+    t = FIELD_DP64(t, ID_AA64MMFR2, UAO, 1);      /* v8.1: FEAT_UAO */
+    t = FIELD_DP64(t, ID_AA64MMFR2, IESB, 1);     /* v8.1: FEAT_IESB */
+    t = FIELD_DP64(t, ID_AA64MMFR2, VARANGE, 1);  /* v8.1: FEAT_LVA */
+    t = FIELD_DP64(t, ID_AA64MMFR2, NV, 2);       /* v8.3: FEAT_NV2 */
+    t = FIELD_DP64(t, ID_AA64MMFR2, ST, 1);       /* v8.3: FEAT_TTST */
+    t = FIELD_DP64(t, ID_AA64MMFR2, AT, 1);       /* v8.2: FEAT_LSE2 */
+    t = FIELD_DP64(t, ID_AA64MMFR2, IDS, 1);      /* v8.3: FEAT_IDST */
+    t = FIELD_DP64(t, ID_AA64MMFR2, FWB, 1);      /* v8.3: FEAT_S2FWB */
+    t = FIELD_DP64(t, ID_AA64MMFR2, TTL, 1);      /* v8.3: FEAT_TTL */
+    t = FIELD_DP64(t, ID_AA64MMFR2, BBM, 2);      /* v8.3: FEAT_BBML2 */
+    t = FIELD_DP64(t, ID_AA64MMFR2, EVT, 2);      /* v8.2: FEAT_EVT2 */
+    t = FIELD_DP64(t, ID_AA64MMFR2, E0PD, 1);     /* v8.4: FEAT_E0PD */
     SET_IDREG(isar, ID_AA64MMFR2, t);
 
     t = GET_IDREG(isar, ID_AA64MMFR3);
-    t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);       /* FEAT_TCR2 */
-    t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
-    t = FIELD_DP64(t, ID_AA64MMFR3, MEC, 1);        /* FEAT_MEC */
-    t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
-    t = FIELD_DP64(t, ID_AA64MMFR3, S1PIE, 1);    /* FEAT_S1PIE */
-    t = FIELD_DP64(t, ID_AA64MMFR3, S2PIE, 1);    /* FEAT_S2PIE */
-    t = FIELD_DP64(t, ID_AA64MMFR3, AIE, 1);      /* FEAT_AIE */
+    t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);     /* v8.0: FEAT_TCR2 */
+    t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);   /* v8.0: FEAT_SCTLR2 */
+    t = FIELD_DP64(t, ID_AA64MMFR3, MEC, 1);      /* v9.2: FEAT_MEC */
+    t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* v8.2: FEAT_FPACC_SPEC */
+    t = FIELD_DP64(t, ID_AA64MMFR3, S1PIE, 1);    /* v8.8: FEAT_S1PIE */
+    t = FIELD_DP64(t, ID_AA64MMFR3, S2PIE, 1);    /* v8.8: FEAT_S2PIE */
+    t = FIELD_DP64(t, ID_AA64MMFR3, AIE, 1);      /* v8.8: FEAT_AIE */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
     t = GET_IDREG(isar, ID_AA64MMFR4);
-    t = FIELD_DP64(t, ID_AA64MMFR4, ASID2, 1);    /* FEAT_ASID2 */
+    t = FIELD_DP64(t, ID_AA64MMFR4, ASID2, 1);    /* v9.4: FEAT_ASID2 */
     SET_IDREG(isar, ID_AA64MMFR4, t);
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
-    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* FEAT_SVE2p1 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* FEAT_SVE_BitPerm */
-    t = FIELD_DP64(t, ID_AA64ZFR0, BFLOAT16, 2);  /* FEAT_BF16, FEAT_EBF16 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 1);    /* FEAT_SVE_B16B16 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, SHA3, 1);      /* FEAT_SVE_SHA3 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, SM4, 1);       /* FEAT_SVE_SM4 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, I8MM, 1);      /* FEAT_I8MM */
-    t = FIELD_DP64(t, ID_AA64ZFR0, F32MM, 1);     /* FEAT_F32MM */
-    t = FIELD_DP64(t, ID_AA64ZFR0, F64MM, 1);     /* FEAT_F64MM */
+    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* v9.2: FEAT_SVE2p1 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* v9.0: FEAT_SVE_PMULL128 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* v9.0: FEAT_SVE_BitPerm */
+    t = FIELD_DP64(t, ID_AA64ZFR0, BFLOAT16, 2);  /* v8.2: FEAT_EBF16 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 1);    /* v9.2: FEAT_SVE_B16B16 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, SHA3, 1);      /* v9.0: FEAT_SVE_SHA3 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, SM4, 1);       /* v9.0: FEAT_SVE_SM4 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, I8MM, 1);      /* v8.1: FEAT_I8MM */
+    t = FIELD_DP64(t, ID_AA64ZFR0, F32MM, 1);     /* v8.2: FEAT_F32MM */
+    t = FIELD_DP64(t, ID_AA64ZFR0, F64MM, 1);     /* v8.2: FEAT_F64MM */
     SET_IDREG(isar, ID_AA64ZFR0, t);
 
     t = GET_IDREG(isar, ID_AA64DFR0);
-    t = FIELD_DP64(t, ID_AA64DFR0, DEBUGVER, 10); /* FEAT_Debugv8p8 */
-    t = FIELD_DP64(t, ID_AA64DFR0, PMUVER, 6);    /* FEAT_PMUv3p5 */
-    t = FIELD_DP64(t, ID_AA64DFR0, HPMN0, 1);     /* FEAT_HPMN0 */
+    t = FIELD_DP64(t, ID_AA64DFR0, DEBUGVER, 10); /* v8.7: FEAT_Debugv8p8 */
+    t = FIELD_DP64(t, ID_AA64DFR0, PMUVER, 6);    /* v8.4: FEAT_PMUv3p5 */
+    t = FIELD_DP64(t, ID_AA64DFR0, HPMN0, 1);     /* v8.5: FEAT_HPMN0 */
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
-    t = FIELD_DP64(t, ID_AA64SMFR0, SMOP4, 1);    /* FEAT_SME_MOP4 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, STMOP, 1);    /* FEAT_SME_TMOP */
-    t = FIELD_DP64(t, ID_AA64SMFR0, SFEXPA, 1);   /* FEAT_SSVE_FEXPA */
-    t = FIELD_DP64(t, ID_AA64SMFR0, AES, 1);      /* FEAT_SSVE_AES */
-    t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* FEAT_SSVE_FP8DOT2 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
-    t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
-    t = FIELD_DP64(t, ID_AA64SMFR0, BI32I32, 1);  /* FEAT_SME2 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, B16F32, 1);   /* FEAT_SME */
-    t = FIELD_DP64(t, ID_AA64SMFR0, F16F32, 1);   /* FEAT_SME */
-    t = FIELD_DP64(t, ID_AA64SMFR0, I8I32, 0xf);  /* FEAT_SME */
-    t = FIELD_DP64(t, ID_AA64SMFR0, F8F32, 1);    /* FEAT_SME_F8F32 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, F8F16, 1);    /* FEAT_SME_F8F16 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, F16F16, 1);   /* FEAT_SME_F16F16 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, B16B16, 1);   /* FEAT_SME_B16B16 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, I16I32, 5);   /* FEAT_SME2 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, F64F64, 1);   /* FEAT_SME_F64F64 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, I16I64, 0xf); /* FEAT_SME_I16I64 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 2);   /* FEAT_SME2p1 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, LUTv2, 1);    /* FEAT_SME_LUTv2 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SMOP4, 1);    /* v9.4: FEAT_SME_MOP4 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, STMOP, 1);    /* v9.4: FEAT_SME_TMOP */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SFEXPA, 1);   /* v9.4: FEAT_SSVE_FEXPA */
+    t = FIELD_DP64(t, ID_AA64SMFR0, AES, 1);      /* v9.5: FEAT_SSVE_AES */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* v9.2: FEAT_SSVE_FP8DOT2 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* v9.2: FEAT_SSVE_FP8DOT4 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* v9.2: FEAT_SSVE_FP8FMA */
+    t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* v9.2: FEAT_SME */
+    t = FIELD_DP64(t, ID_AA64SMFR0, BI32I32, 1);  /* v9.2: FEAT_SME2 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, B16F32, 1);   /* v9.2: FEAT_SME */
+    t = FIELD_DP64(t, ID_AA64SMFR0, F16F32, 1);   /* v9.2: FEAT_SME */
+    t = FIELD_DP64(t, ID_AA64SMFR0, I8I32, 0xf);  /* v9.2: FEAT_SME */
+    t = FIELD_DP64(t, ID_AA64SMFR0, F8F32, 1);    /* v9.2: FEAT_SME_F8F32 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, F8F16, 1);    /* v9.2: FEAT_SME_F8F16 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, F16F16, 1);   /* v9.2: FEAT_SME_F16F16 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, B16B16, 1);   /* v9.2: FEAT_SME_B16B16 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, I16I32, 5);   /* v9.2: FEAT_SME2 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, F64F64, 1);   /* v9.2: FEAT_SME_F64F64 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, I16I64, 0xf); /* v9.2: FEAT_SME_I16I64 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 2);   /* v9.2: FEAT_SME2p1 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, LUTv2, 1);    /* v9.2: FEAT_SME_LUTv2 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* v9.2: FEAT_SME_FA64 */
     SET_IDREG(isar, ID_AA64SMFR0, t);
 
     t = GET_IDREG(isar, ID_AA64FPFR0);
-    t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
-    t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
-    t = FIELD_DP64(t, ID_AA64FPFR0, F8MM4, 1);    /* FEAT_F8F16MM */
-    t = FIELD_DP64(t, ID_AA64FPFR0, F8MM8, 1);    /* FEAT_F8F32MM */
-    t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* FEAT_FP8DOT2 */
-    t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
-    t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
-    t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* v9.2: FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* v9.2: FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8MM4, 1);    /* v9.2: FEAT_F8F16MM */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8MM8, 1);    /* v9.2: FEAT_F8F32MM */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* v9.2: FEAT_FP8DOT2 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* v9.2: FEAT_FP8DOT4 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* v9.2: FEAT_FP8FMA */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* v9.2: FEAT_FP8 */
     SET_IDREG(isar, ID_AA64FPFR0, t);
 
     /* Replicate the same data to the 32-bit id registers.  */
@@ -1432,19 +1435,31 @@ void aarch64_max_tcg_initfn(Object *obj)
     cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
     set_dczid_bs(cpu, 7); /*  512 bytes */
 #endif
+
+    /* v8.4: FEAT_MTE2 */
     cpu->gm_blocksize = 6;  /*  256 bytes */
 
+    /* v8.2: FEAT_SVE */
     cpu->sve_vq.supported = MAKE_64BIT_MASK(0, ARM_MAX_VQ);
-    cpu->sme_vq.supported = SVE_VQ_POW2_MAP;
-
-    aarch64_add_pauth_properties(obj);
     aarch64_add_sve_properties(obj);
-    aarch64_add_sme_properties(obj);
     object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
                         cpu_max_set_sve_max_vq, NULL, NULL);
+
+    /* v9.2: FEAT_SME */
+    cpu->sme_vq.supported = SVE_VQ_POW2_MAP;
+    aarch64_add_sme_properties(obj);
+
+    /* v8.2: FEAT_PAuth2 */
+    aarch64_add_pauth_properties(obj);
+
+    /* v9.1: FEAT_RME */
     object_property_add_bool(obj, "x-rme", cpu_arm_get_rme, cpu_arm_set_rme);
+
+    /* v9.4: FEAT_RME_GPC2 */
     object_property_add(obj, "x-l0gptsz", "uint32", cpu_max_get_l0gptsz,
                         cpu_max_set_l0gptsz, NULL, NULL);
+
+    /* v8.6: FEAT_LPA2 */
     qdev_property_add_static(DEVICE(obj), &arm_cpu_lpa2_property);
 }
 
-- 
2.43.0


