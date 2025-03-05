Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226ABC282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpe0Z-0003eV-Fk; Tue, 04 Mar 2025 20:57:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdzU-0000Z2-Ge
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:56:08 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdzS-0000Ye-P3
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:56:08 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2238d965199so61677015ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139765; x=1741744565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/0hW3+S9jfzX+T8NcB6yuMJZPB70RRZojkSXgIHsNM0=;
 b=lMzQbpOIKNk7bUzzyLmIDFUHFC1Ml13nW/LG+6cMUlZJ5TYs9Lm0CPNYRJRgJntDqU
 u84BSfApeM+ZoISTb+sCBZDVsjqLT+5b4y4QMvKd3G+PeRXJFaqFb+o3c4+cSV8ZES0C
 JtNkX04yE9ePqBusCR0xJSyjIvwuKDPEFhQMlRWkv7onq+uAPHB7vtHEqNX+zSHxdsta
 c5f26ujh9BtIoTFmUWDIkoVGg7E4TEa10HbnHKZzv1uUlFwLU5AUke0VPtyNulaHwrts
 zMy6jxcStyr1xHQYW85ZgpSQJ3Nw1UHi0/u2ZIyY9RCAUvTKFJ3Tbnl3Rxo+YG5Ay050
 1mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139765; x=1741744565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/0hW3+S9jfzX+T8NcB6yuMJZPB70RRZojkSXgIHsNM0=;
 b=Rc49QCkVUCi1IgqXGrgAVNUiBGf8QhTqiZ/KRSxbwSDHVKh+chFFfBQ7VYJzNnz/jm
 oAWaAOTQDglQr+9uXLDm6+TF0kmyBx2xGX3CRkJX6QtTtXOhsT3sWitwF64pU5X1rNFi
 WMq+NzkkJEn+7H2k1rfRqQNfLEg71HcshThGaVPbb0Dj/DOrIavwAMsLBorg0jTX8lMK
 0sr/R1KLqM7ij7rKXZm9YlRkNREVBuDwwpp4aeCVxD1x0n9NKlPCXBnrlhlX+qLUFTiB
 Di4VZuPLYeuW/QeOb0yzd/5YuDaEGm7Gx/uAC5QzB8A6M7HPrHL/VxR1L5F5n4xK+N6k
 BjIw==
X-Gm-Message-State: AOJu0Yy5rVLm903Vl+Crg1S7+vWGG1GlNW32LdqV+RGMzTDm6HSQT3YT
 Q6r7O6WYV9xMArzKG1RppOin1FRUYYGNeYtiawUI6fEXY9q7EEjPdIxqpdphcyc=
X-Gm-Gg: ASbGncvpv/Ud/tfYHy6CKfgaXG5PzJq5Y0OfgWwtJOuaAmd1XBcKH8b7XKeQ5EegmoA
 776rLqfiwabD7QHydP/6qdmU9GaoBMi0zMFZzohrkRkf0QN2HvIvPcbq581+fr/xZSM4LJTvFQ7
 MF0As4eLPt1bz/tVCv5YB31c0+fEwKLsKjO97BXrN6b6WHSFQ2t1YTuuyapJ1YavGJV9CJLKLoy
 5CvR6pIe50T5ztjt2ICbNCEl5pepKJrcckrHqsJH3Qj3Od+KpA0FVokjL11fcQqJkDqor7A6NYv
 66Is/2mYDtOxU1eZwvVUm5WGf7TEO+pAnnQPJFsYq5YxLemUfnBy9q7WBDorgw8cfaRpLL6M5hB
 iaRjYV96+qv85znspzdYXq4KQd3xEZ5vyDFJFpEYn7eCnDDWBPzU=
X-Google-Smtp-Source: AGHT+IHhrQa70jXqY3HaeAlDaFR3sqvwJvJdIuSZcHgq/FFkznwx5+AXc9EE3bxEx3vJLgAlGbH8sg==
X-Received: by 2002:a17:902:c951:b0:220:cb1a:da5 with SMTP id
 d9443c01a7336-223f1d0fa09mr21741235ad.40.1741139765171; 
 Tue, 04 Mar 2025 17:56:05 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:56:04 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 58/59] target/riscv/kvm: add kvm_riscv_reset_regs_csr()
Date: Wed,  5 Mar 2025 11:53:06 +1000
Message-ID: <20250305015307.1463560-59-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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

We're setting reset vals for KVM csrs during kvm_riscv_reset_vcpu(), but
in no particular order and missing some of them (like env->mstatus).

Create a helper to do that, unclogging reset_vcpu(), and initialize
env->mstatus as well. Keep the regs in the same order they appear in
struct kvm_riscv_csr from the KVM UAPI, similar to what
kvm_riscv_(get|put)_regs_csr are doing. This will make a bit easier to
add new KVM CSRs and to verify which values we're writing back to KVM
during vcpu reset.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250224123120.1644186-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index e110e0b909..ba54eaa0b4 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -613,6 +613,19 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
     return ret;
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
 static int kvm_riscv_get_regs_csr(CPUState *cs)
 {
     CPURISCVState *env = &RISCV_CPU(cs)->env;
@@ -1617,14 +1630,8 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
     env->pc = cpu->env.kernel_addr;
     env->gpr[10] = kvm_arch_vcpu_id(CPU(cpu)); /* a0 */
     env->gpr[11] = cpu->env.fdt_addr;          /* a1 */
-    env->satp = 0;
-    env->mie = 0;
-    env->stvec = 0;
-    env->sscratch = 0;
-    env->sepc = 0;
-    env->scause = 0;
-    env->stval = 0;
-    env->mip = 0;
+
+    kvm_riscv_reset_regs_csr(env);
 }
 
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
-- 
2.48.1


