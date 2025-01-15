Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72587C02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 17:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6uo-0007S3-CS; Wed, 15 Jan 2025 12:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6um-0007RX-2X
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:10:48 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6uk-0006ab-E0
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:10:47 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so48817925e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 09:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736961045; x=1737565845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+rpS4UoGMNFWvPB8UZ1XtPkvHJUg2YKopwCuDHPyLwI=;
 b=P6M+Zvz+hcU9nfpTr6Blmwce3ktOcXbQnX6+VdhCdAyf5zE0GwCPYCaRxJCB2UHuaq
 4KOCR6CLtbag9NjFi0M/8Ss0gVke8Lm27xqEJ75MPmIMPug40UHgzyqK8Un0qr7as4K8
 p63Hj2vIYifURDSDo+nlnp7ewQDsUf65Cee6o1R4z0MdI2RYVoMSx5uOXFQGsbhns3IG
 kPRg8pyVg6eqxOaCCy/rcXAB98lyTEN9QQuxmsYCgJxBz4/FmlfyvmHmFNNKBZPbgHud
 8+EYhdJjC8STjvKKZ4f2x5Z2jN6gi+isILTEQC8M3uiLBgCD1myfonL5tfIJZ4I4eICK
 SqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736961045; x=1737565845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+rpS4UoGMNFWvPB8UZ1XtPkvHJUg2YKopwCuDHPyLwI=;
 b=nDRwhxc2jSngPPHf4/HXSeIoF1L9wOawj3zP/XxthOIZOa78r4NIiOwJmP6MG0Z0D2
 igacmbMXOl8euV0pO4THWw3DB2aaRvYtNeobB+6QbgSaXvyTaOnJdT+QpoBAt9OMaDqw
 rdvx6Kdoadwqiq0BxV19iU93kjvJazMkw+y+uCAH/uPURDBTwgJ8hbVbuFSB4kqheRYp
 PfwBqM/7JNin6CjKAicmV8dr6gCHkXJwWcyYwETw5YZGJ3+pgXBkCo+JU4lKiyqNYFmQ
 kGfeuHJvbb4wuo9Su0LWMkpX9Ui/C7+PdqnU58XbfP45QX+ODo5Ilz63Wnpa2tbEPylr
 2KGw==
X-Gm-Message-State: AOJu0Yzm7etfHHkphwdfW1mJZs55DzJmloEW/vHbDI3NhkQ2sQ7GzXhX
 hXuQxAHb2k1DdI/PH7VzJ99rd/qgL5u9pX5E2bgoUTkteFdfhxTCy7wjcdGhtT9JJGkixx7zhJz
 IAY4=
X-Gm-Gg: ASbGncua5SW6ouRRm6y2dleB1gbmgBjA6mOU2kk4D0wY7FFrlsqvcqdQePVvzh5YNOj
 R/PfFmG0aRIytQ5CXCazQheS3yi5xfiKPrtRFTJkW4AS0HUtNRY28oqJZ7zgBInDy3SpDz8pbPw
 EHbcuJ42VMA6AgaBF7wSikp2vB9IUPY76ra2qa2W2I9ogBUyPJGjeoh1n7hHdZ1CdZm4m4ztICk
 nKr75+R/BUD2M5l1f5lm0qiV6q9L7UgDNeP+3LOtCJroLXfmdLsvLp0kh0Cn1nHDPL8XcMDPzDW
 VsOxohMwxTihqRDFN+FaODsZvWnmxNm+ykFJ
X-Google-Smtp-Source: AGHT+IGwIMmh5nVSPuxckx/5uYr/mS/yXYwsEBpL4JrB/ufEyTJQypWVkjFP/rKPOL87TxcbnDBPyA==
X-Received: by 2002:a05:600c:4f4e:b0:434:a902:97cd with SMTP id
 5b1f17b1804b1-436e26935cbmr265279745e9.12.1736961044600; 
 Wed, 15 Jan 2025 09:10:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37e36asm17745917f8f.5.2025.01.15.09.10.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 09:10:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>, qemu-arm@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/13] hw/arm/virt: Remove
 VirtMachineClass::claim_edge_triggered_timers field
Date: Wed, 15 Jan 2025 18:10:03 +0100
Message-ID: <20250115171009.19302-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115171009.19302-1-philmd@linaro.org>
References: <20250115171009.19302-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The VirtMachineClass::claim_edge_triggered_timers field
was only used by virt-2.8 machine, which got removed.
Remove it and simplify fdt_add_timer_nodes() and build_gtdt().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index ccecea9e09b..6e04fea165a 100644
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
index 4ec94190769..ec47ee4755a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -361,14 +361,9 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
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
2.47.1


