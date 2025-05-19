Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912DFC3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs4f-0003JQ-Ve; Mon, 19 May 2025 00:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrp5-0008Ud-R9
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:58 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrp2-0004PI-IY
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:55 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-231fd67a9aeso12605945ad.1
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627790; x=1748232590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1OW1dBcqkD9seiHj1GS+2RugnBsuqu0z4wjW5Lk4KiQ=;
 b=ArX5NVNeXv/fZYllJBNZ+x3ovyvTobBWgzyXT9+XwGQruD+XBoTXkHQXWhUmR84WXH
 pi5FWEeRvTvrcY5Xf0NeB6SEtMV4bLN+lYHCHKYqUWr/6mlVfwXaNBvw5hNe/F44bd4K
 q0vx/sGRy7fM9OIMG8HED6035W6emlH0zif2ROZRIWYapDr5abtNaxNGvT+boLVVDzvC
 5DXZdi4IatvOPFQ1QsH5c6nhJuttOhFbSr0XqKc0hXm3pDEaSmw8GWP1VnRC5ReG3lBW
 l2jK0cRy+VEcH4Z75cOPhhL9utx8AAzzLlm5p7wzZWSOdjnWuXkByZ1zO8Woqb79VhOs
 OOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627790; x=1748232590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1OW1dBcqkD9seiHj1GS+2RugnBsuqu0z4wjW5Lk4KiQ=;
 b=jWhvFglZsN/x/N1e1dIR7L3/cLUZeql0ZNMYxdWQIpXFCFJQ+BEih3/m2QhU6gFEM3
 1AYwTKJ7oBAlURJn5NiD/xkOp0erAbQECmvU2+Hqahr/SwSxgeg1chvTBrZ7LlAhICmU
 l+652XXtUHvbY+5Oo7q57zPTM06cNZYhINZnratNJdmV/OBSbE2qpQx3nSvCxgFvftyx
 aWwLBp0fI07oa6VXwcX7xqAY33qdHrM81QhuQGW8pD018Hut2wdHtESIohHD+PdS2i4L
 Zs84b9/jUhtjLM3pX/gNvDLH/Oi7cGzrXcF3CkuAz+RiIRHGURhsEx/L2kN0Dj8tI+bM
 6nag==
X-Gm-Message-State: AOJu0YwzGHALaU1xNQqr6pv23ocG+IJL/7kGfkCfs7GMsUx69wPL5wqL
 Vuubv8r2DY1kmbLXXa5Kz5UzZpUecy/Mu89plJrd/41hJyF/5lcOkATo4zS8aw==
X-Gm-Gg: ASbGncu3vlzsWUoqpuJzuUaQcEk9dJ6Rpu5GTVMd7ND7hlWn1ag+u58tdKUtLxMnmmJ
 N9i7HxH83LO+cXD5pgJ+jIj9pKFtjezAwD9fhois6Q910lnYu4h023wCTZwj81qxgEPvrhf8VAB
 A29/DXVUNqrYNpWyTQJu7NRWLsloKjjbMSEafMSeR0/fV/phh9HZXAjhU1nhYQYlyLgtzPKOyU8
 cxS/aIx8PJMX/eQ+ZgkRiEbSb3XWKughQZwqMQZYsXcwpAuM3dJoiW6Ej9rMxZQP7S9SxJk9Gfg
 9w8dl/645T11sFcQLfJchPZI9fyQUjCRqnxgAqeBO1u5M1bgcu2WlnaIEFVAuG7bdqbtJRbM/Nb
 5QR2CKcELRM56j0x7xDyRLlsPMoXWeytxIyueLgYRh1f6ly9pR/7E5VH/
X-Google-Smtp-Source: AGHT+IHkXzV3SHqgOD9/ON/6bEPLPMJ46NrHnIqflfqdQ8lAsZTF8i7uDd5mbqJUni6L6IM+3laakQ==
X-Received: by 2002:a17:902:c202:b0:231:c89f:4e94 with SMTP id
 d9443c01a7336-231c89f4f9amr147418275ad.21.1747627790209; 
 Sun, 18 May 2025 21:09:50 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:09:49 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 51/56] hw/riscv/virt.c: add 'base' arg in create_fw_cfg()
Date: Mon, 19 May 2025 14:05:48 +1000
Message-ID: <20250519040555.3797167-52-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

The function can receive the value via s->memmap[VIRT_FW_CFG].base from
the caller, avoiding the use of virt_memmap.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250429125811.224803-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index b349b2b1cf..3d547f7c2b 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1262,9 +1262,8 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
     return dev;
 }
 
-static FWCfgState *create_fw_cfg(const MachineState *ms)
+static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
 {
-    hwaddr base = virt_memmap[VIRT_FW_CFG].base;
     FWCfgState *fw_cfg;
 
     fw_cfg = fw_cfg_init_mem_wide(base + 8, base, 8, base + 16,
@@ -1677,7 +1676,7 @@ static void virt_machine_init(MachineState *machine)
      * Init fw_cfg. Must be done before riscv_load_fdt, otherwise the
      * device tree cannot be altered and we get FDT_ERR_NOSPACE.
      */
-    s->fw_cfg = create_fw_cfg(machine);
+    s->fw_cfg = create_fw_cfg(machine, s->memmap[VIRT_FW_CFG].base);
     rom_set_fw(s->fw_cfg);
 
     /* SiFive Test MMIO device */
-- 
2.49.0


