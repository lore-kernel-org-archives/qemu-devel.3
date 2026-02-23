Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3068EEC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKA-0001Bf-8b; Mon, 23 Feb 2026 12:02:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZK8-0001AA-SZ
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:20 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZK6-0008UE-Bp
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:20 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-4837907f535so41149275e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866137; x=1772470937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QC2jCmUmDa22pq2M5e1IUAC/xLyvzU6A+/CopHKbGoc=;
 b=r+jNM1/qTLbNKGTBa1+KkH5GxpFsJRaVb6+AKqUzF1tDdeegUVkPgHyDGLHyVhKjyF
 CKvuOTJYjmsjLZ/SlKSwwLmje1E7bdyNdUK/axWINDiIzKQEV91POGAgYZXAdz2g4dDQ
 K8lTsvH8jOMHSpCROlPO7H3sHRjwX+9cZWXmByTBkttxmlzIZ5PSBeYB8T5BRcz6eFJE
 O3th+LeyaoAPR27Dg4N2sW1RaQ8nJUXhId0Pc5q3JrdFh+PP0KnjrcmSte6CvMfgM4Cd
 ciEQP+XREEsTYj698PMlYiDYooiRtbT84GLcAHEbdbejgBhnAVi4BbGnG8NuSsi+PA92
 IvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866137; x=1772470937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QC2jCmUmDa22pq2M5e1IUAC/xLyvzU6A+/CopHKbGoc=;
 b=U8CjFi3d/he0RjIRTEz54zz2H9TTx8UZmjL/LYKYRVMGshTktMmIa3jqRv4BtwZBl3
 8T/xG1zYTGON82gTXdV9X+CJAq60wwGYBSlYfDFKYfuEQPAA1UEDt6/Rv/1O1BmwUKLw
 bGZfd56zMO69WJ6ldK2/YAzMM5L/qpKVAzCeODrUp5Z/6kHVOAkloNhP3BVM0jYlQora
 J+CDiyT3Q9FM16e7SDFNegQsNLGW5DPlvuV2DLSD2LgIitC1EPGo92K1oKMmo5BR6lmS
 KFCthJ6bnsgk/WE2mFSQgGRmNwXo+U8h4+5phL9tcsAJZsNWr7v7XvIy24Bf54WCe7bD
 d2vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHtkhb80Ahq9f31w6HJTvx9qI6lsOozTbfMqYJI1XLlRwLP/djx7Fnkvn0GUzgnnudTnP6zwow5Wco@nongnu.org
X-Gm-Message-State: AOJu0YyQfn3EuLufMlrfZIno+ND4gcNMpRlGT7mXRivzgfxSaZ3e0rpd
 5AJMgqUFessLnv+DJGaqsYK8h7sftUzqxH5u2BgOVbRKgavBBnY3s1hY0s+IsLqNdad9dyGbqr7
 e/tvhLhE=
X-Gm-Gg: AZuq6aKxj0pzX3y5g9yLedbbg8vF0HXuIOGR/AGYZx7vV/133psC/SVsi6ddBj6OV0A
 I9OuzRlUw2e7OX481rq3aj8DrAzOwOFcjDZCkBBjVbsl4YR7q4payAhalf7xZTJ9+TBEbmi3ugk
 ix341r9visLYygUllD3oWSMz9a0dcfNweMlo1PDGYDy1HCy+plcP5MdAPmzRtw8kAHmXUWXqVXP
 CJgoG0tGfq3xJ4vfI5vHVPF8tXoPx+8jUzrT5lcI2or5Eapk5TiWsfDRbs3zoa1dAczrVgS3yu+
 JlVVftTHd5eCLilv7qM4hgjRQQSykA2ndPBl+cKMW3iT5lh0EBWA3whl33pMA7+HHHB/kl8yXnV
 puZAqJCgd4QXWdWWZW91aAj8gyzjs/nUIPAESOR97TrE6Oa2jpz7cqjhtEjbz9SxI7Ljot2wUSK
 0cU+uaxrn20mBEnNf5fEwt8YLhTxekwTsbBtyZLwUSPfrcNUe0Hd9yfNTLGZzO9i//tbAaex/BZ
 c39S2q/oVMlT46ZR8cd03HqhjOe3R0=
X-Received: by 2002:a05:600c:8b27:b0:480:69ae:f0e9 with SMTP id
 5b1f17b1804b1-483a95eb3bamr185842405e9.16.1771866136485; 
 Mon, 23 Feb 2026 09:02:16 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 02/65] hw/intc: Skeleton of GICv5 IRS classes
Date: Mon, 23 Feb 2026 17:01:09 +0000
Message-ID: <20260223170212.441276-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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

This commit adds the skeleton of the classes for the GICv5 IRS
(Interrupt Routing Service).  Since the IRS is the main (and only
non-optional) part of the GICv5 outside the CPU, we call it simply
"GICv5", in line with how we've handled the GICv3.

Since we're definitely going to need to have support for KVM VMs
where we present the guest with a GICv5, we use the same split
between an abstract "common" and a concrete specific-to-TCG child
class that we have for the various GICv3 components.  This avoids
having to refactor out the base class later.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/Kconfig                    |  4 +++
 hw/intc/arm_gicv5.c                | 39 ++++++++++++++++++++++++++++++
 hw/intc/arm_gicv5_common.c         | 31 ++++++++++++++++++++++++
 hw/intc/meson.build                |  4 +++
 include/hw/intc/arm_gicv5.h        | 32 ++++++++++++++++++++++++
 include/hw/intc/arm_gicv5_common.h | 31 ++++++++++++++++++++++++
 6 files changed, 141 insertions(+)
 create mode 100644 hw/intc/arm_gicv5.c
 create mode 100644 hw/intc/arm_gicv5_common.c
 create mode 100644 include/hw/intc/arm_gicv5.h
 create mode 100644 include/hw/intc/arm_gicv5_common.h

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 9f456d7e43..a3241fc1eb 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -35,6 +35,10 @@ config ARM_GIC_KVM
     bool
     depends on ARM_GIC && KVM
 
+config ARM_GICV5
+    bool
+    select MSI_NONBROKEN
+
 config XICS
     bool
 
diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
new file mode 100644
index 0000000000..f9dab710d3
--- /dev/null
+++ b/hw/intc/arm_gicv5.c
@@ -0,0 +1,39 @@
+/*
+ * ARM GICv5 emulation: Interrupt Routing Service (IRS)
+ *
+ * Copyright (c) 2025 Linaro Limited
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/intc/arm_gicv5.h"
+
+OBJECT_DEFINE_TYPE(GICv5, gicv5, ARM_GICV5, ARM_GICV5_COMMON)
+
+static void gicv5_reset_hold(Object *obj, ResetType type)
+{
+    GICv5 *s = ARM_GICV5(obj);
+    GICv5Class *c = ARM_GICV5_GET_CLASS(s);
+
+    if (c->parent_phases.hold) {
+        c->parent_phases.hold(obj, type);
+    }
+}
+
+static void gicv5_init(Object *obj)
+{
+}
+
+static void gicv5_finalize(Object *obj)
+{
+}
+
+static void gicv5_class_init(ObjectClass *oc, const void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+    GICv5Class *gc = ARM_GICV5_CLASS(oc);
+
+    resettable_class_set_parent_phases(rc, NULL, gicv5_reset_hold, NULL,
+                                       &gc->parent_phases);
+}
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
new file mode 100644
index 0000000000..b0194f7f26
--- /dev/null
+++ b/hw/intc/arm_gicv5_common.c
@@ -0,0 +1,31 @@
+/*
+ * Common base class for GICv5 IRS
+ *
+ * Copyright (c) 2025 Linaro Limited
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/intc/arm_gicv5_common.h"
+
+OBJECT_DEFINE_ABSTRACT_TYPE(GICv5Common, gicv5_common, ARM_GICV5_COMMON, SYS_BUS_DEVICE)
+
+static void gicv5_common_reset_hold(Object *obj, ResetType type)
+{
+}
+
+static void gicv5_common_init(Object *obj)
+{
+}
+
+static void gicv5_common_finalize(Object *obj)
+{
+}
+
+static void gicv5_common_class_init(ObjectClass *oc, const void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+
+    rc->phases.hold = gicv5_common_reset_hold;
+}
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 96742df090..e4ddc5107f 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -12,6 +12,10 @@ system_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files(
   'arm_gicv3_its.c',
   'arm_gicv3_redist.c',
 ))
+system_ss.add(when: 'CONFIG_ARM_GICV5', if_true: files(
+  'arm_gicv5_common.c',
+  'arm_gicv5.c',
+))
 system_ss.add(when: 'CONFIG_ALLWINNER_A10_PIC', if_true: files('allwinner-a10-pic.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_vic.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_intc.c'))
diff --git a/include/hw/intc/arm_gicv5.h b/include/hw/intc/arm_gicv5.h
new file mode 100644
index 0000000000..3cd9652f6f
--- /dev/null
+++ b/include/hw/intc/arm_gicv5.h
@@ -0,0 +1,32 @@
+/*
+ * ARM GICv5 emulation: Interrupt Routing Service (IRS)
+ *
+ * Copyright (c) 2025 Linaro Limited
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_INTC_ARM_GICV5_H
+#define HW_INTC_ARM_GICV5_H
+
+#include "qom/object.h"
+#include "hw/core/sysbus.h"
+#include "hw/intc/arm_gicv5_common.h"
+
+#define TYPE_ARM_GICV5 "arm-gicv5"
+
+OBJECT_DECLARE_TYPE(GICv5, GICv5Class, ARM_GICV5)
+
+/*
+ * This class is for TCG-specific state for the GICv5.
+ */
+struct GICv5 {
+    GICv5Common parent_obj;
+};
+
+struct GICv5Class {
+    GICv5CommonClass parent_class;
+    ResettablePhases parent_phases;
+};
+
+#endif
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
new file mode 100644
index 0000000000..d2243c7660
--- /dev/null
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -0,0 +1,31 @@
+/*
+ * Common base class for GICv5 IRS
+ *
+ * Copyright (c) 2025 Linaro Limited
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_INTC_ARM_GICV5_COMMON_H
+#define HW_INTC_ARM_GICV5_COMMON_H
+
+#include "qom/object.h"
+#include "hw/core/sysbus.h"
+
+#define TYPE_ARM_GICV5_COMMON "arm-gicv5-common"
+
+OBJECT_DECLARE_TYPE(GICv5Common, GICv5CommonClass, ARM_GICV5_COMMON)
+
+/*
+ * This class is for common state that will eventually be shared
+ * between TCG and KVM implementations of the GICv5.
+ */
+struct GICv5Common {
+    SysBusDevice parent_obj;
+};
+
+struct GICv5CommonClass {
+    SysBusDeviceClass parent_class;
+};
+
+#endif
-- 
2.43.0


