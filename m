Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EBDCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZ8o-0004wb-C7; Tue, 16 Jun 2026 15:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7b-0004Tc-8P
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:06:52 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7W-0000qx-G3
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:06:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490b12270b3so30449935e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636804; x=1782241604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bCfOcDxy18cXYwHGeiHuAV55BSHA/3vZ5XDQkQvuPDg=;
 b=A/KRhTlIizftQ26oZZV3t71E01p49SF/H7MOA7gqgWE5M37LlLdQil0KwLcJiGckgM
 DOmflTttIyavp7an0iK1rTfWHsm/KSSZAzvN0jyKtNPBXQYHC/5jhKeIYZZqaLnzCl0x
 XrXL5ZlsVLhsG/Ry/VGt1ib8VXmcNtMc4i7x2EDxHpIw1LEKvrl261oWlCo0MOv15moK
 YtjtBU7Yi3YeVfNbiO1KMxpvX3NBUOoNqotxKc+zySDN6thq+g3f21y9D7jG7RNGnZpn
 HnzeeaVTDsZY97c6u4GjUAHZN/eiausnuqI6UrA/AsdXEHQESlz6hGAh225pCcNRX1QF
 XgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636804; x=1782241604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bCfOcDxy18cXYwHGeiHuAV55BSHA/3vZ5XDQkQvuPDg=;
 b=FVhcIm5DApSA9qtGPpck44ShTMABryOH8Tn8XABvuWIeQdRSwjMo/6dfxgUK1/7eFM
 nOtKgzA+oeoZoh7cg6ldF9VVMH1PhqxfBQ0/JNjIWNdM0hL1/duq5ITtGu4BRoBdtiwT
 OBKarBhd6Rr/0tWHiC1ugOV3wocyPdnxRz0GOrRM6t3a0AtBmDDl9yd61ccri2HzKfnt
 hJ3k6fNxAQDKFFp2d6POR6fpcdWANEZtEilsfwdTwCU0zJhbowZbV1FRVaf6oJtDJcpJ
 fGpy3yDrWK4Ccm0V0XBQfFx4fGBE8yZKPQ8i893CsMaI44DZX18VqDr7BcZ2suf8yXl9
 ndfw==
X-Gm-Message-State: AOJu0YyMk9gthcx4Ud/dkg3ZtOMgw6erZH3DSC9bLNF07dIMwmEPVV99
 mIFmF8EacenKUkSo39LVGlMW0H1CYMvYJ1Vz97N3cczC7koVzfX1ccjMx9Ow4ILgdcEEZ6DlBQS
 l1NkY
X-Gm-Gg: Acq92OHCojhv1oPrTfBPNZiSZeo44xKJhZ9r11/iT6+LMb5+rep36ziyalJCvQcKfLY
 nfiV/Klozi7YE1gUnD8DC7fxlyOtatkUfTvhaq3qpYFgejr70ywQZJ0XhxATHyWhZ4LvDUtZNFE
 ApJb3uzM42N+0q9p8zD9bNiYb2V262lXBY4KQcLzTNCzgkaK/Qng/V175wR5K8NwEiiNc3Ppr5a
 2XxVA9r2RoHfUfs5Kjfy91tXIFsz3FCPrzDtzTVB1Wq9cZjW74j+NuiaKPy0eGeDVNAxDVymLTf
 q5w9RolPEzmY+ZE7fS2HgXx8GCttWviX63zBj9vq6dBwdJhdVsqj9U2bjvlDDPJ10wDJTsPbA/t
 9SzFMb1p1kglscvVumm6nOoYQhXHhi3N2IYTjMXkjFHCnPOSf8cwKVKQ9YRvBSp2Qwbkh8dC/rm
 YOqifMR0Eq2uW3OXYqgloT5HBFQWHnrP7YtnZ1WtjERhbihu5Ui3jqrit6phpRELYTaHNMJzaNb
 Joh2OVTE9FcvMQ9dqX01ojqF1hB2uF3
X-Received: by 2002:a05:600c:a319:b0:492:1e36:8c4b with SMTP id
 5b1f17b1804b1-492333df110mr10614235e9.36.1781636804047; 
 Tue, 16 Jun 2026 12:06:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.06.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:06:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/61] hw/arm/smmuv3-accel: Add helper for resolving auto
 parameters
Date: Tue, 16 Jun 2026 20:05:40 +0100
Message-ID: <20260616190639.3462006-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Nathan Chen <nathanc@nvidia.com>

Introduce smmuv3_accel_auto_finalise() to resolve properties that are
set to 'auto' for accelerated SMMUv3. This helper function allows
properties such as ats, ril, ssidsize, and oas support to be resolved
from host IOMMU capabilities via IOMMU_GET_HW_INFO.

The later commits in this series set the auto_mode flag to true when
an accel SMMUv3 property value is explicitly set to 'auto', or if the
property value is not set and defaults to auto mode.

Setting these property values to 'auto' requires at least one
cold-plugged device to retrieve and finalise these properties. If the
auto_mode flag is true, register a machine_init_done notifier to
verify this requirement and fail boot if it is not met.

Hot-plugged devices into an accel SMMUv3-associated bus will re-use
the resolved host values from the initial cold-plug.

Subsequent patches will make use of this helper to resolve 'auto' to
what is reported by host IOMMU capabilities.

Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260608174900.2227340-4-nathanc@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c   | 41 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h   |  2 ++
 include/hw/arm/smmuv3.h |  3 +++
 3 files changed, 46 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 862be814a0..fa0a97cece 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -18,6 +18,7 @@
 
 #include "smmuv3-internal.h"
 #include "smmuv3-accel.h"
+#include "system/system.h"
 
 /*
  * The root region aliases the global system memory, and shared_as_sysmem
@@ -35,11 +36,33 @@ static int smmuv3_oas_bits(uint32_t oas)
     return map[oas];
 }
 
+static void smmuv3_accel_auto_finalise(SMMUv3State *s,
+                                       struct iommu_hw_info_arm_smmuv3 *info)
+{
+    SMMUv3AccelState *accel = s->s_accel;
+
+    /*
+     * Return if 'auto' was not set for any accel SMMUv3 property, or
+     * if property values were already resolved from a previous call
+     * to this function (e.g. if this function was called again after
+     * VM boot during device hot plug). We do not accept new property
+     * values in this case where auto_finalised == true, and we re-use
+     * the values determined from the initial cold plug.
+     */
+    if (!accel->auto_mode || accel->auto_finalised) {
+        return;
+    }
+
+    accel->auto_finalised = true;
+}
+
 static bool
 smmuv3_accel_check_hw_compatible(SMMUv3State *s,
                                  struct iommu_hw_info_arm_smmuv3 *info,
                                  Error **errp)
 {
+    smmuv3_accel_auto_finalise(s, info);
+
     /* QEMU SMMUv3 supports both linear and 2-level stream tables */
     if (FIELD_EX32(info->idr[0], IDR0, STLEVEL) !=
                 FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
@@ -918,6 +941,18 @@ static void smmuv3_accel_as_init(SMMUv3State *s)
     address_space_init(shared_as_sysmem, &root, "smmuv3-accel-as-sysmem");
 }
 
+static void smmuv3_accel_machine_done(Notifier *notifier, void *data)
+{
+    SMMUv3State *s = container_of(notifier, SMMUv3State, machine_done);
+    SMMUv3AccelState *accel = s->s_accel;
+
+    if (accel->auto_mode && !accel->auto_finalised) {
+        error_report("arm-smmuv3 accel=on with 'auto' properties requires "
+                     "at least one cold-plugged VFIO device");
+        exit(1);
+    }
+}
+
 bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -925,5 +960,11 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
     s->s_accel = g_new0(SMMUv3AccelState, 1);
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
+
+    if (s->s_accel->auto_mode) {
+        s->machine_done.notify = smmuv3_accel_machine_done;
+        qemu_add_machine_init_done_notifier(&s->machine_done);
+    }
+
     return true;
 }
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 407940616c..87fecb5c68 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -25,6 +25,8 @@ typedef struct SMMUv3AccelState {
     uint32_t bypass_hwpt_id;
     uint32_t abort_hwpt_id;
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
+    bool auto_mode;
+    bool auto_finalised;
 } SMMUv3AccelState;
 
 typedef struct SMMUS1Hwpt {
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 82f18eb090..85be3d7467 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -22,6 +22,7 @@
 #include "hw/arm/smmu-common.h"
 #include "qom/object.h"
 #include "qapi/qapi-types-misc-arm.h"
+#include "qemu/notify.h"
 
 #define TYPE_SMMUV3_IOMMU_MEMORY_REGION "smmuv3-iommu-memory-region"
 
@@ -74,6 +75,8 @@ struct SMMUv3State {
     OnOffAuto ats;
     OasMode oas;
     SsidSizeMode ssidsize;
+
+    Notifier machine_done;
 };
 
 typedef enum {
-- 
2.43.0


