Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86F5C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 09:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLHI-0007Rd-GU; Thu, 17 Jul 2025 05:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucL2M-0003mb-Sh; Thu, 17 Jul 2025 05:36:23 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucL2K-00028X-R8; Thu, 17 Jul 2025 05:36:22 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E167B137D01;
 Thu, 17 Jul 2025 12:34:05 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C334C2491FA;
 Thu, 17 Jul 2025 12:34:13 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Qian Wen <qian.wen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 64/65] i386/cpu: Fix overflow of cache topology fields
 in CPUID.04H
Date: Thu, 17 Jul 2025 12:34:00 +0300
Message-ID: <20250717093412.728292-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250717113032@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250717113032@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Qian Wen <qian.wen@intel.com>

According to SDM, CPUID.0x4:EAX[31:26] indicates the Maximum number of
addressable IDs for processor cores in the physical package. If we
launch over 64 cores VM, the 6-bit field will overflow, and the wrong
core_id number will be reported.

Since the HW reports 0x3f when the intel processor has over 64 cores,
limit the max value written to EAX[31:26] to 63, so max num_cores should
be 64.

For EAX[14:25], though at present Q35 supports up to 4096 CPUs, by
constructing a specific topology, the width of the APIC ID can be
extended beyond 12 bits. For example, using `-smp threads=33,cores=9,
modules=9` results in a die level offset of 6 + 4 + 4 = 14 bits, which
can also cause overflow.  check and honor the maximum value for
EAX[14:25] as well.

In addition, for host-cache-info case, also apply the same checks and
fixes.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Qian Wen <qian.wen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250714080859.1960104-7-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 3e86124e7cb9b66e07fb992667865a308f16fcf2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4603b2b98b..0480ad4ab1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -283,11 +283,17 @@ static void encode_cache_cpuid4(CPUCacheInfo *cache,
     assert(cache->size == cache->line_size * cache->associativity *
                           cache->partitions * cache->sets);
 
+    /*
+     * The following fields have bit-width limitations, so consider the
+     * maximum values to avoid overflow:
+     * Bits 25-14: maximum 4095.
+     * Bits 31-26: maximum 63.
+     */
     *eax = CACHE_TYPE(cache->type) |
            CACHE_LEVEL(cache->level) |
            (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0) |
-           (max_core_ids_in_package(topo_info) << 26) |
-           (max_thread_ids_for_cache(topo_info, cache->share_level) << 14);
+           (MIN(max_core_ids_in_package(topo_info), 63) << 26) |
+           (MIN(max_thread_ids_for_cache(topo_info, cache->share_level), 4095) << 14);
 
     assert(cache->line_size > 0);
     assert(cache->partitions > 0);
@@ -6867,13 +6873,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                 int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
 
                 *eax &= ~0xFC000000;
-                *eax |= max_core_ids_in_package(topo_info) << 26;
+                *eax |= MIN(max_core_ids_in_package(topo_info), 63) << 26;
                 if (host_vcpus_per_cache > threads_per_pkg) {
                     *eax &= ~0x3FFC000;
 
                     /* Share the cache at package level. */
-                    *eax |= max_thread_ids_for_cache(topo_info,
-                                CPU_TOPOLOGY_LEVEL_SOCKET) << 14;
+                    *eax |= MIN(max_thread_ids_for_cache(topo_info,
+                                CPU_TOPOLOGY_LEVEL_SOCKET), 4095) << 14;
                 }
             }
         } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
-- 
2.47.2


