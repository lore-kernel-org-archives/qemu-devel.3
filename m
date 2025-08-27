Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB0FCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHnM-0005TN-Vv; Wed, 27 Aug 2025 11:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHjO-0006pk-FV; Wed, 27 Aug 2025 11:06:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHjM-0005S5-2V; Wed, 27 Aug 2025 11:06:33 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E18BC14C54D;
 Wed, 27 Aug 2025 18:02:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CD6A4269855;
 Wed, 27 Aug 2025 18:03:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Chuang Xu <xuchuangxclwt@bytedance.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [Stable-10.0.4 37/59] target/i386/cpu: Move addressable ID encoding
 out of compat property in CPUID[0x1]
Date: Wed, 27 Aug 2025 18:02:42 +0300
Message-ID: <20250827150323.2694101-37-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Zhao Liu <zhao1.liu@intel.com>

Currently, the addressable ID encoding for CPUID[0x1].EBX[bits 16-23]
(Maximum number of addressable IDs for logical processors in this
physical package) is covered by vendor_cpuid_only_v2 compat property.
The previous consideration was to avoid breaking migration and this
compat property makes it unfriendly to backport the commit f985a1195ba2
("i386/cpu: Fix number of addressable IDs field for CPUID.01H.EBX
[23:16]").

However, NetBSD booting is broken since the commit 88dd4ca06c83
("i386/cpu: Use APIC ID info to encode cache topo in CPUID[4]"),
because NetBSD calculates smt information via `lp_max` / `core_max` for
legacy Intel CPUs which doesn't support 0xb leaf, where `lp_max` is from
CPUID[0x1].EBX.bits[16-23] and `core_max` is from CPUID[0x4].0x0.bits[26
-31].

The commit 88dd4ca0 changed the encoding rule of `core_max` but didn't
update `lp_max`, so that NetBSD would get the wrong smt information,
which leads to the module loading failure.

Luckily, the commit f985a1195ba2 ("i386/cpu: Fix number of addressable
IDs field for CPUID.01H.EBX[23:16]") updated the encoding rule for
`lp_max` and accidentally fixed the NetBSD issue too. This also shows
that using CPUID[0x1] and CPUID[0x4].0x0 to calculate HT/SMT information
is a common practice to detect CPU topology on legacy Intel CPUs.

Therefore, it's necessary to backport the commit f985a1195ba2 to
previous stable QEMU to help address the similar issues as well. Then
the compat property is not needed any more since all stable QEMUs will
follow the same encoding way.

So, in CPUID[0x1], move addressable ID encoding out of compat property.

Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Inspired-by: Chuang Xu <xuchuangxclwt@bytedance.com>
Fixes: commit f985a1195ba2 ("i386/cpu: Fix number of addressable IDs field for CPUID.01H.EBX[23:16]")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3061
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Tested-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20250804053548.1808629-1-zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 4e5d58969ed6927a7f1b08ba6223c34c8b990c92)
(Mjt: when picking up commit f985a1195ba2d9c6f6f33e83fe2e419a7e8acb60
 "i386/cpu: Fix number of addressable IDs field for CPUID.01H.EBX[23:16]"
 to 10.0, I commented out the condition (vendor_cpuid_only_v2 comparison)
 which is now being removed)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 56af1857b9..58c62ff5b5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6842,8 +6842,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              * count, but Intel needs maximum number of addressable IDs for
              * logical processors per package.
              */
-            if (/*10.0: cpu->vendor_cpuid_only_v2*/ false &&
-                (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
+            if ((IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
                 num = 1 << apicid_pkg_offset(topo_info);
             } else {
                 num = threads_per_pkg;
-- 
2.47.2


