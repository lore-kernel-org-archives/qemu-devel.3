Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F308CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 11:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umWI4-0002si-D4; Thu, 14 Aug 2025 07:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1umWHq-0002qH-Mv
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 07:38:27 -0400
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1umWHk-0000wV-5P
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 07:38:26 -0400
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru
 [217.15.195.17]) (Authenticated sender: rastyoginds)
 by air.basealt.ru (Postfix) with ESMTPSA id 47386233B3;
 Thu, 14 Aug 2025 14:38:14 +0300 (MSK)
From: gerben@altlinux.org
To: qemu-devel@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Cc: sdl.qemu@linuxtesting.org
Subject: [PATCH] util/qht: fix possible NULL pointer dereference in
 qht_bucket_remove_entry()
Date: Thu, 14 Aug 2025 14:37:40 +0300
Message-ID: <20250814113807.16146-1-gerben@altlinux.org>
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

If b->pointers[i] is NULL on the first iteration and
prev has not yet been assigned (i.e., is still NULL),
calling qht_entry_move(orig, pos, prev, QHT_BUCKET_ENTRIES - 1)
can lead to a NULL pointer dereference.

The qht_debug_assert(prev) check does not prevent this issue
because QHT_DEBUG is currently disabled (the #define is commented out).

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Reported-by: Alexey Appolonov <alexey@altlinux.org>
Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 util/qht.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/util/qht.c b/util/qht.c
index 92c6b78759..cb7e367ebb 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -768,6 +768,9 @@ static inline void qht_bucket_remove_entry(struct qht_bucket *orig, int pos)
                 return qht_entry_move(orig, pos, b, i - 1);
             }
             qht_debug_assert(prev);
+            if (!prev) {
+                continue;
+            }
             return qht_entry_move(orig, pos, prev, QHT_BUCKET_ENTRIES - 1);
         }
         prev = b;
-- 
2.42.2


