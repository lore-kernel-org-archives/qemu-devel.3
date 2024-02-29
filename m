Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8BAC54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfiMl-0005TP-Qj; Thu, 29 Feb 2024 10:30:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfiMi-0005SG-9x
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:30:32 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfiMf-0005r4-VH
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:30:32 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 439191F7F7;
 Thu, 29 Feb 2024 15:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709220626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qW5yUdTr0mwoltf/iGxZA8snBm043jlfeIZ97rn2OKk=;
 b=rwUaC6yrWhz5KZAXoLs0SDeVVIKDW7MA8Zzdvfw2pIJg+PwoQD+gmYbdvUX+ammKLDLenN
 v791MWDwLpPv/HisLdYTkpBxLHn7ZVq4X5Rk7b34cwdFGB7cyNjm21HttbJQw6qwblz5uy
 XsKl3j0USZ4VtYlIMpUiCDK0nvXjQZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709220626;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qW5yUdTr0mwoltf/iGxZA8snBm043jlfeIZ97rn2OKk=;
 b=NxaS3a91H8PuCOkDPzlew7Qp9EYk0vmbj+rzhVxozYr41dnRRj09F/D4ZsaRzzBWtAquD1
 /UpnvBjKBIm0jSAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709220626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qW5yUdTr0mwoltf/iGxZA8snBm043jlfeIZ97rn2OKk=;
 b=rwUaC6yrWhz5KZAXoLs0SDeVVIKDW7MA8Zzdvfw2pIJg+PwoQD+gmYbdvUX+ammKLDLenN
 v791MWDwLpPv/HisLdYTkpBxLHn7ZVq4X5Rk7b34cwdFGB7cyNjm21HttbJQw6qwblz5uy
 XsKl3j0USZ4VtYlIMpUiCDK0nvXjQZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709220626;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qW5yUdTr0mwoltf/iGxZA8snBm043jlfeIZ97rn2OKk=;
 b=NxaS3a91H8PuCOkDPzlew7Qp9EYk0vmbj+rzhVxozYr41dnRRj09F/D4ZsaRzzBWtAquD1
 /UpnvBjKBIm0jSAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 684F713503;
 Thu, 29 Feb 2024 15:30:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +DEfDBCj4GU/MAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 29 Feb 2024 15:30:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v6 02/23] io: add and implement QIO_CHANNEL_FEATURE_SEEKABLE
 for channel file
Date: Thu, 29 Feb 2024 12:29:56 -0300
Message-Id: <20240229153017.2221-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240229153017.2221-1-farosas@suse.de>
References: <20240229153017.2221-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.18 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.08)[95.52%]
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

From: Nikolay Borisov <nborisov@suse.com>

Add a generic QIOChannel feature SEEKABLE which would be used by the
qemu_file* apis. For the time being this will be only implemented for
file channels.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/io/channel.h | 1 +
 io/channel-file.c    | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index 5f9dbaab65..fcb19fd672 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -44,6 +44,7 @@ enum QIOChannelFeature {
     QIO_CHANNEL_FEATURE_LISTEN,
     QIO_CHANNEL_FEATURE_WRITE_ZERO_COPY,
     QIO_CHANNEL_FEATURE_READ_MSG_PEEK,
+    QIO_CHANNEL_FEATURE_SEEKABLE,
 };
 
 
diff --git a/io/channel-file.c b/io/channel-file.c
index 4a12c61886..f91bf6db1c 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -36,6 +36,10 @@ qio_channel_file_new_fd(int fd)
 
     ioc->fd = fd;
 
+    if (lseek(fd, 0, SEEK_CUR) != (off_t)-1) {
+        qio_channel_set_feature(QIO_CHANNEL(ioc), QIO_CHANNEL_FEATURE_SEEKABLE);
+    }
+
     trace_qio_channel_file_new_fd(ioc, fd);
 
     return ioc;
@@ -60,6 +64,10 @@ qio_channel_file_new_path(const char *path,
         return NULL;
     }
 
+    if (lseek(ioc->fd, 0, SEEK_CUR) != (off_t)-1) {
+        qio_channel_set_feature(QIO_CHANNEL(ioc), QIO_CHANNEL_FEATURE_SEEKABLE);
+    }
+
     trace_qio_channel_file_new_path(ioc, path, flags, mode, ioc->fd);
 
     return ioc;
-- 
2.35.3


