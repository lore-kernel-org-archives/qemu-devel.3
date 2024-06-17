Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB26C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHYL-0003sT-GG; Mon, 17 Jun 2024 14:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJHYK-0003sK-Jk
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:04 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJHYJ-0004tx-3e
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:04 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A178921AD6;
 Mon, 17 Jun 2024 18:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718650681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iUojXKKi7au5lbz0GBdgGak+ICpTnFKCQZykBCuYuWk=;
 b=m5HmwUY48raWZeD1wdUEvFcEujs5kgw3XQSyDFyUXoqM3Nrr3wIGnej27Qzs0+92wwTkIc
 8n7malZY7y8eDezj9R9GISDhN4qU+13CqLsjByT8d0HTRwp4bgkMQOh7Sd+OUKYEgSqjZ8
 UJvxmT5dv9dpQ5aPeIsaxsaFEWXErY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718650681;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iUojXKKi7au5lbz0GBdgGak+ICpTnFKCQZykBCuYuWk=;
 b=ztbejBloYR6sRSqwzAyrh+PAIyLWFCv0/iJXKzikLFGq65U0ucAqzMvWpJO/Zf0LviJd8L
 WCVd5lOGF6C/lSDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718650681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iUojXKKi7au5lbz0GBdgGak+ICpTnFKCQZykBCuYuWk=;
 b=m5HmwUY48raWZeD1wdUEvFcEujs5kgw3XQSyDFyUXoqM3Nrr3wIGnej27Qzs0+92wwTkIc
 8n7malZY7y8eDezj9R9GISDhN4qU+13CqLsjByT8d0HTRwp4bgkMQOh7Sd+OUKYEgSqjZ8
 UJvxmT5dv9dpQ5aPeIsaxsaFEWXErY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718650681;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iUojXKKi7au5lbz0GBdgGak+ICpTnFKCQZykBCuYuWk=;
 b=ztbejBloYR6sRSqwzAyrh+PAIyLWFCv0/iJXKzikLFGq65U0ucAqzMvWpJO/Zf0LviJd8L
 WCVd5lOGF6C/lSDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C51D7139AB;
 Mon, 17 Jun 2024 18:57:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uBl/IjeHcGYJKAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 17 Jun 2024 18:57:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: [PATCH v3 10/16] io: Stop using qemu_open_old in channel-file
Date: Mon, 17 Jun 2024 15:57:25 -0300
Message-Id: <20240617185731.9725-11-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240617185731.9725-1-farosas@suse.de>
References: <20240617185731.9725-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We want to make use of the Error object to report fdset errors from
qemu_open_internal() and passing the error pointer to qemu_open_old()
would require changing all callers. Move the file channel to the new
API instead.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 io/channel-file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/io/channel-file.c b/io/channel-file.c
index 6436cfb6ae..2ea8d08360 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -68,11 +68,13 @@ qio_channel_file_new_path(const char *path,
 
     ioc = QIO_CHANNEL_FILE(object_new(TYPE_QIO_CHANNEL_FILE));
 
-    ioc->fd = qemu_open_old(path, flags, mode);
+    if (flags & O_CREAT) {
+        ioc->fd = qemu_create(path, flags & ~O_CREAT, mode, errp);
+    } else {
+        ioc->fd = qemu_open(path, flags, errp);
+    }
     if (ioc->fd < 0) {
         object_unref(OBJECT(ioc));
-        error_setg_errno(errp, errno,
-                         "Unable to open %s", path);
         return NULL;
     }
 
-- 
2.35.3


