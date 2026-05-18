Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30DACD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 11:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOvj0-0006ad-FK; Mon, 18 May 2026 07:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wOviy-0006Za-1D
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:01:28 -0400
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wOviu-0005iO-5E
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1779102078; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=/Hf9bNk5euKjuZd4SN8a7/rLYdpLWK+prrB/RupffPk=;
 b=uFndEFNu9MfosrdLoTNwjdDueA4IGJ2L2kWcANcZb6WMK730m0nIqqL3AThgc2dTAIGPLy3rvOA950VIB3m2voiKNPwY0bU/6swyhKDK5P6Xd23aMMhM9tQTcxDzllzd+KzKd6E3+zAiflQKSg+YExdHxBV75np61iDL5bRqbjI=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0X382z.a_1779102076; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X382z.a_1779102076 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 18 May 2026 19:01:16 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH 4/8] migration/savevm: use stack-allocated bitmap in
 configuration_validate_capabilities
Date: Mon, 18 May 2026 19:01:08 +0800
Message-ID: <20260518110112.21395-5-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260518110112.21395-1-guobin@linux.alibaba.com>
References: <20260518110112.21395-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

configuration_validate_capabilities() allocates a bitmap on the heap
to track source capabilities via bitmap_new()/g_free().  Since
MIGRATION_CAPABILITY__MAX is a small compile-time constant (< 64),
a heap allocation for a bitmap this small is wasteful: it adds
malloc/free overhead and a potential cache miss for a transient
8-byte allocation.

Replace with DECLARE_BITMAP() on the stack and bitmap_zero() to
initialize.  This eliminates the heap round-trip entirely.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 migration/savevm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index d1dd696c17..23adaf9dd9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -347,10 +347,10 @@ static bool configuration_validate_capabilities(SaveState *state)
 {
     bool ret = true;
     MigrationState *s = migrate_get_current();
-    unsigned long *source_caps_bm;
+    DECLARE_BITMAP(source_caps_bm, MIGRATION_CAPABILITY__MAX);
     int i;
 
-    source_caps_bm = bitmap_new(MIGRATION_CAPABILITY__MAX);
+    bitmap_zero(source_caps_bm, MIGRATION_CAPABILITY__MAX);
     for (i = 0; i < state->caps_count; i++) {
         MigrationCapability capability = state->capabilities[i];
         set_bit(capability, source_caps_bm);
@@ -373,7 +373,6 @@ static bool configuration_validate_capabilities(SaveState *state)
         }
     }
 
-    g_free(source_caps_bm);
     return ret;
 }
 
-- 
2.50.1 (Apple Git-155)


