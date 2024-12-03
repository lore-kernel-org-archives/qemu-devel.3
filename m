Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD83E77166
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 23:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIc6l-0001Qj-0s; Tue, 03 Dec 2024 18:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIc6h-0001PA-3O
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 18:15:03 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIc6b-0001LE-3k
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 18:15:02 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7253bc4d25eso251967b3a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 15:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733267695; x=1733872495;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vTwUWeOBYxedW2UpgZEtaCjLh9J+yVkl+/fWLaqQqm4=;
 b=YEIZ8g6o7hlLJY1RT7mD4mBsQ6dqoRz3SfgJeOwI64KC0M/87bfg1PWAcQh8MTKc/1
 00GChh9XQ9pauZiCRq6JLlnVsy/j82n/6Znql9UystFh5nHeHHA/nTwXLQ6orwFTsfp4
 VVuJ1iOYjZVm5NfSPvDBfcGhv+XSzrd3fVKQGzdLPpwyUp1SQghvNXhfG1jKZrxSnPm+
 0u1Jbim07m9lGMZzb5+5ewRXMwztlHKwQyaBk6VSUbKU1M2YEdlmp5OzdmAPUHGfAiKU
 TUsNNtgFNGQKPQsuTEDpLBDTxPUrJNA9qzu4U90l4DZUod6nUL/KSCJZrpZRWssZl6Eh
 m9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733267695; x=1733872495;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vTwUWeOBYxedW2UpgZEtaCjLh9J+yVkl+/fWLaqQqm4=;
 b=waFDo8J+3P8qECNQf1kKRWNvASHX+dofOZPt0KYAKe97TiHmGj967uTEZxLVfI7l8U
 zl/7wTe51lrijq/nk9XuVxpBvH1fCKQMAQv7yf5ticCN1v8F92pcewoTU8DvdG3tsNLR
 LqtCpndEU3+up9vMHbf3FvjQQWy8Jd9VFKEU2lIRjq6n4lJrKBzmvESJprLHRV/cmnml
 BBDz5IovohOCz0ASeEIfl21N+ItWuw450uECPGKFsnM/s3yNkPO8mCxiYKgBq3sLyzqA
 MTOC1LnLoBFvH2ZOnei3vVprB0VNHYvePER8X4KYKUHcOeFO9g3b1kild8nZovY3eHCF
 zIGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFoD8HQ5MxmRTdKalTOxf8jEzOmkzLoBZ3MWXu/sLsIjQfKsgHCH1dcAX3Uh3Id8H5dMuBsrSXpxxr@nongnu.org
X-Gm-Message-State: AOJu0Yzvlz+vjEDtK9Uq+1w3j8xXdSQMFud8J7S5z7A2MsqbhXDVrgjM
 jdMfAs0DiLP1kr0+qrrPY1X4xtNmFbtS63ybVjJUc7V4NiPWiaFDu+rhHR1CO7o=
X-Gm-Gg: ASbGncvkbHEM9Dw7+d7+93R1jj9HGTlibrQJHd/X6DIQg1lhyDV71nqh4gUn9CXxXGu
 A6vRbcRUH0VtwUXRlZqgS2KTutfK1cyJn+BafcTV+wFfu5dAx611ksYXFYkaUfh1EPEB6gkvljt
 LvTZX+xJAu8wwv9lNUlCXehYAOp7UBy5wuGoALUIT1OkQkNStNjq8n2Bwx8Zy2ZNg/GVVcILlrd
 Ia5P638jFjI+UHNzUjYnLO4VxnTQsaz+dM5zNSIIkm3EEZoPljBcT/IrfO6KKY=
X-Google-Smtp-Source: AGHT+IFqH267BHlWINP68ATaiF7zZgT9wTLIZATLPYoP4ZkDZ7Ifuz3OKfBWha89aJ0denh+vPQk0g==
X-Received: by 2002:a05:6a00:4651:b0:725:37a4:8827 with SMTP id
 d2e1a72fcca58-7257f8dbeedmr7576172b3a.3.1733267695593; 
 Tue, 03 Dec 2024 15:14:55 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254180f78asm11032133b3a.133.2024.12.03.15.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:14:55 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 03 Dec 2024 15:14:47 -0800
Subject: [PATCH v4 09/11] target/riscv: Invoke pmu init after feature
 enable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-counter_delegation-v4-9-c12a89baed86@rivosinc.com>
References: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
In-Reply-To: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x42a.google.com
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

The dependant ISA features are enabled at the end of cpu_realize
in finalize_features. Thus, PMU init should be invoked after that
only. Move the init invocation to riscv_tcg_cpu_finalize_features.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/tcg/tcg-cpu.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c62c2216961b..2b57aa4d1704 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -934,6 +934,20 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
         error_propagate(errp, local_err);
         return;
     }
+#ifndef CONFIG_USER_ONLY
+    if (cpu->cfg.pmu_mask) {
+        riscv_pmu_init(cpu, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
+
+        if (cpu->cfg.ext_sscofpmf) {
+            cpu->pmu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                          riscv_pmu_timer_cb, cpu);
+        }
+    }
+#endif
 }
 
 void riscv_tcg_cpu_finalize_dynamic_decoder(RISCVCPU *cpu)
@@ -981,7 +995,6 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
 
 #ifndef CONFIG_USER_ONLY
     CPURISCVState *env = &cpu->env;
-    Error *local_err = NULL;
 
     tcg_cflags_set(CPU(cs), CF_PCREL);
 
@@ -989,19 +1002,6 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
         riscv_timer_init(cpu);
     }
 
-    if (cpu->cfg.pmu_mask) {
-        riscv_pmu_init(cpu, &local_err);
-        if (local_err != NULL) {
-            error_propagate(errp, local_err);
-            return false;
-        }
-
-        if (cpu->cfg.ext_sscofpmf) {
-            cpu->pmu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                          riscv_pmu_timer_cb, cpu);
-        }
-    }
-
     /* With H-Ext, VSSIP, VSTIP, VSEIP and SGEIP are hardwired to one. */
     if (riscv_has_ext(env, RVH)) {
         env->mideleg = MIP_VSSIP | MIP_VSTIP | MIP_VSEIP | MIP_SGEIP;

-- 
2.34.1


