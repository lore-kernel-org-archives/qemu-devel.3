Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED84AD374A4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Rsm-0003tz-3K; Thu, 17 Oct 2024 10:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1Rsk-0003qe-6p
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:53:42 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1t1Rsi-00070z-Bd
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:53:41 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71e72db7bb1so773321b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 07:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729176819; x=1729781619;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QKxvrf0dTngB2C0JmQktNzjOfh8FzNJmWvUwBe6YVeI=;
 b=b26PrZwsZQg0f41BspkEFoXJHEg4LsTwjMNZ6ReN4qJknR+cwBN7IrQbz/DK/pgQ8z
 2uX2S3NIq+VUDpIHJ0OGTQpVEoFl5E56BW9NkB6huQYOq/zrYmdmw6gibI2Gm+28o8o3
 Z2rCEOqahKOT8u3OE2ZCiMevcAWg+Y7+eJHzyGlZ8RLDnmEU9EhGgSuh06gTsqe2WCLz
 RmNvfnjn4LhIi5uGjFIYFqWXDyEIPlLuVJCMcfhjclBoO2USMYPpP+/uSFFQIj2jOR9m
 PQh4xhSvZUX1f8Advp+bib5oxV8pDH5L8NU5nsmP2mg+nn/ZWyDs7EUYwFIAVhm7r6vb
 wxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176819; x=1729781619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QKxvrf0dTngB2C0JmQktNzjOfh8FzNJmWvUwBe6YVeI=;
 b=W7plQPyHCbHCL26R4CjblcAChYkaWrKsZmNTQmODL4cua0LKeQHTbqdxNNP6pMCrFV
 2DdLtcQXZoAyhNKhpXNRB8PJIHhi37vG9zYjtuMEuuWgJqFiSB+u86k7KaKOkSnML/m0
 1M2Q1tU/8BlXlMPeghT4wlEqlSZzFv2xDdAhxC/EB9Im6rst7QYtFrTTj10T1Wm3I9Xc
 2/EwRcabms5ruK9eAd24NiYOZ7HV6eoxF3U+ZZQEJyypN+9q0tcf9epxGxs/2xPtt6jI
 uE6nFOLy0ZLD2OTPak061qw9iZFeFwG0uXueB5CQVSv6VidbeOXhzReBjwJ5TDeAhI9e
 27Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEO9Qk57Mk43MGls9v2gYSVZoOfrn/mb8BcX1VATRv1vpaAtQTg4Ug17a3GjDx6Dbf0Hb5RyqIs/5p@nongnu.org
X-Gm-Message-State: AOJu0YyDWSy1aJbXNRzHELW3GnCsCXVy4bWJpWSYthzgDFbjEFcvVheY
 M5GYrZiJ9I2Bh3qV0+8/EIIyJLf6P1kS/aMjmvbDdgFaAEML9xxPfeYQu3GcgXw=
X-Google-Smtp-Source: AGHT+IFBYMSMUuHWTJT5HgywUkhjyyitzsHBegi8w1C/PWmt50LkAZTvj8EzoTIL3bGvcS3LH9/bRg==
X-Received: by 2002:a05:6a00:b8b:b0:71e:6f4d:1fa4 with SMTP id
 d2e1a72fcca58-71e6f4d21cdmr16186362b3a.10.1729176819060; 
 Thu, 17 Oct 2024 07:53:39 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e77371193sm4859580b3a.21.2024.10.17.07.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:53:38 -0700 (PDT)
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
Subject: [PATCH v4 8/9] target/riscv: Implement Smdbltrp behavior
Date: Thu, 17 Oct 2024 16:52:19 +0200
Message-ID: <20241017145226.365825-9-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241017145226.365825-1-cleger@rivosinc.com>
References: <20241017145226.365825-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=cleger@rivosinc.com; helo=mail-pf1-x42c.google.com
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

When the Smsdbltrp ISA extension is enabled, if a trap happens while
MSTATUS.MDT is already set, it will trigger an abort or an NMI is the
Smrnmi extension is available.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/cpu_helper.c | 52 +++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 623a3abbf7..8825572d5e 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1703,6 +1703,17 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
     return xinsn;
 }
 
+static void riscv_do_nmi(CPURISCVState *env, target_ulong cause, bool virt)
+{
+    env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, false);
+    env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPV, virt);
+    env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPP, env->priv);
+    env->mncause = cause;
+    env->mnepc = env->pc;
+    env->pc = env->rnmi_irqvec;
+    riscv_cpu_set_mode(env, PRV_M, false);
+}
+
 /*
  * Handle Traps
  *
@@ -1741,15 +1752,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     bool nnmi_excep = false;
 
     if (cpu->cfg.ext_smrnmi && env->rnmip && async) {
-        env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, false);
-        env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPV,
-                                  env->virt_enabled);
-        env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPP,
-                                  env->priv);
-        env->mncause = cause | ((target_ulong)1U << (TARGET_LONG_BITS - 1));
-        env->mnepc = env->pc;
-        env->pc = env->rnmi_irqvec;
-        riscv_cpu_set_mode(env, PRV_M, virt);
+        riscv_do_nmi(env, cause | ((target_ulong)1U << (TARGET_LONG_BITS - 1)),
+                     virt);
         return;
     }
 
@@ -1932,11 +1936,32 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             /* Trapping to M mode, virt is disabled */
             virt = false;
         }
+        /*
+         * If the hart encounters an exception while executing in M-mode,
+         * with the mnstatus.NMIE bit clear, the program counter is set to
+         * the RNMI exception trap handler address.
+         */
+        nnmi_excep = cpu->cfg.ext_smrnmi &&
+                     !get_field(env->mnstatus, MNSTATUS_NMIE) &&
+                     !async;
 
         s = env->mstatus;
         s = set_field(s, MSTATUS_MPIE, get_field(s, MSTATUS_MIE));
         s = set_field(s, MSTATUS_MPP, env->priv);
         s = set_field(s, MSTATUS_MIE, 0);
+        if (cpu->cfg.ext_smdbltrp) {
+            if (env->mstatus & MSTATUS_MDT) {
+                assert(env->priv == PRV_M);
+                if (!cpu->cfg.ext_smrnmi || nnmi_excep) {
+                    cpu_abort(CPU(cpu), "M-mode double trap\n");
+                } else {
+                    riscv_do_nmi(env, cause, false);
+                    return;
+                }
+            }
+
+            s = set_field(s, MSTATUS_MDT, 1);
+        }
         env->mstatus = s;
         mxlen = 16 << riscv_cpu_mxl(env);
         env->mcause = cause | ((target_ulong)async << (mxlen - 1));
@@ -1950,15 +1975,6 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->mtval = tval;
         env->mtinst = tinst;
 
-        /*
-         * If the hart encounters an exception while executing in M-mode,
-         * with the mnstatus.NMIE bit clear, the program counter is set to
-         * the RNMI exception trap handler address.
-         */
-        nnmi_excep = cpu->cfg.ext_smrnmi &&
-                     !get_field(env->mnstatus, MNSTATUS_NMIE) &&
-                     !async;
-
         if (nnmi_excep) {
             env->pc = env->rnmi_excpvec;
         } else {
-- 
2.45.2


