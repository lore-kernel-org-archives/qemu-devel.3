Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7681D6B086
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUb3-0001ag-UQ; Thu, 29 Jan 2026 11:10:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUan-0000YB-Kw
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:02 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUak-0006mN-1a
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:01 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so9518255e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702996; x=1770307796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OJP/2NJ9gFVt5VZ/DFu9x7R1zrkd3AlIv3rZU6uB/Nc=;
 b=n7L6OhoOeknHBBWAeMICwwyGyt4veX8q2v/udC4td6hgHbpVshnqV1BpaQp58I3NND
 uePvgLXNn4898zptcW41u1fZglAItryFaTG21Z7zbJkCFBry3iHWTciLw+ewJkch0L+X
 9uL+wPbQFeiTR0GvtSmm2NNG2l9CjzhF8hWbhpx+oa1p7ghQhUFDxTOKO88Fug1teoot
 d4hTEDtd8G4cTtSI7emkMsJ7Hpgmzuv9q2PeZzct7w58LoAPObV4tCGoaswXo7qnAud0
 wUOrqwVtnPAmItf9p0kt5BYgq2EK6gFd1IfdL28h/rfZJZvDVzkq1sbozt+5XPy/OubY
 nJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702996; x=1770307796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OJP/2NJ9gFVt5VZ/DFu9x7R1zrkd3AlIv3rZU6uB/Nc=;
 b=lCvRVDLkxqan/BdDEQXO1Z6+om0H87eVkJgf7f63XbV/Jb9vnbY+Z22TZXhHq1dZAH
 MtcoKHrAYjVv1xJr4pEGbYyVygqYVhoJ91v1StV1myEmDM+BIfkTO4RTD7w5KHSqgHRk
 zrHadIHpVv0Dprf4PoAyOBllo3mgjQ4+DV+EemNEsrs3loxr1B8W2YlJwlVWJBe0n3gK
 B//DpmHMaJ3TAuvSJMTU8OwkM1SemuA3Xe4nKbybM4ZXyYNhOXNGHR6J3dSuuBmZAGlj
 fL6OWL9pv+TnLOtx0t/WX/voxGz1onE289/awDgPSlkz5Z7veOsEBTIGb9Gs6A1b7SD+
 W+5A==
X-Gm-Message-State: AOJu0Yyo3kAyHE9niY+qpM5qVK9hGl+OZq2vcxazynXruekvLT31EFvE
 YmKcv0YqrorAz5g0stF2bbyp0mPLRXoTbxkyMwyeLBDnNq4aRztczePgqSXvQjOzaHsX6mgnz5s
 d6fA/EaM=
X-Gm-Gg: AZuq6aJ7tpMkO8X5CxLep4pN8sq+NqED/GkCvkOFavi320qtwVw01Z8HHztS/AEBMsA
 L8hkwxRXK9q+Ic9nuwXAvEg/sJFbKenr3G/uTH+pfCypRAIKRbu7AF6ePDoZDbpj7Sau1jTG9oT
 SdlTSSUCWysGfbyHeJBaPZlt+N+u+NuVkiCVDjTAP07zOni1ibI96tGBguEcI3bUNgoB304iOTN
 G0DFzzYGsxuJjeqSP30GfA6akosZMtkOCK7OQeYJiSjSXPYug7wk9tb/MTW43xffhxR5eDP2GWm
 18xER4YVK552GZAgzF6dgZ+Hxm3VeUCu772YRZws7/bpWhKN0KiVWaq6Of5zdnLF+EczdVrRVYO
 cqhxSH4PcWqSvwAa5b4E8Svc3o27eRSUdrzoQASOXDJxjEm7QjYxibFxgX+7ByZ9+Ap4iZGotDV
 PoYoKp9AA2yK0ZMaNxwm9gyE9E0gIy+g==
X-Received: by 2002:a05:600c:620b:b0:480:39ad:3b7c with SMTP id
 5b1f17b1804b1-48069c16922mr126645725e9.16.1769702996181; 
 Thu, 29 Jan 2026 08:09:56 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/43] hw/arm/smmuv3-accel: Add property to specify OAS bits
Date: Thu, 29 Jan 2026 16:09:05 +0000
Message-ID: <20260129160917.1415092-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

QEMU SMMUv3 currently sets the output address size (OAS) to 44 bits.
With accelerator mode enabled, a device may use SVA, where CPU page tables
are shared with the SMMU, requiring an OAS at least as large as the
CPU’s output address size. A user option is added to configure this.

However, the OAS value advertised by the virtual SMMU must remain
compatible with the capabilities of the host SMMUv3. In accelerated
mode, the host SMMU performs stage-2 translation and must be able to
consume the intermediate physical addresses (IPA) produced by stage-1.

The OAS exposed by the virtual SMMU defines the maximum IPA width that
stage-1 translations may generate. For AArch64 implementations, the
maximum usable IPA size on the host SMMU is determined by its own OAS.
Check that the configured OAS does not exceed what the host SMMU
can safely support.

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-32-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c          | 22 ++++++++++++++++++++++
 hw/arm/smmuv3.c                | 16 +++++++++++++++-
 include/hw/arm/smmuv3-common.h |  5 ++++-
 include/hw/arm/smmuv3.h        |  1 +
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index a97abc1f79..ea420afeb7 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -27,6 +27,14 @@
 static MemoryRegion root, sysmem;
 static AddressSpace *shared_as_sysmem;
 
+static int smmuv3_oas_bits(uint32_t oas)
+{
+    static const int map[] = { 32, 36, 40, 42, 44, 48, 52, 56 };
+
+    g_assert(oas < ARRAY_SIZE(map));
+    return map[oas];
+}
+
 static bool
 smmuv3_accel_check_hw_compatible(SMMUv3State *s,
                                  struct iommu_hw_info_arm_smmuv3 *info,
@@ -74,6 +82,15 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
         error_setg(errp, "Host SMMUv3 doesn't support Range Invalidation");
         return false;
     }
+    /* Check OAS value opted is compatible with Host SMMUv3 IPA */
+    if (FIELD_EX32(info->idr[5], IDR5, OAS) <
+                FIELD_EX32(s->idr[5], IDR5, OAS)) {
+        error_setg(errp, "Host SMMUv3 supports only %d-bit IPA, but the vSMMU "
+                   "OAS implies %d-bit IPA",
+                   smmuv3_oas_bits(FIELD_EX32(info->idr[5], IDR5, OAS)),
+                   smmuv3_oas_bits(FIELD_EX32(s->idr[5], IDR5, OAS)));
+        return false;
+    }
 
     /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
     if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
@@ -657,6 +674,11 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
 
     /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
     s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
+
+    /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
+    if (s->oas == SMMU_OAS_48BIT) {
+        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
+    }
 }
 
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ca086ba00a..cb02184d2d 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -299,7 +299,8 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
 
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS); /* 44 bits */
+    /* OAS: 44 bits */
+    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_44);
     /* 4K, 16K and 64K granule support */
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
@@ -1949,6 +1950,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "ats can only be enabled if accel=on");
             return false;
         }
+        if (s->oas != SMMU_OAS_44BIT) {
+            error_setg(errp, "OAS must be 44 bits when accel=off");
+            return false;
+        }
         return true;
     }
 
@@ -1959,6 +1964,11 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         return false;
     }
 
+    if (s->oas != SMMU_OAS_44BIT && s->oas != SMMU_OAS_48BIT) {
+        error_setg(errp, "OAS can only be set to 44 or 48 bits");
+        return false;
+    }
+
     return true;
 }
 
@@ -2085,6 +2095,7 @@ static const Property smmuv3_properties[] = {
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
     DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
+    DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2115,6 +2126,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support (for accel=on). Please ensure host "
         "platform has ATS support before enabling this");
+    object_class_property_set_description(klass, "oas",
+        "Specify Output Address Size (for accel=on). Supported values "
+        "are 44 or 48 bits. Defaults to 44 bits");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index 415b7ccde5..abe3565357 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -342,7 +342,10 @@ REG32(IDR5,                0x14)
      FIELD(IDR5, VAX,        10, 2);
      FIELD(IDR5, STALL_MAX,  16, 16);
 
-#define SMMU_IDR5_OAS 4
+#define SMMU_OAS_44BIT 44
+#define SMMU_OAS_48BIT 48
+#define SMMU_IDR5_OAS_44 4
+#define SMMU_IDR5_OAS_48 5
 
 REG32(IIDR,                0x18)
 REG32(AIDR,                0x1c)
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 242d6429ed..d488a39cd0 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -71,6 +71,7 @@ struct SMMUv3State {
     Error *migration_blocker;
     bool ril;
     bool ats;
+    uint8_t oas;
 };
 
 typedef enum {
-- 
2.43.0


