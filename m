Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97289CF9C69
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 19:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stB4Z-0006UV-EA; Tue, 24 Sep 2024 15:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1stB4Y-0006TY-Ix
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 15:19:42 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1stB4W-00054G-RB
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 15:19:42 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42e748f78d6so49100315e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 12:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727205578; x=1727810378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hC7RUQh5iJG+tj/FBPCCf6KG23a/jAttxBOMoGR0rKk=;
 b=WapE7C94XMBgUm7YgN+lqFsR2UkSW8oE0wYJrzIEmxhZJDc/1Yh/b/OxURNwPrxmO/
 abfr3kde9Nf/pLHo4N2Qq76Nxv42F6y6lZVonufkpCdXKnhNrH+mVFmsB6zzMtvJFsov
 Xpmv0at91qv4PPlna/PMipbOu+AyCL+qp7rGBYsA4ND9qdUdSm4jDYwc/EuLiGisfJDR
 WqKev6sqpazBiDDy2OljPjhJH1SwedUTQbrJgjFpmJNz3n/f/mcfiUqGgRIHmv6FLugZ
 fukJG4d3/8ILND/zVmog5Fs9K34Fvwag5OYfv1Ht6xriDi3RbRiTqzfOGvxWnw+XxW+A
 hZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727205578; x=1727810378;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hC7RUQh5iJG+tj/FBPCCf6KG23a/jAttxBOMoGR0rKk=;
 b=a8Bs9HMCOh9SnXNOlyeYzklrXfuU0TLReFHhQIztqZkI6+EeJyFXSiaOhcVHZJ0hI/
 7Rg+cKwh6Pi50YjHeK+VX8x4jIoVd5qYcxNF2+NrlZTjgM7GZFsDePssY6E+JtUn36w9
 KdjROn1DUOM5FghQpg8UWqOuzvHvfGSVDZnkXZKfqG/5fFTxmM5hMHwDjAuKlYL67QkK
 4xDuBrjKLXjxDbrREiHQhEGr4VPHKjFGSptYW7qtu12xT00lVomuHgkiTQj+Z+zUeZaq
 3chdHe4/WXrFvqkWDE9g8LRZEX/eebBkSBSxeQZxAgT03q/3aLN00FEDLeJe2YScsz8W
 vkvQ==
X-Gm-Message-State: AOJu0Yzr+9g/0RZyZ0JMcbaln9blXux4V7bS+iLnpnweyrWJ0qgQmc2E
 haPBo8oxBxHy1KlVesEvglSIYQ/iDhYaWeIJh8Kg4Gq1LmomggNCSwMNUXbcuuI9iilDm4mjcnq
 iu7Hfr+qr
X-Google-Smtp-Source: AGHT+IGNJiayxioO1SXXuXTL+ED0RUP/8lk6UmsL3sIIbr/0JHE9J2LmBW+5IwCllQ3alFWoH5if8A==
X-Received: by 2002:a05:600c:3d05:b0:42c:de2f:da27 with SMTP id
 5b1f17b1804b1-42e9610381bmr1107585e9.2.1727205577664; 
 Tue, 24 Sep 2024 12:19:37 -0700 (PDT)
Received: from localhost.localdomain (208.15.23.93.rev.sfr.net. [93.23.15.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7543b9a4sm166337075e9.12.2024.09.24.12.19.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Sep 2024 12:19:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Tony Nguyen <tony.nguyen@bt.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] hw/arm/armv7m: Expose and access System Control Space as
 little endian
Date: Tue, 24 Sep 2024 21:19:32 +0200
Message-ID: <20240924191932.49386-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
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

Per the Armv7-M Architecture Reference Manual (ARM DDI 0403E):

  The System Control Space (SCS, address range 0xE000E000 to
  0xE000EFFF) is a memory-mapped 4KB address space that provides
  32-bit registers for configuration, status reporting and control.
  All accesses to the SCS are little endian.

Expose the region as a little-endian one and force dispatched
accesses to also be in little endianness.

Fixes: d5d680cacc ("memory: Access MemoryRegion with endianness")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/armv7m.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 7c68525a9e..4a01b970e6 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -140,7 +140,7 @@ static MemTxResult v7m_sysreg_ns_write(void *opaque, hwaddr addr,
         /* S accesses to the alias act like NS accesses to the real region */
         attrs.secure = 0;
         return memory_region_dispatch_write(mr, addr, value,
-                                            size_memop(size) | MO_TE, attrs);
+                                            size_memop(size) | MO_LE, attrs);
     } else {
         /* NS attrs are RAZ/WI for privileged, and BusFault for user */
         if (attrs.user) {
@@ -160,7 +160,7 @@ static MemTxResult v7m_sysreg_ns_read(void *opaque, hwaddr addr,
         /* S accesses to the alias act like NS accesses to the real region */
         attrs.secure = 0;
         return memory_region_dispatch_read(mr, addr, data,
-                                           size_memop(size) | MO_TE, attrs);
+                                           size_memop(size) | MO_LE, attrs);
     } else {
         /* NS attrs are RAZ/WI for privileged, and BusFault for user */
         if (attrs.user) {
@@ -174,7 +174,7 @@ static MemTxResult v7m_sysreg_ns_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps v7m_sysreg_ns_ops = {
     .read_with_attrs = v7m_sysreg_ns_read,
     .write_with_attrs = v7m_sysreg_ns_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static MemTxResult v7m_systick_write(void *opaque, hwaddr addr,
@@ -187,7 +187,7 @@ static MemTxResult v7m_systick_write(void *opaque, hwaddr addr,
     /* Direct the access to the correct systick */
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systick[attrs.secure]), 0);
     return memory_region_dispatch_write(mr, addr, value,
-                                        size_memop(size) | MO_TE, attrs);
+                                        size_memop(size) | MO_LE, attrs);
 }
 
 static MemTxResult v7m_systick_read(void *opaque, hwaddr addr,
@@ -199,14 +199,14 @@ static MemTxResult v7m_systick_read(void *opaque, hwaddr addr,
 
     /* Direct the access to the correct systick */
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systick[attrs.secure]), 0);
-    return memory_region_dispatch_read(mr, addr, data, size_memop(size) | MO_TE,
-                                       attrs);
+    return memory_region_dispatch_read(mr, addr, data,
+                                       size_memop(size) | MO_LE, attrs);
 }
 
 static const MemoryRegionOps v7m_systick_ops = {
     .read_with_attrs = v7m_systick_read,
     .write_with_attrs = v7m_systick_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 /*
-- 
2.45.2


