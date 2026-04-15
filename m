Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04123FA0C3A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 06:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCu3m-0001OL-Vc; Wed, 15 Apr 2026 02:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wCu3i-0001ND-9z
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 02:49:11 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wCu3g-0001lf-Nx
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 02:49:10 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so49059805ad.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 23:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776235747; x=1776840547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I40LmaMvAl7ia3mfi8/ye+EBtWhiI0K4i/01QGVKBqY=;
 b=AZTG8n7nO1PlOuHPjPF5RgPsOwqLcLpUQTurLbgC+6bUZCfFi6X2eWxmKZ28x1386N
 4qStf8jB0sxU/V9XKiSNedXnjwLoTt0sUXQK1yo/Ndrny0XErZwbq8H6dW/z0/4g3P/O
 HTUoj/6tyFKIKdyXMzy3BblP7UrjvK7VAP1QeEbgTadKeO7Yt67WPgxbM83SiwRcxlD1
 nF+HC9XppdNO5+NUoE9O7037iRXf2cLGLvQaSvTDfpzFUVWAjrSzqwVd1SRxWjSFfRmk
 Npi9buL5W2Gusb4K3/W9W8Oc7rsdvGRMjUOtcbP8g8G8SHY7LQO+DJPLI6h9dkeOLGqk
 mQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776235747; x=1776840547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I40LmaMvAl7ia3mfi8/ye+EBtWhiI0K4i/01QGVKBqY=;
 b=V0VoX5Jc6CeHOc5TGExHFvQuYLyXu4mb15tCXwILnoRKM5PbaQNZMY3JL1lRUOnoft
 lI2bD5J0Ip9XkQD4kNgJLOyfxATkaCkyWA5VwufKpep5ep7OW3U5Mlql/JSwnA1QgFCC
 jHT7SzAZTLGvG/GWv491OvYUujdt5HBTjKhCFnSXrH+BLP8mEpEAsGzHK5gpH6IhhwbY
 rdHZECp6XNK8Z6UNmgjIJakbjVZsUUBc3sLoAaFFL3rquEObqaty73+OJz/6XIqamyrx
 2xWfiQPf30bjRGpUjPanlXe3v3gWPkJeVKzEF1HbHrh4pNymXSnxsEWxIJghTI96q4SD
 DdjA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+D17rwIHkwIzycg5ck+wonUsRe5T8XYj5vU2Ov2YBPI1gqpLf9SkGCEjYfOmwcWIQlOdsEh2SJ1+7N@nongnu.org
X-Gm-Message-State: AOJu0Yx3sjZ5XQ4MLH4Wt/TOp0xbfqjkVL6vMFyU7UXE6rXVE10PJ4JN
 Tpl94C4+JNiQ/EISMWGKDprDOi/oSwpMoUvgkA2rni+nGVjv4hmUieZz
X-Gm-Gg: AeBDieshPuHgSwI0EOwGv9nAF7Pi2DM1khUz1orZP99OpHuxBXMG44+EJcaJ9UXdX9b
 BtLJgQfnWFF3yJPxip+Qcjo2FRkt41TisqihLrJKcy00VqxITzxHPcxQZYTEPbeR4FUzPmrQ8pl
 tAv2bSv9q//oDCh1o0EgkDaXRRZOam85RBDoa/sHclxZ/h4T3sL/KzX2h/x+8VrCdWIsccFH51C
 NhwO3GZxxCvRRrEBCOpje53ZLm082VPeAp2FGkVKaEgJT7H5ScomRT2vI8Jk8wFXD7CiFCT3IXh
 naBExhd/gxYSfei96ZVzGKg/3XV3rB84zW7j1LwhXufsgrjBEI0qms462ORcuF9ZLJ3eCuWgFYz
 +6HGmrwEkPC2HLUF6OSpYi5zUdsW6LrVmwhMbqg+heS+X0OFTzNTDlMZ5b0eBOd21Cf2Gh7ZJ/O
 8iQRbM2Q0jgCAYNgTeJFtLuzDKv/uIN0JpUPrNTLbhcpMJY1xQWfIhh+eITZwpkUHFFZiCCVIyO
 dEenLaPR19z9RGFwYH/PA==
X-Received: by 2002:a17:902:8c97:b0:2b2:549f:7d2b with SMTP id
 d9443c01a7336-2b2d59a52famr167589865ad.11.1776235747410; 
 Tue, 14 Apr 2026 23:49:07 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b478142565sm10353195ad.37.2026.04.14.23.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 23:49:07 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 4/4] hw/riscv/boot: Provide a simple halting payload
Date: Wed, 15 Apr 2026 16:48:36 +1000
Message-ID: <20260415064838.652297-5-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415064838.652297-1-joel@jms.id.au>
References: <20260415064838.652297-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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
v2: Update commit message to clarfiy that Atlantis isn't in the tree yet

 include/hw/riscv/boot.h |  2 ++
 hw/riscv/boot.c         | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index fb90bf12399e..d1d7258a2179 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -78,6 +78,8 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
                                hwaddr rom_base, hwaddr rom_size,
                                uint64_t kernel_entry,
                                uint64_t fdt_load_addr);
+void riscv_setup_halting_payload(MachineState *machine,
+                                 RISCVBootInfo *info, hwaddr addr);
 void riscv_rom_copy_firmware_info(MachineState *machine,
                                   RISCVHartArrayState *harts,
                                   hwaddr rom_base,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 3ea95c175c14..fc8a39a8d913 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -518,6 +518,27 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
                                  kernel_entry);
 }
 
+/* Simple payload so OpenSBI does not hang early with no output */
+void riscv_setup_halting_payload(MachineState *machine,
+                                 RISCVBootInfo *info, hwaddr addr)
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


