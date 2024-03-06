Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2C9C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhrQd-0008HD-AQ; Wed, 06 Mar 2024 08:35:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrQb-0008Go-L7
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:35:25 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrQM-0004zo-8B
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:35:25 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TqYMZ2FYtz4wqN;
 Thu,  7 Mar 2024 00:35:06 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqYMW0wlvz4wcF;
 Thu,  7 Mar 2024 00:35:02 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 04/25] migration: Do not call PRECOPY_NOTIFY_SETUP
 notifiers in case of error
Date: Wed,  6 Mar 2024 14:34:19 +0100
Message-ID: <20240306133441.2351700-5-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306133441.2351700-1-clg@redhat.com>
References: <20240306133441.2351700-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

When commit bd2270608fa0 ("migration/ram.c: add a notifier chain for
precopy") added PRECOPY_NOTIFY_SETUP notifiers at the end of
qemu_savevm_state_setup(), it didn't take into account a possible
error in the loop calling vmstate_save() or .save_setup() handlers.

Check ret value before calling the notifiers.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 migration/savevm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index dc1fb9c0d32bbf037471b810bd28e9361c2d7b87..63066f49f3ad5504be6d44ffdf9f7b759c0a25ef 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1317,7 +1317,7 @@ void qemu_savevm_state_setup(QEMUFile *f)
     MigrationState *ms = migrate_get_current();
     SaveStateEntry *se;
     Error *local_err = NULL;
-    int ret;
+    int ret = 0;
 
     json_writer_int64(ms->vmdesc, "page_size", qemu_target_page_size());
     json_writer_start_array(ms->vmdesc, "devices");
@@ -1351,6 +1351,10 @@ void qemu_savevm_state_setup(QEMUFile *f)
         }
     }
 
+    if (ret) {
+        return;
+    }
+
     if (precopy_notify(PRECOPY_NOTIFY_SETUP, &local_err)) {
         error_report_err(local_err);
     }
-- 
2.44.0


