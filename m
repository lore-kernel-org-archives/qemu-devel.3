Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF52C3DA5D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTl2S-000389-HP; Tue, 16 Jul 2024 12:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1f-0007RV-Mi; Tue, 16 Jul 2024 12:27:40 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1b-0006dX-Bs; Tue, 16 Jul 2024 12:27:39 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70cdc91b227so449691b3a.2; 
 Tue, 16 Jul 2024 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721147241; x=1721752041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CFw001e7GD8WEMem20VntnHs8lxAIjbQ2/80VeZWCz4=;
 b=XV9Qs9ZO0Q/3TLIqOwU01tSWA25uWYR+LRXMy/gQQAUUesgI0XB73TaDMITS4pbgw8
 AP/9yjAQgKvCPzsH1SD2e3frCyAtMpRlA+gu9I6eNof7NstTTWIog09q5zlAmHl8A8C+
 /+nbgAVfLHC/cies8NjHLiwf6Eu8xh2q99wWCobnhZYSe80JyvZkZkJ8OZ890peElNcn
 pA3uYq5SNF/a0IJ31Vb5ud19ScpXJmqjNMBuLWVURBs+F3reNYe54SeX4EopiLfPZe9C
 CVkocLE6zEAbF9b/v5HFmxjJZclPimFOr5sMUWfjepeSy6OdyVUhnj66n1bPr0HWY5qv
 4QYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721147241; x=1721752041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CFw001e7GD8WEMem20VntnHs8lxAIjbQ2/80VeZWCz4=;
 b=V4CriB0G/toYN4q5KUsywCvgwRrKiSzURoyZwYWH9uWjaNvN9ahGUxhQezHnR//pJL
 eR8Ubc9XyqUdjQUQzX9L/BNRTKup758od1xau+ZKzu2I6auQZk0cxezGrekaT0wcvYml
 BD+CioFzJYsGi4P+E6QvmbWUDyJ0WpOtSX2jHLx68+VrAzpg1QOyXRWy6etQSH+Yx4lw
 z5nKp3Visf4qEGGnIC3WUG9g9rMasJzgMDscKeIrGSTM1/s9IIUyu0EMzLDhWcsvLW+3
 Zs+Fh+G6gXau2tV7VjxGpr/0LNlza8EzPsFPq4fc7eZz9QOu3Uo+c2I+CU+l0BGjJal4
 zJNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOl/wFP+eHj2GobBi7pfIZUHTEO49GylcJQ52T9ZANkRdInNQwtZUyG/tFaS77b0BD2uVzkdY4fGs5Sy0P5VIjB62MjWE=
X-Gm-Message-State: AOJu0Yx3/lJpwkrrhc4IVdZfhSL7/8mgLBU3/fW/EhzlWQBk/hs3lZA6
 qvu4/nOu9nq5HGrIWEmkGgagarSrHQtbRM08qbPlhG8Y+bdR35USYkkUjw==
X-Google-Smtp-Source: AGHT+IHJ8Lgkvexh+kbDIxR+lTp85v4LVe9wJZMycbu3OE/wnfLFbFqjH+GdRrkBHFOFirJ3MvBJYw==
X-Received: by 2002:a05:6a00:10c5:b0:706:4889:960d with SMTP id
 d2e1a72fcca58-70c1fbdef6cmr4240437b3a.16.1721147240939; 
 Tue, 16 Jul 2024 09:27:20 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca86d6sm6722161b3a.179.2024.07.16.09.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 09:27:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 15/19] ppc/pnv: Add big-core machine property
Date: Wed, 17 Jul 2024 02:26:11 +1000
Message-ID: <20240716162617.32161-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240716162617.32161-1-npiggin@gmail.com>
References: <20240716162617.32161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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
 hw/ppc/pnv.c | 61 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 322ab9073b..08aaac359b 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2581,6 +2581,34 @@ static int pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
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
@@ -2632,6 +2660,12 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
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
@@ -2668,6 +2702,17 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
 
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
@@ -2680,22 +2725,6 @@ static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
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
-- 
2.45.1


