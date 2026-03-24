Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C088F54ACD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53Pw-0000tv-6w; Tue, 24 Mar 2026 11:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53Pj-0000jn-QF
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:27 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53Ph-0005Do-QD
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:27 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-486b96760easo12859155e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 08:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774365084; x=1774969884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kvuAX+aljmK1WGcU3Y0ud4Mf1yP5fbh/2lCieSQZkf0=;
 b=Kq0kaArPKQYg21Gs27QQepvLKa3ni3u0L6ZMKckhno5Z9SMcGoPs4w0Ni9oZql/vsC
 FdKZ+ymnMrzVwYTzNaY1APvo5KfqFHnjRQXihignHWVYibVtW9VpIu5GL04OHvba6JT6
 KyOpyPGkT6DBWZCzcfoLenu7ViD52xxixHaGVXAdD/ry03QciAmNaGSysv4YahuC6hG7
 9YeWl0/HeD96atOlZG/ndzreQe4vhMbbRDfXCr1NSi/+BOoZ5CwpS3an0LRn+dnXE+La
 ZOvmx26weHLf8WxM5eY6i7Ia1ePLxaWVxejR3eAzmIzuT2Vw32Jopongdhz5qZwdoRL5
 00fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774365084; x=1774969884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kvuAX+aljmK1WGcU3Y0ud4Mf1yP5fbh/2lCieSQZkf0=;
 b=DMHmKCeokqqWuu96vHUGV1m2kwUCma9xyx+gjEkc5/PfagaMkq3KwW4kJ7EnFCsfGZ
 rrf031BzGGEeFlhfqFf05D+HhY2qFxborH/AMq3j9CQ1ArLfrdMDnci4vlC+EaNiJ2jM
 iJdlqu0ZLug+053oTdElkPkVxOpnNzszGr4ULPFMLO7syD2Ft4JRxx4HZ3gHU4oUor8v
 9DG49Ln1Skan3YeBh21o+3M5BEAnQfIWibkXfHlOs5nCJlIudlHPxSx5VC3pHjA2XB1W
 MZVEL3n3N6m0mMFQzOQwnEw81lo5mbtC9TLl+Y+b12NwqlviZqYGIHJo9RySvcAM6e/a
 FyBA==
X-Gm-Message-State: AOJu0Yy2i/QMJTgOJQcqmWJ2QkqVryu4TNFsK6/JjLHHOFfNUWASVqg7
 XCDkazsrb/Ep/wZBTftqSG1XcvgQU4bIY5aIFSG1pk913c18Lg+4CxUH1E13Nhx2p7EOKK2cqO6
 FVNeM4mQ=
X-Gm-Gg: ATEYQzxCz51ZIetJyMZo19VH++J8hIEmpAfPKmobrfNTsWsw6P1+xexn/X/ZLpQSzMl
 VAj6LUaWVEbf9ndE9Mlgog1q/wkIxyzy9RhcZ8OyyWJPSUa9e739/n7EV5J/N2D6YsXfioolzs3
 3wQT8JW/Fb45GHuJWRQwmsq+13uoMdsjcBUK6kKQYv1DA9co9XeH2YUo9CT4C1jujRpCOX4QG8d
 IZlogRY4uTESXhX4sbv7T+SvdyuZIUGTx/criMyorLtS/Ql+OZqwCWdCD6CuSiT7ZLS3xANXnrO
 kGlrLzKzYFaS7tjS+uiB+l4r3DuP1daz9hR2PjIToT9Ks4O/t1VSByvV4An00jiVoGaSX68r9IP
 HScAxOaK59bxlNHsK+cyqVqUhp0TzOEdk7BnAkaYjahVV4AhbmHTADFQ4EJIYvjoTvoyI8ZeqQh
 U+fqVkQWH/PdWksny0WLpAR9USiR7StEdwEiXw2fKSwIvo6HNdSBV+PHv69PKaUexkKFbGBIRZY
 2DcZYyR/mg7h3yhoH8THOcPyjWh4EJXJK6uVCBnJg==
X-Received: by 2002:a05:600c:4e87:b0:477:6d96:b3e5 with SMTP id
 5b1f17b1804b1-48715fd463emr2270045e9.7.1774365084025; 
 Tue, 24 Mar 2026 08:11:24 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64717e97sm40781916f8f.35.2026.03.24.08.11.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 08:11:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/11] hw/arm/smmuv3-accel: Change "ssidsize" property type to
 SsidSizeMode
Date: Tue, 24 Mar 2026 15:11:08 +0000
Message-ID: <20260324151111.237411-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324151111.237411-1-peter.maydell@linaro.org>
References: <20260324151111.237411-1-peter.maydell@linaro.org>
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

Change accel SMMUv3 SSIDSIZE property from uint8_t to SsidSizeMode.
The 'auto' value is not implemented, as this commit is meant to set the
property to the correct type and avoid breaking JSON/QMP when the auto
mode is introduced. A future patch will implement resolution of 'auto'
value to match the host SMMUv3 SSIDSIZE value.

The conversion of the "ssidsize" property type to OnOffAuto is an
incompatible change for JSON/QMP when a uint8_t value is expected for
"ssidsize", but this property is new in 11.0 and this patch is
submitted as a fix to the property type.

Fixes: b8c6f8a69d27 ("hw/arm/smmuv3-accel: Make SubstreamID support configurable")
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Message-id: 20260323182454.1416110-6-nathanc@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c          | 23 +++++++++++++++++++++--
 hw/arm/smmuv3.c                | 19 ++++++++++---------
 include/hw/arm/smmuv3-common.h |  1 -
 include/hw/arm/smmuv3.h        |  3 ++-
 4 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index c31b64295e..bc6cbfebc2 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -802,7 +802,7 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
     SMMUState *bs = opaque;
     SMMUv3State *s = ARM_SMMUV3(bs);
 
-    if (s->ssidsize) {
+    if (s->ssidsize > SSID_SIZE_MODE_0) {
         flags |= VIOMMU_FLAG_PASID_SUPPORTED;
     }
     return flags;
@@ -817,6 +817,22 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_msi_direct_gpa = smmuv3_accel_get_msi_gpa,
 };
 
+/*
+ * This returns the value of a SsidSizeMode value offset by 1 to
+ * account for the enum values offset by 1 from actual values.
+ *
+ * SSID_SIZE_MODE_0 = 1, SSID_SIZE_MODE_1 = 2, etc. so return 0
+ * if SSID_SIZE_MODE_0 is passed as input, return 1 if
+ * SSID_SIZE_MODE_1 is passed as input, etc.
+ */
+static uint8_t ssidsize_mode_to_value(SsidSizeMode mode)
+{
+    if (mode == SSID_SIZE_MODE_AUTO) {
+        return 0;
+    }
+    return mode - 1;
+}
+
 void smmuv3_accel_idr_override(SMMUv3State *s)
 {
     if (!s->accel) {
@@ -842,7 +858,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
      * By default QEMU SMMUv3 has no SubstreamID support. Update IDR1 if user
      * has enabled it.
      */
-    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE, s->ssidsize);
+    if (s->ssidsize > SSID_SIZE_MODE_0) {
+        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
+                               ssidsize_mode_to_value(s->ssidsize));
+    }
 }
 
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ea285bdf64..79018f8d66 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -20,6 +20,7 @@
 #include "qemu/bitops.h"
 #include "hw/core/irq.h"
 #include "hw/core/sysbus.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/blocker.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
@@ -625,7 +626,7 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
     }
 
     /* Multiple context descriptors require SubstreamID support */
-    if (!s->ssidsize && STE_S1CDMAX(ste) != 0) {
+    if (s->ssidsize == SSID_SIZE_MODE_0 && STE_S1CDMAX(ste) != 0) {
         qemu_log_mask(LOG_UNIMP,
                 "SMMUv3: multiple S1 context descriptors require SubstreamID support. "
                 "Configure ssidsize > 0 (requires accel=on)\n");
@@ -1979,6 +1980,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         error_setg(errp, "ril auto mode is not supported");
         return false;
     }
+    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
+        error_setg(errp, "ssidsize auto mode is not supported");
+        return false;
+    }
 
     if (!s->accel) {
         if (s->ril == ON_OFF_AUTO_OFF) {
@@ -1993,7 +1998,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "OAS must be 44 bits when accel=off");
             return false;
         }
-        if (s->ssidsize) {
+        if (s->ssidsize > SSID_SIZE_MODE_0) {
             error_setg(errp, "ssidsize can only be set if accel=on");
             return false;
         }
@@ -2011,11 +2016,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         error_setg(errp, "OAS can only be set to 44 or 48 bits");
         return false;
     }
-    if (s->ssidsize > SMMU_SSID_MAX_BITS) {
-        error_setg(errp, "ssidsize must be in the range 0 to %d",
-                   SMMU_SSID_MAX_BITS);
-        return false;
-    }
 
     return true;
 }
@@ -2144,7 +2144,8 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
     DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
-    DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
+    DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
+                              SSID_SIZE_MODE_0),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2185,7 +2186,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
         "Valid range is 0-20, where 0 disables SubstreamID support. "
         "Defaults to 0. A value greater than 0 is required to enable "
-        "PASID support.");
+        "PASID support. ssidsize=auto is not supported.");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index 9f78bbe89e..7f0f992dfd 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -311,7 +311,6 @@ REG32(IDR1,                0x4)
     FIELD(IDR1, TABLES_PRESET, 30, 1)
     FIELD(IDR1, ECMDQ,        31, 1)
 
-#define SMMU_SSID_MAX_BITS 20
 #define SMMU_IDR1_SIDSIZE 16
 #define SMMU_CMDQS   19
 #define SMMU_EVENTQS 19
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index c35e599bbc..ddf472493d 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -21,6 +21,7 @@
 
 #include "hw/arm/smmu-common.h"
 #include "qom/object.h"
+#include "qapi/qapi-types-misc-arm.h"
 
 #define TYPE_SMMUV3_IOMMU_MEMORY_REGION "smmuv3-iommu-memory-region"
 
@@ -72,7 +73,7 @@ struct SMMUv3State {
     OnOffAuto ril;
     OnOffAuto ats;
     uint8_t oas;
-    uint8_t ssidsize;
+    SsidSizeMode ssidsize;
 };
 
 typedef enum {
-- 
2.43.0


