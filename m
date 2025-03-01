Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB73C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 17:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toQmy-0003vc-9x; Sat, 01 Mar 2025 12:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1toQmv-0003uv-4f
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 12:38:09 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1toQmt-0002Dn-MV
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 12:38:08 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fea795bafeso4761805a91.1
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 09:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1740850686; x=1741455486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d//s6Iyign0gPuEjM1mBLCE+ph1NFY+WQmvm+d2SWk4=;
 b=jU774IFEALBxf+UN9ayAV7Nb3WU9oIttrhwjpD9NrzlLaynidKzd7mWMinvkssOZtE
 Zm+qauBQBYRODEGKmA9PT2eJq8vmksYmuvK1c6IpoQ42K8MLqKv8qWQIGT1BZiLc4S0x
 n7HfBWjF8IuyH8bV30VdKUK2gndI9P7cL9WppWJUqEmvFT7NPOeGX9DdNE6lVZCUtEL4
 QhJP069QPY9NuyIb2szm/1uw9FWOaACz14lx5KXc76ePxn23TjHSckhIKGgUhw87eKwq
 pGxDDEGs0nCM5KgKTu6BQ+Q2d2XA0ynIAYzDaR6qDMJgGovO3LA0MiZxagJM5y7XnClq
 Ll8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740850686; x=1741455486;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d//s6Iyign0gPuEjM1mBLCE+ph1NFY+WQmvm+d2SWk4=;
 b=POeQhMglY5YGNWEf7yxQkqYNTNqhRkCqikO/2YI1v1YbPYc0YCZseNL2La6K8PrsFp
 4Ml+mOsmHPjJzRMTklneaQP4LAn3lwEdMZaHxjRBHUAmNZRV28MoHDAqHoBLKmCUMsBF
 nZdLkL++P1xNCQ2xhyk1TV/oM4KW8PHVF1hQzITp8odKlSJE1QlJo3dn8ljn7EXcZ4Em
 O+7w/bo17e1ywqcQn0J8NyFTk4daE4lAR3hQkynE3PHLUndN0TNHNczylJKDMPUwT9Gg
 DVxCGlerF4mFw+ql8Nu/fumKvyAki0BH5mi3ZU5MC87MDKwXW81l0LHYvwW3mmgpHYUZ
 gPDA==
X-Gm-Message-State: AOJu0YxBTK/8yFlxgxnY5qQm0q5DuWlUKKQHRWFBJbmzWv1mwz4Z1TvD
 dBQsgk3faOxiibZo37sMId0NTlXuhFa7p7zdbwFKQ6aDLbabMT/21bnyVkX+oTcu2eMfi/tNoHm
 WvPPIQKh5l8jF74FzMYsr9jbgVF7jaKfm8DagcDeC4mnK2JmsbZUo2ovNAzNKH1YrnRcoWNIRct
 EYFufbqy7k8IUJoJABM3R6Rw1CHo1+uS8YffHiIxE=
X-Gm-Gg: ASbGncuv4c+w6upe3Mp1PZYpX75r2H+XsLyaZcXUg7qqvIhVKN/lVzkM8ljggZPzdZz
 T1FLpaZFyKI2wejkG1inD328eXF/iAFhMrJ8QVnE+IQlOkdNwwJZ5sBZkNmbshtBQ1mc3MDyFVw
 D5gC2EuT/KwAlp4UeyfYDxRD6fUWzC1RX/k9swsfMCsPQ0buIH6hCx2DdFlw5Y8pr/BxfCXScqu
 oqzedcEYSPZCbcOu/aprXn++y4fy53R6VZjea8w04pVab25EGe/z7M06m791sTh2kkpTq/qIEpr
 5kwq/XBuO+ZRM6F99BFe8Si0KH5nkIhUYez5hmqlhC0S9TYx7S5KjC7j6DQMERnG5Z1uyV8m
X-Google-Smtp-Source: AGHT+IFcYg7fv4dIzzj+zH5PBGRo2Gt6iRhOBXeyzKmiLrfAwqIy9qSzYJGRIEKA0oolWORjYgo7oA==
X-Received: by 2002:a17:90b:1b4f:b0:2fa:22a2:26a3 with SMTP id
 98e67ed59e1d1-2feba5eda81mr12252927a91.6.1740850685483; 
 Sat, 01 Mar 2025 09:38:05 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67530dfsm5877781a91.8.2025.03.01.09.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Mar 2025 09:38:05 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jason Chien <jason.chien@sifive.com>
Subject: [PATCH v2] hw/riscv/riscv-iommu: Fix process directory table walk
Date: Sun,  2 Mar 2025 01:37:51 +0800
Message-ID: <20250301173751.9446-1-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=jason.chien@sifive.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
2.43.2


