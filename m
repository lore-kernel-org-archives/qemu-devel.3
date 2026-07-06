Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F5BC44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggie-0007D6-OJ; Mon, 06 Jul 2026 06:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiS-00073S-Ej
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:22 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiP-0003Pr-2d
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:20 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493bc8fda98so31423445e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334295; x=1783939095; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ura28sdkKYPryMO+LtMRN/uw8MB+2Afo0UvbdUwSUV0=;
 b=VDtJYrsbeQTip2aJDhjdRS1uh83O//kOGZSjEf3Bc+k/VlPrLjmu008hvewM+N263Z
 X8IeGJ7TKxlsth6ML7kEjXk9WKtfL6P28lCLwJgC1sDwCAziIOhQdxJIdUBsBKU6pv94
 Gjb/Fyg7X9w4cjnTd1tuM/ohkH5H4pX1M8ZtcPvqhSjbAv0GPbIqcIHngp5V6Lj4FaPO
 MH5QH/elBIChwEPWi/ql1fPOE0mUEjRgBNLQXqJHCmWkfYs/Jp9T6QvP2lzEK058VNgn
 dacAF8ly9HOG1X0SjSRRAgRAMl9xRnImoN78fxw5Hm+6BFlZDBg5appAwVMbTLO6jj0P
 UcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334295; x=1783939095;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ura28sdkKYPryMO+LtMRN/uw8MB+2Afo0UvbdUwSUV0=;
 b=AYn+Xx58yLhrm4oI6YmkRkk7V3TSJMQcij4eyz5bfV0iQP483fQgjqUZ5ixqPvkzWu
 qvDh38nH5z9f5j1Zxa1tk3zCnUSf0OUQFPkPEcnqf7tak9LIlGbwUXGgMbuV3xnvbA4u
 dfietOJsdXNrOa2A2vBUHOXpfDD8XNSkLhQgevJxGJAJCxpoc7rey4HHeQ5V2pYBL1+8
 yf3HONEO65XolY1suZcjQ78met5rtXgTkblhjohrq7yvkAGAA3/w4SW9++gPbHvkBLhu
 58FwXkn3nvFhQ7suOeKs96eZcie6CLTDcWtWuJNjEhw24PktABPoGthlnNQ7vtgOQwyE
 9tyw==
X-Gm-Message-State: AOJu0YxtI+WRp/7S30wEQVzloaspago/DK0SN2umWXvM0b7sfY1aSUir
 OrGP3DUN0J1y1xCuYZM7zJ7vEEfLwb+tDjAeNEr4io0xk5SxxghMNIhOIOmCZLqseEyFsrw5nD2
 v3BwW6G+B7w==
X-Gm-Gg: AfdE7cnBq0ApJqoeqZJcjTvaxYlgltyKppsI2d0/aZ1VKOCwNPL9lgNJ7rhmsfYtLxo
 3GDAmwmYhrdPOs/jsOtSZBBvY0IKgMI+5SIo99Ik0Y4kyq32ctMj6kF+3+1vRJESaFa1vpwJgYP
 86nNtXVdtjYwie4LnNkJYXPdNFPreDQUEp1IhFg+D59xVhUuj5uLqOibM8jW3/RyW510eQseAit
 rDzM3taB2e32fPGAyuxXH88I0CISqixHW412lLu7vBHFiL1o8eSKP5eFuFk+WbWpYWvz0aqFbAi
 hQ87uhdYCcG6KN5CtbKnbmhFZHZu7g9IvwRSsEp5X0bxLe9/4h4wWa3jyXOA/P8CPpTZf0lM8fk
 cP6X1KmaFZkV0JPAEJ0wyAdlQ5RNMD2mR1YpJ7W3wajmrR2cuuliXZwj2aTTkRXLpVzPoenIXD/
 ECM3lk4H1SPvXai9/WDpFy0zU7g/VOLFnwIVEeGhaf9Llads/BZgSmOYbzRBrEBdyriafQtQXO3
 GOw4A2sAZSIWbkb4Fsv0g==
X-Received: by 2002:a05:600c:5394:b0:492:7101:3d88 with SMTP id
 5b1f17b1804b1-493d11f0ce5mr107854775e9.24.1783334294645; 
 Mon, 06 Jul 2026 03:38:14 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/49] hw/nvram/fw_cfg: Enforce standard layout for
 fw_cfg_init_mem_dma()
Date: Mon,  6 Jul 2026 11:37:22 +0100
Message-ID: <20260706103752.320511-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently fw_cfg_init_mem_dma() allows the caller to customize the
register layout, by specifying separately the offsets for control,
data and DMA registers, plus the width of the data register.

In practice, all the boards using this function specify the same
standard layout: "base + 8, base, 8, base + 16", meaning that the
data register is 8 bytes and the registers are data at offset 0,
control/selector at offset 8, and DMA at offset 16.

Allowing every board to be different is gratuitous and useless
variation which leads to code in guest OSes having architecture
ifdeffery to cope with it.  Avoid potentially introducing any more of
this by removing all the arguments from fw_cfg_init_mem_dma(), so
that the callers only specify the base address.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260529174639.451353-3-peter.maydell@linaro.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/virt.c             |  2 +-
 hw/loongarch/fw_cfg.c     |  3 +--
 hw/nvram/fw_cfg.c         | 10 ++++------
 hw/riscv/virt.c           |  3 +--
 include/hw/nvram/fw_cfg.h | 23 ++++++++++++++++++++---
 5 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d8d27f2ef6..abee62fcbc 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1944,7 +1944,7 @@ static FWCfgState *create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
     FWCfgState *fw_cfg;
     char *nodename;
 
-    fw_cfg = fw_cfg_init_mem_dma(base + 8, base, 8, base + 16, as);
+    fw_cfg = fw_cfg_init_mem_dma(base, as);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)ms->smp.cpus);
 
     nodename = g_strdup_printf("/fw-cfg@%" PRIx64, base);
diff --git a/hw/loongarch/fw_cfg.c b/hw/loongarch/fw_cfg.c
index d2a79efbf7..4c976ce1e5 100644
--- a/hw/loongarch/fw_cfg.c
+++ b/hw/loongarch/fw_cfg.c
@@ -23,8 +23,7 @@ FWCfgState *virt_fw_cfg_init(ram_addr_t ram_size, MachineState *ms)
     int max_cpus = ms->smp.max_cpus;
     int smp_cpus = ms->smp.cpus;
 
-    fw_cfg = fw_cfg_init_mem_dma(VIRT_FWCFG_BASE + 8, VIRT_FWCFG_BASE, 8,
-                                 VIRT_FWCFG_BASE + 16, &address_space_memory);
+    fw_cfg = fw_cfg_init_mem_dma(VIRT_FWCFG_BASE, &address_space_memory);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)max_cpus);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)smp_cpus);
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 1d7d835421..59cf92293c 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1088,13 +1088,11 @@ static FWCfgState *fw_cfg_init_mem_internal(hwaddr ctl_addr,
     return s;
 }
 
-FWCfgState *fw_cfg_init_mem_dma(hwaddr ctl_addr,
-                                hwaddr data_addr, uint32_t data_width,
-                                hwaddr dma_addr, AddressSpace *dma_as)
+FWCfgState *fw_cfg_init_mem_dma(hwaddr base_addr, AddressSpace *dma_as)
 {
-    assert(dma_addr && dma_as);
-    return fw_cfg_init_mem_internal(ctl_addr, data_addr, data_width,
-                                    dma_addr, dma_as);
+    assert(dma_as);
+    return fw_cfg_init_mem_internal(base_addr + 8, base_addr, 8,
+                                    base_addr + 16, dma_as);
 }
 
 FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index b68067cfdd..bd9f77aad3 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1109,8 +1109,7 @@ static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
 {
     FWCfgState *fw_cfg;
 
-    fw_cfg = fw_cfg_init_mem_dma(base + 8, base, 8, base + 16,
-                                 &address_space_memory);
+    fw_cfg = fw_cfg_init_mem_dma(base, &address_space_memory);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)ms->smp.cpus);
 
     return fw_cfg;
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 56f17a0bdc..45a3747908 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -309,9 +309,26 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
                                 AddressSpace *dma_as);
 FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
                                   unsigned data_width);
-FWCfgState *fw_cfg_init_mem_dma(hwaddr ctl_addr,
-                                hwaddr data_addr, uint32_t data_width,
-                                hwaddr dma_addr, AddressSpace *dma_as);
+/**
+ * fw_cfg_init_mem_dma:
+ * @base_addr: address to map the device at
+ * @as: the device will do DMA to/from this AddressSpace
+ *
+ * Create and map a fw_cfg device at the specified base address.
+ *
+ * This always creates a device with DMA support, and the "standard"
+ * register layout:
+ *  - offset 0 : data, 64 bits
+ *  - offset 8 : selector, 16 bits
+ *  - offset 16 : DMA address, 64 bits
+ *
+ * The device will be created, configured and realized, and its
+ * memory regions for the registers will be mapped at the specified
+ * address.
+ *
+ * Returns the device object.
+ */
+FWCfgState *fw_cfg_init_mem_dma(hwaddr base_addr, AddressSpace *dma_as);
 
 FWCfgState *fw_cfg_find(void);
 bool fw_cfg_dma_enabled(void *opaque);
-- 
2.43.0


