Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B993C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2bG-0005Yl-IV; Wed, 18 Dec 2024 17:33:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2a0-0003sv-QZ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:46 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Zy-0003Ky-K3
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:44 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-216426b0865so1797825ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561101; x=1735165901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCANHJZzdmh7o/b4Y2SxAZxP9CzPNdbu0e2gMuhfVd8=;
 b=LyuC4/sVuRo8Tw+TbfpQbPV1JiHZ5iUu91Z26Nq8biZ49n2GJbaM0vHz04NkqAziC5
 nLwgCgEHmINLMI0CyjBiF8b27Lzykvn7Negwn2oTVp9bBmkxNVYH83tW3b3E1sTtlexn
 9SbLNaJhy6EBNJPI0gMAV95ONtjtOT/OIDdI4Hl2V8AGqGmd2Df0O8Tbb/J2mgdXye6h
 tGz+h+a9ITp8Tjw9ACxxsK/4oIIBjqolOFqrWI4ITOWuuQzGRnGaCaH1vBqAWp2z4ZwT
 xEegundVfGRWsHqhtdLDNsPW7cd4wwc6/eBb2Qyki6VTZibkilP/C/GX+9lSM2l3rCWj
 Egqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561101; x=1735165901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RCANHJZzdmh7o/b4Y2SxAZxP9CzPNdbu0e2gMuhfVd8=;
 b=ulJTd96ZDbeplXBAL19qZjBCFLDsp2Q5zAwmLtdXJ19/lsBOTp5R1L732W8xO+tB7N
 RaU+ggvVRTayCchb1zOMbiBNPjEebnyI7SBFn3V1oEKYTBzPZxQTXNIV0PlDP98CyRWz
 1wvwA40bVKTigQd+Y2gKwRklA51igFnJ3g7x987UzGu6jLDRK2TMw5BdhhwwNt09NZ1X
 vLJo+kXM5pnNPQuVQ5tkY0A6k5i4kSShQCEa4SlEt2PJH8AURoJIxmwFcGfeskA4k4Kf
 R1YZzypjQ3Z8C2v6RPUnbb9WrH3WHAxCb61N9hOW+/tziVrTgQFM1k6zG25Ni9ups0AP
 iyWw==
X-Gm-Message-State: AOJu0YxfeYEtVS41l4UnG8cJdhmZsIKyYQjfYCePHWXQhci1Ym1tOFfr
 g1febASpav0XWhe/1WU3Ha1a3JHWv0MdVNFLZuK21kDn/WyfXxPgsaNHJlLx
X-Gm-Gg: ASbGncu0KLaJUFoHkBq9pIxvq4cJFIgpflPeZHoCQOUO5wZq22ObAosu7IuM33YAcxV
 WacF9mdhf1cZOKefkRc6+aUgqZBVN9Yt71hBNBAMXNPuuZ2G8rOlnMZ/5pyXv5AvrOVFDDzQumS
 mrbtv471YxIolHagV/O5IZpOHJwM7mlxXDRkriUhHvFt25zC3WXGEVuuRFmbj6lnvO46HoV557q
 EOz8rMU1dGgXUneoLW0lSUOWiATo7NdhBBfX7WPnMWeSyiqZaZ84nn4U7EHUj9o9HAc5T68MX5f
 ORBkBosu/TJP2viHU7aAzRTNN8ORX1TwkdDqbgO3QT/AMnIcM4bZxirenVF6HNA=
X-Google-Smtp-Source: AGHT+IHCWGFlo7VI5J18KznEOphYSvukB2w/g9pyxwF3JBopV5RpW6eJHIm4aO7WSue9+WAC1Ie7yg==
X-Received: by 2002:a17:903:22c5:b0:216:7ee9:2235 with SMTP id
 d9443c01a7336-219d96ff2c0mr17973605ad.43.1734561100931; 
 Wed, 18 Dec 2024 14:31:40 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:31:40 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 28/39] hw/riscv: Add the checking if DTB overlaps to kernel or
 initrd
Date: Thu, 19 Dec 2024 08:29:58 +1000
Message-ID: <20241218223010.1931245-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Jim Shu <jim.shu@sifive.com>

DTB is placed to the end of memory, so we will check if the start
address of DTB overlaps to the address of kernel/initrd.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20241120153935.24706-4-jim.shu@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/boot.h |  3 +++
 hw/riscv/boot.c         | 25 ++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 06b51ed086..7d59b2e6c6 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -32,6 +32,9 @@ typedef struct RISCVBootInfo {
     hwaddr image_low_addr;
     hwaddr image_high_addr;
 
+    hwaddr initrd_start;
+    ssize_t initrd_size;
+
     bool is_32bit;
 } RISCVBootInfo;
 
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 81d27f935e..bc8074fec8 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -70,6 +70,7 @@ char *riscv_plic_hart_config_string(int hart_count)
 void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts)
 {
     info->kernel_size = 0;
+    info->initrd_size = 0;
     info->is_32bit = riscv_is_32bit(harts);
 }
 
@@ -213,6 +214,9 @@ static void riscv_load_initrd(MachineState *machine, RISCVBootInfo *info)
         }
     }
 
+    info->initrd_start = start;
+    info->initrd_size = size;
+
     /* Some RISC-V machines (e.g. opentitan) don't have a fdt. */
     if (fdt) {
         end = start + size;
@@ -309,6 +313,7 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
     int ret = fdt_pack(ms->fdt);
     hwaddr dram_end, temp;
     int fdtsize;
+    uint64_t dtb_start, dtb_start_limit;
 
     /* Should only fail if we've built a corrupted tree */
     g_assert(ret == 0);
@@ -319,6 +324,17 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
         exit(1);
     }
 
+    if (info->initrd_size) {
+        /* If initrd is successfully loaded, place DTB after it. */
+        dtb_start_limit = info->initrd_start + info->initrd_size;
+    } else if (info->kernel_size) {
+        /* If only kernel is successfully loaded, place DTB after it. */
+        dtb_start_limit = info->image_high_addr;
+    } else {
+        /* Otherwise, do not check DTB overlapping */
+        dtb_start_limit = 0;
+    }
+
     /*
      * A dram_size == 0, usually from a MemMapEntry[].size element,
      * means that the DRAM block goes all the way to ms->ram_size.
@@ -338,7 +354,14 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
         temp = (dram_base < 3072 * MiB) ? MIN(dram_end, 3072 * MiB) : dram_end;
     }
 
-    return QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
+    dtb_start = QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
+
+    if (dtb_start_limit && (dtb_start < dtb_start_limit)) {
+        error_report("No enough memory to place DTB after kernel/initrd");
+        exit(1);
+    }
+
+    return dtb_start;
 }
 
 /*
-- 
2.47.1


