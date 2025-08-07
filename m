Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577F0C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 23:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukATY-0006yU-9t; Thu, 07 Aug 2025 19:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1ukATT-0006wV-UE
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 19:56:44 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1ukATS-0001ld-0L; Thu, 07 Aug 2025 19:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=gfFwROyn/FNYt1OAXIrEQXk2DeONnxLrlOkV6mc1DYY=; b=c/l8SFQV9vgcqoh0IkQn
 Fhw0HemJxsakAxNje8p9jf5YC+0bhHVlRBTlJzDkX3BaocTKcKkHPK3fZLsM8TwTC3MRvFZ2nB0o2
 F7ZYfuBXXlEIJ3FJ0wlp+Hh8XtNe/RThR0ND81Ie2znAtQ464v/8TzZ4UqzeGhT2yro9YFeV6qivM
 3JzBXrjJ8nzJSZNh4mEYYIDS+sh2+aCjq6i2fjAHOPzvpCMiiBCdn1GwIek3jRGtj1dY00AFo1vEx
 L34ONU0fL9rqiQeHGKNwuSQPCyHIerk7JqGMWCE6F3DSPS46LvmIDVnnaXkHPionRsrTXp26LzerV
 rXJQ0TBRVvZ8AQ==;
Date: Fri, 8 Aug 2025 01:56:18 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Viktor Kurilko <murlockkinght@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v4] Add a feature for mapping a host unix socket to a
 guest tcp socket
Message-ID: <aJU9IgWHfCpUEoi5@begin>
References: <20250805145543.580526-1-murlockkinght@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250805145543.580526-1-murlockkinght@gmail.com>
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

We're almost there :)

Viktor Kurilko, le mar. 05 août 2025 21:52:50 +0700, a ecrit:
> @@ -824,30 +827,81 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
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
> +    if (get_str_sep(buf, sizeof(buf), &p, is_unix ? '-' : ':') < 0) {

This factorization looks odd. I don't think it's actually more readable
to try to factorize some separator parsing. I'd say rather have an if
(unix) part and else (ip) part, which both make their own get_str_sep
calls, and factorize just the parsing of the guest part.

> +#endif
> +    {
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
> +        host_addr.in.sin_family = AF_INET;
> +        host_addr.in.sin_addr.s_addr = INADDR_ANY;

This is overwriting the inet_aton call above?

> +        host_addr.in.sin_port = htons(host_port);
> +        host_addr_size = sizeof(host_addr.in);
>      }
> -    host_addr.sin_port = htons(host_port);
>  
>      if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
>          fail_reason = "Missing guest address";

Samuel

