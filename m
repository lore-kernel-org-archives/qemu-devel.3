Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0E5C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 09:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8FcQ-0007kJ-7w; Fri, 25 Apr 2025 05:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1u8FcL-0007cx-C9
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:45:09 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1u8FcH-0001D5-P6
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:45:08 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3054ef26da3so1718927a91.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 02:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1745574304; x=1746179104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3KzbB1hdkpFonoFDX89kp5voEfL/PIiiTiwDmD7yoVU=;
 b=eyT34N7zUpsHc2TABQvqUse7ktBgACbU8clSQXnSdbEEi2KFti2UPoWsqHxGliEhOT
 HPaQNK4tsglRWnkcYIU5FmLhINS1caJwojYqiLOHU/lZtz9ZK/uTkk03xY+E1lgjtXSd
 EFlCEtgtnuO05G67EnPHFqHq2aA9zGgGIw7yFDCC48VN+p5Yk7vYXkaeGWWzOS3HnZ2h
 wWeTsZbtWhh9nc753Pw9SpS4O0x/sb2ZD3zXsPhAQq+ifkhv5PScwEaCA3doNlBz1dXQ
 BSdvzLGEbiMG1V3MKe3AMfN4ECrO556jJ//831UpMOGGvTSaHB+YVcMIdu7itiLyZkcc
 xukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745574304; x=1746179104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3KzbB1hdkpFonoFDX89kp5voEfL/PIiiTiwDmD7yoVU=;
 b=PQOYZ1OU0mYUaqQe/wpeDunXEiqEmdSDhff8EGfB7ngAolzmwi1Rux0uU6D7WzZAEO
 YUnOS1+75LKMhf0flquBDJddL5UV1Ixvb5UPVSAuvI6I/Q+p2QW/yDjpsJyMccvVQ92+
 d8Q3fpqJv6mmSsaafLe7BK2Kvpr7pcA6aO/O35l0Szk/J13jm+um1Y/B4vDtqG0Cged/
 lKds0J6K35AfqRDq2Ykhozm4E7noqbeB1Yk8wO6mc8kF+l65AicvzHNQsDf1PkYLxZr8
 Kq8AOxiKBwUZ/lcRW70ihK6teu7FvttnekhhlNeSpskq/wWJqHdMLp+CRiE0vVa5/Dp4
 i31g==
X-Gm-Message-State: AOJu0Yy0yNc+siPRlbG1p4MlJtwgv3g87C4gQ4LzgZzE42BGhJ8XvIgz
 cc2qBiK2bnSZS1Fw/OSxTMm39Y5MG9NVMEUegoG6TlyhqdMRsZHDX37kdCNubeN+IoEvMxTPeyJ
 qxGWwL5w/Lcwq2vFvHyTwg3MtUYctaBqteR4vsuSxy50xgWos+3fdAL+fNZSq5I5alFwMt1T0ts
 3RC+DjwnxqYaL8+4LTcZmuaOoZRbuIZG+tqj49I9eg8UWZ
X-Gm-Gg: ASbGncs5r6ZgdBmF7DkiaEkIz8FzidA/yyt4+LV0xeeOp/uAumLAkCo0SpJYUY289Mo
 gsERwKLoDB1B7T2QY3PgizcS2wevM6miZbItirBfVjc/SLVQ+b/6jHITeRHF+78fUJgZ9jEZsU/
 s0pKayKFFvgRjMgkOMROLytnRwyI+kigI84MKT+t/5goHHZLTOTgP6Sj2u0WfMWMi+RjUUPLU+4
 ddQSrRkTlaKD/3QPiFMhgBsUu4fbP1jYwCE5uWva5tCJO2Pvgdmy4GeDz7L9cIFhnANUbNUsUCs
 KJdOgwLvoe//F1FHUjgNw+kx5ltyE0RyGCI5e7oj9yDdUJ3i0Z+ldvctq1RyOVfVWKD7q4hco/P
 pAeX9XJR6cA==
X-Google-Smtp-Source: AGHT+IGxPk3viY6u9OGg+cQz4CraYFdOr9CbyXJYZemI4mSjSEPOtjdbNhXarzQ4Z3LCB/inAyi2og==
X-Received: by 2002:a17:90b:3a43:b0:2fe:99cf:f579 with SMTP id
 98e67ed59e1d1-309f8d8cdbemr2102745a91.4.1745574303722; 
 Fri, 25 Apr 2025 02:45:03 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.228.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f27e22dasm2288826a91.17.2025.04.25.02.45.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 02:45:03 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2 1/2] target/riscv: Extend PMP region up to 64
Date: Fri, 25 Apr 2025 17:44:51 +0800
Message-ID: <20250425094452.17013-2-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250425094452.17013-1-jay.chang@sifive.com>
References: <20250425094452.17013-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=jay.chang@sifive.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

According to the RISC-V Privileged Specification (version >1.12),
RV32 supports 16 CSRs (pmpcfg0–pmpcfg15) to configure 64 PMP regions
(pmpaddr0–pmpaddr63).

Reviewed-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Jay Chang <jay.chang@sifive.com>
---
 target/riscv/cpu_bits.h |  60 +++++++++++++++++++
 target/riscv/csr.c      | 124 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 182 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index a30317c617..e6b3e28386 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -372,6 +372,18 @@
 #define CSR_PMPCFG1         0x3a1
 #define CSR_PMPCFG2         0x3a2
 #define CSR_PMPCFG3         0x3a3
+#define CSR_PMPCFG4         0x3a4
+#define CSR_PMPCFG5         0x3a5
+#define CSR_PMPCFG6         0x3a6
+#define CSR_PMPCFG7         0x3a7
+#define CSR_PMPCFG8         0x3a8
+#define CSR_PMPCFG9         0x3a9
+#define CSR_PMPCFG10        0x3aa
+#define CSR_PMPCFG11        0x3ab
+#define CSR_PMPCFG12        0x3ac
+#define CSR_PMPCFG13        0x3ad
+#define CSR_PMPCFG14        0x3ae
+#define CSR_PMPCFG15        0x3af
 #define CSR_PMPADDR0        0x3b0
 #define CSR_PMPADDR1        0x3b1
 #define CSR_PMPADDR2        0x3b2
@@ -388,6 +400,54 @@
 #define CSR_PMPADDR13       0x3bd
 #define CSR_PMPADDR14       0x3be
 #define CSR_PMPADDR15       0x3bf
+#define CSR_PMPADDR16       0x3c0
+#define CSR_PMPADDR17       0x3c1
+#define CSR_PMPADDR18       0x3c2
+#define CSR_PMPADDR19       0x3c3
+#define CSR_PMPADDR20       0x3c4
+#define CSR_PMPADDR21       0x3c5
+#define CSR_PMPADDR22       0x3c6
+#define CSR_PMPADDR23       0x3c7
+#define CSR_PMPADDR24       0x3c8
+#define CSR_PMPADDR25       0x3c9
+#define CSR_PMPADDR26       0x3ca
+#define CSR_PMPADDR27       0x3cb
+#define CSR_PMPADDR28       0x3cc
+#define CSR_PMPADDR29       0x3cd
+#define CSR_PMPADDR30       0x3ce
+#define CSR_PMPADDR31       0x3cf
+#define CSR_PMPADDR32       0x3d0
+#define CSR_PMPADDR33       0x3d1
+#define CSR_PMPADDR34       0x3d2
+#define CSR_PMPADDR35       0x3d3
+#define CSR_PMPADDR36       0x3d4
+#define CSR_PMPADDR37       0x3d5
+#define CSR_PMPADDR38       0x3d6
+#define CSR_PMPADDR39       0x3d7
+#define CSR_PMPADDR40       0x3d8
+#define CSR_PMPADDR41       0x3d9
+#define CSR_PMPADDR42       0x3da
+#define CSR_PMPADDR43       0x3db
+#define CSR_PMPADDR44       0x3dc
+#define CSR_PMPADDR45       0x3dd
+#define CSR_PMPADDR46       0x3de
+#define CSR_PMPADDR47       0x3df
+#define CSR_PMPADDR48       0x3e0
+#define CSR_PMPADDR49       0x3e1
+#define CSR_PMPADDR50       0x3e2
+#define CSR_PMPADDR51       0x3e3
+#define CSR_PMPADDR52       0x3e4
+#define CSR_PMPADDR53       0x3e5
+#define CSR_PMPADDR54       0x3e6
+#define CSR_PMPADDR55       0x3e7
+#define CSR_PMPADDR56       0x3e8
+#define CSR_PMPADDR57       0x3e9
+#define CSR_PMPADDR58       0x3ea
+#define CSR_PMPADDR59       0x3eb
+#define CSR_PMPADDR60       0x3ec
+#define CSR_PMPADDR61       0x3ed
+#define CSR_PMPADDR62       0x3ee
+#define CSR_PMPADDR63       0x3ef
 
 /* RNMI */
 #define CSR_MNSCRATCH       0x740
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 560b45d10d..41cf469615 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -6093,6 +6093,30 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_PMPCFG1]    = { "pmpcfg1",   pmp, read_pmpcfg,  write_pmpcfg  },
     [CSR_PMPCFG2]    = { "pmpcfg2",   pmp, read_pmpcfg,  write_pmpcfg  },
     [CSR_PMPCFG3]    = { "pmpcfg3",   pmp, read_pmpcfg,  write_pmpcfg  },
+    [CSR_PMPCFG4]    = { "pmpcfg4",   pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPCFG5]    = { "pmpcfg5",   pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPCFG6]    = { "pmpcfg6",   pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPCFG7]    = { "pmpcfg7",   pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPCFG8]    = { "pmpcfg8",   pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPCFG9]    = { "pmpcfg9",   pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPCFG10]   = { "pmpcfg10",  pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPCFG11]   = { "pmpcfg11",  pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPCFG12]   = { "pmpcfg12",  pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPCFG13]   = { "pmpcfg13",  pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPCFG14]   = { "pmpcfg14",  pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPCFG15]   = { "pmpcfg15",  pmp, read_pmpcfg,  write_pmpcfg,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
     [CSR_PMPADDR0]   = { "pmpaddr0",  pmp, read_pmpaddr, write_pmpaddr },
     [CSR_PMPADDR1]   = { "pmpaddr1",  pmp, read_pmpaddr, write_pmpaddr },
     [CSR_PMPADDR2]   = { "pmpaddr2",  pmp, read_pmpaddr, write_pmpaddr },
@@ -6107,8 +6131,104 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_PMPADDR11]  = { "pmpaddr11", pmp, read_pmpaddr, write_pmpaddr },
     [CSR_PMPADDR12]  = { "pmpaddr12", pmp, read_pmpaddr, write_pmpaddr },
     [CSR_PMPADDR13]  = { "pmpaddr13", pmp, read_pmpaddr, write_pmpaddr },
-    [CSR_PMPADDR14] =  { "pmpaddr14", pmp, read_pmpaddr, write_pmpaddr },
-    [CSR_PMPADDR15] =  { "pmpaddr15", pmp, read_pmpaddr, write_pmpaddr },
+    [CSR_PMPADDR14]  = { "pmpaddr14", pmp, read_pmpaddr, write_pmpaddr },
+    [CSR_PMPADDR15]  = { "pmpaddr15", pmp, read_pmpaddr, write_pmpaddr },
+    [CSR_PMPADDR16]  = { "pmpaddr16", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR17]  = { "pmpaddr17", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR18]  = { "pmpaddr18", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR19]  = { "pmpaddr19", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR20]  = { "pmpaddr20", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR21]  = { "pmpaddr21", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR22]  = { "pmpaddr22", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR23]  = { "pmpaddr23", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR24]  = { "pmpaddr24", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR25]  = { "pmpaddr25", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR26]  = { "pmpaddr26", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR27]  = { "pmpaddr27", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR28]  = { "pmpaddr28", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR29]  = { "pmpaddr29", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR30]  = { "pmpaddr30", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR31]  = { "pmpaddr31", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR32]  = { "pmpaddr32", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR33]  = { "pmpaddr33", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR34]  = { "pmpaddr34", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR35]  = { "pmpaddr35", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR36]  = { "pmpaddr36", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR37]  = { "pmpaddr37", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR38]  = { "pmpaddr38", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR39]  = { "pmpaddr39", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR40]  = { "pmpaddr40", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR41]  = { "pmpaddr41", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR42]  = { "pmpaddr42", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR43]  = { "pmpaddr43", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR44]  = { "pmpaddr44", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR45]  = { "pmpaddr45", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR46]  = { "pmpaddr46", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR47]  = { "pmpaddr47", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR48]  = { "pmpaddr48", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR49]  = { "pmpaddr49", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR50]  = { "pmpaddr50", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR51]  = { "pmpaddr51", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR52]  = { "pmpaddr52", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR53]  = { "pmpaddr53", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR54]  = { "pmpaddr54", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR55]  = { "pmpaddr55", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR56]  = { "pmpaddr56", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR57]  = { "pmpaddr57", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR58]  = { "pmpaddr58", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR59]  = { "pmpaddr59", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR60]  = { "pmpaddr60", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR61]  = { "pmpaddr61", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR62]  = { "pmpaddr62", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
+    [CSR_PMPADDR63]  = { "pmpaddr63", pmp, read_pmpaddr, write_pmpaddr,
+                         .min_priv_ver = PRIV_VERSION_1_12_0           },
 
     /* Debug CSRs */
     [CSR_TSELECT]   =  { "tselect",  debug, read_tselect,  write_tselect  },
-- 
2.48.1


