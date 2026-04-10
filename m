Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3D1F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 20:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBI28-0007T2-Hh; Fri, 10 Apr 2026 16:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBI27-0007SU-Lm
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 16:00:51 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBI25-0006dv-NJ
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 16:00:51 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488b00ed86fso25920615e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 13:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775851248; x=1776456048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L/8LV952pK5R/dwzOOVcbtAx4yBXkRtXe7hKkHgXjLA=;
 b=DoiyVipYnVk1eOV6f9pAj8GBuz1p7BZRRDAhm8HGCjZeiyLb/wKivgP033uM6/FWGr
 u1f/pBpSejpV0criwBvAchw3HJzy+VLpi5qtYv+RUAw/z4AFJNy2JrpO6SMrbJBSFs0O
 unJmmyIjIhjRbm4yKm9NgcwVfHzp0FCSleyfkG3dfks45uWn2eJys+BCFC8iq43l7zRo
 H5tBCge/hA9cmIlg8dIQM2ByZv08mNWxqo3Le0t6sOBx3S8BzckCY0ZbQK7PRhfi7hd8
 hhOkRuwQjkgAKtp3bK/eUDSylXavl4KIPPaFdJzPXaaZ2pAOaQMFsAg7xp5n8gvnusyp
 wbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775851248; x=1776456048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L/8LV952pK5R/dwzOOVcbtAx4yBXkRtXe7hKkHgXjLA=;
 b=iCpnSr/8tITcs8aiLwpnJGraiCG9XFQcPghQjIqQC0lsgS/mSjWJODScO52pbT1159
 hn19KRV3dc8I9GyaSg5XI1UcH0z36lX4aGQc1LrywSQ5CUPe7o6zpfIJZV5VsfMYQ6hq
 pvVO5RnRcyTIarQNqq04Y9OlFtJVrCN9UhRd6G2agE9Sb45Z/OxOoEoms84mgk9Hn0vj
 SK4fqzW/1/SBoX9tPVY6kVe2u7bBNdyEorRKrIA6igzFRxm8OwxPVh3KrGtbK4eINkyl
 nGTfUszsOmUDMUca0ZalnGN9VtQ+FW6uQC6zkfY88n/Avga3OCj0VMk0JbBc+acvwDut
 YS7w==
X-Gm-Message-State: AOJu0YzeuHG6eSWfWNO5eqX/OkQkoXMqcYJcpIyN2OxP33jskONyaxUd
 sxL1H+bl76CkPURcIGtxWbQ5pVpxrZm7s7wuN0D42iAhy/LXvdUIBHkd2D0hzKxhmN0FfbRCsAq
 pH85NjQ8=
X-Gm-Gg: AeBDieu7dy1l8zXO1F8Q+AQUc9zMWrhlQIQO3Ooj8PmAVQf1uVxvQXLTvPc6AyzSiRF
 UXF8S9oD123ZfXgRCyqq4mi3uIvxzH8uB9Ny8Ctq4i1F/b+sbKJqNNZRv0isGuELP1hbcfnTb5B
 TJ/+xJyKLi2HKA/AG/2kkQsaIh/IenhK+pCojOjxNZhykgB3s2AFviNN7AX9Tppn3g/lXT+Ky1h
 MdWAd1SxnMVRCxgQb+zV+36od6COK5bbHIkJbxALf6pUPjtzBTYaIpuo+j7bcwvHdY+GJs8ovWz
 kcmr6EPrBjptD3HUIZOamJfkLBlpFEHawzBOS/wrtgmHmz5uj3m21ooxpKKDzWsZ/dpTcgfG1wB
 5huKaFnwbul7xj+f8SBBXEKxGaDVVrOMBfi02pmfFQJF4M2+GiT6b9YeJzq8BP6n8eskOw1Hq57
 3XzGvOtxu6Li3rQ9tdIOMWzWU6K7EnIrVz3H1Hou3iYawI7M1w8pYO3raFzjscMXkypXOkL86Y
X-Received: by 2002:a05:600c:8883:b0:488:9439:880d with SMTP id
 5b1f17b1804b1-488d689da95mr40570995e9.29.1775851247610; 
 Fri, 10 Apr 2026 13:00:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d531f2b6sm106579495e9.2.2026.04.10.13.00.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 13:00:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 2/2] hw/arm/smmuv3: Avoid including CONFIG_DEVICES in hw/
 header
Date: Fri, 10 Apr 2026 22:00:31 +0200
Message-ID: <20260410200031.18572-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410200031.18572-1-philmd@linaro.org>
References: <20260410200031.18572-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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


