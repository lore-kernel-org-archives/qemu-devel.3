Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65273C25B4F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 23:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Iby-0001Hi-0U; Sun, 12 May 2024 19:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Ibw-0001HP-US; Sun, 12 May 2024 19:28:08 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Ibv-0000Mp-Ao; Sun, 12 May 2024 19:28:08 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DB0694E65C5;
 Mon, 13 May 2024 01:28:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id iFFvdilWfok2; Mon, 13 May 2024 01:28:03 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id ECEBB4E6543; Mon, 13 May 2024 01:28:03 +0200 (CEST)
Message-Id: <180f806e61e0cb25903b359e33276f0b4c6aa26b.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715555763.git.balaton@eik.bme.hu>
References: <cover.1715555763.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 30/61] target/ppc: Split off common embedded TLB init
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 13 May 2024 01:28:03 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Several 4xx CPUs and e200 share the same TLB settings enclosed in an
ifdef. Split it off in a common function to reduce code duplication
and the number of ifdefs.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 46 ++++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 07ad788e54..92c71b2a09 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2107,18 +2107,22 @@ static int check_pow_hid0_74xx(CPUPPCState *env)
     return 0;
 }
 
+static void init_tlbs_emb(CPUPPCState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    env->nb_tlb = 64;
+    env->nb_ways = 1;
+    env->tlb_type = TLB_EMB;
+#endif
+}
+
 static void init_proc_405(CPUPPCState *env)
 {
     register_40x_sprs(env);
     register_405_sprs(env);
     register_usprgh_sprs(env);
 
-    /* Memory management */
-#if !defined(CONFIG_USER_ONLY)
-    env->nb_tlb = 64;
-    env->nb_ways = 1;
-    env->tlb_type = TLB_EMB;
-#endif
+    init_tlbs_emb(env);
     init_excp_4xx(env);
     env->dcache_line_size = 32;
     env->icache_line_size = 32;
@@ -2185,12 +2189,8 @@ static void init_proc_440EP(CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
                  0x00000000);
-    /* Memory management */
-#if !defined(CONFIG_USER_ONLY)
-    env->nb_tlb = 64;
-    env->nb_ways = 1;
-    env->tlb_type = TLB_EMB;
-#endif
+
+    init_tlbs_emb(env);
     init_excp_BookE(env);
     env->dcache_line_size = 32;
     env->icache_line_size = 32;
@@ -2282,12 +2282,7 @@ static void init_proc_440GP(CPUPPCState *env)
     register_440_sprs(env);
     register_usprgh_sprs(env);
 
-    /* Memory management */
-#if !defined(CONFIG_USER_ONLY)
-    env->nb_tlb = 64;
-    env->nb_ways = 1;
-    env->tlb_type = TLB_EMB;
-#endif
+    init_tlbs_emb(env);
     init_excp_BookE(env);
     env->dcache_line_size = 32;
     env->icache_line_size = 32;
@@ -2355,12 +2350,8 @@ static void init_proc_440x5(CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
                  0x00000000);
-    /* Memory management */
-#if !defined(CONFIG_USER_ONLY)
-    env->nb_tlb = 64;
-    env->nb_ways = 1;
-    env->tlb_type = TLB_EMB;
-#endif
+
+    init_tlbs_emb(env);
     init_excp_BookE(env);
     env->dcache_line_size = 32;
     env->icache_line_size = 32;
@@ -2717,11 +2708,8 @@ static void init_proc_e200(CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
                  0x00000000);
-#if !defined(CONFIG_USER_ONLY)
-    env->nb_tlb = 64;
-    env->nb_ways = 1;
-    env->tlb_type = TLB_EMB;
-#endif
+
+    init_tlbs_emb(env);
     init_excp_e200(env, 0xFFFF0000UL);
     env->dcache_line_size = 32;
     env->icache_line_size = 32;
-- 
2.30.9


