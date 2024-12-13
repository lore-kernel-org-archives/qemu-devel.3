Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B678DE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF85-0002ga-5b; Fri, 13 Dec 2024 18:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF80-0002Zu-Nx
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:31:27 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF7z-0002zp-0w
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:31:24 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-435004228c0so27163355e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132681; x=1734737481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ymSCUtBkTutu1ujFHz/qu8GtFUMUQrGBaFmmGh0PqI=;
 b=t/mLYhX7sEvTLT38EKp8+Tkx11ywG2iyRB+v0zNluDuzi0IedkCcCQcmpwkjACCAo7
 HX7O1ILl+mF1UGC+ZOXx8ueaV8gD3jVONyRzHREsWa5edKB0bxhpYNL0PrFJGLMo/Y0K
 s8JkdxjbHanDyoVmIvOlDEDUW4l7/wZ2zAVrC5mbLCY00Zria8p3U0yPSimZk5HQXuJH
 ERWp1JPBX70xNNcBhwfJrskzgcNUtgkUWGMUtWe+1e13wTg9JEprhe0gPHDFuSVN7lxf
 mUd8Ow5rtpwY5SBQcU0A7pO4F6JnQFDion21kXeZEe55mBBgRUQevUThjOXplabv+3ZT
 2GTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132681; x=1734737481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ymSCUtBkTutu1ujFHz/qu8GtFUMUQrGBaFmmGh0PqI=;
 b=LHW2jnbuqU4fqkmFPEPYi+SJuUXFfjUuxXuqhA/C8dHEAPqDbMG1TysVrZP62KnHE7
 67xw8/fme5EGWJUjjqdHreHjugByawma8TusLJQXMYiYZnoTaKsWB8kOKo1QFiplJ7by
 iFVJTF8u4vHx3RfivVk/3TGHP3Zit+/v6JQJ3faYwrK1Ybv9PyEWG47s7vwRBT4FAzRr
 YDMgBFiU0F7SN/MnzEWQoxcNhDVBBsAA22B9Y+1G0KVCchLLHJntwl67yYm1UKyxAw26
 JhTqvfnMahikr555HditFXtMAcjSw85VucGmnfWKZfKU4kekoDEhaSW1om3+3yO8WG3/
 h6uw==
X-Gm-Message-State: AOJu0YwRBLs8VF8JG0msu0hTSUJTCAnce4EZBVUym8PspcuZOuBXe4Kf
 UflDVmfcf5KTrfkIujUaH+QKk3KDjpDL+shCeLXUej03eBad/EDG2Fk1NilC/rbGhb9AfUDFfJy
 xG8o=
X-Gm-Gg: ASbGncv4UdFCqv0LlXHkAZjHINY/sDlA08Tc3gVD3xzrt5vHOnF4Wb6zcc52z4sQpxS
 piUMChTpQVbGqlaAScoWkEzwR3G5++t1PEZrbzZNKx/AoEjYNEjKbl67YEEzob8jO6LBNWipgKJ
 CB6SqbopYi6Nfa/iAdS7yv5OBU/rOFdz9Sb/uFZMQidhZwxYmpGOrpyBYXVHSu1OhvuucIfqSXW
 Z8f1UDfDWGF0R9tFyhYawVRDS+b99ZRbT2M2EYSEs4FrH9PwI7Wo7JOlW0W82TOvGRZ0s6rtLvI
 yMJw5A==
X-Google-Smtp-Source: AGHT+IHYzBGCN6evdfgKJYFb+x0tQ8pFJNgs6yuJA1NOrGC2osMDNj1EKpNEIwfBZhXUf712IQmEqw==
X-Received: by 2002:a05:6000:2a8:b0:385:fc00:f5e1 with SMTP id
 ffacd0b85a97d-38880ac5fbfmr4626423f8f.9.1734132681217; 
 Fri, 13 Dec 2024 15:31:21 -0800 (PST)
Received: from localhost.localdomain ([45.93.146.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801a47csm840455f8f.44.2024.12.13.15.31.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 15:31:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 04/20] hw/riscv/virt: Remove pointless GPEX_HOST() cast
Date: Sat, 14 Dec 2024 00:30:39 +0100
Message-ID: <20241213233055.39574-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213233055.39574-1-philmd@linaro.org>
References: <20241213233055.39574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

No need to QOM-cast twice, since the intermediate value
is not used.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20241125140535.4526-7-philmd@linaro.org>
---
 hw/riscv/virt.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 45a8c4f8190..2feb851f159 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1140,23 +1140,21 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
     dev = qdev_new(TYPE_GPEX_HOST);
 
     /* Set GPEX object properties for the virt machine */
-    object_property_set_uint(OBJECT(GPEX_HOST(dev)), PCI_HOST_ECAM_BASE,
+    object_property_set_uint(OBJECT(dev), PCI_HOST_ECAM_BASE,
                             ecam_base, NULL);
-    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_ECAM_SIZE,
+    object_property_set_int(OBJECT(dev), PCI_HOST_ECAM_SIZE,
                             ecam_size, NULL);
-    object_property_set_uint(OBJECT(GPEX_HOST(dev)),
-                             PCI_HOST_BELOW_4G_MMIO_BASE,
+    object_property_set_uint(OBJECT(dev), PCI_HOST_BELOW_4G_MMIO_BASE,
                              mmio_base, NULL);
-    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_BELOW_4G_MMIO_SIZE,
+    object_property_set_int(OBJECT(dev), PCI_HOST_BELOW_4G_MMIO_SIZE,
                             mmio_size, NULL);
-    object_property_set_uint(OBJECT(GPEX_HOST(dev)),
-                             PCI_HOST_ABOVE_4G_MMIO_BASE,
+    object_property_set_uint(OBJECT(dev), PCI_HOST_ABOVE_4G_MMIO_BASE,
                              high_mmio_base, NULL);
-    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_ABOVE_4G_MMIO_SIZE,
+    object_property_set_int(OBJECT(dev), PCI_HOST_ABOVE_4G_MMIO_SIZE,
                             high_mmio_size, NULL);
-    object_property_set_uint(OBJECT(GPEX_HOST(dev)), PCI_HOST_PIO_BASE,
+    object_property_set_uint(OBJECT(dev), PCI_HOST_PIO_BASE,
                             pio_base, NULL);
-    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_PIO_SIZE,
+    object_property_set_int(OBJECT(dev), PCI_HOST_PIO_SIZE,
                             pio_size, NULL);
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -1189,7 +1187,7 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
         gpex_set_irq_num(GPEX_HOST(dev), i, PCIE_IRQ + i);
     }
 
-    GPEX_HOST(dev)->gpex_cfg.bus = PCI_HOST_BRIDGE(GPEX_HOST(dev))->bus;
+    GPEX_HOST(dev)->gpex_cfg.bus = PCI_HOST_BRIDGE(dev)->bus;
     return dev;
 }
 
-- 
2.45.2


