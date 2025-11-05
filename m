Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5107ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 15:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGf5x-0006ns-Qy; Wed, 05 Nov 2025 10:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGf5l-0006jr-H2
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 10:06:35 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGf5i-0001ek-Fz
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 10:06:32 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b4736e043f9so308625566b.0
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 07:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762355188; x=1762959988; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8nsTNrCfgMVZMf7HXfmJDggEv05QM07jzYjX6wX/fkQ=;
 b=nDJbVzBtzPG7/NTXad07wKJ9+9IVI9dKxIFFWigEuDQQKjrcl7Gz6XyIK7v/5QOt5l
 yzxovoydHxhCWht9bTouF97IpHq5W5tzPoe3CxIFawmdZuD4TcFokxOnpyxJHwqK3ykQ
 L6XRWHcjnpbSS8ZPQHz4UeDDiNZzpeCHJom8hAYS2tuMX1QRd1MvfC9jWo63plJ4ZKBf
 9Syo1YdFH70tiudipBnMzRSg5aLc+Uw9N3mjEbEUyIKe1bUVO/Vlx+Ghxofvz+6njkPz
 vwIzPgdkP6npAxASFasjZwdgZkShYJUlMG3t4nudThz9M5XDyr3/QKXRASO/6qwdDxQm
 NKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762355188; x=1762959988;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8nsTNrCfgMVZMf7HXfmJDggEv05QM07jzYjX6wX/fkQ=;
 b=F59RoefJzu57Na5+9mKH0O1Xc3nwGHfbM/vA38WISKwCIdmn/03eyoyKiu5b2yL+Ks
 uNipP/4t9f/GJ3F0IE7KLO2KyvaZxmHEqL4Qz9jPvg4RVrn1EE71fopsI7tBKqIgri0L
 zOZKrVcjePOMIWHruvx+zZVNHQwXXSPkTsE8x/IbBbIKr3DTX2S+oq5mmN/+ckOUWUxk
 aI1vNTywHmT34vJdH9gmmHIxgYLrqt+VI7hMUq0xx85EMAEL0FVHM9g+begLg2ctxUh6
 DcZa1lszFrpc96GQULPyORAdiiadNGw3UDJzyGXDhG+8k4VTij0D/Kq5kslyMzHEsIg2
 tJog==
X-Gm-Message-State: AOJu0YxQqau4+aqOkpVCUeLCnKknzXcc2F4t75xHiiZUo/vi8AmcPAhm
 QHKpf2u8geSlGuvQ0dXBserSMaVDZ8IK/hvX4UDz/oyq6uYgPt6yn04+uCQS9yPyiai5sQ1LBze
 XFvCB1IQ=
X-Gm-Gg: ASbGnctMxP4awi2Z3V3RQsgHI2E1IxtSM9+Y0fegI/DfavnAkYupN6B5E2jak4vkULD
 2LB9jf01o8cJ6u7Y3/PApoPIr9R4im2Byim7yyEqwrW8hIoNkD+u61kFIqiB+21gaiDf37GKd2X
 a3dxa8Sl0YyGBymgDWZ9IR7ezewNnBRkD5ez9eQQ2V5dJa7/7wfGMfJkUHE5aTOCzFxK7uguFNI
 ryYgdcXxDhys38IEBMAR14QF4SfFKNV2+Cjx1ZbNM19KsGDPOqCcIGyG4COdpdG/q5tLQtz4HAk
 vmq46BlBpXx49eX5SLg6q2bZGLWthh/lqH01TkG+3wVceRRJytRuVKpC8jp3wrEzLGody0v61Lv
 q/hiF3SMhIh5KQDP7OtKybXjB7eswwQv7eVFz5NltrXpCyzhAGUWduhdpse5sQZTyjy2TWeWM6i
 8vm0kx80+BjKIT8l7TkcTACte8G2oXtzvJ5oXPMQ==
X-Google-Smtp-Source: AGHT+IFsaj+Kn194boHdJS9Pln6If8mMplG+/6FHuXcsHgJsILrdVDNn2XCtUJtVxUmsE6ogHkUmkQ==
X-Received: by 2002:a17:907:9622:b0:b6d:9576:3890 with SMTP id
 a640c23a62f3a-b726555b5d8mr345379866b.45.1762355188048; 
 Wed, 05 Nov 2025 07:06:28 -0800 (PST)
Received: from [172.20.148.100] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723fa0219fsm503515666b.56.2025.11.05.07.06.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 07:06:27 -0800 (PST)
Message-ID: <4dd86e70-fd42-4a70-9f0f-3944e04bc972@linaro.org>
Date: Wed, 5 Nov 2025 16:06:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 06/27] aio-posix: integrate fdmon into glib event loop
To: qemu-devel@nongnu.org
References: <20251104175415.525388-1-kwolf@redhat.com>
 <20251104175415.525388-7-kwolf@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251104175415.525388-7-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x633.google.com
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

On 11/4/25 18:53, Kevin Wolf wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
> 
> AioContext's glib integration only supports ppoll(2) file descriptor
> monitoring. epoll(7) and io_uring(7) disable themselves and switch back
> to ppoll(2) when the glib event loop is used. The main loop thread
> cannot use epoll(7) or io_uring(7) because it always uses the glib event
> loop.
> 
> Future QEMU features may require io_uring(7). One example is uring_cmd
> support in FUSE exports. Each feature could create its own io_uring(7)
> context and integrate it into the event loop, but this is inefficient
> due to extra syscalls. It would be more efficient to reuse the
> AioContext's existing fdmon-io_uring.c io_uring(7) context because
> fdmon-io_uring.c will already be active on systems where Linux io_uring
> is available.
> 
> In order to keep fdmon-io_uring.c's AioContext operational even when the
> glib event loop is used, extend FDMonOps with an API similar to
> GSourceFuncs so that file descriptor monitoring can integrate into the
> glib event loop.
> 
> A quick summary of the GSourceFuncs API:
> - prepare() is called each event loop iteration before waiting for file
>    descriptors and timers.
> - check() is called to determine whether events are ready to be
>    dispatched after waiting.
> - dispatch() is called to process events.
> 
> More details here: https://docs.gtk.org/glib/struct.SourceFuncs.html
> 
> Move the ppoll(2)-specific code from aio-posix.c into fdmon-poll.c and
> also implement epoll(7)- and io_uring(7)-specific file descriptor
> monitoring code for glib event loops.
> 
> Note that it's still faster to use aio_poll() rather than the glib event
> loop since glib waits for file descriptor activity with ppoll(2) and
> does not support adaptive polling. But at least epoll(7) and io_uring(7)
> now work in glib event loops.
> 
> Splitting this into multiple commits without temporarily breaking
> AioContext proved difficult so this commit makes all the changes. The
> next commit will remove the aio_context_use_g_source() API because it is
> no longer needed.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Message-ID: <20251104022933.618123-7-stefanha@redhat.com>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   include/block/aio.h   | 36 ++++++++++++++++++
>   util/aio-posix.h      |  5 +++
>   tests/unit/test-aio.c |  7 +++-
>   util/aio-posix.c      | 69 ++++++++---------------------------
>   util/fdmon-epoll.c    | 34 ++++++++++++++---
>   util/fdmon-io_uring.c | 44 +++++++++++++++++++++-
>   util/fdmon-poll.c     | 85 ++++++++++++++++++++++++++++++++++++++++++-
>   7 files changed, 218 insertions(+), 62 deletions(-)
> 
> diff --git a/include/block/aio.h b/include/block/aio.h
> index 99ff48420b..39ed86d14d 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -106,6 +106,38 @@ typedef struct {
>        * Returns: true if ->wait() should be called, false otherwise.
>        */
>       bool (*need_wait)(AioContext *ctx);
> +
> +    /*
> +     * gsource_prepare:
> +     * @ctx: the AioContext
> +     *
> +     * Prepare for the glib event loop to wait for events instead of the usual
> +     * ->wait() call. See glib's GSourceFuncs->prepare().
> +     */
> +    void (*gsource_prepare)(AioContext *ctx);
> +
> +    /*
> +     * gsource_check:
> +     * @ctx: the AioContext
> +     *
> +     * Called by the glib event loop from glib's GSourceFuncs->check() after
> +     * waiting for events.
> +     *
> +     * Returns: true when ready to be dispatched.
> +     */
> +    bool (*gsource_check)(AioContext *ctx);
> +
> +    /*
> +     * gsource_dispatch:
> +     * @ctx: the AioContext
> +     * @ready_list: list for handlers that become ready
> +     *
> +     * Place ready AioHandlers on ready_list. Called as part of the glib event
> +     * loop from glib's GSourceFuncs->dispatch().
> +     *
> +     * Called with list_lock incremented.
> +     */
> +    void (*gsource_dispatch)(AioContext *ctx, AioHandlerList *ready_list);
>   } FDMonOps;
>   
>   /*
> @@ -222,6 +254,7 @@ struct AioContext {
>       /* State for file descriptor monitoring using Linux io_uring */
>       struct io_uring fdmon_io_uring;
>       AioHandlerSList submit_list;
> +    gpointer io_uring_fd_tag;
>   #endif
>   
>       /* TimerLists for calling timers - one per clock type.  Has its own
> @@ -254,6 +287,9 @@ struct AioContext {
>       /* epoll(7) state used when built with CONFIG_EPOLL */
>       int epollfd;
>   
> +    /* The GSource unix fd tag for epollfd */
> +    gpointer epollfd_tag;
> +
>       const FDMonOps *fdmon_ops;
>   };
>   
> diff --git a/util/aio-posix.h b/util/aio-posix.h
> index 82a0201ea4..f9994ed79e 100644
> --- a/util/aio-posix.h
> +++ b/util/aio-posix.h
> @@ -47,9 +47,14 @@ void aio_add_ready_handler(AioHandlerList *ready_list, AioHandler *node,
>   
>   extern const FDMonOps fdmon_poll_ops;
>   
> +/* Switch back to poll(2). list_lock must be held. */
> +void fdmon_poll_downgrade(AioContext *ctx);
> +
>   #ifdef CONFIG_EPOLL_CREATE1
>   bool fdmon_epoll_try_upgrade(AioContext *ctx, unsigned npfd);
>   void fdmon_epoll_setup(AioContext *ctx);
> +
> +/* list_lock must be held */
>   void fdmon_epoll_disable(AioContext *ctx);
>   #else
>   static inline bool fdmon_epoll_try_upgrade(AioContext *ctx, unsigned npfd)
> diff --git a/tests/unit/test-aio.c b/tests/unit/test-aio.c
> index e77d86be87..010d65b79a 100644
> --- a/tests/unit/test-aio.c
> +++ b/tests/unit/test-aio.c
> @@ -527,7 +527,12 @@ static void test_source_bh_delete_from_cb(void)
>       g_assert_cmpint(data1.n, ==, data1.max);
>       g_assert(data1.bh == NULL);
>   
> -    assert(g_main_context_iteration(NULL, false));
> +    /*
> +     * There may be up to one more iteration due to the aio_notify
> +     * EventNotifier.
> +     */
> +    g_main_context_iteration(NULL, false);
> +
>       assert(!g_main_context_iteration(NULL, false));
>   }
>   
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index 824fdc34cc..9de05ee7e8 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -70,15 +70,6 @@ static AioHandler *find_aio_handler(AioContext *ctx, int fd)
>   
>   static bool aio_remove_fd_handler(AioContext *ctx, AioHandler *node)
>   {
> -    /* If the GSource is in the process of being destroyed then
> -     * g_source_remove_poll() causes an assertion failure.  Skip
> -     * removal in that case, because glib cleans up its state during
> -     * destruction anyway.
> -     */
> -    if (!g_source_is_destroyed(&ctx->source)) {
> -        g_source_remove_poll(&ctx->source, &node->pfd);
> -    }
> -
>       node->pfd.revents = 0;
>       node->poll_ready = false;
>   
> @@ -153,7 +144,6 @@ void aio_set_fd_handler(AioContext *ctx,
>           } else {
>               new_node->pfd = node->pfd;
>           }
> -        g_source_add_poll(&ctx->source, &new_node->pfd);
>   
>           new_node->pfd.events = (io_read ? G_IO_IN | G_IO_HUP | G_IO_ERR : 0);
>           new_node->pfd.events |= (io_write ? G_IO_OUT | G_IO_ERR : 0);
> @@ -267,37 +257,13 @@ bool aio_prepare(AioContext *ctx)
>       poll_set_started(ctx, &ready_list, false);
>       /* TODO what to do with this list? */
>   
> +    ctx->fdmon_ops->gsource_prepare(ctx);
>       return false;
>   }
>   
>   bool aio_pending(AioContext *ctx)
>   {
> -    AioHandler *node;
> -    bool result = false;
> -
> -    /*
> -     * We have to walk very carefully in case aio_set_fd_handler is
> -     * called while we're walking.
> -     */
> -    qemu_lockcnt_inc(&ctx->list_lock);
> -
> -    QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
> -        int revents;
> -
> -        /* TODO should this check poll ready? */
> -        revents = node->pfd.revents & node->pfd.events;
> -        if (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR) && node->io_read) {
> -            result = true;
> -            break;
> -        }
> -        if (revents & (G_IO_OUT | G_IO_ERR) && node->io_write) {
> -            result = true;
> -            break;
> -        }
> -    }
> -    qemu_lockcnt_dec(&ctx->list_lock);
> -
> -    return result;
> +    return ctx->fdmon_ops->gsource_check(ctx);
>   }
>   
>   static void aio_free_deleted_handlers(AioContext *ctx)
> @@ -390,10 +356,6 @@ static bool aio_dispatch_handler(AioContext *ctx, AioHandler *node)
>       return progress;
>   }
>   
> -/*
> - * If we have a list of ready handlers then this is more efficient than
> - * scanning all handlers with aio_dispatch_handlers().
> - */
>   static bool aio_dispatch_ready_handlers(AioContext *ctx,
>                                           AioHandlerList *ready_list,
>                                           int64_t block_ns)
> @@ -417,24 +379,18 @@ static bool aio_dispatch_ready_handlers(AioContext *ctx,
>       return progress;
>   }
>   
> -/* Slower than aio_dispatch_ready_handlers() but only used via glib */
> -static bool aio_dispatch_handlers(AioContext *ctx)
> -{
> -    AioHandler *node, *tmp;
> -    bool progress = false;
> -
> -    QLIST_FOREACH_SAFE_RCU(node, &ctx->aio_handlers, node, tmp) {
> -        progress = aio_dispatch_handler(ctx, node) || progress;
> -    }
> -
> -    return progress;
> -}
> -
>   void aio_dispatch(AioContext *ctx)
>   {
> +    AioHandlerList ready_list = QLIST_HEAD_INITIALIZER(ready_list);
> +
>       qemu_lockcnt_inc(&ctx->list_lock);
>       aio_bh_poll(ctx);
> -    aio_dispatch_handlers(ctx);
> +
> +    ctx->fdmon_ops->gsource_dispatch(ctx, &ready_list);
> +
> +    /* block_ns is 0 because polling is disabled in the glib event loop */
> +    aio_dispatch_ready_handlers(ctx, &ready_list, 0);
> +
>       aio_free_deleted_handlers(ctx);
>       qemu_lockcnt_dec(&ctx->list_lock);
>   
> @@ -766,6 +722,7 @@ void aio_context_setup(AioContext *ctx)
>   {
>       ctx->fdmon_ops = &fdmon_poll_ops;
>       ctx->epollfd = -1;
> +    ctx->epollfd_tag = NULL;
>   
>       /* Use the fastest fd monitoring implementation if available */
>       if (fdmon_io_uring_setup(ctx)) {
> @@ -778,7 +735,11 @@ void aio_context_setup(AioContext *ctx)
>   void aio_context_destroy(AioContext *ctx)
>   {
>       fdmon_io_uring_destroy(ctx);
> +
> +    qemu_lockcnt_lock(&ctx->list_lock);
>       fdmon_epoll_disable(ctx);
> +    qemu_lockcnt_unlock(&ctx->list_lock);
> +
>       aio_free_deleted_handlers(ctx);
>   }
>   
> diff --git a/util/fdmon-epoll.c b/util/fdmon-epoll.c
> index 9fb8800dde..61118e1ee6 100644
> --- a/util/fdmon-epoll.c
> +++ b/util/fdmon-epoll.c
> @@ -19,8 +19,12 @@ void fdmon_epoll_disable(AioContext *ctx)
>           ctx->epollfd = -1;
>       }
>   
> -    /* Switch back */
> -    ctx->fdmon_ops = &fdmon_poll_ops;
> +    if (ctx->epollfd_tag) {
> +        g_source_remove_unix_fd(&ctx->source, ctx->epollfd_tag);
> +        ctx->epollfd_tag = NULL;
> +    }
> +
> +    fdmon_poll_downgrade(ctx);
>   }
>   
>   static inline int epoll_events_from_pfd(int pfd_events)
> @@ -93,10 +97,29 @@ out:
>       return ret;
>   }
>   
> +static void fdmon_epoll_gsource_prepare(AioContext *ctx)
> +{
> +    /* Do nothing */
> +}
> +
> +static bool fdmon_epoll_gsource_check(AioContext *ctx)
> +{
> +    return g_source_query_unix_fd(&ctx->source, ctx->epollfd_tag) & G_IO_IN;
> +}
> +
> +static void fdmon_epoll_gsource_dispatch(AioContext *ctx,
> +                                         AioHandlerList *ready_list)
> +{
> +    fdmon_epoll_wait(ctx, ready_list, 0);
> +}
> +
>   static const FDMonOps fdmon_epoll_ops = {
>       .update = fdmon_epoll_update,
>       .wait = fdmon_epoll_wait,
>       .need_wait = aio_poll_disabled,
> +    .gsource_prepare = fdmon_epoll_gsource_prepare,
> +    .gsource_check = fdmon_epoll_gsource_check,
> +    .gsource_dispatch = fdmon_epoll_gsource_dispatch,
>   };
>   
>   static bool fdmon_epoll_try_enable(AioContext *ctx)
> @@ -118,6 +141,8 @@ static bool fdmon_epoll_try_enable(AioContext *ctx)
>       }
>   
>       ctx->fdmon_ops = &fdmon_epoll_ops;
> +    ctx->epollfd_tag = g_source_add_unix_fd(&ctx->source, ctx->epollfd,
> +                                            G_IO_IN);
>       return true;
>   }
>   
> @@ -139,12 +164,11 @@ bool fdmon_epoll_try_upgrade(AioContext *ctx, unsigned npfd)
>       }
>   
>       ok = fdmon_epoll_try_enable(ctx);
> -
> -    qemu_lockcnt_inc_and_unlock(&ctx->list_lock);
> -
>       if (!ok) {
>           fdmon_epoll_disable(ctx);
>       }
> +
> +    qemu_lockcnt_inc_and_unlock(&ctx->list_lock);
>       return ok;
>   }
>   
> diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
> index 3d8638b0e5..0a5ec5ead6 100644
> --- a/util/fdmon-io_uring.c
> +++ b/util/fdmon-io_uring.c
> @@ -262,6 +262,11 @@ static int process_cq_ring(AioContext *ctx, AioHandlerList *ready_list)
>       unsigned num_ready = 0;
>       unsigned head;
>   
> +    /* If the CQ overflowed then fetch CQEs with a syscall */
> +    if (io_uring_cq_has_overflow(ring)) {
> +        io_uring_get_events(ring);
> +    }


https://gitlab.com/qemu-project/qemu/-/jobs/11984045425#L2379


../util/fdmon-io_uring.c: In function 'process_cq_ring':
../util/fdmon-io_uring.c:315:9: error: implicit declaration of function 
'io_uring_cq_has_overflow' [-Werror=implicit-function-declaration]
   315 |     if (io_uring_cq_has_overflow(ring)) {
       |         ^~~~~~~~~~~~~~~~~~~~~~~~
../util/fdmon-io_uring.c:315:9: error: nested extern declaration of 
'io_uring_cq_has_overflow' [-Werror=nested-externs]
../util/fdmon-io_uring.c:316:9: error: implicit declaration of function 
'io_uring_get_events'; did you mean 'io_uring_get_sqe'? 
[-Werror=implicit-function-declaration]
   316 |         io_uring_get_events(ring);
       |         ^~~~~~~~~~~~~~~~~~~
       |         io_uring_get_sqe
../util/fdmon-io_uring.c:316:9: error: nested extern declaration of 'io_uring_get_events' 
[-Werror=nested-externs]


r~

