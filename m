Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A66CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIF9t-0006iZ-O5; Wed, 29 Apr 2026 20:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9h-0006Tg-PK
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:26 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9g-0006Iv-BB
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:25 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82f8b60e485so152401b3a.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508483; x=1778113283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XfEjDJlVu7LsFiNptc3UAEkKV/ApJAH3Ld019vvaP5k=;
 b=octsh+kqrJ9joC7wGzbRHBUr0MnOBZeyL5V+ybJ+t3gmwX/G//KUUhrNJBxvPYsUgC
 qz8LdWmWauccSMrwnKA411l8fVCOq2VSaIvIHApnjk0Z8cJmSxqeTESLz0CZhKowDpY+
 6xADpApvC13Bbb0yFdVsr9PNSjWFzDOeyCgOAdlVpL0Fyz23qD1Kz7LttKogYFvaxOmD
 ggimenjslft5vzkViKw40y2h1/wAe4VyJWOMGOAKj3s+diTmknFX7kXWLQyZqCDZPV8A
 X4454WF+GBrkFx2ZDnWe8tRiWFWIrstKT3GjOe9qOV1PBJTBSyT2hUfXsS0XBnjuxaTx
 iXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508483; x=1778113283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XfEjDJlVu7LsFiNptc3UAEkKV/ApJAH3Ld019vvaP5k=;
 b=URJ5ieVRb3pqDeASJM4KLqT9vBTNcwNe95L/cgAe3HMkgYzNyb2SeVz7rYJTtqheLo
 xUt8qJ5RTyFd/RtZfiEW8R1KqhLJA29eQ5EtDMJX801aXChEZEGaIJ5CLEEXsDzoloMq
 cN4yzZf8PR5wIzPBTz38auOx2ZRZjn1SET1vMFKI6swCq/sQfCG8p68hVy6bx3sec7a0
 QJkG+dK5OKBn1YAW1ahsVgPASr8KOVpUwA3/g9I4IbO9DKlRJ6Fuo6hUWhQN5ZLMzzSO
 eSoZDXAhetS+T8YnK3QbE/hJ884yH67JkPc75pdESZ036Py9Ew6QD30+61QP1iwiY8eM
 Lfvg==
X-Gm-Message-State: AOJu0YwvNVVOssa2hLjLgbuPsildl6La/yz8Qs3mVoluZEh2pBGTpySd
 HmTwekvSjFRS+k0RcIA+TvCFVdGYXNAlUC6sDOnvv1FSoPqbYm3yIYOHNkzz5WyK+PZYVx3OPKy
 d8NAIjxY=
X-Gm-Gg: AeBDiesBo3G7JD7NcjDQQL+GaezXvexp4FtOrNhWc3gR2RPH1hWhztHJI4jHrM8SDpH
 yW2whDKcHiDU8qEx2x9vege9aHct9iiCLPTrwQJkllkShJyC9gQh7kZu/jf/0vlynEsj6rBOg+p
 5ACiqvhVmmiPIvBQKrsjcPGM7QyPafOo4newkP7k60warJnuwu4ITiQllBg8OqKdXvYYPx0P+Se
 vYlmn2nS4v96TmslOuv7gV02HP926cj1FJhI/nAdQ/YOHMrB/3aPWxhaEQ5C+UnQRPmbUQEveV0
 gicvV8yiJl0//Bk4aba9FqFazvHrlrMuSZlzWbtucl0Cm95rT5nklfrwCAgBc1uk+JpUaka9H/A
 Us0zp1Mj7NNAJt5UcZ8vCuoPm3y5Mg8jNXLIlbeSoeowPJ/Ar/hyf4fRlHfXoOlf5paWmoEFKGP
 pZKv3H6XtW6bKiyP2NkmonQxNFgRpK+A7+HXCGlDhb
X-Received: by 2002:a05:6a00:3492:b0:829:8a84:b9fc with SMTP id
 d2e1a72fcca58-834fe0612a8mr696552b3a.8.1777508482940; 
 Wed, 29 Apr 2026 17:21:22 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:21:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 14/47] target/arm: Enable FEAT_FPMR for -cpu max
Date: Thu, 30 Apr 2026 10:20:13 +1000
Message-ID: <20260430002046.59739-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
index ff0c2b1c47..a377f67b9c 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1297,6 +1297,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
     SET_IDREG(isar, ID_AA64PFR1, t);
 
+    t = GET_IDREG(isar, ID_AA64PFR2);
+    t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* FEAT_FPMR */
+    SET_IDREG(isar, ID_AA64PFR2, t);
+
     t = GET_IDREG(isar, ID_AA64MMFR0);
     t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6); /* FEAT_LPA: 52 bits */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 1);   /* 16k pages supported */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index da5f7efce2..44c7196d09 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -77,6 +77,7 @@ the following architecture extensions:
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
 - FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
+- FEAT_FPMR (Floating-point mode register)
 - FEAT_FRINTTS (Floating-point to integer instructions)
 - FEAT_FlagM (Flag manipulation instructions v2)
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
-- 
2.43.0


