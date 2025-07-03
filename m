Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD90C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHie-0004mI-Te; Thu, 03 Jul 2025 07:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHfh-0006ml-KY
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:06 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHfU-0003XO-QL
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:59:54 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-450ce3a2dd5so43401915e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540391; x=1752145191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+WutgSqJXFykFHZTQaYKZd8VkTwajJGbTU9Mch4jWg=;
 b=MzYsJFueLFbgQ0EdUphQWw5SQdWOShBlR5MMxtviPGuqKtwnOpbdTcSHyUKXbnA1b5
 +33+6fIl10pZq+9W86y3IyDSLFcuHTl5QnJDANyaVpp/r7xut0eK2JEht9XjuC2QHX0L
 o6nWoFha99ROGGgt3bGNiVuj/rTZRAXvhczx7kzQmW02z+yPzBVeG1Ras0TrbXtDi60q
 gJPzKvsEJs14wBA5MVOEXccJRamdKvVOWEBaak7vu1X2EJ9n88xPpE/FnIBmdt9W6JSa
 QHHMx/HhvSoLrlCmyy8/uG3cxHbbTlwTJC1sa5APXeE3NwS1dn6Y6CNYgTyFwKS6e7Tp
 uN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540391; x=1752145191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m+WutgSqJXFykFHZTQaYKZd8VkTwajJGbTU9Mch4jWg=;
 b=E9I3+V/gU20QsyqLqk3j/G9AHFFXoNxXAzT6NxEctB2ebmYgjqAcWnUsmFxuuMy+p/
 d8IT38H9Uf6KMTatkZcTUZeDYcvsXJQXMPXq5jWPmWc5Fyd0MDNGd3pg7nxrwjCbmxE8
 bXQrnb+r4bVG+cmWq0uH07zdODUuzzHY1AEtutpdrrXgASJEclrmNEnr0ErSAijOe0jD
 uC3BdNIc0hhOOboIc0FPQ5/sDviMSI6UVIaQMwI8/6FfkueLBftKjOd6PULjycp+6iqG
 s5/BYj3i7KWdfwnCvAc2fP+q58ztvCIY1tQzonUcQlFaI2tEyS+xCjfJB8W4d2JPnlNe
 /wkQ==
X-Gm-Message-State: AOJu0YzZuW8SQqGDpbS2Ekk0GjqMxqbYv5ILqLWU/ccJGRR/VdBsk1lF
 0g4EQL6UW38agRvYpfxENWqgmvsdDVJtSZ72GkOPDhYJBlShHynQR9Z+/DJ6Rnjxv/HvYCvlCSf
 eBjv1BHE=
X-Gm-Gg: ASbGncvkZ34C7JFH3nb5F1YQsntawRttkWrpXkpQSDv3mCevHIfwPPiAVC+2sJ2CH8g
 +1XsKyqgOSs4lPXnZDhhYz/UeakOzMxS748f3x3ZqoS8vEggqlEG3Ov0xMq37iXNdsB/e1/Muei
 stbgNTPAOUSkrkbOCN2Lhcg+zcncqK1mvmiNa505Mv6URWYkoFdOO3Hvd1zQxgbd2NV2RMChfaT
 dy8uMpHxiASFNoYaC7G8GIn/bURyQ8mePCyR754+TmQWWoDxN9sD7OiAlhloW9p2bGXN7Gl4PyK
 AMnza1sb/ZOEvkNVyL/zj6oldGNgFqUk238xDx0sSsUC4DxEnmhucgB0rnbnvUuLKwSZo5qS2CL
 yrtzm+DePBmk=
X-Google-Smtp-Source: AGHT+IFkJTWECY2pugXbhxGY6HjeCgJxFNGAomzZaEG1B6sFjMYNKg+pM1wp3bta32pi3CVqInJhiA==
X-Received: by 2002:a05:600c:6792:b0:450:c20d:64c3 with SMTP id
 5b1f17b1804b1-454a370308cmr75309655e9.18.1751540390713; 
 Thu, 03 Jul 2025 03:59:50 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9989423sm23583475e9.19.2025.07.03.03.59.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:59:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v5 47/69] target/arm: Use generic hwaccel_enabled() to check
 'host' cpu type
Date: Thu,  3 Jul 2025 12:55:13 +0200
Message-ID: <20250703105540.67664-48-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
index ebac86f70d3..e37376dbd2d 100644
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


