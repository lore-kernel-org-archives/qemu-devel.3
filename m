Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE17E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSFm-0008UI-3o; Thu, 19 Dec 2024 20:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFY-0007YR-GG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:25 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFW-0004Zy-UQ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:20 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-728f1525565so1732139b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659777; x=1735264577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCANHJZzdmh7o/b4Y2SxAZxP9CzPNdbu0e2gMuhfVd8=;
 b=H3SVLNAc0LrYDsggdn85IJL/YhCzOJ+kENbG2nR80WLId/KPK2RvbqlO9ndWmXv37D
 52Mg+VlHy5SIoSHvsfNFxaqCSUS6AIZcAOLuPPv5A7eT27rQZea3VEw21Fxa5Ojts/3B
 3nINdVfPOm2VkPUpQM3o9UDAP6QPjOe5//y8uYTvjC+huxxATio8LG4fj2kK1PQW4/lQ
 cWKeVotKbLugSe6ak1xD3nRTlkbpZ1xojffkN7Rxqs+rgjHdfVmxqNf2IOZqlUV9N3V6
 bbBgI8+4WAMG+DFVNtnBcL1fspk0sfVrj4h95SR3Kv/bt5Uv/t64oljq8wGPlFMDYqDT
 FOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659777; x=1735264577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RCANHJZzdmh7o/b4Y2SxAZxP9CzPNdbu0e2gMuhfVd8=;
 b=X6YyGWUA0rVes3Ak+SiqEioXGw1YKMohqzRobo+FrCSz7FbK660req5LfCoAf50oly
 BTCx8M5m2MSMSNVbom2pmUZRTbmUS1fjp8LFgngw/TpCL6+LWOuVP3Z8o1dSKV57P0WU
 X/96BpRfYdDA5fmXyws1MPSJe37aaIxhlOUpfrLrvMAsPsh4jHkaUiDl4E67zkXSJHCq
 9SIRiyA9m8vmk7eYFfqLBOXa0Xohhm+BIcn+kbA7I5od5Qg32SK1wj4GL2gInOu8dlbi
 36sX4Gg23xX4u7ZY2hcJPacUu6P0t1jhiIGBdzl2HeAu6RqXVPYP5uGOF0XFEnhIYM8V
 w2AQ==
X-Gm-Message-State: AOJu0Yz9pDweu+8dBiaUknKFQRbwaNcRq4mydSV/Svthsg3GRXDGYO1j
 xtyIbwyI+HYoQhFuctnrEQglmerA38Yk0re1yadsXAn0+fuyoivJUGPPvJiQ
X-Gm-Gg: ASbGncuSGk1vSJWBj6pDYyu+R5DVhBcC00WHDS2VSUhCOSHft4pOdXFlFCflZWgzuP7
 5ayh23fm9vif8UpwndMViYfcFCtw6VQDBB6sIgwhYTAicPvLYjJs1y7fUC1oOZTAxpNClfzUKqZ
 uybcSOlFTxz++mibDCLiQRl0PZLTf9aas2R/2RtvKd/XGzXnffpSHTG7Hj6ROSZhRhvzu05RM6C
 AL3OjmBSdvIJHhcmUERgtyqxREmoTQBwrnY/Er7bdd2whkpWNinzrcW4F5HiQxuEPT91EQvzYmt
 V/aGjahmUo/2KII8tOeuh0Y/dnpsB/joGZjs6ZTZmQA0yFDB6J6UYoVz7W81yl8=
X-Google-Smtp-Source: AGHT+IF4mtho33m/iCTl6owM03TFbsBxV+yWTfKcSxTrsZn3sKYLdxMEo3IoTg8VK/XBuUaQ4vXEwg==
X-Received: by 2002:a05:6a21:99a8:b0:1e0:d796:b079 with SMTP id
 adf61e73a8af0-1e5e0459b32mr1899391637.17.1734659777469; 
 Thu, 19 Dec 2024 17:56:17 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:56:17 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL v2 28/39] hw/riscv: Add the checking if DTB overlaps to kernel
 or initrd
Date: Fri, 20 Dec 2024 11:54:28 +1000
Message-ID: <20241220015441.317236-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
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


