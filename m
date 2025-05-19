Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EC8C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs4d-0002yR-F2; Mon, 19 May 2025 00:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrol-0008E1-Gi; Mon, 19 May 2025 00:09:43 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGroi-0004MC-3u; Mon, 19 May 2025 00:09:35 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22fcf9cf3c2so32633755ad.0; 
 Sun, 18 May 2025 21:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627769; x=1748232569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EC1is24wo4EqnqiL+75cKNQLUBaPpMKZFiS8gFEUSwo=;
 b=KG7HJjd3jk3/lEdXOaUjbp8J8rpwq6H+ibRkUlOvmrInnLPAksuOLPnwxxWODqh8gj
 SPTsdcUMS5HnPtq+QCfu9oaXBaMChSVWrYqp4/z5RPiEscQKCoxQbzPvTULAT0tVzzb7
 rYMbP+YgCPQ17/n/9ei9+wIY7JHpcc6mfFEdIPt4R3sCQKhjVFZLkhVyuM9JHxDWHVwh
 Fkjd0LXEARo00Vn3CLiXQIEEQEg8h+VDE1XadQHg3R9OXxtlR2jFNOtsGyQ2zC5FBoOH
 z4Xa7XydXfIvQfsXpzfCtHtbX+DX6anzsJ7nzja2CM02kYtbiBLgDr6O1TYNCWcX2qcU
 goyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627769; x=1748232569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EC1is24wo4EqnqiL+75cKNQLUBaPpMKZFiS8gFEUSwo=;
 b=i32ieNv+9S3nPYqYe1GokjqTDW7u3DZdWJj6szp5UluGQjdA+e/MJvIMrwZYpD/9Ev
 Ibe/n1/rfPzwNIvSC0zyDAIPsDj3N1XO0iWcCpARK/ial0O0trY9eX2bV6gwucPjq55A
 cH1lDFKVoTEsAKJewpachKOPVrh6LpIYVZRqa5ISKOpD7Je8K6/tE7bxFhlha9JHfUfj
 b1DwQxJdhAszP/OzNmTN9DzM7Yfb978WhKLo5dikOIYXqq4Cp45HZalgY2Z8OHvNvGoR
 F0DTVkC792DuI+CPyzC0/LlXfMP5HxkDTfNBu9VOnWlGL69c2WRfr22yOpJ6AFSgggM1
 nZvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt4wDfhS0kn7q0zwTDLEBciTe9esdhmIZHECCFSNCIqR337nGWIwWIZ2ZVzdkrngwaHWeq5Z2SbI9w4w==@nongnu.org
X-Gm-Message-State: AOJu0YxOT6gWIzWyzg6D1G3Kl2ITgDXBIYL2EBFM6rD8C6XQu6U33lAA
 /E0RN3uRfY/y+Ro6kxwA2OLSlaCgmJuTRbszVJdsCPJ1XxpjT5CgjTuJ7mml+Q==
X-Gm-Gg: ASbGnct/9norlt8qW8Z2RnBsLOWKyB6msSOaXfusSQtWY6c48zqZ3nhT059iM07Lh6S
 LyZM0QiIfuXGKOMD6cCbnCBCvMeURNJhT3cDQap/Bw4SevHgc696ZbCFSng3eLZEBKl5QDOAnzD
 3TNKwxzY+N23fZ9XDxdCCsZE/lELkiWYoQY5HWDkYrhzoEZXJrbYBHsbhJ4KHHzsgJYrIa86SCA
 ZQjjmSZT5LaJZuIuvp2/A7U5w0d//oeOBxjlGo6Lf8IIfmRVu1up32mj4r9jC6wQL/9KVTs8EWO
 23IprIcb5guXll9JxI7VKsJJrwGOGUQESgPmUxVYWuo9c3ybseGt4JCn9ML74669ox8vOkMWnmf
 ZvCzxX8MLd65JyeFJW0Tr35Cm0QrbF+ockDPrrxw+QWkpmuSu7EKD3OlY
X-Google-Smtp-Source: AGHT+IE2aE7/BZ4ua2dM60fBFoMJsQOLZ92KT29UIEz/D7V3cltPbXVBSTQpU5ZenBSnpm2gRWWrTA==
X-Received: by 2002:a17:903:3d0f:b0:231:c99b:9fd7 with SMTP id
 d9443c01a7336-231d43ad4b6mr161286545ad.19.1747627769453; 
 Sun, 18 May 2025 21:09:29 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:09:28 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL 44/56] target/riscv/kvm: do not read unavailable CSRs
Date: Mon, 19 May 2025 14:05:41 +1000
Message-ID: <20250519040555.3797167-45-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

[1] reports that commit 4db19d5b21 broke a KVM guest running kernel 6.6.
This happens because the kernel does not know 'senvcfg', making it
unable to boot because QEMU is reading/wriiting it without any checks.

After converting the CSRs to do "automated" get/put reg procedures in
the previous patch we can now scan for availability. Two functions are
created:

- kvm_riscv_read_csr_cfg_legacy() will check if the CSR exists by brute
  forcing KVM_GET_ONE_REG in each one of them, interpreting an EINVAL
  return as indication that the CSR isn't available. This will be use in
  absence of KVM_GET_REG_LIST;

- kvm_riscv_read_csr_cfg() will use the existing result of get_reg_list
  to check if the CSRs ids are present.

kvm_riscv_init_multiext_cfg() is now kvm_riscv_init_cfg() to reflect that
the function is also dealing with CSRs.

[1] https://lore.kernel.org/qemu-riscv/CABJz62OfUDHYkQ0T3rGHStQprf1c7_E0qBLbLKhfv=+jb0SYAw@mail.gmail.com/

Fixes: 4db19d5b21 ("target/riscv/kvm: add missing KVM CSRs")
Reported-by: Andrea Bolognani <abologna@redhat.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250429124421.223883-7-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 target/riscv/kvm/kvm-cpu.c | 62 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 3 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 3740514bba..344616c1cc 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -636,6 +636,10 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
     for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
         KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
 
+        if (!csr_cfg->supported) {
+            continue;
+        }
+
         ret = kvm_get_one_reg(cs, csr_cfg->kvm_reg_id, &reg);
         if (ret) {
             return ret;
@@ -662,6 +666,10 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
     for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
         KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
 
+        if (!csr_cfg->supported) {
+            continue;
+        }
+
         if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
             reg = kvm_cpu_csr_get_u32(cpu, csr_cfg);
         } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
@@ -1090,6 +1098,32 @@ static void kvm_riscv_read_multiext_legacy(RISCVCPU *cpu,
     }
 }
 
+static void kvm_riscv_read_csr_cfg_legacy(KVMScratchCPU *kvmcpu)
+{
+    uint64_t val;
+    int i, ret;
+
+    for (i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
+        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
+        struct kvm_one_reg reg;
+
+        reg.id = csr_cfg->kvm_reg_id;
+        reg.addr = (uint64_t)&val;
+        ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
+        if (ret != 0) {
+            if (errno == EINVAL) {
+                csr_cfg->supported = false;
+            } else {
+                error_report("Unable to read KVM CSR %s: %s",
+                             csr_cfg->name, strerror(errno));
+                exit(EXIT_FAILURE);
+            }
+        } else {
+            csr_cfg->supported = true;
+        }
+    }
+}
+
 static int uint64_cmp(const void *a, const void *b)
 {
     uint64_t val1 = *(const uint64_t *)a;
@@ -1146,7 +1180,26 @@ static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
     }
 }
 
-static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
+static void kvm_riscv_read_csr_cfg(struct kvm_reg_list *reglist)
+{
+    struct kvm_reg_list *reg_search;
+    uint64_t reg_id;
+
+    for (int i = 0; i < ARRAY_SIZE(kvm_csr_cfgs); i++) {
+        KVMCPUConfig *csr_cfg = &kvm_csr_cfgs[i];
+
+        reg_id = csr_cfg->kvm_reg_id;
+        reg_search = bsearch(&reg_id, reglist->reg, reglist->n,
+                             sizeof(uint64_t), uint64_cmp);
+        if (!reg_search) {
+            continue;
+        }
+
+        csr_cfg->supported = true;
+    }
+}
+
+static void kvm_riscv_init_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
 {
     g_autofree struct kvm_reg_list *reglist = NULL;
     KVMCPUConfig *multi_ext_cfg;
@@ -1163,7 +1216,9 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
      * (EINVAL). Use read_legacy() in this case.
      */
     if (errno == EINVAL) {
-        return kvm_riscv_read_multiext_legacy(cpu, kvmcpu);
+        kvm_riscv_read_multiext_legacy(cpu, kvmcpu);
+        kvm_riscv_read_csr_cfg_legacy(kvmcpu);
+        return;
     } else if (errno != E2BIG) {
         /*
          * E2BIG is an expected error message for the API since we
@@ -1226,6 +1281,7 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
     }
 
     kvm_riscv_check_sbi_dbcn_support(cpu, reglist);
+    kvm_riscv_read_csr_cfg(reglist);
 }
 
 static void riscv_init_kvm_registers(Object *cpu_obj)
@@ -1239,7 +1295,7 @@ static void riscv_init_kvm_registers(Object *cpu_obj)
 
     kvm_riscv_init_machine_ids(cpu, &kvmcpu);
     kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
-    kvm_riscv_init_multiext_cfg(cpu, &kvmcpu);
+    kvm_riscv_init_cfg(cpu, &kvmcpu);
 
     kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
 }
-- 
2.49.0


