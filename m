Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E349D6AB16
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 22:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q2u-0000Ns-3B; Thu, 02 Apr 2026 17:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2Y-00006K-Be
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:27 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2V-0007Cs-LT
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:25 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b9c280322e0so162834766b.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167042; x=1775771842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7XwGSsZ5E+pHUCrk55JcghHWJX/O0i4AExLwj5l49n4=;
 b=ZtoJCD94wsJ26HGPVVGsEid/nGX+btDysjk2W83FLG5DhYOeejn3sIO1frJWgoHvS7
 MFJ5I1k+vdYDYZGXBT3RxLwIg1RUROgYe8WYUaxl3oV7rc5vT0ydYzSpR9C1KOF//z7K
 mjix6TcqMTpdeRFeZbnkYOoCCpxvOhoOfDAW4+dbLgWrKWfV1q0rcTMccSqUm825Ii2H
 aGt/wDEPw0zlxB6EjXdGrvOWdUU2rx4WoNaktqY6S8TdpKtjapNm7yH+vf6U1UY68tPT
 MfnGJAmq84s+/BqXMmb8H4JKvxwvNoxXEeqNjQ8SEFFanS9rhOVKZ7TBUOG5mt4VLUfN
 Ghsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167042; x=1775771842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7XwGSsZ5E+pHUCrk55JcghHWJX/O0i4AExLwj5l49n4=;
 b=Z5wSbYj2j5U8BBw1JVMsIk46Jm55j2DXJ6Jmr3qL/rrAg4bViJzCHvK3icqEhqQIN2
 V7rKfIkyx+/ArD5VUAJ5q57dzVFaHdDoHD3lBzu9Nt3IzJof7UThLkt0MZ6tulo87ELg
 T0QKB1flkDaog11X4jlTbSInTaviszPaZQYXiX+bU6r1qkrLD0XCV6XqS9HlEtdhOltO
 pue5YrvssxNCasYBfkVcY5z4pKP6GhLY/89f3rDnOKBv+hycIbXK3VFKALXqfXtOcbO6
 Z0ymf5PF0bin88DtzlBbvA0XeH0hWKG19OvbiERAFQ+8a/6Cve98u1M85mIEVOuJodUu
 Od3g==
X-Gm-Message-State: AOJu0Yzk5mqGor6x4GGZ0CkI95ML1lykBjYZnabw3Dc+G7TjSz1/gRN2
 iluxlE1R0YtoUlDD2rto75umGLbcuKauJoxTdqTzdB3Bxq6ipisuuMSq+ObilsFq
X-Gm-Gg: ATEYQzzgbeyWDUsf6zWNJSxkg7ZAIHqasid0BLt3aYrXcu1bFfAyAwx/eSTVjYrlhmk
 QUKi/oRAy7NSl71x9vvxQ9H0hiP1cu1ZLu4jbsD/xJP+t2TXkO426w3K5g4lBu+LYCdXLI0Pp0u
 wodsbU//TgayQSj6gzq6KZIHY42zQsCKl89NSWz7k3hv2Ev7DRL85SPfUGLR6IuxEgYA0yVX0hj
 JxNE7Siy2NCsTtjEETY1UgQ/PLdBRtNdnn5I5epsReq7F4L1hcDkjzCKgZtgkRwPT/6eTrAuOnn
 jfDdNJu/N3u+sqa/jcaUnKGao8aGckWW3dZMGq8VCtJLfi+w473AwKK5KrKsAdmJyHlaoxUzm+h
 +mAXEwo3xxVUrLuwZJRl8nQjR5koO7w9HZZcPDXk2xdB5dl06DXJTOFY2LhWaNqf9gnpbAVDCA3
 dTaS6KvVJnGNtnpUgb938JJQef+scYuS3Mb8qnUcmX/7bjjDVNo6TUJ4jrqErGm1og2jg3lvL9f
 LQbuamP
X-Received: by 2002:a17:906:fe0d:b0:b98:8e19:7d64 with SMTP id
 a640c23a62f3a-b9c677fbe10mr28976766b.26.1775167041480; 
 Thu, 02 Apr 2026 14:57:21 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:57:21 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 22/33] hw/core/sysbus: implement FDT_GENERIC_MMAP_CLASS
 interface
Date: Thu,  2 Apr 2026 23:56:07 +0200
Message-ID: <20260402215629.745866-23-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x62e.google.com
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

The patch implements FDTGenericMMap interface for sysbus
device class. The implementation maps device's MMIO regions
based on 'reg' property in the Device tree.

This enables automatic memory mapping for the most QEMU
peripherals without the need of device-specific FDT
handling code.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/sysbus.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 3adf2f2faf..78b7827708 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -23,6 +23,8 @@
 #include "monitor/monitor.h"
 #include "system/address-spaces.h"
 
+#include "hw/core/fdt_generic_util.h"
+
 static void sysbus_dev_print(Monitor *mon, DeviceState *dev, int indent);
 static char *sysbus_get_fw_dev_path(DeviceState *dev);
 
@@ -291,11 +293,32 @@ static char *sysbus_get_fw_dev_path(DeviceState *dev)
     return g_strdup(qdev_fw_name(dev));
 }
 
+static bool sysbus_parse_reg(FDTGenericMMap *obj, FDTGenericRegPropInfo reg,
+                             Error **errp)
+{
+    int i;
+
+    for (i = 0; i < reg.n; ++i) {
+        MemoryRegion *mr_parent = (MemoryRegion *)
+            object_dynamic_cast(reg.parents[i], TYPE_MEMORY_REGION);
+        if (!mr_parent) {
+            /* evil */
+            mr_parent = get_system_memory();
+        }
+        memory_region_add_subregion_overlap(mr_parent, reg.a[i],
+                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(obj), i),
+                                 reg.p[i]);
+    }
+    return false;
+}
+
 static void sysbus_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
+    FDTGenericMMapClass *fmc = FDT_GENERIC_MMAP_CLASS(klass);
     k->realize = sysbus_device_realize;
     k->bus_type = TYPE_SYSTEM_BUS;
+    fmc->parse_reg = sysbus_parse_reg;
     /*
      * device_add plugs devices into a suitable bus.  For "real" buses,
      * that actually connects the device.  For sysbus, the connections
@@ -354,6 +377,11 @@ static const TypeInfo sysbus_types[] = {
         .abstract       = true,
         .class_size     = sizeof(SysBusDeviceClass),
         .class_init     = sysbus_device_class_init,
+        .interfaces = (InterfaceInfo[]) {
+        { TYPE_FDT_GENERIC_MMAP },
+        { },
+    },
+
     },
     {
         .name           = TYPE_DYNAMIC_SYS_BUS_DEVICE,
-- 
2.43.0


