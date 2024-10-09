Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7741DCED611
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syfld-00064k-9n; Wed, 09 Oct 2024 19:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1syflc-00064a-8O
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:06:52 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1syflb-0000ST-3U; Wed, 09 Oct 2024 19:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=9KzF+zCv3e3V4AWfHS69GKYm50M0FGk2dTm/QpGneI0=; b=OehDX5JWIO1cxDPmDEvq
 2ur2snewEX3ddsZrrjX7t9fOOcdrFOKykIzTvy+hj76c1LW6bQWIwsFOpsr0Fq4jZ/apVbRCPXI1h
 IJztkqvroBR3XsQ6uwZ6sRvPM7alKsJQitpYmwPv2V0YwFCRkNNxN6MbVjPl1TQ53YzoeDFnnxxsb
 PeNlFFIUBl9LdW1KpXrJCgbvcT87+25k3WV4nSrrq8VtJXyPCg1DHb3j2/IQ8kXjUzRPONWd4FFn/
 81CLHIbXDg8rm+v+0LXlTlFJcxXD5Zkr3YtwbpqrLdKwwuaBDGZLyRHX7ITylgbwutdsLJCRR1MIS
 n0H4uBAQER0/Lg==;
Date: Thu, 10 Oct 2024 01:06:47 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] net/slirp: introduce slirp_os_socket to stay compatible
 with libslirp past 4.8.0
Message-ID: <ZwcMh1Vl9VsTbIRq@begin>
References: <20241005070753.1328079-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005070753.1328079-1-mjt@tls.msk.ru>
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

Michael Tokarev, le sam. 05 oct. 2024 10:07:53 +0300, a ecrit:
> libslirp introduced new typedef after 4.8.0, slirp_os_socket, which
> is defined to SOCKET on windows, which, in turn, is a 64bit number.
> qemu uses int, so callback function prorotypes changed.

I have fixed the code in upstream libslirp, to avoid breaking the API
and ABI, and instead provide new functions & methods so that
qemu/libslirp can upgrade smoothly.

> Introduce
> slirp_os_socket locally if SLIRP_INVALID_SOCKET is not defined (this
> define has been introduced together wiht slirp_os_socket type), for
> libslirp <= 4.8.0, and use it in callback function definitions.
> 
> Link: https://gitlab.freedesktop.org/slirp/libslirp/-/commit/72f85005a2307fd0961543e3cea861ad7a4d201e
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2603
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  net/slirp.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/net/slirp.c b/net/slirp.c
> index eb9a456ed4..fa07268cf4 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -98,6 +98,10 @@ typedef struct SlirpState {
>      GSList *fwd;
>  } SlirpState;
>  
> +#ifndef SLIRP_INVALID_SOCKET /* after 4.8.0 */

You can instead use SLIRP_CONFIG_VERSION_MAX >= 6, and if so set
cfg.version to 6 and use the new fields and functions.

> +typedef int slirp_os_socket;
> +#endif
> +
>  static struct slirp_config_str *slirp_configs;
>  static QTAILQ_HEAD(, SlirpState) slirp_stacks =
>      QTAILQ_HEAD_INITIALIZER(slirp_stacks);
> @@ -247,7 +251,7 @@ static void net_slirp_timer_mod(void *timer, int64_t expire_timer,
>      timer_mod(&t->timer, expire_timer);
>  }
>  
> -static void net_slirp_register_poll_fd(int fd, void *opaque)
> +static void net_slirp_register_poll_fd(slirp_os_socket fd, void *opaque)
>  {
>  #ifdef WIN32
>      AioContext *ctxt = qemu_get_aio_context();
> @@ -260,7 +264,7 @@ static void net_slirp_register_poll_fd(int fd, void *opaque)
>  #endif
>  }
>  
> -static void net_slirp_unregister_poll_fd(int fd, void *opaque)
> +static void net_slirp_unregister_poll_fd(slirp_os_socket fd, void *opaque)
>  {
>  #ifdef WIN32
>      if (WSAEventSelect(fd, NULL, 0) != 0) {
> @@ -314,7 +318,7 @@ static int slirp_poll_to_gio(int events)
>      return ret;
>  }
>  
> -static int net_slirp_add_poll(int fd, int events, void *opaque)
> +static int net_slirp_add_poll(slirp_os_socket fd, int events, void *opaque)
>  {
>      GArray *pollfds = opaque;
>      GPollFD pfd = {
> -- 
> 2.39.5

