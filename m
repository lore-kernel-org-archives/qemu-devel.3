Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32006C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5ls-0007ZL-U9; Thu, 22 Feb 2024 04:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd5lp-0007Z4-Pp
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:53:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd5li-0006on-Ic
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708595609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Om+IE0ZDA+aPoI3NoSAM26F72wV5hnac5vdNwv/5Lk=;
 b=GuzaHnoTW0umGe5/yii4ZHXfjw/61IOrAOz2krB96S8viWvC3xilC3SW87nTZcBHhHQtfD
 nokPRtP9oVkLnSXZhTTYeK46RM/E8lJV0cOa0pkZt2hjREX5zQ+jpvRJO3KptmMiX3p7i+
 R26OnjnvWVsgyOcV+00DmTIU4UKSvt0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-6c4mhx3VPvayNQQXJPVpvQ-1; Thu,
 22 Feb 2024 04:53:26 -0500
X-MC-Unique: 6c4mhx3VPvayNQQXJPVpvQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13E4F3816444;
 Thu, 22 Feb 2024 09:53:26 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 304F78CED;
 Thu, 22 Feb 2024 09:53:22 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 5/5] migration/multifd: Drop unnecessary helper to destroy
 IOC
Date: Thu, 22 Feb 2024 17:53:01 +0800
Message-ID: <20240222095301.171137-6-peterx@redhat.com>
In-Reply-To: <20240222095301.171137-1-peterx@redhat.com>
References: <20240222095301.171137-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

Both socket_send_channel_destroy() and multifd_send_channel_destroy() are
unnecessary wrappers to destroy an IOC, as the only thing to do is to
release the final IOC reference.  We have plenty of code that destroys an
IOC using direct unref() already; keep that style.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/socket.h  | 1 -
 migration/multifd.c | 7 +------
 migration/socket.c  | 7 -------
 3 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/migration/socket.h b/migration/socket.h
index 5f52eddd4c..46c233ecd2 100644
--- a/migration/socket.h
+++ b/migration/socket.h
@@ -23,7 +23,6 @@
 
 void socket_send_channel_create(QIOTaskFunc f, void *data);
 QIOChannel *socket_send_channel_create_sync(Error **errp);
-int socket_send_channel_destroy(QIOChannel *send);
 
 void socket_start_incoming_migration(SocketAddress *saddr, Error **errp);
 
diff --git a/migration/multifd.c b/migration/multifd.c
index e901b32c19..c2eac0c3e6 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -641,16 +641,11 @@ static void multifd_send_terminate_threads(void)
     }
 }
 
-static int multifd_send_channel_destroy(QIOChannel *send)
-{
-    return socket_send_channel_destroy(send);
-}
-
 static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
 {
     if (p->c) {
         migration_ioc_unregister_yank(p->c);
-        multifd_send_channel_destroy(p->c);
+        object_unref(OBJECT(p->c));
         p->c = NULL;
     }
     qemu_sem_destroy(&p->sem);
diff --git a/migration/socket.c b/migration/socket.c
index 3184c7c3c1..9ab89b1e08 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -60,13 +60,6 @@ QIOChannel *socket_send_channel_create_sync(Error **errp)
     return QIO_CHANNEL(sioc);
 }
 
-int socket_send_channel_destroy(QIOChannel *send)
-{
-    /* Remove channel */
-    object_unref(OBJECT(send));
-    return 0;
-}
-
 struct SocketConnectData {
     MigrationState *s;
     char *hostname;
-- 
2.43.0


