Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC820C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 11:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJAP8-0006DB-3v; Mon, 17 Jun 2024 07:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJAP5-0006BD-W1
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 07:20:04 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJAP4-0001Fr-3V
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 07:20:03 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a63359aaaa6so640079266b.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 04:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718623200; x=1719228000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=inpK6xOJiiNz3UpLvpncRJOWvp4Nl5gzWl7O7h7KLjY=;
 b=tjTunuaQaQ5hqRlpDuV6Wx1NRCdVVIu+CnsMW/xABQV8sFfYq8eBLY3inXy8/JaFig
 s5JEjgSPO3cs+URRjcn3KNIFg5yDHRT/0f436ITRWbooye68K4S2Yn+PZ4MKL0hQduzZ
 jg5GIsSp8cqd47Mp6OvfjhK93HFP6Na6juStOX7uzk2Olj/q5ZvoWxiJd6Pu4/6Ko/jR
 kSich3YIGlnPhQF6jCabL7HGfBpCoYHUMqglCX24Oxm3p88xe+wrRti/Y9+o4y7btXVA
 UgmH0BcMs+37UgHJsCwRbxl9RS7qlrg0YrDn7/6kxullvQnd8uKH9zCKXdUM4ZI5gtcs
 ZzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718623200; x=1719228000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=inpK6xOJiiNz3UpLvpncRJOWvp4Nl5gzWl7O7h7KLjY=;
 b=S6cXnZ95HH49UU9EYjsvhswfCeAKg6aeRTLNF7lJVwbQgxxCfW5d5E+PVeRUxJyZ7T
 ilEsYWQlcqGtP4sIBZlOcoFMJgd2nvDCnK+dG8O8rjmAZ30CBG3Xc5yeW20O9EP31F9T
 XLMBQTTckbRD8jvDD/Ejc6KtSNInBCW28PrLlnra0o6fH6aZmUta8y2uukHVf3ubyUUr
 XSwVWOke97BnVb6W6YNXiX4PUsSbHcu1echDb0aJmPzmrQLJMKKjZQL2biUdFbMCDmWV
 ICKc4+7apa73MOKglGHRwvCUvihSxxryfvwjxqb/T3mu85pfm3yUltbIZaIeb+aKwLSe
 Q2FQ==
X-Gm-Message-State: AOJu0YztdeC10Fu0y7Xfs24QjEFh2mSxVC0kQ159Pbs4+lbKwgQIz9gV
 yq36pQyjbwX897fRAj9X3ZLlGO1rkA2RROl3y18NTwLUzfusm47Z+/bbs4dfc+NpwiY+4vv7x75
 S
X-Google-Smtp-Source: AGHT+IFiVEjkQuyVL0KZnqOJOxWY9ArSOzC4LPvnXnz+EHCdkEa8nSXyILOfVgK4DXEAQJcdtndJAg==
X-Received: by 2002:a17:906:40d7:b0:a6f:585d:626d with SMTP id
 a640c23a62f3a-a6f60dc896amr534351666b.48.1718623199966; 
 Mon, 17 Jun 2024 04:19:59 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f4182fsm511208766b.178.2024.06.17.04.19.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jun 2024 04:19:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] ppc/pnv: Introduce pnv_chip_foreach_cpu()
Date: Mon, 17 Jun 2024 13:19:56 +0200
Message-ID: <20240617111956.78414-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

From: Cédric Le Goater <clg@redhat.com>

This helper routine uses the machine definition, sockets, cores and
threads, to loop on all CPUs of the machine. Replace CPU_FOREACH()
with it.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240424093048.180966-1-clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v2: Rebased
Based-on: <20240610062105.49848-1-philmd@linaro.org>
(Since Nick reviewed it, I plan to queue this patch for my
own maintainer convenience).
---
 hw/ppc/pnv.c | 50 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 03c595788f..6b41d1d2dd 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2261,6 +2261,21 @@ PowerPCCPU *pnv_chip_find_cpu(PnvChip *chip, uint32_t pir)
     return NULL;
 }
 
+static void pnv_chip_foreach_cpu(PnvChip *chip,
+                   void (*fn)(PnvChip *chip, PowerPCCPU *cpu, void *opaque),
+                   void *opaque)
+{
+    int i, j;
+
+    for (i = 0; i < chip->nr_cores; i++) {
+        PnvCore *pc = chip->cores[i];
+
+        for (j = 0; j < CPU_CORE(pc)->nr_threads; j++) {
+            fn(chip, pc->threads[j], opaque);
+        }
+    }
+}
+
 static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
 {
     PnvMachineState *pnv = PNV_MACHINE(xi);
@@ -2329,22 +2344,25 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int pir)
     return cpu ? ICP(pnv_cpu_state(cpu)->intc) : NULL;
 }
 
+static void pnv_pic_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
+                                    void *opaque)
+{
+    PNV_CHIP_GET_CLASS(chip)->intc_print_info(chip, cpu, opaque);
+}
+
 static void pnv_pic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
     PnvMachineState *pnv = PNV_MACHINE(obj);
     int i;
-    CPUState *cs;
-
-    CPU_FOREACH(cs) {
-        PowerPCCPU *cpu = POWERPC_CPU(cs);
-
-        /* XXX: loop on each chip/core/thread instead of CPU_FOREACH() */
-        PNV_CHIP_GET_CLASS(pnv->chips[0])->intc_print_info(pnv->chips[0], cpu,
-                                                           buf);
-    }
 
     for (i = 0; i < pnv->num_chips; i++) {
-        PNV_CHIP_GET_CLASS(pnv->chips[i])->pic_print_info(pnv->chips[i], buf);
+        PnvChip *chip = pnv->chips[i];
+
+        /* First CPU presenters */
+        pnv_chip_foreach_cpu(chip, pnv_pic_intc_print_info, buf);
+
+        /* Then other devices, PHB, PSI, XIVE */
+        PNV_CHIP_GET_CLASS(chip)->pic_print_info(chip, buf);
     }
 }
 
@@ -2545,12 +2563,18 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
     }
 }
 
+static void pnv_cpu_do_nmi(PnvChip *chip, PowerPCCPU *cpu, void *opaque)
+{
+    async_run_on_cpu(CPU(cpu), pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
+}
+
 static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
 {
-    CPUState *cs;
+    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
+    int i;
 
-    CPU_FOREACH(cs) {
-        async_run_on_cpu(cs, pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
+    for (i = 0; i < pnv->num_chips; i++) {
+        pnv_chip_foreach_cpu(pnv->chips[i], pnv_cpu_do_nmi, NULL);
     }
 }
 
-- 
2.41.0


