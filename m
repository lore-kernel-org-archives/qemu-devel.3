Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7BCC3DA4D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSF0K-0006mJ-B6; Fri, 12 Jul 2024 08:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSF0I-0006eC-54; Fri, 12 Jul 2024 08:03:58 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSF0D-0005kG-3F; Fri, 12 Jul 2024 08:03:56 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70b03ffbb3aso1587995b3a.0; 
 Fri, 12 Jul 2024 05:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720785831; x=1721390631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5li3telX6sK1Lhm0cQR+KDeo6fDP+MxgfWC2oPVkLoI=;
 b=J//StK1JTREyk9a4flxY3ohf9nCE5mBQSdTXrr3/9fbEHgqJ5r2SnBhUa7oVlrm3qH
 UsCStu6+BXWWsLOd+nv9FTjl6B92e3GExX2CDgMHobHwkVPim/YY80LsOLfZ32YgOUkR
 lquQq/JjN3rnZdlnoswdQ5o0DAy1VII/P65F436JVE5RLd3nsshCif91XGY2CVzMjLJw
 i5EH9ZVjhpnvDQVDxI39HSQd2djdyyJKVKzb0ognWDs53RxILuHTTX2xgDuv6RxoeKkv
 M10h5srYnd9vaP0mjkaXzyW16IXfIQb141t8pv8Nk3l3/6Wzu9Tu1D8Cv1PLs5QqpU3B
 aF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720785831; x=1721390631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5li3telX6sK1Lhm0cQR+KDeo6fDP+MxgfWC2oPVkLoI=;
 b=inBrxG7t8Yn+xe95SP8t6WOINLClqFjBYFemVGA+/zKJA6F/rlh3S+NoEXKTCnUNwd
 BycBWVGBeoKtWmkkdKoZd3dVslUyjVBBrrXDis2tiLmUdCVJyaQwLui9/ATSid8wz/rx
 uQooU94bz2Y/OkgX3plDCFtNY2BgxwsrntmoRDQ0BOPMD7Cu5GlB+UjD/wPcW6lWoooq
 ewfkm2qPHh5RE4Om7C11CK8UuuYqz7fyKZPrbyim3eOYE2PNQIU7dAuEJknE6Poe3JMS
 D0o9c4Pa9UIXUIzhPbCHrV/8SSW3RQMPph8aeZ4zqMG/qQS0A4caoJeIRwTY+md55ShV
 gVqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs4AKII1CIDelUDm8yMC+yic1oIv1MiUzb6rdmRfaDwuBKQPcLYjgY5K8BJ6nh6ZWwpMcVyV9IjPEXIfPcjMCwC6DIFcQ=
X-Gm-Message-State: AOJu0YyAO/dW/oV0mTElO9YQLYu7lSPwG3jZxoXzvarOUrxh+GmkLVpP
 7zZ24OaF8LX8nj48Va1VCCligSRsDouY2C2viEhT6alh2fR/WkxqVI7qkg==
X-Google-Smtp-Source: AGHT+IGu9x2z2KWdH5mv1DOLSgeaKSGBHm+5t0BW5W3zXg8vTFfdZTC1JUFAVAsGZUEeZqzj7Y1MQw==
X-Received: by 2002:a05:6a00:1810:b0:706:7276:6287 with SMTP id
 d2e1a72fcca58-70b434f34c8mr14891028b3a.1.1720785800682; 
 Fri, 12 Jul 2024 05:03:20 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438c0a1csm7308967b3a.63.2024.07.12.05.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 05:03:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 06/19] ppc/pnv: Extend chip_pir class method to TIR as well
Date: Fri, 12 Jul 2024 22:02:33 +1000
Message-ID: <20240712120247.477133-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240712120247.477133-1-npiggin@gmail.com>
References: <20240712120247.477133-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv_chip.h |  4 +-
 hw/ppc/pnv.c              | 85 +++++++++++++++++++++++++--------------
 hw/ppc/pnv_core.c         | 10 +++--
 3 files changed, 64 insertions(+), 35 deletions(-)

diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 4eaa7d3999..7d5d08bcdc 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -150,7 +150,9 @@ struct PnvChipClass {
 
     DeviceRealize parent_realize;
 
-    uint32_t (*chip_pir)(PnvChip *chip, uint32_t core_id, uint32_t thread_id);
+    /* Get PIR and TIR values for a CPU thread identified by core/thread id */
+    void (*get_pir_tir)(PnvChip *chip, uint32_t core_id, uint32_t thread_id,
+                         uint32_t *pir, uint32_t *tir);
     void (*intc_create)(PnvChip *chip, PowerPCCPU *cpu, Error **errp);
     void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu);
     void (*intc_destroy)(PnvChip *chip, PowerPCCPU *cpu);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index fde51ca946..eee34ca926 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -154,7 +154,7 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     char *nodename;
     int cpus_offset = get_cpus_node(fdt);
 
-    pir = pnv_cc->chip_pir(chip, pc->hwid, 0);
+    pnv_cc->get_pir_tir(chip, pc->hwid, 0, &pir, NULL);
 
     nodename = g_strdup_printf("%s@%x", dc->fw_name, pir);
     offset = fdt_add_subnode(fdt, cpus_offset, nodename);
@@ -236,7 +236,8 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
 
     /* Build interrupt servers properties */
     for (i = 0; i < smt_threads; i++) {
-        servers_prop[i] = cpu_to_be32(pnv_cc->chip_pir(chip, pc->hwid, i));
+        pnv_cc->get_pir_tir(chip, pc->hwid, i, &pir, NULL);
+        servers_prop[i] = cpu_to_be32(pir);
     }
     _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
                        servers_prop, sizeof(*servers_prop) * smt_threads)));
@@ -248,14 +249,17 @@ static void pnv_dt_icp(PnvChip *chip, void *fdt, uint32_t hwid,
                        uint32_t nr_threads)
 {
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
-    uint32_t pir = pcc->chip_pir(chip, hwid, 0);
-    uint64_t addr = PNV_ICP_BASE(chip) | (pir << 12);
+    uint32_t pir;
+    uint64_t addr;
     char *name;
     const char compat[] = "IBM,power8-icp\0IBM,ppc-xicp";
     uint32_t irange[2], i, rsize;
     uint64_t *reg;
     int offset;
 
+    pcc->get_pir_tir(chip, hwid, 0, &pir, NULL);
+    addr = PNV_ICP_BASE(chip) | (pir << 12);
+
     irange[0] = cpu_to_be32(pir);
     irange[1] = cpu_to_be32(nr_threads);
 
@@ -1106,10 +1110,16 @@ static void pnv_init(MachineState *machine)
  *   25:28  Core number
  *   29:31  Thread ID
  */
-static uint32_t pnv_chip_pir_p8(PnvChip *chip, uint32_t core_id,
-                                uint32_t thread_id)
+static void pnv_get_pir_tir_p8(PnvChip *chip,
+                                uint32_t core_id, uint32_t thread_id,
+                                uint32_t *pir, uint32_t *tir)
 {
-    return (chip->chip_id << 7) | (core_id << 3) | thread_id;
+    if (pir) {
+        *pir = (chip->chip_id << 7) | (core_id << 3) | thread_id;
+    }
+    if (tir) {
+        *tir = thread_id;
+    }
 }
 
 static void pnv_chip_power8_intc_create(PnvChip *chip, PowerPCCPU *cpu,
@@ -1161,14 +1171,20 @@ static void pnv_chip_power8_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
  *
  * We only care about the lower bits. uint32_t is fine for the moment.
  */
-static uint32_t pnv_chip_pir_p9(PnvChip *chip, uint32_t core_id,
-                                uint32_t thread_id)
-{
-    if (chip->nr_threads == 8) {
-        return (chip->chip_id << 8) | ((thread_id & 1) << 2) | (core_id << 3) |
-               (thread_id >> 1);
-    } else {
-        return (chip->chip_id << 8) | (core_id << 2) | thread_id;
+static void pnv_get_pir_tir_p9(PnvChip *chip,
+                                uint32_t core_id, uint32_t thread_id,
+                                uint32_t *pir, uint32_t *tir)
+{
+    if (pir) {
+        if (chip->nr_threads == 8) {
+            *pir = (chip->chip_id << 8) | ((thread_id & 1) << 2) |
+                   (core_id << 3) | (thread_id >> 1);
+        } else {
+            *pir = (chip->chip_id << 8) | (core_id << 2) | thread_id;
+        }
+    }
+    if (tir) {
+        *tir = thread_id;
     }
 }
 
@@ -1183,14 +1199,20 @@ static uint32_t pnv_chip_pir_p9(PnvChip *chip, uint32_t core_id,
  *
  * We only care about the lower bits. uint32_t is fine for the moment.
  */
-static uint32_t pnv_chip_pir_p10(PnvChip *chip, uint32_t core_id,
-                                 uint32_t thread_id)
-{
-    if (chip->nr_threads == 8) {
-        return (chip->chip_id << 8) | ((core_id / 4) << 4) |
-               ((core_id % 2) << 3) | thread_id;
-    } else {
-        return (chip->chip_id << 8) | (core_id << 2) | thread_id;
+static void pnv_get_pir_tir_p10(PnvChip *chip,
+                                uint32_t core_id, uint32_t thread_id,
+                                uint32_t *pir, uint32_t *tir)
+{
+    if (pir) {
+        if (chip->nr_threads == 8) {
+            *pir = (chip->chip_id << 8) | ((core_id / 4) << 4) |
+                    ((core_id % 2) << 3) | thread_id;
+        } else {
+            *pir = (chip->chip_id << 8) | (core_id << 2) | thread_id;
+        }
+    }
+    if (tir) {
+        *tir = thread_id;
     }
 }
 
@@ -1370,8 +1392,11 @@ static void pnv_chip_icp_realize(Pnv8Chip *chip8, Error **errp)
         int core_hwid = CPU_CORE(pnv_core)->core_id;
 
         for (j = 0; j < CPU_CORE(pnv_core)->nr_threads; j++) {
-            uint32_t pir = pcc->chip_pir(chip, core_hwid, j);
-            PnvICPState *icp = PNV_ICP(xics_icp_get(chip8->xics, pir));
+            uint32_t pir;
+            PnvICPState *icp;
+
+            pcc->get_pir_tir(chip, core_hwid, j, &pir, NULL);
+            icp = PNV_ICP(xics_icp_get(chip8->xics, pir));
 
             memory_region_add_subregion(&chip8->icp_mmio, pir << 12,
                                         &icp->mmio);
@@ -1483,7 +1508,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
     k->chip_cfam_id = 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
     k->cores_mask = POWER8E_CORE_MASK;
     k->num_phbs = 3;
-    k->chip_pir = pnv_chip_pir_p8;
+    k->get_pir_tir = pnv_get_pir_tir_p8;
     k->intc_create = pnv_chip_power8_intc_create;
     k->intc_reset = pnv_chip_power8_intc_reset;
     k->intc_destroy = pnv_chip_power8_intc_destroy;
@@ -1507,7 +1532,7 @@ static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
     k->chip_cfam_id = 0x220ea04980000000ull; /* P8 Venice DD2.0 */
     k->cores_mask = POWER8_CORE_MASK;
     k->num_phbs = 3;
-    k->chip_pir = pnv_chip_pir_p8;
+    k->get_pir_tir = pnv_get_pir_tir_p8;
     k->intc_create = pnv_chip_power8_intc_create;
     k->intc_reset = pnv_chip_power8_intc_reset;
     k->intc_destroy = pnv_chip_power8_intc_destroy;
@@ -1531,7 +1556,7 @@ static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *data)
     k->chip_cfam_id = 0x120d304980000000ull;  /* P8 Naples DD1.0 */
     k->cores_mask = POWER8_CORE_MASK;
     k->num_phbs = 4;
-    k->chip_pir = pnv_chip_pir_p8;
+    k->get_pir_tir = pnv_get_pir_tir_p8;
     k->intc_create = pnv_chip_power8_intc_create;
     k->intc_reset = pnv_chip_power8_intc_reset;
     k->intc_destroy = pnv_chip_power8_intc_destroy;
@@ -1814,7 +1839,7 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
 
     k->chip_cfam_id = 0x220d104900008000ull; /* P9 Nimbus DD2.0 */
     k->cores_mask = POWER9_CORE_MASK;
-    k->chip_pir = pnv_chip_pir_p9;
+    k->get_pir_tir = pnv_get_pir_tir_p9;
     k->intc_create = pnv_chip_power9_intc_create;
     k->intc_reset = pnv_chip_power9_intc_reset;
     k->intc_destroy = pnv_chip_power9_intc_destroy;
@@ -2136,7 +2161,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
 
     k->chip_cfam_id = 0x120da04900008000ull; /* P10 DD1.0 (with NX) */
     k->cores_mask = POWER10_CORE_MASK;
-    k->chip_pir = pnv_chip_pir_p10;
+    k->get_pir_tir = pnv_get_pir_tir_p10;
     k->intc_create = pnv_chip_power10_intc_create;
     k->intc_reset = pnv_chip_power10_intc_reset;
     k->intc_destroy = pnv_chip_power10_intc_destroy;
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 2da271ffb6..28ca61926d 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -227,8 +227,9 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
 {
     CPUPPCState *env = &cpu->env;
     int core_hwid;
-    ppc_spr_t *pir = &env->spr_cb[SPR_PIR];
-    ppc_spr_t *tir = &env->spr_cb[SPR_TIR];
+    ppc_spr_t *pir_spr = &env->spr_cb[SPR_PIR];
+    ppc_spr_t *tir_spr = &env->spr_cb[SPR_TIR];
+    uint32_t pir, tir;
     Error *local_err = NULL;
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(pc->chip);
 
@@ -244,8 +245,9 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
 
     core_hwid = object_property_get_uint(OBJECT(pc), "hwid", &error_abort);
 
-    tir->default_value = thread_index;
-    pir->default_value = pcc->chip_pir(pc->chip, core_hwid, thread_index);
+    pcc->get_pir_tir(pc->chip, core_hwid, thread_index, &pir, &tir);
+    pir_spr->default_value = pir;
+    tir_spr->default_value = tir;
 
     /* Set time-base frequency to 512 MHz */
     cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
-- 
2.45.1


