Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D15C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2fe-0005jL-Of; Wed, 02 Jul 2025 14:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2fb-0005VQ-TD
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:58:59 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2fQ-0002yO-CN
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:58:59 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-453608ed113so49578525e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482723; x=1752087523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+E/J0LnrR39EtKwfOEb6mQjjQJ2XUYL/z1tOblZJ55o=;
 b=CosePY0MF28CKNfnj5NRvcOSdWKIoUu53ROHV8x2szra7uFIKu84M3iQkca99dJK+e
 UEWypT0GakwqG4QVnv3lduY4nvLwE5nrpcUq3EORwG16m8MEo9pEvhZ0Jf4iEgxhLzQx
 tURmlEA+hC7yZPwPiEL8yCHYxCWnbyG82hCekxKMsZykGb741VU/oZMuv9TUgChqHnua
 cBhjaVtZFkCKr1FLflx48UETQBGRv8BWTbj1qzWvSPydu4XTSjcelyz5TJ66mU1/Aj7q
 66PttKJKc2vS429oc9/TaRM4N8LKBkb5Q6KqotU+rOHQ/pVIF2cFSMGe015pROq2mGxx
 Kc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482723; x=1752087523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+E/J0LnrR39EtKwfOEb6mQjjQJ2XUYL/z1tOblZJ55o=;
 b=KgUbX9pGQe4x46Es8A12ytkmyjo42NRhIyK68Pxe1do02GcbBDbCiIxEYiLlKFviQC
 TrCl9Yu/K6ZhJo4hlSgaXU06OZ33CcquaJDP+3CTsH6KwCBjMRqJbf4dyvVisuL1dSrw
 JNJisx6U6FjgYkfMNmFElc5cJeQSKgOQCxmZTeaEFX/CkCUzAFdlLA19lhIIKAjfK4rU
 hnw+gOWwFtqETUDG4DF/FWdXPFFj5mfrcTbgRn7YauuNvHeJ1XRKmLHyeaOY1HfMbUho
 T8XFJrLKMcdCJVltnLfWPTc3jzD1Jw1COgDieYmWLe63xdrrxc5X/knrkBPwkAU5680g
 KQvQ==
X-Gm-Message-State: AOJu0Yxl8AMLA8FkbVm2p8oxlhiOgngdw5/CWw4jGgoZpQ145H/OLd5m
 xO5aOR+/h4MHF2rEj800eP+7VEosjx+J9m0p6poe/s/bwk1SURvY/2k5+Wu/94/t57O69RRIqDX
 02yTl
X-Gm-Gg: ASbGncuzCmpdAGj+NHCVJ7BdzwbytGLl1Fb5Eb4n8it30agh5XYwb8pwBeKF0gaa3ie
 J9G+Yd0LaqEQK9LU2LrfRrYHMODE7NSPkfWZY8BRm/f5qqKM5FYeXOweyYcmgQYRZMGZT6ltblL
 Lk4Kozng3M1+izm/bA/8iinsMGSjaTELsRcfYCKfe4T1dRvoRGi0/j9LDp09G1dbk66gV+wu4hP
 w02OPCS7y5XtFX3NllGHOgyMX3QblEckk1nz84NiaAsuynC18Dd2sEp2aCnWZb3w9ymPM3YEZ4l
 8jnE7yh1//ZsPgYzJHYBs4la5dUdRStZ6vNmIysSbXZ1jWlYpQHBmxNlymcPWhMN+SokyohqOFL
 E3nZ6C6rs6BjeObsWLAC0lHCh2abvj7vkz9fq
X-Google-Smtp-Source: AGHT+IGHn6ZxpPshfR5wvuf8R3zCvqso2bXEWooi9BkpGmBlEXHOWIpLivNJNaJgccbmQciYmUaFuw==
X-Received: by 2002:a05:600c:3148:b0:453:aca:4d05 with SMTP id
 5b1f17b1804b1-454a9cb3b11mr9056495e9.31.1751482723163; 
 Wed, 02 Jul 2025 11:58:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bcebf7sm5793165e9.21.2025.07.02.11.58.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:58:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v4 42/65] target/arm: Use generic hwaccel_enabled() to check
 'host' cpu type
Date: Wed,  2 Jul 2025 20:53:04 +0200
Message-ID: <20250702185332.43650-43-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We should be able to use the 'host' CPU with any hardware accelerator.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/arm-qmp-cmds.c | 5 +++--
 target/arm/cpu.c          | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index cefd2352638..ee5eb1bac9f 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -30,6 +30,7 @@
 #include "qapi/qapi-commands-misc-arm.h"
 #include "qobject/qdict.h"
 #include "qom/qom-qobject.h"
+#include "system/hw_accel.h"
 #include "cpu.h"
 
 static GICCapability *gic_cap_new(int version)
@@ -116,8 +117,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
         return NULL;
     }
 
-    if (!kvm_enabled() && !strcmp(model->name, "host")) {
-        error_setg(errp, "The CPU type '%s' requires KVM", model->name);
+    if (!hwaccel_enabled() && !strcmp(model->name, "host")) {
+        error_setg(errp, "The CPU type 'host' requires hardware accelerator");
         return NULL;
     }
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a59a5b57af6..1e782865233 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1978,8 +1978,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * this is the first point where we can report it.
      */
     if (cpu->host_cpu_probe_failed) {
-        if (!kvm_enabled() && !hvf_enabled()) {
-            error_setg(errp, "The 'host' CPU type can only be used with KVM or HVF");
+        if (!hwaccel_enabled()) {
+            error_setg(errp, "The 'host' CPU type can only be used with "
+                             "hardware accelator such KVM/HVF");
         } else {
             error_setg(errp, "Failed to retrieve host CPU features");
         }
-- 
2.49.0


