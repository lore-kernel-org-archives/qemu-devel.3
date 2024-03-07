Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA42C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 16:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riGED-0005YJ-3o; Thu, 07 Mar 2024 11:04:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riGEC-0005Xg-3l
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:04:16 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riGE8-0006Og-2J
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:04:15 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e5a50d91b4so1013983b3a.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 08:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709827450; x=1710432250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1npuklC5aEdofdL53vX8HPX3oehGBOj2ZxbYnQl0d8Q=;
 b=Pyqq9zWtMdCk1VDDJPLavCkH1c6y5+UQ1ZR6l2rkyiDVFsgGVwdrCJG2alEip09aij
 OLYlJOMrcNNGXJhqjyDmoXuJZ2CbVs9l0X1ltnwxKFQAGiia7i9lkS0FRUy9gbQ+mHqm
 XPDaa2nRwGKGX2cPd+niNdqHcFNumhYGxSAS8YBaQsp9ttmkZlXW4XMmgb1FDSN9eQRu
 meJpIa6Ohw+GGLx6FNeJq/gghRp97+jKWZqhDiqiQSJj5MWO3SlEtKaUSrT1twPeFOAl
 LZ2keX5hJLlH38ViMWQ7NkO7kglddKEXhyNkXxpjoKDddcNyR9CuyZt6XK8iivp5Vnu9
 /LAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709827450; x=1710432250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1npuklC5aEdofdL53vX8HPX3oehGBOj2ZxbYnQl0d8Q=;
 b=od6M3NjuHUzFOGWKG9+Jo/icyhoM6uB0Q/yaMa1iSsWdvoGyCUMdQ9xH5QxkLvdYxX
 5zwTUwVyPZOibWgeO8usIHcgKtyzCWZaTnTvItdYSc5Vng/1JbI0gJGO3Las6WwtLjo+
 Yohuq+93rNRexM6XZMdx+E6OuWJD3lTBHozRGBIz9jXd/Nt4HJvOaVyybw4SAZoiib94
 f9zM3iPlhKAVN9GM/unxFTelDTMaW8U3OgEsOcq2oWxbh0lvLRQVlyu8GUuTkTf4Kh1g
 jvHm4L0fdx8Zhaf04CCdfQo3fZtZsO3ebYo0qM+befyIURlBac+w0THAmvOyy0aO43pZ
 NU8A==
X-Gm-Message-State: AOJu0YwZriKuyifYAvXQVMovljspFvPoxgvU2OobO0AH9m5RJeaGZvYc
 esFPGyzmQeczl6BcflVT5YK4rlb/5TLaVfMS7uIAEAfOD02sJxWI5EQ/+f0rhY1RR1vrcA/Wx+s
 Y
X-Google-Smtp-Source: AGHT+IFtgKfyaxfyOJhkGgUbmZHlfgDqHWUnUT/+OPQg/MXRVIEzsTIWLe1v2YTY2LKJT94wP814Zg==
X-Received: by 2002:a17:902:f552:b0:1dd:6092:743f with SMTP id
 h18-20020a170902f55200b001dd6092743fmr1264098plf.56.1709827450058; 
 Thu, 07 Mar 2024 08:04:10 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a170903124b00b001db2b8b2da7sm14663136plh.122.2024.03.07.08.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 08:04:09 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 12/15] hw/riscv/riscv-iommu: Add another irq for mrif
 notifications
Date: Thu,  7 Mar 2024 13:03:15 -0300
Message-ID: <20240307160319.675044-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307160319.675044-1-dbarboza@ventanamicro.com>
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Andrew Jones <ajones@ventanamicro.com>

And add mrif notification trace.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/riscv-iommu-pci.c | 2 +-
 hw/riscv/riscv-iommu.c     | 1 +
 hw/riscv/trace-events      | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
index 4eb1057210..8a7b71166c 100644
--- a/hw/riscv/riscv-iommu-pci.c
+++ b/hw/riscv/riscv-iommu-pci.c
@@ -78,7 +78,7 @@ static void riscv_iommu_pci_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
                      PCI_BASE_ADDRESS_MEM_TYPE_64, &s->bar0);
 
-    int ret = msix_init(dev, RISCV_IOMMU_INTR_COUNT,
+    int ret = msix_init(dev, RISCV_IOMMU_INTR_COUNT + 1,
                         &s->bar0, 0, RISCV_IOMMU_REG_MSI_CONFIG,
                         &s->bar0, 0, RISCV_IOMMU_REG_MSI_CONFIG + 256, 0, &err);
 
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 1fa1286d07..954a6892c2 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -543,6 +543,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
     if (res != MEMTX_OK) {
         return res;
     }
+    trace_riscv_iommu_mrif_notification(s->parent_obj.id, n190, addr);
 
     return MEMTX_OK;
 }
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index 4b486b6420..d69719a27a 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -6,6 +6,7 @@ riscv_iommu_flt(const char *id, unsigned b, unsigned d, unsigned f, uint64_t rea
 riscv_iommu_pri(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova) "%s: page request %04x:%02x.%u iova: 0x%"PRIx64
 riscv_iommu_dma(const char *id, unsigned b, unsigned d, unsigned f, unsigned pasid, const char *dir, uint64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u #%u %s 0x%"PRIx64" -> 0x%"PRIx64
 riscv_iommu_msi(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova, uint64_t phys) "%s: translate %04x:%02x.%u MSI 0x%"PRIx64" -> 0x%"PRIx64
+riscv_iommu_mrif_notification(const char *id, uint32_t nid, uint64_t phys) "%s: sent MRIF notification 0x%x to 0x%"PRIx64
 riscv_iommu_cmd(const char *id, uint64_t l, uint64_t u) "%s: command 0x%"PRIx64" 0x%"PRIx64
 riscv_iommu_notifier_add(const char *id) "%s: dev-iotlb notifier added"
 riscv_iommu_notifier_del(const char *id) "%s: dev-iotlb notifier removed"
-- 
2.43.2


