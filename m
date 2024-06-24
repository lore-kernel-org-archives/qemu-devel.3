Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2360C3DA41
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 20:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLq9X-00048j-9Y; Mon, 24 Jun 2024 16:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sLq9V-00047m-LB
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 16:19:01 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sLq9T-0003eE-QP
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 16:19:01 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70666ac8f81so1744276b3a.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 13:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719260338; x=1719865138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNa3n4bgAekuCO/Q6xFOqGs2ABaEP8YYnmltDplZHQ8=;
 b=BMvf1H/1cSdzhBYU5IRkE48T/3K8ahTzTAieogCSiDrCIhCgdwZ/lg/pp0Jsd5oIsd
 t1Q9wTMhXE2v/X98cS1wvnTFePX/YEPGbBxPmY+ycyYO7rdQ1ILpVXTdaTj0ovWztavE
 n0XT6v68FiPnzQVnc1OclVKoRjx5tIlmVXpJ3ObyajgUxGb8oshvSUbpdqqUR+HbakRA
 byatEhyLWtm8l8+h+wsUZwP59RkJIJG0ScvIEeSW5bQ767Xw6FpwOYAvR7jP4QLWMcIv
 +RI7pP+vN7X+doZjNNHNuvRLCp0OrzaVWqK2+qz9AasC4XfORh5d4CYeJyHqTnvF6Cwx
 SOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719260338; x=1719865138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mNa3n4bgAekuCO/Q6xFOqGs2ABaEP8YYnmltDplZHQ8=;
 b=o72h0c/DlLi9XhZ91ezT3wdHb/bOOmpd6ngejm2Djn9RFjJIO65dD5abiBmWeUhXzV
 g7QpjIY1YbaPTd8YH2igAmXWvTFz+GElMkgYr9jJlM3Cxj5ujrF5gO0hZes40TFmmZOm
 21OzH0ok1+oMbliDm0U7j97JKvfcbycB4/7tMaL91hXv+jCBk6P/GouaWXOAMpTjvvuH
 UHWEVkbqT/YAt6DXnIAt3KPTIDZ2m4iIANHR09GulBx1G38IPAu3lzLmlHPcqkTTHkzy
 1ECwBV4Y2K4bv0lI3xiQY78t/2qkYld+seVphG2VdUxMal8bMIgp7e7VHEyK3MzeSAow
 cjrw==
X-Gm-Message-State: AOJu0Yy0R5AhK/vIS2REK4rU6xmTqGVT78SFWcBsTcFC8h4bN9FVNWN5
 LNmwdfIe+HPACGf+/tfCUh9xAVYCcKsNsSUoB0QuYPbfDqgnqzBSq/l5fqSPwlUjfG6vKGknHwS
 r
X-Google-Smtp-Source: AGHT+IHl1TIR8u5e6ne9q57TMBYSMg9ZD+fLt3/Ihod2KTOHgxNW3ObhoDmkPhsdZ0BKa/bT+ZN1yw==
X-Received: by 2002:a05:6a20:6720:b0:1b5:ee66:a55 with SMTP id
 adf61e73a8af0-1bd13bdeb6dmr1979740637.16.1719260338057; 
 Mon, 24 Jun 2024 13:18:58 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc0:1aea:63a7:288e:eb77:fe54])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70688f2d76bsm1927091b3a.41.2024.06.24.13.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 13:18:57 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com, frank.chang@sifive.com,
 jason.chien@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 04/14] pci-ids.rst: add Red Hat pci-id for RISC-V IOMMU
 device
Date: Mon, 24 Jun 2024 17:18:14 -0300
Message-ID: <20240624201825.1054980-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
References: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42d.google.com
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
2.45.2


