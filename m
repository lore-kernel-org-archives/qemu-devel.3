Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B01C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL7n-00026h-9A; Mon, 31 Mar 2025 15:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL7Z-00024g-OC
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:48:41 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL7W-0003It-GZ
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:48:32 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39c1efc4577so477431f8f.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450509; x=1744055309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DM3m/dEg3svZtH8DDUxxaSWK9mVWBX/raHjBoGs/Nt0=;
 b=Utpm2mnckF08eG6b9wZtp0BLiUpVacbLcQcClLTk8OJEZtoGCKSE0K+5X7oO/JCF0G
 ef2rGcaALgydJWvwFl153F/z1OOS9n/uCM4MlsFdLlZnJ+WuEQwe+DOUJjizJ3I6AQWV
 IBS23WzKZXXHj+Qseh9z4M0OxLKCr04BSuX//FzuJT9OJA5162WkA1Yc9jtxfQ78tscQ
 4XZHi5GM+qwSFWqzWcrVTf70Aq1gglTS78Oy2z6RXx1uZBqRpdo4kQk0C3I4YsXahV06
 9hRDbZzjVAWarvyEsyoikzSggnq8NGNa1acM6j7FvHi3yCd1YQSEo8h9sLaxkyOcwpFd
 BuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450509; x=1744055309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DM3m/dEg3svZtH8DDUxxaSWK9mVWBX/raHjBoGs/Nt0=;
 b=XzRKsjxvR40z3ar4UPyffmR/2TYDH06zWhDUVQWUUnnM5zwyKuwlQFQdbaOp2Xj310
 EqrvFjZNEKTwkx197+vU3S3UQBOcKGfPWg4s86k3KwhCbu2IEj9AeZTenIJKHTeAti3M
 OVWq0DJ5wvtVKIhpqjAuaOcTkn8LUdeZOdewU1NQQ7jEitKDeYZMVG/8YcbJ5tf96oPR
 xHuSpKBqxsaVHdPZBokfE/VtaI7lL7dGv9Nuu25ML9hquQ2JqTJ/Uxd8Fqu9DHdReP1H
 s/p5a8kusGvudiy7k1nhe/7/UNxNbq+vag3rZlVxXplw9R3uSWZFlTXYT5TUz0dcM/I1
 3qgg==
X-Gm-Message-State: AOJu0YyrjKEuBwU3Nm2zc1W4iG+27rkY0AxJSwvmTqNTg997KY9N6tCE
 +bG4KMWBdx9amf2uVjp8YZqYqIW3ma0rxRj8SUPUptuNaOksh0XXKUhSKabsm7xoj3VzU7yAlnG
 S
X-Gm-Gg: ASbGnctl6fnlmyVQZ54YS/K91OZ87hsiKFdCmbkH1GuY/3cduo6dzkdcKdFqzkvtx3A
 03tNsSR+qsHysW29aNaMRwyIhdkvWL9lXw52o/GV1HTiERmOcnKjSLCRhUkKdHyUxxOrSIXz36L
 O/xPifeTxLxOBKHx9yx3RMyIvJxjCa2mzQkRYEWObKC4hpfdu5lHTxQhf9cPqgEe19ccm5OOx6G
 tTAXuNyDs+zgrgQmPB9c8I7FOwTImsBomN+Z6WzIDazZyoYXe8q8LAF/r/g/eYkMJO314Inv8/y
 Hc3iJiowUew8s9yvYBw6/ldHjD+yPfSW7h/l6d1IW9EKzEh10O7W7g8w6Ct37n+fpazYL/OTv41
 gZqS1qaHBpVZzbWWrlgg=
X-Google-Smtp-Source: AGHT+IFL0VZaCDMHcWYmXwgvkf0hiWkfezNNf0xlJUFZn+yi/98aQBChz2/ZNkkc79gpRKj1UWC3nw==
X-Received: by 2002:a05:6000:2910:b0:390:ea34:7d83 with SMTP id
 ffacd0b85a97d-39c23650080mr217350f8f.31.1743450508648; 
 Mon, 31 Mar 2025 12:48:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e33asm12254361f8f.66.2025.03.31.12.48.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:48:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/23] hw/arm/armv7m: Expose and access System Control Space as
 little endian
Date: Mon, 31 Mar 2025 21:47:59 +0200
Message-ID: <20250331194822.77309-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250312104821.1012-1-philmd@linaro.org>
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


