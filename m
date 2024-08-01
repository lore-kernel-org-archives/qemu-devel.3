Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A72C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 12:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZV27-0000Nf-8U; Thu, 01 Aug 2024 08:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZV1r-0008Q4-4O
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:35:36 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZV1l-0000kk-Fd
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:35:34 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 75C2421A39;
 Thu,  1 Aug 2024 12:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722515726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dITPiGdDARDaPeWT8xSF5kMPl3PJ9+CE1b0/hu08aQk=;
 b=YWQosb+yzZE46guSKGBN1BEepMvSEnJ8eWIq1Mq6VwmL+Ic9sUI3GpLswDWBOzJKqGn7kI
 3wgTDbIRPP0ikVC/sIXK7wElj1lF1eXUmgIeEsxxYvgTcN/L6Y+mYu7A3v1e403N5Oy+Xc
 sgo7EPxdFcWxLnqseF6Ln938kC18Zf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722515726;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dITPiGdDARDaPeWT8xSF5kMPl3PJ9+CE1b0/hu08aQk=;
 b=wpGdIlAboCbWmpAeLjBsg7b4pRzx3A7JKcApngYFPKN/wGFbpXsR9uM+0Llq+7R0fQtMjU
 ssiLXWU+Np0As0CA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YWQosb+y;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wpGdIlAb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722515726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dITPiGdDARDaPeWT8xSF5kMPl3PJ9+CE1b0/hu08aQk=;
 b=YWQosb+yzZE46guSKGBN1BEepMvSEnJ8eWIq1Mq6VwmL+Ic9sUI3GpLswDWBOzJKqGn7kI
 3wgTDbIRPP0ikVC/sIXK7wElj1lF1eXUmgIeEsxxYvgTcN/L6Y+mYu7A3v1e403N5Oy+Xc
 sgo7EPxdFcWxLnqseF6Ln938kC18Zf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722515726;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dITPiGdDARDaPeWT8xSF5kMPl3PJ9+CE1b0/hu08aQk=;
 b=wpGdIlAboCbWmpAeLjBsg7b4pRzx3A7JKcApngYFPKN/wGFbpXsR9uM+0Llq+7R0fQtMjU
 ssiLXWU+Np0As0CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D9AB13946;
 Thu,  1 Aug 2024 12:35:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IMtfBQ2Bq2YEYAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 01 Aug 2024 12:35:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v3 04/14] migration/multifd: Pass in MultiFDPages_t to
 file_write_ramblock_iov
Date: Thu,  1 Aug 2024 09:35:06 -0300
Message-Id: <20240801123516.4498-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240801123516.4498-1-farosas@suse.de>
References: <20240801123516.4498-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.81 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 75C2421A39
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

We want to stop dereferencing 'pages' so it can be replaced by an
opaque pointer in the next patches.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/file.c    | 3 ++-
 migration/file.h    | 2 +-
 migration/multifd.c | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index db870f2cf0..7a8c9e3957 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -198,12 +198,13 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
 }
 
 int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
-                            int niov, RAMBlock *block, Error **errp)
+                            int niov, MultiFDPages_t *pages, Error **errp)
 {
     ssize_t ret = 0;
     int i, slice_idx, slice_num;
     uintptr_t base, next, offset;
     size_t len;
+    RAMBlock *block = pages->block;
 
     slice_idx = 0;
     slice_num = 1;
diff --git a/migration/file.h b/migration/file.h
index 9f71e87f74..1a1115f7f1 100644
--- a/migration/file.h
+++ b/migration/file.h
@@ -21,6 +21,6 @@ int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
 void file_cleanup_outgoing_migration(void);
 bool file_send_channel_create(gpointer opaque, Error **errp);
 int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
-                            int niov, RAMBlock *block, Error **errp);
+                            int niov, MultiFDPages_t *pages, Error **errp);
 int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp);
 #endif
diff --git a/migration/multifd.c b/migration/multifd.c
index b4ca135b47..44d4c3ca11 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -956,7 +956,7 @@ static void *multifd_send_thread(void *opaque)
 
             if (migrate_mapped_ram()) {
                 ret = file_write_ramblock_iov(p->c, p->iov, p->iovs_num,
-                                              pages->block, &local_err);
+                                              pages, &local_err);
             } else {
                 ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num,
                                                   NULL, 0, p->write_flags,
-- 
2.35.3


