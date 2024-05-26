Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C117C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 12:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBCxn-0006NK-45; Sun, 26 May 2024 08:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBCxl-0006Ma-G4; Sun, 26 May 2024 08:26:57 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBCxi-0001P8-LY; Sun, 26 May 2024 08:26:57 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6f8eaa14512so1913474b3a.3; 
 Sun, 26 May 2024 05:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716726412; x=1717331212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L94RTwpjXCATrbcRIUw+XxTfDKit6vzQ4DHSIbjIz4E=;
 b=GtAdGM6xGGhesXR3VofY6UKkqU8DmSi+S0QtkbSIiKJs/6y/ZEvVncLyAs4aF9Duwo
 aKr8B6REjFmMIwm/awMRJcS0ykOH/NxnyUTZDElSJHuEtaX5ciRZF2DxxIpZPinLQR/f
 RWLH/8NKwVBwNvq7B/YsAwq+76TcxQs/OXklsoHYUG5lM1GblFNdZxybzTAVa7sKIywL
 l412d/84TEwig6AeIFaJu1AMwZl1F7kKv1VEcfm5clwSV8DCrayP/X9C9H4unZhy+5PB
 ZY+9hndrSs6C2zEKChCsMcaKiO8EoUnxR7ZpcBP48D6L203uzNKV+llnaKjfJWYKxUgW
 RBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716726412; x=1717331212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L94RTwpjXCATrbcRIUw+XxTfDKit6vzQ4DHSIbjIz4E=;
 b=PFT8bbIgkXCh4rKgqlwTPYUxAIzCxXd1ZAdhgVZysQmMXm4XqiYpd9rY1ufqfhdNsw
 1g4mVX/HCbHcp2/5bD+Kl8VrY9vFjVO7fF/A4VRBdQFPhsfedpHaBA8WkPC6NpmRIUij
 Chf+gINLBWO14udXhbtjhCaqBoGbuT1tLU/PR2QM3n43FG8hSQuRYRjtnixMieS0CXMC
 N6IfWTyjCHDIS+grFC6fHqwaoa8hXc/31zQIBbMlgF8ibHahLZNazeBMPo57j/hFPulh
 emUX2DBYMuQTTi9kTBYaruy/bORx6i0R0vNymYTckFy6zAUSdJFXc+COiDzTVyHtdOPT
 SZEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgkmP6yC2gY06hE8YP1eFBqOsOnwb2v5YXs6V3K2WgDWQC65NcPKpaFOdRrC63mm0qmVXEh4u+tW/YzJM3UPZYHJzgI4g=
X-Gm-Message-State: AOJu0YxoGudWTa9G1+2uE9J+omRLb+gDLzfU73OZchZQcobEY4JvHcxH
 5UudJvry+db4Jersov/DkD9oM0YlqRvfJO3L3b4fspIl3hZMGmBNeAAwUg==
X-Google-Smtp-Source: AGHT+IHopXMDP4FjmYbimSbfofychDP/10LUc8+ZhzOMMlFOWKNsbcEo3qjCXcDGyXlEEvoLvcwyqw==
X-Received: by 2002:a05:6a00:408d:b0:6ee:1d03:77b9 with SMTP id
 d2e1a72fcca58-6f8f42b15eemr8085581b3a.31.1716726411512; 
 Sun, 26 May 2024 05:26:51 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcfe648bsm3457182b3a.168.2024.05.26.05.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 05:26:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 08/10] ppc/pnv: Invert the design for big-core machine
 modelling
Date: Sun, 26 May 2024 22:26:09 +1000
Message-ID: <20240526122612.473476-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526122612.473476-1-npiggin@gmail.com>
References: <20240526122612.473476-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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

POWER9 and POWER10 machines come in two variants, "big-core" and
"small-core".

Big core machines are SMT8 from the software point of view, but in the
low level platform topology ("xscom registers and pervasive
addressing"), these look more like a pair of small cores ganged
together.

Presently, the way this is modelled is to create an SMT8 PnvCore and
add special cases to xscom and pervasive for big-core mode. This is
becoming too complicated to manage as more of the machine is modelled.
The better approach looks like the inverse, which is creating 2xPnvCore
ganging them together to look like an SMT8 core in TCG. The TCG SMT code
is quite simple to do that, and then the xscom and pervasive modelling
does not need to differentiate big and small core modes for the most
part.

device-tree building does need a special case to only build one
CPU node for each big-core because that's what the firmware expects.
And so does a special case workaround in the ChipTOD model.

A big-core machine option is added for powernv9 and 10 machines.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv.h         |   3 +
 include/hw/ppc/pnv_core.h    |   8 ++
 target/ppc/cpu.h             |   4 +-
 hw/ppc/pnv.c                 | 183 ++++++++++++++++++++++++++++-------
 hw/ppc/pnv_core.c            |  20 +++-
 hw/ppc/spapr_cpu_core.c      |   6 +-
 target/ppc/misc_helper.c     |   6 +-
 target/ppc/timebase_helper.c |   9 ++
 8 files changed, 197 insertions(+), 42 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 476b136146..93ecb062b4 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -100,6 +100,9 @@ struct PnvMachineState {
     PnvPnor      *pnor;
 
     hwaddr       fw_load_addr;
+
+    bool         big_core;
+    bool         big_core_tbst_quirk;
 };
 
 PnvChip *pnv_get_chip(PnvMachineState *pnv, uint32_t chip_id);
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 21297262c1..39f8f33e6c 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -27,6 +27,13 @@
 
 /* ChipTOD and TimeBase State Machine */
 struct pnv_tod_tbst {
+    /*
+     * POWER10 DD2.0 - big core TFMR drives the state machine on the even
+     * small core. Skiboot has a workaround that targets the even small core
+     * for CHIPTOD_TO_TB ops.
+     */
+    bool big_core_quirk;
+
     int tb_ready_for_tod; /* core TB ready to receive TOD from chiptod */
     int tod_sent_to_tb;   /* chiptod sent TOD to the core TB */
 
@@ -49,6 +56,7 @@ struct PnvCore {
 
     /*< public >*/
     PowerPCCPU **threads;
+    bool big_core;
     uint32_t pir;
     uint32_t hwid;
     uint64_t hrmor;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 8fd6ade471..de15e38af8 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1248,6 +1248,7 @@ struct CPUArchState {
     int access_type;
 
     /* For SMT processors */
+    int has_smt_siblings;
     int core_index;
 
 #if !defined(CONFIG_USER_ONLY)
@@ -1276,7 +1277,6 @@ struct CPUArchState {
     uint32_t tlb_need_flush; /* Delayed flush needed */
 #define TLB_NEED_LOCAL_FLUSH   0x1
 #define TLB_NEED_GLOBAL_FLUSH  0x2
-
 #endif
 
     /* Other registers */
@@ -1407,7 +1407,7 @@ struct CPUArchState {
 };
 
 #define PPC_CPU_HAS_CORE_SIBLINGS(cs)                           \
-    (cs->nr_threads > 1)
+    (POWERPC_CPU(cs)->env.has_smt_siblings)
 
 #define PPC_CPU_HAS_LPAR_SIBLINGS(cs)                           \
     ((POWERPC_CPU(cs)->env.flags & POWERPC_FLAG_SMT_1LPAR) &&   \
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 7d062ec16c..5364c55bbb 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -142,7 +142,7 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     CPUPPCState *env = &cpu->env;
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
     PnvChipClass *pnv_cc = PNV_CHIP_GET_CLASS(chip);
-    g_autofree uint32_t *servers_prop = g_new(uint32_t, smt_threads);
+    uint32_t *servers_prop;
     int i;
     uint32_t pir, tir;
     uint32_t segs[] = {cpu_to_be32(28), cpu_to_be32(40),
@@ -157,6 +157,14 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
 
     pnv_cc->processor_id(chip, pc->hwid, 0, &pir, &tir);
 
+    /* Only one DT node per (big) core */
+    if (tir != 0) {
+        g_assert(pc->big_core);
+        g_assert(tir == 1);
+        g_assert(pc->hwid & 1);
+        return -1;
+    }
+
     nodename = g_strdup_printf("%s@%x", dc->fw_name, pir);
     offset = fdt_add_subnode(fdt, cpus_offset, nodename);
     _FDT(offset);
@@ -236,12 +244,28 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     }
 
     /* Build interrupt servers properties */
-    for (i = 0; i < smt_threads; i++) {
-        pnv_cc->processor_id(chip, pc->hwid, i, &pir, &tir);
-        servers_prop[i] = cpu_to_be32(pir);
+    if (pc->big_core) {
+        servers_prop = g_new(uint32_t, smt_threads * 2);
+        for (i = 0; i < smt_threads; i++) {
+            pnv_cc->processor_id(chip, pc->hwid, i, &pir, &tir);
+            servers_prop[i * 2] = cpu_to_be32(pir);
+
+            pnv_cc->processor_id(chip, pc->hwid + 1, i, &pir, &tir);
+            servers_prop[i * 2 + 1] = cpu_to_be32(pir);
+        }
+        _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
+                          servers_prop, sizeof(*servers_prop) * smt_threads
+                                        * 2)));
+    } else {
+        servers_prop = g_new(uint32_t, smt_threads);
+        for (i = 0; i < smt_threads; i++) {
+            pnv_cc->processor_id(chip, pc->hwid, i, &pir, &tir);
+            servers_prop[i] = cpu_to_be32(pir);
+        }
+        _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
+                          servers_prop, sizeof(*servers_prop) * smt_threads)));
     }
-    _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
-                       servers_prop, sizeof(*servers_prop) * smt_threads)));
+    g_free(servers_prop);
 
     return offset;
 }
@@ -330,6 +354,8 @@ static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
         int offset;
 
         offset = pnv_dt_core(chip, pnv_core, fdt);
+        if (offset == -1)
+            continue;
 
         _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
                            pa_features_207, sizeof(pa_features_207))));
@@ -387,6 +413,8 @@ static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
         int offset;
 
         offset = pnv_dt_core(chip, pnv_core, fdt);
+        if (offset == -1)
+            continue;
 
         _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
                            pa_features_300, sizeof(pa_features_300))));
@@ -448,6 +476,8 @@ static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
         int offset;
 
         offset = pnv_dt_core(chip, pnv_core, fdt);
+        if (offset == -1)
+            continue;
 
         _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
                            pa_features_31, sizeof(pa_features_31))));
@@ -981,11 +1011,12 @@ static void pnv_init(MachineState *machine)
         machine->smp.max_cpus / (machine->smp.cores * machine->smp.threads);
 
     if (!is_power_of_2(machine->smp.threads)) {
-        error_report("Cannot support %d threads/core on a powernv"
+        error_report("Cannot support %d threads/core on a powernv "
                      "machine because it must be a power of 2",
                      machine->smp.threads);
         exit(1);
     }
+
     /*
      * TODO: should we decide on how many chips we can create based
      * on #cores and Venice vs. Murano vs. Naples chip type etc...,
@@ -1088,10 +1119,37 @@ static void pnv_power8_init(MachineState *machine)
 
 static void pnv_power9_init(MachineState *machine)
 {
-    if (machine->smp.threads > 8) {
-        error_report("Cannot support more than 8 threads/core "
-                     "on a powernv9/10 machine");
-        exit(1);
+    PnvMachineState *pnv = PNV_MACHINE(machine);
+
+    if (pnv->big_core) {
+        if (machine->smp.threads > 8) {
+            error_report("Cannot support more than 8 threads/core "
+                         "on a powernv9/10  machine");
+            exit(1);
+        }
+        if (machine->smp.threads % 2 == 1) {
+            error_report("Cannot support %d threads with big-core option "
+                         "because it must be an even number",
+                         machine->smp.threads);
+            exit(1);
+        }
+
+        /*
+         * powernv models PnvCore as a SMT4 core. Big-core requires 2xPnvCore
+         * per core, so adjust topology here. pnv_dt_core() processor
+         * device-tree and TCG SMT code make the 2 cores appear as one big core
+         * from software point of view. pnv pervasive models and xscoms tend to
+         * see the big core as 2 small core halves.
+         */
+        machine->smp.cores *= 2;
+        machine->smp.threads /= 2;
+    } else {
+        if (machine->smp.threads > 4) {
+            error_report("Cannot support more than 4 threads/core "
+                         "on a powernv9/10 small-core machine "
+                         "(use big-core=on for 8 threads per core)");
+            exit(1);
+        }
     }
 
     pnv_init(machine);
@@ -1099,6 +1157,8 @@ static void pnv_power9_init(MachineState *machine)
 
 static void pnv_power10_init(MachineState *machine)
 {
+    PnvMachineState *pnv = PNV_MACHINE(machine);
+    pnv->big_core_tbst_quirk = true;
     pnv_power9_init(machine);
 }
 
@@ -1169,9 +1229,15 @@ static void pnv_processor_id_p9(PnvChip *chip,
                                 uint32_t core_id, uint32_t thread_id,
                                 uint32_t *pir, uint32_t *tir)
 {
-    if (chip->nr_threads == 8) {
-        *pir = (chip->chip_id << 8) | ((thread_id & 1) << 2) | (core_id << 3) |
-               (thread_id >> 1);
+    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
+
+    if (pnv->big_core) {
+        /* Big-core interleaves thread ID between small-cores */
+        thread_id <<= 1;
+        thread_id |= core_id & 1;
+        core_id >>= 1;
+
+        *pir = (chip->chip_id << 8) | (core_id << 3) | thread_id;
     } else {
         *pir = (chip->chip_id << 8) | (core_id << 2) | thread_id;
     }
@@ -1193,9 +1259,15 @@ static void pnv_processor_id_p10(PnvChip *chip,
                                 uint32_t core_id, uint32_t thread_id,
                                 uint32_t *pir, uint32_t *tir)
 {
-    if (chip->nr_threads == 8) {
-        *pir = (chip->chip_id << 8) | ((core_id / 4) << 4) |
-                ((core_id % 2) << 3) | thread_id;
+    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
+
+    if (pnv->big_core) {
+        /* Big-core interleaves thread ID between small-cores */
+        thread_id <<= 1;
+        thread_id |= core_id & 1;
+        core_id >>= 1;
+
+        *pir = (chip->chip_id << 8) | (core_id << 3) | thread_id;
     } else {
         *pir = (chip->chip_id << 8) | (core_id << 2) | thread_id;
     }
@@ -2146,7 +2218,8 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
                                     &k->parent_realize);
 }
 
-static void pnv_chip_core_sanitize(PnvChip *chip, Error **errp)
+static void pnv_chip_core_sanitize(PnvMachineState *pnv, PnvChip *chip,
+                                   Error **errp)
 {
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
     int cores_max;
@@ -2167,6 +2240,17 @@ static void pnv_chip_core_sanitize(PnvChip *chip, Error **errp)
     }
     chip->cores_mask &= pcc->cores_mask;
 
+    /* Ensure small-cores a paired up in big-core mode */
+    if (pnv->big_core) {
+        uint64_t even_cores = chip->cores_mask & 0x5555555555555555ULL;
+        uint64_t odd_cores = chip->cores_mask & 0xaaaaaaaaaaaaaaaaULL;
+
+        if (even_cores ^ (odd_cores >> 1)) {
+            error_setg(errp, "warning: unpaired cores in big-core mode !");
+            return;
+        }
+    }
+
     /* now that we have a sane layout, let check the number of cores */
     cores_max = ctpop64(chip->cores_mask);
     if (chip->nr_cores > cores_max) {
@@ -2190,7 +2274,7 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
     }
 
     /* Cores */
-    pnv_chip_core_sanitize(chip, &error);
+    pnv_chip_core_sanitize(pnv, chip, &error);
     if (error) {
         error_propagate(errp, error);
         return;
@@ -2445,6 +2529,34 @@ static int pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
     return total_count;
 }
 
+static bool pnv_machine_get_big_core(Object *obj, Error **errp)
+{
+    PnvMachineState *pnv = PNV_MACHINE(obj);
+    return pnv->big_core;
+}
+
+static void pnv_machine_set_big_core(Object *obj, bool value, Error **errp)
+{
+    PnvMachineState *pnv = PNV_MACHINE(obj);
+    pnv->big_core = value;
+}
+
+static bool pnv_machine_get_hb(Object *obj, Error **errp)
+{
+    PnvMachineState *pnv = PNV_MACHINE(obj);
+
+    return !!pnv->fw_load_addr;
+}
+
+static void pnv_machine_set_hb(Object *obj, bool value, Error **errp)
+{
+    PnvMachineState *pnv = PNV_MACHINE(obj);
+
+    if (value) {
+        pnv->fw_load_addr = 0x8000000;
+    }
+}
+
 static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -2496,6 +2608,12 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
     pmc->dt_power_mgt = pnv_dt_power_mgt;
 
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
+
+    object_class_property_add_bool(oc, "big-core",
+                                   pnv_machine_get_big_core,
+                                   pnv_machine_set_big_core);
+    object_class_property_set_description(oc, "big-core",
+                              "Use big-core (aka fused-core) mode");
 }
 
 static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
@@ -2531,6 +2649,17 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
 
     pnv_machine_p10_common_class_init(oc, data);
     mc->desc = "IBM PowerNV (Non-Virtualized) POWER10";
+
+    /*
+     * This is the parent of POWER10 Rainier class, so properies go here
+     * rather than common init (which would add them to both parent and
+     * child which is invalid).
+     */
+    object_class_property_add_bool(oc, "big-core",
+                                   pnv_machine_get_big_core,
+                                   pnv_machine_set_big_core);
+    object_class_property_set_description(oc, "big-core",
+                              "Use big-core (aka fused-core) mode");
 }
 
 static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
@@ -2543,22 +2672,6 @@ static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
     pmc->i2c_init = pnv_rainier_i2c_init;
 }
 
-static bool pnv_machine_get_hb(Object *obj, Error **errp)
-{
-    PnvMachineState *pnv = PNV_MACHINE(obj);
-
-    return !!pnv->fw_load_addr;
-}
-
-static void pnv_machine_set_hb(Object *obj, bool value, Error **errp)
-{
-    PnvMachineState *pnv = PNV_MACHINE(obj);
-
-    if (value) {
-        pnv->fw_load_addr = 0x8000000;
-    }
-}
-
 static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
 {
     CPUPPCState *env = cpu_env(cs);
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 0f61aabb77..10417d92ae 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -58,6 +58,9 @@ static void pnv_core_cpu_reset(PnvCore *pc, PowerPCCPU *cpu)
     env->nip = 0x10;
     env->msr |= MSR_HVB; /* Hypervisor mode */
     env->spr[SPR_HRMOR] = pc->hrmor;
+    if (pc->big_core) {
+        env->spr[SPR_PVR] &= ~PPC_BIT(51); /* Clear "small core" bit */
+    }
     hreg_compute_hflags(env);
     ppc_maybe_interrupt(env);
 
@@ -252,7 +255,12 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
     pir_spr->default_value = pir;
     tir_spr->default_value = tir;
 
-    env->core_index = core_hwid;
+    if (pc->big_core) {
+        /* 2 "small cores" get the same core index for SMT operations */
+        env->core_index = core_hwid >> 1;
+    } else {
+        env->core_index = core_hwid;
+    }
 
     /* Set time-base frequency to 512 MHz */
     cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
@@ -271,6 +279,7 @@ static void pnv_core_reset(void *dev)
 
 static void pnv_core_realize(DeviceState *dev, Error **errp)
 {
+    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
     PnvCore *pc = PNV_CORE(OBJECT(dev));
     PnvCoreClass *pcc = PNV_CORE_GET_CLASS(pc);
     CPUCore *cc = CPU_CORE(OBJECT(dev));
@@ -282,14 +291,19 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
 
     assert(pc->chip);
 
+    pc->big_core = pnv->big_core;
+    pc->pnv_tod_tbst.big_core_quirk = pnv->big_core_tbst_quirk;;
+
     pc->threads = g_new(PowerPCCPU *, cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
         PowerPCCPU *cpu;
 
         obj = object_new(typename);
         cpu = POWERPC_CPU(obj);
-
-        pc->threads[i] = POWERPC_CPU(obj);
+        pc->threads[i] = cpu;
+        if (cc->nr_threads > 1) {
+            cpu->env.has_smt_siblings = true;
+        }
 
         snprintf(name, sizeof(name), "thread[%d]", i);
         object_property_add_child(OBJECT(pc), name, obj);
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 059d372c8a..05195527a5 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -312,12 +312,16 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
      * and the rest are explicitly started up by the guest using an RTAS call.
      */
     qdev_prop_set_bit(DEVICE(obj), "start-powered-off", true);
-    env->core_index = cc->core_id;
     cs->cpu_index = cc->core_id + i;
     if (!spapr_set_vcpu_id(cpu, cs->cpu_index, errp)) {
         return NULL;
     }
 
+    env->core_index = cc->core_id;
+    if (cs->nr_threads > 1) {
+        env->has_smt_siblings = true;
+    }
+
     cpu->node_id = sc->node_id;
 
     id = g_strdup_printf("thread[%d]", i);
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 598c956cdd..1d56d8f85f 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -323,7 +323,11 @@ target_ulong helper_load_sprd(CPUPPCState *env)
              * prefer to get unimplemented message on POWER10 if it were
              * used.
              */
-            return 0;
+            if (pc->big_core) {
+                return PPC_BIT(63);
+            } else {
+                return 0;
+            }
         }
         /* fallthru */
     default:
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index abe7b95696..6163d4ecb3 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -20,6 +20,7 @@
 #include "cpu.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/pnv_core.h"
+#include "hw/ppc/pnv_chip.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "qemu/log.h"
@@ -297,6 +298,14 @@ static struct pnv_tod_tbst *cpu_get_tbst(PowerPCCPU *cpu)
 {
     PnvCore *pc = pnv_cpu_state(cpu)->core;
 
+    if (pc->big_core && pc->pnv_tod_tbst.big_core_quirk) {
+        /* Must operate on the even small core */
+        int core_id = CPU_CORE(pc)->core_id;
+        if (core_id & 1) {
+            pc = pc->chip->cores[core_id & ~1];
+        }
+    }
+
     return &pc->pnv_tod_tbst;
 }
 
-- 
2.43.0


