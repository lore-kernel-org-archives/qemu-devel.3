Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B49CC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbKo-0006Fk-Cz; Tue, 18 Jun 2024 12:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbKm-000671-A7
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:05:24 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbKk-0007c6-G1
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:05:24 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4217990f8baso50180835e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726720; x=1719331520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QAchbjd4STB4wMqJvx/3nQ2+YymWCSUHWaZzeEkCQ5E=;
 b=cPRB3OCxlusfI2SWZ/lhTcTMaq3DrB0+D6cp65VxoirsM7fWALmj3miAuB5Hovn/HM
 q0nMBBEpClrVpWzE4d4wp12M5aAtVvcMy/fTWU/0iuK5DActklRBwhcs8EUr8iP19xk1
 DH7ah5Q12WXzMZ1aA3w5xtmfd3M+4agN9itTXYTpryNpM5/eduSbbhuQqoNQfTefap3H
 eCYmPn882HHjXRmR2HhQsItyC4217jBPiqmX4NJEvqITJxG7mVZrvB5fZq704jFqFaoE
 CT14wl/Hm4vteX70cZN9C6bsZ2B3vrdWA05CuhjIBvKp5kFXvjYPGsp44xUCJbEs86PH
 9P/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726720; x=1719331520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QAchbjd4STB4wMqJvx/3nQ2+YymWCSUHWaZzeEkCQ5E=;
 b=KY25wIEGGtgyNx9f7gWxC4q8CD/X6avVbCZZzlJbC5+/v0OZWeUaPxK0L6O4O2Ce/Y
 3hqLMIcWrFxjWeDnEaPID5Lpw01RXJPIh/qkCZSg7zJhonoN6VZoh1HHdhduA4wYmtB/
 NEHIJYmszkx/uhzacNrwtsAS70CyikCLyq4ldzBhaBgAPz5W955Ah/pXWHVuqnJrxp+L
 a62pMwY19c0DlYaGYs1xzsHQRMbGun4SvkhjZrtj2fglh34+CWE8MtYt4XYm4kkIhqpF
 9pDloDmQorLBajX94DUnbLHt3IlMZM63teQbt3T3ljPbgllAxCylUA1CJZ6Fy6F+jCwU
 yKOw==
X-Gm-Message-State: AOJu0YxmWb0E0X58t5LBZC/lR/mZwWT22y+rCqDGSZ8ycPSN3loHSete
 ZlePVDidUkbXa7d1SoMSLeGUSqzRVpzVJ9uIrOwiOLgdJZoPrA1i9w8mzmDobF6ha10EhfEemE3
 K
X-Google-Smtp-Source: AGHT+IHTgU1Krxh/blnSnCPVwFoRQTl9f7ag3Rpuo53zHLetXqxSBFbR3YROt/SykzJ9UYxDyS4j2A==
X-Received: by 2002:a7b:cc84:0:b0:422:5953:343b with SMTP id
 5b1f17b1804b1-42304858452mr95492735e9.34.1718726720638; 
 Tue, 18 Jun 2024 09:05:20 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-423b7a61501sm113840875e9.46.2024.06.18.09.05.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:05:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 48/76] hw/ppc: Avoid using Monitor in spapr_irq_print_info()
Date: Tue, 18 Jun 2024 18:00:10 +0200
Message-ID: <20240618160039.36108-49-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-Id: <20240610062105.49848-25-philmd@linaro.org>
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
index d7d4b188ee..a22decb643 100644
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


