Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FC2D31A13
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 06:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfufL-0001vy-Dp; Wed, 14 Jan 2026 01:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vfuf3-0001ps-6r
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 01:47:21 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vfuf1-0004AO-2s
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 01:47:20 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 8E46C807BC;
 Wed, 14 Jan 2026 09:47:16 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:c88::1:7])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ClNQD90AqW20-Awhmfl3Y; Wed, 14 Jan 2026 09:47:16 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768373236;
 bh=MN2tkwk+2wULskhErRy+Xg3Kjfi5sWUTJLiHbLKQQjE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=xHKj5APoodrDy58rHi4uuVndh+Rx1Tu06IJrq6I+Oq5fVpM4dYudg5vgYOXGU9bsA
 l8tydnX6ISsvX+FVLLy4uDvzb3JR+YSaLhncXk1XW//7TrtfMW9hKRR2poBhgjw+5i
 B53KXx6PkrIFYw+rkh19Ag2MAjNCKkC9Ss0WLdRQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, dtalexundeer@yandex-team.ru,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH 5/5] qemu-file: qemu_file_get_fd(): improve interface
Date: Wed, 14 Jan 2026 09:47:10 +0300
Message-ID: <20260114064710.176268-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260114064710.176268-1-vsementsov@yandex-team.ru>
References: <20260114064710.176268-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Make it symmetrical with qemu_file_put_fd() and simplify callers.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/qemu-file.c     |  9 ++++-----
 migration/qemu-file.h     |  2 +-
 migration/vmstate-types.c | 10 +---------
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index da701d40e4..f8394cbbb5 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -385,9 +385,8 @@ int qemu_file_put_fd(QEMUFile *f, int fd)
     return ret;
 }
 
-int qemu_file_get_fd(QEMUFile *f)
+int qemu_file_get_fd(QEMUFile *f, int *fd)
 {
-    int fd = -1;
     FdEntry *fde;
     Error *err = NULL;
     int service_byte;
@@ -410,12 +409,12 @@ int qemu_file_get_fd(QEMUFile *f)
         goto fail;
     }
 
-    fd = fde->fd;
+    *fd = fde->fd;
     QTAILQ_REMOVE(&f->fds, fde, entry);
     g_free(fde);
 
-    trace_qemu_file_get_fd(f->ioc->name, fd);
-    return fd;
+    trace_qemu_file_get_fd(f->ioc->name, *fd);
+    return 0;
 
 fail:
     error_report_err(error_copy(err));
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index c13c967167..a8e9bb2ccb 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -82,6 +82,6 @@ size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
 
 QIOChannel *qemu_file_get_ioc(QEMUFile *file);
 int qemu_file_put_fd(QEMUFile *f, int fd);
-int qemu_file_get_fd(QEMUFile *f);
+int qemu_file_get_fd(QEMUFile *f, int *fd);
 
 #endif
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index e34bf4486e..89cb211472 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -321,7 +321,6 @@ const VMStateInfo vmstate_info_uint64 = {
 static int get_fd(QEMUFile *f, void *pv, size_t size,
                   const VMStateField *field)
 {
-    int fd;
     int32_t *v = pv;
 
     if (migrate_mode() == MIG_MODE_CPR_EXEC) {
@@ -329,14 +328,7 @@ static int get_fd(QEMUFile *f, void *pv, size_t size,
         return 0;
     }
 
-    fd = qemu_file_get_fd(f);
-    if (fd < 0) {
-        return -1;
-    }
-
-    *v = fd;
-
-    return 0;
+    return qemu_file_get_fd(f, v);
 }
 
 static int put_fd(QEMUFile *f, void *pv, size_t size,
-- 
2.48.1


