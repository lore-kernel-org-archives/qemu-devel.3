Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A659DEFCBBB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w226O-0007f6-AV; Mon, 16 Mar 2026 03:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w225k-0007VM-II; Mon, 16 Mar 2026 03:10:25 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w225d-0007kb-MY; Mon, 16 Mar 2026 03:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773645002; bh=vvOQEhgJE84u8KF7BBEN5DfHHC1YU/ts6vzHN7FBIOE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=k7Wk2BptcJYQlSYs9TDogLNS830u3pF/NREVR1szee1fWWAbEWMPu0xLwIdFcBQKp
 o3wgEsPY0slFxdNSfudw+zWIMoqzlk7ycRc64/m0LWdjrgx6vtvPoF3MIwB5Cxiji4
 cjxb/XmRnwKQ2B4v2xuS493wonEcVV3uxMg6CyJrI6SbFxfSK9YzlOaGLZjLUg0WDu
 RVyNHUM3OUFglvJhqaZRYMcwHLNDa3SIWvpU8bC7CwarwKWgK7e++thgrTonQdczby
 hrR40u/Y70/VA9t+ouAogy0k3c/FYcCppERYSXVOeLF/0SeExOK9LMJ9DmLvRducqa
 9Kz7wtAcKcFoA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 82759193C24;
 Mon, 16 Mar 2026 10:10:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 806E038004C;
 Mon, 16 Mar 2026 10:10:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Sergei Heifetz <heifetz@yandex-team.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 02/14] migration/savevm.c: reorder usage and assertion of
 mis->from_src_file
Date: Mon, 16 Mar 2026 10:09:50 +0300
Message-ID: <20260316071005.91624-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316071005.91624-1-mjt@tls.msk.ru>
References: <20260316071005.91624-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Sergei Heifetz <heifetz@yandex-team.com>

Reorder the code so the assertion of mis->from_src_file occurs before
the call to migration_ioc_unregister_yank_from_file, which dereferences
it in qemu_file_get_ioc.

Fixes: 39675ffffb3394 ("migration: Move the yank unregister of channel_close out")
Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 migration/savevm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 197c89e0e6..dd58f2a705 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2875,13 +2875,14 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
 
     assert(migrate_postcopy_ram());
 
+    assert(mis->from_src_file);
+
     /*
      * Unregister yank with either from/to src would work, since ioc behind it
      * is the same
      */
     migration_ioc_unregister_yank_from_file(mis->from_src_file);
 
-    assert(mis->from_src_file);
     qemu_file_shutdown(mis->from_src_file);
     qemu_fclose(mis->from_src_file);
     mis->from_src_file = NULL;
-- 
2.47.3


