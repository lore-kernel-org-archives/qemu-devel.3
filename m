Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F330C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN1K-0001Dt-4F; Fri, 21 Aug 2026 07:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN13-0000gV-E3
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:30 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN10-0007Uk-9Y
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:29 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so6732675e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310143; x=1787914943; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ARw3ZyR/JgfXTp+Bm1WywFCxNQGxhq9QIXpcrCCkoXY=;
 b=EARi5FcCn1wU7n9G0hpgReCxR/WdScDt3Op2UjQovSyvFMX3DWqNmguN64JkamKXJA
 98yEl3gCX+2E47yXOUromnCNp448LsCFMgfB2R11hK1+b+IFbGBHSmnJwj84vqvTcWHR
 /Y6pgAt6rCYTE4oTghI/43QQnByjfeOdF1d7vgDsGokNvJvWzpUcOKJOP93AQ9AJEaTG
 TRQYjpm/Fu75gZK7VClW8eQQv3o7pEdVFfqXmySLYw6aCkcUOZcLlLaPcipWitFz+DIO
 p92Sgx9938EaB8bXMvvsvktOzRlqX02QLo2mHyEdmN1rnneJ00tjmrC9YJytp5lmnZQp
 3ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310143; x=1787914943;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ARw3ZyR/JgfXTp+Bm1WywFCxNQGxhq9QIXpcrCCkoXY=;
 b=kmyBICZzW8f9LSNMUawwnw8phbC4dBHGHVrCPh2h9MTmAmX6I8HXn9SQ9qXbMVDBU2
 aaNOr0HkBAiltRus+ebcGJ5IDsNQAEwpQ8UK3bwyaHgX/xTZSLCDzYWggTCR7mpW1HKW
 1eTwByg+O8tXV48uISckXzskMOGkYYWpApSryk7b7NtcUpc8w8Gnx90Y53a+E2LG2fB/
 wZJ+AaRt3P1lIIQF7fK/g6M1ezCfxq7oEHiBvbR4P2weHiAFOtjaT8EMAR3aK0ETpeCf
 vXQxPsrATBJRpa+7WYaXv3nuLgbHMuziS3dgTZrG4vl4ZwaJZWycfbr2QKIYzEeI/qB2
 MB2A==
X-Gm-Message-State: AOJu0Yw6okN6a8FJHzR7/jivcMjGnk8FJFcJJCP3Gvrw6s0qw8pMsdSA
 RF8qWrNI3UU0FkxspyKSvQ30lXrrMKcZSf4KczfXIPrTHIr/S4rK3p85hewmdRHDCSBh+L/WQid
 FfrY8
X-Gm-Gg: AR+sD10xEBefYJ+up87DG9QGjVL81djBCA14SdIlWtXmTIpp9zL65h5hnAVUNt+TbB6
 T1UmS7dCXCK6uTvefwUT9rg65G/R6tvkXPXfcLCljDhdHHNJj8C/s2sDgtpNHXBKr0pQMPc1ale
 M68LKdfUND7BX7KzOvqfCjD22j1ubnRW8ZwG4iRa4qyMgo6U3ZPiYM/PQ0bR+yrYwFkELE4v0fA
 n+PeBlUr2+ScnZYlVUcdpTKTOaHklQtcNJLqnQKUvWuCcRm7cbCcGxE88lw1A1pSns9lykJlmvU
 h5gNQLLrRUwhpeIDQRCD1z6qrfWTqgvFMgZnXF7sHHxEzLhTienKvILT/0zUok7S/mbApD8Lc+T
 cES7kvGC/GBAuLymdBL67EW70RjJxUeTbP09Nrtou4vlJmfA2Zbrhdb/s/S5iqG9AtGC0qfBUTv
 agRfOlp4Vt2NqHGZlQySilmfF2a90QmKcpK1LyVez0wtk5lPUSxDG2UsX8rbH/mjP16j8ItBmc5
 3N0Z3Gk1MoXqVX+7tyg3LrIJSOCjum6jJml3Mjoj/cKwXBRMMUOqWgQdPNI1DM6TsM1RA==
X-Received: by 2002:a05:600c:a088:b0:499:7a19:408b with SMTP id
 5b1f17b1804b1-499b83572bbmr84128515e9.11.1787310143364; 
 Fri, 21 Aug 2026 04:02:23 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/43] hw/arm: aspeed: Store boot info in the machine state
Date: Fri, 21 Aug 2026 12:00:42 +0100
Message-ID: <20260821110101.3971391-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Bin Meng <bin.meng@processmission.com>

arm_load_kernel() keeps a pointer to the boot info struct for the
lifetime of the VM, so the struct logically belongs to the machine
rather than to a file scoped static object.

Move the boot info into the existing AspeedMachineState.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260816131300.51799-2-bin.meng@processmission.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c         | 17 +++++++----------
 include/hw/arm/aspeed.h |  2 ++
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a9238e6217d..8fa16b3831c 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -24,10 +24,6 @@
 #include "hw/core/qdev-clock.h"
 #include "system/system.h"
 
-static struct arm_boot_info aspeed_board_binfo = {
-    .board_id = -1, /* device-tree-only board */
-};
-
 #define AST_SMP_MAILBOX_BASE            0x1e6e2180
 #define AST_SMP_MBOX_FIELD_ENTRY        (AST_SMP_MAILBOX_BASE + 0x0)
 #define AST_SMP_MBOX_FIELD_GOSIGN       (AST_SMP_MAILBOX_BASE + 0x4)
@@ -206,13 +202,14 @@ static void aspeed_machine_init(MachineState *machine)
         memory_region_add_subregion(get_system_memory(),
                                     AST_SMP_MAILBOX_BASE, smpboot);
 
-        aspeed_board_binfo.write_secondary_boot = aspeed_write_smpboot;
-        aspeed_board_binfo.secondary_cpu_reset_hook = aspeed_reset_secondary;
-        aspeed_board_binfo.smp_loader_start = AST_SMP_MBOX_CODE;
+        bmc->bootinfo.write_secondary_boot = aspeed_write_smpboot;
+        bmc->bootinfo.secondary_cpu_reset_hook = aspeed_reset_secondary;
+        bmc->bootinfo.smp_loader_start = AST_SMP_MBOX_CODE;
     }
 
-    aspeed_board_binfo.ram_size = machine->ram_size;
-    aspeed_board_binfo.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
+    bmc->bootinfo.board_id = -1; /* device-tree-only board */
+    bmc->bootinfo.ram_size = machine->ram_size;
+    bmc->bootinfo.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
 
     if (amc->i2c_init) {
         amc->i2c_init(bmc);
@@ -248,7 +245,7 @@ static void aspeed_machine_init(MachineState *machine)
         aspeed_load_vbootrom(bmc->soc, bios_name, &error_abort);
     }
 
-    arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &bmc->bootinfo);
 }
 
 void aspeed_create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index a00238ed74a..54f0d7643d7 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -12,6 +12,7 @@
 #include "hw/core/boards.h"
 #include "qom/object.h"
 #include "hw/arm/aspeed_soc.h"
+#include "hw/arm/boot.h"
 
 typedef struct AspeedMachineState AspeedMachineState;
 
@@ -42,6 +43,7 @@ struct AspeedMachineState {
     char *fmc_model;
     char *spi_model;
     uint32_t hw_strap1;
+    struct arm_boot_info bootinfo;
 };
 
 struct AspeedMachineClass {
-- 
2.43.0


