Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E88BC0218D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 12:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdTmI-0005HW-Db; Thu, 30 Jan 2025 07:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1tdTmG-0005H7-Mc; Thu, 30 Jan 2025 07:36:12 -0500
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1tdTmG-00039g-6O; Thu, 30 Jan 2025 07:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=RsWXZoYmg6y5SC08NjCPAv9kDw0y6mEiuTnP39CxVhI=; b=BGBEaOJrDKPIvLs0h27I
 E9JI0Pt+EP81LZRAI5xNpfqoZMp37z6A2bVaIyoxDn8p4nd3LDC4uTbgdBJ25fwC1FY2RTKb4kCmW
 pgwzVJ9ZY2aCJyvlB3xCGnLUIh+wCU9sSRZdmk2xqKjTHpAltWi5/C18ywC9Epe8gMfsCdJvVBlKR
 av5v65eGP7As3+c0xK9HzC3gnIUYdEaOxTsw4ETThV6YTpnrsywf8YMBmtzvgl6cafBhzcDhcjZ3V
 mgcwTf3mjsP6E523nQbzmYbNBpk9fbETQ0my9NSkuN31iRWZWmhixJT4DlEs9viwVvlIRIT+ElXHF
 15Od/FiK8vUSGg==;
Date: Thu, 30 Jan 2025 13:36:09 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v4] net/slirp: libslirp 4.9.0 compatibility
Message-ID: <Z5tyORoVNNg608Ma@begin>
References: <20250130123253.864681-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130123253.864681-1-mjt@tls.msk.ru>
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

Michael Tokarev, le jeu. 30 janv. 2025 15:32:53 +0300, a ecrit:
> Update the code in net/slirp.c to be compatible with
> libslirp 4.9.0, which deprecated slirp_pollfds_fill()
> and started using slirp_os_socket type for sockets
> (which is a 64-bit integer on win64) for all callbacks
> starting with version 6 of the interface.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thanks!

> ---
> v2: update other callbacks too, use version 6 of the interface
> v3: commit the changes before sending (*_sock => *_socket)
> v4: version is 4.9.0, not 4.8.0
> 
>  net/slirp.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/net/slirp.c b/net/slirp.c
> index eb9a456ed4..c61a93f3fa 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -247,7 +247,14 @@ static void net_slirp_timer_mod(void *timer, int64_t expire_timer,
>      timer_mod(&t->timer, expire_timer);
>  }
>  
> -static void net_slirp_register_poll_fd(int fd, void *opaque)
> +#if !SLIRP_CHECK_VERSION(4,9,0)
> +# define slirp_os_socket int
> +# define slirp_pollfds_fill_socket slirp_pollfds_fill
> +# define register_poll_socket register_poll_fd
> +# define unregister_poll_socket unregister_poll_fd
> +#endif
> +
> +static void net_slirp_register_poll_sock(slirp_os_socket fd, void *opaque)
>  {
>  #ifdef WIN32
>      AioContext *ctxt = qemu_get_aio_context();
> @@ -260,7 +267,7 @@ static void net_slirp_register_poll_fd(int fd, void *opaque)
>  #endif
>  }
>  
> -static void net_slirp_unregister_poll_fd(int fd, void *opaque)
> +static void net_slirp_unregister_poll_sock(slirp_os_socket fd, void *opaque)
>  {
>  #ifdef WIN32
>      if (WSAEventSelect(fd, NULL, 0) != 0) {
> @@ -286,8 +293,8 @@ static const SlirpCb slirp_cb = {
>  #endif
>      .timer_free = net_slirp_timer_free,
>      .timer_mod = net_slirp_timer_mod,
> -    .register_poll_fd = net_slirp_register_poll_fd,
> -    .unregister_poll_fd = net_slirp_unregister_poll_fd,
> +    .register_poll_socket = net_slirp_register_poll_sock,
> +    .unregister_poll_socket = net_slirp_unregister_poll_sock,
>      .notify = net_slirp_notify,
>  };
>  
> @@ -314,7 +321,7 @@ static int slirp_poll_to_gio(int events)
>      return ret;
>  }
>  
> -static int net_slirp_add_poll(int fd, int events, void *opaque)
> +static int net_slirp_add_poll(slirp_os_socket fd, int events, void *opaque)
>  {
>      GArray *pollfds = opaque;
>      GPollFD pfd = {
> @@ -363,8 +370,8 @@ static void net_slirp_poll_notify(Notifier *notifier, void *data)
>  
>      switch (poll->state) {
>      case MAIN_LOOP_POLL_FILL:
> -        slirp_pollfds_fill(s->slirp, &poll->timeout,
> -                           net_slirp_add_poll, poll->pollfds);
> +        slirp_pollfds_fill_socket(s->slirp, &poll->timeout,
> +                                  net_slirp_add_poll, poll->pollfds);
>          break;
>      case MAIN_LOOP_POLL_OK:
>      case MAIN_LOOP_POLL_ERR:
> @@ -629,7 +636,9 @@ static int net_slirp_init(NetClientState *peer, const char *model,
>  
>      s = DO_UPCAST(SlirpState, nc, nc);
>  
> -    cfg.version = SLIRP_CHECK_VERSION(4,7,0) ? 4 : 1;
> +    cfg.version =
> +         SLIRP_CHECK_VERSION(4,9,0) ? 6 :
> +         SLIRP_CHECK_VERSION(4,7,0) ? 4 : 1;
>      cfg.restricted = restricted;
>      cfg.in_enabled = ipv4;
>      cfg.vnetwork = net;
> -- 
> 2.39.5
> 

-- 
Samuel
X-Favorit-Cartoon: Calvin and Hobbes
 -+- Mail header of Wim van Dorst -+-

