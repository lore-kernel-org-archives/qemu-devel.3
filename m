Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5706CA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 13:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuA06-00017y-EL; Thu, 04 Sep 2025 09:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uuA03-00017V-6m
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 09:27:39 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uu9zs-0004GD-DB
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 09:27:38 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3f663c57226so5125305ab.2
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 06:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1756992445; x=1757597245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g+Z6by8yj153dStYnaj/Rum+7G7Oqf9yATcM8/24AcA=;
 b=Ghq6kNxfU1szQUulPI4Qg1CAl84Vtl/ntfEQWUwN0Evd/CJL+8caSSJq5A7KzOjrWa
 H+ySBZm0Z+ZIGds+K5Z1fjCSpcC0Yi+HTmu6fAy5DPSw3J1mU7Cc6AQEzyL/pxuu0XFV
 CcQg7EkWEhDw2ssUfzozds7ss1yew5ZrYZ3bsaCfNJqfpEJVXfLhDyEGL27ErE5aFO6L
 rWlhxGluBRXKQzeYX5Q7FD2/6DWXlXCDx/C3f1cRvaTsSKgh1C+RCVk5Elaxi1MTg33h
 Y5D/oMcrW9lALKu8XEIlYKoOOcgp+Fh4DghWktUTGDNDDaGzgoUZGErv+3xWT0VZf51n
 42ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756992445; x=1757597245;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g+Z6by8yj153dStYnaj/Rum+7G7Oqf9yATcM8/24AcA=;
 b=Merhm6vMRLq4QagvaflctcpB82mj/I5cBfsjTR0oFTgY8I9/fK/FqAmS2lHhcLbOUk
 eSAGA4lQYRi36Ip5XD/zbMxvnDp61C+tMuxK9umVX7YEIb/Y55flRWeu2GaJro3bkBBi
 A+iRAFHCVcHn2ywv3hE+JFyRTYQSngVJtujDbG2cYeSIOVh/ZbbjSFtLp2BkoGIR3jU1
 bmetJFiBdu7Qp8Npu4Z5i79e2yjYojEf+ai7ISS93OrBZmC6UPucKMSvtFkngiRdCXZq
 cOsgHVbohs8UMwQHlGSZEbhNnW8wRm0l/2P5AB2tr8Afh+tIqLWNGZi2gmcp0GZxZw1u
 c9aw==
X-Gm-Message-State: AOJu0YyHLiQ87n/jx0l8RHVhSTQuilE+99gl8hVDKm9+QdLvcGNdxLYz
 m2o2S/grK1vL78nWRBZj/Kqr7QnqALmGDY0D7gENYnQYrjqWU23ynTyLN/yDx7pjTYU4QLyG7SL
 OTQFpIJY=
X-Gm-Gg: ASbGnctLSFi5bg31rRh3gM4TSgLZu3kZPXuVxsTWrxHflGD9KpJTvo/yn4V3+Yzos40
 7DYIo1/SIhDh4pN3JIT+eYWhs94ilSF6OC42H4b/vs1zLVExSlA141RXE//F13MDp/sZlRcq/bq
 EnaRXQSQqMWAiwatFmgFhFVqgBdDcGjXv/xvqrbyJItjDK1qEyMKdcuzfz5yD1Hba3MS4zBhDo4
 ijZq7vF/BpZ4IXSgvfvUlZtcBc2GJZAcgWfAX19Q4Q88CX7QvqJYtaTNAUnLvwCNPFo2CBShErF
 s7DwTWV+2JiCZKvJ3sNGWaBaPrpLvpRZk01DIKajYXk3LInk5frJN5CHL5Pgdw3SivpYjw+3XzL
 u6xcTPRE1sjz3cBZeF+VXS5OUl5rI+nE1pfU=
X-Google-Smtp-Source: AGHT+IHeetYnpOzcl8+XrEPSiIS2VwZYvR6BTeXnZz8w/uHdiBgapf7uUhLxAXbewd882R8wqoZZ1w==
X-Received: by 2002:a05:6e02:4614:b0:3f6:546b:5c9a with SMTP id
 e9e14a558f8ab-3f6546b5d53mr152829605ab.19.1756992444706; 
 Thu, 04 Sep 2025 06:27:24 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5104c5a4d0dsm679121173.0.2025.09.04.06.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 06:27:24 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: alistair.francis@wdc.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, tjeznach@rivosinc.com
Subject: [PATCH] hw/riscv/riscv-iommu: Fix MSI table size limit
Date: Thu,  4 Sep 2025 08:27:24 -0500
Message-ID: <20250904132723.614507-2-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=ajones@ventanamicro.com; helo=mail-il1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The MSI table is not limited to 4k. The only constraint the table has
is that its base address must be aligned to its size, ensuring no
offsets of the table size will overrun when added to the base address
(see "8.5. MSI page tables" of the AIA spec).

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 hw/riscv/riscv-iommu.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 96a7fbdefcf3..155190d032dd 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -558,6 +558,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
     MemTxResult res;
     dma_addr_t addr;
     uint64_t intn;
+    size_t offset;
     uint32_t n190;
     uint64_t pte[2];
     int fault_type = RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
@@ -565,16 +566,18 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
 
     /* Interrupt File Number */
     intn = riscv_iommu_pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
-    if (intn >= 256) {
-        /* Interrupt file number out of range */
-        res = MEMTX_ACCESS_ERROR;
-        cause = RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
-        goto err;
-    }
+    offset = intn * sizeof(pte);
 
     /* fetch MSI PTE */
     addr = PPN_PHYS(get_field(ctx->msiptp, RISCV_IOMMU_DC_MSIPTP_PPN));
-    addr = addr | (intn * sizeof(pte));
+    if (addr & offset) {
+        /* Interrupt file number out of range */
+        res = MEMTX_ACCESS_ERROR;
+        cause = RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
+        goto err;
+    }
+
+    addr |= offset;
     res = dma_memory_read(s->target_as, addr, &pte, sizeof(pte),
             MEMTXATTRS_UNSPECIFIED);
     if (res != MEMTX_OK) {
-- 
2.49.0


