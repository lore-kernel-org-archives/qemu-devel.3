Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B69DCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLY0-0000VJ-Nk; Wed, 10 Jun 2026 12:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXt-0008FK-O7
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:49 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXs-0005b2-4k
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:49 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490b613a17bso68572695e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107966; x=1781712766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wJCeBrpEENm6xQJkJZv3yaCpjhQMSJugeFLYjZ19DHM=;
 b=FhnHlvmT/6+Q5ScIoKuMWS7+liVs7FSI5+V97EkbXyaenq3vrQt/mZooQkny62ALkg
 4DmNT7chRv6Wd9jJUdaSXAkgiouylSsc7qKBSTvQcbNgLuXkf/9OzAtHteTEUp5FlTZH
 hudU9y+rLZNLVWgmHzsYStjoyZuxkIyDlSWjd5yVyIWapHkx8xpINDQf8o6D7ZIOsw67
 o6bm9GGrnKsANdXen5bvYaP7yZ/fxNsKabCVy/bJkk5WaZvVdOw1qmTk8QTlzr9rAWME
 kHO0LtwhTbL7nOZaLAmzbKWm4yzTpW7TZnAXqIzVM0C7ZkaFlR2O1TjSNUHXPWtgpRNr
 q6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107966; x=1781712766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wJCeBrpEENm6xQJkJZv3yaCpjhQMSJugeFLYjZ19DHM=;
 b=bI4dsEzeNkt6vIg0qegDutlz7X4C5yygEJHpEqOq+cAdk6G1fr/Q9oAoxKsbxPh0nD
 o3lvJuI91OXkswU1KJnV//G5z6H2IyI2GMTwpo4FzMwi/5GCxXCcVyTM71SbifyO5Q5a
 s+KPOSKaIhQi5K1GuMGquwHW6upmE2AEFc4efdKYP2Qn1l+CWsX1wUf/rYUlaaS4TABj
 J/krumJ3d4HDA9Bx1l05N8iXukhy2T5Gz7PrVq940Gz8/Gp2XjU/JSpV0NsP1PF4WnvF
 6TWIwfYUjm1aLtyLn55kDHok4Ol2c1KMZ9SMZSc2kr7dBmm3PG8Z1mEZz0DyGQJqqNSs
 +ATA==
X-Gm-Message-State: AOJu0YwbDWZWLyyPlX3OFepSMG23Z/MomSxpZbXszbYRz8cvsnj9idYp
 dVQI5iZZY3nEXnlaBvY/Dd4l6aZAmUxNK8eDPhXlLiHRB+B5I/awfNCso05bI+9N0R1UC/GBhJr
 fF+DO
X-Gm-Gg: Acq92OF97txEfR6KT0ArSuCl+MVl7NkyLbIHypOw49c+pr0cmrRekYvvAJ78UBRM2k+
 oq9eoWcPQzIKN/TNkP/YFbob66WrM1gOAe9cu0sOwJUhJEzJZ71aARhkTC35omHugM9YxbqT7ei
 N7NKKTy8C58uLCjmaDl/uX8saMlAKet1S/txGkGdCRywoV280qtgSu0ZJ3a7tlXow7ZefMO0qgn
 93u7P5bPNTAU09g175YahIwargGyMFL2MFT2JH9AHg3E9DmMxEtwkpkgol/ZkKSJnIWW227mXWa
 /wqWzPmCIuVB4spEIrXCombHy3wjxYOtakM3qR7Ka+yzverwvPc/iyYsGcstTc4AxhQC3G/AlZH
 jLU8oRfFbUk32bpYO49S6GQXdvRT/wTMeY+9q60mP9C9/pVzf8/WdT6E+XSf9SI2Gch3jnqQIo9
 C1EEO0WY7ui5gBfhohhCPE0BgonGwsRq28DGi/fl0upCcWYi3KNlGxSwUz/mTDCjpHgva01Hq+/
 gB9jIx1xGE5xxVcyHg4CmJV5NDB8uUpE5kbzozTesM=
X-Received: by 2002:a05:600c:821a:b0:490:4973:91a0 with SMTP id
 5b1f17b1804b1-490d71fa976mr102376305e9.10.1781107966265; 
 Wed, 10 Jun 2026 09:12:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/71] target/arm: Introduce arm_init_fp_status
Date: Wed, 10 Jun 2026 17:11:22 +0100
Message-ID: <20260610161202.2235298-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Create a function to set all default controls for a float_status.
Other settings for specific FPST will be set afterward.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 8771b695d9..10daca0ad6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -322,6 +322,13 @@ static void cp_reg_check_reset(gpointer key, gpointer value,  gpointer opaque)
     assert(oldvalue == newvalue);
 }
 
+static void arm_init_fp_status(float_status *s)
+{
+    memset(s, 0, sizeof(*s));
+    arm_set_default_fp_behaviours(s);
+    /* We want 0 for all other settings. */
+}
+
 static void arm_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
@@ -644,20 +651,16 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
         env->sau.ctrl = 0;
     }
 
+    for (int i = 0; i < FPST_COUNT; i++) {
+        arm_init_fp_status(&env->vfp.fp_status[i]);
+    }
+
     set_flush_to_zero(1, &env->vfp.fp_status[FPST_STD]);
     set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_STD_F16]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_ZA]);
     set_default_nan_mode(1, &env->vfp.fp_status[FPST_ZA_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_ZA]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A32_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_A64_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_ZA_F16]);
-    arm_set_default_fp_behaviours(&env->vfp.fp_status[FPST_STD_F16]);
     arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH]);
     set_flush_to_zero(1, &env->vfp.fp_status[FPST_AH]);
     set_flush_inputs_to_zero(1, &env->vfp.fp_status[FPST_AH]);
-- 
2.43.0


