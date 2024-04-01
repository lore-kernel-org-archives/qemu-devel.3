Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44865CD1288
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 16:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrKbB-0001zh-4f; Mon, 01 Apr 2024 12:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rrKb7-0001zS-QF
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 12:33:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rrKb6-0006x8-2h
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 12:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711989202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jz7hPJMqc+nHgQKqZHyuRRPSW0CkYx7eJF0oY5eA+4Q=;
 b=HCFarcB4datJ48i/taipFXSBWjWSNEq7zgKMRDGu2qD7fqtwXvjuSNSCydpIYV6o0oNzWD
 njzih3gNfPy5xcT/qDjb3xfICbmJAJTA30PcVFVTyZwy9OhtUWERHjZoxqgwOcplMNKFfX
 SlOL1HIp7BHPUv6AMuR60Sep7rPmc2g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-OfrkJtZmPRKXCNrNx3aDwQ-1; Mon,
 01 Apr 2024 12:33:18 -0400
X-MC-Unique: OfrkJtZmPRKXCNrNx3aDwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 137B71C031AB;
 Mon,  1 Apr 2024 16:33:17 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC64C2024517;
 Mon,  1 Apr 2024 16:33:14 +0000 (UTC)
Date: Mon, 1 Apr 2024 11:33:09 -0500
From: Eric Blake <eblake@redhat.com>
To: Zhu Yangyang <zhuyangyang14@huawei.com>
Cc: stefanha@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 vsementsov@yandex-team.ru, kwolf@redhat.com, luolongmin@huawei.com,
 suxiaodong1@huawei.com, 
 chenxiaoyu48@huawei.com, wangyan122@huawei.com, yebiaoxiang@huawei.com
Subject: Re: [PATCH v2 1/1] nbd/server: do not poll within a coroutine context
Message-ID: <zyi42idsyxyhygty3tlyxliltq5g4mov6yyruqetwu6t5chqop@zwvvnedv32zd>
References: <20240401123342.3947762-1-zhuyangyang14@huawei.com>
 <20240401124120.4020988-1-zhuyangyang14@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401124120.4020988-1-zhuyangyang14@huawei.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Apr 01, 2024 at 08:41:20PM +0800, Zhu Yangyang wrote:
> Coroutines are not supposed to block. Instead, they should yield.
> 
> Fixes: f95910f ("nbd: implement TLS support in the protocol negotiation")
> Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>
> ---
>  nbd/client.c       |  7 ++++---
>  nbd/common.c       | 19 ++++++++++++++++---
>  nbd/nbd-internal.h |  6 +++---
>  nbd/server.c       | 10 +++++-----
>  4 files changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/nbd/client.c b/nbd/client.c
> index 29ffc609a4..1ab91ed205 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -619,18 +619,19 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
>          return NULL;
>      }
>      qio_channel_set_name(QIO_CHANNEL(tioc), "nbd-client-tls");
> -    data.loop = g_main_loop_new(g_main_context_default(), FALSE);
>      trace_nbd_receive_starttls_tls_handshake();
>      qio_channel_tls_handshake(tioc,
> -                              nbd_tls_handshake,
> +                              nbd_client_tls_handshake,
>                                &data,
>                                NULL,
>                                NULL);
>  
>      if (!data.complete) {
> +        data.loop = g_main_loop_new(g_main_context_default(), FALSE);
>          g_main_loop_run(data.loop);
> +        g_main_loop_unref(data.loop);
>      }
> -    g_main_loop_unref(data.loop);
> +

Aha - you figured out an elegant way around the client code not being
in coroutine context that had been stumping me, at least for the sake
of a minimal patch.

>      if (data.error) {
>          error_propagate(errp, data.error);
>          object_unref(OBJECT(tioc));
> diff --git a/nbd/common.c b/nbd/common.c
> index 3247c1d618..01ca30a5c4 100644
> --- a/nbd/common.c
> +++ b/nbd/common.c
> @@ -47,14 +47,27 @@ int nbd_drop(QIOChannel *ioc, size_t size, Error **errp)
>  }
>  
>  
> -void nbd_tls_handshake(QIOTask *task,
> -                       void *opaque)
> +void nbd_client_tls_handshake(QIOTask *task, void *opaque)
>  {
>      struct NBDTLSHandshakeData *data = opaque;
>  
>      qio_task_propagate_error(task, &data->error);
>      data->complete = true;
> -    g_main_loop_quit(data->loop);
> +    if (data->loop) {
> +        g_main_loop_quit(data->loop);
> +    }
> +}
> +
> +
> +void nbd_server_tls_handshake(QIOTask *task, void *opaque)
> +{
> +    struct NBDTLSHandshakeData *data = opaque;
> +
> +    qio_task_propagate_error(task, &data->error);
> +    data->complete = true;
> +    if (!qemu_coroutine_entered(data->co)) {
> +        aio_co_wake(data->co);
> +    }
>  }

This matches up with what I was experimenting with last week, in that
server is in coroutine context while client is not.  However, it means
we no longer have a common implementation between the two, so keeping
the code isolated in nbd/common.c makes less sense than just placing
the two specific callbacks in the two specific files right where their
only use case exists (and even making them static at that point).

Or, can we still merge it into one helper?  It looks like we now have
3 viable possibilities:

data->loop data->co
non-NULL   non-NULL    impossible
NULL       NULL        client, qio_task completed right away
non-NULL   NULL        client, qio_task did not complete right away
NULL       non-NULL    server, waking the coroutine depends on if we are in one

With that, we can still get by with one function, but need good
documentation.  I'll post a v3 along those lines, to see what you
think.

>  
>  
> diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
> index dfa02f77ee..99cca9382c 100644
> --- a/nbd/nbd-internal.h
> +++ b/nbd/nbd-internal.h
> @@ -74,13 +74,13 @@ static inline int nbd_write(QIOChannel *ioc, const void *buffer, size_t size,
>  
>  struct NBDTLSHandshakeData {
>      GMainLoop *loop;
> +    Coroutine *co;
>      bool complete;
>      Error *error;
>  };

I had tried to get rid of the GMainLoop *loop member altogether, but
your change has the benefit of a smaller diff than what I was facing
(I got lost in the weeds trying to see if I could convert all of the
client into running in coroutine context).

>  
> -
> -void nbd_tls_handshake(QIOTask *task,
> -                       void *opaque);
> +void nbd_server_tls_handshake(QIOTask *task, void *opaque);
> +void nbd_client_tls_handshake(QIOTask *task, void *opaque);
>  
>  int nbd_drop(QIOChannel *ioc, size_t size, Error **errp);
>  
> diff --git a/nbd/server.c b/nbd/server.c
> index c3484cc1eb..b218512ced 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -777,17 +777,17 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
>  
>      qio_channel_set_name(QIO_CHANNEL(tioc), "nbd-server-tls");
>      trace_nbd_negotiate_handle_starttls_handshake();
> -    data.loop = g_main_loop_new(g_main_context_default(), FALSE);
> +    data.co = qemu_coroutine_self();
>      qio_channel_tls_handshake(tioc,
> -                              nbd_tls_handshake,
> +                              nbd_server_tls_handshake,
>                                &data,
>                                NULL,
>                                NULL);
>  
> -    if (!data.complete) {
> -        g_main_loop_run(data.loop);
> +    while (!data.complete) {
> +        qemu_coroutine_yield();
>      }
> -    g_main_loop_unref(data.loop);
> +
>      if (data.error) {
>          object_unref(OBJECT(tioc));
>          error_propagate(errp, data.error);
> -- 
> 2.33.0
>

Thanks for the updated patch - it looks like we are heading in a good direction.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


