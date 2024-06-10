Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100E6C27C5F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYRA-0000bp-Hn; Mon, 10 Jun 2024 02:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYR8-0000I7-Oe
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:23:22 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYR6-0004iX-EU
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:23:22 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-35f1a7386d5so1022377f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000598; x=1718605398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jTFNp75u/pYhIEl6kZFuCvdor3PDAS+uCnAKSx/B1Hc=;
 b=ZPfDM5hRm2u+SIPJapOsFbLVybOqWeXxOzwqk5cz99toE7JeBAF1PQ7AWFFCH+X80B
 mr8/I6OgcUF0VilzkRaXj9QQsI4W1ou3NDc/hNU1n75ehGHNILlsLQjy+vWJuggZYa7+
 L0tePqiEzkIaMOzX7owwm+MHVb+jbtM0sTutlC8WBIU77917gfVuYHH4wklJv1GHAYrR
 hmKFl8D7qRiOuHfQYhPvIy/53QMLmdYUq8FPmCgzU6irhxS3WqGfGVIR1jTpILJ50eTG
 HganRqWuMZgXqQbvE21tY1VMecZoRbDKiFHBtrwlbWBdu6huP10U+2ezjkSEvB/l0cnL
 CfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000598; x=1718605398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jTFNp75u/pYhIEl6kZFuCvdor3PDAS+uCnAKSx/B1Hc=;
 b=Xvu8TccQmZcskAPDAXKUdlT79Q1bejzXKPZ/4m9VIyTgknfcuvZQiqDyrn1/dA0Xay
 sUs7ap5X6ToqvK4LaAJ6KvKNpbiEVRDuMHk9cwsLOXmAaV3yixOf5dLVDPu9JGSBeCxz
 uzItVAOPq01yqPhJz98APICKJ/6sQl8y2MgJFdLQE3lh+I/JGVN1iCN2TKBb69PJfyaC
 IxtFi0ZccANbJBtFX5us02yjAPmdhEWFF+GWcF7K4vMRorPoe0ON4CyXvAgtRG3RMcIi
 n32uSJM1dBT9cb1+QpFxPkWCerDCPvm5bPALRuldp7CMP/3+SlJxRkOX/EOgq1/sFvnx
 d9Nw==
X-Gm-Message-State: AOJu0Yy2lD7kHMAtgNp6pyQvmcDRvf8I1k4pnkqSB2xSEzn1zdW3c6a0
 MHBdtJ1OEZcuCqTAzTMY8ou2Nx66Qk8KtPmPF+9LLzI5r0WmiRJfrD32KAXJ/vB2sIoyJ/lEGk8
 o
X-Google-Smtp-Source: AGHT+IHXQWSUUv5/Ocvx+KuF6OEZYbUesNp/A7N7qv2V0d+wAN7h9Xhg9qru1zBzFN4TGnwytx34qQ==
X-Received: by 2002:a05:6000:18a2:b0:35f:1bcd:8e53 with SMTP id
 ffacd0b85a97d-35f1bcd8ec6mr3241468f8f.55.1718000598595; 
 Sun, 09 Jun 2024 23:23:18 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d2da31sm10071613f8f.14.2024.06.09.23.23.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:23:18 -0700 (PDT)
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
Subject: [PATCH 23/26] hw/ppc: Avoid using Monitor in
 SpaprInterruptControllerClass::print_info()
Date: Mon, 10 Jun 2024 08:21:01 +0200
Message-ID: <20240610062105.49848-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
References: <20240610062105.49848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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


