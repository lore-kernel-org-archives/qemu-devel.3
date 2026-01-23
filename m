Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B0DD778B1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 19:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjNEO-0001vJ-QL; Fri, 23 Jan 2026 14:54:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNEN-0001uv-8W
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:54:07 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNEK-0003SN-Qs
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:54:06 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 56A835BCC7;
 Fri, 23 Jan 2026 19:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=auN+ZE4GDXMoV8V22ayEIYUsSI2yfHwprEwhyHMJqc0=;
 b=kR6cQnnIYfVsY+qqvh7bUQ0l/5TVW2/HTy6AM8NQka0k9hPKSFndaYBfdBc1JoaOn5nLcs
 1tMBQ4ikm7oMFN/iNansTrCyOWamOHXq4jGgwVnj6Z3cLmZJ84XdHn6LQtmBS6i026Y1td
 kx0kBLW7RTOGvpOKQ1L/0TpN1om+ZH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198043;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=auN+ZE4GDXMoV8V22ayEIYUsSI2yfHwprEwhyHMJqc0=;
 b=04hdAS87RwHJsCa7vmOdVLjhel5WXIA8TDijwvyQP/7rRCQEuKK83FirqNqNF4U4l7B0s4
 4o6X0/1oaCf3PhBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=auN+ZE4GDXMoV8V22ayEIYUsSI2yfHwprEwhyHMJqc0=;
 b=kR6cQnnIYfVsY+qqvh7bUQ0l/5TVW2/HTy6AM8NQka0k9hPKSFndaYBfdBc1JoaOn5nLcs
 1tMBQ4ikm7oMFN/iNansTrCyOWamOHXq4jGgwVnj6Z3cLmZJ84XdHn6LQtmBS6i026Y1td
 kx0kBLW7RTOGvpOKQ1L/0TpN1om+ZH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198043;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=auN+ZE4GDXMoV8V22ayEIYUsSI2yfHwprEwhyHMJqc0=;
 b=04hdAS87RwHJsCa7vmOdVLjhel5WXIA8TDijwvyQP/7rRCQEuKK83FirqNqNF4U4l7B0s4
 4o6X0/1oaCf3PhBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0319C1395E;
 Fri, 23 Jan 2026 19:54:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UI9ILdnRc2lFZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 19:54:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 04/36] qemu-file: qemu_file_get_fd(): fail if no expected fd
 come
Date: Fri, 23 Jan 2026 16:53:19 -0300
Message-ID: <20260123195352.12850-5-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123195352.12850-1-farosas@suse.de>
References: <20260123195352.12850-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.18 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 BAYES_HAM(-0.02)[53.50%]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

In _put() we don't actually allow send a service byte
without fd. So on _get() it's unexpected. Let's be strict.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/20260114064710.176268-3-vsementsov@yandex-team.ru
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/qemu-file.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 8d82d94416..1f3b4cf4c5 100644
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
2.51.0


