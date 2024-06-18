Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB95C2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbKi-000639-E0; Tue, 18 Jun 2024 12:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbKg-0005x1-QG
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:05:18 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbKe-0007ap-Tp
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:05:18 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57c60b13a56so6736618a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726715; x=1719331515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R4W1MGJBRGFUEbFiT0ZVw3zxdKeF/zBKMMBgexrp4K4=;
 b=dgwvBwjetCSPnYvlZh7Loa7PKF1WXsWF/RczlizHZHs7zadLkgwWCB2JyrrBUjnZ6/
 66uw8Ljl2+2KSjdEIAWKBR1KMDAi0oY6BFpJBEXJja6xavBiUFei21s4xMq8BSECjMDD
 teJdcyuYHXm6evy9bmF+oqNI35btZsN4vVXEc4KQ9KBUjKjWrOEbbFQdTmtiKX7R844j
 Q6j0Ol25ZC9KRen5s/Oh+YAu6XOQuTQTGdEpZU8Y9eLsKo8rC/xEEHJvspXGlMRfmC9Z
 ku46iIhbKZMQDkHiBTDKGJgUVziio9ydpm826CTY+Ag5A6JVLoti1c83jYyNGxOswfRq
 uBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726715; x=1719331515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R4W1MGJBRGFUEbFiT0ZVw3zxdKeF/zBKMMBgexrp4K4=;
 b=d49sMSgZ70NnNeuctf7flOsPHFDnev2kh9BaUlo/sNl0pC1XYF5GEayI3Crkf39V8S
 XLchsPeN4L6S2LGmj5EmCZmBGK74ayHTkCzRe7pfS6z4SIkkHHnBRBPcx8CCyVFeKYbi
 tD84UXqQYEsC1HHDKx1gr4o93rFfbCRIyAn4imgvhgUnIc0OjRPvm6X4X5C7UFfISaqz
 pNqIIGkB1l8JTe86wV/M1H4T8f0otScQ7Edr4bzi9w+v2rirxBXu1qApicKaYWjrZG0C
 ZWqL3pAOdzDeiSz5bbKBD1JJOwj9De0mAIQSUJIqzC/E+ceWKuJFVTjLTHwtWCOvx5vS
 JeCA==
X-Gm-Message-State: AOJu0YxaKYqTB6L/M5r8a90r01ej3LR1UxNS50kC34OeQJRg5SiawRjr
 HXhIUf43Jg2ZNcb3hAZSEWZuRSzdAMP/FS3mHnCKKdA9Bt0UPg7gBMp1ncAzDjQdBTS0PAzHQEL
 F
X-Google-Smtp-Source: AGHT+IHEd9rtV1Wroc75wYV/g/7naYIGAFynhl4Bzf3WqMcZQxNgnnH2jrIFjDqxNb6uRCaiiCrBnA==
X-Received: by 2002:a50:d5c2:0:b0:573:555e:6d89 with SMTP id
 4fb4d7f45d1cf-57cbd652436mr8404843a12.1.1718726715115; 
 Tue, 18 Jun 2024 09:05:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb7439606sm7870168a12.90.2024.06.18.09.05.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:05:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 47/76] hw/ppc: Avoid using Monitor in
 SpaprInterruptControllerClass::print_info()
Date: Tue, 18 Jun 2024 18:00:09 +0200
Message-ID: <20240618160039.36108-48-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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
Message-Id: <20240610062105.49848-24-philmd@linaro.org>
---
 include/hw/ppc/spapr_irq.h | 2 +-
 hw/intc/spapr_xive.c       | 9 +--------
 hw/intc/xics_spapr.c       | 9 +--------
 hw/ppc/spapr_irq.c         | 8 +++++++-
 4 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 4fd2d5853d..6e50470cff 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -73,7 +73,7 @@ struct SpaprInterruptControllerClass {
 
     /* These methods should only be called on the active intc */
     void (*set_irq)(SpaprInterruptController *intc, int irq, int val);
-    void (*print_info)(SpaprInterruptController *intc, Monitor *mon);
+    void (*print_info)(SpaprInterruptController *intc, GString *buf);
     void (*dt)(SpaprInterruptController *intc, uint32_t nr_servers,
                void *fdt, uint32_t phandle);
     int (*post_load)(SpaprInterruptController *intc, int version_id);
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 9d0d5948ff..283a6b8fd2 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -11,13 +11,11 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "qapi/type-helpers.h"
 #include "qemu/error-report.h"
 #include "target/ppc/cpu.h"
 #include "sysemu/cpus.h"
 #include "sysemu/reset.h"
 #include "migration/vmstate.h"
-#include "monitor/monitor.h"
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_cpu_core.h"
@@ -701,12 +699,10 @@ static void spapr_xive_set_irq(SpaprInterruptController *intc, int irq, int val)
     }
 }
 
-static void spapr_xive_print_info(SpaprInterruptController *intc, Monitor *mon)
+static void spapr_xive_print_info(SpaprInterruptController *intc, GString *buf)
 {
     SpaprXive *xive = SPAPR_XIVE(intc);
     CPUState *cs;
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
 
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
@@ -714,9 +710,6 @@ static void spapr_xive_print_info(SpaprInterruptController *intc, Monitor *mon)
         xive_tctx_pic_print_info(spapr_cpu_state(cpu)->tctx, buf);
     }
     spapr_xive_pic_print_info(xive, buf);
-
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 }
 
 static void spapr_xive_dt(SpaprInterruptController *intc, uint32_t nr_servers,
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 1926373ebd..a0d97bdefe 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -34,8 +34,6 @@
 #include "hw/ppc/xics_spapr.h"
 #include "hw/ppc/fdt.h"
 #include "qapi/visitor.h"
-#include "qapi/type-helpers.h"
-#include "monitor/monitor.h"
 
 /*
  * Guest interfaces
@@ -397,12 +395,10 @@ static void xics_spapr_set_irq(SpaprInterruptController *intc, int irq, int val)
     ics_set_irq(ics, srcno, val);
 }
 
-static void xics_spapr_print_info(SpaprInterruptController *intc, Monitor *mon)
+static void xics_spapr_print_info(SpaprInterruptController *intc, GString *buf)
 {
     ICSState *ics = ICS_SPAPR(intc);
     CPUState *cs;
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
 
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
@@ -410,9 +406,6 @@ static void xics_spapr_print_info(SpaprInterruptController *intc, Monitor *mon)
         icp_pic_print_info(spapr_cpu_state(cpu)->icp, buf);
     }
     ics_pic_print_info(ics, buf);
-
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 }
 
 static int xics_spapr_post_load(SpaprInterruptController *intc, int version_id)
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 97b2fc42ab..b43917e7fe 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -11,6 +11,7 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/type-helpers.h"
 #include "hw/irq.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_cpu_core.h"
@@ -18,6 +19,7 @@
 #include "hw/ppc/xics.h"
 #include "hw/ppc/xics_spapr.h"
 #include "hw/qdev-properties.h"
+#include "monitor/monitor.h"
 #include "cpu-models.h"
 #include "sysemu/kvm.h"
 
@@ -269,8 +271,12 @@ void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon)
 {
     SpaprInterruptControllerClass *sicc
         = SPAPR_INTC_GET_CLASS(spapr->active_intc);
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
 
-    sicc->print_info(spapr->active_intc, mon);
+    sicc->print_info(spapr->active_intc, buf);
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 }
 
 void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
-- 
2.41.0


