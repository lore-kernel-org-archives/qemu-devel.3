Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C33ACD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 14:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUPju-0003eO-DP; Tue, 02 Jun 2026 10:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anderson@allelesecurity.com>)
 id 1wUPjs-0003dc-9F
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 10:05:04 -0400
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anderson@allelesecurity.com>)
 id 1wUPjq-0002Ob-2K
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 10:05:03 -0400
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-6cfdce656bfso968693137.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 07:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=allelesecurity.com; s=google; t=1780409101; x=1781013901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CmSaH4fUuZZEN3sgO5R99mha2OHiYvLyU1oJPcEKSh4=;
 b=ngQ2hmpkXFCSXbHeABz5Rm+30292kSoBpOpYAe4IGKvhg2A92HJxnum21YQx4BuDZB
 0Tdw1M+cwIdxVOZHy25i6PPJ/4QmuTpmRkMHbCAQh04wZqiCyJe/PgKBnxZld7ORJF1v
 VtkUXtKp/VK/x0lOYSMETgJgpI+s/eOmQoeXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780409101; x=1781013901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CmSaH4fUuZZEN3sgO5R99mha2OHiYvLyU1oJPcEKSh4=;
 b=QcEYWpkdK++tIF0xmOUY2XlKe2WYhM4CaXAv2D9JmJptPW5HyKwYfjC3JvrBohfVzY
 JRVrbsiBuJazeKtI4629xPkqpxp+Z0cLmEM/QNSO+RepvmcSwYlRDPZDY5++a3iG3qTs
 6uX4PkyN3mRZBdzcHSvyokSxjNRr3Iujgj/fuH58Dp2+AfH4UeV+1ZplGqnLSB0nnVXZ
 TvIM5wrsUQUyqmnAkYHogYBrLH8ZmuWdfYm/ZjeuEaQSpqZNPXPWwx+gbJx2ljwcOce+
 C7VCDGGyJAcNYEXo/cVNMd0hkKJh1g/pF9qvZ80Hd1b04pwxu9PCfRMcTEu0tm3UKWtF
 nX+Q==
X-Gm-Message-State: AOJu0YwdPqWIc5eGxy8XYVMiskO1DIoNVDSkeARnVEA6xJacOCNq0L1E
 SoK3pXWwEnVPXAGxy748ZGPZciMo6kEBnjxXapWjAL1jhZ4jY2fyJePBG5fEKiX8FVvgLO70lSJ
 neswerYM=
X-Gm-Gg: Acq92OFppU8XsiBKo0fi8WM1fv3c5CWMX22MGJIakB8c9f4HU9P1mJqctRtl0X6iUL+
 EoKPjXYB1Wa6/BQKfNwfIyZT5fGCi6ShVAZUcpGLAGwHTnlVVx7oAmR9qXfL7oWMTYL4r05x4Ow
 e+qohsjeZfmXB0W8M3YAUoGpy366GzXHP93aYAQdvI/zgQfBlnlGYcrwDS9PY58rIuvfFduEVSB
 IcK/K3jRSPDnYVN3mk244cSe82n+7xKirVTJoYMo8h+ogAOhGh092Q0DJIWixjogdPgjBFvkZBH
 zUhe5us1Fqqx+5cGQQMHKzMRBFclyuuJbRD5d9H8pJPhONsf64j9WGj+l5UTio2T2/n6//V933C
 nWzvRc1gqsQgsoXewRtejktqkc/xPaepFSmXa/zVNPEnYqROLFo+/qKaMdJR5qBNkDcm1hVURhE
 IoFPNxqQ/Xp6OCoj/iB0Gf2XR6JShCaq6+gojXBA==
X-Received: by 2002:a05:6102:1526:b0:602:a9f3:74d8 with SMTP id
 ada2fe7eead31-6c69806f3bamr6319981137.25.1780409100964; 
 Tue, 02 Jun 2026 07:05:00 -0700 (PDT)
Received: from tarski ([179.105.152.38]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-6d1ff3909b3sm6097602137.6.2026.06.02.07.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 07:05:00 -0700 (PDT)
From: Anderson Nascimento <anderson@allelesecurity.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 zhao1.liu@intel.com, mtosatti@redhat.com
Cc: Anderson Nascimento <anderson@allelesecurity.com>
Subject: [PATCH v2 1/1] target/i386: Add support for KVM APERF/MPERF
 passthrough
Date: Tue,  2 Jun 2026 11:03:47 -0300
Message-ID: <20260602140348.774203-2-anderson@allelesecurity.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602140348.774203-1-anderson@allelesecurity.com>
References: <20260602140348.774203-1-anderson@allelesecurity.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=anderson@allelesecurity.com; helo=mail-vs1-xe31.google.com
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

Introduce support for exposing and enabling APERF/MPERF MSR passthrough
for x86 QEMU guests when running under KVM.

The Linux kernel supports a KVM capability allowing the hypervisor to
disable read intercepts on the IA32_APERF and IA32_MPERF MSRs, enabling
guests to track effective frequency directly without VM-exits. QEMU
currently lacks a native way to request this capability or expose the
corresponding feature bit to the guest.

This patch adds the `aperfmperf` feature flag via `FEAT_6_ECX`
(CPUID.06H:ECX[bit 0]). To ensure safe tracking across power states,
the flag ties into QEMU's existing host power management framework.
When host CPU power management is explicitly requested by the user
(via `-overcommit cpu-pm=on`) and the `+aperfmperf` flag is provided
to the CPU, QEMU will invoke the KVM ioctl to drop the APERF/MPERF
MSR read intercepts.

This implementation allows guest operating systems (such as FreeBSD
or Linux) to dynamically calculate CPU utilization and turbo-boost
metrics without incurring performance overhead from hypervisor trap-and-
emulate loops.

Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
---
Changes in v2
- Added migration flags
- Link to v1: https://lore.kernel.org/all/20260602022048.752453-1-anderson@allelesecurity.com/

 target/i386/cpu.c     | 18 +++++++++++++++++-
 target/i386/cpu.h     |  2 ++
 target/i386/kvm/kvm.c |  5 ++++-
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8929a75c7c..544738d406 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1544,6 +1544,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .cpuid = { .eax = 6, .reg = R_EAX, },
         .tcg_features = TCG_6_EAX_FEATURES,
     },
+    [FEAT_6_ECX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "aperfmperf", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = { .eax = 6, .reg = R_ECX, },
+        .tcg_features = 0,
+        .unmigratable_flags = CPUID_6_ECX_APERFMPERF,
+    },
     [FEAT_XSAVE_XCR0_LO] = {
         .type = CPUID_FEATURE_WORD,
         .cpuid = {
@@ -8770,7 +8786,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         /* Thermal and Power Leaf */
         *eax = env->features[FEAT_6_EAX];
         *ebx = 0;
-        *ecx = 0;
+        *ecx = env->features[FEAT_6_ECX];
         *edx = 0;
         break;
     case 7:
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 67e2ecf325..87864969c7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -700,6 +700,7 @@ typedef enum FeatureWord {
     FEAT_SVM,           /* CPUID[8000_000A].EDX */
     FEAT_XSAVE,         /* CPUID[EAX=0xd,ECX=1].EAX */
     FEAT_6_EAX,         /* CPUID[6].EAX */
+    FEAT_6_ECX,         /* CPUID[6].ECX */
     FEAT_XSAVE_XCR0_LO, /* CPUID[EAX=0xd,ECX=0].EAX */
     FEAT_XSAVE_XCR0_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
     FEAT_ARCH_CAPABILITIES,
@@ -1232,6 +1233,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_XSAVE_XFD        (1U << 4)
 
 #define CPUID_6_EAX_ARAT       (1U << 2)
+#define CPUID_6_ECX_APERFMPERF (1U << 0)
 
 /* CPUID[0x80000007].EDX flags: */
 #define CPUID_APM_INVTSC       (1U << 8)
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9e352882c8..ca722ff9e9 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -498,6 +498,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
         }
     } else if (function == 6 && reg == R_EAX) {
         ret |= CPUID_6_EAX_ARAT; /* safe to allow because of emulated APIC */
+    } else if (function == 6 && reg == R_ECX) {
+        ret |= CPUID_6_ECX_APERFMPERF;
     } else if (function == 7 && index == 0 && reg == R_EBX) {
         /* Not new instructions, just an optimization.  */
         uint32_t ebx;
@@ -3291,7 +3293,8 @@ static int kvm_vm_enable_disable_exits(KVMState *s)
         disable_exits &= (KVM_X86_DISABLE_EXITS_MWAIT |
                           KVM_X86_DISABLE_EXITS_HLT |
                           KVM_X86_DISABLE_EXITS_PAUSE |
-                          KVM_X86_DISABLE_EXITS_CSTATE);
+                          KVM_X86_DISABLE_EXITS_CSTATE |
+                          KVM_X86_DISABLE_EXITS_APERFMPERF);
     }
 
     return kvm_vm_enable_cap(s, KVM_CAP_X86_DISABLE_EXITS, 0,
-- 
2.54.0


