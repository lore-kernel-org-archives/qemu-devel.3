Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB26CCA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN59-0004pn-NU; Wed, 07 Oct 2026 04:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEHlY-0006Tb-Ua
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:52:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEHlJ-0004Qy-Al
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791341346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QHMg9Evu6BsL4KAtm7L3QgUAF+Ch4RbqNyIfur6xzew=;
 b=avUDPZ0lSkDmAG0J3KT5/QNnfxp2SlwrnKYXiHOUG7XPwvKlbAwRhU8rZBIeJG5XYW5tYs
 AMko7a+lJmQJ7eXsWFUJG61iVfFiRqhBDSqlM92hX82elXiO86hwZdRrGJVozxQjQD/t/w
 WLuCx7nwWpw31yZRq7uM5gfUy3b2Ps0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-lvMMr7MKOcCi93luRlYwbQ-1; Tue, 06 Oct 2026 14:21:00 -0400
X-MC-Unique: lvMMr7MKOcCi93luRlYwbQ-1
X-Mimecast-MFC-AGG-ID: lvMMr7MKOcCi93luRlYwbQ_1791310859
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ae8e7e546so576819585a.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 11:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791310859; x=1791915659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QHMg9Evu6BsL4KAtm7L3QgUAF+Ch4RbqNyIfur6xzew=;
 b=XfYqMFpMZYrJoPJwpsgPpc8gpVxJac57TPG7jS0Mprtemrj7pjSh9V0GjVUJs4ShN0
 1NvYo7qIUqGYdBcKQg5FLFNcQr0KosMbn5VXqmfIbkg+AbzNtSWtaX/b08JBREDadfV0
 0GLq6mC7tQj/0iD9gsGMtJh6d5A4qXzXNhGJX3/M4UXZiT3EK9ze5USjIMKlXP4AxQAJ
 GpbUWVrs0HV6J+0c7oPURsybXirzwad+1BFlhtgUkm3wvKMVi+8BeSzqE9pQq2JruFjT
 KiDkimSpMSOMf/Bj39zlysvx3/E1K2i3LaTywIaBzLVQm3as2QUO+Q3OBD1XRbV/kpN1
 n+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791310859; x=1791915659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QHMg9Evu6BsL4KAtm7L3QgUAF+Ch4RbqNyIfur6xzew=;
 b=zWyto2yTaVjA0Dp+sYBF7aQ2mFGI7J2HgaBeUfaM0acAFY9r5K4ubkUMwHtUYirzGg
 /0x78x9R1duwbR0+xeWVYaXpVrUFi98Jt+88FHwhWTQn8sLewEvfXh3UCrfyCA/LR/SP
 sqAO5EFVMo/nkYS1pV2xF1Zjaief32/W4RxRPUWi4Qfg/LnFhJ3zJ/qKzLYOE5GeDya8
 PB5YLNJ4MOQbGbYdoJSKr4a4v53c7auxx0ZR9I/sucY+GHhR0mTlQBfxl1uZW0eAyz07
 icVhulA2l/BL5dbiDQ2SlqEvFtmoX/m6AWuJnDXDnZALZk4TyW2XJme4X+HyKhGbyfgx
 D+rQ==
X-Gm-Message-State: AFuF++kix3MVtZc3PFXkLhGnNEU10Qzyf7+LXKC7yPB+l50W0tF//DdW
 Bbau8IcStzgrjfFAEwI1PQz0wRyg2fJ8L5AC2Id/Ue9e1LE1Etw3UsEKnl2hc1U8R/8UlqrCDjG
 6vQcNNJCgzA6DCjxQWiLf+SLCZWl5iyUJQW3bvW6y4HqsvHa8RcIrkrVD31kr1CwSd1y/funzcY
 qg0btKvW+vt/gw/UW+O4EC7JBaPs1k/6Caq4rhew==
X-Gm-Gg: AYBFou3lKNHNIQug1dIjg4HT+/0rtMt+Y+Zzoy2XShfB8nyGxxEXUcL+AZWqwAsRM+N
 4pF/v9tYcWKstSyrhBdudlkbVZcC5dcCQnYxZv3e2TNu+LlD2dyqHdYzpdKxPB5+ePdS83hwPzD
 vTdaJ7DfRPOm3z9SyB6GS6os6V0Px6dxf8gS6HlB5K3F5zYGgtBt8cRoCnX5+xvFD//Jb6C3KQm
 MXV5ifntyYgdMcbTgjxIncyTCTVAe1NdAvAopXtsrSU7dE//87fhEvvM3FcETgqI7eqJJV5463E
 XYV3xz2pw9VIhO6mzAlSvPHc+tu8onFMT5ZcjjJ2nbxwlBA8O5aJ54fD+HVEvFHVieyUwoc=
X-Received: by 2002:a05:620a:4494:b0:93e:6ff1:b67c with SMTP id
 af79cd13be357-93e8f205862mr437537385a.20.1791310858065; 
 Tue, 06 Oct 2026 11:20:58 -0700 (PDT)
X-Received: by 2002:a05:620a:4494:b0:93e:6ff1:b67c with SMTP id
 af79cd13be357-93e8f205862mr437528185a.20.1791310857054; 
 Tue, 06 Oct 2026 11:20:57 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93e991eca24sm19396985a.39.2026.10.06.11.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 11:20:56 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 6/7] migration: Fix incoming channel race with multifd and
 preempt_pre_7_2
Date: Tue,  6 Oct 2026 14:20:45 -0400
Message-ID: <20261006182046.3767283-7-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006182046.3767283-1-peterx@redhat.com>
References: <20261006182046.3767283-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

PROBLEM
=======

Migration reliably hangs with old machine types (7.2-) when these migration
capabilities are enabled: multifd, postcopy-ram, postcopy-preempt.

Simplest reproducer :

  $ QTEST_QEMU_MACHINE_TYPE=pc-q35-7.2 \
      QTEST_QEMU_BINARY=./qemu-system-x86_64 \
      ./tests/qtest/migration-test --full \
      -r /x86_64/migration/multifd+postcopy/preempt/plain

Current workaround is to kill destination QEMU, cancel the migration on
source (with/without yank), disable one or more of the features, and retry.

The hang is caused by receiving preempt channel before most of the multifd
channels, the peek buffer operation will stuck forever.

Incoming side QEMU hang (with relevant tracepoints enabled):

  migrate_set_state new state setup
  migration_socket_incoming_accepted
  migration_set_incoming_channel ioc=0x557d82c1caa0 ioctype=qio-channel-socket
  migration_socket_incoming_accepted
  migration_set_incoming_channel ioc=0x557d83023840 ioctype=qio-channel-socket
  multifd_recv_new_channel channel 1
  migration_socket_incoming_accepted
  migration_set_incoming_channel ioc=0x557d830c08c0 ioctype=qio-channel-socket
  multifd_recv_new_channel channel 0
  multifd_recv_thread_start 1
  migration_socket_incoming_accepted
  migration_set_incoming_channel ioc=0x557d8284a010 ioctype=qio-channel-socket
  multifd_recv_thread_start 0
  multifd_recv_unfill channel 0 packet_num 0 flags 0x1 next packet size 0
  multifd_recv_unfill channel 1 packet_num 1 flags 0x1 next packet size 0
  [dest qemu hangs here]

Incoming side backtrace:

  __syscall_cancel_arch
  __internal_syscall_cancel
  __syscall_cancel
  recvmsg
  qio_channel_socket_readv
  qio_channel_readv_full
  migration_channel_read_peek
  migration_channel_identify
  migration_channel_process_incoming
  socket_accept_incoming_migration
  qio_net_listener_channel_func
  qio_channel_fd_source_dispatch
  g_main_context_dispatch_unlocked.lto_priv
  g_main_context_dispatch
  glib_pollfds_poll
  os_host_main_loop_wait
  main_loop_wait
  qemu_main_loop
  qemu_default_main
  main

This patch tries to fix it, from incoming side first.  This patch alone
should enable single-direction migration to this new QEMU.  The next patch
will propose a fix for the outgoing path, fixing new->old migrations.

BACKGROUND
==========

preempt_pre_7_2 used to be a flag marking QEMU releases 7.1/7.2 only
because they have a flaw on channel establishment on preempt channel.

Now, after we have multifd + postcopy support, new QEMU binaries can
migrate old machine types with both features enabled.  Juraj reported
constant migration hang at the very beginning for those old machine types
in our downstream systems with such setup.  Juraj found it's because of
this flag.

QEMU source initiates channels in this order on current master when both
features enabled with postcopy-preempt mode (machine type 7.2, implies
preempt_pre_7_2=on):

  - First, main channel connect() happens,
  - Second, postcopy_preempt_setup() invokes connect() for preempt channel,
  - Last, in migration_thread(), multifd_send_setup() invokes connect()s
    for all the multifd channels

However on an old QEMU, it expect the channels arrive in order of
"main"->"multifd"->"preempt".  Even on a new QEMU, the destination expects
the same order of arrival on the channels when the channels are not
peekable.

For peekable channels (non-tls sockets), this time we'll likely see preempt
channel appearing very soon, peeking at it causing main thread hang, like
mentioned in the PROBLEM section above.

SOLUTION
========

One major problem of current hang is we try to peek at preempt channel,
which offers nothing at the beginning.

Since we'll need to accept stream from old binaries (QEMU 10.1 to 11.1),
arrival of preempt channel early is unavoidable.

What we can do, though, is to allow concurrent monitoring of all channels
rather than one.  Meanwhile, we shouldn't peek at anything that has no
data.

migration_channel_read_peek() almost does the wait, but it's too late.
This patch proposes to watch all channels from the start without reading at
them at all, relying on an IO watch attached.  This will make sure (1) for
preempt channel, we never read on it (watch can be gracefully disarmed when
we know it's preempt channel later) (2) since we have one IO watch for each
channel, then we can allow accept() to happen in almost any order, process
only when there's some header to read.

To maintain these watches, a new GArray @channels_early is introduced, with
each element to be a (ioc, GSource) tuple (@MigEarlyIncomingChannel), so
that QEMU can manage all the IO watches later with it.  Here I used GSource
rather than io_tag because the GSource may or may not be attached to the
default main thread gcontext: when OOB is used, it may be the iothread
context instead.  IOW, g_source_remove() on io_tags stops working, which
only works for default main context.

The trick this patch used is when we have the ability to wait on all
channel headers at the same time, we pick one by one from main and multifd
channels (since both of the types will contain headers dumped right at the
very beginning), leave preempt channel alone.  It means, after dest QEMU
finds all main and multifd channels, there are three possibilities:

  - If preempt not enabled, we finished full channel establishment, done.

  - If preempt enabled,

    - If we have one registered IO watch with the IOC, it must be the
      preempt channel,

    - If we have no further IO watch, wait for the next accept(), which
      must be the preempt channel.

This will make channel establish work on incoming side even with the old
QEMU binaries.

While working on it, I managed to refactor the peeking logic quite a bit:
we used to have a very convoluted migration_channel_identify() function,
taking care of two different cases:

(1) when the channel is peekable (like normal socket channels),
(2) when the channel is not peekable (like TLS or file migrations).

This patch refactored that part to make it crystal clear on how we make
decisions on which channel is which, and split the peek/identify paths.

One example incoming migration from pc-q35-7.2 after this patch applied,
and with relevant tracepoints set (8 multifd channels, 1 preempt channel):

  migrate_set_state new state setup
  migration_channel_process_incoming ioc=0x557dc8af4e20 ioctype=qio-channel-socket
  migration_incoming_channel_watch ioc=0x557dc8af4e20 ioctype=qio-channel-socket
  migration_channel_process_incoming ioc=0x557dc8abc5d0 ioctype=qio-channel-socket
  migration_incoming_channel_watch ioc=0x557dc8abc5d0 ioctype=qio-channel-socket
  migration_channel_process_incoming ioc=0x557dc953d680 ioctype=qio-channel-socket
  migration_incoming_channel_watch ioc=0x557dc953d680 ioctype=qio-channel-socket
  migration_set_incoming_channel ioc=0x557dc8abc5d0 ioctype=qio-channel-socket type=MULTIFD
  migration_channel_process_incoming ioc=0x557dc898a820 ioctype=qio-channel-socket
  migration_incoming_channel_watch ioc=0x557dc898a820 ioctype=qio-channel-socket
  migration_set_incoming_channel ioc=0x557dc953d680 ioctype=qio-channel-socket type=MULTIFD
  migration_channel_process_incoming ioc=0x557dc919bd70 ioctype=qio-channel-socket
  migration_incoming_channel_watch ioc=0x557dc919bd70 ioctype=qio-channel-socket
  migration_set_incoming_channel ioc=0x557dc898a820 ioctype=qio-channel-socket type=MULTIFD
  migration_channel_process_incoming ioc=0x557dc8734b20 ioctype=qio-channel-socket
  migration_incoming_channel_watch ioc=0x557dc8734b20 ioctype=qio-channel-socket
  migration_set_incoming_channel ioc=0x557dc919bd70 ioctype=qio-channel-socket type=MULTIFD
  migration_channel_process_incoming ioc=0x557dc898bdf0 ioctype=qio-channel-socket
  migration_incoming_channel_watch ioc=0x557dc898bdf0 ioctype=qio-channel-socket
  migration_set_incoming_channel ioc=0x557dc8734b20 ioctype=qio-channel-socket type=MULTIFD
  migration_channel_process_incoming ioc=0x557dc968cfd0 ioctype=qio-channel-socket
  migration_incoming_channel_watch ioc=0x557dc968cfd0 ioctype=qio-channel-socket
  migration_set_incoming_channel ioc=0x557dc898bdf0 ioctype=qio-channel-socket type=MULTIFD
  migration_channel_process_incoming ioc=0x557dc8c31810 ioctype=qio-channel-socket
  migration_incoming_channel_watch ioc=0x557dc8c31810 ioctype=qio-channel-socket
  migration_set_incoming_channel ioc=0x557dc968cfd0 ioctype=qio-channel-socket type=MULTIFD
  migration_set_incoming_channel ioc=0x557dc8c31810 ioctype=qio-channel-socket type=MULTIFD
  migration_set_incoming_channel ioc=0x557dc8af4e20 ioctype=qio-channel-socket type=MAIN
  migration_start_incoming
  migrate_set_state new state active
  migration_channel_process_incoming ioc=0x557dc8966160 ioctype=qio-channel-socket
  migration_set_incoming_channel ioc=0x557dc8966160 ioctype=qio-channel-socket type=PREEMPT

While at it, I renamed the four channel incoming/outgoing tracepoints, make
all to follow migration_[incoming|outgoing]_channel_*().  Especially for
incoming, then we can enable migration_incoming_channel* for incoming
channel debuggings.

FINAL NOTE ON TLS
=================

Note that this solution isn't a magic bullet fixing everything.  TLS is not
fixable with this approach because TLS isn't peekable channel, hence the
watch won't help.

We can have other ways to hack it to make it work, e.g. we can make TLS
channels peekable too, but I don't want to pollute the TLS iochannel only
for this: let's hope handshake will arrive soon so we can drop these code.

For now, when TLS is involved with such old machine type (7.2-), one needs
to migrate it out with any combination of features except enabling all
four (multifd + TLS + postcopy + preempt) to a patched binary, after that,
all combinations will start working.

BugLink: https://redhat.atlassian.net/browse/RHEL-254933
Fixes: e27418861288 ("migration: enable multifd and postcopy together")
Reported-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/channel.h    |   3 +
 migration/migration.h  |  35 ++++
 migration/channel.c    | 413 +++++++++++++++++++++++++++++++++++------
 migration/migration.c  |  31 +++-
 migration/trace-events |   7 +-
 5 files changed, 418 insertions(+), 71 deletions(-)

diff --git a/migration/channel.h b/migration/channel.h
index 678712f291..40bd339a3e 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -49,4 +49,7 @@ bool migration_channel_parse_input(const char *uri,
                                    MigrationChannel **main_channelp,
                                    MigrationChannel **cpr_channelp,
                                    Error **errp);
+
+void migration_incoming_free_early_channels(MigrationIncomingState *mis);
+
 #endif
diff --git a/migration/migration.h b/migration/migration.h
index 683bc7bdd5..6f23e1805b 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -90,6 +90,28 @@ typedef enum {
     PREEMPT_THREAD_QUIT,
 } PreemptThreadStatus;
 
+typedef struct {
+    /*
+     * The GSource we have allocated to track G_IO_IN events for the
+     * channel.  Note: it may not be attached to the default main gcontext,
+     * for example, when in case of io watch created during an OOB
+     * migrate-recover command.
+     */
+    GSource *source;
+    /* The channel we will identify later after getting some buffers to read */
+    QIOChannel *ioc;
+} MigEarlyIncomingChannel;
+
+typedef struct {
+    GArray *channels;
+    /*
+     * In most cases, channels are only operated with BQl, but since we
+     * have OOB command support, don't assume it, just use a standalone
+     * mutex to protect any access to the channels array.
+     */
+    QemuMutex mutex;
+} MigEarlyIncomingChannels;
+
 /* State for the incoming migration */
 struct MigrationIncomingState {
     QEMUFile *from_src_file;
@@ -255,6 +277,19 @@ struct MigrationIncomingState {
 
     /* Do exit on incoming migration failure */
     bool exit_on_error;
+
+    /*
+     * Maintains all channels only at early stage.  After incoming
+     * migration started, this should be an empty array and no use anymore.
+     *
+     * TODO: we logically only need this to make new QEMU binaries work for
+     * old machines who have @preempt_pre_7_2 set on the source, but it's
+     * also good to have this early stage anyway, making sure when peek the
+     * channel there will be something in the channel.  Ideally, we should
+     * manage all migration channels in the future with proper headers,
+     * then we can drop this.
+     */
+    MigEarlyIncomingChannels channels_early;
 };
 
 MigrationIncomingState *migration_incoming_get_current(void);
diff --git a/migration/channel.c b/migration/channel.c
index b9065efd03..1aeb881485 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -12,6 +12,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/main-loop.h"
+#include "qemu/error-report.h"
 #include "channel.h"
 #include "exec.h"
 #include "fd.h"
@@ -146,61 +148,81 @@ bool migration_has_all_channels(void)
     return true;
 }
 
-static MigChannelType migration_channel_identify(MigrationIncomingState *mis,
-                                                 QIOChannel *ioc, Error **errp)
+static bool qio_channel_is_peekable(QIOChannel *ioc)
+{
+    return qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK);
+}
+
+/*
+ * With multiple channels, it is possible that we receive channels out of
+ * order on destination side, causing incorrect mapping of source channels
+ * on destination side.
+ *
+ * When the channel is peekable (e.g. non-TLS socket channels), check
+ * channel MAGIC to decide type of channel.
+ *
+ * Please note this is best effort, postcopy preempt channel does not send
+ * any magic number so avoid it for postcopy live migration.
+ *
+ * Returns: >0 if success, ==0 (CH_NONE) if error.  If error happened,
+ * *errp must be set.
+ */
+static MigChannelType migration_channel_peek(MigrationIncomingState *mis,
+                                             QIOChannel *ioc,
+                                             Error **errp)
 {
     MigChannelType channel = CH_NONE;
     uint32_t channel_magic = 0;
     int ret = 0;
 
-    if (!migration_has_main_and_multifd_channels()) {
-        if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
-            /*
-             * With multiple channels, it is possible that we receive channels
-             * out of order on destination side, causing incorrect mapping of
-             * source channels on destination side. Check channel MAGIC to
-             * decide type of channel. Please note this is best effort,
-             * postcopy preempt channel does not send any magic number so
-             * avoid it for postcopy live migration. Also tls live migration
-             * already does tls handshake while initializing main channel so
-             * with tls this issue is not possible.
-             */
-            ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
-                                              sizeof(channel_magic), errp);
-            if (ret != 0) {
-                goto out;
-            }
+    assert(qio_channel_is_peekable(ioc));
 
-            channel_magic = be32_to_cpu(channel_magic);
-            if (channel_magic == QEMU_VM_FILE_MAGIC) {
-                channel = CH_MAIN;
-            } else if (channel_magic == MULTIFD_MAGIC) {
-                assert(migrate_multifd());
-                channel = CH_MULTIFD;
-            } else if (!mis->from_src_file &&
-                        mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
-                /* reconnect main channel for postcopy recovery */
-                channel = CH_MAIN;
-            } else {
-                error_setg(errp, "unknown channel magic: %u", channel_magic);
-            }
-        } else if (mis->from_src_file && migrate_multifd()) {
-            /*
-             * Non-peekable channels like tls/file are processed as
-             * multifd channels when multifd is enabled.
-             */
-            channel = CH_MULTIFD;
-        } else if (!mis->from_src_file) {
-            channel = CH_MAIN;
-        } else {
-            error_setg(errp, "non-peekable channel used without multifd");
-        }
+    ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
+                                      sizeof(channel_magic), errp);
+    if (ret != 0) {
+        /* Failed */
+        return channel;
+    }
+
+    channel_magic = be32_to_cpu(channel_magic);
+
+    if (channel_magic == QEMU_VM_FILE_MAGIC) {
+        channel = CH_MAIN;
+    } else if (channel_magic == MULTIFD_MAGIC) {
+        assert(migrate_multifd());
+        channel = CH_MULTIFD;
+    } else if (!mis->from_src_file &&
+               mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+        /* reconnect main channel for postcopy recovery */
+        channel = CH_MAIN;
     } else {
-        assert(migrate_postcopy_preempt());
-        channel = CH_POSTCOPY;
+        error_setg(errp, "Unknown channel magic: %u", channel_magic);
+    }
+
+    return channel;
+}
+
+/*
+ * Returns: >0 if success, ==0 (CH_NONE) if error.  If error happened,
+ * *errp must be set.  NOTE: preempt channel is done separately.
+ */
+static MigChannelType migration_channel_identify(MigrationIncomingState *mis,
+                                                 QIOChannel *ioc, Error **errp)
+{
+    MigChannelType channel = CH_NONE;
+
+    if (!mis->from_src_file) {
+        channel = CH_MAIN;
+    } else if (migrate_multifd()) {
+        /*
+         * Non-peekable channels like tls/file are processed as
+         * multifd channels when multifd is enabled.
+         */
+        channel = CH_MULTIFD;
+    } else {
+        error_setg(errp, "Unexpected non-peekable channel observed");
     }
 
-out:
     return channel;
 }
 
@@ -214,33 +236,264 @@ static void migration_incoming_error_propagate(MigrationIncomingState *mis,
     }
 }
 
-static bool migration_incoming_channel_install(MigrationIncomingState *mis,
-                                               QIOChannel *ioc,
-                                               Error **errp)
+/* Must be with mis->channels_early.mutex held */
+static void
+migration_incoming_early_channel_insert(MigrationIncomingState *mis,
+                                        QIOChannel *ioc,
+                                        GSource *source)
 {
-    MigChannelType ch = migration_channel_identify(mis, ioc, errp);
+    MigEarlyIncomingChannel chan = {
+        .source = source,
+        .ioc = ioc,
+    };
 
-    if (!ch) {
-        assert(*errp);
-        return false;
+    object_ref(OBJECT(ioc));
+    g_source_ref(source);
+
+    g_array_append_val(mis->channels_early.channels, chan);
+}
+
+static void migration_incoming_early_channel_free(GArray *channels, int i)
+{
+    MigEarlyIncomingChannel *chan;
+
+    chan = &g_array_index(channels, MigEarlyIncomingChannel, i);
+
+    g_source_destroy(chan->source);
+    g_source_unref(chan->source);
+    object_unref(OBJECT(chan->ioc));
+
+    g_array_remove_index_fast(channels, i);
+}
+
+/*
+ * Remove this channel from the monitoring of @channels_early array.
+ * Return true if found and successful, false otherwise.
+ */
+static bool
+migration_incoming_early_channel_remove(MigrationIncomingState *mis,
+                                        QIOChannel *ioc)
+{
+    GArray *channels = mis->channels_early.channels;
+    MigEarlyIncomingChannel *chan;
+    int i;
+
+    QEMU_LOCK_GUARD(&mis->channels_early.mutex);
+
+    for (i = 0; i < channels->len; i++) {
+        chan = &g_array_index(channels, MigEarlyIncomingChannel, i);
+        if (chan->ioc != ioc) {
+            continue;
+        }
+        migration_incoming_early_channel_free(channels, i);
+        return true;
+    }
+
+    return false;
+}
+
+void migration_incoming_free_early_channels(MigrationIncomingState *mis)
+{
+    GArray *channels = mis->channels_early.channels;
+
+    QEMU_LOCK_GUARD(&mis->channels_early.mutex);
+
+    while (channels->len) {
+        migration_incoming_early_channel_free(channels, 0);
     }
+}
 
-    trace_migration_set_incoming_channel(ioc,
+static bool migration_incoming_setup_channel(QIOChannel *ioc,
+                                             MigChannelType ch,
+                                             Error **errp)
+{
+    trace_migration_incoming_channel_set(ioc,
                                          object_get_typename(OBJECT(ioc)),
                                          mig_channel_str[ch]);
     migration_ioc_register_yank(ioc);
 
-    if (migration_incoming_setup(ioc, ch, errp)) {
-        migration_start_incoming();
-    }
+    return migration_incoming_setup(ioc, ch, errp);
+}
 
-    if (*errp) {
+static bool migration_incoming_channel_install(MigrationIncomingState *mis,
+                                               QIOChannel *ioc,
+                                               MigChannelType ch,
+                                               Error **errp)
+{
+    if (!migration_incoming_setup_channel(ioc, ch, errp)) {
         return false;
     }
 
+    /* Installation succeeded, kickoff migration if needed */
+    if (migration_has_main_and_multifd_channels()) {
+        migration_start_incoming();
+    }
+
     return true;
 }
 
+static void
+migration_incoming_channel_preempt_setup(QIOChannel *ioc)
+{
+    assert(migrate_postcopy_preempt());
+    /* Installation of preempt channel should never fail */
+    migration_incoming_setup_channel(ioc, CH_POSTCOPY, &error_abort);
+}
+
+static void
+migration_incoming_detect_preempt_channel(MigrationIncomingState *mis)
+{
+    GArray *channels = mis->channels_early.channels;
+    MigEarlyIncomingChannel *chan;
+
+    QEMU_LOCK_GUARD(&mis->channels_early.mutex);
+
+    /* When preempt mode not enabled, nothing to detect.. */
+    if (!migrate_postcopy_preempt()) {
+        /*
+         * .. but if we found something pending, throw an error only, which
+         * should not happen.  Even if it happens, resources will still be
+         * released after incoming migration is completedly.
+         */
+        if (channels->len) {
+            error_report("%s: Found %u unused channels",
+                         __func__, channels->len);
+        }
+        return;
+    }
+
+    /* Preempt channel hasn't yet arrived?  Process it later */
+    if (!channels->len) {
+        return;
+    }
+
+    /*
+     * More than one channel should never happen.. capture it in case if
+     * it happens, then there's not much we can do.
+     */
+    if (channels->len > 1) {
+        error_report("%s: Found %u unused channels, "
+                     "can't identify preempt channel",
+                     __func__, channels->len);
+        return;
+    }
+
+    assert(channels->len == 1);
+    /* This is the preempt channel, install it directly */
+    chan = &g_array_index(channels, MigEarlyIncomingChannel, 0);
+    migration_incoming_channel_preempt_setup(chan->ioc);
+    migration_incoming_early_channel_free(channels, 0);
+}
+
+static gboolean migration_incoming_channel_readable(QIOChannel *ioc,
+                                                    GIOCondition condition,
+                                                    gpointer opaque)
+{
+    MigrationIncomingState *mis = opaque;
+    Error *local_err = NULL;
+    MigChannelType ch;
+
+    /*
+     * No need to monitor this channel anymore as long as anything arrived,
+     * remove it from tracking.
+     *
+     * NOTE: this means if partial data arrived we may still block here,
+     * but it shouldn't happen in production, only malicious stream.  Since
+     * migration stream is trusted (either due to trusted network, or TLS),
+     * that's non-issue.
+     *
+     * NOTE2: it's theoretically possible that this entry is gone reaching
+     * here. Example: the main thread is doing incoming cleanup having this
+     * one removed, while this watch can be registered on the monitor
+     * iothread's context and fired at the exact same time but in the
+     * iothread instead.  If it happens, skip the rest.  I'm not sure if
+     * this could happen at all, may depend on iothread lifespan management
+     * in the main thread, but be prepared.
+     */
+    if (!migration_incoming_early_channel_remove(mis, ioc)) {
+        goto out;
+    }
+
+    ch = migration_channel_peek(mis, ioc, &local_err);
+    if (!ch) {
+        goto out;
+    }
+
+    if (!migration_incoming_channel_install(mis, ioc, ch, &local_err)) {
+        goto out;
+    }
+
+    if (migration_has_main_and_multifd_channels()) {
+        /*
+         * Possibilities when reaching here:
+         *
+         * (1) if preempt not enabled, this should be no-op, all done,
+         * (2) if preempt enabled,
+         *   (2.a) preempt channel arrived @channels_early, handle it now
+         *   (2.b) preempt channel not arrived, to be handled in
+         *         migration_channel_process_incoming() later
+         */
+        migration_incoming_detect_preempt_channel(mis);
+    }
+
+out:
+    if (local_err) {
+        migration_incoming_error_propagate(mis, local_err);
+    }
+
+    /*
+     * NOTE: we should have already detached the GSource, returning
+     * G_SOURCE_REMOVE to be logically consistent only.
+     */
+    return G_SOURCE_REMOVE;
+}
+
+static void migration_incoming_channel_watch(MigrationIncomingState *mis,
+                                             QIOChannel *ioc)
+{
+    GMainContext *context = g_main_context_get_thread_default();
+    GSource *source;
+    guint io_tag;
+
+    trace_migration_incoming_channel_watch(ioc,
+                                           object_get_typename(OBJECT(ioc)));
+
+    /*
+     * Careful: this can be run from either the main thread or the monitor
+     * iothread when migrate_recover is used with OOB=on, so we need to
+     * take the lock and use the full version to specify the correct
+     * context.
+     */
+    QEMU_LOCK_GUARD(&mis->channels_early.mutex);
+
+    /*
+     * We should never watch an @ioc that is not peekable, because there's
+     * no point.  What is worse is we lose the real order of accept()s via
+     * the asynchronous IO watch operation.
+     *
+     * Another note is TLS channel (non-peekable) may or may not work
+     * properly with IO watch due to its current .io_create_watch() impl,
+     * which is another story.  Just guard both points.
+     */
+    assert(qio_channel_is_peekable(ioc));
+    io_tag = qio_channel_add_watch_full(ioc, G_IO_IN,
+                                        migration_incoming_channel_readable,
+                                        mis, NULL, context);
+
+    /*
+     * Replace this if one day qio_channel_add_watch*() API can directly
+     * return the GSource*.. for now, stick with it.
+     */
+    source = g_main_context_find_source_by_id(context, io_tag);
+    /*
+     * Nothing can race with adding the IO watch, aka, concurrent removal
+     * is not possible when we have the lock.  So it must be present.
+     */
+    assert(source);
+
+    migration_incoming_early_channel_insert(mis, ioc, source);
+}
+
 /**
  * @migration_channel_process_incoming - Create new incoming migration channel
  *
@@ -253,14 +506,52 @@ void migration_channel_process_incoming(QIOChannel *ioc)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     Error *local_err = NULL;
+    MigChannelType ch;
 
-    trace_migration_channel_process_incoming(
+    trace_migration_incoming_channel_process(
         ioc, object_get_typename(OBJECT(ioc)));
 
     if (migrate_channel_requires_tls_upgrade(ioc)) {
         migration_tls_channel_process_incoming(ioc, &local_err);
     } else {
-        migration_incoming_channel_install(mis, ioc, &local_err);
+        if (migration_has_main_and_multifd_channels()) {
+            /*
+             * If all main+multifd channels are present already, this must
+             * be the preempt channel.
+             *
+             * QEMU can't register an IO watch for it if there is only the
+             * last preempt channel left, because it means the IO watch
+             * will never fire and nobody will pick it up: we rely on the
+             * one before the last one to pick both.
+             *
+             * See comment in migration_incoming_channel_readable() on
+             * the migration_incoming_detect_preempt_channel() call.
+             */
+            migration_incoming_channel_preempt_setup(ioc);
+        } else {
+            if (qio_channel_is_peekable(ioc)) {
+                /*
+                 * Register an IO watch for the peekable channel, deciding
+                 * the type of channel later by peeking at it whenever
+                 * possible.  migration_incoming_channel_install() will be
+                 * postponed.
+                 */
+                migration_incoming_channel_watch(mis, ioc);
+            } else {
+                /*
+                 * Non-peekable channels (file, TLS, etc.), cannot register
+                 * IO watch because (1) there's nothing to peek, (2) after
+                 * registering IO watch, QEMU will lose the real ordering
+                 * it gets from accept(), which is still so far the only
+                 * source of truth to identify a channel in this case.
+                 */
+                ch = migration_channel_identify(mis, ioc, &local_err);
+                if (ch) {
+                    migration_incoming_channel_install(mis, ioc, ch,
+                                                       &local_err);
+                }
+            }
+        }
     }
 
     if (local_err) {
@@ -270,7 +561,7 @@ void migration_channel_process_incoming(QIOChannel *ioc)
 
 void migration_channel_connect_outgoing(MigrationState *s, QIOChannel *ioc)
 {
-    trace_migration_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)));
+    trace_migration_outgoing_channel_set(ioc, object_get_typename(OBJECT(ioc)));
 
     if (migrate_channel_requires_tls_upgrade(ioc)) {
         Error *local_err = NULL;
diff --git a/migration/migration.c b/migration/migration.c
index 3ffc0c2c6a..b140fb6950 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -334,6 +334,10 @@ void migration_object_init(void)
     current_incoming->page_requested = g_tree_new(page_request_addr_cmp);
 
     current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
+    /* zero_terminated=false, clear_=true (NOTE, "clear_" is not a typo) */
+    current_incoming->channels_early.channels =
+        g_array_new(FALSE, TRUE, sizeof(MigEarlyIncomingChannel));
+    qemu_mutex_init(&current_incoming->channels_early.mutex);
 
     migration_object_check(current_migration, &error_fatal);
 
@@ -447,6 +451,24 @@ void migration_incoming_state_destroy(void)
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyState ps = postcopy_state_get();
 
+    /* Cleanup listener to make sure no further accept() for sockets */
+    migration_incoming_transport_cleanup(mis);
+
+    /*
+     * It's safer to free channel watches earlier than most of the rest, in
+     * case the IO watches could fire in the monitor iothread concurrently
+     * against this function.
+     *
+     * Above migration_incoming_transport_cleanup() should have disarmed
+     * anything that we could accept() new sockets.
+     *
+     * Here return of migration_incoming_free_early_channels() makes sure
+     * even if something already fired concurrently, it won't really do
+     * anything but return - see migration_incoming_early_channel_remove()
+     * and its return code for details.
+     */
+    migration_incoming_free_early_channels(mis);
+
     multifd_recv_cleanup();
 
     if (ps != POSTCOPY_INCOMING_NONE) {
@@ -491,7 +513,6 @@ void migration_incoming_state_destroy(void)
         mis->postcopy_remote_fds = NULL;
     }
 
-    migration_incoming_transport_cleanup(mis);
     qemu_event_reset(&mis->main_thread_load_event);
 
     if (mis->page_requested) {
@@ -833,10 +854,6 @@ out:
     migrate_incoming_unref_outgoing_state();
 }
 
-/*
- * Returns whether all the necessary channels to proceed with the
- * incoming migration have been established without error.
- */
 bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
@@ -865,13 +882,13 @@ bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp)
         assert(!mis->postcopy_qemufile_dst);
         f = qemu_file_new_input(ioc);
         postcopy_preempt_new_channel(mis, f);
-        return false;
+        break;
 
     default:
         g_assert_not_reached();
     }
 
-    return migration_has_main_and_multifd_channels();
+    return true;
 }
 
 void migration_outgoing_setup(QIOChannel *ioc)
diff --git a/migration/trace-events b/migration/trace-events
index 8840d82f8d..a6e11451f1 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -207,9 +207,10 @@ migration_start_incoming(void) ""
 migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma) "qemu_file %" PRIu64 " multifd %" PRIu64 " RDMA %" PRIu64
 
 # channel.c
-migration_channel_process_incoming(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
-migration_set_incoming_channel(void *ioc, const char *ioctype, const char *type) "ioc=%p ioctype=%s type=%s"
-migration_set_outgoing_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
+migration_outgoing_channel_set(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
+migration_incoming_channel_process(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
+migration_incoming_channel_set(void *ioc, const char *ioctype, const char *type) "ioc=%p ioctype=%s type=%s"
+migration_incoming_channel_watch(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
 
 # global_state.c
 migrate_state_too_big(void) ""
-- 
2.55.0


