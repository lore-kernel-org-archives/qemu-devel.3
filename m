Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A088C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSF0w-0002GP-Kl; Fri, 12 Jul 2024 08:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSF0s-0001rp-RI; Fri, 12 Jul 2024 08:04:35 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSF0q-0005qz-Ar; Fri, 12 Jul 2024 08:04:34 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70b5117ae06so1438518b3a.2; 
 Fri, 12 Jul 2024 05:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720785869; x=1721390669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ILljuqyS396GZphJq1/X7QybV+ipPMbO/Gt67zfSb9g=;
 b=YknrTA2yt1vk11J6oJaaFsja/rJCqJXfH+gXZ3cQYsdzHGY+gPPAH2MiLihkOQpGC0
 G8mw6ViRkYpT0SEXK+CKjKhpP9ukwiE9ka1l1ziVCoG9yQXTABU9y5JHh6QhLDxnDUp6
 doyF8FWM6ckfQRyxmLrTYj1TzIL1CVB2QPmwNefoKXVcLjiOJx4uUvsxqXHysuyaRfYx
 l50J70KZaFTlH3/yHydKzj8njHf2VMXkNVeZPHWkAMVSSnoonRpQOn272ZD+w2NfQFeq
 JHb8ZjthV7WxKAvzHTuGYLHbJBHigmPr+pn+hVkDkzvTZUsxPTZhQY7vqU6wukU9aSa6
 GV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720785869; x=1721390669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ILljuqyS396GZphJq1/X7QybV+ipPMbO/Gt67zfSb9g=;
 b=akmHN7ek5I6unQ9geLqmA6MG2hNTiGs4eUI399msqkmoAHIRNSGILq/GPp2z9vHJKQ
 KOVg32jts830EHIGgrriI6imKz+S57AZ6lK401VrFBWkaKNXY+eEU47c9sLr4ZpWZxSo
 EorzSDxvGdaXV8NyOk/RTRhFQ60nXzu64raD676I/KmAULarzgW3yXFivXtiv0nIhnKw
 viCsW4FnmkJVGT1sxYq7GFDXnqb9qcQpr9lsiZ4j312RzTsSsXeuucUDqvA1V51NAm9e
 VeE7EZGehH0mEnlg2IAroAxn8vBusPk9jLippo/85a1hFBF4Clq0B/qO0yRpWoMgcYnx
 MpdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUvHSVD50TK1yOubOK77dtVaAwVaTcPJW4sDDbWibB09SxgqsCm2ZinOw1OSIX1llWpKWcDs75ukKCf2VeHsaqZlPHWGg=
X-Gm-Message-State: AOJu0YzoGvFiIWG1fAqyT908f5wsQKH0/ZcFgXEh//jzd4caz5OivVR5
 5u73rr6sN1mfaW+KmlQlH6pHVuVJAKxKFNBGK09p3l0cWKscMkhvyb/f5A==
X-Google-Smtp-Source: AGHT+IFI6O177iKhevZC9TLsNEh/QLd0R6MrsRqhDKWHnTq2sivtgSjB7Hs7OAl2C4agzL2wqW3axg==
X-Received: by 2002:a05:6a00:140d:b0:70b:1d25:c844 with SMTP id
 d2e1a72fcca58-70b43544188mr13320260b3a.14.1720785868769; 
 Fri, 12 Jul 2024 05:04:28 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438c0a1csm7308967b3a.63.2024.07.12.05.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 05:04:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 15/19] ppc/pnv: Add big-core machine property
Date: Fri, 12 Jul 2024 22:02:42 +1000
Message-ID: <20240712120247.477133-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240712120247.477133-1-npiggin@gmail.com>
References: <20240712120247.477133-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

Big-core implementation is complete, so expose it as a machine
property that may be set with big-core=on option on powernv9 and
powernv10 machines.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c      | 62 +++++++++++++++++++++++++++++++++++------------
 hw/ppc/pnv_core.c |  2 +-
 2 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 24f7c007ce..e405d416ff 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2338,6 +2338,7 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
                                  &error_abort);
 
         pnv_core->tod_state.big_core_quirk = pmc->quirk_tb_big_core;
+        pnv_core->big_core = chip->big_core;
 
         qdev_realize(DEVICE(pnv_core), NULL, &error_fatal);
 
@@ -2578,6 +2579,34 @@ static int pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
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
@@ -2629,6 +2658,12 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
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
@@ -2665,6 +2700,17 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
 
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
@@ -2677,22 +2723,6 @@ static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
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
index a96ec4e2b9..238a4cd4ab 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -296,7 +296,7 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
         obj = object_new(typename);
         cpu = POWERPC_CPU(obj);
 
-        pc->threads[i] = POWERPC_CPU(obj);
+        pc->threads[i] = cpu;
         if (cc->nr_threads > 1) {
             cpu->env.has_smt_siblings = true;
         }
-- 
2.45.1


