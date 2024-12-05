Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50406E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 11:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJAIZ-0006b4-3L; Thu, 05 Dec 2024 06:45:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tJAIH-0006Zd-AO; Thu, 05 Dec 2024 06:45:19 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tJAIB-0006B1-3g; Thu, 05 Dec 2024 06:45:15 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5ceb03aadb1so1041232a12.0; 
 Thu, 05 Dec 2024 03:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733399108; x=1734003908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9s0hMfjvbYQ/LKkihNMA1CzdcUWVB98CacXxz3Ckk3I=;
 b=UoWOFaWM3P2MfyYPp6axxV7S3N7Bb4rLq1QXo5iavJPVZjoyUeRABEEzaiwOIQyoku
 +M7+qN8L/cW/ubfqBmmvU5iOiJknVRhTpPXsFYqn/9qygboEPQPn3xLgm3gs0QzwTZWc
 q2lqiDLr8bOGDspUJcafD8QWIh98wNHDjLGs6L2qfPgndOKCw4+laizGFy4XtuejaF+J
 u9kcknFp6Fk9BQPVSAQGB0Y9VT/YgSvLXMnmmxgmlvwcLx6ahYq2rjXLhgGt9NpYSvuO
 qhs3ThsVX45G948ZYqxKQpYXXXhnbB8lcs9L/HJgSgw0ld0OrpLpjOfPYuoT7Y82VPO5
 q++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733399108; x=1734003908;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9s0hMfjvbYQ/LKkihNMA1CzdcUWVB98CacXxz3Ckk3I=;
 b=N2T6K/fqsH0fawlz/lF3/3KSw4IEY8koplJ290owwuAbuIEzAN9X1GkIPGBYGCXVDx
 rWr7Wnxw2C/bR+gw2/Ke3IQN7diPhj3J7RLe7VTse6J+BOWX027BLRlAKpxKSdU8KDQl
 fStz1b8fAq1DlqvCuj/bFqBSKYPaTow95g+z2vInfgMh8gEzMqP1qgEClhiBU2kzfo5L
 af7bSVHKL+cE1dKkudLrVDZ81F3+9sYws+9GYpym7HJEPUwkd+hG/BGll3WRTyXRW8jq
 Zbp/VLpiLY654jlT8mUOzTjAZYJymwPhlDTRLKm+4f9//+UTtSPCmTVD0dmBOimS8w++
 SsIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdf2gnV+7UyrdfEC90krkb27KhWW04iR5cyl/lNwJiKZHHMmMVRcJgGXqjbS8qhL9GzhUkclwbzH6a@nongnu.org
X-Gm-Message-State: AOJu0YzkpavqUvZsk7Wsj20XjIuTzLo547AshlHfS7AYhrD73KCrHtJx
 FNLIZ0jYInaboC7uW6E4GFvQGSOkwqpl3pYW9ONrZbvgfqA0I/zDn5q1bQ==
X-Gm-Gg: ASbGncsN5vB0Nb60EQuikZGnPHDlg7HqsrzqWT6mEvhJbvL40tFfx8NA5TqNPkgEfNa
 iEzXPchYN81bzhUWV1HRI/qJ5JvpU+kPTGcxli8UfmoxeHlNCkZrSa7JTl76H4NREG5gh2Y36f1
 lqV1weW5NyroQhveBh3J4pYPH67SO4vUcQbo5aakHp/ymWztlZQ9P6mWQjjm6FZNbrVpPz5BHFM
 YN8LOLwPb9hwN5G8vBF5A0THaRd3eSPw8xlKsgbvxvde0ngv+2EKumPBHoLBHLUywWN4Dwnlwoj
 26aNg8SkBDpnY7R52Zzy8kVi/TZEPYo0dQQ=
X-Google-Smtp-Source: AGHT+IH0TqIHy0EgoWQIfI1on1+lUMp9fYNz8V5TTWeD3rD8GC0JGW1UXIhsbe5QsyzLi2qklYp1yw==
X-Received: by 2002:a05:6402:35cf:b0:5d0:bcdd:ffa7 with SMTP id
 4fb4d7f45d1cf-5d10cb4d121mr12722998a12.3.1733399107642; 
 Thu, 05 Dec 2024 03:45:07 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-078-054-030-063.78.54.pool.telefonica.de. [78.54.30.63])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa625e4db2dsm80317666b.9.2024.12.05.03.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 03:45:07 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Peter Xu <peterx@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2] hw/ide/ahci: Decouple from PCI
Date: Thu,  5 Dec 2024 12:44:53 +0100
Message-ID: <20241205114453.1848-1-shentey@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 include/hw/ide/ahci.h |  2 --
 hw/ide/ahci.c         | 39 ++++-----------------------------------
 hw/ide/ich.c          | 17 ++++++++++++++++-
 3 files changed, 20 insertions(+), 38 deletions(-)

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


