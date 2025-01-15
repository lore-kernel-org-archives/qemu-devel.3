Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEE1C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 17:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6ue-0007OU-B4; Wed, 15 Jan 2025 12:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6uc-0007O7-Dj
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:10:38 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6ua-0006Yk-Cl
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:10:38 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436341f575fso74225935e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 09:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736961034; x=1737565834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZpQYY+dgdMviIpUml6KdhqzTGvxqX3W0VvYn2a5rV6U=;
 b=Ifu41O6QZhcpadZ39CgiSDcztnvchIZG5CgFd81aDO5YIc8SzlF7AzbRws8PZ11te5
 X6PuDdfnm9UTncq9JRsmUQFTXmTjmNgRTNgxf0zcMPb7cUfIFU272ZIi1hFXfWOMbNoR
 1ggCetkCMVuv83y/5ilkaO4wWf626Dlmh7CaTHCxLFKjDnUjU1n9wNEY9jgvHMAlycDu
 i77WdYKNY1gkss1Y3B5MtBkyG7pR1TnUnrXJmDWqcv7B94mEyG0GNfPYb/sAR11jdzWT
 ywtYbxhq6PTqMJWRfmhL8kKoSvWiRGfsU2oFyHoLUMfWoXshwGMsa/0DzUmhXhapa2cK
 Skqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736961034; x=1737565834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZpQYY+dgdMviIpUml6KdhqzTGvxqX3W0VvYn2a5rV6U=;
 b=NjRwu2mSuWRMvW+YLzd7SP2sVwj0eEVa3YOYgMkIDHMoANYXyQDjH3s0FTo3NgrH9x
 W+JCBA2j05WVsYtpQOO2zw4rWnx4JCtanMgbTly707P9WdsJeiMhqsECSmlUx55MDgwR
 Agz52JwuBBlxKxs3cUg1eHPrV0+LEIQ+1Tk6KH2UjbXEIPSiiS8rtyAUD2WjGbzwN3WE
 5gd3ot5qrvILq51OGuvZe6VfPuOoAGak1QWaxhz56dqw58wT8X7gvMxs/wj/bDbKNIy3
 io2uMgpfmBx7T9pQ7LF29NvugyH4qlzWr6ZllzMqRMg0s7DLdI04Pom5vvhExML1YBay
 UJwQ==
X-Gm-Message-State: AOJu0YwEtD9PC8iKpeX3BDYXWdKX1Dtj+h/z7FQ9iAj5dkos09KV9Wnf
 AN0lf1XtrH6Sd/vJtW0KWR9sbx8JrWrTEGGzzCAdZa3/34iKGF3fCU0MBDoSYBo4yaqLOyfra/c
 x+QQ=
X-Gm-Gg: ASbGncupoUbCLS9OGoEyg8655GH0yaXB0NygEXKOeo/8JrGNDk5UnH3ln3zLIMTM4tf
 lqunk4b8m/tIBbYYm9fy65WjP1wijgAZlULnvxSvrRz4nmSlWBnFO9/omZpAi4emrlKSK1/It5j
 YkjGyUE4SOVSKAt16+nWQsZUihU/lYk6MSJuEiHfrdNV4A3BnWB9CQLbkzNylXUbdnypN5zirYD
 Y8AIwYPAzVCydzggrVMUZj5QZnBX4syKLCCTvkpRbPU7YtdRMF+PPBrGDbUj90+XsKdYmy4+rTG
 CurghKspXMPF6CE0XVIpMfzzQWet7Hgy/Mgq
X-Google-Smtp-Source: AGHT+IHpWPvqjQwMeUSXZ98zby5MmvBkVROMrpWWhbVVWcttenbsUtuQjxj4Nd6K0F5i5WHPwBtMdg==
X-Received: by 2002:a05:600c:a09:b0:434:f753:6012 with SMTP id
 5b1f17b1804b1-436e26aa593mr307632195e9.17.1736961034507; 
 Wed, 15 Jan 2025 09:10:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74f9ccasm29516495e9.39.2025.01.15.09.10.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 09:10:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>, qemu-arm@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/13] hw/arm/virt: Remove VirtMachineClass::no_its field
Date: Wed, 15 Jan 2025 18:10:01 +0100
Message-ID: <20250115171009.19302-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115171009.19302-1-philmd@linaro.org>
References: <20250115171009.19302-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

The VirtMachineClass::no_its field was only used by
virt-2.7 machine, which got removed. Remove it and
simplify virt_instance_init() and virt_acpi_build().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/virt.h    |  1 -
 hw/arm/virt-acpi-build.c |  5 ++---
 hw/arm/virt.c            | 16 ++++++----------
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 5d3b25509ff..463ac09615e 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -117,7 +117,6 @@ typedef enum VirtGICType {
 
 struct VirtMachineClass {
     MachineClass parent;
-    bool no_its;
     bool no_tcg_its;
     bool claim_edge_triggered_timers;
     bool smbios_old_sys_ver;
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c9b13057a34..ccecea9e09b 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -670,7 +670,6 @@ static void
 build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     int i;
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     const MemMapEntry *memmap = vms->memmap;
     AcpiTable table = { .sig = "APIC", .rev = 4, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
@@ -741,7 +740,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                                           memmap[VIRT_HIGH_GIC_REDIST2].size);
         }
 
-        if (its_class_name() && !vmc->no_its) {
+        if (its_class_name()) {
             /*
              * ACPI spec, Revision 6.0 Errata A
              * (original 6.0 definition has invalid Length)
@@ -974,7 +973,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
                           vms->oem_table_id);
     }
 
-    if (its_class_name() && !vmc->no_its) {
+    if (its_class_name()) {
         acpi_add_table(table_offsets, tables_blob);
         build_iort(tables_blob, tables->linker, vms);
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7747dae4dc7..d7a7cee79df 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3278,17 +3278,13 @@ static void virt_instance_init(Object *obj)
     vms->highmem_mmio = true;
     vms->highmem_redists = true;
 
-    if (vmc->no_its) {
-        vms->its = false;
-    } else {
-        /* Default allows ITS instantiation */
-        vms->its = true;
+    /* Default allows ITS instantiation */
+    vms->its = true;
 
-        if (vmc->no_tcg_its) {
-            vms->tcg_its = false;
-        } else {
-            vms->tcg_its = true;
-        }
+    if (vmc->no_tcg_its) {
+        vms->tcg_its = false;
+    } else {
+        vms->tcg_its = true;
     }
 
     /* Default disallows iommu instantiation */
-- 
2.47.1


