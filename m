Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD4CFA1FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdmc-0004th-HZ; Wed, 22 Apr 2026 16:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdlx-0004Sh-SR
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:02:11 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdlw-0003HI-0g
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:02:09 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso51121075e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888126; x=1777492926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7YIc9Uus+72qElGOAoitBrtXHx1hU376Lko1zKcoR6E=;
 b=bxRu+Pf/b96AcNdGrAC0Qh2L7gZwjrJy8sbwTGS6VjlN0s3NwW/cjAmmiyLs0MZnfB
 9JLvwciKiCbN1J/5NKRO6QhwxcLLR4KqXFKQWY9lg2XpEbxjr/ldK5siZ+HwvlfGkklz
 36rpKqIf+d1ZaSAvuD+m0A30gAnnJaICxjWSnmtNXOICivveRGCs1NPcH5o1A6i4+0yy
 X5N2QKUJ+9QU7nDOTuhuU+NJJqj2Oybt8+AEgZGbBD/De1oRpnyhvxvhgPbB5zIFZq7a
 J6dXEwuMdB4zYfxxO1zwb0wWYQvpB6otBF/ePUTXJTbRLl6ts0EHzmeOZpRfREjrCzV4
 I2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888126; x=1777492926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7YIc9Uus+72qElGOAoitBrtXHx1hU376Lko1zKcoR6E=;
 b=FhWw4pTbbWXvpcqdtVwvP5d5+hQmHwkhrOiCr/lfReC9+TPYhR4bDsC1hTQGqJFOHD
 SRMaFqlIFj9do6Yw2ptBg+Q52HfTad7devRGvBmBJ/q+HEbeZ/uEjWbCmeIgsKGFwQlJ
 QbE2Rb1YSokbN9qa38KLmzYISMnfcnSmShlqe2cSHhltnVM4tIrVuHqoOxFMGayP/RGz
 3I9Coau6Hz/0Vvk/c2aAItuZloErec0SL6mAUgqcNvSmoHcXUdWpfCbq/bBi0Ofdlx1M
 3KQk76PTmj7Iv2+Y3oyd6jGeQB1IKLv6EgAgpJaxSozyBOOdu64St4RfJmNljiYA2WXd
 1law==
X-Gm-Message-State: AOJu0YwqQCjUsXiV1X318BQkns8HcxhMkzUJay2ep1cvFJKGgSMsXkDz
 9M2BSuuI23TVcyj72xiJDMSb/Pz+9wX/ouiGUehsXwxC0H6jD5wh5/lGLXQVmtCLm4drkmmoLKn
 Q7Hcy5YM=
X-Gm-Gg: AeBDiesM95p6J1yF/qWUcCgIXep8sl2TTtRVe/TMT1u3C3n/20pqIbCi5rAHLgW5O4Z
 RqcdpAashTwrlmtcakF/AXymDTUQC9V80Si0I50WWoDIkGv36sF0/adn8D5QYkrrMbQIJlEMgcH
 gtSWl3x3cHTG0AlhufpHxao03B7+w0MbTqAZMeG+Ii9GoryguCvW0epGqOwLQ8EmlsI6reLu5UC
 U0+Z+c7I7jmeTDDhwoEWRWIbo7a2OWNGHt4gYLl6Ue8FKRy6jBSWx5kI7B5Bl1MxusZBx86sH2a
 7R6TjreuMCMVnhxTHkrlNDpCcufylq62tDSdqVUJ7h7V82D9soja+jRhftavYdr2Id78sPeDNoe
 omBSAL1CYlt0OcM3lYJDLgpg4sQqKMcdO7UFRYpZ2iykFiuG1uBB/A1PSoxaVR3uaJ7zh6i88Wi
 N+jZse2MBeqKK8mMXPZSZ45N32tXA0VN4xwXv05Gu8PeNByK2b3ZYsAvkCiRgSOeaiWwTSpfPL0
 G7AROnd6BQ=
X-Received: by 2002:a05:600c:620c:b0:488:ae6c:42c6 with SMTP id
 5b1f17b1804b1-488fb7786c2mr359567175e9.14.1776888125815; 
 Wed, 22 Apr 2026 13:02:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4ffa8sm49166042f8f.35.2026.04.22.13.02.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:02:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/48] hw/arm/smmuv3: Avoid including CONFIG_DEVICES in hw/
 header
Date: Wed, 22 Apr 2026 21:57:34 +0200
Message-ID: <20260422195746.88865-37-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

By turning the inline functions into stubs we can avoid the
use of target-specific CONFIG_DEVICES include in a hw/ header,
allowing to build the source files including it as common objects.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-Id: <20260410200031.18572-3-philmd@linaro.org>
---
 hw/arm/smmuv3-accel.h       | 42 ------------------------------
 hw/arm/smmuv3-accel-stubs.c | 52 +++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build          |  5 ++--
 3 files changed, 55 insertions(+), 44 deletions(-)
 create mode 100644 hw/arm/smmuv3-accel-stubs.c

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 1ca2c80a933..85669d0e00e 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -14,7 +14,6 @@
 #ifdef CONFIG_LINUX
 #include <linux/iommufd.h>
 #endif
-#include CONFIG_DEVICES
 
 /*
  * Represents an accelerated SMMU instance backed by an iommufd vIOMMU object.
@@ -41,7 +40,6 @@ typedef struct SMMUv3AccelDevice {
     SMMUv3AccelState *s_accel;
 } SMMUv3AccelDevice;
 
-#ifdef CONFIG_ARM_SMMUV3_ACCEL
 bool smmuv3_accel_init(SMMUv3State *s, Error **errp);
 bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
                               Error **errp);
@@ -53,45 +51,5 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
 void smmuv3_accel_idr_override(SMMUv3State *s);
 bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
-#else
-#include "qapi/error.h"
-static inline bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
-{
-    error_setg(errp, "accel=on support not compiled in");
-    return false;
-}
-static inline bool
-smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
-                         Error **errp)
-{
-    return true;
-}
-static inline bool
-smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
-                               Error **errp)
-{
-    return true;
-}
-static inline bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
-{
-    return true;
-}
-static inline bool
-smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
-                           Error **errp)
-{
-    return true;
-}
-static inline void smmuv3_accel_idr_override(SMMUv3State *s)
-{
-}
-static inline bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
-{
-    return true;
-}
-static inline void smmuv3_accel_reset(SMMUv3State *s)
-{
-}
-#endif
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3-accel-stubs.c b/hw/arm/smmuv3-accel-stubs.c
new file mode 100644
index 00000000000..70cef66966a
--- /dev/null
+++ b/hw/arm/smmuv3-accel-stubs.c
@@ -0,0 +1,52 @@
+/*
+ * Stubs for accelerated SMMU instance backed by an iommufd vIOMMU object.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/arm/smmuv3.h"
+#include "hw/arm/smmuv3-accel.h"
+
+bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
+{
+    error_setg(errp, "accel=on support not compiled in");
+    return false;
+}
+
+bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
+                              Error **errp)
+{
+    return true;
+}
+
+bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
+                                    Error **errp)
+{
+    return true;
+}
+
+bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
+{
+    return true;
+}
+
+bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
+                                Error **errp)
+{
+    return true;
+}
+
+void smmuv3_accel_idr_override(SMMUv3State *s)
+{
+}
+
+bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
+{
+    return true;
+}
+
+void smmuv3_accel_reset(SMMUv3State *s)
+{
+}
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index b187b946f04..3be1252c4f1 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -84,8 +84,9 @@ arm_common_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
-arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
-arm_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true: files('smmuv3-accel.c'))
+arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
+arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true: files('smmuv3-accel.c'))
+stub_ss.add(files('smmuv3-accel-stubs.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_common_ss.add(when: 'CONFIG_XEN', if_true: files(
-- 
2.53.0


