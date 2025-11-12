Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCBACCF9E3
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 15:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJCpw-0004N9-8t; Wed, 12 Nov 2025 10:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>) id 1vJCoo-0003YD-3k
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 10:31:34 -0500
Received: from out28-78.mail.aliyun.com ([115.124.28.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>) id 1vJCoh-0002r8-Tj
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 10:31:33 -0500
Received: from Sun.localdomain(mailfrom:mail@jiesong.me
 fp:SMTPD_---.fKuO.7o_1762961464 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 12 Nov 2025 23:31:11 +0800
From: Jie Song <mail@jiesong.me>
To: armbru@redhat.com
Cc: berrange@redhat.com, mail@jiesong.me, qemu-devel@nongnu.org,
 songjie_yewu@cmss.chinamobile.com
Subject: Re: [PATCH] monitor/qmp: cleanup socket listener sources early to
 avoid fd handling race
Date: Wed, 12 Nov 2025 23:31:04 +0800
Message-ID: <20251112153104.21104-1-mail@jiesong.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87a50r8w3g.fsf@pond.sub.org>
References: <87a50r8w3g.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.78; envelope-from=mail@jiesong.me;
 helo=out28-78.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

> Daniel, is this in your area of expertise?
> 
> Jie Song, can you identify the commit that introduced the bug?
> 
> Jie Song <mail@jiesong.me> writes:
> 
> > From: Jie Song <songjie_yewu@cmss.chinamobile.com>
> >
> > When starting a dummy QEMU process with virsh, monitor_init_qmp() enables
> > IOThread monitoring of the QMP fd by default. However, a race condition
> > exists during the initialization phase: the IOThread only removes the
> > main thread's fd watch when it reaches qio_net_listener_set_client_func_full(),
> > which may be delayed under high system load.
> >
> > This creates a window between monitor_qmp_setup_handlers_bh() and
> > qio_net_listener_set_client_func_full() where both the main thread and
> > IOThread are simultaneously monitoring the same fd and processing events.
> > This race can cause either the main thread or the IOThread to hang and
> > become unresponsive.
> >
> > Fix this by proactively cleaning up the listener's IO sources in
> > monitor_init_qmp() before the IOThread initializes QMP monitoring,
> > ensuring exclusive fd ownership and eliminating the race condition.
> >
> > The fix introduces socket_chr_listener_cleanup() to destroy and unref
> > all existing IO sources on the socket chardev listener, guaranteeing
> > that no concurrent fd monitoring occurs during the transition to
> > IOThread handling.
> >
> > Signed-off-by: Jie Song <songjie_yewu@cmss.chinamobile.com>
> > ---
> >  chardev/char-socket.c         | 18 ++++++++++++++++++
> >  include/chardev/char-socket.h |  2 ++
> >  monitor/qmp.c                 |  6 ++++++
> >  3 files changed, 26 insertions(+)
> >
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index 62852e3caf..073a9da855 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -656,6 +656,24 @@ static void tcp_chr_telnet_destroy(SocketChardev *s)
> >      }
> >  }
> >  
> > +void socket_chr_listener_cleanup(Chardev *chr)
> > +{
> > +    SocketChardev *s = SOCKET_CHARDEV(chr);
> > +
> > +    if (s->listener) {
> > +        QIONetListener *listener = s->listener;
> > +        size_t i;
> > +
> > +        for (i = 0; i < listener->nsioc; i++) {
> > +            if (listener->io_source[i]) {
> > +                g_source_destroy(listener->io_source[i]);
> > +                g_source_unref(listener->io_source[i]);
> > +                listener->io_source[i] = NULL;
> > +            }
> > +        }
> > +    }
> > +}
> > +
> >  static void tcp_chr_update_read_handler(Chardev *chr)
> >  {
> >      SocketChardev *s = SOCKET_CHARDEV(chr);
> > diff --git a/include/chardev/char-socket.h b/include/chardev/char-socket.h
> > index d6d13ad37f..682440c6de 100644
> > --- a/include/chardev/char-socket.h
> > +++ b/include/chardev/char-socket.h
> > @@ -84,4 +84,6 @@ typedef struct SocketChardev SocketChardev;
> >  DECLARE_INSTANCE_CHECKER(SocketChardev, SOCKET_CHARDEV,
> >                           TYPE_CHARDEV_SOCKET)
> >  
> > +void socket_chr_listener_cleanup(Chardev *chr);
> > +
> >  #endif /* CHAR_SOCKET_H */
> > diff --git a/monitor/qmp.c b/monitor/qmp.c
> > index cb99a12d94..d9d1fafa70 100644
> > --- a/monitor/qmp.c
> > +++ b/monitor/qmp.c
> > @@ -25,6 +25,7 @@
> >  #include "qemu/osdep.h"
> >  
> >  #include "chardev/char-io.h"
> > +#include "chardev/char-socket.h"
> >  #include "monitor-internal.h"
> >  #include "qapi/error.h"
> >  #include "qapi/qapi-commands-control.h"
> > @@ -537,6 +538,11 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
> >           * e.g. the chardev is in client mode, with wait=on.
> >           */
> >          remove_fd_in_watch(chr);
> > +        /*
> > +         * Clean up listener IO sources early to prevent racy fd
> > +         * handling between the main thread and the I/O thread.
> > +         */
> > +        socket_chr_listener_cleanup(chr);
> >          /*
> >           * We can't call qemu_chr_fe_set_handlers() directly here
> >           * since chardev might be running in the monitor I/O

Hi Markus,

Thank you for the question.

The issue you're referring to is not tied to any specific commit but rather 
arises from the current process flow. Specifically, in scenarios like the one 
with virsh starting a dummy QEMU process, the following command line may
triggers the bug:
`/usr/bin/qemu-system-x86_64 -S -no-user-config -nodefaults -nographic -machine
none,accel=tcg -qmp unix:/var/lib/libvirt/qemu/qmp-xxx/qmp.monitor,server=on,wait=off`

We can reproduce this issue using gdb with the following steps:
  1.Pause the I/O thread: Execute monitor_init_qmp in the main thread, and before 
    aio_bh_schedule_oneshot is called, suspend the I/O thread (scheduler-locking on). 
    This simulates a high load scenario.
  2.Set a breakpoint at qemu_accept: Allow the main thread to continue running. 
    The main thread will reach qemu_accept, and at this point, the main thread will 
    be listening for the corresponding chardev (the QMP socket).
  3.Simulate a client connection: Use nc -U to simulate a client connecting to the 
    Unix socket. The main thread will detect the event and hit the breakpoint at qemu_accept.
  4.Resume the I/O thread: Now, switch to the I/O thread and allow it to run. 
    It will also reach the qemu_accept breakpoint, creating a race condition where 
    both threads are handling the same accept event.

This race causes either the main thread or the IOThread to hang and become unresponsive.

The issue stems from the window between when the main thread sets up the listener watch and
when the IOThread takes over exclusive ownership. Under normal conditions this window is 
very small, but under high load or with specific timing, both threads can end up processing 
events on the same fd simultaneously.

I hope this explanation clarifies the issue. 

Best regards,
Jie Song

