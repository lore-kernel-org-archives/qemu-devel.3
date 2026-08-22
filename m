Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E31C5DF8C
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 19:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxrd5-0001ut-8e; Sat, 22 Aug 2026 15:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wxrd3-0001uB-DF
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 15:43:45 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wxrd1-000766-Ku
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 15:43:45 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ce98cb8165so20969295ad.1
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 12:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787427822; x=1788032622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tbhBHxya38fjpp+X2qaBnuq4c0QicotBSxaB11D8ECk=;
 b=pMcjzv3N0sfWPKc3Tckk/sROastrhxDbg/NrPW5wcI90MNioOqVWfDl0ehSQld+tlq
 3BQnQ1JGTUNcNw8rbx/V5vIB+qAsgBNiT0BO5cVeEYMtjj39QfEAJ2VJ83HHn1Yd9iWr
 yvk1IrL3APmn2Sba2iRsHXH84VmF7Lc+AgrDqd3QsS6UArwjmRONw/E4fqYILi8VnDQh
 Db85A/hgK+Q/uTJer/T1V5oYjD7U1xcwS0JLPQk7bq/ObYfFV25uoh0HXEGKJZ6EFYxu
 D0+Ezbov+/Gv4MNUgCfWuq30s0vXbMCHihESMeOb2WxSLqXyxs0cPEcRO3wbuTbw0G7+
 qf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787427822; x=1788032622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tbhBHxya38fjpp+X2qaBnuq4c0QicotBSxaB11D8ECk=;
 b=Oln0OFxXeSPAs+EbfZ53kDfxBAiK0aw9uSCKRH6NE3fJ1Ra+Mh1lEi3tFd/bW7rE31
 jKU7BbVoBRHnlq0gDv+DgFwznRQQGUcLYx+6c7wuY8OIVGGF3aOKA0RYuzAkaKcaKhzo
 kZeBDME8ig0QJtg1qpSwN5XQTAvNMrEPCWJZFKyYD/QdZG2xfmX7OZovRcHejwsdNhtP
 q5jWfK/mYYIYp+Kd4ta2J12neI9qoSHKCiw28mIpOcn7Cg3+QoNtDXw9nO0Gzm+y29DL
 8uSOUAPWIQjMyW+4oqp0zukEPhT+L9NwuWQMjsovNU65MJA371n4u/eslMB6IzFhkLa6
 hJ5g==
X-Forwarded-Encrypted: i=1;
 AHgh+RreoXEt6T5cl8kgYPnXXIhgxdu9U0DBVDJNGZ6Q7Om0rsMwcucexdntpoUWIedDvOaN+2LhHgGNCZ5N@nongnu.org
X-Gm-Message-State: AFuF++mRLoA4PrPabStjN3u7q50nKHQ6e1zB+LJojUNeQX7FpFYO93Zv
 /kZ4eoV/rPMUudVWvbu9q/5db0BG/kQvFDrogJzyJIojVD/aVZ0m89w4
X-Gm-Gg: AR+sD12N4YFBY19A7gLzXcAVMkf2+7iVEsyXZIozY8ysQseJfhGuJmNa0Eamz/RCqAu
 gnr5wKqcoSxDSoKxJZA4eD9ctpBMCK/+Lk6/LdtpiGSrloP4CdAC75KJ9dUROIXt2Qa1ZRDrn5g
 bnlWgkQWPLSYhIPyaQ3i/6E+ilkQhtrj9ZCg0X3HFET1aXEHSwiTQMlbcNq3bDUo5Xnr8g4KPAV
 SYAbMGgJaDBaTDkjfoRAyF9RgOGwOXJuGyVkFDc4RKtwtgSJO/JFXR8CC3xoRmb2l6b8t9/PxQp
 dhSlwJdrt/U4OctkFx+EnBKH1XCVNKv7POHKfIQIHiOMtmH3O+ZnN+L58mXNV3lHN+qxhB+Sxl0
 Odu+uIZBCSneZ3sSht3zXrMcT2thtuDij/d0lSn42vp5wnDXbyEJm+NKXzBd/yi7UY5FX82Y0es
 IWJBaZelpNC9SN6KwSL2PBjFt44pTle17wQNDCx6qEXZd/X3Rq3sHe5IKMqIH9IMEopyuCn4BXK
 GesdbwZKH28n17VtnzE7flDbxzbWVy7T/R2JzbhItNDKKvX/h4eQjmZ50ew6u+DDA==
X-Received: by 2002:a17:902:ec8c:b0:2d3:b109:bd7c with SMTP id
 d9443c01a7336-2d61a064bdemr269907045ad.4.1787427822079; 
 Sat, 22 Aug 2026 12:43:42 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (202.176.229.35.bc.googleusercontent.com. [35.229.176.202])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d676895799sm5892715ad.38.2026.08.22.12.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 12:43:41 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pierrick.bouvier@oss.qualcomm.com, almer@dabbelt.com,
 alistair.francis@wdc.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 farosas@suse.de, lvivier@redhat.com
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 wxchen0913@gmail.com, jserv@ccns.ncku.edu.tw, marscheng@google.com,
 eleanor15x@gmail.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v4 2/7] hw/misc: Add Sophgo CV1800B clock controller
Date: Sat, 22 Aug 2026 19:43:09 +0000
Message-ID: <20260822194315.2550260-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
In-Reply-To: <20260822194315.2550260-1-visitorckw@gmail.com>
References: <20260822194315.2550260-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=visitorckw@gmail.com; helo=mail-pl1-x630.google.com
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

Add a stub for the CV1800B clock controller. This is specifically
required for the SDHCI controller to function correctly under Linux.

The Linux 'sophgo,cv1800-clk' driver probes this device to determine
the clock tree configuration. This implementation sets the bypass
registers (CLK_BYP_0 and CLK_BYP_1) to 0xFFFFFFFF during reset,
matching the POR default state. This bypasses the PLLs and allows the
SDHCI and other peripherals to operate using the 25MHz reference clock.

Without this device, the SD card driver fails to initialize, preventing
the system from mounting the root filesystem from the SD card.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 hw/misc/Kconfig               |  3 ++
 hw/misc/cv1800b_clk.c         | 90 +++++++++++++++++++++++++++++++++++
 hw/misc/meson.build           |  1 +
 include/hw/misc/cv1800b_clk.h | 26 ++++++++++
 4 files changed, 120 insertions(+)
 create mode 100644 hw/misc/cv1800b_clk.c
 create mode 100644 include/hw/misc/cv1800b_clk.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index b8860dd3e7..2325ddd348 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -260,4 +260,7 @@ config XLNX_ZYNQ_DDRC
 config AXIADO_CLK
     bool
 
+config SOPHGO_CV1800B_CLK
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/cv1800b_clk.c b/hw/misc/cv1800b_clk.c
new file mode 100644
index 0000000000..b92f0889a3
--- /dev/null
+++ b/hw/misc/cv1800b_clk.c
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Sophgo CV1800B Clock Controller
+ *
+ * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/misc/cv1800b_clk.h"
+
+#define REG_BYTE_WIDTH    (4)
+#define REG_CLK_BYP_0     (0x030 / REG_BYTE_WIDTH)
+#define REG_CLK_BYP_1     (0x034 / REG_BYTE_WIDTH)
+
+static uint64_t cv1800b_clk_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    CV1800BClkState *s = opaque;
+    uint32_t val = 0;
+
+    if ((addr / REG_BYTE_WIDTH) < ARRAY_SIZE(s->regs)) {
+        val = s->regs[addr / REG_BYTE_WIDTH];
+    }
+
+    return val;
+}
+
+static void cv1800b_clk_write(void *opaque, hwaddr addr, uint64_t val, unsigned int size)
+{
+    CV1800BClkState *s = opaque;
+
+    if ((addr / REG_BYTE_WIDTH) < ARRAY_SIZE(s->regs)) {
+        s->regs[addr / REG_BYTE_WIDTH] = val;
+    }
+}
+
+static const MemoryRegionOps cv1800b_clk_ops = {
+    .read = cv1800b_clk_read,
+    .write = cv1800b_clk_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void cv1800b_clk_reset_hold(Object *obj, ResetType type)
+{
+    CV1800BClkState *s = CV1800B_CLK(obj);
+
+    memset(s->regs, 0, sizeof(s->regs));
+
+    /*
+     * TODO: Implement proper PLL state machines.
+     * For now, use POR default to bypass PLLs and boot via 25MHz XTAL.
+     */
+    s->regs[REG_CLK_BYP_0] = 0xFFFFFFFF;
+    s->regs[REG_CLK_BYP_1] = 0xFFFFFFFF;
+}
+
+static void cv1800b_clk_init(Object *obj)
+{
+    CV1800BClkState *s = CV1800B_CLK(obj);
+
+    memory_region_init_io(&s->iomem, obj, &cv1800b_clk_ops, s,
+                            TYPE_CV1800B_CLK, CV1800B_CLK_IOSIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static void cv1800b_clk_class_init(ObjectClass *klass, const void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.hold = cv1800b_clk_reset_hold;
+}
+
+static const TypeInfo cv1800b_clk_info = {
+    .name = TYPE_CV1800B_CLK,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(CV1800BClkState),
+    .instance_init = cv1800b_clk_init,
+    .class_init = cv1800b_clk_class_init,
+};
+
+static void cv1800b_clk_register_types(void)
+{
+    type_register_static(&cv1800b_clk_info);
+}
+
+type_init(cv1800b_clk_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 858ca845a2..4c6ae551ba 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -37,6 +37,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
+system_ss.add(when: 'CONFIG_SOPHGO_CV1800B_CLK', if_true: files('cv1800b_clk.c'))
 
 subdir('macio')
 
diff --git a/include/hw/misc/cv1800b_clk.h b/include/hw/misc/cv1800b_clk.h
new file mode 100644
index 0000000000..4d03d887c6
--- /dev/null
+++ b/include/hw/misc/cv1800b_clk.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Sophgo CV1800B Clock Controller
+ *
+ * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#ifndef HW_MISC_CV1800B_CLK_H
+#define HW_MISC_CV1800B_CLK_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_CV1800B_CLK "cv1800b-clk"
+OBJECT_DECLARE_SIMPLE_TYPE(CV1800BClkState, CV1800B_CLK)
+
+#define CV1800B_CLK_IOSIZE 0x1000
+
+struct CV1800BClkState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint32_t regs[CV1800B_CLK_IOSIZE / sizeof(uint32_t)];
+};
+
+#endif
-- 
2.55.0.766.g2966f0265a-goog


