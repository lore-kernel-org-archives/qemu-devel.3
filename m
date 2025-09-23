Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCA9CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zqs-0003fA-ST; Tue, 23 Sep 2025 06:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0zqK-0002vh-1W
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:01:52 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0zpy-0000vQ-Sg
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:01:51 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 2708980B6E;
 Tue, 23 Sep 2025 13:01:21 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b38::1:12])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id C1Ug0C0Fha60-BVlNaRNH; Tue, 23 Sep 2025 13:01:20 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758621680;
 bh=GzChdpIiKM7X9bgeu4CwKiMXmrBRh/3YN7kvx854C6k=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=OF3WdaO4FbwXyhl/0dqAiFImJ9RDWHHMfeiU6sWStq/BdVbCRbOoh9PR0HwrlwYhK
 s2iT+mL8XOFwOFuoPM5ka4Iwob6HNTIgH/hMgSLp0MqAtj9jlQhPr4oV1vrdif1LSS
 HfZBfOPRpVf1wzm4Glopyo7o3U/c9goaoZEzozbA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, armbru@redhat.com,
 farosas@suse.de, peterx@redhat.com, berrange@redhat.com,
 jasowang@redhat.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v6 14/19] migration: add MIG_EVENT_PRE_INCOMING
Date: Tue, 23 Sep 2025 13:01:05 +0300
Message-ID: <20250923100110.70862-15-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250923100110.70862-1-vsementsov@yandex-team.ru>
References: <20250923100110.70862-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We are going to implement backend-transfer migration feature for
virtio-net/tap. When it's enabled (by setting migration parameter), TAP
device is passed through migration channel (which should be a unix
socket to pass fds) to a new QEMU.

So we need to know during TAP initialization, should we open TAP
device, or wait for incoming fds. But we can't check for migration
parameter at TAP creation time, as use may set migration parameter
later (especially when TAP is added by command line parameter).

To solve this, we have prepared TAP initialization code so that
opening the device may be postponed to later point. And this later
point is obviously the early beginning of qmp_migrate_incoming():
here we already know all migration parameters and capabilities,
but we are not in downtime, so we can continue initialization
of TAP device.

This commit introduces MIG_EVENT_PRE_INCOMING, to be used by TAP
code in following commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/migration/misc.h | 1 +
 migration/migration.c    | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index a261f99d89..5765fcc204 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -63,6 +63,7 @@ typedef enum MigrationEventType {
     MIG_EVENT_PRECOPY_SETUP,
     MIG_EVENT_PRECOPY_DONE,
     MIG_EVENT_PRECOPY_FAILED,
+    MIG_EVENT_PRE_INCOMING,
     MIG_EVENT_MAX
 } MigrationEventType;
 
diff --git a/migration/migration.c b/migration/migration.c
index e1ac4d73c2..4c356e0b92 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1696,7 +1696,8 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
     e.type = type;
     ret = notifier_with_return_list_notify(&migration_state_notifiers[mode],
                                            &e, errp);
-    assert(!ret || type == MIG_EVENT_PRECOPY_SETUP);
+    assert(!ret || type == MIG_EVENT_PRECOPY_SETUP ||
+           type == MIG_EVENT_PRE_INCOMING);
     return ret;
 }
 
@@ -1936,6 +1937,11 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
         return;
     }
 
+    if (migration_call_notifiers(migrate_get_current(), MIG_EVENT_PRE_INCOMING,
+                                 errp)) {
+        return;
+    }
+
     if (!yank_register_instance(MIGRATION_YANK_INSTANCE, errp)) {
         return;
     }
-- 
2.48.1


