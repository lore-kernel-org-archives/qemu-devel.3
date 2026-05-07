Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADFECD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11L-0003Uq-2t; Thu, 07 May 2026 11:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11I-0003Tq-NO
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:12 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11G-0003p8-Re
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:12 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso11496805e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169129; x=1778773929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vm5QiSnH8IwWNwI3N643Op2tyJpVuocW3kNmorzza+w=;
 b=URtaOKwDNpffNodKK8KF+cHsd4VMfwI4kvtlv8cYNyRk1WgPw+9SfWr9CBlTgiOx0I
 e/+CzmYadD9rnqhEYwc6m38LzqZfDTVXKwkaZah3isQdKvHMaiK3YwgpbLBZnwG794IY
 mVO6kLdfyJ+Zs9OmvdEZ2YCz6i+0R/kG9KfbOYkeqcTNI3xymFERam2o2zU1RdcTAl4v
 T4gzTXGiWWEFAfOvLSziaPHhyS/nu7wPqGpzL43mQuczXHPe4L+nhYEfzafvfHuvH8+n
 ve/eNLOWlvF1g4Dcxt6RfO0+tJG/NLUo1uiRFnHvKrnPrujlDcBNZU5BIlk9qPh/nzeT
 a3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169129; x=1778773929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vm5QiSnH8IwWNwI3N643Op2tyJpVuocW3kNmorzza+w=;
 b=Wp0TCnm0/+BrRQ8oTctFutPNl1U5j2t2Vd1cmg0JZUYnpVnkduJw4YYip/cIbJuRb/
 j81uI6ZD+QVQZ86SJ2O3qLAhWNoyueKmK5ouamWenSpziTQbLafMBE02BC6GrHWYF734
 GqlCE626a/BJDH0T2HlHvYH0UD5OfowROEbRedCUdpr3/oQeac7BUXCcQZ1XLQz/0aBq
 svBrtlxHcb8jrlqPf99xW1HK11JwobOXpUmbL596jR8zCVPoNh/vAfmNZNxpuKJ++BHg
 K5fsQXYXXHdqhz1J8wwifpcf8bBNKfLp5icVewOxZJeQKfxlgS9NwyvT50bG0a+AOdj7
 ML3g==
X-Gm-Message-State: AOJu0YztZFpgvIG7hiyuyx2Nz3vbCjkXumr9PU6o3HeUASgS+9ExlsTc
 z4V9t2swNid6sYqr9kfcWcsvIbqC+PxdP09ekYMUrurJtAMVsMW+EO3mxD+RK4ZB4ZdpbKsCEPj
 mboBX
X-Gm-Gg: AeBDiesgOsNwONddom/Fx5BzOcXY0hhBaa3HQpfLm6opV4dO1LpT/AdkNaULvF8jXbq
 psibDZWKOLo4DvRmskQlQt4M/6xjDE3rliwyOAq90YkHTnXCSRrREwa/JB3d338pn/CEJm/NWeb
 3XDbgyIa9Ac45akP637dz0BgQdaCS2AJB2UyvkxFYIkiOoCb/dgWFOA/WQvoU9tuTzAMjjl/h3q
 fx+Uqbf05jAwaBQ44Os3PJsfcF3ZTM4jP/6HTa641vlE1svletv48vj42c8E/cxdYUDqBHPTfZ0
 MwV7AO8Vo4ZyurljoVFgwpHRlb/TAlHpBAm3Qj3XVmmwBDEp0OWxWbdS+wBvj/hC0hrm3tJq5nM
 B3sRYKYloQS/JwSyIHSnseqLI2JkLDvX/kPnJzl3Ki9QU5TZsEguPAo3LeXp55CizWNmpO1AdhE
 wvizaO5B1/pOq2mr3pR7UantGaakeofHJePBB8vnfILW8+noiZ2ztbewNHdnJuUwVIFAVb/UbZx
 RNJGT9kxcrRs8IToLWw9C1Ghphd2659ldUmAvb2hQ==
X-Received: by 2002:a05:600d:18:b0:488:b811:51c4 with SMTP id
 5b1f17b1804b1-48e51f3c4f4mr107777795e9.25.1778169129155; 
 Thu, 07 May 2026 08:52:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/67] target/arm: Set up pointer to GICv5 in each CPU
Date: Thu,  7 May 2026 16:51:02 +0100
Message-ID: <20260507155154.1886557-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260327111700.795099-16-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5_common.c         |  9 +++++++++
 include/hw/intc/arm_gicv5_stream.h | 32 ++++++++++++++++++++++++++++++
 target/arm/cpu.c                   | 16 +++++++++++++++
 target/arm/cpu.h                   |  2 ++
 4 files changed, 59 insertions(+)
 create mode 100644 include/hw/intc/arm_gicv5_stream.h

diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 29cc96917e..98a432af33 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/intc/arm_gicv5_common.h"
+#include "hw/intc/arm_gicv5_stream.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
 #include "trace.h"
@@ -127,6 +128,14 @@ static void gicv5_common_realize(DeviceState *dev, Error **errp)
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
index 0000000000..7257ddde90
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
+ * Set the CPU object's GICv5 pointer to point to this GIC IRS.  The
+ * IRS must call this when it is realized, for each CPU it is
+ * connected to.
+ *
+ * Returns true on success, false if the CPU doesn't implement the
+ * GICv5 CPU interface.
+ */
+bool gicv5_set_gicv5state(ARMCPU *cpu, GICv5Common *cs);
+
+#endif
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 10feb639c4..de9ba141bd 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -39,6 +39,7 @@
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/core/loader.h"
 #include "hw/core/boards.h"
+#include "hw/intc/arm_gicv5_stream.h"
 #ifdef CONFIG_TCG
 #include "hw/intc/armv7m_nvic.h"
 #endif /* CONFIG_TCG */
@@ -1157,6 +1158,21 @@ static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
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
index 0b9755533b..91cb2b87f0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -811,6 +811,8 @@ typedef struct CPUArchState {
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


