Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC78C369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 12:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5OgI-0008IU-25; Thu, 17 Apr 2025 08:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u5Og6-00089N-Ks
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 08:49:18 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u5Og2-0004XI-IS
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 08:49:14 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22c33e4fdb8so7438715ad.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 05:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1744894146; x=1745498946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mhMWvebBndCctdZE7v9a5Un+bT2+Jjj+Q/YEZ4K/HOM=;
 b=b0HEl8CoR8ynuVuRHTKZA0FsmpOCs0ovzUg3fnP1+BIX+xpp9N/v+OteXAys2VLhFl
 SyUil+qKsBNp6AANJUsI1wUiBEW/YBF8h57GeVYfIPc9Z+Uo6Rt/Ori+eW3xi/P3aMBO
 L6s8kWZi3JNZ6sWQGj5sdDF2LQ/mi6DU3MXKraHu4ujvOdepxxxCDKWbfhnpuiXVCjLu
 9/uc8EDzH8l3c/uyh6JOwLhCk+mOK2d7wOExhXkFaRxMyMXV98P0F5qSrdUvtPmCWMAG
 wMAT492Xyt0CuzUSmQRzqpg9bYZ4P2YqfjvofZRzaZlbueXFItPxR5q7puy2wznxLv0D
 SKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744894146; x=1745498946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mhMWvebBndCctdZE7v9a5Un+bT2+Jjj+Q/YEZ4K/HOM=;
 b=Mz1uYT0W5NEOrp5V9EV1vrwMY602ynq6MW6IwmhQNU7oh+lO0gb4Sre8wIO/WriHcK
 ODvbgn9P7GOxi2abcGqqG6YNHDaJgFiI5OXim9hLpeDtvBDtTM0tAa/tkUp1DsrXAfCZ
 ZwYYdn/QbcRRIn+QWMNIRK4qGzAjTS34EVsH0ZySfCyN2GtZwrTuebORIayhGrXRZoLE
 eX0v93ynByLIclGs/OahmuR5MJKkrT3PF/i6ip5Be7jJy+/8UMRKUZFP5zv5kmigoidc
 ZIp3vg5RNHQ1WU75MgmEEmSVXAqufAOH1vbxWWS070oWC6NMEt5NrprgENKR80WnA4M+
 NjFA==
X-Gm-Message-State: AOJu0YylBgtxlVUAsxdqyanfofI5dv8JcZzeBavDJnDsNczxKiomaoYo
 Xvmnl+6EWFFWjc/cRhnPecbIqL43jSOykLfZO100dA17LKV0SJatdJdABuIZT+EL2IHjpEo2fN0
 x
X-Gm-Gg: ASbGncv+9ZNgBnAv+gGt1RB+uADXuux3pZzvKCp38dny6R10Rc0+2aXv4TG+ER65LT2
 GH3h4PuapUFc0vEBpIXoaoXJ8SHQrN57ArAW6PAnyFxGaDgWFGDw1GnGeGqxOkVZij82fRbfrH2
 4flHJcBYxNrDFrzt3bZBFfv7t5yUXoJV4wIC+jofR5A8zEQ1Nc2gVZwEKKU3GBn7cUoO3u9tmAp
 i8SBITuxzI5QoexnkZYLnSq5eyQYKki2QJ0rp0xS9xumcKDhf/yLxYMHea+jEbd+mAbZrLyR/Mh
 mWQkA6w1EhjoA8BdaO/6hXq0j0xkW9YS0VrnuFa+FtsHaN2pEu6RXXru21Ho4rQH8AQ6
X-Google-Smtp-Source: AGHT+IF6hXL3iBN48ZBxahp6sM3v/TELb/KEXJ4f2w683HhxVwsFiDm46KNyf5r4nuKeXaMbUeUh0g==
X-Received: by 2002:a17:903:24c:b0:227:e74a:a066 with SMTP id
 d9443c01a7336-22c35916cc4mr74355195ad.28.1744894146139; 
 Thu, 17 Apr 2025 05:49:06 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fe6dbasm32175065ad.239.2025.04.17.05.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 05:49:05 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, abologna@redhat.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 7/7] target/riscv/kvm: reset 'scounteren' with host val
Date: Thu, 17 Apr 2025 09:48:39 -0300
Message-ID: <20250417124839.1870494-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417124839.1870494-1-dbarboza@ventanamicro.com>
References: <20250417124839.1870494-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The Linux kernel, up until at least version 6.12, has issues with a KVM
guest setting scounteren to 0 during reset. No error will be thrown
during boot, but trying to use rdtime in the guest (by executing 'ping'
for example) will result in a stack trace and an illegal instruction
error:

/ # ping 8.8.8.8
PING 3.33.130.190 (8.8.8.8): 56 data bytes
[   19.464484] ping[56]: unhandled signal 4 code 0x1 at 0x00007fffae0665f4
[   19.493332] CPU: 0 PID: 56 Comm: ping Not tainted 6.9.0-rc3-dbarboza #7
[   19.523249] Hardware name: riscv-virtio,qemu (DT)
[   19.546641] epc : 00007fffae0665f4 ra : 00000000000c6316 sp : 00007fffc7cfd9f0
[   19.576214]  gp : 0000000000172408 tp : 00000000001767a0 t0 : 0000000000000000
[   19.606719]  t1 : 0000000000000020 t2 : 0000000000000000 s0 : 00007fffc7cfda00
[   19.640938]  s1 : 00007fffc7cfda30 a0 : 0000000000000001 a1 : 00007fffc7cfda30
[   19.676698]  a2 : 0000000000000000 a3 : 00000000000009ee a4 : 00007fffae064000
[   19.721036]  a5 : 0000000000000001 a6 : 0000000000000000 a7 : 00000000001784d0
[   19.765061]  s2 : 00000000001784d0 s3 : 000000000011ca38 s4 : 000000000011d000
[   19.801985]  s5 : 0000000000000001 s6 : 0000000000000000 s7 : 0000000000000000
[   19.841235]  s8 : 0000000000177788 s9 : 0000000000176828 s10: 0000000000000000
[   19.882479]  s11: 00000000001777a8 t3 : ffffffffffffffff t4 : 0000000000172f60
[   19.923651]  t5 : 0000000000000020 t6 : 000000000000000a
[   19.950491] status: 0000000200004020 badaddr: 00000000c01027f3 cause: 0000000000000002
[   19.995864] Code: 431c f613 0017 869b 0007 ea59 000f 0220 435c cfbd (27f3) c010
Illegal instruction
/ #

Reading the host scounteren val and using it during reset, instead of
zeroing it, will prevent this error. It is worth noting that scounteren
is a WARL reg according to the RISC-V ISA spec, and in theory the kernel
should accept a zero val and convert it to something that won't break
the guest.

We can't tell from userspace if the host kernel handles scounteren = 0
during reset accordingly, so to prevent this error we'll assume that it
won't. Read the reg from the host and use it as reset value.

We'll end up repeating code from kvm_riscv_get_regs_csr() to do that.
Create a helper that will get a single CSR and use it in get_regs_csr()
and in kvm_riscv_reset_regs_csr() to avoid code duplication.

Fixes: 4db19d5b21 ("target/riscv/kvm: add missing KVM CSRs")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 73 ++++++++++++++++++++++++++++----------
 1 file changed, 55 insertions(+), 18 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index a91a87b175..918fe51257 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -634,29 +634,40 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
     return ret;
 }
 
-static int kvm_riscv_get_regs_csr(CPUState *cs)
+static int kvm_riscv_get_reg_csr(CPUState *cs,
+                                 KVMCPUConfig *csr_cfg)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     uint64_t reg;
-    int i, ret;
+    int ret;
 
-    for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
-        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
+    if (!csr_cfg->supported) {
+        return 0;
+    }
 
-        if (!csr_cfg->supported) {
-            continue;
-        }
+    ret = kvm_get_one_reg(cs, csr_cfg->kvm_reg_id, &reg);
+    if (ret) {
+        return ret;
+    }
+
+    if (csr_cfg->prop_size == sizeof(uint32_t)) {
+        kvm_cpu_csr_set_u32(cpu, csr_cfg, reg);
+    } else {
+        kvm_cpu_csr_set_u64(cpu, csr_cfg, reg);
+    }
+
+    return 0;
+}
+
+static int kvm_riscv_get_regs_csr(CPUState *cs)
+{
+    int i, ret;
 
-        ret = kvm_get_one_reg(cs, csr_cfg->kvm_reg_id, &reg);
+    for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
+        ret = kvm_riscv_get_reg_csr(cs, &kvm_csr_cfgs[i]);
         if (ret) {
             return ret;
         }
-
-        if (csr_cfg->prop_size == sizeof(uint32_t)) {
-            kvm_cpu_csr_set_u32(cpu, csr_cfg, reg);
-        } else {
-            kvm_cpu_csr_set_u64(cpu, csr_cfg, reg);
-        }
     }
 
     return 0;
@@ -690,8 +701,11 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
     return 0;
 }
 
-static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
+static void kvm_riscv_reset_regs_csr(CPUState *cs, CPURISCVState *env)
 {
+    uint64_t scounteren_kvm_id = RISCV_CSR_REG(scounteren);
+    int ret;
+
     env->mstatus = 0;
     env->mie = 0;
     env->stvec = 0;
@@ -701,8 +715,30 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
     env->stval = 0;
     env->mip = 0;
     env->satp = 0;
-    env->scounteren = 0;
     env->senvcfg = 0;
+
+    /*
+     * Some kernels will take issue with env->scounteren = 0
+     * causing problems inside the KVM guest with 'rdtime'.
+     * Read 'scounteren' from the host and use it.
+     */
+    for (int i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
+        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
+
+        if (csr_cfg->kvm_reg_id != scounteren_kvm_id) {
+            continue;
+        }
+
+        if (!csr_cfg->supported) {
+            break;
+        }
+
+        ret = kvm_riscv_get_reg_csr(cs, &kvm_csr_cfgs[i]);
+        if (ret) {
+            error_report("Unable to retrieve scounteren from host ,"
+                         "error %d", ret);
+        }
+    }
 }
 
 static int kvm_riscv_get_regs_fp(CPUState *cs)
@@ -1711,16 +1747,17 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
 {
     CPURISCVState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
     int i;
 
     for (i = 0; i < 32; i++) {
         env->gpr[i] = 0;
     }
     env->pc = cpu->env.kernel_addr;
-    env->gpr[10] = kvm_arch_vcpu_id(CPU(cpu)); /* a0 */
+    env->gpr[10] = kvm_arch_vcpu_id(cs);       /* a0 */
     env->gpr[11] = cpu->env.fdt_addr;          /* a1 */
 
-    kvm_riscv_reset_regs_csr(env);
+    kvm_riscv_reset_regs_csr(cs, env);
 }
 
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
-- 
2.49.0


