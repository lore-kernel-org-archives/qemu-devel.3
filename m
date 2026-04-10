Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86D7F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 20:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBI23-0007P5-3t; Fri, 10 Apr 2026 16:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBI20-0007Ok-3e
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 16:00:44 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBI1y-0006bn-I7
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 16:00:43 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso21893715e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 13:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775851241; x=1776456041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qsggwi5zbpivKYu9vxgPsRTzFrjprzvcyLLml3Oa1F4=;
 b=NGTGoFjN6Peqk52B2QhZDDzyYEDg8UuIo2fXVmlll/9aOk99btm3mTQWDga219toLo
 Zo03pJ3RQGfT5TQw3hT/8zHK93wWTJbevO97TxLfY3o87OXQIlHaTJ/bCU/14OA15qw+
 CKyk2fbe+eKAMIxpm/L+llJB+hbxLh10p6ioLo/nCL8DTtMq57pR5LUWVfo9425BSWHr
 imWFlWSYtM8BxvYu6hRTCEC6Q2PPSAqPC87vYsEfAyYIstj2u9kN+iHEo+LCaTkpedhU
 dTpzm5MXjteBc+AaZkTwE6M5FF2AaEvQKO2BVVSM4Keib+falxNUPzoec3ToYunfGZQs
 AwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775851241; x=1776456041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qsggwi5zbpivKYu9vxgPsRTzFrjprzvcyLLml3Oa1F4=;
 b=j9iPziE0oPxtIaCOsSroDv3pTrqbhjS93DcMDaCi7HKzQd6GaUBBoHqwAeocw03kNG
 mum5gUE6vQzryWMF/Wwud9WyqiEK4Xv1z8KqOty9mD7HyARDCFJdJhw4KyYxadysNBy/
 rTbZx2NO0ttCbkfmW/v1CeTRKtx0TqtrjBYzBVaraEhaaeKvY+I6PE35i813TpqsWI9Z
 P3c3rn4wCj5OrUODNutCzdg93e2XI+ftYpktxBNbuBQVbZLSlqH0UBaqB8usaiyaIvco
 sRjyD+k/oaVV9Lz4vocBiS3Nu6jfFeCn6O93AFJCiw6D2i5/0M+BBXiz90w1BULY7jFC
 m8Og==
X-Gm-Message-State: AOJu0YzMRVcWwTiK5+g8BHhtNWKH/uM4mJZvxl4exveG1+ZnOWqwydo6
 BZIw1QzFxR6BNUTxxmavrR37NTUG6MKKJV8DQwx5aA/zsPi9dSuKxR69BOuJDUSCn3OdZ/wcGOd
 cnmFy45c=
X-Gm-Gg: AeBDieuh/Z4/SXrTGUpEKT60Ekq5BX64Awyu6TsXrIYhUFxoGdXzbwNNhYUjiLSZT7n
 UxB1uOn2ah5cEKZenvCxh1tOzj2KUHa0yX+Yty7GketjA+kytAxuCCOGRR/CjnlBO942sxAqhb0
 FtQQo57enIISMMVQ/gDe+xth7wbQD0PhGHAqIK9mJo/Hgo6i+MRT3TV+bgFwc0i7YINiXgLbeCE
 x/vTNZaeJUv1pIyoRIEGAkHIGVcaIYHvnWWOTUcnWIkY8sIw+wM/04iZZ23kHOGcYzSKNPXqRPD
 /wTjtxss17nKN0mgTsvPmThcfdRMzrdVxS/dJgbVWGi/39WYgbuoCNiVf2R/awvbJgMAx0LkGb5
 7drPvpF0Jb6+GqGDGNHq2xzxCg60qR7pAvR3m5bKYyCXIPVFVfVf73PBueQ5ZN3o5367baSVrg6
 qwsga/F6JJuThlygLExNLhs/kBw217ljB2DUoUhaeUtwosPouVDuJgZ6/IJ+ZWt/Cfjp+1zM86
X-Received: by 2002:a05:600c:1f83:b0:488:b99b:4177 with SMTP id
 5b1f17b1804b1-488d687bf61mr56226695e9.25.1775851240522; 
 Fri, 10 Apr 2026 13:00:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5b3c597sm92483685e9.12.2026.04.10.13.00.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 13:00:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] hw/arm/smmuv3: Have smmuv3_accel_init() take an Error*
 parameter
Date: Fri, 10 Apr 2026 22:00:30 +0200
Message-ID: <20260410200031.18572-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410200031.18572-1-philmd@linaro.org>
References: <20260410200031.18572-1-philmd@linaro.org>
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

By giving smmuv3_accel_init() the ability to populate an error,
we can fail early in smmu_realize() when CONFIG_ARM_SMMUV3_ACCEL
is not available, simplifying smmu_validate_property().

Suggested-by: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Co-developed-by: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/smmuv3-accel.h |  7 +++++--
 hw/arm/smmuv3-accel.c |  3 ++-
 hw/arm/smmuv3.c       | 11 +++--------
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index dba6c71de52..1ca2c80a933 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -42,7 +42,7 @@ typedef struct SMMUv3AccelDevice {
 } SMMUv3AccelDevice;
 
 #ifdef CONFIG_ARM_SMMUV3_ACCEL
-void smmuv3_accel_init(SMMUv3State *s);
+bool smmuv3_accel_init(SMMUv3State *s, Error **errp);
 bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
                               Error **errp);
 bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
@@ -54,8 +54,11 @@ void smmuv3_accel_idr_override(SMMUv3State *s);
 bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
 #else
-static inline void smmuv3_accel_init(SMMUv3State *s)
+#include "qapi/error.h"
+static inline bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
 {
+    error_setg(errp, "accel=on support not compiled in");
+    return false;
 }
 static inline bool
 smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 65c2f44880a..ae031f1eccf 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -917,11 +917,12 @@ static void smmuv3_accel_as_init(SMMUv3State *s)
     address_space_init(shared_as_sysmem, &root, "smmuv3-accel-as-sysmem");
 }
 
-void smmuv3_accel_init(SMMUv3State *s)
+bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
 {
     SMMUState *bs = ARM_SMMU(s);
 
     s->s_accel = g_new0(SMMUv3AccelState, 1);
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
+    return true;
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 5570a13c8a6..5c2855c3770 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1965,13 +1965,6 @@ static void smmu_reset_exit(Object *obj, ResetType type)
 
 static bool smmu_validate_property(SMMUv3State *s, Error **errp)
 {
-#ifndef CONFIG_ARM_SMMUV3_ACCEL
-    if (s->accel) {
-        error_setg(errp, "accel=on support not compiled in");
-        return false;
-    }
-#endif
-
     if (s->ats == ON_OFF_AUTO_AUTO) {
         error_setg(errp, "ats auto mode is not supported");
         return false;
@@ -2033,7 +2026,9 @@ static void smmu_realize(DeviceState *d, Error **errp)
     }
 
     if (s->accel) {
-        smmuv3_accel_init(s);
+        if (!smmuv3_accel_init(s, errp)) {
+            return;
+        }
         error_setg(&s->migration_blocker, "Migration not supported with SMMUv3 "
                    "accelerator mode enabled");
         if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
-- 
2.53.0


