Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26818D5E368
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kTs-0005jZ-Gy; Sat, 09 Nov 2024 07:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kSQ-0003wD-E2; Sat, 09 Nov 2024 07:20:52 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kSO-0005rW-7y; Sat, 09 Nov 2024 07:20:50 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3062DA1660;
 Sat,  9 Nov 2024 15:08:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E082F167FE6;
 Sat,  9 Nov 2024 15:09:04 +0300 (MSK)
Received: (nullmailer pid 3296295 invoked by uid 1000);
 Sat, 09 Nov 2024 12:09:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 54/58] target/arm: Fix SVE SDOT/UDOT/USDOT (4-way,
 indexed)
Date: Sat,  9 Nov 2024 15:08:55 +0300
Message-Id: <20241109120901.3295995-54-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Peter Maydell <peter.maydell@linaro.org>

Our implementation of the indexed version of SVE SDOT/UDOT/USDOT got
the calculation of the inner loop terminator wrong.  Although we
correctly account for the element size when we calculate the
terminator for the first iteration:
   intptr_t segend = MIN(16 / sizeof(TYPED), opr_sz_n);
we don't do that when we move it forward after the first inner loop
completes.  The intention is that we process the vector in 128-bit
segments, which for a 64-bit element size should mean (1, 2), (3, 4),
(5, 6), etc.  This bug meant that we would iterate (1, 2), (3, 4, 5,
6), (7, 8, 9, 10) etc and apply the wrong indexed element to some of
the operations, and also index off the end of the vector.

You don't see this bug if the vector length is small enough that we
don't need to iterate the outer loop, i.e.  if it is only 128 bits,
or if it is the 64-bit special case from AA32/AA64 AdvSIMD.  If the
vector length is 256 bits then we calculate the right results for the
elements in the vector but do index off the end of the vector. Vector
lengths greater than 256 bits see wrong answers. The instructions
that produce 32-bit results behave correctly.

Fix the recalculation of 'segend' for subsequent iterations, and
restore a version of the comment that was lost in the refactor of
commit 7020ffd656a5 that explains why we only need to clamp segend to
opr_sz_n for the first iteration, not the later ones.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2595
Fixes: 7020ffd656a5 ("target/arm: Macroize helper_gvec_{s,u}dot_idx_{b,h}")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241101185544.2130972-1-peter.maydell@linaro.org
(cherry picked from commit e6b2fa1b81ac6b05c4397237c846a295a9857920)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 98604d170f..7cbd1b0f43 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -836,6 +836,13 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)  \
 {                                                                         \
     intptr_t i = 0, opr_sz = simd_oprsz(desc);                            \
     intptr_t opr_sz_n = opr_sz / sizeof(TYPED);                           \
+    /*                                                                    \
+     * Special case: opr_sz == 8 from AA64/AA32 advsimd means the         \
+     * first iteration might not be a full 16 byte segment. But           \
+     * for vector lengths beyond that this must be SVE and we know        \
+     * opr_sz is a multiple of 16, so we need not clamp segend            \
+     * to opr_sz_n when we advance it at the end of the loop.             \
+     */                                                                   \
     intptr_t segend = MIN(16 / sizeof(TYPED), opr_sz_n);                  \
     intptr_t index = simd_data(desc);                                     \
     TYPED *d = vd, *a = va;                                               \
@@ -853,7 +860,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)  \
                     n[i * 4 + 2] * m2 +                                   \
                     n[i * 4 + 3] * m3);                                   \
         } while (++i < segend);                                           \
-        segend = i + 4;                                                   \
+        segend = i + (16 / sizeof(TYPED));                                \
     } while (i < opr_sz_n);                                               \
     clear_tail(d, opr_sz, simd_maxsz(desc));                              \
 }
-- 
2.39.5


