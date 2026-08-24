Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82117C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNEL-0008M9-Rq; Mon, 24 Aug 2026 01:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wyNEH-0008LN-C0
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:28:17 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wyNEF-0006f6-NS
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:28:17 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-ca12086c06eso2310522a12.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787549294; x=1788154094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GBf7j30tCwZkHaEPfJB/Zz5KRf4bjAJ+JkM3UIPIc40=;
 b=Ee30XnYajfQoO3JYmuNfTI82rH6MfKBz+1A1Bgk3Wd7/uiz/zomLbYx41WxiDrZsz0
 wSpRuifFD2wrGdWSYtQhLlwYrPEQ/HVMvOv5sWMZgUSTO1E159hhq7SrVi0K+Jfz5sVC
 qJMw30FSrfrTUIZy+NaUKH6HeeUYWii2VHrKUZUP3m0MP6dDtwUtTBSbD8W22xkbtWrk
 /Y+X5HhX7I4nieOMS1o853Lcv/H5KDHg6lByZiP3sigoqaUqKEPG0HfW2Ju4ILU2KnN7
 O2cHXaorX0tnuQV0ZoxDnV9m/NvYdxR1+YQ8931INvA08hHhhCjeJnQji0tTKZ18YpeS
 xV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787549294; x=1788154094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GBf7j30tCwZkHaEPfJB/Zz5KRf4bjAJ+JkM3UIPIc40=;
 b=LcO78nfvVzJ6JXGFvuuxg3KuhrygEUIlPsyHlgYss+2RclOKXDfgKOyC1SXcKdxICf
 ljxyH+4bY4fefovYAGEX4oPbdw3bcao4Ouaxuuz432s0H4nHYW8VJRdg6vSN9c13oAFP
 IAf4309DwmARx553cxsguiotsg+qj1s0ovrLIgPVGLoZz0yVtq8JAUumOWp4Hm9bpxoY
 zgH/LiBga2AOVg7CzPQV09N8BqQM4iz/4ZDLrWG/K+XNgq27qpgsYASC6ayTgYuAon32
 ZMBXawjJN2i0B2wpw3h92CPdkRvZzI1fEhqG43jmcRP9nL+lTDtu8JLlA5QGQSquJR8D
 fvHA==
X-Gm-Message-State: AFuF++mjVmOEv0vdielFGPSSdZe/h7FfxltyNjZuEiX9ZbGiIKH5dKYR
 Ib9jNUL/tycE8bGlNJNCGXQRNEpqmbKAe/7PzMEiyzcfriqZMBgDFaZ17lCU5Q==
X-Gm-Gg: AR+sD10ZY5ndbBI5SnWWIayf+L/DsHmxzNpgd3tcd4B3XgGniygL8ndVJiePL9T0iJW
 hOB6b1otVjCJT0tYb0gw+1LqJ21Dtk6mtrM+HSOpPltIMv43jetn8OEq2pOjvVfEkoifdcISYtQ
 31WAglCbFpuHLY/WpUDTJD6L5tfilGrVvHMyJXVmjSe9eF0QOFKUCp/SVhqWCQul+wNr8KE2sOf
 VKVWJA4hIzTHGlXHaMgB99jC2xVoYhErLqFHZ2W82jstscuS7mXBS/fC/hYnS07G7B7+Swsbb5f
 pGiSHkTACIrLJY1U5Fgb776q+tyOdBTYHOpW8MXeUZy/cKW+uTEIBSUMikm8TAGmM0UNgV/qdHp
 SWQJYTFgffILPO/QBVgOniI1uBHw3ZRfXAYI5Dn+hLZ7qbcvGyoASJB7/lxS4yiBCKye0hFMOQq
 cdz/aNytpSDVnjU4Hpc/ij/LSSGtx2dxSUjxdHr2lYVTr/yIlAboBs9aHdWe8jqIypdmahM91z3
 S+s
X-Received: by 2002:a17:90b:280a:b0:38e:bfe:81e9 with SMTP id
 98e67ed59e1d1-395dee56103mr31979891a91.1.1787549293998; 
 Sun, 23 Aug 2026 22:28:13 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e494f9fdsm8557346a91.3.2026.08.23.22.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:28:13 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com, mikail.sadic@ibm.com,
 clg@kaod.org, Jeuk Kim <jeuk20.kim@gmail.com>
Subject: [PULL 2/2] hw/ufs: Add a generic SysBus frontend
Date: Mon, 24 Aug 2026 14:27:56 +0900
Message-ID: <6ed05d5e65208a5ee23a02667d5df0dc6491c156.1787548791.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787548791.git.jeuk20.kim@samsung.com>
References: <cover.1787548791.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 hw/ufs/ufs-sysbus.c | 80 +++++++++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs-sysbus.h | 22 +++++++++++++
 4 files changed, 107 insertions(+)
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
index 0000000000..84de2e95ac
--- /dev/null
+++ b/hw/ufs/ufs-sysbus.c
@@ -0,0 +1,80 @@
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
+    DEFINE_PROP_UINT8("mcq-maxq", SysbusUfsState, ufs.params.mcq_maxq, 2),
+    DEFINE_PROP_UINT32("wb-max-size", SysbusUfsState, ufs.params.wb_max_size,
+                       0x400),
+    DEFINE_PROP_UINT32("wb-min-size", SysbusUfsState, ufs.params.wb_min_size,
+                       0x100),
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


