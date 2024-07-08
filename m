Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB04DC3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 11:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQmqr-00020o-4h; Mon, 08 Jul 2024 07:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sQmqp-0001vX-FZ
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:48:11 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sQmqd-0000zX-5x
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:48:11 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70b2a0542c2so828327b3a.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 04:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1720439276; x=1721044076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VrHiIjwct91ht0i7PHZglY7Dj7SLTZxWTqnnPukeXL0=;
 b=KiMcmSKV/zXN1fmVB12IrfAge2RP7iMw2zKzj18Hg9e2yei2SXQh0dJG9ZKj1rwlkW
 Oz0I0+nkgyGJFQjhcjAZPwrW837CNyjqK7YU6SL4NedCg9XSGcKXIfHWzqSP6GPEJ0Qy
 FRIFPZTosb+PHg0Ylr5VPsyG18tz0ofmvImTMjsmcVz+C64CrRx9JcifbJoVhKVhfehh
 QMo1G665m7el+FiqWoWPKXokqQBQI75RlT/9+78AfO3oflhdIYXrYdESdML52hRhEkCz
 E85bts3VCt2jeFRlJxnBd+SewvrFvt4IHTUz6oL+VdcIK0sWJYToP1IKCZ+HBI8Lejn0
 sYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720439276; x=1721044076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VrHiIjwct91ht0i7PHZglY7Dj7SLTZxWTqnnPukeXL0=;
 b=VbokqSooUJ/pO6x6MEYt1va4ZOIyHy3mdbXPApwJvmF3M/66VvTxc6VqfJ/eKx+jSv
 xA1hp6hKl5CqEc5S52K7M9ZRjPp/3aEBLADnOxnZEwwPhKIZoEC1/xL2yKaw8r3M92jV
 Lx5e0lYZCG3iZ95cTHvd8y9b+hr6Il3TpC76zWH7AS4GOLN/HS/AscMZy+wYfOi9G4dn
 DPWbcmVjyLvEd8pHqvs/ZTc8S8Fxvt/2Ugmf2wx2NSe7SgdqOpuIvhTi1rt4bpGuiRVN
 TH/CMLrnBjOBcRST4UJyA9KBGxCDfrKIgvU5+p1QbkdFGDWRI9KrKr86kaRMzruZ2v0T
 Drzg==
X-Gm-Message-State: AOJu0YzvyaGPb5KCOm/T8n40QGFrgBFBTGszQd9FUI8FeU6gVYdF4xiS
 QK0PGXRNdCbZWslimmOCyKjNjygHt4ODTaaCajJkmg6MFdvBF5uM0H7RlyFzX4goz8HbSO2fd54
 h
X-Google-Smtp-Source: AGHT+IHFlU+rWwSr6KtFsPmwPzz0lGrvPirNNcURX2ncYjd0ANVTO+zJXJY3S9fVvYAWII6Nx36ouQ==
X-Received: by 2002:a05:6a00:4b16:b0:705:be21:f2be with SMTP id
 d2e1a72fcca58-70b00960b21mr15176007b3a.18.1720439276283; 
 Mon, 08 Jul 2024 04:47:56 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b2a432ac6sm2769642b3a.94.2024.07.08.04.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 04:47:55 -0700 (PDT)
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
Subject: [PATCH v2 2/9] hw/riscv/virt-acpi-build.c: Update the HID of RISC-V
 UART
Date: Mon,  8 Jul 2024 17:17:34 +0530
Message-ID: <20240708114741.3499585-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
References: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The RISC-V BRS specification [1] requires NS16550 compatible UART to
have the HID RSCV0003. So, update the HID for the UART.

[1] - https://github.com/riscv-non-isa/riscv-brs

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 87fe882af0..939f951e45 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -192,7 +192,7 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
                     uint32_t uart_irq)
 {
     Aml *dev = aml_device("COM0");
-    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
+    aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0003")));
     aml_append(dev, aml_name_decl("_UID", aml_int(0)));
 
     Aml *crs = aml_resource_template();
-- 
2.43.0


