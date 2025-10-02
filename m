Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CCBCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Mw2-0001Kw-J1; Thu, 02 Oct 2025 13:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4Mvc-00013z-2s
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MvQ-0005tE-Uf
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+wOqIA00+2P30PgO3MjOrt5nn3whgZt6cWLk1eUimlA=;
 b=TRMKMJmJwwgHDplCXi9QJxXR37fN/54n6MOaKrK1KzSnNePtyfRExRbwB5UcprIitug4Hy
 IHU7ifEAwSZXczeFaFEp6Q3ghXhqkrmkRPnbE7sZXxQZv55E7rvyHWROY6UMGZKb1PCXYS
 yx8oOgUclQh2soJ7MvVndXbD2c0LL/A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81--CH9qluKMz6wP0P746wCyQ-1; Thu, 02 Oct 2025 13:16:57 -0400
X-MC-Unique: -CH9qluKMz6wP0P746wCyQ-1
X-Mimecast-MFC-AGG-ID: -CH9qluKMz6wP0P746wCyQ_1759425416
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b4068ff9c19so117481266b.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425415; x=1760030215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+wOqIA00+2P30PgO3MjOrt5nn3whgZt6cWLk1eUimlA=;
 b=RyilzGUOO15UZUsKt5IjbxGjZ/jl6tFdbo73KdbH/tc30z+j96KCf9SNNYhgQ8vhRc
 fQiMcsI11D5F8ORQcioiRF2bvTquj/JM8EWp2t5TGT3x0wFE/NWXLE/S5JWAaSMuigVa
 92Y1Eh1fN+Fy4c1R/FXlOfdsj12m6oQBHdxqCQkfVzEIPhTQQmzFR9G56Gy0z+5wpP2r
 EPC/a5SsZsXg98XF226SMiCiVyT3NIpfD2j6Xtu7wZBXxRbXM9HUEJXboIgu0dQKFXrc
 v8kwjboZszHOdy265NsMcK73/oJmuuDUE/9AUa8C1MBgxrTPc2qLxzVoyNhc9Rux57hl
 9cIg==
X-Gm-Message-State: AOJu0YysC3uio9RcZR4fUbIe5kdkFps21zxW2ITjQabD+gBmo9Oz7HWH
 3K+NhFZEeJYcDsmKscebBgDmXtw1JAqJqZfKQIO9Qzr45ZV1qHXLkEJkbkcTgZ4Q6SBqOjYfdla
 LKJTvcH5vEyOMIFwN/pCa7hQHqfHcFDWxkN9p0Si5hS+hacMta6k8mohflput3wx82gizRzGqU5
 m8ymhqNfgQAEh5vWJpSXXeitziAuR7jQ5pv5Vmg9DZ
X-Gm-Gg: ASbGncvHwkFaImReZXrOFZmzKiG7c0iC5NaMP7SPWQh7QD+hDq5ZsjSasAMekUR9qUA
 6fqUbjMbr2MNeap0motkQzXVD47nIRNoKlAqBBbCHBDhpEShPAisu+1nedrEQlWHUllZQ55ao+Y
 8tsCidZGNpdws/eSImD98fluQiCEf9kg1jMErai97o7Hq6+29qXAuTFPfFCWaMsAAoSO9thrk7s
 YVQUao2WlfPW3fVsNBilETszaFKWEgNf7WC8krJlm7RZEnWleEXvi2KcZJmnu4l/uTF6ARa+165
 mAWh84Y1WqltZYgPIdTedW2JzfVnjxltpk5V2YdfVLmK8uJT2l0iVjBW1xMRgUXa3qgeomKydYf
 foXVCrBrBuyIooAarACU7aGfLjvcSKcDCfnpT4tIOR4z+Owxb
X-Received: by 2002:a17:906:f5a0:b0:b30:ead5:56d0 with SMTP id
 a640c23a62f3a-b49c334efbbmr20781066b.61.1759425415201; 
 Thu, 02 Oct 2025 10:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFui8qKDfhbQ2hqhn8HwvV2oObkmMyrkiILLVA5hWGVsdqEvwb6/plNuEWLFXNd5chYIx/Mg==
X-Received: by 2002:a17:906:f5a0:b0:b30:ead5:56d0 with SMTP id
 a640c23a62f3a-b49c334efbbmr20777466b.61.1759425414703; 
 Thu, 02 Oct 2025 10:16:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b48628a6d90sm244898866b.0.2025.10.02.10.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:16:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 25/27] target/i386/mshv: Use preallocated page for hvcall
Date: Thu,  2 Oct 2025 19:15:34 +0200
Message-ID: <20251002171536.1460049-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002171536.1460049-1-pbonzini@redhat.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

There are hvcalls that are invoked during MMIO exits, the payload is of
dynamic size. To avoid heap allocations we can use preallocated pages as
in/out buffer for those calls. A page is reserved per vCPU and used for
set/get register hv calls.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-26-magnuskulke@linux.microsoft.com
[Use standard MAX_CONST macro; mshv.h/mshv_int.h split. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h   |  7 +++++++
 accel/mshv/mshv-all.c       |  2 +-
 target/i386/mshv/mshv-cpu.c | 38 +++++++++++++++++++++++++------------
 3 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 6350c69e9d3..490563c1ab2 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -20,9 +20,16 @@
 
 typedef struct hyperv_message hv_message;
 
+typedef struct MshvHvCallArgs {
+    void *base;
+    void *input_page;
+    void *output_page;
+} MshvHvCallArgs;
+
 struct AccelCPUState {
     int cpufd;
     bool dirty;
+    MshvHvCallArgs hvcall_args;
 };
 
 typedef struct MshvMemoryListener {
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 5edfcbad9d2..45174f7c4eb 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -399,8 +399,8 @@ static int mshv_init_vcpu(CPUState *cpu)
     uint8_t vp_index = cpu->cpu_index;
     int ret;
 
-    mshv_arch_init_vcpu(cpu);
     cpu->accel = g_new0(AccelCPUState, 1);
+    mshv_arch_init_vcpu(cpu);
 
     ret = mshv_create_vcpu(vm_fd, vp_index, &cpu->accel->cpufd);
     if (ret < 0) {
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index de87142bffc..1f7b9cb37ec 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -34,6 +34,10 @@
 
 #include <sys/ioctl.h>
 
+#define MAX_REGISTER_COUNT (MAX_CONST(ARRAY_SIZE(STANDARD_REGISTER_NAMES), \
+                            MAX_CONST(ARRAY_SIZE(SPECIAL_REGISTER_NAMES), \
+                                      ARRAY_SIZE(FPU_REGISTER_NAMES))))
+
 static enum hv_register_name STANDARD_REGISTER_NAMES[18] = {
     HV_X64_REGISTER_RAX,
     HV_X64_REGISTER_RBX,
@@ -151,7 +155,7 @@ int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
     int cpu_fd = mshv_vcpufd(cpu);
     int vp_index = cpu->cpu_index;
     size_t in_sz, assocs_sz;
-    hv_input_set_vp_registers *in;
+    hv_input_set_vp_registers *in = cpu->accel->hvcall_args.input_page;
     struct mshv_root_hvcall args = {0};
     int ret;
 
@@ -160,7 +164,7 @@ int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
     in_sz = sizeof(hv_input_set_vp_registers) + assocs_sz;
 
     /* fill the input struct */
-    in = g_malloc0(in_sz);
+    memset(in, 0, sizeof(hv_input_set_vp_registers));
     in->vp_index = vp_index;
     memcpy(in->elements, assocs, assocs_sz);
 
@@ -172,7 +176,6 @@ int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
 
     /* perform the call */
     ret = mshv_hvcall(cpu_fd, &args);
-    g_free(in);
     if (ret < 0) {
         error_report("Failed to set registers");
         return -1;
@@ -193,8 +196,8 @@ static int get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
 {
     int cpu_fd = mshv_vcpufd(cpu);
     int vp_index = cpu->cpu_index;
-    hv_input_get_vp_registers *in;
-    hv_register_value *values;
+    hv_input_get_vp_registers *in = cpu->accel->hvcall_args.input_page;
+    hv_register_value *values = cpu->accel->hvcall_args.output_page;
     size_t in_sz, names_sz, values_sz;
     int i, ret;
     struct mshv_root_hvcall args = {0};
@@ -204,15 +207,14 @@ static int get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
     in_sz = sizeof(hv_input_get_vp_registers) + names_sz;
 
     /* fill the input struct */
-    in = g_malloc0(in_sz);
+    memset(in, 0, sizeof(hv_input_get_vp_registers));
     in->vp_index = vp_index;
     for (i = 0; i < n_regs; i++) {
         in->names[i] = assocs[i].name;
     }
 
-    /* allocate value output buffer */
+    /* determine size of value output buffer */
     values_sz = n_regs * sizeof(union hv_register_value);
-    values = g_malloc0(values_sz);
 
     /* create the hvcall envelope */
     args.code = HVCALL_GET_VP_REGISTERS;
@@ -224,16 +226,13 @@ static int get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
 
     /* perform the call */
     ret = mshv_hvcall(cpu_fd, &args);
-    g_free(in);
     if (ret < 0) {
-        g_free(values);
         error_report("Failed to retrieve registers");
         return -1;
     }
 
     /* assert we got all registers */
     if (args.reps != n_regs) {
-        g_free(values);
         error_report("Failed to retrieve registers: expected %zu elements"
                      ", got %u", n_regs, args.reps);
         return -1;
@@ -243,7 +242,6 @@ static int get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
     for (i = 0; i < n_regs; i++) {
         assocs[i].value = values[i];
     }
-    g_free(values);
 
     return 0;
 }
@@ -1696,6 +1694,19 @@ void mshv_arch_init_vcpu(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
+    AccelCPUState *state = cpu->accel;
+    size_t page = HV_HYP_PAGE_SIZE;
+    void *mem = qemu_memalign(page, 2 * page);
+
+    /* sanity check, to make sure we don't overflow the page */
+    QEMU_BUILD_BUG_ON((MAX_REGISTER_COUNT
+                      * sizeof(hv_register_assoc)
+                      + sizeof(hv_input_get_vp_registers)
+                      > HV_HYP_PAGE_SIZE));
+
+    state->hvcall_args.base = mem;
+    state->hvcall_args.input_page = mem;
+    state->hvcall_args.output_page = (uint8_t *)mem + page;
 
     env->emu_mmio_buf = g_new(char, 4096);
 }
@@ -1704,7 +1715,10 @@ void mshv_arch_destroy_vcpu(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
+    AccelCPUState *state = cpu->accel;
 
+    g_free(state->hvcall_args.base);
+    state->hvcall_args = (MshvHvCallArgs){0};
     g_clear_pointer(&env->emu_mmio_buf, g_free);
 }
 
-- 
2.51.0


