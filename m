Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B83CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 08:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v23Xp-0006y1-6F; Fri, 26 Sep 2025 04:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23Xm-0006x5-Eb; Fri, 26 Sep 2025 04:11:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23Xg-00008z-NL; Fri, 26 Sep 2025 04:11:05 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CE001157D4A;
 Fri, 26 Sep 2025 11:10:30 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E2AA9290C2E;
 Fri, 26 Sep 2025 11:10:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zero Tang <zero.tangptr@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 02/60] i386/tcg/svm: fix incorrect canonicalization
Date: Fri, 26 Sep 2025 11:09:30 +0300
Message-ID: <20250926081031.2214971-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Zero Tang <zero.tangptr@gmail.com>

For all 32-bit systems and 64-bit Windows systems, "long" is 4 bytes long.
Due to using "long" for a linear address, svm_canonicalization would
set all high bits to 1 when (assuming 48-bit linear address) the segment
base is bigger than 0x7FFF.

This fixes booting guests under TCG when the guest IDT and GDT bases are
above 0x7FFF, thereby resulting in incorrect bases. When an interrupt
arrives, it would trigger a #PF exception; the #PF would trigger again,
resulting in a #DF exception; the #PF would trigger for the third time,
resulting in triple-fault, and eventually causes a shutdown VM-Exit to
the hypervisor right after guest boot.

Cc: qemu-stable@nongnu.org
Signed-off-by: Zero Tang <zero.tangptr@gmail.com>
(cherry picked from commit c12cbaa007c9da97a11e74119ea3aed9fcc3ac4c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/system/svm_helper.c
index b27049b9ed..dea039b87a 100644
--- a/target/i386/tcg/system/svm_helper.c
+++ b/target/i386/tcg/system/svm_helper.c
@@ -49,7 +49,7 @@ static void svm_save_seg(CPUX86State *env, int mmu_idx, hwaddr addr,
 static inline void svm_canonicalization(CPUX86State *env, target_ulong *seg_base)
 {
     uint16_t shift_amt = 64 - cpu_x86_virtual_addr_width(env);
-    *seg_base = ((((long) *seg_base) << shift_amt) >> shift_amt);
+    *seg_base = (((int64_t) *seg_base) << shift_amt) >> shift_amt;
 }
 
 static void svm_load_seg(CPUX86State *env, int mmu_idx, hwaddr addr,
-- 
2.47.3


