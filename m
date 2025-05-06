Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD09C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJX0-0000sh-V1; Tue, 06 May 2025 10:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVD-0001dR-FM
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:36 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVA-00027N-C3
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:35 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so32630825e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542551; x=1747147351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5E5blIzr/7R8AU6vWnHAs12sKtgyOGDJz11Dz6ogeEY=;
 b=F2dxvdPS5wuRvUvMG2HeHQJ0I4eXkLVfuxKQa9wjHTasc8aCKTOmpaj4R4A3K/Ktgm
 036yRZYhEMIfkn66eZr4D/7UvUOsTsV+kJoOR8n4daQjhSkaM7MppWOBIkL03AhjITUh
 dKTc7iLULEJTjSMWYXY1Lm7JrgdiW4C3u1pjAFjgRvsNjKIJXlXVoGQox5TWvf4CuHyU
 3MUUL2vH5cIQLYMVJ/FlnUpqTdedwPhEcLxPDgGiVW0IAJja31DPZcimvFL4YmamXPpL
 fBdUfSJbh88RF4Xxgxsk3wBKAjnPjYNiytD2hNqjemHhLsFOJe554w6LH1YShr5i9/z5
 W/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542551; x=1747147351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5E5blIzr/7R8AU6vWnHAs12sKtgyOGDJz11Dz6ogeEY=;
 b=OVbn0Jq0WYGAPTxfB/hVA1mfQzz2XtJBi1da/qcKuBSrFJVVe/C7+6Ip8DE/nuyO8R
 RQ7gkBb00NVy7ccZXD1B7OTr8yutuOSo2wL7opvE5gGGHUfDt/3AiroKjWs6G2iZW0D3
 hGmbD6Ymli7iSy7+75fjXV/spmigY6FdEhSHbPWoBW0OcclRItma85A1pn7orP23CTP5
 tfjj9wA2EVrdxEnaug7i8g9sW74dv/ZYNGXUMgPCq0ql/6mgwwgsDm8GhgP5pN1g060m
 XEvIkSz7vW+Csv/1g9ojhA54+3dRXUH8J0NsfgMVoy7obLpubbNrkolrL5jMzbBG8pIp
 nADA==
X-Gm-Message-State: AOJu0YyS/T0bIfWPd+S1zlEXIflbwmhFEsB1coy12dGauZQvYrhUHR57
 mAVLeOhynNSZHHzZvYbYNhqMJH8nH/qJ2Ui7vz/6foPBlgOElcaN7W7mjz7nit+aQ4AOfAWX+bl
 2
X-Gm-Gg: ASbGncvVVREx8Ay2XAxonWLtsogMp/laygFCDq0bU2tOfY/z52UspEe8MQD/faLcpWC
 DYKnpeysnCIe5WTcxLAImwYtvi2mLXv+IXrbfkxzMcPhwuLIjwjLeJwmXRwZDR4bJlkw87UTe5A
 qCCJGFW1TEVKITxf6FJWYnIS5Q3CWBhbOO2MdqqratqzsQcnd4Y7G+Ni2V+jCDq8RXbgKGK4/Es
 RxJxnA0Y3ALjXf81IC4b3A7uueyQpDqa/XPBNaPV0w1I5l1bnSgVY+dnzS2lzjGmS7GWPqVj+9i
 9S3Pg5UmqP08b2fkRFaReOOh1YvWR05XHsCy9nFVMArXhN8=
X-Google-Smtp-Source: AGHT+IGT1SrXFnipOTAO9GfP3Yc7uTbn9m7KydErM7ERWkBKSyUlSMhIWx34luYwXn9kf6g24MaLGw==
X-Received: by 2002:a05:600c:3848:b0:43c:f0ae:da7 with SMTP id
 5b1f17b1804b1-441d0fbd372mr28379845e9.7.1746542550754; 
 Tue, 06 May 2025 07:42:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/32] hw/arm/virt: Remove VirtMachineClass::no_its field
Date: Tue,  6 May 2025 15:41:54 +0100
Message-ID: <20250506144214.1221450-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

The VirtMachineClass::no_its field was only used by
virt-2.7 machine, which got removed. Remove it and
simplify virt_instance_init() and virt_acpi_build().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
index 3ac8f8e1786..1c8b61f9f8a 100644
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
@@ -973,7 +972,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
                           vms->oem_table_id);
     }
 
-    if (its_class_name() && !vmc->no_its) {
+    if (its_class_name()) {
         acpi_add_table(table_offsets, tables_blob);
         build_iort(tables_blob, tables->linker, vms);
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a2a213717cc..9c4efcd8556 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3347,17 +3347,13 @@ static void virt_instance_init(Object *obj)
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
2.43.0


