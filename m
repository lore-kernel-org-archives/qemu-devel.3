Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C977CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 15:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux5px-0003kk-OV; Fri, 12 Sep 2025 11:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ux5pu-0003kJ-Eu
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 11:37:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ux5po-0006Cl-9s
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 11:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757691426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eVp8TpoHLW8SnmnqxnKjIkE4TG/JukuxLYm74vQ3Ixs=;
 b=NpYndXPbcl4hhte8lov/k1rA5nqG19zTm+C5CoPQ9K7KAXSxVc+1hR2pGY/vzRCnu1ZVKe
 3Gy99k575wllsz+0hMY6Z6erS8xYXv2O+vjwHX8lwmh+q4iycVYGOFP4DaiR6XGajXf4xt
 DIHIDSztVnUUkzhtS7thZ9HPnxwX+yI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-ashIqv_QM_qRWL_jer4fkQ-1; Fri, 12 Sep 2025 11:37:05 -0400
X-MC-Unique: ashIqv_QM_qRWL_jer4fkQ-1
X-Mimecast-MFC-AGG-ID: ashIqv_QM_qRWL_jer4fkQ_1757691425
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-70ddadde46bso41255646d6.2
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 08:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757691425; x=1758296225;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eVp8TpoHLW8SnmnqxnKjIkE4TG/JukuxLYm74vQ3Ixs=;
 b=T0YkSvaceSbEbAHaDV3SZY3H+5IFpC9x9GrqDDFTzkLyFjnJbHOZmsUzvKp3hMQm1/
 UFBSH48j1YRnnsne2YT19qiaqzpC7xQ4cU92DuuTevx++MasdxpRAW/XxQPHj4+Zdmgy
 KQEoYXDeR6Y09CHqRQfS653XPce3vJz59VT0T/lN5eUj/pJ3X8wiYQ2CO4SiaKLbLEGE
 MZ85E01Q4nwHpPO2MSfcXQYdTlXRARzdB2agabvhxc0qSTfENukLk8d2QsSsiSVWbA6b
 M/OKhuetAUQyIZTSomjFDtc2nokfvMUj14XOHjDFaIYILVNElI1ARAoBj95wlOgDDcMc
 855g==
X-Gm-Message-State: AOJu0YwXKmle1Ntd+0GfidD/JcrivzScTMIHWCQv+GbQ3OUEOmnljqKy
 +m1BpEy+7sqhgBZy6N/a0huT83eOPEtHXdxIZbD4zlnskHOGMGFf7eHtMmlyRr+bavfvhX4aTrs
 uI5dcSwzXRXUn1LZB3XWVscs3U4i4jRg0hEB2C8shgQGe42Vvzz+i4irc
X-Gm-Gg: ASbGncuDDguMnr+ljdm9t7IWEYMuCBK7jT7pE+bCmHdHN3eRK0q+nJzHFroWzDN8wWj
 0t+YExAvirSe0n7npY/Yywqs6Xp+Zfk764rfdXXpu/AzfLgy5/9hf/FB2lJ6qn5iCnlJi4ha89d
 GlXoZjFhRIaUn3B0fVaW1PAkpXwcrnb6zwhaHOFLpY7H2BtYI1dVp95udjhV5oALolLwkOiFp+B
 Yl5R31XxKBWcziIIyN1tKVvqcUJKPBVKJ0X+GIRGupwJorJgqdziZ8tgzf8cOdwRlDcR+snI7Xo
 T5Yw8th+36Dr6UHMcD8PWc7aVNOfd2qD
X-Received: by 2002:ad4:5aa7:0:b0:70d:ed3a:38c with SMTP id
 6a1803df08f44-767c506486dmr37024376d6.62.1757691424761; 
 Fri, 12 Sep 2025 08:37:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9PxWBRI44FfYL4fArTe400dVn31DoU2Yak0z2I1pPDkq0ZN+Oe4bxbI8ZUoQWagMdz4xd5g==
X-Received: by 2002:ad4:5aa7:0:b0:70d:ed3a:38c with SMTP id
 6a1803df08f44-767c506486dmr37023896d6.62.1757691424150; 
 Fri, 12 Sep 2025 08:37:04 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-76e576ee0fcsm5403476d6.69.2025.09.12.08.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 08:37:03 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:36:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 2/3] io/tls: Make qio_channel_tls_bye() always
 synchronous
Message-ID: <aMQ-E8BkvQq6Pisx@x1.local>
References: <20250911212355.1943494-1-peterx@redhat.com>
 <20250911212355.1943494-3-peterx@redhat.com>
 <aMQDuFI2hQQ8clAF@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMQDuFI2hQQ8clAF@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 12, 2025 at 12:27:52PM +0100, Daniel P. Berrangé wrote:
> On Thu, Sep 11, 2025 at 05:23:54PM -0400, Peter Xu wrote:
> > No issue I hit, the change is only from code observation when I am looking
> > at a TLS premature termination issue.
> > 
> > qio_channel_tls_bye() API needs to be synchronous.  When it's not, the
> > previous impl will attach an asynchronous task retrying but only until when
> > the channel gets the relevant GIO event. It may be problematic, because the
> > caller of qio_channel_tls_bye() may have invoked channel close() before
> > that, leading to premature termination of the TLS session.
> > 
> > Remove the asynchronous handling, instead retry it immediately.  Currently,
> > the only two possible cases that may lead to async task is either INTERRUPT
> > or EAGAIN.  It should be suffice to spin retry as of now, until a solid
> > proof showing that a more complicated retry logic is needed.
> > 
> > With that, we can remove the whole async model for the bye task.
> > 
> > When at it, making the function return bool, which looks like a common
> > pattern in QEMU when errp is used.
> > 
> > Side note on the tracepoints: previously the tracepoint bye_complete()
> > isn't used.  Start to use it in this patch.  bye_pending() and bye_cancel()
> > can be dropped now.  Adding bye_retry() instead.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/io/channel-tls.h |  5 ++-
> >  io/channel-tls.c         | 86 +++++-----------------------------------
> >  io/trace-events          |  3 +-
> >  3 files changed, 15 insertions(+), 79 deletions(-)
> > 
> > diff --git a/include/io/channel-tls.h b/include/io/channel-tls.h
> > index 7e9023570d..bcd14ffbd6 100644
> > --- a/include/io/channel-tls.h
> > +++ b/include/io/channel-tls.h
> > @@ -49,7 +49,6 @@ struct QIOChannelTLS {
> >      QCryptoTLSSession *session;
> >      QIOChannelShutdown shutdown;
> >      guint hs_ioc_tag;
> > -    guint bye_ioc_tag;
> >  };
> >  
> >  /**
> > @@ -60,8 +59,10 @@ struct QIOChannelTLS {
> >   * Perform the TLS session termination. This method will return
> >   * immediately and the termination will continue in the background,
> >   * provided the main loop is running.
> > + *
> > + * Returns: true on success, false on error (with errp set)
> >   */
> > -void qio_channel_tls_bye(QIOChannelTLS *ioc, Error **errp);
> > +bool qio_channel_tls_bye(QIOChannelTLS *ioc, Error **errp);
> >  
> >  /**
> >   * qio_channel_tls_new_server:
> > diff --git a/io/channel-tls.c b/io/channel-tls.c
> > index 5a2c8188ce..8510a187a8 100644
> > --- a/io/channel-tls.c
> > +++ b/io/channel-tls.c
> > @@ -253,84 +253,25 @@ void qio_channel_tls_handshake(QIOChannelTLS *ioc,
> >      qio_channel_tls_handshake_task(ioc, task, context);
> >  }
> >  
> > -static gboolean qio_channel_tls_bye_io(QIOChannel *ioc, GIOCondition condition,
> > -                                       gpointer user_data);
> > -
> > -static void qio_channel_tls_bye_task(QIOChannelTLS *ioc, QIOTask *task,
> > -                                     GMainContext *context)
> > +bool qio_channel_tls_bye(QIOChannelTLS *ioc, Error **errp)
> >  {
> > -    GIOCondition condition;
> > -    QIOChannelTLSData *data;
> >      int status;
> > -    Error *err = NULL;
> >  
> > -    status = qcrypto_tls_session_bye(ioc->session, &err);
> > +    trace_qio_channel_tls_bye_start(ioc);
> > +retry:
> > +    status = qcrypto_tls_session_bye(ioc->session, errp);
> >  
> >      if (status < 0) {
> >          trace_qio_channel_tls_bye_fail(ioc);
> 
> snip
> 
> > +        return false;
> > +    } else if (status != QCRYPTO_TLS_BYE_COMPLETE) {
> > +        /* BYE event must be synchronous, retry immediately */
> > +        trace_qio_channel_tls_bye_retry(ioc, status);
> > +        goto retry;
> >      }
> 
> We cannot do this. If the gnutls_bye() API needs to perform
> socket I/O, and so when we're running over a non-blocking
> socket we must expect EAGAIN. With this handling, QEMU will
> busy loop burning 100% CPU when the socket is not ready.

Right.  That was the plan when drafting this, the hope is spinning will
almost not happen, and even if it happens it'll finish soon (migration is
completing, it means network mustn't be so bad), unless the network is
stuck exactly at when we send the bye().

> 
> A second point is that from a QIOChannel POV, we need to
> ensure that all APIs can be used in a non-blocking scenario.
> This is why in the QIOChannelSocket impl connect/listen APIs
> we provide both _sync and _async variants of the APIs, or
> in the QIOChannelTLS impl, the handshake API is always
> async with a callback to be invokved on completion.

I agree.  The issue is if so, migration code needs to be always be prepared
with a possible async op even if in 99.9999% cases it won't happen... we
need to complicate the multifd logic a lot for this, but the gain is
little..

This series still used patch 1 to fix the problem (rather than do real BYE
on preempt channels, for example) only because it's the easiest, after all
it's still a contract in tls channel impl to allow premature termination
for explicit shutdown()s on the host.

If we want to do 100% graceful shutdowns, we'll need to apply this to all
channels, and the async-possible model can definitely add more complexity
more than multifd.  I hope it won't be necessary.. but just to mention it.

> 
> The QIOChanel 'bye' method is flawed in that it is
> asynchronous, but has no callback for completion.
> 
> If migration is /always/ using a blocking socket for the
> TLS channels this isn't a problem as gnutls will complete
> immediately, but if any async sockets are used we have no
> way to wait for completion. This requires improving the
> API design in some manner.

I recall one of your future series on TLS would start to enable async for
all channels?  In all cases, we definitely don't want to have this call to
be relevant to the blocking mode of the channels.

Would it make sense to introduce a _sync() version of it, but keep the
original bye(), leaving the rest until a real async user appears?

I can also at least drop this patch as of now, because we can still wish it
almost always be synchronous.  However we have risk forgetting that forever
and hit it a few years later..

Thanks,

-- 
Peter Xu


