Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B69C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJZg-0001kt-CO; Mon, 01 Jul 2024 12:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZG-0000pX-6c
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:50 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZC-0005UF-Ja
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:49 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42567ddf099so23097725e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850063; x=1720454863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QnprYGSDTA/0TStnFoLmzzYBTMez64bKJk78fitMFgo=;
 b=Rh0xQZfsvMrXp1uocjN7/zXgTqjY93kfm6HL81XxDHaCKWZIlhE5bR188QWCVxfYQe
 JeLUYpvCqRWSIzVVh2wiR4RPj8MooV87B/X1dhe44OZ6GGl9TiBmvMVOBliiEpwYtY20
 aDdCAZE1GrPoNlC3XjOWrEZswNqRwkVcWbrlrV/Y6eeRhGkWnCQbqolzVhE9xuQTZcBb
 S5wKPW6qfew7J5EZUw7KaYXxr1y9s5TcfzEfytXlawDR2+EDb60WzZQdI7xzuIrTv5DJ
 92JGAt/is53NHCruFEEQlbap5R1P/TnjXQrNr1Kll1IbRxrU/0loke8l+fXyHbOvpRML
 SGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850063; x=1720454863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QnprYGSDTA/0TStnFoLmzzYBTMez64bKJk78fitMFgo=;
 b=Oq+Vr/Z/Uco9mF27OGe417jwV4cdVNs+yW1Of+spYSLeCKB/sW/fuJQhY+U1ce4LTu
 J2+7/Lv20TSYrodu8ilrNdnls4ZfFOilinx3gY1Ig8x5Uh0IJFwEqiHxDfUIz+AE0JB6
 m93UK/8KQmbnSK2/qW3nh7ljoi04luQcSGwpbMGqVhK8gkD3fF7ikWu8FbEn4msnpvCi
 /tyDzCqJx/5ns0FPSK9bM6geT8uLDpNSfwUIe9d9bS0VrEBssCecsRLNX1Jp7xoQUc9/
 bUY2e20UCZ1YXCewzRz83Y2iX+28a7GFJdNHQ9F+p8hIUq2eboukWleMLLmOZyE6dIiB
 sIPA==
X-Gm-Message-State: AOJu0Yzs/gkiduc4aOGSL1MPMFbF0wGzRBjFhd8TMX8Te8N4QtAioWS7
 j7S2AtrYX6wCGwinF1kecv+QLDQCKPjPVPkDFO1qmKSVO089VxaC0HHiOC0XGGfFM01Fbnm96We
 q0yU=
X-Google-Smtp-Source: AGHT+IHQDPFxcK0f8O8zbf2RctNaPxXdxFv/rdT17gV/J3Ggr9vrrVblgQ5CVGQ9ff3ZZ5ab/VPr7Q==
X-Received: by 2002:a05:600c:2e4b:b0:424:8fa1:b2c3 with SMTP id
 5b1f17b1804b1-4257a0117a8mr39302925e9.23.1719850063158; 
 Mon, 01 Jul 2024 09:07:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/29] hw/arm/xilinx_zynq: Add boot-mode property
Date: Mon,  1 Jul 2024 17:07:25 +0100
Message-Id: <20240701160729.1910763-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>

Read boot-mode value as machine property and propagate that to
SLCR.BOOT_MODE register.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Acked-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Message-id: 20240621125906.1300995-3-sai.pavan.boddu@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xilinx_zynq.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index c79661bbc1b..3c56b9abe1c 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -38,6 +38,7 @@
 #include "qom/object.h"
 #include "exec/tswap.h"
 #include "target/arm/cpu-qom.h"
+#include "qapi/visitor.h"
 
 #define TYPE_ZYNQ_MACHINE MACHINE_TYPE_NAME("xilinx-zynq-a9")
 OBJECT_DECLARE_SIMPLE_TYPE(ZynqMachineState, ZYNQ_MACHINE)
@@ -90,6 +91,7 @@ struct ZynqMachineState {
     MachineState parent;
     Clock *ps_clk;
     ARMCPU *cpu[ZYNQ_MAX_CPUS];
+    uint8_t boot_mode;
 };
 
 static void zynq_write_board_setup(ARMCPU *cpu,
@@ -176,6 +178,27 @@ static inline int zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
     return unit;
 }
 
+static void zynq_set_boot_mode(Object *obj, const char *str,
+                                               Error **errp)
+{
+    ZynqMachineState *m = ZYNQ_MACHINE(obj);
+    uint8_t mode = 0;
+
+    if (!strncasecmp(str, "qspi", 4)) {
+        mode = 1;
+    } else if (!strncasecmp(str, "sd", 2)) {
+        mode = 5;
+    } else if (!strncasecmp(str, "nor", 3)) {
+        mode = 2;
+    } else if (!strncasecmp(str, "jtag", 4)) {
+        mode = 0;
+    } else {
+        error_setg(errp, "%s boot mode not supported", str);
+        return;
+    }
+    m->boot_mode = mode;
+}
+
 static void zynq_init(MachineState *machine)
 {
     ZynqMachineState *zynq_machine = ZYNQ_MACHINE(machine);
@@ -241,6 +264,7 @@ static void zynq_init(MachineState *machine)
     /* Create slcr, keep a pointer to connect clocks */
     slcr = qdev_new("xilinx-zynq_slcr");
     qdev_connect_clock_in(slcr, "ps_clk", zynq_machine->ps_clk);
+    qdev_prop_set_uint8(slcr, "boot-mode", zynq_machine->boot_mode);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(slcr), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
 
@@ -373,6 +397,7 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
         NULL
     };
     MachineClass *mc = MACHINE_CLASS(oc);
+    ObjectProperty *prop;
     mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
     mc->init = zynq_init;
     mc->max_cpus = ZYNQ_MAX_CPUS;
@@ -380,6 +405,12 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
     mc->ignore_memory_transaction_failures = true;
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "zynq.ext_ram";
+    prop = object_class_property_add_str(oc, "boot-mode", NULL,
+                                         zynq_set_boot_mode);
+    object_class_property_set_description(oc, "boot-mode",
+                                          "Supported boot modes:"
+                                          " jtag qspi sd nor");
+    object_property_set_default_str(prop, "qspi");
 }
 
 static const TypeInfo zynq_machine_type = {
-- 
2.34.1


