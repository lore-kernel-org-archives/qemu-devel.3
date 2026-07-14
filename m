Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E34C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 15:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjfHm-0001OL-0D; Tue, 14 Jul 2026 11:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjfHg-0001LF-IM
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:43:00 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjfHf-000845-3g
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:43:00 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c1b:16:0:640:bc52:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id C4A3E80B07;
 Tue, 14 Jul 2026 18:42:57 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:c5a::1:8])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id lgRdV71YDKo0-wmPbPaNM; Tue, 14 Jul 2026 18:42:57 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784043777;
 bh=cu73PT7yPvhQWzkPeGOzwE074CR4qAek7bUnSiGJNag=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=XJObylRqL/udHwLiAJhPAitwiKLHo7eMYPxUsFVR3ZUz3240nxasfQyBmRWfOE/Kk
 gV00OKWIVabCdqaTPDXeWFZrQbMWyyniVvAf9qaNoVm8qT44N2heZxRqSBQRS5Ihm0
 oBVgNIJv8g4plrtvMqB4TUD8lCrRUZeLAurEpOZQ=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com
Subject: [PATCH v19 10/15] migration/channel: check that transfer is UNIX
 socket when "local" set
Date: Tue, 14 Jul 2026 18:42:38 +0300
Message-ID: <20260714154246.1242856-11-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

As documented, for "local", the migration channel must be direct
UNIX socket connection from source to target. We can't check for
it being "direct", but let's at least check that we deal with
UNIX socket (fd-passing supported).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/channel.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/migration/channel.c b/migration/channel.c
index 1e2935f926b..ba00dd1931d 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -214,6 +214,13 @@ void migration_channel_process_incoming(QIOChannel *ioc)
     trace_migration_set_incoming_channel(
         ioc, object_get_typename(OBJECT(ioc)));
 
+    if (migrate_local() &&
+        !qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS)) {
+        error_setg(&local_err,
+                   "local migration requires a UNIX domain socket channel");
+        goto out;
+    }
+
     if (migrate_channel_requires_tls_upgrade(ioc)) {
         migration_tls_channel_process_incoming(ioc, &local_err);
     } else {
@@ -241,6 +248,16 @@ void migration_channel_connect_outgoing(MigrationState *s, QIOChannel *ioc)
 {
     trace_migration_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)));
 
+    if (migrate_local() &&
+        !qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_FD_PASS)) {
+        Error *local_err = NULL;
+
+        error_setg(&local_err,
+                   "local migration requires a UNIX domain socket channel");
+        migration_connect_error_propagate(s, local_err);
+        return;
+    }
+
     if (migrate_channel_requires_tls_upgrade(ioc)) {
         Error *local_err = NULL;
 
-- 
2.43.0


