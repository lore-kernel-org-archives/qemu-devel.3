Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0AFF5A8D2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3ji-0000Tb-Tn; Tue, 21 Apr 2026 01:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wF3jg-0000SF-JE
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:33:25 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wF3jf-0004QO-0s
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:33:24 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35fc258aaa4so2359402a91.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776749602; x=1777354402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UOf+lRYb8kBYFx9GhbOqJp0Zp/ZahLQSb+Dx2wr2ujs=;
 b=O92i3bQT0LnSoQ95Y8TW9sugIOMFp2usuxLSRmUwiqd1ZZSW0ai6zfyOVt4xMmcvrr
 Lz9cC7mn/ghH8/arYX3H3TO0ghrFqdNmBcS7/FMV614mhFf9OcTo9i/aF9oj/DHaGKdu
 joOwO2SUq4kTWAIaJpwi3JmoEr9oOG2b0RgHDprGB9k6qdtoKxZ7IifWuCu+Qj1uOz/W
 B0qUHSI2TGFzUqhiANCeYgrnCArJkzOYVvjkto/169UBwtga8GxWs7JmaomWfXMWcU5Y
 zAEpGMmTC2UM+tcQiAOjTAaXVmotIZcgUZWXiLEP8th/U91EYftknczcB86KLdZsQv5H
 E8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776749602; x=1777354402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UOf+lRYb8kBYFx9GhbOqJp0Zp/ZahLQSb+Dx2wr2ujs=;
 b=IkyxSgdio4xn3d/KvtK+J9MPknjDiW8/HoHMq80nT+OcGtCI4VR28PJKEvL3h2BRxM
 5BX/ERRb6R+btdDwA+YihrZYmQFaemtC7Gq91V2586U0BFagT4p/5WdMDi17Mxn3nnV4
 fe0ov3gw5PGUgFcCZbag2HUijbL2LFkJfLZVqgEdtTa8hp97j1e9GjtvxkxsBTOtY/+Y
 K1Pg42WhMHwMUXSnvFzKppEvSV15s6kh2kmWXU0uFsIUAPaWgz8mnyT+8GsHvJ3c6F79
 KoQVxnvIjEQq2bWhQ5771WQdmsB1ZxOmYGcNLOT5EMM4x3AAePwfZ4BxwA1MXO4uSShR
 Iy7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ZkYlv1TXrtKx3SUwz6DSZPHjqvxVVLZ9ubS1nj4ZsBOMIYFhNT+5I7IyYem0kY+XzTvSlU9rsgjx/@nongnu.org
X-Gm-Message-State: AOJu0Yzi4JjcqmjSMqO/OzgGJzd1b3BKfXIpshTcEs6bUV9mRX5EL2Oa
 7aY1y5wrmsx0ysyydSukgor81AR7TEiPyVtaDF62oMguYs/ozZsSA+tf
X-Gm-Gg: AeBDietmlcwFPms1xYMG5ClEYG4pUkgRPwhGCwnGouTygImkyVHMSyxmj/2LBkrSXWm
 OORXM7i+jcXIumlSnQtXF1/nP+HuYOScX46XW9yLQ90QEkkzyT03csaRUD5tJ2VUwSYyOTAPS8n
 c0fEj7/NWTjL8twf3CaRlXLUWTYQChZRYb52f6bFGUzHutFE2UJQxjuw+9MwSCxboA0yNj1MrI5
 KrV2cwzQtxpBpMxVlaT5gPUDu+PxkYCimGADGXXmgaWqQrm4wF19gPatEEL9XPLPE1cb/JZCcj6
 SD7ngpI8N/K6Ubtl/edT+PPbZck3ztNYHZnbLLWWqRGYPCu4mBq92J/3cOclza6idjXTujizlPP
 Hne1V81EJ4PxSE4lb8nAwRGTefy33R9IqSeaIh6S9XIlfn3zTs9xYeYs/Mb72OsW6Bwl/IasG44
 /Tksc/NU96KCbvtxHOMcjx+NbhGn7LQTPFiqCTJLsMzzYTaC+lIAleNl2YP30dFq48ghlDGlEqc
 Z7VyzXnMt2UmQk06t1zSUNF6ST2iDLFAHL7eVvywQtX+pZ7
X-Received: by 2002:a17:90b:2fc8:b0:35e:5a4c:9069 with SMTP id
 98e67ed59e1d1-3614048a431mr16791897a91.14.1776749601522; 
 Mon, 20 Apr 2026 22:33:21 -0700 (PDT)
Received: from donnager-debian.. ([203.221.103.1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36141898ebasm12472308a91.7.2026.04.20.22.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:33:20 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 04/13] hw/riscv/boot: Provide a simple halting payload
Date: Tue, 21 Apr 2026 15:31:29 +1000
Message-ID: <20260421053140.752059-5-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421053140.752059-1-joel@jms.id.au>
References: <20260421053140.752059-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Nicholas Piggin <npiggin@gmail.com>

OpenSBI hangs before any console output if the domain init code sees the
next stage is not in an executable region.

If no kernel payload is provided to QEMU, the next stage address is
NULL, and the riscv virt machine memory map ends up covering the 0
address with the catch all S-mode RWX region and so OpenSBI prints
console messages and does not hang until the next stage boot.

The soon to be added Tenstorrent Atlantis board address map has RAM
starting at 0 and it loads OpenSBI there, so it is M-mode and not
accessible by S-mode, tripping the early check and hang.

Add a helper to set up a simple payload that gets OpenSBI messages
to console.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v3: MachineState argument was unused
---
 include/hw/riscv/boot.h |  1 +
 hw/riscv/boot.c         | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index fb90bf12399e..a1eb377474b9 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -78,6 +78,7 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
                                hwaddr rom_base, hwaddr rom_size,
                                uint64_t kernel_entry,
                                uint64_t fdt_load_addr);
+void riscv_setup_halting_payload(RISCVBootInfo *info, hwaddr addr);
 void riscv_rom_copy_firmware_info(MachineState *machine,
                                   RISCVHartArrayState *harts,
                                   hwaddr rom_base,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 3ea95c175c14..3a97fd1441f7 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -518,6 +518,26 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
                                  kernel_entry);
 }
 
+/* Simple payload so OpenSBI does not hang early with no output */
+void riscv_setup_halting_payload(RISCVBootInfo *info, hwaddr addr)
+{
+    int i;
+    uint32_t payload_vec[] = {
+        0x10500073,                     /* 1: wfi           */
+        0xffdff06f,                     /* j       1b       */
+    };
+    /* copy in the payload vector in little_endian byte order */
+    for (i = 0; i < ARRAY_SIZE(payload_vec); i++) {
+        payload_vec[i] = cpu_to_le32(payload_vec[i]);
+    }
+    rom_add_blob_fixed_as("mrom.payload", payload_vec, sizeof(payload_vec),
+                          addr, &address_space_memory);
+
+    info->kernel_size = sizeof(payload_vec);
+    info->image_low_addr = addr;
+    info->image_high_addr = info->image_low_addr + info->kernel_size;
+}
+
 void riscv_setup_direct_kernel(hwaddr kernel_addr, hwaddr fdt_addr)
 {
     CPUState *cs;
-- 
2.47.3


