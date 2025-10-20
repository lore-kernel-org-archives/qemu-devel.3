Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD20ACCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnIr-0001DB-Cl; Mon, 20 Oct 2025 06:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnI9-0000n4-RF
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:39:07 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnI7-0000Gv-Gz
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:39:05 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b85so5701193f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956741; x=1761561541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6xuVM3VBVeU3OiQAywkIH3HRIqyaSbIK3vlGaxdyGbI=;
 b=gboSN8lq6DqWD7cY8um0znb7tdv0MC1FE3bxZGE3dsOPbWXyn8d4y/bjKXDXNvAx5H
 NfFFQSyhGU7i9Scbo8zUnz+e+7Kuac7vUyR5VHl/4xMWCv0NP5EhjKyvPHfki0DPte3k
 Wiu/KXN4q0u/ujHaTIw3XoEd745/m4Gb1saH3alwKA0k6/KCz8tkd82jx9vTKGAvf4TP
 6uOb4UcrQrL36nxafJlfuXdpl9fCzF3rRjwX9JSH2SGvODYKA8/Wre9xq6arhM9X/lvQ
 GR8Nyz7patmPv6goJKNgQH/FvCGFTjDgIbmc5AlT6HbxyL9AbKRihvAH2FqGbbsExSxD
 CI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956741; x=1761561541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6xuVM3VBVeU3OiQAywkIH3HRIqyaSbIK3vlGaxdyGbI=;
 b=Ho14ZA3KxPemnC+LFHRvdTGfQoBOTWQvZu8aWqdWEsjEE5S+EIe4X4ycjWzgusg9pL
 o0ODDRm0GaaLdQr2ZdquLtuC2ePK9zjbjZ3DpRlLsTbkOTi0d0XJUX+b2LJIWwLCwPCL
 AMn8FcsaRIGxhxAQyekMXerbmDBriHIXSYQ6kWqpER+61UqkuOce1i38kA8ZJuMBoecW
 Df3Zxl6+MDYHOx2xmK/FrYPiWuNnzUaEmu+FsX7qSAyEXO72nYjxJdLbE4uM3b8CoJyM
 sLIJJ16eGcoMRK9pXw2wFdz/E9kOZgsiBBRwHDquoteBsHfZc2sWO/MtgP1hNQuDrlZ4
 Em5A==
X-Gm-Message-State: AOJu0YxIqWdZ2baLoPEUGRvY1F6u83a/jwzFQeDJ/G4p7ecnxWQAiDx5
 mxenSUvzp2IrKWPYU81NH/4j5rH90L1Oquk+7RznMToYD6a16sZuSfIw0Ru8cJ2h9536FhM5U6e
 IVsL/WfI=
X-Gm-Gg: ASbGncv/jlsLpY4Z57hsoGNnSY2uXzvlVKHXLBOZtjAPzZubPzCZlB7CIRdVgtiMbDe
 WtMFpkueXxI2cnVM1e4QrDIKiHcB4U/OQpIJHGEltbPL++qQu30BJTIp8Zd5malptpxQCv90GzX
 syjEM987QIJTl3IEopLq2V8JcVpB7DBeJNjBE9ODbMtHvUJRv6qIB8x5Hce3Px9YItQoGcn+z1L
 INC1wxRh06IIr2sjL44fdbC78xy4mpFJGizSzrw7zIqVAO27nMhZYuIRTU8ObrriqfwhPsiKJlv
 GID4Db/pf5l7AyGH447ue5dLn9r9jd8QBz1oevhH6B3ODhtbDH+Xv7gk1OHtMHDZoTxsHakhyfr
 n3voeN0kGdkOafnhRe+zfUDSKTQTLSPV+Tx+BNkqCjHZ+SYLxd3PBAGDX/OFocP40UifM/7X3eb
 zf3aV0AIpPg/QJ1Mq7cTuf4bY309rAAsjNYLKofufWcDWchl2BQzH7Q6Xk/PwT
X-Google-Smtp-Source: AGHT+IGj40Tm0Y+OPmraCNCsy+lwL4gLutxE0a+akPs+fVR+0b8fI4LoEZvRXbYntpUAMFO0RpfcpQ==
X-Received: by 2002:a05:6000:701:b0:427:614:83d9 with SMTP id
 ffacd0b85a97d-4270614848dmr7984928f8f.48.1760956741485; 
 Mon, 20 Oct 2025 03:39:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a781sm15047517f8f.30.2025.10.20.03.39.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 03:39:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, kvm@vger.kernel.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/18] hw/ppc/spapr: Remove SpaprMachineClass::dr_phb_enabled
 field
Date: Mon, 20 Oct 2025 12:38:05 +0200
Message-ID: <20251020103815.78415-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020103815.78415-1-philmd@linaro.org>
References: <20251020103815.78415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

The SpaprMachineClass::dr_phb_enabled field was only used by the
pseries-3.1 machine, which got removed. Remove it as now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr.h |  1 -
 hw/ppc/spapr.c         | 28 +++-------------------------
 2 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 06e2ad8ffe6..bc75e29084b 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -143,7 +143,6 @@ struct SpaprMachineClass {
     MachineClass parent_class;
 
     /*< public >*/
-    bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHBs */
     bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
     bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
     bool linux_pci_probe;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e06eefa3233..b81eb7ffe73 100644
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
@@ -1254,9 +1253,7 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
 
     /* ibm,drc-indexes and friends */
     root_drc_type_mask |= SPAPR_DR_CONNECTOR_TYPE_LMB;
-    if (smc->dr_phb_enabled) {
-        root_drc_type_mask |= SPAPR_DR_CONNECTOR_TYPE_PHB;
-    }
+    root_drc_type_mask |= SPAPR_DR_CONNECTOR_TYPE_PHB;
     if (mc->nvdimm_supported) {
         root_drc_type_mask |= SPAPR_DR_CONNECTOR_TYPE_PMEM;
     }
@@ -3003,10 +3000,8 @@ static void spapr_machine_init(MachineState *machine)
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
@@ -4089,11 +4084,6 @@ static bool spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
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
@@ -4119,16 +4109,10 @@ static bool spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
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
@@ -4254,7 +4238,6 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
 {
     SpaprMachineState *sms = SPAPR_MACHINE(OBJECT(hotplug_dev));
     MachineClass *mc = MACHINE_GET_CLASS(sms);
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         if (spapr_memory_hot_unplug_supported(sms)) {
@@ -4269,10 +4252,6 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
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
@@ -4682,7 +4661,6 @@ static void spapr_machine_class_init(ObjectClass *oc, const void *data)
     smc->default_caps.caps[SPAPR_CAP_AIL_MODE_3] = SPAPR_CAP_ON;
     spapr_caps_add_properties(smc);
     smc->irq = &spapr_irq_dual;
-    smc->dr_phb_enabled = true;
     smc->linux_pci_probe = true;
     smc->smp_threads_vsmt = true;
     xfc->match_nvt = spapr_match_nvt;
-- 
2.51.0


