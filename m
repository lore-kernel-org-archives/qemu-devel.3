Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4236AD591AE
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 19:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD7XH-0006ey-1C; Mon, 18 Nov 2024 14:35:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tD7XB-0006dM-QC; Mon, 18 Nov 2024 14:35:41 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tD7X9-0002hg-V1; Mon, 18 Nov 2024 14:35:41 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B1370A54E5;
 Mon, 18 Nov 2024 22:35:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 310691735A2;
 Mon, 18 Nov 2024 22:35:21 +0300 (MSK)
Received: (nullmailer pid 2312691 invoked by uid 1000);
 Mon, 18 Nov 2024 19:35:20 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.8 56/61] tcg: Allow top bit of SIMD_DATA_BITS to be set
 in simd_desc()
Date: Mon, 18 Nov 2024 22:35:11 +0300
Message-Id: <20241118193520.2312620-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.8-20241118211929@cover.tls.msk.ru>
References: <qemu-stable-8.2.8-20241118211929@cover.tls.msk.ru>
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

In simd_desc() we create a SIMD descriptor from various pieces
including an arbitrary data value from the caller.  We try to
sanitize these to make sure everything will fit: the 'data' value
needs to fit in the SIMD_DATA_BITS (== 22) sized field.  However we
do that sanitizing with:
   tcg_debug_assert(data == sextract32(data, 0, SIMD_DATA_BITS));

This works for the case where the data is supposed to be considered
as a signed integer (which can then be returned via simd_data()).
However, some callers want to treat the data value as unsigned.

Specifically, for the Arm SVE operations, make_svemte_desc()
assembles a data value as a collection of fields, and it needs to use
all 22 bits.  Currently if MTE is enabled then its MTEDESC SIZEM1
field may have the most significant bit set, and then it will trip
this assertion.

Loosen the assertion so that we only check that the data value will
fit into the field in some way, either as a signed or as an unsigned
value.  This means we will fail to detect some kinds of bug in the
callers, but we won't spuriously assert for intentional use of the
data field as unsigned.

Cc: qemu-stable@nongnu.org
Fixes: db432672dc50e ("tcg: Add generic vector expanders")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2601
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20241115172515.1229393-1-peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 8377e3fb854d126ba10e61cb6b60885af8443ad4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 566fd6eef7..8117e4fb39 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -88,7 +88,20 @@ uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data)
     uint32_t desc = 0;
 
     check_size_align(oprsz, maxsz, 0);
-    tcg_debug_assert(data == sextract32(data, 0, SIMD_DATA_BITS));
+
+    /*
+     * We want to check that 'data' will fit into SIMD_DATA_BITS.
+     * However, some callers want to treat the data as a signed
+     * value (which they can later get back with simd_data())
+     * and some want to treat it as an unsigned value.
+     * So here we assert only that the data will fit into the
+     * field in at least one way. This means that some invalid
+     * values from the caller will not be detected, e.g. if the
+     * caller wants to handle the value as a signed integer but
+     * incorrectly passes us 1 << (SIMD_DATA_BITS - 1).
+     */
+    tcg_debug_assert(data == sextract32(data, 0, SIMD_DATA_BITS) ||
+                     data == extract32(data, 0, SIMD_DATA_BITS));
 
     oprsz = (oprsz / 8) - 1;
     maxsz = (maxsz / 8) - 1;
-- 
2.39.5


