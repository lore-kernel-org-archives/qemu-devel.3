Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22ADC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgint-0000wl-Hh; Mon, 06 Jul 2026 08:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wgcQW-0002sG-Gi
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 02:03:32 -0400
Received: from [115.124.28.193] (helo=out28-193.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wgcQR-0005Ru-75
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 02:03:32 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.0743885|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.0678529-0.000905267-0.931242;
 FP=7205585317544953051|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033037028158;
 MF=zhang_wei@open-hieco.net; NM=1; PH=DS; RN=6; RT=6; SR=0;
 TI=SMTPD_---.iEEStpQ_1783317364; 
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net
 fp:SMTPD_---.iEEStpQ_1783317364 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 06 Jul 2026 13:56:04 +0800
From: zhang_wei@open-hieco.net
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v1 2/9] target/i386: Hide Intel cache CPUID leaves for Hygon
Date: Mon,  6 Jul 2026 13:55:23 +0800
Message-ID: <20260706055530.1752094-3-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.193 (deferred)
Received-SPF: pass client-ip=115.124.28.193;
 envelope-from=zhang_wei@open-hieco.net; helo=out28-193.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 06 Jul 2026 08:51:52 -0400
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

When x-vendor-cpuid-only is enabled, QEMU suppresses CPUID leaves 2
and 4 for AuthenticAMD CPUs because those leaves describe Intel cache
information.  Hygon Dhyana uses the HygonGenuine vendor string, so it
currently skips that filtering and can expose Intel cache leaves together
with AMD/Hygon extended cache leaves.

That is inconsistent guest-visible CPUID: Hygon Dhyana provides cache
information through the extended cache leaves, so it should not also
advertise the Intel cache descriptor and deterministic cache parameter
leaves.

Apply the same leaf 2 and leaf 4 filtering to Hygon CPUs when Hygon
vendor ABI fixes are enabled.  The property keeps the old CPUID output
for pc-11.0 and older machine types.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 target/i386/cpu.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 32b8bc9ebd..f0cad38c94 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8622,6 +8622,21 @@ static bool x86_cpu_has_amd_cpuid_aliases(const X86CPU *cpu)
            (cpu->hygon_vendor_abi_fixes && IS_HYGON_CPU(env));
 }
 
+/*
+ * CPUID leaves 2 and 4 describe Intel cache information.  AMD CPUs use
+ * extended cache leaves instead, and Hygon Dhyana follows that AMD/Hygon
+ * convention.  Enable the corrected Hygon behavior only for machine types
+ * where Hygon vendor ABI fixes are on.
+ */
+static bool x86_cpu_filter_intel_cache_leaves(const X86CPU *cpu)
+{
+    const CPUX86State *env = &cpu->env;
+
+    return cpu->vendor_cpuid_only &&
+           (IS_AMD_CPU(env) ||
+            (cpu->hygon_vendor_abi_fixes && IS_HYGON_CPU(env)));
+}
+
 void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                    uint32_t *eax, uint32_t *ebx,
                    uint32_t *ecx, uint32_t *edx)
@@ -8707,7 +8722,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
-        } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
+        } else if (x86_cpu_filter_intel_cache_leaves(cpu)) {
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
@@ -8743,7 +8758,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                                 CPU_TOPOLOGY_LEVEL_SOCKET), 4095) << 14;
                 }
             }
-        } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
+        } else if (x86_cpu_filter_intel_cache_leaves(cpu)) {
             *eax = *ebx = *ecx = *edx = 0;
         } else {
             *eax = 0;
-- 
2.43.7


