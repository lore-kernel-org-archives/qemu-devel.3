Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59239CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZ8x-00053N-UV; Tue, 16 Jun 2026 15:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7b-0004Td-Di
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:06:52 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7Y-0000sX-A5
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:06:49 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490afc47455so22584645e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636806; x=1782241606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/dB7M/fDHtSrW6aC8fEDHLa+zvgj33Xv8Vnh6D9Vtkk=;
 b=goPP4TGLmWofvUI7UyBDMFFrFOiJ8L5DxjKTeg+O+Ak6V+Y1cxs2sp+UnjwliK3b5l
 vcVVic8pI2UHBvzMRxpKNWlJnF+QpQTR4eucw554KsD6P0msKwBTWtQyfUFZ8fAXSnCH
 XIzGKTr8txaea1n0D+X6rQJ3q55aLYSjTNTTZ5rVkWmejH489u14F65YHUYeyGTuzwPa
 WobbK5lBJdk2oeH/pLtnsPnTUX/GZTiRt6BEgjwdcvNq7M2MrdlZa59THe7Qe+Yo9lQs
 7hXqWW7I3/sNCzeNB1rlwNi0dwT7/2vgBbx+jvl+MPrUCWxC4xiVRh1xH+u2s6JEMCWF
 BI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636806; x=1782241606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/dB7M/fDHtSrW6aC8fEDHLa+zvgj33Xv8Vnh6D9Vtkk=;
 b=TB+ZAVS0P2fXe23yAKfLyHSXhqIGEHsK/Ii8J6Y3ePZp1QUwA+LSPu2uezxpRDAQLB
 bP38QVTsJyrt62RMV6FMpyMIz+2a5GbJIh0uJLKM7/GdSyXkD+ZVaXKb9fROxQ9UrGHV
 KULKvfCiQjjtnRTYAg14ATwU2WuXStQxhU9gj4v+5obqGwA2+N4zKw7Z+Fc4fmk3pdpK
 9lYQzxilrVK4hJD34sFgYuAejgA/+0jEcRzCprgRruU0iNd22IablgGlEDC107d9CfJz
 BkzmvUbbPaj9HQhILt4wSA5MGN+XXOUN0sAIbsJLRrPvxxXjuJF9xKILJ0aiUYPfl/N9
 2fhA==
X-Gm-Message-State: AOJu0YxXCGJ7vKcrD/1nklXCC7tShr949vG7OJjd9NfH3fWr058Gr9cu
 mxGnL1a+7MZ21UKyXDIhVFWg+e0G7ujjVAvrSx92C7GaW9IQl3/4QTFD+CPf9YooexasyC9hACp
 nMb1Z
X-Gm-Gg: Acq92OGzrK7oU2zIrhNt7F392COcWtkPPWGzlvk5WBCN1Dj/Em+ca3i0vjB956ojy1l
 uTN71U5tkFPMuf1MnywZkBiSMhJezzmPqpzPEoBMxIp7mQ+WTk2n54rcpkqKdVpm19mmkFt6AFV
 4Dm2KAWYEsngilMqD3oNHSy6AXyy898SDYSeG4CsFDTJL09mVFhaNeThVdj8D0+IxFv2e0jph6j
 3F+HEmXg1qa/rKBkoVeO8Ok8dmjyzk567Ao/B97HMjSHVIY7loLJygfph6G35EuroDWIEJUeL4Y
 4v6qZwMrFrDCIKcNoIARzWN5eF6HNzcOUMKKQcrEp8Y5q+Ar9Cijq6hO6BSJ84y3/GbzA6qjw0C
 H8VMKdjD7fFajOEM2yHjyNR8D+7iCfX7VI0t2CVnvpFgMWGH7RAeiM2NWkoZ13sou2K8nCyOPMN
 ZmjpEqlNt91SG8DTofQUcr+FBS4TIXa5suVeUDpcRh2Onuzossvf1T6GSS/PbTRlRKI5bsk032N
 7hdeS8ToUAsZD/GJVvv0aL9zZc3x6mC6luTkYt4xMY=
X-Received: by 2002:a05:600c:c094:b0:490:b642:ce2c with SMTP id
 5b1f17b1804b1-492333af1b4mr11230595e9.14.1781636806076; 
 Tue, 16 Jun 2026 12:06:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.06.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:06:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/61] hw/arm/smmuv3-accel: Implement "auto" value for "ril"
Date: Tue, 16 Jun 2026 20:05:42 +0100
Message-ID: <20260616190639.3462006-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Allow accelerated SMMUv3 Range Invalidation support property to be
derived from host IOMMU capabilities. Derive host values using
IOMMU_GET_HW_INFO, retrieving RIL capability from IDR3.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260608174900.2227340-6-nathanc@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c |  8 +++++++-
 hw/arm/smmuv3.c       | 10 ++++------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 4c2acbbedf..25699a1317 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -58,6 +58,11 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
                                FIELD_EX32(info->idr[0], IDR0, ATS));
     }
 
+    if (s->ril == ON_OFF_AUTO_AUTO) {
+        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL,
+                               FIELD_EX32(info->idr[3], IDR3, RIL));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -966,7 +971,8 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
 
-    if (s->ats == ON_OFF_AUTO_AUTO) {
+    if (s->ats == ON_OFF_AUTO_AUTO ||
+        s->ril == ON_OFF_AUTO_AUTO) {
         s->s_accel->auto_mode = true;
     }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 436155d883..c183964b2e 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1965,10 +1965,6 @@ static void smmu_reset_exit(Object *obj, ResetType type)
 
 static bool smmu_validate_property(SMMUv3State *s, Error **errp)
 {
-    if (s->ril == ON_OFF_AUTO_AUTO) {
-        error_setg(errp, "ril auto mode is not supported");
-        return false;
-    }
     if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
         error_setg(errp, "ssidsize auto mode is not supported");
         return false;
@@ -2165,8 +2161,10 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "ensure the host SMMUv3 supports nested translation before "
         "enabling.");
     object_class_property_set_description(klass, "ril",
-        "Disable range invalidation support (for accel=on). ril=auto "
-        "is not supported.");
+        "Enable/disable range invalidation support (for accel=on). "
+        "Valid values are on, off, and auto. Defaults to on. "
+        "Any attempt to turn it 'on' while the host does not support "
+        "it would fail.");
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support (for accel=on). "
         "Valid values are on, off, and auto. Defaults to off. "
-- 
2.43.0


