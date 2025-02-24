Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC2FC021B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 12:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmXce-0004cF-KS; Mon, 24 Feb 2025 07:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmXcX-0004aW-Tx
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 07:31:39 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmXcW-0007e6-7V
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 07:31:37 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-220d398bea9so65127105ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 04:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740400293; x=1741005093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JPRjPzsyH6ci6P/bl1qfQrjC3pu5csoKQFGIXMVv/Tg=;
 b=AjqThLlvhMkd6jJsI1YeX7/L4pm+LasMsDxh4sHF0CaFyU8kFNpOQX0GJnl1Om6Y0W
 6B7hJkFiCXbZozgdVVAoM+Pm648n6SkQY6ttJTjInfY1H80W1kaFJxsy5WVBn54Ad/1F
 MlQ77lTQdyectK1i1toTz5E79fgoPLnrAIWcRkiEPfWOKvZdOQTqa2GHnchnf/Guehyg
 YxjgRNqTwDbtSu/rlhu5pg1+4JaT3ZqnDve23RmrNLzTYPhVEfXgDBOFYzmhG78JgB3n
 xO2Q1mkGHsos2zPCL4qzpHEvVMPuybGcGRPqFf6xnvHKlGDKr5XyNuRN/2b0mpBb0Lx9
 AqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740400293; x=1741005093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JPRjPzsyH6ci6P/bl1qfQrjC3pu5csoKQFGIXMVv/Tg=;
 b=bcrjobG95hzklI28YjK2n1PDf22ht6kORhnBnEfJOCksK/3kyJJjMV7ARjoeQvoBtn
 DNDRNjRIZcL7119Nh4uonBWNrYEmE4Hac2epW8Gt9PBoNa112Ap1llwxUaSodTNWqqvs
 51wpAuQI68nUt+QJsZCs+ImvtiGzvEIGUTc724GejU6aJbT2jxq0eLzg4o6BavFIMxJ6
 LSxQgpIj7sDBTB6qp3GhXkQpPf0rJsJxdzeR84laUgWTqqaE2pJSqmEqrxafV2AK6LxI
 tzGeTvyF7VnHe3BzqBhSCUuLvZdOkUhOuhfeTBugn7lyyD0OMc5nLYu/fZIGW/L7qOR9
 BqhA==
X-Gm-Message-State: AOJu0YxqXpUaqwXPZnOYIwoYeKMDjRQYG0ml8e3n0EaQWRR9IvoaoGK0
 luIoijdkjw8z64YfX92L9YaeWvXyGHOUffzc9Vr0eoSq/vR+MyKs+me+1ZMWYeSE++QTa4FDq/2
 O
X-Gm-Gg: ASbGncuOtu2kvXqPV780+7+LM8ShKn7iUzYFZ/elhAFF0rNzBXIy1zh8ZX82Lwgwoy6
 To8Vj9exeEUJtYq/XI+ldH+XqBiHFKtavpibMYxn6Oh3nCuPT7urmQ99ua/t6H4Z5t3iRlyfnLu
 wgQnwm5j97H2lLW1i3lOfRsvwlRrLhAHu3INB7+Xe7q7v4weq80BiJOm29goCgL43SU7JONAIIR
 wz8TXCzh+TdxTjPK2/RIVscHDFTo5JR5kclv2/8G1lKuew0Qj4kH/0SZd5g2Jdqc/DN614lSsTq
 CsPs/UdWEM/dZ45zX8GBNpJretgvJA==
X-Google-Smtp-Source: AGHT+IHArtpqW7nnZcEKLAW9JADWu2123/0Xf6sNdyyLQ6AFms+O4QhyhMV8QVEjwZfahyyfmqUY1g==
X-Received: by 2002:a05:6a00:238b:b0:732:6222:9edf with SMTP id
 d2e1a72fcca58-73426c7c75bmr21090522b3a.5.1740400293515; 
 Mon, 24 Feb 2025 04:31:33 -0800 (PST)
Received: from grind.. ([177.170.227.219]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73242568af8sm20554470b3a.48.2025.02.24.04.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 04:31:33 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 2/3] target/riscv/kvm: add kvm_riscv_reset_regs_csr()
Date: Mon, 24 Feb 2025 09:31:19 -0300
Message-ID: <20250224123120.1644186-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224123120.1644186-1-dbarboza@ventanamicro.com>
References: <20250224123120.1644186-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
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
---
 target/riscv/kvm/kvm-cpu.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 19bb87515b..cabc34b6a2 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -608,6 +608,19 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
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
@@ -1612,14 +1625,8 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
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


