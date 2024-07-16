Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A71C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjOs-0004DL-Q6; Tue, 16 Jul 2024 10:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTjOr-000498-Mx
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:43:29 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTjOp-000302-1w
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:43:29 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-793a3a79a83so1347750a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 07:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1721141003; x=1721745803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/5uhu6Kg5Ht8M//pg+LE9MtLky6V7L27T+s5kfGc6lw=;
 b=lBy839MFdao5hsNdnm1wqpBwv03rNcJUmkKXUEcpDIgQ0F3CQ7bCOTta4LaJRRHLcD
 cU0NtM5642pdRpEBRtiW4+aS9lkgOCMQjrffSY/W/ry1X2z40iHX6wGNu4FnimrT6xq+
 Y8Yoj0F7h+oxHUf3hs0M1RTjNqpBNhV0916YF462QRYLUB0hZnH4LXUcJXNftEhhpJG5
 yfIGPRjB4mPhipIC0K7hAEHuJNbu8xaxDdwAupYfuyBvlkoecxgplQJFcNsRpQiDpujv
 3zarCPsnSl7/xdKXM5dgptLXPr7ri36Iemip5nlCtebQDiPUDyBg5+6GZiuJifuJeR0x
 vwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721141003; x=1721745803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/5uhu6Kg5Ht8M//pg+LE9MtLky6V7L27T+s5kfGc6lw=;
 b=e3hZDZb5WxO/NCtnKHIovRMfrARXfZfD15nAHwl3lMMAsoxLPpsfbxoEbItS51Fu2B
 1M2vhhwTqI27c5V78OSi3227ZVXKO0CBkp8If19MZSsVEghmnlQAxhKHLDJeGHTjT9Cg
 351vYxgifRo24r4Rn41yBH5GuRcHYfSWLQSI2/SPdhw68YGre5Tb+XxIB+tY8EM170o0
 wxzs+TSuWUGqYFDI0DN9MedZV1xGVlfg4M/LfukdpSnn0OEJRrsppzFYmBiojW7mi8PM
 NdoQ5NsNW698g0fvU3tyR8a3qco+OU9kxo41X0ObALMRo4FiB1E/5KrWJ3dSSrge/nF9
 6BvQ==
X-Gm-Message-State: AOJu0YyE3i2rASHpu8tUNAz7XsMEieWt6sOhOx1kHJ4mUOdqlblE/awd
 /cfPbqpoLw+JWhvFLJ+B0sPYxIzba7KliZmwd+9kLJUjNbUzKsH1BAkhlP82re94dyoG9LpyCJr
 8cbs=
X-Google-Smtp-Source: AGHT+IEMnZ/SVXv0PH6LBaG6KNxSoZA0HahYQLf7NWYbXCp+0P4uu+KVIPdVsk51tkfDwUr1wfG9Ng==
X-Received: by 2002:a05:6a20:6a0f:b0:1be:c4bb:6f31 with SMTP id
 adf61e73a8af0-1c3f1210aacmr3016275637.18.1721141003650; 
 Tue, 16 Jul 2024 07:43:23 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2caf480d61bsm6084782a91.18.2024.07.16.07.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 07:43:23 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v4 1/9] hw/riscv/virt-acpi-build.c: Add namespace devices for
 PLIC and APLIC
Date: Tue, 16 Jul 2024 20:12:58 +0530
Message-ID: <20240716144306.2432257-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716144306.2432257-1-sunilvl@ventanamicro.com>
References: <20240716144306.2432257-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pg1-x52d.google.com
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

As per the requirement ACPI_080 in the RISC-V Boot and Runtime Services
(BRS) specification [1],  PLIC and APLIC should be in namespace as well.
So, add them using the defined HID.

[1] - https://github.com/riscv-non-isa/riscv-brs/releases/download/v0.0.2/riscv-brs-spec.pdf
      (Chapter 6)

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/riscv/virt-acpi-build.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 0925528160..5f5082a35b 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -141,6 +141,30 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
     }
 }
 
+static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
+                                     uint64_t mmio_base, uint64_t mmio_size,
+                                     const char *hid)
+{
+    uint64_t plic_aplic_addr;
+    uint32_t gsi_base;
+    uint8_t  socket;
+
+    for (socket = 0; socket < socket_count; socket++) {
+        plic_aplic_addr = mmio_base + mmio_size * socket;
+        gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
+        Aml *dev = aml_device("IC%.02X", socket);
+        aml_append(dev, aml_name_decl("_HID", aml_string("%s", hid)));
+        aml_append(dev, aml_name_decl("_UID", aml_int(socket)));
+        aml_append(dev, aml_name_decl("_GSB", aml_int(gsi_base)));
+
+        Aml *crs = aml_resource_template();
+        aml_append(crs, aml_memory32_fixed(plic_aplic_addr, mmio_size,
+                                           AML_READ_WRITE));
+        aml_append(dev, aml_name_decl("_CRS", crs));
+        aml_append(scope, dev);
+    }
+}
+
 static void
 acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
                     uint32_t uart_irq)
@@ -411,6 +435,14 @@ static void build_dsdt(GArray *table_data,
 
     socket_count = riscv_socket_count(ms);
 
+    if (s->aia_type == VIRT_AIA_TYPE_NONE) {
+        acpi_dsdt_add_plic_aplic(scope, socket_count, memmap[VIRT_PLIC].base,
+                                 memmap[VIRT_PLIC].size, "RSCV0001");
+    } else {
+        acpi_dsdt_add_plic_aplic(scope, socket_count, memmap[VIRT_APLIC_S].base,
+                                 memmap[VIRT_APLIC_S].size, "RSCV0002");
+    }
+
     acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ);
 
     if (socket_count == 1) {
-- 
2.43.0


