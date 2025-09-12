Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DA8CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 11:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux1wx-0008Qc-NL; Fri, 12 Sep 2025 07:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux1wu-0008PQ-3a
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 07:28:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux1wm-0007SU-3L
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 07:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757676483;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=L8aqRcDrre0v+mWm33qBdegYp6tYKn0y8aRaK9hGvmw=;
 b=I5eJ2nlm/B1TjFhSufMdLuSAPMzrjf1MN2hiBggWqefH+LlIKTOK70CNO8n7MtHuh0NoH/
 SrUG7xt1gbTu7fiKNGZjxzQv6SjXbwcy+ZU/g1fzMyKP4WorTRVHjH+YrNvlCvNZTtFhxv
 /IhDm0PnR40n5KKXfyEQHBlbg2fudRk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-q0IHK2-KN0iI2y9Tu6PwFQ-1; Fri,
 12 Sep 2025 07:27:59 -0400
X-MC-Unique: q0IHK2-KN0iI2y9Tu6PwFQ-1
X-Mimecast-MFC-AGG-ID: q0IHK2-KN0iI2y9Tu6PwFQ_1757676479
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BA121954194; Fri, 12 Sep 2025 11:27:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58E0A19560B1; Fri, 12 Sep 2025 11:27:56 +0000 (UTC)
Date: Fri, 12 Sep 2025 12:27:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 2/3] io/tls: Make qio_channel_tls_bye() always
 synchronous
Message-ID: <aMQDuFI2hQQ8clAF@redhat.com>
References: <20250911212355.1943494-1-peterx@redhat.com>
 <20250911212355.1943494-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250911212355.1943494-3-peterx@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 11, 2025 at 05:23:54PM -0400, Peter Xu wrote:
> No issue I hit, the change is only from code observation when I am looking
> at a TLS premature termination issue.
> 
> qio_channel_tls_bye() API needs to be synchronous.  When it's not, the
> previous impl will attach an asynchronous task retrying but only until when
> the channel gets the relevant GIO event. It may be problematic, because the
> caller of qio_channel_tls_bye() may have invoked channel close() before
> that, leading to premature termination of the TLS session.
> 
> Remove the asynchronous handling, instead retry it immediately.  Currently,
> the only two possible cases that may lead to async task is either INTERRUPT
> or EAGAIN.  It should be suffice to spin retry as of now, until a solid
> proof showing that a more complicated retry logic is needed.
> 
> With that, we can remove the whole async model for the bye task.
> 
> When at it, making the function return bool, which looks like a common
> pattern in QEMU when errp is used.
> 
> Side note on the tracepoints: previously the tracepoint bye_complete()
> isn't used.  Start to use it in this patch.  bye_pending() and bye_cancel()
> can be dropped now.  Adding bye_retry() instead.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/io/channel-tls.h |  5 ++-
>  io/channel-tls.c         | 86 +++++-----------------------------------
>  io/trace-events          |  3 +-
>  3 files changed, 15 insertions(+), 79 deletions(-)
> 
> diff --git a/include/io/channel-tls.h b/include/io/channel-tls.h
> index 7e9023570d..bcd14ffbd6 100644
> --- a/include/io/channel-tls.h
> +++ b/include/io/channel-tls.h
> @@ -49,7 +49,6 @@ struct QIOChannelTLS {
>      QCryptoTLSSession *session;
>      QIOChannelShutdown shutdown;
>      guint hs_ioc_tag;
> -    guint bye_ioc_tag;
>  };
>  
>  /**
> @@ -60,8 +59,10 @@ struct QIOChannelTLS {
>   * Perform the TLS session termination. This method will return
>   * immediately and the termination will continue in the background,
>   * provided the main loop is running.
> + *
> + * Returns: true on success, false on error (with errp set)
>   */
> -void qio_channel_tls_bye(QIOChannelTLS *ioc, Error **errp);
> +bool qio_channel_tls_bye(QIOChannelTLS *ioc, Error **errp);
>  
>  /**
>   * qio_channel_tls_new_server:
> diff --git a/io/channel-tls.c b/io/channel-tls.c
> index 5a2c8188ce..8510a187a8 100644
> --- a/io/channel-tls.c
> +++ b/io/channel-tls.c
> @@ -253,84 +253,25 @@ void qio_channel_tls_handshake(QIOChannelTLS *ioc,
>      qio_channel_tls_handshake_task(ioc, task, context);
>  }
>  
> -static gboolean qio_channel_tls_bye_io(QIOChannel *ioc, GIOCondition condition,
> -                                       gpointer user_data);
> -
> -static void qio_channel_tls_bye_task(QIOChannelTLS *ioc, QIOTask *task,
> -                                     GMainContext *context)
> +bool qio_channel_tls_bye(QIOChannelTLS *ioc, Error **errp)
>  {
> -    GIOCondition condition;
> -    QIOChannelTLSData *data;
>      int status;
> -    Error *err = NULL;
>  
> -    status = qcrypto_tls_session_bye(ioc->session, &err);
> +    trace_qio_channel_tls_bye_start(ioc);
> +retry:
> +    status = qcrypto_tls_session_bye(ioc->session, errp);
>  
>      if (status < 0) {
>          trace_qio_channel_tls_bye_fail(ioc);

snip

> +        return false;
> +    } else if (status != QCRYPTO_TLS_BYE_COMPLETE) {
> +        /* BYE event must be synchronous, retry immediately */
> +        trace_qio_channel_tls_bye_retry(ioc, status);
> +        goto retry;
>      }

We cannot do this. If the gnutls_bye() API needs to perform
socket I/O, and so when we're running over a non-blocking
socket we must expect EAGAIN. With this handling, QEMU will
busy loop burning 100% CPU when the socket is not ready.

A second point is that from a QIOChannel POV, we need to
ensure that all APIs can be used in a non-blocking scenario.
This is why in the QIOChannelSocket impl connect/listen APIs
we provide both _sync and _async variants of the APIs, or
in the QIOChannelTLS impl, the handshake API is always
async with a callback to be invokved on completion.

The QIOChanel 'bye' method is flawed in that it is
asynchronous, but has no callback for completion.

If migration is /always/ using a blocking socket for the
TLS channels this isn't a problem as gnutls will complete
immediately, but if any async sockets are used we have no
way to wait for completion. This requires improving the
API design in some manner.


>  
> -    return FALSE;
> -}
> -
> -static void propagate_error(QIOTask *task, gpointer opaque)
> -{
> -    qio_task_propagate_error(task, opaque);
> -}
> -
> -void qio_channel_tls_bye(QIOChannelTLS *ioc, Error **errp)
> -{
> -    QIOTask *task;
> -
> -    task = qio_task_new(OBJECT(ioc), propagate_error, errp, NULL);
> -
> -    trace_qio_channel_tls_bye_start(ioc);
> -    qio_channel_tls_bye_task(ioc, task, NULL);
> +    trace_qio_channel_tls_bye_complete(ioc);
> +    return true;
>  }
>  
>  static void qio_channel_tls_init(Object *obj G_GNUC_UNUSED)
> @@ -482,11 +423,6 @@ static int qio_channel_tls_close(QIOChannel *ioc,
>          g_clear_handle_id(&tioc->hs_ioc_tag, g_source_remove);
>      }
>  
> -    if (tioc->bye_ioc_tag) {
> -        trace_qio_channel_tls_bye_cancel(ioc);
> -        g_clear_handle_id(&tioc->bye_ioc_tag, g_source_remove);
> -    }
> -
>      return qio_channel_close(tioc->master, errp);
>  }
>  
> diff --git a/io/trace-events b/io/trace-events
> index dc3a63ba1f..67b3814192 100644
> --- a/io/trace-events
> +++ b/io/trace-events
> @@ -45,10 +45,9 @@ qio_channel_tls_handshake_fail(void *ioc) "TLS handshake fail ioc=%p"
>  qio_channel_tls_handshake_complete(void *ioc) "TLS handshake complete ioc=%p"
>  qio_channel_tls_handshake_cancel(void *ioc) "TLS handshake cancel ioc=%p"
>  qio_channel_tls_bye_start(void *ioc) "TLS termination start ioc=%p"
> -qio_channel_tls_bye_pending(void *ioc, int status) "TLS termination pending ioc=%p status=%d"
> +qio_channel_tls_bye_retry(void *ioc, int status) "TLS termination pending ioc=%p status=%d"
>  qio_channel_tls_bye_fail(void *ioc) "TLS termination fail ioc=%p"
>  qio_channel_tls_bye_complete(void *ioc) "TLS termination complete ioc=%p"
> -qio_channel_tls_bye_cancel(void *ioc) "TLS termination cancel ioc=%p"
>  qio_channel_tls_credentials_allow(void *ioc) "TLS credentials allow ioc=%p"
>  qio_channel_tls_credentials_deny(void *ioc) "TLS credentials deny ioc=%p"
>  
> -- 
> 2.50.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


