Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B84C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctzd-0002WI-Dk; Wed, 21 Feb 2024 16:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctzO-0001P3-5o
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:18:55 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctzJ-0001Dv-If
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:18:49 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3394ca0c874so3915184f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550323; x=1709155123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfxMxGGGcVex8fdynjVIKbNEXslFjUR/0YwN6ul07SQ=;
 b=WcwmGaNbrsJ+LjDufUCLGA347RjWRYf5kVuIQIHlU9nBhVgdG8tKcjOwQFzAxm+AA+
 jnkRui0VVIU10WuPVODy5PwtE7GhgHr7P79gDj5ode2YIBYVv4tT55la6AbXT8O1JWQP
 7Id385EoHEQ1l6NtI3SJESSRozI/D3LR6qrvBf00fB36VRC+kENHSjRxPj5Pqvxsx7QO
 WyE+JwLOLsGRYxVZIF6W/m5N7q/HbVBqCrmMdmw0rfDvnESBVnkpt+3zrUbo9/Xxe35F
 qqpdxLP0hfGoTALERZRvwvwrqtMrDsxt467SyUp9sU3gGd8WzafgsP78sV8WXBC3CxsJ
 1H6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550323; x=1709155123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vfxMxGGGcVex8fdynjVIKbNEXslFjUR/0YwN6ul07SQ=;
 b=RPin9tTV4lvq74d3iS+buBffD25YUkznhlmAAUTWa84Qmquu/jMQBJ6C9+ir08FSbq
 L2vY5qLEim30PixM1qI3f9pijZx6Ksrw+6l2xLCFVltqrS4mZAjT0ak+WJVHp3w6tl2J
 fNiV7DL2aGuhBQNwQLcrbfSIcDj5sIJzcNM7xy8m5/eojMsoapw4cfqSPjFo1mjE16tf
 vFpQE910fGr1IKIE/7nMDUboggfvhRUnZx+In8lhALohfCliTaVHiLyfCGTJ4BE+S4Ff
 JU1qQ22X42tI6m4STmnxNAEUfMuuixk9/x9cVbBFnMJVZUaxGoWYiiH3aoGcWidmhhL0
 fF/g==
X-Gm-Message-State: AOJu0YxR1LGysWNWEYnGLrHVypogBZQpPXDcHH5/Lrl4j0eukzSzxcOp
 SRbFsjDTpPw7PXihKTPDTaBz2xXJpvT7r78Q5gFekN3DoDJudlvZ2VHiypWGMLQdV2/APqmhpTf
 V7QA=
X-Google-Smtp-Source: AGHT+IFBX2qapA5BTI4TKGBakxxbaYDSRqOO95Na3ED+H1D2Ur7W4oCtszDE/+oxCEBApvG0QMGFtQ==
X-Received: by 2002:a05:6000:118a:b0:33d:66be:6da4 with SMTP id
 g10-20020a056000118a00b0033d66be6da4mr4380687wrx.29.1708550323494; 
 Wed, 21 Feb 2024 13:18:43 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 x4-20020adff644000000b0033b792ed609sm18116174wrp.91.2024.02.21.13.18.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:18:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PULL 18/25] hw/ide: Add the possibility to disable the CompactFlash
 device in the build
Date: Wed, 21 Feb 2024 22:16:18 +0100
Message-ID: <20240221211626.48190-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

For distros like downstream RHEL, it would be helpful to allow to disable
the CompactFlash device. For making this possible, we need a separate
Kconfig switch for this device, and the code should reside in a separate
file. Let's also introduce a new header ide-dev.h which can be used to
collect definitions related to IDE devices.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20240220085505.30255-2-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ide/ide-dev.h | 41 ++++++++++++++++++++++++++++
 hw/ide/cf.c              | 58 ++++++++++++++++++++++++++++++++++++++++
 hw/ide/qdev.c            | 51 ++---------------------------------
 hw/ide/Kconfig           |  4 +++
 hw/ide/meson.build       |  1 +
 5 files changed, 106 insertions(+), 49 deletions(-)
 create mode 100644 include/hw/ide/ide-dev.h
 create mode 100644 hw/ide/cf.c

diff --git a/include/hw/ide/ide-dev.h b/include/hw/ide/ide-dev.h
new file mode 100644
index 0000000000..7e9663cda9
--- /dev/null
+++ b/include/hw/ide/ide-dev.h
@@ -0,0 +1,41 @@
+/*
+ * ide device definitions
+ *
+ * Copyright (c) 2009 Gerd Hoffmann <kraxel@redhat.com>
+ *
+ * This code is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef IDE_DEV_H
+#define IDE_DEV_H
+
+#include "hw/qdev-properties.h"
+#include "hw/block/block.h"
+#include "hw/ide/internal.h"
+
+typedef struct IDEDrive {
+    IDEDevice dev;
+} IDEDrive;
+
+#define DEFINE_IDE_DEV_PROPERTIES()                     \
+    DEFINE_BLOCK_PROPERTIES(IDEDrive, dev.conf),        \
+    DEFINE_BLOCK_ERROR_PROPERTIES(IDEDrive, dev.conf),  \
+    DEFINE_PROP_STRING("ver",  IDEDrive, dev.version),  \
+    DEFINE_PROP_UINT64("wwn",  IDEDrive, dev.wwn, 0),   \
+    DEFINE_PROP_STRING("serial",  IDEDrive, dev.serial),\
+    DEFINE_PROP_STRING("model", IDEDrive, dev.model)
+
+void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp);
+
+#endif
diff --git a/hw/ide/cf.c b/hw/ide/cf.c
new file mode 100644
index 0000000000..2a425cb0f2
--- /dev/null
+++ b/hw/ide/cf.c
@@ -0,0 +1,58 @@
+/*
+ * ide CompactFlash support
+ *
+ * This code is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/ide/ide-dev.h"
+#include "qapi/qapi-types-block.h"
+
+static void ide_cf_realize(IDEDevice *dev, Error **errp)
+{
+    ide_dev_initfn(dev, IDE_CFATA, errp);
+}
+
+static Property ide_cf_properties[] = {
+    DEFINE_IDE_DEV_PROPERTIES(),
+    DEFINE_BLOCK_CHS_PROPERTIES(IDEDrive, dev.conf),
+    DEFINE_PROP_BIOS_CHS_TRANS("bios-chs-trans",
+                IDEDrive, dev.chs_trans, BIOS_ATA_TRANSLATION_AUTO),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void ide_cf_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    IDEDeviceClass *k = IDE_DEVICE_CLASS(klass);
+
+    k->realize  = ide_cf_realize;
+    dc->fw_name = "drive";
+    dc->desc    = "virtual CompactFlash card";
+    device_class_set_props(dc, ide_cf_properties);
+}
+
+static const TypeInfo ide_cf_info = {
+    .name          = "ide-cf",
+    .parent        = TYPE_IDE_DEVICE,
+    .instance_size = sizeof(IDEDrive),
+    .class_init    = ide_cf_class_init,
+};
+
+static void ide_cf_register_type(void)
+{
+    type_register_static(&ide_cf_info);
+}
+
+type_init(ide_cf_register_type)
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 1b3b4da01d..4189313d30 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -24,12 +24,9 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
-#include "hw/ide/internal.h"
-#include "hw/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/ide/ide-dev.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
-#include "hw/block/block.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/runstate.h"
 #include "qapi/visitor.h"
@@ -158,11 +155,7 @@ int ide_get_bios_chs_trans(BusState *bus, int unit)
 
 /* --------------------------------- */
 
-typedef struct IDEDrive {
-    IDEDevice dev;
-} IDEDrive;
-
-static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
+void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
 {
     IDEBus *bus = DO_UPCAST(IDEBus, qbus, dev->qdev.parent_bus);
     IDEState *s = bus->ifs + dev->unit;
@@ -283,19 +276,6 @@ static void ide_cd_realize(IDEDevice *dev, Error **errp)
     ide_dev_initfn(dev, IDE_CD, errp);
 }
 
-static void ide_cf_realize(IDEDevice *dev, Error **errp)
-{
-    ide_dev_initfn(dev, IDE_CFATA, errp);
-}
-
-#define DEFINE_IDE_DEV_PROPERTIES()                     \
-    DEFINE_BLOCK_PROPERTIES(IDEDrive, dev.conf),        \
-    DEFINE_BLOCK_ERROR_PROPERTIES(IDEDrive, dev.conf),  \
-    DEFINE_PROP_STRING("ver",  IDEDrive, dev.version),  \
-    DEFINE_PROP_UINT64("wwn",  IDEDrive, dev.wwn, 0),   \
-    DEFINE_PROP_STRING("serial",  IDEDrive, dev.serial),\
-    DEFINE_PROP_STRING("model", IDEDrive, dev.model)
-
 static Property ide_hd_properties[] = {
     DEFINE_IDE_DEV_PROPERTIES(),
     DEFINE_BLOCK_CHS_PROPERTIES(IDEDrive, dev.conf),
@@ -346,32 +326,6 @@ static const TypeInfo ide_cd_info = {
     .class_init    = ide_cd_class_init,
 };
 
-static Property ide_cf_properties[] = {
-    DEFINE_IDE_DEV_PROPERTIES(),
-    DEFINE_BLOCK_CHS_PROPERTIES(IDEDrive, dev.conf),
-    DEFINE_PROP_BIOS_CHS_TRANS("bios-chs-trans",
-                IDEDrive, dev.chs_trans, BIOS_ATA_TRANSLATION_AUTO),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void ide_cf_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    IDEDeviceClass *k = IDE_DEVICE_CLASS(klass);
-
-    k->realize  = ide_cf_realize;
-    dc->fw_name = "drive";
-    dc->desc    = "virtual CompactFlash card";
-    device_class_set_props(dc, ide_cf_properties);
-}
-
-static const TypeInfo ide_cf_info = {
-    .name          = "ide-cf",
-    .parent        = TYPE_IDE_DEVICE,
-    .instance_size = sizeof(IDEDrive),
-    .class_init    = ide_cf_class_init,
-};
-
 static void ide_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
@@ -396,7 +350,6 @@ static void ide_register_types(void)
     type_register_static(&ide_bus_info);
     type_register_static(&ide_hd_info);
     type_register_static(&ide_cd_info);
-    type_register_static(&ide_cf_info);
     type_register_static(&ide_device_type_info);
 }
 
diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
index dd85fa3619..b93d6743d5 100644
--- a/hw/ide/Kconfig
+++ b/hw/ide/Kconfig
@@ -57,3 +57,7 @@ config IDE_SII3112
     bool
     select IDE_PCI
     select IDE_QDEV
+
+config IDE_CF
+    bool
+    default y if IDE_QDEV
diff --git a/hw/ide/meson.build b/hw/ide/meson.build
index e050eef942..d2e5b45c9e 100644
--- a/hw/ide/meson.build
+++ b/hw/ide/meson.build
@@ -1,6 +1,7 @@
 system_ss.add(when: 'CONFIG_AHCI', if_true: files('ahci.c'))
 system_ss.add(when: 'CONFIG_AHCI_ICH9', if_true: files('ich.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('ahci-allwinner.c'))
+system_ss.add(when: 'CONFIG_IDE_CF', if_true: files('cf.c'))
 system_ss.add(when: 'CONFIG_IDE_CMD646', if_true: files('cmd646.c'))
 system_ss.add(when: 'CONFIG_IDE_CORE', if_true: files('core.c', 'atapi.c'))
 system_ss.add(when: 'CONFIG_IDE_ISA', if_true: files('isa.c', 'ioport.c'))
-- 
2.41.0


