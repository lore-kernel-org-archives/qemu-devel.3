Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5989C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 14:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5R4H-0006tu-3D; Fri, 10 May 2024 10:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1s5R4F-0006tb-L3; Fri, 10 May 2024 10:17:47 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1s5R4D-0001Sm-IO; Fri, 10 May 2024 10:17:47 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a59b097b202so495174966b.0; 
 Fri, 10 May 2024 07:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715350663; x=1715955463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o9fjU59fGtvCVR/tbRDabxmDNDs6GCEKkABmHTUx8AE=;
 b=f8HBX5/WzVojM3XNnUBYwgnNeutK4di2vIGP3qoqeNmeE1pRx4nkYmFybpelHZOMmR
 disTuOYtjrgV37Y0UStlhA0iqtXExGutSa6VHi6RBs4QTOyJcfrnk3WKAX7Em+6scxpp
 lH5bhQR5Rx4YJV5fjlNiEcXysZzvz7qdsvfFvBgCSDORfCylzqfFrgP4fDJTVikUfqZw
 a5oP4U4kDeJ4A7X1NuDJhfBMSmJ/HlsqH/im7pKOOEURTedmbKn6+9S90xYaQ6EJ3gj7
 kCT90I4IpFWSBHIwo2pjMpJtdbTpllFf+0OpT0GCY055AcoFsIytpmrg6TTxRHV9Mlh4
 Ai1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715350663; x=1715955463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o9fjU59fGtvCVR/tbRDabxmDNDs6GCEKkABmHTUx8AE=;
 b=xSR8sx2aql33XAQNuXzPBsWzWZfdUENS3Sq+nZFcpNbE9C9S/83QIK4+mVVpqMRkYN
 PGBaQ6WXwFdrt0h3dD5BrCka+1GHeXaAjLOMhLdPkQq3Rn2JXhTPTLNEo7GefT7Z8NDe
 js2Heh5x3fSPrVaCKc8dNufiLgMS1qyJMEyR3M/LPPLzenKOMyB/GnGnJ4iyNUm8+29W
 DSTUGSMYP9+MyBfvgwuat3wqJh++yJ3jZ1ys4JfcyiUSi0uvOS2O7h1LrAwlA1aDiq/b
 d9AOtzI6Xba3/VeInl+JKAFBki5HnxiQ5fCv4Niq+QcKxWfAeUpimlQTpHyP+w92AL+M
 A/tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwDhrA6+YWo65WQrUUSJyucBz5eXTo3qEyJSeFDCO9YJWEImzrXE6h/9NNELOv/HeFPTv0qw4VrHo7g9nWIBqSsd9u
X-Gm-Message-State: AOJu0YxWWIc2JjDXuyyyzZ/Xeua0rmZKsRpOaVc23ilKiL4a+TMQRbT2
 wYesF2Hzvqilv32K6VAq0g88ZoZX4e01TXf1TSjqL11nLzguQaGer8LUAw==
X-Google-Smtp-Source: AGHT+IHt0qMyVTgYPSyttXJDG+K8xXdyNxPxtEdWWaoLEyuNLzrbRoB30YFMHbKInCdDumL1vBZ2Aw==
X-Received: by 2002:a17:906:a8f:b0:a55:acd8:996c with SMTP id
 a640c23a62f3a-a5a2d55af14mr182233366b.29.1715350662698; 
 Fri, 10 May 2024 07:17:42 -0700 (PDT)
Received: from localhost.localdomain ([212.70.119.83])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17891f6esm190093466b.54.2024.05.10.07.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 07:17:42 -0700 (PDT)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH 1/3] hw/nvram: Add BCM2835 OTP device
Date: Fri, 10 May 2024 19:40:08 +0530
Message-Id: <20240510141010.656561-2-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510141010.656561-1-rayhan.faizel@gmail.com>
References: <20240510141010.656561-1-rayhan.faizel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-ej1-x629.google.com
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

The OTP device registers are currently stubbed. For now, the device
houses the OTP rows which will be accessed directly by other peripherals.

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
---
 hw/nvram/bcm2835_otp.c         | 187 +++++++++++++++++++++++++++++++++
 hw/nvram/meson.build           |   1 +
 include/hw/nvram/bcm2835_otp.h |  43 ++++++++
 3 files changed, 231 insertions(+)
 create mode 100644 hw/nvram/bcm2835_otp.c
 create mode 100644 include/hw/nvram/bcm2835_otp.h

diff --git a/hw/nvram/bcm2835_otp.c b/hw/nvram/bcm2835_otp.c
new file mode 100644
index 0000000000..a8d01c6f1d
--- /dev/null
+++ b/hw/nvram/bcm2835_otp.c
@@ -0,0 +1,187 @@
+/*
+ * BCM2835 One-Time Programmable (OTP) Memory
+ *
+ * The OTP implementation is mostly a stub except for the OTP rows
+ * which are accessed directly by other peripherals such as the mailbox.
+ *
+ * The OTP registers are unimplemented due to lack of documentation.
+ *
+ * Copyright (c) 2024 Rayhan Faizel <rayhan.faizel@gmail.com>
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/nvram/bcm2835_otp.h"
+#include "migration/vmstate.h"
+
+/* OTP rows are 1-indexed */
+uint32_t bcm2835_otp_read_row(BCM2835OTPState *s, unsigned int row)
+{
+    assert(row <= 66 && row >= 1);
+
+    return s->otp_rows[row - 1];
+}
+
+void bcm2835_otp_write_row(BCM2835OTPState *s, unsigned int row,
+                           uint32_t value)
+{
+    assert(row <= 66 && row >= 1);
+
+    /* Real OTP rows work as e-fuses */
+    s->otp_rows[row - 1] |= value;
+}
+
+static uint64_t bcm2835_otp_read(void *opaque, hwaddr addr, unsigned size)
+{
+    switch (addr) {
+    case BCM2835_OTP_BOOTMODE_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_BOOTMODE_REG\n");
+        break;
+    case BCM2835_OTP_CONFIG_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_CONFIG_REG\n");
+        break;
+    case BCM2835_OTP_CTRL_LO_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_CTRL_LO_REG\n");
+        break;
+    case BCM2835_OTP_CTRL_HI_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_CTRL_HI_REG\n");
+        break;
+    case BCM2835_OTP_STATUS_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_STATUS_REG\n");
+        break;
+    case BCM2835_OTP_BITSEL_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_BITSEL_REG\n");
+        break;
+    case BCM2835_OTP_DATA_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_DATA_REG\n");
+        break;
+    case BCM2835_OTP_ADDR_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_ADDR_REG\n");
+        break;
+    case BCM2835_OTP_WRITE_DATA_READ_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_WRITE_DATA_READ_REG\n");
+        break;
+    case BCM2835_OTP_INIT_STATUS_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_INIT_STATUS_REG\n");
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, addr);
+    }
+
+    return 0;
+}
+
+static void bcm2835_otp_write(void *opaque, hwaddr addr,
+                              uint64_t value, unsigned int size)
+{
+    switch (addr) {
+    case BCM2835_OTP_BOOTMODE_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_BOOTMODE_REG\n");
+        break;
+    case BCM2835_OTP_CONFIG_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_CONFIG_REG\n");
+        break;
+    case BCM2835_OTP_CTRL_LO_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_CTRL_LO_REG\n");
+        break;
+    case BCM2835_OTP_CTRL_HI_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_CTRL_HI_REG\n");
+        break;
+    case BCM2835_OTP_STATUS_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_STATUS_REG\n");
+        break;
+    case BCM2835_OTP_BITSEL_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_BITSEL_REG\n");
+        break;
+    case BCM2835_OTP_DATA_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_DATA_REG\n");
+        break;
+    case BCM2835_OTP_ADDR_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_ADDR_REG\n");
+        break;
+    case BCM2835_OTP_WRITE_DATA_READ_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_WRITE_DATA_READ_REG\n");
+        break;
+    case BCM2835_OTP_INIT_STATUS_REG:
+        qemu_log_mask(LOG_UNIMP,
+                      "bcm2835_otp: BCM2835_OTP_INIT_STATUS_REG\n");
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, addr);
+    }
+}
+
+static const MemoryRegionOps bcm2835_otp_ops = {
+    .read = bcm2835_otp_read,
+    .write = bcm2835_otp_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void bcm2835_otp_realize(DeviceState *dev, Error **errp)
+{
+    BCM2835OTPState *s = BCM2835_OTP(dev);
+    memory_region_init_io(&s->iomem, OBJECT(dev), &bcm2835_otp_ops, s,
+                          TYPE_BCM2835_OTP, 0x28);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
+
+    memset(s->otp_rows, 0x00, sizeof(s->otp_rows));
+}
+
+static const VMStateDescription vmstate_bcm2835_otp = {
+    .name = TYPE_BCM2835_OTP,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(otp_rows, BCM2835OTPState, 66),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void bcm2835_otp_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = bcm2835_otp_realize;
+    dc->vmsd = &vmstate_bcm2835_otp;
+}
+
+static const TypeInfo bcm2835_otp_info = {
+    .name = TYPE_BCM2835_OTP,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2835OTPState),
+    .class_init = bcm2835_otp_class_init,
+};
+
+static void bcm2835_otp_register_types(void)
+{
+    type_register_static(&bcm2835_otp_info);
+}
+
+type_init(bcm2835_otp_register_types)
diff --git a/hw/nvram/meson.build b/hw/nvram/meson.build
index 4996c72456..10f3639db6 100644
--- a/hw/nvram/meson.build
+++ b/hw/nvram/meson.build
@@ -1,5 +1,6 @@
 system_ss.add(files('fw_cfg-interface.c'))
 system_ss.add(files('fw_cfg.c'))
+system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_otp.c'))
 system_ss.add(when: 'CONFIG_CHRP_NVRAM', if_true: files('chrp_nvram.c'))
 system_ss.add(when: 'CONFIG_DS1225Y', if_true: files('ds1225y.c'))
 system_ss.add(when: 'CONFIG_NMC93XX_EEPROM', if_true: files('eeprom93xx.c'))
diff --git a/include/hw/nvram/bcm2835_otp.h b/include/hw/nvram/bcm2835_otp.h
new file mode 100644
index 0000000000..ef02d3055c
--- /dev/null
+++ b/include/hw/nvram/bcm2835_otp.h
@@ -0,0 +1,43 @@
+/*
+ * BCM2835 One-Time Programmable (OTP) Memory
+ *
+ * Copyright (c) 2024 Rayhan Faizel <rayhan.faizel@gmail.com>
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#ifndef BCM2835_OTP_H
+#define BCM2835_OTP_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_BCM2835_OTP "bcm2835-otp"
+OBJECT_DECLARE_SIMPLE_TYPE(BCM2835OTPState, BCM2835_OTP)
+
+/* https://elinux.org/BCM2835_registers#OTP */
+#define BCM2835_OTP_BOOTMODE_REG            0x00
+#define BCM2835_OTP_CONFIG_REG              0x04
+#define BCM2835_OTP_CTRL_LO_REG             0x08
+#define BCM2835_OTP_CTRL_HI_REG             0x0c
+#define BCM2835_OTP_STATUS_REG              0x10
+#define BCM2835_OTP_BITSEL_REG              0x14
+#define BCM2835_OTP_DATA_REG                0x18
+#define BCM2835_OTP_ADDR_REG                0x1c
+#define BCM2835_OTP_WRITE_DATA_READ_REG     0x20
+#define BCM2835_OTP_INIT_STATUS_REG         0x24
+
+struct BCM2835OTPState {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion iomem;
+    uint32_t otp_rows[66];
+};
+
+
+uint32_t bcm2835_otp_read_row(BCM2835OTPState *s, unsigned int row);
+void bcm2835_otp_write_row(BCM2835OTPState *s, unsigned row, uint32_t value);
+
+#endif
-- 
2.34.1


