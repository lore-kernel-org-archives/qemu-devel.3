Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DF2D374A4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1RsK-00036j-EV; Thu, 17 Oct 2024 10:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1RsI-00034k-8M
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:53:14 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1RsF-0006uL-TO
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:53:14 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7e9e38dd5f1so818929a12.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 07:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729176790; x=1729781590;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7VKEtn5rFJqEDMMyFqWRlHYBbefKBg0QW1klzQG6OU=;
 b=RSMZMMkh00P9Y3qx5g/rKzLE/Y7xljqx+GqH/F5+lzGsbme7049eIDBSc6RdkDaRmy
 wsePWAbr5YGGaCADxAPeN84RRFbZJ/GDZtNi0/M3BVkr8F7FxZaaOJu7KJAF+7jIPmQI
 FkiY0ZS2gpXnOPQVHwGahlnkUBzSbrhodMhTwQtvkR+jC5pRVO4kJYsQWklaSZBCHYr4
 59sYC3cUVMwHQnOkEtP6FzRBG9Lfv2oXcrSKs9r2J3KVAU9urqpPoMDiYXCqwrrwMW05
 wTgCvHfJYtDkUMnHkDOLVDk6e0t1FSehrL8k0Ef0sgw61NWObkMeEWhga6HBf/GZwwgB
 6Mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176790; x=1729781590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7VKEtn5rFJqEDMMyFqWRlHYBbefKBg0QW1klzQG6OU=;
 b=uDUHfj4yQFEgRdK2if7GSNvhAlNIxZutnuhZdfZtewIE/m/Jycr0wi0upJoaOnz+vI
 8F2Ob+Ga0MMe9MSprNK5SIILFXbqjKWC9+UZDMbp62Le/OOjYeQ5gWWA7gM48EYqriZH
 p+cTVgWCm3QrWQmgeAdYK3H0u6UgwqNaW1n8behxX3pVP9xiEOaAI/72PKRhOn/aOC8y
 ed0vvdZBxBcmJbXtx1fElMgxph6tlk7RmrfZArAp9uACeRJ1d0m4Im3HxTuRxhiPKEyG
 Vduv3JQ3nQzx7WkmY1xw994PwAHYcLbXLWbSo2PlaHzUk16j9tMJFx3bjNYv7x4QiHNv
 iGnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs/MaHJpv7U5CaRZrrUCdMTPsTJ2LWfnQr9xjcVaK1WFp56ochKVgdBOXH8KBop1tEUmVAaWO7JTfK@nongnu.org
X-Gm-Message-State: AOJu0Yyiqx23FbWkUfJRD9UHAmRGsK4Sk92Sv4qinzS0JPnKU/klSEab
 by1AZyCR0LBwI7OKasAl7tF23yGpTX+zrIIX9JH3wdGHI/LrfIAGRFXLhbVXNw8=
X-Google-Smtp-Source: AGHT+IGaabGoe7Tp+cIaz7g8YGp0MIzjHfN+JbTmJ182ibOh54/kw4xjwOMFUjVI2cfJrv0KyYJHKA==
X-Received: by 2002:a05:6a21:150d:b0:1d4:e638:d066 with SMTP id
 adf61e73a8af0-1d905e99a93mr12398090637.6.1729176790404; 
 Thu, 17 Oct 2024 07:53:10 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e77371193sm4859580b3a.21.2024.10.17.07.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:53:09 -0700 (PDT)
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
Subject: [PATCH v4 4/9] target/riscv: Implement Ssdbltrp exception handling
Date: Thu, 17 Oct 2024 16:52:15 +0200
Message-ID: <20241017145226.365825-5-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241017145226.365825-1-cleger@rivosinc.com>
References: <20241017145226.365825-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=cleger@rivosinc.com; helo=mail-pg1-x531.google.com
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
index fed64741d1..5224eb356d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -285,7 +285,7 @@ static const char * const riscv_excp_names[] = {
     "load_page_fault",
     "reserved",
     "store_page_fault",
-    "reserved",
+    "double_trap",
     "reserved",
     "reserved",
     "reserved",
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 08cc5b2e22..0d0f253fcb 100644
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
index b9f36e8621..623a3abbf7 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1715,6 +1715,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     CPURISCVState *env = &cpu->env;
     bool virt = env->virt_enabled;
     bool write_gva = false;
+    bool vsmode_exc;
     uint64_t s;
     int mode;
 
@@ -1729,6 +1730,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         !(env->mip & (1 << cause));
     bool vs_injected = env->hvip & (1 << cause) & env->hvien &&
         !(env->mip & (1 << cause));
+    bool smode_double_trap = false;
+    uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
     target_ulong tval = 0;
     target_ulong tinst = 0;
     target_ulong htval = 0;
@@ -1839,13 +1842,34 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
         if (riscv_has_ext(env, RVH)) {
-            uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
-
-            if (env->virt_enabled &&
-                (((hdeleg >> cause) & 1) || vs_injected)) {
+            if (vsmode_exc) {
                 /* Trap to VS mode */
                 /*
                  * See if we need to adjust cause. Yes if its VS mode interrupt
@@ -1878,6 +1902,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         s = set_field(s, MSTATUS_SPIE, get_field(s, MSTATUS_SIE));
         s = set_field(s, MSTATUS_SPP, env->priv);
         s = set_field(s, MSTATUS_SIE, 0);
+        if (riscv_env_smode_dbltrp_enabled(env, virt)) {
+            s = set_field(s, MSTATUS_SDT, 1);
+        }
         env->mstatus = s;
         sxlen = 16 << riscv_cpu_sxl(env);
         env->scause = cause | ((target_ulong)async << (sxlen - 1));
@@ -1913,9 +1940,14 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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


