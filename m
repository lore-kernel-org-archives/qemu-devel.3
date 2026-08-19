Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9C7C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwkcc-0004Lz-Rv; Wed, 19 Aug 2026 14:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwkcZ-0004KI-0p
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:02:39 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwkcX-0007Qn-D8
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:02:38 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 1A478C08AF;
 Wed, 19 Aug 2026 21:02:36 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:c60::1:5])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id M2bUThDaVKo0-5ZFV58K2; Wed, 19 Aug 2026 21:02:35 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787162555;
 bh=4J39I5MQiW15oResX/G2JSRk8nr42/jo3rCu6TGqFZQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=zSaS67O3H1HXkiywbpEApHZZhaT7OSb+WOZHntTeN+H4scoLHnFZ9A4TW8Fbn72e8
 YAc1FU0mkTzpzCIijseuFSiP2pnCJUe5BtxFqnxIrDfEiPZQzQJIG22oSkzBcsTdAJ
 iZQ/md4R3m1t05EcYzQHFF0Q+Ou0vfJ7JPoQCsys=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com
Subject: [PATCH v21 12/16] migration: check that transfer is UNIX socket when
 "local" set
Date: Wed, 19 Aug 2026 21:01:55 +0300
Message-ID: <20260819180201.1970193-13-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819180201.1970193-1-vsementsov@yandex-team.ru>
References: <20260819180201.1970193-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

As documented, for "local", the migration channel must be direct UNIX
socket connection from source to target (except for CPR_EXEC mode). We
can't check for it being "direct", but let's at least check that we deal
with UNIX socket.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/fd.c        | 14 ++++++++++++++
 migration/migration.c | 13 +++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/migration/fd.c b/migration/fd.c
index 78a27caca22..4a891e814a4 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -39,6 +39,20 @@ static bool fd_is_pipe(int fd)
 
 static bool migration_fd_valid(int fd, Error **errp)
 {
+    if (migrate_local() && migrate_mode() != MIG_MODE_CPR_EXEC) {
+        struct sockaddr_storage ss;
+        socklen_t sslen = sizeof(ss);
+
+        if (getsockname(fd, (struct sockaddr *)&ss, &sslen) < 0 ||
+            ss.ss_family != AF_UNIX) {
+            error_setg(errp,
+                       "local migration requires a UNIX domain socket channel");
+            return false;
+        }
+
+        return true;
+    }
+
     if (fd_is_socket(fd) || fd_is_pipe(fd)) {
         return true;
     }
diff --git a/migration/migration.c b/migration/migration.c
index 9df6da131ce..e30fce30a56 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -260,6 +260,19 @@ migration_capabilities_and_transport_compatible(MigrationAddress *addr,
                                        errp);
     }
 
+    if (migrate_local() && migrate_mode() != MIG_MODE_CPR_EXEC &&
+        (addr->transport != MIGRATION_ADDRESS_TYPE_SOCKET ||
+         (addr->u.socket.type != SOCKET_ADDRESS_TYPE_UNIX &&
+          addr->u.socket.type != SOCKET_ADDRESS_TYPE_FD))) {
+        /*
+         * For SOCKET_ADDRESS_TYPE_FD we do check the fd itself later
+         * in migration_fd_valid().
+         */
+        error_setg(errp,
+                   "local migration requires a UNIX domain socket channel");
+        return false;
+    }
+
     return true;
 }
 
-- 
2.43.0


