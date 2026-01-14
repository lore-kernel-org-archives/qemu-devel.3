Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83BCD31A09
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 06:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfufO-0001w3-Q0; Wed, 14 Jan 2026 01:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vfuf4-0001pz-6E
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 01:47:22 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vfuf1-0004AJ-5S
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 01:47:21 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 04A0380676;
 Wed, 14 Jan 2026 09:47:16 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:c88::1:7])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ClNQD90AqW20-W6iwykCf; Wed, 14 Jan 2026 09:47:15 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768373235;
 bh=jsy4reI1TzanCtXBfxJ4/w5QjWMW6WCD9Mr70g2ZVgo=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=G7hg0wfSlTvbz//H4usF7syB7F1fRjSqDkyUa+0hdcR0JQzGNDBwHN6oHIVUko0jS
 MPJAh25vv69Kx9LOiyNUawq2C7rXKvLPB/DPM9PpSQhpWP4jt9g7Jw4uBz/4OtG4Et
 iuIOXE77DLsYC1DJqha1RCOBPiZ0pVtWD3nOZS+A=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, dtalexundeer@yandex-team.ru,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH 4/5] qemu-file: qemu_file_get_fd(): check service byte itself
Date: Wed, 14 Jan 2026 09:47:09 +0300
Message-ID: <20260114064710.176268-5-vsementsov@yandex-team.ru>
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

We can check it, so, why not.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/qemu-file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 3a9a0a49d4..da701d40e4 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -390,13 +390,19 @@ int qemu_file_get_fd(QEMUFile *f)
     int fd = -1;
     FdEntry *fde;
     Error *err = NULL;
+    int service_byte;
 
     if (!f->can_pass_fd) {
         error_setg(&err, "%s does not support fd passing", f->ioc->name);
         goto fail;
     }
 
-    qemu_get_byte(f);
+    service_byte = qemu_get_byte(f);
+    if (service_byte != ' ') {
+        error_setg(&err, "%s unexpected service byte: %d(%c)", f->ioc->name,
+                   service_byte, service_byte);
+        goto fail;
+    }
 
     fde = QTAILQ_FIRST(&f->fds);
     if (!fde) {
-- 
2.48.1


