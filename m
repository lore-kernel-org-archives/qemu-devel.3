Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D194FC2BD05
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiTL-0003H0-Ql; Fri, 21 Jun 2024 13:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTF-0003F5-FG
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:54:45 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTD-0003JW-TH
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:54:45 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BCCDA1F835;
 Fri, 21 Jun 2024 17:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hKJ7OgowTW5xAwPODDARLGeRGWa3PEf/OcdtH34X+gM=;
 b=I16D8+MxbdxjvZjCKRssOzipIz61C3cRDvaw76rUyqaJYGPcYi667jBLysLFCZgwUv0I70
 8zTjZwDm6PjlmjOVR6nbMliMe/cOeoBdIKqQd9h0Xs/klmX1rjca/MwzzsSpJd02zP+Xnn
 pIOssOpa6mc4j/SUdfDDzNFpcm7lKU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992481;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hKJ7OgowTW5xAwPODDARLGeRGWa3PEf/OcdtH34X+gM=;
 b=SKaxUYlxr3/QdljMpNxAqLBHvX2dF3fccNbjiS3yq4wWvj9ALVC38eB18lYDxcbQxsP4KB
 GeL0knzceV3nTECw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hKJ7OgowTW5xAwPODDARLGeRGWa3PEf/OcdtH34X+gM=;
 b=I16D8+MxbdxjvZjCKRssOzipIz61C3cRDvaw76rUyqaJYGPcYi667jBLysLFCZgwUv0I70
 8zTjZwDm6PjlmjOVR6nbMliMe/cOeoBdIKqQd9h0Xs/klmX1rjca/MwzzsSpJd02zP+Xnn
 pIOssOpa6mc4j/SUdfDDzNFpcm7lKU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992481;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hKJ7OgowTW5xAwPODDARLGeRGWa3PEf/OcdtH34X+gM=;
 b=SKaxUYlxr3/QdljMpNxAqLBHvX2dF3fccNbjiS3yq4wWvj9ALVC38eB18lYDxcbQxsP4KB
 GeL0knzceV3nTECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 163DC13AAA;
 Fri, 21 Jun 2024 17:54:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EDdsM1++dWZNawAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Jun 2024 17:54:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 02/28] migration: Fix file migration with fdset
Date: Fri, 21 Jun 2024 14:54:08 -0300
Message-Id: <20240621175434.31180-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240621175434.31180-1-farosas@suse.de>
References: <20240621175434.31180-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_FIVE(0.00)[5]
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

When the "file:" migration support was added we missed the special
case in the qemu_open_old implementation that allows for a particular
file name format to be used to refer to a set of file descriptors that
have been previously provided to QEMU via the add-fd QMP command.

When using this fdset feature, we should not truncate the migration
file because being given an fd means that the management layer is in
control of the file and will likely already have some data written to
it. This is further indicated by the presence of the 'offset'
argument, which indicates the start of the region where QEMU is
allowed to write.

Fix the issue by replacing the O_TRUNC flag on open by an ftruncate
call, which will take the offset into consideration.

Fixes: 385f510df5 ("migration: file URI offset")
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/file.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index 2bb8c64092..a903710f06 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -84,12 +84,19 @@ void file_start_outgoing_migration(MigrationState *s,
 
     trace_migration_file_outgoing(filename);
 
-    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
-                                     0600, errp);
+    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY, 0600, errp);
     if (!fioc) {
         return;
     }
 
+    if (ftruncate(fioc->fd, offset)) {
+        error_setg_errno(errp, errno,
+                         "failed to truncate migration file to offset %" PRIx64,
+                         offset);
+        object_unref(OBJECT(fioc));
+        return;
+    }
+
     outgoing_args.fname = g_strdup(filename);
 
     ioc = QIO_CHANNEL(fioc);
-- 
2.35.3


