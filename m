Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD996C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvau-00008j-D5; Fri, 02 Feb 2024 10:36:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvas-000067-2r
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:42 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvaq-0004Qu-Gy
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:41 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5113e895660so77666e87.0
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888199; x=1707492999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QRkC6R0A/Ijw4AEfBzkD0qNh2L8zWNNbkytmxmpXoIc=;
 b=gU2miu2P7k7oQubb/N2xRy5//kpVWeCfItUx0o3bso+9Kp+W/fTpYnxYpYzrKPciW1
 g+EyYIurLAeP9UBM53YltsFACJnimnqehCXy1vtkBcJ/OD5UWF423wXBLie1S/g8f8Zz
 52M0CnP4I58jaSMkP9BYcQnlL9jv0sOQFT9ZXDpThsSeBivKVd/N0vfTJixukNXpjqP5
 HamczlptatubjCKAfXMWlGL4mZTCf5NGyHQddxc/+VKn6xCuowfncsn+Z159hKl7yK+j
 iztd7eN7AAztW13R4DdHa7iai8JYTV1alNHsv57Kl0G6toxK53jxVWIv1A60EnPdw4oW
 T7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888199; x=1707492999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QRkC6R0A/Ijw4AEfBzkD0qNh2L8zWNNbkytmxmpXoIc=;
 b=Mssz7xn6eKMChls9Do9TVnT8OrtRvCbn8fFapkjuxJVzkTz8ifPwFwJkup+jKKCz4A
 KyE5Mj2EwB6795oWxZ77z6JoN/rO6J2nHwLm3HUH120VJHgi5ROqKl/xMfSbCvuzLVK4
 mCRG7iPTb5e6NaTYjinTM6XtLVm1Z/bngS5X8NLij4NLx+cf7gDon70KUIS+iMHHBmwz
 7QosW3Ujs97mkYhGyAzH6g3c8DibH+87bXG4yALXvmak6Ymmwxf/SDfFoGR/XZY6Z/a0
 RF6yVP9EpxmhlsfuwLnGwbZ5pHRCaxwl/Ff9IWjpu00K62aqnbOmnPPIOUVZlW36mrcZ
 gsWQ==
X-Gm-Message-State: AOJu0YzEZh9OhSxqApQtgroglVp2p6B6mLI7TERRKr/qPpVly96OFi2x
 cFAQX7iCNOAsdVrSyEiiuJ78uCR3dIUsqA1wlruwLgxCq2FouTd8DTjaqB183WuWNSV/nQ1wuE+
 6
X-Google-Smtp-Source: AGHT+IHFR30meajtkVe46CiVUIqFDI83OgR7aQCJY2+NIyZbuIy9vXr5yrN321+7fWIzlPFpI5r4Xg==
X-Received: by 2002:ac2:5ed9:0:b0:511:325a:948b with SMTP id
 d25-20020ac25ed9000000b00511325a948bmr1652424lfq.30.1706888198784; 
 Fri, 02 Feb 2024 07:36:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/36] target/arm: fix exception syndrome for AArch32 bkpt insn
Date: Fri,  2 Feb 2024 15:36:02 +0000
Message-Id: <20240202153637.3710444-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
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

From: Jan Klötzke <jan.kloetzke@kernkonzept.com>

Debug exceptions that target AArch32 Hyp mode are reported differently
than on AAarch64. Internally, Qemu uses the AArch64 syndromes. Therefore
such exceptions need to be either converted to a prefetch abort
(breakpoints, vector catch) or a data abort (watchpoints).

Cc: qemu-stable@nongnu.org
Signed-off-by: Jan Klötzke <jan.kloetzke@kernkonzept.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240127202758.3326381-1-jan.kloetzke@kernkonzept.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h |  8 ++++++++
 target/arm/helper.c   | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 1a49767479f..3244e0740dd 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -25,6 +25,8 @@
 #ifndef TARGET_ARM_SYNDROME_H
 #define TARGET_ARM_SYNDROME_H
 
+#include "qemu/bitops.h"
+
 /* Valid Syndrome Register EC field values */
 enum arm_exception_class {
     EC_UNCATEGORIZED          = 0x00,
@@ -80,6 +82,7 @@ typedef enum {
     SME_ET_InactiveZA,
 } SMEExceptionType;
 
+#define ARM_EL_EC_LENGTH 6
 #define ARM_EL_EC_SHIFT 26
 #define ARM_EL_IL_SHIFT 25
 #define ARM_EL_ISV_SHIFT 24
@@ -94,6 +97,11 @@ static inline uint32_t syn_get_ec(uint32_t syn)
     return syn >> ARM_EL_EC_SHIFT;
 }
 
+static inline uint32_t syn_set_ec(uint32_t syn, uint32_t ec)
+{
+    return deposit32(syn, ARM_EL_EC_SHIFT, ARM_EL_EC_LENGTH, ec);
+}
+
 /*
  * Utility functions for constructing various kinds of syndrome value.
  * Note that in general we follow the AArch64 syndrome values; in a
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 945d8571a61..a0041aa0ec7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11015,6 +11015,24 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
     }
 
     if (env->exception.target_el == 2) {
+        /* Debug exceptions are reported differently on AArch32 */
+        switch (syn_get_ec(env->exception.syndrome)) {
+        case EC_BREAKPOINT:
+        case EC_BREAKPOINT_SAME_EL:
+        case EC_AA32_BKPT:
+        case EC_VECTORCATCH:
+            env->exception.syndrome = syn_insn_abort(arm_current_el(env) == 2,
+                                                     0, 0, 0x22);
+            break;
+        case EC_WATCHPOINT:
+            env->exception.syndrome = syn_set_ec(env->exception.syndrome,
+                                                 EC_DATAABORT);
+            break;
+        case EC_WATCHPOINT_SAME_EL:
+            env->exception.syndrome = syn_set_ec(env->exception.syndrome,
+                                                 EC_DATAABORT_SAME_EL);
+            break;
+        }
         arm_cpu_do_interrupt_aarch32_hyp(cs);
         return;
     }
-- 
2.34.1


