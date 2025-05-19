Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EFCC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGrv0-0004TU-Aq; Mon, 19 May 2025 00:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGroT-0007vZ-Bb; Mon, 19 May 2025 00:09:25 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGroR-0004KH-Lw; Mon, 19 May 2025 00:09:17 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2320d2a7852so8590995ad.3; 
 Sun, 18 May 2025 21:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627753; x=1748232553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wY7mpEOJfCURI42HnRpTQwtH82i/7RJ4cmoo53i44Rk=;
 b=Xqv1ZlRBNTbEJDdSjwo79ZBfbtL24+VafjaUrFFUq8Tu586EmEQXEVMgFMsm0IP3hy
 H/cXBEprFCnwxqQxN36c5WRP5SBq913hWtd9TV5me96MchP4Z7qhMwpeD+nr0niV8Jaz
 6D1KKkSuyVFr+UH84/JBycFgpC/+qAenaiTvSsfPQWRxI9K7s1gtiAmvONT0ww8niYU7
 v8rJ+3U5VAA5Y6jk8TUQh4r/iKRyZw9VXGG+IrIvv46rTnpifAxytj3+3CsSD7GitRSv
 /qlVLWyS5RYKdKpyeLwnm3jewcBMpAYgPyugo7GMRyXW7zr2NTfcAFm9d7M0C+hYUH/Q
 fr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627753; x=1748232553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wY7mpEOJfCURI42HnRpTQwtH82i/7RJ4cmoo53i44Rk=;
 b=TEnsxF5PplpPbXGg8vqQhoinAzBA9DY423pRiYupNz5eXJWG3t4Zv8cgxfQzb2XGB/
 Gw6Q59cSGtDoultFbdrysTyyzogxiZX0f6/6aGn/hfZOVxckkBq2eTuck4E2agJC8Byt
 uGWx51SDaq1kEB5eUtHhWPd2Eo8M9rBtUYtm0fChJoiXcJGDrOxzXKXyoyb0OxAViuWf
 5MvGODSzpmFtQaCmsI7+bDz2xca7ItzfPZU8cLzL5/xNvCvy8Oh7MD5TT80wWiLRDulT
 sMraBWp8lNo19BAaUg814xriKWPPqFypd7UxEeYaYG4hpAqOynNqbb9MIUzSiuux3VR4
 cEDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpQJ3lktYaQmvIchY5L1Z4bxSRowGKk96dsrpVwcMUiK3carIRxXPWflhqB9pLs42/vu5kzliUe8y3yg==@nongnu.org
X-Gm-Message-State: AOJu0YwXv4LWmo897vmkYEsBnGrP8TwLwpDXcVA5+ka3OFf/biJJ1DSW
 cf8SF4Qmy3aTV/2IqMWIlwRGgT3pjSeGjSKPYVMkYX0XG82OPOdWPs6inZP6dg==
X-Gm-Gg: ASbGncs1avUOO6fnkFtTEy40JOFtnVVmsvYF/Abij80lJC8xyKqYA9RQbr5WJDAcTYS
 rgS7M4ozkOW/ulbmcOFXjM0Uq3v0r0A+xNhXEQFA07bDL4aCmC8tRsKle6dwErJmh/vBf5uUPYY
 WuWHyNgFryQpsZcyZA6/xucqn9r5SOaAmNK4uHxHwExhZvkgW/MYCjdCjg0JBf4F5Kt+4z6CemO
 wrp1nHi/5J5CZ7+ntWBlzFvnzgwOC1pd241O+oRQtn2zZCTIcfue3lZNCjKQWp6Gvbf2MN9GTRY
 K/S6hxCFSAFuSKqK1Rynq1V199TQuftFHier7t+jhlGMPyzVXNjyHb/ux7MHko+FeOLcQ+UM9cF
 FGmheoHyBv0jQVFfi9GM+yT+weFB8fAKVr/bE/Xxg6vCu+H561F2gCA5/
X-Google-Smtp-Source: AGHT+IG791m1GQiVC7YqYmNHcrA83Ciz35E5QnfsgPs4XHea0ujTmkmY5QvCXp5UL6vLagZNqSotYQ==
X-Received: by 2002:a17:902:c411:b0:224:1ec0:8a1d with SMTP id
 d9443c01a7336-231de376684mr139468955ad.30.1747627753043; 
 Sun, 18 May 2025 21:09:13 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:09:12 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL 39/56] target/riscv/kvm: minor fixes/tweaks
Date: Mon, 19 May 2025 14:05:36 +1000
Message-ID: <20250519040555.3797167-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Remove an unused 'KVMScratchCPU' pointer argument in
kvm_riscv_check_sbi_dbcn_support().

Put kvm_riscv_reset_regs_csr() after kvm_riscv_put_regs_csr(). This will
make a future patch diff easier to read, when changes in
kvm_riscv_reset_regs_csr() and kvm_riscv_get_regs_csr() will be made.

Fixes: a6b53378f5 ("target/riscv/kvm: implement SBI debug console (DBCN) calls")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250429124421.223883-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 target/riscv/kvm/kvm-cpu.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 75724b6af4..cad54b720a 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -613,19 +613,6 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
     return ret;
 }
 
-static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
-{
-    env->mstatus = 0;
-    env->mie = 0;
-    env->stvec = 0;
-    env->sscratch = 0;
-    env->sepc = 0;
-    env->scause = 0;
-    env->stval = 0;
-    env->mip = 0;
-    env->satp = 0;
-}
-
 static int kvm_riscv_get_regs_csr(CPUState *cs)
 {
     CPURISCVState *env = &RISCV_CPU(cs)->env;
@@ -660,6 +647,19 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
     return 0;
 }
 
+static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
+{
+    env->mstatus = 0;
+    env->mie = 0;
+    env->stvec = 0;
+    env->sscratch = 0;
+    env->sepc = 0;
+    env->scause = 0;
+    env->stval = 0;
+    env->mip = 0;
+    env->satp = 0;
+}
+
 static int kvm_riscv_get_regs_fp(CPUState *cs)
 {
     int ret = 0;
@@ -1078,7 +1078,6 @@ static int uint64_cmp(const void *a, const void *b)
 }
 
 static void kvm_riscv_check_sbi_dbcn_support(RISCVCPU *cpu,
-                                             KVMScratchCPU *kvmcpu,
                                              struct kvm_reg_list *reglist)
 {
     struct kvm_reg_list *reg_search;
@@ -1197,7 +1196,7 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
         kvm_riscv_read_vlenb(cpu, kvmcpu, reglist);
     }
 
-    kvm_riscv_check_sbi_dbcn_support(cpu, kvmcpu, reglist);
+    kvm_riscv_check_sbi_dbcn_support(cpu, reglist);
 }
 
 static void riscv_init_kvm_registers(Object *cpu_obj)
-- 
2.49.0


