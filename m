Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871E7CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 13:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6UW9-0007ux-Ko; Wed, 08 Oct 2025 09:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v6UW7-0007ud-DG; Wed, 08 Oct 2025 09:47:43 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v6UVu-0008PN-9Y; Wed, 08 Oct 2025 09:47:42 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D331D15B959;
 Wed, 08 Oct 2025 16:47:09 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3392E29BA9C;
 Wed,  8 Oct 2025 16:47:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH for-10.0.x] Revert "i386/cpu: Move adjustment of
 CPUID_EXT_PDCM before feature_dependencies[] check"
Date: Wed,  8 Oct 2025 16:47:14 +0300
Message-ID: <20251008134716.528025-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
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

This reverts commit 3d26cb65c27190e57637644ecf6c96b8c3d246a3
(v10.0.3-34-g3d26cb65c271) from 10.0.x branch.

The problem is that the change makes qemu 10.0.x non-migratable
to subsequent qemu versions, since it requires introducing a new
machine type.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 target/i386/cpu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 58c62ff5b5..34b52ef7a1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6851,6 +6851,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             /* Fixup overflow: max value for bits 23-16 is 255. */
             *ebx |= MIN(num, 255) << 16;
         }
+        if (!cpu->enable_pmu) {
+            *ecx &= ~CPUID_EXT_PDCM;
+        }
         break;
     case 2:
         /* cache info: needed for Pentium Pro compatibility */
@@ -7840,10 +7843,6 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
-    if (!cpu->enable_pmu) {
-        env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
-    }
-
     for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
         FeatureDep *d = &feature_dependencies[i];
         if (!(env->features[d->from.index] & d->from.mask)) {
-- 
2.47.3


