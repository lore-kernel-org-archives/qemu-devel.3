Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8170C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfLt-0005am-B5; Fri, 17 Jan 2025 00:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLq-0005Qq-4O
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:02 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLo-0005zD-9z
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:01 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-215770613dbso22704265ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093418; x=1737698218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HoGXO43r9qDXaHablQVjOVSCK/3SyKJM+5NhSlCrZrs=;
 b=XN0WCST0HtvRJjCvvJXnmdfLVUnx2FvqGMrKIINxhv7JUcfIJUfD28J+zfu1oDB1gQ
 ee8zzyinAjzned/sLdfSfg60FvJSeofhRsHwbfa3zJDZ9qcFGZciszLq7Q+LM73c/qvg
 fVa04cNCcWin1Xq5RMxCov+ka/EvjrMlyR69nMwYZrHYmMycwUouvuZQIoYijSawcIC4
 RzqNxq3VPzoTY2AyF2+4ZEgg2sA+Keyqt9bm84HKqGe2EBvpRw/Oo94lFe/+4h2VdwyA
 ZPlDvBLjEs9ZvUCuLae0dWlSd8w5f+SSDSoJrIdKphlc2SkeVaemNeeLsu/A++Y+WiPt
 wz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093418; x=1737698218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HoGXO43r9qDXaHablQVjOVSCK/3SyKJM+5NhSlCrZrs=;
 b=JXFngqlUmg9J3tyFSmY09UkucY09W38E40n4DgblG0y2GJbDP70fMM4oYVhNk/ZCza
 aYh0DEiXCILkybIi/wFgzUY87sD5x0KsY97UseRR9RCdSDm6BnP7hTIgfBnTAuVGPOfd
 2sIcVg2Yta4z03dU1sS/pUz2VhmI5Z0OGo0N5roQevojeFnMLnJvCN+phsrGymD19Oy/
 gEMK1/sZLWhpMfbHp9Dp24ymwj/ApmC9ylDCFXYOW7VaIy6zQfc+sP5ldtso4JfGu3mD
 QTOzBG7CZPtTpTACZWpOtkDRQaZDdhwYp9VhFt1e7txEoSiRdCwtOwDERdvgrELoJOs6
 q6BQ==
X-Gm-Message-State: AOJu0YyKrsghozo3vAlnXZeRrLD674IkedMWz14zNdekJzENgjPtffIx
 K6QZeLsxld+VQFnWyJTudwj7GztlfqM4F9u4ZeaTC43m/6wxma1lphtMKA==
X-Gm-Gg: ASbGncvwKI1IyYPY2qePWbF+WW/0oHH0gn93/av0rVYpdbSMYN50VGpaknkVCs0Zacx
 w+O3TzkTf1u2JjohfW4PngUdPGNbccPSdBnVYOVVgAS53M/2yp5FMaEyqivWpCeVkM9A7nUTyPd
 a6QkOWCUfSD3LsIFu6e6B5MibhHvrz8JBZQLm80cbhGeVQe4ZScaVInI0iAkr9Y+5Fd6vsHP0ev
 NCNo9b5n6k5ZVzpWUwqIo246ugiVl05KOf0JwzoJBY6NI6kwHAv0KIVc2IFV7gppoNUT9kiwoxm
 /OJUt40V77fTvKB/p3B/3aDf/Y9s0gGyJ3b/PNpFBDux2+ZAd2bmofJz7u7+
X-Google-Smtp-Source: AGHT+IEMLFPQns9pN9MMUSrYPzjxeLBa/FD3336VRlWhT/xQjyuJxPhJA8ceuZ2tHrZsuq7z0kEFJw==
X-Received: by 2002:a17:903:2447:b0:215:8ca3:3bac with SMTP id
 d9443c01a7336-21c3540278dmr21599015ad.16.1737093418490; 
 Thu, 16 Jan 2025 21:56:58 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:56:58 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alexey Baturo <baturo.alexey@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 17/50] target/riscv: Update address modify functions to take
 into account pointer masking
Date: Fri, 17 Jan 2025 15:55:19 +1000
Message-ID: <20250117055552.108376-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250106102346.1100149-6-baturo.alexey@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c     | 22 ++++++++++++++++------
 target/riscv/vector_helper.c | 16 ++++++++++++++++
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 26350b2826..698b74f7a8 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -589,8 +589,10 @@ static TCGv get_address(DisasContext *ctx, int rs1, int imm)
     TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
 
     tcg_gen_addi_tl(addr, src1, imm);
-    if (get_address_xl(ctx) == MXL_RV32) {
-        tcg_gen_ext32u_tl(addr, addr);
+    if (ctx->addr_signed) {
+        tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_xl);
+    } else {
+        tcg_gen_extract_tl(addr, addr, 0, ctx->addr_xl);
     }
 
     return addr;
@@ -603,8 +605,10 @@ static TCGv get_address_indexed(DisasContext *ctx, int rs1, TCGv offs)
     TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
 
     tcg_gen_add_tl(addr, src1, offs);
-    if (get_xl(ctx) == MXL_RV32) {
-        tcg_gen_ext32u_tl(addr, addr);
+    if (ctx->addr_signed) {
+        tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_xl);
+    } else {
+        tcg_gen_extract_tl(addr, addr, 0, ctx->addr_xl);
     }
 
     return addr;
@@ -1234,8 +1238,14 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
     ctx->cs = cs;
-    ctx->addr_xl = 0;
-    ctx->addr_signed = false;
+    if (get_xl(ctx) == MXL_RV32) {
+        ctx->addr_xl = 32;
+        ctx->addr_signed = false;
+    } else {
+        int pm_pmm = FIELD_EX32(tb_flags, TB_FLAGS, PM_PMM);
+        ctx->addr_xl = 64 - riscv_pm_get_pmlen(pm_pmm);
+        ctx->addr_signed = FIELD_EX32(tb_flags, TB_FLAGS, PM_SIGNEXTEND);
+    }
     ctx->ztso = cpu->cfg.ext_ztso;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
     ctx->bcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, BCFI_ENABLED);
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index cf5dd7f2e1..0eea124b66 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -107,6 +107,22 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
 
 static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong addr)
 {
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        return addr;
+    }
+    RISCVPmPmm pmm = riscv_pm_get_pmm(env);
+    if (pmm == PMM_FIELD_DISABLED) {
+        return addr;
+    }
+    int pmlen = riscv_pm_get_pmlen(pmm);
+    bool signext = riscv_cpu_virt_mem_enabled(env);
+    addr = addr << pmlen;
+    /* sign/zero extend masked address by N-1 bit */
+    if (signext) {
+        addr = (target_long)addr >> pmlen;
+    } else {
+        addr = addr >> pmlen;
+    }
     return addr;
 }
 
-- 
2.47.1


