Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D472CD343B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 04:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKqWc-0000PU-PK; Thu, 07 May 2026 00:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKqWb-0000PF-P8
 for qemu-devel@nongnu.org; Thu, 07 May 2026 00:39:49 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKqWa-0003rW-6J
 for qemu-devel@nongnu.org; Thu, 07 May 2026 00:39:49 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b9705613ddso2584665ad.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 21:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778128787; x=1778733587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r58xAilyz0m62aKrNY5JMXEmTJub2NBNqjXn8vtcN8c=;
 b=BGJ929fXmNw4hZdWQIHQRDsGuW1nJRVFJYA3TXJtOdafEdsqcolVUl1T05YTPepH28
 E0d7bhRquiH1DLUcmz+IcnLa7uyUxIzsHyodNgpkPgJneTNMnSk8ciWgnRJwIRfltkvc
 AwMAy4cCWqQDMBUixeR0ZLHGTTbRPMXlPqnIhU2b373t3M8SUJWpfxSP41EnXMvd5pi9
 7NdXMk3YMdOLV60zS5jGfgbu0UgvB9Joxc/NqSC0Tc/rF1JZRPR2/qxlsgR5e9lI0yV8
 oWhCPKj+GrmLNZjRoIcjR8UgFGwn9Ezel+Gstm9+3ehcpsMtNZ6VrfCslW2z8Nuop4gV
 9udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778128787; x=1778733587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r58xAilyz0m62aKrNY5JMXEmTJub2NBNqjXn8vtcN8c=;
 b=LajadLJfgC80Ipa12WF7zN4ubUulUUoLmW1dIVqm539ai2IfD8LGlZjHh416PliG5i
 iecJGDWfjTPmEbrkZarEmZT+c+aZGjUIIgScNsjsCUWUoyPqy8IWMsV+U3SRYPQQ6Z0w
 TVcTGidYiNLTgDrIxKevoXsTIVyEWTFm/BdK3qSa8AB0119MSyzAsvwzuupQqTFHbSA6
 X4zL/j0xhXrD38LH6cx+B1NOEMnb+im1GoDIENdMUm40RGy3oKgjspbVojzEKzG+RRwe
 xU1JpVAqzW/jjwixUtxtq1E4h/VzyEicm8t0eUz9KdJJFIC+F2dRm6izsT/lrokAw2eL
 kIyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MP41DT5m3q04HlUza1A+VOONmW8ZdKPOchGe15u52bX2bS2vpNg27x6A3DCJbougqUI4IshyCh5VF@nongnu.org
X-Gm-Message-State: AOJu0YyCim8T+kQleh7ymjCtN6jeNYsYOvVZDQBqGanuWc3b4UHblE4Y
 +peYggOj83Wj9Q6QE9CQQBCsR1ki94nev3p3xiS2H+sEA+sVrG7kyUkl
X-Gm-Gg: AeBDievev5oLacuqhui44v7yLbB5c8VscQHsDPWMlGkcTQ5552CNSiBIRF6b/ozsz2C
 y6gsGNFcJklz2R6PSr0BlemR6j36c/Bw11RWBOLDuSV3fIgkYRRHxdr3ysEhkBB4+Mik28sos8Y
 cl8wvFZ3ILfCWrIQOcNOfcvJK8pe2sjF//7jqSSD5Z6xnnR3FEd/L+T0aBISqJT5P8TfkXGv7gl
 PSx1NRdiY/Vk6lSilDbeIwyfYS5NNjt2/v3p0m3vGqqWBUaIiwXpjx4NuaU+DWEazd8kjslCheZ
 8HeY4Qn4fpapRFmNk1e++naqQ+ek5qRZhNe1jzWI3GBwTHQUA8TyiXsMvFLnVgSKM/OXvyiyLWg
 xhnSataeEjFhp/SSDyHaESK7JYNWp/fC45VeVR+lb2ZtC/KI7qptqS9FLqlMtH4C5jcI/8s0oMq
 UzpRhnJmrTlfjK1mz290olnYhRacBQxKdTolMD6zULHUwsJNEUOXrq5fCU472i9g/Mhhk3FG3JO
 yE1Ucj7
X-Received: by 2002:a17:903:f8b:b0:2aa:d5e5:b136 with SMTP id
 d9443c01a7336-2ba79f192e0mr72101335ad.38.1778128786737; 
 Wed, 06 May 2026 21:39:46 -0700 (PDT)
Received: from localhost (124.158.97.178.qld.leaptel.network. [124.158.97.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2babaaf38d2sm8899235ad.32.2026.05.06.21.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 21:39:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Subject: [PATCH v5 1/9] hw/riscv/boot: Describe discontiguous memory in
 boot_info
Date: Thu,  7 May 2026 14:38:29 +1000
Message-ID: <20260507043838.45652-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507043838.45652-1-npiggin@gmail.com>
References: <20260507043838.45652-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 roms/seabios-hppa       |  2 +-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 9086793b7a..6e0c6c2d17 100644
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
diff --git a/roms/seabios-hppa b/roms/seabios-hppa
index d9560852a3..1a8ada1fb7 160000
--- a/roms/seabios-hppa
+++ b/roms/seabios-hppa
@@ -1 +1 @@
-Subproject commit d9560852a34f156155b3777745baa0d96d553f22
+Subproject commit 1a8ada1fb70643172e251aacbac673c9ecda99e9
-- 
2.53.0


