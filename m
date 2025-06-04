Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9847C5B559
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 02:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMeIp-0002DZ-Hh; Tue, 03 Jun 2025 22:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIm-0002Cp-Sk; Tue, 03 Jun 2025 22:56:28 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uMeIl-0000Qv-Ei; Tue, 03 Jun 2025 22:56:28 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2351227b098so44027535ad.2; 
 Tue, 03 Jun 2025 19:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749005785; x=1749610585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mZb1PN7GT5tBM4E+RD0BlKVebwzNtkntVesD3GuzMrw=;
 b=U4+2PdQEXfSGF251F/ngzwTr7tXpYxV9CkczzN3hTOIzSZ2eM5tGx3SeBix6zFj3zj
 /uFzvc1v2WYfOOkCNQVhezxHJRpsvzbcMdEF7MCcbczNuoSpcLm4kNLE67Zf5ITSsep2
 eiJM5GWIYckP8rKIKWyxvM7cU5y1Xx0jKhoxVNExwW66SgLwtgP80KF9xP9+KK4j8JEU
 BTzpXzLzK7GH1Xv5r+DT+6JJZrhZQfwapvWHs+PAKseKE5OSxmBQ9t0p6WsxS4lljK69
 KjpPVF8RLpv3DElh3/EQY68y0R72aV7AhGeWUfK9ZyyjWTGMiLWbLMENRCfCP0vuI3uP
 uVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749005785; x=1749610585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mZb1PN7GT5tBM4E+RD0BlKVebwzNtkntVesD3GuzMrw=;
 b=np8ZTgv/nmjd0pebpRaXSHTGIUP/MFkZ2fU6GOw0i+8v4ueNFSO1tWNcvmWHyn/qci
 yOpvJ4kx/3oqmQXegqfTFsgYKBdk59PYh8UNTJl7uX8u90RZNO18r2JlrCsf1dh60i3H
 rA7f/+0AzyZeLNeoO+6N5Zw4eWI+EFUE5ZLF/F1ET5gHSHTyHamSFR8Qb6Vv4uKmyfpF
 F4Jv8WH4yDguU37fCK30lnfBIeBZzq3y/K4hV6bf1wyJQpx5Obb5GTVvDQYqSXSCXCMa
 E0W2VstTTzXQereZackYy9IU9c5pc2bin4lpu2oRHPH1aEvBVwcCSfImLDSuDtkS7Zms
 EQog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZlxJJBu9rrpM/GDliWPrxKukgGWpy7l1nAnvaWv6V6jKG5u9Q0yaxhMd+QUMbj6ACUgNKt0+CHMCS@nongnu.org
X-Gm-Message-State: AOJu0Yy984YRyy6W12nHEuZLg6LB3PrFLJ696J0LM4Z8bD3uTh77V9I/
 RTLD2gmTxQxeMfFYsA4bL9gGfwfmC7wZ+FGLPDgb9xZUXhRcM3V58DnpWbjSGB65
X-Gm-Gg: ASbGncszsRNxphIFDvjq66YdhxLCLcPoxX7UGDKK8pWN65izCyRiKgDOyJp+nxScxeg
 VHmsbA+tmR7pftBdug+jfFNtETxvH1yD4Kc7LuvUYKIFxxHlFBGKxfkA2MyR5swbsD9TaVGxGNd
 d05gjIKfE8/o3FHutcx+rzCH13KkIZ9OKuvylvG/eDBVwewJCnvwpjcZZd1XUtCCdZmOVqzsJBE
 5xdZhVBZh4rzG8h8rP1DAXyMaabshPH6I8u5I2j2J97lc31q6RFpv7NnbKyAfqJDIU9zvW16cow
 kv9tei/9xlIkOK876LZk0GG686c5tBQqRK631F1/QhDUaZ+5vILg4lOyvG7x4w==
X-Google-Smtp-Source: AGHT+IFcTlOVQJh7u63++qJTY0fw1RSrBjukHzN+g9JLGVr5lwCWAcoXBe6/sLLtYo52bBJlJxsRZA==
X-Received: by 2002:a17:903:228a:b0:220:df73:b639 with SMTP id
 d9443c01a7336-235e11e74d0mr16848525ad.36.1749005785662; 
 Tue, 03 Jun 2025 19:56:25 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506d21818sm94457555ad.254.2025.06.03.19.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 19:56:25 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 11/12] hw/riscv/virt: Use setprop_sized_cells for iommu
Date: Wed,  4 Jun 2025 12:24:47 +0930
Message-ID: <20250604025450.85327-12-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250604025450.85327-1-joel@jms.id.au>
References: <20250604025450.85327-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

The current device tree property uses two cells for the address (and for
the size), but assumes the they are less than 32 bits by hard coding the
high cell to zero.

Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
and lower 32 bits across cells.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/virt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 4fa2bad24804..67490c5c693a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1088,8 +1088,7 @@ static void create_fdt_iommu_sys(RISCVVirtState *s, uint32_t irq_chip,
     qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
     qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
 
-    qemu_fdt_setprop_cells(fdt, iommu_node, "reg",
-                           addr >> 32, addr, size >> 32, size);
+    qemu_fdt_setprop_sized_cells(fdt, iommu_node, "reg", 2, addr, 2, size);
     qemu_fdt_setprop_cell(fdt, iommu_node, "interrupt-parent", irq_chip);
 
     qemu_fdt_setprop_cells(fdt, iommu_node, "interrupts",
-- 
2.47.2


