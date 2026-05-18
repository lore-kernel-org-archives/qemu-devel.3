Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251A2CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 10:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOvaK-0003qI-8p; Mon, 18 May 2026 06:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wOvaD-0003pX-Is
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:52:27 -0400
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wOva9-0000tg-9G
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1779101528; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=tYd/FuZSv5qtUD4kEa/eP6UgqMgevIiY56njdGnB7yo=;
 b=w/oNBwaaQg3pgk1NtS6IGkaIEwd7KBr0GV1AG7ma1mptBMA23eLlW/MddnA8mnQZRuTuVkiS0mGDJqlF4SJ8ECoOgggV95QPElyAr7vlCV2MpmKfj4AwdvQPpiWm32PCcrtVBlau4PVzOk1IO/JTR0ExekA9F+ROj9NO0QXXhAQ=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0X37cuKt_1779101522; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X37cuKt_1779101522 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 18 May 2026 18:52:07 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH 1/8] migration/fd: collapse migration_fd_valid into single
 boolean expression
Date: Mon, 18 May 2026 18:51:48 +0800
Message-ID: <20260518105156.17626-2-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260518105156.17626-1-guobin@linux.alibaba.com>
References: <20260518105156.17626-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
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

Two if/return-true blocks followed by a final return false
are equivalent to a single OR-expression and easier to scan.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 migration/fd.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/migration/fd.c b/migration/fd.c
index f05f95992f..939cdda4e1 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -39,15 +39,7 @@ static bool fd_is_pipe(int fd)
 
 static bool migration_fd_valid(int fd)
 {
-    if (fd_is_socket(fd)) {
-        return true;
-    }
-
-    if (fd_is_pipe(fd)) {
-        return true;
-    }
-
-    return false;
+    return fd_is_socket(fd) || fd_is_pipe(fd);
 }
 
 QIOChannel *fd_connect_outgoing(MigrationState *s, const char *fdname,
-- 
2.50.1 (Apple Git-155)


