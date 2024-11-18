Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BB3D10F3B
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 01:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCqOA-00018J-18; Sun, 17 Nov 2024 20:17:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tCqO4-000164-ID
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 20:17:08 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tCqO1-0006SR-PH
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 20:17:08 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7242f559a9fso3641054b3a.1
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 17:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731892623; x=1732497423;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vTwUWeOBYxedW2UpgZEtaCjLh9J+yVkl+/fWLaqQqm4=;
 b=gjaruk1NpVJtksDbuItOGNb0pRNXlllPkneZnP6psuI/l767M4c9TIUOBA3HunRO1b
 a3GVBiYsSlip/WypxlpzEkJglwxYDCVEKD1MyE21Fp4CgRUryFjU6jHPwzORCRCY9Xyc
 9SESFVL5cQZNCdqBf21Kni+ju3R5sdfCnzewto6G/EH80zt4A5vTFBSid3pKWkGGkOB0
 DZT5zgwyesewTCitcHMsJhncKBijW96cqXsDWWdFpAknoaf099hRc4UfB7qLzcRkymGX
 w+YCM9HsiUy36NqpMXT5Vh7BX5+kttPEfwHGPUlk/diD2X29pckoLxCdxRXGAm9rNYyo
 G0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731892623; x=1732497423;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vTwUWeOBYxedW2UpgZEtaCjLh9J+yVkl+/fWLaqQqm4=;
 b=hM7jRGtCA8famg4FCd3x5VWzy/o+ivIWuYXr0KZocijDJqij7Tb9j6nkU7ZY81N4J+
 QOi/SssvdCJvmbEwU1GCc9HQ2oqc3/qFnWtaefji5HldMUBF0Zl2ldF4bfhYxdipoVh5
 8HWq0Os3kpN9Eyp6kbfbahd71WY8+Hrqn0rsaZMkMNYDIa2F2BhiJimv1IgPs52hmjPG
 2bQn1DNIFLx8OXV+FOrBd1tf3kyx5eXGbNEY1iNmxbDcxlcqXmnvo1Ae+Y/LDJqyHK/j
 pY4vm5VxciHengXN2sRQZPGpEKrzK+W3XOY3hC+2zlFa0ndj3+deJuQOx3ObMXcddBmb
 7m9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcWm7H3oM9zKpLKlpLo8HyTePwqwJoWasrB7j+ZyAR2DNs8s5sVp/nNMvERAs4xPnrCCDwIyHufwD9@nongnu.org
X-Gm-Message-State: AOJu0YxOeLZ+O1Fz534Q1a85aCTxEVaqup7fQDf/2XE4NhQx0y/cdeGt
 X6NbKrdWJGcNPqPlgTTtbQWGqvJNDUbpQnzfvevrxh1GErVG/ARCVsQApeNXVcQ0tHlSOxIPbWT
 i
X-Google-Smtp-Source: AGHT+IEwZY5kGEiU8iG2TpGudSxC8njlxU0UDeI2a1y6PnU4xVa1Qx8FYXlEjBQLnJOFTZTZNL6lIQ==
X-Received: by 2002:a05:6a00:4fc8:b0:71e:5e04:be9b with SMTP id
 d2e1a72fcca58-72476bb89b3mr12661111b3a.12.1731892623118; 
 Sun, 17 Nov 2024 17:17:03 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724771e8b75sm5134024b3a.147.2024.11.17.17.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 17:17:02 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Sun, 17 Nov 2024 17:15:57 -0800
Subject: [PATCH v3 09/11] target/riscv: Invoke pmu init after feature
 enable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241117-counter_delegation-v3-9-476d6f36e3c8@rivosinc.com>
References: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
In-Reply-To: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x42f.google.com
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


