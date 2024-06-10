Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A28C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYPs-0002z2-Ga; Mon, 10 Jun 2024 02:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYPr-0002y1-5P
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:22:03 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYPp-0004Qh-7j
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:22:02 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4217c7eb6b4so9999685e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000519; x=1718605319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z6td0QzB0OX12yCkGcEdYwy+GAJGeNI6h457pOg9Qi4=;
 b=U9u/GWoGxRyaT0DBJP9zcFG73m4fj3nCxS874/iHrQ7EeaoEx8f9WTrpjwEXTKuDRH
 rcqoJdxejovezMdsPsEaVKb2QHcNk6/OdxXXmfhogMfR84P3lI+wCxg9MASehLVULa0z
 CKRI53qQUMfOlffXZQZWNEFcYRHbgixp1xzXrO8B1klB8aZl/SA3cvPWqnyiZKUa1JAn
 NFg9Tgj6iW6ZG/YcM+s6djPZRrYBk7B15jk0izhuPKtK2BedQX8SV6cw4DIdoHk6Hoeu
 +9GLGUMu7XTAp/67UPhrVNljpExHkhlOsNgCsA4Z8RIUfknfMOYpouf0NkTFo3OxQQSq
 nNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000519; x=1718605319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z6td0QzB0OX12yCkGcEdYwy+GAJGeNI6h457pOg9Qi4=;
 b=rfWfIJyV6gtlSf/PqthRyAIwl42djo2ZLAHYhuQVhGdBLA9tiKEsYOTrw0Fe6bxE2/
 Fg5PQj2clY7dB5gqaa4iSMrEbnL3hQhjcgPNa8RQwQbC7FSQmz/3o1e2Iied3/7jTkdp
 yxdjvXcfFu6kYiCJQlApdRYS2keNdfc54H/pKuBCX7v+Nyj52X299WABfFKrhIzOFxFX
 zNirdQr5/ox58gL2jYD0qAZ6sjE39F+xpOOoRdX8o6ntLa30ZYrWDca4yMu6RgilJiEW
 BRf04X2lz89tTnp7tr7SnLNoceDjGc0m6St4PrzPS0oP8xzxy+2oEeO6FH01leHug7tb
 rBmw==
X-Gm-Message-State: AOJu0YxnA2GfCXIeH4chtEjDTkX3F/gI/ERuHhzQi9Q2jNObw2Hu/z5A
 GHdM4IVDtvIcwlAvLrXgndv/1n2NXlu2IoopRGOqFj4nHmuWFF92fi6nG11FuKnTW8T0iKxM7KJ
 E
X-Google-Smtp-Source: AGHT+IFdo63W5O8H761jFoBRAGo7VHA4KdVs0uWqjnyH+j/F8H3M6xVG7d0AFLg/IduAVCFRqMalEg==
X-Received: by 2002:a05:600c:1e0d:b0:418:f5a9:b91c with SMTP id
 5b1f17b1804b1-42164a32c03mr70524075e9.33.1718000519447; 
 Sun, 09 Jun 2024 23:21:59 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421727aac08sm89259285e9.43.2024.06.09.23.21.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:21:59 -0700 (PDT)
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
Subject: [PATCH 09/26] hw/ppc: Avoid using Monitor in
 xive_source_pic_print_info()
Date: Mon, 10 Jun 2024 08:20:47 +0200
Message-ID: <20240610062105.49848-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
References: <20240610062105.49848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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


