Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77531D5E13A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 06:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9I3t-0003pa-Tw; Fri, 08 Nov 2024 01:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1t9I3t-0003os-6k; Fri, 08 Nov 2024 01:01:37 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1t9I3r-00084P-C8; Fri, 08 Nov 2024 01:01:36 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fb3c3d5513so17267231fa.1; 
 Thu, 07 Nov 2024 22:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731045693; x=1731650493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gwcJT32j32KKKz/tCRrugf9yi6vjemEK7dj9TrpBfM8=;
 b=BVCoiuvAAd7TCo96wlGSHQoVqyUP0ILVZhtGJ4T+ih93BDfzboqNvw2rbq6ILx2p0L
 DRMH0Dhwlbx6bn22Vu5KjvJubqB8+UU+ySCKcC/0r595jY4+clxOjnYgYiSXWseSccL5
 9hZXuMF0db4L4SpuKYAJApV3aPfY8ztQMOytaxulZQubtJTDNHyhrvPlTjrl0nZPaH98
 1AiHeReCIBZT81QQkOSbKyIidF01CNq9kxIic66Y77dJleW9QxXa2/9txSD5krkyXbjn
 uDVGEr+Q0HenTiGPjT7XGOag05nOOqNUQv7kqGxr7XQyQPlW8p2SYByU3CHk6s+dp9t3
 VDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731045693; x=1731650493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gwcJT32j32KKKz/tCRrugf9yi6vjemEK7dj9TrpBfM8=;
 b=kCOOrPoUbYvQjGvtJ+6edX+dm9Zu2L8BGa2ssP1lL9pfZFpg1i3rx39UwLcDtprmJw
 kEXly2rvDbX0yRJQmW7vwzF5iQHdpftZa/5XYgMHFU1OlVpHMXWE03mOA0QGHS7AX4vP
 LDVKYIex1oOjQ2RXLxFaNkkOhwWk1KitNP3ARWt9Vmetj+9H69GekJMm3dep7fr7Ftqg
 W4iY/U1Xoklqxs7cnPMFuEEi8ShL2Ia2QVPiB6X6mahLchBigWQshhL5Bydx59fhzPuO
 iZcSy5y5v6u8YhuQlDVkzYJphXq5ALLRbKGWincgOgWzDiksNOPsVC91G1JXdyh+fobi
 BB7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo2UM2Fc+Y6CiSZV+0ZadUhSwvXa9+P8sL8k2C4EovyUtlRKmX51GEIttl07yadpx8OySIeezX8LZl@nongnu.org,
 AJvYcCUplrwdAPMb8Kris0m21dOym0cxmsJ2+NJa4DiO8ybt4Ov88VZ2sO1ajBoSt7aoiWkLYWjqn7q/MGzmhQ==@nongnu.org
X-Gm-Message-State: AOJu0Yxw0dF3uA5OhbWx6MJWwKNrzV7Hbjv8ZV46dMMhlm26HfRlM921
 3tNFXyaG1zDYBLmwzt0qUBs/a3YRe74+ewtNXCBb+68NDYqPvzQc
X-Google-Smtp-Source: AGHT+IFvGZJ/rgYEPquMXFmnviIlzELVLlM0WTt293QJNFx2UBznqdMH3eLtHxNacDoNu7LyPomuSQ==
X-Received: by 2002:a05:651c:221b:b0:2fb:8de8:7f9e with SMTP id
 38308e7fff4ca-2ff201118cdmr5791831fa.1.1731045693125; 
 Thu, 07 Nov 2024 22:01:33 -0800 (PST)
Received: from hades.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ff178ee325sm5159001fa.27.2024.11.07.22.01.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Nov 2024 22:01:32 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 6/7] target/riscv: Apply pointer masking for virtualized
 memory accesses
Date: Fri,  8 Nov 2024 09:01:15 +0300
Message-Id: <20241108060116.37397-7-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241108060116.37397-1-baturo.alexey@gmail.com>
References: <20241108060116.37397-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
---
 target/riscv/cpu.h                      |  2 ++
 target/riscv/cpu_helper.c               | 19 +++++++++++++++++++
 target/riscv/insn_trans/trans_rvh.c.inc | 11 +++++++++++
 target/riscv/translate.c                |  4 ++++
 4 files changed, 36 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 11e3a6d647..6bbd9c6c25 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -634,6 +634,7 @@ FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)
 /* If pointer masking should be applied and address sign extended */
 FIELD(TB_FLAGS, PM_PMM, 29, 2)
 FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
+FIELD(TB_FLAGS, PM_VPMM, 32, 2)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
@@ -773,6 +774,7 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
 bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
+RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env);
 int riscv_pm_get_pmlen(RISCVPmPmm pmm);
 
 RISCVException riscv_csrr(CPURISCVState *env, int csrno,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 78b461a5cf..4065809d9f 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -213,6 +213,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     flags = FIELD_DP32(flags, TB_FLAGS, AXL, cpu_address_xl(env));
     flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
     flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
+    flags = FIELD_DP64(flags, TB_FLAGS, PM_VPMM, riscv_pm_get_virt_pmm(env));
 
     *pflags = flags;
 }
@@ -260,6 +261,24 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
     return pmm;
 }
 
+RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env)
+{
+    RISCVPmPmm pmm = PMM_FIELD_DISABLED;
+#ifndef CONFIG_USER_ONLY
+    int priv_mode = cpu_address_mode(env);
+    if (priv_mode == PRV_U) {
+        pmm = get_field(env->hstatus, HSTATUS_HUPMM);
+    } else {
+        if (get_field(env->hstatus, HSTATUS_SPVP)) {
+            pmm = get_field(env->henvcfg, HENVCFG_PMM);
+        } else {
+            pmm = get_field(env->senvcfg, SENVCFG_PMM);
+        }
+    }
+#endif
+    return pmm;
+}
+
 bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
 {
     bool virt_mem_en = false;
diff --git a/target/riscv/insn_trans/trans_rvh.c.inc b/target/riscv/insn_trans/trans_rvh.c.inc
index 03c6694430..ae067789d1 100644
--- a/target/riscv/insn_trans/trans_rvh.c.inc
+++ b/target/riscv/insn_trans/trans_rvh.c.inc
@@ -44,6 +44,14 @@ static bool do_hlv(DisasContext *ctx, arg_r2 *a,
     TCGv dest = dest_gpr(ctx, a->rd);
     TCGv addr = get_gpr(ctx, a->rs1, EXT_NONE);
 
+    bool is_hlvx = (func == gen_helper_hyp_hlvx_hu) ||
+                   (func == gen_helper_hyp_hlvx_wu);
+
+    /* Apply Zjpm pointer masking */
+    if (!is_hlvx) {
+        tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_vxl);
+    }
+
     decode_save_opc(ctx, 0);
     func(dest, tcg_env, addr);
     gen_set_gpr(ctx, a->rd, dest);
@@ -56,6 +64,9 @@ static bool do_hsv(DisasContext *ctx, arg_r2_s *a,
     TCGv addr = get_gpr(ctx, a->rs1, EXT_NONE);
     TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
 
+    /* Apply Zjpm pointer masking */
+    tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_vxl);
+
     decode_save_opc(ctx, 0);
     func(tcg_env, addr, data);
     return true;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 32df295123..d8f83315c6 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -104,6 +104,7 @@ typedef struct DisasContext {
     TCGv zero;
     /* actual address width */
     uint8_t addr_xl;
+    uint8_t addr_vxl;
     bool addr_signed;
     /* Ztso */
     bool ztso;
@@ -1239,10 +1240,13 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->cs = cs;
     if (get_xl(ctx) == MXL_RV32) {
         ctx->addr_xl = 32;
+        ctx->addr_vxl = 32;
         ctx->addr_signed = false;
     } else {
         int pm_pmm = FIELD_EX32(tb_flags, TB_FLAGS, PM_PMM);
         ctx->addr_xl = 64 - riscv_pm_get_pmlen(pm_pmm);
+        int pm_vpmm = FIELD_EX64(tb_flags, TB_FLAGS, PM_VPMM);
+        ctx->addr_vxl = 64 - riscv_pm_get_pmlen(pm_vpmm);
         ctx->addr_signed = FIELD_EX32(tb_flags, TB_FLAGS, PM_SIGNEXTEND);
     }
     ctx->ztso = cpu->cfg.ext_ztso;
-- 
2.39.5


