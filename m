Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CD3C3DA4D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSF10-0002eE-2F; Fri, 12 Jul 2024 08:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSF0x-0002EU-BN; Fri, 12 Jul 2024 08:04:40 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSF0m-0005qL-JL; Fri, 12 Jul 2024 08:04:37 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70b42250526so1515821b3a.1; 
 Fri, 12 Jul 2024 05:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720785865; x=1721390665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SnBixgNCZR5umEUBDPQD9xrONIImNH7KH0Dw6R9WoY0=;
 b=gvZAOFj6gnA+Uq0fQUYniX/HFImQv3t5QRp2bzbMflp1WPwECkWZsF9BrjQ2ic288A
 /4d+Otpsn3XEtq9kWtR1PRCF2OW7BV8yd8OyYebZOerNgN0akFCwKxv6B/RLGoknjb+V
 YscLlc/28KkeRgvuodW0zuHRKeFAgHphP6lTmZDtL9fHJs4CBghuEfLyliZCNMrhLUvI
 CXq44X4GNJhQ6axUz7AOX5XeGfwd+ti3ScxFgv75WjCwJS5VhjoyBT1L5ohoKedRWVU5
 v0i1ljo6VnPtJq4FVpCfz4wu0IS/2Ajhk4v1CeFUh3T+XyUdIn156hbJy2rRYeGziVBr
 thDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720785865; x=1721390665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SnBixgNCZR5umEUBDPQD9xrONIImNH7KH0Dw6R9WoY0=;
 b=PBRgDqHOaiOD5okImaKJqOawJ/513tgo9hX7UtAKnliBxYzb69H1zl+OdM45jq7K9J
 5w1EsFNykoZjdSYN2EqB5QC6mElInQT5XRBaN5DwTX1SAL5H29z238+0btu8FuHrvB8o
 3xSF4yxgDXvuiHaYoUmzoKEttEGJMMq1eEkadKzVqlo0Gq9HTP5xV51tdPM3aHJtm3RB
 PoHU7iIS7skQ7UwALmLS0tNcUbQlZSbBM3koVj0MISAiFqAjeVdko4F3PT5b8PjstvCb
 FHVRMzwZu4HXVY6C+AWT9Ghnjdhj8njICvlUjKpLPAb28sr9mC8wX3e5dxzcDSL9n82S
 Y3+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzzXlrRmjaqWb691Jw4jVNWAU+GCV6dvPJlJJnKJfYi34/HblAYrwgWFNJkZbGYW+vV2+mN8HcQKzR8+BhTGYBMEwC3o8=
X-Gm-Message-State: AOJu0YyyLo8/HK4pfiGSUQMJp+8ugfxP6PO14vlJO06X9Q+hfsmLCanH
 FVg5Z+vOa8sPHjg6oZJj6p8HgLvfzHmmcEk7UlWLOeqZCqtr5i0S4uGy5w==
X-Google-Smtp-Source: AGHT+IGS0tPCjl7Wg1M5TBfg7AKkIF/WLSCuxuBlRiwFP9hOAWkrZzs7T5rfgnnuPv8PPbavjksP4Q==
X-Received: by 2002:a05:6a00:2e27:b0:706:6824:9c53 with SMTP id
 d2e1a72fcca58-70b435412b1mr13544838b3a.10.1720785865198; 
 Fri, 12 Jul 2024 05:04:25 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438c0a1csm7308967b3a.63.2024.07.12.05.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 05:04:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 14/19] ppc/pnv: Add POWER10 ChipTOD quirk for big-core
Date: Fri, 12 Jul 2024 22:02:41 +1000
Message-ID: <20240712120247.477133-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240712120247.477133-1-npiggin@gmail.com>
References: <20240712120247.477133-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

POWER10 has a quirk in its ChipTOD addressing that requires the even
small-core to be selected even when programming the odd small-core.
This allows skiboot chiptod init to run in big-core mode.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv.h         | 1 +
 include/hw/ppc/pnv_core.h    | 7 +++++++
 hw/ppc/pnv.c                 | 7 ++++++-
 target/ppc/timebase_helper.c | 9 +++++++++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 283ddd50e7..c56d152889 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -77,6 +77,7 @@ struct PnvMachineClass {
     const char *compat;
     int compat_size;
     int max_smt_threads;
+    bool quirk_tb_big_core;
 
     void (*dt_power_mgt)(PnvMachineState *pnv, void *fdt);
     void (*i2c_init)(PnvMachineState *pnv);
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 50164e9e1f..c8784777a4 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -27,6 +27,13 @@
 
 /* Per-core ChipTOD / TimeBase state */
 typedef struct PnvCoreTODState {
+    /*
+     * POWER10 DD2.0 - big core TFMR drives the state machine on the even
+     * small core. Skiboot has a workaround that targets the even small core
+     * for CHIPTOD_TO_TB ops.
+     */
+    bool big_core_quirk;
+
     int tb_ready_for_tod; /* core TB ready to receive TOD from chiptod */
     int tod_sent_to_tb;   /* chiptod sent TOD to the core TB */
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index fdf66323b8..24f7c007ce 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2288,11 +2288,12 @@ static void pnv_chip_core_sanitize(PnvMachineState *pnv, PnvChip *chip,
 
 static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
 {
+    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
+    PnvMachineClass *pmc = PNV_MACHINE_GET_CLASS(pnv);
     Error *error = NULL;
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
     const char *typename = pnv_chip_core_typename(chip);
     int i, core_hwid;
-    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
 
     if (!object_class_by_name(typename)) {
         error_setg(errp, "Unable to find PowerNV CPU Core '%s'", typename);
@@ -2335,6 +2336,9 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
                                 &error_fatal);
         object_property_set_link(OBJECT(pnv_core), "chip", OBJECT(chip),
                                  &error_abort);
+
+        pnv_core->tod_state.big_core_quirk = pmc->quirk_tb_big_core;
+
         qdev_realize(DEVICE(pnv_core), NULL, &error_fatal);
 
         /* Each core has an XSCOM MMIO region */
@@ -2647,6 +2651,7 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
     pmc->max_smt_threads = 4;
+    pmc->quirk_tb_big_core = true;
     pmc->dt_power_mgt = pnv_dt_power_mgt;
 
     xfc->match_nvt = pnv10_xive_match_nvt;
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 44cacf065e..019b8ee41f 100644
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
@@ -297,6 +298,14 @@ static PnvCoreTODState *cpu_get_tbst(PowerPCCPU *cpu)
 {
     PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
 
+    if (pc->big_core && pc->tod_state.big_core_quirk) {
+        /* Must operate on the even small core */
+        int core_id = CPU_CORE(pc)->core_id;
+        if (core_id & 1) {
+            pc = pc->chip->cores[core_id & ~1];
+        }
+    }
+
     return &pc->tod_state;
 }
 
-- 
2.45.1


