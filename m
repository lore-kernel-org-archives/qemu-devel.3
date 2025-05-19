Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3541BC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGrn7-0004pU-1u; Mon, 19 May 2025 00:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmz-0004oB-PA
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:45 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmx-0004AC-UJ
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:45 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-231ecd4f2a5so18038845ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627662; x=1748232462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UDrVd2WWk3SFniHGi6MKc7UY2YxFUpUMKaQa30I15no=;
 b=OzIXxDa8ToopIjpGBleByGArkhHZOhUmTpkHXtRlUg8LVddQ7zEd5MP4i4mn2AqJmj
 mHE/Z6/d5sanlYTv8TVYVaU1+WApWU0cvm4++6fgpn+ANB06+MhlMa66iZ5HEt2BcFnY
 SAI3qVfI1dbmFwLqG08VRkimMsNMMVe6w7jEHB9QPTJoZcM8dBmFSDn45rq5aA43oNRn
 /LlhhfaV5KRIKbZXxAppRPcCM2kKI4K0sIcuFMnsvBKZXAhfracstMN7omAkmOcV8H/c
 ap8P5tm7VEpfxTpxAX4k2QBxrXyI8lWnyfwuCeKpqxTfjnp+ZHXbRlspB3/eHiepFXh7
 yibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627662; x=1748232462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UDrVd2WWk3SFniHGi6MKc7UY2YxFUpUMKaQa30I15no=;
 b=DTe671Ti1tvySbMruk25MYZazb2TCGigfKicV58QkErMr+dsDEPvPKVCVpfb9n2hLE
 FxJPwC1M0AX/37Z34Acqm7nYQMIu1o1y0rN9H9+avZ2kHspCUPnTRC4XuDvkvrDEF5cg
 DqaXxSkAooCJx3ya3me+6epmv33+O5JuOgra+FeC+copK7kJhiO85IjGKMQEaPDrCgsi
 09hLbPCS9z96nULOfG3JZpYatb8DRoY8jctuj6jFG0Z7PegV8cUdRCb4bClErGGbkVeO
 hswEDs07DgYa2H4O9QzcpnJ6CEPFwxkV/W5PEzd9Iceva1B0QPsiTxQBhtNtz5WoodTc
 y/hA==
X-Gm-Message-State: AOJu0YyvTnf17FPCUx6+WG+oKwex1RtK2I3/1r+SLn9DX80FNQoY5d17
 dwtUWvuUlf1j7pNQV8y91eHrJR9rJ7WOMcAYy60OtiIV6dDWkmb2eV3HbINzCg==
X-Gm-Gg: ASbGncsd5kPi2V5EzNDGSQmXNAc4A4xsYEfClPpwRhRNHEt1f44bxX5G7f3bzvub+Yt
 T9pNMvqooYagxcL1JUrhF2HLzSauVsYeA/ifJZHF2S89rUpwjM3lNISnzm/hARIgZDx204z1L6R
 dT77MnRSIqG404s9mWpfmkzuAchdeQL+Qe1S8SpLUlWnnj5GUz0JlSDed08sdlTRHqFfhOsPNca
 TcJZWBtGeSjCu0NCQjUBNUrqbu0G+3HZDqLQLSzmXLwRLaAWQjY8Vjs9EahEF6dV+8ADx7XeAVP
 QODNK3M0fiAzsyswpo+hCfiazLwD2XasjKQXQF5WCu056CJF/LNmC2439/YTb/wI6/AAA0ZmMPA
 ob1sZ6OW11RcpbsKqticoHOT5VJHG/MMErDtzzKUphJ8v7CsBR7MKIGhZ0sVx1/Tpy5E=
X-Google-Smtp-Source: AGHT+IHGITJ0J1IN/fkmrM19qaKa3J7XF80hd0ThEEI1NKGUujhvlpIjTl2GQnH+QjAdJ7Nuraausw==
X-Received: by 2002:a17:903:1246:b0:224:26f2:97d6 with SMTP id
 d9443c01a7336-231de3427cfmr167984355ad.28.1747627662087; 
 Sun, 18 May 2025 21:07:42 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:07:41 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 12/56] hw/riscv: Allow direct start of kernel for MPFS
Date: Mon, 19 May 2025 14:05:09 +1000
Message-ID: <20250519040555.3797167-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
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

From: Sebastian Huber <sebastian.huber@embedded-brains.de>

Further customize the -bios and -kernel options behaviour for the
microchip-icicle-kit machine.  If "-bios none -kernel filename" is
specified, then do not load a firmware and instead only load and start
the kernel image.

For test runs, use an approach similar to
riscv_find_and_load_firmware().

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250319061342.26435-5-sebastian.huber@embedded-brains.de>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/microchip_pfsoc.c | 59 +++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index b8a8d5251d..6e5b17c05f 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -578,29 +578,47 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     }
 
     /*
-     * We follow the following table to select which payload we execute.
+     * We follow the following table to select which firmware we use.
      *
-     *  -bios |    -kernel | payload
-     * -------+------------+--------
-     *      N |          N | HSS
-     *      Y | don't care | HSS
-     *      N |          Y | kernel
-     *
-     * This ensures backwards compatibility with how we used to expose -bios
-     * to users but allows them to run through direct kernel booting as well.
+     * -bios         | -kernel    | firmware
+     * --------------+------------+--------
+     * none          |          N | error
+     * none          |          Y | kernel
+     * NULL, default |          N | BIOS_FILENAME
+     * NULL, default |          Y | RISCV64_BIOS_BIN
+     * other         | don't care | other
      */
+    if (machine->firmware && !strcmp(machine->firmware, "none")) {
+        if (!machine->kernel_filename) {
+            error_report("for -bios none, a kernel is required");
+            exit(1);
+        }
 
-    if (machine->kernel_filename) {
-        firmware_name = RISCV64_BIOS_BIN;
-        firmware_load_addr = memmap[MICROCHIP_PFSOC_DRAM_LO].base;
+        firmware_name = NULL;
+        firmware_load_addr = RESET_VECTOR;
+    } else if (!machine->firmware || !strcmp(machine->firmware, "default")) {
+        if (machine->kernel_filename) {
+            firmware_name = RISCV64_BIOS_BIN;
+            firmware_load_addr = memmap[MICROCHIP_PFSOC_DRAM_LO].base;
+        } else {
+            firmware_name = BIOS_FILENAME;
+            firmware_load_addr = RESET_VECTOR;
+        }
     } else {
-        firmware_name = BIOS_FILENAME;
+        firmware_name = machine->firmware;
         firmware_load_addr = RESET_VECTOR;
     }
 
-    /* Load the firmware */
-    firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
-                                                     &firmware_load_addr, NULL);
+    /* Load the firmware if necessary */
+    firmware_end_addr = firmware_load_addr;
+    if (firmware_name) {
+        char *filename = riscv_find_firmware(firmware_name, NULL);
+        if (filename) {
+            firmware_end_addr = riscv_load_firmware(filename,
+                                                    &firmware_load_addr, NULL);
+            g_free(filename);
+        }
+    }
 
     riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
     if (machine->kernel_filename) {
@@ -638,8 +656,15 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
             fdt_load_addr = 0;
         }
 
+        hwaddr start_addr;
+        if (firmware_name) {
+            start_addr = firmware_load_addr;
+        } else {
+            start_addr = kernel_entry;
+        }
+
         /* Load the reset vector */
-        riscv_setup_rom_reset_vec(machine, &s->soc.u_cpus, firmware_load_addr,
+        riscv_setup_rom_reset_vec(machine, &s->soc.u_cpus, start_addr,
                                   memmap[MICROCHIP_PFSOC_ENVM_DATA].base,
                                   memmap[MICROCHIP_PFSOC_ENVM_DATA].size,
                                   kernel_entry, fdt_load_addr);
-- 
2.49.0


