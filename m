Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA46AD6552F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFz7v-0007Cc-7J; Tue, 26 Nov 2024 12:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFz7j-00079C-0d; Tue, 26 Nov 2024 12:13:15 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFz7h-0004Hu-BL; Tue, 26 Nov 2024 12:13:14 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-214d1c6d724so20477345ad.3; 
 Tue, 26 Nov 2024 09:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732641191; x=1733245991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=er6EAmnjAudD3kPiQB9zkLV3SUfbN2uxnS0cWpglFxE=;
 b=hWTsozBEg4fBr/w3MGcqXvPvRWoIfDymNGpfCZYeRufnbhBDUDD0bt1OWSuBAZFMg9
 O7Fi5hZl66UZdED7auem+lmRa4XnpOF3TcMS5F1niHCERHC3XDmPJpKMdZViXmmJ3eOO
 K2aBuKKpCFv11bZraZ2txw8PRiWCGNbHilVau6y1J6rIFQ3GGPLsj7SmLP+ne8ndeW5u
 VjNod05/sf568Z5a3TRH6Lg+srE8uhuD1c1JFIfw8y65u0I9l+dREhH+lFCo6SQVkt3X
 DW3BGwNWobNLqO3xZfo7DA/ltRV9TdW5a3QakqiQ2pvoeDliU43UtR9FX/Yk78GwLCn7
 WHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732641191; x=1733245991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=er6EAmnjAudD3kPiQB9zkLV3SUfbN2uxnS0cWpglFxE=;
 b=YdSJPpEKgaCaTe6he1AbShFUE6K3csWJiog9ixpLvXkwslCDljxdzl9G8UYxU2V1QQ
 gV4oe/JUNomMmCzxIoPknq8EMn+gJoIY/RNvel6z1k+T7F2jQLm312ubpqyBBCZ9f+vF
 n5xR9lRzlQo7SZ4o8JHV1MnH2pzh2J8rfu/US0BYsWL05P2KIwG1zKQJJ/zJpe7r/vzQ
 xhTRTXkNkafaTahMdbIdpvHb7gcEJZfnjnwiflzJADJuLGfIO1sDaCQ5+/oSMAsSV6X5
 hfeDMVBC6GZMR0BwPax+vcGfQlcd9JgxJRDI5XhOnhq1vFlZOJ3gF8NJXUtT/DASKi5f
 0a2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA2vYVG/PRsSbBlmuUWSekQSK261qxyDZI5Ay+gZUcTbF3xze/16LCYc9+bIuBeoF24wzdazvGUw==@nongnu.org
X-Gm-Message-State: AOJu0YzAqBE7qMEaFkG6ZMHxB+AZY1T4O24LEBGUIHfg8LqGjW2T3IHf
 Qzb58SUnbEiCqgEIvQT42TVuOg3UWFgTpT5X/2mVYPrwN910IXdoBbQHPQ==
X-Gm-Gg: ASbGncu3csmlCCIrvyuD+ryzxqe54F84vCDtQz2QzhAI1oDYU24afZ4y+hcCOzNVez4
 cglfLivdGHgpCt/ycmH65mZkKX0LWBpVQ+hk55Au5oh7/NiubLrR3ny/l3nOIWdFVEMTtFe/UKF
 FgmaMqBdjqednY03S+hAgtAAYKF/Y+8rIC3m+GsIvYO4Kd5OAPrmUYPsNdBCOHcEiKB5ANxwGS8
 3wJ/y4B9lUgK9Mn7wbGSgHiqH+ZEV3pljVwyi0CaLldU6IFHnJ/MJAM8fnXQnHOZY52W3vN0YQb
 UcO16Q==
X-Google-Smtp-Source: AGHT+IE5flv56BZkzOAFRRII/6UguyQi2QW7K7yaJWrdcGa555DTHLRJtWJj68CmzlMLrLrNcFKL0A==
X-Received: by 2002:a17:902:ea0b:b0:211:f10e:2dce with SMTP id
 d9443c01a7336-2129f233babmr185866065ad.21.1732641191148; 
 Tue, 26 Nov 2024 09:13:11 -0800 (PST)
Received: from wheely.local0.net (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc21c28sm87321175ad.246.2024.11.26.09.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 09:13:10 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 6/6] hw/ppc/pegasos2: Fix IRQ routing from pci.0
Date: Wed, 27 Nov 2024 03:12:35 +1000
Message-ID: <20241126171235.362916-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126171235.362916-1-npiggin@gmail.com>
References: <20241126171235.362916-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The MV64361 has two PCI buses one of which is used for AGP on
PegasosII. So far we only emulated the PCI bus on pci.1 but some
graphics cards are only recognised by some guests when connected to
pci.0 corresponding to the AGP port. So far the interrupts were not
routed from pci.0 so this patch fixes that allowing the use of both
PCI buses. On real board only INTA and INTB are connected for AGP but
to avoid surprises we connect all 4 PCI interrupt lines so pci.0 can
be used for all PCI cards as well.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/pci-host/mv64361.c |  1 +
 hw/ppc/pegasos2.c     | 30 +++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
index 1036d8600d..421c287eb0 100644
--- a/hw/pci-host/mv64361.c
+++ b/hw/pci-host/mv64361.c
@@ -95,6 +95,7 @@ static void mv64361_pcihost_realize(DeviceState *dev, Error **errp)
                                    &s->mem, &s->io, 0, 4, TYPE_PCI_BUS);
     g_free(name);
     pci_create_simple(h->bus, 0, TYPE_MV64361_PCI_BRIDGE);
+    qdev_init_gpio_out(dev, s->irq, ARRAY_SIZE(s->irq));
 }
 
 static Property mv64361_pcihost_props[] = {
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 8ff4a00c34..16abeaac82 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -14,6 +14,7 @@
 #include "hw/sysbus.h"
 #include "hw/pci/pci_host.h"
 #include "hw/irq.h"
+#include "hw/or-irq.h"
 #include "hw/pci-host/mv64361.h"
 #include "hw/isa/vt82c686.h"
 #include "hw/ide/pci.h"
@@ -73,8 +74,11 @@ OBJECT_DECLARE_TYPE(Pegasos2MachineState, MachineClass, PEGASOS2_MACHINE)
 
 struct Pegasos2MachineState {
     MachineState parent_obj;
+
     PowerPCCPU *cpu;
     DeviceState *mv;
+    IRQState pci_irqs[PCI_NUM_PINS];
+    OrIRQState orirq[PCI_NUM_PINS];
     qemu_irq mv_pirq[PCI_NUM_PINS];
     qemu_irq via_pirq[PCI_NUM_PINS];
     Vof *vof;
@@ -177,7 +181,6 @@ static void pegasos2_init(MachineState *machine)
         pm->mv_pirq[i] = qdev_get_gpio_in_named(pm->mv, "gpp", 12 + i);
     }
     pci_bus = mv64361_get_pci_bus(pm->mv, 1);
-    pci_bus_irqs(pci_bus, pegasos2_pci_irq, pm, PCI_NUM_PINS);
 
     /* VIA VT8231 South Bridge (multifunction PCI device) */
     via = OBJECT(pci_new_multifunction(PCI_DEVFN(12, 0), TYPE_VT8231_ISA));
@@ -209,6 +212,31 @@ static void pegasos2_init(MachineState *machine)
     /* other PC hardware */
     pci_vga_init(pci_bus);
 
+    /* PCI interrupt routing: lines from pci.0 and pci.1 are ORed */
+    for (int h = 0; h < 2; h++) {
+        DeviceState *pd;
+        g_autofree const char *pn = g_strdup_printf("pcihost%d", h);
+
+        pd = DEVICE(object_resolve_path_component(OBJECT(pm->mv), pn));
+        assert(pd);
+        for (i = 0; i < PCI_NUM_PINS; i++) {
+            OrIRQState *ori = &pm->orirq[i];
+
+            if (h == 0) {
+                g_autofree const char *n = g_strdup_printf("pci-orirq[%d]", i);
+
+                object_initialize_child_with_props(OBJECT(pm), n,
+                                                   ori, sizeof(*ori),
+                                                   TYPE_OR_IRQ, &error_fatal,
+                                                   "num-lines", "2", NULL);
+                qdev_realize(DEVICE(ori), NULL, &error_fatal);
+                qemu_init_irq(&pm->pci_irqs[i], pegasos2_pci_irq, pm, i);
+                qdev_connect_gpio_out(DEVICE(ori), 0, &pm->pci_irqs[i]);
+            }
+            qdev_connect_gpio_out(pd, i, qdev_get_gpio_in(DEVICE(ori), h));
+        }
+    }
+
     if (machine->kernel_filename) {
         sz = load_elf(machine->kernel_filename, NULL, NULL, NULL,
                       &pm->kernel_entry, &pm->kernel_addr, NULL, NULL, 1,
-- 
2.45.2


