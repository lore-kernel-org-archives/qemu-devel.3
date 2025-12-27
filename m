Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE97E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQuw-0003Zm-EU; Sat, 27 Dec 2025 04:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuY-0002IV-Un
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuT-0006ta-Um
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bhMzQBznpreh9ZxnptD90zF45nT9leymZqtVkihCPfI=;
 b=J4HykKCYxbLPRvWtgI8//WfWe0Q8KHzJqeH+xv4Lc+i2KEgNOB0BMObEKhjlsXuqL++x07
 3m2Es1ZVBlvt0LiRas9x96RGLLJ8L+NDuH1iFo6r9NdtQaLHfmSyWFrRIDZRM7MOb9awgY
 yI72S2OtZoZ1vWlp9hvw9OI5rfVeMTM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-M5uEcwAMMKm5uortkMvgAA-1; Sat, 27 Dec 2025 04:48:28 -0500
X-MC-Unique: M5uEcwAMMKm5uortkMvgAA-1
X-Mimecast-MFC-AGG-ID: M5uEcwAMMKm5uortkMvgAA_1766828907
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47910af0c8bso53726435e9.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828906; x=1767433706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bhMzQBznpreh9ZxnptD90zF45nT9leymZqtVkihCPfI=;
 b=YLRQE1Pr114VoWQmORc6wlDlz+55I176k9rAwDgy3FVWKnSkiDaVy+vpgaRM6TD3XI
 h0mYNDZbjxnDJVHusiRGUOJkrtFss/7U+srAAnItYmyftPeWNsZekxj1FKRdMApSj7cY
 wXYqVuIqvFd9AKtke6wvmUlYqIx4JdG90acpxv5RP0/6TXkLnB2xqHC6z2bnWHtyCwAs
 G6abtABXHN+uc2MfseLOYQPCzi2uHFz4kxVefYagAURq6QOvI7T5fEmfvWNzzmzFZ0bR
 zFskmfH8rgP3YM2l7QxHURIoShO9AD6HA/l2yI5W5r6O3mhCfUUcGrf6IBRcIAk6mCPq
 exZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828906; x=1767433706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bhMzQBznpreh9ZxnptD90zF45nT9leymZqtVkihCPfI=;
 b=SZlhAp70ixzrX4dCkEu3zPLP1lJb1xjVMdSHdytOwAsqETkp4InHuEggL6F/+hGgay
 Sr2jsvP5ILBE3iKfNMl9RSwdBcmHkQs1PF8Q+ueEEU+EXvBlg0YEMf/gckE0ZlEwiEpY
 GEzmgDG0uG8BKNAUekoXVKSvPHCcre7F8f+Y4Lw2otSXoA+GnjAay+AMDKMCvVDE9Zb9
 lOAvM4wJGnDevW+6uHCYJkWFTkkfIwiK6nwQ7kuIRvIhisNIOT4fp+lo88MmJV6PPnTe
 xsNqAxdENcb0Wa7FUeLPpHEuubBP6ProMF3muxM6qE21Rc5LkS0kHYQAeTa+7GJtM3sK
 WTBQ==
X-Gm-Message-State: AOJu0YxMRQsPveRbsJP5qDYPv17Ap2lOEUI1cqe9gCPoNIyD6nqLx+Rg
 fBgZFrakopMKNNpFxkpDrkIvjssh9zjjfrYgUJMn3+AjIcDknQLf0kV2FGGealtOvozbyC4Fb1k
 U9qBVVHDhQHcrIXFXngFIFr+gBrwTkfINYiemc8oJ7XyOYt1sdbs6LzPEymvBp9XGI+vLTBUmG1
 18qbUCyeTloBFWvFAV1cr7EqS6X8ivemYOp2mwFVXk
X-Gm-Gg: AY/fxX4TD28AXQp7PBSsJ7LNrUVngVLbffGmqwKeJTSV1B2ZcQxd/Z/UDuAEKF5nBtu
 A+qOPCw/JFz/xGJ4LJlFEJPtS2nh7U4Xo+cXkMEtZgRKL5IP3ZR9qC56vJn5jTdJnEOwW5TIPea
 t5Nem1x1jDfCJKyqie4o5GgV7t3GciWatuKXq2wAtY09PIkp4iU+PyHk6Fo0UyIQTtJ/g039Z0g
 t8h7QOW1ixhLrb0E3PHxqPOHJAaPR1O/kFxlj8uH2IlvC3etHCk7A2FkJPG0dDJuW4ajfooxGT0
 QXDLH4fCa048futb8jOzjyL3DcWtXrwDglGaeBYI+o7a2aVKQkX2+cYwRtIMFKMuWXz/IDyYkyA
 1LSz6q8gHRdDVY0mnTMDWvaT6ePEwD3PG8Eq0+9rANCtVZ8oysZXp4pe30aGsGcOafm0mA0gMnl
 NUiXMKC/vkzPgf6y8=
X-Received: by 2002:a05:600c:524f:b0:45d:d8d6:7fcc with SMTP id
 5b1f17b1804b1-47d1958b73cmr285259695e9.27.1766828905877; 
 Sat, 27 Dec 2025 01:48:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/xBIzn+C7tpRU0OnKNoFMvXqW1ZtmfBtZjkVl69mPPy90XAWq97D0itjfDmw/NxyTABMHHw==
X-Received: by 2002:a05:600c:524f:b0:45d:d8d6:7fcc with SMTP id
 5b1f17b1804b1-47d1958b73cmr285259385e9.27.1766828905417; 
 Sat, 27 Dec 2025 01:48:25 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3acdb87sm191616315e9.16.2025.12.27.01.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Yang Weijiang <weijiang.yang@intel.com>, "Xin Li (Intel)" <xin@zytor.com>,
 Chao Gao <chao.gao@intel.com>
Subject: [PULL 086/153] i386/kvm: Add save/restore support for CET MSRs
Date: Sat, 27 Dec 2025 10:46:51 +0100
Message-ID: <20251227094759.35658-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Yang Weijiang <weijiang.yang@intel.com>

CET (architectural) MSRs include:
MSR_IA32_U_CET - user mode CET control bits.
MSR_IA32_S_CET - supervisor mode CET control bits.
MSR_IA32_PL{0,1,2,3}_SSP - linear addresses of SSPs for user/kernel modes.
MSR_IA32_INT_SSP_TAB - linear address of interrupt SSP table

Since FRED also needs to save/restore MSR_IA32_PL0_SSP, to avoid duplicate
operations, make FRED only save/restore MSR_IA32_PL0_SSP when CET-SHSTK
is not enumerated.

And considerring MSR_IA32_SSP_TBL_ADDR is only presented on 64 bit
processor, wrap it with TARGET_X86_64 macro.

For other MSRs, add save/restore support directly.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Suggested-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Co-developed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211060801.3600039-15-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     | 26 ++++++++++---
 target/i386/kvm/kvm.c | 91 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 98 insertions(+), 19 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 84e5cf0ab0c..37cc218bf3a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -543,7 +543,7 @@ typedef enum X86Seg {
 #define MSR_IA32_XFD                    0x000001c4
 #define MSR_IA32_XFD_ERR                0x000001c5
 
-/* FRED MSRs */
+/* FRED MSRs (MSR_IA32_FRED_SSP0 is defined as MSR_IA32_PL0_SSP in CET MSRs) */
 #define MSR_IA32_FRED_RSP0              0x000001cc       /* Stack level 0 regular stack pointer */
 #define MSR_IA32_FRED_RSP1              0x000001cd       /* Stack level 1 regular stack pointer */
 #define MSR_IA32_FRED_RSP2              0x000001ce       /* Stack level 2 regular stack pointer */
@@ -554,9 +554,6 @@ typedef enum X86Seg {
 #define MSR_IA32_FRED_SSP3              0x000001d3       /* Stack level 3 shadow stack pointer in ring 0 */
 #define MSR_IA32_FRED_CONFIG            0x000001d4       /* FRED Entrypoint and interrupt stack level */
 
-/* FRED and CET MSR */
-#define MSR_IA32_PL0_SSP                0x000006a4       /* ring-0 shadow stack pointer (aka MSR_IA32_FRED_SSP0 for FRED) */
-
 #define MSR_IA32_BNDCFGS                0x00000d90
 #define MSR_IA32_XSS                    0x00000da0
 #define MSR_IA32_UMWAIT_CONTROL         0xe1
@@ -583,6 +580,15 @@ typedef enum X86Seg {
 #define MSR_APIC_START                  0x00000800
 #define MSR_APIC_END                    0x000008ff
 
+/* CET MSRs */
+#define MSR_IA32_U_CET                  0x000006a0       /* user mode cet */
+#define MSR_IA32_S_CET                  0x000006a2       /* kernel mode cet */
+#define MSR_IA32_PL0_SSP                0x000006a4       /* ring-0 shadow stack pointer */
+#define MSR_IA32_PL1_SSP                0x000006a5       /* ring-1 shadow stack pointer */
+#define MSR_IA32_PL2_SSP                0x000006a6       /* ring-2 shadow stack pointer */
+#define MSR_IA32_PL3_SSP                0x000006a7       /* ring-3 shadow stack pointer */
+#define MSR_IA32_INT_SSP_TAB            0x000006a8       /* exception shadow stack table */
+
 #define XSTATE_FP_BIT                   0
 #define XSTATE_SSE_BIT                  1
 #define XSTATE_YMM_BIT                  2
@@ -1973,8 +1979,16 @@ typedef struct CPUArchState {
     uint64_t fred_config;
 #endif
 
-    /* MSR used for both FRED and CET (SHSTK) */
-    uint64_t pl0_ssp;
+    /* CET MSRs */
+    uint64_t u_cet;
+    uint64_t s_cet;
+    uint64_t pl0_ssp; /* also used for FRED */
+    uint64_t pl1_ssp;
+    uint64_t pl2_ssp;
+    uint64_t pl3_ssp;
+#ifdef TARGET_X86_64
+    uint64_t int_ssp_table;
+#endif
 
     uint64_t tsc_adjust;
     uint64_t tsc_deadline;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 5b8c7550a16..e1a1f0ce9e5 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4009,11 +4009,14 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP2, env->fred_ssp2);
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP3, env->fred_ssp3);
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_CONFIG, env->fred_config);
-            /*
-             * Aka MSR_IA32_FRED_SSP0. This MSR is accessible even if
-             * CET shadow stack is not supported.
-             */
-            kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, env->pl0_ssp);
+
+            if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK)) {
+                /*
+                 * Aka MSR_IA32_FRED_SSP0. This MSR is accessible even if
+                 * CET shadow stack is not supported.
+                 */
+                kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, env->pl0_ssp);
+            }
         }
     }
 #endif
@@ -4267,6 +4270,26 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
         }
     }
 
+    if (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK ||
+        env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_CET_IBT) {
+        kvm_msr_entry_add(cpu, MSR_IA32_U_CET, env->u_cet);
+        kvm_msr_entry_add(cpu, MSR_IA32_S_CET, env->s_cet);
+
+        if (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) {
+            kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, env->pl0_ssp);
+            kvm_msr_entry_add(cpu, MSR_IA32_PL1_SSP, env->pl1_ssp);
+            kvm_msr_entry_add(cpu, MSR_IA32_PL2_SSP, env->pl2_ssp);
+            kvm_msr_entry_add(cpu, MSR_IA32_PL3_SSP, env->pl3_ssp);
+
+#ifdef TARGET_X86_64
+            if (lm_capable_kernel) {
+                kvm_msr_entry_add(cpu, MSR_IA32_INT_SSP_TAB,
+                                  env->int_ssp_table);
+            }
+#endif
+        }
+    }
+
     return kvm_buf_set_msrs(cpu);
 }
 
@@ -4501,11 +4524,14 @@ static int kvm_get_msrs(X86CPU *cpu)
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP2, 0);
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP3, 0);
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_CONFIG, 0);
-            /*
-             * Aka MSR_IA32_FRED_SSP0. This MSR is accessible even if
-             * CET shadow stack is not supported.
-             */
-            kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, 0);
+
+            if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK)) {
+                /*
+                 * Aka MSR_IA32_FRED_SSP0. This MSR is accessible even if
+                 * CET shadow stack is not supported.
+                 */
+                kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, 0);
+            }
         }
     }
 #endif
@@ -4663,6 +4689,25 @@ static int kvm_get_msrs(X86CPU *cpu)
         }
     }
 
+    if (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK ||
+        env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_CET_IBT) {
+        kvm_msr_entry_add(cpu, MSR_IA32_U_CET, 0);
+        kvm_msr_entry_add(cpu, MSR_IA32_S_CET, 0);
+
+        if (env->features[FEAT_7_0_EDX] & CPUID_7_0_ECX_CET_SHSTK) {
+            kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_PL1_SSP, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_PL2_SSP, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_PL3_SSP, 0);
+
+#ifdef TARGET_X86_64
+            if (lm_capable_kernel) {
+                kvm_msr_entry_add(cpu, MSR_IA32_INT_SSP_TAB, 0);
+            }
+#endif
+        }
+    }
+
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MSRS, cpu->kvm_msr_buf);
     if (ret < 0) {
         return ret;
@@ -4757,9 +4802,6 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_IA32_FRED_CONFIG:
             env->fred_config = msrs[i].data;
             break;
-        case MSR_IA32_PL0_SSP: /* aka MSR_IA32_FRED_SSP0 */
-            env->pl0_ssp = msrs[i].data;
-            break;
 #endif
         case MSR_IA32_TSC:
             env->tsc = msrs[i].data;
@@ -5013,6 +5055,29 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_ARCH_LBR_INFO_0 ... MSR_ARCH_LBR_INFO_0 + 31:
             env->lbr_records[index - MSR_ARCH_LBR_INFO_0].info = msrs[i].data;
             break;
+        case MSR_IA32_U_CET:
+            env->u_cet = msrs[i].data;
+            break;
+        case MSR_IA32_S_CET:
+            env->s_cet = msrs[i].data;
+            break;
+        case MSR_IA32_PL0_SSP: /* aka MSR_IA32_FRED_SSP0 */
+            env->pl0_ssp = msrs[i].data;
+            break;
+        case MSR_IA32_PL1_SSP:
+            env->pl1_ssp = msrs[i].data;
+            break;
+        case MSR_IA32_PL2_SSP:
+            env->pl2_ssp = msrs[i].data;
+            break;
+        case MSR_IA32_PL3_SSP:
+            env->pl3_ssp = msrs[i].data;
+            break;
+#ifdef TARGET_X86_64
+        case MSR_IA32_INT_SSP_TAB:
+            env->int_ssp_table = msrs[i].data;
+            break;
+#endif
         case MSR_K7_HWCR:
             env->msr_hwcr = msrs[i].data;
             break;
-- 
2.52.0


