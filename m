Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCF6CCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnHk-0000cH-Ta; Mon, 20 Oct 2025 06:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnHh-0000aU-Pq
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:38:37 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnHf-0000EA-B7
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:38:37 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4711825a02bso26009895e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956713; x=1761561513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCVCJzBQFldWaH4w+gbsije/shLLiDepBPxOaxlrC0k=;
 b=MJUpKsAFdiuduW3GM/sipiRhPLBhGlNyADWeqmcmf72NhTZaSMvipc9Rn0l1ZdRVgX
 i4yBN+7cUn/KlcNcdAFMOMMHKoJJIspDPhqnFAkem1qbD4KjRqSIfcIyaoanDbP6dkdA
 C89e5h5qLEAylVA0D/3sJDPJiT6jb7qBPlvC7Ft/mTQLcNKcvjV+EDhsFtesTMyqm8gv
 g/IU8T0hs6h+ksDdGcrWlmFyXlHgHbiKYtDurGvD3MKjZ8NZoVlbrRXBTmK42k5p5rOR
 WuxpLv3Wx/tty0kh7aK39VYfBccdcHrKSl8LFEp/OOqCnyazeTn7+vEd9X+EjKo5EKwv
 t2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956713; x=1761561513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCVCJzBQFldWaH4w+gbsije/shLLiDepBPxOaxlrC0k=;
 b=reP7yTGWV2+9HXbrcVl1UIitY4d5MgXtBqg56S5RjO6kYnvU231gOCfPCdwkokpKRR
 PI8uc5d3iJq4o/elLvNbq16/0HtqIweypnEnFowCzuGMW9yjxa7AMcU8qEEoOSdi5YIv
 QaoU9EPvGIvDeNJJgzOVsQ/X5FAqozL76738mC9ZWXIemvFrr3lUkYtrgpgph39uBn3h
 fNOVM81oHhKzp107qasn9CnhDirXWcPIKfy+OfUzS83gEznrxmSjUDwKRJFSdnyhtGE5
 W6p/2tNf95zuTXufLKzngOp7tWdGtzQQ8zOjAeF83K6bMY3NCE+9/zDt/UEyVlDrjLCU
 vL/A==
X-Gm-Message-State: AOJu0YweIZeKiUpcyEfb978JxTqqqttl+apEayAb4Ucsnf3RImqO88DS
 bk696ikfegUQb5GOC90aH1TuOBSeda/0ZNgpgqiDRSbr+swXCfrTW+zg49OxlmMWrk0r/I137Fr
 7JlUZlHY=
X-Gm-Gg: ASbGnctXvFs1VAXNp4mdThDqb7lNBevy/AFucPgZpdQd1+yhaBbbdg+uzoWYi3Daaga
 eut1sEPorB1+zoQoE4Vtgj+HUow+bO4MAesS1EGH1QIfLmggpN+5o8GS2KyFmaRglKAiVwBWvPN
 gFlB4+Dp/kzQ6A9ttCoWRqT1HkaTJWqYqjpP3GmSv2V8QRtySAKeXAnvETmwGlO/F2RPRy5cVvm
 O5jcBfQUCxh1cyaHKY7Yck11QIFmC/EUZUrGAgUjQzVE4vJ7r3gKZTlFA9ZL52vN9pu1jlOxTnL
 7uZJ315EDrJ/DUpo9PeqdQFhzjBlhyGr0RhEx0GKgA6hBfLvYY+Om62bS4kr0aakTRM8t/z+VmN
 yvRw6wbu2/dPIQb7FjTR00pwjposKYSeTs4eRwDOrUprOY+VBc0GMd3k6DNpHkExcjpkWdlRGUv
 TpsA1E0Kda0ZJlxb9/BJ2/+mWouvs/c6w8W9EAD/owUEZAkmXbYA==
X-Google-Smtp-Source: AGHT+IE1F5AkBjZ2Kcl+ql57kKPzckKqh+6Vz8ZzF/8zSDBRUEs2BLnaHom0/e3CLqeN/DyttLrGiQ==
X-Received: by 2002:a05:600c:548a:b0:46e:6d5f:f68 with SMTP id
 5b1f17b1804b1-4711787a2cdmr85471925e9.12.1760956712528; 
 Mon, 20 Oct 2025 03:38:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4715e2ee446sm61701135e9.6.2025.10.20.03.38.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 03:38:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, kvm@vger.kernel.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/18] hw/ppc/spapr: Remove
 SpaprMachineClass::legacy_irq_allocation field
Date: Mon, 20 Oct 2025 12:37:59 +0200
Message-ID: <20251020103815.78415-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020103815.78415-1-philmd@linaro.org>
References: <20251020103815.78415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The SpaprMachineClass::legacy_irq_allocation field was only used by the
pseries-3.0 machine, which got removed. Remove it as now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr.h |  1 -
 hw/ppc/spapr.c         |  5 -----
 hw/ppc/spapr_events.c  | 20 ++++----------------
 hw/ppc/spapr_irq.c     | 11 +----------
 hw/ppc/spapr_pci.c     | 32 ++++----------------------------
 hw/ppc/spapr_vio.c     |  9 ---------
 6 files changed, 9 insertions(+), 69 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 39bd5bd5ed3..0c1e5132de2 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -145,7 +145,6 @@ struct SpaprMachineClass {
     /*< public >*/
     bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHBs */
     bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
-    bool legacy_irq_allocation;
     uint32_t nr_xirqs;
     bool broken_host_serial_model; /* present real host info to the guest */
     bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ebc8e84512a..426a778d3e8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3361,11 +3361,6 @@ static void spapr_set_ic_mode(Object *obj, const char *value, Error **errp)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
 
-    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-        error_setg(errp, "This machine only uses the legacy XICS backend, don't pass ic-mode");
-        return;
-    }
-
     /* The legacy IRQ backend can not be set */
     if (strcmp(value, "xics") == 0) {
         spapr->irq = &spapr_irq_xics;
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 832b0212f31..892ddc7f8f7 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -1041,20 +1041,14 @@ void spapr_clear_pending_hotplug_events(SpaprMachineState *spapr)
 
 void spapr_events_init(SpaprMachineState *spapr)
 {
-    int epow_irq = SPAPR_IRQ_EPOW;
-
-    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-        epow_irq = spapr_irq_findone(spapr, &error_fatal);
-    }
-
-    spapr_irq_claim(spapr, epow_irq, false, &error_fatal);
+    spapr_irq_claim(spapr, SPAPR_IRQ_EPOW, false, &error_fatal);
 
     QTAILQ_INIT(&spapr->pending_events);
 
     spapr->event_sources = spapr_event_sources_new();
 
     spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_EPOW,
-                                 epow_irq);
+                                 SPAPR_IRQ_EPOW);
 
     /* NOTE: if machine supports modern/dedicated hotplug event source,
      * we add it to the device-tree unconditionally. This means we may
@@ -1065,16 +1059,10 @@ void spapr_events_init(SpaprMachineState *spapr)
      * checking that it's enabled.
      */
     if (spapr->use_hotplug_event_source) {
-        int hp_irq = SPAPR_IRQ_HOTPLUG;
-
-        if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-            hp_irq = spapr_irq_findone(spapr, &error_fatal);
-        }
-
-        spapr_irq_claim(spapr, hp_irq, false, &error_fatal);
+        spapr_irq_claim(spapr, SPAPR_IRQ_HOTPLUG, false, &error_fatal);
 
         spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_HOT_PLUG,
-                                     hp_irq);
+                                     SPAPR_IRQ_HOTPLUG);
     }
 
     spapr->epow_notifier.notify = spapr_powerdown_req;
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 363bfc00db4..14e47acc65b 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -33,11 +33,6 @@ static const TypeInfo spapr_intc_info = {
 
 static void spapr_irq_msi_init(SpaprMachineState *spapr)
 {
-    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-        /* Legacy mode doesn't use this allocator */
-        return;
-    }
-
     spapr->irq_map_nr = spapr_irq_nr_msis(spapr);
     spapr->irq_map = bitmap_new(spapr->irq_map_nr);
 }
@@ -286,11 +281,7 @@ uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
 {
     SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
 
-    if (smc->legacy_irq_allocation) {
-        return smc->nr_xirqs;
-    } else {
-        return SPAPR_XIRQ_BASE + smc->nr_xirqs - SPAPR_IRQ_MSI;
-    }
+    return smc->nr_xirqs + SPAPR_XIRQ_BASE - SPAPR_IRQ_MSI;
 }
 
 void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f9095552e86..bdec8f0728d 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -268,7 +268,6 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                 target_ulong args, uint32_t nret,
                                 target_ulong rets)
 {
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     uint32_t config_addr = rtas_ld(args, 0);
     uint64_t buid = rtas_ldq(args, 1);
     unsigned int func = rtas_ld(args, 3);
@@ -373,13 +372,8 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, SpaprMachineState *spapr,
     }
 
     /* Allocate MSIs */
-    if (smc->legacy_irq_allocation) {
-        irq = spapr_irq_find(spapr, req_num, ret_intr_type == RTAS_TYPE_MSI,
-                             &err);
-    } else {
-        irq = spapr_irq_msi_alloc(spapr, req_num,
-                                  ret_intr_type == RTAS_TYPE_MSI, &err);
-    }
+    irq = spapr_irq_msi_alloc(spapr, req_num,
+                              ret_intr_type == RTAS_TYPE_MSI, &err);
     if (err) {
         error_reportf_err(err, "Can't allocate MSIs for device %x: ",
                           config_addr);
@@ -393,9 +387,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, SpaprMachineState *spapr,
             if (i) {
                 spapr_irq_free(spapr, irq, i);
             }
-            if (!smc->legacy_irq_allocation) {
-                spapr_irq_msi_free(spapr, irq, req_num);
-            }
+            spapr_irq_msi_free(spapr, irq, req_num);
             error_reportf_err(err, "Can't allocate MSIs for device %x: ",
                               config_addr);
             rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
@@ -1789,12 +1781,9 @@ static void spapr_phb_unrealize(DeviceState *dev)
 static void spapr_phb_destroy_msi(gpointer opaque)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     SpaprPciMsi *msi = opaque;
 
-    if (!smc->legacy_irq_allocation) {
-        spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
-    }
+    spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
     spapr_irq_free(spapr, msi->first_irq, msi->num);
     g_free(msi);
 }
@@ -1808,7 +1797,6 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     SpaprMachineState *spapr =
         (SpaprMachineState *) object_dynamic_cast(qdev_get_machine(),
                                                   TYPE_SPAPR_MACHINE);
-    SpaprMachineClass *smc = spapr ? SPAPR_MACHINE_GET_CLASS(spapr) : NULL;
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(sbd);
     PCIHostState *phb = PCI_HOST_BRIDGE(sbd);
@@ -1956,18 +1944,6 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < PCI_NUM_PINS; i++) {
         int irq = SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i;
 
-        if (smc->legacy_irq_allocation) {
-            irq = spapr_irq_findone(spapr, errp);
-            if (irq < 0) {
-                error_prepend(errp, "can't allocate LSIs: ");
-                /*
-                 * Older machines will never support PHB hotplug, ie, this is an
-                 * init only path and QEMU will terminate. No need to rollback.
-                 */
-                return;
-            }
-        }
-
         if (spapr_irq_claim(spapr, irq, true, errp) < 0) {
             error_prepend(errp, "can't allocate LSIs: ");
             goto unrealize;
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 7759436a4f5..c21a2a3274e 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -507,15 +507,6 @@ static void spapr_vio_busdev_realize(DeviceState *qdev, Error **errp)
 
     dev->irq = spapr_vio_reg_to_irq(dev->reg);
 
-    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-        int irq = spapr_irq_findone(spapr, errp);
-
-        if (irq < 0) {
-            return;
-        }
-        dev->irq = irq;
-    }
-
     if (spapr_irq_claim(spapr, dev->irq, false, errp) < 0) {
         return;
     }
-- 
2.51.0


