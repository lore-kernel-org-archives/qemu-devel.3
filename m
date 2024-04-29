Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62684C19F53
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 07:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1LsD-0005Vw-Id; Mon, 29 Apr 2024 03:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1Ls2-0005Sm-TD
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 03:56:18 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1Lrz-0003Zv-8Z
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 03:56:17 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id CDD5460B58;
 Mon, 29 Apr 2024 10:56:09 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b739::1:30])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id xtKJiB1IWmI0-xgtu59B6; Mon, 29 Apr 2024 10:56:09 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714377369;
 bh=B4lb0xAY50iptOjN0OivH1864Aq3iVwhsMVxS2PuLw4=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=mZvFLBQvVzB9T9NHG2fh+h/GNgdKAPwRRSAKpN/niwuXdnECtMgsCjYPEWDRg3nsA
 5PALwmJosoek4ZTs6KZl7vdxfvXN9I7xqRHLpvkxj3kNdP/Rf+/0lxTd1czsbmXLYp
 xa+HkL9DGtY5VnGxUPWP1sG/mqKDrA9xb4Cydm7g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com,
	farosas@suse.de
Cc: eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v4 2/4] migration: process_incoming_migration_co(): complete
 cleanup on failure
Date: Mon, 29 Apr 2024 10:55:39 +0300
Message-Id: <20240429075541.1959050-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429075541.1959050-1-vsementsov@yandex-team.ru>
References: <20240429075541.1959050-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Make call to migration_incoming_state_destroy(), instead of doing only
partial of it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2dc6a063e9..0d26db47f7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -799,10 +799,7 @@ process_incoming_migration_co(void *opaque)
 fail:
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_FAILED);
-    qemu_fclose(mis->from_src_file);
-
-    multifd_recv_cleanup();
-    compress_threads_load_cleanup();
+    migration_incoming_state_destroy();
 
     exit(EXIT_FAILURE);
 }
-- 
2.34.1


