Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E937C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 12:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdTiB-0002wA-SH; Thu, 30 Jan 2025 07:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1tdTi8-0002vT-Fc; Thu, 30 Jan 2025 07:31:56 -0500
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1tdTi8-0002Xx-6B; Thu, 30 Jan 2025 07:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=EAibwlh47tTV7StW38Tzn6UTSGf6GEWN0DKwOqQFUdg=; b=TH9lavyfnBUTyvPCIUZG
 IhvBtrAZf8KrHHEVkkEddtoHvQ+ReJhtVA+g/wPqfXlacBjv8u+7XxakHH+VRHCkVOVe4/yGbDstI
 XLvuru7wnZZZRXaMOb+6h6rKv5QoSAXbNsGHgWSzyq8zMi4DgzxsOpSBoNQ/1DKlGKk4UUsfq5qlc
 bWrThl/gz5hlz+43fVTjqkv4rUU0P5awoDgevvpdyPZ/kIfrqZ0F5d3AGM+JRVd8MLTDkJf0WsHIT
 TQS0Egq3D+ZUL628GSUHWR1K1jUja2OEWMt3jel4ANKt+nl+3DYyADPy4C3zEjoojdWC32vFB0cp0
 oO5C24GowOU9LQ==;
Date: Thu, 30 Jan 2025 13:31:53 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v3] net/slirp: libslirp 4.8.0 compatibility
Message-ID: <Z5txOfhRVytJXKXj@begin>
References: <20250130114810.857224-1-mjt@tls.msk.ru>
 <c445afee-582d-46f7-a3eb-6b04f3b6cdee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c445afee-582d-46f7-a3eb-6b04f3b6cdee@redhat.com>
Organization: I am not organized
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

Thomas Huth, le jeu. 30 janv. 2025 13:21:23 +0100, a ecrit:
> On 30/01/2025 12.48, Michael Tokarev wrote:
> > Update the code in net/slirp.c to be compatible with
> > libslirp 4.8.0, which deprecated slirp_pollfds_fill()
> > and started using slirp_os_socket type for sockets
> > (which is a 64-bit integer on win64) for all callbacks
> > starting with version 6 of the interface.
> > 
> > Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> > ---
> > v2: update other callbacks too, use version 6 of the interface
> > v3: commit the changes before sending (*_sock => *_socket)
> > 
> >   net/slirp.c | 25 +++++++++++++++++--------
> >   1 file changed, 17 insertions(+), 8 deletions(-)
> > 
> > diff --git a/net/slirp.c b/net/slirp.c
> > index eb9a456ed4..2d2a58a6ee 100644
> > --- a/net/slirp.c
> > +++ b/net/slirp.c
> > @@ -247,7 +247,14 @@ static void net_slirp_timer_mod(void *timer, int64_t expire_timer,
> >       timer_mod(&t->timer, expire_timer);
> >   }
> > -static void net_slirp_register_poll_fd(int fd, void *opaque)
> > +#if !SLIRP_CHECK_VERSION(4,8,0)

Shouldn't this be 4,9,0?

> > +# define slirp_os_socket int
> > +# define slirp_pollfds_fill_socket slirp_pollfds_fill
> > +# define register_poll_socket register_poll_fd
> 
> If I get that right, register_poll_socket has just been added to libslirp
> 4.9.0, but is not available with 4.8.0 yet?

Yes. None of these are defined in 4.8.0

> ... so you might need to split
> the #if into two parts, one for 4.8.0 and one for 4.9.0 ?

This is just defining what is in 4.9.0 but never before, so it should be
fine with just a ≥ 4.9.0 section.

Samuel

> > +# define unregister_poll_socket unregister_poll_fd
> > +#endif
> > +
> > +static void net_slirp_register_poll_sock(slirp_os_socket fd, void *opaque)
> >   {
> >   #ifdef WIN32
> >       AioContext *ctxt = qemu_get_aio_context();
> > @@ -260,7 +267,7 @@ static void net_slirp_register_poll_fd(int fd, void *opaque)
> >   #endif
> >   }
> > -static void net_slirp_unregister_poll_fd(int fd, void *opaque)
> > +static void net_slirp_unregister_poll_sock(slirp_os_socket fd, void *opaque)
> >   {
> >   #ifdef WIN32
> >       if (WSAEventSelect(fd, NULL, 0) != 0) {
> > @@ -286,8 +293,8 @@ static const SlirpCb slirp_cb = {
> >   #endif
> >       .timer_free = net_slirp_timer_free,
> >       .timer_mod = net_slirp_timer_mod,
> > -    .register_poll_fd = net_slirp_register_poll_fd,
> > -    .unregister_poll_fd = net_slirp_unregister_poll_fd,
> > +    .register_poll_socket = net_slirp_register_poll_sock,
> > +    .unregister_poll_socket = net_slirp_unregister_poll_sock,
> >       .notify = net_slirp_notify,
> >   };
> > @@ -314,7 +321,7 @@ static int slirp_poll_to_gio(int events)
> >       return ret;
> >   }
> > -static int net_slirp_add_poll(int fd, int events, void *opaque)
> > +static int net_slirp_add_poll(slirp_os_socket fd, int events, void *opaque)
> >   {
> >       GArray *pollfds = opaque;
> >       GPollFD pfd = {
> > @@ -363,8 +370,8 @@ static void net_slirp_poll_notify(Notifier *notifier, void *data)
> >       switch (poll->state) {
> >       case MAIN_LOOP_POLL_FILL:
> > -        slirp_pollfds_fill(s->slirp, &poll->timeout,
> > -                           net_slirp_add_poll, poll->pollfds);
> > +        slirp_pollfds_fill_socket(s->slirp, &poll->timeout,
> > +                                  net_slirp_add_poll, poll->pollfds);
> >           break;
> >       case MAIN_LOOP_POLL_OK:
> >       case MAIN_LOOP_POLL_ERR:
> > @@ -629,7 +636,9 @@ static int net_slirp_init(NetClientState *peer, const char *model,
> >       s = DO_UPCAST(SlirpState, nc, nc);
> > -    cfg.version = SLIRP_CHECK_VERSION(4,7,0) ? 4 : 1;
> > +    cfg.version =
> > +         SLIRP_CHECK_VERSION(4,8,0) ? 6 :
> > +         SLIRP_CHECK_VERSION(4,7,0) ? 4 : 1;
> >       cfg.restricted = restricted;
> >       cfg.in_enabled = ipv4;
> >       cfg.vnetwork = net;
> 

-- 
Samuel
<T> l'autre jour j'ai eu un type qu'est venu me demander « J'ai installé le
logiciel comme indiqué sur le site. Puis quand je le lance ça plante et ça me
marque “Voulez-vous envoyez un rapport d'erreur ?”. Je fais quoi ?! »
  -+- ... -+-

