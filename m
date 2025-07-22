Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90257C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 23:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueMdF-0002QN-6v; Tue, 22 Jul 2025 19:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ueMdE-0002PT-AL
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 19:42:48 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ueMdB-0007rX-Dv
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 19:42:47 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 518221F7A0;
 Tue, 22 Jul 2025 23:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753227749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9T7mh+QJ0Qn3+vuo5odbDBZt5ruNTk4Dn/PbWX7kUc=;
 b=e3OTUtmJCGof/dBk1b8i8uRuMo0L8vXTNVyytbI8XErVF/XdFIG/u4Q/bjsMD/bzMCumUp
 vJIHEmT4DsSC9VfWPbLeeUzSgMrqg/L1Wy0AYSCJJyJ61pgYZBeIRdZBVLayP4QFdQ4VgS
 Qu62rmOC/t3vbZfezsrwTWQmw8VGEZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753227749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9T7mh+QJ0Qn3+vuo5odbDBZt5ruNTk4Dn/PbWX7kUc=;
 b=dr56fBFEdMNWd18oqHzRFAhsqY/zk5J7IZUYTwQNfjWUXV9x/2C/adzkRmHUQQGmU2YmRB
 XLAH1z3QAzoVQEAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=e3OTUtmJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dr56fBFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753227749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9T7mh+QJ0Qn3+vuo5odbDBZt5ruNTk4Dn/PbWX7kUc=;
 b=e3OTUtmJCGof/dBk1b8i8uRuMo0L8vXTNVyytbI8XErVF/XdFIG/u4Q/bjsMD/bzMCumUp
 vJIHEmT4DsSC9VfWPbLeeUzSgMrqg/L1Wy0AYSCJJyJ61pgYZBeIRdZBVLayP4QFdQ4VgS
 Qu62rmOC/t3vbZfezsrwTWQmw8VGEZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753227749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9T7mh+QJ0Qn3+vuo5odbDBZt5ruNTk4Dn/PbWX7kUc=;
 b=dr56fBFEdMNWd18oqHzRFAhsqY/zk5J7IZUYTwQNfjWUXV9x/2C/adzkRmHUQQGmU2YmRB
 XLAH1z3QAzoVQEAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3EE913A32;
 Tue, 22 Jul 2025 23:42:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wCH8K+MhgGiqOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 22 Jul 2025 23:42:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 5/7] io: add support for activating TLS thread safety workaround
Date: Tue, 22 Jul 2025 20:42:13 -0300
Message-Id: <20250722234215.6807-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250722234215.6807-1-farosas@suse.de>
References: <20250722234215.6807-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 518221F7A0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Add a QIO_CHANNEL_FEATURE_CONCURRENT_IO feature flag.

If this is set on a QIOChannelTLS session object, the TLS
session will be marked as requiring thread safety, which
will activate the workaround for GNUTLS bug 1717 if needed.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/20250718150514.2635338-3-berrange@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/io/channel.h | 1 +
 io/channel-tls.c     | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index 62b657109c..234e5db70d 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -46,6 +46,7 @@ enum QIOChannelFeature {
     QIO_CHANNEL_FEATURE_WRITE_ZERO_COPY,
     QIO_CHANNEL_FEATURE_READ_MSG_PEEK,
     QIO_CHANNEL_FEATURE_SEEKABLE,
+    QIO_CHANNEL_FEATURE_CONCURRENT_IO,
 };
 
 
diff --git a/io/channel-tls.c b/io/channel-tls.c
index db2ac1deae..a8248a9216 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -241,6 +241,11 @@ void qio_channel_tls_handshake(QIOChannelTLS *ioc,
 {
     QIOTask *task;
 
+    if (qio_channel_has_feature(QIO_CHANNEL(ioc),
+                                QIO_CHANNEL_FEATURE_CONCURRENT_IO)) {
+        qcrypto_tls_session_require_thread_safety(ioc->session);
+    }
+
     task = qio_task_new(OBJECT(ioc),
                         func, opaque, destroy);
 
-- 
2.35.3


