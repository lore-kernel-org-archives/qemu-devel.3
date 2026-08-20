Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28987C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtj3-0000Rr-Al; Wed, 19 Aug 2026 23:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtj1-0000Ix-Kg
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:55 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtiz-00040K-Un
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:55 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3811f512167so2522485a91.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197552; x=1787802352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PltKUjMnHc0h/eHYDCnaxVw3n7hGNmURlznNMKxaWok=;
 b=OFOwshXN1nGgeWigLfBcsXCC54q1miIhHw/L9mCjVu8wA9PMfrmAKsWjKOibNnuhWA
 jAYvCjIxpKfyTan7U1wQwYjN3zDG7TbWyabsiS9qir3qTZRZYR6CYGHK3BiK2c9pqWa/
 LPdKs8kHellxnMVT5WJEjKkhMK1ZjQQ9HEqDHavxUGyWNngbuCfAsZCS0KiKulp4p48E
 VuNfJRj0dvyVcvhP/cWq5p5Vl7J23noMIf/GEyi02XJV+THC35deUF1GjWzZI0lY06LM
 z9ObvVNLFRDr6VEBuQAk06Rx927Luphz5e2hAQajsFe3qRcMskZ7U0FuoFhLhYHGAF34
 dmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197552; x=1787802352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PltKUjMnHc0h/eHYDCnaxVw3n7hGNmURlznNMKxaWok=;
 b=KBUkn/BJGvnHVRv725M6cFS4IJcgqVAajx3xoVwIGc1TyIN0nYfHxyqOU3LdYrVd/0
 ra5A/dYpuW/5JZ0iKWd+WeQOGEbva8YNcVRZlczKOULcUWfCnAWNi45feLF/sZwqmmkU
 +Ec7aEyzO7wlHleLMfotClrRBD3cJSnyylJ6/ZiMd9VvzJiAoQvpv1SKXartiOKgS0uL
 o90uwi07EOFfokq4AxYU+8TdC/qTRTWlb7S0r5sj5p8v45Q+PQBByQwSWrsuCNC247XC
 DbMKgOeElhOXHjzMAofKyvjRviLdObnC7IWE2xoYfzZWsYY9ToMXcMGNQ8ZiywNHJRHC
 EPcg==
X-Gm-Message-State: AFuF++mqkIwFgFK96ZxoHGaQtojsGgpYjh1eh1TWBrKfqKYHNXjtSVqt
 RfhxE+oZgBsGEGA/Mb3Tku7ZBqWFpf17SSWcffAqai7ETMC1IG8Rs9myrb8H2g==
X-Gm-Gg: AR+sD136bfjmYRclYw3Uhq9P3wvW1GvlwQRbqeDZkVwxeYOPCcGxTN+IZWuTuVjGr6M
 NMhfg4avziCWv+VlkGpln2bCpOKBLGwBlKQOqRfMzo155+21vFBNwXRKl2l8caVdlxnjkEfgGwS
 6gSwUacfUNYK2THlI4WRdruvILyqvZrFkXnutYuHUz8p0hIbJcJqhK23Ze3q6aByTsQD9m3vHmr
 lSmDiPsF1EVQClG+h/qNuDy1qP6Xtv1AKsLU/tWdBq5gPL0yK6m6pKqWWv0CA7IY4pKS5koDtYL
 3uHg+N2bcX6K0k+liNDtyZGJB5b9cl/b3wzaawPHogv0KX+Z8RtI4zbvMLLRwK4DatGaD/X7PwR
 K6++6NSW2u9ckChV/rySaY1nd+pMmxz9Sv3gcw4+nEHZTMCQ5m22NyjGHPz2JVG4b1p7D4x0J5n
 FHgpkHex9Eo1IHlDMB8/PdQ2h2i/Mysy/IR8Y2P8gFlZ4hNsxW4nRpx4UN201O3kU0y0gQzAICA
 N4tbQ==
X-Received: by 2002:a17:90b:4e8f:b0:392:ca3b:370a with SMTP id
 98e67ed59e1d1-39580a50d67mr19140461a91.2.1787197552157; 
 Wed, 19 Aug 2026 20:45:52 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:45:51 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Flavien Solt <flavien.solt97@gmail.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 23/93] hw/misc/iommu-testdev: support PCI MSI test writes
Date: Thu, 20 Aug 2026 13:43:20 +1000
Message-ID: <20260820034430.1186695-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1033.google.com
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

From: Flavien Solt <flavien.solt97@gmail.com>

iommu-testdev writes ITD_DMA_WRITE_VAL with unspecified requester
attributes. RISC-V MSI remapping tests need to select an interrupt
identity in the payload. The MSI trap also identifies the device through
MemTxAttrs.requester_id.

Add a write-value register with the existing constant as its reset
default. Populate the requester ID from the PCI function. Existing
translation tests retain their payload while interrupt-remapping tests
can issue a valid MSI for the test device.

Signed-off-by: Flavien Solt <flavien.solt97@gmail.com>
Reviewed-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260727-qemu-mrif-v4-v4-1-73e0890ad395@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/misc/iommu-testdev.h |  1 +
 hw/misc/iommu-testdev.c         | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/hw/misc/iommu-testdev.h b/include/hw/misc/iommu-testdev.h
index 338365947c..2f4e9310df 100644
--- a/include/hw/misc/iommu-testdev.h
+++ b/include/hw/misc/iommu-testdev.h
@@ -81,6 +81,7 @@ enum {
     ITD_REG_DMA_ATTRS       = 0x18,
     ITD_REG_DMA_GPA_LO      = 0x1c,
     ITD_REG_DMA_GPA_HI      = 0x20,
+    ITD_REG_DMA_WRITE_VAL   = 0x24,
     BAR0_SIZE               = 0x1000,
 };
 
diff --git a/hw/misc/iommu-testdev.c b/hw/misc/iommu-testdev.c
index 15eb6de78a..6428a57fed 100644
--- a/hw/misc/iommu-testdev.c
+++ b/hw/misc/iommu-testdev.c
@@ -28,6 +28,7 @@ struct IOMMUTestDevState {
     uint64_t dma_paddr;
     uint32_t dma_len;
     uint32_t dma_result;
+    uint32_t dma_write_val;
     bool dma_armed; /* armed until a trigger consumes the request */
 
     AddressSpace *dma_as;   /* IOMMU-mediated DMA AS for this device */
@@ -80,6 +81,7 @@ static void iommu_testdev_maybe_run_dma(IOMMUTestDevState *s)
 
     /* Initialize MemTxAttrs from generic register. */
     attrs.secure = ITD_ATTRS_GET_SECURE(s->dma_attrs_cfg);
+    attrs.requester_id = pci_requester_id(&s->parent_obj);
 
     space_valid = ITD_ATTRS_GET_SPACE_VALID(s->dma_attrs_cfg);
     if (space_valid) {
@@ -97,12 +99,12 @@ static void iommu_testdev_maybe_run_dma(IOMMUTestDevState *s)
 
     as = s->dma_as;
 
-    /* Step 1: Write ITD_DMA_WRITE_VAL to DMA address */
+    /* Step 1: Write the configured test value to DMA address */
     trace_iommu_testdev_dma_write(s->dma_vaddr, s->dma_len);
 
     for (int i = 0; i < s->dma_len; i++) {
         /* Data is written in little-endian order */
-        write_buf[i] = (ITD_DMA_WRITE_VAL >> ((i % 4) * 8)) & 0xff;
+        write_buf[i] = (s->dma_write_val >> ((i % 4) * 8)) & 0xff;
     }
     write_res = dma_memory_write(as, s->dma_vaddr, write_buf,
                                  s->dma_len, attrs);
@@ -186,6 +188,9 @@ static uint64_t iommu_testdev_mmio_read(void *opaque, hwaddr addr,
     case ITD_REG_DMA_ATTRS:
         value = s->dma_attrs_cfg;
         break;
+    case ITD_REG_DMA_WRITE_VAL:
+        value = s->dma_write_val;
+        break;
     default:
         value = 0;
         break;
@@ -240,6 +245,9 @@ static void iommu_testdev_mmio_write(void *opaque, hwaddr addr, uint64_t val,
     case ITD_REG_DMA_ATTRS:
         s->dma_attrs_cfg = data;
         break;
+    case ITD_REG_DMA_WRITE_VAL:
+        s->dma_write_val = data;
+        break;
     default:
         break;
     }
@@ -263,6 +271,7 @@ static void iommu_testdev_realize(PCIDevice *pdev, Error **errp)
     s->dma_paddr = 0;
     s->dma_len = 0;
     s->dma_result = ITD_DMA_RESULT_IDLE;
+    s->dma_write_val = ITD_DMA_WRITE_VAL;
     s->dma_armed = false;
     s->dma_attrs_cfg = ITD_ATTRS_SET_SPACE(0, ITD_ATTRS_SPACE_NONSECURE);
     s->dma_as = pci_device_iommu_address_space(pdev);
@@ -280,6 +289,7 @@ static void iommu_testdev_reset(DeviceState *dev)
     s->dma_paddr = 0;
     s->dma_len = 0;
     s->dma_result = ITD_DMA_RESULT_IDLE;
+    s->dma_write_val = ITD_DMA_WRITE_VAL;
     s->dma_armed = false;
     s->dma_attrs_cfg = ITD_ATTRS_SET_SPACE(0, ITD_ATTRS_SPACE_NONSECURE);
 }
-- 
2.54.0


