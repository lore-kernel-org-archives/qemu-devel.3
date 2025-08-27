Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180C0CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHmi-0004jO-2S; Wed, 27 Aug 2025 11:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHjJ-0006k8-QY; Wed, 27 Aug 2025 11:06:31 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHjH-0005RL-Pm; Wed, 27 Aug 2025 11:06:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BDA2314C54B;
 Wed, 27 Aug 2025 18:02:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A6A09269853;
 Wed, 27 Aug 2025 18:03:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Chuang Xu <xuchuangxclwt@bytedance.com>,
 Zhao Liu <zhao1.liu@intel.com>, Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 35/59] i386/cpu: Fix number of addressable IDs field
 for CPUID.01H.EBX[23:16]
Date: Wed, 27 Aug 2025 18:02:40 +0300
Message-ID: <20250827150323.2694101-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Chuang Xu <xuchuangxclwt@bytedance.com>

When QEMU is started with:
-cpu host,migratable=on,host-cache-info=on,l3-cache=off
-smp 180,sockets=2,dies=1,cores=45,threads=2

On Intel platform:
CPUID.01H.EBX[23:16] is defined as "max number of addressable IDs for
logical processors in the physical package".

When executing "cpuid -1 -l 1 -r" in the guest, we obtain a value of 90 for
CPUID.01H.EBX[23:16], whereas the expected value is 128. Additionally,
executing "cpuid -1 -l 4 -r" in the guest yields a value of 63 for
CPUID.04H.EAX[31:26], which matches the expected result.

As (1+CPUID.04H.EAX[31:26]) rounds up to the nearest power-of-2 integer,
it's necessary to round up CPUID.01H.EBX[23:16] to the nearest power-of-2
integer too. Otherwise there would be unexpected results in guest with
older kernel.

For example, when QEMU is started with CLI above and xtopology is disabled,
guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
as the result, even though threads-per-core should actually be 2.

And on AMD platform:
CPUID.01H.EBX[23:16] is defined as "Logical processor count". Current
result meets our expectation.

So round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer only
for Intel platform to solve the unexpected result.

Use the "x-vendor-cpuid-only-v2" compat option to fix this issue.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250714080859.1960104-5-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit f985a1195ba2d9c6f6f33e83fe2e419a7e8acb60)
(Mjt: this change refers to cpu->vendor_cpuid_only_v2 which is introduced
 after 10.0, but this reference is removed later.  Replace it with false
 for now, so effectively this commit is a no-op, but prepares the code
 for the next change in this area and keeps historical references)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d3e3ca13ca..ed262edcc8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6835,7 +6835,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         *edx = env->features[FEAT_1_EDX];
         if (threads_per_pkg > 1) {
-            *ebx |= threads_per_pkg << 16;
+            /*
+             * For CPUID.01H.EBX[Bits 23-16], AMD requires logical processor
+             * count, but Intel needs maximum number of addressable IDs for
+             * logical processors per package.
+             */
+            if (/*10.0: cpu->vendor_cpuid_only_v2*/ false &&
+                (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
+                *ebx |= 1 << apicid_pkg_offset(topo_info) << 16;
+            } else {
+                *ebx |= threads_per_pkg << 16;
+            }
         }
         break;
     case 2:
-- 
2.47.2


