Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2756C25B7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 19:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sADlH-0001wj-Lv; Thu, 23 May 2024 15:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlG-0001wK-QP
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:05:58 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlF-0004FX-3y
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:05:58 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D3ADC20410;
 Thu, 23 May 2024 19:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vv1wgOdsadIPSi81PyTrC26xDTPAu/UHUd/1ECzKYOI=;
 b=2BtgqYXHwIRylVWWMeTQL1QWfmc1Rw2h/Is6PjLtWhdn0urwkE/FanQietQySEuo05jlS7
 RqQ/W+sHboQ7QXT8m936fam+xEvN24Nmu/buDzcm8Ifxn4f/CRJh6EHTaxe7ZDnmbzuVTR
 Bwef9LVaKstW6+IpS8qJ38D/8uVE6Ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491155;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vv1wgOdsadIPSi81PyTrC26xDTPAu/UHUd/1ECzKYOI=;
 b=IJElDfq7adCD8OKxz6lPa5r7tTUDV/igAdZTi2yfuszk4ufTtgL9Vp79T3ki2FHwbDYzF4
 FAWjIKFNH1zjv8AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vv1wgOdsadIPSi81PyTrC26xDTPAu/UHUd/1ECzKYOI=;
 b=XHcCOSB2uhwBubnR4AhTiSYsk/MrQsn4bdxohJ7iE+CwOt9szf8bnIrN7hlZEaazlEeljH
 lAFXU1tQfX6GPhOuIj+gzBOVmxYnUT0jDLhLTLw+TfizOQMMGjJQcO0FHlF8RVr2n+zPsm
 1/8UgjDIvxTBR/DOq0RNh445SiwDnV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491154;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vv1wgOdsadIPSi81PyTrC26xDTPAu/UHUd/1ECzKYOI=;
 b=zvLOFcV69KYKLktytdAFhZxW1FlPZC3pKBlFf4khhvqFpkXpRDsnccJynOVRpZf2HsI/fF
 cscaQRyUVB9+d4DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0846013A6B;
 Thu, 23 May 2024 19:05:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2JY4MJCTT2bUEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 May 2024 19:05:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: [PATCH v2 01/18] migration: Fix file migration with fdset
Date: Thu, 23 May 2024 16:05:31 -0300
Message-Id: <20240523190548.23977-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240523190548.23977-1-farosas@suse.de>
References: <20240523190548.23977-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/file.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index ab18ba505a..ba5b5c44ff 100644
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


