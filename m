Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB29CFB42C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAk8-0005MZ-Jm; Sat, 05 Oct 2024 15:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAk5-0005K4-LF; Sat, 05 Oct 2024 15:47:05 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAk4-0007eL-3P; Sat, 05 Oct 2024 15:47:05 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cc8782869so31362305e9.2; 
 Sat, 05 Oct 2024 12:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157622; x=1728762422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AG+Y+5gJzuPsjRokhUJksRfJzuj5XbN634xFpFT8fEk=;
 b=ezrrNo1pl9TH2WFZb7giO34SWbcbt4WCvrNsRcMbv6VrcWmFA8ykxlMTz8MOKrQPiB
 9Y6w4SwY8kdPcCpJfiwOaj04b5ICBvsOCYPfbDIKqS2YN8IzhoVwtSWqS2yMBN/0gR/m
 2OkrB2PYOFm54g8iVaD8IJJdzTF1r0Bj4kG6NPqhi2WdIRT+qES0M1Xv9pwW79Jr2Alb
 mQ5i4zguLADC9ksudXKhJzFuAGtDaRvzfH4eprTGMkIZtCDeZT+FCloO3Bvx9HG8TeJj
 cKLIcw6WEmxpKoN3LjMHtdtXMKCqw3RcjNvcMnZEmnyMPidX0uC6HYiUBfiBzLqlgUkr
 uerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157622; x=1728762422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AG+Y+5gJzuPsjRokhUJksRfJzuj5XbN634xFpFT8fEk=;
 b=Lv+CXRWD5B+5ZeieGuWObqPA0MeYdUaU5Gz3KWzGI3UKlKbTLpnfNOfOSGXkFHL7XC
 ed8l8Lo5HAwEP2cJoT7zF++q4QOu/B44ljs1Rhl4X2kb1E3l2YA1y3xWWPn062lWnYKE
 iabKsb64vQ5u01ZuPcVtvlLreSHgQtoAbIJZuY3/suGJ2zsO6p9SkwpIKiGtTWB4fXGQ
 NMgCtVhj6/o2G6ga5ANLOBSqrZulqXz4KP831+fzU89XnkkZrymOUFvH+zH4zBAdfNWa
 W61rFBpjTw3xMb7wDUmDVSWsbFdVmNksWiz4PcvZsTmu8OZ3i5Uy0M/g4m5kNwL5WCEF
 mZPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTtipvVMNwoLe23qi0pJLchig9+X5oUGOGU1T/h/SlL6RghuK6/nIXGuMOZS4d7W8MCQxleedEFlpZ@nongnu.org,
 AJvYcCWt5zcOJuqE/odyZAOvsJZ8j6oQSIG3dr05+KfU7TL4QN9cwFQkjgjAas15OXEgF6TQFk/FiKpkZzo=@nongnu.org
X-Gm-Message-State: AOJu0YyPdPbwLCIPPVQOb8El1nCst0BZH6llRfzbIi8dduoqGdNoI/39
 M8wSeVt1ENdeVFKtWj1eJ36TTyfRa492GooDC5Tu9uS6ZZkfgeJ0qDnZAg==
X-Google-Smtp-Source: AGHT+IHMnlgDi28En56nIgJC30XNtmsxCf3ECZfv1iNq6CZdbVw+wP6zhfxEGZ/bWa2e77vqhXh14Q==
X-Received: by 2002:a05:600c:3ca6:b0:42c:b5f1:44ff with SMTP id
 5b1f17b1804b1-42f85ae92ffmr53387145e9.24.1728157621309; 
 Sat, 05 Oct 2024 12:47:01 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:47:00 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 06/23] hw/ppc/e500: Use SysBusDevice API to access
 TYPE_CCSR's internal resources
Date: Sat,  5 Oct 2024 21:45:46 +0200
Message-ID: <20241005194603.23139-7-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x336.google.com
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

Rather than accessing the attributes of TYPE_CCSR directly, use the SysBusDevice
API which exists exactly for that purpose. Furthermore, registering the memory
region with the SysBusDevice API makes it show up in QMP's `info qom-tree`
command.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/pci-host/ppce500.c | 10 +++++-----
 hw/ppc/e500.c         |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 95b983b2b3..97e5d47cec 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -16,7 +16,6 @@
 
 #include "qemu/osdep.h"
 #include "hw/irq.h"
-#include "hw/ppc/e500-ccsr.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/pci/pci_device.h"
@@ -419,11 +418,12 @@ static const VMStateDescription vmstate_ppce500_pci = {
 static void e500_pcihost_bridge_realize(PCIDevice *d, Error **errp)
 {
     PPCE500PCIBridgeState *b = PPC_E500_PCI_BRIDGE(d);
-    PPCE500CCSRState *ccsr = CCSR(container_get(qdev_get_machine(),
-                                  "/e500-ccsr"));
+    SysBusDevice *ccsr = SYS_BUS_DEVICE(container_get(qdev_get_machine(),
+                                                      "/e500-ccsr"));
+    MemoryRegion *ccsr_space = sysbus_mmio_get_region(ccsr, 0);
 
-    memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0", &ccsr->ccsr_space,
-                             0, int128_get64(ccsr->ccsr_space.size));
+    memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0",
+                             ccsr_space, 0, int128_get64(ccsr_space->size));
     pci_register_bar(d, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &b->bar0);
 }
 
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index e2a4f265a5..2225533e33 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -924,7 +924,6 @@ void ppce500_init(MachineState *machine)
     DriveInfo *dinfo;
     MemoryRegion *ccsr_addr_space;
     SysBusDevice *s;
-    PPCE500CCSRState *ccsr;
     I2CBus *i2c;
 
     irqs = g_new0(IrqLines, smp_cpus);
@@ -980,10 +979,10 @@ void ppce500_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
     dev = qdev_new("e500-ccsr");
+    s = SYS_BUS_DEVICE(dev);
     object_property_add_child(OBJECT(machine), "e500-ccsr", OBJECT(dev));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    ccsr = CCSR(dev);
-    ccsr_addr_space = &ccsr->ccsr_space;
+    sysbus_realize_and_unref(s, &error_fatal);
+    ccsr_addr_space = sysbus_mmio_get_region(s, 0);
     memory_region_add_subregion(address_space_mem, pmc->ccsrbar_base,
                                 ccsr_addr_space);
 
@@ -1270,6 +1269,7 @@ static void e500_ccsr_initfn(Object *obj)
     PPCE500CCSRState *ccsr = CCSR(obj);
     memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
                        MPC8544_CCSRBAR_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(ccsr), &ccsr->ccsr_space);
 }
 
 static const TypeInfo e500_ccsr_info = {
-- 
2.46.2


