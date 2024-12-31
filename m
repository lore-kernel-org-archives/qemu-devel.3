Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA9EE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSili-0002MN-7N; Tue, 31 Dec 2024 15:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSilg-0002M8-8k
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:08 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSile-0000qY-LB
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:08 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361f796586so106895275e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676584; x=1736281384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GTH2NS4uBQl2BnMaC5NUzMTAA4jFlWhBioB2cxgitBU=;
 b=K1KX2neA/ULhbEPrDQau4crtUIeLDFnDBBx9s7RaM/D0hHo37fPROQwk+CUAYK1mMS
 lFmGMcHWuzVCqvZVrH4sHogchJwXufs6mRQ0Uz8wuN3g2pt/0BPuzCaZbdtYKsBlq3aj
 I6TTsTxjK8a7yvkU4CWcZY4SlKLcpHk9ySLNRphUVXLh10RCnY62lDvijAnMS2uOqUBu
 3nlliTO/nJDp3dsfX0/WTRkkCUpedeRHJebaZFSu3rdlax2LGwmah4UbFqbOk0BF7APv
 XW++vC5XSykILT7aAN39iArtp8DIQqdFI7ysyit1FFQ8UKWrtliXP+sgjj6V823Gznbf
 XjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676584; x=1736281384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GTH2NS4uBQl2BnMaC5NUzMTAA4jFlWhBioB2cxgitBU=;
 b=McBpFYzrMNHpIMJRBRaxu/9fT+C0pv/+JOj07w1qbGngHsWckVzQnUB1QKZ8cqP9zl
 FXYu17PyquhVKhHn5xnBLAmEF7v74hTittBEcLOsavz+W7CzP3PYX8ch02hmCERH3BFb
 p/K6ouqe3fTxS9Xdc8P7MmkP8RD99++Ax8w64H+vZUYOyxzak/mbqxb8q4WROhAydQMP
 cdzX/SBIGvXdGz9kHmh2/qclMGTczZ1FRxdbkaY9F9r/Qi0c3Q2zGjaS6xvBt5yaD36q
 jFyU/IoyGgwWzOsPOFSrBPhHIMDv6h8Yc57eOLPdR1Vo0Sn8/I54xfpOIbSbCmQ3s5XY
 u9FQ==
X-Gm-Message-State: AOJu0YxmbB7c/ia9wsjxnW5J9lV4HeBkClpOD/E742d6QjCUCV6gRI1H
 oT1fS+39UR0o4utI2yZpQJ3AYf64mpQkRC3xDRNG3MOpK2mL9YnNqnzC7VkEdNZYvZir8x9OjRM
 C6AY=
X-Gm-Gg: ASbGncvxCDFhXs04qWv8bvq7ZQLRLK1tRG9RDp6iULbEsjeKOAc9D61554YCsejjBW4
 MD5zHlnEzPyGRhN9voMxNsCfFNe6lufeg6SoHzMnX2c818JJBI2S3BjJY1ep7w2fgtP8kaHAa0C
 TPW+tOqyKrievu+1OFsQQ6Y5hKK/3tjdOlqX/IRSuAh+OaNTmNNgA3jUDxOcqfZj/YnVgGE391n
 5BLCiDKuSa7n2nwyTzeufKVun+EO1jv2xKhN/iGaOh3jEQqw9QjKj34w/oZd7sTg778RonUkSvC
 itf7Tc6/iVfsv7/Kq7DmTOSP44IL8o4=
X-Google-Smtp-Source: AGHT+IEwcfIODGsf6fHeLL6ojpLHonOjR56fo6RGVOY0Z+T+onxQTzRXOP/xwMCtAdIXihuAM7hA7A==
X-Received: by 2002:a05:600c:1383:b0:434:fddf:5c0c with SMTP id
 5b1f17b1804b1-4366835c41emr342504985e9.4.1735676584615; 
 Tue, 31 Dec 2024 12:23:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b4471bsm431993565e9.44.2024.12.31.12.23.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:23:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
Subject: [PULL 07/29] hw/i386: Mark devices as little-endian
Date: Tue, 31 Dec 2024 21:22:06 +0100
Message-ID: <20241231202228.28819-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
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

These devices are only used by the X86 targets, which are only
built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
definition expand to DEVICE_LITTLE_ENDIAN (besides, the
DEVICE_BIG_ENDIAN case isn't tested). Simplify directly using
DEVICE_LITTLE_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-Id: <20241106184612.71897-2-philmd@linaro.org>
---
 hw/i386/kvm/apic.c         | 2 +-
 hw/i386/pc.c               | 4 ++--
 hw/i386/vapic.c            | 2 +-
 hw/i386/xen/xen_apic.c     | 2 +-
 hw/i386/xen/xen_platform.c | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 602c7696565..75751060009 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -214,7 +214,7 @@ static void kvm_apic_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps kvm_apic_io_ops = {
     .read = kvm_apic_mem_read,
     .write = kvm_apic_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void kvm_apic_reset(APICCommonState *s)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 53a2f226d03..71118765884 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1068,7 +1068,7 @@ DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus)
 static const MemoryRegionOps ioport80_io_ops = {
     .write = ioport80_write,
     .read = ioport80_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -1078,7 +1078,7 @@ static const MemoryRegionOps ioport80_io_ops = {
 static const MemoryRegionOps ioportF0_io_ops = {
     .write = ioportF0_write,
     .read = ioportF0_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 0e6d058d063..14de9b7a820 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -718,7 +718,7 @@ static uint64_t vapic_read(void *opaque, hwaddr addr, unsigned size)
 static const MemoryRegionOps vapic_ops = {
     .write = vapic_write,
     .read = vapic_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void vapic_realize(DeviceState *dev, Error **errp)
diff --git a/hw/i386/xen/xen_apic.c b/hw/i386/xen/xen_apic.c
index 101e16a7662..a94e9005cbe 100644
--- a/hw/i386/xen/xen_apic.c
+++ b/hw/i386/xen/xen_apic.c
@@ -36,7 +36,7 @@ static void xen_apic_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps xen_apic_io_ops = {
     .read = xen_apic_mem_read,
     .write = xen_apic_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void xen_apic_realize(DeviceState *dev, Error **errp)
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 0f68c3fe7b3..dd648a2ee94 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -514,7 +514,7 @@ static void platform_mmio_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps platform_mmio_handler = {
     .read = &platform_mmio_read,
     .write = &platform_mmio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void platform_mmio_setup(PCIXenPlatformState *d)
-- 
2.47.1


