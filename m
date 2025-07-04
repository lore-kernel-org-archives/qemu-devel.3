Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5152FC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeO5-0006bU-QX; Fri, 04 Jul 2025 07:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMw-0004dr-Vf
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:16 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMp-0004KA-9b
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:13 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2350fc2591dso8705175ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627646; x=1752232446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=agWjWYPtfbUFcF7BoNC4FyaeOOST0sty4z+xdnIJbn4=;
 b=QD4KRN7SfpDArzNy36WPmIYYrkCXqe+qW64ytY23BO4zd+2b7cg7LoIORB5ddR+bgu
 Pufv0BHckxbmNOEProm2mPAJ2h5FCkdQO41kWQct3TrwTBxWp+sK94gqvUD8cVIMqOYI
 F9HOaCBg2aWOCpjm3E7B7xorDUSa04FS+5Ftx85El7ev7XuFiOge76aPv7fZ6/Q2pA+1
 MA5HhJ+LdvJBPt8S+Am5s4QFXIVbNxkvji0a2JtF+KcWoitVGQr+i7ourEloCtDWBrUZ
 cGUtdkLwY8LQHCSBWg+GzjPJwqqlzB0SqRBLqdpjmzQCcnIw+HUBy8ETf09cz2E1n7kl
 BQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627646; x=1752232446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=agWjWYPtfbUFcF7BoNC4FyaeOOST0sty4z+xdnIJbn4=;
 b=UPdzgbVCpT9fb1B1xntkQ8eV2DqSIgal0SiPeT9NJC2l5U66WybxFEgk8iklUryTYu
 JLuuznGWL3KoyLuFx+hNK0F/nSW43iw2xBtxFSHDYSO1wyJmmU6oQ5J2tizmT1n4J0+C
 i8HpLTDhmiuwEMx1gKn5BYtFO27mx7gMfErjky0tdVqvHoL7nqHbGmClkKpQiLM2Ti0O
 TpcfZyKvQgrKHmEr1r+5WafY4PTVCkPXcu7k7VCQ8sj2pDrvcWxXdec5xidB2xgT55zp
 ZuEb5bKvOFs8x9JLn+7Ttjs66C+WTgdb25ERbpLQCXQwVpc0fsBzcOy5dTn1j1aEcKEy
 2s1A==
X-Gm-Message-State: AOJu0YzWXmOKdSQckQBZvpP+LxtxdV4vsLh/solFWFWOnPuA2qiletB3
 qQB9qYO1trhNXfBuGI2x214SGJlqx9MIZkwLGgLFeHbdnW+CPGsACmZYabKgtw==
X-Gm-Gg: ASbGncvcE8oKqTvBZFKsUEOmZIhAfXjx8oibkvwdDUUO0VLLgUaJVTdDs0k8VUNKLjW
 aL2s4CShDqt8fRpgEWBl9/88/M22x48M46rhC0LkTss0Le4oVHaVEhuZGkriz4NEBxc/H8q0c3+
 dQCLXP2TJP+6kCrGQIlLCn2Z4/S8bW1vaiMb5ktyKw3ZjMljl73vC9QEc8JRERAdsyxPgufVhNu
 5E/mluvR8z16KyK29/MF6WXrf7qFEvFf5ipn1pQSOQUsx/ZXNvuie91Tir9UEuepYNsL8iCLABm
 Kmj1mBNrapMtdMNlDRO2QreJh5UAcIfQeG08Dsck6LxmINjTM8/K/nc4xrq1aoytR4z+tuNBD3H
 /9YYGvsWd/JQ+oysydywY7lI6a7gM8D1Vxna5QD0fFh5R8m+RMDWyXbpC3Cq7btaQekW2qUzkZp
 vvfg==
X-Google-Smtp-Source: AGHT+IGnGRObkw2OfpEbr9WQI1mqYlyep8f1xKw1FLOPyk+OO6+/81243lcUKu/EZZdgmsR8lJ7zJQ==
X-Received: by 2002:a17:903:198c:b0:237:e3bc:7691 with SMTP id
 d9443c01a7336-23c85938d6fmr41255045ad.13.1751627645572; 
 Fri, 04 Jul 2025 04:14:05 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:14:05 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 32/40] hw/riscv/virt: Use setprop_sized_cells for pcie
Date: Fri,  4 Jul 2025 21:11:59 +1000
Message-ID: <20250704111207.591994-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

From: Joel Stanley <joel@jms.id.au>

The current device tree property uses two cells for the address (and for
the size), but assumes the they are less than 32 bits by hard coding the
high cell to zero.

Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
and lower 32 bits across cells.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20250604025450.85327-13-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 67490c5c69..47e573f85a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -894,8 +894,8 @@ static void create_fdt_pcie(RISCVVirtState *s,
     if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
         qemu_fdt_setprop_cell(ms->fdt, name, "msi-parent", msi_pcie_phandle);
     }
-    qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0,
-        s->memmap[VIRT_PCIE_ECAM].base, 0, s->memmap[VIRT_PCIE_ECAM].size);
+    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg", 2,
+        s->memmap[VIRT_PCIE_ECAM].base, 2, s->memmap[VIRT_PCIE_ECAM].size);
     qemu_fdt_setprop_sized_cells(ms->fdt, name, "ranges",
         1, FDT_PCI_RANGE_IOPORT, 2, 0,
         2, s->memmap[VIRT_PCIE_PIO].base, 2, s->memmap[VIRT_PCIE_PIO].size,
-- 
2.50.0


