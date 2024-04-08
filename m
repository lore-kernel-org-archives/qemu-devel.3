Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2DDC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtkeU-00023k-UJ; Mon, 08 Apr 2024 04:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rtkeT-00021g-5O; Mon, 08 Apr 2024 04:46:53 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rtkeQ-0004Ox-4p; Mon, 08 Apr 2024 04:46:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c16:1785:0:640:67c7:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 9E62060D54;
 Mon,  8 Apr 2024 11:46:41 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b483::1:2e] (unknown
 [2a02:6b8:b081:b483::1:2e])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id dkTLWS1ixSw0-dEDxd4uM; Mon, 08 Apr 2024 11:46:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1712566000;
 bh=1A+cGG1ekpqd0Tt02qlZg9ecDhNknK/ad1HbPTySeik=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=QUmMXIAIlLONeuQMmGEK1C1ZvK/Nb8+NhIM43MhvJq91DHEAQYDPAR1LqwUV4IVYz
 I3R+TwQ/RDUqvl41joAI9TNgHyWAXnliRp3C3ffhKtSZjadrfRK1KhaOsGa8LDPxP7
 HlK6AtcthigSM9dkXWiHTyQiFKOObvBk/gbjqZoc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7c0f6e62-2ad5-44f5-a4b2-c1518ae86af2@yandex-team.ru>
Date: Mon, 8 Apr 2024 11:46:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nbd/server: do not poll within a coroutine context
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Zhu Yangyang <zhuyangyang14@huawei.com>
References: <20240405174523.844181-2-eblake@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240405174523.844181-2-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 05.04.24 20:44, Eric Blake wrote:
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

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

still, some notes below

> ---
> 
> v3: https://lists.gnu.org/archive/html/qemu-devel/2024-04/msg00375.html
> 
> in v4, factor even the struct to the .c files, avoiding a union [Vladimir]
> 
>   nbd/nbd-internal.h | 10 ----------
>   nbd/client.c       | 27 +++++++++++++++++++++++----
>   nbd/common.c       | 11 -----------
>   nbd/server.c       | 29 +++++++++++++++++++++++------
>   4 files changed, 46 insertions(+), 31 deletions(-)
> 
> diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
> index dfa02f77ee4..91895106a95 100644
> --- a/nbd/nbd-internal.h
> +++ b/nbd/nbd-internal.h
> @@ -72,16 +72,6 @@ static inline int nbd_write(QIOChannel *ioc, const void *buffer, size_t size,
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
> index 29ffc609a4b..c7141d7a098 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -596,13 +596,31 @@ static int nbd_request_simple_option(QIOChannel *ioc, int opt, bool strict,
>       return 1;
>   }
> 
> +/* Callback to learn when QIO TLS upgrade is complete */
> +struct NBDTLSClientHandshakeData {
> +    bool complete;
> +    Error *error;
> +    GMainLoop *loop;
> +};
> +
> +static void nbd_client_tls_handshake(QIOTask *task, void *opaque)
> +{
> +    struct NBDTLSClientHandshakeData *data = opaque;
> +
> +    qio_task_propagate_error(task, &data->error);
> +    data->complete = true;
> +    if (data->loop) {
> +        g_main_loop_quit(data->loop);
> +    }
> +}
> +
>   static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
>                                           QCryptoTLSCreds *tlscreds,
>                                           const char *hostname, Error **errp)
>   {
>       int ret;
>       QIOChannelTLS *tioc;
> -    struct NBDTLSHandshakeData data = { 0 };
> +    struct NBDTLSClientHandshakeData data = { 0 };
> 
>       ret = nbd_request_simple_option(ioc, NBD_OPT_STARTTLS, true, errp);
>       if (ret <= 0) {
> @@ -619,18 +637,19 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
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
> +        data.loop = g_main_loop_new(g_main_context_default(), FALSE);
>           g_main_loop_run(data.loop);
> +        g_main_loop_unref(data.loop);

probably good to assert(data.complete);

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
> index c3484cc1ebc..ea13cf0e766 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -748,6 +748,23 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
>       return rc;
>   }
> 
> +/* Callback to learn when QIO TLS upgrade is complete */
> +struct NBDTLSServerHandshakeData {
> +    bool complete;
> +    Error *error;
> +    Coroutine *co;
> +};
> +
> +static void nbd_server_tls_handshake(QIOTask *task, void *opaque)
> +{
> +    struct NBDTLSServerHandshakeData *data = opaque;
> +
> +    qio_task_propagate_error(task, &data->error);
> +    data->complete = true;
> +    if (!qemu_coroutine_entered(data->co)) {
> +        aio_co_wake(data->co);
> +    }
> +}
> 
>   /* Handle NBD_OPT_STARTTLS. Return NULL to drop connection, or else the
>    * new channel for all further (now-encrypted) communication. */
> @@ -756,7 +773,7 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
>   {
>       QIOChannel *ioc;
>       QIOChannelTLS *tioc;
> -    struct NBDTLSHandshakeData data = { 0 };
> +    struct NBDTLSServerHandshakeData data = { 0 };
> 
>       assert(client->opt == NBD_OPT_STARTTLS);
> 
> @@ -777,17 +794,17 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,

preexisting: lack coroutine_fn, as well as caller nbd_negotiate_options()

> 
>       qio_channel_set_name(QIO_CHANNEL(tioc), "nbd-server-tls");
>       trace_nbd_negotiate_handle_starttls_handshake();
> -    data.loop = g_main_loop_new(g_main_context_default(), FALSE);
> +    data.co = qemu_coroutine_self();
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

not "if", but "while".. Do we expect entering from somewhere except nbd_server_tls_handshake?

if not, probably safer construction would be

if (!data.complete) {
    qemu_coroutine_yield();
    assert(data.complete);
}

- to avoid hiding unexpected coroutine switching bugs

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


