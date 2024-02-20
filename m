Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3349EC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYpN-0005X3-BK; Tue, 20 Feb 2024 17:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYpG-0005Rr-44
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:58 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYpE-0006QY-JD
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:57 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D4C11FB40;
 Tue, 20 Feb 2024 22:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZVp1Kh9ePdTIP4PY9Va+CuAtPIW5XqjAK0WxIkPuas=;
 b=POIH8eOQwPNWwTz31GTJxLqNRG6MVwjcyau7weBBpESlEu+bBg0Qv34g1Q2uCheG6rxa9F
 U4ed+o4aj8xUJ5MIf6d3gU1Ylzx6AZTVdS77Bc5s0tkHuUxtAgjmml/otGXU/8nIRPl9il
 kJlrD17KvYao0RQTMy/n7vWUz9RzpeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468975;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZVp1Kh9ePdTIP4PY9Va+CuAtPIW5XqjAK0WxIkPuas=;
 b=8pX3M0tcQnRNFaWt5BcyYr77OulewM9BsInN0kb4zc0Vgl0Gd9rc0lrg7cwxcUuUOzQwtZ
 vORSl0NIqtOn1xDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZVp1Kh9ePdTIP4PY9Va+CuAtPIW5XqjAK0WxIkPuas=;
 b=POIH8eOQwPNWwTz31GTJxLqNRG6MVwjcyau7weBBpESlEu+bBg0Qv34g1Q2uCheG6rxa9F
 U4ed+o4aj8xUJ5MIf6d3gU1Ylzx6AZTVdS77Bc5s0tkHuUxtAgjmml/otGXU/8nIRPl9il
 kJlrD17KvYao0RQTMy/n7vWUz9RzpeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468975;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZVp1Kh9ePdTIP4PY9Va+CuAtPIW5XqjAK0WxIkPuas=;
 b=8pX3M0tcQnRNFaWt5BcyYr77OulewM9BsInN0kb4zc0Vgl0Gd9rc0lrg7cwxcUuUOzQwtZ
 vORSl0NIqtOn1xDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CF78139D0;
 Tue, 20 Feb 2024 22:42:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8EnpGO0q1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:42:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v4 32/34] monitor: fdset: Match against O_DIRECT
Date: Tue, 20 Feb 2024 19:41:36 -0300
Message-Id: <20240220224138.24759-33-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [3.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[39.01%]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Extend the fdset matching function to behave the same with the
O_DIRECT flag.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 monitor/fds.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/monitor/fds.c b/monitor/fds.c
index 9a28e4b72b..42bf3eb982 100644
--- a/monitor/fds.c
+++ b/monitor/fds.c
@@ -413,6 +413,12 @@ static bool monitor_fdset_flags_match(int flags, int fd_flags)
 
     if ((flags & O_ACCMODE) == (fd_flags & O_ACCMODE)) {
         match = true;
+
+#ifdef O_DIRECT
+        if ((flags & O_DIRECT) != (fd_flags & O_DIRECT)) {
+            match = false;
+        }
+#endif
     }
 
     return match;
-- 
2.35.3


