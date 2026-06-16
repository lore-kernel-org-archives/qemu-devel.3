Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4E5CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAU-0006tl-MM; Tue, 16 Jun 2026 15:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7k-0004UR-Mi
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:24 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7c-0000uu-P0
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:06:55 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49230a567a9so6465995e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636811; x=1782241611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AIHwlbRuUl3nYtw5K+xyEs99Ce+k47eRk9h4LhKsLb4=;
 b=JsquobFpjsNmDIHs3k8tocNby6OOTWDrhgbGYVtY9HWZjbIh4DhrGJH7DMBnVL7Vx5
 j+YFDzPNkyfowPLeiP8ku6WUZN20lZ2PCDozPzdyfIpSK9CfzXR9MGFay+sSXkY6flAB
 ZEW0D/ew/B6z/81GjxHVw2LUVpLcvSEoFpc6UsaC3VFJQJA24Yg3NCjz3urzmbC5hfOQ
 Ba6wSs8TLTZlkNTlQEI7PF3yMsTQZUp5y3Dt+3EB0yso/I4F40npCpUvgxa5iXevylsK
 vVn6uHkt5mvw+YWm6J3qZqZ/2NLyQBsijtFPQ2L3w1GfsNC1P2zNp+liy0plmNGPUmsJ
 7XTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636811; x=1782241611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AIHwlbRuUl3nYtw5K+xyEs99Ce+k47eRk9h4LhKsLb4=;
 b=Ieio1R2Kp0YKOh5hQWc6ZhvfGQkm1qCt6XC3Q3/F04Ilo1+k2ePdJ+JBXrocwnPhqb
 PE9IC+1lei5Gu6ojF2ISRl6HY550uTd3ofSIrfjOSPVXZpFCRib9+XFryjKIfDe5E7Ur
 TlPd4QR5ORaZeQ1/1NP5bV3lTbYtzUdAZFqtRh+C4mb9UrlFz/HsCCgL0ZG3+YsfKHDP
 jqGgrY7rMSny2gAka9d/ZlveJPVFgJUkvrwPJmqjIW6MlNMugfYnm+8dmA2ROyUoUuAe
 zFoPEKE4nhhfybhYMrzZVsowOitGIFNpelhiyfLNHE81LfXH6+BHV0PoYzjJ2M2ukzg6
 LTmA==
X-Gm-Message-State: AOJu0Yyb64uDQoJ/0Km/zQOKai6HU6/WsXnFRJvxknDTifsdVQ58YFiW
 AEKy7GMcFuuVZhi3nkOEZxXC/DEQW/As0Gj3SRa8cT44U1I2JvPUUfPDB0NJejgFKA6xYIwj1KI
 jJKQJ
X-Gm-Gg: Acq92OHZNGmGzCy/EV1/tH5uR0ruHQiKtTqUSNL6rPXwyuVfxpEsHj3GjF4V71GTlal
 1YG5lFsLPOvgbjj1DwCT37H7SfXu9GDc6NcfNXjG9O5Sj3Z2uTaqPu3YvJ89ohh+Zq572JZv0gv
 lQM/o1+/3CSd1ikHh1a1kvUgRRGJaZGrGImUX7jYQ5UGOkxnIdjSEGkOanpOf/OqILCMdFoAL1C
 Z1vRUmP/GKuzAszicj5gtkNadFr5FZXTlyxlcW2WEZOuyw5kkPotS8gYD0FLlrHLch3DY+vdSby
 ZLXblVa3JIWQfCAljZJosst3fK490QYpqoO6ytbOrp8fp9WWN3F7XiQ49r2RPVfhn6b7vYphSb5
 4Oo5kDbR+Xr/nSpoUXxMFlDSb0ALLhCe78tBgEJ071STpoIBKjppIySTH6TTQdFVhdfLfIgS7im
 QO2rEiRNXOE3HyV/3IL3bC5A4uMThv3zWCyDiW/lxmdJC64+YHnjpON7LkKzcEPlwinxw30c5/t
 ll4S4ZH84qaVUNJmAZn6zrAtQpoEQHv
X-Received: by 2002:a05:600c:19c6:b0:48e:6db3:ff33 with SMTP id
 5b1f17b1804b1-492333f9b76mr11316645e9.14.1781636811202; 
 Tue, 16 Jun 2026 12:06:51 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.06.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:06:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/61] hw/arm/smmuv3: Set default ats, ril, ssidsize,
 oas to auto
Date: Tue, 16 Jun 2026 20:05:45 +0100
Message-ID: <20260616190639.3462006-9-peter.maydell@linaro.org>
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

Set the default value of ATS, RIL, SSIDSIZE, and OAS to auto, in order
to match the host IOMMU properties when accel=on.

If accel=off and these property values are set to auto, the default
property values defined in smmuv3_init_id_regs() for OAS and RIL will
remain unchanged, while SSIDSIZE and ATS values will remain initialized
at 0.

Introduce a new compat for the changed defaults.

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260608174900.2227340-9-nathanc@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c   | 23 +++++++++++++++--------
 hw/core/machine.c |  5 +++++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 89289ab6d2..83fa6468fd 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2129,12 +2129,19 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
+    /*
+     * AUTO values for accel=off will resolve to:
+     * ril: on
+     * ats: off
+     * oas: 44
+     * ssidsize: 0
+     */
     /* RIL can be turned off for accel cases */
-    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
-    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
-    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
+    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_AUTO),
     DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
-                              SSID_SIZE_MODE_0),
+                              SSID_SIZE_MODE_AUTO),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2164,22 +2171,22 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "enabling.");
     object_class_property_set_description(klass, "ril",
         "Enable/disable range invalidation support (for accel=on). "
-        "Valid values are on, off, and auto. Defaults to on. "
+        "Valid values are on, off, and auto. Defaults to auto. "
         "Any attempt to turn it 'on' while the host does not support "
         "it would fail.");
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support (for accel=on). "
-        "Valid values are on, off, and auto. Defaults to off. "
+        "Valid values are on, off, and auto. Defaults to auto. "
         "Please ensure host platform supports ATS before setting it "
         "to on.");
     object_class_property_set_description(klass, "oas",
         "Set Output Address Size in bits (for accel=on). "
-        "Valid values are 44, 48, and auto. Defaults to 44 bits."
+        "Valid values are 44, 48, and auto. Defaults to auto."
         "Please ensure the value does not exceed the maximum "
         "Output Address Size supported by the host platform.");
     object_class_property_set_description(klass, "ssidsize",
         "Set number of bits used to represent SubstreamIDs (SSIDs). "
-        "Valid values are 0-20 and auto. Defaults to 0. "
+        "Valid values are 0-20 and auto. Defaults to auto. "
         "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
         "A value of 0 disables SubstreamID support. A value greater "
         "than 0 is required to enable PASID support."
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4d8b15d99e..9a10e45aab 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,11 +38,16 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
+#include "hw/arm/smmuv3.h"
 
 GlobalProperty hw_compat_11_0[] = {
     { "chardev-vc", "encoding", "cp437" },
     { "tpm-crb", "cap-chunk", "off" },
     { "tpm-crb", "x-allow-chunk-migration", "off" },
+    { TYPE_ARM_SMMUV3, "ats", "off" },
+    { TYPE_ARM_SMMUV3, "ril", "on" },
+    { TYPE_ARM_SMMUV3, "ssidsize", "0" },
+    { TYPE_ARM_SMMUV3, "oas", "44" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
-- 
2.43.0


