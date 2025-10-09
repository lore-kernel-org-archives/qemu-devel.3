Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38957CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lRK-0000Cs-2n; Thu, 09 Oct 2025 03:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lRG-0000Bu-Nq
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lRB-0004UA-0o
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+wOqIA00+2P30PgO3MjOrt5nn3whgZt6cWLk1eUimlA=;
 b=BhHkXOYCiUnzsHDKREqy2IfdCKWUhwoVg7T/VsJ9W27IfkwifaaWw14JptIGtFQXxSul9s
 OgJXjrnx6i7acaBFkz9WvJqE71U7yngE8qbVo2eDx4f1Rz59puz4cZxkPMuhZ6a5e/ZqP9
 w+n6NC9nuhdxUCv+xDv8yMbteE04/5s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-FWhQntWAPdS2eET1d75xTQ-1; Thu, 09 Oct 2025 03:51:40 -0400
X-MC-Unique: FWhQntWAPdS2eET1d75xTQ-1
X-Mimecast-MFC-AGG-ID: FWhQntWAPdS2eET1d75xTQ_1759996300
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e7a2c3773so7859625e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996298; x=1760601098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+wOqIA00+2P30PgO3MjOrt5nn3whgZt6cWLk1eUimlA=;
 b=Ti/RavlC/B/icaBKNtCTT/tXMGOvAEDH+ORq8dfCI8gv4t0ZzkRI1K29rVfIjd8PgJ
 mVC6nWnOtMTWQKzPvqkWm0YfYha1wi+4d/NeNdqVEcEZZ43Le8JVkV+vpZpb5bfbNwiP
 OBNPYviCzfSgSQzGLu0oUo6gV1C7YV3llcIlUB6BhMpg3aBkgH1mwANVac397av6/mNW
 nhnH4ygmznunW6dQ2vzzU0UfGiDCgbJ7NatNJPPPTSq4a24OWVujnosvAIm+BgN6nv6B
 OCO/+akM65VNQMpM2KJrwajSB9hOt5QnDBTFsio9NOFCLZv7LXu+jguISf0XgBHQFxSE
 0X1w==
X-Gm-Message-State: AOJu0YxE7oRD8biIEG7sY0ztY6x1ZBk+Rz7HIQNgCwEdyDg9liYxUVrU
 HuBIIlOY1J/0hZrTpWL6p0L2I0fM/Vt9P0z4a+nEFf/N9vcj1LpMnRGZleocn8vK32dww/yZ9DM
 VobcjyAY2AjA/AZx3GWiEF49IReuiVde8PTThpSHmXmHxcek5Y8wzkkdZiodpvErVSh93Vqdqkt
 wp6JbenOZ994TWcdkKn4QAVDhSRv6R2xyqq1E0DOHF5Qo=
X-Gm-Gg: ASbGncs43A1r9QjEyI1/+d1nH52RJhfMsLt+eny4lTFJrbgsZH6SwWtrK+dSo+6cM+v
 V3k+jn3yPopjkbjqoHy8XQ/5UwZ/rGkSqQhaxauxcsSylFKBf4KJZOlmM6sSj/WvSrsft14Xdpz
 IV/mc0vFGafRukU6NBit9byHkkOxQ38p+Xf6S2E4q7aFoOmMN6JgVGUOLtEVvmc/1uOOv3LNQwr
 YTCsS+L1pRxa5fWc8iCUOJ1da4t+Ca+2j5qaqA4fk4giWKUpkwWUoDjVrqv+1+Ue0y+yjiQydiU
 DlogPCz1xngefEN7IsW2bROXFy5nxkCOkDKzdNYzJQ2D2F/pucuPK+OFeMtgYYCRKx+Y5XrFpof
 ItkNX2GeFjd/7z2wmSs/e8uNyjknW6hz9KVu2/tx6E5PSCoD+
X-Received: by 2002:a05:600c:8a8:b0:46d:38c4:1ac9 with SMTP id
 5b1f17b1804b1-46fa2952c99mr43879895e9.2.1759996298376; 
 Thu, 09 Oct 2025 00:51:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+yhF/3xtvAR9nF2QwTpmPEbmP/LRAts19mBJVnh2C3KgJojsjLH/l92YmUYziuTGFEa9+EA==
X-Received: by 2002:a05:600c:8a8:b0:46d:38c4:1ac9 with SMTP id
 5b1f17b1804b1-46fa2952c99mr43879725e9.2.1759996297841; 
 Thu, 09 Oct 2025 00:51:37 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46faf105ad7sm33921625e9.4.2025.10.09.00.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:51:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 31/35] target/i386/mshv: Use preallocated page for hvcall
Date: Thu,  9 Oct 2025 09:50:21 +0200
Message-ID: <20251009075026.505715-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


