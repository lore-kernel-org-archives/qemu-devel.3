Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF00BC2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbIz-0007pQ-30; Tue, 18 Jun 2024 12:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbIw-0007io-Bv
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:03:30 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbIu-0007AD-9f
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:03:29 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a6f0c3d0792so665578566b.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726606; x=1719331406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q64a/UtP53Z3SK6mE3/iQc+gyaav2rASLGADleRJIug=;
 b=Z0wfAqWi6J5HsRJEtBI6KW7EngpTaiW8p9Y3vCaZ9h38tUsLh/Ih8H5QWeUc7iQ6NZ
 /XdNJuIlraP5CiY1bYwZuCrX82WT41aot5wUC6lJlBjfE3bvintJHZs/a5vw+Bvly3Bp
 OGrNO5T6LGNfpgcwD+HWz43HuOPtfhpQhFJ9nryUXhEu4xNjWoIyctej8TAEBfgxJ8I2
 tkrURFLAz98uSh21ANfwha23bv5E7cMb8lFHjn4lccGKeznVDJbw5bBIOlD87WitZyhC
 AApltWYQIUqirtCKjyzEMy6DUqCxFZNP5DsasYT8kzQtOLC5S5VdVwAqYyu22Cbuq7oC
 WIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726606; x=1719331406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q64a/UtP53Z3SK6mE3/iQc+gyaav2rASLGADleRJIug=;
 b=wGVn1OAUja6oAeucHiwkf1sLVfvM/GVcHwPPEH633Yztn1gikLDmZKx5Ck2gVG+bxN
 E4+7ihPgsd4Ka/TWJGeMvbi6h+2F3yZIMEE3zfNHKlAhXN3dcnaO9UpiCaPwMc+QQsWa
 ciNweocCv+KcQMwhGCrR4s30taLedYMJsAFgp/Su5YaItQsf3UJZThbvLidwIBkD3MO/
 XxqSJifdSR3q/FCFnVoHpUbeiUW5KxHbnpI/dBVlLz/6lo0mN8Rxor8NBtxlZOcwdjJY
 u+fVyf5fhlrQbj1v9Pf5uAWaLPG5MXRYiPak+UXaYZvBAhz499Cimn5dEytk6QF0hoOV
 ExnA==
X-Gm-Message-State: AOJu0YxPZMNf97GbuTO6gYxmpxty/m51mvXTDqhyJcV/NDMjsxx7vDTu
 5ylNv102eW+VpmZ4p1hBwh9asE1hINTS3c4NWZ4coQu/jUcAEZETDjs4gfcQqavGSB3YJuZt9oV
 S
X-Google-Smtp-Source: AGHT+IE0n+7QDDE8ct6glW4Kj5auXzIPv5z04Ln5VuKL+7uWQbGqbegtR7AUi9Z+OJoRrvT0YSynhA==
X-Received: by 2002:a17:906:7c9:b0:a68:a800:5f7e with SMTP id
 a640c23a62f3a-a6f60cefe50mr952193366b.10.1718726606530; 
 Tue, 18 Jun 2024 09:03:26 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56da329asm632887466b.37.2024.06.18.09.03.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:03:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 28/76] hw/ppc: Avoid using Monitor in ics_pic_print_info()
Date: Tue, 18 Jun 2024 17:59:50 +0200
Message-ID: <20240618160039.36108-29-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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
Message-Id: <20240610062105.49848-5-philmd@linaro.org>
---
 include/hw/ppc/xics.h |  2 +-
 hw/intc/xics.c        | 17 ++++++++---------
 hw/intc/xics_spapr.c  |  4 ++--
 hw/ppc/pnv.c          | 15 ++++++++-------
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 1116aa6953..e94d53405f 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -172,7 +172,7 @@ static inline bool ics_irq_free(ICSState *ics, uint32_t srcno)
 
 void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
 void icp_pic_print_info(ICPState *icp, GString *buf);
-void ics_pic_print_info(ICSState *ics, Monitor *mon);
+void ics_pic_print_info(ICSState *ics, GString *buf);
 
 void ics_resend(ICSState *ics);
 void icp_resend(ICPState *ss);
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 039e10a0e4..6f4d5271ea 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -35,7 +35,6 @@
 #include "qemu/module.h"
 #include "qapi/visitor.h"
 #include "migration/vmstate.h"
-#include "monitor/monitor.h"
 #include "hw/intc/intc.h"
 #include "hw/irq.h"
 #include "sysemu/kvm.h"
@@ -68,12 +67,12 @@ void icp_pic_print_info(ICPState *icp, GString *buf)
                            icp->pending_priority, icp->mfrr);
 }
 
-void ics_pic_print_info(ICSState *ics, Monitor *mon)
+void ics_pic_print_info(ICSState *ics, GString *buf)
 {
     uint32_t i;
 
-    monitor_printf(mon, "ICS %4x..%4x %p\n",
-                   ics->offset, ics->offset + ics->nr_irqs - 1, ics);
+    g_string_append_printf(buf, "ICS %4x..%4x %p\n",
+                           ics->offset, ics->offset + ics->nr_irqs - 1, ics);
 
     if (!ics->irqs) {
         return;
@@ -89,11 +88,11 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon)
         if (!(irq->flags & XICS_FLAGS_IRQ_MASK)) {
             continue;
         }
-        monitor_printf(mon, "  %4x %s %02x %02x\n",
-                       ics->offset + i,
-                       (irq->flags & XICS_FLAGS_IRQ_LSI) ?
-                       "LSI" : "MSI",
-                       irq->priority, irq->status);
+        g_string_append_printf(buf, "  %4x %s %02x %02x\n",
+                               ics->offset + i,
+                               (irq->flags & XICS_FLAGS_IRQ_LSI) ?
+                               "LSI" : "MSI",
+                               irq->priority, irq->status);
     }
 }
 
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index bab9d88218..1926373ebd 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -409,10 +409,10 @@ static void xics_spapr_print_info(SpaprInterruptController *intc, Monitor *mon)
 
         icp_pic_print_info(spapr_cpu_state(cpu)->icp, buf);
     }
+    ics_pic_print_info(ics, buf);
+
     info = human_readable_text_from_str(buf);
     monitor_puts(mon, info->human_readable_text);
-
-    ics_pic_print_info(ics, mon);
 }
 
 static int xics_spapr_post_load(SpaprInterruptController *intc, int version_id)
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 5854358f65..3eaf674efa 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -770,20 +770,21 @@ static void pnv_chip_power8_pic_print_info(PnvChip *chip, Monitor *mon)
     Pnv8Chip *chip8 = PNV8_CHIP(chip);
     int i;
 
-    ics_pic_print_info(&chip8->psi.ics, mon);
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
+
+    ics_pic_print_info(&chip8->psi.ics, buf);
 
     for (i = 0; i < chip8->num_phbs; i++) {
         PnvPHB *phb = chip8->phbs[i];
         PnvPHB3 *phb3 = PNV_PHB3(phb->backend);
-        g_autoptr(GString) buf = g_string_new("");
-        g_autoptr(HumanReadableText) info = NULL;
 
         pnv_phb3_msi_pic_print_info(&phb3->msis, buf);
-        info = human_readable_text_from_str(buf);
-        monitor_puts(mon, info->human_readable_text);
-
-        ics_pic_print_info(&phb3->lsis, mon);
+        ics_pic_print_info(&phb3->lsis, buf);
     }
+
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 }
 
 static int pnv_chip_power9_pic_print_info_child(Object *child, void *opaque)
-- 
2.41.0


