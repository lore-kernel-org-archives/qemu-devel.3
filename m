Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A35C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 14:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1racSM-0008Uc-Gf; Thu, 15 Feb 2024 09:11:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1racSJ-0008UK-Uz
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:11:15 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1racSI-0006c8-00
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:11:15 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-411fc61a03dso7761705e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 06:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708006270; x=1708611070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KP6i+B6MLL2wkbYjl8abKTqzuoFKsngNSwGHVWde45g=;
 b=bjW9z8wYxkFVY3Gic+ETZJaE/lKHuwSOAavGjuqKlAlFl4TQfSi8Via3Nig+5Uho5b
 ZMS1uI1RACg4elenv5gf9Db0D0aGbtjDepLesNYSCB9zqsn12yWJsJKirG7NtY1i1Qol
 nV3af81Et3AYprNamjPjs29xTl6C6axK50pd85haV3QTRdbLueoXgrkryDk5EdLpRf6V
 L6hWgKJNipdLFfVr9xuUK6XXHRzgUtdsrVcDZlFyCSVl3VA6FRK9S7WHKKd+W/QXzEkP
 ZUNKfaaaOPPnC2sRB2640qiPAqu191kj1diqsgqx+h0r1yugukXfnhtdg+gg0T5XzYHr
 GLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708006270; x=1708611070;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KP6i+B6MLL2wkbYjl8abKTqzuoFKsngNSwGHVWde45g=;
 b=PBQrIzoza9VnUfcZna05HhjfdGb1TFUODuz7ep3kEvdIOvS/+CaQGvyondOzNK3Wkr
 eU2zJqqvaPsD59ZLsF2hhG9YuaklkW2+iTo7/AytMar3gW79k/f2jzoI1e0grs77BmqY
 /BZCFKx3SsAzc6BjTYzcHSSsH5ImMCHYOYPXz5FA+cL+HO5yomCcsVqE5NlHXqfSDlJG
 qB7NQFbrGukD3fJHkGOLFcZ1Y4uC8VB8//dri9L1brY5P1zdUgL7mVnL03zZAxX5NH1b
 KfF1FvUto+kfK1pjO4Z/ERqysswnWj59z/pk55wC+m1XRpEP3pgtiROjmTVrT0btqoEq
 DinQ==
X-Gm-Message-State: AOJu0Yxed1sOKQIy+QTC2vxF3JQRh60oetrXWTwtqtKAPCwv1Z4UMzhJ
 SbcBbXbP+Qlw6czRO8DlkgbqTZolQoMoImottQrbJvSKGnE3DipjUIxw7pOB5iU=
X-Google-Smtp-Source: AGHT+IFwCFqt3BfoswasiB4f+GEoizh5kQ77j6XhpPdWD+Pvi32vkAPOI+RokET9vClrhgu1GJ1sUA==
X-Received: by 2002:a05:600c:384c:b0:412:1954:b9e8 with SMTP id
 s12-20020a05600c384c00b004121954b9e8mr1382586wmr.3.1708006270244; 
 Thu, 15 Feb 2024 06:11:10 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 az32-20020a05600c602000b00411bff9f7cbsm2253684wmb.37.2024.02.15.06.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 06:11:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8FD9E5F8AD;
 Thu, 15 Feb 2024 14:11:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] hw/misc: add a user creatable dummy device for debugging
Date: Thu, 15 Feb 2024 14:10:55 +0000
Message-Id: <20240215141055.55173-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is an experimental patch to allow the creation of unimp regions
from the command line. I'm not sure we would ever merge it as
generally unimp regions are created by the machine definition and
adding your own regions into existing device spaces is likely to break
things pretty badly.

However what I was looking for was a simple way to test that a Xen XFT
test was accessing and trapping where I thought it was without hacking
up the machine models themselves. It allows the addition of unimp
regions to specific address spaces as in the future we shouldn't rely
on sysbus being the default but it's pretty clunky as you need to
intuit the full QOM path of the region, e.g.:

  /qemu-system-aarch64 -machine fby35 --display none \
    -serial mon:stdio -d unimp \
    --device dummy-device,name=dummy1,offset=0x10001000,size=0x1000,x-address-space="/machine/unattached/fsi.opb[0]"

Then running info mtree -f shows:

  ...
  FlatView #15
   AS "fsi.opb", root: fsi.opb
   Root memory region: fsi.opb
    0000000010001000-0000000010001fff (prio 0, i/o): dummy1
    0000000080000000-000000008fffffff (prio 0, i/o): fsi.master
    00000000a0000000-00000000a00003ff (prio 0, i/o): cfam.config
    00000000a0000400-00000000a00007ff (prio 0, i/o): cfam @0000000000000400
    00000000a0000800-00000000a0000bff (prio 0, i/o): fsi.slave
    00000000a0000c00-00000000a0000fff (prio 0, i/o): fsi.scratchpad
    00000000a0001000-00000000a01fffff (prio 0, i/o): cfam @0000000000001000

No need to review this RFC unless you particularly think this would be
useful to develop further.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/dummy.c     | 97 +++++++++++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build |  2 +-
 2 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/dummy.c

diff --git a/hw/misc/dummy.c b/hw/misc/dummy.c
new file mode 100644
index 00000000000..701c3468951
--- /dev/null
+++ b/hw/misc/dummy.c
@@ -0,0 +1,97 @@
+/*
+ * user creatable dummy device wrapper
+ *
+ * This is a simple wrapper around the unimp device
+ *
+ * Copyright (c) 2024 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "exec/address-spaces.h"
+#include "hw/misc/unimp.h"
+
+#define TYPE_DUMMY_DEVICE "dummy-device"
+
+OBJECT_DECLARE_SIMPLE_TYPE(DummyDeviceState, DUMMY_DEVICE)
+
+struct DummyDeviceState {
+    DeviceState parent_obj;
+
+    DeviceState *unimp;
+
+    MemoryRegion *mr;
+
+    char *name;
+    char *as_name;
+    uint64_t offset;
+    uint64_t size;
+};
+
+static void dummy_realize(DeviceState *dev, Error **errp)
+{
+    DummyDeviceState *s = DUMMY_DEVICE(dev);
+
+    if (s->size == 0) {
+        error_setg(errp, "property 'size' not specified or zero");
+        return;
+    }
+
+    if (s->name == NULL) {
+        error_setg(errp, "property 'name' not specified");
+        return;
+    }
+
+    if (s->as_name == NULL) {
+        s->mr = get_system_memory();
+    } else {
+        bool ambiguous = false;
+        /* this needs to be a full path. e.g. /machine/unattached/foo[0] */
+        Object *obj = object_resolve_path_type(s->as_name, TYPE_MEMORY_REGION, &ambiguous);
+        if (!obj || ambiguous) {
+            error_setg(errp, "Unable to find %s to locate region", s->as_name);
+            return;
+        }
+        s->mr = MEMORY_REGION(obj);
+    }
+
+    /*
+     * While this is a test device we don't want to make it too easy
+     * to shoot yourself in the foot.
+     */
+    s->unimp = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
+    qdev_prop_set_string(s->unimp, "name", s->name);
+    qdev_prop_set_uint64(s->unimp, "size", s->size);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s->unimp), &error_fatal);
+
+    /* Now lets map it to memory */
+    memory_region_add_subregion_overlap(s->mr, s->offset, &UNIMPLEMENTED_DEVICE(s->unimp)->iomem, 0);
+}
+
+static Property dummy_properties[] = {
+    DEFINE_PROP_UINT64("offset", DummyDeviceState, offset, 0),
+    DEFINE_PROP_UINT64("size", DummyDeviceState, size, 0),
+    DEFINE_PROP_STRING("name", DummyDeviceState, name),
+    DEFINE_PROP_STRING("x-address-space", DummyDeviceState, as_name),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void dummy_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = dummy_realize;
+    device_class_set_props(dc, dummy_properties);
+}
+
+static const TypeInfo dummy_devices[]  = {
+    {
+        .name = TYPE_DUMMY_DEVICE,
+        .parent = TYPE_DEVICE,
+        .instance_size = sizeof(DummyDeviceState),
+        .class_init = dummy_class_init,
+    }
+};
+
+DEFINE_TYPES(dummy_devices)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index e4ef1da5a53..309314e2398 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -5,7 +5,7 @@ system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugexit.c'))
 system_ss.add(when: 'CONFIG_ISA_TESTDEV', if_true: files('pc-testdev.c'))
 system_ss.add(when: 'CONFIG_PCA9552', if_true: files('pca9552.c'))
 system_ss.add(when: 'CONFIG_PCI_TESTDEV', if_true: files('pci-testdev.c'))
-system_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
+system_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c', 'dummy.c'))
 system_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
 system_ss.add(when: 'CONFIG_LED', if_true: files('led.c'))
 system_ss.add(when: 'CONFIG_PVPANIC_COMMON', if_true: files('pvpanic.c'))
-- 
2.39.2


