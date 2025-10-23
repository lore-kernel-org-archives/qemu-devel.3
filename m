Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A07CCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC55G-0005KP-F4; Thu, 23 Oct 2025 19:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54v-000594-I9
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:48 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54t-0007UA-OC
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:45 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7a27ab05a2dso1039186b3a.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263442; x=1761868242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otDqyi4KcGYYeSRiH0WBEkbvf1wg7FPRPexsVZjLPww=;
 b=OVBjw7BDapB25i+4rBhtf5TQ1bQF8C7Oga1EFoKu+D+N0a0Raf162zAUvp2GnvF66h
 Xvs1h052p38i+p0sVDNZhBWcfK0m28af0wbL/i7G2pLea/vEl0SBytZjDO6JHDmXeVeS
 GEjndvjJiC9MZl4aPlDbMXTN7PbJX3KAIfxFNhk/UtIwb8zlMcIE7ZDLjLxkYiUpE5RP
 cgIG60Nz15DDIt+jB5187cRBvSLbtbID7mqDnKUs1QaaLkEOK/tSOwCjoqr0fk1kAE8p
 5iYQRBIS4XMykHA0iZDpB3ZDOyfWWOHQjL6ekTOnKHhs8CrGLmRaEdwwrpm27q+nsGX8
 IDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263442; x=1761868242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=otDqyi4KcGYYeSRiH0WBEkbvf1wg7FPRPexsVZjLPww=;
 b=L83FHd6ZQvkK2fEiWW9/1nFpIQEXJocRuL5+m8NYN8c/ECaGjMDI5Do2OjUKCHZ4JJ
 aAVsM/dYD1dbrYWpsYk3cBYbsAppjuXD2+PQQXKlXBUXtGlEolO3U/bWf2FkgEFj6kHF
 hLrhrrPytlF9RI1TlD5kOtNgfBjO6V8Gv0wVABCzoTdnLgXjMz2bopSwqmX98HdidthY
 nxzDCpiggptnRYjUoV9GDXCxPLwjmpSvxfQFxuxOf5VtL5nGg9yIApPi1K0x6aomQE/U
 KOiV5ZWRSgbFznuYYk/6fD/aTO29JK9npQ26BV+PgLG0WSNuC/a4LDkUda6eKFsyC8t2
 0QWA==
X-Gm-Message-State: AOJu0YzAIeytD0ZDtYXeNGRehyBaQD5pdvQzVQ6PgZlbNTO/HNO6qEdB
 141pYztl3MUNLhvvher2PWASXzTZjBgKL/WIae+tGzllZSLR4urtGd23xwpFiA==
X-Gm-Gg: ASbGncuvVmX2zWMl72KUIJXz+kQRYg63yz8q6SG3WjuP5mdF6G4aXma+UonLnfJ/XVb
 /MkkfCL6cOuUrQBV9GU68J12SYr9hIdVqHU9JafR0mo8ddj9BNuJd38BLs54LG2qt1/FbaQB8nF
 FdwnTNO4PY8uXOvpiMZhXcaavvZXV37nXu15wCB1aojd2C7nHfOs8yybgBh/jvdfb7vXNA4qBYo
 F0psQaXscRYlZnQ2X+Y+nc/ylOqBmLvoh1zBwXz13CrwlulR/hFc4p8nREqav5+7zjoFwx+7e5Y
 h34PO3cJe8Sf1pwSsyBDlhyRTDb+IYoDzyiD1xRIBqx9ge0Zyqn2C+gEpdvGWZRxuUwahNaqpWx
 JsR38IcyXosaGQVB6IoreBgoAHCkLjmJhHjzrFKJaHOTwxlRaqmI/KEKMhFmKT3mbRmhs1WSB4U
 ZlUyqpm1pm+ZZRFlgMFID3LrQzUem7lvNs4XWKX7DtoD1nHKQn5jtJzDGfgUxB4+15/8BjwIhUi
 tFgWLfV
X-Google-Smtp-Source: AGHT+IEiZjGKPPtsOf4S1bOCr22lSvvl9wDWz0HVyMJq0QGKuPCi0C52pVKjozjRERC/z7nvN+BjnA==
X-Received: by 2002:a17:903:2290:b0:269:8d85:2249 with SMTP id
 d9443c01a7336-290d14e83a7mr307389785ad.22.1761263441755; 
 Thu, 23 Oct 2025 16:50:41 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de02cb7sm36088525ad.40.2025.10.23.16.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:50:40 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 19/25] hw/intc: Allow gaps in hartids for aclint and aplic
Date: Fri, 24 Oct 2025 09:49:21 +1000
Message-ID: <20251023234927.1864284-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023234927.1864284-1-alistair.francis@wdc.com>
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

This is needed for riscv based CPUs by MIPS since those may have
sparse hart-ID layouts. ACLINT and APLIC still assume a dense
range, and if a hart is missing, this causes NULL derefs.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251018154522.745788-2-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aclint.c | 18 ++++++++++++++++--
 hw/intc/riscv_aplic.c  | 13 ++++++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 9f4c36e965..c6f13f647e 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -297,7 +297,12 @@ static void riscv_aclint_mtimer_realize(DeviceState *dev, Error **errp)
     s->timecmp = g_new0(uint64_t, s->num_harts);
     /* Claim timer interrupt bits */
     for (i = 0; i < s->num_harts; i++) {
-        RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
+        CPUState *cpu_by_hartid = cpu_by_arch_id(s->hartid_base + i);
+        if (cpu_by_hartid == NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
+        RISCVCPU *cpu = RISCV_CPU(cpu_by_hartid);
         if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
             error_report("MTIP already claimed");
             exit(1);
@@ -489,7 +494,12 @@ static void riscv_aclint_swi_realize(DeviceState *dev, Error **errp)
 
     /* Claim software interrupt bits */
     for (i = 0; i < swi->num_harts; i++) {
-        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(swi->hartid_base + i));
+        CPUState *cpu_by_hartid = cpu_by_arch_id(swi->hartid_base + i);
+        if (cpu_by_hartid == NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
+        RISCVCPU *cpu = RISCV_CPU(cpu_by_hartid);
         /* We don't claim mip.SSIP because it is writable by software */
         if (riscv_cpu_claim_interrupts(cpu, swi->sswi ? 0 : MIP_MSIP) < 0) {
             error_report("MSIP already claimed");
@@ -553,6 +563,10 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint32_t hartid_base,
 
     for (i = 0; i < num_harts; i++) {
         CPUState *cpu = cpu_by_arch_id(hartid_base + i);
+        if (cpu == NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
         RISCVCPU *rvcpu = RISCV_CPU(cpu);
 
         qdev_connect_gpio_out(dev, i,
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 6dccca73af..a2041e7022 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -910,9 +910,12 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
         if (!aplic->msimode) {
             /* Claim the CPU interrupt to be triggered by this APLIC */
             for (i = 0; i < aplic->num_harts; i++) {
-                RISCVCPU *cpu;
-
-                cpu = RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i));
+                CPUState *temp = cpu_by_arch_id(aplic->hartid_base + i);
+                if (temp == NULL) {
+                    /* Valid for sparse hart layouts - skip this hart ID */
+                    continue;
+                }
+                RISCVCPU *cpu = RISCV_CPU(temp);
                 if (riscv_cpu_claim_interrupts(cpu,
                     (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
                     error_report("%s already claimed",
@@ -1095,6 +1098,10 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
         if (!msimode) {
             for (i = 0; i < num_harts; i++) {
                 CPUState *cpu = cpu_by_arch_id(hartid_base + i);
+                if (cpu == NULL) {
+                    /* Valid for sparse hart layouts - skip this hart ID */
+                    continue;
+                }
 
                 qdev_connect_gpio_out_named(dev, NULL, i,
                                             qdev_get_gpio_in(DEVICE(cpu),
-- 
2.51.0


