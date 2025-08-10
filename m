Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BEEC87FCF
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Aug 2025 07:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ul0aM-0003Wb-DQ; Sun, 10 Aug 2025 03:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1ul0aA-0003UV-EM
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 03:35:08 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1ul0aA-0001uS-5I; Sun, 10 Aug 2025 03:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=cdK+Vnpn7rubPO4qMxcPOs59+6ayxTvtoWT3tIOE+5k=; b=eayz7dAjx97iAqxe+Rve
 SUdb6iGp+5PNU3nu+5Hje4XNggKazzc/lEZ0ETFqnmjJa0FAwYuGdFcMH4fkbfs7C9NHp/eozX8RO
 nHzQpG7z57QJ9C7oGaLj3zOdaxVwvmuIcQE/dZ+mHQu/UKah/lANSospGeHeQqBB+wPIh0Z/dMvnM
 M76bUxh40VCvfozi8kYEfVcPS1xZla48caH87KSBIiKP57RWwe1JPjPHcPvSqJRTIYyxiBlVgfgfq
 LJrH84vKFyhwIy8X9WKQswBfkDDvTDTb54reR5hVwHC2Z9MyeU5LDaIwibx0CglyX+oQl70mvxFsN
 klChDlAwcz0r6g==;
Date: Sun, 10 Aug 2025 09:35:00 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Viktor Kurilko <murlockkinght@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v5] Add a feature for mapping a host unix socket to a
 guest tcp socket
Message-ID: <aJhLpNUHVMkIkp3N@begin>
References: <20250808143904.363907-1-murlockkinght@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250808143904.363907-1-murlockkinght@gmail.com>
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

Viktor Kurilko, le ven. 08 août 2025 21:29:25 +0700, a ecrit:
> This patch adds the ability to map a host unix socket to a guest tcp socket when
> using the slirp backend. This feature was added in libslirp version 4.7.0.
> 
> A new syntax for unix socket: -hostfwd=unix:hostpath-[guestaddr]:guestport
> 
> Signed-off-by: Viktor Kurilko <murlockkinght@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thanks!

> ---
> Separator parsing has been moved to protocol-specific blocks.
> Fixed overwriting of sin_addr.
> `
>  docs/system/devices/net.rst |   2 +-
>  hmp-commands.hx             |   4 +-
>  net/slirp.c                 | 110 +++++++++++++++++++++++++++---------
>  qapi/net.json               |   2 +-
>  qemu-options.hx             |  11 +++-
>  5 files changed, 97 insertions(+), 32 deletions(-)
> 
> diff --git a/docs/system/devices/net.rst b/docs/system/devices/net.rst
> index 7d76fe88c4..13199a44fd 100644
> --- a/docs/system/devices/net.rst
> +++ b/docs/system/devices/net.rst
> @@ -79,7 +79,7 @@ those sockets. To allow ping for GID 100 (usually users group)::
>  
>  When using the built-in TFTP server, the router is also the TFTP server.
>  
> -When using the ``'-netdev user,hostfwd=...'`` option, TCP or UDP
> +When using the ``'-netdev user,hostfwd=...'`` option, TCP, UDP or UNIX
>  connections can be redirected from the host to the guest. It allows for
>  example to redirect X11, telnet or SSH connections.
>  
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index d0e4f35a30..64a463b15b 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1357,8 +1357,8 @@ ERST
>      {
>          .name       = "hostfwd_add",
>          .args_type  = "arg1:s,arg2:s?",
> -        .params     = "[netdev_id] [tcp|udp]:[hostaddr]:hostport-[guestaddr]:guestport",
> -        .help       = "redirect TCP or UDP connections from host to guest (requires -net user)",
> +        .params     = "[netdev_id] [tcp|udp|unix]:[[hostaddr]:hostport|hostpath]-[guestaddr]:guestport",
> +        .help       = "redirect TCP, UDP or UNIX connections from host to guest (requires -net user)",
>          .cmd        = hmp_hostfwd_add,
>      },
>  #endif
> diff --git a/net/slirp.c b/net/slirp.c
> index 9657e86a84..1b5e67f9d1 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -795,12 +795,13 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict)
>  
>  static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
>  {
> -    struct sockaddr_in host_addr = {
> -        .sin_family = AF_INET,
> -        .sin_addr = {
> -            .s_addr = INADDR_ANY,
> -        },
> -    };
> +    union {
> +        struct sockaddr_in in;
> +#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
> +        struct sockaddr_un un;
> +#endif
> +    } host_addr = {0};
> +
>      struct sockaddr_in guest_addr = {
>          .sin_family = AF_INET,
>          .sin_addr = {
> @@ -811,9 +812,13 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
>      int host_port, guest_port;
>      const char *p;
>      char buf[256];
> -    int is_udp;
> +    int is_udp = 0;
> +#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
> +    int is_unix = 0;
> +#endif
>      const char *end;
>      const char *fail_reason = "Unknown reason";
> +    socklen_t host_addr_size;
>  
>      p = redir_str;
>      if (!p || get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
> @@ -824,30 +829,83 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
>          is_udp = 0;
>      } else if (!strcmp(buf, "udp")) {
>          is_udp = 1;
> -    } else {
> -        fail_reason = "Bad protocol name";
> -        goto fail_syntax;
>      }
> -
> -    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
> -        fail_reason = "Missing : separator";
> -        goto fail_syntax;
> +#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
> +    else if (!strcmp(buf, "unix")) {
> +        is_unix = 1;
>      }
> -    if (buf[0] != '\0' && !inet_aton(buf, &host_addr.sin_addr)) {
> -        fail_reason = "Bad host address";
> +#endif
> +    else {
> +        fail_reason = "Bad protocol name";
>          goto fail_syntax;
>      }
>  
> -    if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
> -        fail_reason = "Bad host port separator";
> -        goto fail_syntax;
> -    }
> -    err = qemu_strtoi(buf, &end, 0, &host_port);
> -    if (err || host_port < 0 || host_port > 65535) {
> -        fail_reason = "Bad host port";
> -        goto fail_syntax;
> +#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
> +    if (is_unix) {
> +        if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
> +            fail_reason = "Missing - separator";
> +            goto fail_syntax;
> +        }
> +        if (buf[0] == '\0') {
> +            fail_reason = "Missing unix socket path";
> +            goto fail_syntax;
> +        }
> +        if (buf[0] != '/') {
> +            fail_reason = "unix socket path must be absolute";
> +            goto fail_syntax;
> +        }
> +
> +        size_t path_len = strlen(buf);
> +        if (path_len > sizeof(host_addr.un.sun_path) - 1) {
> +            fail_reason = "Unix socket path is too long";
> +            goto fail_syntax;
> +        }
> +
> +        struct stat st;
> +        if (stat(buf, &st) == 0) {
> +            if (!S_ISSOCK(st.st_mode)) {
> +                fail_reason = "file exists and it's not unix socket";
> +                goto fail_syntax;
> +            }
> +
> +            if (unlink(buf) < 0) {
> +                error_setg_errno(errp, errno, "Failed to unlink '%s'", buf);
> +                goto fail_syntax;
> +            }
> +        }
> +        host_addr.un.sun_family = AF_UNIX;
> +        memcpy(host_addr.un.sun_path, buf, path_len);
> +        host_addr_size = sizeof(host_addr.un);
> +    } else
> +#endif
> +    {
> +        host_addr.in.sin_family = AF_INET;
> +        host_addr.in.sin_addr.s_addr = INADDR_ANY;
> +
> +        if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
> +            fail_reason = "Missing : separator";
> +            goto fail_syntax;
> +        }
> +
> +        if (buf[0] != '\0' && !inet_aton(buf, &host_addr.in.sin_addr)) {
> +            fail_reason = "Bad host address";
> +            goto fail_syntax;
> +        }
> +
> +        if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
> +            fail_reason = "Bad host port separator";
> +            goto fail_syntax;
> +        }
> +
> +        err = qemu_strtoi(buf, &end, 0, &host_port);
> +        if (err || host_port < 0 || host_port > 65535) {
> +            fail_reason = "Bad host port";
> +            goto fail_syntax;
> +        }
> +
> +        host_addr.in.sin_port = htons(host_port);
> +        host_addr_size = sizeof(host_addr.in);
>      }
> -    host_addr.sin_port = htons(host_port);
>  
>      if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
>          fail_reason = "Missing guest address";
> @@ -867,7 +925,7 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
>  
>  #if SLIRP_CHECK_VERSION(4, 5, 0)
>      err = slirp_add_hostxfwd(s->slirp,
> -            (struct sockaddr *) &host_addr, sizeof(host_addr),
> +            (struct sockaddr *) &host_addr, host_addr_size,
>              (struct sockaddr *) &guest_addr, sizeof(guest_addr),
>              is_udp ? SLIRP_HOSTFWD_UDP : 0);
>  #else
> diff --git a/qapi/net.json b/qapi/net.json
> index 78bcc9871e..60d196afe5 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -281,7 +281,7 @@
>  #
>  # @smbserver: IP address of the built-in SMB server
>  #
> -# @hostfwd: redirect incoming TCP or UDP host connections to guest
> +# @hostfwd: redirect incoming TCP, UDP or UNIX host connections to guest
>  #     endpoints
>  #
>  # @guestfwd: forward guest TCP connections
> diff --git a/qemu-options.hx b/qemu-options.hx
> index ab23f14d21..86a70e0315 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3317,8 +3317,8 @@ SRST
>  
>          Note that a SAMBA server must be installed on the host OS.
>  
> -    ``hostfwd=[tcp|udp]:[hostaddr]:hostport-[guestaddr]:guestport``
> -        Redirect incoming TCP or UDP connections to the host port
> +    ``hostfwd=[tcp|udp|unix]:[[hostaddr]:hostport|hostpath]-[guestaddr]:guestport``
> +        Redirect incoming TCP, UDP or UNIX connections to the host port
>          hostport to the guest IP address guestaddr on guest port
>          guestport. If guestaddr is not specified, its value is x.x.x.15
>          (default first address given by the built-in DHCP server). By
> @@ -3348,6 +3348,13 @@ SRST
>          Then when you use on the host ``telnet localhost 5555``, you
>          connect to the guest telnet server.
>  
> +        To redirect host unix socket /tmp/vm to guest tcp socket 23 use
> +        following:
> +
> +        .. parsed-literal::
> +            # on the host
> +            |qemu_system| -nic user,hostfwd=unix:/tmp/vm-:23
> +
>      ``guestfwd=[tcp]:server:port-dev``; \ ``guestfwd=[tcp]:server:port-cmd:command``
>          Forward guest TCP connections to the IP address server on port
>          port to the character device dev or to a program executed by
> -- 
> 2.50.1
> 

-- 
Samuel
<i8b4uUnderground> d-_-b
<BonyNoMore> how u make that inverted b?
<BonyNoMore> wait
<BonyNoMore> never mind

