Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36119C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 14:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rskH1-00009f-SV; Fri, 05 Apr 2024 10:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rskGy-000095-V8; Fri, 05 Apr 2024 10:10:29 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rskGv-00013c-1k; Fri, 05 Apr 2024 10:10:28 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:7619:0:640:c0b:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id C857460E6F;
 Fri,  5 Apr 2024 17:10:17 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b538::1:32] (unknown
 [2a02:6b8:b081:b538::1:32])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GAWLUO0c4Cg0-toN6UdFn; Fri, 05 Apr 2024 17:10:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1712326217;
 bh=14RCtiu7SsbvxaoxFqGrQvSg/lB1SSNc6WLg9jT6pNE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=BoJZamw7727kZXycdbdiqtNBTiLJECRfiAosSI0qykR5yB5bFwBGYDlWPJtwkUgaU
 ogkGTlEwb+WhXLT1Y1vF/71ad+Jjl/BLdgwwyfAArZ4QdlpTsgx8rMhCVPYnw0+4MZ
 FrZ9dNKRsHlkfpwBMi2Qt0IxbnelGjSDvQj51rLo=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <5f189e2a-7972-46f4-a94b-040d3d0baf91@yandex-team.ru>
Date: Fri, 5 Apr 2024 17:10:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nbd/server: do not poll within a coroutine context
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Zhu Yangyang <zhuyangyang14@huawei.com>
References: <20240404014418.620851-2-eblake@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240404014418.620851-2-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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

On 04.04.24 04:42, Eric Blake wrote:
> From: Zhu Yangyang <zhuyangyang14@huawei.com>
> 
> Coroutines are not supposed to block. Instead, they should yield.
> 
> The client performs TLS upgrade outside of an AIOContext, during
> synchronous handshake; this still requires g_main_loop.  But the
> server responds to TLS upgrade inside a coroutine, so a nested
> g_main_loop is wrong.  Since the two callbacks no longer share more
> than the setting of data.complete and data.error, it's just as easy to
> use static helpers instead of trying to share a common code path.
> 
> Fixes: f95910f ("nbd: implement TLS support in the protocol negotiation")
> Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>
> [eblake: move callbacks to their use point]
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> After looking at this more, I'm less convinced that there is enough
> common code here to even be worth trying to share in common.c.  This
> takes the essence of the v2 patch, but refactors it a bit.

Maybe, do the complete split, and make separate structure definitions in client.c and server.c, and don't make shared NBDTLSHandshakeData with union? Finally, it's just a simple opaque-structure for static callback function, seems good to keep it in .c as well.

> 
> v2: https://lists.gnu.org/archive/html/qemu-devel/2024-04/msg00019.html
> 
>   nbd/nbd-internal.h | 20 ++++++++++----------
>   nbd/client.c       | 21 +++++++++++++++++----
>   nbd/common.c       | 11 -----------
>   nbd/server.c       | 21 ++++++++++++++++-----
>   4 files changed, 43 insertions(+), 30 deletions(-)
> 
> diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
> index dfa02f77ee4..087c6bfc002 100644
> --- a/nbd/nbd-internal.h
> +++ b/nbd/nbd-internal.h
> @@ -63,6 +63,16 @@
>   #define NBD_SET_TIMEOUT             _IO(0xab, 9)
>   #define NBD_SET_FLAGS               _IO(0xab, 10)
> 
> +/* Used in NBD_OPT_STARTTLS handling */
> +struct NBDTLSHandshakeData {
> +    bool complete;
> +    Error *error;
> +    union {
> +        GMainLoop *loop;
> +        Coroutine *co;
> +    } u;
> +};
> +
>   /* nbd_write
>    * Writes @size bytes to @ioc. Returns 0 on success.
>    */
> @@ -72,16 +82,6 @@ static inline int nbd_write(QIOChannel *ioc, const void *buffer, size_t size,
>       return qio_channel_write_all(ioc, buffer, size, errp) < 0 ? -EIO : 0;
>   }
> 
> -struct NBDTLSHandshakeData {
> -    GMainLoop *loop;
> -    bool complete;
> -    Error *error;
> -};
> -
> -
> -void nbd_tls_handshake(QIOTask *task,
> -                       void *opaque);
> -
>   int nbd_drop(QIOChannel *ioc, size_t size, Error **errp);
> 
>   #endif
> diff --git a/nbd/client.c b/nbd/client.c
> index 29ffc609a4b..c9dc5265404 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -596,6 +596,18 @@ static int nbd_request_simple_option(QIOChannel *ioc, int opt, bool strict,
>       return 1;
>   }
> 
> +/* Callback to learn when QIO TLS upgrade is complete */
> +static void nbd_client_tls_handshake(QIOTask *task, void *opaque)
> +{
> +    struct NBDTLSHandshakeData *data = opaque;
> +
> +    qio_task_propagate_error(task, &data->error);
> +    data->complete = true;
> +    if (data->u.loop) {
> +        g_main_loop_quit(data->u.loop);
> +    }
> +}
> +
>   static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
>                                           QCryptoTLSCreds *tlscreds,
>                                           const char *hostname, Error **errp)
> @@ -619,18 +631,19 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
>           return NULL;
>       }
>       qio_channel_set_name(QIO_CHANNEL(tioc), "nbd-client-tls");
> -    data.loop = g_main_loop_new(g_main_context_default(), FALSE);
>       trace_nbd_receive_starttls_tls_handshake();
>       qio_channel_tls_handshake(tioc,
> -                              nbd_tls_handshake,
> +                              nbd_client_tls_handshake,
>                                 &data,
>                                 NULL,
>                                 NULL);
> 
>       if (!data.complete) {
> -        g_main_loop_run(data.loop);
> +        data.u.loop = g_main_loop_new(g_main_context_default(), FALSE);
> +        g_main_loop_run(data.u.loop);
> +        g_main_loop_unref(data.u.loop);
>       }
> -    g_main_loop_unref(data.loop);
> +
>       if (data.error) {
>           error_propagate(errp, data.error);
>           object_unref(OBJECT(tioc));
> diff --git a/nbd/common.c b/nbd/common.c
> index 3247c1d618a..589a748cfe6 100644
> --- a/nbd/common.c
> +++ b/nbd/common.c
> @@ -47,17 +47,6 @@ int nbd_drop(QIOChannel *ioc, size_t size, Error **errp)
>   }
> 
> 
> -void nbd_tls_handshake(QIOTask *task,
> -                       void *opaque)
> -{
> -    struct NBDTLSHandshakeData *data = opaque;
> -
> -    qio_task_propagate_error(task, &data->error);
> -    data->complete = true;
> -    g_main_loop_quit(data->loop);
> -}
> -
> -
>   const char *nbd_opt_lookup(uint32_t opt)
>   {
>       switch (opt) {
> diff --git a/nbd/server.c b/nbd/server.c
> index c3484cc1ebc..d16726a6326 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -748,6 +748,17 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
>       return rc;
>   }
> 
> +/* Callback to learn when QIO TLS upgrade is complete */
> +static void nbd_server_tls_handshake(QIOTask *task, void *opaque)
> +{
> +    struct NBDTLSHandshakeData *data = opaque;
> +
> +    qio_task_propagate_error(task, &data->error);
> +    data->complete = true;
> +    if (!qemu_coroutine_entered(data->u.co)) {
> +        aio_co_wake(data->u.co);
> +    }
> +}
> 
>   /* Handle NBD_OPT_STARTTLS. Return NULL to drop connection, or else the
>    * new channel for all further (now-encrypted) communication. */
> @@ -777,17 +788,17 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
> 
>       qio_channel_set_name(QIO_CHANNEL(tioc), "nbd-server-tls");
>       trace_nbd_negotiate_handle_starttls_handshake();
> -    data.loop = g_main_loop_new(g_main_context_default(), FALSE);
> +    data.u.co = qemu_coroutine_self();
>       qio_channel_tls_handshake(tioc,
> -                              nbd_tls_handshake,
> +                              nbd_server_tls_handshake,
>                                 &data,
>                                 NULL,
>                                 NULL);
> 
> -    if (!data.complete) {
> -        g_main_loop_run(data.loop);
> +    while (!data.complete) {
> +        qemu_coroutine_yield();
>       }
> -    g_main_loop_unref(data.loop);
> +
>       if (data.error) {
>           object_unref(OBJECT(tioc));
>           error_propagate(errp, data.error);

-- 
Best regards,
Vladimir


