Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D58FDEE3F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzdE-0005qA-8C; Thu, 23 Apr 2026 15:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzck-0004gu-4f
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:22:07 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzch-0002JX-55
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:22:04 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9BDE55BD8A;
 Thu, 23 Apr 2026 19:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gFYc2iCcctX8eeRxlptNc9/OtgMtLaoHlJzTpnV+VcY=;
 b=n4AyYiELDz/FFkSMrQniN+ZTzZEh7D8T9+yzNsPtwnPCogy/FAVZA7x7OPS87kHzsBVKQY
 zMBrL8Bu+1GKt9iMq25WwtBOLm+ByGpreAwiRUGl98q5PlfHau0YWdQrZ+MleCEQ3/UeQY
 1dtrvsh+8RH+Tj+lKDxKquHSojzvuRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972065;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gFYc2iCcctX8eeRxlptNc9/OtgMtLaoHlJzTpnV+VcY=;
 b=MOUWPl3/ZruAXhn2++qOKJsbE7lCy0pottxt3D8OqG9eMfw7TN9Ws+CK9j877o73Tsofug
 Grk1i+UclYhPkxCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gFYc2iCcctX8eeRxlptNc9/OtgMtLaoHlJzTpnV+VcY=;
 b=CnbQcL8ax7SGnm4qeZD15ZiFS8U3b3EKe9ZIJyPFgg1vXQYh7ma1jXhT/Gngk08UcMD1Ru
 Z/Gt769BFvjMxcXvYeSv39mcULK5WaPKmAn0IoBk9F8kkRkYcBGy9rewxQUFYiZF3Pc6lG
 cAM9bRgQOiZ2t8buErBPp8C5xvYKzeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972064;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gFYc2iCcctX8eeRxlptNc9/OtgMtLaoHlJzTpnV+VcY=;
 b=FK4YCewqlUjnBBmhtsLWV4kfkjPPvqC1SH3li7oY06CN2PI8hB9Y5zSsrt8XEjnF6iQUe5
 JD69D8ZY960AYdAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 909E9593B0;
 Thu, 23 Apr 2026 19:21:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aGQXFx9x6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:21:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Junjie Cao <junjie.cao@intel.com>
Subject: [PULL 41/43] migration/qemu-file: switch buffer_at functions to
 positioned I/O _all helpers
Date: Thu, 23 Apr 2026 16:19:55 -0300
Message-ID: <20260423191958.1440-42-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,intel.com:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Junjie Cao <junjie.cao@intel.com>

qemu_put_buffer_at() and qemu_get_buffer_at() have the same pattern as
the bug fixed in multifd_file_recv_data(): the ssize_t return value from
the channel layer is stored in a size_t variable, and a short transfer
would be mishandled rather than retried.

Switch to qio_channel_pwrite_all() / qio_channel_pread_all() which
handle short transfers internally and make the code more robust and
consistent with the rest of the positioned I/O call sites.

Fixes: 7f5b50a401 ("migration/qemu-file: add utility methods for working with seekable channels")
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260420201317.30199-2-junjie.cao@intel.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/qemu-file.c | 35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 9cf7dc3bd5..9dfb202203 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -535,28 +535,13 @@ void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
                         off_t pos)
 {
     Error *err = NULL;
-    size_t ret;
 
     if (f->last_error) {
         return;
     }
 
     qemu_fflush(f);
-    ret = qio_channel_pwrite(f->ioc, (char *)buf, buflen, pos, &err);
-
-    if (err) {
-        qemu_file_set_error_obj(f, -EIO, err);
-        return;
-    }
-
-    if ((ssize_t)ret == QIO_CHANNEL_ERR_BLOCK) {
-        qemu_file_set_error_obj(f, -EAGAIN, NULL);
-        return;
-    }
-
-    if (ret != buflen) {
-        error_setg(&err, "Partial write of size %zu, expected %zu", ret,
-                   buflen);
+    if (qio_channel_pwrite_all(f->ioc, buf, buflen, pos, &err) < 0) {
         qemu_file_set_error_obj(f, -EIO, err);
         return;
     }
@@ -569,31 +554,17 @@ size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
                           off_t pos)
 {
     Error *err = NULL;
-    size_t ret;
 
     if (f->last_error) {
         return 0;
     }
 
-    ret = qio_channel_pread(f->ioc, (char *)buf, buflen, pos, &err);
-
-    if ((ssize_t)ret == -1 || err) {
-        qemu_file_set_error_obj(f, -EIO, err);
-        return 0;
-    }
-
-    if ((ssize_t)ret == QIO_CHANNEL_ERR_BLOCK) {
-        qemu_file_set_error_obj(f, -EAGAIN, NULL);
-        return 0;
-    }
-
-    if (ret != buflen) {
-        error_setg(&err, "Partial read of size %zu, expected %zu", ret, buflen);
+    if (qio_channel_pread_all(f->ioc, (char *)buf, buflen, pos, &err) < 0) {
         qemu_file_set_error_obj(f, -EIO, err);
         return 0;
     }
 
-    return ret;
+    return buflen;
 }
 
 void qemu_set_offset(QEMUFile *f, off_t off, int whence)
-- 
2.51.0


