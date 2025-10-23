Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC3BCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwjU-0004h4-9A; Thu, 23 Oct 2025 10:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjS-0004gK-Vh
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:02 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjQ-0005Xa-8z
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:02 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4298a028de6so588098f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761231359; x=1761836159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AGZpsqJmNFV2S3U5w399Aimk84khi2fK7lf+2CsSRB8=;
 b=u0GXwagKeYwUEEniqzqMeVjaahQsT4HBMzf18ZETaykD97SCX/E28YKMJtj7DcSHos
 MqdsCA1TjhwincqEL7dEGsE1f0AlOPMCM+YZolCLBXuVaYE1Dv0Z3MrDf0aPHME4Iy4z
 PmzfhJrRKxoUgGTBZ+GtauLDW4gWdMATcLXVkIwC+WXtoXVGAZAGyvI/ATI05w99qZPZ
 9Rvy60MkX7RC1Vw4Hx889Se0PtO+5dSD0ye7x9uWxSH1xXMsNnclcLfKPS/M7LwBbS2T
 FV/iOIZlidw5ULSHfw9C/J96ZQEHSThAcCnm2pywrgJlbK5ldgyva2bDP36yoYFf9l7V
 DGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761231359; x=1761836159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AGZpsqJmNFV2S3U5w399Aimk84khi2fK7lf+2CsSRB8=;
 b=uIj1JT+Rd//0FKw2uDRxVrcQZ0ecAW7c/lTAh+K17HE77TwU+qpdUcdsZysrTtDkAC
 sLDbiqHrSBumje/SUIvFmr7+Hg6UyvWWJDLTiMwCIJtp60angW92k87qXutyvHD+WiiI
 1TmH9xO7Qx96lIk05QRi3KnLaep5hO1SCr+Jcm63ZhyxORuRPHFeSGptU8YUKXMd1gNV
 NHv+yD8FEa6TcpnkfG+ccq/DEaq4+QCg0fn5mGX5ntlqCbQdfb3n+JUhLuyqHl5Hld5v
 2yn5IMbCMvG+0O5wIawReIeo8EioEqz5hX55JXt2bFDJfbZ9vPCSbWoh2XBeibwP1DXL
 xciQ==
X-Gm-Message-State: AOJu0YxBmM+P+jybP3XGwiLFpujqiQ53hbeJYMRFL0q38vh7ss8e3PV+
 C2+BZmdTmY2mhvQQDFgYAbCmnadG6cMIOiMpAGRTr6uwOCwF3qTgHK++Rkk9kLK3fXpirmQ5z3k
 c4kiU
X-Gm-Gg: ASbGncu7LleiC1Bn1FWkJaivhNKLhr54d9F3/XeQP+yE+iI2vjgqZMxOXsoYUbdc9Bf
 0HxXKilefH5/nWq0WT+EC+Mnl94UPQNPZHY1DBAuzuKpX7YcDjt60Pln7teWUy8/6ZkDgoPKJIP
 sVkHeDibXk0cpslELqNtjAiw3C+oETEMmU4MVWbHHHZBPoKT0PmyRcLcKPMPDG04lbhrLCfrPEl
 MixPlCtG8dnJGimTSlk9wUVmHqoISxC4+2yOnDeDvwXeXvu1jta+U/5dfCpdN3Rs8emzHp0E+mb
 O/aJvKiihNJOM+z0Hc3Qcq7TIpUyMR/oCbciX9eOzEbXJtf6oHiDXmhHUCTzu+v46wTFkPEIFjz
 N4FfHbxwX5lC8UeQGmzJmwDVxQxiIVeqO7PaHtjEw7p8RkPAg38b1cTyTykQiP4Kc080Zxw30q2
 KYKOXwqOtVA9d7cx3/
X-Google-Smtp-Source: AGHT+IEJzQc+JKCUg/EHKHWKuUiispFgfI/O65CHj1dZkykJMkPKZsI9amP3F0AGHHdF9xsG4Y7a4g==
X-Received: by 2002:a05:6000:4012:b0:3df:9ba8:21a3 with SMTP id
 ffacd0b85a97d-4285326765cmr5237609f8f.18.1761231358705; 
 Thu, 23 Oct 2025 07:55:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898acc63sm4398465f8f.27.2025.10.23.07.55.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 07:55:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/16] hw/intc/arm_gicv3_kvm: Drop DPRINTF macro
Date: Thu, 23 Oct 2025 15:55:40 +0100
Message-ID: <20251023145554.2062752-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023145554.2062752-1-peter.maydell@linaro.org>
References: <20251023145554.2062752-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

We don't generally like DPRINTF debug macros, preferring tracepoints.
In this case the macro is used in only three places (reset, realize,
and in the unlikely event the host kernel doesn't have GICv3 register
access support). These don't seem worth converting to tracepoints,
so simply delete the macro and its uses.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/intc/arm_gicv3_kvm.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 9829e2146da..405496c7bb3 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -36,14 +36,6 @@
 #include "target/arm/cpregs.h"
 
 
-#ifdef DEBUG_GICV3_KVM
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, "kvm_gicv3: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
-
 #define TYPE_KVM_ARM_GICV3 "kvm-arm-gicv3"
 typedef struct KVMARMGICv3Class KVMARMGICv3Class;
 /* This is reusing the GICv3State typedef from ARM_GICV3_ITS_COMMON */
@@ -708,14 +700,11 @@ static void kvm_arm_gicv3_reset_hold(Object *obj, ResetType type)
     GICv3State *s = ARM_GICV3_COMMON(obj);
     KVMARMGICv3Class *kgc = KVM_ARM_GICV3_GET_CLASS(s);
 
-    DPRINTF("Reset\n");
-
     if (kgc->parent_phases.hold) {
         kgc->parent_phases.hold(obj, type);
     }
 
     if (s->migration_blocker) {
-        DPRINTF("Cannot put kernel gic state, no kernel interface\n");
         return;
     }
 
@@ -797,8 +786,6 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
     int i;
 
-    DPRINTF("kvm_arm_gicv3_realize\n");
-
     kgc->parent_realize(dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-- 
2.43.0


