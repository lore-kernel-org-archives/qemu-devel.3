Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEE0C0218D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 02:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdK3q-0008R1-FS; Wed, 29 Jan 2025 21:13:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1tdK3p-0008Qq-04
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 21:13:41 -0500
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1tdK3n-00079L-2c; Wed, 29 Jan 2025 21:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=iXJbLk/PigKn4WNm9Io25NtoNrttE3JAQ7eMTV1E3Eo=; b=sLKf1GRgTkdjMobAKZWX
 7a3EElJASy/zYu4JOjC8iAnY8WbicGTC4O13YnzHtU9uAMqVBNefoara/7z3w3v0H9/0rjNFjYvYE
 zZcjo9h2Tp+l2xP4lRHMLz8+paFOz//4tb4WHJex3LJuC78REw2CCpOD7ANJlERknT4+qqr6qmpO1
 WMm5S0D7ubDbIvCehdRsIpDCON0kPvokjnEj5fAfdlIlQUOATP1z+8d+jqw34L2Ei5zmnIxew6u4x
 mMIEIsObqn0UEtMUUJmbNEJH1nckAGwxZDmmgt7TE99pbjcc4+j/QyU0zV+x86mgP/lmHWkHdmboB
 WzlhhqX/+E2pmg==;
Date: Thu, 30 Jan 2025 03:13:36 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] net/slirp: introduce slirp_os_socket to stay compatible
 with libslirp past 4.8.0
Message-ID: <Z5rgUDDB0X58-XZt@begin>
References: <20241005070753.1328079-1-mjt@tls.msk.ru> <ZwcMh1Vl9VsTbIRq@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwcMh1Vl9VsTbIRq@begin>
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

Hello,

Samuel Thibault, le jeu. 10 oct. 2024 01:06:47 +0200, a ecrit:
> Michael Tokarev, le sam. 05 oct. 2024 10:07:53 +0300, a ecrit:
> > libslirp introduced new typedef after 4.8.0, slirp_os_socket, which
> > is defined to SOCKET on windows, which, in turn, is a 64bit number.
> > qemu uses int, so callback function prorotypes changed.
> 
> I have fixed the code in upstream libslirp, to avoid breaking the API
> and ABI, and instead provide new functions & methods so that
> qemu/libslirp can upgrade smoothly.

It is now released in version 4.9.0 of libslirp.

Samuel

> > Introduce
> > slirp_os_socket locally if SLIRP_INVALID_SOCKET is not defined (this
> > define has been introduced together wiht slirp_os_socket type), for
> > libslirp <= 4.8.0, and use it in callback function definitions.
> > 
> > Link: https://gitlab.freedesktop.org/slirp/libslirp/-/commit/72f85005a2307fd0961543e3cea861ad7a4d201e
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2603
> > Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> > ---
> >  net/slirp.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/slirp.c b/net/slirp.c
> > index eb9a456ed4..fa07268cf4 100644
> > --- a/net/slirp.c
> > +++ b/net/slirp.c
> > @@ -98,6 +98,10 @@ typedef struct SlirpState {
> >      GSList *fwd;
> >  } SlirpState;
> >  
> > +#ifndef SLIRP_INVALID_SOCKET /* after 4.8.0 */
> 
> You can instead use SLIRP_CONFIG_VERSION_MAX >= 6, and if so set
> cfg.version to 6 and use the new fields and functions.
> 
> > +typedef int slirp_os_socket;
> > +#endif
> > +
> >  static struct slirp_config_str *slirp_configs;
> >  static QTAILQ_HEAD(, SlirpState) slirp_stacks =
> >      QTAILQ_HEAD_INITIALIZER(slirp_stacks);
> > @@ -247,7 +251,7 @@ static void net_slirp_timer_mod(void *timer, int64_t expire_timer,
> >      timer_mod(&t->timer, expire_timer);
> >  }
> >  
> > -static void net_slirp_register_poll_fd(int fd, void *opaque)
> > +static void net_slirp_register_poll_fd(slirp_os_socket fd, void *opaque)
> >  {
> >  #ifdef WIN32
> >      AioContext *ctxt = qemu_get_aio_context();
> > @@ -260,7 +264,7 @@ static void net_slirp_register_poll_fd(int fd, void *opaque)
> >  #endif
> >  }
> >  
> > -static void net_slirp_unregister_poll_fd(int fd, void *opaque)
> > +static void net_slirp_unregister_poll_fd(slirp_os_socket fd, void *opaque)
> >  {
> >  #ifdef WIN32
> >      if (WSAEventSelect(fd, NULL, 0) != 0) {
> > @@ -314,7 +318,7 @@ static int slirp_poll_to_gio(int events)
> >      return ret;
> >  }
> >  
> > -static int net_slirp_add_poll(int fd, int events, void *opaque)
> > +static int net_slirp_add_poll(slirp_os_socket fd, int events, void *opaque)
> >  {
> >      GArray *pollfds = opaque;
> >      GPollFD pfd = {
> > -- 
> > 2.39.5

-- 
Samuel
c> ah (on trouve fluide glacial sur le net, ou il faut aller dans le monde reel ?)
s> dans le monde reel
c> zut

