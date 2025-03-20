Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C826EC36000
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOSP-0006qr-KI; Thu, 20 Mar 2025 18:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPn-0002cU-Rp
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:31:04 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPP-0007Cv-0Y
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:31:03 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-224019ad9edso32567205ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509836; x=1743114636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fL3ZYVUJJ3Fd0+aNoGxPeRJrA53EVcQamm5mrQ+p0v0=;
 b=qsxpKgNed01pLLo87NsSOszOC1dEfTVC0PHK+2Tf7K6B4dYgbNf6Ag85+dKBnSg82r
 jOt/8T2Rp4as1pdrEWH45IkLhHde8hiiftKIAwWcUnXoFmXBYwm5zZMWLfqab8r4gbAd
 iFO9imUfHJfLi30bu/cPE/xjEDMBVwg6lXbIkpOq3ISZlW1hbHKSjLMFSoiFXU8xkIeV
 HekX7ofayg9laRFVaF+xb70Z/vYZvaKb1345wJZaWLVd9hrYxuRHJIunPPV4kwBI0SzB
 atrsMz4cfFb4UjNq128dvy0Xy6UIPYi5PXkKNTsvOSFjjVhDCUIOXXVYbEyAnGYtIJ9X
 EsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509836; x=1743114636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fL3ZYVUJJ3Fd0+aNoGxPeRJrA53EVcQamm5mrQ+p0v0=;
 b=WtbadwatLwPn5x/GoS6S3fYYa8zYzJ1uQFYkmldjTN0OSKnimGuwetOmzgoy63w/7W
 izGE/YcG8laIBe0bHrb3cbti+FvxraGe4WUv5hBEf26y1axK9qBVrNrGEzUeydvh0Ira
 roz2Kb+ijY+yPOpURRydBCwEofnO+5/FFbt7Wyv84IX45Vj6r9U7hPOuHSf1tR7tLCE9
 ngBN3IVA4YAIuBuS6aldcikrNfMqWk4UmRy9PKf+MHw8qgDy5ftaBlyjXuPcYhI3akr9
 BxzhXemU4kMYfP2iO63HRcZUteUaJ9FnTLUlyCHEClBnJczyBxXNeyNbPwYPEX0jLa7O
 7/IA==
X-Gm-Message-State: AOJu0YyAA+G/vfjR7T8qC81chHWDihFKqlj3QA6utGVxDwY8rPVSTguS
 qteOujiB1qNazxPYfAufPeIKcyRHlBaw0GSg3n7AXwMfEB1kOJe5LuBJtKRNBgzW+iZznutL5QA
 P
X-Gm-Gg: ASbGncsENRYLCdG1CjVlkK4vFiPQ83NkT0dnX2dd7Ao7n8tcnRIoVPW+l7s47L2qff9
 nxUHiszdbTU3pxMDKtvEq0uctotfS7hWMDbdVrImLS5EkWXV/3vtS21K6bRhpYDZJfFbIBakJ7l
 dyF1qs1EXCxktRIqajrhXU8T3uHHjKUCMO5rmiV8kfWsQR08sXZBeKsgScvmgJ32OXcTxaNgRtQ
 YwdX0bRIE+Y7dQESdt7x41u4mTaZ9aT6SVd6qv/p7W+VYKmITEf3Jq6PJ2SisGJ2Ajmix6uj0NG
 uOsRNv67XVF4x15HEb+DLHXHjrFQ+HG//UQ43kmx28ft
X-Google-Smtp-Source: AGHT+IFSTCeT7YVoPbAHuUe991xoUWlgfGrS/bDdF4/Ez/lU2sHP5ScxJ+1FSK8cU5+QipVe/utZzg==
X-Received: by 2002:a17:903:250:b0:223:635d:3e38 with SMTP id
 d9443c01a7336-22780c76135mr18937465ad.15.1742509836244; 
 Thu, 20 Mar 2025 15:30:36 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 25/30] hw/arm/boot: make compilation unit hw common
Date: Thu, 20 Mar 2025 15:29:57 -0700
Message-Id: <20250320223002.2915728-26-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

Now we eliminated poisoned identifiers from headers, this file can now
be compiled once for all arm targets.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/boot.c      | 1 +
 hw/arm/meson.build | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index d3811b896fd..f94b940bc31 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -14,6 +14,7 @@
 #include <libfdt.h>
 #include "hw/arm/boot.h"
 #include "hw/arm/linux-boot-if.h"
+#include "cpu.h"
 #include "exec/target_page.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index ac473ce7cda..9e8c96059eb 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,5 +1,5 @@
 arm_ss = ss.source_set()
-arm_ss.add(files('boot.c'))
+arm_common_ss = ss.source_set()
 arm_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 arm_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
@@ -75,4 +75,7 @@ system_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
 system_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 system_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
+arm_common_ss.add(fdt, files('boot.c'))
+
 hw_arch += {'arm': arm_ss}
+hw_common_arch += {'arm': arm_common_ss}
-- 
2.39.5


