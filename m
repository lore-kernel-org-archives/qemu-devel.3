Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7D0C3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 22:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFgwL-0006aC-GM; Thu, 15 May 2025 18:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uFgwJ-0006YB-PL
 for qemu-devel@nongnu.org; Thu, 15 May 2025 18:20:31 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uFgwD-0000Y2-RZ
 for qemu-devel@nongnu.org; Thu, 15 May 2025 18:20:31 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 98228218E0;
 Thu, 15 May 2025 22:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747347621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=De0gjRa3T5YCe7yJyKnDVayes1vb36P+Z2zMRdyCnAA=;
 b=ykqL7LuWaSALMuZrIT+6GZIo/epzIP8eI81JVpXCLWKVYGnUxf+e9xRq7Lh9F/68vNoypj
 Fj5RsirI2ylbvB5XhABVUBOfz7K3pRCki8TOb5xu7VTP79p3zdnwEaXejXENkqUjX8dAMY
 kmnUwFtBDEDWDz5gtl3h0AuLfBDyPSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747347621;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=De0gjRa3T5YCe7yJyKnDVayes1vb36P+Z2zMRdyCnAA=;
 b=AmAJr0ZxyZ2QU6ZOhCQ85g+1I3TCEgFZMf1mgP1HPQw7v5RgRzhj5ZWru6xjdu3JLfhDSs
 BPOJKAcH9KeyiDBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ykqL7LuW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AmAJr0Zx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747347621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=De0gjRa3T5YCe7yJyKnDVayes1vb36P+Z2zMRdyCnAA=;
 b=ykqL7LuWaSALMuZrIT+6GZIo/epzIP8eI81JVpXCLWKVYGnUxf+e9xRq7Lh9F/68vNoypj
 Fj5RsirI2ylbvB5XhABVUBOfz7K3pRCki8TOb5xu7VTP79p3zdnwEaXejXENkqUjX8dAMY
 kmnUwFtBDEDWDz5gtl3h0AuLfBDyPSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747347621;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=De0gjRa3T5YCe7yJyKnDVayes1vb36P+Z2zMRdyCnAA=;
 b=AmAJr0ZxyZ2QU6ZOhCQ85g+1I3TCEgFZMf1mgP1HPQw7v5RgRzhj5ZWru6xjdu3JLfhDSs
 BPOJKAcH9KeyiDBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F11FA137E8;
 Thu, 15 May 2025 22:20:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WAA7K6NoJmhUNgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 15 May 2025 22:20:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	berrange@redhat.com,
	pbonzini@redhat.com
Subject: [PATCH 1/4] chardev: Fix QIOChannel refcount
Date: Thu, 15 May 2025 19:20:11 -0300
Message-Id: <20250515222014.4161-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250515222014.4161-1-farosas@suse.de>
References: <20250515222014.4161-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 98228218E0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_NONE(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

The IOWatchPoll holds a reference to the iochannel while the "child"
source (iwp->src) is removed from the context and freed. Freeing the
source leads to the iochannel being also freed at
qio_channel_fd_source_finalize().

Later, io_watch_poll_prepare() tries to create another source with the
same iochannel and hits an use after free:

==8241==ERROR: AddressSanitizer: heap-use-after-free on address 0x514000000040
READ of size 8 at 0x514000000040 thread T2
    #0 0x561c2d272fcd in object_get_class  ../qom/object.c:1043:17
    #1 0x561c2d338f84 in QIO_CHANNEL_GET_CLASS  include/io/channel.h:29:1
    #2 0x561c2d33b26f in qio_channel_create_watch  ../io/channel.c:388:30
    #3 0x561c2d2f0993 in io_watch_poll_prepare  ../chardev/char-io.c:65:20
    ...

0x514000000040 is located 0 bytes inside of 392-byte region [0x514000000040,0x5140000001c8)
freed by thread T2 here:
    #0 0x561c2d2319a5 in free
    #1 0x7fb2c0926638 in g_free
    #2 0x561c2d276507 in object_finalize  ../qom/object.c:734:9
    #3 0x561c2d271d0d in object_unref  ../qom/object.c:1231:9
    #4 0x561c2d32ef1d in qio_channel_fd_source_finalize  ../io/channel-watch.c:95:5
    #5 0x7fb2c091d124 in g_source_unref_internal ../glib/gmain.c:2298
    #6 0x561c2d2f0b6c in io_watch_poll_prepare  ../chardev/char-io.c:71:9
    ...

previously allocated by thread T3 (connect) here:
    #0 0x561c2d231c69 in malloc
    #1 0x7fb2c0926518 in g_malloc
    #2 0x561c2d27246e in object_new_with_type  ../qom/object.c:767:15
    #3 0x561c2d272530 in object_new  ../qom/object.c:789:12
    #4 0x561c2d320193 in qio_channel_socket_new  ../io/channel-socket.c:64:31
    #5 0x561c2d308013 in tcp_chr_connect_client_async  ../chardev/char-socket.c:1181:12
    #6 0x561c2d3002e7 in qmp_chardev_open_socket_client  ../chardev/char-socket.c:1281:9
    ...

Fix the issue by incrementing the iochannel reference count when the
IOWatchPoll takes a reference and decrementing when it is finalized.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 chardev/char-io.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/chardev/char-io.c b/chardev/char-io.c
index 3be17b51ca..d9b11f335f 100644
--- a/chardev/char-io.c
+++ b/chardev/char-io.c
@@ -88,6 +88,9 @@ static gboolean io_watch_poll_dispatch(GSource *source, GSourceFunc callback,
 static void io_watch_poll_finalize(GSource *source)
 {
     IOWatchPoll *iwp = io_watch_poll_from_source(source);
+
+    object_unref(OBJECT(iwp->ioc));
+
     if (iwp->src) {
         g_source_destroy(iwp->src);
         g_source_unref(iwp->src);
@@ -117,6 +120,8 @@ GSource *io_add_watch_poll(Chardev *chr,
     iwp->fd_can_read = fd_can_read;
     iwp->opaque = user_data;
     iwp->ioc = ioc;
+    object_ref(OBJECT(iwp->ioc));
+
     iwp->fd_read = (GSourceFunc) fd_read;
     iwp->src = NULL;
     iwp->context = context;
-- 
2.35.3


