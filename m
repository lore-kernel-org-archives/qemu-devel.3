Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFFA106289F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 13:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0JPc-0000ow-In; Wed, 11 Mar 2026 09:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w0JPR-0000mo-Bm; Wed, 11 Mar 2026 09:15:33 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w0JPN-0000Mb-Gf; Wed, 11 Mar 2026 09:15:33 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 156A580606;
 Wed, 11 Mar 2026 16:15:25 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:d28::1:5])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id MFGaO30AdeA0-WCu8oipK; Wed, 11 Mar 2026 16:15:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1773234924;
 bh=aib1BAh5M0/WVaVVuWFg17CTYoL9n/LthhkUS9jzeSU=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=VNFO+oW8qUqstjz8iawyeIUPsWLxQ9qgZUSfuDp0wHLBSDHKlcGAmcbbodSQeTvwp
 SC5xvDIWTUNV+CoRjOVvK/AUQC4X/3I10UwmE4ocVFgVcWQXnNn7nRtX47Ghcu9FFT
 2a3D43cyXKVsfXJGjvnJUQ8ATiYyUciOQLERYJeQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v4 1/4] migration/savevm.c: reorder usage and assertion of
 mis->from_src_file
Date: Wed, 11 Mar 2026 18:15:19 +0500
Message-Id: <20260311131522.58600-2-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311131522.58600-1-heifetz@yandex-team.com>
References: <20260311131522.58600-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 migration/savevm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 3dc812a7bbb..930a3391e35 100644
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


