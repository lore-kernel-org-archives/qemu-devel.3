Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3111C27C5F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYPX-0002nm-2e; Mon, 10 Jun 2024 02:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYPU-0002ic-Tm
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:21:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYPS-0004NN-M0
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:21:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42138eadf64so34770175e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000496; x=1718605296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUkjBdMn0Xwkp4SAMe6a316u0vtim0sUUdnsa/RAHC8=;
 b=DGTLrgYuEHYE57zMic3K4hmrXFGAf2rBJMk494a1vImKdYVzbaq7F7qyv0XUV68D92
 HMiPD210In2UUYcAHk3ykbxCXx/hplXwSF4tPH/hJiNBID3LGZf3Qxuv4Jq20yEWzMid
 6r5lL02c3uRMKYVoc/dSdcKs5+X2TJdKqbvRCHQqFnf6QBCCNKp9ZZuggZzsIfAt34Kv
 Tjwzc1bV8ernXqS6lJ/iDXdsMIkxE9HiNqK6Q8HO1ZaMOS8wS1Pkm86Sp76RlRBo8twe
 F0eO1a7grX6A+TILhoCPMRnFWcQiqPyh1j+evtM6pLcGy40ossuN/tKIFQxVbeuwjxSi
 gxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000496; x=1718605296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zUkjBdMn0Xwkp4SAMe6a316u0vtim0sUUdnsa/RAHC8=;
 b=Xc7eLCwV6g5hrdb1JrXxqGm0IlNa6QRbN+Hue5s5FQFHLkTOdDBQsi0k/ktoT6eiNv
 g5Cy1mvU99yb+32dKe/LaHR69tVxsAQ2vAoqG3t8wXhCM1VAvHyTvaGmf1DShx/hkUaj
 z0wrhYf+qpyvaP4sDhlCl8VA6coCVthkSZL9DLUYRs77SiACma0tMbAVPoEuMNfzhA2T
 ISvnFjj/EHLY9Ewjdce9pFLj+dhZg8HuiMe2nR1ZmWhKIANCtDzloDt+8fv/KgkWbSG7
 FLFPyxjEIzo+Fjgs0PxjaPNFZmbouQeMuGYFLQqrWaF/s1mops5XGcG54btZo7V72uPC
 8L3Q==
X-Gm-Message-State: AOJu0YzdDZPPtr63u6vPW8RdrrIZ4Ui6oAI/xEBIP0jBg+wER0yeflxV
 y1EfvN2oIg6Dt/mRcTi8tUYLNOx4QW+NisTnl9hu1q4cfA1JvZK+FhbQLRyLdc3WtbgWgoNpPh0
 j
X-Google-Smtp-Source: AGHT+IGdNNTXnbFwdebW9MgZlCggUZoURHEV5bZrv1lF5xyiy658kN6IiTUOXL/LpCf9yoeQx6R8EA==
X-Received: by 2002:a05:600c:1ca6:b0:421:a575:99b1 with SMTP id
 5b1f17b1804b1-421a5759c17mr16675555e9.29.1718000496455; 
 Sun, 09 Jun 2024 23:21:36 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f118f5423sm5662871f8f.98.2024.06.09.23.21.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:21:36 -0700 (PDT)
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
Subject: [PATCH 05/26] hw/ppc: Avoid using Monitor in
 PnvChipClass::intc_print_info()
Date: Mon, 10 Jun 2024 08:20:43 +0200
Message-ID: <20240610062105.49848-6-philmd@linaro.org>
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


