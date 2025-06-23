Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36897C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 17:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTkrg-0004Uv-5q; Mon, 23 Jun 2025 13:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uTkrR-0004Rn-Cs
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 13:21:38 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uTkrP-0006E2-9J
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 13:21:37 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b2fd091f826so3399552a12.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 10:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1750699293; x=1751304093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ghnsqsuTP2eOK0pz8lkELt9NeubIcUGu0srdYwhqGo0=;
 b=e0QnvmOccgoIae82scl+dOWRHpwcsjGnwMk/aJxtpv7xAwwr/7rbv+xs/bw1F3h1sd
 g84jY50my21g1kO+/aWaDYBRzkKUhRPUcY1exo7qCDEMnGPBxLBbzhssfe4C+7REsiV1
 duIkDhzAZaaX8zKZtb2WwBA/8UmR0UhYSfB+MHs5HnwGOMXtaCZ1POxzVUVcjs4UvlR6
 UYtcFde33AC3wif9HlgY/MRfZJMHPW9EmpMt3wGbL/CuttnNJO8P8ZtbejYCBnYSHCzR
 En3TfC7nRk+4FsT5fqiVuftuwCFnWgEQr1dcxAlc6U/ofDGtN++Q8daCNFaGPAnlrT/k
 MSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750699293; x=1751304093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ghnsqsuTP2eOK0pz8lkELt9NeubIcUGu0srdYwhqGo0=;
 b=qdILnH6QmMFeFV1YMC6ak2LEPo1Ie0uGZiCAD4Nw56MHk2PrSffD5nRbtNl7lRo11p
 gnol3kJ7ojSoW4xFFV4LHvnbeEIXztohaTd5ZWk8lQyAAfKQGIvowNYSI2dng78jwuUg
 4DUF4T54kKM3l/qgu18eJw3tHL3JGnRMHhrtv0zAEMliz46gl+OeA708F3j4mTEO8zmg
 wfTjEKm9d0/l76etMtvvJ2xaD/eFfLYwbmLAtBa1vM1bV+d3i81Z5PTe/heICP3uzUtV
 jX0R+PRMdxs5Kg4iDCvAE8kXluTkkscfSnjXsa9YMadz0V/ypW7ME185j1+1XNkQfWJF
 eUUQ==
X-Gm-Message-State: AOJu0YzuGfNfRhx/us6q85HEPYg/X62meolgMn6H6GMRntNA5g8AHDW4
 ZHl5NBsyLIyNol+SdMDpnKicY7fL9O0n78wu5IqusKQX3vbDYYrjkEzhXZPETr4CzIrKY2HvzCC
 ZDkZmKMQ=
X-Gm-Gg: ASbGncunMiSQgWIy3UefIrKA5cQ5HFAwBfJCxsEkHwugrlRFeeVVu++fEL/Ts9z3BSz
 UJl68BW1pK0GcKHWyt2HzoxbT/6o2oLQCstCbHqJk2pUH4qjtqQm+Kj/ZT4K6r8soKP0LP++Vq7
 sU57xrjH4gn2zHvsEcntImjdXkJ6wVH0KSPP/7HRT0JqoT979byRmx2tK+lWllnTo5jh9m+jMbT
 tDggiTraUm6YU012aCeHE8GaMYY4NCCqC0aUjEAY+iA+KfQVE5ptOzS9IULXtFmYkWaQ4lUznjj
 q8k/jUmOqMDieTLCiaNwxXkkhqpEwhoI58Vrv6jJjLlrNJVA9ZEBI9x+FIHcOcqK4kqSU88tRdw
 =
X-Google-Smtp-Source: AGHT+IFK04sa0p5ov4RETysY0BD2GYY07uznPn5FOVaf/tnK0nmIeC10L9o06hevZcIJGAf0ASkgRw==
X-Received: by 2002:a17:902:b417:b0:231:c3c1:babb with SMTP id
 d9443c01a7336-2380249777emr3446225ad.18.1750699293228; 
 Mon, 23 Jun 2025 10:21:33 -0700 (PDT)
Received: from grind.. ([191.255.35.152]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d873845esm90847525ad.243.2025.06.23.10.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 10:21:32 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 3/3] target/riscv: print all available CSRs in
 riscv_cpu_dump_state()
Date: Mon, 23 Jun 2025 14:21:19 -0300
Message-ID: <20250623172119.997166-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623172119.997166-1-dbarboza@ventanamicro.com>
References: <20250623172119.997166-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

At this moment we're printing a small selection of CSRs. There's no
particular reason to not print all of them.

We're ignoring the note about CSR_SSTATUS being ommited because it can
be read via CSR_MSTATUS. There's a huge list of CSRs that would fall in
this category and it would be an extra burden to manage them, not
mentioning having to document "we're not listing X because it's the same
value as Y" to users.

Remove 'dump_csrs' and use the existing 'csr_ops' array to print all
available CSRs. Create two helpers in csr.c to identify FPU and VPU CSRs
and skip them - they'll be printed in the FPU/VPU blocks later.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 55 ++++++++++++++++------------------------------
 target/riscv/cpu.h |  2 ++
 target/riscv/csr.c | 18 +++++++++++++++
 3 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 95d0b88937..ed1bf18625 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -544,44 +544,27 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #endif
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
 #ifndef CONFIG_USER_ONLY
-    {
-        static const int dump_csrs[] = {
-            CSR_MHARTID,
-            CSR_MSTATUS,
-            CSR_MSTATUSH,
-            /*
-             * CSR_SSTATUS is intentionally omitted here as its value
-             * can be figured out by looking at CSR_MSTATUS
-             */
-            CSR_HSTATUS,
-            CSR_VSSTATUS,
-            CSR_MIP,
-            CSR_MIE,
-            CSR_MIDELEG,
-            CSR_HIDELEG,
-            CSR_MEDELEG,
-            CSR_HEDELEG,
-            CSR_MTVEC,
-            CSR_STVEC,
-            CSR_VSTVEC,
-            CSR_MEPC,
-            CSR_SEPC,
-            CSR_VSEPC,
-            CSR_MCAUSE,
-            CSR_SCAUSE,
-            CSR_VSCAUSE,
-            CSR_MTVAL,
-            CSR_STVAL,
-            CSR_HTVAL,
-            CSR_MTVAL2,
-            CSR_MSCRATCH,
-            CSR_SSCRATCH,
-            CSR_SATP,
-        };
+    for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
+        int csrno = i;
 
-        for (i = 0; i < ARRAY_SIZE(dump_csrs); ++i) {
-            riscv_dump_csr(env, dump_csrs[i], f);
+        /*
+         * Early skip when possible since we're going
+         * through a lot of NULL entries.
+         */
+        if (csr_ops[csrno].predicate == NULL) {
+            continue;
         }
+
+        /*
+         * FPU and VPU CSRs will be printed in the
+         * CPU_DUMP_FPU/CPU_DUMP_VPU blocks later.
+         */
+        if (riscv_csr_is_fpu(csrno) ||
+            riscv_csr_is_vpu(csrno)) {
+            continue;
+        }
+
+        riscv_dump_csr(env, csrno, f);
     }
 #endif
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4a862da615..ecdf709c2d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -967,6 +967,8 @@ bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
 
 /* CSR function table */
 extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
+bool riscv_csr_is_fpu(int csrno);
+bool riscv_csr_is_vpu(int csrno);
 
 extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 6296ecd1e1..229257b31b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -5799,6 +5799,24 @@ static RISCVException write_jvt(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+bool riscv_csr_is_fpu(int csrno)
+{
+    if (!csr_ops[csrno].predicate) {
+        return false;
+    }
+
+    return csr_ops[csrno].predicate == fs;
+}
+
+bool riscv_csr_is_vpu(int csrno)
+{
+    if (!csr_ops[csrno].predicate) {
+        return false;
+    }
+
+    return csr_ops[csrno].predicate == vs;
+}
+
 /*
  * Control and Status Register function table
  * riscv_csr_operations::predicate() must be provided for an implemented CSR
-- 
2.49.0


