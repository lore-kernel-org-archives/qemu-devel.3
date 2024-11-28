Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5200CD69113
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 14:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGfHQ-0005vf-LU; Thu, 28 Nov 2024 09:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tGfHL-0005dl-4e
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:13:59 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tGfHH-000669-JM
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:13:57 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-724d8422f37so804067b3a.2
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 06:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732803234; x=1733408034;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Nv58FYpnM7owBpC7KsSmszH2TLrrLmHRGoBsSTg858=;
 b=1xyLNQIlqMre0v5m1LxLF+vUs2ANCuCw3sGCJi6jz/IzE67+O8Ugj6gGyVrx85hEaw
 QFQPHE11E4uUwXXfFE6JforaNNzjS4U0esbWof13dmzediWPPXbdJyhPOgfPrbmAt6nf
 t6akI96yRJQ7hh24Z5MYkSecxAa8W/iFA6toaGmJtQHbTyVCbs143AcpuuFfAx7fCi2T
 Ukr8MZJqmjuPm2dzjSclRpUeCHUIvvEvS0xkaPCeR0nnIF257zPdKug2YjSFytaQTGa1
 s+pDpyG3GLEmpOZ2zoifKbxJgl3pq4D09wOtJ4rxqVj+0S7PaheuL/PVVIYnLI1k/F/a
 fGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732803234; x=1733408034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Nv58FYpnM7owBpC7KsSmszH2TLrrLmHRGoBsSTg858=;
 b=VaTAwXV25KtMvgJRIwcbnYkCitzBDfvCOLLiG6MXU2RNV1JVoy3Rb+Hl1auJzZN9/O
 ldByeDC7FyUDunLJIj8B98XeRptnA3CRT46fSmvGpmsyLxtnzmdr4WLM3Jnl27BsCpHH
 JBt5wpDXsNgMP7k5q1PI9C5svLRTqnBYnoyFQ0nSAFffSAVOIGCvUgmRQ9x4Y/ImCX+9
 m5qnZisemPFF7F9lO9egeiD2KgLzSzsiu68kxdKzzmrKcCRcK02TaWwa7NXwowI+wIsT
 dkAuVO7ftSjLDKVBmPvViziUjyuo5FVHvgE5nhtHaD0X2Aljp2VPuznNg8gZeATfrLHk
 LdwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9KAMBnRKDKj5Tw47PTwzMvnqV+uNCzA/ZbAsKprolnRJunAH6kvKv4hEhkNYtgrW1Py72tLdaX/NB@nongnu.org
X-Gm-Message-State: AOJu0Yzhm6b8Jjf1KB8frCMtY+khs8wmHE83EtmvCs7h6NQ8UCU+bTds
 nMXgTLgWGSR8MuzaR4+Nmb3GSMiEwUI6VvlzhBEtuJgTE1p6tRLdoipVlTAsjd8=
X-Gm-Gg: ASbGncus5ittUNRZdE6Gq12kHcIILd0hzvymM1FtvgrxMGzvh9ZGFndA5MWGQ0QdPbG
 lRjPxX+dvP18LFagg/8q7RRZlO+QDDYqJPWgEuUfykXNur+9ot0UWUQ3Cm8sbs+jZw0AKxrfSLm
 8/U1mZlxVwZ/GPNmjP1Kv7aXijgzsxzTSwnU+PUc96o2pZmsAivC7uDSUuGdFaTD87nDWtz9VAO
 P+fzbnZETBI95WoZcoHr2TzQRPd3Fpoh1dzhS4eYB8BvfeSoIE=
X-Google-Smtp-Source: AGHT+IEaFeEFh3xOHmzfPqrm/lV9EtxNF4t/TvFa+7dvmIHZuqdpmaKlYGYQ7CRQqbzNjIYM1Z0XhQ==
X-Received: by 2002:a17:902:e84a:b0:20c:6b11:deef with SMTP id
 d9443c01a7336-21501e5c036mr96258615ad.48.1732803234036; 
 Thu, 28 Nov 2024 06:13:54 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215218f452csm13829005ad.48.2024.11.28.06.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:13:53 -0800 (PST)
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
Subject: [PATCH v6 8/9] target/riscv: Implement Smdbltrp behavior
Date: Thu, 28 Nov 2024 15:12:28 +0100
Message-ID: <20241128141230.284320-9-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241128141230.284320-1-cleger@rivosinc.com>
References: <20241128141230.284320-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=cleger@rivosinc.com; helo=mail-pf1-x42d.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 56 ++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0525bfad48..f46be166f6 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1835,6 +1835,23 @@ static target_ulong promote_load_fault(target_ulong orig_cause)
     /* if no promotion, return original cause */
     return orig_cause;
 }
+
+static void riscv_do_nmi(CPURISCVState *env, target_ulong cause, bool virt)
+{
+    env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, false);
+    env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPV, virt);
+    env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPP, env->priv);
+    env->mncause = cause;
+    env->mnepc = env->pc;
+    env->pc = env->rnmi_irqvec;
+
+    if (cpu_get_fcfien(env)) {
+        env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP, env->elp);
+    }
+
+    riscv_cpu_set_mode(env, PRV_M, false);
+}
+
 /*
  * Handle Traps
  *
@@ -1874,22 +1891,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
-
-        if (cpu_get_fcfien(env)) {
-            env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP, env->elp);
-        }
-
-        /* Trapping to M mode, virt is disabled */
-        riscv_cpu_set_mode(env, PRV_M, false);
-
+        riscv_do_nmi(env, cause | ((target_ulong)1U << (TARGET_LONG_BITS - 1)),
+                     virt);
         return;
     }
 
@@ -2101,11 +2104,32 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
-- 
2.45.2


