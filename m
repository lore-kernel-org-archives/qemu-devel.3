Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6485C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbJ5-00083g-9R; Tue, 18 Jun 2024 12:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbJ2-0007xp-TT
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:03:36 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbJ0-0007Aa-SZ
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:03:36 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a6efacd25ecso350321766b.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726612; x=1719331412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9G2DPLJNs6E99rtv08P3G2cb9DYQeKMhfy51jfr6pg=;
 b=mzFpzcRTaCdGoZXCP0+kga27c5YRgo5l829SqVAPtwkmwV3d99+ce7R4xdIvY+zNH4
 M/jGowJUQtwNE6AC/5wETHS/7qyHfBNYGdyqD1TDaZroLoDioFlAV7lgTjH6D5JpW1XS
 iA/JYw5L6caeu+dtE/nzQiRrjRZPte00gVec8G6gS/6WlO7u1nwPseofnObjCV76lZ3m
 Q/nARMP6Jp0nGPbOzL7zheG+71mRlyyG1CHj02LYxPFIgUsn3VfLNrxwxCqraQKJq7D7
 oQbqrUjDEbVcfxpgYSnmbVpEMbzIvy9lR+AutzQhPRfaapJybCNssUft76Yfe7uvZ8M7
 az5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726612; x=1719331412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U9G2DPLJNs6E99rtv08P3G2cb9DYQeKMhfy51jfr6pg=;
 b=D+sI/osO1qHzNFQgMXz4XMRzmSGh9X+FjpBkAFnZBRZyhKsc3rJU61Fc42piMhDdk3
 5V/l2vQMX8I7bdiOJgErS7k01+/c2uhydRaLzcuqENnK7olM5LLE+v2x3d/8Dra5mPRH
 gz0GdKb4k+oI9ebvj/eg8kpB1Zez/Z2X7YQzFSfdHRUP3dhklgNFBqEqFj1Lydxb6XCg
 0NoBHXC8vk73C3uxIiEaaVHIjurL+wjZC++36pIccykGs38Z9CZnUA8ep+tvPKiE+iqa
 SIXjZpF9zk7d5rVdyI2kQK5BvO38TlsQeGd7LpxYQwtgCS8wf73V6t4PxRVOX6mxmTg3
 nDaQ==
X-Gm-Message-State: AOJu0YzeS4aLkvOYcuBUyqTb1hQdYV9GEehsb1PvJjcDNO1J2tessA5e
 P7UnnGeRUjLlpmK3YlFxFXW/drSmWe4cHFeT/L16dS/9tSOhUzRb/wIe6ZnAFjuKEKPOWJmhb5Q
 h
X-Google-Smtp-Source: AGHT+IEBW1E4Rm9ooiPVPgwIy9fT+j1bQbLvVXl28p7E3dD07oFpeXE/bmv4NauG7YQq+e3Ft5Mv7g==
X-Received: by 2002:a50:f61c:0:b0:57d:3df:f881 with SMTP id
 4fb4d7f45d1cf-57d03dff928mr1088220a12.3.1718726612244; 
 Tue, 18 Jun 2024 09:03:32 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f86dfdb22sm253599366b.77.2024.06.18.09.03.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:03:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 29/76] hw/ppc: Avoid using Monitor in
 PnvChipClass::intc_print_info()
Date: Tue, 18 Jun 2024 17:59:51 +0200
Message-ID: <20240618160039.36108-30-philmd@linaro.org>
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
Message-Id: <20240610062105.49848-6-philmd@linaro.org>
---
 include/hw/ppc/pnv_chip.h |  2 +-
 hw/ppc/pnv.c              | 30 ++++++++----------------------
 2 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 8589f3291e..a5e428be7c 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -151,7 +151,7 @@ struct PnvChipClass {
     void (*intc_create)(PnvChip *chip, PowerPCCPU *cpu, Error **errp);
     void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu);
     void (*intc_destroy)(PnvChip *chip, PowerPCCPU *cpu);
-    void (*intc_print_info)(PnvChip *chip, PowerPCCPU *cpu, Monitor *mon);
+    void (*intc_print_info)(PnvChip *chip, PowerPCCPU *cpu, GString *buf);
     ISABus *(*isa_create)(PnvChip *chip, Error **errp);
     void (*dt_populate)(PnvChip *chip, void *fdt);
     void (*pic_print_info)(PnvChip *chip, Monitor *mon);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 3eaf674efa..aed6767c8d 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1129,15 +1129,9 @@ static void pnv_chip_power8_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
 }
 
 static void pnv_chip_power8_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
-                                            Monitor *mon)
+                                            GString *buf)
 {
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
-
     icp_pic_print_info(ICP(pnv_cpu_state(cpu)->intc), buf);
-
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 }
 
 /*
@@ -1222,15 +1216,9 @@ static void pnv_chip_power9_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
 }
 
 static void pnv_chip_power9_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
-                                            Monitor *mon)
+                                            GString *buf)
 {
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
-
     xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), buf);
-
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 }
 
 static void pnv_chip_power10_intc_create(PnvChip *chip, PowerPCCPU *cpu,
@@ -1272,15 +1260,9 @@ static void pnv_chip_power10_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
 }
 
 static void pnv_chip_power10_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
-                                             Monitor *mon)
+                                             GString *buf)
 {
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
-
     xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), buf);
-
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 }
 
 /*
@@ -2363,14 +2345,18 @@ static void pnv_pic_print_info(InterruptStatsProvider *obj,
     PnvMachineState *pnv = PNV_MACHINE(obj);
     int i;
     CPUState *cs;
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
 
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
 
         /* XXX: loop on each chip/core/thread instead of CPU_FOREACH() */
         PNV_CHIP_GET_CLASS(pnv->chips[0])->intc_print_info(pnv->chips[0], cpu,
-                                                           mon);
+                                                           buf);
     }
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 
     for (i = 0; i < pnv->num_chips; i++) {
         PNV_CHIP_GET_CLASS(pnv->chips[i])->pic_print_info(pnv->chips[i], mon);
-- 
2.41.0


