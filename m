Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC11F54ACE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53Pk-0000kR-5z; Tue, 24 Mar 2026 11:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53Pg-0000g6-Fe
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:25 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53Pe-0005Cr-LN
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:24 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-439af7d77f0so4121617f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 08:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774365080; x=1774969880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SNjKRlPgyHByobSZXWFL5LbzsZyidVKneZpX7LBz9rs=;
 b=hroRSSoDKLKfSPbhermzzM8azuX8HhT6ZVzAx3LYgxHZQdIPDyCkHSw4e2zaHeMIe0
 duTJtdbDrrskFGiP7gpQZkpy0HSom8iCwHBH8+tYZwLFl+kOiW4o8AR2R8sOeHa7x0x0
 74ljfpPFLBKyoWAFCCfe0DMqv9+1iDu2I0D6zx65u9hnRUA7zm4GJHtMZb4bRovzRefJ
 M8BjIa8C53uYXGx0Zfc5s9eTF4HigXbzMIQi8u9H+8EhVD/MTV2s72ERaYJIQzLDofKC
 ASFym7pc/ycSLxebgSpo+awMb9+ExcrA8j2tuf0/sgkG2FwFU9y3Ru5v5lPCuWYQCLm9
 9Lcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774365080; x=1774969880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SNjKRlPgyHByobSZXWFL5LbzsZyidVKneZpX7LBz9rs=;
 b=sfgXPyjH4ooqhL2Nldsfsd0h6ULEtveifaZkEP4rENCqp0RQbJW4sks5/m3WDnL0oK
 UjYSbD+RG3rTw+8NnMZaThPc7gMOWBt2Ydnk7aAMQJBL0tK1H3sxZH7kTMG8XcirnZHv
 S6GaZbTkPxaz+m3dSoYTYb1ZmbeIvPL5hI26H+zNJQsvbcz3lHfvu1KdJ36mPvO19S6p
 4jdv0s94Z7FNnoaqd81t6VmSFIqQHcTmw52PXdy1Huek/4PH7d1ejaNAfM8BodSoXGIN
 dRqiS5GVhh+3WkCjjcpONXeEyoaePx3TQHq1ySfN6e3SVPX3RD2dXCdTFH2MsYuiX8mO
 /+Uw==
X-Gm-Message-State: AOJu0Yw5BXVyebNIIFojKjrUL6X2xMk2lqbIw8/bDVRRyEUm43rWnpAx
 z/i+4LLVNLXIbdhSM/ZbJfPjuPt1FJhzF9kP2qSGu0Ahh7Ge2UqRuIGiAxNVajLzYipUCbJZ4aH
 KkTdh9Dg=
X-Gm-Gg: ATEYQzzu26PQ5msjP6kYaBnqpC1wYppdHaU/lQkioGj+rjKtBsN7PDtAwEpXED7QlxS
 NQdpESHWSSvy0c7k5dTh+5g7Ht3Q+z/KfPp7XMzAoiUyrKTG/W4jepK7qiaU6/hwEQrxvsgPKg0
 QLHzt9xMVGBfqXW7xu276+g4wc+Mb+AZD4nnYCer3NxRPUaMjlnqLMX7C1MtR8YsVzKrFglyz7w
 /Le0nxqaGFa/EL4EOTyx8f9J1PLTMhKSqN4CEskh2FSK6VHAAsL9XkJl4e92BfghfN0MSrl9BE0
 D6068p+ocJxatc8DnCoMoU9kCjCmQfcMaup4N9YdfoJTQf7mfUP6gEjMQeQBM0U2p/ixMtmnri2
 +SPLjZFNc6KG++tQWn0TMI5DJQeVWoPfifptCYEhtMsZOJIdGHETEFVSi9xYO42n29CMnpyvIMR
 YD+f6nRnurZLR8wxTum/SsxQKAQPPFypIE9mV6Z+LRUtQPIji+kDWvJ7TgDM3jq8q+9sGRlqSAa
 ZCG5Hn73svTV/zmrFkEFLA0XZnNiUEJicgtW/ThSw==
X-Received: by 2002:a5d:64c6:0:b0:439:bd26:3c63 with SMTP id
 ffacd0b85a97d-43b64262da5mr24967152f8f.28.1774365080321; 
 Tue, 24 Mar 2026 08:11:20 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64717e97sm40781916f8f.35.2026.03.24.08.11.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 08:11:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/11] hw/arm/smmuv3-accel: Change "ats" property type to
 OnOffAuto
Date: Tue, 24 Mar 2026 15:11:05 +0000
Message-ID: <20260324151111.237411-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324151111.237411-1-peter.maydell@linaro.org>
References: <20260324151111.237411-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

Change accel SMMUv3 ATS property from bool to OnOffAuto. The 'auto'
value is not implemented, as this commit is meant to set the property
to the correct type and avoid breaking JSON/QMP when the auto mode is
introduced. A future patch will implement resolution of the 'auto'
value to match the host SMMUv3 ATS support.

The conversion of the ATS property type to OnOffAuto is an
incompatible change for JSON/QMP when a bool value is expected for
"ats", but the "ats" property is new in 11.0 and this patch is
submitted as a fix to the property type.

Fixes: f7f5013a55a3 ("hw/arm/smmuv3-accel: Add support for ATS")
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Message-id: 20260323182454.1416110-3-nathanc@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c    |  4 +++-
 hw/arm/smmuv3.c          | 17 ++++++++++++++---
 hw/arm/virt-acpi-build.c |  2 +-
 include/hw/arm/smmuv3.h  |  4 +++-
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 2bb142c47f..f21a6a9997 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -827,7 +827,9 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
 
     /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
+    if (s->ats == ON_OFF_AUTO_ON) {
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1);
+    }
 
     /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
     if (s->oas == SMMU_OAS_48BIT) {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 068108e49b..a683402a0c 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -317,6 +317,11 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
     smmuv3_accel_idr_override(s);
 }
 
+bool smmuv3_ats_enabled(SMMUv3State *s)
+{
+    return FIELD_EX32(s->idr[0], IDR0, ATS);
+}
+
 static void smmuv3_reset(SMMUv3State *s)
 {
     s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
@@ -1966,12 +1971,17 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
     }
 #endif
 
+    if (s->ats == ON_OFF_AUTO_AUTO) {
+        error_setg(errp, "ats auto mode is not supported");
+        return false;
+    }
+
     if (!s->accel) {
         if (!s->ril) {
             error_setg(errp, "ril can only be disabled if accel=on");
             return false;
         }
-        if (s->ats) {
+        if (s->ats == ON_OFF_AUTO_ON) {
             error_setg(errp, "ats can only be enabled if accel=on");
             return false;
         }
@@ -2128,7 +2138,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
-    DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
+    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
     DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
 };
@@ -2160,7 +2170,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Disable range invalidation support (for accel=on)");
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support (for accel=on). Please ensure host "
-        "platform has ATS support before enabling this");
+        "platform has ATS support before enabling this. ats=auto is not "
+        "supported.");
     object_class_property_set_description(klass, "oas",
         "Specify Output Address Size (for accel=on). Supported values "
         "are 44 or 48 bits. Defaults to 44 bits");
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 719d2f994e..591cfc993c 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -402,7 +402,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
 
     bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
     sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
-    sdev.ats = object_property_get_bool(obj, "ats", &error_abort);
+    sdev.ats = smmuv3_ats_enabled(ARM_SMMUV3(obj));
     pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
     sbdev = SYS_BUS_DEVICE(obj);
     sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 26b2fc42fd..ce51a5b9b4 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -70,7 +70,7 @@ struct SMMUv3State {
     uint64_t msi_gpa;
     Error *migration_blocker;
     bool ril;
-    bool ats;
+    OnOffAuto ats;
     uint8_t oas;
     uint8_t ssidsize;
 };
@@ -91,6 +91,8 @@ struct SMMUv3Class {
     ResettablePhases parent_phases;
 };
 
+bool smmuv3_ats_enabled(struct SMMUv3State *s);
+
 #define TYPE_ARM_SMMUV3   "arm-smmuv3"
 OBJECT_DECLARE_TYPE(SMMUv3State, SMMUv3Class, ARM_SMMUV3)
 
-- 
2.43.0


