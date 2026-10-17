Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712CECCF2CF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB6R-000812-Pz; Sat, 17 Oct 2026 16:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB56-00059f-Iw; Sat, 17 Oct 2026 16:32:47 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB52-0004bD-EI; Sat, 17 Oct 2026 16:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268889; bh=VKUnSP4MIXl2/yGJYq9auI1KCGTNRfkDaSvnnfePFpI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fcA/7kZbIRrEL4SxkQpmJriwqgXeAJLqm7R3QpWXirffgMZoRwFdqVXs8Cwahi7Z1
 Ax7WoyMt8pJDfTgCuNNE2c/+PtKT2JzN/YI6oe7nInjnnVfa+rHPTMKX9p9EWJXHTs
 6g5ST2b9CLJk7dgfpXDsdg4X5xYWYpOPs1BD0QzclPLFryBNWr6lNawpFsK1Wl4jkp
 ocKb4uhEVp6LyhhWS9k8md8wP4sjwcqHXiFgd3eq/3JdnBS531vXwMGV/5Rd+YMjq8
 UrnOGPnahFpQHDPKr+vPjcNanMJx+TOwR+V67dhIvI89MxNNxCJrFasBgYBZSEjtP1
 2L2jAQtyztkug==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C6FD41DE77B;
 Sat, 17 Oct 2026 23:28:09 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A636444344E;
 Sat, 17 Oct 2026 23:28:08 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fuad Tabba <fuad.tabba@linux.dev>,
 Gustavo Romero <gromero@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 60/73] target/arm: Use the 52-bit TTBR base address
 layout when TCR.DS is set
Date: Sat, 17 Oct 2026 23:26:18 +0300
Message-ID: <20261017202638.728621-60-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Fuad Tabba <fuad.tabba@linux.dev>

With TCR.DS set, TTBR[5:2] hold bits [51:48] of the translation table
base address, whatever the OA size. If the effective OA size is below
52 bits, setting any of them is a level 0 Address size fault
(AArch64_S1TTBaseAddress(), AArch64_S1Walk()).

get_phys_addr_lpae() uses the 52-bit layout only when the OA size is
over 48 bits. With TCR.DS set and an IPS of 48 bits, it takes TTBR[5:2]
as base address bits [5:2] instead. A guest that sets them gets no
fault: the walk either succeeds with TTBR[5:2] ignored, or reads its
first descriptor from the wrong address. VTTBR walks with VTCR.DS take
the same path.

Use the 52-bit layout whenever TCR.DS is set, and check the whole base
address against the OA size.

Fixes: ef56c2425e5f ("target/arm: Implement FEAT_LPA2")
Cc: qemu-stable@nongnu.org
Reviewed-by: Gustavo Romero <gromero@redhat.com>
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Message-id: 20261009115728.1299384-4-fuad.tabba@linux.dev
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 2c372119465e14f26c094bdcca58e4b1fca84afd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index f1f8f5cdc0..ce256fc87c 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2107,18 +2107,21 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     descaddr = extract64(ttbr, 0, 48);
 
     /*
-     * With a 52-bit OA (FEAT_LPA or FEAT_LPA2), bits [51:48] of descaddr are
-     * in [5:2] of TTBR, and bits [5:0] of the base address are zero: a table
-     * under 64 bytes is still 64-byte aligned (R_KBLCR).
+     * With a 52-bit OA (FEAT_LPA or FEAT_LPA2), or with TCR.DS set at any OA
+     * size, bits [51:48] of descaddr are in [5:2] of TTBR, and bits [5:0] of
+     * the base address are zero: a table under 64 bytes is still 64-byte
+     * aligned (R_KBLCR).
      *
-     * Otherwise, if the base address is out of range, raise AddressSizeFault.
-     * In the pseudocode, this is !IsZero(baseregister<47:outputsize>),
-     * but we've just cleared the bits above 47, so simplify the test.
+     * If the base address is out of range, raise AddressSizeFault.
+     * In the pseudocode, this is !IsZero(address<NUM_PABITS-1:outputsize>)
+     * in AArch64_OAOutOfRange(), but descaddr has no bits set above 51,
+     * so simplify the test.
      */
-    if (outputsize > 48) {
+    if (outputsize > 48 || param.ds) {
         descaddr &= ~MAKE_64BIT_MASK(0, 6);
         descaddr |= extract64(ttbr, 2, 4) << 48;
-    } else if (descaddr >> outputsize) {
+    }
+    if (descaddr >> outputsize) {
         level = 0;
         fi->type = ARMFault_AddressSize;
         goto do_fault;
-- 
2.47.3


