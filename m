Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D7EC02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJts-0000ba-2c; Sat, 18 Jan 2025 20:14:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtp-0000LA-8U
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:49 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtn-0003PU-C7
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:48 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2f43da61ba9so4501234a91.2
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249285; x=1737854085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBdLRF0uol7FqBm4EOyL0TOCyZ3ye1dx/esQnUs6Ug0=;
 b=FdnrPXpcHPtFkJCcU+xzcMiVmdNcARHb9QaMSPjxTtFTErPUi9WR7FcmW/R4V0wAal
 i94fVNkYuI4mV3WREVtaom4gp4+tMov1z7AlkeeFTVwD9bBvUJF8U9Fagcm+x+4odjIr
 bBATkKjDPWkuezkFINYOH/espA7yPY8p0NFhBfbUJXWrhkgHRJIumu924rrNyM7bCkXI
 Mn+KZL/bENWafyDRoPcZkhk7hQV5Re0826UaC3+NaFjfzI2vdWPFLE4k7ddG2ZWpqabY
 XyB5Sb+dbIgoLcSBXyV+TDpH90pml0kM7+SC/sSk0nQZpiRj44OtAa8sn10oKJODjUQZ
 VBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249285; x=1737854085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tBdLRF0uol7FqBm4EOyL0TOCyZ3ye1dx/esQnUs6Ug0=;
 b=vpqOIl6QMzPoTK3SZraMRmhRVvkTRdvz+cIrbYwkkKu/BbpzDuJVYGS+zxfodd0lwF
 pV0Img5y0b529uevChGWqt7E7lr/gMHd0MAZB3QcaDSwKoGL4pHvs4IvNsmP4ad50eB1
 nrM6Ls7rvisR2XArQ5YSCES758gamSrLW7hQe60wYVqeu95Mfit7OETSfkNBQsuMJfts
 dYQy+k3CjUZm8WgQY/bKpybWeYwncdoQCD9gGJz/+G+CP4Fr0P6DNQ2PdAWB/LYFXpap
 PrZ77DY2SZJNfmJ5EFTV4X7lR6INhlO+njyspjbtAkRaHChaUl+OFjLCuIEZAJKQGyUT
 w57A==
X-Gm-Message-State: AOJu0YzGWP3qS/tfYSymuT2bCqlrxBQsxymqA8QgJNFQ4ax24UEwcQis
 WXXAsokMZgwMRSbz152TfcyLa5nk1HQFQJiWtaT/TROQQMk0gX7N8k6NhkJp
X-Gm-Gg: ASbGncs7Ve6WnjkIt1mEDhE8zgWpBGvuWEHjfoGXM8Po6Jc8EnCZ7h4aKMsKEsYfOS3
 8b7b356u5u8uEyjE+DjnOiDrUsmB1hc3nI1IrOYnmS9CObsvBrx06ojXyCwata4q6WWx0T3TPKT
 P1BK0JfsIV/tXLBl5kyEm24PB4nvkgGcXhtXnF0TfiNEAlY+l8ok/vKxuezYVlY/qsbdw+Vd+6T
 9EjjtSGQAEgWIX5F1a/KXCSyhBfmlYWty4aMQXZORjqHlpd5jYYmDHT7GfXgR+KuFSMu0Ma8R8S
 TaCS8Pn3rvajOsjvNYjGsKmslFJUHmvT7I5v0SzpKlaQBfiJvlSSJHNpLfxlWWV8mTNAhgHXiw=
 =
X-Google-Smtp-Source: AGHT+IEWOT1KSj31fkWKAt7f7vcncsB9UzhvONskoP6hc7GcpVCrU+ncPIkzvpVAv3yOc5muAzXm2w==
X-Received: by 2002:a17:90b:5146:b0:2ee:c04a:4281 with SMTP id
 98e67ed59e1d1-2f782c6579dmr10503573a91.6.1737249285257; 
 Sat, 18 Jan 2025 17:14:45 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:14:44 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 36/50] target/riscv: Invoke pmu init after feature enable
Date: Sun, 19 Jan 2025 11:12:11 +1000
Message-ID: <20250119011225.11452-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
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
2.48.1


