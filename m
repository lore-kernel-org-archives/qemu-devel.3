Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFE4C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGrsh-0002f3-5A; Mon, 19 May 2025 00:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmR-0004ic-AL
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:12 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmP-00044Y-GG
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:07:10 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22d95f0dda4so42457195ad.2
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627628; x=1748232428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P6JJI4ooRSsyyt0Tzy9/ReM0MFaAWn7bzyEKD90/3cI=;
 b=HGYIpp9K2gJmAOBmFPurbtoHSI7eJmYSbscf/wrUX9h5kmnrueeUAloMrbv/mjyzu9
 4ZGrIHprRgHfsLrg+XIQ7p5P1sWiep/E8WT3mITtdeoRUdMVLo1qEevIzxD0f7pT6+CI
 +Bof+aU1Tu2RaFXX+1N32OEmaCgzr5FJRNzIqL/L20eb8PRXAwl8glq4skRuhasz2jjx
 G1w1Zt088PGuafRJ6Gal7EMrAXnTfgwAVcY6HwbwRxM3wXXRC1No03BJJMV86gwgce5D
 Eiv0Vub29KJa7f5GQ1qzrQmSzyNiSGuHngl1XHIsztUkPKtX3Nlsbxta9WSncUwT9eJ0
 co6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627628; x=1748232428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P6JJI4ooRSsyyt0Tzy9/ReM0MFaAWn7bzyEKD90/3cI=;
 b=khxbwO1Ok8G6calV4bV6S2uKPdFDk6LagEav/BtqZyZty0pJLeRj3CSJcjG7h8Y0Tk
 4zHUCcclKSUBaU9JpFJKfL88NWvjGW42GH0MbbrFi0yBiYiFY5pqUZGeAAE+Os/kQxTg
 Ia4XHqU+vnA/yU+BtrUjoNL/toLJ0EtLN0sIKFeo3w58JaD0PKguA04OBXQYYPiCQp3F
 n+Zjk1L8G9QAcMInKyKevvoTd2FLt9gJ9G8bDKmXBLsuxK5KzLtkjrdiM0Qm9Y4uXoBs
 htiKMAIHo7uv1BNAXjsCo1AqgaNiVIGI2mpMIocZzS2ekSyU5jwIbZo4T5lgeKzyP57K
 xdGw==
X-Gm-Message-State: AOJu0YwIwsRfVEVuT+qewTS8cjIHA+MHzCalwtoFjNDSqD9n+q4Ub2EE
 HYn/yTV3+6Pam9CBtT8bLI5OvAa3hKwWk5vgoOG/Ey3hZk8H4zboigLLOEuTFg==
X-Gm-Gg: ASbGncvfQtmp5VbQvhOT46GT58EO/20O6wcG+y/C+AS98oR1+byqxnHcnaaQnd4k2ik
 Wrsd35yTZHgBTXhOXNELteEFZkCGpbnxv22Q/axF8fovzAG8aaVEpw6AvH3OaMVqKWN+7QMiuUr
 vrINbyjW7HBoPrTjO0qbnaLoOp7WEdRbmVhcF7cfcdsqgVWSVHqG8KxCRJjsKKFK5pAvoFujXkV
 orQdLPAaau+qmXJNJMM5zO8qsrF9mia6ep2xuhmPN3COtZbkTLeHE4U1c35Uk1QNiFuWfZa+QiC
 egWmMLtSv+elZ/vALa8mQnhhRUPcg0sa+DVpu/mFRPijsvSVwUAGimDWJ/rE5GzDHP+SRD3n1G4
 gJGjdn27YYjNKrhCQI9jRMS09fIobYxMgOLdp2GDSF7OZBWYFm1XU7/eL
X-Google-Smtp-Source: AGHT+IErVI4K+2Cd8mxzRbdmrQiEi0kY9smnHcILaZWoMLm3FCyJ9HMO6fQCZ2gDTDmYvX7tE3dmvQ==
X-Received: by 2002:a17:903:19c4:b0:224:1935:d9a3 with SMTP id
 d9443c01a7336-231d4512038mr186516095ad.21.1747627627602; 
 Sun, 18 May 2025 21:07:07 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:07:06 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sunil V L <sunilvl@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/56] hw/riscv/virt: Add the BDF of IOMMU to RISCVVirtState
 structure
Date: Mon, 19 May 2025 14:04:58 +1000
Message-ID: <20250519040555.3797167-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
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

From: Sunil V L <sunilvl@ventanamicro.com>

When the IOMMU is implemented as a PCI device, its BDF is created
locally in virt.c. However, the same BDF is also required in
virt-acpi-build.c to support ACPI. Therefore, make this information part
of the global RISCVVirtState structure so that it can be accessed
outside of virt.c as well.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250322043139.2003479-2-sunilvl@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/virt.h | 1 +
 hw/riscv/virt.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 48a14bea2e..7b4c2c8b7d 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -63,6 +63,7 @@ struct RISCVVirtState {
     const MemMapEntry *memmap;
     struct GPEXHost *gpex_host;
     OnOffAuto iommu_sys;
+    uint16_t pci_iommu_bdf;
 };
 
 enum {
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index be1bf0f646..5958ad1f7d 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1117,6 +1117,7 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
     qemu_fdt_setprop_cells(fdt, pci_node, "iommu-map",
                            0, iommu_phandle, 0, bdf,
                            bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf);
+    s->pci_iommu_bdf = bdf;
 }
 
 static void finalize_fdt(RISCVVirtState *s)
-- 
2.49.0


