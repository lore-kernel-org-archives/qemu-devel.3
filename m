Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED055C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wutyY-0004EO-Ul; Fri, 14 Aug 2026 11:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong_li@linux.alibaba.com>)
 id 1wutyX-0004E8-QM
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 11:37:41 -0400
Received: from [115.124.30.111] (helo=out30-111.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong_li@linux.alibaba.com>)
 id 1wutyR-0007pO-2Z
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 11:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1786721836; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
 bh=T8E5m3smgtWglJdjv9V8jj+KgVnIxmSokYam2wm6f4c=;
 b=TU5JPAgJkiUGJIK7/LkwBjvXbH+5+mPDH4CbdgaKXeWF/qGr+1r2mSulazCyWLFWKSwIf7uHWPEqsKWZN96nUCQpGEOFMfQ1m+G7GBQ+lWvcLfbVw8PmsKxIWjVHkx5BWZqnsO18SR6JvmtDJ4ExcPgUDDiyQKARMDqMl23wLBQ=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=zhengrong_li@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0X8xpSXQ_1786721829; 
Received: from U-92DF4J33-2338.local(mailfrom:zhengrong_li@linux.alibaba.com
 fp:SMTPD_---0X8xpSXQ_1786721829 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 14 Aug 2026 23:37:15 +0800
From: Zhengrong Li <zhengrong_li@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, seanjc@google.com,
 zhengrong_li@linux.alibaba.com
Subject: [PATCH] target/i386: show nested VMX peer state in info registers
Date: Fri, 14 Aug 2026 23:36:57 +0800
Message-ID: <178672181798.77890.17896034190526266014@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.111 (deferred)
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=zhengrong_li@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

>From c8f876a1feeddcb0a65fb49bc8c01573efbc018f Mon Sep 17 00:00:00 2001
From: Zhengrong Li <zhengrong_li@linux.alibaba.com>
Date: Fri, 14 Aug 2026 23:25:54 +0800
Subject: [PATCH] target/i386: show nested VMX peer state in info registers

When a vCPU is running a nested guest (L2), QEMU's "info registers"
only shows L2 state.  There is no way to see where L1 was executing.
Similarly, when L1 is running and has configured an L2 guest via
VMPTRLD, the L2 guest-state area of vmcs12 is not displayed.

The vmcs12 blob returned by KVM_GET_NESTED_STATE already contains
both the GUEST area (L2 state configured by L1) and the HOST area
(L1 state restored on VM-exit from L2).  Parse these fields directly
from the existing vmcs12 byte array using well-known offsets from the
kernel's struct vmcs12 layout, which is locked by live-migration
compatibility and compile-time CHECK_OFFSET assertions.

Two cases:
- CPU in L2 (KVM_STATE_NESTED_GUEST_MODE set): append L1 partial
  state from vmcs12 HOST area (RIP, RSP, CR0/3/4, EFER, PAT,
  segment selectors, FS/GS/TR bases, GDTR/IDTR, SYSENTER).
- CPU in L1 (guest mode not set): append L2 partial state from
  vmcs12 GUEST area (full registers, segments with limit/ar,
  GDTR/IDTR with limit, DR7, PDPTR, SYSENTER).

A VMCS12_REVISION sanity check at offset 0 guards against layout
mismatch.  Only VMX is handled; SVM is skipped.

Signed-off-by: Zhengrong Li <zhengrong_li@linux.alibaba.com>
---
 target/i386/cpu-dump.c | 252 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 252 insertions(+)

diff --git a/target/i386/cpu-dump.c b/target/i386/cpu-dump.c
index 9e290c0b9b..81500932a6 100644
--- a/target/i386/cpu-dump.c
+++ b/target/i386/cpu-dump.c
@@ -23,6 +23,9 @@
 #ifndef CONFIG_USER_ONLY
 #include "hw/i386/apic_internal.h"
 #endif
+#ifdef CONFIG_KVM
+#include <linux/kvm.h>
+#endif
=20
 /***********************************************************/
 /* x86 debug */
@@ -343,6 +346,250 @@ void x86_cpu_dump_local_apic_state(CPUState *cs, int fl=
ags)
 #define DUMP_CODE_BYTES_TOTAL    50
 #define DUMP_CODE_BYTES_BACKWARD 20
=20
+#ifdef CONFIG_KVM
+/*
+ * Byte offsets into the vmcs12 blob returned by KVM_GET_NESTED_STATE.
+ * Taken from struct vmcs12 in arch/x86/kvm/vmx/vmcs12.h (kernel v6.16).
+ * The layout is locked by live-migration compatibility and compile-time
+ * CHECK_OFFSET assertions in the kernel, so existing offsets are stable.
+ * Only new fields may be appended at the end; existing fields cannot be
+ * moved, deleted, or have their type changed.
+ */
+#define VMCS12_REVISION                  0x11e57ed0
+#define VMCS12_GUEST_IA32_PAT            192
+#define VMCS12_GUEST_IA32_EFER           200
+#define VMCS12_HOST_IA32_PAT             256
+#define VMCS12_HOST_IA32_EFER            264
+#define VMCS12_GUEST_CR0                 424
+#define VMCS12_GUEST_CR3                 432
+#define VMCS12_GUEST_CR4                 440
+#define VMCS12_GUEST_ES_BASE             448
+#define VMCS12_GUEST_CS_BASE             456
+#define VMCS12_GUEST_SS_BASE             464
+#define VMCS12_GUEST_DS_BASE             472
+#define VMCS12_GUEST_FS_BASE             480
+#define VMCS12_GUEST_GS_BASE             488
+#define VMCS12_GUEST_LDTR_BASE           496
+#define VMCS12_GUEST_TR_BASE             504
+#define VMCS12_GUEST_GDTR_BASE           512
+#define VMCS12_GUEST_IDTR_BASE           520
+#define VMCS12_GUEST_DR7                 528
+#define VMCS12_GUEST_RSP                 536
+#define VMCS12_GUEST_RIP                 544
+#define VMCS12_GUEST_RFLAGS              552
+#define VMCS12_GUEST_SYSENTER_ESP        568
+#define VMCS12_GUEST_SYSENTER_EIP        576
+#define VMCS12_HOST_CR0                  584
+#define VMCS12_HOST_CR3                  592
+#define VMCS12_HOST_CR4                  600
+#define VMCS12_HOST_FS_BASE              608
+#define VMCS12_HOST_GS_BASE              616
+#define VMCS12_HOST_TR_BASE              624
+#define VMCS12_HOST_GDTR_BASE            632
+#define VMCS12_HOST_IDTR_BASE            640
+#define VMCS12_HOST_IA32_SYSENTER_ESP    648
+#define VMCS12_HOST_IA32_SYSENTER_EIP    656
+#define VMCS12_HOST_RSP                  664
+#define VMCS12_HOST_RIP                  672
+#define VMCS12_GUEST_ES_LIMIT            840
+#define VMCS12_GUEST_CS_LIMIT            844
+#define VMCS12_GUEST_SS_LIMIT            848
+#define VMCS12_GUEST_DS_LIMIT            852
+#define VMCS12_GUEST_FS_LIMIT            856
+#define VMCS12_GUEST_GS_LIMIT            860
+#define VMCS12_GUEST_LDTR_LIMIT          864
+#define VMCS12_GUEST_TR_LIMIT            868
+#define VMCS12_GUEST_GDTR_LIMIT          872
+#define VMCS12_GUEST_IDTR_LIMIT          876
+#define VMCS12_GUEST_ES_AR_BYTES         880
+#define VMCS12_GUEST_CS_AR_BYTES         884
+#define VMCS12_GUEST_SS_AR_BYTES         888
+#define VMCS12_GUEST_DS_AR_BYTES         892
+#define VMCS12_GUEST_FS_AR_BYTES         896
+#define VMCS12_GUEST_GS_AR_BYTES         900
+#define VMCS12_GUEST_LDTR_AR_BYTES       904
+#define VMCS12_GUEST_TR_AR_BYTES         908
+#define VMCS12_GUEST_SYSENTER_CS         920
+#define VMCS12_HOST_IA32_SYSENTER_CS     924
+#define VMCS12_GUEST_ES_SELECTOR         964
+#define VMCS12_GUEST_CS_SELECTOR         966
+#define VMCS12_GUEST_SS_SELECTOR         968
+#define VMCS12_GUEST_DS_SELECTOR         970
+#define VMCS12_GUEST_FS_SELECTOR         972
+#define VMCS12_GUEST_GS_SELECTOR         974
+#define VMCS12_GUEST_LDTR_SELECTOR       976
+#define VMCS12_GUEST_TR_SELECTOR         978
+#define VMCS12_HOST_ES_SELECTOR          982
+#define VMCS12_HOST_CS_SELECTOR          984
+#define VMCS12_HOST_SS_SELECTOR          986
+#define VMCS12_HOST_DS_SELECTOR          988
+#define VMCS12_HOST_FS_SELECTOR          990
+#define VMCS12_HOST_GS_SELECTOR          992
+#define VMCS12_HOST_TR_SELECTOR          994
+
+static inline uint64_t vmcs12_read64(const uint8_t *vmcs12, size_t off)
+{
+    uint64_t val;
+    memcpy(&val, vmcs12 + off, sizeof(val));
+    return val;
+}
+
+static inline uint32_t vmcs12_read32(const uint8_t *vmcs12, size_t off)
+{
+    uint32_t val;
+    memcpy(&val, vmcs12 + off, sizeof(val));
+    return val;
+}
+
+static inline uint16_t vmcs12_read16(const uint8_t *vmcs12, size_t off)
+{
+    uint16_t val;
+    memcpy(&val, vmcs12 + off, sizeof(val));
+    return val;
+}
+
+static void dump_vmcs12_nested_state(CPUX86State *env, FILE *f,
+                                     const char *seg_name[6])
+{
+    const uint8_t *vmcs12;
+    uint64_t base[8];
+    uint32_t limit[8], ar[8];
+    uint16_t sel[8];
+    int i;
+
+    if (!env->nested_state ||
+        env->nested_state->format !=3D KVM_STATE_NESTED_FORMAT_VMX) {
+        return;
+    }
+
+    vmcs12 =3D env->nested_state->data.vmx[0].vmcs12;
+
+    /* Sanity check: vmcs12 revision must match expected layout */
+    if (vmcs12_read32(vmcs12, 0) !=3D VMCS12_REVISION) {
+        return;
+    }
+
+    if (env->hflags & HF_GUEST_MASK) {
+        /*
+         * CPU is in L2 (VMX non-root). Show L1 state from vmcs12 HOST
+         * area -- this is the context L1 set up for VM-exit from L2.
+         */
+        qemu_fprintf(f, "\nL1 state (from vmcs12 HOST area):\n");
+        qemu_fprintf(f, "RIP=3D%016" PRIx64 " RSP=3D%016" PRIx64 "\n",
+                     vmcs12_read64(vmcs12, VMCS12_HOST_RIP),
+                     vmcs12_read64(vmcs12, VMCS12_HOST_RSP));
+        qemu_fprintf(f, "CR0=3D%016" PRIx64 " CR3=3D%016" PRIx64
+                     " CR4=3D%016" PRIx64 "\n",
+                     vmcs12_read64(vmcs12, VMCS12_HOST_CR0),
+                     vmcs12_read64(vmcs12, VMCS12_HOST_CR3),
+                     vmcs12_read64(vmcs12, VMCS12_HOST_CR4));
+        qemu_fprintf(f, "EFER=3D%016" PRIx64 " PAT=3D%016" PRIx64 "\n",
+                     vmcs12_read64(vmcs12, VMCS12_HOST_IA32_EFER),
+                     vmcs12_read64(vmcs12, VMCS12_HOST_IA32_PAT));
+
+        sel[0] =3D vmcs12_read16(vmcs12, VMCS12_HOST_ES_SELECTOR);
+        sel[1] =3D vmcs12_read16(vmcs12, VMCS12_HOST_CS_SELECTOR);
+        sel[2] =3D vmcs12_read16(vmcs12, VMCS12_HOST_SS_SELECTOR);
+        sel[3] =3D vmcs12_read16(vmcs12, VMCS12_HOST_DS_SELECTOR);
+        sel[4] =3D vmcs12_read16(vmcs12, VMCS12_HOST_FS_SELECTOR);
+        sel[5] =3D vmcs12_read16(vmcs12, VMCS12_HOST_GS_SELECTOR);
+        for (i =3D 0; i < 6; i++) {
+            qemu_fprintf(f, "%-4s sel=3D%04x\n", seg_name[i], sel[i]);
+        }
+        qemu_fprintf(f, "TR   sel=3D%04x base=3D%016" PRIx64 "\n",
+                     vmcs12_read16(vmcs12, VMCS12_HOST_TR_SELECTOR),
+                     vmcs12_read64(vmcs12, VMCS12_HOST_TR_BASE));
+        qemu_fprintf(f, "FS base=3D%016" PRIx64 " GS base=3D%016" PRIx64 "\n=
",
+                     vmcs12_read64(vmcs12, VMCS12_HOST_FS_BASE),
+                     vmcs12_read64(vmcs12, VMCS12_HOST_GS_BASE));
+        qemu_fprintf(f, "GDT=3D     %016" PRIx64 "\n",
+                     vmcs12_read64(vmcs12, VMCS12_HOST_GDTR_BASE));
+        qemu_fprintf(f, "IDT=3D     %016" PRIx64 "\n",
+                     vmcs12_read64(vmcs12, VMCS12_HOST_IDTR_BASE));
+        qemu_fprintf(f, "SYSENTER cs=3D%08x esp=3D%016" PRIx64
+                     " eip=3D%016" PRIx64 "\n",
+                     vmcs12_read32(vmcs12, VMCS12_HOST_IA32_SYSENTER_CS),
+                     vmcs12_read64(vmcs12, VMCS12_HOST_IA32_SYSENTER_ESP),
+                     vmcs12_read64(vmcs12, VMCS12_HOST_IA32_SYSENTER_EIP));
+    } else {
+        /*
+         * CPU is in L1. Show L2 state from vmcs12 GUEST area -- this
+         * is the state L1 configured for L2 via VMWRITE.
+         */
+        qemu_fprintf(f, "\nL2 state (from vmcs12 GUEST area):\n");
+        qemu_fprintf(f, "RIP=3D%016" PRIx64 " RSP=3D%016" PRIx64
+                     " RFL=3D%016" PRIx64 "\n",
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_RIP),
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_RSP),
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_RFLAGS));
+        qemu_fprintf(f, "CR0=3D%016" PRIx64 " CR3=3D%016" PRIx64
+                     " CR4=3D%016" PRIx64 "\n",
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_CR0),
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_CR3),
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_CR4));
+        qemu_fprintf(f, "DR7=3D%016" PRIx64 " EFER=3D%016" PRIx64
+                     " PAT=3D%016" PRIx64 "\n",
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_DR7),
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_IA32_EFER),
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_IA32_PAT));
+
+        sel[0] =3D vmcs12_read16(vmcs12, VMCS12_GUEST_ES_SELECTOR);
+        sel[1] =3D vmcs12_read16(vmcs12, VMCS12_GUEST_CS_SELECTOR);
+        sel[2] =3D vmcs12_read16(vmcs12, VMCS12_GUEST_SS_SELECTOR);
+        sel[3] =3D vmcs12_read16(vmcs12, VMCS12_GUEST_DS_SELECTOR);
+        sel[4] =3D vmcs12_read16(vmcs12, VMCS12_GUEST_FS_SELECTOR);
+        sel[5] =3D vmcs12_read16(vmcs12, VMCS12_GUEST_GS_SELECTOR);
+        base[0] =3D vmcs12_read64(vmcs12, VMCS12_GUEST_ES_BASE);
+        base[1] =3D vmcs12_read64(vmcs12, VMCS12_GUEST_CS_BASE);
+        base[2] =3D vmcs12_read64(vmcs12, VMCS12_GUEST_SS_BASE);
+        base[3] =3D vmcs12_read64(vmcs12, VMCS12_GUEST_DS_BASE);
+        base[4] =3D vmcs12_read64(vmcs12, VMCS12_GUEST_FS_BASE);
+        base[5] =3D vmcs12_read64(vmcs12, VMCS12_GUEST_GS_BASE);
+        limit[0] =3D vmcs12_read32(vmcs12, VMCS12_GUEST_ES_LIMIT);
+        limit[1] =3D vmcs12_read32(vmcs12, VMCS12_GUEST_CS_LIMIT);
+        limit[2] =3D vmcs12_read32(vmcs12, VMCS12_GUEST_SS_LIMIT);
+        limit[3] =3D vmcs12_read32(vmcs12, VMCS12_GUEST_DS_LIMIT);
+        limit[4] =3D vmcs12_read32(vmcs12, VMCS12_GUEST_FS_LIMIT);
+        limit[5] =3D vmcs12_read32(vmcs12, VMCS12_GUEST_GS_LIMIT);
+        ar[0] =3D vmcs12_read32(vmcs12, VMCS12_GUEST_ES_AR_BYTES);
+        ar[1] =3D vmcs12_read32(vmcs12, VMCS12_GUEST_CS_AR_BYTES);
+        ar[2] =3D vmcs12_read32(vmcs12, VMCS12_GUEST_SS_AR_BYTES);
+        ar[3] =3D vmcs12_read32(vmcs12, VMCS12_GUEST_DS_AR_BYTES);
+        ar[4] =3D vmcs12_read32(vmcs12, VMCS12_GUEST_FS_AR_BYTES);
+        ar[5] =3D vmcs12_read32(vmcs12, VMCS12_GUEST_GS_AR_BYTES);
+        for (i =3D 0; i < 6; i++) {
+            qemu_fprintf(f, "%-4s sel=3D%04x base=3D%016" PRIx64
+                         " limit=3D%08x ar=3D%08x\n",
+                         seg_name[i], sel[i], base[i], limit[i], ar[i]);
+        }
+        qemu_fprintf(f, "LDT  sel=3D%04x base=3D%016" PRIx64
+                     " limit=3D%08x ar=3D%08x\n",
+                     vmcs12_read16(vmcs12, VMCS12_GUEST_LDTR_SELECTOR),
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_LDTR_BASE),
+                     vmcs12_read32(vmcs12, VMCS12_GUEST_LDTR_LIMIT),
+                     vmcs12_read32(vmcs12, VMCS12_GUEST_LDTR_AR_BYTES));
+        qemu_fprintf(f, "TR   sel=3D%04x base=3D%016" PRIx64
+                     " limit=3D%08x ar=3D%08x\n",
+                     vmcs12_read16(vmcs12, VMCS12_GUEST_TR_SELECTOR),
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_TR_BASE),
+                     vmcs12_read32(vmcs12, VMCS12_GUEST_TR_LIMIT),
+                     vmcs12_read32(vmcs12, VMCS12_GUEST_TR_AR_BYTES));
+
+        qemu_fprintf(f, "GDT=3D     %016" PRIx64 " %08x\n",
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_GDTR_BASE),
+                     vmcs12_read32(vmcs12, VMCS12_GUEST_GDTR_LIMIT));
+        qemu_fprintf(f, "IDT=3D     %016" PRIx64 " %08x\n",
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_IDTR_BASE),
+                     vmcs12_read32(vmcs12, VMCS12_GUEST_IDTR_LIMIT));
+        qemu_fprintf(f, "SYSENTER cs=3D%08x esp=3D%016" PRIx64
+                     " eip=3D%016" PRIx64 "\n",
+                     vmcs12_read32(vmcs12, VMCS12_GUEST_SYSENTER_CS),
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_SYSENTER_ESP),
+                     vmcs12_read64(vmcs12, VMCS12_GUEST_SYSENTER_EIP));
+    }
+}
+#endif /* CONFIG_KVM */
+
 void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     X86CPU *cpu =3D X86_CPU(cs);
@@ -595,4 +842,9 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         }
         qemu_fprintf(f, "\n");
     }
+
+#ifdef CONFIG_KVM
+    /* Show nested peer state from vmcs12 when applicable */
+    dump_vmcs12_nested_state(env, f, seg_name);
+#endif
 }
--=20
2.43.7


