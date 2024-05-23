Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FA7C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 17:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sACQr-0000eJ-TG; Thu, 23 May 2024 13:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sACQa-0000bu-Q3
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:40:34 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sACQV-0001Vt-Ak
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:40:30 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f3406f225bso6930285ad.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 10:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716486023; x=1717090823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfuqroyjI8kqLzWg0XJqI6RuWQT/noyUzD/FR5+TOHo=;
 b=KOQlfSTHI+TTbVhX20KHYGwZpXV+pPTpydB4TRl8VnCm4J3TLcyRGzYRuPDJQOzz35
 2sU1T7nGvJMSBzL0kC7qeJqAy813ctSb4SpSIxExtpGw6iH+ri9ZI1YUStLW/xAHmb5O
 zlsQkFEeH2c5AiQyeEeIjtOzsCi4Oxb2g9aznsXZVT63moxsT55BvfYlbrBLaorWhCq3
 cEbsBuDW27WRWbakB8YUzFg5i/BsUSgC5hRqqBcpVxSgMvJ1bofJ0zTRPrS+xZB+HxOi
 0O1FySyOh+fUhF6wjPtI/rQnz+U1A49IRx+7RvCPfxMDhEv+CbdHo9NojWYM6CWblTvT
 ZycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716486023; x=1717090823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vfuqroyjI8kqLzWg0XJqI6RuWQT/noyUzD/FR5+TOHo=;
 b=tkdtEjQn72lmSL0qdRMcl89CHZNrqbgxSVVR37dx1gH7rz++iZPwo9M8yWOB8v4dBA
 oVW3YOxYAjNpI6QX9oE9TMmZhxMcEBSFaGHnmXwIH4yuWC90bVjJm7VGHlHIveOtuqms
 3PeqgTR4rhfA/G5rCh1TkB5SEnh6cFibB8Ys6NwHXavIinlXJa368KyDHgsw/cZGV3u1
 hkIfwr8hBvM8PVgKPDpcYq9zzAbEmfNIdG4ky1ZSBCXNdjM+wPlUAe3+J7pv3nxn+IzF
 rYDJcR9p/CAeDT8igDAFkZuPD+ZQNooxBM2PvWOJBCY7s2bySBcmEMA3EBWy44PHHmxF
 /ZyQ==
X-Gm-Message-State: AOJu0Yxe+q3+V+mbTkNkqXJiVc1px/6uNmqzYDCIIm0Mup+nWiEoxqpV
 FFPSFKIUoJ/qUnS5E8KT9GnIamOJ1Ratb1bioLYXZI233h0mB/I2cKkFHtrDpC8KJTZL0dw0Vzm
 w
X-Google-Smtp-Source: AGHT+IF4ewjc0Om3+9EPP2JQkQWjCxP7kgxh55lrMk/F7fFCLkjngLJOgImWfK/h/yIclhm8VuluhA==
X-Received: by 2002:a17:903:41ce:b0:1f2:f26f:268f with SMTP id
 d9443c01a7336-1f44873bf34mr395215ad.20.1716486023198; 
 Thu, 23 May 2024 10:40:23 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.42.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f2fb4ca0ebsm81246535ad.119.2024.05.23.10.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 10:40:22 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 tjeznach@rivosinc.com, ajones@ventanamicro.com, frank.chang@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 04/13] pci-ids.rst: add Red Hat pci-id for RISC-V IOMMU
 device
Date: Thu, 23 May 2024 14:39:45 -0300
Message-ID: <20240523173955.1940072-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
References: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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

The RISC-V IOMMU PCI device we're going to add next is a reference
implementation of the riscv-iommu spec [1], which predicts that the
IOMMU can be implemented as a PCIe device.

However, RISC-V International (RVI), the entity that ratified the
riscv-iommu spec, didn't bother assigning a PCI ID for this IOMMU PCIe
implementation that the spec predicts. This puts us in an uncommon
situation because we want to add the reference IOMMU PCIe implementation
but we don't have a PCI ID for it.

Given that RVI doesn't provide a PCI ID for it we reached out to Red Hat
and Gerd Hoffman, and they were kind enough to give us a PCI ID for the
RISC-V IOMMU PCI reference device.

Thanks Red Hat and Gerd for this RISC-V IOMMU PCIe device ID.

[1] https://github.com/riscv-non-isa/riscv-iommu/releases/tag/v1.0.0

Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 docs/specs/pci-ids.rst | 2 ++
 include/hw/pci/pci.h   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index c0a3dec2e7..a89a9d0939 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -94,6 +94,8 @@ PCI devices (other than virtio):
   PCI ACPI ERST device (``-device acpi-erst``)
 1b36:0013
   PCI UFS device (``-device ufs``)
+1b36:0014
+  PCI RISC-V IOMMU device
 
 All these devices are documented in :doc:`index`.
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index eaa3fc99d8..462aed1503 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -115,6 +115,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_REDHAT_PVPANIC     0x0011
 #define PCI_DEVICE_ID_REDHAT_ACPI_ERST   0x0012
 #define PCI_DEVICE_ID_REDHAT_UFS         0x0013
+#define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
 
 #define FMT_PCIBUS                      PRIx64
-- 
2.44.0


