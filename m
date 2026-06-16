Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D5CCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZ8h-0004po-34; Tue, 16 Jun 2026 15:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7c-0004Tw-HL
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:08 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7a-0000t8-HN
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:06:52 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490b4a8e28bso37728185e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636807; x=1782241607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x7Z0DitXa1v+MteFgBvClXzp4a3rrnN+3XF0rZy7+F0=;
 b=Q8PfXhqyODktYtZ/+qduL/6nbok9oeTMtDUGyNVZaxGGlY9/6lU/sDBPpjtSlVVoic
 t/k7nGLr8sIlhoMVsgGw4W+auxQwjNByX3TSGDTSnxQ9MQX44FaWR5Tvs/tU5SQkI1Uj
 5Gua3PXPDaE91VuIgceiwQzTBPThZ5B7rTDVplTMETqyluEeHlZVNFi22LavVzEs3dr/
 DmKud8RRQg2tvUChrnO2sJ7MRHSncoL7z98wvKNMQ/6uy9RDtO9Uvxf6lZAiVFBNinc/
 jd+N0ibPQfvGYSgDOWij0LbHkaZv0RT/bMEXzUvkgU4+R08yf/F16E5WNLRHbK+0TZBe
 XOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636807; x=1782241607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x7Z0DitXa1v+MteFgBvClXzp4a3rrnN+3XF0rZy7+F0=;
 b=SU/7ROIaJ8rdfKBKwdui6sD57VnQOyoVBoXeXWHqynQ6TsvtMRqlx9xToMVwAX33/N
 1xN4vkqCYpYqe7LTSdOMBgo/tygycYgcGnsdhtIt/ug4P1uQn/glllMk7J0fOmqcffDb
 SkXLdhL3NNZvHRSMv8XTNnIt7f1Dlc5aYye0vu+WyQLsX5i5gaQtLhA/zT0AUATRpNYP
 gmp+usM1qzGi61j18twyTvbn+psoyURWv95thmTdoxWi4m9BMfbfk4qD3Vq3YnaYohu4
 GXKkucRPHW6a14gfJlVGGnzFP5/1ub7ktwRL7i89XCN7/nxTZVDYTbamaPl0JqtIKIWi
 k2Sg==
X-Gm-Message-State: AOJu0YyjIJJLylVoVAVpdDhL5eee5R72FNUj7r+003gxIfGssQlYAeWA
 Di92qd5BWGovCS0GMP+a/w4dj74nZ6YepAp1t+gdo+23Dan2k19jabH1jgrP3+417sgRtIEWPBd
 CZC8a
X-Gm-Gg: Acq92OHq5kfZ+izZ/xWhlxGeHc/17AnaUQwXKhlNj0xKxTcVeeGNIHBMtL3CjQcaerY
 3RuyqOCeA2JkcM0O8uDtY69761Pj79kWuAamnOGssrB1RbiOTLAyiTtyc99Yn9rKJO8/9FwYH9Y
 dQ5CGsexhllTp8zegQ6okii9Sq3iwy8reBGzXTeZOKgKOjDl8rNTS4rnEAOvVKGyl0YyopkDYMR
 Yri7DGc68Pe7YFeMJQ/Dia5qPZKzsfokj7kkQhDDnISsUoYnnkfihRowLi1Psi64waiicuHSLwD
 RF5a2O1UB6PiNF0bWr16o66wmxI4aYWSI8jqoEIM5k1XPfOYw1uTotP1cEHvWZzzxJq5za7UEqy
 HMljpmbhfMBQYyNVq8uOobNkBPahgrN1VVdrA9p1zu5vjEGl6eZv06MMQWw6qtWoUnXweoQBP8r
 S/GJ5OCTMpfjgFYT/XQlT6WSxMekP0y40TDAYd7y+IvvHfH6Z7AlXRtNtOSs2TiD4MCvfFdwUPF
 3GD1E4Z7PKobvi6f5PUGzkCdt47m/ZS
X-Received: by 2002:a05:600c:a111:b0:490:e5c1:b89d with SMTP id
 5b1f17b1804b1-492333ffd28mr10996215e9.0.1781636807478; 
 Tue, 16 Jun 2026 12:06:47 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.06.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:06:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/61] hw/arm/smmuv3-accel: Implement "auto" value for
 "ssidsize"
Date: Tue, 16 Jun 2026 20:05:43 +0100
Message-ID: <20260616190639.3462006-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Allow accelerated SMMUv3 SSID size property to be derived from host
IOMMU capabilities. Derive host values using IOMMU_GET_HW_INFO,
retrieving SSID size from IDR1. When the auto SSID size is resolved
to a non-zero value, PASID capability is advertised to the vIOMMU
and accelerated use cases such as Shared Virtual Addressing (SVA)
are supported.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260608174900.2227340-7-nathanc@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c | 17 +++++++++++++++--
 hw/arm/smmuv3.c       | 22 ++++++++++++----------
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 25699a1317..3f141991eb 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -63,6 +63,11 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
                                FIELD_EX32(info->idr[3], IDR3, RIL));
     }
 
+    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
+        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
+                               FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -823,6 +828,13 @@ static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
     }
 }
 
+static inline bool smmuv3_pasid_supported(SMMUv3State *s)
+{
+    return s->ssidsize > SSID_SIZE_MODE_0 ||
+           (s->ssidsize == SSID_SIZE_MODE_AUTO &&
+            FIELD_EX32(s->idr[1], IDR1, SSIDSIZE));
+}
+
 static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
 {
     /*
@@ -835,7 +847,7 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
     SMMUState *bs = opaque;
     SMMUv3State *s = ARM_SMMUV3(bs);
 
-    if (s->ssidsize > SSID_SIZE_MODE_0) {
+    if (smmuv3_pasid_supported(s)) {
         flags |= VIOMMU_FLAG_PASID_SUPPORTED;
     }
     return flags;
@@ -972,7 +984,8 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
     smmuv3_accel_as_init(s);
 
     if (s->ats == ON_OFF_AUTO_AUTO ||
-        s->ril == ON_OFF_AUTO_AUTO) {
+        s->ril == ON_OFF_AUTO_AUTO ||
+        s->ssidsize == SSID_SIZE_MODE_AUTO) {
         s->s_accel->auto_mode = true;
     }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c183964b2e..d59931d1a7 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -626,7 +626,10 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
     }
 
     /* Multiple context descriptors require SubstreamID support */
-    if (s->ssidsize == SSID_SIZE_MODE_0 && STE_S1CDMAX(ste) != 0) {
+    if ((s->ssidsize == SSID_SIZE_MODE_0 ||
+         (s->ssidsize == SSID_SIZE_MODE_AUTO &&
+          !FIELD_EX32(s->idr[1], IDR1, SSIDSIZE))) &&
+        STE_S1CDMAX(ste) != 0) {
         qemu_log_mask(LOG_UNIMP,
                 "SMMUv3: multiple S1 context descriptors require SubstreamID support. "
                 "Configure ssidsize > 0 (requires accel=on)\n");
@@ -1965,10 +1968,6 @@ static void smmu_reset_exit(Object *obj, ResetType type)
 
 static bool smmu_validate_property(SMMUv3State *s, Error **errp)
 {
-    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
-        error_setg(errp, "ssidsize auto mode is not supported");
-        return false;
-    }
     if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
         error_setg(errp, "QEMU SMMUv3 model only implements 44 and 48 bit"
                    "OAS; other OasMode values are not supported");
@@ -1989,7 +1988,8 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             return false;
         }
         if (s->ssidsize > SSID_SIZE_MODE_0) {
-            error_setg(errp, "ssidsize can only be set if accel=on");
+            error_setg(errp, "ssidsize can only be greater than 0 "
+                       "bits if accel=on");
             return false;
         }
         return true;
@@ -2175,11 +2175,13 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
         "supported.");
     object_class_property_set_description(klass, "ssidsize",
-        "Number of bits used to represent SubstreamIDs (SSIDs). "
+        "Set number of bits used to represent SubstreamIDs (SSIDs). "
+        "Valid values are 0-20 and auto. Defaults to 0. "
         "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
-        "Valid range is 0-20, where 0 disables SubstreamID support. "
-        "Defaults to 0. A value greater than 0 is required to enable "
-        "PASID support. ssidsize=auto is not supported.");
+        "A value of 0 disables SubstreamID support. A value greater "
+        "than 0 is required to enable PASID support."
+        "Please ensure the value does not exceed the maximum "
+        "SubstreamID size supported by the host platform.");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
-- 
2.43.0


