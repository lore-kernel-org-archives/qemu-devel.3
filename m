Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24A7CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB6j-0000Pv-8U; Sat, 17 Oct 2026 16:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB51-00054e-1P; Sat, 17 Oct 2026 16:32:43 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB4y-0004Zq-DR; Sat, 17 Oct 2026 16:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268887; bh=L9B8d1Hu+c8ihlJHBjp15OqI98nKpqYwbkty3L3XrcM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=p6nX8FLkgPh/uqSZR28sszpXRkhWmqNg9OqvfgOXfrsIzU9PyLkCYN4Dp2WrSRHgN
 KaL6Xo0yPfvvrEayEeG9bmk2CDzIgciO3QMhKNCHOLy6aVR4a1cMpnh5BgNMvveGCO
 aCOa+vasKYITq0nmOshHHx2x+WxYvgqOKUzAPXaXKHVdi+RpXzXWIv2kBMh7wGMG6b
 3228FkobIRbk8crGOju/9J35pmzMsXxVq9QIrRNf4jy38Tqdh1/9STkiislAIfJ/h+
 40jlkgEJIwn8VJIUDeHLLj+x7u5pkuC+OyiVCfg6HsVM9npIX3SkE2sama+ZB4SNWB
 3z84pS9LNU+4g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 430C61DE779;
 Sat, 17 Oct 2026 23:28:07 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 50C6544344C;
 Sat, 17 Oct 2026 23:28:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fuad Tabba <fuad.tabba@linux.dev>,
 Itaru Kitayama <itaru.kitayama@linux.dev>,
 Gustavo Romero <gromero@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 58/73] target/arm: Clear TTBR[5:0] from a 52-bit table
 base address
Date: Sat, 17 Oct 2026 23:26:16 +0300
Message-ID: <20261017202638.728621-58-mjt@tls.msk.ru>
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

get_phys_addr_lpae() can read the first descriptor of a walk from the
wrong address. This happens with a 52-bit OA when the initial lookup
table has fewer than eight entries and its base address has bit 51 set,
or bit 50 for a two-entry table. The walk then faults or translates
through whatever that address holds. VTTBR walks for stage 2 take the
same path.

For example, the 16KB granule with a 48-bit VA has a two-entry level 0
(FEAT_LPA2). The 64KB granule with a 44-bit VA has a four-entry level 1
(FEAT_LPA). KVM's page_fault_test hangs on this in its 16KB, 52-bit PA
guest mode under TCG, as reported on kvmarm.

With a 52-bit OA, TTBR[5:2] hold bits [51:48] of the base address. Such
a table is 64-byte aligned (R_KBLCR), so bits [5:0] of the base address
are zero. get_phys_addr_lpae() ORs TTBR[5:2] into bits [51:48], but
then clears only the bits in indexmask. For these tables indexmask
covers fewer than six bits, so TTBR[5] stays in the address, and
TTBR[4] too for a two-entry table.

Clear TTBR[5:0] when forming a 52-bit table base address.

Cc: qemu-stable@nongnu.org
Fixes: 7a928f43d872 ("target/arm: Implement FEAT_LPA")
Reported-by: Itaru Kitayama <itaru.kitayama@linux.dev>
Reviewed-by: Gustavo Romero <gromero@redhat.com>
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Message-id: 20261009115728.1299384-2-fuad.tabba@linux.dev
Link: https://lore.kernel.org/kvmarm/B4C0AC3E-6A4F-4A7B-B7BC-81207539115E@linux.dev/
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 0dedeff9328d4d458dc849176e9bd4582b2b2bd8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 663a4862a4..f1f8f5cdc0 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2107,13 +2107,16 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     descaddr = extract64(ttbr, 0, 48);
 
     /*
-     * For FEAT_LPA and PS=6, bits [51:48] of descaddr are in [5:2] of TTBR.
+     * With a 52-bit OA (FEAT_LPA or FEAT_LPA2), bits [51:48] of descaddr are
+     * in [5:2] of TTBR, and bits [5:0] of the base address are zero: a table
+     * under 64 bytes is still 64-byte aligned (R_KBLCR).
      *
      * Otherwise, if the base address is out of range, raise AddressSizeFault.
      * In the pseudocode, this is !IsZero(baseregister<47:outputsize>),
      * but we've just cleared the bits above 47, so simplify the test.
      */
     if (outputsize > 48) {
+        descaddr &= ~MAKE_64BIT_MASK(0, 6);
         descaddr |= extract64(ttbr, 2, 4) << 48;
     } else if (descaddr >> outputsize) {
         level = 0;
-- 
2.47.3


