Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD92C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdzg-0001W1-3k; Tue, 04 Mar 2025 20:56:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdzJ-0007pi-Mx
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:57 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdzH-0000Vu-MN
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:57 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-223480ea43aso156445905ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139753; x=1741744553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjTF1ZGD6+FxtdMflNGzLhj5EB+HlRI1B/aKHXZtkpY=;
 b=cLjp4UzkXCdPAoUeY5A1qG21FCpUKnWFSJl3p/Y/umO9Wa6ocV+dkoSgcDmiloBhjR
 6J8bagWHe8oE2OMkVbK67lVz23IwUIxBLOXNA14VGYj4oCWeySyAwnYaqUroT1vhjssV
 KULl7TMoqISvHzWo88uFP+2S316zbmwtHNtFDOOInP7sw4ZVajyuzDjUc2CS5k6KFDx5
 wwQsltEES3BIphSdHAQLuORhmFa9lzdZ3ldrBzCknKVFQO8vWOdjk0uROW2utk1u4bjG
 oKUY2sEU6//CUbA1vKOZkIk/0gbQMHgH3p1xk2h7AKOK3ljEAgWAmDyj11zgrUNdQ2kN
 fKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139753; x=1741744553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OjTF1ZGD6+FxtdMflNGzLhj5EB+HlRI1B/aKHXZtkpY=;
 b=WqG73FoumpaNyGfupofTlP+S1y/3a2e1Z/5YNi52d6e0cX49L9byKfvXC6edBaQtgP
 EQFOAMJK33Y4BC2KhvQroGG2Dx8xVp4gPG09Rjm+/+V989FmzU/a3UEHyfrEXbKOitot
 3JXRnJfyYuG425nXLSjpPZiqx4JOV0S8ZOJPnf1dQhdZfh/Eb3Mg5NZBiUaeP7Q52Qw5
 vq2mryakNAUsibkf0ktexn21lOZuuxWSLBoCs8UlTM4Q1yrAPqxAmNv6Kp64KpHs1Dl4
 pMotYBNOOlnXtoVhgEy6W5hfWEcHlLaL4oTovd7hYM3p+xK3FXtisOpnaOp0OZiId31U
 vd2w==
X-Gm-Message-State: AOJu0YxRp0C//bassOSZeYC6BdweF310i3T1lbEkJJs+vVImOm0vsBj9
 Rv7z3Gr1aptoJ1hl3SHOMTWwg7S6NIgFaxW+FJ1Hl/e4jfb4j2GcBDb6vpyGoDU=
X-Gm-Gg: ASbGnctXqUYoZjmKPxATr7Zck56wQ/nqOSg0V6nqhL7Zu2i/NwWtlqjyk1vRNo5TZ8D
 TIlym0Uy7BM5JhxN3R8095UkcjQopnAB6FFmNkFVEtHb2HlmqHSNt63yNmblqNO462r2EjU1t4S
 OfulYfFlZZSCSuP733uT91JVh4uwJ0wT97VkZZZUZbxpXmlR4NlLK3PYqtKFGs3QfNRFOOHtxi4
 KjYI4SScW5SwTYa3thlviykv7KlWcGKnoc7wpbLCWEtmQnKXlQdo+i8rkA7H9fWTH9ZrZmNwf+w
 Z/kDjkjdMtgdKlQKyqGFCIEK/eLQDAa3KgleSuGgi8wMGlkUoQSwKkSZv7wPflEoSvg+Bsq45Cx
 kDdK5PvRDrnR6M9+oc0RB9aKsMHyLgX/SFc4nEAvQHbYaTGLcaao=
X-Google-Smtp-Source: AGHT+IFPIhbI4cXZ/URIE8uzDGLhv57ez5uVDyMC5/j2icF2uHlzUoToLQ4AMZV/aZQf2cQkRN1uUQ==
X-Received: by 2002:a17:903:f83:b0:220:d078:eb33 with SMTP id
 d9443c01a7336-223f1d1f10bmr21937995ad.36.1741139753315; 
 Tue, 04 Mar 2025 17:55:53 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:55:52 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 54/59] hw/intc/imsic: refine the IMSIC realize
Date: Wed,  5 Mar 2025 11:53:02 +1000
Message-ID: <20250305015307.1463560-55-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

When the IMSIC is emulated in the kernel, the GPIO output lines to CPUs
and aia_ireg_rmw_fn setting can be remove. In this case the IMSIC
trigger CPU interrupts by KVM APIs, and the RMW of IREG is handled in
kernel.

This patch also move the code that claim the CPU interrupts to the
beginning of IMSIC realization. This can avoid the unnecessary resource
allocation before checking failed.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250224025722.3999-2-yongxuan.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_imsic.c | 47 ++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index dc8162c0a7..241b12fef0 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -349,7 +349,19 @@ static void riscv_imsic_realize(DeviceState *dev, Error **errp)
     CPUState *cpu = cpu_by_arch_id(imsic->hartid);
     CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
 
+    /* Claim the CPU interrupt to be triggered by this IMSIC */
+    if (riscv_cpu_claim_interrupts(rcpu,
+            (imsic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
+        error_setg(errp, "%s already claimed",
+                   (imsic->mmode) ? "MEIP" : "SEIP");
+        return;
+    }
+
     if (!kvm_irqchip_in_kernel()) {
+        /* Create output IRQ lines */
+        imsic->external_irqs = g_malloc(sizeof(qemu_irq) * imsic->num_pages);
+        qdev_init_gpio_out(dev, imsic->external_irqs, imsic->num_pages);
+
         imsic->num_eistate = imsic->num_pages * imsic->num_irqs;
         imsic->eidelivery = g_new0(uint32_t, imsic->num_pages);
         imsic->eithreshold = g_new0(uint32_t, imsic->num_pages);
@@ -361,18 +373,6 @@ static void riscv_imsic_realize(DeviceState *dev, Error **errp)
                           IMSIC_MMIO_SIZE(imsic->num_pages));
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &imsic->mmio);
 
-    /* Claim the CPU interrupt to be triggered by this IMSIC */
-    if (riscv_cpu_claim_interrupts(rcpu,
-            (imsic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
-        error_setg(errp, "%s already claimed",
-                   (imsic->mmode) ? "MEIP" : "SEIP");
-        return;
-    }
-
-    /* Create output IRQ lines */
-    imsic->external_irqs = g_malloc(sizeof(qemu_irq) * imsic->num_pages);
-    qdev_init_gpio_out(dev, imsic->external_irqs, imsic->num_pages);
-
     /* Force select AIA feature and setup CSR read-modify-write callback */
     if (env) {
         if (!imsic->mmode) {
@@ -381,8 +381,11 @@ static void riscv_imsic_realize(DeviceState *dev, Error **errp)
         } else {
             rcpu->cfg.ext_smaia = true;
         }
-        riscv_cpu_set_aia_ireg_rmw_fn(env, (imsic->mmode) ? PRV_M : PRV_S,
-                                      riscv_imsic_rmw, imsic);
+
+        if (!kvm_irqchip_in_kernel()) {
+            riscv_cpu_set_aia_ireg_rmw_fn(env, (imsic->mmode) ? PRV_M : PRV_S,
+                                          riscv_imsic_rmw, imsic);
+        }
     }
 
     msi_nonbroken = true;
@@ -464,15 +467,17 @@ DeviceState *riscv_imsic_create(hwaddr addr, uint32_t hartid, bool mmode,
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
 
-    for (i = 0; i < num_pages; i++) {
-        if (!i) {
-            qdev_connect_gpio_out_named(dev, NULL, i,
-                                        qdev_get_gpio_in(DEVICE(cpu),
+    if (!kvm_irqchip_in_kernel()) {
+        for (i = 0; i < num_pages; i++) {
+            if (!i) {
+                qdev_connect_gpio_out_named(dev, NULL, i,
+                                            qdev_get_gpio_in(DEVICE(cpu),
                                             (mmode) ? IRQ_M_EXT : IRQ_S_EXT));
-        } else {
-            qdev_connect_gpio_out_named(dev, NULL, i,
-                                        qdev_get_gpio_in(DEVICE(cpu),
+            } else {
+                qdev_connect_gpio_out_named(dev, NULL, i,
+                                            qdev_get_gpio_in(DEVICE(cpu),
                                             IRQ_LOCAL_MAX + i - 1));
+            }
         }
     }
 
-- 
2.48.1


