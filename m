Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE01EDE998
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 07:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soHjP-0005cs-FF; Wed, 11 Sep 2024 03:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1soHjH-0005aZ-T1
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 03:25:34 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1soHiz-000064-6z
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 03:25:15 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:b1cb:0:640:2a1e:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E15F460B68;
 Wed, 11 Sep 2024 10:25:05 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b518::1:c] (unknown
 [2a02:6b8:b081:b518::1:c])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 3PdOil0IWmI0-34k1aznd; Wed, 11 Sep 2024 10:25:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1726039505;
 bh=hZC0aMhNru0CtKkRF9DUqfRPm/+5WibgnBvdNb9F8hU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=kDC0NvfGXZbcXjgr6euwj8X7ueDwqjeo2LMtYdOQuqOEsBlPtPOmsScxuz+NLZQh6
 WDrLsI1IEmPNIw4WAauBJ5uqZ6aIUDynyjzFJXNnbz8TiKlB5oBlWgZNLnyGJ7ptyB
 spopdE6P8TWU5d95dBw0IYIBTRqpw7WZ7wAP7CZo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <35d9d3b9-d6e1-4570-b4e2-3b5acb03cdc1@yandex-team.ru>
Date: Wed, 11 Sep 2024 10:25:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] chardev: introduce 'reconnect-ms' and deprecate
 'reconnect'
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org, Peter Krempa <pkrempa@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20240905085703.106156-1-d-tatianin@yandex-team.ru>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <20240905085703.106156-1-d-tatianin@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Ping :) I think this one should be good to go now!

On 9/5/24 11:57 AM, Daniil Tatianin wrote:
> The 'reconnect' option only allows to specify the time in seconds,
> which is way too long for certain workflows.
>
> We have a lightweight disk backend server, which takes about 20ms to
> live update, but due to this limitation in QEMU, previously the guest
> disk controller would hang for one second because it would take this
> long for QEMU to reinitialize the socket connection.
>
> Introduce a new option called 'reconnect-ms', which is the same as
> 'reconnect', except the value is treated as milliseconds. These are
> mutually exclusive and specifying both results in an error.
>
> 'reconnect' is also deprecated by this commit to make it possible to
> remove it in the future as to not keep two options that control the
> same thing.
>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Acked-by: Peter Krempa <pkrempa@redhat.com>
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>
> Changes since v0:
> - Mention the deprecation in docs (Paolo)
>
> ---
>   chardev/char-socket.c         | 33 ++++++++++++++++++++++++---------
>   chardev/char.c                |  3 +++
>   docs/about/deprecated.rst     |  6 ++++++
>   include/chardev/char-socket.h |  2 +-
>   qapi/char.json                | 17 +++++++++++++++--
>   5 files changed, 49 insertions(+), 12 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 1ca9441b1b..c24331ac23 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -74,7 +74,7 @@ static void qemu_chr_socket_restart_timer(Chardev *chr)
>       assert(!s->reconnect_timer);
>       name = g_strdup_printf("chardev-socket-reconnect-%s", chr->label);
>       s->reconnect_timer = qemu_chr_timeout_add_ms(chr,
> -                                                 s->reconnect_time * 1000,
> +                                                 s->reconnect_time_ms,
>                                                    socket_reconnect_timeout,
>                                                    chr);
>       g_source_set_name(s->reconnect_timer, name);
> @@ -481,7 +481,7 @@ static void tcp_chr_disconnect_locked(Chardev *chr)
>       if (emit_close) {
>           qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
>       }
> -    if (s->reconnect_time && !s->reconnect_timer) {
> +    if (s->reconnect_time_ms && !s->reconnect_timer) {
>           qemu_chr_socket_restart_timer(chr);
>       }
>   }
> @@ -1080,9 +1080,9 @@ static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
>           } else {
>               Error *err = NULL;
>               if (tcp_chr_connect_client_sync(chr, &err) < 0) {
> -                if (s->reconnect_time) {
> +                if (s->reconnect_time_ms) {
>                       error_free(err);
> -                    g_usleep(s->reconnect_time * 1000ULL * 1000ULL);
> +                    g_usleep(s->reconnect_time_ms * 1000ULL);
>                   } else {
>                       error_propagate(errp, err);
>                       return -1;
> @@ -1267,13 +1267,13 @@ skip_listen:
>   
>   
>   static int qmp_chardev_open_socket_client(Chardev *chr,
> -                                          int64_t reconnect,
> +                                          int64_t reconnect_ms,
>                                             Error **errp)
>   {
>       SocketChardev *s = SOCKET_CHARDEV(chr);
>   
> -    if (reconnect > 0) {
> -        s->reconnect_time = reconnect;
> +    if (reconnect_ms > 0) {
> +        s->reconnect_time_ms = reconnect_ms;
>           tcp_chr_connect_client_async(chr);
>           return 0;
>       } else {
> @@ -1371,7 +1371,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>       bool is_tn3270      = sock->has_tn3270  ? sock->tn3270  : false;
>       bool is_waitconnect = sock->has_wait    ? sock->wait    : false;
>       bool is_websock     = sock->has_websocket ? sock->websocket : false;
> -    int64_t reconnect   = sock->has_reconnect ? sock->reconnect : 0;
> +    int64_t reconnect_ms = 0;
>       SocketAddress *addr;
>   
>       s->is_listen = is_listen;
> @@ -1443,7 +1443,13 @@ static void qmp_chardev_open_socket(Chardev *chr,
>               return;
>           }
>       } else {
> -        if (qmp_chardev_open_socket_client(chr, reconnect, errp) < 0) {
> +        if (sock->has_reconnect) {
> +            reconnect_ms = sock->reconnect * 1000ULL;
> +        } else if (sock->has_reconnect_ms) {
> +            reconnect_ms = sock->reconnect_ms;
> +        }
> +
> +        if (qmp_chardev_open_socket_client(chr, reconnect_ms, errp) < 0) {
>               return;
>           }
>       }
> @@ -1509,6 +1515,15 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
>       sock->wait = qemu_opt_get_bool(opts, "wait", true);
>       sock->has_reconnect = qemu_opt_find(opts, "reconnect");
>       sock->reconnect = qemu_opt_get_number(opts, "reconnect", 0);
> +    sock->has_reconnect_ms = qemu_opt_find(opts, "reconnect-ms");
> +    sock->reconnect_ms = qemu_opt_get_number(opts, "reconnect-ms", 0);
> +
> +    if (sock->has_reconnect_ms && sock->has_reconnect) {
> +        error_setg(errp,
> +            "'reconnect' and 'reconnect-ms' are mutually exclusive");
> +        return;
> +    }
> +
>       sock->tls_creds = g_strdup(qemu_opt_get(opts, "tls-creds"));
>       sock->tls_authz = g_strdup(qemu_opt_get(opts, "tls-authz"));
>   
> diff --git a/chardev/char.c b/chardev/char.c
> index ba847b6e9e..35623c78a3 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -888,6 +888,9 @@ QemuOptsList qemu_chardev_opts = {
>           },{
>               .name = "reconnect",
>               .type = QEMU_OPT_NUMBER,
> +        },{
> +            .name = "reconnect-ms",
> +            .type = QEMU_OPT_NUMBER,
>           },{
>               .name = "telnet",
>               .type = QEMU_OPT_BOOL,
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 88f0f03786..e5db9bc6e9 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -430,6 +430,12 @@ Backend ``memory`` (since 9.0)
>   
>   ``memory`` is a deprecated synonym for ``ringbuf``.
>   
> +``reconnect`` (since 9.2)
> +^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The ``reconnect`` option only allows specifiying second granularity timeouts,
> +which is not enough for all types of use cases, use ``reconnect-ms`` instead.
> +
>   CPU device properties
>   '''''''''''''''''''''
>   
> diff --git a/include/chardev/char-socket.h b/include/chardev/char-socket.h
> index 0708ca6fa9..d6d13ad37f 100644
> --- a/include/chardev/char-socket.h
> +++ b/include/chardev/char-socket.h
> @@ -74,7 +74,7 @@ struct SocketChardev {
>       bool is_websock;
>   
>       GSource *reconnect_timer;
> -    int64_t reconnect_time;
> +    int64_t reconnect_time_ms;
>       bool connect_err_reported;
>   
>       QIOTask *connect_task;
> diff --git a/qapi/char.json b/qapi/char.json
> index ef58445cee..7f117438c6 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -273,7 +273,19 @@
>   #
>   # @reconnect: For a client socket, if a socket is disconnected, then
>   #     attempt a reconnect after the given number of seconds.  Setting
> -#     this to zero disables this function.  (default: 0) (Since: 2.2)
> +#     this to zero disables this function.  The use of this member is
> +#     deprecated, use @reconnect-ms instead. (default: 0) (Since: 2.2)
> +#
> +# @reconnect-ms: For a client socket, if a socket is disconnected,
> +#     then attempt a reconnect after the given number of milliseconds.
> +#     Setting this to zero disables this function.  This member is
> +#     mutually exclusive with @reconnect.
> +#     (default: 0) (Since: 9.2)
> +#
> +# Features:
> +#
> +# @deprecated: Member @reconnect is deprecated.  Use @reconnect-ms
> +#     instead.
>   #
>   # Since: 1.4
>   ##
> @@ -287,7 +299,8 @@
>               '*telnet': 'bool',
>               '*tn3270': 'bool',
>               '*websocket': 'bool',
> -            '*reconnect': 'int' },
> +            '*reconnect': { 'type': 'int', 'features': [ 'deprecated' ] },
> +            '*reconnect-ms': 'int' },
>     'base': 'ChardevCommon' }
>   
>   ##

