Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2156BC3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJX9-0001sd-Nw; Tue, 06 May 2025 10:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVF-0001hu-KM
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:39 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVD-00027x-Er
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:37 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so50015215e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542553; x=1747147353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1/dIcnRF1J/rEa4WYQBcsfZswkyaBEqJJS3LI+QWLNs=;
 b=d19KFUBTQ8eMbal94K0tbP/LW5p1zIR1MLHyD+bL2TCnqmtCNwhOmTJyn+QDezuEbT
 vBlcPkk6To0xjxaVIHFbgHCoIUN9F0DeaQ4p1ID/TH+7N+0r7cy5uUIsmiHF9stl0e6N
 8u8CTd4YbsJdiYxll2p6AOXRFlrdzQ3N4gj9fGVb/FfdORGnEFaIeZuk05c/PRR82NAW
 KejJEjWTjAz9SS2/2lJLWyq4tEnKm6fN3B018GpiHY9rvGyDw7Fp82oHoEaPhlmDC/lI
 dUeCm4pEPcX3u9wTgXQYqUpHHU7aiY74Hbnj7mUwmGNPmDWIr841qrsjuON/YgLQgNsL
 DRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542553; x=1747147353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1/dIcnRF1J/rEa4WYQBcsfZswkyaBEqJJS3LI+QWLNs=;
 b=Fek7tUK924CbrPkcGndoT0aFtMIQ8ZeDeWTfMUJ30MP4Q3tJmMs9EEr06SRd+xfa9o
 Mts5SanCpOfUK9CAfHIwPy7xj4RW4D95hcUiyyvOirROgkrrdsaH/rvZbdTgJIYVVAVP
 mWDj9Zjrqyl5OeXUQmAyezGWHg+1XiJaSx/tkMcEb7XxiFAGzpKwn74aeHmbqWzUg9GI
 JtItB8TYQSLWxzI3Ec6RMP5JyI92D8wPnPoCAApfu5yGvbjZkDF7uxBlvVlMFTRkSPe5
 9kl62cntjIyIWEXQv/sDgZVi8iRYK8Wo4lfCkT6gAhTLR++US9/8oeMCfpDaO33+JWBH
 A8Ew==
X-Gm-Message-State: AOJu0YxqSIbsEIhaQ4ycUvxCPfvhI+2VRVAKoWisWIPDpJqbX3pJiojM
 JV3mdPambtScFWk1s3T1586vTgJFcqnJ9C6FtsCb57+1jZGQ/REWrx4k71A0Gjh7kDNnFfYwBI9
 e
X-Gm-Gg: ASbGncsG0tyhjPPq8l+uGXOH9L9PQBd1UIuPa2XZ6lwXhit2y1CM7I+j0MEW0QxfJCu
 869BNirsZlayL2Fbibjx8ECZVDn2Z29MWh0/OY167CeO6Xu2Uh8aojCw+WWoG6jUfJCpo+jm21Z
 5xEMGHAyOYifw2zxm4j2zKWbptkvHbEikr4VrOyFtIFIhOxPlL2rhO79DJePQr5sgYAjWSRuTO1
 rx8BN0H/UFu+irsVWZhh44exg4pHV0v04IoaRzKO7EW7/VFtEy83rvQl+TS0Q45CQ4f6B1cj7OS
 tJaRgAL+Nfgm2c96U6av7ydDzYmoUU3eWgt4+B7iFjfW/yrv6atQe9FiBg==
X-Google-Smtp-Source: AGHT+IGHteRxz2J/j2dV0eAMEYG43PHeS/5gYFm/n45hEJ9rv55IS9sL1lYYjZMptYZUsNBfA6iduA==
X-Received: by 2002:a05:600d:1c:b0:43c:fda5:41e9 with SMTP id
 5b1f17b1804b1-441c4933d05mr107317655e9.31.1746542553152; 
 Tue, 06 May 2025 07:42:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/32] hw/arm/virt: Remove
 VirtMachineClass::claim_edge_triggered_timers field
Date: Tue,  6 May 2025 15:41:56 +0100
Message-ID: <20250506144214.1221450-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The VirtMachineClass::claim_edge_triggered_timers field
was only used by virt-2.8 machine, which got removed.
Remove it and simplify fdt_add_timer_nodes() and build_gtdt().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h    | 1 -
 hw/arm/virt-acpi-build.c | 5 +----
 hw/arm/virt.c            | 5 -----
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 463ac09615e..9c531e28d04 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -118,7 +118,6 @@ typedef enum VirtGICType {
 struct VirtMachineClass {
     MachineClass parent;
     bool no_tcg_its;
-    bool claim_edge_triggered_timers;
     bool smbios_old_sys_ver;
     bool no_highmem_compact;
     bool no_highmem_ecam;
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 1c8b61f9f8a..7e8e0f0298d 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -537,15 +537,12 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 static void
 build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     /*
      * Table 5-117 Flag Definitions
      * set only "Timer interrupt Mode" and assume "Timer Interrupt
      * polarity" bit as '0: Interrupt is Active high'
      */
-    uint32_t irqflags = vmc->claim_edge_triggered_timers ?
-        1 : /* Interrupt is Edge triggered */
-        0;  /* Interrupt is Level triggered  */
+    const uint32_t irqflags = 0;  /* Interrupt is Level triggered  */
     AcpiTable table = { .sig = "GTDT", .rev = 3, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4ef3f043a21..13cbd2275ef 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -370,14 +370,9 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
      * the correct information.
      */
     ARMCPU *armcpu;
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     uint32_t irqflags = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
     MachineState *ms = MACHINE(vms);
 
-    if (vmc->claim_edge_triggered_timers) {
-        irqflags = GIC_FDT_IRQ_FLAGS_EDGE_LO_HI;
-    }
-
     if (vms->gic_version == VIRT_GIC_VERSION_2) {
         irqflags = deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
                              GIC_FDT_IRQ_PPI_CPU_WIDTH,
-- 
2.43.0


