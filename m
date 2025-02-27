Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26745C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 07:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnYPz-0005Vi-8C; Thu, 27 Feb 2025 02:34:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tnYPw-0005UT-2B
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 02:34:49 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tnYPu-0004qB-Cf
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 02:34:47 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2235908a30aso3378615ad.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 23:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1740641684; x=1741246484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=49Lqc3jo0xCLKFBce68EsedKQHxM1L0GYblpsYHQ2gI=;
 b=UrI5/ecO6NDwHaX1xl+ey5xlpzKs/17L5cq5VlAxNjKS7mNun/Q+pMDOyp+d6QxBwB
 eEabu1fZ9oF88k+bK4JwCkvz236o4/O9YNF152QUkgtsPs0mLDme8QJRXwLgKb6rD0KZ
 i/bBrS2lZk5KVqVCoQQaJVCFLqmjRJ0sG+iGPxe8XwCjRAK3EwS0HgLg3AtA5FIJK0OB
 F7xNYKwpybY4nhdl1pO9TEkokBodVk8l6GxuzWAV8IfWuAm5IdayqSKGHGdJDdwGZlJM
 R9oUxayx6WpY3dorYMxluTbC5HyM6J0snADaJFlhooQV2GxAW1mPzWkOGM29OUt9IBKt
 mIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740641684; x=1741246484;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=49Lqc3jo0xCLKFBce68EsedKQHxM1L0GYblpsYHQ2gI=;
 b=A0a9cskWin6gf5HVpyZIJ1qTz50ruRDH6CsVptDjTAMOQ4pgP+u6R++J0sqThEdfCK
 d4fSaLN15HPcqyaoj8Q36g8keHLsoUePFyma2WRBWHDO3wzP/t9h1oPd2vEPricqWDrG
 1cwKL/m5YAB9D569nF3oV9GXwAMvJi3ks3Hx8MFnsYx7MB9pKx7gCtrIOYikgkWtsDC7
 CwVGX264MeOEEKoypCgdvh/Uf0fwww2KbGhhaKnQgfOvWBRbe6LlPBeKDY8uVoJ3GSkZ
 XhBPUrv5u20UUgbxlPEf3BMNfoimtG0yA94Q2ht1fgEoLnXtPSWT8kWV9oMSGAveXddy
 E2Ow==
X-Gm-Message-State: AOJu0Ywz18IHZ4h0ZMtXy/Mj2VPYjLQPdQGFAG23D0flcUX2Mmii0rhJ
 Fi1a9G4QIVNNa+jwGm4TJff1gYOk1djN8tJdvvotrneYkbAEU77pAV5NmUyE4naXG9iVlGE8pjS
 kNLudcrKibRxCW3cbB7WHzVC+hHqxIh4o6w9HKyo0vdjk6TlQjrWu3GHLAlvdkG1ioWelAmWD+2
 USVAJnig6vJSEDKC/zUSR01+QSL2kDrtToJAFJHTo=
X-Gm-Gg: ASbGncvHNRovAVJQkxaJObE2icHC85K4yL9xaBxSJsXaceC3Lf+6GbjMxJ8PxAwlLrb
 BKMSp1Mt3nwq2HJInFjGshZLbDuYetaNDi73mBGv5B1Qvqo9Jd5opcOARN12PtD1PMxpekVgRPj
 +T4QW12MyIJE6KK2uA+EQXbg5IBM0Eq14iQH6xOAg5EJ7T7ZS3LsC+yIV05+Ra4yWWCzTCDeDv/
 miF1MOsEQlR/W55CDPf6Uq4tuThSVaUNVn1qtybZO+Yx5oPDamPLV/3DQfpy2+21xyc44N6JfZc
 CVns97ejzc7oI09lAUUvOFEgcSXJs/eBppBCy4P1DR+5bRxyPjxe3w==
X-Google-Smtp-Source: AGHT+IEgaM8PvfnGnrNGlcHIjF2vTIhLkdqE8oaJxliNrDEdoHh+LtTKbTOqFaqRMin4hgqj2Xby8w==
X-Received: by 2002:a05:6a21:99a1:b0:1ee:6fec:3e5c with SMTP id
 adf61e73a8af0-1f10acf5c0amr10762316637.7.1740641684075; 
 Wed, 26 Feb 2025 23:34:44 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aee7de1a642sm714350a12.22.2025.02.26.23.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 23:34:43 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jason Chien <jason.chien@sifive.com>
Subject: [PATCH] hw/riscv/riscv-iommu: Fix process directory table walk
Date: Thu, 27 Feb 2025 15:34:21 +0800
Message-ID: <20250227073421.399-1-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x634.google.com
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

The PPN field in a non-leaf PDT entry is positioned differently from that
in a leaf PDT entry. The original implementation incorrectly used the leaf
entry's PPN mask to extract the PPN from a non-leaf entry, leading to an
erroneous page table walk.

This commit introduces new macros to properly define the fields for
non-leaf PDT entries and corrects the page table walk.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
---
 hw/riscv/riscv-iommu-bits.h | 6 +++++-
 hw/riscv/riscv-iommu.c      | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index de599b80d6..8d621c5b70 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -368,12 +368,16 @@ enum riscv_iommu_fq_causes {
 #define RISCV_IOMMU_DC_MSIPTP_MODE_OFF  0
 #define RISCV_IOMMU_DC_MSIPTP_MODE_FLAT 1
 
+/* 2.2 Process Directory Table */
+#define RISCV_IOMMU_PDTE_VALID          BIT_ULL(0)
+#define RISCV_IOMMU_PDTE_PPN            RISCV_IOMMU_PPN_FIELD
+
 /* Translation attributes fields */
 #define RISCV_IOMMU_PC_TA_V             BIT_ULL(0)
 #define RISCV_IOMMU_PC_TA_RESERVED      GENMASK_ULL(63, 32)
 
 /* First stage context fields */
-#define RISCV_IOMMU_PC_FSC_PPN          GENMASK_ULL(43, 0)
+#define RISCV_IOMMU_PC_FSC_PPN          RISCV_IOMMU_ATP_PPN_FIELD
 #define RISCV_IOMMU_PC_FSC_RESERVED     GENMASK_ULL(59, 44)
 
 enum riscv_iommu_fq_ttypes {
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index e7568ca227..1abe981244 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1043,10 +1043,10 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
             return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
         }
         le64_to_cpus(&de);
-        if (!(de & RISCV_IOMMU_PC_TA_V)) {
+        if (!(de & RISCV_IOMMU_PDTE_VALID)) {
             return RISCV_IOMMU_FQ_CAUSE_PDT_INVALID;
         }
-        addr = PPN_PHYS(get_field(de, RISCV_IOMMU_PC_FSC_PPN));
+        addr = PPN_PHYS(get_field(de, RISCV_IOMMU_PDTE_PPN));
     }
 
     /* Leaf entry in PDT */
-- 
2.43.2


