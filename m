Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91F7E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPS4-0000Ia-NG; Wed, 11 Dec 2024 11:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPS0-0000GZ-SL
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:37 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRz-0007iT-9A
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:36 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434a736518eso77686155e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934034; x=1734538834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8h/sNzFR5aix6eqqSQJk01xGJeoXIpNBM9AztS4My+s=;
 b=TuWWeRexXXrk76kKkCxLwM4F7eOdOfigWGCsD6P4QgwRMHTG+Ve1KHFAXUP2U7eP/E
 OlmMvLSQcpcMfgfXVUJuu+jl9M0DmUzSQM1jrmucyw5FnW6DqhwsJYR12hIjxi1sncYk
 JZToVAKTY8z6AKH97Dv9/FvSIGYTh8gZnQL9+PdGd82hVe45c6Q2nYkPWaqlcPLEy402
 nFWLGX6s28JAcw9vnQvM3m/hBEYBy1pQPTkmTH8TYuSq5zX58qgOdoHzup6YlCOWMS/H
 bHJMRF05p+rLZ2pf6LrLtmOuHUK3y07dX7NQI8SQpuoyKkb+xfO3riVPlmZYXx24hq43
 NWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934034; x=1734538834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8h/sNzFR5aix6eqqSQJk01xGJeoXIpNBM9AztS4My+s=;
 b=tw8oFojwqb5rVoXEZnyuHnxfq5ejUZbyhw1MnMsysNo+7nlwpZaw8XdDbnjQiZhqOU
 aijYsw46Gop4RdV0pvSLIdaJjrOuXXAyvwnjgAGW048/Ig8za/U68HPewGT4E7G1OjjL
 8/fqPcg7Lq/eYdfJk+YF9ovzDSdpG4B+1FZ5MUOp1YHHyU12Dgh1qFaQyMVrCCuq6cqi
 gTEPchySBNGBlNxxw2oQ1P2b5T/SbSfAyS6Ej7L8Jk0Bzuz3FYJ9XG42fPE4WRrt5Psb
 UIekxzOvTv4t1/8JtTnQ7WXyr4QdNkfKm6+fnbiyrbf4zc8dFfBM6UfdX+22+EkBGe+x
 pN+Q==
X-Gm-Message-State: AOJu0YwiREC0XaoRlG0hv6a3CZNRMFUmxv5d2yvVHCtewOVHcop9y6Pp
 JI3Xe6bFQ9Idygj+svNBWIVYSuo40a62aaa5L84QT7kgLw5mDVUShkjJVVJcwyVOgtE3jULJmjX
 F
X-Gm-Gg: ASbGnctMPCUdXPRiaIKKXgFfmIMQAlkJk3uH2Qdr2WUala6Kb9zTyeSX+toUU6NIZDj
 LqL8d4BXK75W30zMcS6h59rxbz66/MwA/TxXLYe3iKYYL0l78eEIcGJJ5sTIluZXtP5k7JBWfZX
 7wdPSS8HqhbQAzEiXqm1plnQrGekDXt0Gyxf+2u5PllVHJhI3tprsqDyltVnrbNmajq1fqm/YHX
 SNEwJp+bEDfddI+1waGNOdvrxJFTNfAx0wQySh+9exlzEkmDfo2jccAYm3c
X-Google-Smtp-Source: AGHT+IGiUgtzoA8+arzXkLvcNYtHp6a3gfZSuV8SqjzDcj1xGWPN8trlAwhznSqVYTwDpGxA4tF91g==
X-Received: by 2002:a05:600c:4f13:b0:434:ff45:cbbe with SMTP id
 5b1f17b1804b1-4361c3c7df9mr32567785e9.18.1733934033839; 
 Wed, 11 Dec 2024 08:20:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/72] target/arm: Set Float3NaNPropRule explicitly
Date: Wed, 11 Dec 2024 16:19:14 +0000
Message-Id: <20241211162004.2795499-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Set the Float3NaNPropRule explicitly for Arm, and remove the
ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-18-peter.maydell@linaro.org
---
 target/arm/cpu.c               | 5 +++++
 fpu/softfloat-specialize.c.inc | 8 +-------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ead39793985..c81f6df3fca 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -173,6 +173,10 @@ void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
  *  * tininess-before-rounding
  *  * 2-input NaN propagation prefers SNaN over QNaN, and then
  *    operand A over operand B (see FPProcessNaNs() pseudocode)
+ *  * 3-input NaN propagation prefers SNaN over QNaN, and then
+ *    operand C over A over B (see FPProcessNaNs3() pseudocode,
+ *    but note that for QEMU muladd is a * b + c, whereas for
+ *    the pseudocode function the arguments are in the order c, a, b.
  *  * 0 * Inf + NaN returns the default NaN if the input NaN is quiet,
  *    and the input NaN if it is signalling
  */
@@ -180,6 +184,7 @@ static void arm_set_default_fp_behaviours(float_status *s)
 {
     set_float_detect_tininess(float_tininess_before_rounding, s);
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, s);
+    set_float_3nan_prop_rule(float_3nan_prop_s_cab, s);
     set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, s);
 }
 
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index b4f3f0efa82..3a2d0444475 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -505,13 +505,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
     }
 
     if (rule == float_3nan_prop_none) {
-#if defined(TARGET_ARM)
-        /*
-         * This looks different from the ARM ARM pseudocode, because the ARM ARM
-         * puts the operands to a fused mac operation (a*b)+c in the order c,a,b
-         */
-        rule = float_3nan_prop_s_cab;
-#elif defined(TARGET_MIPS)
+#if defined(TARGET_MIPS)
         if (snan_bit_is_one(status)) {
             rule = float_3nan_prop_s_abc;
         } else {
-- 
2.34.1


