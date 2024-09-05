Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974A9CD4F5B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 08:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm7Re-0004N1-JZ; Thu, 05 Sep 2024 04:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sm7Rc-0004MX-I0
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 04:02:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sm7Ra-0007NH-La
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 04:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725523337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qH+yOonltHHk+ko0oYfD08djzV2mQb5x/SYHruQfIwU=;
 b=FsfSh2g4/H5UdHPY8Dmq3y8PTygDUK/eCxJ1yACKHSUkfDaqFk01GWEKQgt2t/DVB4bxQj
 R1QuiI8gV7Qq4qBNnljmqC4TQCamX5FCDg6ei62uEIgRuwBhy9e3kOIk4oOq9xHrV2fkkM
 bNA9QZHKQKd1hPagB6RCUALxMkx7YT8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-S_s5HxMNOt2b04jjw5W0Sw-1; Thu, 05 Sep 2024 04:02:15 -0400
X-MC-Unique: S_s5HxMNOt2b04jjw5W0Sw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42bafca2438so4487485e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 01:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725523335; x=1726128135;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qH+yOonltHHk+ko0oYfD08djzV2mQb5x/SYHruQfIwU=;
 b=rpsJECKtOJjDYX2h7pKtfU7ZvTeHPe8tE+T+omMxT5CqMPH8+97Y7EtwQQcBuDJm3x
 1aF+rOg8XJ5boI032YqXgQv/rsw95jVs31GtRYoEpj1MuxeiSx3BSILSDNlicN0szT7C
 7C08xfbowu3SiiXpA/UdQYBmakKn6V8ugwH2nstjrjXPFId3hmjBc9v9nmGgfAhfOJIb
 WjSP90Wr7ou3Q/0D3XeUUGll38/0zHY6ujeFLQDD7Dzm5B1CjKedmKsBcRCOf5TLn+nF
 LZLnbgR1VF265NZt2L2qJj5mca4tYJoUv9TgM+vw3vbUfolU/4cXcpu0IQescF7K7Og5
 Xh1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtlIJnsGQI+6jL8aQVd+HBdgpSDdjonfMo1l0/WmU2/NQqVVaUnFpJ6+zZCg5cMrnn+4FKktjxVQHn@nongnu.org
X-Gm-Message-State: AOJu0YzbG6QWpoVAbametQosjqnMOcg2+fybpJjNLdNfSA8Puq883r/I
 SCSVttf33B1oi3zRex4xpUinZC27zydpKkbOqYb9kFMWuhztcOb2pZHjTNYRWTbShTJazW3Q8eY
 rrqn0lkUlUjM/uYct7blgN58Bt33ku2uf0WN7Dl79DMIW4iHi4KEv
X-Received: by 2002:a05:600c:1994:b0:426:5269:982c with SMTP id
 5b1f17b1804b1-42c9a38b28bmr12759775e9.28.1725523334522; 
 Thu, 05 Sep 2024 01:02:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpwlHuQ37b0yHfThSlovHnTj0Ijh8URs5/DGZQAobOOG2pmhGqDIOdsv7l1gQGD8utK+P0yw==
X-Received: by 2002:a05:600c:1994:b0:426:5269:982c with SMTP id
 5b1f17b1804b1-42c9a38b28bmr12759345e9.28.1725523333889; 
 Thu, 05 Sep 2024 01:02:13 -0700 (PDT)
Received: from [192.168.10.28] ([151.95.101.29])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-377a662aea3sm3394821f8f.11.2024.09.05.01.02.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 01:02:13 -0700 (PDT)
Message-ID: <139aa7aa-817e-4d1e-8d42-1abee92e22aa@redhat.com>
Date: Thu, 5 Sep 2024 10:02:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] chardev: introduce 'reconnect-ms' and deprecate
 'reconnect'
To: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, devel@lists.libvirt.org,
 Peter Krempa <pkrempa@redhat.com>, Michal Privoznik <mprivozn@redhat.com>
References: <20240904051913.53148-1-d-tatianin@yandex-team.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240904051913.53148-1-d-tatianin@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 9/4/24 07:19, Daniil Tatianin wrote:
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

Please add it also to docs/about/deprecated.rst

Otherwise looks good, thanks!

Paolo

> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ACKed-by: Peter Krempa <pkrempa@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   chardev/char-socket.c         | 33 ++++++++++++++++++++++++---------
>   chardev/char.c                |  3 +++
>   include/chardev/char-socket.h |  2 +-
>   qapi/char.json                | 17 +++++++++++++++--
>   4 files changed, 43 insertions(+), 12 deletions(-)
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


