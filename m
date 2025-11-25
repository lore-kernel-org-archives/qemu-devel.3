Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46714D0E6E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 13:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNsrO-0001UG-5T; Tue, 25 Nov 2025 08:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>) id 1vNsrK-0001LC-Vx
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 08:13:31 -0500
Received: from out28-55.mail.aliyun.com ([115.124.28.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>) id 1vNsrE-00087z-W2
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 08:13:29 -0500
Received: from Sun.localdomain(mailfrom:mail@jiesong.me
 fp:SMTPD_---.fVdMqEa_1764076381 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 25 Nov 2025 21:13:07 +0800
From: Jie Song <mail@jiesong.me>
To: marcandre.lureau@gmail.com
Cc: armbru@redhat.com, berrange@redhat.com, eblake@redhat.com, mail@jiesong.me,
 qemu-devel@nongnu.org, songjie_yewu@cmss.chinamobile.com
Subject: Re: [PATCH v3] monitor/qmp: cleanup SocketChardev listener sources
 early to avoid fd handling race
Date: Tue, 25 Nov 2025 21:12:58 +0800
Message-ID: <20251125131259.9527-1-mail@jiesong.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJ+F1CLhRbqLzaXcm9XizpJgNgwX2Dy0L34aKLSRUrxCOHQSgA@mail.gmail.com>
References: <CAJ+F1CLhRbqLzaXcm9XizpJgNgwX2Dy0L34aKLSRUrxCOHQSgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.55; envelope-from=mail@jiesong.me;
 helo=out28-55.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

> Hi
> 
> On Sat, Nov 22, 2025 at 7:33=E2=80=AFAM Jie Song <mail@jiesong.me> wrote:
> >
> > From: Jie Song <songjie_yewu@cmss.chinamobile.com>
> >
> > When starting a dummy QEMU process with virsh version, monitor_init_qmp()
> > enables IOThread monitoring of the QMP fd by default. However, a race
> > condition exists during the initialization phase: the IOThread only remov=
> es
> > the main thread's fd watch when it reaches qio_net_listener_set_client_fu=
> nc_full(),
> > which may be delayed under high system load.
> >
> > This creates a window between monitor_qmp_setup_handlers_bh() and
> > qio_net_listener_set_client_func_full() where both the main thread and
> > IOThread are simultaneously monitoring the same fd and processing events.
> > This race can cause either the main thread or the IOThread to hang and
> > become unresponsive.
> 
> Ok, but do you have a backtrace of a hang to share?
> 
> >
> > Fix this by proactively cleaning up the listener's IO sources in
> > monitor_init_qmp() before the IOThread initializes QMP monitoring,
> > ensuring exclusive fd ownership and eliminating the race condition.
> >
> > Signed-off-by: Jie Song <songjie_yewu@cmss.chinamobile.com>
> > ---
> > Changes in v3:
> > - Use a more general method to fix the problem.
> > - Link to v2:
> >   https://lore.kernel.org/qemu-devel/20251117150142.131694-1-mail@jiesong=
> .me/
> > - Link to v1:
> >   https://lore.kernel.org/qemu-devel/20251111150144.76751-1-mail@jiesong.=
> me/
> > ---
> >  chardev/char-io.c         | 8 ++++++++
> >  chardev/char-socket.c     | 9 +++++++++
> >  include/chardev/char-io.h | 2 ++
> >  include/chardev/char.h    | 2 ++
> >  monitor/qmp.c             | 5 +++++
> >  5 files changed, 26 insertions(+)
> >
> > diff --git a/chardev/char-io.c b/chardev/char-io.c
> > index 3be17b51ca..998282e526 100644
> > --- a/chardev/char-io.c
> > +++ b/chardev/char-io.c
> > @@ -182,3 +182,11 @@ int io_channel_send(QIOChannel *ioc, const void *buf=
> , size_t len)
> >  {
> >      return io_channel_send_full(ioc, buf, len, NULL, 0);
> >  }
> > +
> > +void remove_listaner_fd_in_watch(Chardev *chr)
> > +{
> > +    ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
> > +    if (cc->chr_listener_cleanup) {
> > +        cc->chr_listener_cleanup(chr);
> > +    }
> > +}
> 
> I wonder if this code shouldn't just be added to remove_fd_in_watch()
> instead. It would need careful review of all existing users,
> nevermind.
> 
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index 26d2f11202..39b3a76638 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -1570,6 +1570,14 @@ char_socket_get_connected(Object *obj, Error **err=
> p)
> >      return s->state =3D=3D TCP_CHARDEV_STATE_CONNECTED;
> >  }
> >
> > +static void tcp_chr_listener_cleanup(Chardev *chr)
> > +{
> > +    SocketChardev *s =3D SOCKET_CHARDEV(chr);
> > +    if (s->listener)
> > +        qio_net_listener_set_client_func_full(s->listener, NULL, NULL,
> > +                                              NULL, chr->gcontext);
> 
> Add braces
> 
> > +}
> > +
> >  static void char_socket_class_init(ObjectClass *oc, const void *data)
> >  {
> >      ChardevClass *cc =3D CHARDEV_CLASS(oc);
> > @@ -1587,6 +1595,7 @@ static void char_socket_class_init(ObjectClass *oc,=
>  const void *data)
> >      cc->chr_add_client =3D tcp_chr_add_client;
> >      cc->chr_add_watch =3D tcp_chr_add_watch;
> >      cc->chr_update_read_handler =3D tcp_chr_update_read_handler;
> > +    cc->chr_listener_cleanup =3D tcp_chr_listener_cleanup;
> >
> >      object_class_property_add(oc, "addr", "SocketAddress",
> >                                char_socket_get_addr, NULL,
> > diff --git a/include/chardev/char-io.h b/include/chardev/char-io.h
> > index ac379ea70e..087a250c70 100644
> > --- a/include/chardev/char-io.h
> > +++ b/include/chardev/char-io.h
> > @@ -43,4 +43,6 @@ int io_channel_send(QIOChannel *ioc, const void *buf, s=
> ize_t len);
> >  int io_channel_send_full(QIOChannel *ioc, const void *buf, size_t len,
> >                           int *fds, size_t nfds);
> >
> > +void remove_listaner_fd_in_watch(Chardev *chr);
> > +
> >  #endif /* CHAR_IO_H */
> > diff --git a/include/chardev/char.h b/include/chardev/char.h
> > index b65e9981c1..192cad67d4 100644
> > --- a/include/chardev/char.h
> > +++ b/include/chardev/char.h
> > @@ -307,6 +307,8 @@ struct ChardevClass {
> >
> >      /* handle various events */
> >      void (*chr_be_event)(Chardev *s, QEMUChrEvent event);
> > +
> > +    void (*chr_listener_cleanup)(Chardev *chr);
> >  };
> >
> >  Chardev *qemu_chardev_new(const char *id, const char *typename,
> > diff --git a/monitor/qmp.c b/monitor/qmp.c
> > index cb99a12d94..e2b1c49ed6 100644
> > --- a/monitor/qmp.c
> > +++ b/monitor/qmp.c
> > @@ -537,6 +537,11 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Err=
> or **errp)
> >           * e.g. the chardev is in client mode, with wait=3Don.
> >           */
> >          remove_fd_in_watch(chr);
> > +        /*
> > +         * Clean up listener IO sources early to prevent racy fd
> > +         * handling between the main thread and the I/O thread.
> > +         */
> > +        remove_listaner_fd_in_watch(chr);
> >          /*
> >           * We can't call qemu_chr_fe_set_handlers() directly here
> >           * since chardev might be running in the monitor I/O
> > --
> > 2.43.0
> >
> >
> 
> otherwise, looks ok to me
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> 
> -- 
> Marc-André Lureau

Hi, Marc-André.

Thank you for your review and the valuable feedback on the patch.
I’ll address the points raised and submit a new patch soon.

Additionally, I’d like to share a backtrace of the hang that we encountered.
Please find it below:

gdb --args ./qemu-system-x86_64 -S -no-user-config -nodefaults -nographic \
 -machine none,accel=kvm:tcg \
 -qmp unix:/tmp/qmp-xxx/qmp.monitor,server=on,wait=off
nc -U /tmp/qmp-xxx/qmp.monitor

```
...
(gdb) i threads
  Id   Target Id                                          Frame
* 1    Thread 0x7ffff7a13c80 (LWP 4713) "qemu-system-x86" accept4 (fd=9, addr=..., addr_len=0x5555577c6de0, flags=524288)
    at ../sysdeps/unix/sysv/linux/accept4.c:29
  2    Thread 0x7ffff76fd6c0 (LWP 4716) "qemu-system-x86" syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
  3    Thread 0x7ffff6dfb6c0 (LWP 4737) "qemu-system-x86" accept4 (fd=9, addr=..., addr_len=0x7fffe8000f90, flags=524288)
    at ../sysdeps/unix/sysv/linux/accept4.c:29
(gdb) i b
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x000055555608f58c in monitor_init_qmp at ../monitor/qmp.c:516
        breakpoint already hit 1 time
2       breakpoint     keep y   0x00007ffff792b8c0 in accept4 at ../sysdeps/unix/sysv/linux/accept4.c:29
        breakpoint already hit 2 times
(gdb) bt
#0  accept4 (fd=9, addr=..., addr_len=0x5555577c6de0, flags=524288) at ../sysdeps/unix/sysv/linux/accept4.c:29
#1  0x000055555615a01d in qemu_accept (s=9, addr=0x5555577c6d60, addrlen=0x5555577c6de0) at ../util/osdep.c:483
#2  0x0000555555f64ddb in qio_channel_socket_accept (ioc=0x5555577c46f0, errp=0x0) at ../io/channel-socket.c:407
#3  0x0000555555f6e585 in qio_net_listener_channel_func (ioc=0x5555577c46f0, condition=G_IO_IN, opaque=0x5555577c42b0) 
    at ../io/net-listener.c:64
#4  0x0000555555f67eee in qio_channel_fd_source_dispatch (source=0x5555577c4be0, callback=0x555555f6e50e
    <qio_net_listener_channel_func>, user_data=0x5555577c42b0) 
    at ../io/channel-watch.c:84
#5  0x00007ffff7bc049e in ??? () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
#6  0x00007ffff7bc0710 in g_main_context_dispatch () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
#7  0x000055555617f74e in glib_pollfds_poll () at ../util/main-loop.c:290
#8  0x000055555617f7e0 in os_host_main_loop_wait (timeout=-1) at ../util/main-loop.c:313
#9  0x000055555617f91b in main_loop_wait (nonblocking=0) at ../util/main-loop.c:592
#10 0x0000555555c3fe91 in qemu_main_loop () at ../system/runstate.c:903
#11 0x000055555608fff0 in qemu_default_main (opaque=0x0) at ../system/main.c:50
#12 0x00005555560900ae in main (argc=9, argv=0x7fffffffdd98) at ../system/main.c:93
(gdb) t 3
[Switching to thread 3 (Thread 0x7ffff6dfb6c0 (LWP 4737))]
#0  accept4 (fd=9, addr=..., addr_len=0x7fffe8000f90, flags=524288) at ../sysdeps/unix/sysv/linux/accept4.c:29
29      in ../sysdeps/unix/sysv/linux/accept4.c
(gdb) bt
#0  accept4 (fd=9, addr=..., addr_len=0x7fffe8000f90, flags=524288) at ../sysdeps/unix/sysv/linux/accept4.c:29
#1  0x000055555615a01d in qemu_accept (s=9, addr=0x7fffe8000f10, addrlen=0x7fffe8000f90) at ../util/osdep.c:483
#2  0x0000555555f64ddb in qio_channel_socket_accept (ioc=0x5555577c46f0, errp=0x0) at ../io/channel-socket.c:407
#3  0x0000555555f6e585 in qio_net_listener_channel_func (ioc=0x5555577c46f0, condition=G_IO_IN, opaque=0x5555577c42b0) 
    at ../io/net-listener.c:64
#4  0x0000555555f67eee in qio_channel_fd_source_dispatch (source=0x7fffe8000c50, callback=0x555555f6e50e 
    <qio_net_listener_channel_func>, user_data=0x5555577c42b0)
    at ../io/channel-watch.c:84
#5  0x00007ffff7bc049e in ??? () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
#6  0x00007ffff7c1f737 in ??? () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
#7  0x00007ffff7bc0f87 in g_main_loop_run () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
#8  0x0000555555f971fa in iothread_run (opaque=0x555557573ce0) at ../iothread.c:70
#9  0x000055555616431b in qemu_thread_start (args=0x555557570590) at ../util/qemu-thread-posix.c:393
#10 0x00007ffff789caa4 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:447
#11 0x00007ffff7929c6c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78
```

Both the main thread and the io thread will call accept4, and the one called later will get stuck.

