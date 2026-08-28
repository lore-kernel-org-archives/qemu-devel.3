Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4B1C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpkb-00055h-BR; Fri, 28 Aug 2026 02:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpkZ-00055H-KP
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:07:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpkX-0000eR-H8
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:07:39 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S236k43689466
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=u+Ma1ynAQwemef+k6
 VSAddALpVI9wmQW+ejGk1rywXE=; b=mnXH4El3wPYmG7XdskxnVacdb0VKzUF5+
 4ZC8FPpfjSK3gnsVlkaW1z6wQBAoJm5Zs9+SAjETtvYh8URtPQlGkiLRCo4oK6Uj
 IYbti9bm23oxdvbA92pgOGHdbHUEvCRRRCXYJEZjp/x2mx2Q9crErcStKS5Fxbhi
 pm28CkjESebfYbzUHw/CLopa3lUAr1ramkbzVkxcL6CrlssybV9T0rIUJNTq8ZDR
 ZQXc/MX2ds6/tA4sH2EXjz8sWa5UNC+YWt87bbS584ZjYmnvKuaassKcasCoFxmT
 cPJD/ffNoIiSDDEZldPZ2zsGlTv8kdFwmfwYm/fjP6Gd5fGEBjGZQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726f27yy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uEs4025163
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragvg98-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S67VgS51577334
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:07:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2658C20043;
 Fri, 28 Aug 2026 06:07:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D96120040;
 Fri, 28 Aug 2026 06:07:29 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:07:29 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>
Subject: [PULL 02/41] target/ppc/kvm: Add support for querying host
 compatibility mode
Date: Fri, 28 Aug 2026 11:36:37 +0530
Message-ID: <20260828060716.91672-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a9125a7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=R_9d5M2Ok3QZz6TfjUMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX/+RJsI62W/+N
 zsfhhKD6RcWk6IeqReCZKFfpb9C90Id4dwEoVZ5wGtsATkERF8QzGy77fePr0TEe/fg678R+fF6
 V0js9QEh+HlOuQpIwI98F8xlkXmEMxE=
X-Proofpoint-GUID: dzSvSncGLMAZtbrVJlcx-eQAoEtsBwil
X-Proofpoint-ORIG-GUID: dzSvSncGLMAZtbrVJlcx-eQAoEtsBwil
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX1CQaPuQ6Xv/g
 TiVN6h5HEm9pJPgZt2d/aF3DVphDq9YfZP5mbXtUQ2nlBJ+TCYQB6RUDWkKOtMKp+mgYm1XQtIf
 cZLxbw/k3FnjNYJIrYkgf5GMmqrtBVFanG73OUaVwK0v5iGGFBjHDz3i3IAFKlYObEOa91cr7tH
 /5PKf7xi095mKI0Gz4LLQmS5o2HvLkKSQlt+kcsdl/mqA0ypthh6TeOC+WiA7G5EDEEByYQMaq3
 lQRKvtmPeC/2YQblVIOaIYrYl9DpD5xew5PRwMXF0IFjyStoAbKeAsk9d8+z2DvgrCmW0j75NJ1
 QxRN8V2L/yDGJaVTramEPBbsWqxjGgsOiKAxGumytsreOjJNpsDsLAb3jip7nQBVppLhgT6Kb4G
 58SaZ4ae607r3xJnE1w63lavzclaa7xuoR8yAbeAas0VaRlwgVK+FrL4Jx7k/Jwc1uaXZ1LE5XS
 Wj6IW/xh7bq7pNMFYvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280050
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Amit Machhiwal <amachhiw@linux.ibm.com>

Add infrastructure to query the host CPU compatibility mode via the
KVM_PPC_GET_COMPAT_CAPS ioctl. This allows QEMU to determine if the
host is running in a compatibility mode (e.g., a Power11 processor
operating in Power10 compatibility mode).

The kvmppc_get_compat_caps() function issues the ioctl and returns the
compat_capabilities bitmap. The kvm_ppc_host_compat_pvr() function derives
the effective PVR from the bitmap using ctz64() to find the lowest set
bit (highest supported compat level in IBM MSB-0 numbering).

The struct kvm_ppc_compat_caps places 'size' first and userspace sets it
to sizeof(struct kvm_ppc_compat_caps) before calling the ioctl. The kernel
uses copy_struct_from/to_user() to handle forward and backward ABI
compatibility: an older userspace with a smaller struct gets trailing fields
zero-padded. When newer userspace passes a larger struct to an older kernel
(usize > ksize), the kernel unconditionally returns -E2BIG and writes its
own ksize back into host_compat.size. QEMU detects this, validates the
returned size against KVM_PPC_COMPAT_CAPS_SIZE_VER0, and retries with that
size.

Additionally, cas_check_pvr() in hw/ppc/spapr_hcall.c is updated to
prevent fallback to raw mode when the host is running in compatibility
mode. This ensures that nested guests cannot exceed the host's
compatibility level. The call is guarded with kvm_enabled() since
kvm_ppc_host_compat_pvr() invokes kvm_vm_ioctl() which dereferences
kvm_state; without the guard, a TCG guest on a CONFIG_KVM=y binary
would segfault.

If the capability is not supported or the query fails, the functions
return 0, allowing fallback to existing behavior.

Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260812170854.58709-3-amachhiw@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/kvm_ppc.h |  7 +++++
 hw/ppc/spapr_hcall.c | 14 +++++++++
 target/ppc/kvm.c     | 75 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 742881231e..195dbaac5e 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -81,6 +81,8 @@ bool kvmppc_supports_ail_3(void);
 int kvmppc_enable_hwrng(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
+
+uint32_t kvm_ppc_host_compat_pvr(void);
 void kvmppc_check_papr_resize_hpt(Error **errp);
 int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu, target_ulong flags, int shift);
 int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int shift);
@@ -440,6 +442,11 @@ static inline PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
     return NULL;
 }
 
+static inline uint32_t kvm_ppc_host_compat_pvr(void)
+{
+    return 0;
+}
+
 static inline void kvmppc_check_papr_resize_hpt(Error **errp)
 {
 }
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 23bcd788da..708902934c 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1136,6 +1136,7 @@ static uint32_t cas_check_pvr(PowerPCCPU *cpu, uint32_t max_compat,
 {
     bool explicit_match = false; /* Matched the CPU's real PVR */
     uint32_t best_compat = 0;
+    uint32_t compat_host_pvr = 0;
     int i;
 
     /*
@@ -1163,6 +1164,19 @@ static uint32_t cas_check_pvr(PowerPCCPU *cpu, uint32_t max_compat,
         }
     }
 
+    if (explicit_match && kvm_enabled()) {
+        compat_host_pvr = kvm_ppc_host_compat_pvr();
+        /*
+         * If the host is booted in a compatibility mode, do not try booting in
+         * the raw mode as it may allow KVM guests to boot with a higher CPU
+         * version compared to what host was booted with; which should not be
+         * allowed.
+         */
+        if (compat_host_pvr) {
+            explicit_match = false;
+        }
+    }
+
     *raw_mode_supported = explicit_match;
 
     /* Parsing finished */
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 116b39a00f..d4c5601a00 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2602,6 +2602,81 @@ bool kvmppc_supports_ail_3(void)
     return cap_ail_mode_3;
 }
 
+#if defined(TARGET_PPC64)
+static target_ulong kvmppc_get_compat_caps(void)
+{
+    struct kvm_ppc_compat_caps host_compat;
+    int ret;
+
+    if (!kvm_check_extension(kvm_state, KVM_CAP_PPC_COMPAT_CAPS)) {
+        return 0;
+    }
+
+    /*
+     * Set size to sizeof(struct kvm_ppc_compat_caps) so the kernel applies
+     * copy_struct_from/to_user() versioning. size must be >= VER0.
+     */
+    memset(&host_compat, 0, sizeof(host_compat));
+    host_compat.size = sizeof(host_compat);
+
+    ret = kvm_vm_ioctl(kvm_state, KVM_PPC_GET_COMPAT_CAPS, &host_compat);
+    if (ret == -E2BIG && host_compat.size >= KVM_PPC_COMPAT_CAPS_SIZE_VER0) {
+        /*
+         * Kernel is older and knows only a smaller struct version. It
+         * wrote back its ksize into host_compat.size. Retry with that
+         * size so the kernel accepts the call.
+         *
+         * When a VER1 struct is introduced, add a check here:
+         *   if (host_compat.size >= KVM_PPC_COMPAT_CAPS_SIZE_VER1) { ... }
+         */
+        uint64_t ksize = host_compat.size;
+        memset(&host_compat, 0, sizeof(host_compat));
+        host_compat.size = ksize;
+        ret = kvm_vm_ioctl(kvm_state, KVM_PPC_GET_COMPAT_CAPS, &host_compat);
+    }
+
+    if (ret < 0) {
+        error_report("KVM: failed to get host CPU compat capabilities: %s",
+                     strerror(-ret));
+        return 0;
+    }
+
+    return host_compat.compat_capabilities & KVM_PPC_COMPAT_BITMASK;
+}
+
+/*
+ * Return the effective host PVR based on the CPU compatibility mode
+ * reported by KVM. Returns 0 if no compat mode is active or the
+ * capability is not supported, in which case the caller falls back
+ * to the raw hardware PVR.
+ */
+uint32_t kvm_ppc_host_compat_pvr(void)
+{
+    uint32_t compat_host_pvr = 0;
+    uint64_t cap_idx = 0;
+    target_ulong host_caps = kvmppc_get_compat_caps();
+
+    if (host_caps) {
+        cap_idx = 1ULL << ctz64(host_caps);
+        switch (cap_idx) {
+        case KVM_PPC_COMPAT_CAP_POWER9:
+            compat_host_pvr = CPU_POWERPC_POWER9_DD22;
+            break;
+        case KVM_PPC_COMPAT_CAP_POWER10:
+            compat_host_pvr = CPU_POWERPC_POWER10_DD20;
+            break;
+        case KVM_PPC_COMPAT_CAP_POWER11:
+            compat_host_pvr = CPU_POWERPC_POWER11_DD20;
+            break;
+        default:
+            break;
+        }
+    }
+
+    return compat_host_pvr;
+}
+#endif /* TARGET_PPC64 */
+
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
 {
     uint32_t host_pvr = mfpvr();
-- 
2.52.0


