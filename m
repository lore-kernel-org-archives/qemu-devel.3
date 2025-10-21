Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F851CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 08:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB7yP-0008L0-Ca; Tue, 21 Oct 2025 04:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7yN-0008Kb-E2
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:44:03 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7yK-0000uT-SY
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:44:03 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4711f156326so39723125e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 01:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761036238; x=1761641038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0M4ai3rHfvY9hawDUvi5q45cAeCDeC3osatMpD7h84s=;
 b=OFWoqE9cFOUhbfmX1HQx5tg/cFlkgjk/NA+5AF1QmmfVRKlY77ayRwGFnzIZxwoGoU
 Gk43oAMOb6bej+ayXWYEZEfnr59B7I05K3IF4dYmiWjuQBChDNf8eBnp1JrQHqA8vbQZ
 zaXJtuG0fDJ8yOKoD4zXjthkl/X2Xvh9kWrnehcIriTcs0nARzkaOdSuqJkSOI0N8NuQ
 LOyRftl4Um7iY8fZGtUj2ZPXhkMXDMoBpl1lGq+BL6NPOGHJ9da2vXgQt9aZSClLhE/m
 6EgI0dmVBiRXZiVng/ksExs9sAAl0WudI0jlE2zgcRAHdm6clsADl6N/RuBOxhaUK3mi
 uyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761036238; x=1761641038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0M4ai3rHfvY9hawDUvi5q45cAeCDeC3osatMpD7h84s=;
 b=Uys8p6lif5+lM8o/QG8LW9cymKAmLUzFd+qf177ui+t7ID7elizQN8pRa+bB55DTiT
 38KqKDK51FMEvZd8E41dm7VdOA/X+SXu9ZAYzdGWeUB2Xul3tPuvCskC773DTifmWBzj
 FwaLU4VheRGqGc5Xb6kswTefdTdsO8cLwXvuHrCDaUMzKpIoAqT1sK9ilFXd4MciV+tw
 gfZlmA9my89S5iIaWJuyaDnlfk9+DxfY+nH6Dq5NwaH66Cp5wW1QxVCPz0jS6qRUByQT
 wIJIdVs3JpmM1S7UCxWYX2evP4588x6QyqN+HkB0o+QE0dsd/f3JpKedybuEVDMcQmJo
 gReA==
X-Gm-Message-State: AOJu0YxWiaV72IWAu6h+907gSa/84G74jQiqOVr9FevEMu/ivg5Rb/+5
 gUorm7+tS5/pCH0SiX6aogtuGGnVNO/fpnVT21aFZPXFGm5tj1jFqOAuoryWgr8Z2OBIsrcTR3T
 LYQTClBM=
X-Gm-Gg: ASbGnctjNENGIBDHJYXuvdEgnsO2bFZxpDijy6DZJQool/a1Ysc7VwUcuhVrnwnwc8i
 j9y/t4H7FaD1KmrbVtOs5ktU9eVo3np0NAeI/PTafbkk3KSex66PcMBicZFPFvD0+e3GYh7Chnn
 QKHz2reVTudfy3+qhOksw3A4+KMHd8dajSPM03dfkxc8CJhWUDATmctmeWdr1CjPgSaCP+XdP4E
 Ya4ejJLX8EPTKue4sWrT+6wV8gfNeybtjE0zQ3k539W3s4zmmeAoKJ6vI6cocO5ioiGTY9mrLzH
 SXLVewsps257lfvga5i9d+8SUVJWjIjbevrtYoAY2djmUwbHben1EG+pSf1xQY8KeHOzHYQHR4X
 e+If5RPPLRu3v3MDXx5FRl6rzDqwA3VpESi5EWS/mD1khNsHwuqMFpMd0/S12vB8F6tSWAcKHQA
 d5zV/wIA32qSqA+agE7B2Mcfx7CYIo4K+gYSYB8DvGQOyxr3lqL4ZiBmZsgMVY
X-Google-Smtp-Source: AGHT+IF8DS0Pay/oC0pJ1fYSBffefIYbS8RO4hSfwedEHxc9anqZvGqetbuBUGSMzHhFnNO4Qmql8Q==
X-Received: by 2002:a05:6000:2082:b0:425:7e40:1e02 with SMTP id
 ffacd0b85a97d-42704d49a0amr9499699f8f.7.1761036237724; 
 Tue, 21 Oct 2025 01:43:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a0f7dsm18932120f8f.4.2025.10.21.01.43.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 01:43:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/11] hw/ppc/spapr: Remove SpaprMachineClass::nr_xirqs
 field
Date: Tue, 21 Oct 2025 10:43:36 +0200
Message-ID: <20251021084346.73671-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021084346.73671-1-philmd@linaro.org>
References: <20251021084346.73671-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

The SpaprMachineClass::nr_xirqs field was only used by the
pseries-3.0 machine, which got removed. Remove it as now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr.h |  1 -
 hw/ppc/spapr.c         |  1 -
 hw/ppc/spapr_irq.c     | 22 +++++++---------------
 3 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 0c1e5132de2..494367fb99a 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -145,7 +145,6 @@ struct SpaprMachineClass {
     /*< public >*/
     bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHBs */
     bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
-    uint32_t nr_xirqs;
     bool broken_host_serial_model; /* present real host info to the guest */
     bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
     bool linux_pci_probe;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 426a778d3e8..b5d20bc1756 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4691,7 +4691,6 @@ static void spapr_machine_class_init(ObjectClass *oc, const void *data)
     smc->dr_phb_enabled = true;
     smc->linux_pci_probe = true;
     smc->smp_threads_vsmt = true;
-    smc->nr_xirqs = SPAPR_NR_XIRQS;
     xfc->match_nvt = spapr_match_nvt;
     vmc->client_architecture_support = spapr_vof_client_architecture_support;
     vmc->quiesce = spapr_vof_quiesce;
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 317d57a3802..2ce323457be 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -279,15 +279,11 @@ void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
 
 uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
 {
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
-
-    return SPAPR_XIRQ_BASE + smc->nr_xirqs - SPAPR_IRQ_MSI;
+    return SPAPR_NR_XIRQS + SPAPR_XIRQ_BASE - SPAPR_IRQ_MSI;
 }
 
 void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
 {
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
-
     if (kvm_enabled() && kvm_kernel_irqchip_split()) {
         error_setg(errp, "kernel_irqchip split mode not supported on pseries");
         return;
@@ -308,7 +304,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         object_property_add_child(OBJECT(spapr), "ics", obj);
         object_property_set_link(obj, ICS_PROP_XICS, OBJECT(spapr),
                                  &error_abort);
-        object_property_set_int(obj, "nr-irqs", smc->nr_xirqs, &error_abort);
+        object_property_set_int(obj, "nr-irqs", SPAPR_NR_XIRQS, &error_abort);
         if (!qdev_realize(DEVICE(obj), NULL, errp)) {
             return;
         }
@@ -322,7 +318,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         int i;
 
         dev = qdev_new(TYPE_SPAPR_XIVE);
-        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_IRQ_NR_IPIS);
+        qdev_prop_set_uint32(dev, "nr-irqs", SPAPR_NR_XIRQS + SPAPR_IRQ_NR_IPIS);
         /*
          * 8 XIVE END structures per CPU. One for each available
          * priority
@@ -349,7 +345,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
     }
 
     spapr->qirqs = qemu_allocate_irqs(spapr_set_irq, spapr,
-                                      smc->nr_xirqs + SPAPR_IRQ_NR_IPIS);
+                                      SPAPR_NR_XIRQS + SPAPR_IRQ_NR_IPIS);
 
     /*
      * Mostly we don't actually need this until reset, except that not
@@ -364,11 +360,10 @@ int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error **errp)
 {
     SpaprInterruptController *intcs[] = ALL_INTCS(spapr);
     int i;
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     int rc;
 
     assert(irq >= SPAPR_XIRQ_BASE);
-    assert(irq < (smc->nr_xirqs + SPAPR_XIRQ_BASE));
+    assert(irq < (SPAPR_NR_XIRQS + SPAPR_XIRQ_BASE));
 
     for (i = 0; i < ARRAY_SIZE(intcs); i++) {
         SpaprInterruptController *intc = intcs[i];
@@ -388,10 +383,9 @@ void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
 {
     SpaprInterruptController *intcs[] = ALL_INTCS(spapr);
     int i, j;
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
 
     assert(irq >= SPAPR_XIRQ_BASE);
-    assert((irq + num) <= (smc->nr_xirqs + SPAPR_XIRQ_BASE));
+    assert((irq + num) <= (SPAPR_NR_XIRQS + SPAPR_XIRQ_BASE));
 
     for (i = irq; i < (irq + num); i++) {
         for (j = 0; j < ARRAY_SIZE(intcs); j++) {
@@ -408,8 +402,6 @@ void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
 
 qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
 {
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
-
     /*
      * This interface is basically for VIO and PHB devices to find the
      * right qemu_irq to manipulate, so we only allow access to the
@@ -418,7 +410,7 @@ qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
      * interfaces, we can change this if we need to in future.
      */
     assert(irq >= SPAPR_XIRQ_BASE);
-    assert(irq < (smc->nr_xirqs + SPAPR_XIRQ_BASE));
+    assert(irq < (SPAPR_NR_XIRQS + SPAPR_XIRQ_BASE));
 
     if (spapr->ics) {
         assert(ics_valid_irq(spapr->ics, irq));
-- 
2.51.0


