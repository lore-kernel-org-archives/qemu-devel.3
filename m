Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA5EFF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEx8-0003TH-5G; Wed, 29 Apr 2026 20:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvl-0008Qh-7Y
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:07:04 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvj-00020r-Lh
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:07:00 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-82f8b60e54dso219986b3a.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507618; x=1778112418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T2ZghK4sNfiM5z8zyNlYLTncliVfy0NuA2KHs5cYwz0=;
 b=mhslQS4Ltt5KX0bj/8oX8FMantG4XkpyXnEkQ5mI84o91FWkrkCkjRJZRp2iWsF31a
 daHjXP2fFFC2iGwC04C8en6rTIyYjz92xzIkPJQDzpM34ZchogJzmrEvcPrG87jnLCxJ
 KVOrH8YY1qNrcTwxW03k0eC+TM0sExbvAVvdB55PcYjoUNNg0TtoFldDSoTZgrkiWVP8
 dN5rO90hnWni5G6XZdntIm9ub7gPOxuXfMC8scWd4J2KNgzWmlY7y6QJUJwWk7RejG8b
 aoELkNYSMtYh3KWk+C9JbCpsigP5rbOyJ/le5WTEPRTQvvqSXT/XXDIn7a1/gO5beEie
 TIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507618; x=1778112418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T2ZghK4sNfiM5z8zyNlYLTncliVfy0NuA2KHs5cYwz0=;
 b=mmCHEw7tMs6jVTwuuJTRrcofR3aQR8ydnNxZQC0S4TrwEPq0GGtXD2UBab4JjYvsPJ
 nGrlm5tqZazw/FjdhVlVNejejilAquljY4/HtPelrqZYvoRl1A29XUzIM6a0TkxB28t3
 Lc6FBsffH6PEAYJOUEUowvW3eWRh7TOqiUIVc9ih1qogFMPXknfY7VuAdMwTEEKzg/a9
 cfIVNwE3m7Crn3XY1N/19MeDCykKjE1PzXQa+yHq5ubUMFpVWLsLOKxunU2gwR/PJ66n
 dijq1Zvz1HPiFU4fUwl8amcsZWPgpXyWiT9e3Rq+AisbXBopJ3CGJWr8gyFB8MubWxo4
 Anbg==
X-Gm-Message-State: AOJu0Yy39aRfBHsqbcO2fcNeAe40DZJYR+aEmtsWvgijHZEiWppKLhpr
 JAixIattjNxXOMV/yGNrbzp1Q7x/uMbrx7ErOLSjTyWzdXpxx7YFJkJUGjHlKEHCf72JtAgBqWU
 iJcPxZww=
X-Gm-Gg: AeBDievtgENF5uV9alW6e9zGqrTbE8BWpiPkzbV2xQZWqUWSfVbYoGuKJxphuuHcWua
 tmlBJLYXJ0txJiO8KwEiXvtztedQevMB1vhVgf3F4Iw7yaqdnguayyiA5Ycq64uT32QGGbmsZWf
 podWh7wsW2iS1IVWRGTy1XgFhVW1NTI/02M8kXFVxhchzY0kQdK8k43+2gvy5o0Wx/Xh/43RBZv
 aoyRbLl2/Xl2txEO9TsJ8h9qXv83I1JBe32V+sabfBnr7fy2Fw7zBIEjxjQJK+z4J9MLRaDLZPm
 iszXPqCDsDFRu4O11Zxf1Smad96rv4dRETDIh9Evg8vdEQl9ChAtWL2qboKHKHPTlupYAXr6nJt
 x7dZS3PiEXir9zdtX5MMEg+K5G2KdhbSSPGqa8Sw86OVZsywQ5bWQdQ5usM+WtHc+hBKNTy0i9t
 0/aVdrucerMyDg93tWbNEI+rRPUGuns9YTSicimWTh
X-Received: by 2002:a05:6a00:6c81:b0:82f:a6bf:bede with SMTP id
 d2e1a72fcca58-834fdbfebc5mr832422b3a.40.1777507617664; 
 Wed, 29 Apr 2026 17:06:57 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:06:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 39/40] fpu: Saturate the exponent in uncanon_normal
Date: Thu, 30 Apr 2026 10:05:22 +1000
Message-ID: <20260430000524.56046-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Notice the conflict between saturation and rebias_overflow,
which should never happen.  Otherwise, saturate to INT32_MAX
and allow the usual overflow to max, infinity, or dnan.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 6df98eb5fb..c5a828eb90 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -341,7 +341,17 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
         g_assert_not_reached();
     }
 
-    exp = p->exp + fmt->exp_bias;
+    /* Because exp_bias is positive, we can only overflow past INT_MAX. */
+    if (sadd32_overflow(p->exp, fmt->exp_bias, &exp)) {
+        /*
+         * rebias_overflow wants to compute a modulo exponent, which
+         * conflicts with saturation.  That said, saturation can only
+         * happen with scalbn, which is not a PowerPC operation.
+         */
+        assert(!s->rebias_overflow);
+        exp = INT32_MAX;
+    }
+
     if (likely(exp > 0)) {
         if (p->frac_lo & round_mask) {
             flags |= float_flag_inexact;
-- 
2.43.0


