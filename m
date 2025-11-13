Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4987ECD6E7D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 15:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJYyX-00071f-FF; Thu, 13 Nov 2025 10:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>) id 1vJYyC-0006DU-Iz
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 10:10:45 -0500
Received: from out28-65.mail.aliyun.com ([115.124.28.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@jiesong.me>) id 1vJYy8-0000Tz-Tw
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 10:10:43 -0500
Received: from Sun.localdomain(mailfrom:mail@jiesong.me
 fp:SMTPD_---.fLjnf.0_1763046623 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 13 Nov 2025 23:10:29 +0800
From: mail@jiesong.me
To: eblake@redhat.com
Cc: armbru@redhat.com, berrange@redhat.com, mail@jiesong.me,
 qemu-devel@nongnu.org, songjie_yewu@cmss.chinamobile.com
Subject: Re: [PATCH] monitor/qmp: cleanup socket listener sources early to
 avoid fd handling race
Date: Thu, 13 Nov 2025 23:10:23 +0800
Message-ID: <20251113151023.41440-1-mail@jiesong.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cslgtf2v45soo57j2qfrkefitokjkhpywllz6wait4d2nx5yt6@q34i6bk37gvk>
References: <cslgtf2v45soo57j2qfrkefitokjkhpywllz6wait4d2nx5yt6@q34i6bk37gvk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.65; envelope-from=mail@jiesong.me;
 helo=out28-65.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> On Tue, Nov 11, 2025 at 11:01:44PM +0800, Jie Song wrote:
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
> 
> This directly accesses listener->nsioc outside of net-listener.c.
> I've got a pending patch that frowns on this type of usage (here's the
> link to v2; v3 is coming soon):
> 
> https://lore.kernel.org/qemu-devel/20251108230525.3169174-14-eblake@redhat.com/T/#m69a13da54c24ad55351b6a004ec1c0cba7a7b49c
> 
> But it might be possible to do what you want without peeking inside
> the listener; have you tested calling
> qio_net_listener_set_client_func_full() to change the callback to NULL
> prior to doing the handover to iothread, and then reregistering
> tcp_chr_accept after that point?
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org

Hi Eric,

Thanks a lot for the detailed feedback! You're absolutely right—the current
patch does have issues with encapsulation by directly accessing internal 
listener structures like nsioc. 

I took your advice and tested it: before the I/O thread initializes 
the QMP listener, call qio_net_listener_set_client_func_full() with the callback
set to NULL. This effectively purges the main thread's fd watch without any 
new helper functions, and then the I/O thread can safely re-register tcp_chr_accept. 

Besides, Daniel also raised a solid concern in his reply: the chardev backend 
isn't guaranteed to be a SocketChardev type, so blindly calling a socket-specific 
cleanup could lead to crashes. 
https://lore.kernel.org/qemu-devel/20251112145743.15075-1-mail@jiesong.me/

The v1 patch needs to be modified. I'll iterate on a v2 incorporating 
both your NULL-callback advice and Daniel's robustness improvements. 

Best regards,
Jie Song 

