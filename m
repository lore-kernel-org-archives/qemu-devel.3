Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AEDEC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKR-0001fT-B4; Mon, 23 Feb 2026 12:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKN-0001Ue-3n
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:35 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKL-00008K-1Q
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:34 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso36857035e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866151; x=1772470951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dKOYQWFzPxR9pIFAnXPm0w2KogR9R3k5m6huzTb6ybI=;
 b=bPco4e6U/0BROPb3lnhllmAc1M8/xQCFA/WLSwQkNuY+ErSdfDzx6B/vytO0NBd31S
 jMwKhK66vjNOchjPgpTDPCJ4je4kv7GtnPpZI1pXYTXxTWtEQsx50s2wH596R5/Kq6Vm
 jzDuQDmLV2vfl1VYJtpr2CpTpJSMoCOdKlnZOG0i5GyK1RVkdTQuEjzCny4evad6Ttcm
 AJyPlcCZWcSsbBYGWaJBZKcLg29bbspziKIVP1bLfnSdnnZMBMS3r9p6s2fjiEMbMsO0
 /QQxEPcw3BbAygonExaQGs8XfylCNGw0kz9Mv4TK8LamWECfHx+Huq1XQU5cWptYRhZY
 YafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866151; x=1772470951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dKOYQWFzPxR9pIFAnXPm0w2KogR9R3k5m6huzTb6ybI=;
 b=EuYTGpg2+U/7bKawn6E/3QXwRCXtnvMU3cnZl0TgvVjNDxhrEUT+lA4ZdJaE7yBDXZ
 1hwQIlMymQ3bKqTLCzAshDYyOXtuppJD7/3ZEekUii65fBIe2f97tKpmAt791aM1oIHY
 75eNLaF8PK1W997PDGGZ7Pic5YpdTZz5PTM8evrUIyi1Jvm08po8Wh9Lc8NM2sJJHqDJ
 s1ZizHOCeEOwRig3o9GD/A5l8+6wJc630uXc7XkSNMIOGQad9VVN+tn73SsLXiHeebee
 g8JN3DVRZAaf1vYT5L011+9ZP+rsjAlnqDY8QhEpdttpRzWU3h+jyxBaO9pKWrHFh9Qn
 BZlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZtTOaOmGW+/cv5gdalGLflDb6bASXvSza1tv++8T27YpIdAWpWKx3KxaipSTQzWFoIW5BxdTf7l7v@nongnu.org
X-Gm-Message-State: AOJu0Yz2BCPGu/fFMFTBWzBt/jxyuGKCnFGhVeqJJMH+6uHYLH9mVfG2
 oDzMSHz3WTaN0oMplVr4YOgzqQ200ArS2kLHyH4eK3ttMU3ykyF1Cvg9KVGYvYR9xjjwxvjrqwz
 vFIs9
X-Gm-Gg: AZuq6aJgsGtmZpL27Tkg1+upieaoUx4TnhY9GGb+OhBVfnIpPDfBqX1mVHcI4gKlEsG
 7rqDHswdiWtqAEk+HKi2yO8e2FkHRBvdxwOerxQbwNrKhIRbO4f7LxbVmTvvptYFwXDlDN6Hb+o
 aeuKakLh7oNutqh2kqRKBp2s2f1CsEfxkTieEQai4IZBZjO6j9Ct1EKlBxYhYxoMyjMYgO1kpmw
 qhWodt9k1cT1XtgXFq5xTHCDVC8vj1Dcxkfzmy3W+bl3dzXZa0gja/nXJgFPuQY7ni+NYHRFVIx
 gKPbePkimWkCJopOWFRpCgSmY8pQ3bF3BqYGVyXMupmMXtlxwahMVmfOa+85xhkNOBU1jOZRXQW
 b9zN/alocjApBvIZHjy2n2BzQ/Rf6YtfWIc4SEvhFImUz4Am/Bn9jzqeYT6VpVjl+taN+pPSHPx
 fJIYT4KOuu1Du8DfJOqFf95fjFD8xXoFx4xkixZLFvp3surjth6Ndhrv8CRpWHwYFoYmhjY8mo6
 HWs0tivc4F2DUqcRjE1cJbr0bF/6D0=
X-Received: by 2002:a05:600c:4749:b0:480:69b6:dfed with SMTP id
 5b1f17b1804b1-483a95e5ab8mr160397335e9.24.1771866151442; 
 Mon, 23 Feb 2026 09:02:31 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 14/65] target/arm: Set up pointer to GICv5 in each CPU
Date: Mon, 23 Feb 2026 17:01:21 +0000
Message-ID: <20260223170212.441276-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

The qdev link property array gives the IRS a pointer to each CPU that
is connected to it, but the CPU also needs a pointer to the IRS so
that it can issue commands.  Set this up in a similar way to how we
do it for the GICv3: have the GIC's realize function call
gicv5_set_gicv5state() to set a pointer in the CPUARMState.

The CPU will only allow this link to be made if it actually
implements the GICv5 CPU interface; it will be the responsibility of
the board code to configure the CPU to have a GICv5 cpuif if it wants
to connect a GICv5 to it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5_common.c         |  9 +++++++++
 include/hw/intc/arm_gicv5_stream.h | 32 ++++++++++++++++++++++++++++++
 target/arm/cpu.c                   | 16 +++++++++++++++
 target/arm/cpu.h                   |  2 ++
 4 files changed, 59 insertions(+)
 create mode 100644 include/hw/intc/arm_gicv5_stream.h

diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 620ae3b88f..046dcdf5a3 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/intc/arm_gicv5_common.h"
+#include "hw/intc/arm_gicv5_stream.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "trace.h"
@@ -129,6 +130,14 @@ static void gicv5_common_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    for (int i = 0; i < cs->num_cpus; i++) {
+        if (!gicv5_set_gicv5state(cs->cpus[i], cs)) {
+            error_setg(errp,
+                       "CPU %d does not implement GICv5 CPU interface", i);
+            return;
+        }
+    }
+
     address_space_init(&cs->dma_as, cs->dma, "gicv5-sysmem");
 
     trace_gicv5_common_realize(cs->irsid, cs->num_cpus,
diff --git a/include/hw/intc/arm_gicv5_stream.h b/include/hw/intc/arm_gicv5_stream.h
new file mode 100644
index 0000000000..9b9c2e4b60
--- /dev/null
+++ b/include/hw/intc/arm_gicv5_stream.h
@@ -0,0 +1,32 @@
+/*
+ * Interface between GICv5 CPU interface and GICv5 IRS
+ * Loosely modelled on the GICv5 Stream Protocol interface documented
+ * in the GICv5 specification.
+ *
+ * Copyright (c) 2025 Linaro Limited
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_INTC_ARM_GICV5_STREAM_H
+#define HW_INTC_ARM_GICV5_STREAM_H
+
+#include "target/arm/cpu-qom.h"
+
+typedef struct GICv5Common GICv5Common;
+
+/**
+ * gicv5_set_gicv5state
+ * @cpu: CPU object to tell about its IRS
+ * @cs: the GIC IRS it is connected to
+ *
+ * Set the CPU object's GICv5 pointer to point to this GIC IRS.
+ * The IRS must call this when it is realized, for each CPU it is
+ * connected to.
+ *
+ * Returns true on success, false if the CPU doesn't implement
+ * the GICv5 CPU interface.
+ */
+bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs);
+
+#endif
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 10f8280eef..ef2afca6b9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -41,6 +41,7 @@
 #include "hw/core/boards.h"
 #ifdef CONFIG_TCG
 #include "hw/intc/armv7m_nvic.h"
+#include "hw/intc/arm_gicv5_stream.h"
 #endif /* CONFIG_TCG */
 #endif /* !CONFIG_USER_ONLY */
 #include "system/tcg.h"
@@ -1085,6 +1086,21 @@ static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
+#ifndef CONFIG_USER_ONLY
+bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs)
+{
+    /*
+     * Set this CPU's gicv5state pointer to point to the GIC that we are
+     * connected to.
+     */
+    if (!cpu_isar_feature(aa64_gcie, cpu)) {
+        return false;
+    }
+    cpu->env.gicv5state = cs;
+    return true;
+}
+#endif
+
 uint64_t arm_build_mp_affinity(int idx, uint8_t clustersz)
 {
     uint32_t Aff1 = idx / clustersz;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 657ff4ab20..16de0ebfa8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -812,6 +812,8 @@ typedef struct CPUArchState {
     const struct arm_boot_info *boot_info;
     /* Store GICv3CPUState to access from this struct */
     void *gicv3state;
+    /* Similarly, for a GICv5Common */
+    void *gicv5state;
 #else /* CONFIG_USER_ONLY */
     /* For usermode syscall translation.  */
     bool eabi;
-- 
2.43.0


