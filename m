Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E18CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3ec-00012l-P8; Fri, 26 Jun 2026 06:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eZ-0000qI-EX
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eW-0005NN-9r
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5qTe4qQrXMwNdhcjN8qbG5KKgxfqPRAjc19lPqN684=;
 b=ImUWlrrdUjAb1v2LKePWJEc0pKyWsvy2eKPoI1ne6l5Uukl8w6T39J5bULjvfw/h38YsTi
 cwpzXKGaAJSs6KfGlvDwXejleN5JcyL2sTWsEUaIlkfW4qhF524pI/VDin0meuL1MPHszv
 ESIE2lnVhFUPeb+geelduTXdyc7SVdA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-cxjWObpPM2akDTDhlCn6Ig-1; Fri, 26 Jun 2026 06:19:14 -0400
X-MC-Unique: cxjWObpPM2akDTDhlCn6Ig-1
X-Mimecast-MFC-AGG-ID: cxjWObpPM2akDTDhlCn6Ig_1782469153
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490c56e2576so5483315e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469153; x=1783073953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o5qTe4qQrXMwNdhcjN8qbG5KKgxfqPRAjc19lPqN684=;
 b=Xj5uKEiAFWVdJd+21qWhe8WXBKqhBOqXF9nJnd+66SVB0LMpvSSpQWkRFphxLe5Ne7
 ZmaL8WH+ApfzuPIdcEcE5KEjk/4IAd9GH6Rm6eoi9XbFgAwapC2iB48KeEBSfoIo4I4/
 yMKn6FvhFpwbiKyMzzf21c56oj0UKalDUO1x5zS7g617UpcPb042oogwyFh/jACWFkmx
 PD+2H52vdFtOB4CUQfQq/NkJ8mK7mdG1HwTarIfaAF3A9FOIXR/6nFqZR1DfWPCE2zD7
 RBdw8Vosdk6huSjXKJLeJgFoWGHlrfpx2jNrIRujlQBs3ZKbNwCkmnOA/KqfEFBiG/vN
 lJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469153; x=1783073953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o5qTe4qQrXMwNdhcjN8qbG5KKgxfqPRAjc19lPqN684=;
 b=fEhgze4HHm97za9KB+EFe/lUmXA3xGMFMyckNzFr0SGAN46kobIWRGNTcTreHAimCn
 HP1MCVwQN0eUB79cVrLyP9IP4uCHxROd1jokvjU7D8AZnKI1YZN4swWLvg9Y0F8Ogs50
 qfPwXC7f18AH3ZuxoEfvUQniL+GxArpepdX7s5Qt/rUXHuntY92Z+8fj8O7dZ6WsEqL9
 3bpjzpwE9Ur0eccHEd67GfVSZ464cIP8qazksTJVVUhrTyubUnqVip9ehwMD9UeF1YUZ
 XLK509Wh73hT3izyjQSTJ8DRbZXe44TtWdxBahcC9WLQ+GOMg6tlcKlxY/xJOUG+rCZ4
 RC5g==
X-Gm-Message-State: AOJu0Yy84SD6ub+vPIU0KrA+lbgvkwoELoicFDx5Ku0ilxzFZQ238yTW
 cHgeloUfn2UrqDk6hJGFaYBQ9BQ7cqRfxrdXbJD34OiTTTicoqwoH69LHGxlr53jrmNDdTICzVG
 fnRvgNJriv89LeYMohmd3+PN3Ny3wBd8syWAtgdeUMgt680L/AfrWo3oAnVC+4Cw0T/7/jzgfBf
 UrdlSxS6uQMOf1cX7RgmlDbsn5wgA8ZYFFLJ4XXtMi
X-Gm-Gg: AfdE7clKMW/+xbejo49C86s708yVLo52K0sTCPrMkkUIv7yZPffBr+62r69PKiIZKZE
 UtrFMPiOIYYYEV4vchxtT6dEklmD+4COEDw0BuRPt+JV5KJVEOwiWmjwavPjw379dApvWAOuvUI
 stClhHwHhuGTBujM1i15ukLiNo6lAL5KVUyayy0y3uexJEEZ/9RA6r1E3OOjvOxNqJMJHZanyUU
 pLCRm8KAL1vWrNdlXD9tcH2razE9G9mwvl9xkNeCrm2Xpjq9gepUmOPshdgVQNp6ogBqxrl0fMF
 C4Hl29q80BMo2h+MrA+8acqz8d2S0XFwSJn9KW95Vt9ge80ftszXKWvl9Zofzw6R57Ie7iREAMU
 LozNllEx7+DcNZfs6MbwC8vKUelBBKSLVYOBVxdaZZ6CwG2vJPIpIa261yf32aR94MlGbLmqJgR
 hs3fipW7Mf6Qn2CN+U
X-Received: by 2002:a05:600c:6094:b0:490:da12:f1fa with SMTP id
 5b1f17b1804b1-4926689343bmr91711195e9.31.1782469152420; 
 Fri, 26 Jun 2026 03:19:12 -0700 (PDT)
X-Received: by 2002:a05:600c:6094:b0:490:da12:f1fa with SMTP id
 5b1f17b1804b1-4926689343bmr91710305e9.31.1782469151696; 
 Fri, 26 Jun 2026 03:19:11 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926c291489sm35258525e9.2.2026.06.26.03.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:19:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 30/45] target/i386/mshv: migrate MSRs
Date: Fri, 26 Jun 2026 12:17:33 +0200
Message-ID: <20260626101748.1728079-31-pbonzini@redhat.com>
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

In this change the we rewrite the existing MSR logic to make MSRs
migratable:

- we map them on existing QEMU fields in the CPU. A table and a macro
  MSHV_ENV_FIELD is used to associate a HV register name to the their msr
  index and their offset in the cpu state struct. The list is not
  exhaustive and will be extended in follow-up commits.
- mshv_set/get_msrs() fns are called in the arch_load/store_vcpu_state()
  fns. they use use generic registers ioctl's and map the input/output
  via load/store_to/from_env() from/to the hv register content to the
  cpu state representation.
- init_msrs() has been moved from mshv-vcpu to the msr source file
- we need to perform some filtering of MSR because before writing and
  reading, because the hvcalls will fail if the partition doesn't
  support a given MSRs.
- Some MSRs are partition-wide and so we will only write the to on the
  BSP.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-21-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/hyperv/hvgdk_mini.h |  14 +
 include/system/mshv_int.h      |  16 +-
 target/i386/mshv/mshv-cpu.c    |  39 +--
 target/i386/mshv/msr.c         | 574 ++++++++++++++-------------------
 4 files changed, 264 insertions(+), 379 deletions(-)

diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index 81fe7f7efb0..b00ec8a6367 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -9,6 +9,19 @@
 
 #define MSHV_IOCTL  0xB8
 
+/* Hyper-V specific model specific registers (MSRs) */
+
+/* HV_X64_SYNTHETIC_MSR */
+#define HV_X64_MSR_GUEST_OS_ID      0x40000000
+#define HV_X64_MSR_HYPERCALL        0x40000001
+#define HV_X64_MSR_VP_INDEX         0x40000002
+#define HV_X64_MSR_RESET            0x40000003
+#define HV_X64_MSR_VP_RUNTIME       0x40000010
+#define HV_X64_MSR_TIME_REF_COUNT   0x40000020
+#define HV_X64_MSR_REFERENCE_TSC    0x40000021
+#define HV_X64_MSR_TSC_FREQUENCY    0x40000022
+#define HV_X64_MSR_APIC_FREQUENCY   0x40000023
+
 typedef enum hv_register_name {
     /* Pending Interruption Register */
     HV_REGISTER_PENDING_INTERRUPTION = 0x00010002,
@@ -161,6 +174,7 @@ typedef enum hv_register_name {
     HV_X64_REGISTER_MSR_IA32_MISC_ENABLE = 0x000800A0,
 
     /* Misc */
+    HV_X64_REGISTER_HYPERCALL       = 0x00090001,
     HV_REGISTER_GUEST_OS_ID         = 0x00090002,
     HV_REGISTER_REFERENCE_TSC       = 0x00090017,
 
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 5a30dceeea8..ba3073888ac 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -129,18 +129,8 @@ bool mshv_log_global_start(MemoryListener *listener, Error **errp);
 void mshv_log_global_stop(MemoryListener *listener);
 
 /* msr */
-typedef struct MshvMsrEntry {
-  uint32_t index;
-  uint32_t reserved;
-  uint64_t data;
-} MshvMsrEntry;
-
-typedef struct MshvMsrEntries {
-    MshvMsrEntry entries[MSHV_MSR_ENTRIES_COUNT];
-    uint32_t nmsrs;
-} MshvMsrEntries;
-
-int mshv_configure_msr(const CPUState *cpu, const MshvMsrEntry *msrs,
-                       size_t n_msrs);
+int mshv_init_msrs(const CPUState *cpu);
+int mshv_get_msrs(CPUState *cpu);
+int mshv_set_msrs(const CPUState *cpu);
 
 #endif
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 8bd63bd9628..a383e0ab104 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -802,6 +802,11 @@ int mshv_arch_load_vcpu_state(CPUState *cpu)
         return ret;
     }
 
+    ret = mshv_get_msrs(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     ret = get_xsave_state(cpu);
     if (ret < 0) {
         return ret;
@@ -1353,6 +1358,11 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
         return ret;
     }
 
+    ret = mshv_set_msrs(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     ret = set_xsave_state(cpu);
     if (ret < 0) {
         return ret;
@@ -1880,33 +1890,6 @@ void mshv_init_mmio_emu(void)
     init_emu(&mshv_x86_emul_ops);
 }
 
-static int init_msrs(const CPUState *cpu)
-{
-    int ret;
-    uint64_t d_t = MSR_MTRR_ENABLE | MSR_MTRR_MEM_TYPE_WB;
-
-    const struct hv_register_assoc assocs[] = {
-        { .name = HV_X64_REGISTER_SYSENTER_CS,       .value.reg64 = 0x0 },
-        { .name = HV_X64_REGISTER_SYSENTER_ESP,      .value.reg64 = 0x0 },
-        { .name = HV_X64_REGISTER_SYSENTER_EIP,      .value.reg64 = 0x0 },
-        { .name = HV_X64_REGISTER_STAR,              .value.reg64 = 0x0 },
-        { .name = HV_X64_REGISTER_CSTAR,             .value.reg64 = 0x0 },
-        { .name = HV_X64_REGISTER_LSTAR,             .value.reg64 = 0x0 },
-        { .name = HV_X64_REGISTER_KERNEL_GS_BASE,    .value.reg64 = 0x0 },
-        { .name = HV_X64_REGISTER_SFMASK,            .value.reg64 = 0x0 },
-        { .name = HV_X64_REGISTER_MSR_MTRR_DEF_TYPE, .value.reg64 = d_t },
-    };
-    QEMU_BUILD_BUG_ON(ARRAY_SIZE(assocs) > MSHV_MSR_ENTRIES_COUNT);
-
-    ret = mshv_set_generic_regs(cpu, assocs, ARRAY_SIZE(assocs));
-    if (ret < 0) {
-        error_report("failed to put msrs");
-        return -1;
-    }
-
-    return 0;
-}
-
 void mshv_arch_init_vcpu(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -1948,7 +1931,7 @@ void mshv_arch_init_vcpu(CPUState *cpu)
     ret = init_cpuid2(cpu);
     assert(ret == 0);
 
-    ret = init_msrs(cpu);
+    ret = mshv_init_msrs(cpu);
     assert(ret == 0);
 
     ret = init_lint(cpu);
diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
index e6e5baef507..7447467dbf5 100644
--- a/target/i386/mshv/msr.c
+++ b/target/i386/mshv/msr.c
@@ -14,362 +14,260 @@
 #include "hw/hyperv/hvgdk_mini.h"
 #include "linux/mshv.h"
 #include "qemu/error-report.h"
+#include "cpu.h"
 
-static uint32_t supported_msrs[64] = {
-    IA32_MSR_TSC,
-    IA32_MSR_EFER,
-    IA32_MSR_KERNEL_GS_BASE,
-    IA32_MSR_APIC_BASE,
-    IA32_MSR_PAT,
-    IA32_MSR_SYSENTER_CS,
-    IA32_MSR_SYSENTER_ESP,
-    IA32_MSR_SYSENTER_EIP,
-    IA32_MSR_STAR,
-    IA32_MSR_LSTAR,
-    IA32_MSR_CSTAR,
-    IA32_MSR_SFMASK,
-    IA32_MSR_MTRR_DEF_TYPE,
-    IA32_MSR_MTRR_PHYSBASE0,
-    IA32_MSR_MTRR_PHYSMASK0,
-    IA32_MSR_MTRR_PHYSBASE1,
-    IA32_MSR_MTRR_PHYSMASK1,
-    IA32_MSR_MTRR_PHYSBASE2,
-    IA32_MSR_MTRR_PHYSMASK2,
-    IA32_MSR_MTRR_PHYSBASE3,
-    IA32_MSR_MTRR_PHYSMASK3,
-    IA32_MSR_MTRR_PHYSBASE4,
-    IA32_MSR_MTRR_PHYSMASK4,
-    IA32_MSR_MTRR_PHYSBASE5,
-    IA32_MSR_MTRR_PHYSMASK5,
-    IA32_MSR_MTRR_PHYSBASE6,
-    IA32_MSR_MTRR_PHYSMASK6,
-    IA32_MSR_MTRR_PHYSBASE7,
-    IA32_MSR_MTRR_PHYSMASK7,
-    IA32_MSR_MTRR_FIX64K_00000,
-    IA32_MSR_MTRR_FIX16K_80000,
-    IA32_MSR_MTRR_FIX16K_A0000,
-    IA32_MSR_MTRR_FIX4K_C0000,
-    IA32_MSR_MTRR_FIX4K_C8000,
-    IA32_MSR_MTRR_FIX4K_D0000,
-    IA32_MSR_MTRR_FIX4K_D8000,
-    IA32_MSR_MTRR_FIX4K_E0000,
-    IA32_MSR_MTRR_FIX4K_E8000,
-    IA32_MSR_MTRR_FIX4K_F0000,
-    IA32_MSR_MTRR_FIX4K_F8000,
-    IA32_MSR_TSC_AUX,
-    IA32_MSR_DEBUG_CTL,
-    HV_X64_MSR_GUEST_OS_ID,
-    HV_X64_MSR_SINT0,
-    HV_X64_MSR_SINT1,
-    HV_X64_MSR_SINT2,
-    HV_X64_MSR_SINT3,
-    HV_X64_MSR_SINT4,
-    HV_X64_MSR_SINT5,
-    HV_X64_MSR_SINT6,
-    HV_X64_MSR_SINT7,
-    HV_X64_MSR_SINT8,
-    HV_X64_MSR_SINT9,
-    HV_X64_MSR_SINT10,
-    HV_X64_MSR_SINT11,
-    HV_X64_MSR_SINT12,
-    HV_X64_MSR_SINT13,
-    HV_X64_MSR_SINT14,
-    HV_X64_MSR_SINT15,
-    HV_X64_MSR_SCONTROL,
-    HV_X64_MSR_SIEFP,
-    HV_X64_MSR_SIMP,
-    HV_X64_MSR_REFERENCE_TSC,
-    HV_X64_MSR_EOM,
+#define MSHV_ENV_FIELD(env, offset) (*(uint64_t *)((char *)(env) + (offset)))
+
+typedef struct MshvMsrEnvMap {
+    uint32_t msr_index;
+    uint32_t hv_name;
+    ptrdiff_t env_offset;
+} MshvMsrEnvMap;
+
+/* We assert that 64bit access to sysenter_cs is safe because of padding */
+QEMU_BUILD_BUG_ON(offsetof(CPUX86State, sysenter_esp) -
+                  offsetof(CPUX86State, sysenter_cs)
+                  < sizeof(uint64_t));
+
+/* Those MSRs have a direct mapping to fields in CPUX86State  */
+static const MshvMsrEnvMap msr_env_map[] = {
+    /* Architectural */
+    { IA32_MSR_EFER, HV_X64_REGISTER_EFER, offsetof(CPUX86State, efer) },
+    { IA32_MSR_PAT,  HV_X64_REGISTER_PAT,  offsetof(CPUX86State, pat) },
+
+    /* Syscall */
+    { IA32_MSR_SYSENTER_CS,    HV_X64_REGISTER_SYSENTER_CS,
+                               offsetof(CPUX86State, sysenter_cs) },
+    { IA32_MSR_SYSENTER_ESP,   HV_X64_REGISTER_SYSENTER_ESP,
+                               offsetof(CPUX86State, sysenter_esp) },
+    { IA32_MSR_SYSENTER_EIP,   HV_X64_REGISTER_SYSENTER_EIP,
+                               offsetof(CPUX86State, sysenter_eip) },
+    { IA32_MSR_STAR,           HV_X64_REGISTER_STAR,
+                               offsetof(CPUX86State, star) },
+    { IA32_MSR_LSTAR,          HV_X64_REGISTER_LSTAR,
+                               offsetof(CPUX86State, lstar) },
+    { IA32_MSR_CSTAR,          HV_X64_REGISTER_CSTAR,
+                               offsetof(CPUX86State, cstar) },
+    { IA32_MSR_SFMASK,         HV_X64_REGISTER_SFMASK,
+                               offsetof(CPUX86State, fmask) },
+    { IA32_MSR_KERNEL_GS_BASE, HV_X64_REGISTER_KERNEL_GS_BASE,
+                               offsetof(CPUX86State, kernelgsbase) },
+
+    /* TSC-related */
+    { IA32_MSR_TSC,          HV_X64_REGISTER_TSC,
+                             offsetof(CPUX86State, tsc) },
+    { IA32_MSR_TSC_AUX,      HV_X64_REGISTER_TSC_AUX,
+                             offsetof(CPUX86State, tsc_aux) },
+    { IA32_MSR_TSC_ADJUST,   HV_X64_REGISTER_TSC_ADJUST,
+                             offsetof(CPUX86State, tsc_adjust) },
+
+    /* Hyper-V per-partition MSRs */
+    { HV_X64_MSR_HYPERCALL,     HV_X64_REGISTER_HYPERCALL,
+                                offsetof(CPUX86State, msr_hv_hypercall) },
+    { HV_X64_MSR_GUEST_OS_ID,   HV_REGISTER_GUEST_OS_ID,
+                                offsetof(CPUX86State, msr_hv_guest_os_id) },
+    { HV_X64_MSR_REFERENCE_TSC, HV_REGISTER_REFERENCE_TSC,
+                                offsetof(CPUX86State, msr_hv_tsc) },
+
+    /* Hyper-V MSRs (non-SINT) */
+    { HV_X64_MSR_SCONTROL,  HV_REGISTER_SCONTROL,
+                            offsetof(CPUX86State, msr_hv_synic_control) },
+    { HV_X64_MSR_SIEFP,     HV_REGISTER_SIEFP,
+                            offsetof(CPUX86State, msr_hv_synic_evt_page) },
+    { HV_X64_MSR_SIMP,      HV_REGISTER_SIMP,
+                            offsetof(CPUX86State, msr_hv_synic_msg_page) },
+
+    /* Other */
+
+    /* TODO: find out processor features that correlate to unsupported MSRs. */
+    /* { IA32_MSR_MISC_ENABLE, HV_X64_REGISTER_MSR_IA32_MISC_ENABLE, */
+    /*                         offsetof(CPUX86State, msr_ia32_misc_enable) }, */
+    /* { IA32_MSR_BNDCFGS,     HV_X64_REGISTER_BNDCFGS, */
+    /*                         offsetof(CPUX86State, msr_bndcfgs) }, */
+    { IA32_MSR_SPEC_CTRL,   HV_X64_REGISTER_SPEC_CTRL,
+                            offsetof(CPUX86State, spec_ctrl) },
 };
-static const size_t msr_count = ARRAY_SIZE(supported_msrs);
 
-static int compare_msr_index(const void *a, const void *b)
+int mshv_init_msrs(const CPUState *cpu)
 {
-    return *(uint32_t *)a - *(uint32_t *)b;
-}
-
-__attribute__((constructor))
-static void init_sorted_msr_map(void)
-{
-    qsort(supported_msrs, msr_count, sizeof(uint32_t), compare_msr_index);
-}
-
-static int mshv_is_supported_msr(uint32_t msr)
-{
-    return bsearch(&msr, supported_msrs, msr_count, sizeof(uint32_t),
-                   compare_msr_index) != NULL;
-}
-
-static int mshv_msr_to_hv_reg_name(uint32_t msr, uint32_t *hv_reg)
-{
-    switch (msr) {
-    case IA32_MSR_TSC:
-        *hv_reg = HV_X64_REGISTER_TSC;
-        return 0;
-    case IA32_MSR_EFER:
-        *hv_reg = HV_X64_REGISTER_EFER;
-        return 0;
-    case IA32_MSR_KERNEL_GS_BASE:
-        *hv_reg = HV_X64_REGISTER_KERNEL_GS_BASE;
-        return 0;
-    case IA32_MSR_APIC_BASE:
-        *hv_reg = HV_X64_REGISTER_APIC_BASE;
-        return 0;
-    case IA32_MSR_PAT:
-        *hv_reg = HV_X64_REGISTER_PAT;
-        return 0;
-    case IA32_MSR_SYSENTER_CS:
-        *hv_reg = HV_X64_REGISTER_SYSENTER_CS;
-        return 0;
-    case IA32_MSR_SYSENTER_ESP:
-        *hv_reg = HV_X64_REGISTER_SYSENTER_ESP;
-        return 0;
-    case IA32_MSR_SYSENTER_EIP:
-        *hv_reg = HV_X64_REGISTER_SYSENTER_EIP;
-        return 0;
-    case IA32_MSR_STAR:
-        *hv_reg = HV_X64_REGISTER_STAR;
-        return 0;
-    case IA32_MSR_LSTAR:
-        *hv_reg = HV_X64_REGISTER_LSTAR;
-        return 0;
-    case IA32_MSR_CSTAR:
-        *hv_reg = HV_X64_REGISTER_CSTAR;
-        return 0;
-    case IA32_MSR_SFMASK:
-        *hv_reg = HV_X64_REGISTER_SFMASK;
-        return 0;
-    case IA32_MSR_MTRR_CAP:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_CAP;
-        return 0;
-    case IA32_MSR_MTRR_DEF_TYPE:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_DEF_TYPE;
-        return 0;
-    case IA32_MSR_MTRR_PHYSBASE0:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0;
-        return 0;
-    case IA32_MSR_MTRR_PHYSMASK0:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0;
-        return 0;
-    case IA32_MSR_MTRR_PHYSBASE1:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1;
-        return 0;
-    case IA32_MSR_MTRR_PHYSMASK1:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1;
-        return 0;
-    case IA32_MSR_MTRR_PHYSBASE2:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2;
-        return 0;
-    case IA32_MSR_MTRR_PHYSMASK2:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2;
-        return 0;
-    case IA32_MSR_MTRR_PHYSBASE3:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3;
-        return 0;
-    case IA32_MSR_MTRR_PHYSMASK3:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3;
-        return 0;
-    case IA32_MSR_MTRR_PHYSBASE4:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4;
-        return 0;
-    case IA32_MSR_MTRR_PHYSMASK4:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4;
-        return 0;
-    case IA32_MSR_MTRR_PHYSBASE5:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5;
-        return 0;
-    case IA32_MSR_MTRR_PHYSMASK5:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5;
-        return 0;
-    case IA32_MSR_MTRR_PHYSBASE6:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6;
-        return 0;
-    case IA32_MSR_MTRR_PHYSMASK6:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6;
-        return 0;
-    case IA32_MSR_MTRR_PHYSBASE7:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7;
-        return 0;
-    case IA32_MSR_MTRR_PHYSMASK7:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7;
-        return 0;
-    case IA32_MSR_MTRR_FIX64K_00000:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX64K00000;
-        return 0;
-    case IA32_MSR_MTRR_FIX16K_80000:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX16K80000;
-        return 0;
-    case IA32_MSR_MTRR_FIX16K_A0000:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX16KA0000;
-        return 0;
-    case IA32_MSR_MTRR_FIX4K_C0000:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KC0000;
-        return 0;
-    case IA32_MSR_MTRR_FIX4K_C8000:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KC8000;
-        return 0;
-    case IA32_MSR_MTRR_FIX4K_D0000:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KD0000;
-        return 0;
-    case IA32_MSR_MTRR_FIX4K_D8000:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KD8000;
-        return 0;
-    case IA32_MSR_MTRR_FIX4K_E0000:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KE0000;
-        return 0;
-    case IA32_MSR_MTRR_FIX4K_E8000:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KE8000;
-        return 0;
-    case IA32_MSR_MTRR_FIX4K_F0000:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KF0000;
-        return 0;
-    case IA32_MSR_MTRR_FIX4K_F8000:
-        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KF8000;
-        return 0;
-    case IA32_MSR_TSC_AUX:
-        *hv_reg = HV_X64_REGISTER_TSC_AUX;
-        return 0;
-    case IA32_MSR_BNDCFGS:
-        *hv_reg = HV_X64_REGISTER_BNDCFGS;
-        return 0;
-    case IA32_MSR_DEBUG_CTL:
-        *hv_reg = HV_X64_REGISTER_DEBUG_CTL;
-        return 0;
-    case IA32_MSR_TSC_ADJUST:
-        *hv_reg = HV_X64_REGISTER_TSC_ADJUST;
-        return 0;
-    case IA32_MSR_SPEC_CTRL:
-        *hv_reg = HV_X64_REGISTER_SPEC_CTRL;
-        return 0;
-    case HV_X64_MSR_GUEST_OS_ID:
-        *hv_reg = HV_REGISTER_GUEST_OS_ID;
-        return 0;
-    case HV_X64_MSR_SINT0:
-        *hv_reg = HV_REGISTER_SINT0;
-        return 0;
-    case HV_X64_MSR_SINT1:
-        *hv_reg = HV_REGISTER_SINT1;
-        return 0;
-    case HV_X64_MSR_SINT2:
-        *hv_reg = HV_REGISTER_SINT2;
-        return 0;
-    case HV_X64_MSR_SINT3:
-        *hv_reg = HV_REGISTER_SINT3;
-        return 0;
-    case HV_X64_MSR_SINT4:
-        *hv_reg = HV_REGISTER_SINT4;
-        return 0;
-    case HV_X64_MSR_SINT5:
-        *hv_reg = HV_REGISTER_SINT5;
-        return 0;
-    case HV_X64_MSR_SINT6:
-        *hv_reg = HV_REGISTER_SINT6;
-        return 0;
-    case HV_X64_MSR_SINT7:
-        *hv_reg = HV_REGISTER_SINT7;
-        return 0;
-    case HV_X64_MSR_SINT8:
-        *hv_reg = HV_REGISTER_SINT8;
-        return 0;
-    case HV_X64_MSR_SINT9:
-        *hv_reg = HV_REGISTER_SINT9;
-        return 0;
-    case HV_X64_MSR_SINT10:
-        *hv_reg = HV_REGISTER_SINT10;
-        return 0;
-    case HV_X64_MSR_SINT11:
-        *hv_reg = HV_REGISTER_SINT11;
-        return 0;
-    case HV_X64_MSR_SINT12:
-        *hv_reg = HV_REGISTER_SINT12;
-        return 0;
-    case HV_X64_MSR_SINT13:
-        *hv_reg = HV_REGISTER_SINT13;
-        return 0;
-    case HV_X64_MSR_SINT14:
-        *hv_reg = HV_REGISTER_SINT14;
-        return 0;
-    case HV_X64_MSR_SINT15:
-        *hv_reg = HV_REGISTER_SINT15;
-        return 0;
-    case IA32_MSR_MISC_ENABLE:
-        *hv_reg = HV_X64_REGISTER_MSR_IA32_MISC_ENABLE;
-        return 0;
-    case HV_X64_MSR_SCONTROL:
-        *hv_reg = HV_REGISTER_SCONTROL;
-        return 0;
-    case HV_X64_MSR_SIEFP:
-        *hv_reg = HV_REGISTER_SIEFP;
-        return 0;
-    case HV_X64_MSR_SIMP:
-        *hv_reg = HV_REGISTER_SIMP;
-        return 0;
-    case HV_X64_MSR_REFERENCE_TSC:
-        *hv_reg = HV_REGISTER_REFERENCE_TSC;
-        return 0;
-    case HV_X64_MSR_EOM:
-        *hv_reg = HV_REGISTER_EOM;
-        return 0;
-    default:
-        error_report("failed to map MSR %u to HV register name", msr);
-        return -1;
-    }
-}
-
-static int set_msrs(const CPUState *cpu, GList *msrs)
-{
-    size_t n_msrs;
-    GList *entries;
-    MshvMsrEntry *entry;
-    enum hv_register_name name;
-    struct hv_register_assoc *assoc;
     int ret;
-    size_t i = 0;
+    uint64_t d_t = MSR_MTRR_ENABLE | MSR_MTRR_MEM_TYPE_WB;
 
-    n_msrs = g_list_length(msrs);
-    hv_register_assoc *assocs = g_new0(hv_register_assoc, n_msrs);
+    const struct hv_register_assoc assocs[] = {
+        { .name = HV_X64_REGISTER_SYSENTER_CS,       .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_SYSENTER_ESP,      .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_SYSENTER_EIP,      .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_STAR,              .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_CSTAR,             .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_LSTAR,             .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_KERNEL_GS_BASE,    .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_SFMASK,            .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_MSR_MTRR_DEF_TYPE, .value.reg64 = d_t },
+    };
 
-    entries = msrs;
-    for (const GList *elem = entries; elem != NULL; elem = elem->next) {
-        entry = elem->data;
-        ret = mshv_msr_to_hv_reg_name(entry->index, &name);
-        if (ret < 0) {
-            g_free(assocs);
-            return ret;
-        }
-        assoc = &assocs[i];
-        assoc->name = name;
-        /* the union has been initialized to 0 */
-        assoc->value.reg64 = entry->data;
-        i++;
-    }
-    ret = mshv_set_generic_regs(cpu, assocs, n_msrs);
-    g_free(assocs);
+    ret = mshv_set_generic_regs(cpu, assocs, ARRAY_SIZE(assocs));
     if (ret < 0) {
-        error_report("failed to set msrs");
+        error_report("failed to put msrs");
         return -1;
     }
+
     return 0;
 }
 
 
-int mshv_configure_msr(const CPUState *cpu, const MshvMsrEntry *msrs,
-                       size_t n_msrs)
+/*
+ * INVARIANT: this fn expects assocs in the same order as they appear in
+ * msr_env_map.
+ */
+static void store_in_env(CPUState *cpu, const struct hv_register_assoc *assocs,
+                         size_t n_assocs)
 {
-    GList *valid_msrs = NULL;
-    uint32_t msr_index;
-    int ret;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    size_t i, j;
+    const MshvMsrEnvMap *mapping;
+    union hv_register_value hv_value;
+    ptrdiff_t offset;
+    uint32_t hv_name;
 
-    for (size_t i = 0; i < n_msrs; i++) {
-        msr_index = msrs[i].index;
-        /* check whether index of msrs is in SUPPORTED_MSRS */
-        if (mshv_is_supported_msr(msr_index)) {
-            valid_msrs = g_list_append(valid_msrs, (void *) &msrs[i]);
+    assert(n_assocs <= (ARRAY_SIZE(msr_env_map)));
+
+    for (i = 0, j = 0; i < ARRAY_SIZE(msr_env_map); i++) {
+        hv_name = assocs[j].name;
+        mapping = &msr_env_map[i];
+        if (hv_name != mapping->hv_name) {
+            continue;
         }
+
+        hv_value = assocs[j].value;
+        offset = mapping->env_offset;
+        MSHV_ENV_FIELD(env, offset) = hv_value.reg64;
+        j++;
+    }
+}
+
+static void set_hv_name_in_assocs(struct hv_register_assoc *assocs,
+                                  size_t n_assocs)
+{
+    size_t i;
+
+    assert(n_assocs == ARRAY_SIZE(msr_env_map));
+    for (i = 0; i < ARRAY_SIZE(msr_env_map); i++) {
+        assocs[i].name = msr_env_map[i].hv_name;
+    }
+}
+
+static bool msr_supported(uint32_t name)
+{
+    /*
+     * This check is not done comprehensively, it's meant to avoid hvcall
+     * failures for certain MSRs on architectures that don't support them.
+     */
+
+    switch (name) {
+    case HV_X64_REGISTER_SPEC_CTRL:
+        return mshv_state->processor_features.ibrs_support;
+    case HV_X64_REGISTER_TSC_ADJUST:
+        return mshv_state->processor_features.tsc_adjust_support;
     }
 
-    ret = set_msrs(cpu, valid_msrs);
-    g_list_free(valid_msrs);
+    return true;
+}
 
-    return ret;
+int mshv_get_msrs(CPUState *cpu)
+{
+    int ret = 0;
+    size_t n_assocs = ARRAY_SIZE(msr_env_map);
+    struct hv_register_assoc assocs[ARRAY_SIZE(msr_env_map)];
+    size_t i, j;
+    uint32_t name;
+
+    set_hv_name_in_assocs(assocs, n_assocs);
+
+    /* Filter out MSRs that cannot be read */
+    for (i = 0, j = 0; i < n_assocs; i++) {
+        name = assocs[i].name;
+
+        if (!msr_supported(name)) {
+            continue;
+        }
+
+        if (j != i) {
+            assocs[j] = assocs[i];
+        }
+        j++;
+    }
+    n_assocs = j;
+
+    ret = mshv_get_generic_regs(cpu, assocs, n_assocs);
+    if (ret < 0) {
+        error_report("Failed to get MSRs");
+        return -errno;
+    }
+
+    store_in_env(cpu, assocs, n_assocs);
+
+    return 0;
+}
+
+static void load_from_env(const CPUState *cpu, struct hv_register_assoc *assocs,
+                          size_t n_assocs)
+{
+    size_t i;
+    const MshvMsrEnvMap *mapping;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    ptrdiff_t offset;
+    union hv_register_value *hv_value;
+
+    assert(n_assocs == ARRAY_SIZE(msr_env_map));
+
+    for (i = 0; i < ARRAY_SIZE(msr_env_map); i++) {
+        mapping = &msr_env_map[i];
+        offset = mapping->env_offset;
+        assocs[i].name = mapping->hv_name;
+        hv_value = &assocs[i].value;
+        hv_value->reg64 = MSHV_ENV_FIELD(env, offset);
+    }
+}
+
+int mshv_set_msrs(const CPUState *cpu)
+{
+    size_t n_assocs = ARRAY_SIZE(msr_env_map);
+    struct hv_register_assoc assocs[ARRAY_SIZE(msr_env_map)];
+    int ret;
+    size_t i, j;
+
+    load_from_env(cpu, assocs, n_assocs);
+
+    /* Filter out MSRs that cannot be written */
+    for (i = 0, j = 0; i < n_assocs; i++) {
+        uint32_t name = assocs[i].name;
+
+        /* Partition-wide MSRs: only write on vCPU 0 */
+        if (cpu->cpu_index != 0 &&
+            (name == HV_X64_REGISTER_HYPERCALL ||
+             name == HV_REGISTER_GUEST_OS_ID ||
+             name == HV_REGISTER_REFERENCE_TSC)) {
+            continue;
+        }
+
+        if (!msr_supported(name)) {
+            continue;
+        }
+
+        if (j != i) {
+            assocs[j] = assocs[i];
+        }
+        j++;
+    }
+    n_assocs = j;
+
+    ret = mshv_set_generic_regs(cpu, assocs, n_assocs);
+    if (ret < 0) {
+        error_report("Failed to set MSRs");
+        return -errno;
+    }
+
+    return 0;
 }
-- 
2.54.0


