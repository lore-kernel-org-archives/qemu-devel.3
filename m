Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8903C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 19:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJzpW-0003wn-05; Tue, 27 May 2025 15:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elisey@Eliseys-PC.local>)
 id 1uJxSx-0007sz-Gu
 for qemu-devel@nongnu.org; Tue, 27 May 2025 12:47:51 -0400
Received: from [212.28.69.22] (helo=Eliseys-PC.local)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elisey@Eliseys-PC.local>) id 1uJxSu-00041h-EA
 for qemu-devel@nongnu.org; Tue, 27 May 2025 12:47:51 -0400
Received: by Eliseys-PC.local (Postfix, from userid 501)
 id 120B51BA47E; Tue, 27 May 2025 17:29:19 +0300 (EEST)
To: qemu-devel@nongnu.org
Cc: Elisey <elisey.konstantinov@icloud.com>
Subject: [PATCH 1/1] Revert "i386/cpu: Set up CPUID_HT in
 x86_cpu_expand_features() instead of cpu_x86_cpuid()"
Date: Tue, 27 May 2025 17:29:14 +0300
Message-Id: <20250527142914.19334-1-elisey.konstantinov@icloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 212.28.69.22 (failed)
Received-SPF: none client-ip=212.28.69.22;
 envelope-from=elisey@Eliseys-PC.local; helo=Eliseys-PC.local
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 NO_DNS_FOR_FROM=0.001, RCVD_IN_PBL=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_NONE=0.001, SPOOFED_FREEMAIL=0.001,
 SPOOFED_FREEMAIL_NO_RDNS=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 May 2025 15:19:15 -0400
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
Reply-to:  Elisey <elisey.konstantinov@icloud.com>
From:  Elisey via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This reverts commit c6bd2dd634208ca717b6dc010064fe34d1359080.
---
 target/i386/cpu.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9689f6374e..c648a1cf04 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6859,6 +6859,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *edx = env->features[FEAT_1_EDX];
         if (threads_per_pkg > 1) {
             *ebx |= threads_per_pkg << 16;
+            *edx |= CPUID_HT;
         }
         if (!cpu->enable_pmu) {
             *ecx &= ~CPUID_EXT_PDCM;
@@ -7838,20 +7839,6 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
-    if (x86_threads_per_pkg(&env->topo_info) > 1) {
-        env->features[FEAT_1_EDX] |= CPUID_HT;
-
-        /*
-         * The Linux kernel checks for the CMPLegacy bit and
-         * discards multiple thread information if it is set.
-         * So don't set it here for Intel (and other processors
-         * following Intel's behavior) to make Linux guests happy.
-         */
-        if (!IS_INTEL_CPU(env) && !IS_ZHAOXIN_CPU(env)) {
-            env->features[FEAT_8000_0001_ECX] |= CPUID_EXT3_CMP_LEG;
-        }
-    }
-
     for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
         FeatureDep *d = &feature_dependencies[i];
         if (!(env->features[d->from.index] & d->from.mask)) {
-- 
2.39.5 (Apple Git-154)


