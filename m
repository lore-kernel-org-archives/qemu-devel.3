Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0B8CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 17:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urJb9-00088L-1y; Wed, 27 Aug 2025 13:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urJaD-0006WW-N0; Wed, 27 Aug 2025 13:05:19 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urJa8-0007xe-7w; Wed, 27 Aug 2025 13:05:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D6A2214C72F;
 Wed, 27 Aug 2025 20:03:29 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E878B2698F5;
 Wed, 27 Aug 2025 20:03:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zenghui Yu <zenghui.yu@linux.dev>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.20 13/18] hw/intc/arm_gicv3_kvm: Write all 1's to clear
 enable/active
Date: Wed, 27 Aug 2025 20:03:48 +0300
Message-ID: <20250827170356.2698446-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-7.2.20-20250827180339@cover.tls.msk.ru>
References: <qemu-stable-7.2.20-20250827180339@cover.tls.msk.ru>
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

From: Zenghui Yu <zenghui.yu@linux.dev>

KVM's userspace access interface to the GICD enable and active bits
is via set/clear register pairs which implement the hardware's "write
1s to the clear register to clear the 0 bits, and write 1s to the set
register to set the 1 bits" semantics.  We didn't get this right,
because we were writing 0 to the clear register.

Writing 0 to GICD_IC{ENABLE,ACTIVE}R architecturally has no effect on
interrupt status (all writes are simply ignored by KVM) and doesn't
comply with the intention of "first write to the clear-reg to clear
all bits".

Write all 1's to actually clear the enable/active status.

This didn't have any adverse effects on migration because there
we start with a clean VM state; it would be guest-visible when
doing a system reset, but since Linux always cleans up the
register state of the GIC during bootup before it enables it
most users won't have run into a problem here.

Cc: qemu-stable@nongnu.org
Fixes: 367b9f527bec ("hw/intc/arm_gicv3_kvm: Implement get/put functions")
Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
Message-id: 20250729161650.43758-3-zenghui.yu@linux.dev
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit b10bd4bd17ac8628ede8735a08ad82dc3b721c64)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 3ca643ecba..6d98dafc02 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -294,7 +294,7 @@ static void kvm_dist_putbmp(GICv3State *s, uint32_t offset,
          * the 1 bits.
          */
         if (clroffset != 0) {
-            reg = 0;
+            reg = ~0;
             kvm_gicd_access(s, clroffset, &reg, true);
             clroffset += 4;
         }
-- 
2.47.2


