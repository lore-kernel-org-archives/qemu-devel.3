Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264A9C02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 14:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgPLE-0001Wg-WE; Fri, 07 Feb 2025 09:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgPLD-0001WT-NY
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:28:23 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgPLC-0000AR-3t
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:28:23 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 73EC221167;
 Fri,  7 Feb 2025 14:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738938499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4LhTZ3XjAU5lIgBN4zZO13ECclz2zlfauidAgULZzoY=;
 b=S6QzvsXOPlroMutlIauVlWzhuOr/9Ylzl6mdbMUfwbt4lAkXTT8tJpnAWhM3NJCR7NE+iQ
 LmxgN8kvM8+1RJX9LhX/d8TBhy1fUfcDLHfuTQ5BBgp8Te6tHhlREGrv1sdDyM5+8ouyLj
 HkMVI5GFxDDQcBvy08evgkpNh7SO3Jg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738938499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4LhTZ3XjAU5lIgBN4zZO13ECclz2zlfauidAgULZzoY=;
 b=9OfrW0C6H4yW91Y2GoqlhQmuDiBhT6MFReLZYddqGZn4Eh+8P2TCuKkiPysnRTtvUQMkde
 Mi14kBpDPRW0BQBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738938499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4LhTZ3XjAU5lIgBN4zZO13ECclz2zlfauidAgULZzoY=;
 b=S6QzvsXOPlroMutlIauVlWzhuOr/9Ylzl6mdbMUfwbt4lAkXTT8tJpnAWhM3NJCR7NE+iQ
 LmxgN8kvM8+1RJX9LhX/d8TBhy1fUfcDLHfuTQ5BBgp8Te6tHhlREGrv1sdDyM5+8ouyLj
 HkMVI5GFxDDQcBvy08evgkpNh7SO3Jg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738938499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4LhTZ3XjAU5lIgBN4zZO13ECclz2zlfauidAgULZzoY=;
 b=9OfrW0C6H4yW91Y2GoqlhQmuDiBhT6MFReLZYddqGZn4Eh+8P2TCuKkiPysnRTtvUQMkde
 Mi14kBpDPRW0BQBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1F9C139CB;
 Fri,  7 Feb 2025 14:28:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gASFI4EYpmcoOwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Feb 2025 14:28:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH v2 7/8] io: Add a read flag for relaxed EOF
Date: Fri,  7 Feb 2025 11:27:57 -0300
Message-Id: <20250207142758.6936-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250207142758.6936-1-farosas@suse.de>
References: <20250207142758.6936-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
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

Add a read flag that can inform a channel that it's ok to receive an
EOF at any moment. Channels that have some form of strict EOF
tracking, such as TLS session termination, may choose to ignore EOF
errors with the use of this flag.

This is being added for compatibility with older migration streams
that do not include a TLS termination step.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/io/channel.h | 1 +
 io/channel-tls.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index 6110f0ffe9..55d70fb853 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -35,6 +35,7 @@ OBJECT_DECLARE_TYPE(QIOChannel, QIOChannelClass,
 #define QIO_CHANNEL_WRITE_FLAG_ZERO_COPY 0x1
 
 #define QIO_CHANNEL_READ_FLAG_MSG_PEEK 0x1
+#define QIO_CHANNEL_READ_FLAG_RELAXED_EOF 0x2
 
 typedef enum QIOChannelFeature QIOChannelFeature;
 
diff --git a/io/channel-tls.c b/io/channel-tls.c
index ecde6b57bf..caf8301a9e 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -359,6 +359,7 @@ static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
             tioc->session,
             iov[i].iov_base,
             iov[i].iov_len,
+            flags & QIO_CHANNEL_READ_FLAG_RELAXED_EOF ||
             qatomic_load_acquire(&tioc->shutdown) & QIO_CHANNEL_SHUTDOWN_READ,
             errp);
         if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {
-- 
2.35.3


