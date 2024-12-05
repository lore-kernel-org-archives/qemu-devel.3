Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D064FE7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 13:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJBmK-0005vF-Fo; Thu, 05 Dec 2024 08:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tJBmG-0005pK-3G; Thu, 05 Dec 2024 08:20:21 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tJBm9-0002Qw-2O; Thu, 05 Dec 2024 08:20:15 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa51bf95ce1so165953266b.3; 
 Thu, 05 Dec 2024 05:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733404808; x=1734009608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6KS6mJWvQ2ey495S0Auedhz0o83srQmKO5NX2QJlUDI=;
 b=i8Kj99t2urX873b0EC+MbCSwbJcQzbK6lUN6juHqUIuJ5YxGYzkpEITb43K5mlSUnT
 8hGz0YQdR0uifH1YUCjuaZ2Pxs0anNtctRwcXtyoctF3tZJoZcOf/+GboVPWFn/HU8LR
 A5pNmjrUktU9xOgVdJP4SWYnhbq7i9NCuFSbUdizzUheZ0IbHftghpADaQqw+kd1oYF8
 DaBCmDey0YvfIOgqU64D0Y0bTrWMPXGJW6mRd8sHfEt7aqZdlcrG+m1dmV8M7q7Ce4rr
 2sYuoPT/+q4HxY2mBWiaURnzxk8iftUOZeyXGxWEUPbkgqm6Mat3yyzJOzKdYqzGU8vK
 u2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733404808; x=1734009608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6KS6mJWvQ2ey495S0Auedhz0o83srQmKO5NX2QJlUDI=;
 b=AQZbMO1DFZQImHNPYluhzwFuHhl55HR7cNraOAgvFGT4koFnIixRX3gf02PjOLq4xj
 hZopTcZmd61xnp5yz77NKKo24ayXjI37WM4T2D3RUENQPLxr2/A+IlH0oszI/GWaoiD2
 4Xmoj+0LnvCQlpqCCqifv1+w1iDMUFQNMCvbpqLmrsHbhS8kwD7ATJUknBw/2l1AkUQf
 K21CLo0DF0QhRtsEsjRqpcP3b4uw682WK1yAkTn+sxUEC6nyTX6oDyn+K1eXT6FVgr14
 1bTdn//uGF9jZMQbIertXZpBEsU3+4KnTBHuA74aIUUno8owBv4pD3Nj/T6X/dBshea2
 aRPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMAsw/Mq6iXSTrWavMUFjNpELAoY279mySt2E3DdroSCtF9V/2tJbsiwcM6RJahe6kZ3uja2POmw==@nongnu.org,
 AJvYcCVmMdAEukrQApZyeIlMzO1hrFbVz9+GL+eiK6+vcXBC0T2/JBZhiq6GpPd3zX55yIR5p/R9fuQt7OBD7g==@nongnu.org
X-Gm-Message-State: AOJu0Ywm8JLUfq8QCYruoTk2Rnz5DQm01GPADpoeunRhufhehs2elZf7
 wFYFNPVw1DlcKhoxmGwzLNlQrI5XkZoGDinlA7zWFPKP1kkX7Tae9CyLxQ==
X-Gm-Gg: ASbGncvzh7P9ZShDfr0skC551Iqn3m5xcN5/aHMGuw3hf9SepvmSI1F5Bm9cux42CMc
 kwshbkaXz23A+tTFFTlkVVvdQOIFu2TA/8ePpmhbwE9oRyUfgAaty5Z5YenaIpT0px7/CCg8jRs
 fFRbQcrtBWJjmyDyKD5pj7kPsz6bxbYmaU6X7e3GDBPNgvet+ZGp/XJOaAsbmvD8AwaCt0Um459
 /nzB/JLBKQV7yi2rUZL479Q9tHWpTcOXAAxt6EYYKsn6JKnFMDt30uR7r5XBzKJYZnEEgMYUF0Z
 yVpscZoVmib9d4l7EjOT0awBQjH6ZjrkoiI=
X-Google-Smtp-Source: AGHT+IFyU2G5R09Kj/j1ypPPIsYT0fvdU2aMkmJaXsjs++VUEuTxHAsjdSg8lh6SkM//M8mHjy2OCQ==
X-Received: by 2002:a17:906:1ba2:b0:aa6:21ce:cde3 with SMTP id
 a640c23a62f3a-aa621cecf55mr295904666b.60.1733404807913; 
 Thu, 05 Dec 2024 05:20:07 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-078-054-030-063.78.54.pool.telefonica.de. [78.54.30.63])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa625e92a58sm91959066b.48.2024.12.05.05.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 05:20:07 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 John Snow <jsnow@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 1/2] hw/ide/ahci: Decouple from PCI
Date: Thu,  5 Dec 2024 14:19:36 +0100
Message-ID: <20241205131937.32833-2-shentey@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205131937.32833-1-shentey@gmail.com>
References: <20241205131937.32833-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
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

In some adhoc profiling booting Linux VMs, it's observed that ahci_irq_lower()
can be a hot path (10000+ triggers until login prompt appears). Even though the
parent device never changes, this method re-determines whether the parent device
is a PCI device or not using the rather expensive object_dynamic_cast()
function. Avoid this overhead by pushing the interrupt handling to the parent
device, essentially turning AHCIState into an "IP block".

Note that this change also frees AHCIState from the PCI dependency which wasn't
reflected in Kconfig.

Reported-by: Peter Xu <peterx@redhat.com>
Inspired-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>

--
Supersedes: 20241121100152.65476-1-philmd@linaro.org
---
 hw/ide/ahci-internal.h |  1 -
 include/hw/ide/ahci.h  |  2 --
 hw/ide/ahci.c          | 39 ++++-----------------------------------
 hw/ide/ich.c           | 17 ++++++++++++++++-
 4 files changed, 20 insertions(+), 39 deletions(-)

diff --git a/hw/ide/ahci-internal.h b/hw/ide/ahci-internal.h
index 7e63ea2310..a318f36811 100644
--- a/hw/ide/ahci-internal.h
+++ b/hw/ide/ahci-internal.h
@@ -25,7 +25,6 @@
 #define HW_IDE_AHCI_INTERNAL_H
 
 #include "hw/ide/ahci.h"
-#include "hw/pci/pci_device.h"
 #include "ide-internal.h"
 
 #define AHCI_MEM_BAR_SIZE         0x1000
diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index ba31e75ff9..ac0292c634 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -37,8 +37,6 @@ typedef struct AHCIControlRegs {
 } AHCIControlRegs;
 
 typedef struct AHCIState {
-    DeviceState *container;
-
     AHCIDevice *dev;
     AHCIControlRegs control_regs;
     MemoryRegion mem;
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 0eb24304ee..5836aa924b 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -23,8 +23,6 @@
 
 #include "qemu/osdep.h"
 #include "hw/irq.h"
-#include "hw/pci/msi.h"
-#include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 
@@ -34,8 +32,6 @@
 #include "qemu/module.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
-#include "hw/ide/pci.h"
-#include "hw/ide/ahci-pci.h"
 #include "hw/ide/ahci-sysbus.h"
 #include "ahci-internal.h"
 #include "ide-internal.h"
@@ -179,34 +175,6 @@ static uint32_t ahci_port_read(AHCIState *s, int port, int offset)
     return val;
 }
 
-static void ahci_irq_raise(AHCIState *s)
-{
-    DeviceState *dev_state = s->container;
-    PCIDevice *pci_dev = (PCIDevice *) object_dynamic_cast(OBJECT(dev_state),
-                                                           TYPE_PCI_DEVICE);
-
-    trace_ahci_irq_raise(s);
-
-    if (pci_dev && msi_enabled(pci_dev)) {
-        msi_notify(pci_dev, 0);
-    } else {
-        qemu_irq_raise(s->irq);
-    }
-}
-
-static void ahci_irq_lower(AHCIState *s)
-{
-    DeviceState *dev_state = s->container;
-    PCIDevice *pci_dev = (PCIDevice *) object_dynamic_cast(OBJECT(dev_state),
-                                                           TYPE_PCI_DEVICE);
-
-    trace_ahci_irq_lower(s);
-
-    if (!pci_dev || !msi_enabled(pci_dev)) {
-        qemu_irq_lower(s->irq);
-    }
-}
-
 static void ahci_check_irq(AHCIState *s)
 {
     int i;
@@ -222,9 +190,11 @@ static void ahci_check_irq(AHCIState *s)
     trace_ahci_check_irq(s, old_irq, s->control_regs.irqstatus);
     if (s->control_regs.irqstatus &&
         (s->control_regs.ghc & HOST_CTL_IRQ_EN)) {
-            ahci_irq_raise(s);
+        trace_ahci_irq_raise(s);
+        qemu_irq_raise(s->irq);
     } else {
-        ahci_irq_lower(s);
+        trace_ahci_irq_lower(s);
+        qemu_irq_lower(s->irq);
     }
 }
 
@@ -1608,7 +1578,6 @@ static const IDEDMAOps ahci_dma_ops = {
 
 void ahci_init(AHCIState *s, DeviceState *qdev)
 {
-    s->container = qdev;
     /* XXX BAR size should be 1k, but that breaks, so bump it to 4k for now */
     memory_region_init_io(&s->mem, OBJECT(qdev), &ahci_mem_ops, s,
                           "ahci", AHCI_MEM_BAR_SIZE);
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index b311450c12..066554f6cc 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -91,6 +91,21 @@ static const VMStateDescription vmstate_ich9_ahci = {
     },
 };
 
+static void pci_ich9_ahci_update_irq(void *opaque, int irq_num, int level)
+{
+    PCIDevice *pci_dev = opaque;
+
+    assert(irq_num == 0);
+
+    if (msi_enabled(pci_dev)) {
+        if (level) {
+            msi_notify(pci_dev, 0);
+        }
+    } else {
+        pci_set_irq(pci_dev, level);
+    }
+}
+
 static void pci_ich9_reset(DeviceState *dev)
 {
     AHCIPCIState *d = ICH9_AHCI(dev);
@@ -125,7 +140,7 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
     /* XXX Software should program this register */
     dev->config[0x90]   = 1 << 6; /* Address Map Register - AHCI mode */
 
-    d->ahci.irq = pci_allocate_irq(dev);
+    d->ahci.irq = qemu_allocate_irq(pci_ich9_ahci_update_irq, d, 0);
 
     pci_register_bar(dev, ICH9_IDP_BAR, PCI_BASE_ADDRESS_SPACE_IO,
                      &d->ahci.idp);
-- 
2.47.1


