Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C058BCCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Qu-00061i-Qy; Tue, 07 Oct 2025 10:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qc-0005q8-DK
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:34 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QM-0002Jx-0O
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:34 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e384dfde0so70063455e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846333; x=1760451133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=64bm6zQUNNcbqTI3Im3LQpuyvcJOm+Jr9r6z2jplxD0=;
 b=z2R8s6E+d6n1/GLW8GgbDYfr0jsIFTOVSEFDXBx2PpK1TqW37v1kzRxqoM8QRNVXWu
 5mGnQSuGpUy74uSOhhcyAVKh8YCNWRkYyAY12Q/MPFf0c8OeAz9jV1XI/34Cxz7MvAnu
 VAFeg6EY7pPcsZs4DT6+fns3lirJvOKEOhQVWfO1o6JUZm6lN12tMLQyJJS9bu33KHxw
 GheIUWIhOfp4lpMhu6neQHB+zRQp/Vus8ioqXTruLc+8NplX2UusV1LbKkJamXWyI8ET
 4f6tB8LEl/dDO2WYiiTQ0crFoH5nmmOht8diiT36sZno0fjW9yOWgDPiZ90TnfuBDTwD
 JdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846333; x=1760451133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=64bm6zQUNNcbqTI3Im3LQpuyvcJOm+Jr9r6z2jplxD0=;
 b=TaiSb9iTirFYWvbXazWXAkQdiedHkX5bT495L8oYNLjgssXuzIJwBDG2yowEfMfV1G
 NnzTXqsAb7I7L6sYiiQwdI+XPyCGAeO/Dk03wg+7qh1K/FIORhTU7QQjk4OuQWNq4XzN
 +4wBnQb7xQhLH2DcvcED17tW8q1M2HZODn+z2jg+JcPmMCudLbQtiPJzZaXppe2KKbKP
 OSsO0xhT2vrYjSnyuENUbjE7L4vnccbZ1rz3MsjVMl7I3uaSU/gPD+2xTDkFoGDr52bI
 A1ZHF8zpN13XwBZqx8iYYW1mgncvESN0uHU+9AvJD2Fa8vZs/jqH3N+whQ+KiXWYFrCs
 Vrng==
X-Gm-Message-State: AOJu0YzEM70dSLWe0VwG2FJc8GZoQFQ/Em27jWTwOxpkPUDdLUh8m+ZE
 x/+7Cmw1G5rYOjnq85BDN7a754yJk9f3dFzxxVdyLUPrPAnnn5UX6rMiiQ60qo2+DJYi/aTcXOI
 uoN3s
X-Gm-Gg: ASbGncu1bYa6q2HgEVJfEsluklVj302b1sEwD81nFUNVQ0xCOlDdf/tumYNSoH8fg2u
 VcOqro5rj14KySCDknEFEaeeyIefOYHjCaZqZWxYcZLMhHEczfPz518PGoAPDYMsLopC5/PQpDZ
 8NuoBpk/8j99alBeLgEry02l+AFJ7A0pG18ywfumWA51BcjZBHqamajE+bUkpTfKuEhE5pesO6r
 Ie3L/p5HQeZR4BK5q1bPbsMV0E/VMj0MtyJBHP+5d/c1rlPPMTDIk3G9D+t3GA/7YcyO50DcwVr
 9dFZuz2mjTQxvtdp5Bwj87qIgSJU9G0ZUEJ9EGoCOHUqm8qkjy/skXMNBqbMX4L/8jdx8fsvPUw
 JPJgLw4tStMmPrhHakTKLMCzK/dKI/WavmIkWffS7XsbfPTEacFmFW3ZN
X-Google-Smtp-Source: AGHT+IGUiwf4odeZjl8tOHx00qJcN0rBlU7n8l0igSk21qsl34TLZb2PC8eWCPWfsGto9IT4uUWOvg==
X-Received: by 2002:a05:600c:64c4:b0:46d:45e:3514 with SMTP id
 5b1f17b1804b1-46e7114310amr132482525e9.17.1759846332576; 
 Tue, 07 Oct 2025 07:12:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/62] hw/arm/xlnx-versal-virt: tidy up
Date: Tue,  7 Oct 2025 15:11:04 +0100
Message-ID: <20251007141123.3239867-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Luc Michel <luc.michel@amd.com>

Remove now unused clock nodes. They have been replaced by the ones
created in the SoC. Remove the unused cfg.secure VersalVirt field.
Remove unecessary include directives.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-44-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-versal-virt.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index f9abb9ed639..14c2d5cc924 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -19,10 +19,8 @@
 #include "hw/boards.h"
 #include "hw/sysbus.h"
 #include "hw/arm/fdt.h"
-#include "hw/qdev-properties.h"
 #include "hw/arm/xlnx-versal.h"
 #include "hw/arm/boot.h"
-#include "target/arm/multiprocessing.h"
 #include "qom/object.h"
 #include "target/arm/cpu.h"
 
@@ -41,16 +39,11 @@ struct VersalVirt {
 
     void *fdt;
     int fdt_size;
-    struct {
-        uint32_t clk_125Mhz;
-        uint32_t clk_25Mhz;
-    } phandle;
     struct arm_boot_info binfo;
 
     CanBusState **canbus;
 
     struct {
-        bool secure;
         char *ospi_model;
     } cfg;
 };
@@ -72,10 +65,6 @@ static void fdt_create(VersalVirt *s)
         exit(1);
     }
 
-    /* Allocate all phandles.  */
-    s->phandle.clk_25Mhz = qemu_fdt_alloc_phandle(s->fdt);
-    s->phandle.clk_125Mhz = qemu_fdt_alloc_phandle(s->fdt);
-
     /* Create /chosen node for load_dtb.  */
     qemu_fdt_add_subnode(s->fdt, "/chosen");
     qemu_fdt_add_subnode(s->fdt, "/aliases");
@@ -86,17 +75,6 @@ static void fdt_create(VersalVirt *s)
                      sizeof(versal_compat));
 }
 
-static void fdt_add_clk_node(VersalVirt *s, const char *name,
-                             unsigned int freq_hz, uint32_t phandle)
-{
-    qemu_fdt_add_subnode(s->fdt, name);
-    qemu_fdt_setprop_cell(s->fdt, name, "phandle", phandle);
-    qemu_fdt_setprop_cell(s->fdt, name, "clock-frequency", freq_hz);
-    qemu_fdt_setprop_cell(s->fdt, name, "#clock-cells", 0x0);
-    qemu_fdt_setprop_string(s->fdt, name, "compatible", "fixed-clock");
-    qemu_fdt_setprop(s->fdt, name, "u-boot,dm-pre-reloc", NULL, 0);
-}
-
 static void fdt_nop_memory_nodes(void *fdt, Error **errp)
 {
     Error *err = NULL;
@@ -268,9 +246,6 @@ static void versal_virt_init(MachineState *machine)
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
     create_virtio_regions(s);
 
-    fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
-    fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
-
     /*
      * Map the SoC address space onto system memory. This will allow virtio and
      * other modules unaware of multiple address-spaces to work.
-- 
2.43.0


