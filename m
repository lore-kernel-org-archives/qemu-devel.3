Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEBEC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricUQ-0007tr-DK; Fri, 08 Mar 2024 10:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricUL-0007UE-O9
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:50:25 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricUI-0004HD-1W
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:50:25 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33e70d71756so930646f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 07:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709913018; x=1710517818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ejoX6B83wxuPaH1DIRcrBj3nXLL1aa1KSo/sDVGM2V8=;
 b=TixzLlnRm8vqtrF7HpFPNFql9RvmFxu9v3N1qnhWMs/OZolFeJJNmetpLF4GuEqn79
 ausIi1jR4mpoo3ECtu7tt3zc78NCAp5ru6PRZLTjPdgtQYSd1jkRHNusVCt5sNBJY86a
 nIuC6eQgdBVveTvdexrHQ+f0vFmPNzMv7+X1LGDU90scV+htM9Iox+043+rH04wJSbJ/
 qy9TT7KY7Mx2DUZdAwRhgWQ3LG6aRbk2uMWO06tZFmaufc21vj55S4HG6CYXlr06+n2s
 p7HmBKjpJmCODqu8zBtHikYVF19ZCdxIZU+0nYoVHp//T/6b3r1DFtC4OGNlHapyrGEp
 JEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709913018; x=1710517818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ejoX6B83wxuPaH1DIRcrBj3nXLL1aa1KSo/sDVGM2V8=;
 b=EIQBRnkAEJNjZc7jej2fC5QBaSATDR39yypp+dc0+ldPtYyp0SCw8yG4OO/c3y2S5E
 SScPdUCjwh8E9v+lfA+SYleDb4MoG42SvbNdSfo9aRlqYgbMi6Llp6kgWZuiD2GN5Ixx
 eIDbAfLcfIMkL1Bs4MJ4uSOr8f4uijQfCZeG4s/aOE/iL//XkXAtyBhkPmoUoVaTvyEu
 5IvA+c4elYe2aEq41wDBVorm/uZjH3GpTcHmguPQJ9US498NtY1B7RNA81v/zYnAqsQQ
 VaK8LC+AvSfytjJ4z2rQT20bGTBX02BKqC2pg7i+P5AiP5LGieH6QzerkAIRT+icdSAG
 Qcig==
X-Gm-Message-State: AOJu0Yz0ME2L/FK78kqPkkZSgdV8FkJJLkKLo/96nLYgxTB/uiyQUm7U
 Zf3yr1SzIr3vMPhM9ebZdLL0YoUtHTkUhEVLWPDF8qdz6pJN16in7V60ZFT6o7P5dVyPutpDd+4
 o
X-Google-Smtp-Source: AGHT+IGXTB0g2oaucEAbhB74FVaVN9LhSoP6sdfE3PWpd437XXtRlCm0ITZgJpjGpf0KgzyD6izFnA==
X-Received: by 2002:a5d:604f:0:b0:33d:f60c:53e2 with SMTP id
 j15-20020a5d604f000000b0033df60c53e2mr658853wrt.11.1709913018461; 
 Fri, 08 Mar 2024 07:50:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f2-20020adff8c2000000b0033e7a204dc7sm856080wrq.32.2024.03.08.07.50.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 07:50:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/14] target/arm: Don't allow RES0 CNTHCTL_EL2 bits to be
 written
Date: Fri,  8 Mar 2024 15:50:05 +0000
Message-Id: <20240308155015.3637663-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308155015.3637663-1-peter.maydell@linaro.org>
References: <20240308155015.3637663-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Don't allow the guest to write CNTHCTL_EL2 bits which don't exist.
This is not strictly architecturally required, but it is how we've
tended to implement registers more recently.

In particular, bits [19:18] are only present with FEAT_RME,
and bits [17:12] will only be present with FEAT_ECV.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240301183219.2424889-5-peter.maydell@linaro.org
---
 target/arm/helper.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1c82d12a883..37845218527 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2968,6 +2968,24 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     ARMCPU *cpu = env_archcpu(env);
     uint32_t oldval = env->cp15.cnthctl_el2;
+    uint32_t valid_mask =
+        R_CNTHCTL_EL0PCTEN_E2H1_MASK |
+        R_CNTHCTL_EL0VCTEN_E2H1_MASK |
+        R_CNTHCTL_EVNTEN_MASK |
+        R_CNTHCTL_EVNTDIR_MASK |
+        R_CNTHCTL_EVNTI_MASK |
+        R_CNTHCTL_EL0VTEN_MASK |
+        R_CNTHCTL_EL0PTEN_MASK |
+        R_CNTHCTL_EL1PCTEN_E2H1_MASK |
+        R_CNTHCTL_EL1PTEN_MASK;
+
+    if (cpu_isar_feature(aa64_rme, cpu)) {
+        valid_mask |= R_CNTHCTL_CNTVMASK_MASK | R_CNTHCTL_CNTPMASK_MASK;
+    }
+
+    /* Clear RES0 bits */
+    value &= valid_mask;
+
     raw_write(env, ri, value);
 
     if ((oldval ^ value) & R_CNTHCTL_CNTVMASK_MASK) {
-- 
2.34.1


