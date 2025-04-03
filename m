Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29834C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0MMX-0000NG-KA; Thu, 03 Apr 2025 11:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MLv-0007oZ-Gd
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:19:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MLt-0000Z5-MZ
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:19:35 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so8666465e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743693572; x=1744298372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oEde1hNJ4ybKOdNMShnxkmNSbB2tItcMj9l8T50o98M=;
 b=bVVFFccNz+Em/4r8Sn/+/Bs6AqQ/ImF4ubhavyvpTBLuU52bbrG11HJXYsKGKkhdBO
 2f0Yi2sZssh0mLmqrJpN1w/PLIGfASKHO1rlkXjz5+3JzurHFzR/IzZVavsm6oOWSmOv
 IGKX9y1gUlJThKB6eWxC1S41RomaKvalwI+g9EDSDO7s6+TWvr5LDbua1oXAQdIxO/3H
 cmYQMjl8n2GGXCW5c6aguoxo1VugtoV1KhbHJJHEJdyuSesloEuEgxiNeTTs/vcVRpoT
 a0KEW3B6DTGiWSznCvJTnhPE7JeuN7akRFAsOteBUgvFkUQRV2+EbMLvg0VaVVytH3bx
 1GfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743693572; x=1744298372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oEde1hNJ4ybKOdNMShnxkmNSbB2tItcMj9l8T50o98M=;
 b=NWt3YoxzBOrsTaK4KTcrQ4aZHmRGN3j/uE+yAlQLEUBTnFHd9jXhePuiNiXqjeSwvx
 0McKIVC50yjlWc2RzcXPhqkv6peqME3/+kSVMeIBaxtaU6iEfz4XSdovPQul/adACmRw
 JLk+UDzYamYzgY0Hy+fTjLzt+DKZQzGv11VwyfvS3pk4z5XTzEXDLs9rY+5zaURhtZO7
 kBceERTtLKcGp5ytCyxMzxb6Wifio5FjGRd9vn5Fn5mPVZzYwYynqqaSenwuj3zzKMiE
 AyPT/BIINj7/1lkTxYzcfIF/cdnKyGcNj16OtqlBTvzCH0W1u2qcO/dPWT2hCMjtNAek
 K+4Q==
X-Gm-Message-State: AOJu0Yxu5+GlV6kjG7YCa7awxzqGJJvUnKXn7XFxT8KQIw+GITVPFKMU
 Da7f+mQn9ZxAWvqT1erC4lYH5WLWFxx+VGYAJTTY2FyYxEzjWH4h6biN7RtgAOHJ/RaKKXSwkzm
 3
X-Gm-Gg: ASbGncs3GsK4Yr3JSSj1dL+lMAJv7a+2U3Ce8Qn51ROK7CFO8qTMcTnCGaDG8WGul8x
 ga22BNg6TNLXcaqCA3e6DUlNsVPb8DtTnDSRuoVRZcuF8FnFoIn1KlUcu5q/dEWCDqg2fkYHt3f
 RNkV+qZisFCGXPNnpIJZbx5NnV+6bSvp7+y1fRwhA/UKwdua+qqgySl8q3RH/Y/jv5JjMTxx3IG
 pDKmMmyx8oofsdFDbtDKVgfZLTcDRB5iP96wHsaLOVWiVyxo0/NAI3wNa5O3nEgiLQFnAVL6hZi
 5tcNfPx4crPKDM2aCyFOAiYI/ArmwX0gi8JmHxr6/wrVp8sIlqDOBBSYT7P5ym6It80jV19vnbb
 u5enwO/5JYsonrBZ7ank=
X-Google-Smtp-Source: AGHT+IGHak1E3ibrDVZ9cscoOWpyVwW1ZMFS7IyXWRHqtfLC3ggjOh+OvJZg5UyqHqPgNcMeL0Xf/A==
X-Received: by 2002:a5d:6dad:0:b0:38d:e304:7470 with SMTP id
 ffacd0b85a97d-39c297675dbmr5712414f8f.25.1743693571608; 
 Thu, 03 Apr 2025 08:19:31 -0700 (PDT)
Received: from localhost.localdomain (145.171.88.92.rev.sfr.net.
 [92.88.171.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30227e3bsm2042053f8f.100.2025.04.03.08.19.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 08:19:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Udo Steinberg <udo@hypervisor.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH-for-10.0? v2 09/14] hw/arm/virt-acpi: Factor its_enabled()
 helper out
Date: Thu,  3 Apr 2025 17:18:24 +0200
Message-ID: <20250403151829.44858-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403151829.44858-1-philmd@linaro.org>
References: <20250403151829.44858-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

GIC ITS is checked for the MADT and IORT tables.
Factor the checks out to the its_enabled() helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/arm/virt-acpi-build.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9b7fc99f170..1c389ef5cdb 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -208,6 +208,13 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
 #define ROOT_COMPLEX_ENTRY_SIZE 36
 #define IORT_NODE_OFFSET 48
 
+static bool its_enabled(VirtMachineState *vms)
+{
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+
+    return !vmc->no_its;
+}
+
 /*
  * Append an ID mapping entry as described by "Table 4 ID mapping format" in
  * "IO Remapping Table System Software on ARM Platforms", Chapter 3.
@@ -670,7 +677,6 @@ static void
 build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     int i;
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     const MemMapEntry *memmap = vms->memmap;
     AcpiTable table = { .sig = "APIC", .rev = 4, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
@@ -741,7 +747,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                                           memmap[VIRT_HIGH_GIC_REDIST2].size);
         }
 
-        if (!vmc->no_its) {
+        if (its_enabled(vms)) {
             /*
              * ACPI spec, Revision 6.0 Errata A
              * (original 6.0 definition has invalid Length)
@@ -973,7 +979,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
                           vms->oem_table_id);
     }
 
-    if (!vmc->no_its) {
+    if (its_enabled(vms)) {
         acpi_add_table(table_offsets, tables_blob);
         build_iort(tables_blob, tables->linker, vms);
     }
-- 
2.47.1


