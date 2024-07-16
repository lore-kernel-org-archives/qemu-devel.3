Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A74C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjOu-0004LU-TU; Tue, 16 Jul 2024 10:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTjOt-0004Fh-CQ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:43:31 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTjOr-00030k-MK
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:43:31 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fb53bfb6easo37295055ad.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 07:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1721141007; x=1721745807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UDXZelutsce9cIB9fGIii64fwelO+gsXLon0gJsxJ+4=;
 b=ZMM2y9KMqabtnrUqtpkiVLRlaY20xQ4TnYK6UtHuNtpt8AedSf8GQJ8t60S9wr81+/
 yMfxsLPvlumuKTYt3xDw5kBZVs4y/gbNpQuEm4ur2igcxohvaPCO4frzyplUsFH+R4UK
 M7nyvRTqB6VKjweHcgFOBHDVVqIWlm5ewjejAj0vVYt/93r5WZOaJzEP7w4KWMIqDI65
 01WPyUOlut4P+pNQgCrvqEiLRljvwnF/3VbrsWcoMmSv8eop9gmDuf175b4EZgcqyvYV
 CyvBAWcrRlttPoMGDnL9TmbtGZ8aDDlURP0LhPUcrjgNwDuOUk1PkT53Sa3cWVHtohbD
 whQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721141007; x=1721745807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UDXZelutsce9cIB9fGIii64fwelO+gsXLon0gJsxJ+4=;
 b=mDWv1RviPAtw87ci62TyyPshI/fv8RjQ1JvT/5OBH4+ODDAzy8UEDoY/KFzZdiviMJ
 lH/Ei74vzkxOnya5s6rybZAMK7n1m5QjB9SyMeYdY1ATvHtetTrCA4gOFnBTt6c825MW
 msH7pYJriUWoiGbmvOiQ5OISCrXTM12BE6fc/a3RnTwppc14aDvrpLNBjDwuLRUVolJK
 JXJyENrIfvPLW2Hcw6V6vtWUshiQZI2JbwurD9dpw34zsCEJ5kZAScbLHStRkS1Q7mw6
 XCN5OJfVCcT/w7TbRE0IVjTMj7nHbJHJT7i+OwxsSOC9nRGttw4v7LN7PcCgonAGuyjN
 JkUw==
X-Gm-Message-State: AOJu0Yxw5K5MO//3Jj/W3h+BSyTzu+C9brhMQgO+KpFsrRKoWsbCjFgj
 HKJxlB5Y3FppgODp0G7RWeNUjyNDFTgIBaPHgMG+XYVeSoxKMTHbQjDKK6yNX14llwrU0biLedm
 Typ0=
X-Google-Smtp-Source: AGHT+IFcty9g8lbLOQ4dE32RnwkVpQXphfFixBbgeIevudOfss6B7AaJvV42U7MMZyToCIpfDUcsHw==
X-Received: by 2002:a17:90a:ad8a:b0:2c9:75fd:298a with SMTP id
 98e67ed59e1d1-2cb36e51603mr1802699a91.42.1721141007318; 
 Tue, 16 Jul 2024 07:43:27 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2caf480d61bsm6084782a91.18.2024.07.16.07.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 07:43:26 -0700 (PDT)
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
Subject: [PATCH v4 2/9] hw/riscv/virt-acpi-build.c: Update the HID of RISC-V
 UART
Date: Tue, 16 Jul 2024 20:12:59 +0530
Message-ID: <20240716144306.2432257-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716144306.2432257-1-sunilvl@ventanamicro.com>
References: <20240716144306.2432257-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pl1-x636.google.com
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

The requirement ACPI_060 in the RISC-V BRS specification [1], requires
NS16550 compatible UART to have the HID RSCV0003. So, update the HID for
the UART.

[1] -  https://github.com/riscv-non-isa/riscv-brs/releases/download/v0.0.2/riscv-brs-spec.pdf
       (Chapter 6)

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/riscv/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 5f5082a35b..36d6a3a412 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -170,7 +170,7 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
                     uint32_t uart_irq)
 {
     Aml *dev = aml_device("COM0");
-    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
+    aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0003")));
     aml_append(dev, aml_name_decl("_UID", aml_int(0)));
 
     Aml *crs = aml_resource_template();
-- 
2.43.0


