Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7AAC25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 12:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBCxa-0006H6-Dk; Sun, 26 May 2024 08:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBCxY-0006Fn-3T; Sun, 26 May 2024 08:26:44 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBCxV-0001Ma-RI; Sun, 26 May 2024 08:26:43 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3737b3c56d7so9593585ab.2; 
 Sun, 26 May 2024 05:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716726399; x=1717331199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qaa1CJNZBddwryvQGk2blXK8TkhlUvCCGTcuF5Y8qHE=;
 b=N72bm8eJ1QicayRbRR17N+/XrP8TXrm+X7oTzq+/lwBCOjrRWDPlF030zogWuk+Oh3
 uoobrocubhPdegCrvqA8L+Gr+FwcRezkgC4/Mdgat+1Mv3DgO6YPOD1Va0Sy7t3dPPL7
 K++C+ufaooh5eyjds1RvWV+sP3ao9tG+S9QLdnZ1Aqi8mgQbBvcYpAPymLdltsGoRocU
 i+iHMpVHe+KolWe1oZljTZ/QvU/XNTABD3XN4Olu8c5UnqZmWV5iu9C1HWfrJOVL5zTU
 TWkvsRn9hpBwpIWiNf4dA4bt7k6YeNZasUL3WMZExnNryH8c4D+Z46HX+kx8Movil39V
 bLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716726399; x=1717331199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qaa1CJNZBddwryvQGk2blXK8TkhlUvCCGTcuF5Y8qHE=;
 b=AJlZp7oahb+/32bT2/XrqJ6ehRWWwsgINphxJYy4PPacLLAzKgERCclZ4LGZMMCHdN
 DlqHdW70z2zSAQR13AJHBPa1BuYNkw4bvE10+KNAO+EbpXwyGbZSp2CZRI179pUczPQp
 6w2k2wvY/XLKcs/yjB/1ekwmpz5hWgUUNvquS2hLMdM8iA7IkfzO8FaHlxj+61Y8JptZ
 sPzi6E9F1XnEE+DDD0hwSN9EBqDybO7peb2zdNcW7CDz19WWuCa6aX4wTCAV+SwERPfi
 3my1phcgUOrZKuzSviQ+ytnqrPlm74DRA26nsAbh8hQuW0Vs2WHXiF0ZUWScsV0/YW0T
 6E5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDPOQu9dCsYE/uz55htxKhQTjpb098y8Xsp2u/2YkkfMBY9l0IDBzF3LpBMEsZm/EStq+eaqO2PA+gN4u05S1GKq973P8=
X-Gm-Message-State: AOJu0YyTEZMOLlDE67s49sEejaPMIcG78YM/OvtxUT03Oz1rGPQL8ani
 ZLBZ/Mrf7Sd+AGuKFmRukh8W8fJpn5xQqz0iKOplorEjfHa6bpI64jnlWw==
X-Google-Smtp-Source: AGHT+IG07y+vZ4y0eyZICzLbhhBq+op1D5zAMbEM2+NtNNNX1DvXXhdCb3sEYW41PVDgAv2rQMUe4w==
X-Received: by 2002:a92:cda6:0:b0:36d:b4b0:9c8e with SMTP id
 e9e14a558f8ab-3737b2f0d8bmr74180845ab.8.1716726399561; 
 Sun, 26 May 2024 05:26:39 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcfe648bsm3457182b3a.168.2024.05.26.05.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 05:26:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 05/10] ppc/pnv: Extend chip_pir class method to TIR as well
Date: Sun, 26 May 2024 22:26:06 +1000
Message-ID: <20240526122612.473476-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526122612.473476-1-npiggin@gmail.com>
References: <20240526122612.473476-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The chip_pir chip class method allows the platform to set the PIR
processor identification register. Extend this to a more general
ID function which also allows the TIR to be set. This is in
preparation for "big core", which is a more complicated topology
of cores and threads.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv_chip.h |  3 +-
 hw/ppc/pnv.c              | 61 ++++++++++++++++++++++++---------------
 hw/ppc/pnv_core.c         | 10 ++++---
 3 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 8589f3291e..679723926a 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -147,7 +147,8 @@ struct PnvChipClass {
 
     DeviceRealize parent_realize;
 
-    uint32_t (*chip_pir)(PnvChip *chip, uint32_t core_id, uint32_t thread_id);
+    void (*processor_id)(PnvChip *chip, uint32_t core_id, uint32_t thread_id,
+                         uint32_t *pir, uint32_t *tir);
     void (*intc_create)(PnvChip *chip, PowerPCCPU *cpu, Error **errp);
     void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu);
     void (*intc_destroy)(PnvChip *chip, PowerPCCPU *cpu);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index a706de2e36..7d062ec16c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -144,7 +144,7 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     PnvChipClass *pnv_cc = PNV_CHIP_GET_CLASS(chip);
     g_autofree uint32_t *servers_prop = g_new(uint32_t, smt_threads);
     int i;
-    uint32_t pir;
+    uint32_t pir, tir;
     uint32_t segs[] = {cpu_to_be32(28), cpu_to_be32(40),
                        0xffffffff, 0xffffffff};
     uint32_t tbfreq = PNV_TIMEBASE_FREQ;
@@ -155,7 +155,7 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     char *nodename;
     int cpus_offset = get_cpus_node(fdt);
 
-    pir = pnv_cc->chip_pir(chip, pc->hwid, 0);
+    pnv_cc->processor_id(chip, pc->hwid, 0, &pir, &tir);
 
     nodename = g_strdup_printf("%s@%x", dc->fw_name, pir);
     offset = fdt_add_subnode(fdt, cpus_offset, nodename);
@@ -237,7 +237,8 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
 
     /* Build interrupt servers properties */
     for (i = 0; i < smt_threads; i++) {
-        servers_prop[i] = cpu_to_be32(pnv_cc->chip_pir(chip, pc->hwid, i));
+        pnv_cc->processor_id(chip, pc->hwid, i, &pir, &tir);
+        servers_prop[i] = cpu_to_be32(pir);
     }
     _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
                        servers_prop, sizeof(*servers_prop) * smt_threads)));
@@ -249,14 +250,17 @@ static void pnv_dt_icp(PnvChip *chip, void *fdt, uint32_t hwid,
                        uint32_t nr_threads)
 {
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
-    uint32_t pir = pcc->chip_pir(chip, hwid, 0);
-    uint64_t addr = PNV_ICP_BASE(chip) | (pir << 12);
+    uint32_t pir, tir;
+    uint64_t addr;
     char *name;
     const char compat[] = "IBM,power8-icp\0IBM,ppc-xicp";
     uint32_t irange[2], i, rsize;
     uint64_t *reg;
     int offset;
 
+    pcc->processor_id(chip, hwid, 0, &pir, &tir);
+    addr = PNV_ICP_BASE(chip) | (pir << 12);
+
     irange[0] = cpu_to_be32(pir);
     irange[1] = cpu_to_be32(nr_threads);
 
@@ -1104,10 +1108,12 @@ static void pnv_power10_init(MachineState *machine)
  *   25:28  Core number
  *   29:31  Thread ID
  */
-static uint32_t pnv_chip_pir_p8(PnvChip *chip, uint32_t core_id,
-                                uint32_t thread_id)
+static void pnv_processor_id_p8(PnvChip *chip,
+                                uint32_t core_id, uint32_t thread_id,
+                                uint32_t *pir, uint32_t *tir)
 {
-    return (chip->chip_id << 7) | (core_id << 3) | thread_id;
+    *pir = (chip->chip_id << 7) | (core_id << 3) | thread_id;
+    *tir = thread_id;
 }
 
 static void pnv_chip_power8_intc_create(PnvChip *chip, PowerPCCPU *cpu,
@@ -1159,15 +1165,17 @@ static void pnv_chip_power8_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
  *
  * We only care about the lower bits. uint32_t is fine for the moment.
  */
-static uint32_t pnv_chip_pir_p9(PnvChip *chip, uint32_t core_id,
-                                uint32_t thread_id)
+static void pnv_processor_id_p9(PnvChip *chip,
+                                uint32_t core_id, uint32_t thread_id,
+                                uint32_t *pir, uint32_t *tir)
 {
     if (chip->nr_threads == 8) {
-        return (chip->chip_id << 8) | ((thread_id & 1) << 2) | (core_id << 3) |
+        *pir = (chip->chip_id << 8) | ((thread_id & 1) << 2) | (core_id << 3) |
                (thread_id >> 1);
     } else {
-        return (chip->chip_id << 8) | (core_id << 2) | thread_id;
+        *pir = (chip->chip_id << 8) | (core_id << 2) | thread_id;
     }
+    *tir = thread_id;
 }
 
 /*
@@ -1181,15 +1189,17 @@ static uint32_t pnv_chip_pir_p9(PnvChip *chip, uint32_t core_id,
  *
  * We only care about the lower bits. uint32_t is fine for the moment.
  */
-static uint32_t pnv_chip_pir_p10(PnvChip *chip, uint32_t core_id,
-                                 uint32_t thread_id)
+static void pnv_processor_id_p10(PnvChip *chip,
+                                uint32_t core_id, uint32_t thread_id,
+                                uint32_t *pir, uint32_t *tir)
 {
     if (chip->nr_threads == 8) {
-        return (chip->chip_id << 8) | ((core_id / 4) << 4) |
-               ((core_id % 2) << 3) | thread_id;
+        *pir = (chip->chip_id << 8) | ((core_id / 4) << 4) |
+                ((core_id % 2) << 3) | thread_id;
     } else {
-        return (chip->chip_id << 8) | (core_id << 2) | thread_id;
+        *pir = (chip->chip_id << 8) | (core_id << 2) | thread_id;
     }
+    *tir = thread_id;
 }
 
 static void pnv_chip_power9_intc_create(PnvChip *chip, PowerPCCPU *cpu,
@@ -1368,8 +1378,11 @@ static void pnv_chip_icp_realize(Pnv8Chip *chip8, Error **errp)
         int core_hwid = CPU_CORE(pnv_core)->core_id;
 
         for (j = 0; j < CPU_CORE(pnv_core)->nr_threads; j++) {
-            uint32_t pir = pcc->chip_pir(chip, core_hwid, j);
-            PnvICPState *icp = PNV_ICP(xics_icp_get(chip8->xics, pir));
+            uint32_t pir, tir;
+            PnvICPState *icp;
+
+            pcc->processor_id(chip, core_hwid, j, &pir, &tir);
+            icp = PNV_ICP(xics_icp_get(chip8->xics, pir));
 
             memory_region_add_subregion(&chip8->icp_mmio, pir << 12,
                                         &icp->mmio);
@@ -1481,7 +1494,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
     k->chip_cfam_id = 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
     k->cores_mask = POWER8E_CORE_MASK;
     k->num_phbs = 3;
-    k->chip_pir = pnv_chip_pir_p8;
+    k->processor_id = pnv_processor_id_p8;
     k->intc_create = pnv_chip_power8_intc_create;
     k->intc_reset = pnv_chip_power8_intc_reset;
     k->intc_destroy = pnv_chip_power8_intc_destroy;
@@ -1505,7 +1518,7 @@ static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
     k->chip_cfam_id = 0x220ea04980000000ull; /* P8 Venice DD2.0 */
     k->cores_mask = POWER8_CORE_MASK;
     k->num_phbs = 3;
-    k->chip_pir = pnv_chip_pir_p8;
+    k->processor_id = pnv_processor_id_p8;
     k->intc_create = pnv_chip_power8_intc_create;
     k->intc_reset = pnv_chip_power8_intc_reset;
     k->intc_destroy = pnv_chip_power8_intc_destroy;
@@ -1529,7 +1542,7 @@ static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *data)
     k->chip_cfam_id = 0x120d304980000000ull;  /* P8 Naples DD1.0 */
     k->cores_mask = POWER8_CORE_MASK;
     k->num_phbs = 4;
-    k->chip_pir = pnv_chip_pir_p8;
+    k->processor_id = pnv_processor_id_p8;
     k->intc_create = pnv_chip_power8_intc_create;
     k->intc_reset = pnv_chip_power8_intc_reset;
     k->intc_destroy = pnv_chip_power8_intc_destroy;
@@ -1802,7 +1815,7 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
 
     k->chip_cfam_id = 0x220d104900008000ull; /* P9 Nimbus DD2.0 */
     k->cores_mask = POWER9_CORE_MASK;
-    k->chip_pir = pnv_chip_pir_p9;
+    k->processor_id = pnv_processor_id_p9;
     k->intc_create = pnv_chip_power9_intc_create;
     k->intc_reset = pnv_chip_power9_intc_reset;
     k->intc_destroy = pnv_chip_power9_intc_destroy;
@@ -2114,7 +2127,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
 
     k->chip_cfam_id = 0x120da04900008000ull; /* P10 DD1.0 (with NX) */
     k->cores_mask = POWER10_CORE_MASK;
-    k->chip_pir = pnv_chip_pir_p10;
+    k->processor_id = pnv_processor_id_p10;
     k->intc_create = pnv_chip_power10_intc_create;
     k->intc_reset = pnv_chip_power10_intc_reset;
     k->intc_destroy = pnv_chip_power10_intc_destroy;
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 7b0ea7812b..9b5edd9e48 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -228,8 +228,9 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
     PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
     CPUPPCState *env = &cpu->env;
     int core_hwid;
-    ppc_spr_t *pir = &env->spr_cb[SPR_PIR];
-    ppc_spr_t *tir = &env->spr_cb[SPR_TIR];
+    ppc_spr_t *pir_spr = &env->spr_cb[SPR_PIR];
+    ppc_spr_t *tir_spr = &env->spr_cb[SPR_TIR];
+    uint32_t pir, tir;
     Error *local_err = NULL;
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(pc->chip);
 
@@ -247,8 +248,9 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
 
     core_hwid = object_property_get_uint(OBJECT(pc), "hwid", &error_abort);
 
-    tir->default_value = thread_index;
-    pir->default_value = pcc->chip_pir(pc->chip, core_hwid, thread_index);
+    pcc->processor_id(pc->chip, core_hwid, thread_index, &pir, &tir);
+    pir_spr->default_value = pir;
+    tir_spr->default_value = tir;
 
     /* Set time-base frequency to 512 MHz */
     cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
-- 
2.43.0


