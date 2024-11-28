Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50920D69113
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 14:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGfGq-0005AA-DL; Thu, 28 Nov 2024 09:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tGfGp-00059r-4g
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:13:27 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tGfGn-0005wv-GG
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:13:26 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21288402a26so7174465ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 06:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732803204; x=1733408004;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jFc6IlNRnNduu1qhiN6zUJvi9doVv2GL0KddS1ZLVCE=;
 b=V8o2lS7C87Ut1HvU7b5vFrib7dVgXeUaApNTp05qdw4d7JrwiLmvwn1mKxPVQ9F8nB
 lbeucivLlK+8MUhD6IjUWAYH8FxNLI0Nug3v87Md23ZQmThLwfX+RWkT+zOi7RgMzNV0
 l+Lr1J/Nb2ahBEbvWRqTaNZBHO68PUnIfH6fpeEfKCrq3uzWKm9uFVbfbKQzj0C/wSiI
 CjJShbj16+QDP+H4JZzEs3cETsUmmAizbVe6YrwfOgZ+YO5DreV8HHomL1NneMOUvtZq
 jwu8b3fML1XUxc823hbnj8PkqoDx8SoxG/YO6TRB+7rGXYHIyVYIF0Xjc+xcHTRSJVXD
 9S0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732803204; x=1733408004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jFc6IlNRnNduu1qhiN6zUJvi9doVv2GL0KddS1ZLVCE=;
 b=JpiTHQy7TO8/Ahw2pzCZXO3sbbI3O9BV3PyUsQEZOva91i50iC9cu6Figg9QsbRlI/
 KKZbCIPwjdEDZRCQOh3bn/bm9HzcOqI8lu5abodHzV5zGFt0C8//gWbvmaBKoBxsOb1M
 iRVuMrFZIp+iMSNvI82OSbSL4DvHsQmSwUusblFl7imGeGkkEbDH7PJMMOx32oZPFNMo
 /wg2kHZITsckTkT49ep4clU1VmuI1VcjAbSaAiyQRJ8r8+JQZAPuzWVhzFPTNdfO4GKP
 0Nd43BTpr52uPAJ1/pEyFrOhbsA1drjeBdB9ygLDmREwLNwDbXlcqwDXmHbDg1gMsNrO
 8ygg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn+WslZ9LY5R/OWxK1hriIGVxUsImo88Q5Nd9LcM5vbGj0cszCL/JQ/ieoiuPXWRFe9PqD9YsRygOO@nongnu.org
X-Gm-Message-State: AOJu0YySNh+y2uxUN7x404CcwhHXjtnfBPl+G+vEjnGgzx/biaSu+huY
 PzD948nrlSoxLwfyEv8fedg33fHQcYlWC5AVQ/S2Q7BndYVKe/xixgw8PGyfwoc=
X-Gm-Gg: ASbGncvbv82awd5BOhywKq4vHbIgdnrjas84lRAMqcjvZzu2z69hnuhTZ8jx5uEm5vd
 DOQIFlvxFe5zi3OEkIibTQKAN5oPLpbw5+5g4BvbzkdUrC2XxwJoeVH0s4tO7V5p/YnFlXLwnUQ
 pU1F+FngT3SjQZldiN87QEk13+Dt+eUWAoNUTUL/yrzefHrpRXnBSFqxpcJEjbRzm7snHpJnJ3v
 HdPnEdbZ6ST4FO4yylpHfoeTI4X7ygcY3XqQqYxNvJh2ltctd0=
X-Google-Smtp-Source: AGHT+IGT+tDD/79Df6ifyy328H+X1dEXPZcRvLtGDWao3gTBbbUIDtAbqw0JSHHBAbcTkiWZCClOSw==
X-Received: by 2002:a17:902:d4cd:b0:20b:a10c:9bdf with SMTP id
 d9443c01a7336-215018582b1mr90360085ad.32.1732803204292; 
 Thu, 28 Nov 2024 06:13:24 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215218f452csm13829005ad.48.2024.11.28.06.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:13:23 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v6 4/9] target/riscv: Implement Ssdbltrp exception handling
Date: Thu, 28 Nov 2024 15:12:24 +0100
Message-ID: <20241128141230.284320-5-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241128141230.284320-1-cleger@rivosinc.com>
References: <20241128141230.284320-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=cleger@rivosinc.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

When the Ssdbltrp ISA extension is enabled, if a trap happens in S-mode
while SSTATUS.SDT isn't cleared, generate a double trap exception to
M-mode.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c        |  2 +-
 target/riscv/cpu_bits.h   |  1 +
 target/riscv/cpu_helper.c | 42 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f56ec7c927..1fac03ca99 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -287,7 +287,7 @@ static const char * const riscv_excp_names[] = {
     "load_page_fault",
     "reserved",
     "store_page_fault",
-    "reserved",
+    "double_trap",
     "reserved",
     "reserved",
     "reserved",
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index dcf63b7f32..ed33610b83 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -706,6 +706,7 @@ typedef enum RISCVException {
     RISCV_EXCP_INST_PAGE_FAULT = 0xc, /* since: priv-1.10.0 */
     RISCV_EXCP_LOAD_PAGE_FAULT = 0xd, /* since: priv-1.10.0 */
     RISCV_EXCP_STORE_PAGE_FAULT = 0xf, /* since: priv-1.10.0 */
+    RISCV_EXCP_DOUBLE_TRAP = 0x10,
     RISCV_EXCP_SW_CHECK = 0x12, /* since: priv-1.13.0 */
     RISCV_EXCP_HW_ERR = 0x13, /* since: priv-1.13.0 */
     RISCV_EXCP_INST_GUEST_PAGE_FAULT = 0x14,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 3fabd3379c..0525bfad48 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1848,6 +1848,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     bool virt = env->virt_enabled;
     bool write_gva = false;
     bool always_storeamo = (env->excp_uw2 & RISCV_UW2_ALWAYS_STORE_AMO);
+    bool vsmode_exc;
     uint64_t s;
     int mode;
 
@@ -1862,6 +1863,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         !(env->mip & (1 << cause));
     bool vs_injected = env->hvip & (1 << cause) & env->hvien &&
         !(env->mip & (1 << cause));
+    bool smode_double_trap = false;
+    uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
     target_ulong tval = 0;
     target_ulong tinst = 0;
     target_ulong htval = 0;
@@ -1985,6 +1988,30 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     mode = env->priv <= PRV_S && cause < 64 &&
         (((deleg >> cause) & 1) || s_injected || vs_injected) ? PRV_S : PRV_M;
 
+    vsmode_exc = env->virt_enabled && (((hdeleg >> cause) & 1) || vs_injected);
+    /*
+     * Check double trap condition only if already in S-mode and targeting
+     * S-mode
+     */
+    if (cpu->cfg.ext_ssdbltrp && env->priv == PRV_S && mode == PRV_S) {
+        bool dte = (env->menvcfg & MENVCFG_DTE) != 0;
+        bool sdt = (env->mstatus & MSTATUS_SDT) != 0;
+        /* In VS or HS */
+        if (riscv_has_ext(env, RVH)) {
+            if (vsmode_exc) {
+                /* VS -> VS, use henvcfg instead of menvcfg*/
+                dte = (env->henvcfg & HENVCFG_DTE) != 0;
+            } else if (env->virt_enabled) {
+                /* VS -> HS, use mstatus_hs */
+                sdt = (env->mstatus_hs & MSTATUS_SDT) != 0;
+            }
+        }
+        smode_double_trap = dte && sdt;
+        if (smode_double_trap) {
+            mode = PRV_M;
+        }
+    }
+
     if (mode == PRV_S) {
         /* handle the trap in S-mode */
         /* save elp status */
@@ -1993,10 +2020,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         }
 
         if (riscv_has_ext(env, RVH)) {
-            uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
-
-            if (env->virt_enabled &&
-                (((hdeleg >> cause) & 1) || vs_injected)) {
+            if (vsmode_exc) {
                 /* Trap to VS mode */
                 /*
                  * See if we need to adjust cause. Yes if its VS mode interrupt
@@ -2029,6 +2053,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         s = set_field(s, MSTATUS_SPIE, get_field(s, MSTATUS_SIE));
         s = set_field(s, MSTATUS_SPP, env->priv);
         s = set_field(s, MSTATUS_SIE, 0);
+        if (riscv_env_smode_dbltrp_enabled(env, virt)) {
+            s = set_field(s, MSTATUS_SDT, 1);
+        }
         env->mstatus = s;
         sxlen = 16 << riscv_cpu_sxl(env);
         env->scause = cause | ((target_ulong)async << (sxlen - 1));
@@ -2082,9 +2109,14 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->mstatus = s;
         mxlen = 16 << riscv_cpu_mxl(env);
         env->mcause = cause | ((target_ulong)async << (mxlen - 1));
+        if (smode_double_trap) {
+            env->mtval2 = env->mcause;
+            env->mcause = RISCV_EXCP_DOUBLE_TRAP;
+        } else {
+            env->mtval2 = mtval2;
+        }
         env->mepc = env->pc;
         env->mtval = tval;
-        env->mtval2 = mtval2;
         env->mtinst = tinst;
 
         /*
-- 
2.45.2


