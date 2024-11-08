Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5295DD5C0EF
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9RAU-0006Us-LJ; Fri, 08 Nov 2024 10:45:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9RA8-0005kl-5K
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:44:41 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9RA4-0005iJ-Ey
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:44:39 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4316e9f4a40so19299165e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731080674; x=1731685474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nyi/+ckDY5gxjaj2iNxAGxUSeJilbxcUNQNXX+QNCJA=;
 b=jTRgdLQMDwpus0Gs7jmzqoPGAvowVOO/pRxUyhXiob8aSbqrjaDBA01+ZSFPyxgaMM
 4k9nMF46oKHD8z2t21xkdIf/W39XbgQjYkGNnacPXeXHzC1AGtWATnAN/hRvxdeSifNw
 K/FAtqPWf20HoazRoOsH4NYxY2yXqN0FN1SnEVRSRwxyxeeeZ/aejbQQlc0zw7TAxrSo
 KRJUg5G2633H3sczi80mXtyTrL/SNQ3gf+QEtlrF0BNz8hCf+p+mMtxgiBygK/DQi9R6
 i/INun4/gOR15oo0UY4mJWgcroxdvnPeFg0QxbHSwx/VjSdXCkOQGyVSmKTuaw9U8Tde
 c8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731080674; x=1731685474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nyi/+ckDY5gxjaj2iNxAGxUSeJilbxcUNQNXX+QNCJA=;
 b=whdhyiNMy29FH+20UTTHdT0UNzmsKyoHcsas6OVP0LGj402SOShhbAmmVKLOCqEeVC
 fF4BK7cWVhwN9gGBcTXLXNVoYStKscN7a4V983JSMWjr4jRt90cj61pTi3vrb053ZMky
 au0KeM+npu8GTihmeNlXqBnFr+U1WtQzkj8dMNQ1WG4YjufM/LovVMo88IDCqj2pNQkL
 R9PpzzpZOH1qe+rMT2MvMpYh5u9gPm7/jj+W3qUPVuZkB+qyvTRccnsySFWKyrgS9JJ4
 szXJ87aAXtSpfzbj8gDJrgQUZ/KXcAnA/a+LV7piNDxkC0TW9CN14L7U9I4h2zbUQUnO
 EdRA==
X-Gm-Message-State: AOJu0YzKedFE5HHdIFPE/SwDQPW498t4fUu2f5bHGqmjse2Tsfra3OxS
 T0SP9UppcUv7DD6sRiHLfaoI9Tmbr0NxYZ42yFACBlUO3YaiMD0UnDKGgn9itK3J3nHPlmTrQZg
 F
X-Google-Smtp-Source: AGHT+IFpn2ZFiNaRQVwn5c3YxiR0bfaprWtS8Ul5pA+aXdhjByggo7utK68ddxZwy0nitrnjguYj4A==
X-Received: by 2002:a05:600c:3ba8:b0:42f:75cd:2566 with SMTP id
 5b1f17b1804b1-432b74faa24mr26643275e9.2.1731080673766; 
 Fri, 08 Nov 2024 07:44:33 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ea647sm5157519f8f.68.2024.11.08.07.44.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Nov 2024 07:44:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 15/17] hw/microblaze: Support various endianness for
 s3adsp1800 machines
Date: Fri,  8 Nov 2024 15:43:15 +0000
Message-ID: <20241108154317.12129-16-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108154317.12129-1-philmd@linaro.org>
References: <20241108154317.12129-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Introduce an abstract machine parent class which defines
the 'little_endian' property. Duplicate the current machine,
which endian is tied to the binary endianness, to one big
endian and a little endian machine; updating the machine
description. Keep the current default machine for each binary.

'petalogix-s3adsp1800' machine is aliased as:
- 'petalogix-s3adsp1800-be' on big-endian binary,
- 'petalogix-s3adsp1800-le' on little-endian one.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 62 +++++++++++++++++++-----
 1 file changed, 51 insertions(+), 11 deletions(-)

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 2d2b3c9bca..df123ad4cc 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -55,8 +55,17 @@
 #define ETHLITE_IRQ         1
 #define UARTLITE_IRQ        3
 
+typedef struct PetalogixS3adsp1800MachineClass {
+    MachineClass parent_obj;
+
+    bool little_endian;
+} PetalogixS3adsp1800MachineClass;
+
 #define TYPE_PETALOGIX_S3ADSP1800_MACHINE \
-            MACHINE_TYPE_NAME("petalogix-s3adsp1800")
+            MACHINE_TYPE_NAME("petalogix-s3adsp1800-common")
+DECLARE_CLASS_CHECKERS(PetalogixS3adsp1800MachineClass,
+                       PETALOGIX_S3ADSP1800_MACHINE,
+                       TYPE_PETALOGIX_S3ADSP1800_MACHINE)
 
 static void
 petalogix_s3adsp1800_init(MachineState *machine)
@@ -71,11 +80,13 @@ petalogix_s3adsp1800_init(MachineState *machine)
     MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
     qemu_irq irq[32];
     MemoryRegion *sysmem = get_system_memory();
+    PetalogixS3adsp1800MachineClass *pmc;
 
+    pmc = PETALOGIX_S3ADSP1800_MACHINE_GET_CLASS(machine);
     cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
     object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_abort);
     object_property_set_bool(OBJECT(cpu), "little-endian",
-                             !TARGET_BIG_ENDIAN, &error_abort);
+                             pmc->little_endian, &error_abort);
     qdev_realize(DEVICE(cpu), NULL, &error_abort);
 
     /* Attach emulated BRAM through the LMB.  */
@@ -95,7 +106,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
                           64 * KiB, 1, 0x89, 0x18, 0x0000, 0x0, 1);
 
     dev = qdev_new("xlnx.xps-intc");
-    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
+    qdev_prop_set_bit(dev, "little-endian", pmc->little_endian);
     qdev_prop_set_uint32(dev, "kind-of-intr",
                          1 << ETHLITE_IRQ | 1 << UARTLITE_IRQ);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -107,7 +118,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     }
 
     dev = qdev_new(TYPE_XILINX_UARTLITE);
-    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
+    qdev_prop_set_bit(dev, "little-endian", pmc->little_endian);
     qdev_prop_set_chr(dev, "chardev", serial_hd(0));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, UARTLITE_BASEADDR);
@@ -115,7 +126,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
 
     /* 2 timers at irq 2 @ 62 Mhz.  */
     dev = qdev_new("xlnx.xps-timer");
-    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
+    qdev_prop_set_bit(dev, "little-endian", pmc->little_endian);
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -123,7 +134,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
 
     dev = qdev_new("xlnx.xps-ethernetlite");
-    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
+    qdev_prop_set_bit(dev, "little-endian", pmc->little_endian);
     qemu_configure_nic_device(dev, true, NULL);
     qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
     qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
@@ -133,26 +144,55 @@ petalogix_s3adsp1800_init(MachineState *machine)
 
     create_unimplemented_device("xps_gpio", GPIO_BASEADDR, 0x10000);
 
-    microblaze_load_kernel(cpu, !TARGET_BIG_ENDIAN, ddr_base, ram_size,
+    microblaze_load_kernel(cpu, pmc->little_endian, ddr_base, ram_size,
                            machine->initrd_filename,
                            BINARY_DEVICE_TREE_FILE,
                            NULL);
 }
 
-static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc, void *data)
+static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc,
+                                                    bool little_endian)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    PetalogixS3adsp1800MachineClass *pmc = PETALOGIX_S3ADSP1800_MACHINE_CLASS(oc);
 
-    mc->desc = "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800";
     mc->init = petalogix_s3adsp1800_init;
-    mc->is_default = true;
+    pmc->little_endian = little_endian;
+    mc->desc = little_endian
+        ? "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800 (little endian)"
+        : "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800 (big endian)";
+    if (little_endian == !TARGET_BIG_ENDIAN) {
+        mc->is_default = true;
+        mc->alias = "petalogix-s3adsp1800";
+    }
+}
+
+static void petalogix_s3adsp1800_machine_class_init_be(ObjectClass *oc, void *data)
+{
+    petalogix_s3adsp1800_machine_class_init(oc, false);
+}
+
+static void petalogix_s3adsp1800_machine_class_init_le(ObjectClass *oc, void *data)
+{
+    petalogix_s3adsp1800_machine_class_init(oc, true);
 }
 
 static const TypeInfo petalogix_s3adsp1800_machine_types[] = {
     {
         .name           = TYPE_PETALOGIX_S3ADSP1800_MACHINE,
         .parent         = TYPE_MACHINE,
-        .class_init     = petalogix_s3adsp1800_machine_class_init,
+        .abstract       = true,
+        .class_size     = sizeof(PetalogixS3adsp1800MachineClass),
+    },
+    {
+        .name           = MACHINE_TYPE_NAME("petalogix-s3adsp1800-be"),
+        .parent         = TYPE_PETALOGIX_S3ADSP1800_MACHINE,
+        .class_init     = petalogix_s3adsp1800_machine_class_init_be,
+    },
+    {
+        .name           = MACHINE_TYPE_NAME("petalogix-s3adsp1800-le"),
+        .parent         = TYPE_PETALOGIX_S3ADSP1800_MACHINE,
+        .class_init     = petalogix_s3adsp1800_machine_class_init_le,
     },
 };
 
-- 
2.45.2


