Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2199CD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 05:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruQnv-0000x8-EA; Wed, 10 Apr 2024 01:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQne-0000bs-KZ; Wed, 10 Apr 2024 01:47:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQnZ-0001xm-Rc; Wed, 10 Apr 2024 01:47:08 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A4AE45D4F6;
 Wed, 10 Apr 2024 08:46:16 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6A097B015D;
 Wed, 10 Apr 2024 08:44:18 +0300 (MSK)
Received: (nullmailer pid 4182092 invoked by uid 1000);
 Wed, 10 Apr 2024 05:44:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 30/41] target/i386: fix direction of "32-bit MMU" test
Date: Wed, 10 Apr 2024 08:43:51 +0300
Message-Id: <20240410054416.4181891-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
References: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Paolo Bonzini <pbonzini@redhat.com>

The low bit of MMU indices for x86 TCG indicates whether the processor is
in 32-bit mode and therefore linear addresses have to be masked to 32 bits.
However, the index was computed incorrectly, leading to possible conflicts
in the TLB for any address above 4G.

Analyzed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Fixes: b1661801c18 ("target/i386: Fix physical address truncation", 2024-02-28)
Fixes: 1c15f97b4f1 ("target/i386: Fix physical address truncation" in stable-7.2)
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2206
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 2cc68629a6fc198f4a972698bdd6477f883aedfb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: move changes for x86_cpu_mmu_index() to cpu_mmu_index() due to missing
 v8.2.0-1030-gace0c5fe59 "target/i386: Populate CPUClass.mmu_index")

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 73eee08f3f..326649ca99 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2201,7 +2201,7 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 
 static inline int cpu_mmu_index(CPUX86State *env, bool ifetch)
 {
-    int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 1 : 0;
+    int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 0 : 1;
     int mmu_index_base =
         (env->hflags & HF_CPL_MASK) == 3 ? MMU_USER64_IDX :
         !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
@@ -2228,7 +2228,7 @@ static inline bool is_mmu_index_32(int mmu_index)
 
 static inline int cpu_mmu_index_kernel(CPUX86State *env)
 {
-    int mmu_index_32 = (env->hflags & HF_LMA_MASK) ? 1 : 0;
+    int mmu_index_32 = (env->hflags & HF_LMA_MASK) ? 0 : 1;
     int mmu_index_base =
         !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
         ((env->hflags & HF_CPL_MASK) < 3 && (env->eflags & AC_MASK)) ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX;
-- 
2.39.2


