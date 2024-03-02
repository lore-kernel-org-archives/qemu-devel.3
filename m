Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AED4C5478C
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 22:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgXxK-0006AF-6x; Sat, 02 Mar 2024 17:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rgXxG-00069P-Jr
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 17:35:42 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rgXxD-0003h0-VG
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 17:35:42 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 9A90CCE0E56;
 Sat,  2 Mar 2024 22:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2884C433C7;
 Sat,  2 Mar 2024 22:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709418929;
 bh=H1D85PsxCikcpBoGzIuPNZM3ookZM27ORgB1MqAcUdI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=st+3lG8HjmKe+ElVac6VIng5HznaQFCP9sZHXUkod+Omg7WnJASBcTR0wBEU5uaV3
 HV6kSIoQ7dBZe5I0Seznf/K67I4dJ7EPFHjyZhN5JlnPSotQq836YvGeTRPLfb2WdU
 62jd4qPbVNezySKHjhchE2/SzSW60nA4UYhuwyUyZjL1bwo9oEsxkZovpOS1mTBnV8
 PixZIhm1kUfgN4zeyfWi7ZuKOb4YPqXKVcrf4cvttBC1myDE2uCEzuYdz5WYei08Hi
 H9a2seoumXAGueyfozyD3XyVoFyzRCOeFUgthxYn71N80A86JCFIyCh4buwjJ0mLh9
 F/6Th0jRfd9JQ==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 2/5] target/hppa: Restore unwind_breg before calculating ior
Date: Sat,  2 Mar 2024 23:35:21 +0100
Message-ID: <20240302223524.24421-3-deller@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240302223524.24421-1-deller@kernel.org>
References: <20240302223524.24421-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.094,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

When calculating the IOR for the exception handlers, the current
unwind_breg value is needed on 64-bit hppa machines.
Restore that value by calling cpu_restore_state() earlier, which in turn
calls hppa_restore_state_to_opc() which restores the unwind_breg for the
current instruction.

Signed-off-by: Helge Deller <deller@gmx.de>
Fixes: 3824e0d643f3 ("target/hppa: Export function hppa_set_ior_and_isr()")
---
 target/hppa/cpu.c        | 3 ++-
 target/hppa/mem_helper.c | 3 ++-
 target/hppa/op_helper.c  | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index afe73d4474..3831cb6db2 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -121,9 +121,10 @@ void hppa_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     CPUHPPAState *env = &cpu->env;
 
     cs->exception_index = EXCP_UNALIGN;
+    cpu_restore_state(cs, retaddr);
     hppa_set_ior_and_isr(env, addr, MMU_IDX_MMU_DISABLED(mmu_idx));
 
-    cpu_loop_exit_restore(cs, retaddr);
+    cpu_loop_exit(cs);
 }
 #endif /* CONFIG_USER_ONLY */
 
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 66b8fa7d72..3fc895c1c2 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -348,9 +348,10 @@ raise_exception_with_ior(CPUHPPAState *env, int excp, uintptr_t retaddr,
     CPUState *cs = env_cpu(env);
 
     cs->exception_index = excp;
+    cpu_restore_state(cs, retaddr);
     hppa_set_ior_and_isr(env, addr, mmu_disabled);
 
-    cpu_loop_exit_restore(cs, retaddr);
+    cpu_loop_exit(cs);
 }
 
 void hppa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index b1f24a5aad..480fe80844 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -351,11 +351,12 @@ target_ulong HELPER(probe)(CPUHPPAState *env, target_ulong addr,
     excp = hppa_get_physical_address(env, addr, mmu_idx, 0, &phys,
                                      &prot, NULL);
     if (excp >= 0) {
+        cpu_restore_state(env_cpu(env), GETPC());
         hppa_set_ior_and_isr(env, addr, MMU_IDX_MMU_DISABLED(mmu_idx));
         if (excp == EXCP_DTLB_MISS) {
             excp = EXCP_NA_DTLB_MISS;
         }
-        hppa_dynamic_excp(env, excp, GETPC());
+        helper_excp(env, excp);
     }
     return (want & prot) != 0;
 #endif
-- 
2.44.0


