Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91975C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 01:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugvIO-00066q-S5; Tue, 29 Jul 2025 21:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCS-00033M-Qi
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:01:44 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugvCQ-0004iV-Q2
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 21:01:44 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7494999de5cso4359896b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 18:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753837301; x=1754442101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4aIWN5OnX9/GMC6APQFtk8p77iCVg7Chzcce/9d2M6A=;
 b=SvkLI1gmqZyyofKjkPZ9SOw8QmGLRrdQofHeYO5WLgLIi4tyOCZTEIckSJ56E+W456
 b1zQS4OkAJiL47OunYe6rOm52/FVg1UBoe0czOlwuctY05VAl0SB34m/68H/nYGxiXDm
 utQ3ulEecRQURgYNyyYU18xkk9SMYPWTPQEr+Lal+5FQYbqVTWLtSd+3vw6yh2iURbko
 IP5p3pbaxi60uh0L0DRR1cfVQmKcAQIyRIy7MJB2GCByoU5qiOoRkW550S20W35emTLo
 z+NRwYdkhB6SqKP2I4H1maOdoaqZipBRI8gbZFImH9h4q5YF64/j6XzYGcD3Ul0/GMZH
 MpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753837301; x=1754442101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4aIWN5OnX9/GMC6APQFtk8p77iCVg7Chzcce/9d2M6A=;
 b=JAVFl8ke41AA+G/s4wdqKvvZ3r42L20zMIXwWUsxc/c43qFkUljWevSXst11ht/+P3
 PqegzxF9HGnEpvo6MFml0jBcfiK87ac+3bvS1VfyKsD/t86JOS4RF9gvm/1OY2fY1SSV
 JAQvPEJQzg33tfn7yOvh/CnXWkczB6M4T9o4T73VDk4iu27t+8nGBfPJQbzjzWWQxgZl
 HEh2b7sjvWJCTr0jDxB/nUma7IDRYrUBeDEW5JldGQmXtM8oz+ysmeGbMjYLQneCWJs7
 P8tfZ056OWw5LegZZB/KwbC4s8dHylFX1e8vrfC+w871EQeI3vu3D3yTHuxcuqKMsjsP
 Stbw==
X-Gm-Message-State: AOJu0YzUSZ6EcPyAirvszwMX8LJggAQ4Nr0d92oz83qC+ZpCqyG/CrhO
 40PrRapa0U84Znt7y8NreB1wXxlAxMTWvCuGNfZQFEV8v1IcIy12xL80d/bjfQ==
X-Gm-Gg: ASbGncvog/h6o+JzI/diQIskyK4/aDhrnehdvS+XhJSPcYkUZJv4HWjdwYr+qg3K/N4
 5TbGsyNfagVMD30m5reBRL8lcDzpKjDfFR3ptqyLmqaC8hhS4YCRlxKb9m7MVV2vWqhjE6N8Fzj
 X3ypiqg/wUQ9iFIbNDxzk6o8PISVbKpRJOAMgw2h7C5vuu0Od8pmdmnWzmRgmazkHC2hvzv3XV7
 8U9G9LNwRWWVjRrjFfsBmubYm2RIvqem58keAu8anFTp7+Y6aQPVkMfjuxqfJ5AXVAWiU9l8ZVN
 wKN73t7aDnp+rDbkjzLjkf9GrXklzfepL0PK1XvRq5p/nzrUA0+mD93Ipxt9n7kbNI3tlQOoRLx
 Hu8m6lt/UfMBLKZf5GDF7V6B6MiWeCPHKu9ox9tRstM8CVc7HTw4365RgAKhbgvTTs+ME7t7y6P
 LZfQPaIJLkyZjqYv6ODT8B4BBjPyI=
X-Google-Smtp-Source: AGHT+IGO5+dWwvxKlGWZjHjzWJbplJrycQOQWKLE673qmnxy3f79EGF0fqMSgITxrplJXNK3GaVR7Q==
X-Received: by 2002:a05:6a20:3d06:b0:22b:8f7f:5cb2 with SMTP id
 adf61e73a8af0-23dc0cf7867mr2163901637.8.1753837299835; 
 Tue, 29 Jul 2025 18:01:39 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63df5adfsm343253a91.25.2025.07.29.18.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 18:01:39 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sunil V L <sunilvl@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nutty Liu <liujingqi@lanxincomputing.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/11] hw/riscv/virt-acpi-build.c: Update FADT and MADT versions
Date: Wed, 30 Jul 2025 11:01:14 +1000
Message-ID: <20250730010122.4193496-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250730010122.4193496-1-alistair.francis@wdc.com>
References: <20250730010122.4193496-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Sunil V L <sunilvl@ventanamicro.com>

RISC-V support is added only in ACPI 6.6. According to the ACPI 6.6
specification, the minor version of the Fixed ACPI Description Table
(FADT) should be 6, and the Multiple APIC Description Table (MADT)
should use revision 7. So, update the RISC-V FADT and MADT to reflect
correct versions.

Update the code comments to reflect ACPI 6.6 version details.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>
Message-ID: <20250724110350.452828-3-sunilvl@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.50.0


