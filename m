Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB392C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 08:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuoPY-0008QO-CK; Wed, 19 Mar 2025 04:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuoOn-00081X-Lm
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:03:43 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuoOl-0004Qb-VT
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:03:37 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2239c066347so139691025ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 01:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742371414; x=1742976214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bT/bW29GwGcJx+ezk5/UB0aQ+0X7tJA6z6SWSn/AAEY=;
 b=nhJssNZigDXZUrZXjc2h2MmKIkwrBiuQa1OWRjBvemFlM+r9kM8duwp4unywe7zctU
 kMsGOk9D7ao62xp88WDvE8glWy16U9bBjB2ZHWgeyPwNFn6UcLExi9D97B7GkbpPhy9T
 J1FV+6ntgrux5YOkZANLlniNMBE+EceOulgZkYLTyzvGEDmmXJJ9LLOZucmOjZcGqmhh
 9IiOtACADDiycLdSVl92P4GoKhVEhW5KtCbmaXc3HKI4CcPybXAOqgfplsYsawAq7o9x
 JTCNmdjV4jN84yZqzGPwSifdlQxQVk19FJlRiIF5gBtjYlzjqgDM7q47BET6EX0h8wEz
 a8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742371414; x=1742976214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bT/bW29GwGcJx+ezk5/UB0aQ+0X7tJA6z6SWSn/AAEY=;
 b=SXDP0i83NEsxK9NxgdS1lUQxeKE0srsDdeZU3ICkDTVoFhV0gex+9byFtyrrUTHT/u
 5eboNwxyJpHz2Y8aSzLZp95JVpRdCbwckXMk91LjlGcYNhIz81ianT82TyQYd4zrsYyx
 f+idPsrD57+bzrOaIzAcj6PGyd4bt++gyBbpz5bArq0qxQspU2hf7rVXcJDq6YSxwVRS
 SEAQKe0rKEALTOwEQkl6u4kO3XAfiW364ZVHWu01zJg5XeC3efAU1g7vkGoE7CpcQEm8
 k9+c914Sbax1e7B0iZ5lg02eRtqvCa3ctWXjSrrssx/TdiOjHwvN4EM4VqpiBcr7NbAI
 zTuQ==
X-Gm-Message-State: AOJu0YxF+Af8rDRalMfzFL6FWyDNf5D/kgERHH365OwFnbu/iDjaMGui
 DDOdrYlNEaCWV4VggGlzW0/+MxVRy+9wIp9BD85h2TRApX9hLg7TB3okdQ==
X-Gm-Gg: ASbGnctymmY8WXr5q85sCIiQFhBc2imtp5BFnjdKIomkIMRMnzoe2feF2D8irJw3qgq
 MCWuCiFtJ4pmujDHLjPqo53FZkMSUguXhuKXUYAqRIiU8+VnNXE0tan4USJeL+7LhVQ6QhKmok5
 9dsaps0jt5+AzVs+7ro+sMdZqH1Q+uxXv/gmsAKevE9R1OKyw4wJkLtoaX5n7CCjftg41aIXb0f
 nMrFNYY6H8hCveZS8tnDtfpSsoizQju6vObmC4KtZ+NlAyN44vpvkMcrN0nYXargpp4APl8OgJd
 Fck50DhZx5vqFIuEOTkwnaN7ay4rzL5Is06u9ikU1Sb9fWZinhmKE4VVLgkeO0evDMEu/5AlCnr
 dl9RSTKgmMM/nQ0ukvlsIk6KrsvHPMHid02O4S86tAOJJuRmUINWn3KJG7ao=
X-Google-Smtp-Source: AGHT+IGOqGFNprgMH8JVaqm0cdADuORQVG5lz32bfcK0QZrctu2ve9laI0H9evIOfcJ+IdGaxNnRbg==
X-Received: by 2002:a17:903:19d0:b0:224:93e:b5d7 with SMTP id
 d9443c01a7336-22649c8f95amr34446055ad.34.1742371413809; 
 Wed, 19 Mar 2025 01:03:33 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6c8dsm107725255ad.156.2025.03.19.01.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 01:03:33 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jason Chien <jason.chien@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/10] hw/riscv/riscv-iommu: Fix process directory table walk
Date: Wed, 19 Mar 2025 18:03:03 +1000
Message-ID: <20250319080308.609520-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319080308.609520-1-alistair.francis@wdc.com>
References: <20250319080308.609520-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

The PPN field in a non-leaf PDT entry is positioned differently from that
in a leaf PDT entry. The original implementation incorrectly used the leaf
entry's PPN mask to extract the PPN from a non-leaf entry, leading to an
erroneous page table walk.

This commit introduces new macros to properly define the fields for
non-leaf PDT entries and corrects the page table walk.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250301173751.9446-1-jason.chien@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-bits.h | 6 +++++-
 hw/riscv/riscv-iommu.c      | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index b7cb1bc736..1017d73fc6 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -415,12 +415,16 @@ enum riscv_iommu_fq_causes {
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
index d46beb2d64..76e0fcd873 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1042,10 +1042,10 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
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
 
     riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_PD_WALK);
-- 
2.48.1


