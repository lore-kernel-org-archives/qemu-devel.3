Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526B4CFB454
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtHI-0002XC-0p; Mon, 07 Oct 2024 15:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtGK-0007H3-8h; Mon, 07 Oct 2024 15:19:20 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtGI-0004RL-EX; Mon, 07 Oct 2024 15:19:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0760A9625A;
 Mon,  7 Oct 2024 22:16:50 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D281614F73A;
 Mon,  7 Oct 2024 22:16:56 +0300 (MSK)
Received: (nullmailer pid 2592789 invoked by uid 1000);
 Mon, 07 Oct 2024 19:16:54 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ard Biesheuvel <ardb@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.1 29/32] target/arm: Avoid target_ulong for physical
 address lookups
Date: Mon,  7 Oct 2024 22:16:46 +0300
Message-Id: <20241007191654.2592616-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.1-20241007221311@cover.tls.msk.ru>
References: <qemu-stable-9.1.1-20241007221311@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Ard Biesheuvel <ardb@kernel.org>

target_ulong is typedef'ed as a 32-bit integer when building the
qemu-system-arm target, and this is smaller than the size of an
intermediate physical address when LPAE is being used.

Given that Linux may place leaf level user page tables in high memory
when built for LPAE, the kernel will crash with an external abort as
soon as it enters user space when running with more than ~3 GiB of
system RAM.

So replace target_ulong with vaddr in places where it may carry an
address value that is not representable in 32 bits.

Fixes: f3639a64f602ea ("target/arm: Use softmmu tlbs for page table walking")
Cc: qemu-stable@nongnu.org
Reported-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Message-id: 20240927071051.1444768-1-ardb+git@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 67d762e716a7127ecc114e9708254316dd521911)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 203a2dae14..38545552d0 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1430,7 +1430,7 @@ typedef struct GetPhysAddrResult {
  *  * for PSMAv5 based systems we don't bother to return a full FSR format
  *    value.
  */
-bool get_phys_addr(CPUARMState *env, target_ulong address,
+bool get_phys_addr(CPUARMState *env, vaddr address,
                    MMUAccessType access_type, ARMMMUIdx mmu_idx,
                    GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
     __attribute__((nonnull));
@@ -1449,7 +1449,7 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
  * Similar to get_phys_addr, but use the given security space and don't perform
  * a Granule Protection Check on the resulting address.
  */
-bool get_phys_addr_with_space_nogpc(CPUARMState *env, target_ulong address,
+bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
                                     MMUAccessType access_type,
                                     ARMMMUIdx mmu_idx, ARMSecuritySpace space,
                                     GetPhysAddrResult *result,
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 278004661b..26e670290f 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -74,13 +74,13 @@ typedef struct S1Translate {
 } S1Translate;
 
 static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
-                                target_ulong address,
+                                vaddr address,
                                 MMUAccessType access_type,
                                 GetPhysAddrResult *result,
                                 ARMMMUFaultInfo *fi);
 
 static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
-                              target_ulong address,
+                              vaddr address,
                               MMUAccessType access_type,
                               GetPhysAddrResult *result,
                               ARMMMUFaultInfo *fi);
@@ -3202,7 +3202,7 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
  */
 static bool get_phys_addr_disabled(CPUARMState *env,
                                    S1Translate *ptw,
-                                   target_ulong address,
+                                   vaddr address,
                                    MMUAccessType access_type,
                                    GetPhysAddrResult *result,
                                    ARMMMUFaultInfo *fi)
@@ -3285,7 +3285,7 @@ static bool get_phys_addr_disabled(CPUARMState *env,
 }
 
 static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
-                                   target_ulong address,
+                                   vaddr address,
                                    MMUAccessType access_type,
                                    GetPhysAddrResult *result,
                                    ARMMMUFaultInfo *fi)
@@ -3390,7 +3390,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
 }
 
 static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
-                                      target_ulong address,
+                                      vaddr address,
                                       MMUAccessType access_type,
                                       GetPhysAddrResult *result,
                                       ARMMMUFaultInfo *fi)
@@ -3527,7 +3527,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
 }
 
 static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
-                              target_ulong address,
+                              vaddr address,
                               MMUAccessType access_type,
                               GetPhysAddrResult *result,
                               ARMMMUFaultInfo *fi)
@@ -3543,7 +3543,7 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
     return false;
 }
 
-bool get_phys_addr_with_space_nogpc(CPUARMState *env, target_ulong address,
+bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
                                     MMUAccessType access_type,
                                     ARMMMUIdx mmu_idx, ARMSecuritySpace space,
                                     GetPhysAddrResult *result,
@@ -3556,7 +3556,7 @@ bool get_phys_addr_with_space_nogpc(CPUARMState *env, target_ulong address,
     return get_phys_addr_nogpc(env, &ptw, address, access_type, result, fi);
 }
 
-bool get_phys_addr(CPUARMState *env, target_ulong address,
+bool get_phys_addr(CPUARMState *env, vaddr address,
                    MMUAccessType access_type, ARMMMUIdx mmu_idx,
                    GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
 {
-- 
2.39.5


