Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F052EC5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN1J-00015S-2b; Fri, 21 Aug 2026 07:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN13-0000gW-Ii
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:30 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN10-0007Uv-OK
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:29 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-499840a2575so4775865e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310145; x=1787914945; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZW+43f0HNk0MlxWq71xFTJBbmIurAt5Kb0ZGOXTKsqY=;
 b=XHhDhJMAoVxz+ZRkz4nPmy225bSXfQ98qvyP43izXJfDmPd7AyipddGs5MdN3EDOo4
 o9yk+PXv1aUCARjy2te9kBPNwN3asHw7sv+krcqXmtuWQ0Wy4JUytqIfSMzw7HTyaReo
 ZXYgVD3YV+az75e29lwfcw3nFKgRumgOiw2szJFbbF2zyw6U8dnf3uLrtE4TNyOVk/pn
 gck9+anTgWtxxtp/IrkeJ+9zyNq4IBKeJx39HQ9uatrdPL0OeVlkH2DHWuGxWN6jri4r
 Ks5h9Q8xPVjg4YKoDI8uUnF28VSMlQEXL7FZYBUz6r/uBXsaDfEfPcxBwX5DKFZCa8Uh
 s0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310145; x=1787914945;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZW+43f0HNk0MlxWq71xFTJBbmIurAt5Kb0ZGOXTKsqY=;
 b=ApJJeFc2q4JxRH87bRZLA/w3dwc4fRK3ZIYGxNmkB2Vwb6Yo4GdX3ZY7LybBZsLoN9
 tKT9utS9H2VBkglF050tFYQJTptvByGGcKCsBMCuvXYRswlXCxUm0QlP5sHQMPlJPHAM
 8xFVLpdmzd8McYWzFlBmgpa9PFDFV+XD6bz9F1R3fcALpzZKMYxPkfCP5Ca8V2MkPcHH
 8+lYCKIZFH59fLjOHoDWSUgetp4EOZjRjWO81KV48EGUBzfq2zceb00M1WjVmgO05bYG
 q3rLVF8DYeTTS+sr6W++XIpCAyFvy1YhqVXn3UspiVrzsUMO5OsaRLlj/1lZwHYr+w7h
 3H9w==
X-Gm-Message-State: AOJu0Yzzz+MqiwZyZ/TD+lKfWKB9DKuIpe7Hg28IUMJRVfeGTod8/8Wq
 obs6Hy7JhJ3uucoA+al1axsmfc+5seB6vXMkSyh9jJFadkKIqR+vAzKQDdmPFnBUhsIo1Pwacmo
 VP+rL
X-Gm-Gg: AR+sD13vKT+OQClslTVL9Wlwb+WRpU6zt93ekYMDJdwaROjhVXrwDfj+pNYFl581XOL
 qe7PuRBOOMZNfbxvs5O4LknLce2aK/PgkOjU05t1v53T0BFxfCIacXG40fN/9Wg4Q9o4AnAFPco
 +mg/TG1BwlIsypVLtoRBOXTAcmJKRKEv9KReeeerHavTgqzy5KCwS5iAz+U1PxUu6CTNq4iQkUL
 s4jl3plPIbe9b0zg3T/8RU8O/qk4NbPzyoOPmZc6BlWa75PqME5WpdHEjQWEQjCSJPxT2L3XyCL
 1kDhTLKDo+Blz3EfwcHHMaSLqHI9GzRkWIn6wjR29QuePz5bkz2eVmUlolLNR4vTPoZk0gdrYNV
 xHJuq2q1Hb8J+EYHVMXKwsIFkFAILI1bFkKLlJUDibwLq5fQ/kgFwF0YgoOUUi5X3BDPgcUFlHQ
 8DjkxF4V4XLoA64+U9kuNCN95y7hWAgjEM9wlLClPy/HCjePSnanlnPnPTxzpO94sn7aThVJxwo
 xmP8VLjHB1rTXstOTvR1ChDLX5HT+2dEezYs5nspny95knbPGYhKBw8T8sO1zbIDHOL+2+qV4M2
 5wz1
X-Received: by 2002:a05:600c:1548:b0:495:5fdf:2075 with SMTP id
 5b1f17b1804b1-499b8277214mr79175265e9.0.1787310144998; 
 Fri, 21 Aug 2026 04:02:24 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/43] hw/arm: aspeed_ast27x0-fc: Store boot info in the
 machine state
Date: Fri, 21 Aug 2026 12:00:43 +0100
Message-ID: <20260821110101.3971391-26-peter.maydell@linaro.org>
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

Move the boot info into the existing Ast2700FCState.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260816131300.51799-3-bin.meng@processmission.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed_ast27x0-fc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 058cea42edc..ceeae336df1 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -27,10 +27,6 @@
 #define TYPE_AST2700FC MACHINE_TYPE_NAME("ast2700fc")
 OBJECT_DECLARE_SIMPLE_TYPE(Ast2700FCState, AST2700FC);
 
-static struct arm_boot_info ast2700fc_board_info = {
-    .board_id = -1, /* device-tree-only board */
-};
-
 struct Ast2700FCState {
     MachineState parent_obj;
 
@@ -46,6 +42,8 @@ struct Ast2700FCState {
     Aspeed27x0SoCState ca35;
     Aspeed27x0CoprocessorState ssp;
     Aspeed27x0CoprocessorState tsp;
+
+    struct arm_boot_info bootinfo;
 };
 
 #define AST2700FC_BMC_RAM_SIZE (2 * GiB)
@@ -114,8 +112,9 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
     aspeed_board_init_flashes(&soc->fmc, AST2700FC_FMC_MODEL, 2, 0);
     aspeed_board_init_flashes(&soc->spi[0], AST2700FC_SPI_MODEL, 1, 2);
 
-    ast2700fc_board_info.ram_size = machine->ram_size;
-    ast2700fc_board_info.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
+    s->bootinfo.ram_size = machine->ram_size;
+    s->bootinfo.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
+    s->bootinfo.board_id = -1; /* device-tree-only board */
 
     dev = ssi_get_cs(soc->fmc.spi, 0);
     fmc0 = dev ? m25p80_get_blk(dev) : NULL;
@@ -129,7 +128,7 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
     bios_name = machine->firmware ?: VBOOTROM_FILE_NAME;
     aspeed_load_vbootrom(soc, bios_name, errp);
 
-    arm_load_kernel(ARM_CPU(first_cpu), machine, &ast2700fc_board_info);
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &s->bootinfo);
 
     return true;
 }
-- 
2.43.0


