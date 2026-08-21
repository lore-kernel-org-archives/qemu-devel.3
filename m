Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03238C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN0o-0007yl-IE; Fri, 21 Aug 2026 07:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0m-0007rA-Nx
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:12 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0k-0007Mj-Tj
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:12 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4998e0916faso4894825e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310129; x=1787914929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LHJQk44yFfynPaUC5hQjyP5aA7i00MLZRfDUAfCRXcE=;
 b=jKRFXFHwcaOOmCzLzlpi+GctkyT4Ow4ZuZcnu5foNcqDWvtgSMj7mjZMJ/pe3iwLUP
 8Uba5FmztpvoNzY/JsFI5t/UtbygSG9Dwe8P1cVYnz7y5g1/AT5WdlXxJPsbXcLLriTw
 JaODd1Dz0f23ls+u5Zwg2bmYWmYvlim13Gh475Qly1uTSht17RhSR+cwp+udQ8RPXkXi
 P1Ob+QEKs3AWkSjOuBmE9jcDkLmdA5+8UjWHzFvXrRnv7wd5pYH6zTuMS/ba9SaxgH1W
 rZh/kS5rmKeSdc8+6aXM1gQvcGR6OlPCBdQKu9KrTubEoLuJtst/jS1i5E3DG/tLuYse
 HPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310129; x=1787914929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LHJQk44yFfynPaUC5hQjyP5aA7i00MLZRfDUAfCRXcE=;
 b=EZp/9gkKx4Mfay1EOSd2CncUiA5LZEyzi5rNsSl1JhvJ7eFzpAeKF+To0FoUZ/sinE
 AZeVc1RVm49snHGXfmp1sTfqniudIy4N3RlaMELFl+EM1TAvI09uPfSd5e3jvB/ABTe4
 +1web5PunMOuz44W4oVdMiaQTl2JhHx8xuawVjHxVUIXosIOA+jRKIOgCgleZZGzJqBG
 DiZtArL2JFwNNO7vwoZjgiOjILDmco60lhS1bBiLXHHWF7+GpYg0WW9CZTqfufmhe3od
 orw2yGTF78//nHr0uWibG07VUJ7o19p/ciVix+2PBBMfJhHh0p/7iAfqUH+MMGzLobTU
 EsUw==
X-Gm-Message-State: AOJu0YytR8mRCtftdQZYx838NFy+FHz6qo2XNvPrH20W5ToLGbGGawSp
 S/M4LeGglar+GZGQNmDugOhfuqFx8kW0XRuLLO1jjXqYSmqi3cq74n/gCqYjIwBRD9ggG7KwmBb
 qDaFR
X-Gm-Gg: AR+sD13OMhzgEe6k51WwJOVyIDyCw70u5Evk88niN/XbXODfg1zm3Hi6Cr2Zi6rxGXa
 58xTvUXTC6wjsfLLlarIitlD/sXGU05AUWYcoLyGqmKP6k6KvTL1tHzLhlHNmbFdr/GFPew5Vuy
 0N8GB3taWDwtIayTQR5iq4N1cbEizU38SGblDRSv1EnyeXL7+Xd2YqQ3qLXdgt/j6qUE9hdG4Nh
 qaa1pVAPTxcVwKi8jPd2i0VEpEyRtVtYGdGALc5RBlyZQbdMOoNDEc+J4kUzMBW3Lc4l6CMrjFv
 AwLf+k8wyizc9F/Qkpq6Pf2WHmqRkwYVN0F/wkkO3S6f0dlls58oqeXYC/4lqBjWGaRg1Y9Fbaf
 jVkQY6HCtGIuHLD6KnO0wwxq8dHI56j3lthgLQs+dRQGhAxLxgB0j3EnsBvQiQfQyYzBZ1iAcFn
 ornOX+7vWdQ4e1Q2J8CurSEgzcsmvo612vAYC7v/FGgwuTvr3aFhmPJxbQ7OpobBmOkFXe8SM2q
 d6/GUpo22ciGcwRyN/B+rMaFKDE45JMfxM4jnfekcq149kMb3O+18CQCap2xlE+tESEWw==
X-Received: by 2002:a05:600c:8b6e:b0:499:a5fc:2087 with SMTP id
 5b1f17b1804b1-499b8320523mr81641095e9.6.1787310129458; 
 Fri, 21 Aug 2026 04:02:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/43] target/arm: Handle NSACR.NSASEDIS in HCPTR accesses
Date: Fri, 21 Aug 2026 12:00:35 +0100
Message-ID: <20260821110101.3971391-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

In cptr_el2_read() and cptr_el2_write()  we have code that implements the
"HCPTR.{TCP10,TCP11} behave as RAO/WI from NonSecure when NSACR.cp10 is
0" behaviour.  There is a similar requirement for HCPTR.TASE: if
NSACR.NSASEDIS is 1 then CPACR.ASEDIS behaves as RAO/WI in NS.

This doesn't matter to us yet because we don't currently implement
ASEDIS or NSASEDIS. But we're about to do that, so add the handling
to cptr_el2_read() and cptr_el2_write().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260817123838.1578060-3-peter.maydell@linaro.org
---
 target/arm/helper.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6a707b80cff..d582eeba577 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4117,11 +4117,18 @@ static void cptr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     /*
      * For A-profile AArch32 EL3, if NSACR.CP10
      * is 0 then HCPTR.{TCP11,TCP10} ignore writes and read as 1.
+     * Similarly, if NSACR.NSASEDIS is 1 then HCPTR.TASE behaves as RAO/WI.
      */
     if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
-        !arm_is_secure(env) && !FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
-        uint64_t mask = R_HCPTR_TCP11_MASK | R_HCPTR_TCP10_MASK;
-        value = (value & ~mask) | (env->cp15.cptr_el[2] & mask);
+        !arm_is_secure(env)) {
+        if (!FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
+            uint64_t mask = R_HCPTR_TCP11_MASK | R_HCPTR_TCP10_MASK;
+            value = (value & ~mask) | (env->cp15.cptr_el[2] & mask);
+        }
+        if (FIELD_EX32(env->cp15.nsacr, NSACR, NSASEDIS)) {
+            uint64_t mask = R_HCPTR_TASE_MASK;
+            value = (value & ~mask) | (env->cp15.cptr_el[2] & mask);
+        }
     }
     env->cp15.cptr_el[2] = value;
 }
@@ -4131,12 +4138,18 @@ static uint64_t cptr_el2_read(CPUARMState *env, const ARMCPRegInfo *ri)
     /*
      * For A-profile AArch32 EL3, if NSACR.CP10
      * is 0 then HCPTR.{TCP11,TCP10} ignore writes and read as 1.
+     * Similarly, if NSACR.NSASEDIS is 1 then HCPTR.TASE behaves as RAO/WI.
      */
     uint64_t value = env->cp15.cptr_el[2];
 
     if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
-        !arm_is_secure(env) && !FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
-        value |= R_HCPTR_TCP11_MASK | R_HCPTR_TCP10_MASK;
+        !arm_is_secure(env)) {
+        if (!FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
+            value |= R_HCPTR_TCP11_MASK | R_HCPTR_TCP10_MASK;
+        }
+        if (!FIELD_EX32(env->cp15.nsacr, NSACR, NSASEDIS)) {
+            value |= R_HCPTR_TASE_MASK;
+        }
     }
     return value;
 }
-- 
2.43.0


