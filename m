Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4334C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYcv-0006Iv-A3; Mon, 10 Jun 2024 02:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYcu-0006IQ-0u
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:35:32 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYcr-0007M6-QQ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:35:31 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-35f0aeff7a8so1841512f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718001328; x=1718606128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WSHT2oKRIgkAwXEwFKRYVcc2pOp65D9y1DNTV96pudc=;
 b=XMaFveqGeqXetDVew2/wuO98R6Qs7SeRkoFK1QdgG37iWLJMqSFRSCP9zk5eRkfkAP
 9aJ103ti31xu26nZgCM1vptZq/FxR3LUV6XDy6cj7VqDPZBemosOOZa5Ps2mrtgeZs3m
 q+3LX2joXpCIl6+shyWCuMsygwtl6Dg+8na+orPIDfSI9sE8y5AOcJN4mgxlYJs9F4Eq
 x+V3tCyFVSC3hGJ54T6zc+fjU3mBqeIgWXgW2/5kMK4ysCyzH2f+ZbaOx1Wjiq+M6Hk6
 pIyotZQVEsslaIC6Av+LsSHioxmi3EmJ3SHPbFVZUbf08jyUqnU0Xbu1Sfqhe6nGWLse
 VNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718001328; x=1718606128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WSHT2oKRIgkAwXEwFKRYVcc2pOp65D9y1DNTV96pudc=;
 b=SUBclX/hwKYomsMUE1FEFaJ0tS+Go9wjAy9CGCPDKI8+O01iH+gbjsc+MOZBPFRwFO
 JD7ElQFmT+2cYfSta6go20VirW28boRv7FPlTxytkUbhEBAyAbY38cInqKocBaZxBlDI
 BwpePzmk+aTZStwZuTzN/uuoYK8QqMY/8SIM/3rhHOjsB6KybYNEf8A4nsMbqJPuvXmO
 yGOMt6sMxehT8ImjU1iKRhXfo4IV+8ZdaSoII/U2z7KIYn86d6YucuVhGuazf3pWulc5
 DkgN0tn3wxwlRs7CX2YWIdhvWQutzKm7mDiF5LPBCEfLJGGu7GIXdyqN68XLHUgySDQ8
 ByDg==
X-Gm-Message-State: AOJu0YxYxFPrztYmWc9LCy2JTjmaJ0tNwFlYxg0pr/AYDjheL4ABWz9c
 MDX2mh3tG431J4um/RNHJ2j7h1wUWT5hxLSIE1rzm11rsxt8IsTGhg9k4e+1K0b/Pux1rK3Gzyj
 t
X-Google-Smtp-Source: AGHT+IGN/t8xrIEI/mZmvM5rwSVtVhBU+Mfo+Yzio0t1c/TKmVkt3dmpWSShJC98H9EZ5+k9BIQECA==
X-Received: by 2002:a05:6000:4008:b0:354:f7b9:75bd with SMTP id
 ffacd0b85a97d-35efedca5c0mr7717266f8f.47.1718001327916; 
 Sun, 09 Jun 2024 23:35:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f1dc8e2a2sm3708153f8f.106.2024.06.09.23.35.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:35:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Don Porter <porter@cs.unc.edu>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 1/2] hw/intc: Avoid using Monitor in
 INTERRUPT_STATS_PROVIDER::print_info()
Date: Mon, 10 Jun 2024 08:35:16 +0200
Message-ID: <20240610063518.50680-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610063518.50680-1-philmd@linaro.org>
References: <20240610063518.50680-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Replace Monitor API by HumanReadableText one (see commit f2de406f29
"docs/devel: document expectations for QAPI data modelling for QMP"
for rationale).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/intc/intc.h  |  2 +-
 hw/intc/goldfish_pic.c  |  8 +++---
 hw/intc/i8259_common.c  | 14 +++++-----
 hw/intc/ioapic_common.c | 57 +++++++++++++++++++++--------------------
 hw/intc/m68k_irqc.c     |  5 ++--
 hw/intc/slavio_intctl.c | 11 ++++----
 hw/ppc/pnv.c            | 10 +-------
 hw/ppc/spapr.c          | 10 +-------
 monitor/hmp-cmds.c      |  8 +++++-
 9 files changed, 57 insertions(+), 68 deletions(-)

diff --git a/include/hw/intc/intc.h b/include/hw/intc/intc.h
index 7018f608ca..e40194b8e3 100644
--- a/include/hw/intc/intc.h
+++ b/include/hw/intc/intc.h
@@ -22,7 +22,7 @@ struct InterruptStatsProviderClass {
      */
     bool (*get_statistics)(InterruptStatsProvider *obj, uint64_t **irq_counts,
                            unsigned int *nb_irqs);
-    void (*print_info)(InterruptStatsProvider *obj, Monitor *mon);
+    void (*print_info)(InterruptStatsProvider *obj, GString *buf);
 };
 
 #endif
diff --git a/hw/intc/goldfish_pic.c b/hw/intc/goldfish_pic.c
index d662dfeb99..6cc1c69d26 100644
--- a/hw/intc/goldfish_pic.c
+++ b/hw/intc/goldfish_pic.c
@@ -12,7 +12,6 @@
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "monitor/monitor.h"
 #include "qemu/log.h"
 #include "trace.h"
 #include "hw/intc/intc.h"
@@ -39,11 +38,12 @@ static bool goldfish_pic_get_statistics(InterruptStatsProvider *obj,
     return true;
 }
 
-static void goldfish_pic_print_info(InterruptStatsProvider *obj, Monitor *mon)
+static void goldfish_pic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
     GoldfishPICState *s = GOLDFISH_PIC(obj);
-    monitor_printf(mon, "goldfish-pic.%d: pending=0x%08x enabled=0x%08x\n",
-                   s->idx, s->pending, s->enabled);
+    g_string_append_printf(buf,
+                           "goldfish-pic.%d: pending=0x%08x enabled=0x%08x\n",
+                           s->idx, s->pending, s->enabled);
 }
 
 static void goldfish_pic_update(GoldfishPICState *s)
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index ee0041115c..d9558e3940 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -28,7 +28,6 @@
 #include "hw/isa/i8259_internal.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
-#include "monitor/monitor.h"
 #include "qapi/error.h"
 
 static int irq_level[16];
@@ -132,16 +131,17 @@ static bool pic_get_statistics(InterruptStatsProvider *obj,
     return true;
 }
 
-static void pic_print_info(InterruptStatsProvider *obj, Monitor *mon)
+static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
     PICCommonState *s = PIC_COMMON(obj);
 
     pic_dispatch_pre_save(s);
-    monitor_printf(mon, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
-                   "irq_base=%02x rr_sel=%d elcr=%02x fnm=%d\n",
-                   s->master ? 0 : 1, s->irr, s->imr, s->isr, s->priority_add,
-                   s->irq_base, s->read_reg_select, s->elcr,
-                   s->special_fully_nested_mode);
+    g_string_append_printf(buf, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
+                           "irq_base=%02x rr_sel=%d elcr=%02x fnm=%d\n",
+                           s->master ? 0 : 1, s->irr, s->imr, s->isr,
+                           s->priority_add,
+                           s->irq_base, s->read_reg_select, s->elcr,
+                           s->special_fully_nested_mode);
 }
 
 static bool ltim_state_needed(void *opaque)
diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index efbe6958c8..769896353a 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -23,7 +23,6 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "migration/vmstate.h"
-#include "monitor/monitor.h"
 #include "hw/intc/intc.h"
 #include "hw/intc/ioapic.h"
 #include "hw/intc/ioapic_internal.h"
@@ -59,59 +58,62 @@ static bool ioapic_get_statistics(InterruptStatsProvider *obj,
     return true;
 }
 
-static void ioapic_irr_dump(Monitor *mon, const char *name, uint32_t bitmap)
+static void ioapic_irr_dump(GString *buf, const char *name, uint32_t bitmap)
 {
     int i;
 
-    monitor_printf(mon, "%-10s ", name);
+    g_string_append_printf(buf, "%-10s ", name);
     if (bitmap == 0) {
-        monitor_printf(mon, "(none)\n");
+        g_string_append_printf(buf, "(none)\n");
         return;
     }
     for (i = 0; i < IOAPIC_NUM_PINS; i++) {
         if (bitmap & (1 << i)) {
-            monitor_printf(mon, "%-2u ", i);
+            g_string_append_printf(buf, "%-2u ", i);
         }
     }
-    monitor_printf(mon, "\n");
+    g_string_append_c(buf, '\n');
 }
 
-static void ioapic_print_redtbl(Monitor *mon, IOAPICCommonState *s)
+static void ioapic_print_redtbl(GString *buf, IOAPICCommonState *s)
 {
     static const char *delm_str[] = {
         "fixed", "lowest", "SMI", "...", "NMI", "INIT", "...", "extINT"};
     uint32_t remote_irr = 0;
     int i;
 
-    monitor_printf(mon, "ioapic0: ver=0x%x id=0x%02x sel=0x%02x",
-                   s->version, s->id, s->ioregsel);
+    g_string_append_printf(buf, "ioapic0: ver=0x%x id=0x%02x sel=0x%02x",
+                           s->version, s->id, s->ioregsel);
     if (s->ioregsel) {
-        monitor_printf(mon, " (redir[%u])\n",
-                       (s->ioregsel - IOAPIC_REG_REDTBL_BASE) >> 1);
+        g_string_append_printf(buf, " (redir[%u])\n",
+                               (s->ioregsel - IOAPIC_REG_REDTBL_BASE) >> 1);
     } else {
-        monitor_printf(mon, "\n");
+        g_string_append_c(buf, '\n');
     }
     for (i = 0; i < IOAPIC_NUM_PINS; i++) {
         uint64_t entry = s->ioredtbl[i];
         uint32_t delm = (uint32_t)((entry & IOAPIC_LVT_DELIV_MODE) >>
                                    IOAPIC_LVT_DELIV_MODE_SHIFT);
-        monitor_printf(mon, "  pin %-2u 0x%016"PRIx64" dest=%"PRIx64
-                       " vec=%-3"PRIu64" %s %-5s %-6s %-6s %s\n",
-                       i, entry,
-                       (entry >> IOAPIC_LVT_DEST_SHIFT) &
-                            (entry & IOAPIC_LVT_DEST_MODE ? 0xff : 0xf),
-                       entry & IOAPIC_VECTOR_MASK,
-                       entry & IOAPIC_LVT_POLARITY ? "active-lo" : "active-hi",
-                       entry & IOAPIC_LVT_TRIGGER_MODE ? "level" : "edge",
-                       entry & IOAPIC_LVT_MASKED ? "masked" : "",
-                       delm_str[delm],
-                       entry & IOAPIC_LVT_DEST_MODE ? "logical" : "physical");
+        g_string_append_printf(buf, "  pin %-2u 0x%016"PRIx64" dest=%"PRIx64
+                               " vec=%-3"PRIu64" %s %-5s %-6s %-6s %s\n",
+                               i, entry,
+                               (entry >> IOAPIC_LVT_DEST_SHIFT) &
+                                    (entry & IOAPIC_LVT_DEST_MODE ? 0xff : 0xf),
+                               entry & IOAPIC_VECTOR_MASK,
+                               entry & IOAPIC_LVT_POLARITY
+                                    ? "active-lo" : "active-hi",
+                               entry & IOAPIC_LVT_TRIGGER_MODE
+                                    ? "level" : "edge",
+                               entry & IOAPIC_LVT_MASKED ? "masked" : "",
+                               delm_str[delm],
+                               entry & IOAPIC_LVT_DEST_MODE
+                                    ? "logical" : "physical");
 
         remote_irr |= entry & IOAPIC_LVT_TRIGGER_MODE ?
                         (entry & IOAPIC_LVT_REMOTE_IRR ? (1 << i) : 0) : 0;
     }
-    ioapic_irr_dump(mon, "  IRR", s->irr);
-    ioapic_irr_dump(mon, "  Remote IRR", remote_irr);
+    ioapic_irr_dump(buf, "  IRR", s->irr);
+    ioapic_irr_dump(buf, "  Remote IRR", remote_irr);
 }
 
 void ioapic_reset_common(DeviceState *dev)
@@ -171,13 +173,12 @@ static void ioapic_common_realize(DeviceState *dev, Error **errp)
     ioapic_no++;
 }
 
-static void ioapic_print_info(InterruptStatsProvider *obj,
-                              Monitor *mon)
+static void ioapic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
     IOAPICCommonState *s = IOAPIC_COMMON(obj);
 
     ioapic_dispatch_pre_save(s);
-    ioapic_print_redtbl(mon, s);
+    ioapic_print_redtbl(buf, s);
 }
 
 static const VMStateDescription vmstate_ioapic_common = {
diff --git a/hw/intc/m68k_irqc.c b/hw/intc/m68k_irqc.c
index 4b11fb9f72..cf3beefcfe 100644
--- a/hw/intc/m68k_irqc.c
+++ b/hw/intc/m68k_irqc.c
@@ -10,7 +10,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "migration/vmstate.h"
-#include "monitor/monitor.h"
 #include "hw/qdev-properties.h"
 #include "hw/nmi.h"
 #include "hw/intc/intc.h"
@@ -27,10 +26,10 @@ static bool m68k_irqc_get_statistics(InterruptStatsProvider *obj,
     return true;
 }
 
-static void m68k_irqc_print_info(InterruptStatsProvider *obj, Monitor *mon)
+static void m68k_irqc_print_info(InterruptStatsProvider *obj, GString *buf)
 {
     M68KIRQCState *s = M68K_IRQC(obj);
-    monitor_printf(mon, "m68k-irqc: ipr=0x%x\n", s->ipr);
+    g_string_append_printf(buf, "m68k-irqc: ipr=0x%x\n", s->ipr);
 }
 
 static void m68k_set_irq(void *opaque, int irq, int level)
diff --git a/hw/intc/slavio_intctl.c b/hw/intc/slavio_intctl.c
index 36b4a12f60..d6e49d29aa 100644
--- a/hw/intc/slavio_intctl.c
+++ b/hw/intc/slavio_intctl.c
@@ -24,7 +24,6 @@
 
 #include "qemu/osdep.h"
 #include "migration/vmstate.h"
-#include "monitor/monitor.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "hw/intc/intc.h"
@@ -401,17 +400,17 @@ static bool slavio_intctl_get_statistics(InterruptStatsProvider *obj,
 }
 #endif
 
-static void slavio_intctl_print_info(InterruptStatsProvider *obj, Monitor *mon)
+static void slavio_intctl_print_info(InterruptStatsProvider *obj, GString *buf)
 {
     SLAVIO_INTCTLState *s = SLAVIO_INTCTL(obj);
     int i;
 
     for (i = 0; i < MAX_CPUS; i++) {
-        monitor_printf(mon, "per-cpu %d: pending 0x%08x\n", i,
-                       s->slaves[i].intreg_pending);
+        g_string_append_printf(buf, "per-cpu %d: pending 0x%08x\n", i,
+                               s->slaves[i].intreg_pending);
     }
-    monitor_printf(mon, "master: pending 0x%08x, disabled 0x%08x\n",
-                   s->intregm_pending, s->intregm_disabled);
+    g_string_append_printf(buf, "master: pending 0x%08x, disabled 0x%08x\n",
+                           s->intregm_pending, s->intregm_disabled);
 }
 
 static void slavio_intctl_init(Object *obj)
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index df74f032d7..03c595788f 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -38,8 +38,6 @@
 #include "hw/loader.h"
 #include "hw/nmi.h"
 #include "qapi/visitor.h"
-#include "qapi/type-helpers.h"
-#include "monitor/monitor.h"
 #include "hw/intc/intc.h"
 #include "hw/ipmi/ipmi.h"
 #include "target/ppc/mmu-hash64.h"
@@ -2331,14 +2329,11 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int pir)
     return cpu ? ICP(pnv_cpu_state(cpu)->intc) : NULL;
 }
 
-static void pnv_pic_print_info(InterruptStatsProvider *obj,
-                               Monitor *mon)
+static void pnv_pic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
     PnvMachineState *pnv = PNV_MACHINE(obj);
     int i;
     CPUState *cs;
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
 
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
@@ -2351,9 +2346,6 @@ static void pnv_pic_print_info(InterruptStatsProvider *obj,
     for (i = 0; i < pnv->num_chips; i++) {
         PNV_CHIP_GET_CLASS(pnv->chips[i])->pic_print_info(pnv->chips[i], buf);
     }
-
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 }
 
 static int pnv_match_nvt(XiveFabric *xfb, uint8_t format,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index cd9b811ac6..1f12d6c24b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -31,7 +31,6 @@
 #include "qapi/error.h"
 #include "qapi/qapi-events-machine.h"
 #include "qapi/qapi-events-qdev.h"
-#include "qapi/type-helpers.h"
 #include "qapi/visitor.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/hostmem.h"
@@ -90,8 +89,6 @@
 #include "hw/ppc/spapr_nvdimm.h"
 #include "hw/ppc/spapr_numa.h"
 
-#include "monitor/monitor.h"
-
 #include <libfdt.h>
 
 /* SLOF memory layout:
@@ -4527,18 +4524,13 @@ static ICPState *spapr_icp_get(XICSFabric *xi, int vcpu_id)
     return cpu ? spapr_cpu_state(cpu)->icp : NULL;
 }
 
-static void spapr_pic_print_info(InterruptStatsProvider *obj,
-                                 Monitor *mon)
+static void spapr_pic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
 
     spapr_irq_print_info(spapr, buf);
     g_string_append_printf(buf, "irqchip: %s\n",
                            kvm_irqchip_in_kernel() ? "in-kernel" : "emulated");
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 }
 
 /*
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index ea79148ee8..fbff7fdb57 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -25,6 +25,7 @@
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/type-helpers.h"
 #include "qemu/cutils.h"
 #include "hw/intc/intc.h"
 #include "qemu/log.h"
@@ -92,7 +93,12 @@ static int hmp_info_pic_foreach(Object *obj, void *opaque)
         intc = INTERRUPT_STATS_PROVIDER(obj);
         k = INTERRUPT_STATS_PROVIDER_GET_CLASS(obj);
         if (k->print_info) {
-            k->print_info(intc, mon);
+            g_autoptr(GString) buf = g_string_new("");
+            g_autoptr(HumanReadableText) info = NULL;
+
+            k->print_info(intc, buf);
+            info = human_readable_text_from_str(buf);
+            monitor_puts(mon, info->human_readable_text);
         } else {
             monitor_printf(mon, "Interrupt controller information not available for %s.\n",
                            object_get_typename(obj));
-- 
2.41.0


