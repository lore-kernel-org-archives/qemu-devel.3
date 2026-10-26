Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A3D606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=iBHr86wm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLCn-0000R5-V1; Mon, 26 Oct 2026 09:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLC4-0007Ez-IO; Mon, 26 Oct 2026 09:57:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLBv-0000HV-MO; Mon, 26 Oct 2026 09:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022904; bh=0lSL56TUdH247uqbKpOd3hHtWR/nmwNwDxrOIgUBUYg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iBHr86wmMHTGZtjkHEZlk4LwonHgeUDGG6xjbbDYJLf5LTTvzY1jQvqqh9uTfsdwB
 yrLZr/C7U3VOA5gh/HxzhvNOyk76td6fJqJsUkNh461I2wspxep0/UBwsOR3kid5eu
 tOhymYmxchYLOSRUi0Vej4eqK0ZLhNdwsviMHiPkc4ETD8mzmMBtLh6Cb1DNRp4nzT
 v/4OQI46SNXV1J12ISE4vohrDbLaLkn54y3oM1rwXveGZtPx/z0tBcrvFywhfaDsC/
 3pV/KSebCfBwXGk3PbFc5wK9ROl1h9oXHNLbBi8BVn9HIrRxr/Oofv+0oxwZe+qGN/
 6fEOf4ZBTvnwg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 004341E1290;
 Mon, 26 Oct 2026 16:55:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id F20BE44B8DD;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C3E85934AF; Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 v2 90/91] hw/intc/exynos4210_combiner: Fix group
 register range check
Date: Mon, 26 Oct 2026 16:54:33 +0300
Message-ID: <20261026135441.1019505-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

The exynos4210 combiner has registers arranged in sets of 4:
 offset 0x0: IIESR0 (handles interrupt groups 0..3)
 offset 0x4: IIECR0
 offset 0x8: IISTR0
 offset 0xc: IIMSR0
 offset 0x10: IIESR1 (handles interrupt groups 4..7)
 offset 0x14: IIECR1

and so on for a total of 16 sets of registers, which puts the final
IIMSR15 at offset 0xfc.  After that come two registers which aren't
grouped, ICIPSR0 at 0x100 and ICIPSR1 at 0x104.  The entire register
memory region is thus 0x108 bytes.

The logic which separates out the "offset is in one of the sets of
registers" from "offset is one of the ICIPSRn registers" is
incorrect, and so a write to offset 0x10448100 (which should be
ICIPSR0) falls through into the code for handling accesses to a set
of registers, and indexes off the end of the s->group[] array.

For an input offset of, say, 0x3C, req_quad_base_n is 0x3, because
this is in the 3rd set of registers.  grp_quad_base_n is then 0xC,
because this set of registers handles interrupt groups 12..15, and we
will index s->group[] with grp_quad_base_n through to grp_quad_base_n
+ 3.  IIC_NGRP is the size of the group[] array, and so we need to
check grp_quad_base_n against it, not req_quad_base_n.

Fix the bounds check, and add an assertion that the code path
where we are beyond the register-set range isn't going to
overrun its array, which we know to be true because of the
size used for the MemoryRegion.

Cc: qemu-stable@nongnu.org
Fixes: 8e03cf1eeb1f9e0 ("ARM: exynos4210: IRQ subsystem support.")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4709
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20261019162217.3272337-2-peter.maydell@linaro.org
(cherry picked from commit ab6579bf73b5ffb7f2e9d1c28c1e6c1d9fccd5ed)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index af0b408a886..b57b2341b77 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -91,8 +91,9 @@ exynos4210_combiner_read(void *opaque, hwaddr offset, unsigned size)
     grp_quad_base_n = req_quad_base_n << 2;
     reg_n = (offset - (req_quad_base_n << 4)) >> 2;
 
-    if (req_quad_base_n >= IIC_NGRP) {
-        /* Read of ICIPSR register */
+    if (grp_quad_base_n >= IIC_NGRP) {
+        /* Read of ICIPSR register. MR size ensures this must be in bounds */
+        assert(reg_n < ARRAY_SIZE(s->icipsr));
         return s->icipsr[reg_n];
     }
 
@@ -184,7 +185,7 @@ static void exynos4210_combiner_write(void *opaque, hwaddr offset,
     grp_quad_base_n = req_quad_base_n << 2;
     reg_n = (offset - (req_quad_base_n << 4)) >> 2;
 
-    if (req_quad_base_n >= IIC_NGRP) {
+    if (grp_quad_base_n >= IIC_NGRP) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "exynos4210.combiner: unallowed write access at offset 0x"
                       HWADDR_FMT_plx "\n", offset);
-- 
2.47.3


