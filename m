Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16942CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 14:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzFui-0003zN-O0; Thu, 18 Sep 2025 10:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uzFue-0003sx-81
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 10:47:08 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uzFuc-0005Hl-1l
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 10:47:07 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B162C3368A;
 Thu, 18 Sep 2025 14:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758206823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fw/Yvw7s2tvzq2t/RxZfpH8Sqi3RBXGHJOZqtZ0hiB0=;
 b=NiwifVR/pDJqmEKbr/x6M0fVOjsI3SBIRN77cr+i71F1MXNnk6NxWSunkWSEGPcdse4/m4
 4fuiTZBC4HmfD1vq7lyUEL4uoN0jaNATGXyJMuzR6ljSYCXmwomCW43ewPag87kVndZN21
 LMy8vaFApUV3Un0fWeu24dlKiN1qlNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758206823;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fw/Yvw7s2tvzq2t/RxZfpH8Sqi3RBXGHJOZqtZ0hiB0=;
 b=qZvhkbBWv2yPRIGjRE/M3Hxd4sng4aL1RP7d62eyD4h7csvhbxZdHDkXyFqT6CsAy0Ea6F
 bNc+5DC4JUJDRgDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="NiwifVR/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qZvhkbBW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758206823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fw/Yvw7s2tvzq2t/RxZfpH8Sqi3RBXGHJOZqtZ0hiB0=;
 b=NiwifVR/pDJqmEKbr/x6M0fVOjsI3SBIRN77cr+i71F1MXNnk6NxWSunkWSEGPcdse4/m4
 4fuiTZBC4HmfD1vq7lyUEL4uoN0jaNATGXyJMuzR6ljSYCXmwomCW43ewPag87kVndZN21
 LMy8vaFApUV3Un0fWeu24dlKiN1qlNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758206823;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fw/Yvw7s2tvzq2t/RxZfpH8Sqi3RBXGHJOZqtZ0hiB0=;
 b=qZvhkbBWv2yPRIGjRE/M3Hxd4sng4aL1RP7d62eyD4h7csvhbxZdHDkXyFqT6CsAy0Ea6F
 bNc+5DC4JUJDRgDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 286F613A39;
 Thu, 18 Sep 2025 14:47:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q3A1NWYbzGiWTQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 18 Sep 2025 14:47:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang?=
 =?utf-8?Q?=C3=A9?= <berrange@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH v2 2/3] io/tls: Make qio_channel_tls_bye() always
 synchronous
In-Reply-To: <20250911212355.1943494-3-peterx@redhat.com>
References: <20250911212355.1943494-1-peterx@redhat.com>
 <20250911212355.1943494-3-peterx@redhat.com>
Date: Thu, 18 Sep 2025 11:47:00 -0300
Message-ID: <87bjn7vmvv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: B162C3368A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> No issue I hit, the change is only from code observation when I am looking
> at a TLS premature termination issue.
>
> qio_channel_tls_bye() API needs to be synchronous.  When it's not, the
> previous impl will attach an asynchronous task retrying but only until when
> the channel gets the relevant GIO event. It may be problematic, because the
> caller of qio_channel_tls_bye() may have invoked channel close() before
> that, leading to premature termination of the TLS session.
>

I'm not super versed on socket APIs, so bear with me: Wouldn't the
subsequent shutdown() before close() ensure that the io watch gets
triggered? Assuming we're atomically installing the watch before the
shutdown() (at the moment, we're not).

> Remove the asynchronous handling, instead retry it immediately.  Currently,
> the only two possible cases that may lead to async task is either INTERRUPT
> or EAGAIN.  It should be suffice to spin retry as of now, until a solid
> proof showing that a more complicated retry logic is needed.
>
> With that, we can remove the whole async model for the bye task.
>

With the bye() being synchronous, do we still have the issue when
migration fails? I guess it depends on what the answer to my question
above is...

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
> -        qio_task_set_error(task, err);
> -        qio_task_complete(task);
> -        return;
> -    }
> -
> -    if (status == QCRYPTO_TLS_BYE_COMPLETE) {
> -        qio_task_complete(task);
> -        return;
> -    }
> -
> -    data = g_new0(typeof(*data), 1);
> -    data->task = task;
> -    data->context = context;
> -
> -    if (context) {
> -        g_main_context_ref(context);
> -    }
> -
> -    if (status == QCRYPTO_TLS_BYE_SENDING) {
> -        condition = G_IO_OUT;
> -    } else {
> -        condition = G_IO_IN;
> -    }
> -
> -    trace_qio_channel_tls_bye_pending(ioc, status);
> -    ioc->bye_ioc_tag = qio_channel_add_watch_full(ioc->master, condition,
> -                                                  qio_channel_tls_bye_io,
> -                                                  data, NULL, context);
> -}
> -
> -
> -static gboolean qio_channel_tls_bye_io(QIOChannel *ioc, GIOCondition condition,
> -                                       gpointer user_data)
> -{
> -    QIOChannelTLSData *data = user_data;
> -    QIOTask *task = data->task;
> -    GMainContext *context = data->context;
> -    QIOChannelTLS *tioc = QIO_CHANNEL_TLS(qio_task_get_source(task));
> -
> -    tioc->bye_ioc_tag = 0;
> -    g_free(data);
> -    qio_channel_tls_bye_task(tioc, task, context);
> -
> -    if (context) {
> -        g_main_context_unref(context);
> +        return false;
> +    } else if (status != QCRYPTO_TLS_BYE_COMPLETE) {
> +        /* BYE event must be synchronous, retry immediately */
> +        trace_qio_channel_tls_bye_retry(ioc, status);
> +        goto retry;
>      }
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

