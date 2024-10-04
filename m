Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2000CF884F
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swkgr-0007QH-Rc; Fri, 04 Oct 2024 11:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1swkgc-0007Ju-QQ
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 11:57:47 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1swkgb-0000pK-3o
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 11:57:46 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20aff65aa37so19882365ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1728057462; x=1728662262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2FlkjWOEsjJoMDEMxy5fL2jBzz/PnyJOUhMSZO37LI=;
 b=mvrNllORShdYyXLRPmUrTJZJZgydZTdaWSsU5V6tXjCmOU4ERTlbXdqL4GV7pllPJ3
 TFltL173UMCctJb+6zLhfJJDD/uRwhhUJbXtgIoDstL/5C1ufQOnl7PdwQEkehgwEgGy
 7XECyt93HZVY+Y4XBfboxbQCe8m2CfQddJ9RXkKe3qN+kcjd7fxTDjrx827DV+DlCaO/
 OiEgjB+aEYZvcrbYyeYoHbU4rNr7CXlZGLN9OCEEg/8Cahr7VUc/JI47ddWBAlXVpk3W
 vblSQJrV60yCf7HBl0E00fgWhNjsv/CRRlAkVYujfhCWdXm9JxPaJAtwtOfGyIsPFjrz
 SmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728057462; x=1728662262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N2FlkjWOEsjJoMDEMxy5fL2jBzz/PnyJOUhMSZO37LI=;
 b=Zs8aL1SMVxqgCS4cQvE+hCJibfM65ObpuA3k3OWuJ7mrDgUO3Cn2JjQj+tgWgMzTl6
 MP48Tj+P8NnCGJow9xGLLxL/ckc3d9r49MlICIj7igIE88KV93+GH8uVwyQNqrq1xRD3
 rOEfHLkIg557ZxsaBmHP1v52CdzQd6met1K6+R3j9Q0WdyMUEx6wFQhxxZGvlemoJ8xf
 XhAxYSnNEncBxdZdOWbcng2RL5L1ndlYd2zAr6MRgm6hLS/3AFhziqF05nWpwUVu/0PZ
 b6YLYFDfGKsubJaU15vfMLrkWokwaEZ7WPlpbjqXe2vJdDdv5+XeS+XLQz3AMWBQ/Tkt
 KIeg==
X-Gm-Message-State: AOJu0YwnMWLDNZMdogjYZRl5D0gfsVWBoquTZYy80cSN+z7ri62JvARG
 wuc0XVARQMLExBmXRZJIQUgvNwKUcfs45zGK5deSPvN23am1nbP+k0f+wEohgDRIGhFHg0C7XFn
 J
X-Google-Smtp-Source: AGHT+IFNxKt/mxhnpxHWNPGozqRHQC66TlsZb+zmFsNv8JUjfDtP5t1bC5Z7U7S2jFpAgygeG3mQVA==
X-Received: by 2002:a17:902:c949:b0:204:e4c9:ce91 with SMTP id
 d9443c01a7336-20bfde55489mr51181145ad.7.1728057462602; 
 Fri, 04 Oct 2024 08:57:42 -0700 (PDT)
Received: from grind.. (200-206-229-93.dsl.telesp.net.br. [200.206.229.93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c139306cfsm107635ad.170.2024.10.04.08.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 08:57:42 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v9 04/12] pci-ids.rst: add Red Hat pci-id for RISC-V IOMMU
 device
Date: Fri,  4 Oct 2024 12:57:11 -0300
Message-ID: <20241004155721.2154626-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004155721.2154626-1-dbarboza@ventanamicro.com>
References: <20241004155721.2154626-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/specs/pci-ids.rst | 2 ++
 include/hw/pci/pci.h   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index 328ab31fe8..261b0f359f 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -98,6 +98,8 @@ PCI devices (other than virtio):
   PCI ACPI ERST device (``-device acpi-erst``)
 1b36:0013
   PCI UFS device (``-device ufs``)
+1b36:0014
+  PCI RISC-V IOMMU device
 
 All these devices are documented in :doc:`index`.
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index eb26cac810..35d4fe0bbf 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -116,6 +116,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_REDHAT_PVPANIC     0x0011
 #define PCI_DEVICE_ID_REDHAT_ACPI_ERST   0x0012
 #define PCI_DEVICE_ID_REDHAT_UFS         0x0013
+#define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
 
 #define FMT_PCIBUS                      PRIx64
-- 
2.45.2


