Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01ADCCCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Pr-0005bP-P9; Tue, 07 Oct 2025 10:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Po-0005ai-Ld
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:44 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Pd-00026R-8j
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:44 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e4ad36541so68178785e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846288; x=1760451088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oX2FCvIB4I7ri29/FyaOfLvbFk1Cxz3ulaGtZkX8IS8=;
 b=MxT7ICH3iFBIwWfEvYy4A1Z6P5JlWx7adplQMGAclQVkUWr1O3B859geX16hTU+QM7
 0TpIEwqhW0BKCmWwYRbBqqKuEsbVs8ORAqiFpv4Ey40aI+mEWtb8jb6tTvqP8Ze8nWSR
 7eumgRxcoe1cmI+Wd9O0PSMrXHsXfQ3DPx+XEijs6MtCs8+YUpAY5hwp4nlLXX5p1ci6
 OM/rErsJAPr8WHTOfNWnikmAVwZH8RHoskPub7Cm7s6l251Hx/JkjNfV0EqxGpFa96cL
 qmJKe/bcbpCmCCJsNuEQkA+3c2nn2Oa+qR5udxiu3DsdvmalfM7T/2f3/Ti1sYe5kPIA
 kjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846288; x=1760451088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oX2FCvIB4I7ri29/FyaOfLvbFk1Cxz3ulaGtZkX8IS8=;
 b=g3+aHSREK357/FiqbHZTjkfhH9V6b143JqQnwzhphqg2HxnFXXu5sBQ1qocLZQxSbJ
 vcQWLbjPNta/I2O7UIW3gzxkKed9sP1r1JRKTQDN9flendliwVKNnzcdDc8iZE3AVA8C
 HwEFtoWWh6LCgob4mwryQRFUB0X8Z5IBivqkkg1ntzXKf212bLJLb+nh7SBIdFJTifVG
 M2XX8JyZ7BQJejMbHn/W04wdf8aJ4dC/IVHpiI35dem4sHnYIozV0UJUi/NE0fwDQ/qf
 oVwe34KmncsSEpkGL5DvToaDqJTOaTGfJ3aC3Agnddq50jsrTo46cXRrsbLtLVXuufJv
 UuTw==
X-Gm-Message-State: AOJu0YzU+q/xwivYzeCftMFUjzYVqmwEqnbSWWJBKt9ONrfv+TDbmhc9
 4jRpIJE1JU8dTWqavLwEjQPBxoLxFYfXwr8pMrbDFUs7DYQ8g/cMFCCArgTADeKFDGTAnS09tyR
 5nF1F
X-Gm-Gg: ASbGnctFPG4P0AgkfNCC33Nbc9H58sGJ+ryXlNuxIuj7Llg6MprRzqft1A8zXcpeRJ8
 G4xjCws3hcjUl1clsqkAOWtbDvmJ4Bn9oSCzmV200x1lYMDl9d/AhahT0K3OseHQl72IXnY8tSE
 6nqT+Ev7Tv7aa5SEzFgGP8As+gLkD5sA+FEaW5JXKUkmMu7dFQmlEc1NKqpoKvFkO4If61XGN3P
 lH0H4p9vNxqajrjujcY3Pt0pWYtFEauOLTQoJ/CP6S0j9CNZN+niQP6g9CTRIn3QI8UV+lUwjjS
 xjEckY6VRW9EVo2TvrDZyylUxmMelORmXEgQSneJbNMzbIPJ72Q2jguJinvYW7b/oBXXhjalMgn
 JeeqlkNh4HnRXRFA8sn0b78aIF10t1pGV6NI0ZLvyOjqWBXQKtKiHuePa
X-Google-Smtp-Source: AGHT+IFO9sYj0iJIOkTbH5ZUnYWrBPt7MVtPkfd7jkiS09x3M/ybUg6EPQKUSZd/QTXP8/c8ol6zxg==
X-Received: by 2002:a05:600c:4e0e:b0:46e:5df3:190d with SMTP id
 5b1f17b1804b1-46f9d694446mr47402235e9.11.1759846287886; 
 Tue, 07 Oct 2025 07:11:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/62] hw/arm/xlnx-versal: split the xlnx-versal type
Date: Tue,  7 Oct 2025 15:10:22 +0100
Message-ID: <20251007141123.3239867-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Luc Michel <luc.michel@amd.com>

Split the xlnx-versal device into two classes, a base, abstract class
and the existing concrete one. Introduce a VersalVersion type that will
be used across several device models when versal2 implementation is
added.

This is in preparation for versal2 implementation.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-2-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal-version.h | 15 ++++++++++++++
 include/hw/arm/xlnx-versal.h         | 12 ++++++++++-
 hw/arm/xlnx-versal.c                 | 31 +++++++++++++++++++++-------
 3 files changed, 50 insertions(+), 8 deletions(-)
 create mode 100644 include/hw/arm/xlnx-versal-version.h

diff --git a/include/hw/arm/xlnx-versal-version.h b/include/hw/arm/xlnx-versal-version.h
new file mode 100644
index 00000000000..c4307d1304a
--- /dev/null
+++ b/include/hw/arm/xlnx-versal-version.h
@@ -0,0 +1,15 @@
+/*
+ * AMD Versal versions
+ *
+ * Copyright (c) 2025 Advanced Micro Devices, Inc.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_ARM_XLNX_VERSAL_VERSION_H
+#define HW_ARM_XLNX_VERSAL_VERSION_H
+
+typedef enum VersalVersion {
+    VERSAL_VER_VERSAL,
+} VersalVersion;
+
+#endif
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 05ed641b6b6..1f92e314d6c 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -2,6 +2,7 @@
  * Model of the Xilinx Versal
  *
  * Copyright (c) 2018 Xilinx Inc.
+ * Copyright (c) 2025 Advanced Micro Devices, Inc.
  * Written by Edgar E. Iglesias
  *
  * This program is free software; you can redistribute it and/or modify
@@ -35,9 +36,12 @@
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "target/arm/cpu.h"
+#include "hw/arm/xlnx-versal-version.h"
+
+#define TYPE_XLNX_VERSAL_BASE "xlnx-versal-base"
+OBJECT_DECLARE_TYPE(Versal, VersalClass, XLNX_VERSAL_BASE)
 
 #define TYPE_XLNX_VERSAL "xlnx-versal"
-OBJECT_DECLARE_SIMPLE_TYPE(Versal, XLNX_VERSAL)
 
 #define XLNX_VERSAL_NR_ACPUS   2
 #define XLNX_VERSAL_NR_RCPUS   2
@@ -137,6 +141,12 @@ struct Versal {
     } cfg;
 };
 
+struct VersalClass {
+    SysBusDeviceClass parent;
+
+    VersalVersion version;
+};
+
 /* Memory-map and IRQ definitions. Copied a subset from
  * auto-generated files.  */
 
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index a42b9e7140b..4da656318f6 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -2,6 +2,7 @@
  * Xilinx Versal SoC model.
  *
  * Copyright (c) 2018 Xilinx Inc.
+ * Copyright (c) 2025 Advanced Micro Devices, Inc.
  * Written by Edgar E. Iglesias
  *
  * This program is free software; you can redistribute it and/or modify
@@ -920,7 +921,7 @@ static void versal_unimp(Versal *s)
 
 static void versal_realize(DeviceState *dev, Error **errp)
 {
-    Versal *s = XLNX_VERSAL(dev);
+    Versal *s = XLNX_VERSAL_BASE(dev);
     qemu_irq pic[XLNX_VERSAL_NR_IRQS];
 
     versal_create_apu_cpus(s);
@@ -955,9 +956,9 @@ static void versal_realize(DeviceState *dev, Error **errp)
                                         &s->lpd.rpu.mr_ps_alias, 0);
 }
 
-static void versal_init(Object *obj)
+static void versal_base_init(Object *obj)
 {
-    Versal *s = XLNX_VERSAL(obj);
+    Versal *s = XLNX_VERSAL_BASE(obj);
 
     memory_region_init(&s->fpd.apu.mr, obj, "mr-apu", UINT64_MAX);
     memory_region_init(&s->lpd.rpu.mr, obj, "mr-rpu", UINT64_MAX);
@@ -975,7 +976,7 @@ static const Property versal_properties[] = {
                       TYPE_CAN_BUS, CanBusState *),
 };
 
-static void versal_class_init(ObjectClass *klass, const void *data)
+static void versal_base_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -984,16 +985,32 @@ static void versal_class_init(ObjectClass *klass, const void *data)
     /* No VMSD since we haven't got any top-level SoC state to save.  */
 }
 
-static const TypeInfo versal_info = {
-    .name = TYPE_XLNX_VERSAL,
+static void versal_class_init(ObjectClass *klass, const void *data)
+{
+    VersalClass *vc = XLNX_VERSAL_BASE_CLASS(klass);
+
+    vc->version = VERSAL_VER_VERSAL;
+}
+
+static const TypeInfo versal_base_info = {
+    .name = TYPE_XLNX_VERSAL_BASE,
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(Versal),
-    .instance_init = versal_init,
+    .instance_init = versal_base_init,
+    .class_init = versal_base_class_init,
+    .class_size = sizeof(VersalClass),
+    .abstract = true,
+};
+
+static const TypeInfo versal_info = {
+    .name = TYPE_XLNX_VERSAL,
+    .parent = TYPE_XLNX_VERSAL_BASE,
     .class_init = versal_class_init,
 };
 
 static void versal_register_types(void)
 {
+    type_register_static(&versal_base_info);
     type_register_static(&versal_info);
 }
 
-- 
2.43.0


