Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704FEC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 17:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt8m4-0002Hw-Q7; Fri, 14 Mar 2025 13:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tt8m1-0002HL-3D
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:24:42 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tt8lx-00072Y-UR
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:24:40 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:921:0:640:f23d:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 018A8609F3;
 Fri, 14 Mar 2025 20:24:33 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a420::1:c] (unknown
 [2a02:6b8:b081:a420::1:c])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VOIrqr4FcCg0-4RFfZQrK; Fri, 14 Mar 2025 20:24:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1741973072;
 bh=uIqNh5orC91PoMC5cg11KMxKHrKHHHviGyOSCg/ptjY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=wJiheN5D2uOUbPPngKtglwcmZhL8+nzmQJVvfzeSho0408rUgVTrX1AjAKmtJs7SV
 87PCMCPXjXV34o7OzQgmIqbt9gnJ0+Kvvygkl9ZG/lglOSxqp/1NmqxiSFB/TyhH7k
 r4/qui9jSswizxlsgMUlSXEgR7dJv2J539ObPzSU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <8ca88996-07e7-4882-8169-328b599e5570@yandex-team.ru>
Date: Fri, 14 Mar 2025 20:24:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] util/qemu-sockets: Add support for keep-alive flag to
 passive sockets
To: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250303143312.640909-1-jmarcin@redhat.com>
 <20250303143312.640909-2-jmarcin@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250303143312.640909-2-jmarcin@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03.03.25 17:33, Juraj Marcin wrote:
> Commit aec21d3175 (qapi: Add InetSocketAddress member keep-alive)
> introduces the keep-alive flag, which enables the SO_KEEPALIVE socket
> option, but only on client-side sockets. However, this option is also
> useful for server-side sockets, so they can check if a client is still
> reachable or drop the connection otherwise.
> 
> This patch enables the SO_KEEPALIVE socket option on passive server-side
> sockets if the keep-alive flag is enabled. This socket option is then
> inherited by active server-side sockets communicating with connected
> clients.
> 
> This patch also fixes an issue in 'qio_dns_resolver_lookup_sync_inet()'
> where the keep-alive flag is not copied together with other attributes.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>   io/dns-resolver.c   |  2 ++
>   qapi/sockets.json   |  4 ++--
>   util/qemu-sockets.c | 19 +++++++++++++------
>   3 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/io/dns-resolver.c b/io/dns-resolver.c
> index 53b0e8407a..ee7403b65b 100644
> --- a/io/dns-resolver.c
> +++ b/io/dns-resolver.c
> @@ -126,6 +126,8 @@ static int qio_dns_resolver_lookup_sync_inet(QIODNSResolver *resolver,
>               .has_mptcp = iaddr->has_mptcp,
>               .mptcp = iaddr->mptcp,
>   #endif
> +            .has_keep_alive = iaddr->has_keep_alive,
> +            .keep_alive = iaddr->keep_alive,
>           };
>   
>           (*addrs)[i] = newaddr;
> diff --git a/qapi/sockets.json b/qapi/sockets.json
> index 6a95023315..eb50f64e3a 100644
> --- a/qapi/sockets.json
> +++ b/qapi/sockets.json
> @@ -56,8 +56,8 @@
>   # @ipv6: whether to accept IPv6 addresses, default try both IPv4 and
>   #     IPv6
>   #
> -# @keep-alive: enable keep-alive when connecting to this socket.  Not
> -#     supported for passive sockets.  (Since 4.2)
> +# @keep-alive: enable keep-alive when connecting to/listening on this socket.
> +#     (Since 4.2, not supported for listening sockets until 10.0)
>   #
>   # @mptcp: enable multi-path TCP.  (Since 6.1)
>   #
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 77477c1cd5..c30e4ac2ce 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -220,12 +220,6 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
>       int saved_errno = 0;
>       bool socket_created = false;
>   
> -    if (saddr->keep_alive) {
> -        error_setg(errp, "keep-alive option is not supported for passive "
> -                   "sockets");
> -        return -1;
> -    }
> -
>       memset(&ai,0, sizeof(ai));
>       ai.ai_flags = AI_PASSIVE;
>       if (saddr->has_numeric && saddr->numeric) {
> @@ -344,6 +338,19 @@ listen_failed:
>       return -1;
>   
>   listen_ok:
> +    if (saddr->keep_alive) {
> +        int val = 1;
> +        int ret = setsockopt(slisten, SOL_SOCKET, SO_KEEPALIVE,
> +                             &val, sizeof(val));
> +
> +        if (ret < 0) {
> +            error_setg_errno(errp, errno, "Unable to set KEEPALIVE");
> +            close(slisten);

previous code do the trick to not rewrite errno by close() call. I'm not sure it's really needed, but consistency counts. So should do the same here. Or drop the logic around errno at all in this function if it's not really needed (need to check the callers).

Or this way: just goto listen_failed here. And don't add extra "exit:" label. And to make final code more readable, move "listen_failed:" block to the and of the function and rename to just "fail:" (better to do it in additional preparation patch).

> +            slisten = -1;
> +            goto exit;
> +        }
> +    }
> +exit:
>       freeaddrinfo(res);
>       return slisten;
>   }

-- 
Best regards,
Vladimir


