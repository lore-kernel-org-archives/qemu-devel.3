Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE44CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3e5-0007Ye-Np; Fri, 26 Jun 2026 06:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dl-0007GM-TK
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3de-0005Ar-39
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YDk/PP2EpHiCfKWGuR3JeDRX3vI+ycdJA1d8xSPIUgU=;
 b=Ei2hiN23eUcniXe0p6Sx/u6FVF/5dkoRJp3amf4NV2wcEGCKxRm8JfB9ZU2andW4TST+q6
 NiO83x4qSqR9oDv8z1QODdgCJka5iLFGCZsGVNCh7KiMNarl1MyuPopfPh5MHrGX1zCLjg
 c/ykpfsxw0Ybd3TDoaM2HYfLUa2oBfU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-6jABUwHQOxelqmSYCLqJUA-1; Fri, 26 Jun 2026 06:18:20 -0400
X-MC-Unique: 6jABUwHQOxelqmSYCLqJUA-1
X-Mimecast-MFC-AGG-ID: 6jABUwHQOxelqmSYCLqJUA_1782469099
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4625b4f54c6so584991f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469099; x=1783073899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YDk/PP2EpHiCfKWGuR3JeDRX3vI+ycdJA1d8xSPIUgU=;
 b=B2AWnpm5QPrpREj33x4BQXuKTX9QHVFlgy4vRPokTz36kIRKBBqZk36wfR/DcxofH/
 f2iFNDtbTd+BHXAGDOUNswARfig3ygWl+eraa8/c74z6zDBtEu7BYD3eyaCjmgNBSv1U
 rVzZBkOEFFG48gnd0Qc8WO2vqC838vmoOEF0jOuODs3Dl3iXRGkqIm+6YodVNY3rkNTj
 8RTaJOAjbpTdVL+jJcgdxo5JYvzE8Upmi4yGtfw2Vx5Vzo2vX9CbyNopyGODZNkIRSjE
 EVbaYQS4V7GAcl5bGCu5Kxarp6YzJr8fIuvuZ2me5XbIAc11q9ZNSShDgssMxUxFBDJT
 boug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469099; x=1783073899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YDk/PP2EpHiCfKWGuR3JeDRX3vI+ycdJA1d8xSPIUgU=;
 b=bFhKV4J7i2bDsXup9LOyzIPdS3pZ2lbF4kM74OcuIJNJCaOrH7SxEk/yTKnRBJr6Qx
 RsZgcHDmG48/RE2sIAKtI13IGPJ8k/lbIyhuBwMVwm+txC8xUgajj6xP9/QcwAoaX6p9
 F4WDtuj8Y0J+gJ/pVISWLAQoo2ieTA3oVsCIn9HUn7GBbWLfBcDajW1G5CYCZ85jhEfr
 bXl3blKAGk0aBMHhEw6esYvzaKMhGiOMp1vYL+cJCkSNLaItdpZq6vsWmUM0K50uQIeJ
 pKNbc6NN1XVYc8XE3Gbl6wuycYlSkjVklQrRU2LKBxynvAdi85Dw6pNWHn1BVizPUB80
 Q8vA==
X-Gm-Message-State: AOJu0YxPIea0feDBPri7bqsyunBhOQZBO1Z+dwUILqEoaVrNBeM0e+oE
 yg3aV+izGUGsAynDx8wAwv6q19zXaqx3kvdtd3SWJcjN1x2+CFneXj8B+iH/kiFgZV5bmJRpWPN
 ZvIlVh6Xqt+7Poc65Up1tyQVKMNiPDXq6BSTJNMA2ASiyS8wVhC+v/C3fWrz0kUGFxkIV3qyRPM
 ZUT1fx2hxRd9XkfD3ul7kYyihZ8yBzkj9t3MVgk6Wt
X-Gm-Gg: AfdE7clBgYt9nydDzWr+EtDIrZbVUqzn1zjPWAHzVNfWp+JW3HFAq6ra+k10G7tBcO1
 CmDqaaGobHCCSU8TmbDpOlxEuCpGPXl8A+nUA/7heCplf+C5obSVgmemhrvAGATEvcfCjT6Ao+R
 ie2IzhLstbhtMVNYOxFR4TtbKy+gRvZAocxzapeRhBmVC8A6nUjaiZojK7dek8RBVyg31YqCbin
 vh6oUejrBPEchI8cfHJyfz87N6jojPL1yQkgY3oFou6MvYeyOQTo3pSIWSRBf0k3izEZalW7DpY
 fQ4HokNlQ4tm9XtrxxAlWccDuexh6uiIejpXojjMYHFK2yyL9cG8BfGRCO3EprU0Spjm93YkWaS
 MUf7kn3312vzZfUfCL2PmdCDTpS/YpUQcRCrruB1YLtCkj+XVZVXFudQ40wCXJvcOdPPBi+Zbhv
 LfQ4ags34aZofuMJ29
X-Received: by 2002:a05:6000:250d:b0:460:6a13:9131 with SMTP id
 ffacd0b85a97d-46dbfab5605mr10531735f8f.19.1782469098779; 
 Fri, 26 Jun 2026 03:18:18 -0700 (PDT)
X-Received: by 2002:a05:6000:250d:b0:460:6a13:9131 with SMTP id
 ffacd0b85a97d-46dbfab5605mr10531672f8f.19.1782469098268; 
 Fri, 26 Jun 2026 03:18:18 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46f4ffc11d9sm2810904f8f.37.2026.06.26.03.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:18:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 10/45] target/i386/mshv: use arch_load/store_reg fns
Date: Fri, 26 Jun 2026 12:17:13 +0200
Message-ID: <20260626101748.1728079-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Improved consistency around the naming of load/store register fn's. this
is required since we want to roundtrip more registers in a migration
than what's currently required for MMIO emulation.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-2-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h   |  6 ++---
 accel/mshv/mshv-all.c       |  2 +-
 target/i386/mshv/mshv-cpu.c | 52 ++++++++++++++-----------------------
 3 files changed, 23 insertions(+), 37 deletions(-)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index ca156cdf4be..bf0fe571f01 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -82,11 +82,9 @@ void mshv_init_mmio_emu(void);
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
 int mshv_configure_vcpu(const CPUState *cpu, const MshvFPU *fpu, uint64_t xcr0);
-int mshv_get_standard_regs(CPUState *cpu);
-int mshv_get_special_regs(CPUState *cpu);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
-int mshv_load_regs(CPUState *cpu);
-int mshv_store_regs(CPUState *cpu);
+int mshv_arch_load_regs(CPUState *cpu);
+int mshv_arch_store_regs(CPUState *cpu);
 int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
                           size_t n_regs);
 int mshv_arch_put_registers(const CPUState *cpu);
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 52623be5d93..ec9c90cddda 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -729,7 +729,7 @@ static void mshv_cpu_synchronize_pre_loadvm(CPUState *cpu)
 static void do_mshv_cpu_synchronize(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->accel->dirty) {
-        int ret = mshv_load_regs(cpu);
+        int ret = mshv_arch_load_regs(cpu);
         if (ret < 0) {
             error_report("Failed to load registers for vcpu %d",
                          cpu->cpu_index);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 3523cfcb70c..fba95392b9d 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -110,6 +110,8 @@ static enum hv_register_name FPU_REGISTER_NAMES[26] = {
     HV_X64_REGISTER_XMM_CONTROL_STATUS,
 };
 
+static int set_special_regs(const CPUState *cpu);
+
 static int translate_gva(const CPUState *cpu, uint64_t gva, uint64_t *gpa,
                          uint64_t flags)
 {
@@ -288,7 +290,7 @@ static int set_standard_regs(const CPUState *cpu)
     return 0;
 }
 
-int mshv_store_regs(CPUState *cpu)
+int mshv_arch_store_regs(CPUState *cpu)
 {
     int ret;
 
@@ -298,6 +300,12 @@ int mshv_store_regs(CPUState *cpu)
         return -1;
     }
 
+    ret = set_special_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to store speical registers");
+        return ret;
+    }
+
     return 0;
 }
 
@@ -326,7 +334,7 @@ static void populate_standard_regs(const hv_register_assoc *assocs,
     rflags_to_lflags(env);
 }
 
-int mshv_get_standard_regs(CPUState *cpu)
+static int get_standard_regs(CPUState *cpu)
 {
     struct hv_register_assoc assocs[ARRAY_SIZE(STANDARD_REGISTER_NAMES)];
     int ret;
@@ -404,8 +412,7 @@ static void populate_special_regs(const hv_register_assoc *assocs,
     cpu_set_apic_base(x86cpu->apic_state, assocs[16].value.reg64);
 }
 
-
-int mshv_get_special_regs(CPUState *cpu)
+static int get_special_regs(CPUState *cpu)
 {
     struct hv_register_assoc assocs[ARRAY_SIZE(SPECIAL_REGISTER_NAMES)];
     int ret;
@@ -425,17 +432,17 @@ int mshv_get_special_regs(CPUState *cpu)
     return 0;
 }
 
-int mshv_load_regs(CPUState *cpu)
+int mshv_arch_load_regs(CPUState *cpu)
 {
     int ret;
 
-    ret = mshv_get_standard_regs(cpu);
+    ret = get_standard_regs(cpu);
     if (ret < 0) {
         error_report("Failed to load standard registers");
         return -1;
     }
 
-    ret = mshv_get_special_regs(cpu);
+    ret = get_special_regs(cpu);
     if (ret < 0) {
         error_report("Failed to load special registers");
         return -1;
@@ -1159,16 +1166,16 @@ static int emulate_instruction(CPUState *cpu,
     int ret;
     x86_insn_stream stream = { .bytes = insn_bytes, .len = insn_len };
 
-    ret = mshv_load_regs(cpu);
+    ret = mshv_arch_load_regs(cpu);
     if (ret < 0) {
-        error_report("failed to load registers");
+        error_report("Failed to load registers");
         return -1;
     }
 
     decode_instruction_stream(env, &decode, &stream);
     exec_instruction(env, &decode);
 
-    ret = mshv_store_regs(cpu);
+    ret = mshv_arch_store_regs(cpu);
     if (ret < 0) {
         error_report("failed to store registers");
         return -1;
@@ -1347,25 +1354,6 @@ static int handle_pio_non_str(const CPUState *cpu,
     return 0;
 }
 
-static int fetch_guest_state(CPUState *cpu)
-{
-    int ret;
-
-    ret = mshv_get_standard_regs(cpu);
-    if (ret < 0) {
-        error_report("Failed to get standard registers");
-        return -1;
-    }
-
-    ret = mshv_get_special_regs(cpu);
-    if (ret < 0) {
-        error_report("Failed to get special registers");
-        return -1;
-    }
-
-    return 0;
-}
-
 static int read_memory(const CPUState *cpu, uint64_t initial_gva,
                        uint64_t initial_gpa, uint64_t gva, uint8_t *data,
                        size_t len)
@@ -1485,9 +1473,9 @@ static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
 
-    ret = fetch_guest_state(cpu);
+    ret = mshv_arch_load_regs(cpu);
     if (ret < 0) {
-        error_report("Failed to fetch guest state");
+        error_report("Failed to load registers");
         return -1;
     }
 
@@ -1518,7 +1506,7 @@ static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
 
     ret = set_x64_registers(cpu, reg_names, reg_values);
     if (ret < 0) {
-        error_report("Failed to set x64 registers");
+        error_report("Failed to set RIP and RAX registers");
         return -1;
     }
 
-- 
2.54.0


