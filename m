Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED50C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 15:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rez4E-0003Ns-7i; Tue, 27 Feb 2024 10:08:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rez4A-0003KF-Dl; Tue, 27 Feb 2024 10:08:22 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rez45-00081e-SV; Tue, 27 Feb 2024 10:08:22 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D86E24E6138;
 Tue, 27 Feb 2024 16:08:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id P4N3Nwd2V1_z; Tue, 27 Feb 2024 16:08:08 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id F0EF04E6117; Tue, 27 Feb 2024 16:08:08 +0100 (CET)
Message-Id: <dc89f170c6a10b2b5eb479229e80784175f88c97.1709045654.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1709045654.git.balaton@eik.bme.hu>
References: <cover.1709045654.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 08/10] target/ppc: Clean up ifdefs in excp_helper.c, part 2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
Date: Tue, 27 Feb 2024 16:08:08 +0100 (CET)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Remove check for !defined(CONFIG_USER_ONLY) as this is already within
an #ifndef CONFIG_USER_ONLY block.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/excp_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index ba0620ffd1..8160dabd6a 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2614,7 +2614,7 @@ void helper_hrfid(CPUPPCState *env)
 }
 #endif /* TARGET_PPC64 */
 
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+#ifdef TARGET_PPC64
 void helper_rfebb(CPUPPCState *env, target_ulong s)
 {
     target_ulong msr = env->msr;
@@ -2689,7 +2689,7 @@ void raise_ebb_perfm_exception(CPUPPCState *env)
 
     do_ebb(env, POWERPC_EXCP_PERFM_EBB);
 }
-#endif /* defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY) */
+#endif /* TARGET_PPC64 */
 
 /*****************************************************************************/
 /* Embedded PowerPC specific helpers */
-- 
2.30.9


