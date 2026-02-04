Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4244EE83EE7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnXn8-00017T-Fv; Wed, 04 Feb 2026 02:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vnXn5-00014q-6a; Wed, 04 Feb 2026 02:59:11 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vnXn1-0006dm-Gt; Wed, 04 Feb 2026 02:59:08 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1593:0:640:6beb:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 8AF9880830;
 Wed, 04 Feb 2026 10:59:03 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:b69::1:1a])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id lwj54n0AFCg0-u4HaURiD; 
 Wed, 04 Feb 2026 10:59:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1770191943;
 bh=x2BACitWrsPLZRV91SG2I0BF2s7UC2JexW9F7xC6lbQ=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=bgwi40WTPlhpQPPu3yJwCIjMq6SidAZO1av0ujkEttISLh9rC1VOXZPNRUEKiOcoT
 /Zf6TFcvxvG23dXVAUVYNzNgSDfZf1pupiN3IZZrFP0Nf6Mdhz1Tqjycqzbf+dmxUw
 Je2rt+O1a1ISR748AwCQIcPgOl73/A3F8GPVcZMw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	Sergei Heifetz <heifetz@yandex-team.com>
Subject: [PATCH 1/4] migration/savevm.c: reorder usage and assertion of
 mis->from_src_file
Date: Wed,  4 Feb 2026 12:57:51 +0500
Message-Id: <20260204075754.21078-2-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204075754.21078-1-heifetz@yandex-team.com>
References: <20260204075754.21078-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


