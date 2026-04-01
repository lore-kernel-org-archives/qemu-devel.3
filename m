Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EC7D35166
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 10:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7sNN-0005Wg-V5; Wed, 01 Apr 2026 06:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1w7sNJ-0005UQ-Nh
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 06:00:38 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1w7sNC-0001vh-Ux
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 06:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1775037613; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=9bFZlLNwTFbooIfTwwN58QYLgiJuJrKDiz3NLMytJF0=;
 b=VgRbRPxO7D//UFgY8pl1nRm3K2Lb1mT5PJM7CLsEDufQUJqKORXqGQIJJRhEerk3hOryKproITlAI6jlH9JuluI0ubh2En81WtMpHjcIZhaS/UeAS5EvNiEO7euhHzJeqMrj51OPUW0BuEh1rkpib8R9ejDAj17eFj33LPaWzU0=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R351e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0X0AcEy1_1775037605; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X0AcEy1_1775037605 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 01 Apr 2026 18:00:12 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, richard.henderson@linaro.org, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [PATCH] physmem: Simplify dirty memory type checks with loop
Date: Wed,  1 Apr 2026 18:00:05 +0800
Message-ID: <20260401100005.20651-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
X-Spam_score_int: -154
X-Spam_score: -15.5
X-Spam_bar: ---------------
X-Spam_report: (-15.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

In physical_memory_range_includes_clean(), we have three nearly identical
if-statements checking different DIRTY_MEMORY types (VGA, CODE, MIGRATION).
This code duplication makes maintenance harder and increases the risk of
inconsistencies when adding new dirty memory types.

Replace the repetitive checks with a simple loop that iterates through
all DIRTY_MEMORY_NUM types, checking only those specified in the mask.
This reduces code size and makes it easier to add new dirty memory types
in the future.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 system/physmem.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 4e26f1a1d4..c58d940e80 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -981,17 +981,11 @@ uint8_t physical_memory_range_includes_clean(ram_addr_t start,
 {
     uint8_t ret = 0;
 
-    if (mask & (1 << DIRTY_MEMORY_VGA) &&
-        !physical_memory_all_dirty(start, length, DIRTY_MEMORY_VGA)) {
-        ret |= (1 << DIRTY_MEMORY_VGA);
-    }
-    if (mask & (1 << DIRTY_MEMORY_CODE) &&
-        !physical_memory_all_dirty(start, length, DIRTY_MEMORY_CODE)) {
-        ret |= (1 << DIRTY_MEMORY_CODE);
-    }
-    if (mask & (1 << DIRTY_MEMORY_MIGRATION) &&
-        !physical_memory_all_dirty(start, length, DIRTY_MEMORY_MIGRATION)) {
-        ret |= (1 << DIRTY_MEMORY_MIGRATION);
+    for (int i = 0; i < DIRTY_MEMORY_NUM; i++) {
+        if ((mask & (1 << i)) &&
+            !physical_memory_all_dirty(start, length, i)) {
+            ret |= (1 << i);
+        }
     }
     return ret;
 }
-- 
2.50.1 (Apple Git-155)


