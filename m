Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BADFDEE45
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzdI-00068S-MS; Thu, 23 Apr 2026 15:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzcp-0004nl-82
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:22:11 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzcn-0002Mi-At
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:22:10 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 137D85BD90;
 Thu, 23 Apr 2026 19:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9sthEBYIMVPUpMPGDxjvreljDqO5OkAeAFlrIWjqBnQ=;
 b=SC2vMrt0kf10Qy2eJucJwl2j12YzEHTugvSkbtCSq/1CD48Lx1k9b1y1+Jy/ODFuj2vj9o
 GtX+WULcx23o7k5kl2JBWFQfTN0XblqON47ujg+p3/LQ0TM3x0KCQOd15A0+1nzMidb+9F
 j261dJRzLdDnlCEBOrfZCv6BCI6l/m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972066;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9sthEBYIMVPUpMPGDxjvreljDqO5OkAeAFlrIWjqBnQ=;
 b=K26oJMj+D6MZ1gDPP4tGCoiyEk70Bti/3n7sfpkQCuhcuv3MTWlAltP0LLR9VLj15UgB8M
 VJtux+LwcGu0AjDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SC2vMrt0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=K26oJMj+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9sthEBYIMVPUpMPGDxjvreljDqO5OkAeAFlrIWjqBnQ=;
 b=SC2vMrt0kf10Qy2eJucJwl2j12YzEHTugvSkbtCSq/1CD48Lx1k9b1y1+Jy/ODFuj2vj9o
 GtX+WULcx23o7k5kl2JBWFQfTN0XblqON47ujg+p3/LQ0TM3x0KCQOd15A0+1nzMidb+9F
 j261dJRzLdDnlCEBOrfZCv6BCI6l/m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972066;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9sthEBYIMVPUpMPGDxjvreljDqO5OkAeAFlrIWjqBnQ=;
 b=K26oJMj+D6MZ1gDPP4tGCoiyEk70Bti/3n7sfpkQCuhcuv3MTWlAltP0LLR9VLj15UgB8M
 VJtux+LwcGu0AjDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08317593B1;
 Thu, 23 Apr 2026 19:21:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KBxnMSBx6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:21:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Junjie Cao <junjie.cao@intel.com>
Subject: [PULL 42/43] migration/file: switch file_write_ramblock_iov to
 pwritev_all
Date: Thu, 23 Apr 2026 16:19:56 -0300
Message-ID: <20260423191958.1440-43-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,intel.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 137D85BD90
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

file_write_ramblock_iov() uses single-shot qio_channel_pwritev() and
only checks for ret < 0.  A short write (0 <= ret < requested) would be
treated as success.

Switch to qio_channel_pwritev_all() which retries until all bytes are
written or an error occurs.

Fixes: f427d90b98 ("migration/multifd: Support outgoing mapped-ram stream format")
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260420201317.30199-3-junjie.cao@intel.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index 4e2524e548..8ba1de2006 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -202,7 +202,7 @@ void file_connect_incoming(FileMigrationArgs *file_args, Error **errp)
 int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
                             int niov, MultiFDPages_t *pages, Error **errp)
 {
-    ssize_t ret = 0;
+    int ret = 0;
     int i, slice_idx, slice_num;
     uintptr_t base, next, offset;
     size_t len;
@@ -241,8 +241,8 @@ int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
             break;
         }
 
-        ret = qio_channel_pwritev(ioc, &iov[slice_idx], slice_num,
-                                  block->pages_offset + offset, errp);
+        ret = qio_channel_pwritev_all(ioc, &iov[slice_idx], slice_num,
+                                      block->pages_offset + offset, errp);
         if (ret < 0) {
             break;
         }
@@ -251,7 +251,7 @@ int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
         slice_num = 0;
     }
 
-    return (ret < 0) ? ret : 0;
+    return ret;
 }
 
 int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp)
-- 
2.51.0


