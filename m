Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AF7C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRudv-0003pB-5L; Thu, 11 Jul 2024 10:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRuds-0003hs-PT; Thu, 11 Jul 2024 10:19:28 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRudr-0005UD-1X; Thu, 11 Jul 2024 10:19:28 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70af0684c2bso743685b3a.0; 
 Thu, 11 Jul 2024 07:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720707565; x=1721312365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E8FfYVZLhfQmqykNToV7464fETgc8v1WopuhnlmN23k=;
 b=gzNOIcNZD0Go/3ejyaBzMrwe1/vnoH1imM/TER8RxMlerDqQzSH0ksfZeTsLFijlge
 epV14ZGFRdekCHAHPdrmOJlA/P/cSRsTBg8kMp6z2164I2vRzgSXzv7QPcXxCkg902FQ
 9RUSHm1hOfEJNpwkOoe0ZrySkd9pUJ1AA/TzWuO7d1ZCc3sjGy/y8gsJdXT9+vSUpIyT
 4p07hSSFHl+nhgUwTVZTyx/elBREeoFbI27zuE2vq0fxMU8jOX690cWtNodQyfR6svzR
 H4+ivlNqkznMWsGSvf5I94+Yf3VdgmX20cir18prMb/HqKej3XhV1qatvLBMXBBVwrW1
 oeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720707565; x=1721312365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E8FfYVZLhfQmqykNToV7464fETgc8v1WopuhnlmN23k=;
 b=G48fwlePKN14g37CxfEMXKXsI3q4cexgb2vwoBTvNXlWSaoPY1fbYOkpowSBLZCjvU
 Mx1IlnjGlazpVvS0SlR5fhmWzFsDkF6TeANvJxzk87vAOeZC6nHQmNN9LF9Imo+AWHEg
 nab5shjj8dGXTq++8b617ZpXvPsaIGl8+zoAn86wkhmR0glrSy9n0F/lkMmaktxjmFGN
 UXMb8SOWKdxY+fzyegF8I01xmmVedhYQucKKNS/r31O6Ow9IK/3TW9ED2vTqnVOWaoZJ
 4YbH+JIe9XgoCLumr5o6AOp7bl9qwZoS6XoeCyE/j2U3hI99ttZ16nmwNy3c/NRn3ccY
 NE5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPSCNUGcGRaaWZmCeAGXkyssU1hEkS2rx9xNNZ3uIKPbAwvpV1myKyHd8XX42M2HJFBfokx3sgvbix/vYRDxAGj+JK6FM=
X-Gm-Message-State: AOJu0Yz4MjITyCbW5+Ho2r/T6USkC5nbNIH90fvHFT1uNMVJwCBRiWg2
 MDIOT0x27rhE6AkNGHll2YRnk/ASBDhuSAimsMXQ6SUOhyuDw+Mh7DkkP0ft
X-Google-Smtp-Source: AGHT+IEmhuqmMLysUrr4i8UMZ8S/BOJHlLE1G5ubnC9v6rwXi6K4QXnamm6hLHOMQy5ctPrhqO2qJg==
X-Received: by 2002:a05:6a21:680d:b0:1c2:8fd1:a47d with SMTP id
 adf61e73a8af0-1c29820396amr9982671637.6.1720707564671; 
 Thu, 11 Jul 2024 07:19:24 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b54ec730fsm3308904b3a.173.2024.07.11.07.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 07:19:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 06/18] ppc/pnv: specialise init for powernv8/9/10 machines
Date: Fri, 12 Jul 2024 00:18:38 +1000
Message-ID: <20240711141851.406677-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240711141851.406677-1-npiggin@gmail.com>
References: <20240711141851.406677-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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

This will allow different settings and checks for different
machine types with later changes.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv.h |  1 +
 hw/ppc/pnv.c         | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 476b136146..1993dededf 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -76,6 +76,7 @@ struct PnvMachineClass {
     /*< public >*/
     const char *compat;
     int compat_size;
+    int max_smt_threads;
 
     void (*dt_power_mgt)(PnvMachineState *pnv, void *fdt);
     void (*i2c_init)(PnvMachineState *pnv);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 3bcf11984c..4252bcd28d 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -899,6 +899,7 @@ static void pnv_init(MachineState *machine)
     PnvMachineState *pnv = PNV_MACHINE(machine);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     PnvMachineClass *pmc = PNV_MACHINE_GET_CLASS(machine);
+    int max_smt_threads = pmc->max_smt_threads;
     char *fw_filename;
     long fw_size;
     uint64_t chip_ram_start = 0;
@@ -997,17 +998,19 @@ static void pnv_init(MachineState *machine)
     pnv->num_chips =
         machine->smp.max_cpus / (machine->smp.cores * machine->smp.threads);
 
-    if (machine->smp.threads > 8) {
-        error_report("Cannot support more than 8 threads/core "
-                     "on a powernv machine");
+    if (machine->smp.threads > max_smt_threads) {
+        error_report("Cannot support more than %d threads/core "
+                     "on %s machine", max_smt_threads, mc->desc);
         exit(1);
     }
+
     if (!is_power_of_2(machine->smp.threads)) {
         error_report("Cannot support %d threads/core on a powernv"
                      "machine because it must be a power of 2",
                      machine->smp.threads);
         exit(1);
     }
+
     /*
      * TODO: should we decide on how many chips we can create based
      * on #cores and Venice vs. Murano vs. Naples chip type etc...,
@@ -2491,6 +2494,7 @@ static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
 
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
+    pmc->max_smt_threads = 8;
 
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
 }
@@ -2515,6 +2519,7 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
 
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
+    pmc->max_smt_threads = 4;
     pmc->dt_power_mgt = pnv_dt_power_mgt;
 
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
@@ -2539,6 +2544,7 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
 
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
+    pmc->max_smt_threads = 4;
     pmc->dt_power_mgt = pnv_dt_power_mgt;
 
     xfc->match_nvt = pnv10_xive_match_nvt;
-- 
2.45.1


