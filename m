Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18AEC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbIu-0007fS-Fp; Tue, 18 Jun 2024 12:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbIs-0007cG-Eg
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:03:26 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbIq-00079l-BK
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:03:26 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52bc27cfb14so6967458e87.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726601; x=1719331401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0D0UVQQFPvgGs+AWFdh2z7yAuwNg5N51LbDWqW4G400=;
 b=Th2OKuC/CoPBIBcrh8LcVxvv/fH7dXSyWjdcMl192DKu1cQnxccBPtiK7+wfKlWzUD
 xiU5U/xiZ4R0ce4BAL8/GojX10QxWhidf9XNifRf+nqz2KhFYQtNVSrHGWFUsFZ429UE
 Nl/rpQaKU08iBxfeoZBx/qxe6AaISu4AIRZghxH96l57jnRanNQRyZp4YPGCCivygehN
 FCqlq/nuWRppKqwtA1M77big6i9KL5M5vYUMFpTWti0bMXQs0ZODL3JDHEUBZNUSC0dg
 XpaPggiRTvVa+M1AQxmsO1wWInZU6iZmSANbWH2HVEiGF6J3vWxBi7lqqa2yCo91c6oe
 eeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726601; x=1719331401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0D0UVQQFPvgGs+AWFdh2z7yAuwNg5N51LbDWqW4G400=;
 b=o8ruIExiCXMvjTs2Wcqs5JFxRGTjUUBDOTuKEbdDckhyJBJRVpHQwu9ghdC5gVXmOc
 vUXPK0CNDeVoJ/EuDL4U9RWp2LynvMgnoShzqIZ1y/8nocZR3k3CkSfkTiqji6weg1zb
 Q7J94srCD7BNVStyd62UTOy30nOiM5hG9LSCSj+rhlhtA6q9xNQTaSQo9DASVZJeU17y
 Xt1/dMkXN7DIh9akjoqLx2/6tp2la4fW2LduyKzP7qHGhz4aAfz6c5MW1nbJ+tJ/p0VH
 AYcwi81JWJyq92qqoXefPTHIxkcgZ1eSjMQEz1Ex8KUruuiJngs5PV5LUqZ/ZqKEIpFK
 tGfA==
X-Gm-Message-State: AOJu0Ywed6T9EkjFpCEJ83az4THErRCFapDevMXaihm8z35BHHtBkmIp
 KRTStwHfyxlHDwC0AvwHu30iZABxNxdROJOBQvSATSP7L85KoRRW7x0Ogk9vGDGw9WeNdYqthNM
 h
X-Google-Smtp-Source: AGHT+IGh+6zAvVKqVqqbTDKLOxPstPbifmFJ1P3QkVtWj476EYQM2mCrkpWl42HP1ag2l+BVZJPL/Q==
X-Received: by 2002:ac2:43b5:0:b0:52c:8811:42f7 with SMTP id
 2adb3069b0e04-52ccaa32a00mr64711e87.19.1718726600866; 
 Tue, 18 Jun 2024 09:03:20 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56dd3109sm633044166b.95.2024.06.18.09.03.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:03:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 27/76] hw/ppc: Avoid using Monitor in xive_tctx_pic_print_info()
Date: Tue, 18 Jun 2024 17:59:49 +0200
Message-ID: <20240618160039.36108-28-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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
Message-Id: <20240610062105.49848-4-philmd@linaro.org>
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


