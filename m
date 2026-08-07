Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA98C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsKox-0006Xb-B3; Fri, 07 Aug 2026 09:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wsKov-0006X3-KI
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:41:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wsKot-0002yV-UI
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786110067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UUf7ST3t0GG6c4E8ye9mGEz9ifzwyqaEOtooB/hZTi8=;
 b=SRbG8XzCw/gk3/9uRpQxAt5jxSGkZtyiy+FWrG+L9N6CfjOGJsyk8zCMjaHzGdmOSRSFzU
 N1E/uugruU0HRFHgxM5z+zdeplbFT8+NeZCVvUNXoxQ2i9o1mWBcfoXsqnVHXsDj+TwWzd
 mMWGrjVYJJuvbWAJIWoW0lOwr+/D6rc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-uxc3fgn_POeQABlhDZStVA-1; Fri,
 07 Aug 2026 09:41:06 -0400
X-MC-Unique: uxc3fgn_POeQABlhDZStVA-1
X-Mimecast-MFC-AGG-ID: uxc3fgn_POeQABlhDZStVA_1786110065
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2900C1956041; Fri,  7 Aug 2026 13:41:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 843AE180049F; Fri,  7 Aug 2026 13:41:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3C14321E6920; Fri, 07 Aug 2026 15:41:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  'Daniel P .
 =?utf-8?Q?Berrang=C3=A9'?= <berrange@redhat.com>,  Jason Wang
 <jasowang@redhat.com>
Subject: Re: [PATCH V11 03/15] iothread: track users with holder name
In-Reply-To: <20260806202531.243806-4-zhangckid@gmail.com> (Zhang Chen's
 message of "Fri, 7 Aug 2026 04:25:12 +0800")
References: <20260806202531.243806-1-zhangckid@gmail.com>
 <20260806202531.243806-4-zhangckid@gmail.com>
Date: Fri, 07 Aug 2026 15:41:02 +0200
Message-ID: <87wlu2nj4h.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Zhang Chen <zhangckid@gmail.com> writes:

> Introduce iothread_ref_and_get_aio_context() with a holder argument
> and its counterpart iothread_put_aio_context().
>
> Previously, users of an IOThread AioContext did not explicitly record
> their identity, making it difficult to debug which devices or
> subsystems were pinning an IOThread.
>
> Registering a holder takes an IOThread object reference so that the
> IOThread and its AioContext stay alive until the matching put
> operation. Document the ownership and BQL requirements.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  include/system/iothread.h | 21 +++++++++++++++++++++
>  iothread.c                | 23 ++++++++++++++++++++++-
>  2 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/include/system/iothread.h b/include/system/iothread.h
> index b8aeb32b0e..b6664e7a38 100644
> --- a/include/system/iothread.h
> +++ b/include/system/iothread.h
> @@ -67,6 +67,27 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
>  char *iothread_get_id(IOThread *iothread);
>  IOThread *iothread_by_id(const char *id);
>  AioContext *iothread_get_aio_context(IOThread *iothread);
> +
> +/*
> + * Register @holder and return @iothread's AioContext.  The holder is copied,
> + * and a reference is taken on @iothread so that both the IOThread and its
> + * AioContext remain alive.
> + *
> + * The caller must eventually call iothread_put_aio_context() with an
> + * equivalent holder.  This function is not thread-safe and must be called
> + * under the Big QEMU Lock (BQL).
> + */
> +AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> +                                             const IOThreadHolder *holder);
> +
> +/*
> + * Unregister @holder and release the corresponding reference on @iothread.
> + * Calling this function without a matching
> + * iothread_ref_and_get_aio_context() call is a programming error.
> + *
> + * This function is not thread-safe and must be called under the BQL.
> + */
> +void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder);
>  GMainContext *iothread_get_g_main_context(IOThread *iothread);
>  
>  /*
> diff --git a/iothread.c b/iothread.c
> index 2a4c92e08b..0cc8344ee6 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -33,6 +33,11 @@ void iothread_ref(IOThread *iothread, const IOThreadHolder *holder)
>      assert(holder);
>  
>      QAPI_LIST_PREPEND(iothread->holders, QAPI_CLONE(IOThreadHolder, holder));
> +    /*
> +     * This guarantees that the IOThread and its AioContext remain alive
> +     * as long as there is a holder.
> +     */
> +    object_ref(OBJECT(iothread));
>  }
>  
>  static int iothread_holder_compare(const IOThreadHolder *holder_a,
> @@ -78,6 +83,7 @@ void iothread_unref(IOThread *iothread, const IOThreadHolder *holder)
>              *prev = curr->next;
>              curr->next = NULL;
>              qapi_free_IOThreadHolderList(curr);
> +            object_unref(OBJECT(iothread));
>              return;
>          }
>          prev = &curr->next;
> @@ -199,7 +205,7 @@ static void iothread_init_gcontext(IOThread *iothread, const char *thread_name)
>      g_autofree char *name = g_strdup_printf("%s aio-context", thread_name);
>  
>      iothread->worker_context = g_main_context_new();
> -    source = aio_get_g_source(iothread_get_aio_context(iothread));
> +    source = aio_get_g_source(iothread->ctx);
>      g_source_set_name(source, name);
>      g_source_attach(source, iothread->worker_context);
>      g_source_unref(source);
> @@ -421,6 +427,21 @@ AioContext *iothread_get_aio_context(IOThread *iothread)
>      return iothread->ctx;
>  }
>  
> +AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
> +                                             const IOThreadHolder *holder)
> +{
> +    /* Add IOThreadHolder to the list */
> +    iothread_ref(iothread, holder);
> +
> +    return iothread->ctx;
> +}
> +
> +void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder)

Should we name this "unref" rather than "put"?  Perhaps Stefan has an
opinion.

> +{
> +    /* Delete IOThreadHolder from the list */
> +    iothread_unref(iothread, holder);
> +}
> +
>  static int query_one_iothread(Object *object, void *opaque)
>  {
>      IOThreadInfoList ***tail = opaque;


