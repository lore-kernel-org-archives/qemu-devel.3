Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922C4C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfNa-0000yq-4i; Fri, 17 Jan 2025 00:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfMt-000837-Od
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:08 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfMs-00068b-83
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:07 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21670dce0a7so38093675ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093485; x=1737698285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JxBG/sCQsp/iAM/lHy+4Lr1ps18h2Gv4vOagJzfUaj4=;
 b=a4EA5Exh7qzB6vCTk623UIbr4Gv932RggQoXb4fPJ49+QMzlcIDyay/48hATRQwYrH
 MAuKajiRKy+YI5gGZQA8mOrxIBgl+LlNkbDWBTOifEUiaY4pF7V4GmofQY0dwEnN5AIn
 SByHYYdPnvZMv/mDCHp9l+s+10irb9eWB4JmfvwO27g1kga0hnG580FVtZPLIT30YzUD
 WjKNMfCFWJIJ03xoZB16L/kQTBA2VEnroP7Y/huEinx+WpemQWN0UtB8DOMRUObzX/ZU
 C0Ru+9nO+TTb/gE6Zb14gqSf+Kn9X1zNQFKFq8cFaeDOxrMQPU8r4VPlKfq1yG7Utsn7
 6j4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093485; x=1737698285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JxBG/sCQsp/iAM/lHy+4Lr1ps18h2Gv4vOagJzfUaj4=;
 b=JL659P8VBPEo1PGHgmRYYZ7lHZe2jEtb2jsv/rJQkDIj/qnZH3mFByOnNU3IVtPII7
 l46x8xcR1LzIRc2qDyRdb/r0Uc/FagU2vaD0aRS7C3oIlct8Y1hgQjtX03WV53kJfL3y
 QnHI3U1+1s+7ejMh42AKm0cTn7JEJ5WmTKCp/BZGcyUtknecjlIOJEO1ZlmvBuaJ+7Fo
 KUF9LpD7rZaCPHrENQFbUP0kAXmAPzDvQVk5jBDbD5VCq+R0FwQ/faeaTNvJq/OvbK/q
 V5YrUAffshYLtfndoQjqU2GjRAPRZ3vLGItrdohjMjusnrSQBURqNHALl7OUl321bSY7
 zang==
X-Gm-Message-State: AOJu0Yz0ovH+1u0WpJUFttG0WfTSYTGiQEQrDdiStyvTpq29hzoHZiS/
 HlGln0ShkfkwMX6r/ZFQOezdAvoVKEMzgfGQH3/sB+jedYhHHzOqq7X8bQ==
X-Gm-Gg: ASbGncsCbGd4v7qklnRk+bm8iwiLwSvC12xoqctSOJ8KIN8rXaUtqNqaPrQTK8/22Uw
 A2alWtbUAQIH66Qbh/PqjniGFEzhDdJfIhgWkJdLcg93lTFR9mpkKSqkYn7tkSyefjuMWiNbdQh
 HO7WcKTv5K9Gwi5Z1eJl0y+8B7La54CHFRH5xnMa7CnB+Va1vQcemRLodGN9qoEZeq/lCzuyVsk
 Xp7L0jIlmxNBp96U1WyZpAButtnlYoBXtwxcmGZdjLMC2vfq4iuSTR9IBEUwjxlT5KBJeOD4spO
 iy7GA3fZEAh/J0CSBGMNH3qTIzWxAe8IM4B4xKnFNwNK44+D2WW3yQiSpMuD
X-Google-Smtp-Source: AGHT+IGwoimLsjnCI9vyYzadAkJMyXbNR5RBw8Pc9jBgER2nboWT8YPfACpsw3WhoyhVA34MfgHQKQ==
X-Received: by 2002:a17:902:d4d2:b0:215:620f:8de4 with SMTP id
 d9443c01a7336-21c352de109mr26801165ad.2.1737093484783; 
 Thu, 16 Jan 2025 21:58:04 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:58:04 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 36/50] target/riscv: Invoke pmu init after feature enable
Date: Fri, 17 Jan 2025 15:55:38 +1000
Message-ID: <20250117055552.108376-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Atish Patra <atishp@rivosinc.com>

The dependant ISA features are enabled at the end of cpu_realize
in finalize_features. Thus, PMU init should be invoked after that
only. Move the init invocation to riscv_tcg_cpu_finalize_features.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20250110-counter_delegation-v5-9-e83d797ae294@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f94aa9f29e..48be24bbbe 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -963,6 +963,20 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
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
@@ -1010,7 +1024,6 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
 
 #ifndef CONFIG_USER_ONLY
     CPURISCVState *env = &cpu->env;
-    Error *local_err = NULL;
 
     tcg_cflags_set(CPU(cs), CF_PCREL);
 
@@ -1018,19 +1031,6 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
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
2.47.1


