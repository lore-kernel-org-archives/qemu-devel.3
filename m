Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AC2CA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF9EK-0004hn-A3; Fri, 09 Oct 2026 07:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1xF9EH-0004gF-H8
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 07:57:38 -0400
Received: from out-56.mta0.migadu.com ([2001:41d0:1004:224b::38]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1xF9EF-0001XC-Py
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 07:57:37 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=yOq/SAR2JwAJ7inL7GzZiSIF1VKEwUj39XzwFDpcgf8=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791547053; v=1; x=1792151853;
 b=dK4Y3JQLNOQZOH+kdzpal5ypWhVKkX2RQbovEX8AcEoIuTu2zXobUthsw6cQZUqlq+0u3Nmt
 eJYbyWBkza2iqSfZ56Rqcy9sSMRvQrbpcPIJxxJ1nmw8oUdagyD72b7xgySAiowyabsXN2vGAqg
 QPGBP/xE2D2WY0UUfvLeOS/U=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id c5a0742f418a80cf;
 Fri, 09 Oct 2026 11:57:33 +0000
X-Mizu-Trace-ID: c5a0742f418a80cf
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gromero@redhat.com>,
 Itaru Kitayama <itaru.kitayama@linux.dev>, Will Deacon <will@kernel.org>,
 Fuad Tabba <tabba@google.com>
Subject: [PATCH v3 3/4] target/arm: Use the 52-bit TTBR base address layout
 when TCR.DS is set
Date: Fri,  9 Oct 2026 12:57:27 +0100
Message-Id: <20261009115728.1299384-4-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261009115728.1299384-1-fuad.tabba@linux.dev>
References: <20261009115728.1299384-1-fuad.tabba@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::38;
 envelope-from=fuad.tabba@linux.dev; helo=mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
---
 target/arm/ptw.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 6cff52d592..2e67d02493 100644
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
2.39.5


