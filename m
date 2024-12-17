Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F73E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 09:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNTYH-0008U9-Jn; Tue, 17 Dec 2024 04:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tNTY4-0008NC-3n
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:07:25 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tNTY1-0001Z7-Qr
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:07:23 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so2734123f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 01:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734426440; x=1735031240;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCg28i4MG0lkw6euk86rkXCzW2QK+WzYLzj3FP0/alY=;
 b=zUZzJ8PMz1Wv95DaFSYVM5SWfDfzFX1/rshm1Cq/GqFOmGgAoNxwx1y76/bGqz1k9R
 ZSGL7U75CDvu82Soqz03uey7faI9qKYMr4cO9wfw3AgcJ4yiXt5esywbs++I7YZiNNa8
 TSb1ny64Z4B5iEHwf7uH8D+FVuX0MoNR6eZVDf70n/eeztVmAez+nwQEX1r6KBZ8gvlG
 lUZi0sXPnmgW5qzPeR8cWizJfIdPf+shs3HYk1pohkiypk6nKDMPcSSsbGf0n5BjeY/p
 AxYPBa25YuqsEgMyTo1lRaJZHTJrYO2rVXLLQVUJzGZuqKw8RfBNMciOJ6RAN2kG590l
 //7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734426440; x=1735031240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vCg28i4MG0lkw6euk86rkXCzW2QK+WzYLzj3FP0/alY=;
 b=baHa7YVXF4qAagoJaQJhbs7TPtxKIMb6RlAtGmKBmwzEEoZYKbBRtvu5kKDLcDHWDg
 ngYCGkkO5DiSZRZZmGZjXv7FcTLslFjSVplz5cY728FtRYZhs1tjWxC5l/neGeL3skDw
 bO5ur7x5V1+/Mi4LTNGAPJhDiA/DOwGMZSh5nMvUnSI/Ml1v/phTOZmE/x4Yki+qCUj5
 yG0JFtZttskAskZDNM7/J/jucMUIyX3sQPlb2IIe8PvUaHCmJTyI0KYvEfsLBRXUIG0h
 byQ+7Tz9YWI6W8MjcG7lHMtgTRgSdW77I5Idvjb4DEAehqTNwrWq9+U/EoVGZ2cSvBix
 2hhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFvWQG/Owf7xGxsscWDppr0AS1XZeDAp4TclECPh+68r47V65B2GMXPMtIKKE9Tx18sXRJcH3SY7X7@nongnu.org
X-Gm-Message-State: AOJu0Yxz59mI6ZTfe5ehQ0pJrCTspCS1hmN8BlIaLDgsPRydZck2edyP
 wa17H68Sk6almNnyrvVcFeems/Tk/PdA3d+dVSRF4luaR2f7I53ovRNJCFADbfM=
X-Gm-Gg: ASbGncs9YgXXUO5/y4hkAW9Aq3QotZsNihVedmEqzRMdz/nO9Gpu937mexM/nX9UuA7
 RCsON7X/bVR+lHo2IgrELJqoukmxEiOHSxeDfrYZeyR5XxUqhMryMoKUbLNjrJQd5cMEO4xtOoK
 U5wZXAvIkoeD+4nIOSFAu9mpVf0SwCm1Nn4cWOdIjCeAIcfzFtKHQemHIrzHQaOoizUMJYZNjFL
 JbQVpuTBVcrw+y+8JH1fB1sR5sIgdTpwwyYyiqeifDy8+4b/4nIkYzy6w==
X-Google-Smtp-Source: AGHT+IGWTCP6sFTgOlfzC5opaKGlRIWR9mmwsF6kiZgjz4DM9QbiduFGHi2OOKwXdIT/t9BsKP1poA==
X-Received: by 2002:a5d:6d06:0:b0:382:6f3:a20f with SMTP id
 ffacd0b85a97d-388da380c5amr2568890f8f.11.1734426440148; 
 Tue, 17 Dec 2024 01:07:20 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8046c46sm10704122f8f.71.2024.12.17.01.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 01:07:19 -0800 (PST)
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
Subject: [PATCH v7 8/9] target/riscv: Implement Smdbltrp behavior
Date: Tue, 17 Dec 2024 10:07:04 +0100
Message-ID: <20241217090707.3511160-9-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241217090707.3511160-1-cleger@rivosinc.com>
References: <20241217090707.3511160-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x436.google.com
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
index 06d5dc6a3d..a29483f48d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1890,6 +1890,23 @@ static target_ulong promote_load_fault(target_ulong orig_cause)
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
@@ -1929,22 +1946,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
 
@@ -2156,11 +2159,32 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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


