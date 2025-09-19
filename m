Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDC8CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 10:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzXr7-0006H6-Lo; Fri, 19 Sep 2025 05:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzXqe-0005lU-Ql
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:56:13 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzXqa-0004bL-7r
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:56:12 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1621:0:640:12d9:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 6500380EF5;
 Fri, 19 Sep 2025 12:56:01 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a72::1:38])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ntP1fK1GvGk0-izTsWkir; Fri, 19 Sep 2025 12:56:00 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758275760;
 bh=5HYkPbO4hAPLbFB3eh6cxR13ZYd+5c7xqpnj9WYGlKA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=O8PNS0M8q1PUQ+0d0seNOEuksM9LZ51zKKB4j32CXsFgEMLf2/BDCnwturFZM1iVX
 QiW1w9z99LTCJemKoJudjtCrPXgOV7dIu7ACZusjOSzsO2tUuPsq2CxiLskgqk5/Y8
 D2U3cQQ9tFHOSTJ1sIBmUT4JqdKFyDimc88tVG3o=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, armbru@redhat.com,
 farosas@suse.de, peterx@redhat.com, berrange@redhat.com,
 jasowang@redhat.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v5 14/19] migration: add MIG_EVENT_PRE_INCOMING
Date: Fri, 19 Sep 2025 12:55:40 +0300
Message-ID: <20250919095545.1912042-15-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250919095545.1912042-1-vsementsov@yandex-team.ru>
References: <20250919095545.1912042-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

We are going to implement fds-passing migration feature. When it's
enabled (by setting migration parameter), TAP device (and later other
devices of-course) is passed through migration channel (which should be
a unix socket to pass fds) to a new QEMU.

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
index 10c216d25d..88daa13960 100644
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


