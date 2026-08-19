Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66748C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwkca-0004KW-Br; Wed, 19 Aug 2026 14:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwkcY-0004JN-5V
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:02:38 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwkcW-0007QR-JD
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:02:37 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 4EBA0C0D18;
 Wed, 19 Aug 2026 21:02:35 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:c60::1:5])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id M2bUThDaVKo0-2lxIMhkT; Wed, 19 Aug 2026 21:02:34 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787162554;
 bh=qaYQibXsMStBAjFyr2RAt6vm97uFnbe3yjAWh42yQvM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=HitzHQotkufcXUJ0rx3KEI8nAP7ROR1uJore2u6UbZlOAEz9KDqPOBh9dSYudMtLo
 dEpVPP9W1SPO9wIehnmhqcctiXZvExKTfrBg7uAKkrG+JG+GiAPzHvBsz38nOhlRba
 p0uqJq6LAMrrsR3QyGrMTV4AsbsXfhamnZK1UFVw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com
Subject: [PATCH v21 11/16] migration/fd: add errp parameter to
 migration_fd_valid()
Date: Wed, 19 Aug 2026 21:01:54 +0300
Message-ID: <20260819180201.1970193-12-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819180201.1970193-1-vsementsov@yandex-team.ru>
References: <20260819180201.1970193-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

Let migration_fd_valid() report the error itself, instead of
duplicating the error message in both callers. This also prepares
for adding one more check (with a different error message) to the
function.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/fd.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/migration/fd.c b/migration/fd.c
index 02b39b150eb..78a27caca22 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -37,16 +37,14 @@ static bool fd_is_pipe(int fd)
     return S_ISFIFO(statbuf.st_mode);
 }
 
-static bool migration_fd_valid(int fd)
+static bool migration_fd_valid(int fd, Error **errp)
 {
-    if (fd_is_socket(fd)) {
-        return true;
-    }
-
-    if (fd_is_pipe(fd)) {
+    if (fd_is_socket(fd) || fd_is_pipe(fd)) {
         return true;
     }
 
+    error_setg(errp, "fd: migration to a file is not supported."
+               " Use file: instead.");
     return false;
 }
 
@@ -59,9 +57,7 @@ QIOChannel *fd_connect_outgoing(MigrationState *s, const char *fdname,
         goto out;
     }
 
-    if (!migration_fd_valid(fd)) {
-        error_setg(errp, "fd: migration to a file is not supported."
-                   " Use file: instead.");
+    if (!migration_fd_valid(fd, errp)) {
         close(fd);
         goto out;
     }
@@ -95,9 +91,7 @@ void fd_connect_incoming(const char *fdname, Error **errp)
         return;
     }
 
-    if (!migration_fd_valid(fd)) {
-        error_setg(errp, "fd: migration to a file is not supported."
-                   " Use file: instead.");
+    if (!migration_fd_valid(fd, errp)) {
         close(fd);
         return;
     }
-- 
2.43.0


