Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6ADCCD183
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WSe-0006wG-OC; Thu, 02 Oct 2025 23:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WSc-0006vj-Km
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:27:58 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WSV-0001AI-66
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:27:58 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-32ed19ce5a3so1574151a91.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462061; x=1760066861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72uD3fuSOrRwGd0bi0oTLTeihEB7qSrLAvtmW/GYVLI=;
 b=IP9iRIWJdqEgRtklDeOIs0oYB7drjyvPe4TOHqG+uGa16FF/devJlwuL44izh5Kb5b
 SjR4+TwiLNLfLllPPQrO1Kt/z38ZyRd2drK5rIulK4OzPe1iouTlQKLysoinm+MAIyYd
 5HrCRKB+xZJkQOXxciEj3hPTgiPHkA7zcjfkP5FbOFohA4bncoq8SjbUSzlNSzAOlJt7
 gC6yArvMPg4RgWjM9X/uVJoEW4ENEfTPmnX1JXm97VlawQYNsx1g94DX6CLaNGEl+12r
 Hh9gJgwotC8uShxRADKkfLqBfAA8Xm5PdFboss0AB6o1Vv0IKYk5iohKjZ2tbP7DXI6P
 o4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462061; x=1760066861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=72uD3fuSOrRwGd0bi0oTLTeihEB7qSrLAvtmW/GYVLI=;
 b=t5TZMiC5VtuufSmLQnZZGH0ViueKPq49xYwnbM4+4T0OTf5p1EdbSvtNeEqCb0AF3n
 3MY5DDAeI+cvtiqZ87F9xbkLIQYuIDdQj53vFvbJFws0SnFC3IdAQOi5B3CqCyJXnXoE
 mklySgZXH638/s7JE7X6tF7SqQa1TWQ3UoXfzd1eaGM6KxdT/XIcn3aV3xC1iUzRo0cF
 X7BmfoV9UuPM1Jok7+/yi0kZKSzWpDUDLa5E8By7cHYLu00+b4RkvVglZ7Dv4v79Nija
 JsADELou9a7Nszs7Q2uz04lkS0aTXv7J5sW1ldkhygyVUIhuYyBtFfAJzM7J4b7DvZZx
 hfnA==
X-Gm-Message-State: AOJu0Yz2HjzJiYB92PqdHWnbwTGh/HkVZSbYfE3l/tYG1Xl7/21nMQ6A
 qvmyjSUOm5/beWVx9KTdzzjVnpbXQQGlEnIEJCyjdqu18UWL5FOZxjN+AkKKYQ==
X-Gm-Gg: ASbGncsOYZ0+DKdyiVJ+4nN53t3UfUqt3dgIMAXVSQS+94N94lzeyfA47BKbMwQ+gD5
 O9cNRF7OgPhDezC5U3jn7GY7Y3u8k5e0Y8uzv/SWw1Cs8tzplMSDSnTxjSa6KIicGr3EQdI+aWm
 UytenNndnzsSGrmy0Q0MAnzgkgcVW68tJlCq/nqpYueL+TagR7GBghU0RliSdmqMmvFgW2WnuvV
 CA+y+6RxjYdJCtFCNVoH64Ai2EAJwifp83OpLi3+FHShxf9cc8zLgEGESkhQSHZwB58veDzrGUM
 kDQNkzpT6fF4oREXgKhJSJxXCAPEUULtgnm8Ok1CQOQpKih4dZVoi4UVKg+o5kxqxxBbkVctNAP
 xssSmscIjlBVE0kUmox7uKYsCE/FY8J7G6LHe7ZLDqD37upEFpZF1EuxgGCEWCIL4Mok3DnPC1t
 +TvjwDSaesJ8hVrUljeH7dIGaBlwTGrwExvht7AwVR5FQou8za6qI40w4Ym61vyFw=
X-Google-Smtp-Source: AGHT+IGfO0dczdrRqfT7rXQGaL6tpIG+s+MFqgIT+Vm86F782hg0nxtLUOi9P23UTjQIYG0qUPdR2A==
X-Received: by 2002:a17:90b:3b41:b0:32d:dffc:7ad6 with SMTP id
 98e67ed59e1d1-339c27b94demr1785432a91.33.1759462060855; 
 Thu, 02 Oct 2025 20:27:40 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:27:33 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/26] hw/riscv/riscv-iommu: Fix MSI table size limit
Date: Fri,  3 Oct 2025 13:26:53 +1000
Message-ID: <20251003032718.1324734-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Andrew Jones <ajones@ventanamicro.com>

The MSI table is not limited to 4k. The only constraint the table has
is that its base address must be aligned to its size, ensuring no
offsets of the table size will overrun when added to the base address
(see "8.5. MSI page tables" of the AIA spec).

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250904132723.614507-2-ajones@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 96a7fbdefc..155190d032 100644
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
+    offset = intn * sizeof(pte);
+
+    /* fetch MSI PTE */
+    addr = PPN_PHYS(get_field(ctx->msiptp, RISCV_IOMMU_DC_MSIPTP_PPN));
+    if (addr & offset) {
         /* Interrupt file number out of range */
         res = MEMTX_ACCESS_ERROR;
         cause = RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
         goto err;
     }
 
-    /* fetch MSI PTE */
-    addr = PPN_PHYS(get_field(ctx->msiptp, RISCV_IOMMU_DC_MSIPTP_PPN));
-    addr = addr | (intn * sizeof(pte));
+    addr |= offset;
     res = dma_memory_read(s->target_as, addr, &pte, sizeof(pte),
             MEMTXATTRS_UNSPECIFIED);
     if (res != MEMTX_OK) {
-- 
2.51.0


