Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD04C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wginr-0000o3-9X; Mon, 06 Jul 2026 08:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wgcQV-0002s3-Iq
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 02:03:31 -0400
Received: from [115.124.28.5] (helo=out28-5.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wgcQR-0005Rq-6o
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 02:03:31 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07468145|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.253112-0.000743695-0.746145;
 FP=7196585128222115019|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033037021130;
 MF=zhang_wei@open-hieco.net; NM=1; PH=DS; RN=6; RT=6; SR=0;
 TI=SMTPD_---.iEEStq6_1783317364; 
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net
 fp:SMTPD_---.iEEStq6_1783317364 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 06 Jul 2026 13:56:05 +0800
From: zhang_wei@open-hieco.net
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v1 3/9] target/i386: Hide ARCH_CAPABILITIES for Hygon
Date: Mon,  6 Jul 2026 13:55:24 +0800
Message-ID: <20260706055530.1752094-4-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.5 (deferred)
Received-SPF: pass client-ip=115.124.28.5;
 envelope-from=zhang_wei@open-hieco.net; helo=out28-5.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 06 Jul 2026 08:51:44 -0400
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

From: Tina Zhang <zhang_wei@open-hieco.net>

IA32_ARCH_CAPABILITIES is an Intel-defined MSR.  KVM can synthesize the
CPUID bit and read-only MSR for non-Intel guests, and QEMU already hides
that interface for AMD CPU models because Windows may not expect it on
AMD-compatible CPUs.

Hygon Dhyana uses the HygonGenuine vendor string, so it currently skips
that AMD filter.  If arch-capabilities=on is requested, QEMU can expose
CPUID.7.0.EDX[ARCH_CAPABILITIES] and the associated MSR feature word to
a Hygon guest.

That creates a vendor-inconsistent CPU ABI: the guest sees an
AMD-compatible vendor and cache/topology interface, but also sees an
Intel-specific architectural capabilities MSR.  Guests that choose CPU
mitigation or feature paths from the vendor can mis-handle that
combination; Windows is known to be sensitive to ARCH_CAPABILITIES on
AMD-compatible CPUs.

Apply the same ARCH_CAPABILITIES hiding rule to Hygon CPUs when Hygon
vendor ABI fixes are enabled.  Keep arch_cap_always_on as the migration
escape hatch, and keep the old Hygon CPUID/MSR output for pc-11.0 and
older machine types via x-hygon-vendor-abi-fixes=false.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 target/i386/cpu.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f0cad38c94..47f48f4a96 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8209,6 +8209,8 @@ static uint8_t x86_cpu_get_host_avx10_version(void)
     return ebx & 0xff;
 }
 
+static bool x86_cpu_should_hide_arch_capabilities(const X86CPU *cpu);
+
 uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
 {
     FeatureWordInfo *wi = &feature_word_info[w];
@@ -8294,15 +8296,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
         break;
 
     case FEAT_7_0_EDX:
-        /*
-         * Windows does not like ARCH_CAPABILITIES on AMD machines at all.
-         * Do not show the fake ARCH_CAPABILITIES MSR that KVM sets up,
-         * except if needed for migration.
-         *
-         * When arch_cap_always_on is removed, this tweak can move to
-         * kvm_arch_get_supported_cpuid.
-         */
-        if (cpu && IS_AMD_CPU(&cpu->env) && !cpu->arch_cap_always_on) {
+        if (cpu && x86_cpu_should_hide_arch_capabilities(cpu)) {
             unavail = CPUID_7_0_EDX_ARCH_CAPABILITIES;
         }
         break;
@@ -8608,6 +8602,27 @@ uint32_t cpu_x86_virtual_addr_width(CPUX86State *env)
     }
 }
 
+/*
+ * Windows does not like ARCH_CAPABILITIES on AMD machines at all.
+ * Do not show the fake ARCH_CAPABILITIES MSR that KVM sets up,
+ * except if needed for migration.  Apply the same rule to Hygon CPUs when
+ * Hygon vendor ABI fixes are enabled.
+ *
+ * When arch_cap_always_on is removed, this tweak can move to
+ * kvm_arch_get_supported_cpuid.
+ */
+static bool x86_cpu_should_hide_arch_capabilities(const X86CPU *cpu)
+{
+    const CPUX86State *env = &cpu->env;
+
+    if (cpu->arch_cap_always_on) {
+        return false;
+    }
+
+    return IS_AMD_CPU(env) ||
+           (cpu->hygon_vendor_abi_fixes && IS_HYGON_CPU(env));
+}
+
 /*
  * AMD CPUs define CPUID[0x80000001].EDX aliases for selected CPUID[1].EDX
  * feature bits.  Hygon Dhyana follows the same extended feature alias rules.
-- 
2.43.7


