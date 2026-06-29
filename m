Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6DFC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgV-0007pG-NT; Mon, 29 Jun 2026 08:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfx-00072e-GU
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:22 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfv-0007aB-Tj
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:21 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-691c5776f35so4922363a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734478; x=1783339278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uABLgJwHmKoW5wIwYEcwRXxpSE6Uum9z9tY7YjVQSII=;
 b=szr4o+OkdyyXnKVL5+r844eVRY4BlMgpeiYLTVJM8ivJf5NAPiT1IDkXGmAsW+y9Hz
 7RLdzUVJNpo5prVKuIYaaZbfdY5m8EM4DMfy1CVtQ6oho9PD7L2Pk3ji4zFAgIArcVY/
 K1/LyZ8obfuCrmlJ7SgZigyto2wTfCoD1su2xaAGvsdQMuQLrmbYAYYSP+56Suw8rW4y
 r4QGisgGEPwlHFYHxTy5WZDDBKZ7V91MRWe022F2jEvAsjzCIZBu3ADmI8v6yOCsmJDw
 LpKQs58S4bTTV7paUox6muW79KRQaM12MkQ4eFwgnTfeopY+ByHWW1oiTDS62MchQq2q
 IxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734478; x=1783339278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uABLgJwHmKoW5wIwYEcwRXxpSE6Uum9z9tY7YjVQSII=;
 b=XDB2EDJuiKXAKWoIgRxBQeIoMcU72AFRoSZu6Rl3ReLfA1ZGCDAFMLxIf+7IjUVG1K
 fIiYTiDHBHiDYzdwpsCpo63KUIKy/+8UAOFrn9md+WfAyzQStjTf2HwcwPmZR3F0wzEI
 auTiobu8vmt/0sWofsJf/zw8vba1heRONeCgFqnX7cd8RnazM+1ha15/QIkhONzqWpNH
 XDWr7ocuqrgLOHRaoBA9lcemzZNv0lZPo0tA9dDpCbyaIkTqIPSZ+S2mXrmlbUYJMcpw
 cV7xGbgFHfWl3VmWZC44SMJyBaDzfDcO5FD6LCzjpGwwN5d0yJgklPvRdd6ywnw+IizI
 9JDA==
X-Gm-Message-State: AOJu0Yyb1xb3j3ePYz5aE0HFit0ztSuDayuhwDUnfYMxxeiouDwl/DHW
 YnoeAfSrJseHK58pmAtbdKdXwSVC1mInhg84UdwaQv8aBlbm/OxsAiKrP0WEeRjt94JSwFdqzKV
 Bp6kr
X-Gm-Gg: AfdE7ckaGaDlF95j3lFhgbiaMXyOEAxfPlJgBXOSJBBSXRQZWaTaqaoL2wpMNNGJ8aU
 oa36bVyaVhRKsw0tdJWBWfIj4TWhOGS3Rvkp+8ouhI/AYeqcGvmMfufeDCytBRIer53S+nuV6s+
 CDSJxxa6+2nujN8w4LjQLiCyMR8DMSgDvHr6jtb9aNmAslJkFG4TFYTbD/P0t92Ue2Dl9kbY5hh
 1W/u2mwj9G5vhPLYMzOmpzxex6FU3hyunF/HGAVM0XIQu9M75ULkJuUL83qIIMyOuBN0H5ylbsE
 eX0vkD90VCV2L+yVPIXPXxCoSbQEgheILZX5LPCzHgO945K9ZKPJsKJMDpxnhKU5MCZjchJlVq6
 vJ817a5MqWP4K/uRr0tVT8bUO9DWGUde+6FaSnw92J7ULa1AoUvEgae/IAfMTMfB2O8/OR+55Rx
 qQjfHyYKsxt7giBpcpa/Yy+e5nZajzKwCxlht0+6I79wCoYPZlP3ubEC+ALEi8IxSlNflRHFUkV
 CEe10yBq/PBgMmJW2XnIA==
X-Received: by 2002:a05:6402:43c5:b0:698:5f35:a8e0 with SMTP id
 4fb4d7f45d1cf-6985f35b11dmr1979746a12.6.1782734477953; 
 Mon, 29 Jun 2026 05:01:17 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/54] target/arm: trigger timer recalc on HCR:(E2H|TGE) changes
Date: Mon, 29 Jun 2026 13:00:20 +0100
Message-ID: <20260629120032.1645265-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Toggling the HCR state affects the offset calculated in
gt_phys_raw_cnt_offset so we should trigger a re-calculation on its
change.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260624124527.1018912-6-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 20165dbf48..93e3d8b575 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3716,6 +3716,7 @@ static const ARMCPRegInfo v8_aa32_el1_reginfo[] = {
 static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
 {
     ARMCPU *cpu = env_archcpu(env);
+    bool hcr_change_timer;
 
     if (arm_feature(env, ARM_FEATURE_V8)) {
         valid_mask |= MAKE_64BIT_MASK(0, 34);  /* ARMv8.0 */
@@ -3807,6 +3808,10 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
         (HCR_VM | HCR_PTW | HCR_DC | HCR_DCT | HCR_FWB | HCR_NV | HCR_NV1)) {
         tlb_flush(CPU(cpu));
     }
+    hcr_change_timer = (env->cp15.hcr_el2 ^ value) &
+                       (HCR_E2H | HCR_TGE);
+
+    /* update */
     env->cp15.hcr_el2 = value;
 
     /*
@@ -3828,6 +3833,11 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
         arm_cpu_update_vinmi(cpu);
         arm_cpu_update_vfnmi(cpu);
     }
+    if (hcr_change_timer) {
+#ifndef CONFIG_USER_ONLY
+        gt_recalc_timer(cpu, GTIMER_PHYS);
+#endif
+    }
 }
 
 static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
-- 
2.43.0


