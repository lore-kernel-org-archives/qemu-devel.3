Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD01CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 08:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB7yU-0008O9-9o; Tue, 21 Oct 2025 04:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7yR-0008MV-Fk
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:44:07 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7yO-0000ux-MN
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:44:07 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so34533455e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 01:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761036243; x=1761641043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wkrg0aZa1WjauUtDHq9tPYBBcjWPVRSRJlbYYy68XEA=;
 b=a1FTyJL8wN3r1alBekCSHXPzLjh+sBafWwdDe50j/FdjCeOEOz8GFavJQCn3/QCRM/
 ll9yH4EL2nuUtH+VXuRdta9dlyWAVBT63RDYuiXyuMMACsdrsE51fYO2KOJNlnISIV/S
 9lO9KdWazf7yowVtMijPNDdhoxOlC9/CcgoDlHdesmwKeHCj6b4XXNK+9YXsUpqRCrwk
 pk1xGuPaYrbqBYUrALHcX6QOBRJlkmsAjYCmIQ0WBG4EjB8cPWBJAHnFoLs4AGxQRA7X
 3lTwwQG4UqI43mXVAitcELxWW3yTSUUkC5KJsgZ791z14tk205L4ThTJ4xW3r1R6debm
 XtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761036243; x=1761641043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wkrg0aZa1WjauUtDHq9tPYBBcjWPVRSRJlbYYy68XEA=;
 b=dVo3dsGrwcH2ED60klY2GThr44Kb5DIgsWIhgYcRADAlzGdmSRAoUTTRm5o/rherhI
 1JK4I/2YOInAppXBDsVncs6c93C24yZ0UXWeVXQgD663G0umRTQtFq+xP0gmLwW1oQC0
 vbkRPE/XjscPQzX8QGUIYsKV8H8jMfmj8lVghLjZiW89Lf47dbiT6xmi/lHn5WBzKX3x
 0DjbWROIPBqrVtvNd/l0OUaOwJeyiKLD6GDRusyeWQcyE/U/mTT0lg2U05/ZzR4i476E
 B/7gpffSGkdFboPEk8oR66ftzQJOHvgS4zwc69F9FDLaB7F3/sxT+A6WxSz84OuXVDxW
 hawg==
X-Gm-Message-State: AOJu0Yx8NFDBerV99wGvB7GIG4DgwdDx352c/CsSb7Plua3o+3l5izJY
 mq75ngTY3v20gAtlDWPHKtFtuLlwY8YTvcjGgm1qANV1MNEMD39X7I/Vmi/LI4b6qBQQSUNFeS+
 vYbX5BbQ=
X-Gm-Gg: ASbGncvho7ziwlBtUa9StLNxg9oM8T3gWB9E3rTig9sXPjwavSfzZ0CmAEYzXhfx8UK
 DyT2GJmy+3/gsNJvZdH6JhlDSF38uB/T6FkldkDWV33mdzSuAc4N+PCGCe16su/Y4poctfVUuHt
 pnN0vRhgR5Z+runchXcvrt2BkrMQBIIa8TS0aS+1CRo2U46MUqwQBZtxiDkgDic/yXtZy3VEAi7
 TSA/o+JBHt+H8cuk+KTCpnOGKPcRYDKTxNXXoJFD3CoexGqb/IVm9NMR9hEdCKbjHN7z5qphlJO
 UXH+BCcAMU0nGTcoro0RKp4BLFdyVJPbxKRXmTaw2izB8055qnDdW9KgoidySesTb7+F+2eMhUV
 Jl5RJn3ft9RBHqaD2wTyhbT0yJJKDwPUN6HkEveQmdUmRVth0/dC+3UAdVQIx0edhbA15KZQxpT
 DGHG0YSoNtp42uuJlPGu6Lrm8B/pR/cFOMYoaDaXUvVD/9ulgesQmGMfppc9Lm
X-Google-Smtp-Source: AGHT+IFirZECNQbu8fTMpQHw/i7BErvqCsfDdrQA40bf/Y4sMvLQvdzRegS8xxtTQnqeKY56pJvjEg==
X-Received: by 2002:a05:600c:4f95:b0:46e:345d:dfde with SMTP id
 5b1f17b1804b1-471178ac017mr105182205e9.16.1761036242592; 
 Tue, 21 Oct 2025 01:44:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4715520dd65sm181550785e9.15.2025.10.21.01.44.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 01:44:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/11] ppc/spapr: remove deprecated machine pseries-3.1
Date: Tue, 21 Oct 2025 10:43:37 +0200
Message-ID: <20251021084346.73671-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021084346.73671-1-philmd@linaro.org>
References: <20251021084346.73671-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

pseries-3.1 had been deprecated and due for removal now as per policy.
Also remove backward compatibility flags and related code introduced for
pre pseries-4.0 machines.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr.h |  3 --
 hw/ppc/spapr.c         | 62 ++++--------------------------------------
 hw/ppc/spapr_hcall.c   |  5 ----
 3 files changed, 5 insertions(+), 65 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 494367fb99a..1db67784de8 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -143,9 +143,6 @@ struct SpaprMachineClass {
     MachineClass parent_class;
 
     /*< public >*/
-    bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHBs */
-    bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
-    bool broken_host_serial_model; /* present real host info to the guest */
     bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
     bool linux_pci_probe;
     bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b5d20bc1756..458d1c29b4d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1182,7 +1182,6 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
 {
     MachineState *machine = MACHINE(spapr);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
     uint32_t root_drc_type_mask = 0;
     int ret;
     void *fdt;
@@ -1213,16 +1212,10 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
     /* Host Model & Serial Number */
     if (spapr->host_model) {
         _FDT(fdt_setprop_string(fdt, 0, "host-model", spapr->host_model));
-    } else if (smc->broken_host_serial_model && kvmppc_get_host_model(&buf)) {
-        _FDT(fdt_setprop_string(fdt, 0, "host-model", buf));
-        g_free(buf);
     }
 
     if (spapr->host_serial) {
         _FDT(fdt_setprop_string(fdt, 0, "host-serial", spapr->host_serial));
-    } else if (smc->broken_host_serial_model && kvmppc_get_host_serial(&buf)) {
-        _FDT(fdt_setprop_string(fdt, 0, "host-serial", buf));
-        g_free(buf);
     }
 
     _FDT(fdt_setprop_cell(fdt, 0, "#address-cells", 2));
@@ -1260,9 +1253,8 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
 
     /* ibm,drc-indexes and friends */
     root_drc_type_mask |= SPAPR_DR_CONNECTOR_TYPE_LMB;
-    if (smc->dr_phb_enabled) {
-        root_drc_type_mask |= SPAPR_DR_CONNECTOR_TYPE_PHB;
-    }
+    root_drc_type_mask |= SPAPR_DR_CONNECTOR_TYPE_PHB;
+
     if (mc->nvdimm_supported) {
         root_drc_type_mask |= SPAPR_DR_CONNECTOR_TYPE_PMEM;
     }
@@ -2063,9 +2055,7 @@ static const VMStateDescription vmstate_spapr_irq_map = {
 
 static bool spapr_dtb_needed(void *opaque)
 {
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(opaque);
-
-    return smc->update_dt_enabled;
+    return true; /* backward migration compat */
 }
 
 static int spapr_dtb_pre_load(void *opaque)
@@ -3009,10 +2999,8 @@ static void spapr_machine_init(MachineState *machine)
      * connectors for a PHBs PCI slots) are added as needed during their
      * parent's realization.
      */
-    if (smc->dr_phb_enabled) {
-        for (i = 0; i < SPAPR_MAX_PHBS; i++) {
-            spapr_dr_connector_new(OBJECT(machine), TYPE_SPAPR_DRC_PHB, i);
-        }
+    for (i = 0; i < SPAPR_MAX_PHBS; i++) {
+        spapr_dr_connector_new(OBJECT(machine), TYPE_SPAPR_DRC_PHB, i);
     }
 
     /* Set up PCI */
@@ -4095,11 +4083,6 @@ static bool spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     const unsigned windows_supported = spapr_phb_windows_supported(sphb);
     SpaprDrc *drc;
 
-    if (dev->hotplugged && !smc->dr_phb_enabled) {
-        error_setg(errp, "PHB hotplug not supported for this machine");
-        return false;
-    }
-
     if (sphb->index == (uint32_t)-1) {
         error_setg(errp, "\"index\" for PAPR PHB is mandatory");
         return false;
@@ -4125,16 +4108,10 @@ static bool spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
 static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
 {
-    SpaprMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(dev);
     SpaprDrc *drc;
     bool hotplugged = spapr_drc_hotplugged(dev);
 
-    if (!smc->dr_phb_enabled) {
-        return;
-    }
-
     drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->index);
     /* hotplug hooks should check it's enabled before getting this far */
     assert(drc);
@@ -4260,7 +4237,6 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
 {
     SpaprMachineState *sms = SPAPR_MACHINE(OBJECT(hotplug_dev));
     MachineClass *mc = MACHINE_GET_CLASS(sms);
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         if (spapr_memory_hot_unplug_supported(sms)) {
@@ -4275,10 +4251,6 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
         }
         spapr_core_unplug_request(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
-        if (!smc->dr_phb_enabled) {
-            error_setg(errp, "PHB hot unplug not supported on this machine");
-            return;
-        }
         spapr_phb_unplug_request(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_TPM_PROXY)) {
         spapr_tpm_proxy_unplug(hotplug_dev, dev);
@@ -4634,7 +4606,6 @@ static void spapr_machine_class_init(ObjectClass *oc, const void *data)
     hc->unplug_request = spapr_machine_device_unplug_request;
     hc->unplug = spapr_machine_device_unplug;
 
-    smc->update_dt_enabled = true;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
     mc->has_hotpluggable_cpus = true;
     mc->nvdimm_supported = true;
@@ -4688,7 +4659,6 @@ static void spapr_machine_class_init(ObjectClass *oc, const void *data)
     smc->default_caps.caps[SPAPR_CAP_AIL_MODE_3] = SPAPR_CAP_ON;
     spapr_caps_add_properties(smc);
     smc->irq = &spapr_irq_dual;
-    smc->dr_phb_enabled = true;
     smc->linux_pci_probe = true;
     smc->smp_threads_vsmt = true;
     xfc->match_nvt = spapr_match_nvt;
@@ -5032,28 +5002,6 @@ static void spapr_machine_4_0_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(4, 0);
 
-/*
- * pseries-3.1
- */
-static void spapr_machine_3_1_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-
-    spapr_machine_4_0_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_len);
-
-    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
-    smc->update_dt_enabled = false;
-    smc->dr_phb_enabled = false;
-    smc->broken_host_serial_model = true;
-    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
-    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
-    smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
-    smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_OFF;
-}
-
-DEFINE_SPAPR_MACHINE(3, 1);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8c1e0a4817b..8f03b3e7764 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1475,16 +1475,11 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, SpaprMachineState *spapr,
     target_ulong dt = ppc64_phys_to_real(args[0]);
     struct fdt_header hdr = { 0 };
     unsigned cb;
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     void *fdt;
 
     cpu_physical_memory_read(dt, &hdr, sizeof(hdr));
     cb = fdt32_to_cpu(hdr.totalsize);
 
-    if (!smc->update_dt_enabled) {
-        return H_SUCCESS;
-    }
-
     /* Check that the fdt did not grow out of proportion */
     if (cb > spapr->fdt_initial_size * 2) {
         trace_spapr_update_dt_failed_size(spapr->fdt_initial_size, cb,
-- 
2.51.0


