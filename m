Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1D7CAC59A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 08:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy4mL-00080O-Vx; Mon, 15 Sep 2025 04:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uy4m3-0007Zy-7p
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:41:24 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uy4lo-0002Pl-Gr
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:41:22 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-776b0100de0so989045b3a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1757925662; x=1758530462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q2aTgYBYQIaIB2ry1ZOOQRZzj19yzWH4/DlOx0B0kCk=;
 b=OPNPLCvni+eKzlBdpgsO4bnzjlyJ9Gvgbp2SNBcLl333++7eMRyTBm5oXrVFKqYYXZ
 aMOMl3zKiDSAKVCYiJjHvPa2xoikX1S/idJPGlHyaaw41HjcB3We2sFmiAuo1vPg5smB
 ZqNwyEiYXJfPIYCRrTSCYUVjzqPQYRgIRNkNQiFwRyw1izJnuFdjMda4EA3eGWwuQwKE
 4n7H9AfCFMT42p7B45JzSGS4SgI/IVMFBGC/KCO16bDYolHIVHyfnrnibKaimmCNfM89
 ZpUrsmoph+lIkJkD5e2oh6zC+A3K59vN5QQD4djs5KcBXK9vDVVkF1LxewY6OmefBsEM
 sWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757925662; x=1758530462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q2aTgYBYQIaIB2ry1ZOOQRZzj19yzWH4/DlOx0B0kCk=;
 b=IQe/oas2/X9+BuP5Zn7dnCkmJ5o5l8T4ddIEDAW4E5c4Pgk2gybjWijSV1yff4Yu4r
 BuI0s5e1WnSRDObUxQ5hNnIvIDKVXmAk2U89jX1wsDLcQiDrGbAcwhLtDi3FLhBknmHC
 my4IOvQIaEq10GfRTWOZdyYxkJ4hPsy3lA+rN3TcgcZh702L0LfS0Oiohwv4dy387Vve
 OHp9hAnCE89d7Nne21a1cuCCwU1bmSgA+h2khJ0I/NwHoDp0rztTwX2jT8xcfNV5yNFu
 66iXh6PBmgQeZDmUIunXM5iifOFu4nQMNcJGBW7n6JCMfpgtGFYWfEFzh0aCNK4OdPQb
 o8Yw==
X-Gm-Message-State: AOJu0Yzn4ZwkqkvxOV+TXBMP6kcW9Hop47L6A8U5N3zuSA3ypH6HFNyp
 Te64gM3GpiCPZoGr/qgsUa331Ys/axG/IhK0xmJk15+MJkLvHKpSqLOHRRb8Z3dPh4IVsLZfZMK
 IjjaRbktNMj682M9CXmPjMEOlvxaA6V6jqI0moMd8t/PetzFdqeLc6OgMxXt4YUromLiM9FJ/A9
 OuJ2IS8q5R/vWfUeGnKgCc0m/RHt1dtFMNmc0D6T0eZw==
X-Gm-Gg: ASbGnctePmfZa+W8PUMqQyervqTssNSTQWoBUJXtHSNvqnM0Z6PbE8HcYlWZoVUkxYe
 l8GNR9Hu2IaEBttpcUVrV+edU7vHNhoa6GeTzfx3nOFGcoQtqe8oFROnEvLuhRYA+OCCWkRoPEB
 1OT1+76d1biRYpCr7MQojPC1yppFMgvvM3DMzaWVgTtP+zBUJvQO8+NKjaoY1xt+oXV7LlnbIMO
 tBoqJ9X9kLY17ZMiTjMcXt7EOMul8ENkZMHBZxgat2U7pHhcFr6TYUobb+bu3GTtxWeNC7iO6YN
 boVSb90x287kMNhanLGzCnrSbH3nhQ28GudI+0ft56U2NiXLHMjaiULXTd+qpynlfQCLQRoO2oZ
 BZMpRIL1Ff858TNDuLzk6MmVxc9oOKGkTXIF1FsMaR1fBAT9vWnCA6FjdjRmybgGAWAU=
X-Google-Smtp-Source: AGHT+IH8V7MdroBz/3fN9apeVG6sXCH4KqW8b+316l/Kr5KVgm+tp5xdLxZX9LqTEazx0tpHOBjK8w==
X-Received: by 2002:a17:903:19c8:b0:24c:e9de:ee11 with SMTP id
 d9443c01a7336-25d2c560f8emr140821965ad.17.1757925661514; 
 Mon, 15 Sep 2025 01:41:01 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-26295996ff6sm55852045ad.64.2025.09.15.01.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 01:41:01 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH 4/8] target/riscv: Use the tb->cs_bqse as the extend tb
 flags.
Date: Mon, 15 Sep 2025 16:40:32 +0800
Message-ID: <20250915084037.1816893-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915084037.1816893-1-max.chou@sifive.com>
References: <20250915084037.1816893-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42b.google.com
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

We have more than 32-bits worth of state per TB, so use the
tb->cs_base, which is otherwise unused for RISC-V, as the extend flag.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 include/exec/translation-block.h | 1 +
 target/riscv/cpu.h               | 2 ++
 target/riscv/tcg/tcg-cpu.c       | 6 +++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index cdce399ebab..aa2dd4b12f8 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -63,6 +63,7 @@ struct TranslationBlock {
      * arm: an extension of tb->flags,
      * s390x: instruction data for EXECUTE,
      * sparc: the next pc of the instruction queue (for delay slots).
+     * riscv: an extension of tb->flags,
      */
     uint64_t cs_base;
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 532386000af..d10464eeeca 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -704,6 +704,8 @@ FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)
 FIELD(TB_FLAGS, PM_PMM, 29, 2)
 FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
 
+FIELD(EXT_TB_FLAGS, ALTFMT, 0, 1)
+
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
 #else
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 07b2b137934..6fe3ae9c085 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -104,6 +104,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     RISCVCPU *cpu = env_archcpu(env);
     RISCVExtStatus fs, vs;
     uint32_t flags = 0;
+    uint64_t ext_flags = 0;
     bool pm_signext = riscv_cpu_virt_mem_enabled(env);
 
     if (cpu->cfg.ext_zve32x) {
@@ -118,6 +119,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
 
         /* lmul encoded as in DisasContext::lmul */
         int8_t lmul = sextract32(FIELD_EX64(env->vtype, VTYPE, VLMUL), 0, 3);
+        uint8_t altfmt = FIELD_EX64(env->vtype, VTYPE, ALTFMT);
         uint32_t vsew = FIELD_EX64(env->vtype, VTYPE, VSEW);
         uint32_t vlmax = vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
         uint32_t maxsz = vlmax << vsew;
@@ -133,6 +135,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
         flags = FIELD_DP32(flags, TB_FLAGS, VMA,
                            FIELD_EX64(env->vtype, VTYPE, VMA));
         flags = FIELD_DP32(flags, TB_FLAGS, VSTART_EQ_ZERO, env->vstart == 0);
+        ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, ALTFMT, altfmt);
     } else {
         flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
     }
@@ -191,7 +194,8 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
 
     return (TCGTBCPUState){
         .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
-        .flags = flags
+        .flags = flags,
+        .cs_base = ext_flags,
     };
 }
 
-- 
2.43.0


