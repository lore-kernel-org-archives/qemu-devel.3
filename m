Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA70EF06E2
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 10:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vp2EG-0004B9-W2; Sun, 08 Feb 2026 05:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vp2EF-0004AT-CM; Sun, 08 Feb 2026 05:41:23 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vp2ED-000774-CE; Sun, 08 Feb 2026 05:41:22 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id B449B8070C;
 Sun, 08 Feb 2026 13:41:18 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:d25::1:35])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id WeNYFo1Apa60-5uzkbhb6; 
 Sun, 08 Feb 2026 13:41:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1770547278;
 bh=x2BACitWrsPLZRV91SG2I0BF2s7UC2JexW9F7xC6lbQ=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=DYCLPQlS42Yh4nrBcjmnpoEEmCzj+6K4gKFeE6jdk4/i4VRoFW3jH1PokLD73pk6A
 9LY7ooWgHBIyQDcYga5VyQTwso4u5DfgLY8/3SZ6HcgkagVpHhn3CSDpu5cTBf1HAS
 USufn/YxdbcMyIG+C+GFBzF8ogQzWSkPrA09fWT0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH v3 1/4] migration/savevm.c: reorder usage and assertion of
 mis->from_src_file
Date: Sun,  8 Feb 2026 15:39:55 +0500
Message-Id: <20260208103958.121455-2-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208103958.121455-1-heifetz@yandex-team.com>
References: <20260208103958.121455-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reorder the code so the assertion of mis->from_src_file occurs before
the call to migration_ioc_unregister_yank_from_file, which dereferences
it in qemu_file_get_ioc.

Fixes: 39675ffffb3394 ("migration: Move the yank unregister of channel_close out")
Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
---
 migration/savevm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 3dc812a7bb..930a3391e3 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2885,13 +2885,14 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
 
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
2.34.1


