Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E2BC3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJZL-00012d-Uo; Mon, 01 Jul 2024 12:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ2-0000eA-Qe
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:37 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJYy-0005PT-Oh
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:36 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2e72224c395so35569421fa.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850051; x=1720454851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DEL1nYqcktgvW/KVYnuY/WYje2WQ4Eqs61dE2s1g5tU=;
 b=NgeeOT3ANjWyMO8fT8Hqo8DRFnGbg+y6+/I0Vf6AZrMamHz+9FyoPTzcTzwPwjqbBE
 Gp7J40lqkkAY2lzV3Ml/OsWjma+ZvzlXTDoeSuXJYaNHVNiUgTu6R+168OmOixukF6La
 +vRh2CsoV2zVX1SMOk1BR8yUo+E44b01aBXl7O2Vu4gYMwT51Mokr/KRd9XL++cYysBl
 NGtgia0AP07yqIDzXZQ1c1zf2moF2QDNzsCIqNhF/msjJnC0OpbDbbXz/MkfxqjeZn2S
 ECYIC1/ZL4RidELKODngZhqC2zVtvr7eUh5oU3xIkyULO8zN4MgXQA5yNmnbt8Xwzp7j
 rjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850051; x=1720454851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DEL1nYqcktgvW/KVYnuY/WYje2WQ4Eqs61dE2s1g5tU=;
 b=Kq2jjL9xcKe3zx4w3a0aZ/1OUwWi49QOWAWlecBwSwxPwSGzxHjv1pFSWzKFz59PzR
 lbIycYJhb/jx9AujtsSi6SitUf8R/hRujvqlncVdoRdBAyghOaxaHXDZp5ug+SySLsTE
 UFzQf+UrEldYJDxXTjqxZtg/9BqDkLPbxjOcG018d7SG0Z7AwdoqSfkb/gPVBEC159Og
 4drDtBrcnIFBmmz7P+hy1f4oAmimME+PbX5GjkmQiqZNKq5zTP1df5CH1yi9aZa3OZoS
 AkXQDGBOOjr79cdUL+dSLB3r/MS89XOdSzpKAETSqqALb4EBguzv31Le2UF9f8wk7bGd
 fR7w==
X-Gm-Message-State: AOJu0YxS98VtJc6JQPe0KffwXI1pzxudOzn76gCi55+oEycyMVD/D+8+
 TBsxJr1R9d1FqgvD3zzk4o/mROCXPL4wrORNgkaWSKCuFx/qy0CKajPNxAqS06yB0ZOGdzIam5X
 bU8s=
X-Google-Smtp-Source: AGHT+IGX8A5M+Gfp3D2SfgybimCIJX2WohsF8Jy+zdaT23F1cEwPKdtnymwTb8GXVsDqaQgCrnxOLQ==
X-Received: by 2002:a2e:300e:0:b0:2ec:616e:1c92 with SMTP id
 38308e7fff4ca-2ee5e337980mr39436591fa.2.1719850050705; 
 Mon, 01 Jul 2024 09:07:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/29] hw/nvram: Add BCM2835 OTP device
Date: Mon,  1 Jul 2024 17:07:01 +0100
Message-Id: <20240701160729.1910763-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Rayhan Faizel <rayhan.faizel@gmail.com>

The OTP device registers are currently stubbed. For now, the device
houses the OTP rows which will be accessed directly by other peripherals.

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/nvram/bcm2835_otp.h |  68 ++++++++++++
 hw/nvram/bcm2835_otp.c         | 187 +++++++++++++++++++++++++++++++++
 hw/nvram/meson.build           |   1 +
 3 files changed, 256 insertions(+)
 create mode 100644 include/hw/nvram/bcm2835_otp.h
 create mode 100644 hw/nvram/bcm2835_otp.c

diff --git a/include/hw/nvram/bcm2835_otp.h b/include/hw/nvram/bcm2835_otp.h
new file mode 100644
index 00000000000..1df33700bde
--- /dev/null
+++ b/include/hw/nvram/bcm2835_otp.h
@@ -0,0 +1,68 @@
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
+#define BCM2835_OTP_ROW_COUNT                              66
+
+/* https://elinux.org/BCM2835_registers#OTP */
+#define BCM2835_OTP_BOOTMODE_REG                         0x00
+#define BCM2835_OTP_CONFIG_REG                           0x04
+#define BCM2835_OTP_CTRL_LO_REG                          0x08
+#define BCM2835_OTP_CTRL_HI_REG                          0x0c
+#define BCM2835_OTP_STATUS_REG                           0x10
+#define BCM2835_OTP_BITSEL_REG                           0x14
+#define BCM2835_OTP_DATA_REG                             0x18
+#define BCM2835_OTP_ADDR_REG                             0x1c
+#define BCM2835_OTP_WRITE_DATA_READ_REG                  0x20
+#define BCM2835_OTP_INIT_STATUS_REG                      0x24
+
+
+/* -- Row 32: Undocumented -- */
+
+#define BCM2835_OTP_ROW_32                                 32
+
+/* Lock OTP Programming (Customer OTP and private key) */
+#define BCM2835_OTP_ROW_32_LOCK                        BIT(6)
+
+/* -- Row 36-43: Customer OTP -- */
+
+#define BCM2835_OTP_CUSTOMER_OTP                           36
+#define BCM2835_OTP_CUSTOMER_OTP_LEN                        8
+
+/* Magic numbers to lock programming of customer OTP and private key */
+#define BCM2835_OTP_LOCK_NUM1                      0xffffffff
+#define BCM2835_OTP_LOCK_NUM2                      0xaffe0000
+
+/* -- Row 56-63: Device-specific private key -- */
+
+#define BCM2835_OTP_PRIVATE_KEY                            56
+#define BCM2835_OTP_PRIVATE_KEY_LEN                         8
+
+
+struct BCM2835OTPState {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion iomem;
+    uint32_t otp_rows[BCM2835_OTP_ROW_COUNT];
+};
+
+
+uint32_t bcm2835_otp_get_row(BCM2835OTPState *s, unsigned int row);
+void bcm2835_otp_set_row(BCM2835OTPState *s, unsigned int row, uint32_t value);
+
+#endif
diff --git a/hw/nvram/bcm2835_otp.c b/hw/nvram/bcm2835_otp.c
new file mode 100644
index 00000000000..c4aed28472b
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
+uint32_t bcm2835_otp_get_row(BCM2835OTPState *s, unsigned int row)
+{
+    assert(row <= BCM2835_OTP_ROW_COUNT && row >= 1);
+
+    return s->otp_rows[row - 1];
+}
+
+void bcm2835_otp_set_row(BCM2835OTPState *s, unsigned int row,
+                           uint32_t value)
+{
+    assert(row <= BCM2835_OTP_ROW_COUNT && row >= 1);
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
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void bcm2835_otp_realize(DeviceState *dev, Error **errp)
+{
+    BCM2835OTPState *s = BCM2835_OTP(dev);
+    memory_region_init_io(&s->iomem, OBJECT(dev), &bcm2835_otp_ops, s,
+                          TYPE_BCM2835_OTP, 0x80);
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
+        VMSTATE_UINT32_ARRAY(otp_rows, BCM2835OTPState, BCM2835_OTP_ROW_COUNT),
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
index 4996c72456f..10f3639db6a 100644
--- a/hw/nvram/meson.build
+++ b/hw/nvram/meson.build
@@ -1,5 +1,6 @@
 system_ss.add(files('fw_cfg-interface.c'))
 system_ss.add(files('fw_cfg.c'))
+system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_otp.c'))
 system_ss.add(when: 'CONFIG_CHRP_NVRAM', if_true: files('chrp_nvram.c'))
 system_ss.add(when: 'CONFIG_DS1225Y', if_true: files('ds1225y.c'))
 system_ss.add(when: 'CONFIG_NMC93XX_EEPROM', if_true: files('eeprom93xx.c'))
-- 
2.34.1


