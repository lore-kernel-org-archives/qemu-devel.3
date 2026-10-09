Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4790CA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF9EM-0004iT-TL; Fri, 09 Oct 2026 07:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1xF9EF-0004fB-NN
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 07:57:35 -0400
Received: from out-179.mta1.migadu.com ([2001:41d0:203:375::b3]
 helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1xF9EC-0001VB-3J
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 07:57:35 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=M+ZtplqIrDauigjFRV3gZedIQhB8KIDGj28jk0eQ/ZY=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791547049; v=1; x=1792151849;
 b=GEwWzBBttIqU/eSld1pZDcN8hmMaoXvwDpl+WA/BQPJiShgyF1YOP3kgWm0Fi2ZUSocWr+qm
 XZ8YnN3gLREaH6wWWWXIe9agMmJfUy1EoiD1RtyM+PwhTWTBT7DKfDxDm5HuoX6l3cARG0XvFgq
 +Ph+RNM3Adiog404caOeB7EM=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id ae2c93e32cc55c61;
 Fri, 09 Oct 2026 11:57:29 +0000
X-Mizu-Trace-ID: ae2c93e32cc55c61
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gromero@redhat.com>,
 Itaru Kitayama <itaru.kitayama@linux.dev>, Will Deacon <will@kernel.org>,
 Fuad Tabba <tabba@google.com>
Subject: [PATCH v3 1/4] target/arm: Clear TTBR[5:0] from a 52-bit table base
 address
Date: Fri,  9 Oct 2026 12:57:25 +0100
Message-Id: <20261009115728.1299384-2-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261009115728.1299384-1-fuad.tabba@linux.dev>
References: <20261009115728.1299384-1-fuad.tabba@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:203:375::b3;
 envelope-from=fuad.tabba@linux.dev; helo=mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reported-by: Itaru Kitayama <itaru.kitayama@linux.dev>
Link: https://lore.kernel.org/kvmarm/B4C0AC3E-6A4F-4A7B-B7BC-81207539115E@linux.dev/
Fixes: 7a928f43d872 ("target/arm: Implement FEAT_LPA")
Cc: qemu-stable@nongnu.org
Reviewed-by: Gustavo Romero <gromero@redhat.com>
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 target/arm/ptw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index de0435a58b..6cff52d592 100644
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
2.39.5


