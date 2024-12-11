Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2053BE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPS1-0000GI-QT; Wed, 11 Dec 2024 11:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRw-0000Es-OW
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:33 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRu-0007hY-Q2
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:32 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385e06af753so3068563f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934029; x=1734538829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=129ef8vVSPhcYKXwuPVUePnnMXZtavBkurzU5VPKzhM=;
 b=rHcRkOb4wgFbhFF0GnbW2XBMuIYq5ELpnnjRTyhZ+U37BIj/ES4khs2gn8PneRLj1x
 tIdASBVVzvqxQgGfGlXeVzSMQ0ZydMAqqkERK7Ip0XCHUPKysNfrpZyd71kBW+CakDcW
 1tZlDlqZ1/KE677lA5TMcKi+vMi2I9Vl9qLMzH7HdRRK9+YP+qP5tHS0iOs9XFivBkEH
 vbNyTVYdP1J4h8TAArn1hR//EknMc/+d85R/E93C5jipL9nq1aTEnSap1GSMPmhR1Ph+
 UsmHDcRMnMJ49Q4hBA2VrSO4x5NEEJGjz6WbRIc8So7plrj05bpz1LV4HkHJLb4dbuo+
 XiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934029; x=1734538829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=129ef8vVSPhcYKXwuPVUePnnMXZtavBkurzU5VPKzhM=;
 b=sLP59tY91tBsUgiLBAgMzAgVtzY6AjnUwe19NTiLMyx+Kxmcdf2NV4cPk/SZwbNX/a
 t3Poa++g+YIrUU8nK5h28ofl/lZEZxiDMKJ2LwidNk8kZpcbiv9h37B6PvBbXh0ybt6U
 NLiq/3UC3LFJHMOQFxBvMZEjEHjlV/uXg6BCdYwja0zMADTzFei8Kta++912s8zKPUd2
 UBVr8eEVeVFEC0m05n8B+/JEQ+20KYYg3MVOsp4TFXxB2uQXRTXo1GYjW0kuxZhAH+Em
 vJ0wHPToRoRKKdKatrZHD7R+EZIwE2vHfqSuJFNXU9VE6V0QcAfH8KlPe7g825pAgDRY
 21fg==
X-Gm-Message-State: AOJu0YxtJPR3rEIEs63Q5sLfa7Re+5XdFyC9OXszjyuwIJAkltJAQOB/
 8OUoY6E2kJN2pZOSE8H8dnyd5f1M5sG9BMFjnnYXE+feOcQp9XfZrAEwE0PhkePj/5WwUxFMCNO
 O
X-Gm-Gg: ASbGnctvwaDHpSoYTuPeWuaesPBES5plyhx+aNfrzpf8BUHxjPuzHtzzI8R0+3SVfB9
 dCWdn3oEtVB8Ce4Ewx6wgtjLKaf2iIgNRWMFwiMPihTpZMq8hMJdN05LgICZVA+5npjIct2U9BI
 61DVJecuvL8goU9+IUuFMBJ0sPLadGzSg0ip/Zqt2ri0u3o3J4D0FOtGCW314I4i3trvDZXdcSb
 ezjanohhjhEpUaS0u5TqDyhV/0fNbsvODog/QnjWu0WUWPgqx/AZI2to5b6
X-Google-Smtp-Source: AGHT+IHawayYOLRoJVyOTs7hXbcV8NUwQ5+tFgdwmnnncbnmg2QktS3knJYw/k1h8+v8DS9ORsqNvw==
X-Received: by 2002:a05:6000:144d:b0:386:1cd3:8a0b with SMTP id
 ffacd0b85a97d-3864ce968f8mr2280236f8f.17.1733934029265; 
 Wed, 11 Dec 2024 08:20:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/72] target/hppa: Set FloatInfZeroNaNRule explicitly
Date: Wed, 11 Dec 2024 16:19:10 +0000
Message-Id: <20241211162004.2795499-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
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

Set the FloatInfZeroNaNRule explicitly for the HPPA target,
so we can remove the ifdef from pickNaNMulAdd().

As this is the last target to be converted to explicitly setting
the rule, we can remove the fallback code in pickNaNMulAdd()
entirely.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-14-peter.maydell@linaro.org
---
 target/hppa/fpu_helper.c       |  2 ++
 fpu/softfloat-specialize.c.inc | 13 +------------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index 0e44074ba82..393cae33bf9 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -55,6 +55,8 @@ void HELPER(loaded_fr0)(CPUHPPAState *env)
      * HPPA does note implement a CPU reset method at all...
      */
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, &env->fp_status);
+    /* For inf * 0 + NaN, return the input NaN */
+    set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
 }
 
 void cpu_hppa_loaded_fr0(CPUHPPAState *env)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 05dec2fcb4c..3e4ec938b25 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -475,8 +475,6 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
 static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
                          bool infzero, float_status *status)
 {
-    FloatInfZeroNaNRule rule = status->float_infzeronan_rule;
-
     /*
      * We guarantee not to require the target to tell us how to
      * pick a NaN if we're always returning the default NaN.
@@ -485,21 +483,12 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
      */
     assert(!status->default_nan_mode);
 
-    if (rule == float_infzeronan_none) {
-        /*
-         * Temporarily fall back to ifdef ladder
-         */
-#if defined(TARGET_HPPA)
-        rule = float_infzeronan_dnan_never;
-#endif
-    }
-
     if (infzero) {
         /*
          * Inf * 0 + NaN -- some implementations return the default NaN here,
          * and some return the input NaN.
          */
-        switch (rule) {
+        switch (status->float_infzeronan_rule) {
         case float_infzeronan_dnan_never:
             return 2;
         case float_infzeronan_dnan_always:
-- 
2.34.1


