Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDAFE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2Ym-00030m-Fr; Wed, 18 Dec 2024 17:30:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Yi-000300-6v
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:24 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Yf-0001x5-M4
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:23 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2165448243fso2029045ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561020; x=1735165820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gPuLbZvSp6+8tc9tl8q4PUHJAk1piLXuGGcNU0EdvfA=;
 b=nj4BlUmAMPDjIvSA1JnxqxcsoBSSxzNesaKXZ0iJWZYL1fe2UAdBdQQI9FF7Ti285s
 jqGTlFgmjQZExegS6CRbE9rYR5CfzhtiTTv68x6RcKZ+QXMuEzObwJD7HIhGY2s2SA9e
 CfFSfVtLWzzB46lbPOD9YTMSu+xS9DREiO/RVafIos00qVXfX7hsNWnvzqSkTQNbE3gZ
 PqOxt65OcoSK0TeYoJNqIucbF0wrHbbF3hdfZ299Roi4w9oCmswsqGQCKOLkjZWmQwb1
 FKT0klxz2qSfNmyUJ3LXGK8FP68XfxXTClv2hkUIz3Ty/uJlLkawkFBNCPrNeYK+JM86
 0TOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561020; x=1735165820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gPuLbZvSp6+8tc9tl8q4PUHJAk1piLXuGGcNU0EdvfA=;
 b=kTe9+/P2HHpRfY2B4f/DWUpM8ZUcfEzbFenQna40CpO5AuesB9han3XZIt1I8vEZOT
 JWnKoAhg+WYYrvf2acoMxg3/bRIuFPtjxVql/8DtQnLt21wk+jK2CFYQEtumgHLEpWYO
 eS6jDfEpcHKTUE+3wn7rXg6CljYyWeyVfdoo/XOH1tvrUlaZ3oSBkUT5yp1CAVLLsQpo
 LnbY/4mhkN5A8+KNY+CkCo282LFMdTBjhcPh1y2mM0zh8OYgXsxuEYM0MFxmxg3BBHHF
 j8G6kFbkGb1poozrEOKj0KBLTAuh1amaXpSBmNniYT1CBVO702thsCeQLsY9CLHcF+Fj
 WAyg==
X-Gm-Message-State: AOJu0Yzo26sNyelySbS5QavvK+hFPaAaQL1oCbPivXGl3lKRzf5A0tgE
 nc0ZcrcdL2iFT2hDs4uNFbESPo5dzA9LaxewRj5KovFqLfW0VNiAH+d2nZEi
X-Gm-Gg: ASbGnctMILKiSyIx11nbh9VeMDpwEfwj/YmovOJD47jUsQ4hh1162Ej1Bm/nEV5fYn5
 gZcCRpKHAXTgj4IBoNP0lg4i2PXG4LiypiPd9O97YW7vtN7qsVIhLCr76/UrKqdxODdkcjUufRt
 0SFijBUxNR6B2FXMcEj6zTiHOldCY1Z1c6atniAQTHOBQdY3RyazgusyMqwAyGezfDJgFTYMswD
 cYdjR2F3vyOcv/DlX/Y1dA4YNs0/NDYe+duH5iBrLilfGBZohctEDCDSKIwX8XjLbpJgSXAakRK
 zthQyCOXUkRmphxqVGz/jpFtPW2RdzhA3GQ/w1RePnh644whcRic85/NhTiUNMg=
X-Google-Smtp-Source: AGHT+IGWAg3aspw1mPERYm3GY9oOqlpzOx7gwKAcSRdwzIObIfKMmtxblZJA0W4gw9qPvP7+T1b1oQ==
X-Received: by 2002:a17:902:f54e:b0:216:25a2:2ebe with SMTP id
 d9443c01a7336-218d70fb66cmr67728725ad.19.1734561019960; 
 Wed, 18 Dec 2024 14:30:19 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:30:19 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jason Chien <jason.chien@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/39] hw/riscv/riscv-iommu.c: Correct the validness check of
 iova
Date: Thu, 19 Dec 2024 08:29:31 +1000
Message-ID: <20241218223010.1931245-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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


