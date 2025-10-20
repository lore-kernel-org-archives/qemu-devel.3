Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CD8CCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnHp-0000eM-3I; Mon, 20 Oct 2025 06:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnHl-0000d0-UU
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:38:42 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnHj-0000Et-KT
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:38:41 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b85so5700560f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956717; x=1761561517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ihxvz/zYsaWUtfE9vP9orWGk1XOSmxd+RXF63zIcqM=;
 b=c0pc5gQsT1vNbbLMIvUyJWH96PuuPNXuecRBE6RB+68+5KC5wn3sR0k19bM7hbUlRI
 7+UEsCm61C+soSoyRZrKaXPy38Qx12WjDWX73LerV5Ya8rHhPLm1tUqoULI/DYzoCICv
 zqSC/DgwwGISdQF127tId8uF58PIzSDl3VFcmju5W4XjSu8iuMKlLGAmjZfmC+1dx32A
 yBtFqLIp7a+86r1VxBuWfMNmE885t9InqS8hbu85durWt3bFb6P/LE1TwF4KuXoDDQPn
 jd0Oul95fQYgeH8vHkm2Q2VaM1OSXX2S75jby30WFAScocgbJClN0yPmol3eSx+bv2zu
 Y3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956717; x=1761561517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ihxvz/zYsaWUtfE9vP9orWGk1XOSmxd+RXF63zIcqM=;
 b=Fa0BIKWK2osXCZJk+XQRPCYltEGE0uN4dN6087kU2hfQz6dqi8gFB5saelRFoEwRH7
 HbV8q4dlMy9JvFizYReJ1h3/9wnRyKmeNdDo3B2aql7vSN6jztVCrpHwuOwoPt6AJ3eb
 JZAqos0vRwJW+lNcV5Cj8vqRYDOovHACP/NDlPkOyLTsdg49QVtJDutwClktX1GhuLrW
 p18gSlMTUtwvawIbpJLcZH0QOBGxVX86EY7Xmsk6BNEPiY5fM2sUKxz/8AWTFKjq5i5a
 WlmraYLHydHHAAr0Nj/44uta+zTbe8ahLuiPzW0tEpzeLpjfFBjbfzboIWNWEKMaGzLi
 L9/Q==
X-Gm-Message-State: AOJu0Yy61HPzf34UkOmI7yPf97J0u4ZSYsxtmIYpgROiVKsk4x1h9HBQ
 J57sYNP/sNndWOVK48Q+6XS2cQ8WHNEdx5cfJlh39enHtGX2Xg6JhDoulOIxTaBrYzrbcLJHEHP
 /jUGA3eo=
X-Gm-Gg: ASbGncsN6w5myX8uKKpAP4Ua0uqxvg6o/mVRgik5kQa6iiYcA/cs2NJ85tnmmf4W4/8
 EBBeNGwPbpc3mtIdhzUs/z6v8ydph7lexgRE1HAggJd9wwWhR2BFWdESL0Ej4x1bjsrBmYAe7mN
 77//Ue5pRoCy/cXzY+TTNi4fDEDSoNEcuzejv4BZoopE0sdFTREjgNG3HLvNgi5XyVbefNBL1AA
 e93VyYjCN5YsoR+k9AkLcwXV1dF0lvSRJv4k1afJBwn1hOGlnEV20U+/ekWG5bbjZGu9ZMY2Af9
 EW/AhvH/qjxVSYBgdjRKnXJw7+l+soUyQaHFAY1lZsg3Zfq7NT2A+zxf5+oICplgsQyL3C01um2
 siZ7q8dZktetoEeor92VHcl/qnZpa4Q0sNWWUvqG5zKBNX6KUFVZGGg0gnGznwcadr7eWw9Sfvo
 xdZOBEf1KR85nKNMIBunW/a6V/xtBPNMyhXOA7RreQpPIjsm/v0gKlPLaE+V03
X-Google-Smtp-Source: AGHT+IFxCHaLufk14XE5nX0AAEVGB8FvcIDFeS8snE/LozpgkoX/10SV+mciQRu6gpCSHDLuCGf/jA==
X-Received: by 2002:a05:6000:4021:b0:426:d836:f323 with SMTP id
 ffacd0b85a97d-42704d7e928mr8617320f8f.13.1760956717468; 
 Mon, 20 Oct 2025 03:38:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a0e9csm14845298f8f.5.2025.10.20.03.38.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 03:38:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, kvm@vger.kernel.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/18] hw/ppc/spapr: Remove SpaprMachineClass::nr_xirqs field
Date: Mon, 20 Oct 2025 12:38:00 +0200
Message-ID: <20251020103815.78415-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020103815.78415-1-philmd@linaro.org>
References: <20251020103815.78415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
index 14e47acc65b..2ce323457be 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -279,15 +279,11 @@ void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
 
 uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
 {
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
-
-    return smc->nr_xirqs + SPAPR_XIRQ_BASE - SPAPR_IRQ_MSI;
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


