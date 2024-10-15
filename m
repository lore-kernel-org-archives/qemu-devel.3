Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D474D216AD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iN8-0005vN-PH; Tue, 15 Oct 2024 10:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iN3-0005qi-IN
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iMz-0003JD-Q2
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q5mOjeOG5zrNARLwUzGvIDFpbu+ekL1lDbrgqwzQgGQ=;
 b=S7x6y9RzCcZFy8MaRqphLwtGQcv04e7nVAiaR3h+Qi69bAMNB2VHKlJKJ9VsML35sHJ2fN
 MOQvIHGsKY9ti8A5fbPbQYmwsev1zQvfgBgaAQS9MwntdJ3/FF3gERnLLjdaDG+A0OmfpK
 PjL/q/ETUgPY/DH5lxr98Pl0PxxrkYI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256---iP9cUFPiS-zJ3NRS6ZQg-1; Tue, 15 Oct 2024 10:17:40 -0400
X-MC-Unique: --iP9cUFPiS-zJ3NRS6ZQg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d4854fa0eso2720720f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001858; x=1729606658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q5mOjeOG5zrNARLwUzGvIDFpbu+ekL1lDbrgqwzQgGQ=;
 b=w46mXyETCTl84TpSI4LNo9QMkjCAi/z0GhbPbDCmxtLmyM7CCFUs5ZoefIswDYMV9N
 1nG0whL2uJd/n8DQDrUExAxUgCxgRtv5DQW0ECL75ezqKammvirf/41KHX0Jcjy18wgE
 vEso8gsyesYzrCoEx0NrAQvuWjIHNoh+qZrRzyZ7pO/kAKqQNfWDiG2vysVmbero29rw
 hKRNR2wwuDMBzZWYhw/FglOAG+5exoQV9tfHPEQsTbwCerqgi0G/RwZkq3tn1iW8Mtnl
 tHwZNs7R2+TvM+jQSK2YqdhWrxGRt/09T9yPEFElgAAQ3IIJMzNwqNrTRdKJJJa2kXua
 sSsg==
X-Gm-Message-State: AOJu0YxiQ5z5q8CjclnUlxoIRnRvfBqVg1+JrUMz30LulBM/xdH6lTtx
 Pnjyn7sfljl5rcQjvYU67A2mIck3DvzU0lgvMMgqKxjUum5mIsc2Ozfk+QsiC76V3nGHeuq1miI
 HjapHUmnUTcJjR/P9iCEFmD1WwGX5E2VcliNackFF6GmCTpB1CgLNrC+DwRdBwYePLOY5Uhx9m2
 Tgp4ZSy6EmHLFOWWysh4IIPHyaUupc0IxZ61gEyD8=
X-Received: by 2002:a5d:634b:0:b0:37d:47ee:10d9 with SMTP id
 ffacd0b85a97d-37d86c09fa8mr363632f8f.34.1729001856142; 
 Tue, 15 Oct 2024 07:17:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrxktjN745zpsGPWC+LCx2mVtIXsTGLI5cISRVUtw6mnU5xAD/iYtdzrJJj1AUQWmCqzK6HA==
X-Received: by 2002:a5d:634b:0:b0:37d:47ee:10d9 with SMTP id
 ffacd0b85a97d-37d86c09fa8mr363546f8f.34.1729001854187; 
 Tue, 15 Oct 2024 07:17:34 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa90547sm1692733f8f.49.2024.10.15.07.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:17:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gao Shiyuan <gaoshiyuan@baidu.com>,
	Wang Liang <wangliang44@baidu.com>
Subject: [PULL 06/25] target/i386: Add support save/load HWCR MSR
Date: Tue, 15 Oct 2024 16:16:52 +0200
Message-ID: <20241015141711.528342-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Gao Shiyuan <gaoshiyuan@baidu.com>

KVM commit 191c8137a939 ("x86/kvm: Implement HWCR support")
introduced support for emulating HWCR MSR.

Add support for QEMU to save/load this MSR for migration purposes.

Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
Signed-off-by: Wang Liang <wangliang44@baidu.com>
Link: https://lore.kernel.org/r/20241009095109.66843-1-gaoshiyuan@baidu.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     |  5 +++++
 target/i386/kvm/kvm.c | 12 ++++++++++++
 target/i386/machine.c | 20 ++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4c84cd41fd5..74886d1580f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -533,6 +533,8 @@ typedef enum X86Seg {
 
 #define MSR_AMD64_TSC_RATIO_DEFAULT     0x100000000ULL
 
+#define MSR_K7_HWCR                     0xc0010015
+
 #define MSR_VM_HSAVE_PA                 0xc0010117
 
 #define MSR_IA32_XFD                    0x000001c4
@@ -1858,6 +1860,9 @@ typedef struct CPUArchState {
     uint64_t msr_lbr_depth;
     LBREntry lbr_records[ARCH_LBR_NR_ENTRIES];
 
+    /* AMD MSRC001_0015 Hardware Configuration */
+    uint64_t msr_hwcr;
+
     /* exception/interrupt handling */
     int error_code;
     int exception_is_int;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 77e88165707..7c3fcb8698f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -165,6 +165,7 @@ static bool has_msr_ucode_rev;
 static bool has_msr_vmx_procbased_ctls2;
 static bool has_msr_perf_capabs;
 static bool has_msr_pkrs;
+static bool has_msr_hwcr;
 
 static uint32_t has_architectural_pmu_version;
 static uint32_t num_architectural_pmu_gp_counters;
@@ -2577,6 +2578,8 @@ static int kvm_get_supported_msrs(KVMState *s)
             case MSR_IA32_PKRS:
                 has_msr_pkrs = true;
                 break;
+            case MSR_K7_HWCR:
+                has_msr_hwcr = true;
             }
         }
     }
@@ -3919,6 +3922,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
     if (has_msr_virt_ssbd) {
         kvm_msr_entry_add(cpu, MSR_VIRT_SSBD, env->virt_ssbd);
     }
+    if (has_msr_hwcr) {
+        kvm_msr_entry_add(cpu, MSR_K7_HWCR, env->msr_hwcr);
+    }
 
 #ifdef TARGET_X86_64
     if (lm_capable_kernel) {
@@ -4403,6 +4409,9 @@ static int kvm_get_msrs(X86CPU *cpu)
         kvm_msr_entry_add(cpu, MSR_IA32_TSC, 0);
         env->tsc_valid = !runstate_is_running();
     }
+    if (has_msr_hwcr) {
+        kvm_msr_entry_add(cpu, MSR_K7_HWCR, 0);
+    }
 
 #ifdef TARGET_X86_64
     if (lm_capable_kernel) {
@@ -4922,6 +4931,9 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_ARCH_LBR_INFO_0 ... MSR_ARCH_LBR_INFO_0 + 31:
             env->lbr_records[index - MSR_ARCH_LBR_INFO_0].info = msrs[i].data;
             break;
+        case MSR_K7_HWCR:
+            env->msr_hwcr = msrs[i].data;
+            break;
         }
     }
 
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 39f8294f279..b4610325aad 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1543,6 +1543,25 @@ static const VMStateDescription vmstate_msr_xfd = {
     }
 };
 
+static bool msr_hwcr_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->msr_hwcr != 0;
+}
+
+static const VMStateDescription vmstate_msr_hwcr = {
+    .name = "cpu/msr_hwcr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = msr_hwcr_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.msr_hwcr, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 #ifdef TARGET_X86_64
 static bool intel_fred_msrs_needed(void *opaque)
 {
@@ -1773,6 +1792,7 @@ const VMStateDescription vmstate_x86_cpu = {
         &vmstate_msr_intel_sgx,
         &vmstate_pdptrs,
         &vmstate_msr_xfd,
+        &vmstate_msr_hwcr,
 #ifdef TARGET_X86_64
         &vmstate_msr_fred,
         &vmstate_amx_xtile,
-- 
2.46.2


