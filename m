Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A508C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 15:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc3bB-0000Hg-NN; Wed, 16 Jul 2025 10:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uc3Kh-0000XZ-1j
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 10:42:08 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uc3Kc-0004D6-RZ
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 10:42:05 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-af51596da56so5615263a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 07:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1752676918; x=1753281718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dvZMU+Jp2i+nkStnLXkRcOA2jT1hsR9XWGiTLF22h+c=;
 b=diPZXD7aYzdyq0T41Xy9oNQVLU0lHomfCYqc8DiravbHjpWqtn7X25l3CKXO1IOfhm
 25lEkVXLgvershvj3q6+irkr0rKDEuvcc8NAWHx4kPDNfQykn3YKpbsWxcA8RUOeMqHq
 guPOwEsGdWOwJxU13Jqz+hFXcw85rCkmVDDevyiL4wFCYpnlDX63h+dHcuMtZdj+gLFX
 Mm8YtQqdqAmzmoScu/2yB0rTK1auA/8E764dVFKo24Yll2hu8Hhad3zfaVVg1kW/wulA
 3EWxEeyKktsuKn2GgwfU7JpPEQsV5Xrk3datgyDCfwAtprsahNrga+mrr33IoSsPMcFJ
 O84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752676918; x=1753281718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dvZMU+Jp2i+nkStnLXkRcOA2jT1hsR9XWGiTLF22h+c=;
 b=grZcPKxqCFyDfK3PAhZgq5opGN0+te7uYWVxdJE/p4ZWYxSLtcOKkd/GK21LfKqjC/
 9h99scx0g/EuMXJN9flOokEVQJbFA9wSnep/vHbYXVg0gutQ6anQbExZmP7+O+fxyU7Q
 Lyy7RY6+h0RcIHRpjv8hezWFDvsbS+uZLNP252xB8Vw9Xbz2lMLPpR0uVyVejrjcpQG4
 EghYIzU+XXpK8PjzFofcxRjV9yvu5CVy0EwyaHbyWcYeIQZkoyte60XSJyNAXRlSeGhg
 d6zKNclp936yda4hEv37SfZujvT1HLq+P5EFCdFB+IIEOYl+PxobcjQZ2dGebvy4XS5u
 VB6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIEDd9ubYspTtT4h4T6R0JsJP4N2SO7WfeAitR8VhUGWAwBwH1v24m5HAklT6CxcmHKpmJkMy4uHkL@nongnu.org
X-Gm-Message-State: AOJu0YzNIHvgGIlERM3Jy2QlLIfg5sCptMuWpakf/3Clvq3AA0Ldl5Mj
 NtNHugClH+lbpYtl7c5HKt1DEsDN0wSIAAvmX2TxVAd449/XCBPnFVy3zQneJIpyh94=
X-Gm-Gg: ASbGncsyvdeXgmX8VZEa15sceKxAkobM5BxTP/7oxODoYmsxG73ISxS26IfBDKnhkfn
 qOjRvYHgLM/k71kzsdb5L7vompaP3/aU3LGW/fVZoXwbipawAfsZGTxLQrjA2fAQyoJPQ6MAou3
 r+3brB/5Q7Qgv+vMoU7eayBYfxZ+aHzZZzuC4wDaVcrt3OrdkxOkzPQ8ZxhrKRsTm2DKdk2fl0t
 iWUFm3W0cZC95GvCUc3CpJnskKxoy/DhmXW3knyawUGjCJrXNfWFPAw4Ew05nx66aqZu114Pl7w
 knD0HBdMjMZOwOb8tqMiyr1/24lagTry9PtAGvDqxPYf8E+tZAvPH8NQwTItOSh3BLE+2Z2umsJ
 GszQIbyELSy7+wwFOvG7d/AGtqFE3QihT
X-Google-Smtp-Source: AGHT+IEONFlC7D4m23u8wP2sqs7iF1q5eTUOPlb1/yoBmV7j7soI3fKYeiqwB+sg8KxEWXH0J/OzUQ==
X-Received: by 2002:a17:90b:3905:b0:311:f99e:7f57 with SMTP id
 98e67ed59e1d1-31c9f4cf480mr4252500a91.23.1752676917836; 
 Wed, 16 Jul 2025 07:41:57 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.195.230])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f2879fcsm1622950a91.28.2025.07.16.07.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 07:41:57 -0700 (PDT)
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
Subject: [PATCH 2/3] hw/riscv/virt-acpi-build.c: Update FADT and MADT versions
Date: Wed, 16 Jul 2025 20:11:39 +0530
Message-ID: <20250716144140.3954431-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716144140.3954431-1-sunilvl@ventanamicro.com>
References: <20250716144140.3954431-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pg1-x534.google.com
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

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 hw/riscv/virt-acpi-build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index ee1416d264..d7e57cbb1f 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -429,7 +429,7 @@ static void build_fadt_rev6(GArray *table_data,
 {
     AcpiFadtData fadt = {
         .rev = 6,
-        .minor_ver = 5,
+        .minor_ver = 6,
         .flags = 1 << ACPI_FADT_F_HW_REDUCED_ACPI,
         .xdsdt_tbl_offset = &dsdt_tbl_offset,
     };
@@ -537,7 +537,7 @@ static void build_madt(GArray *table_data,
 
     hart_index_bits = imsic_num_bits(imsic_max_hart_per_socket);
 
-    AcpiTable table = { .sig = "APIC", .rev = 6, .oem_id = s->oem_id,
+    AcpiTable table = { .sig = "APIC", .rev = 7, .oem_id = s->oem_id,
                         .oem_table_id = s->oem_table_id };
 
     acpi_table_begin(&table, table_data);
-- 
2.43.0


