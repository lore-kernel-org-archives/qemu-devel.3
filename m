Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E947D31A11
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 06:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfufJ-0001uM-AM; Wed, 14 Jan 2026 01:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vfuf2-0001pl-UK
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 01:47:21 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vfuf0-0004A8-HB
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 01:47:20 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 1412D8074D;
 Wed, 14 Jan 2026 09:47:15 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:c88::1:7])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ClNQD90AqW20-0Zw04bIg; Wed, 14 Jan 2026 09:47:14 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768373234;
 bh=Tif36W+c4IEEnHeR+8q+hVk+mR4A73d1GMBH7oqV3UA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=WFnsEhpPlPwxCywp/aMYs4q7alunzPm2kKCS/UZ/JFObwlq7CxpBFx598db3F3UBR
 9YTfuG7F5Ga1s/ZHgh6ASrPhQJgwSMVgstY6dnMhvT0IdCtTyso2bYGKvj6sPm7AN0
 9H7i4KArs3h+3n5csw9pofYX9hac9Qqrk2ec84A0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, dtalexundeer@yandex-team.ru,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH 2/5] qemu-file: qemu_file_get_fd(): fail if no expected fd come
Date: Wed, 14 Jan 2026 09:47:07 +0300
Message-ID: <20260114064710.176268-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260114064710.176268-1-vsementsov@yandex-team.ru>
References: <20260114064710.176268-1-vsementsov@yandex-team.ru>
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

In _put() we don't actually allow send a service byte
without fd. So on _get() it's unexpected. Let's be strict.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/qemu-file.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 4b5a409a80..02f30c1c21 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -389,28 +389,34 @@ int qemu_file_get_fd(QEMUFile *f)
 {
     int fd = -1;
     FdEntry *fde;
+    Error *err = NULL;
 
     if (!f->can_pass_fd) {
-        Error *err = NULL;
         error_setg(&err, "%s does not support fd passing", f->ioc->name);
-        error_report_err(error_copy(err));
-        qemu_file_set_error_obj(f, -EIO, err);
-        goto out;
+        goto fail;
     }
 
     /* Force the dummy byte and its fd passenger to appear. */
     qemu_peek_byte(f, 0);
 
     fde = QTAILQ_FIRST(&f->fds);
-    if (fde) {
-        qemu_get_byte(f);       /* Drop the dummy byte */
-        fd = fde->fd;
-        QTAILQ_REMOVE(&f->fds, fde, entry);
-        g_free(fde);
+    if (!fde) {
+        error_setg(&err, "%s no FD come with service byte", f->ioc->name);
+        goto fail;
     }
-out:
+
+    qemu_get_byte(f);       /* Drop the dummy byte */
+    fd = fde->fd;
+    QTAILQ_REMOVE(&f->fds, fde, entry);
+    g_free(fde);
+
     trace_qemu_file_get_fd(f->ioc->name, fd);
     return fd;
+
+fail:
+    error_report_err(error_copy(err));
+    qemu_file_set_error_obj(f, -EIO, err);
+    return -1;
 }
 
 /** Closes the file
-- 
2.48.1


