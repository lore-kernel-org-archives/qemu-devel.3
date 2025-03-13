Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23494C28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 10:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsfgH-0005L8-N5; Thu, 13 Mar 2025 06:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1tsfg2-0005JA-Gk
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:20:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1tsffx-0002Nc-Pr
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741861229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HSi7UVsmClVu72xEu4yllomq/nC2HQFwOx2jiGv9qBg=;
 b=Rvhgw7wc5zm1F7w47sDjWEEI0oIgY0eQ8lSpg0dEGrUmgz0Xr0tefhpfMJxgWUnMlniGTB
 hUKR5McC4jm+/yj6bHpoWt9l8/VgCarkmVqKvexdnJ4Jd3/UC+OVCz7zc0IQpRkBK1TDXn
 fob96MCJ0v9ipYiOYL8y9Syir7r5G4M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-vfpnrnCZMkybsV7-fsY_xg-1; Thu,
 13 Mar 2025 06:19:16 -0400
X-MC-Unique: vfpnrnCZMkybsV7-fsY_xg-1
X-Mimecast-MFC-AGG-ID: vfpnrnCZMkybsV7-fsY_xg_1741861155
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 852CC1801A07
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 10:19:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.22.17])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BB88F300376F; Thu, 13 Mar 2025 10:19:13 +0000 (UTC)
From: Anthony Harivel <aharivel@redhat.com>
To: pbonzini@redhat.com,
	berrange@redhat.com
Cc: qemu-devel@nongnu.org,
	Anthony Harivel <aharivel@redhat.com>
Subject: [PATCH 1/2] target/i386/kvm: add AMD support for RAPL MSR
Date: Thu, 13 Mar 2025 11:19:01 +0100
Message-ID: <20250313101902.835556-2-aharivel@redhat.com>
In-Reply-To: <20250313101902.835556-1-aharivel@redhat.com>
References: <20250313101902.835556-1-aharivel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Rework the RAPL MSR support to function with AMD specific RAPL MSR.

Implement support for AMD-specific RAPL MSRs. AMD CPUs support three
MSRs: MSR_AMD_RAPL_POWER_UNIT, MSR_AMD_PKG_ENERGY_STATUS, and
MSR_AMD_CORE_ENERGY_STATUS. These MSRs have different addresses compared
to their Intel counterparts. Integrate the first two MSRs to align with
the current RAPL MSR implementation. Automatically detect the host CPU
at runtime and select the appropriate MSRs.

Signed-off-by: Anthony Harivel <aharivel@redhat.com>
---
 docs/specs/rapl-msr.rst       |  21 ++++---
 include/system/kvm_int.h      |   4 ++
 target/i386/cpu.h             |   2 +
 target/i386/kvm/kvm.c         | 111 ++++++++++++++++++++++------------
 target/i386/kvm/vmsr_energy.c |  10 +++
 target/i386/kvm/vmsr_energy.h |   1 +
 tools/i386/qemu-vmsr-helper.c |  47 ++++++++------
 tools/i386/rapl-msr-index.h   |   4 ++
 8 files changed, 134 insertions(+), 66 deletions(-)

diff --git a/docs/specs/rapl-msr.rst b/docs/specs/rapl-msr.rst
index aaf0db9f91b9..37fb9677c9a4 100644
--- a/docs/specs/rapl-msr.rst
+++ b/docs/specs/rapl-msr.rst
@@ -20,10 +20,14 @@ At the moment the following MSRs are involved:
 
 .. code:: C
 
+    // Intel CPU
     #define MSR_RAPL_POWER_UNIT             0x00000606
     #define MSR_PKG_POWER_LIMIT             0x00000610
     #define MSR_PKG_ENERGY_STATUS           0x00000611
     #define MSR_PKG_POWER_INFO              0x00000614
+    // AMD CPU
+    #define MSR_AMD_RAPL_POWER_UNIT         0xc0010299
+    #define MSR_AMD_PKG_ENERGY_STATUS       0xc001029b
 
 The ``*_POWER_UNIT``, ``*_POWER_LIMIT``, ``*_POWER INFO`` are part of the RAPL
 spec and specify the power limit of the package, provide range of parameter(min
@@ -32,18 +36,18 @@ counter to calculate the power. Those MSRs are populated once at the beginning
 by reading the host CPU MSRs and are given back to the guest 1:1 when
 requested.
 
-The MSR_PKG_ENERGY_STATUS is a counter; it represents the total amount of
+The ``*_PKG_ENERGY_STATUS`` is a counter; it represents the total amount of
 energy consumed since the last time the register was cleared. If you multiply
 it with the UNIT provided above you'll get the power in micro-joules. This
 counter is always increasing and it increases more or less faster depending on
 the consumption of the package. This counter is supposed to overflow at some
 point.
 
-Each core belonging to the same Package reading the MSR_PKG_ENERGY_STATUS (i.e
-"rdmsr 0x611") will retrieve the same value. The value represents the energy
-for the whole package. Whatever Core reading it will get the same value and a
-core that belongs to PKG-0 will not be able to get the value of PKG-1 and
-vice-versa.
+Each core belonging to the same Package reading the ``*_PKG_ENERGY_STATUS`` (i.e
+"rdmsr 0x611" for Intel CPU) will retrieve the same value. The value represents
+the energy for the whole package. Whatever Core reading it will get the same
+value and a core that belongs to PKG-0 will not be able to get the value of
+PKG-1 and vice-versa.
 
 High level implementation
 -------------------------
@@ -146,9 +150,6 @@ See the qemu-pr-helper documentation or manpage for further details.
 Current Limitations
 -------------------
 
-- Works only on Intel host CPUs because AMD CPUs are using different MSR
-  addresses.
-
-- Only the Package Power-Plane (MSR_PKG_ENERGY_STATUS) is reported at the
+- Only the Package Power-Plane (``*_PKG_ENERGY_STATUS``) is reported at the
   moment.
 
diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 4de6106869b0..3c91aa35d1a5 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -76,6 +76,10 @@ struct KVMMsrEnergy {
     X86CPUTopoInfo guest_topo_info;
     KVMHostTopoInfo host_topo;
     const CPUArchIdList *guest_cpu_list;
+    uint64_t msr_value_addr;
+    uint64_t msr_unit_addr;
+    uint64_t msr_limit_addr;
+    uint64_t msr_info_addr;
     uint64_t *msr_value;
     uint64_t msr_unit;
     uint64_t msr_limit;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 76f24446a55d..89a0202e3f40 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -420,6 +420,8 @@ typedef enum X86Seg {
 #define MSR_ARCH_LBR_FROM_0             0x00001500
 #define MSR_ARCH_LBR_TO_0               0x00001600
 #define MSR_ARCH_LBR_INFO_0             0x00001200
+#define MSR_AMD_RAPL_POWER_UNIT         0xc0010299
+#define MSR_AMD_PKG_ENERGY_STATUS       0xc001029b
 
 #define FEATURE_CONTROL_LOCKED                    (1<<0)
 #define FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX  (1ULL << 1)
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6c749d4ee812..4bd40d4060a4 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2772,7 +2772,7 @@ static void *kvm_msr_energy_thread(void *data)
                  */
                 if (thd_stat[j].pkg_id == i) {
                     pkg_stat[i].e_start =
-                    vmsr_read_msr(MSR_PKG_ENERGY_STATUS,
+                    vmsr_read_msr(s->msr_energy.msr_value_addr,
                                   thd_stat[j].cpu_id,
                                   thd_stat[j].thread_id,
                                   s->msr_energy.sioc);
@@ -2796,7 +2796,7 @@ static void *kvm_msr_energy_thread(void *data)
                  */
                 if (thd_stat[j].pkg_id == i) {
                     pkg_stat[i].e_end =
-                    vmsr_read_msr(MSR_PKG_ENERGY_STATUS,
+                    vmsr_read_msr(s->msr_energy.msr_value_addr,
                                   thd_stat[j].cpu_id,
                                   thd_stat[j].thread_id,
                                   s->msr_energy.sioc);
@@ -2936,12 +2936,23 @@ static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
 
     /*
      * Sanity check
-     * 1. Host cpu must be Intel cpu
+     * 1. Host cpu must be Intel or AMD cpu
      * 2. RAPL must be enabled on the Host
      */
-    if (!is_host_cpu_intel()) {
+    if (is_host_cpu_intel()) {
+        r->msr_value_addr = MSR_PKG_ENERGY_STATUS;
+        r->msr_unit_addr  = MSR_RAPL_POWER_UNIT;
+        r->msr_limit_addr = MSR_PKG_POWER_LIMIT;
+        r->msr_info_addr  = MSR_PKG_POWER_INFO;
+    } else if (is_host_cpu_amd()) {
+        r->msr_value_addr = MSR_AMD_PKG_ENERGY_STATUS;
+        r->msr_unit_addr  = MSR_AMD_RAPL_POWER_UNIT;
+        /* The following MSR are not available on AMD CPU */
+        r->msr_limit_addr = 0;
+        r->msr_info_addr  = 0;
+    } else {
         error_report("The RAPL feature can only be enabled on hosts "
-                     "with Intel CPU models");
+                     "with Intel or AMD CPU models");
         return -1;
     }
 
@@ -3008,17 +3019,22 @@ static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
     }
 
     /* Those MSR values should not change */
-    r->msr_unit  = vmsr_read_msr(MSR_RAPL_POWER_UNIT, 0, r->pid,
+    r->msr_unit  = vmsr_read_msr(r->msr_unit_addr, 0, r->pid,
                                     s->msr_energy.sioc);
-    r->msr_limit = vmsr_read_msr(MSR_PKG_POWER_LIMIT, 0, r->pid,
-                                    s->msr_energy.sioc);
-    r->msr_info  = vmsr_read_msr(MSR_PKG_POWER_INFO, 0, r->pid,
-                                    s->msr_energy.sioc);
-    if (r->msr_unit == 0 || r->msr_limit == 0 || r->msr_info == 0) {
-        error_report("can't read any virtual msr");
+
+    if (r->msr_unit == 0) {
+        error_report("Can't read Unit info virtual msr");
         return -1;
     }
 
+    /* Only Intel CPU expose those MSR */
+    if (!r->msr_limit_addr == 0 || !r->msr_info_addr == 0) {
+        r->msr_limit = vmsr_read_msr(r->msr_limit_addr, 0, r->pid,
+                                        s->msr_energy.sioc);
+        r->msr_info  = vmsr_read_msr(r->msr_info_addr, 0, r->pid,
+                                        s->msr_energy.sioc);
+    }
+
     qemu_thread_create(&r->msr_thr, "kvm-msr",
                        kvm_msr_energy_thread,
                        s, QEMU_THREAD_JOINABLE);
@@ -3164,35 +3180,52 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
     int ret;
 
     if (s->msr_energy.enable == true) {
-        ret = kvm_filter_msr(s, MSR_RAPL_POWER_UNIT,
-                             kvm_rdmsr_rapl_power_unit, NULL);
-        if (ret < 0) {
-            error_report("Could not install MSR_RAPL_POWER_UNIT handler: %s",
-                         strerror(-ret));
-            return ret;
-        }
+        if (is_host_cpu_intel()) {
+            ret = kvm_filter_msr(s, MSR_RAPL_POWER_UNIT,
+                                 kvm_rdmsr_rapl_power_unit, NULL);
+            if (ret < 0) {
+                error_report("Could not install RAPL POWER UNIT handler: %s",
+                             strerror(-ret));
+                return ret;
+            }
 
-        ret = kvm_filter_msr(s, MSR_PKG_POWER_LIMIT,
-                             kvm_rdmsr_pkg_power_limit, NULL);
-        if (ret < 0) {
-            error_report("Could not install MSR_PKG_POWER_LIMIT handler: %s",
-                         strerror(-ret));
-            return ret;
-        }
+            ret = kvm_filter_msr(s, MSR_PKG_POWER_LIMIT,
+                                 kvm_rdmsr_pkg_power_limit, NULL);
+            if (ret < 0) {
+                error_report("Could not install RAPL POWER LIMIT handler: %s",
+                             strerror(-ret));
+                return ret;
+            }
 
-        ret = kvm_filter_msr(s, MSR_PKG_POWER_INFO,
-                             kvm_rdmsr_pkg_power_info, NULL);
-        if (ret < 0) {
-            error_report("Could not install MSR_PKG_POWER_INFO handler: %s",
-                         strerror(-ret));
-            return ret;
-        }
-        ret = kvm_filter_msr(s, MSR_PKG_ENERGY_STATUS,
-                             kvm_rdmsr_pkg_energy_status, NULL);
-        if (ret < 0) {
-            error_report("Could not install MSR_PKG_ENERGY_STATUS handler: %s",
-                         strerror(-ret));
-            return ret;
+            ret = kvm_filter_msr(s, MSR_PKG_POWER_INFO,
+                                 kvm_rdmsr_pkg_power_info, NULL);
+            if (ret < 0) {
+                error_report("Could not install RAPL POWER INFO handler: %s",
+                             strerror(-ret));
+                return ret;
+            }
+            ret = kvm_filter_msr(s, MSR_PKG_ENERGY_STATUS,
+                                 kvm_rdmsr_pkg_energy_status, NULL);
+            if (ret < 0) {
+                error_report("Could not install RAPL ENERGY STATUS handler: %s",
+                             strerror(-ret));
+                return ret;
+            }
+        } else if (is_host_cpu_amd()) {
+            ret = kvm_filter_msr(s, MSR_AMD_RAPL_POWER_UNIT,
+                                 kvm_rdmsr_rapl_power_unit, NULL);
+            if (ret < 0) {
+                error_report("Could not install RAPL POWER UNIT handler: %s",
+                             strerror(-ret));
+                return ret;
+            }
+            ret = kvm_filter_msr(s, MSR_AMD_PKG_ENERGY_STATUS,
+                                 kvm_rdmsr_pkg_energy_status, NULL);
+            if (ret < 0) {
+                error_report("Could not install RAPL ENERGY STATUS handler: %s",
+                             strerror(-ret));
+                return ret;
+            }
         }
     }
     return 0;
diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energy.c
index 31508d4e77a2..f3861d0607bb 100644
--- a/target/i386/kvm/vmsr_energy.c
+++ b/target/i386/kvm/vmsr_energy.c
@@ -37,6 +37,16 @@ bool is_host_cpu_intel(void)
     return g_str_equal(vendor, CPUID_VENDOR_INTEL);
 }
 
+bool is_host_cpu_amd(void)
+{
+    int family, model, stepping;
+    char vendor[CPUID_VENDOR_SZ + 1];
+
+    host_cpu_vendor_fms(vendor, &family, &model, &stepping);
+
+    return g_str_equal(vendor, CPUID_VENDOR_AMD);
+}
+
 int is_rapl_enabled(void)
 {
     const char *path = "/sys/class/powercap/intel-rapl/enabled";
diff --git a/target/i386/kvm/vmsr_energy.h b/target/i386/kvm/vmsr_energy.h
index 16cc1f4814f6..8aeed09c33b7 100644
--- a/target/i386/kvm/vmsr_energy.h
+++ b/target/i386/kvm/vmsr_energy.h
@@ -95,5 +95,6 @@ double vmsr_get_ratio(uint64_t e_delta,
                       unsigned int maxticks);
 void vmsr_init_topo_info(X86CPUTopoInfo *topo_info, const MachineState *ms);
 bool is_host_cpu_intel(void);
+bool is_host_cpu_amd(void);
 int is_rapl_enabled(void);
 #endif /* VMSR_ENERGY_H */
diff --git a/tools/i386/qemu-vmsr-helper.c b/tools/i386/qemu-vmsr-helper.c
index a35dcb88a3fd..35831423cd53 100644
--- a/tools/i386/qemu-vmsr-helper.c
+++ b/tools/i386/qemu-vmsr-helper.c
@@ -48,6 +48,15 @@
 
 #define MSR_PATH_TEMPLATE "/dev/cpu/%u/msr"
 
+/* Constants for Intel and AMD vendor IDs */
+#define INTEL_VENDOR_ID_EBX 0x756e6547
+#define INTEL_VENDOR_ID_ECX 0x6c65746e
+#define INTEL_VENDOR_ID_EDX 0x49656e69
+
+#define AMD_VENDOR_ID_EBX 0x68747541
+#define AMD_VENDOR_ID_ECX 0x444d4163
+#define AMD_VENDOR_ID_EDX 0x69746e65
+
 static char *socket_path;
 static char *pidfile;
 static enum { RUNNING, TERMINATE, TERMINATING } state;
@@ -69,27 +78,29 @@ static void compute_default_paths(void)
     pidfile = g_build_filename(state, "run", "qemu-vmsr-helper.pid", NULL);
 }
 
-static int is_intel_processor(void)
+static void get_cpu_vendor_ids(uint32_t *ebx, uint32_t *ecx, uint32_t *edx)
 {
-    int result;
-    int ebx, ecx, edx;
-
-    /* Execute CPUID instruction with eax=0 (basic identification) */
     asm volatile (
         "cpuid"
-        : "=b" (ebx), "=c" (ecx), "=d" (edx)
+        : "=b" (*ebx), "=c" (*ecx), "=d" (*edx)
         : "a" (0)
     );
+}
 
-    /*
-     *  Check if processor is "GenuineIntel"
-     *  0x756e6547 = "Genu"
-     *  0x49656e69 = "ineI"
-     *  0x6c65746e = "ntel"
-     */
-    result = (ebx == 0x756e6547) && (edx == 0x49656e69) && (ecx == 0x6c65746e);
+static int is_intel_processor(void)
+{
+    uint32_t ebx, ecx, edx;
+    get_cpu_vendor_ids(&ebx, &ecx, &edx);
+    return (ebx == INTEL_VENDOR_ID_EBX) && (ecx == INTEL_VENDOR_ID_ECX)
+        && (edx == INTEL_VENDOR_ID_EDX);
+}
 
-    return result;
+static int is_amd_processor(void)
+{
+    uint32_t ebx, ecx, edx;
+    get_cpu_vendor_ids(&ebx, &ecx, &edx);
+    return (ebx == AMD_VENDOR_ID_EBX) && (ecx == AMD_VENDOR_ID_ECX)
+        && (edx == AMD_VENDOR_ID_EDX);
 }
 
 static int is_rapl_enabled(void)
@@ -137,6 +148,8 @@ static bool is_msr_allowed(uint32_t reg)
     case MSR_PKG_POWER_LIMIT:
     case MSR_PKG_ENERGY_STATUS:
     case MSR_PKG_POWER_INFO:
+    case MSR_AMD_RAPL_POWER_UNIT:
+    case MSR_AMD_PKG_ENERGY_STATUS:
         return true;
     default:
         return false;
@@ -369,11 +382,11 @@ int main(int argc, char **argv)
 
     /*
      * Sanity check
-     * 1. cpu must be Intel cpu
+     * 1. cpu must be Intel or AMD cpu
      * 2. RAPL must be enabled
      */
-    if (!is_intel_processor()) {
-        error_report("error: CPU is not INTEL cpu");
+    if (!is_intel_processor() && !is_amd_processor()) {
+        error_report("error: CPU is neither INTEL nor AMD cpu");
         exit(EXIT_FAILURE);
     }
 
diff --git a/tools/i386/rapl-msr-index.h b/tools/i386/rapl-msr-index.h
index 9a7118639ae3..45e89823a647 100644
--- a/tools/i386/rapl-msr-index.h
+++ b/tools/i386/rapl-msr-index.h
@@ -26,3 +26,7 @@
 #define MSR_PKG_POWER_LIMIT             0x00000610
 #define MSR_PKG_ENERGY_STATUS           0x00000611
 #define MSR_PKG_POWER_INFO              0x00000614
+
+/* AMD Specific RAPL MSR */
+#define MSR_AMD_RAPL_POWER_UNIT         0xc0010299
+#define MSR_AMD_PKG_ENERGY_STATUS       0xc001029b
-- 
2.48.1


