Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A278C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 19:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9U4q-0003Zp-GQ; Mon, 28 Apr 2025 15:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9U4o-0003ZG-MO
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:23:38 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9U4m-0007L2-Sf
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:23:38 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-227a8cdd241so71921625ad.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 12:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745868215; x=1746473015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6R3EUC6CKMFKAnlwhLj+btXOWn++vvQKz0yRoESdjA=;
 b=bydd+26VxDfTlpoAAdxIMyokamEXXfU3nLepQzB9puxChlucxUubQ5RrLENS/bZ/nD
 BnsvwHyxrgmU1xYN3yizBDY3lTt2qLQZr2ujY5/M2QfI9FQOOgbfefphhaFV9WyteCPm
 r33/lc4fNeYz+cc8o8mnCAqybfix/RSAKTy+6MyDqjmZASi/Qm2A5WPHYRbsmkKT5pUj
 Kwd35Oi26pXxhu/CeJ9BBUIcyXKkuLN5doWIbO2kDJR/FbhhkNIFZuF78ihgWX6bMOEk
 nicIxP1+v1UkXZtboxMT5rw43xt4FCn02/nbzDpt9AQWfaSKEEpws5m4WUhJH7DAkyWw
 pZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868215; x=1746473015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f6R3EUC6CKMFKAnlwhLj+btXOWn++vvQKz0yRoESdjA=;
 b=Zg0Gli3GIn46WKV+yWzqP0foU+TqF8oqQCK+MIIN+F+XB52s6D7FrdLZoB7hc+XK95
 IlttfaY3mzbpyYEjg/grzRzxlIQ5YxKmvD5LeWgO1uRhMnfy0l2y2KwWFRpgtI5lB04o
 olq6QU6ykcDJ8l6TMje4iyIGvzTeFPSI4fKucrhQoo894Ni5LfqyrkTAgP3TX5W3u04h
 tKUdJYxUQgXUnVVSR/bqLZDFvScSGQPOiSekm7uhQW3udADfEvXVTSNayQzayUFiIhX+
 qCdNslv5CUwMn1OoWR2Dkk19RiyySff8zg+X/+ya3BrecrNYjYsG/MMzmFMU/mNerLGI
 2a2w==
X-Gm-Message-State: AOJu0YzWmSZSW1pka6wVKinvcNgQesdNGoROdkeYbEMbbWIOa7Ku3Fd6
 K2OYbNhlKH33fIqvbLcLpSn6ekW4ASpj+oHbi+iej7auArNLlg2/vG0JtG42J71mZsxC2VNYNLw
 Jv5c=
X-Gm-Gg: ASbGncv8uDG/phZvLpMTSSCdC/MEJxU9wGJh3ApY2+Ei4rDLz5N6fjwFw+Cvj7A6aFR
 UulafWAtPWW850rCBg6LCB6YRN9CQjnfO7hRyht2+i0Ot3CLT9SdSDty8XYEjqmdDNBYBkPlrqE
 XyvS2LccX49RFKWh5HydEeas43XSF42gHYyXfgcoN7f+EWFU2s+hZX9Bxz1YWLbJg5xAct7YqJI
 zfjNgf/xBLF/Pv0z2TjznOux9S5A5XFTtv3XWgQLIdo7H7eJZ+pJpJyS3pj2Fi80fZakxqbW1tZ
 cPVpfhXx5hHvjThwG5e3cDNLAYMcS/QWTvNTFXXieXAM
X-Google-Smtp-Source: AGHT+IFKXO5/nXj+orASD82eF4pVoLKsZzXBII/O+Jdd8Ktxb0Nn2fusoZYvHfWZrcWBlA5fMVJDyA==
X-Received: by 2002:a17:903:2ec7:b0:224:b60:3ce0 with SMTP id
 d9443c01a7336-22de6f7e62dmr4066915ad.5.1745868215000; 
 Mon, 28 Apr 2025 12:23:35 -0700 (PDT)
Received: from grind.. ([2804:7f0:bcc0:906e:57d5:dca2:1ab3:20de])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4db99d3sm87300565ad.53.2025.04.28.12.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 12:23:34 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 1/9] target/riscv/kvm: minor fixes/tweaks
Date: Mon, 28 Apr 2025 16:23:15 -0300
Message-ID: <20250428192323.84992-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428192323.84992-1-dbarboza@ventanamicro.com>
References: <20250428192323.84992-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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

Remove an unused 'KVMScratchCPU' pointer argument in
kvm_riscv_check_sbi_dbcn_support().

Put kvm_riscv_reset_regs_csr() after kvm_riscv_put_regs_csr(). This will
make a future patch diff easier to read, when changes in
kvm_riscv_reset_regs_csr() and kvm_riscv_get_regs_csr() will be made.

Fixes: a6b53378f5 ("target/riscv/kvm: implement SBI debug console (DBCN) calls")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 9214ce490c..accad4c28e 100644
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


