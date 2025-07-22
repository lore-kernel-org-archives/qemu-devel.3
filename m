Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F02C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 11:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueB2C-0004P7-2H; Tue, 22 Jul 2025 07:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1ueB1q-00049C-Bd
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 07:19:26 -0400
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1ueB1n-0004bp-Pi
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 07:19:25 -0400
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru
 [217.15.195.17]) (Authenticated sender: rastyoginds)
 by air.basealt.ru (Postfix) with ESMTPSA id 8FA3E23395;
 Tue, 22 Jul 2025 14:19:19 +0300 (MSK)
From: gerben@altlinux.org
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Subject: [PATCH] hw/display: refine upper limit for offset value in assert
 check
Date: Tue, 22 Jul 2025 14:17:47 +0300
Message-ID: <20250722111917.19584-1-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=gerben@altlinux.org;
 helo=air.basealt.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Denis Rastyogin <gerben@altlinux.org>

Accessing s->core_registers (size 236) could overflow
if the offset goes beyond the valid range.

Since the memory region matches core_registers size exactly,
guest cannot write out-of-bounds.

Therefore, the debug assert has been refined to ensure the offset
remains within DP_CORE_REG_ARRAY_SIZE, preventing internal errors.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Reported-by: David Meliksetyan <d.meliksetyan@fobos-nt.ru>
Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 hw/display/xlnx_dp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 7c980ee642..b35ee2f869 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -896,7 +896,11 @@ static void xlnx_dp_write(void *opaque, hwaddr offset, uint64_t value,
         xlnx_dp_update_irq(s);
         break;
     default:
-        assert(offset <= (0x504C >> 2));
+        /*
+         * Check to ensure the offset is within the bounds of
+         * the core_registers[] array.
+         */
+        assert(offset < DP_CORE_REG_ARRAY_SIZE);
         s->core_registers[offset] = value;
         break;
     }
-- 
2.42.2


