Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBBEC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetkw-0000Qc-J6; Thu, 24 Jul 2025 07:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uetkB-000809-GC
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:04:19 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uetk9-0000Zz-A3
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:04:11 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-75ce8f8a3a1so559299b3a.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 04:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1753355048; x=1753959848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0BMZbh3/31+jd2Tm96ixJQcChjMCHbFHTiQVo4p1qM=;
 b=juTS9qInrrLdsTfYOOxlsDgnNbPuvwannYdg8ACVTIinyU/xVbBA7hsQ4ZEvfoKQlo
 JDQxksItI+ltH/sW4wKLTog/pXSyVVaLUADFY/c4TcA1V2eZOzND674OJBBhYn0b9j8O
 WsrjObiYF1UDdTOnfCFq3xurmB6Rs/LfLg+DxJRZyY68dU9tmnMLcxFXXpqZJxwenL7b
 hf49DcjulzBZyoklOifjzvUgRyB6i1sUcS/AxYmlhsggWwFX82BzB2YtlQrnsMXUm3IE
 CGW5ymqkkVKDTM3mFWcbl5v045Mx3Qvl1nzmDjJ/h3Vu/6cTjT7Crs5PJHRF0qpGT2k3
 uaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753355048; x=1753959848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o0BMZbh3/31+jd2Tm96ixJQcChjMCHbFHTiQVo4p1qM=;
 b=rBnxlSAycdJv8/5qqUevnDm9UYa1oTfQ1DCbhyFuAtvIKIf4Rz1RbyYO9nNlKF8VqJ
 lgICXyiYpCCTI57R+W/tryZ0Uc1rrZ/515/wdkpx6Je/MomEM93NeGNX8JpmMYx9Knik
 iOPDdfJ+2Nz5WgBUjWiC+Vqx0DdI19zK5gNvpJEKIpm9nHi9YZ5+rkQQsOAY38/YuxKU
 M80Yx7ziyJBvOqteahPTrQ+iirrNZGiIO3Z+1W+aDQL5tVIgWqq5tkUWPUStW+/oNhkR
 05lSHYYgxKX4rogpRO961G8RhbEjV42VQuByYuzcUdPwQHO8pqcG/k/CSLN+15jh2i6e
 7PeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUlqsd0C65UH9WHiG2jpMvkQbjScc78YgkNDQf/vptsogSM4xaroQsSTk6298gv7NleUg1mlQfOT99@nongnu.org
X-Gm-Message-State: AOJu0YzNbnaEMj355w0ozC/+J9SEacfCyLWQvHPUZWh0gNQ99WZj/KvJ
 y2stXDD1wJ76bVgd9XqHSLX3ajJIwkAKRuDXmqKmJYeM/75LaIYNA3RX06FgybN6A1Q=
X-Gm-Gg: ASbGncuwMEdsYnPNi7DjXKSEWMxehxT1E36Qzks13VNs3gA6ofXSJLo+WVASfa6OEoR
 PcJMtHKL7jCkz5eXCwFwyduMPMm+uQr2JA1Dxm0AeS99xdeVagdzZRygN5tSMUdybWC6uzE8gkB
 J/Eq4crHgchkR2Hp7VQ87h92Z5E4x1iej7uLsIldfG112b1zvyGf5pgsXMgMLT6F0KTBTQZqOxo
 y55/Ym6cGh3sPNI4NTXciTrpuhInoKWPMPe3S6Jrgc2P5ja5E20kqRXKj5vMcEhlTLCvV9Tggri
 rmHNW9mxxgqWhcC9/8Yr7OskQwezDT2E96MSc7PYPgppRcBPxtClltjXk3wPfEcy/VZJVN/WUUJ
 Lu/0Iw4WxUGxsGfH0d8jxO7uweoXSAfKRg2wVSDKwlJueExHs
X-Google-Smtp-Source: AGHT+IEFNTackg9wTLSAmzC2Obx3r665AFcK8CBWfXt+ue/K1sS8Dt0SfZgyYypeoBSCLZK6nVCqhA==
X-Received: by 2002:a05:6a00:9281:b0:748:e150:ac5c with SMTP id
 d2e1a72fcca58-76035fe970cmr9041748b3a.23.1753355046885; 
 Thu, 24 Jul 2025 04:04:06 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.219])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-761add64fd1sm1430578b3a.13.2025.07.24.04.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 04:04:06 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 Atish Kumar Patra <atishp@rivosinc.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2 2/3] hw/riscv/virt-acpi-build.c: Update FADT and MADT
 versions
Date: Thu, 24 Jul 2025 16:33:49 +0530
Message-ID: <20250724110350.452828-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724110350.452828-1-sunilvl@ventanamicro.com>
References: <20250724110350.452828-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x42b.google.com
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

RISC-V support is added only in ACPI 6.6. According to the ACPI 6.6
specification, the minor version of the Fixed ACPI Description Table
(FADT) should be 6, and the Multiple APIC Description Table (MADT)
should use revision 7. So, update the RISC-V FADT and MADT to reflect
correct versions.

Update the code comments to reflect ACPI 6.6 version details.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/riscv/virt-acpi-build.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index ee1416d264..f1406cb683 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -270,11 +270,8 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
 #define RHCT_NODE_ARRAY_OFFSET 56
 
 /*
- * ACPI spec, Revision 6.5+
- * 5.2.36 RISC-V Hart Capabilities Table (RHCT)
- * REF: https://github.com/riscv-non-isa/riscv-acpi/issues/16
- *      https://drive.google.com/file/d/1nP3nFiH4jkPMp6COOxP6123DCZKR-tia/view
- *      https://drive.google.com/file/d/1sKbOa8m1UZw1JkquZYe3F1zQBN1xXsaf/view
+ * ACPI spec, Revision 6.6
+ * 5.2.37 RISC-V Hart Capabilities Table (RHCT)
  */
 static void build_rhct(GArray *table_data,
                        BIOSLinker *linker,
@@ -421,7 +418,10 @@ static void build_rhct(GArray *table_data,
     acpi_table_end(linker, &table);
 }
 
-/* FADT */
+/*
+ * ACPI spec, Revision 6.6
+ * 5.2.9 Fixed ACPI Description Table (MADT)
+ */
 static void build_fadt_rev6(GArray *table_data,
                             BIOSLinker *linker,
                             RISCVVirtState *s,
@@ -429,7 +429,7 @@ static void build_fadt_rev6(GArray *table_data,
 {
     AcpiFadtData fadt = {
         .rev = 6,
-        .minor_ver = 5,
+        .minor_ver = 6,
         .flags = 1 << ACPI_FADT_F_HW_REDUCED_ACPI,
         .xdsdt_tbl_offset = &dsdt_tbl_offset,
     };
@@ -508,11 +508,8 @@ static void build_dsdt(GArray *table_data,
 }
 
 /*
- * ACPI spec, Revision 6.5+
+ * ACPI spec, Revision 6.6
  * 5.2.12 Multiple APIC Description Table (MADT)
- * REF: https://github.com/riscv-non-isa/riscv-acpi/issues/15
- *      https://drive.google.com/file/d/1R6k4MshhN3WTT-hwqAquu5nX6xSEqK2l/view
- *      https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view
  */
 static void build_madt(GArray *table_data,
                        BIOSLinker *linker,
@@ -537,7 +534,7 @@ static void build_madt(GArray *table_data,
 
     hart_index_bits = imsic_num_bits(imsic_max_hart_per_socket);
 
-    AcpiTable table = { .sig = "APIC", .rev = 6, .oem_id = s->oem_id,
+    AcpiTable table = { .sig = "APIC", .rev = 7, .oem_id = s->oem_id,
                         .oem_table_id = s->oem_table_id };
 
     acpi_table_begin(&table, table_data);
@@ -812,10 +809,8 @@ static void build_rimt(GArray *table_data, BIOSLinker *linker,
 }
 
 /*
- * ACPI spec, Revision 6.5+
+ * ACPI spec, Revision 6.6
  * 5.2.16 System Resource Affinity Table (SRAT)
- * REF: https://github.com/riscv-non-isa/riscv-acpi/issues/25
- *      https://drive.google.com/file/d/1YTdDx2IPm5IeZjAW932EYU-tUtgS08tX/view
  */
 static void
 build_srat(GArray *table_data, BIOSLinker *linker, RISCVVirtState *vms)
-- 
2.43.0


