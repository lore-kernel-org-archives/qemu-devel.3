Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6811C624D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 05:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x20Nt-0006he-Qx; Thu, 03 Sep 2026 01:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20Nl-0006ad-Oh
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:53:05 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20Nk-0006Sg-7j
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:53:05 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-84e27035206so1789537b3a.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 22:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788414783; x=1789019583; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+s6fEopBsd7ppapT8KmLn2uzOdAaKJBsOus7rTyRoiQ=;
 b=BUwzsxNFQkASONZA9oUyKAChshn/LlUK8DdDaype+ejB9me3Ozv8Ve0j6wTyIAFyBW
 Ftu5uJx8POraCNlBpSOilitDlk21rMBMaIjRojZIYCifZbjZAPeD6pdeO573tpj2m0LZ
 OT88FuWH3Q+YOWf+k75S5X3VIRONRQVPCigZ+ZIyuyaQYbNfyIgxm80COq7mKb9DadUR
 0uoedgdZMUShGCGiVpc8vBsrir78rlr42BvuUjJoP9RFQCmbSqc2gbtB4EXNDVyNyfH3
 /TXKVLjp0MlTNF2g6CvwFdD4QlWGwJRltnxfqJdJeALLGNDGVeicKS0Lh2WdF/+kSQdC
 wLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788414783; x=1789019583;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+s6fEopBsd7ppapT8KmLn2uzOdAaKJBsOus7rTyRoiQ=;
 b=cL+0v1Iq+qthVvwajlKeg/46XkUi7gojjhBVTkTY2NANihfWfQFimlSHPZijjEq0lI
 OXR3M1pfTfPGAffTxiOslakR4atESSLjoMSvUj0E9SLd2VpVnzrYwlHfiaRWfGv5oBs+
 ICW8Bd3Lm2YKDAwr8iPLnylJQF/2oUV2TPmXIB9KJItUWMKhey2OVv0XH4IJh8mR3r6O
 knh8lUHvGn/UrlCPb1Z2z5EoKnCJqnbpfNxPyfkxGNFnSeAX4p8lrTGY8pxyAhg08JGJ
 9XaPqKQMS42XJsX8K5Kv7pL/ewGePnJDn1Hx9hphfhW3wHIrrGAfhY0YiwSfZOwnYzD3
 9eGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSATbUgDBKva95Ige1hwuyi4kChkKn0KVp/qIH+/64PGdSt0GZi2SHR8w0+Ps+y7peL2TzSeX/4mst@nongnu.org
X-Gm-Message-State: AFuF++mxqCNB7guQWS8faKdJyL11GR4UJ7qvq/mNCgTPzFSr1O+E3DFz
 CeSEqbS7IyiNjEHImQh2/Tgj0F3kt6JbcmX6Q7g9qLJxRf5ZbbCrbEC+
X-Gm-Gg: AYBFou0+X2V2gvfQXuNgGhssmSD/+VtWyGd16nDxthY4qIvf75DYP88U8Ey5Xjg4XM0
 OT4CYf0ISJ4z2QPJAlNd1bqWZNaALrDzUgBGqZpzXOmwswmbsAWtf5mPP6EPkhDwOFBtkwdDITs
 fD6OPgKFXbaUpafgPsEzj/enAr3u4avJoFQcY9RE5i8SsZR+an1v23xYuEAQaldVRlci5dUAY9B
 Svn/0GKVI3BtvdcZU/6cV7ylHrMQjEWIbhhhYWFZeheBaSmnkFIPx5IfaSn2AgVgT4Mfdtyq2jC
 01jXGQTY90Qwq+dqGSagXRnUvhC/HMdgFFrEfWZCLtk0Jp9gnMCXTFk49jvymhTf+4CE4eJKV4C
 2VNPpm/Umd/0mpDyqaAISxuLUGT3huBVbHDNkK3Vzkkxi7E3VGXs5+dQAC5+qxLlb5igT3BXy1U
 9RR4BMqpXW2v1k8wigIGI2a0ZWR59DaMnndSY0Gs4C6CImFpT0dUWQ0FinOwa1T8DQiVX/3hw4s
 9QK03zGm0MowZS50ySzoUf3BhBbuRsm3QrSch9Q27uxlxoy7/0oIokO5JxkGX8FGtQlWfObTy95
 R92nC/yP+NOp7MAQoRV8OlP9ZS+jlZw=
X-Received: by 2002:a05:6a20:9381:b0:3c3:7179:a640 with SMTP id
 adf61e73a8af0-3d9adabade4mr14397385637.3.1788414782660; 
 Wed, 02 Sep 2026 22:53:02 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431990a39bsm2770619c88.3.2026.09.02.22.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 22:53:01 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 07/16] hw/riscv/atlantis: Make UART unimp region a SoC
 device
Date: Thu,  3 Sep 2026 15:21:21 +0930
Message-ID: <20260903055131.257903-8-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903055131.257903-1-joel@jms.id.au>
References: <20260903055131.257903-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Make the unimplemented region covering the remainder of the console
UART's register space a SoC child device, mapped using a helper. This
makes it easier to map it into the SoC's memory container along with
the other devices in the future.

While here, rename the region from uart0 to uart1. The uart0 name was
a leftover from an earlier revision that used a different device for
the console.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/tt_atlantis.h |  2 ++
 hw/riscv/tt_atlantis.c         | 19 ++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 7f7d4a5a5905..c9308aa57017 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -13,6 +13,7 @@
 #include "hw/core/sysbus.h"
 #include "hw/i2c/designware_i2c.h"
 #include "hw/intc/riscv_imsic.h"
+#include "hw/misc/unimp.h"
 #include "hw/riscv/riscv_hart.h"
 
 #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
@@ -31,6 +32,7 @@ struct TTAtlantisState {
     RISCVHartArrayState soc;
     DeviceState *irqchip;
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
+    UnimplementedDeviceState uart1;
 
     int fdt_size;
 };
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 373d4dabf3a4..a2fb83aab78e 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -411,6 +411,17 @@ static void load_fdt(TTAtlantisState *s)
     create_fdt_memory(s);
 }
 
+static void mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
+                                   const char *name, hwaddr addr, uint64_t size)
+{
+    qdev_prop_set_string(DEVICE(dev), "name", name);
+    qdev_prop_set_uint64(DEVICE(dev), "size", size);
+    sysbus_realize(dev, &error_abort);
+
+    memory_region_add_subregion_overlap(memory, addr,
+                                        sysbus_mmio_get_region(dev, 0), -1000);
+}
+
 static void tt_atlantis_machine_done(Notifier *notifier, void *data)
 {
     TTAtlantisState *s = container_of(notifier, TTAtlantisState, machine_done);
@@ -562,9 +573,11 @@ static void tt_atlantis_machine_init(MachineState *machine)
      * Create an unimplemented device region so writes don't fault
      * and reads return zero, which keeps Linux happy.
      */
-    create_unimplemented_device("tt-atlantis.uart0",
-                                s->memmap[TT_ATL_UART1].base,
-                                s->memmap[TT_ATL_UART1].size);
+    object_initialize_child(OBJECT(s), "uart1", &s->uart1,
+                            TYPE_UNIMPLEMENTED_DEVICE);
+    mmio_map_unimplemented(system_memory, SYS_BUS_DEVICE(&s->uart1),
+                           "tt-atlantis.uart1", s->memmap[TT_ATL_UART1].base,
+                           s->memmap[TT_ATL_UART1].size);
 
     /* I2C */
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
-- 
2.47.3


