Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88B2D11100
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 15:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7c6t-0000ZE-LM; Sun, 03 Nov 2024 10:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t7c6I-0008Mr-3Y
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 10:01:13 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t7c6D-0006Zk-N7
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 10:01:09 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9e71401844so274064266b.3
 for <qemu-devel@nongnu.org>; Sun, 03 Nov 2024 07:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730646063; x=1731250863;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oRS+0IKfHz5Oswaa/GcDCGPOKlj/D3aQAGpgmUVuXww=;
 b=f9JcbskxuKCpPTMkGlbW+MpgllNBl4qnuEXMYJ1Z8jWctFPrqZVWuxubbEVjm3R2kK
 6Xfddy5Sc2i4B4fe1/qKxx80HWNanE/vOoLx3RkTp4yQix+5s4QAaSlt1247rR6eAr4T
 lXm64GGtxQdzr+AUoKizgxZxULH9lZ6m/OVpVOLk0ls9lcdwkeDLBYq7jAYKz0yFktm+
 Qnp5Uz58d/qjTmc+NK1hucxI/HoVoDfpNt986HcZl9RJv+lUFdDl5EiiWdJ0/KAs3KV0
 tH0F005YGHp+QBcQp8Ix22jYGR3wGa8B2o9x8PAM5EJ+JYY1TLoftSSW39rX1lYtfgsg
 zN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730646063; x=1731250863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oRS+0IKfHz5Oswaa/GcDCGPOKlj/D3aQAGpgmUVuXww=;
 b=XJhax9zcsk2cWye4pzErgKSLo+4xSKU0nER2jQuci0YtViG24Ws+KfzR+zmZzJpS41
 kjp1z6Mlb8JrzCto4khtHu4LAj0mWYHQLN14USQdsidwt1W0mgjXxbyX2KI3kzwEpsWQ
 LvE3bqYiP97I+Ur5wTW7fDCJFh2d6FgjV39rqzU/eOzr3Cn3cDV5/b8jEHuaT8xhcdXg
 LNHToyMCuQqSDqaHcwFGmiroIZG6tV+Bg1W6f5mYgen/Iot5UKlOp11RBWs6Bx6D6BSx
 tCBnMyXb4OoKhMQbcpahtWQXha+yLp4bdKM2ZLmkdrwrK/AW4YOaY4W5GmleyCXF0h3v
 nUkw==
X-Gm-Message-State: AOJu0Yzg/2/z7awlWLAtnIcOQ68DWhslYUGP1MhEEjLNs52bp9ZYuKt0
 B1++X56gUdZbPlqEIJ0IebieOtNMEYoaF+XyyjSeqIEsi0ejY2bZZkOFZbO+gSDdskttxRqKsnJ
 deA==
X-Google-Smtp-Source: AGHT+IEA77YTmspSPvaZXaWsKtggXQiIKNUxgFCduqYtzRsz+SS4LIxOe1gmYlEH2RwDRfp3l7mfFQ==
X-Received: by 2002:a17:907:7214:b0:a9a:10c9:f4b8 with SMTP id
 a640c23a62f3a-a9e50cb736fmr1191317366b.61.1730646061853; 
 Sun, 03 Nov 2024 07:01:01 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm431536666b.159.2024.11.03.07.01.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 03 Nov 2024 07:01:01 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, Alexander Graf <graf@amazon.com>
Subject: [PATCH v6 07/15] hw/misc/pvpanic: Add MMIO interface
Date: Sun,  3 Nov 2024 16:00:29 +0100
Message-Id: <20241103150037.48194-8-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241103150037.48194-1-phil@philjordan.eu>
References: <20241103150037.48194-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::632;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x632.google.com
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
---
v3:

 * Rebased on upstream, updated a header path
 hw/misc/Kconfig           |  4 +++
 hw/misc/meson.build       |  1 +
 hw/misc/pvpanic-mmio.c    | 61 +++++++++++++++++++++++++++++++++++++++
 include/hw/misc/pvpanic.h |  1 +
 4 files changed, 67 insertions(+)
 create mode 100644 hw/misc/pvpanic-mmio.c

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1f1baa5dde9..5a6c1603b60 100644
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
index d02d96e403b..4de4db0a600 100644
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
index 00000000000..56738efee53
--- /dev/null
+++ b/hw/misc/pvpanic-mmio.c
@@ -0,0 +1,61 @@
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
+static Property pvpanic_mmio_properties[] = {
+    DEFINE_PROP_UINT8("events", PVPanicMMIOState, pvpanic.events,
+                      PVPANIC_PANICKED | PVPANIC_CRASH_LOADED),
+    DEFINE_PROP_END_OF_LIST(),
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
index 9a71a5ad0d7..049a94c1125 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -26,6 +26,7 @@
 
 #define TYPE_PVPANIC_ISA_DEVICE "pvpanic"
 #define TYPE_PVPANIC_PCI_DEVICE "pvpanic-pci"
+#define TYPE_PVPANIC_MMIO_DEVICE "pvpanic-mmio"
 
 #define PVPANIC_IOPORT_PROP "ioport"
 
-- 
2.39.3 (Apple Git-145)


