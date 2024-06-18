Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D68C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbJQ-0001nb-42; Tue, 18 Jun 2024 12:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbJP-0001fL-3n
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:03:59 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbJM-0007Dc-U1
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:03:58 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a63359aaaa6so866090366b.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726635; x=1719331435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=089XdY79KgdMF0Itsg2m4WYzfo4qdafqkNkAig9zmdA=;
 b=sG3MdXkhH4/SU2EYspfzuNVSx4HK3kKSM5fpEj/xwjLG8MNTZnhG/g5pA7SxITFzQL
 wOumYxxMRRXtGaWc8SBba+nw2yNYL4BDE586wKNCSN6YenC4OTSgzM5jNNAASXh4zSCt
 dsRZEr/HrrE3sdUDNPdkIPx9fKR8Rr96+kpFL/4WzawXj0Yi4A5UdeALIy+gV6F8/noT
 jhVEskLUamQq5u5bUr/eWBnNgx23SGsi0CvTae/LgLJTnqqqI8k/rZ3O3OZJ7TPcKuHI
 Vd6jKzmUy/q7H3n8k0Eaujw0+ZuYU0OCzzCJaxF5vQs6ZjuAWTLmkL1A5tIs4UuNTo5S
 ozgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726635; x=1719331435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=089XdY79KgdMF0Itsg2m4WYzfo4qdafqkNkAig9zmdA=;
 b=WsObFkX6Yq3bmXOPwhcxLO8iMox8nMO1pfwsPObYsRJ4ZqMisHa1YCOUOGCGY4ZgWe
 VXWyzo86M/FEeQIHnXyiwlc4I7fLlFedNzKfYF6+E/kryNGM5MSAdQ3aBjPChJrnUIQa
 TrHrGeH46uZtkiWT2tjiRxUoRS/LNOJqCs4lOb4NTqjp0rhI2IZ2B0DW7X+pIFYrMvwh
 SHJDV5jctBallTNnHkIaDQ/2XdEcCskG1GYKHd2dOfT74ZNleKaenrZ61IcMC+6Engw1
 UdV4VpqJ0V6gmNQzKzVZ79MsAwReiBwlxnROi9wJhmVe8jMT1RW1uW8qDt7hYqBxbVwz
 jvWw==
X-Gm-Message-State: AOJu0YyflrHsttVNeOFNnFz9gIDP3B3r3hCe3htR0Ns9fzdCajCnqm3j
 Yqa3npCp19D4B+tHBQ9P9BhojD4rdYETsr1JVAP88wQ8ShIY2K1DnFzbDtT0VeljPm1HwIZg8oF
 D
X-Google-Smtp-Source: AGHT+IEoqWHAwBTF3RsaXQlbgNQnrwdaPnxNo+dyBYh7xxuQNp6aT2x3fwMTHmNb/+0irhcCKKqnaQ==
X-Received: by 2002:a17:906:258b:b0:a6f:6014:6ccf with SMTP id
 a640c23a62f3a-a6f60cf401bmr698840766b.16.1718726634856; 
 Tue, 18 Jun 2024 09:03:54 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ed3690sm631055266b.128.2024.06.18.09.03.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:03:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 33/76] hw/ppc: Avoid using Monitor in
 xive_source_pic_print_info()
Date: Tue, 18 Jun 2024 17:59:55 +0200
Message-ID: <20240618160039.36108-34-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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
Message-Id: <20240610062105.49848-10-philmd@linaro.org>
---
 include/hw/ppc/xive.h  |  2 +-
 hw/intc/pnv_xive.c     | 11 ++++++++---
 hw/intc/pnv_xive2.c    |  8 +++++++-
 hw/intc/xive.c         | 16 +++++++---------
 hw/pci-host/pnv_phb4.c | 20 ++++++++++++++------
 hw/ppc/pnv_psi.c       | 12 +++++++++---
 6 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index bc1cbad8a8..28c181faa2 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -314,7 +314,7 @@ static inline bool xive_source_is_asserted(XiveSource *xsrc, uint32_t srcno)
 }
 
 void xive_source_pic_print_info(XiveSource *xsrc, uint32_t offset,
-                                Monitor *mon);
+                                GString *buf);
 
 static inline bool xive_source_irq_is_lsi(XiveSource *xsrc, uint32_t srcno)
 {
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index da10deceb8..520d7e0acd 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -11,6 +11,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "qapi/type-helpers.h"
 #include "target/ppc/cpu.h"
 #include "sysemu/cpus.h"
 #include "sysemu/dma.h"
@@ -1857,10 +1858,14 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon)
     XiveNVT nvt;
     int i;
     uint64_t xive_nvt_per_subpage;
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
 
-    monitor_printf(mon, "XIVE[%x] #%d Source %08x .. %08x\n", chip_id, blk,
-                   srcno0, srcno0 + nr_ipis - 1);
-    xive_source_pic_print_info(&xive->ipi_source, srcno0, mon);
+    g_string_append_printf(buf, "XIVE[%x] #%d Source %08x .. %08x\n",
+                           chip_id, blk, srcno0, srcno0 + nr_ipis - 1);
+    xive_source_pic_print_info(&xive->ipi_source, srcno0, buf);
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 
     monitor_printf(mon, "XIVE[%x] #%d EAT %08x .. %08x\n", chip_id, blk,
                    srcno0, srcno0 + nr_ipis - 1);
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 4b8d0a5d81..83e0f6b09f 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
+#include "qapi/type-helpers.h"
 #include "target/ppc/cpu.h"
 #include "sysemu/cpus.h"
 #include "sysemu/dma.h"
@@ -2116,10 +2117,15 @@ void pnv_xive2_pic_print_info(PnvXive2 *xive, Monitor *mon)
     Xive2Nvp nvp;
     int i;
     uint64_t xive_nvp_per_subpage;
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
 
     monitor_printf(mon, "XIVE[%x] Source %08x .. %08x\n", blk, srcno0,
                    srcno0 + nr_esbs - 1);
-    xive_source_pic_print_info(&xive->ipi_source, srcno0, mon);
+    xive_source_pic_print_info(&xive->ipi_source, srcno0, buf);
+
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 
     monitor_printf(mon, "XIVE[%x] EAT %08x .. %08x\n", blk, srcno0,
                    srcno0 + nr_esbs - 1);
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 260a94e2ca..1adb0439c5 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1209,22 +1209,20 @@ void xive_source_set_irq(void *opaque, int srcno, int val)
     }
 }
 
-void xive_source_pic_print_info(XiveSource *xsrc, uint32_t offset, Monitor *mon)
+void xive_source_pic_print_info(XiveSource *xsrc, uint32_t offset, GString *buf)
 {
-    int i;
-
-    for (i = 0; i < xsrc->nr_irqs; i++) {
+    for (unsigned i = 0; i < xsrc->nr_irqs; i++) {
         uint8_t pq = xive_source_esb_get(xsrc, i);
 
         if (pq == XIVE_ESB_OFF) {
             continue;
         }
 
-        monitor_printf(mon, "  %08x %s %c%c%c\n", i + offset,
-                       xive_source_irq_is_lsi(xsrc, i) ? "LSI" : "MSI",
-                       pq & XIVE_ESB_VAL_P ? 'P' : '-',
-                       pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
-                       xive_source_is_asserted(xsrc, i) ? 'A' : ' ');
+        g_string_append_printf(buf, "  %08x %s %c%c%c\n", i + offset,
+                               xive_source_irq_is_lsi(xsrc, i) ? "LSI" : "MSI",
+                               pq & XIVE_ESB_VAL_P ? 'P' : '-',
+                               pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
+                               xive_source_is_asserted(xsrc, i) ? 'A' : ' ');
     }
 }
 
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 075499d36d..4b453997e7 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -10,6 +10,7 @@
 #include "qemu/log.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
+#include "qapi/type-helpers.h"
 #include "monitor/monitor.h"
 #include "target/ppc/cpu.h"
 #include "hw/pci-host/pnv_phb4_regs.h"
@@ -1807,11 +1808,18 @@ void pnv_phb4_pic_print_info(PnvPHB4 *phb, Monitor *mon)
         phb->regs[PHB_INT_NOTIFY_ADDR >> 3] & ~PHB_INT_NOTIFY_ADDR_64K;
     uint32_t offset = phb->regs[PHB_INT_NOTIFY_INDEX >> 3];
     bool abt = !!(phb->regs[PHB_CTRLR >> 3] & PHB_CTRLR_IRQ_ABT_MODE);
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
 
-    monitor_printf(mon, "PHB4[%x:%x] Source %08x .. %08x %s @%"HWADDR_PRIx"\n",
-                   phb->chip_id, phb->phb_id,
-                   offset, offset + phb->xsrc.nr_irqs - 1,
-                   abt ? "ABT" : "",
-                   notif_port);
-    xive_source_pic_print_info(&phb->xsrc, 0, mon);
+    g_string_append_printf(buf,
+                           "PHB4[%x:%x] Source %08x .. %08x "
+                           "%s @%"HWADDR_PRIx"\n",
+                           phb->chip_id, phb->phb_id,
+                           offset, offset + phb->xsrc.nr_irqs - 1,
+                           abt ? "ABT" : "",
+                           notif_port);
+    xive_source_pic_print_info(&phb->xsrc, 0, buf);
+
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 }
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 26460d210d..922ac07b2f 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -25,6 +25,7 @@
 #include "qemu/module.h"
 #include "sysemu/reset.h"
 #include "qapi/error.h"
+#include "qapi/type-helpers.h"
 #include "monitor/monitor.h"
 
 
@@ -980,11 +981,16 @@ type_init(pnv_psi_register_types);
 void pnv_psi_pic_print_info(Pnv9Psi *psi9, Monitor *mon)
 {
     PnvPsi *psi = PNV_PSI(psi9);
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
 
     uint32_t offset =
         (psi->regs[PSIHB_REG(PSIHB9_IVT_OFFSET)] >> PSIHB9_IVT_OFF_SHIFT);
 
-    monitor_printf(mon, "PSIHB Source %08x .. %08x\n",
-                  offset, offset + psi9->source.nr_irqs - 1);
-    xive_source_pic_print_info(&psi9->source, offset, mon);
+    g_string_append_printf(buf, "PSIHB Source %08x .. %08x\n",
+                           offset, offset + psi9->source.nr_irqs - 1);
+    xive_source_pic_print_info(&psi9->source, offset, buf);
+
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 }
-- 
2.41.0


