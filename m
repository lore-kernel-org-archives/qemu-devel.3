Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE94AE7718D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 22:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPqkA-0002DX-Fi; Mon, 23 Dec 2024 17:17:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tPqjm-00021L-Eo
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 17:17:18 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tPqji-0006yf-N0
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 17:17:17 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so48365695e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 14:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734992230; x=1735597030;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nSPynu/TsTtjPcRM35CFCvp80g/vZQK7JfvWWbZ1qQU=;
 b=iXWGXwqWAF+lBd3DDkk14fLLyax8/qU1xdga2RjWgzOl3CVdI3aqnfRf5slpKLh2E8
 lIyzPlaz5ugE4Ycl4YMnjaHDvinI0uOzVVVIY+exDq6bw5Wi7bRzaAv7fYuBBNx327Kr
 71/9SojJac3p6GcQV9wUE0P0R8XCmhhAxLf9ZBFcE7u2FKbcktb1zoUUNNKu9O7EvvvX
 dKaSiNCnj9PX2/sAFjffQbZVQQWJS+boCEiSxlhEQjVwpt87HUgBG2VlwQ3e0P8LyeoI
 Doe34//+exnxFu84Cx3hxiM1pKyatb1KXexAxaYqxbHG9SQbLCka3pesRIG1830wGpI8
 V0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734992230; x=1735597030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nSPynu/TsTtjPcRM35CFCvp80g/vZQK7JfvWWbZ1qQU=;
 b=e9z8HsaxzJsY50KHNkySwqfQo6V2NMi9nZo+34hHxi/wKT0w4tV7cEfqtGvButB1/3
 kqe5Vdjklp9oILVnGBREYXD7MlPxqpD2yJ3jMR5g2bWzKeaCtYmlptCsrl/aWwEKyQIH
 2C9KUjYcIZsn3dcV7SM07CEG92a6GIuN1E/FWRUW++rGQWcvMtYHi5tu52guFMQXJ8XK
 n51jmxyvlYnfw5eVcZrquFH6ZIzcmRl410TMnfF/KZNTpVOeoFPoWysdvPBcg8xpatMG
 gEgXmM8mSIwc0xpRDFpj6vKwuSos5aa1W5XkpmuGJod/yMxAJzzYGCCFkFgXn2tPmfkC
 yg9w==
X-Gm-Message-State: AOJu0YwKWIwMWP09nZGAB8EQnceSO4eZ4uHBqwZ5WHcbwdRO0IY6RmhE
 BS/oTP+196jQqInq+ybzEjupK1aZ7edKEe0N2oZip/u537Ph6sAJWOjALUwDgRyY0FZEmigcQP3
 Oaw==
X-Gm-Gg: ASbGncthXtRCqo6dInxtCJzXx6UpPloMzlGueSLtaaaz4rc6ec51jBCLAK4iz/E5gVh
 XuLiP9gwgFvpzr7XIfeqW0XNjgvOvLiN0w/M32xqZakMkd6HcJPlE377HkBChIYXMG5oat91Vid
 MkcP+RKe3vhakkV1JqPN7HVSay3IwKYAk28rJ4L5ES5+js0duIxYqa8qQC9eHSQJ51Cr4xvKVGA
 goSvBH8xoqhW1f6CjVxRLtpO6XaUgWfiR8lfhRBpsV8VBCEjIVsclaIy9CTajuacqmJFmMMe3Vi
 jUzmj2mvnMi94CLHsW+pGO5sgf47G1+k
X-Google-Smtp-Source: AGHT+IHxLSAe712Lk1+6hP6rxTB6LZBTaYi5kJ9NpsSBoNCMLTHqGJOkaZPy75itVybuMA7kjLsboA==
X-Received: by 2002:a05:600c:1547:b0:434:fd15:3ac9 with SMTP id
 5b1f17b1804b1-4366b2fa09amr112877345e9.22.1734992229965; 
 Mon, 23 Dec 2024 14:17:09 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611fc161sm147561075e9.10.2024.12.23.14.17.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Dec 2024 14:17:09 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, balaton@eik.bme.hu, Alexander Graf <graf@amazon.com>
Subject: [PATCH v16 07/14] hw/misc/pvpanic: Add MMIO interface
Date: Mon, 23 Dec 2024 23:16:38 +0100
Message-Id: <20241223221645.29911-8-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241223221645.29911-1-phil@philjordan.eu>
References: <20241223221645.29911-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::32d;
 envelope-from=phil@philjordan.eu; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

From: Alexander Graf <graf@amazon.com>

In addition to the ISA and PCI variants of pvpanic, let's add an MMIO
platform device that we can use in embedded arm environments.

Signed-off-by: Alexander Graf <graf@amazon.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---

v3:
 * Rebased on upstream, updated a header path

v15:
 * Constified the property table.

v16:
 * Removed the DEFINE_PROP_END_OF_LIST marker to match recent upstream
   changes.

 hw/misc/Kconfig           |  4 +++
 hw/misc/meson.build       |  1 +
 hw/misc/pvpanic-mmio.c    | 60 +++++++++++++++++++++++++++++++++++++++
 include/hw/misc/pvpanic.h |  1 +
 4 files changed, 66 insertions(+)
 create mode 100644 hw/misc/pvpanic-mmio.c

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1f1baa5dde..5a6c1603b6 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -145,6 +145,10 @@ config PVPANIC_ISA
     depends on ISA_BUS
     select PVPANIC_COMMON
 
+config PVPANIC_MMIO
+    bool
+    select PVPANIC_COMMON
+
 config AUX
     bool
     select I2C
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index d02d96e403..4de4db0a60 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -122,6 +122,7 @@ system_ss.add(when: 'CONFIG_ARMSSE_MHU', if_true: files('armsse-mhu.c'))
 
 system_ss.add(when: 'CONFIG_PVPANIC_ISA', if_true: files('pvpanic-isa.c'))
 system_ss.add(when: 'CONFIG_PVPANIC_PCI', if_true: files('pvpanic-pci.c'))
+system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: files('pvpanic-mmio.c'))
 system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_hace.c',
diff --git a/hw/misc/pvpanic-mmio.c b/hw/misc/pvpanic-mmio.c
new file mode 100644
index 0000000000..70097cecc7
--- /dev/null
+++ b/hw/misc/pvpanic-mmio.c
@@ -0,0 +1,60 @@
+/*
+ * QEMU simulated pvpanic device (MMIO frontend)
+ *
+ * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/qdev-properties.h"
+#include "hw/misc/pvpanic.h"
+#include "hw/sysbus.h"
+#include "standard-headers/misc/pvpanic.h"
+
+OBJECT_DECLARE_SIMPLE_TYPE(PVPanicMMIOState, PVPANIC_MMIO_DEVICE)
+
+#define PVPANIC_MMIO_SIZE 0x2
+
+struct PVPanicMMIOState {
+    SysBusDevice parent_obj;
+
+    PVPanicState pvpanic;
+};
+
+static void pvpanic_mmio_initfn(Object *obj)
+{
+    PVPanicMMIOState *s = PVPANIC_MMIO_DEVICE(obj);
+
+    pvpanic_setup_io(&s->pvpanic, DEVICE(s), PVPANIC_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->pvpanic.mr);
+}
+
+static const Property pvpanic_mmio_properties[] = {
+    DEFINE_PROP_UINT8("events", PVPanicMMIOState, pvpanic.events,
+                      PVPANIC_PANICKED | PVPANIC_CRASH_LOADED),
+};
+
+static void pvpanic_mmio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, pvpanic_mmio_properties);
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo pvpanic_mmio_info = {
+    .name          = TYPE_PVPANIC_MMIO_DEVICE,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PVPanicMMIOState),
+    .instance_init = pvpanic_mmio_initfn,
+    .class_init    = pvpanic_mmio_class_init,
+};
+
+static void pvpanic_register_types(void)
+{
+    type_register_static(&pvpanic_mmio_info);
+}
+
+type_init(pvpanic_register_types)
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index 9a71a5ad0d..049a94c112 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -26,6 +26,7 @@
 
 #define TYPE_PVPANIC_ISA_DEVICE "pvpanic"
 #define TYPE_PVPANIC_PCI_DEVICE "pvpanic-pci"
+#define TYPE_PVPANIC_MMIO_DEVICE "pvpanic-mmio"
 
 #define PVPANIC_IOPORT_PROP "ioport"
 
-- 
2.39.5 (Apple Git-154)


