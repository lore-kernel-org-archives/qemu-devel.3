Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA57AEEB565
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 08:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sofVx-0003rE-BH; Thu, 12 Sep 2024 04:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sofVV-0001ri-Te
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:48:54 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sofVT-0000Li-BA
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:48:52 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cb0f28bfbso5698315e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 01:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726130930; x=1726735730;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o961jt+tkXgagOiy0R3at1ff5f3NvYQ/iAvwybcevIw=;
 b=iJu+dML3PfePROlE8LYIf0nlgazZDLK4VNBGSESzXrnhL738QbdN5fi3QJW8T0yP3h
 vAYNg8GUg5Dy38B689GKC//4WWjZ4Kl1ZqXvcf/Frd1o9CXhxkwYdFSHik1ltODhF64C
 mWB3cnZK2iPICLM0grkDEc2qGXB5r+HAsVvSGtWJNhVDHFnSm5/3bLuE3CrhcZfLc3uj
 LF1s33aqlYhIK9BvMoUlPoyr41TPOPCdZ75eqja0AT5xrJWpwp6UbB8icouK/tGLTHFA
 oyhFgDTlymH2aNFtPObiDEEMubfjPqwNxpADJka0WwR6VRpFjFfU0DjnSwjwBop5OmmS
 3kWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726130930; x=1726735730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o961jt+tkXgagOiy0R3at1ff5f3NvYQ/iAvwybcevIw=;
 b=hAJv9/G9vb11PYNTvjbqyRLehwlN5I6tVeGKNn42ujJ9AYROJJwbLSGvRgPwjdNt//
 56mA0B/CaNCuqn56UaWo6kDdUShvo0989cUwDjTUmv7zbKCjTNqhjc19/WaRBOYLriSv
 EdQhv+CCRRLedcypvsOLVQNAyTy855YDiJfUM9xHeyWr1gKLxJJ82Z+A0ReLzVOeBRfr
 FSj23P0aZ2/44KAeETLWFW9sO1GRrgSgMmUFQPOcblAh91qeo4xMHizvPxjg6+SXe4YW
 T/QGAqfHF3wMveQ6MZWWh3+6P0UtGjNdhcCa9NhiP0Xoko6rH51Fi18cxlMmJxJQvjsd
 pPVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBg+jqcEhIqkvUy/87XXfPBkw1IO+gUrcKTuPvxDl5FG5xoPnh6EPfOPhvOFId+Yd7mGQkXIRCF+4e@nongnu.org
X-Gm-Message-State: AOJu0YzDz1bR4Apy2znZ5iqtb6+sQB6CAABGTTEZSx9kkq95iau53bRd
 8PsgjZtXqCkGe3G6Dcfl9gKJjS9NBwScTShDyzpre49v7Ux8J2prGUjH6OGPLJw=
X-Google-Smtp-Source: AGHT+IHphUWslHtupEwaJa9vFQCTAWPR4kYx9tku6ze9fkRoV8XzIBH1y3NBc0r4uAOX9bl7a4sVQA==
X-Received: by 2002:a05:600c:4f4f:b0:428:1965:450d with SMTP id
 5b1f17b1804b1-42cdb53bd22mr17219945e9.17.1726130929741; 
 Thu, 12 Sep 2024 01:48:49 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb33a92sm165637475e9.20.2024.09.12.01.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 01:48:48 -0700 (PDT)
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
Subject: [PATCH 09/10] target/riscv: Implement Smdbltrp behavior
Date: Thu, 12 Sep 2024 10:48:28 +0200
Message-ID: <20240912084832.2906991-10-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912084832.2906991-1-cleger@rivosinc.com>
References: <20240912084832.2906991-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x32f.google.com
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

When the Smsdbltrp ISA extension is enabled, MSTATUS.MDT bit is enabled
at reset and set upon trap. If a trap happens while MSTATUS.MDT is
already set, it will trigger an abort or an NMI is the Smrnmi extension
is available.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/cpu.c        |  3 +++
 target/riscv/cpu_helper.c | 35 ++++++++++++++++++++++++++---------
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 75433a4359..f9b2ce4463 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -967,6 +967,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
             env->mstatus_hs = set_field(env->mstatus_hs,
                                         MSTATUS64_UXL, env->misa_mxl);
         }
+        if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+            env->mstatus = set_field(env->mstatus, MSTATUS_MDT, 1);
+        }
     }
     env->mcause = 0;
     env->miclaim = MIP_SGEIP;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 69da3c3384..5a30d1b8a8 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1697,6 +1697,17 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
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
+    riscv_cpu_set_mode(env, PRV_M, virt);
+}
+
 /*
  * Handle Traps
  *
@@ -1733,15 +1744,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     bool nmi_execp = false;
 
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
 
@@ -1937,6 +1941,19 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         s = set_field(s, MSTATUS_MPIE, get_field(s, MSTATUS_MIE));
         s = set_field(s, MSTATUS_MPP, env->priv);
         s = set_field(s, MSTATUS_MIE, 0);
+        if (cpu->cfg.ext_smdbltrp) {
+            if (env->mstatus & MSTATUS_MDT) {
+                assert(env->priv == PRV_M);
+                if (!cpu->cfg.ext_smrnmi || nmi_execp) {
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
         env->mcause = cause | ~(((target_ulong)-1) >> async);
         if (smode_double_trap) {
-- 
2.45.2


