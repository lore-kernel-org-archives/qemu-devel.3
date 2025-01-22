Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83007C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 06:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taUfL-0006Vk-H3; Wed, 22 Jan 2025 01:56:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taUfI-0006VZ-FM
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 01:56:40 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taUfG-0004r4-Ml
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 01:56:40 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so64296715e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 22:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737528997; x=1738133797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tjh5IVOBSPsoqIOCCYuc+Rv5XXY/OFaWEQyojhKRV8s=;
 b=YukDnHI0g0NWcRdEPUo7fg+Iuu792CjZ3weP+Umc0kp4Vudt0WVCbaLGThW83Mw2LF
 k0Wg8dMgVOd6tevUqF/pT41cyNBYtE1sOMbRChSKtNfdsYLYADquhBzL/0kSIlEa2r4O
 lcS01hPVnW5A40XOVKNmSwj1Sq/i/XMvQ2JvGXuc7VqhxvNPn/1svAaE2eLiVpFkFfos
 3bij9ynL5C67euqkIW4kUsnp84DUZO2HcHUzo8QD9EY7OxDg5J6mAm2DdsKlBpxhvHgP
 9WHN5Vz/monMwAPqjiNUwV3MOkQgDcfIKvrJRJcr1OsoMzrS+PX7xHq+RoCkebhQAcXC
 /MVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737528997; x=1738133797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tjh5IVOBSPsoqIOCCYuc+Rv5XXY/OFaWEQyojhKRV8s=;
 b=t2DUtZPrIZ/UCpbY9eyERK7g3xAZbr9FGq6ujMmVx6JSFTaqp1OgMxtAY492p7sgVu
 gDNyUq4ce9C5USxC62hr+tDei5RBVDOG+8LYM3u22iyeL4jU0DZVJF13v/a45MnM24/x
 LjJVC9gn+5WgLugjKzNB6peobzso+GZpWQtJqz5QokNBZmo77w8TpRpILa7XcDkR2psE
 D4tLgjGAvzukR/06KTnDMxWOmPK28316COS5NQmjhbZ3jRRtmbqtyPgf5DYAXTEQHT94
 ufc00mveGNtQ3rLprCK6LBhO7G+a+EAkitzwvifiOCGa3vwac9rYdv7tQzUOnfP2bGw8
 OMtQ==
X-Gm-Message-State: AOJu0Ywt/nfXlXUhh1j1EI0+5q0Gj/GAiJMwOjpDowhA5u2a5U5j0fax
 3RKIKC+fXWc7wK4l+W2KWGj/kX6IgEurOBfbidXXRv1SzEVX2RE3PL0e87zCAtVMJnplGo75rWo
 /7M8=
X-Gm-Gg: ASbGncs/lXBgESKHXT6OIyrXzO2/69JVoKzNv1IeUFsb13xGIIG+5EiIUG+azbs1zuY
 FrhWn/7B7hbsfz3xdRgsBMFAiGXfyPVZ2h/7YuJVrRgNaEoTcqNMxS6RZ5d9b5XDffo/6AumjB1
 oJsQvjh3K2pHHXeYFqm930x+92oa9nNUDe42hBf0H3l+oeEYqlEmxuYzqYK9Oa23o0U+jy2lEY8
 0HwUZP/u9RP0floYiK+2dSMOUgcYER01x0o7AqfHAAHmz65tNbaNpgM5e2Y/DNYC5yaymUC9UL0
 vid1z2HniVKn3MPOp1lOGaOhzTP3KtP2m5epUdX4aaK8
X-Google-Smtp-Source: AGHT+IFVWgmVFsOL6GSlruA72nMhcqS3yCU5ne4VUvUTPlcz6gs5wigi/PYUgrlfuZvsAyRkkGQYQg==
X-Received: by 2002:a05:600c:9a3:b0:434:fa73:a907 with SMTP id
 5b1f17b1804b1-4389191b819mr182618535e9.13.1737528996711; 
 Tue, 21 Jan 2025 22:56:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf32845e8sm15666718f8f.97.2025.01.21.22.56.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 22:56:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] hw/cxl: Allow tracing component I/O accesses
Date: Wed, 22 Jan 2025 07:56:24 +0100
Message-ID: <20250122065624.34203-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122065624.34203-1-philmd@linaro.org>
References: <20250122065624.34203-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Map the component I/O region as UnimplementedDevice
to be able to trace guest I/O accesses with '-d unimp'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/cxl/cxl_component.h |  3 ++-
 hw/cxl/cxl-component-utils.c   | 14 +++++++++++---
 hw/cxl/Kconfig                 |  1 +
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index ac61c3f33a5..54fd369a838 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -18,6 +18,7 @@
 #include "qemu/range.h"
 #include "hw/cxl/cxl_cdat.h"
 #include "hw/register.h"
+#include "hw/misc/unimp.h"
 #include "qapi/error.h"
 
 enum reg_type {
@@ -218,7 +219,7 @@ typedef struct component_registers {
      *   0xe000 - 0xe3ff CXL ARB/MUX registers
      *   0xe400 - 0xffff RSVD
      */
-    MemoryRegion io;
+    UnimplementedDeviceState io;
 
     uint32_t cache_mem_registers[CXL2_COMPONENT_CM_REGION_SIZE >> 2];
     uint32_t cache_mem_regs_write_mask[CXL2_COMPONENT_CM_REGION_SIZE >> 2];
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index cd116c04012..6d593475d00 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -192,17 +192,25 @@ void cxl_component_register_block_init(Object *obj,
                                        const char *type)
 {
     ComponentRegisters *cregs = &cxl_cstate->crb;
+    DeviceState *io_dev;
+    SysBusDevice *io_sbd;
 
     memory_region_init(&cregs->component_registers, obj, type,
                        CXL2_COMPONENT_BLOCK_SIZE);
 
     /* io registers controls link which we don't care about in QEMU */
-    memory_region_init_io(&cregs->io, obj, NULL, NULL, ".io",
-                          CXL2_COMPONENT_IO_REGION_SIZE);
+    object_initialize_child(obj, "io", &cregs->io, TYPE_UNIMPLEMENTED_DEVICE);
+    io_dev = DEVICE(&cregs->io);
+    io_sbd = SYS_BUS_DEVICE(&cregs->io);
+    qdev_prop_set_string(io_dev, "name", ".io");
+    qdev_prop_set_uint64(io_dev, "size", CXL2_COMPONENT_IO_REGION_SIZE);
+    sysbus_realize(io_sbd, &error_fatal);
+
     memory_region_init_io(&cregs->cache_mem, obj, &cache_mem_ops, cxl_cstate,
                           ".cache_mem", CXL2_COMPONENT_CM_REGION_SIZE);
 
-    memory_region_add_subregion(&cregs->component_registers, 0, &cregs->io);
+    memory_region_add_subregion(&cregs->component_registers, 0,
+                                sysbus_mmio_get_region(io_sbd, 0));
     memory_region_add_subregion(&cregs->component_registers,
                                 CXL2_COMPONENT_IO_REGION_SIZE,
                                 &cregs->cache_mem);
diff --git a/hw/cxl/Kconfig b/hw/cxl/Kconfig
index 8e67519b161..d6c7536001e 100644
--- a/hw/cxl/Kconfig
+++ b/hw/cxl/Kconfig
@@ -1,3 +1,4 @@
 config CXL
     bool
     default y if PCI_EXPRESS
+    select UNIMP
-- 
2.47.1


