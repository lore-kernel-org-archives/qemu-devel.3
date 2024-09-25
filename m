Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63E6C369D5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 11:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stQfC-0005lS-Qp; Wed, 25 Sep 2024 07:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1stQew-0004lt-NS
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:58:18 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1stQeu-0000g0-Jx
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:58:18 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cba6cdf32so62133805e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 04:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727265495; x=1727870295;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h97nUszG9qKo4bXzeGQ8cjaR38u/eSqQ0yAMBnAx8VQ=;
 b=J3vDJZZ3Y6JwR2kO4j2MF6IjuHaaDci68RbmXPV+bgMDxAOKYcDQUNIrIRbFKpEqyd
 nE+rQo2r7KWbbh1RvqY3MJBT+D2DmTP3nCMkSGpaRrp70WD49w962gtxPVwwm2FmE2zX
 I9ksM81toK1xrcKfgyLF61tthJw2XNl03yj1BOZk6DS0nSOvtWa4qAG/dZGFCauMygbT
 sagP2jTvgzuo+ZYGwtfWA4eE3FjICF+zkUgcNHNK4yaxhS6HrmlygmHFlXHljvIsicCb
 wAs8F/HZgE2lVX1zGdx3aiDxcg5F4gAaQTIc5WCgZ7oF5T7ONdJe3cLfDqF6/dfqipmg
 hiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727265495; x=1727870295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h97nUszG9qKo4bXzeGQ8cjaR38u/eSqQ0yAMBnAx8VQ=;
 b=mol/H/sqTOQzMWF86AjQqbGOHIuYlM1WlgiOS9KtcUBphPkxvP/RmhA8HqAAUqwC2V
 kvBonnGaJcbAbgeqNHpkntHENDd4PibF4wnTtS2MLX6EeCFJ4FDu93jsCOrYLBtj9ZcC
 VMsmCpnSyu4evXAbZzAvCnns/Q/7+jHWQqDJTm9d1EsXtn6SDQROVR5qiHVZCdE7G5ym
 MK9tXYwP8pze+0dnmuEUrvkHjGREZ6eexnwwhVxTJ98lNJK9pKma/2FWeVyPc58nCnEV
 sMKTeln1jZqKonve7y+b0FTcb/Z7qGh4DzaJGd9Hq7zO1MKUi63Ki6bKbv4DIZs+z0yy
 yRSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHKkQOxph/wMzn+owRvCkVf7j3smoERcKr8PHLy69Q0OkSCKQrDk09X3osTdYdpsNc+dHzS/fiJAo+@nongnu.org
X-Gm-Message-State: AOJu0YyY93rTPtFrnuSBNfUxbsBEfInEM+y9CFGTHoJLM7vRq8twhw5K
 aGvvku39jUwpOxJIw6GwHEDYD1rDx7otxICJJ1xZc6RFKNd4L/SA4WL52Eoq3yU=
X-Google-Smtp-Source: AGHT+IEux2+xmeRLkl6/aTHmFK4VN9m6gD69zhYir9hGxIxHWyzTFcMo4poXkhV+c6MN7/W9yQR81Q==
X-Received: by 2002:a05:600c:1c26:b0:42c:bb41:a079 with SMTP id
 5b1f17b1804b1-42e96103bbdmr18084935e9.1.1727265494770; 
 Wed, 25 Sep 2024 04:58:14 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc2ab52fsm3770612f8f.13.2024.09.25.04.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 04:58:13 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 3/8] target/riscv: Implement Ssdbltrp exception handling
Date: Wed, 25 Sep 2024 13:58:01 +0200
Message-ID: <20240925115808.77874-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925115808.77874-1-cleger@rivosinc.com>
References: <20240925115808.77874-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

When the Ssdbltrp ISA extension is enabled, if a trap happens in S-mode
while SSTATUS.SDT isn't cleared, generate a double trap exception to
M-mode.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/cpu.c        |  2 +-
 target/riscv/cpu_bits.h   |  1 +
 target/riscv/cpu_helper.c | 47 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cf06cd741a..65347ccd5a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -284,7 +284,7 @@ static const char * const riscv_excp_names[] = {
     "load_page_fault",
     "reserved",
     "store_page_fault",
-    "reserved",
+    "double_trap",
     "reserved",
     "reserved",
     "reserved",
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 3a5588d4df..5557a86348 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -699,6 +699,7 @@ typedef enum RISCVException {
     RISCV_EXCP_INST_PAGE_FAULT = 0xc, /* since: priv-1.10.0 */
     RISCV_EXCP_LOAD_PAGE_FAULT = 0xd, /* since: priv-1.10.0 */
     RISCV_EXCP_STORE_PAGE_FAULT = 0xf, /* since: priv-1.10.0 */
+    RISCV_EXCP_DOUBLE_TRAP = 0x10,
     RISCV_EXCP_SW_CHECK = 0x12, /* since: priv-1.13.0 */
     RISCV_EXCP_HW_ERR = 0x13, /* since: priv-1.13.0 */
     RISCV_EXCP_INST_GUEST_PAGE_FAULT = 0x14,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 395d8235ce..69da3c3384 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -575,7 +575,9 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
         mstatus_mask |= MSTATUS_FS;
     }
     bool current_virt = env->virt_enabled;
-
+    if (riscv_env_smode_dbltrp_enabled(env, current_virt)) {
+        mstatus_mask |= MSTATUS_SDT;
+    }
     g_assert(riscv_has_ext(env, RVH));
 
     if (current_virt) {
@@ -1707,6 +1709,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     CPURISCVState *env = &cpu->env;
     bool virt = env->virt_enabled;
     bool write_gva = false;
+    bool vsmode_exc;
     uint64_t s;
     int mode;
 
@@ -1721,6 +1724,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         !(env->mip & (1 << cause));
     bool vs_injected = env->hvip & (1 << cause) & env->hvien &&
         !(env->mip & (1 << cause));
+    bool smode_double_trap = false;
+    uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
     target_ulong tval = 0;
     target_ulong tinst = 0;
     target_ulong htval = 0;
@@ -1837,13 +1842,35 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                 !async &&
                 mode == PRV_M;
 
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
+                /* VS -> VS */
+                /* Stay in VS mode, use henvcfg instead of menvcfg*/
+                dte = (env->henvcfg & HENVCFG_DTE) != 0;
+            } else if (env->virt_enabled) {
+                /* VS -> HS */
+                dte = false;
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
         if (riscv_has_ext(env, RVH)) {
-            uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
-
-            if (env->virt_enabled &&
-                (((hdeleg >> cause) & 1) || vs_injected)) {
+            if (vsmode_exc) {
                 /* Trap to VS mode */
                 /*
                  * See if we need to adjust cause. Yes if its VS mode interrupt
@@ -1876,6 +1903,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         s = set_field(s, MSTATUS_SPIE, get_field(s, MSTATUS_SIE));
         s = set_field(s, MSTATUS_SPP, env->priv);
         s = set_field(s, MSTATUS_SIE, 0);
+        if (riscv_env_smode_dbltrp_enabled(env, virt)) {
+            s = set_field(s, MSTATUS_SDT, 1);
+        }
         env->mstatus = s;
         env->scause = cause | ((target_ulong)async << (TARGET_LONG_BITS - 1));
         env->sepc = env->pc;
@@ -1909,9 +1939,14 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         s = set_field(s, MSTATUS_MIE, 0);
         env->mstatus = s;
         env->mcause = cause | ~(((target_ulong)-1) >> async);
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
 
         if (cpu->cfg.ext_smrnmi && nmi_execp) {
-- 
2.45.2


