Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF735C83F25
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 10:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueA5X-0004YU-Vk; Tue, 22 Jul 2025 06:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1ueA5T-0004S4-W0
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 06:19:09 -0400
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1ueA5R-0000ZD-W0
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 06:19:07 -0400
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru
 [217.15.195.17]) (Authenticated sender: rastyoginds)
 by air.basealt.ru (Postfix) with ESMTPSA id 6556023392;
 Tue, 22 Jul 2025 13:19:04 +0300 (MSK)
From: gerben@altlinux.org
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: sdl.qemu@linuxtesting.org
Subject: [PATCH] target/hppa: prevent overflow in BTLB entry size calculation
Date: Tue, 22 Jul 2025 13:18:52 +0300
Message-ID: <20250722101902.16613-1-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=gerben@altlinux.org;
 helo=air.basealt.ru
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

From: Denis Rastyogin <gerben@altlinux.org>

Cast len to long long before multiplying by TARGET_PAGE_SIZE
when calculating btlb->itree.last to ensure 64-bit arithmetic
and avoid potential overflow.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 target/hppa/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 9bdd0a6f23..0c196b5bfc 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -766,7 +766,7 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
 
             /* Create new BTLB entry */
             btlb->itree.start = virt_page << TARGET_PAGE_BITS;
-            btlb->itree.last = btlb->itree.start + len * TARGET_PAGE_SIZE - 1;
+            btlb->itree.last = btlb->itree.start + (long long) len * TARGET_PAGE_SIZE - 1;
             btlb->pa = phys_page << TARGET_PAGE_BITS;
             set_access_bits_pa11(env, btlb, env->gr[20]);
             btlb->t = 0;
-- 
2.42.2


