Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8306CCD19A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MNe-0007VS-Do; Thu, 16 Oct 2025 07:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MNM-0007J4-Cj; Thu, 16 Oct 2025 07:42:34 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MNA-0003WJ-45; Thu, 16 Oct 2025 07:42:29 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 21DA6C01E5;
 Thu, 16 Oct 2025 14:41:41 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LfP2M73FEmI0-dX3pXnq5; Thu, 16 Oct 2025 14:41:40 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760614900;
 bh=etGolHGsB6Q4bwretmKOtTv/P9Q70AzAWgYe4IY9dEc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Ms/zZEb6gxKqik1zu39OiRmEq8tuZCp1kVs+JvQ3m9IdL1FpWCETOw3C9D3i5dHC2
 xXpKQuOqG7e1cX3VhO0S8/1FJ8nldOV9a6SfAG/OmAKd6MKj8Yj9mxVpnSl+LfOgbn
 vtGZV1Rg8BQLVBv97P2WeN0xKpe1Auyo/M3VwUmk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: raphael@enfabrica.net,
	pbonzini@redhat.com,
	farosas@suse.de
Cc: mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, jasowang@redhat.com,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 23/25] RFC qapi: add local-vhost-user-blk migration
 capability
Date: Thu, 16 Oct 2025 14:41:00 +0300
Message-ID: <20251016114104.1384675-24-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

That's an old way to enable backend-transfer feature for
vhost-user-blk.

I just kept it unchanged since v1 of the series.

At least, it should be migration-parameter instead of
capability.

But currently, there is discussion on final API in
context of "[PATCH v8 00/19] virtio-net: live-TAP local migration", here:
https://lore.kernel.org/qemu-devel/29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru/

So, consider this one as temporary patch, which will be replaced
by some other API.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/options.c |  7 +++++++
 migration/options.h |  1 +
 qapi/migration.json | 11 +++++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 5183112775..3a013b9898 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -262,6 +262,13 @@ bool migrate_mapped_ram(void)
     return s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM];
 }
 
+bool migrate_local_vhost_user_blk(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->capabilities[MIGRATION_CAPABILITY_LOCAL_VHOST_USER_BLK];
+}
+
 bool migrate_ignore_shared(void)
 {
     MigrationState *s = migrate_get_current();
diff --git a/migration/options.h b/migration/options.h
index 82d839709e..95a3f482bc 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -30,6 +30,7 @@ bool migrate_colo(void);
 bool migrate_dirty_bitmaps(void);
 bool migrate_events(void);
 bool migrate_mapped_ram(void);
+bool migrate_local_vhost_user_blk(void);
 bool migrate_ignore_shared(void);
 bool migrate_late_block_activate(void);
 bool migrate_multifd(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index be0f3fcc12..d29a4915b4 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -517,9 +517,15 @@
 #     each RAM page.  Requires a migration URI that supports seeking,
 #     such as a file.  (since 9.0)
 #
+# @local-vhost-user-blk: Migrate vhost-user-blk locally, keeping
+#     backend alive. Open file descriptors and backend-related state
+#     are migrated. Only may be used when migration channel is UNIX
+#     domain socket. (since 10.2)
+#
 # Features:
 #
-# @unstable: Members @x-colo and @x-ignore-shared are experimental.
+# @unstable: Members @x-colo, @x-ignore-shared,
+#     @local-vhost-user-blk are experimental.
 # @deprecated: Member @zero-blocks is deprecated as being part of
 #     block migration which was already removed.
 #
@@ -536,7 +542,8 @@
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
            'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
-           'dirty-limit', 'mapped-ram'] }
+           'dirty-limit', 'mapped-ram',
+           { 'name': 'local-vhost-user-blk', 'features': [ 'unstable' ] } ] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
2.48.1


