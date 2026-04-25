Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3CBFF8860
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 13:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGcts-00075H-NW; Sat, 25 Apr 2026 09:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wGctp-00074f-Dn
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:18:22 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wGctn-0008TV-VP
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:18:21 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-83177129e28so1195312b3a.1
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 06:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777123098; x=1777727898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sW0fdPqCEH1I1Gmqkpz2eOq8cT+yEGpRcyXw/JwbtO4=;
 b=IKjnjme/h7RX0D0ujU6/lH/j78aFVlxaAp4ky2jkkEwXP1EM4f1CBDfBc11yr08sJo
 on1VZYA5kZTPH4Fj93nkpQrPaiu5rykKlmySi1bEkhnQLNE9wx1LI0unHQnhA1/U8SV7
 n4laM9ajK4eYZ0W2lW7q94N4CgyZQByBFlL+eSRGzMoB28oCeDPStuaDqP8hp+Rndx0+
 UWCOiqqePtRSmKTfL++QbnlVCsZo5h+o8+4be8W9QvWM3ZbBE3BFyqsOV3sWTviuchJy
 I7vUeexXZND22QzFbMrrKN3f+g4L8hHfnkXianLY0P/iUW1KlyVfEuCrQOFreRHG5klz
 O4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777123098; x=1777727898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sW0fdPqCEH1I1Gmqkpz2eOq8cT+yEGpRcyXw/JwbtO4=;
 b=U8P8PyJQtpYlY48c1SmBz/oUUjqmZtBQZVRIg6zswYrERwW+2EJiGLq0ZEbvRZGGdr
 /7jF+2JubBzol0yo6cCV8qka5gUft4SmQY8JIiui9eMYxthQGCKdKQuMmuFWtFV5H2E3
 BDqkOk/o4AhCAFSIAnhvIr9qCvF/s621AbMrgbz8iodYkpYjiJT3cnABh3691nYc1sL9
 Dibhi+XjQ6gQ39gHlWdmeDTdBcn2BiMHn4vynxvToIPJDvwyLnGY3t0ccBHvMK/7Ihb8
 bK78aHyt9UoqDtpyhBf19BtIrOCUx9I46SbxHpr4NUOncEPB3PkIUblS0iHZtmAVsbG6
 2QAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ83uU+kBeRyNZz7SyvHrIhYSdCEfL3ytwIUJmrw0unYu9P/OCup/J52EaK7kvPjF8rPmIx9M2TCYU0W@nongnu.org
X-Gm-Message-State: AOJu0Yw5l20S5p3qgsXRjw8K/0jUdv77sthYX6tD4bVOl+ZkNQFVvJof
 w4ZvAcHtwkbc8KWzePUl4fR8zx4g9RQsqGAAtDKa3WGTwXAVkmzTYOc+
X-Gm-Gg: AeBDiesrprv7oWSwRGHmbysiMxmRfPV9AEhYMCuhziBHHnEbwYyuXYRpjc7t0n3lNpU
 w36J3c2n29QpG0F+CVVTQyq/s8T0mfeU7HBzh9//E1WdBCf9iX/MAV5iFu5veZajooRzaPlHCZL
 eBt/NfDo7riqoRfpE3stfGSl21UmyOZ0Y5ZEFeMGqNuMq/VPUVhgeWsJ11djvJ4PVHVIgaPCGBB
 0jjPsXvTcukB9EB4rrdCWoma5JPWUohWjV13Fp23mV9w0PcTAxvog7AY+rz5wep+jfnr2fSB/mX
 gTWYKbuBPBmpjY3Re1BTm9HYOk5FAemVuafvPtymlVTOsp/9zHSq7wdDqbT4M9C79lARpsZ9Zjz
 vsEqfxSbkUVSxSlvskN1mmzJ8WVT9sYYcD7Gu5JboR9aBykgdhu2QLn9MSYFMgHGKbaJ37MOPKr
 22my70lKPSbWSlvUUpvrqn4RrT7caHA8npB9MOkg2li8QosOs+FrFBeniScMyR7KBfrfWICONgc
 8Laoe+clBJLhzjJVwW7IWoZqHmm+vL6
X-Received: by 2002:a05:6a00:2d03:b0:82d:6310:2efc with SMTP id
 d2e1a72fcca58-82f8c82d824mr36173369b3a.17.1777123097874; 
 Sat, 25 Apr 2026 06:18:17 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9f7735sm26898866b3a.21.2026.04.25.06.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 06:18:17 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 04/13] hw/riscv/boot: Provide a simple halting payload
Date: Sat, 25 Apr 2026 23:17:10 +1000
Message-ID: <20260425131721.932250-5-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260425131721.932250-1-joel@jms.id.au>
References: <20260425131721.932250-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x433.google.com
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
v4: Make vec instructions const
v3: MachineState argument was unused
---
 include/hw/riscv/boot.h |  1 +
 hw/riscv/boot.c         | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index b2ef64fb1d14..3dfb0e98db4c 100644
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
index 4fbc778263cf..3c2501b3c721 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -518,6 +518,22 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
                                  kernel_entry);
 }
 
+/* Simple payload so OpenSBI does not hang early with no output */
+void riscv_setup_halting_payload(RISCVBootInfo *info, hwaddr addr)
+{
+    /* Store the payload vector in little_endian byte order */
+    static const uint32_t payload_vec[] = {
+        const_le32(0x10500073),         /* 1: wfi           */
+        const_le32(0xffdff06f),         /* j       1b       */
+    };
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


