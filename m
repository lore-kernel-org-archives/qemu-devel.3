Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD57D16245
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 11:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0J9v-0006Xs-0C; Mon, 14 Oct 2024 07:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t0J9r-0006VT-MV
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:22:39 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t0J9p-0002cV-PA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:22:39 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37d4a5ecc44so2953341f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 04:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728904956; x=1729509756;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Xvl0BCdfuSbxLN2r2iyzpL1Dr4H5UKtM3MitHEn5Ro=;
 b=vN+gZ/Ze+Jpr9YUr7RTD0bsowZTVgPb/7PDg4nsxvuGv0knpFZgOd8ZQuiX6g6Guzr
 HUnYjGh3D4a+wbhmRGEppNwrwGjup2Vj4Ie1izB3SMb/LhmVJhiteasZfO9lURXYjj2I
 EEzp7Vg0fVu/aeDieGJAmTN/lkyuMt6C5u975ZWEz/gSWqS3ciUAME0jp2xx4pAtf4i6
 5dN+jRMFZfM08pKjD5+4yzclrEx8RBKFxFhxBoNKYIuC7jMMKi+uhX1sr4iB/aPZvidW
 aCwoanPfcxs6EMk7xufVG1ZBpeV5nWtkrwlv0OLvmnDdUQum+HoxkRhGE0IMSlTt//Zv
 cnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728904956; x=1729509756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Xvl0BCdfuSbxLN2r2iyzpL1Dr4H5UKtM3MitHEn5Ro=;
 b=S65zlL1AMkLKd88kYWRZQHq10KIdfFitL5R3W93Bx/kD/X89bUZUorCzPudKBL0xV4
 iaP9DjWIJXbuvcQU3hoZsXMpCx2Ql1MSeoShV5DjciHIYLuMoXzhVh2gPPEm1MS1PT2o
 acC/9ELe0+IiXgj5CFi+76o6vM4k5SLkEJ7aJhR0rxTAZHOHCwUpuOXSo19XjHJxr7WE
 Y4tWScWedYKdHJVQ94uI6sSSiSwSwn0v0DoDMgOwtcFWXWB+5VP8TlrCHQXASVVmkICw
 eC7k+F2pnIRG1s+OgqWVMRH/nVfXLsLUf3AQAwnm+0bAxzvf7x+Vk1x4ImSDZzKDMso1
 inUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC6yw/EnGGH+Hpor+/Wf4rGu16UiUTtu9zleC/kBwkCgjoJPgL+/Aug0Ib9Ob4qGcD7s89fd7Ajcxm@nongnu.org
X-Gm-Message-State: AOJu0YyP6gjXyPgT+bH0Sm3wMQoI88Omx+9OQR1uP0YPwELb53Rzf0QP
 KuNzsKpxBlHFLZutxWk05F25zoYJJi3eQPaA4bk+niE1Py8wf+x5+sF0ODoAChM=
X-Google-Smtp-Source: AGHT+IFTB/L7tF0axs2brZvg17fG9mIyc4+5Q2dmhE3fpbB1PWz/09HLp4+yLKbAmiQis3S/zP/xSA==
X-Received: by 2002:a05:6000:1d0:b0:374:cd3e:7d98 with SMTP id
 ffacd0b85a97d-37d551e3caamr8208016f8f.19.1728904955744; 
 Mon, 14 Oct 2024 04:22:35 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b6bd382sm11117303f8f.43.2024.10.14.04.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 04:22:35 -0700 (PDT)
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
Subject: [PATCH v3 3/8] target/riscv: Implement Ssdbltrp exception handling
Date: Mon, 14 Oct 2024 13:22:13 +0200
Message-ID: <20241014112225.90297-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241014112225.90297-1-cleger@rivosinc.com>
References: <20241014112225.90297-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x42a.google.com
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
---
 target/riscv/cpu.c        |  2 +-
 target/riscv/cpu_bits.h   |  1 +
 target/riscv/cpu_helper.c | 42 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 39 insertions(+), 6 deletions(-)

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
index 77e7736d8a..5173155070 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1711,6 +1711,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     CPURISCVState *env = &cpu->env;
     bool virt = env->virt_enabled;
     bool write_gva = false;
+    bool vsmode_exc;
     uint64_t s;
     int mode;
 
@@ -1725,6 +1726,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         !(env->mip & (1 << cause));
     bool vs_injected = env->hvip & (1 << cause) & env->hvien &&
         !(env->mip & (1 << cause));
+    bool smode_double_trap = false;
+    uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
     target_ulong tval = 0;
     target_ulong tinst = 0;
     target_ulong htval = 0;
@@ -1841,13 +1844,34 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
+                /* VS -> VS, use henvcfg instead of menvcfg*/
+                dte = (env->henvcfg & HENVCFG_DTE) != 0;
+            } else if (env->virt_enabled) {
+                /* VS -> HS, mret/sret always reset dte to false */
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
@@ -1880,6 +1904,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         s = set_field(s, MSTATUS_SPIE, get_field(s, MSTATUS_SIE));
         s = set_field(s, MSTATUS_SPP, env->priv);
         s = set_field(s, MSTATUS_SIE, 0);
+        if (riscv_env_smode_dbltrp_enabled(env, virt)) {
+            s = set_field(s, MSTATUS_SDT, 1);
+        }
         env->mstatus = s;
         env->scause = cause | ((target_ulong)async << (TARGET_LONG_BITS - 1));
         env->sepc = env->pc;
@@ -1913,9 +1940,14 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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


