Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C97606C194
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmvY-0002uZ-11; Fri, 13 Nov 2026 03:46:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmvU-0002tO-VH
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:29 -0500
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmvT-0007QN-E3
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:28 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id EA6F01DD;
 Fri, 13 Nov 2026 14:16:25 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v6 11/26] target/loongarch: add host TLBRet and handle
Date: Fri, 13 Nov 2026 16:45:26 +0800
Message-ID: <23c435596b199c9d3531aa29cfdc5b3bd5c5d726.1794558695.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794558695.git.prcups@krgm.moe>
References: <cover.1794558695.git.prcups@krgm.moe>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a14:640:1:12b5::1 (failed)
Received-SPF: pass client-ip=2a14:640:1:12b5::1; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add host value in enum TLBRet, and use it in raise_mmu_exception().

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu-mmu.h        |  8 ++++++++
 target/loongarch/tcg/tlb_helper.c | 18 ++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 491eb514d9..17fb92a213 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -17,6 +17,14 @@ typedef enum TLBRet {
     TLBRET_RI,
     TLBRET_XI,
     TLBRET_PE,
+    TLBRET_HOST_MATCH,
+    TLBRET_HOST_BADADDR,
+    TLBRET_HOST_NOMATCH,
+    TLBRET_HOST_INVALID,
+    TLBRET_HOST_DIRTY,
+    TLBRET_HOST_RI,
+    TLBRET_HOST_XI,
+    TLBRET_HOST_PE,
 } TLBRet;
 
 typedef struct MMUContext {
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 5662b2c49a..33d5e04eb4 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -48,15 +48,24 @@ static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
                                 MMUAccessType access_type, TLBRet tlb_error)
 {
     CPUState *cs = env_cpu(env);
-    CPUSysState *sys = env_sys(env);
+    bool real_guest;
+
+    if (env_vm_level(env) == VM_LEVEL1 && tlb_error > TLBRET_HOST_MATCH) {
+        trigger_vm_exit(env);
+    }
+
+    real_guest = !env->vm_exit && env_vm_level(env);
+    CPUSysState *sys = get_sys(env, real_guest);
 
     switch (tlb_error) {
     default:
     case TLBRET_BADADDR:
+    case TLBRET_HOST_BADADDR:
         cs->exception_index = access_type == MMU_INST_FETCH
                               ? EXCCODE_ADEF : EXCCODE_ADEM;
         break;
     case TLBRET_NOMATCH:
+    case TLBRET_HOST_NOMATCH:
         /* No TLB match for a mapped address */
         if (access_type == MMU_DATA_LOAD) {
             cs->exception_index = EXCCODE_PIL;
@@ -68,6 +77,7 @@ static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
         sys->CSR_TLBRERA = FIELD_DP64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 1);
         break;
     case TLBRET_INVALID:
+    case TLBRET_HOST_INVALID:
         /* TLB match with no valid bit */
         if (access_type == MMU_DATA_LOAD) {
             cs->exception_index = EXCCODE_PIL;
@@ -78,24 +88,28 @@ static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
         }
         break;
     case TLBRET_DIRTY:
+    case TLBRET_HOST_DIRTY:
         /* TLB match but 'D' bit is cleared */
         cs->exception_index = EXCCODE_PME;
         break;
     case TLBRET_XI:
+    case TLBRET_HOST_XI:
         /* Execute-Inhibit Exception */
         cs->exception_index = EXCCODE_PNX;
         break;
     case TLBRET_RI:
+    case TLBRET_HOST_RI:
         /* Read-Inhibit Exception */
         cs->exception_index = EXCCODE_PNR;
         break;
     case TLBRET_PE:
+    case TLBRET_HOST_PE:
         /* Privileged Exception */
         cs->exception_index = EXCCODE_PPI;
         break;
     }
 
-    if (tlb_error == TLBRET_NOMATCH) {
+    if (tlb_error == TLBRET_NOMATCH || tlb_error == TLBRET_HOST_NOMATCH) {
         sys->CSR_TLBRBADV = address;
         if (is_la64(env)) {
             sys->CSR_TLBREHI = FIELD_DP64(sys->CSR_TLBREHI, CSR_TLBREHI_64,
-- 
2.56.0


