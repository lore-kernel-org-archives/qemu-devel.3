Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946DFC27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYRG-0001SH-5f; Mon, 10 Jun 2024 02:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYRE-0001Iu-LC
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:23:28 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYRC-0004jY-Cy
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:23:28 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52c6f381434so2311493e87.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000604; x=1718605404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCDgKLBaeeDvn2QqbIauKDYEeh4Bef/zoBzza2n2iFc=;
 b=C8tPthBnRiLirn5ZC4CF08Rs63uO5ltvd+Dh5jFoLz7kL1j/YCToXbZOLN1IMzxBlN
 eRyHcTCykKTLUvKXXJwUpeYkomQ6rqj36crqg0VYWeVd1DZilq7khsxFXvAAO/EQIgl8
 z4j77fqNNzxWvGv/VYzME7FuYTFWCC049HtaybGeCkzgNhZ7iDA1ZnBuroYARGmcBpS7
 8y+t9kQvJw1VJu67ZEq2T3Jj1Q+pM2EEnvk5WKtYUpp6j4RH6blnsSoIsi8gucoyItT1
 Bis8T+qOiFNeyQ+jNei9N4rC7mckpgzuSLbpdjOpsBE0N93GYoZOUg8XQaUwhrGaNYCp
 4eUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000604; x=1718605404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UCDgKLBaeeDvn2QqbIauKDYEeh4Bef/zoBzza2n2iFc=;
 b=uUwW7wAKQSY/6gGU8ZQ5EY+H8Vkosv1HnUp9JQvKtdgk7PV+KaBCAjUkaw+Ia5vcHv
 rX46n/ALwV7tNqNISHBAUqrr84PXdAkbsYV8j8Y7O6yLYpA0A87m0vv+26dUSPGjvNbU
 ll4ifVXPIC9gYY6vr2hxEfTriCSJIYRejJPoZGtyyzk2syFAhzlWfCP2uhj25vi6ew8H
 wZOG97MRRjUqwlzmMM1e822hI9DKFnc/Foijev91I1yQ6CQ99mt7/RXHGst0e5hCcb/3
 tEUrdqAcLPOvkxTUHVqzDf2XbDPjjQLfztkshRYjgBOrWrCLFne051zF79pLeiBcGk9Q
 B2Tw==
X-Gm-Message-State: AOJu0YzBQ2rIf5Fxxq9tpK5WQ/FrHFOA17bBKOp67PsNYp2Kp58K+Cv0
 +1clpoLEUl03VjOlcFV5VLu40J8Sv/oOMfR6vSPXwPV+X3dxjpfMfPU5o1srMooMAS+aP0Rc9/7
 f
X-Google-Smtp-Source: AGHT+IFZYOdPk2s41eJ44i4k91hhXV+iMO7bqcrzGyfooTGWbKYjI2cMVFU3AKOh/V7IWUan99oUmA==
X-Received: by 2002:a05:6512:1285:b0:51b:1e76:4ea9 with SMTP id
 2adb3069b0e04-52bb9f663f0mr8935766e87.4.1718000604159; 
 Sun, 09 Jun 2024 23:23:24 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f1ed08253sm3424416f8f.24.2024.06.09.23.23.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:23:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 24/26] hw/ppc: Avoid using Monitor in spapr_irq_print_info()
Date: Mon, 10 Jun 2024 08:21:02 +0200
Message-ID: <20240610062105.49848-25-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
References: <20240610062105.49848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Replace Monitor API by HumanReadableText one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr_irq.h |  2 +-
 hw/ppc/spapr.c             | 11 ++++++++---
 hw/ppc/spapr_irq.c         |  8 +-------
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 6e50470cff..cb9a85f657 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -85,7 +85,7 @@ int spapr_irq_cpu_intc_create(struct SpaprMachineState *spapr,
                               PowerPCCPU *cpu, Error **errp);
 void spapr_irq_cpu_intc_reset(struct SpaprMachineState *spapr, PowerPCCPU *cpu);
 void spapr_irq_cpu_intc_destroy(struct SpaprMachineState *spapr, PowerPCCPU *cpu);
-void spapr_irq_print_info(struct SpaprMachineState *spapr, Monitor *mon);
+void spapr_irq_print_info(struct SpaprMachineState *spapr, GString *buf);
 void spapr_irq_dt(struct SpaprMachineState *spapr, uint32_t nr_servers,
                   void *fdt, uint32_t phandle);
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 81a187f126..cd9b811ac6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -31,6 +31,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-events-machine.h"
 #include "qapi/qapi-events-qdev.h"
+#include "qapi/type-helpers.h"
 #include "qapi/visitor.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/hostmem.h"
@@ -4530,10 +4531,14 @@ static void spapr_pic_print_info(InterruptStatsProvider *obj,
                                  Monitor *mon)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
 
-    spapr_irq_print_info(spapr, mon);
-    monitor_printf(mon, "irqchip: %s\n",
-                   kvm_irqchip_in_kernel() ? "in-kernel" : "emulated");
+    spapr_irq_print_info(spapr, buf);
+    g_string_append_printf(buf, "irqchip: %s\n",
+                           kvm_irqchip_in_kernel() ? "in-kernel" : "emulated");
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 }
 
 /*
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index b43917e7fe..aebd7eaabb 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -11,7 +11,6 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "qapi/type-helpers.h"
 #include "hw/irq.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_cpu_core.h"
@@ -19,7 +18,6 @@
 #include "hw/ppc/xics.h"
 #include "hw/ppc/xics_spapr.h"
 #include "hw/qdev-properties.h"
-#include "monitor/monitor.h"
 #include "cpu-models.h"
 #include "sysemu/kvm.h"
 
@@ -267,16 +265,12 @@ static void spapr_set_irq(void *opaque, int irq, int level)
     sicc->set_irq(spapr->active_intc, irq, level);
 }
 
-void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon)
+void spapr_irq_print_info(SpaprMachineState *spapr, GString *buf)
 {
     SpaprInterruptControllerClass *sicc
         = SPAPR_INTC_GET_CLASS(spapr->active_intc);
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
 
     sicc->print_info(spapr->active_intc, buf);
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 }
 
 void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
-- 
2.41.0


