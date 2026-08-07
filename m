Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F843C5AC7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsHxx-0007TL-Jw; Fri, 07 Aug 2026 06:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wsHxq-0007SJ-LT
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 06:38:11 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wsHxo-0001Jn-RT
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 06:38:10 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38dcbade417so2651426a91.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 03:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786099087; x=1786703887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dv9GQYEPppTXcN6LQExNF2JV9HtFyHHwJH4DTkJGYpc=;
 b=POrY9HueCYqhCMsomnTrFPG58wMCbuAHeWXHbqKbluZQm6ARYzuPk8HwT4bcULveDR
 iIDZhaU0uOntjyRL7SD3+bVjE5p9ix8w2U2++K+CD6gG/6Z/GP66qxFSBZv5ambWYscp
 nCw1rqSvcrFS1bOdRx8x0wUXbF9CoXBlhaaD7H2ABSdtUA4UUVqey3D2YxZf8ks8vF+6
 FheF5XvCeQkrIh9l9UzT9jocGcmq6hoPqn3mqfjhLq3UNg04uJqLWxt60PrUqdY1h/hN
 hJOfapYEY4pJ4sv3956Z5DYX5KZco7ECO7V3GX8gPVLcQU+clW8pmYxlkazEXjXs+7Py
 fwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786099087; x=1786703887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dv9GQYEPppTXcN6LQExNF2JV9HtFyHHwJH4DTkJGYpc=;
 b=XOvl85qrxhG3CAWezPaYKFw46nEPHlE/cVsW5ij3x6CfFMpMb+n6M7D8SlBzbufYxw
 IXCfdOytOmyAuoBQzvDfT84GX1x93tctr6EPySah1BMo+2fxKcDvfMVahhtCAi5fDDWH
 7l081uSCzHPFIlaT2PLerqpMEZyD+BAbwn/kzj9HaNh6GtulT/jHb1NBH2F0hayd9wHS
 XOauMMoaD6r+n09JA4rDyr5QgzTgjNGXwo0Jc/WsPG0pxH7LUkgfogh+UHao2rdaihaS
 ZTn6Z0tl2vnPpwynB1A2kzJ22A+l8JFnEN+HFElHOzMGM5CpbyAFj7J6CG8OsLQUg2Vu
 i/fw==
X-Gm-Message-State: AOJu0Ywf4K9EMyJ+Gvdwsmb0Pyg5BO7Dp5MOFCO//+kT2ZRtBbIgu8Hi
 3NdYl2geAYI64bNAL4WVk3S8Yf7r/1o1cAO53efurRHqWSDPzkc28TqJ6ZiCiQ==
X-Gm-Gg: AR+sD13gL+4QWiDBQYcViepahTJdhn24JPlM96arJ4pCjD/PzTLWMyy95goqdEt9ys0
 8+OtvWbWDwTQFel9boM2DVModIN+1PtQUPiw+jl5gk/X6DCdUTf7vwLS6stDwFvzVBSpzNiMC5Z
 Cgk/2ZgkAYGMDYc2oNKmy+/UOBP2KFfpUXFpF17FK1Hw+DIV2jSxVopx6YNZQbe3XL+FJtOUpvs
 uo9ni/VQcP9cCraveSZW5cIWxr8Qnt2T2vEYgm8S9uivTtUU/ua0zTZA26teEFvBHjAWb3byfR1
 9rGbP4UyvMcthhH7/NTzLVe5S1dy3dJJtMjvr2lies4wILqXotzhxyQwxxroKlPnS1gUuW+7EWB
 JiRnd4SUS1kBPALWFTQ+TFH2a0I+s0awqIp6uZBTDVwigwitlHqbaROcmJmuHZXLBK7FnGih77T
 EuP9F6ZKfriIYv6SGffwtYOnnqQqdAQF8LyDrCt6w+jJ05fKUVCSfVOZ3SEw4ydme62DtTvsvz7
 f2a0HM=
X-Received: by 2002:a17:90b:1f8f:b0:38f:837e:fc5d with SMTP id
 98e67ed59e1d1-3903c542eaamr22637600a91.3.1786099087266; 
 Fri, 07 Aug 2026 03:38:07 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085c393d5sm4474743a91.0.2026.08.07.03.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 03:38:06 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, pbonzini@redhat.com, qemu-block@nongnu.org,
 j-young.choi@samsung.com, mikail.sadic@ibm.com, hyenc.jeong@samsung.com
Subject: [PATCH 2/2] hw/ufs: Add a generic SysBus frontend
Date: Fri,  7 Aug 2026 19:36:17 +0900
Message-ID: <0d786da9f86269d4abd2a06c73a45d18db6a7a04.1786096976.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1786096976.git.jeuk20.kim@samsung.com>
References: <cover.1786096976.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x1033.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add TYPE_SYSBUS_UFS as a reusable frontend for the
transport-independent UFS controller core.

Use the system memory address space for DMA, expose the controller MMIO
region and IRQ through SysBus, and provide the same properties and
migration policy as the PCI frontend. Platform-specific controllers can
derive from this type and keep only their hardware-specific behavior.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/Kconfig      |  4 +++
 hw/ufs/meson.build  |  1 +
 hw/ufs/ufs-sysbus.c | 81 +++++++++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs-sysbus.h | 22 ++++++++++++
 4 files changed, 108 insertions(+)
 create mode 100644 hw/ufs/ufs-sysbus.c
 create mode 100644 hw/ufs/ufs-sysbus.h

diff --git a/hw/ufs/Kconfig b/hw/ufs/Kconfig
index 47e28a30ea..0e40f08a41 100644
--- a/hw/ufs/Kconfig
+++ b/hw/ufs/Kconfig
@@ -7,3 +7,7 @@ config UFS_PCI
     default y if PCI_DEVICES
     depends on PCI
     select UFS
+
+config UFS_SYSBUS
+    bool
+    select UFS
diff --git a/hw/ufs/meson.build b/hw/ufs/meson.build
index 880fc52c05..a84627b96a 100644
--- a/hw/ufs/meson.build
+++ b/hw/ufs/meson.build
@@ -1,2 +1,3 @@
 system_ss.add(when: 'CONFIG_UFS', if_true: files('ufs.c', 'lu.c'))
 system_ss.add(when: 'CONFIG_UFS_PCI', if_true: files('ufs-pci.c'))
+system_ss.add(when: 'CONFIG_UFS_SYSBUS', if_true: files('ufs-sysbus.c'))
diff --git a/hw/ufs/ufs-sysbus.c b/hw/ufs/ufs-sysbus.c
new file mode 100644
index 0000000000..e811d967e2
--- /dev/null
+++ b/hw/ufs/ufs-sysbus.c
@@ -0,0 +1,81 @@
+/*
+ * QEMU Universal Flash Storage (UFS) sysbus controller
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/qdev-properties.h"
+#include "ufs-sysbus.h"
+#include "migration/vmstate.h"
+#include "system/address-spaces.h"
+
+static void ufs_sysbus_realize(DeviceState *dev, Error **errp)
+{
+    SysbusUfsState *s = SYSBUS_UFS(dev);
+
+    if (!ufs_realize(&s->ufs, dev, &address_space_memory, errp)) {
+        return;
+    }
+
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->ufs.iomem);
+}
+
+static void ufs_sysbus_unrealize(DeviceState *dev)
+{
+    SysbusUfsState *s = SYSBUS_UFS(dev);
+
+    ufs_unrealize(&s->ufs);
+}
+
+static void ufs_sysbus_init(Object *obj)
+{
+    SysbusUfsState *s = SYSBUS_UFS(obj);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->ufs.irq);
+}
+
+static const Property ufs_sysbus_props[] = {
+    DEFINE_PROP_STRING("serial", SysbusUfsState, ufs.params.serial),
+    DEFINE_PROP_UINT8("nutrs", SysbusUfsState, ufs.params.nutrs, 32),
+    DEFINE_PROP_UINT8("nutmrs", SysbusUfsState, ufs.params.nutmrs, 8),
+    DEFINE_PROP_BOOL("mcq", SysbusUfsState, ufs.params.mcq, false),
+    DEFINE_PROP_UINT8("mcq-maxq", SysbusUfsState,
+                      ufs.params.mcq_maxq, 2),
+    DEFINE_PROP_UINT32("wb-max-size", SysbusUfsState,
+                       ufs.params.wb_max_size, 0x400),
+    DEFINE_PROP_UINT32("wb-min-size", SysbusUfsState,
+                       ufs.params.wb_min_size, 0x100),
+};
+
+static const VMStateDescription ufs_sysbus_vmstate = {
+    .name = TYPE_SYSBUS_UFS,
+    .unmigratable = 1,
+};
+
+static void ufs_sysbus_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = ufs_sysbus_realize;
+    dc->unrealize = ufs_sysbus_unrealize;
+    dc->vmsd = &ufs_sysbus_vmstate;
+    dc->desc = "Universal Flash Storage";
+    device_class_set_props(dc, ufs_sysbus_props);
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+}
+
+static const TypeInfo ufs_sysbus_info = {
+    .name = TYPE_SYSBUS_UFS,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SysbusUfsState),
+    .instance_init = ufs_sysbus_init,
+    .class_init = ufs_sysbus_class_init,
+};
+
+static void ufs_sysbus_register_types(void)
+{
+    type_register_static(&ufs_sysbus_info);
+}
+
+type_init(ufs_sysbus_register_types)
diff --git a/hw/ufs/ufs-sysbus.h b/hw/ufs/ufs-sysbus.h
new file mode 100644
index 0000000000..71b6787d3a
--- /dev/null
+++ b/hw/ufs/ufs-sysbus.h
@@ -0,0 +1,22 @@
+/*
+ * QEMU Universal Flash Storage (UFS) sysbus controller
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_UFS_UFS_SYSBUS_H
+#define HW_UFS_UFS_SYSBUS_H
+
+#include "hw/core/sysbus.h"
+#include "ufs.h"
+
+#define TYPE_SYSBUS_UFS "sysbus-ufs"
+OBJECT_DECLARE_SIMPLE_TYPE(SysbusUfsState, SYSBUS_UFS)
+
+struct SysbusUfsState {
+    SysBusDevice parent_obj;
+
+    UfsHc ufs;
+};
+
+#endif /* HW_UFS_UFS_SYSBUS_H */
-- 
2.43.0


