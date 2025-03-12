Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4FFC28B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 10:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsJdX-0006sF-G0; Wed, 12 Mar 2025 06:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsJdV-0006qx-Gi
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:48:29 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsJdT-0003ui-HY
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:48:29 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso17246505e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 03:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741776505; x=1742381305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bGTk3wZieMnMBHFN56YbH1bCGtYh8kBdfeLs078qQRo=;
 b=hDkVtQ2RK1Al64rEhSl0+th8E8RusTtmcI1Vsc2Wqv5kPb0xWzztL1koAt+tFcmqsl
 1LtwCzU/iIVbeoikjrztEWCpfmrhqVA7cRP/zYlXs25Lttm4QwMSiYVOByIK4bgEZgLq
 kBU4+C5+gHD5/MWcfCDTDdsUrGarqNAKnEh/+lMtHaqKzDYAbOr4XWeO8Khu3CjGbQBk
 2AR7m1KWqsN47S+hhK4vJdhLoxDAtldd7do6L5WF7UbVapjPL1LUWAgMik1vSsEl/6pX
 mZfCD2bEEYB0WX67UsPvoW+LtgXR+ON/lr6xkumFpdLuRNJ9gPi6RwwGN7KRyW7WmJVA
 eD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741776505; x=1742381305;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bGTk3wZieMnMBHFN56YbH1bCGtYh8kBdfeLs078qQRo=;
 b=Vyg59zpUnGgecbJ9rMh05+e+8xZZfkggeYtfgnuFxFTnA4InwhKvsKEi3Ep+jShvMd
 lsBaLDAqExjCPsi4JnnjgZH47oxCdI80JSZx+1zMoP3huACp72O1UkbL2+xjNQev9HVX
 gURqLzezbFc+PenRNts7o82FJ2+3kRp8/gYdChwQrw+wgbexELwPO2HmOxZLHtWKNQo1
 CTFMpw5khxnDuET7vyN179nwcApSokkesuBwfmeC6jnDBcrn2c+Uk8m2+MgHzyzXFdpX
 1qBSu2hdDlxGo6GInYboVLTzQlKInso7eSTJ26GSG5miPgTuK2k2o6TD176pzttAqcqT
 sQVg==
X-Gm-Message-State: AOJu0Yz9vx0iGz0oxfeJhJ5jF/76S0BZ/A/sJ+hTHRdw/gnd4AofUhYj
 RqSUgehvvX/ljvmyHJRFtH4WcvF7WMPvCqmZEWU8H5/x/Y89KMqoNaF2Yu/IKAZEeLHrUgZ4GPA
 q
X-Gm-Gg: ASbGncvseOXCwt7tpeeT4um0GRQvMLUyF08EOn75nr0vnxrYdA0JoQ8hwGhQtcu4iPC
 FLBpNoM0IJQjvqIz2ktivFx1Yzk/AOdTJ7owromdpfmlFQFJr5KGBGGq3ONlFTaWazGq2loVJVW
 ldUZ7a4lrwMiCVRH8xaJwPrepN/uU3NutsZxtvLunX+sGt6eUvUv+gnT8BH4LqEb6R+PVIbUlyL
 FMS5U+Vy8o4Na2DAChOMu/YjoQZ52bmrcPmjxZSlCHKlMa9ZjEiAOrpwxtviv37a17QbK7vsaFW
 kCYBhfeiU3Vd3kcipE6s7xzWRymC/s4s9C1/iP9NARX1IGwQBqqjmMtpfC8sytx6m5zTwr0j47w
 P9s4ljP2emMFtrQ==
X-Google-Smtp-Source: AGHT+IGT+9FArTQoD99QGe7wmcg8j0ufLMs8Sx4n25xM84sinx1DDa4xm3+yAOfOy8kB+dX5Wibfsw==
X-Received: by 2002:a05:600c:4e8f:b0:43b:cc3c:60bc with SMTP id
 5b1f17b1804b1-43d01be6503mr75918495e9.15.1741776504870; 
 Wed, 12 Mar 2025 03:48:24 -0700 (PDT)
Received: from localhost.localdomain (99.167.185.81.rev.sfr.net.
 [81.185.167.99]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a72ed3csm17441755e9.6.2025.03.12.03.48.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Mar 2025 03:48:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Tony Nguyen <tony.nguyen@bt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2] hw/arm/armv7m: Expose and access System Control
 Space as little endian
Date: Wed, 12 Mar 2025 11:48:21 +0100
Message-ID: <20250312104821.1012-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

We only build ARM system emulators using little
endianness, so the MO_TE definition always expands to
MO_LE, and DEVICE_TARGET_ENDIAN to DEVICE_LITTLE_ENDIAN.

Replace the definitions by their expanded value, making
it closer to the Armv7-M Architecture Reference Manual
(ARM DDI 0403E) description:

  The System Control Space (SCS, address range 0xE000E000 to
  0xE000EFFF) is a memory-mapped 4KB address space that provides
  32-bit registers for configuration, status reporting and control.
  All accesses to the SCS are little endian.

Fixes: d5d680cacc ("memory: Access MemoryRegion with endianness")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/armv7m.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 98a69846119..64009174b97 100644
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
2.47.1


