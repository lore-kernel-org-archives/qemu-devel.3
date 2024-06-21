Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FB9C2BB85
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiTb-0003Sf-NB; Fri, 21 Jun 2024 13:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTa-0003RU-1d
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:06 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTY-0003MD-Cz
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:05 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2534E1FB84;
 Fri, 21 Jun 2024 17:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MkrcRNBtpDTsthhpbC7Y92TOWA0h/KuMNbfGLxSxh9U=;
 b=mNXBhqvcvzN2T3kQ3scZLiUQeXSGfSZADZjTDtPfmIyf8FZCtHABMGhlJtx1fNxzfzUy+o
 BwZ9kLRz90nrHDbW1Rgj2GmhqmsGJDc5PIQL3YAa2hm84XR04kXs64dRT9Q7Fj0uV1DYxT
 v74NWBZwn14wDJ+S3g4kVkFvKuTlzUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992503;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MkrcRNBtpDTsthhpbC7Y92TOWA0h/KuMNbfGLxSxh9U=;
 b=syU3YvuY/FLvVg0k5J1qO9joSZdeYMzs3wz3QC5wZ5aIyCVy6DWPL+rCOLyIIHtL7Fj3C6
 WTIU9qtzNEScpMBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mNXBhqvc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=syU3YvuY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MkrcRNBtpDTsthhpbC7Y92TOWA0h/KuMNbfGLxSxh9U=;
 b=mNXBhqvcvzN2T3kQ3scZLiUQeXSGfSZADZjTDtPfmIyf8FZCtHABMGhlJtx1fNxzfzUy+o
 BwZ9kLRz90nrHDbW1Rgj2GmhqmsGJDc5PIQL3YAa2hm84XR04kXs64dRT9Q7Fj0uV1DYxT
 v74NWBZwn14wDJ+S3g4kVkFvKuTlzUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992503;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MkrcRNBtpDTsthhpbC7Y92TOWA0h/KuMNbfGLxSxh9U=;
 b=syU3YvuY/FLvVg0k5J1qO9joSZdeYMzs3wz3QC5wZ5aIyCVy6DWPL+rCOLyIIHtL7Fj3C6
 WTIU9qtzNEScpMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E106213AAA;
 Fri, 21 Jun 2024 17:55:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yPQ3KXW+dWZNawAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Jun 2024 17:55:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/28] monitor: fdset: Match against O_DIRECT
Date: Fri, 21 Jun 2024 14:54:20 -0300
Message-Id: <20240621175434.31180-15-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240621175434.31180-1-farosas@suse.de>
References: <20240621175434.31180-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2534E1FB84
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

We're about to enable the use of O_DIRECT in the migration code and
due to the alignment restrictions imposed by filesystems we need to
make sure the flag is only used when doing aligned IO.

The migration will do parallel IO to different regions of a file, so
we need to use more than one file descriptor. Those cannot be obtained
by duplicating (dup()) since duplicated file descriptors share the
file status flags, including O_DIRECT. If one migration channel does
unaligned IO while another sets O_DIRECT to do aligned IO, the
filesystem would fail the unaligned operation.

The add-fd QMP command along with the fdset code are specifically
designed to allow the user to pass a set of file descriptors with
different access flags into QEMU to be later fetched by code that
needs to alternate between those flags when doing IO.

Extend the fdset matching to behave the same with the O_DIRECT flag.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 monitor/fds.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/monitor/fds.c b/monitor/fds.c
index d8c6b395b0..b5416b5b5d 100644
--- a/monitor/fds.c
+++ b/monitor/fds.c
@@ -424,6 +424,11 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags, Error **errp)
         int fd = -1;
         int dup_fd;
         int mon_fd_flags;
+        int mask = O_ACCMODE;
+
+#ifdef O_DIRECT
+        mask |= O_DIRECT;
+#endif
 
         if (mon_fdset->id != fdset_id) {
             continue;
@@ -437,7 +442,7 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags, Error **errp)
                 return -1;
             }
 
-            if ((flags & O_ACCMODE) == (mon_fd_flags & O_ACCMODE)) {
+            if ((flags & mask) == (mon_fd_flags & mask)) {
                 fd = mon_fdset_fd->fd;
                 break;
             }
-- 
2.35.3


