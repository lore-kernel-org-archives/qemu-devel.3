Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84994FF885A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkuO-00046B-Tz; Fri, 01 May 2026 06:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuK-00043i-6b
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:40 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuI-0000G8-Ij
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:39 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso16033095e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630537; x=1778235337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FNx1Ywj4Qu3y0jOumawWKaDs7AucOHa5C++JOEYBlgo=;
 b=Ap27P3zOp70CiIHWgic7Bs5v7IO/1c2PgVHQ3CrscKwaxf0SwIjHchQhRTdzmaqAaY
 zQmJyaWJ55J5MJrk7uyKrauXEoxPggW0Rtn2FzAZeTfnJ2s4P1VCTdfPnaeB3nxFqRG3
 lw07Z7DbT35Q0xB+FRfaZatxIPFkBTBUXWuIqlKLcWqbpEvy+L+rmdyf79sxYPmahELp
 aLZfOABsgPcEfYAGhJ4mxAYebWq5VN47DXsNUfKTyxzPijTrCDgGEqySUCkyxpTt7nXO
 cKgD2+gRZ2so/ex5mK/1bOsy84Puul+2huTO1jYFus/+hbAeNtXS9pviYRZEHKxmIARz
 mRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630537; x=1778235337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FNx1Ywj4Qu3y0jOumawWKaDs7AucOHa5C++JOEYBlgo=;
 b=pct2+yGKHu1Nenxf7mNVcfZ78/gQ/4lISOp0BN1NFcx1Yp0G82mJq9XCDlVAoyVeLi
 go6Fj3esj+eg9u16CQiXA1AS1JiewusJjjLLm+0AUSSHYpldQEwi57rB2rRy7FZdf8d6
 6Zvsl8CArhj2mfwBx74eMroUehbIBSz1CObiG3l9kU5U+Qvdq/BazqxScHDvFBFPKnNm
 wN8z/u5I/yjao8dIdNiOTZyNcAh1xEmrOglCzswM3nsYiAOhKVLTPGMjzqjSN4Wj7Pn4
 6BuOBCPWnfcQtH1d//FYSNyu2AJL/lvmJcGHdYSBtnpjfnH88z8SfhumfIfgsb288+7y
 RFHA==
X-Gm-Message-State: AOJu0YyzUb/aEdSfAPy9eAF5RL5osCSRhwO2K+J4RSk/QMjB0+nmT8TL
 3jtaRGyJgHU4eUkdi21Ix97CQEdsT/vigjq4h2T9WmZNgRmyNjurQcWr2ZztjNOy1DXyWqePKJB
 /9RM+
X-Gm-Gg: AeBDiesFoa7VS0pX2p9zkoew88HWEEA0Ps27VFQNbdSdGo+mowH9YOwo6nSJkSO/cXQ
 032vnaqBviGkB3+wW1C+Nrn+vf/KtsPCEzOmLulkjpKvX7qc0ldViBRDyYsA01UtqY82Vq0JkS9
 L9+rAfRb8lCnA4PoqiDNoZuOtwlwlLGAadUDbpmmGCeEQ5XZFph3UHRnPJL1vD24D4+SbRwT0QB
 kUM80DDj3ASMrxaIrBEwUyjGdDogQDR+/olDTlGZGEQrjMteQ6TUlgSPgypc0j2Aw71RxNHBG8T
 ERPgp8G2Fbq6BWF85d0ef9PGIfz9Eudf5Y898G9hhGpRd7LSrk4LqoLFno6550t0e/G+H0KQKPY
 3PpgjbEy1PPw8c+Zu+sDOye0STt6F9phk/2j9/2AJ8ehW1a4XUMNkn43sG7j23WYVxqgtJgvmFK
 8cjQDa18WcS4BElgsSJ1Lj47oTt96YRSu94AZVatNeH+MiWDLaLEhQLrkhPLZ/DvAFdqTQRy2/8
 RSDvQWKzfsimgXRG0EPjVSfhGUBrEq3fzWjjzmoiA==
X-Received: by 2002:a05:600c:8b21:b0:48a:6fd4:d3d3 with SMTP id
 5b1f17b1804b1-48a8eb99216mr39064985e9.20.1777630537073; 
 Fri, 01 May 2026 03:15:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/28] hvf: arm: disable SME when nested virt is active
Date: Fri,  1 May 2026 11:15:02 +0100
Message-ID: <20260501101505.3485916-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Currently, Apple doesn't support the nested virtualisation + SME combination.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260429190532.26538-13-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 5 +++++
 target/arm/hvf_arm.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 1894be6b0e..6062e08c49 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1206,6 +1206,11 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
     }
 
+    if (hvf_nested_virt_enabled()) {
+        /* SME is not implemented with nested virt on the Apple side */
+        FIELD_DP64_IDREG(&host_isar, ID_AA64PFR1, SME, 0);
+    }
+
     ahcf->isar = host_isar;
 
     /*
diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index 8029d48caf..59e19f6e84 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -11,6 +11,7 @@
 #ifndef QEMU_HVF_ARM_H
 #define QEMU_HVF_ARM_H
 
+#include "system/hvf.h"
 #include "target/arm/cpu-qom.h"
 
 /**
@@ -35,6 +36,10 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
         if (__builtin_available(macOS 15.2, *)) {
             size_t svl_bytes;
             hv_return_t result = hv_sme_config_get_max_svl_bytes(&svl_bytes);
+            /* Nested virt not supported together with SME right now. */
+            if (hvf_nested_virt_enabled()) {
+                return false;
+            }
             if (result == HV_UNSUPPORTED) {
                 return false;
             }
-- 
2.43.0


