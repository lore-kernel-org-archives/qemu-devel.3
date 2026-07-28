Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7105EC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 20:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woohN-0008Cs-IT; Tue, 28 Jul 2026 16:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1woohL-0008CQ-2X
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 16:46:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1woohJ-0001IF-5S
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 16:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785271603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tyYrci+SqDiXj523SP2QWHVzT3hYSaTidHhfmmseMQM=;
 b=UP140JqR1+M44dhSm24UkSic3jb0+JCaDeVckc/O1H11V6sU/gOh5fJiDYH8owURCbGnRY
 +5Zs53vwsFmdM+qVsmRbzwjqPSlOZiD8L9lSy5sHW/guqf/0cWUlSwPNlMlE6eUHZ0AE4v
 zYeMSpB+bJBVU4suRtuYkHAa7UUadj4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-DdaA1b2gM-CpkhJ3VTchGw-1; Tue, 28 Jul 2026 16:46:42 -0400
X-MC-Unique: DdaA1b2gM-CpkhJ3VTchGw-1
X-Mimecast-MFC-AGG-ID: DdaA1b2gM-CpkhJ3VTchGw_1785271601
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-90410c668adso2997116d6.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 13:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785271601; x=1785876401; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tyYrci+SqDiXj523SP2QWHVzT3hYSaTidHhfmmseMQM=;
 b=qpUkivbBPJNUl1omI4DD9pilB8P1aZG2GO3EH1EGdA1e7/sQa4kaTmSAlNWgp0kI87
 rZGB6NlF8cFuV5CQwcHczpzDecBC30bHIZvGkJs/tUsNNiGJWjeue/pFCGqfXuk2VVUS
 7UI1Rtd7tveTcKcd12J2TuvhoGITqazMvdXRLdwJJXIgAsGh74bZjyieKpsnnd+3vRcs
 a8sRD3SdvzC/BOJ5XE/xY6cIc32hgtNFhh/edyjOh3D/KymY/aFHxcCKqvtUNdlxJ9xd
 RZLsE9Lqao86qyZR3Ee06Twsv+EfO7eHM7TbPwXfAIcP9+XMyxL84BUErufsVdp17ykJ
 Km8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785271601; x=1785876401;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tyYrci+SqDiXj523SP2QWHVzT3hYSaTidHhfmmseMQM=;
 b=ImU9W0AOLDTDj4075I5tGQySQbTBloBUPGhHpOc8Y7LQIFGNERHtO/3Z3bNHW7q+KB
 B+dDp2QxuX8/k2rkxtRZSmOLbJqJE4rZU59kc0VD+e5ZEOGEM60cnE8w1XtuLMh0nH/v
 LcDSfGD0jgngIr2SHmY0Rq3XkC1Zvb/JmER3bgVpZ6xRV5p1jAvjioX2xhk++I9vPqGs
 ZweskC7mn3EiHfFp8yRu3w8zsDIF7Z0K9nU2bUuoCucdYkK+2v38Mu9vaYxpFl8mX+g+
 3OFO/jY7s0LXtek05EBjfDAaKUnep8dHisTTIgQisSW+Jfd8Ui5RalVf+U94/cMZVZhS
 bimA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqbL744zkPHaMF0724bOEap9ETOnmOMK8ANc276lLgXPb16p/m+ctz+oh1yw3YKb4XjRPO5EaXqzWpu@nongnu.org
X-Gm-Message-State: AOJu0Yx2+JK99s/4gELqv6jPC6WUMNdunkbzDY3UuYcn6ZM4azw+FB4H
 qCp7VrvnTQjKsSiPjgxD1YtCMJk7ncxN9EIDljsxIW97D7K/u0/qSN+s2rH3tT6e2hD4Q/qptN4
 GfVG7sE2mJvoR9nNSMVLRkITKSZt9A5RNzJkGx5eXCqb4Dlv54vJFii+O
X-Gm-Gg: AR+sD13b1tWhe+TTOFu4XsVHdOuGWV5blsNW3KYhFP8JqSd9p7JVcM1rOgAvDmwnF8f
 SQZu21xfHJGtP38WaKbH+CKgxNOAbMohPpnhNwufe1narB5+sQarUGGsFVkoQ1LzjL6UIDp5z2E
 abYH2vq2mOUBwdNUQxOHSfnPIfrQS959+wUcaYf8U0jaXaG+nplg9zUnmtG5VZnYvZNioI59Iun
 F9G7erItb7IaUXKGJ7aoFhPqqDaWKPhOcrZpbN0mbLMs48LOHIhBNIrQytpN4E20YRug4AD+isT
 36gkMWTBHuH6lDO7p7kmnFWnOX2BD6PHWULM5XZw9jBlUpo8hpNpdgzmf2f4cHAG1gwn
X-Received: by 2002:a05:6214:310d:b0:8f2:5a3e:c5fe with SMTP id
 6a1803df08f44-908172dca3cmr43825196d6.45.1785271601289; 
 Tue, 28 Jul 2026 13:46:41 -0700 (PDT)
X-Received: by 2002:a05:6214:310d:b0:8f2:5a3e:c5fe with SMTP id
 6a1803df08f44-908172dca3cmr43824886d6.45.1785271600720; 
 Tue, 28 Jul 2026 13:46:40 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9081dd8cb0dsm7482806d6.48.2026.07.28.13.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 13:46:39 -0700 (PDT)
Date: Tue, 28 Jul 2026 16:46:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Feifan Qian <bea1e@proton.me>
Subject: Re: [PATCH 4/5] migration: Fix rare hang of
 migration_channel_read_peek()
Message-ID: <amkVJZ14O60zAeVt@x1.local>
References: <20260728155247.1894355-1-peterx@redhat.com>
 <20260728155247.1894355-5-peterx@redhat.com>
 <amjXxDH73ah-dUGE@redhat.com> <amjiLyOJF92okvik@x1.local>
 <87o6fqopgn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o6fqopgn.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 28, 2026 at 04:59:20PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Jul 28, 2026 at 05:24:36PM +0100, Daniel P. Berrangé wrote:
> >> On Tue, Jul 28, 2026 at 11:52:46AM -0400, Peter Xu wrote:
> >> > In an unlikely case, when a migration stream is attached to the destination
> >> > QEMU and only send <4 bytes to the channel as magic, it's possible that
> >> > migration_channel_read_peek() may spin forever without yielding in the main
> >> > thread causing two unwanted consequences:
> >> > 
> >> > - CPU will spin 100% waiting for the rest bytes until it reaches 4
> >> > - (more importantly..) Main thread is stuck during this process as the qio
> >> >   operation won't really yield the coroutine
> >> > 
> >> > Fix it by consuming the bytes that arrived.
> >> > 
> >> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3889
> >> > Cc: Daniel P. Berrangé <berrange@redhat.com>
> >> > Reported-by: Feifan Qian <bea1e@proton.me>
> >> > Signed-off-by: Peter Xu <peterx@redhat.com>
> >> > ---
> >> >  migration/channel.c | 26 +++++++++++++++++++++++---
> >> >  1 file changed, 23 insertions(+), 3 deletions(-)
> >> > 
> >> > diff --git a/migration/channel.c b/migration/channel.c
> >> > index 1e2935f926..28fe1d2906 100644
> >> > --- a/migration/channel.c
> >> > +++ b/migration/channel.c
> >> > @@ -294,11 +294,31 @@ int migration_channel_read_peek(QIOChannel *ioc,
> >> >              return -1;
> >> >          }
> >> >  
> >> > -        if (len == buflen) {
> >> > +        if (len == iov.iov_len) {
> >> >              break;
> >> > -        }
> >> > +        } else if (len == 0) {
> >> > +            qio_channel_wait_cond(ioc, G_IO_IN);
> >> > +        } else {
> >> > +            ssize_t received = len;
> >> >  
> >> > -        qio_channel_wait_cond(ioc, G_IO_IN);
> >> > +            /*
> >> > +             * Partially arrived, read out to make qio_channel_wait_cond()
> >> > +             * won't return immediately, causing an unwanted spin on this
> >> > +             * CPU.
> >> > +             */
> >> > +            iov.iov_len = len;
> >> > +            len = qio_channel_readv_full(ioc, &iov, 1, NULL, NULL, 0, errp);
> >> 
> >> Sure this breaks the API behaviour that the caller is expecting to
> >> see.
> >> 
> >> migration_channel_identify will call migration_channel_read_peek
> >> to match the magic bytes.
> >> 
> >> But something later in the flow will actually try to read the magic
> >> bytes.  By consuming them in this migration_channel_read_peek
> >> method, surely we're breaking the code that wants to read the bytes
> >> later.
> >
> > Ah right, stupid me.  The best then is for partial read we apply a manual
> > wait.
> >
> > I can also revert 604bb1badc ("migration: Properly wait on G_IO_IN when
> > peeking messages"), looping with 1ms interval for data isn't too bad.  But
> > the best is we only do that for partial, so:
> >
> > diff --git a/migration/channel.c b/migration/channel.c
> > index 1e2935f926..88f89521f8 100644
> > --- a/migration/channel.c
> > +++ b/migration/channel.c
> > @@ -296,9 +296,19 @@ int migration_channel_read_peek(QIOChannel *ioc,
> >
> >          if (len == buflen) {
> >              break;
> > +        } else if (len == 0) {
> > +            qio_channel_wait_cond(ioc, G_IO_IN);
> > +        } else {
> > +            /*
> > +             * When partially ready, we can't use qio_channel_wait_cond()
> > +             * because it will return immediately.  Apply a manual wait.
> > +             */
> > +            if (qemu_in_coroutine()) {
> 
> There's no coroutine at this point, could replace this with an assert.

Hmm, true..  Then it means this can stuck the main thread even if no data
arrived (len==0), hang monitors..  I hope it's not a major issue and
shouldn't easily happen in real life, because normally when src connected,
at least the headers will be dumped very soon.

I'll switch to assert for now.

> 
> > +                qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000);
> > +            } else {
> > +                g_usleep(1000);
> > +            }
> >          }
> > -
> > -        qio_channel_wait_cond(ioc, G_IO_IN);
> >      }
> >
> >      return 0;
> >
> > Any preference?
> >
> > Thanks,
> >
> >> 
> >> > +            /*
> >> > +             * QIO_CHANNEL_ERR_BLOCK also shouldn't happen, due to the
> >> > +             * prior peek just happened.  We should be pretty sure we will
> >> > +             * read what we peeked, or the channel was broken.
> >> > +             */
> >> > +            if (len != received) {
> >> > +                return -1;
> >> > +            }
> >> > +            iov.iov_base += received;
> >> > +            iov.iov_len = buflen - received;
> >> > +        }
> >> >      }
> >> >  
> >> >      return 0;
> >> > -- 
> >> > 2.54.0
> >> > 
> >> 
> >> With regards,
> >> Daniel
> >> -- 
> >> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> >> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> >> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
> >> 
> 

-- 
Peter Xu


