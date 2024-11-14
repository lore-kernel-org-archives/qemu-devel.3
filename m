Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6AED65C61
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 09:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBVw3-0000TG-Br; Thu, 14 Nov 2024 04:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tBVvL-0008L8-H8
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 04:14:00 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tBVvH-0007iP-UV
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 04:13:59 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d49a7207cso243015f8f.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 01:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731575632; x=1732180432;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rhsOIHC2GPGhTuIUOV5OrweCSoluniZqBwzjLjieyy0=;
 b=ORRTONr1iM4q7OQhDCpuftApwxYYSeb6rjvj/vtaiH4xFhptagunhFUxyzI77VW1yF
 epP1fcP9n8dA9gCvYh0ES2qKyVPqT5Bjx0K6DJyQN03E5gyZjGOmOiXzTnrfj16MVJZU
 +o/UOA06A6qXbhFZ8bqxw4AIZBWBpBbQ3JkBmVVfkrdxqmgd3wV4R/OaYNmsDjmfky70
 2+cdkk+B6+RVf13dWK8ADi9nrB2NFr5spAd1cElVX+JrkoPZZ36psjRHR4hMtETiN61p
 QxKxofKB2SslIz4ZmORXJTpqxz8Vdens9U1GMes99eSIddoZ5jz0fPJDvV8etsdCbYBm
 jpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731575632; x=1732180432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rhsOIHC2GPGhTuIUOV5OrweCSoluniZqBwzjLjieyy0=;
 b=W46MgdsD1P2vRRQHif2kZHhT/PFNVms0NahEhdrJ+6//MTjgIxGW4USjROzGaFenZW
 fK4/VD6NLYAxJsx1/Mg89ZlL7nVc031ehpUNqLUncIVqgvd4uUUWbiGIgAjlXFFlPwNN
 ZFZgdrJMAzMchb5tRBDlqUW9aauhqhASNh7bNBUyWnIlsQTqt6ArnmoeUCWGivsExBZ0
 ukPS0q9sNZ1KuGgPjIVuAC4Oc7GFHkb3YdL/3kVoUZzDsySWhc7MUWqLxS/PS12Kt7bD
 YmHwqRKVYkk+ZZnqvLmjT2aBXxr5xay07beD+FsuPBWvgXbY8ne/aim1BVB/wauqFuje
 WWlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZWUXgo3O3Na52so7/CqKTg7eYXvyQFQeGDIIi090eDmFTdDJCrEPsNeL9FtXKEp1e2DIFBCBpBU+1@nongnu.org
X-Gm-Message-State: AOJu0YxW2gImJAFQK2JnIMTzXKVetIo11fGRzCacl4rLmPrJowV76R6Y
 a94J3YOBr6aA5F9LJ2i+el6703gv1UVUT/2LWckgeaeSPOeT926Rui/YXjX2yZA=
X-Google-Smtp-Source: AGHT+IE1jEjtcZStucPGHvWfPm7tNwdJGb58mm7Ps0ze9doZWu8W46uB6Y6On+JLC/aJcdMpKFjHSQ==
X-Received: by 2002:a05:6000:400c:b0:381:c7b7:706d with SMTP id
 ffacd0b85a97d-3821851c9c4mr1368506f8f.27.1731575632370; 
 Thu, 14 Nov 2024 01:13:52 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae313e3sm899050f8f.94.2024.11.14.01.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 01:13:51 -0800 (PST)
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
Subject: [PATCH v5 8/9] target/riscv: Implement Smdbltrp behavior
Date: Thu, 14 Nov 2024 10:13:29 +0100
Message-ID: <20241114091332.108811-9-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114091332.108811-1-cleger@rivosinc.com>
References: <20241114091332.108811-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

When the Smsdbltrp ISA extension is enabled, if a trap happens while
MSTATUS.MDT is already set, it will trigger an abort or an NMI is the
Smrnmi extension is available.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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


