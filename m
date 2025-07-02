Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4EDC7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 09:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWtoO-0004ew-1o; Wed, 02 Jul 2025 05:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexandre.chartre@oracle.com>)
 id 1uWtoM-0004ei-A9; Wed, 02 Jul 2025 05:31:26 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexandre.chartre@oracle.com>)
 id 1uWtoK-0003Up-8N; Wed, 02 Jul 2025 05:31:25 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5627MhO3000672;
 Wed, 2 Jul 2025 09:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=o9rOi9sQPonl3ohRBI3xA3LLxfdoy
 hJ2Uj05bKOzct0=; b=JTQ76gP0CT+NwVXYvPZTpeuuDgxDDgBkW2OcM2FlRCSAf
 mXMDuuqKvNXptpqhcipd7KF8cFU2lZsL1Zz4MQmDIRUThVzCZ9TLJbUNxYm1EUu7
 hWeRldQSIrFjuy9OBiaNtkNdYjUltQpkdl4A6DBjcgzVuzvZLJy2j9nrf7Hve0OM
 b0JyEaKI6F8guJSWFFshfxOx25fwil3MuuhqTO2YbK/l0cNoP5o2bDqzMpwjGGlc
 W+ipN2WiHH7Fw23RpydIGSNPW7Af0xiJafnSPpkGyw4J1ZnGqQ3dkNznHchcaDR6
 muyLAimX0L9rpYdquuy6sp2BVUxzGznUfzrnicciw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8ef6kab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 09:31:19 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5628eHmB019559; Wed, 2 Jul 2025 09:31:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6uaqr18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 09:31:18 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5629SHNF032499;
 Wed, 2 Jul 2025 09:31:18 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com
 (dhcp-10-154-170-239.vpn.oracle.com [10.154.170.239])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 47j6uaqqy3-1; Wed, 02 Jul 2025 09:31:17 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, xiaoyao.li@intel.com
Cc: qemu-stable@nongnu.org, seanjc@google.com, zhao1.liu@intel.com,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
 maciej.szmigiero@oracle.com, alexandre.chartre@oracle.com
Subject: [PATCH v2] i386/cpu: ARCH_CAPABILITIES should not be advertised on AMD
Date: Wed,  2 Jul 2025 11:31:14 +0200
Message-ID: <20250702093114.789651-1-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020076
X-Proofpoint-GUID: QTP2sqdkql-ejwQ3BiPowxwzEsu0N6dL
X-Proofpoint-ORIG-GUID: QTP2sqdkql-ejwQ3BiPowxwzEsu0N6dL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA3NyBTYWx0ZWRfXzZhgJGVkzS+S
 qLwKi+9B6cx/2kZgquTfodgZ10+ifnvYbLulAJC+/Ot8NYSBhYiriEnoQeVISTW+ZtDm2f6wCOD
 Sji+3GRdBX1lGCbaHfRAexS3ty8GF9BlPqxnPDu30PO1fqeBW5f0gZ41+MgSLt4jDtcCf6I0ce1
 NR9E45TuoXNSHreLx9CCL3Sw9RFGHPCBHdkBztWGP0A09bCdnNRQcIOl78WcFkI0z2Q0jRkOu2x
 S64Bs9afLgZ4RAEwRdw2+kbGTc77qlHMJljqidItNOAnqyxMfztUxcgqt+F75fnPprDHFtuOWYR
 eY1hhc0mOOqD3eWvYQejgTcGg6RSHTunuKtKgbdp3G3p919RajtTOJJTEBHLphiOrYj1qI70CcY
 u/1JXHHUGayXXhET7mZAzeLCVKpeNJY+0hPf49pgxHobvwM4u1QLdRQxaD3WpVe8x417MN0Z
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=6864fc67 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Wb1JkmetP80A:10 a=p0WdMEafAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=3gmFI6HadyW09CJ1zRIA:9
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alexandre.chartre@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

KVM emulates the ARCH_CAPABILITIES on x86 for both Intel and AMD
cpus, although the IA32_ARCH_CAPABILITIES MSR is an Intel-specific
MSR and it makes no sense to emulate it on AMD.

As a consequence, VMs created on AMD with qemu -cpu host and using
KVM will advertise the ARCH_CAPABILITIES feature and provide the
IA32_ARCH_CAPABILITIES MSR. This can cause issues (like Windows BSOD)
as the guest OS might not expect this MSR to exist on such cpus (the
AMD documentation specifies that ARCH_CAPABILITIES feature and MSR
are not defined on the AMD architecture).

A fix was proposed in KVM code, however KVM maintainers don't want to
change this behavior that exists for 6+ years and suggest changes to be
done in qemu instead.

So this commit changes the behavior in qemu so that ARCH_CAPABILITIES
is not available anymore for AMD cpus on i440fx and q35 machines.
The capability remains available (and enabled by default) on older
versions of i440fx/q35 machines.

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3001
Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 hw/i386/pc.c          |  4 +++-
 target/i386/cpu.c     | 18 ++++++++++++++++++
 target/i386/cpu.h     |  7 +++++++
 target/i386/kvm/kvm.c |  5 +++++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b211633575..c175e7d9e7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -81,7 +81,9 @@
     { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
-GlobalProperty pc_compat_10_0[] = {};
+GlobalProperty pc_compat_10_0[] = {
+    { TYPE_X86_CPU, "x-amd-disable-arch-capabs", "false" },
+};
 const size_t pc_compat_10_0_len = G_N_ELEMENTS(pc_compat_10_0);
 
 GlobalProperty pc_compat_9_2[] = {};
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0d35e95430..6247e347ea 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8324,6 +8324,22 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
+    /*
+     * For years, KVM has inadvertently emulated the ARCH_CAPABILITIES
+     * MSR on AMD although this is an Intel-specific MSR; and KVM will
+     * continue doing so to not change its ABI for existing setups.
+     *
+     * So ensure that the ARCH_CAPABILITIES MSR is disabled on AMD cpus
+     * to prevent providing a cpu with an MSR which is not supposed to
+     * be there.
+     */
+    if (cpu->amd_disable_arch_capabs && IS_AMD_CPU(env)) {
+        mark_unavailable_features(cpu, FEAT_7_0_EDX,
+            env->user_features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_CAPABILITIES,
+            "This feature is not available for AMD Guest");
+        env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_CAPABILITIES;
+    }
+
     if (x86_threads_per_pkg(&env->topo_info) > 1) {
         env->features[FEAT_1_EDX] |= CPUID_HT;
 
@@ -9393,6 +9409,8 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level,
                      true),
     DEFINE_PROP_BOOL("x-l1-cache-per-thread", X86CPU, l1_cache_per_core, true),
+    DEFINE_PROP_BOOL("x-amd-disable-arch-capabs", X86CPU, amd_disable_arch_capabs,
+                     true),
 };
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 51e10139df..a3fc80de3a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2306,6 +2306,13 @@ struct ArchCPU {
      */
     uint32_t guest_phys_bits;
 
+    /*
+     * Compatibility bits for old machine types.
+     * If true disable CPUID_7_0_EDX_ARCH_CAPABILITIES and
+     * MSR_IA32_ARCH_CAPABILITIES for AMD Guest.
+     */
+    bool amd_disable_arch_capabs;
+
     /* in order to simplify APIC support, we leave this pointer to the
        user */
     struct DeviceState *apic_state;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 234878c613..40a50ae193 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2368,6 +2368,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     cpu->kvm_msr_buf = g_malloc0(MSR_BUF_SIZE);
 
+    if (cpu->amd_disable_arch_capabs &&
+        !(env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_CAPABILITIES)) {
+        has_msr_arch_capabs = false;
+    }
+
     if (!(env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_RDTSCP)) {
         has_msr_tsc_aux = false;
     }
-- 
2.43.5


