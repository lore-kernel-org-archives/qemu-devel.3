Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D09C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYPP-0002WN-2J; Mon, 10 Jun 2024 02:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYPJ-0002RF-3H
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:21:29 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYPH-0004KN-0l
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:21:28 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-35f1691b18fso1174373f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000485; x=1718605285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D40FZcL+mJmpN95PJa44NQEo8v0tD6RGQ/QbhHM5uF8=;
 b=TdkI0dEovI4rdlmu66D00MViJvC/hnyE3cyZJJ9mtIBuPQm86tCsuG68koV2M0n9XN
 n8JGgxu61xH4UGvsUGf04Avkygnp1MxQZoLhZOIiFrmdKBxUJvibv0W3XSXUQ94NLz8r
 9f0WK7cGtbviciYqA7UYTGIdXaFh8w5Ag3cHL3kn9WfEN58/zAPtRqkNluQ9GfH3sWVT
 Ilfw/9lOFWM0o9Sf5FxfvGYjmGlPLWChYDfbelbuFfRsknQ8r962Nf3ZxJ5td1R7aqKT
 rNySk0h7voE5GhWMKDgMzym0OaNSpaeXwRxZcxWa9nYUvrNCZ7wEAipQ4dsmtWYU6BLL
 7mzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000485; x=1718605285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D40FZcL+mJmpN95PJa44NQEo8v0tD6RGQ/QbhHM5uF8=;
 b=k3yXchfvcq36krM0qlwgbuo6VlqjUMq7aehV4lI2FlhwVh/oRPS/J6p4MMh6Yu7pUO
 2PJvrvpVc16wGPNijTIOUWkWafyogncFl16nKMtD6E0CLWv+YUTQQ41FSd7rfm0jDcze
 POID2zXz9DhOvdyNJS8vwSwBXa585ll7KI/AjZcaa4VvKh5iAP+uoKqSFfvmftVPCpxR
 UUnCHMkztSePSLgMqmenCnW+LhC+nJUqAFgI+NCFrbPQgxSWYtY6K3LnPNCu0t7Jnu2D
 JRd1/O7TbbwEGTmksltRUI5tqMyJu6+p23MtFSRluwjjcGDNb8ih0Qa904rnodere6eM
 FCeg==
X-Gm-Message-State: AOJu0YwMavEkpkZlntcsThU02YF8qTCrTtaWCJEE/TAUhX6at320KQkI
 xE5vO8vg1jOBSQZXMSP4OeW1nDtBNryCHMldIl/nJzkDRdX2o2rY4oA3ByfpneeXWKycQA1av3a
 T
X-Google-Smtp-Source: AGHT+IG57r7p3mZMbK/FZkUcdXcxB1WrW0ztVnu3YFut4qEHA/BchmkhxNuw/hAFSlaaMXH//L6ZhQ==
X-Received: by 2002:a05:6000:1ccf:b0:35f:16c9:aa9c with SMTP id
 ffacd0b85a97d-35f16c9abf1mr2720023f8f.40.1718000485254; 
 Sun, 09 Jun 2024 23:21:25 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5fc3197sm10185649f8f.101.2024.06.09.23.21.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:21:24 -0700 (PDT)
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
Subject: [PATCH 03/26] hw/ppc: Avoid using Monitor in
 xive_tctx_pic_print_info()
Date: Mon, 10 Jun 2024 08:20:41 +0200
Message-ID: <20240610062105.49848-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
References: <20240610062105.49848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
---
 include/hw/ppc/xive.h |  2 +-
 hw/intc/spapr_xive.c  |  7 ++++++-
 hw/intc/xive.c        | 11 ++++++-----
 hw/ppc/pnv.c          | 16 ++++++++++++++--
 4 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index f120874e0f..bc1cbad8a8 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -528,7 +528,7 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
 uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
                            unsigned size);
 
-void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
+void xive_tctx_pic_print_info(XiveTCTX *tctx, GString *buf);
 Object *xive_tctx_create(Object *cpu, XivePresenter *xptr, Error **errp);
 void xive_tctx_reset(XiveTCTX *tctx);
 void xive_tctx_destroy(XiveTCTX *tctx);
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index d7e56bfb20..b7c12aa432 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -11,6 +11,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "qapi/type-helpers.h"
 #include "qemu/error-report.h"
 #include "target/ppc/cpu.h"
 #include "sysemu/cpus.h"
@@ -703,12 +704,16 @@ static void spapr_xive_print_info(SpaprInterruptController *intc, Monitor *mon)
 {
     SpaprXive *xive = SPAPR_XIVE(intc);
     CPUState *cs;
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
 
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
 
-        xive_tctx_pic_print_info(spapr_cpu_state(cpu)->tctx, mon);
+        xive_tctx_pic_print_info(spapr_cpu_state(cpu)->tctx, buf);
     }
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 
     spapr_xive_pic_print_info(xive, mon);
 }
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 057b308ae9..a0d7e7ca67 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -669,7 +669,7 @@ static const char * const xive_tctx_ring_names[] = {
          xpc->in_kernel ? xpc->in_kernel(xptr) : false;                 \
      }))
 
-void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon)
+void xive_tctx_pic_print_info(XiveTCTX *tctx, GString *buf)
 {
     int cpu_index;
     int i;
@@ -693,13 +693,14 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon)
         }
     }
 
-    monitor_printf(mon, "CPU[%04x]:   QW   NSR CPPR IPB LSMFB ACK# INC AGE PIPR"
-                   "  W2\n", cpu_index);
+    g_string_append_printf(buf, "CPU[%04x]:   "
+                           "QW   NSR CPPR IPB LSMFB ACK# INC AGE PIPR  W2\n",
+                           cpu_index);
 
     for (i = 0; i < XIVE_TM_RING_COUNT; i++) {
         char *s = xive_tctx_ring_print(&tctx->regs[i * XIVE_TM_RING_SIZE]);
-        monitor_printf(mon, "CPU[%04x]: %4s    %s\n", cpu_index,
-                       xive_tctx_ring_names[i], s);
+        g_string_append_printf(buf, "CPU[%04x]: %4s    %s\n",
+                               cpu_index, xive_tctx_ring_names[i], s);
         g_free(s);
     }
 }
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index fa23b27a2b..5854358f65 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1223,7 +1223,13 @@ static void pnv_chip_power9_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
 static void pnv_chip_power9_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
                                             Monitor *mon)
 {
-    xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), mon);
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
+
+    xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), buf);
+
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 }
 
 static void pnv_chip_power10_intc_create(PnvChip *chip, PowerPCCPU *cpu,
@@ -1267,7 +1273,13 @@ static void pnv_chip_power10_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
 static void pnv_chip_power10_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
                                              Monitor *mon)
 {
-    xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), mon);
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
+
+    xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), buf);
+
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 }
 
 /*
-- 
2.41.0


