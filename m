Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C052EC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYoX-0003GC-7J; Tue, 20 Feb 2024 17:42:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYoQ-0003A2-GS
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:07 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYoP-0006KM-3Z
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:06 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8227A2225A;
 Tue, 20 Feb 2024 22:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XYDo3cJ7Gj35k+6IouB+z3ra8IA1Tj4jwzWBGYzRy/A=;
 b=vwbN/x2zz8xV/62gORQQEgCeRlPqR6/D7LNkrBdik+RlYbfjKNtzjVK5if+Hr3/1YeMXbE
 C+VjHh4O7Im5pyvKCN+FRyoL6QDFgxjFvIeSE8IWMHg+PNwE+OGtB1ZPzM4Vlvix44WgHr
 nNQ5Mmb9VSmMaiRD72x3X9tpPAtJl84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XYDo3cJ7Gj35k+6IouB+z3ra8IA1Tj4jwzWBGYzRy/A=;
 b=G8TjkpODQjCmT8eAg9fErpxxsKhgoZ3npJsAxv19RIBhH51YEkxYz/DE6pT42yJm4PWkM7
 N5vSgAJ/WycBxNBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XYDo3cJ7Gj35k+6IouB+z3ra8IA1Tj4jwzWBGYzRy/A=;
 b=vwbN/x2zz8xV/62gORQQEgCeRlPqR6/D7LNkrBdik+RlYbfjKNtzjVK5if+Hr3/1YeMXbE
 C+VjHh4O7Im5pyvKCN+FRyoL6QDFgxjFvIeSE8IWMHg+PNwE+OGtB1ZPzM4Vlvix44WgHr
 nNQ5Mmb9VSmMaiRD72x3X9tpPAtJl84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XYDo3cJ7Gj35k+6IouB+z3ra8IA1Tj4jwzWBGYzRy/A=;
 b=G8TjkpODQjCmT8eAg9fErpxxsKhgoZ3npJsAxv19RIBhH51YEkxYz/DE6pT42yJm4PWkM7
 N5vSgAJ/WycBxNBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4456139D0;
 Tue, 20 Feb 2024 22:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oGIFKrkq1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:42:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v4 09/34] io: fsync before closing a file channel
Date: Tue, 20 Feb 2024 19:41:13 -0300
Message-Id: <20240220224138.24759-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.73 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-1.43)[91.18%]
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

Make sure the data is flushed to disk before closing file
channels. This is to ensure data is on disk and not lost in the event
of a host crash.

This is currently being implemented to affect the migration code when
migrating to a file, but all QIOChannelFile users should benefit from
the change.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
- improved commit message
---
 io/channel-file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/io/channel-file.c b/io/channel-file.c
index a6ad7770c6..d4706fa592 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -242,6 +242,11 @@ static int qio_channel_file_close(QIOChannel *ioc,
 {
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
 
+    if (qemu_fdatasync(fioc->fd) < 0) {
+        error_setg_errno(errp, errno,
+                         "Unable to synchronize file data with storage device");
+        return -1;
+    }
     if (qemu_close(fioc->fd) < 0) {
         error_setg_errno(errp, errno,
                          "Unable to close file");
-- 
2.35.3


