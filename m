Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93716C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCSW-0007az-1z; Wed, 12 Aug 2026 13:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wuCSK-0007Z9-FC; Wed, 12 Aug 2026 13:09:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wuCSG-0007Ft-MO; Wed, 12 Aug 2026 13:09:32 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CH1ZKF4040803; Wed, 12 Aug 2026 17:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=/aPAVC/8dDH0mnpSi
 aHDSqAaFMg2mEKE4CDE5oWOwoA=; b=R+9S0FCv0wsADGr6RLo+9ah+TLg1s0zNf
 E9S7s1JsiiHaP1DKew/bi7b0o1zjyduAxmMPzfbYHV3ei76aNgc7tlh1t0QdwIb0
 dD9Ewrt8GWbUyS+GsjLQ2DEABprtlytKBeAB1N5/JL/2N9eNFj9zpvZ5n9kW5aIL
 y3eDlniTbJcoSANAdJ7yjVl/POLvn+mYdDp5QsVx+zVrZbVtgiZrksZO0eFRPCaH
 ERJ1IuqtBhdlEb3QUlz08S9K2qj7sMWCj0LOiAqfl+qehq5kZLt+U/R1SiK58F+y
 A0C0eUQz4HALD94HvMTyn6GfSVokndVP86paXk5crkHPkcHph9VWw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9kn57-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:09:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CGumKJ021450;
 Wed, 12 Aug 2026 17:09:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w772x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:09:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CH9Inb51380546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 17:09:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CF402004D;
 Wed, 12 Aug 2026 17:09:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 16B5020040;
 Wed, 12 Aug 2026 17:09:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.26.117])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 17:09:14 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: [PATCH v6 2/3] target/ppc/kvm: Add support for querying host
 compatibility mode
Date: Wed, 12 Aug 2026 22:38:53 +0530
Message-ID: <20260812170854.58709-3-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260812170854.58709-1-amachhiw@linux.ibm.com>
References: <20260812170854.58709-1-amachhiw@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 7lx6V9T1h6uHzN_d2LEYH7P3LyHF65G1
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7ca8c3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=R_9d5M2Ok3QZz6TfjUMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX3ji5stUKpfNd
 v9NG4C82YjHkPbjPqj+6PILBwcRr+nSxbXhkd/tF5fQ/QFsdkzIMfpSb19od/dPV32G1CdBxluX
 teWpUCzf7Erw8PAAuxc7Q7ERoiTpoqsVEfo2WTF5qyrOANCgzyXME+eIF63PgFywzZwIYgJh8Gj
 LMfWoaAbl3+woR8sz558AywfH87w/olMd41oJRH4r2sW0IHX/6R6Uzn/8ad2vEi5thr6W9hQ5EY
 laMOYawSLU+dDMzayn3RBTCqnz0dAe/ctb9vK1rqAX+etdZfZaDbrrRWfWWshSFFdwvhyhXleM4
 oBs2Rzkb+4T8Kn0kAm/ffu8rXFDWX3W5XaMlXFMr4Rr6qufL0ezT02C9DxMuWduhwetvMPPEd5y
 eMsxh1fVUSD3ssXLTRHh1WjmT7cyBRbgjX5tJ7SIjSG7ouXQBaYJGoUaluVpWC34Pe4MCkUeOt1
 +msr3Gr7kxXBPGLAsJQ==
X-Proofpoint-ORIG-GUID: 2S6FJDLOQnjTGDvozDkYB3ySgYPVO9w7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX1C5UP3y2HmDd
 qIrNRSsvCRjXJetN/DZuOqkIh70K6qWnn8jGa71HAFZsPVubu28BBo96EMU2D4w9nJGwVlblSSS
 U+sv6CruQg0EuwxrhOJYVr7EXChl9Ic=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120138
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
---
No changes in this version.

 hw/ppc/spapr_hcall.c | 14 +++++++++
 target/ppc/kvm.c     | 75 ++++++++++++++++++++++++++++++++++++++++++++
 target/ppc/kvm_ppc.h |  7 +++++
 3 files changed, 96 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 23bcd788daf6..708902934cff 100644
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
index 116b39a00f4e..d4c5601a00c4 100644
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
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 742881231e16..195dbaac5e17 100644
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
-- 
2.50.1 (Apple Git-155)


