Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08028E7718C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 01:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSEJ-0005wR-H4; Thu, 19 Dec 2024 20:55:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEH-0005vT-PK
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:01 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEG-0004BV-7i
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:01 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7fc88476a02so1109104a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659697; x=1735264497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gPuLbZvSp6+8tc9tl8q4PUHJAk1piLXuGGcNU0EdvfA=;
 b=fUqZDbFSxK2TtHtpjVV/gluN/I1E1Jm5xhUeiZcsJNHYnkOl1lLRCuO2FZcOwP5J2u
 wwI1L6NGH0tpmBYqLghdqti8dMZL6+Ncl/Km0yZJwl3j/HMOniuN4fatsndTdbz53wAK
 WvSemcaffBIVCHIdHc/4TffhGJ5G0xb5gTMFuBETMWgIXh/R0lMKJsTiPnQoMKG9LLVH
 MSOrNFzMq8831dxrZTecuGT9qE2wS10C7Xe+Tm/gzmomVN0507tLo6mWZi2cY65uirNb
 o/JGT/dHPSUxQxZtHGP2HZoPaYtXw6z8C3/bc0GzqMZyu/qnq2hi9oYTqIQgxA0gVWPd
 U7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659697; x=1735264497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gPuLbZvSp6+8tc9tl8q4PUHJAk1piLXuGGcNU0EdvfA=;
 b=Lp3XmMt+bIqzjN4bvItR4YfCpKxjJuy/giYpl83BErJdLgYVI4OOs/voZf2MunAJwk
 nO0MVUvEd/9Xaa/q33jJMgNdpbOgslgtAXWMNiOCGVjp3sJ+iMmAJ/4HxuzYnqjGWqTy
 gkw7fnv0CwhDftSz2JKEFyRtyWEMx6BK17rYSbR0qsi+YMnjhSvWIndPassXd2Fu9BPb
 q1j4QZUYPjhBBJKj7pADA1n0Tn6zmR+RKaTgJMDWMsihuq5o/RHXsOcz4vwaCDGDNSmZ
 S2MKPXC6wANyoKCVq2IVDKoOH52vNnfqJFao0BlI54pN7wxR/eW4LItppzJZUPP1+pxv
 GQ0w==
X-Gm-Message-State: AOJu0YyhsfplS+Ep3qArN31xpOSNxC8f6UXnMZkEl+xMpHF2USD9p4yB
 MPeHZheJjnAVhrGXRy5ZdHYhwxYQVzBU8YBByEG5AtntT2fbjp1RUlIpS9KV
X-Gm-Gg: ASbGncug3cF12sGkjQQenI2ksGaZdmzUXg83x3b5XsyVgQeQRKR1GmQQCSYWoV7DuC3
 BXc0bzbtiOHUmDCpLMNMb4XA23TN/ATM7xZeK0jldiHjR0tYpIYk9jYHhxWiDxr9QC3UyJIL+iG
 fE8QAJaGjeaoaQ4Fy6C3xTUxuxve1xxxGyhQhyDpLai56vuFdwsknd9Sv7DWDltJEpPW38rg44q
 1VA93GiNdXjdKXkOsTa9MPUhDtn5T3TXZGqCA1K58QZZ8H136ZKlOEYIJ8TPCkF6yLELGRky6kw
 AtCIvxeLB5v4uLRBJEkl9PfJP7UWZV1fgr5wQQ+X5paq1q3bVcW4CH7TlmnYmY0=
X-Google-Smtp-Source: AGHT+IGJ4m6qftyu9+sZIxmE0dWWZPlgSNn93hOfNyjgrMw9KGcq17kLjqEp/in2EQNYorp2DQvdYw==
X-Received: by 2002:a05:6a20:2d07:b0:1e1:b44f:cff1 with SMTP id
 adf61e73a8af0-1e5e07f9c06mr2050865637.33.1734659697423; 
 Thu, 19 Dec 2024 17:54:57 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:54:56 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jason Chien <jason.chien@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 01/39] hw/riscv/riscv-iommu.c: Correct the validness check
 of iova
Date: Fri, 20 Dec 2024 11:54:01 +1000
Message-ID: <20241220015441.317236-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52f.google.com
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

From: Jason Chien <jason.chien@sifive.com>

From RISCV IOMMU spec section 2.1.3:
When SXL is 1, the following rules apply:
- If the first-stage is not Bare, then a page fault corresponding to the
original access type occurs if the IOVA has bits beyond bit 31 set to 1.
- If the second-stage is not Bare, then a guest page fault corresponding
to the original access type occurs if the incoming GPA has bits beyond bit
33 set to 1.

From RISCV IOMMU spec section 2.3 step 17:
Use the process specified in Section "Two-Stage Address Translation" of
the RISC-V Privileged specification to determine the GPA accessed by the
transaction.

From RISCV IOMMU spec section 2.3 step 19:
Use the second-stage address translation process specified in Section
"Two-Stage Address Translation" of the RISC-V Privileged specification
to translate the GPA A to determine the SPA accessed by the transaction.

This commit adds the iova check with the following rules:
- For Sv32, Sv32x4, Sv39x4, Sv48x4 and Sv57x4, the iova must be zero
extended.
- For Sv39, Sv48 and Sv57, the iova must be signed extended with most
significant bit.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20241114065617.25133-1-jason.chien@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 07fed36986..b6b9477129 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -392,9 +392,26 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
 
         /* Address range check before first level lookup */
         if (!sc[pass].step) {
-            const uint64_t va_mask = (1ULL << (va_skip + va_bits)) - 1;
-            if ((addr & va_mask) != addr) {
-                return RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED;
+            const uint64_t va_len = va_skip + va_bits;
+            const uint64_t va_mask = (1ULL << va_len) - 1;
+
+            if (pass == S_STAGE && va_len > 32) {
+                target_ulong mask, masked_msbs;
+
+                mask = (1L << (TARGET_LONG_BITS - (va_len - 1))) - 1;
+                masked_msbs = (addr >> (va_len - 1)) & mask;
+
+                if (masked_msbs != 0 && masked_msbs != mask) {
+                    return (iotlb->perm & IOMMU_WO) ?
+                                RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S :
+                                RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S;
+                }
+            } else {
+                if ((addr & va_mask) != addr) {
+                    return (iotlb->perm & IOMMU_WO) ?
+                                RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
+                                RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS;
+                }
             }
         }
 
-- 
2.47.1


