Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B22EC87FCB
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 20:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uifag-0007l9-0D; Sun, 03 Aug 2025 16:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1uifab-0007ge-7i
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 16:45:53 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1uifaa-00038a-UN; Sun, 03 Aug 2025 16:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=pycdUvLaGhGviUyuNg5dHDkUVXBpgAL7u4h8yJZOLMo=; b=f1qaMWboHEZgcm8x1PnI
 Dhka2yHMTcKRTTmifVpX1G864Q4h0xBxqb+2n0Xj01BITog6yxJb3m9iYVTOMBrR+L0FwmRrmWLzG
 bNt9N835TsjCaUNgNfVS6sNYLZPkFP+gYLve8Q91ZiQ/w5/aduLoFNS2+Hg5GAfM2aIT+GTdtVdnc
 dXl/CK19vikiN8K7/Ssx9iF5pl9eyyGYdAXypxdyK04xlHBUKfxblwCBTikIMFb8wu4yKzBLJ6zOj
 STlsTzwTVN4hUxBjnhqKtUyXp02bdq/9Jafhwt4/+aTdfwGpgk/j+n6rES/TsYY1yQy9vfv34DbWX
 WVow5HdEUwEVhQ==;
Date: Sun, 3 Aug 2025 22:45:48 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Viktor Kurilko <murlockkinght@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] Add a feature for mapping a host unix socket to a
 guest tcp socket
Message-ID: <aI_KfBAUO75Bmn_e@begin>
References: <20250803050124.32007-1-murlockkinght@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250803050124.32007-1-murlockkinght@gmail.com>
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

Thanks for working on this!

Viktor Kurilko, le dim. 03 août 2025 12:01:04 +0700, a ecrit:
> diff --git a/net/slirp.c b/net/slirp.c
> index 9657e86a84..d096ee7ce6 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -795,12 +795,16 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict)
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
> +    host_addr.in.sin_family = AF_INET;
> +    host_addr.in.sin_addr.s_addr = INADDR_ANY;
> +    socklen_t host_addr_size = sizeof(host_addr.in);
> +
>      struct sockaddr_in guest_addr = {
>          .sin_family = AF_INET,
>          .sin_addr = {
> @@ -833,7 +837,7 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
>          fail_reason = "Missing : separator";
>          goto fail_syntax;
>      }
> -    if (buf[0] != '\0' && !inet_aton(buf, &host_addr.sin_addr)) {
> +    if (buf[0] != '\0' && !inet_aton(buf, &host_addr.in.sin_addr)) {

Does that not behave oddly when given a path?

Also, it's a bit odd to set host_addr for AF_INET and overwrite for the
UNIX case. Perhaps better use:

#if ..
  if (buf[0] == '/') {
    ...
    handle UNIX case
    ...
    host_addr.in.sin_family = AF_UNIX;
    host_addr_size = sizeof(host_addr.un);
  } else
#endif
  {
    ...
    handle INET case
    ...
    host_addr.in.sin_family = AF_INET;
    host_addr_size = sizeof(host_addr.in);
  }

>          fail_reason = "Bad host address";
>          goto fail_syntax;
>      }
> @@ -842,12 +846,43 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
>          fail_reason = "Bad host port separator";
>          goto fail_syntax;
>      }
> -    err = qemu_strtoi(buf, &end, 0, &host_port);
> -    if (err || host_port < 0 || host_port > 65535) {
> -        fail_reason = "Bad host port";
> -        goto fail_syntax;
> +#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
> +    if (buf[0] == '/') {
> +        if (is_udp) {
> +            fail_reason = "Mapping unix to udp is not supported";
> +            goto fail_syntax;
> +        }
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
> +        err = qemu_strtoi(buf, &end, 0, &host_port);
> +        if (err || host_port < 0 || host_port > 65535) {
> +            fail_reason = "Bad host port";
> +            goto fail_syntax;
> +        }
> +        host_addr.in.sin_port = htons(host_port);
>      }
> -    host_addr.sin_port = htons(host_port);
>  
>      if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
>          fail_reason = "Missing guest address";
> @@ -867,7 +902,7 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
>  
>  #if SLIRP_CHECK_VERSION(4, 5, 0)
>      err = slirp_add_hostxfwd(s->slirp,
> -            (struct sockaddr *) &host_addr, sizeof(host_addr),
> +            (struct sockaddr *) &host_addr, host_addr_size,
>              (struct sockaddr *) &guest_addr, sizeof(guest_addr),
>              is_udp ? SLIRP_HOSTFWD_UDP : 0);
>  #else
> -- 
> 2.50.1

