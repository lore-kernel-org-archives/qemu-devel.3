Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A73BD2B921
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8JGl-00065y-M3; Tue, 05 Nov 2024 08:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JGa-0005fE-A6
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:06:42 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JGY-0002d2-A9
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:06:40 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4316a44d1bbso46496155e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730811996; x=1731416796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8o7w6mm+R/wQGpGGVYXrXktqPkxmlHPhQB9iwAgMFYc=;
 b=MxAp+1ehdfasvlGIbeGzzUdYsHvm29DUahviUlIv/AL3BUtqUlsUmQkGAAf/V9fbuV
 2F/qKMIQ4qT692ob6zlwFdhBcc/9UwiBRbaThXMnmCQVZg9SFctb+ypUwdtpGKnn4/Bi
 CMajKhcPq8XV0PMZejRvmybMiyp0OH25G0449MeMaDzJPCiQzOBCBtGMTHwZ6D6j/2Nk
 wQiFMkS5JzFaLJDgQudsryJRV8iL/71BqLFAZtZlRVQLK+JV+CvKRiERpnDSrgNsl6JO
 HWKqUi3g1upvQj39rVv+Y4eB7NwsvjOD8zFREY1Mq9TdN4btNHQmWiO9Zv883IUJuV45
 2J2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730811996; x=1731416796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8o7w6mm+R/wQGpGGVYXrXktqPkxmlHPhQB9iwAgMFYc=;
 b=krzmkqeHqOz3f6l/eD6xYFVjwqDPervCoYHdePLkkBr5N77zrdoWpAiaKfy68nXH58
 eiig2WtyzV8V/ZAn1GAw0dRzvYKTgkWHgm9TpT5otesNHCXM70CQZkIXNLT+a9Vu7f4k
 77vzRsCE5NortigHrAkT1DmsFSA2dlzdDPkokHN812sX1OSqDMnd2Bsr76+QKavOzTIG
 VRgRChOpug2Pdj+xZ1+K/PWqUyRbskIlqSWR5LXl1eksxXGny4OmzO9Rs+ncenOiyb0h
 cKDPyUJDkEoxVCIZQLmAf4igkhxytvvkZuPncEyEYWz0mAllAIoVSwLX3lcV0mfi9V1J
 CQ9g==
X-Gm-Message-State: AOJu0YyFFKVHPqAugrGm0HyMclj9tUeBoMz0F2jBoUEnkD66nltJcKVA
 pKqIyVYuVTh3Q4TiruPENO+6YZPyJqs20BgC/lRCmQJLumXHDcuOqkJT2E8jYPbn6oJuXnZNXJ5
 mtDk=
X-Google-Smtp-Source: AGHT+IGJfMAsKECXVoK0zYacWad+CWee04MBRfDuL0IXDekiXipIffi1uncuWI4/YK351Ggybd4Lqg==
X-Received: by 2002:a05:600c:3507:b0:431:4e3f:9dee with SMTP id
 5b1f17b1804b1-4327b6f46d3mr165594015e9.4.1730811995992; 
 Tue, 05 Nov 2024 05:06:35 -0800 (PST)
Received: from localhost.localdomain (86.red-88-29-160.dynamicip.rima-tde.net.
 [88.29.160.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5c65absm185489175e9.16.2024.11.05.05.06.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 05:06:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/19] hw/net/xilinx_ethlite: Only expect big-endian accesses
Date: Tue,  5 Nov 2024 14:04:24 +0100
Message-ID: <20241105130431.22564-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105130431.22564-1-philmd@linaro.org>
References: <20241105130431.22564-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

The Xilinx 'ethlite' device was added in commit b43848a100
("xilinx: Add ethlite emulation"), being only built back
then for a big-endian MicroBlaze target (see commit 72b675caac
"microblaze: Hook into the build-system").

I/O endianness access was then clarified in commit d48751ed4f
("xilinx-ethlite: Simplify byteswapping to/from brams"). Here
the 'fix' was to use tswap32(). Since the machine was built as
big-endian target, tswap32() use means the fix was for a little
endian host. While the datasheet (reference added in file header)
is not precise about it, we interpret such change as the device
expects accesses in big-endian order. Besides, this is what other
Xilinx/MicroBlaze devices use (see the 3 previous commits).

Correct the MemoryRegionOps endianness. Add a 'access-little-endian'
property, so if the bus access expect little-endian order we swap
the values. Replace the tswap32() calls accordingly.

Set the property on the single machine using this device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
 hw/net/xilinx_ethlite.c                  | 20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 8110be83715..8407dbee12a 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -123,6 +123,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     qemu_configure_nic_device(dev, true, NULL);
     qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
     qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
+    qdev_prop_set_bit(dev, "access-little-endian", !TARGET_BIG_ENDIAN);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ETHLITE_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[ETHLITE_IRQ]);
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index ede7c172748..44ef11ebf89 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -3,6 +3,9 @@
  *
  * Copyright (c) 2009 Edgar E. Iglesias.
  *
+ * DS580: https://docs.amd.com/v/u/en-US/xps_ethernetlite
+ * LogiCORE IP XPS Ethernet Lite Media Access Controller
+ *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
  * in the Software without restriction, including without limitation the rights
@@ -25,7 +28,6 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qom/object.h"
-#include "exec/tswap.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
@@ -65,6 +67,7 @@ struct xlx_ethlite
     NICState *nic;
     NICConf conf;
 
+    bool access_little_endian;
     uint32_t c_tx_pingpong;
     uint32_t c_rx_pingpong;
     unsigned int txbuf;
@@ -103,9 +106,12 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
             break;
 
         default:
-            r = tswap32(s->regs[addr]);
+            r = s->regs[addr];
             break;
     }
+    if (s->access_little_endian) {
+        bswap32s(&r);
+    }
     return r;
 }
 
@@ -117,6 +123,10 @@ eth_write(void *opaque, hwaddr addr,
     unsigned int base = 0;
     uint32_t value = val64;
 
+    if (s->access_little_endian) {
+        bswap32s(&value);
+    }
+
     addr >>= 2;
     switch (addr) 
     {
@@ -161,7 +171,7 @@ eth_write(void *opaque, hwaddr addr,
             break;
 
         default:
-            s->regs[addr] = tswap32(value);
+            s->regs[addr] = value;
             break;
     }
 }
@@ -169,7 +179,7 @@ eth_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps eth_ops = {
     .read = eth_read,
     .write = eth_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -256,6 +266,8 @@ static void xilinx_ethlite_init(Object *obj)
 }
 
 static Property xilinx_ethlite_properties[] = {
+    DEFINE_PROP_BOOL("access-little-endian", struct xlx_ethlite,
+                     access_little_endian, false),
     DEFINE_PROP_UINT32("tx-ping-pong", struct xlx_ethlite, c_tx_pingpong, 1),
     DEFINE_PROP_UINT32("rx-ping-pong", struct xlx_ethlite, c_rx_pingpong, 1),
     DEFINE_NIC_PROPERTIES(struct xlx_ethlite, conf),
-- 
2.45.2


