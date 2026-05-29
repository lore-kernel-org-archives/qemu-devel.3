Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD10CD6E55
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 12:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSwfv-0004lv-4S; Fri, 29 May 2026 08:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wSwft-0004lX-OM
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:50:53 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wSwfq-0006E8-Ug
 for qemu-devel@nongnu.org; Fri, 29 May 2026 08:50:53 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-83945063f70so6695108b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 05:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780059049; x=1780663849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oBtA1oFudyVY7Vw5dgqM/2NWOChlQXrgG47s0EI8hXU=;
 b=nNrne3pOxDEnu+yfWVIJN/fxt0G79YgYAZ5D8HkjcWrQDUN+bAy41LUSF7VsEW1yWh
 nlilq1SPgo9V1HAm+kzoNkhsrL1XknhMv7Zdw+S6MisX7o/c9OTj6S7SxPBZ1J2qin5I
 lRo7deUxQbJoaO7zE54dJQRK9VWU96+yUNHS2RhDxbZsLUkZzggnYLM7BYDKZgy+w+t2
 MriwGxL3aRFaC0PT7J9A7xQokkSNLTNGV+oP6cTFsLXvXzqy3BQf7GFTJw6CKo/7vEEH
 bELysypz7zzHtKDTOi6DQnuhcTsRuHQolSSYmaQCf8RzjEi0hgeZ8kWDyo5Gj3xdgGXJ
 pmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780059049; x=1780663849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oBtA1oFudyVY7Vw5dgqM/2NWOChlQXrgG47s0EI8hXU=;
 b=WUOQluqcAjFmK6wfgWLcYd8GeQSqP8bfjPz509kEGvEFiw1uhGurh4WldbN298XIHi
 8B2xny+fzLbAarVh3DDL+GEVuUDD9t41n9DSpWZ7TdFwEFEXuppoCYbYNiZa+ZXsLm4P
 TIOSsPAORI56TP2SUimnYfFzJYFcaniGZlXrUVDK0t2WTXK0l6Lej7kZbhBuw4y4KU06
 fyyipfToYCbgI0DUditpuRf9N7suS5uhhYm73lhGlPNqdCf2S+SFlU+y7V/t5q6Dqiyi
 ba/QTkuE3x2QPX9JNNhMqj1kGPbctuPCeiXA0ZVYfj2iR5yz6HlroFaOWA/D5QHkfwJd
 8WMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+w/XTgF//F5W0ZYzxa4oz4rvow6fo9JI6ZJDV9XErCY1QPx/qdXEBMh0sVPFzJWyn/go+gzYG4LSUX@nongnu.org
X-Gm-Message-State: AOJu0YwKTOJqzNVatDNJmayK+Qq+2g+MAgqnY+EvjqaTi3UfHrk3ugkB
 /2vPH2jIlO/CrcWgjWIq3l075J+qj+JIuYqJDZk+cjIMUB8m96iSWaZQPG3QHg==
X-Gm-Gg: Acq92OEmEE6dIMuk4NiOEnKMxwOsMyH4tXW2Mx70Vjm7WLemEUeeRaJJrIvhKwBqqYQ
 F2bG7z6LPmzHJlwMQo2GhD6o2H0KDAdD133e9YMjyAKKpBEitk3xB/u79Q59onwW2tfJeF5ge94
 GGEod5dT7XY50+N+rg0S1W3tHu/3gZJLRnqdsB/dt7uEb3blaxStAS5TYnhonAXg/l+PLyhEnSs
 Z/THAfzgvoocObobBO+uRAfN4PRWk5u/pwvDNpwiHNPPEwt07r47U5V/qGyFnZeqhFv9C33n9e9
 7UiviNQkERk5GDbpZa7/Syg2Da03ii7/imOZCBDT/kPae1qH6fHWVLf7pvC9Y47HpJwilDugjSA
 48ZuO2YL4l6/Ax25AT9AgSK69RdtxoeG27xtK2GYIgeVLDbK5SY0iS11tUW2xmkKxJLJ6O0JSX5
 KDzqb/MjYFFRkFCP6o5iBoefXl3oXSP6Smf/ju0HsJhGBsJ7adMIBrwtKpRAdh96C0E2c7fT8lE
 3rc/Ep1
X-Received: by 2002:a05:6a00:12c6:b0:7e8:3fcb:9b03 with SMTP id
 d2e1a72fcca58-84210c9e6d8mr2463722b3a.25.1780059049246; 
 Fri, 29 May 2026 05:50:49 -0700 (PDT)
Received: from localhost (124.158.97.178.qld.leaptel.network. [124.158.97.178])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214c92fc6sm1791888b3a.36.2026.05.29.05.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 05:50:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Subject: [PATCH v7 01/10] hw/riscv/boot: Describe discontiguous memory in
 boot_info
Date: Fri, 29 May 2026 05:50:26 -0700
Message-ID: <20260529125036.728206-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529125036.728206-1-npiggin@gmail.com>
References: <20260529125036.728206-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Machines that have discontiguous memory may need to adjust where
firmware and images are loaded at boot. Provide an interface for
machines to describe a discontiguous low/high RAM scheme for this
purpose.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/riscv/boot.c         | 16 ++++++++++++++++
 include/hw/riscv/boot.h |  7 +++++++
 2 files changed, 23 insertions(+)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index ae2f86c7ce..b1a020b58a 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -69,11 +69,27 @@ char *riscv_plic_hart_config_string(int hart_count)
 
 void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts)
 {
+    info->ram_low_start = 0;
+    info->ram_low_size = 0;
     info->kernel_size = 0;
     info->initrd_size = 0;
     info->is_32bit = riscv_is_32bit(harts);
 }
 
+/*
+ * This can be used instead of riscv_boot_info_init() if the machine has
+ * discontiguous physical memory. The low memory range specified will be
+ * used to place firmware images.
+ */
+void riscv_boot_info_init_discontig_mem(RISCVBootInfo *info,
+                                        RISCVHartArrayState *harts,
+                                        hwaddr low_start, hwaddr low_size)
+{
+    riscv_boot_info_init(info, harts);
+    info->ram_low_start = low_start;
+    info->ram_low_size = low_size;
+}
+
 vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
                                    hwaddr firmware_end_addr) {
     if (info->is_32bit) {
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index f00b3ca122..69c99a1496 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -28,6 +28,10 @@
 #define RISCV64_BIOS_BIN    "opensbi-riscv64-generic-fw_dynamic.bin"
 
 typedef struct RISCVBootInfo {
+    /* First contiguous RAM region. If size is zero then assume entire RAM */
+    hwaddr ram_low_start;
+    hwaddr ram_low_size;
+
     ssize_t kernel_size;
     hwaddr image_low_addr;
     hwaddr image_high_addr;
@@ -43,6 +47,9 @@ bool riscv_is_32bit(RISCVHartArrayState *harts);
 char *riscv_plic_hart_config_string(int hart_count);
 
 void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts);
+void riscv_boot_info_init_discontig_mem(RISCVBootInfo *info,
+                                        RISCVHartArrayState *harts,
+                                        hwaddr low_start, hwaddr low_size);
 vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
                                    hwaddr firmware_end_addr);
 hwaddr riscv_find_and_load_firmware(MachineState *machine,
-- 
2.53.0


