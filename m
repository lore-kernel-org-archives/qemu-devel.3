Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD8BC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBiB-0005U5-ND; Wed, 14 May 2025 08:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBhu-0004jB-KC; Wed, 14 May 2025 08:59:38 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBhr-0007uT-NX; Wed, 14 May 2025 08:59:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 871D9121AE9;
 Wed, 14 May 2025 15:57:49 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 31FE520B857;
 Wed, 14 May 2025 15:57:59 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Helge Konetzka <hk@zapateado.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [Stable-9.2.4 11/34] tcg: Allocate TEMP_VAL_MEM frame in temp_load()
Date: Wed, 14 May 2025 15:57:33 +0300
Message-Id: <20250514125758.92030-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
References: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Be sure to allocate the temp frame if it wasn't.

In the resolved issues, incomplete dead code elimination left a load
at the top of an unreachable loop.  We simply need to allocate the
stack slot to avoid crashing.

Fixes: c896fe29d6c ("TCG code generator")
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Reported-by: Helge Konetzka <hk@zapateado.de>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2891
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2899
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401144332.41615-1-philmd@linaro.org>
(cherry picked from commit e139bc4b1772575e1f2dcf8e3dbe1df2b684ef1f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 4578b185be..13f735b246 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -4461,6 +4461,9 @@ static void temp_load(TCGContext *s, TCGTemp *ts, TCGRegSet desired_regs,
         ts->mem_coherent = 0;
         break;
     case TEMP_VAL_MEM:
+        if (!ts->mem_allocated) {
+            temp_allocate_frame(s, ts);
+        }
         reg = tcg_reg_alloc(s, desired_regs, allocated_regs,
                             preferred_regs, ts->indirect_base);
         tcg_out_ld(s, ts->type, reg, ts->mem_base->reg, ts->mem_offset);
-- 
2.39.5


