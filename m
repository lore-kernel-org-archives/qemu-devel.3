Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0D0C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 14:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgOyR-0002lD-7A; Fri, 07 Feb 2025 09:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgOyP-0002kv-F8
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:04:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgOyM-0006VY-K5
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738937084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4lbWVtC3BnSNs3F99/bduuyAaf1nbSBAxvwUs5lHP/g=;
 b=D4lAg6CeSmK0s3zomlqJjakptBATh8mGYMMyVtT0M8TSTD2b+XHmnON72MFNpUbvqDdB3Y
 ii4C6m986e0z8K01r8LQDnxxo5vAfqJu418Tg7Adv856OhtuPJGu97xcLG+7q5jOmiJ4N0
 DemkxdvN675gfO8uGFDLNmc7cML5EXE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-ycm1AGPCNIGug2ANDMIFdw-1; Fri, 07 Feb 2025 09:04:43 -0500
X-MC-Unique: ycm1AGPCNIGug2ANDMIFdw-1
X-Mimecast-MFC-AGG-ID: ycm1AGPCNIGug2ANDMIFdw
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-467bb8aad28so23529741cf.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 06:04:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738937083; x=1739541883;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4lbWVtC3BnSNs3F99/bduuyAaf1nbSBAxvwUs5lHP/g=;
 b=xSeVrSNwfhQEWFkCzJgrSUCrpH8Ew88suNgCuB6Oq0cJGp+Ytq9mDgNGSOmW8lR3yE
 GWMfl4bSXtTNqdL6YfOlBZEWEF2WTE+hXs+uFmGgx72VsfIRKJLRbq5kTrl7I+wn5rGR
 y/guY9ua1f68a3z5T0Hb3bdbwp178q7sddsQ0l5GJwEMuehRaKo/pftEa5ACA+2t7BLO
 XWGrPuUFD6HSHr7B9H6b61K/YJtDawiCNm/J9QsgfS+Sj7yL4kfNwa7Ji2VvoEDm1U4B
 TpCSzIXbK3AsybCnoWSvzG/W+K42Cszyon3DL2Mnd62ms3KQN4jrkH6OobLVbA9WF64s
 NvIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzaHJkMmUCKex3uKCQF9uivQHpqXfKMsdV8OKHOrA0roti7pFaFlYX91/pdYSALs7HnpwVMNrMelTf@nongnu.org
X-Gm-Message-State: AOJu0YyZv6ZxPMz+DiZHQMkIzeVnwp4HrhGU8w8J+AE15tI+LZqZ9Txq
 gEL3W2I3+UW8zADBgww1UizOhE30xEwWi08Yaxo9uv4uPIgkYx2lixEQ0xf0yAUai/GZFMDH4aN
 LGJdoOQi+Rq+Q634asQneqSRygYZ0LK3EUQblB7GvQiq/+mj0MCg+
X-Gm-Gg: ASbGncuD8IgmJTK3BGmu3sN9jEoP+PtuL+uQPHsPfP/4e1ENxobndsTIGaOnyMA2i7x
 shhoOJ1bYLMBlPaz66zS9H+kvTLYdc4OAEXphc7MQQ2y5st2VB31iULunD9IbwGcbyRGlhY8PuT
 OfZQhMQrHtnJDwFDir396Se5orUDC8QUq4niA3SM/Mqhe6h71/Jo6miP1lewefsXliz4zAVD+7n
 ugqI9TuMMEc3M8GPH6iIuiLFEd3QqwREzhViPZrORm2R2Dl+0fKNggDS/8DU0Rz/zYwVwl7JD6h
 7U+PDJl3gJ8Sc3Cl5NftfLliPu+k9Zvt9oZeMHoJvPVJMBXX
X-Received: by 2002:a05:622a:12:b0:46d:d2d2:3904 with SMTP id
 d75a77b69052e-47167b2e506mr53549581cf.33.1738937082670; 
 Fri, 07 Feb 2025 06:04:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvFRrcp8959XSABoY91njwXGDG+Abk0rXkGDMNP/5nojw6DIl7a0pCtWg+dJBH0GVhkESi5A==
X-Received: by 2002:a05:622a:12:b0:46d:d2d2:3904 with SMTP id
 d75a77b69052e-47167b2e506mr53549051cf.33.1738937082222; 
 Fri, 07 Feb 2025 06:04:42 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-471492763ebsm16816101cf.1.2025.02.07.06.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 06:04:41 -0800 (PST)
Date: Fri, 7 Feb 2025 09:04:39 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/33] migration/multifd: Allow premature EOF on TLS
 incoming channels
Message-ID: <Z6YS95V5RA9-UmGl@x1.local>
References: <87zfj0mcmy.fsf@suse.de> <87wme4m8ci.fsf@suse.de>
 <192db6a6-f3ff-4cf9-8537-b849fb3a97b3@maciej.szmigiero.name>
 <87tt97ma9l.fsf@suse.de>
 <ac6f56c0-58d9-45a4-bbf4-6b28649a8952@maciej.szmigiero.name>
 <87msezm75y.fsf@suse.de>
 <eba9c2d2-5a20-489c-aa89-8adde2781c7a@maciej.szmigiero.name>
 <87jza3m12b.fsf@suse.de> <Z6Uu50gzSIgKsiLA@x1.local>
 <87cyftnbc0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cyftnbc0.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Feb 07, 2025 at 10:17:19AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Feb 06, 2025 at 02:32:12PM -0300, Fabiano Rosas wrote:
> >> > In any case we'd still need some kind of a compatibility behavior for
> >> > the TLS bit stream emitted by older QEMU versions (which is always
> >> > improperly terminated).
> >> >
> >> 
> >> There is no compat issue. For <= 9.2, QEMU is still doing an extra
> >> multifd_send_sync_main(), which results in an extra MULTIFD_FLAG_SYNC on
> >> the destination and it gets stuck waiting for the
> >> RAM_SAVE_FLAG_MULTIFD_FLUSH that never comes. Therefore the src always
> >> closes the connection before dst reaches the extra recv().
> >> 
> >> I test migration both ways with 2 previous QEMU versions and the
> >> gnutls_bye() series passes all tests. I also put an assert at
> >> tlssession.c and never triggers for GNUTLS_E_PREMATURE_TERMINATION. The
> >> MULTIFD_FLAG_EOS should behave the same.
> >
> > Which are the versions you tried?  As only 9.1 and 9.2 has 637280aeb2, so I
> > wonder if the same issue would hit too with 9.0 or older.
> 
> Good point. 9.0 indeed breaks.
> 
> >
> > I'd confess I feel unreliable relying on the side effect of 637280aeb2,
> > because fundamentally it works based on the fact that multifd threads need
> > to be kicked out by the main load thread SYNC event on dest QEMU to avoid
> > the readv() from going wrong.
> >
> 
> We're relying on the opposite: mutlifd_recv NOT getting kicked. Which is
> a bug that 1d457daf86 fixed.
> 
> > What I'm not sure here is, is it sheer luck that the main channel SYNC will
> > always arrive _before_ pre-mature terminations of the multifd channels?  It
> > sounds like it could also happen when the multifd channels got its
> > pre-mature termination early, before the main thread got the SYNC.
> 
> You lost me here, what main channel sync? Its the MULTIFD_FLAG_SYNC that
> puts the recv thread in the "won't see the termination" state and that
> is serialized:
> 
>    SEND                        RECV
>    -------------------------+----------------------------
> 1  multifd_send_sync_main()
> 2  pending_sync==true,
> 3  send thread sends SYNC      recv thread gets SYNC
> 4  <some work>                 recv gets stuck.
> 5  multifd_send_shutdown()     <time passes>
> 6  shutdown()                  multifd_recv_shutdown()
>                                recv_terminate_threads()
>                                recv exits without recv()
> 
> In other words, RECV would need to see the shutdown (6) before the SYNC
> (3), which I don't think it possible.

Ah yeah, I somehow remembered we sent a SYNC in the main channel but forgot
to push the per-channel SYNC.  I got it the other way round.  Yeah if data
is always ordered with shutdown() effect on recv then it seems in order.

> 
> >
> > Maybe we still need a compat property at the end..
> 
> This is actually similar to preempt_pre_7_2, what about:
> 
>     /*
>      * This variable only makes sense when set on the machine that is
>      * the destination of a multifd migration with TLS enabled. It
>      * affects the behavior of the last send->recv iteration with
>      * regards to termination of the TLS session. Defaults to true.
>      *
>      * When set:
>      *
>      * - the destination QEMU instance can expect to never get a
>      *   GNUTLS_E_PREMATURE_TERMINATION error. Manifested as the error
>      *   message: "The TLS connection was non-properly terminated".
>      *
>      * When clear:
>      *
>      * - the destination QEMU instance can expect to see a
>      *   GNUTLS_E_PREMATURE_TERMINATION error in any multifd channel
>      *   whenever the last recv() call of that channel happens after
>      *   the source QEMU instance has already issued shutdown() on the
>      *   channel. This is affected by (at least) commits 637280aeb2
>      *   and 1d457daf86.

If we want to reference them after all, we could use another sentence to
describe the effects:

       *   Commit 637280aeb2 (since 9.1) introduced a side effect to cause
       *   pre-mature termination not happen, while commit 1d457daf86
       *   (since 10.0) can unexpectedly re-expose the pre-mature
       *   termination issue.

>      *
>      * NOTE: Regardless of the state of this option, a premature
>      * termination of the TLS connection might happen due to error at
>      * any moment prior to the last send->recv iteration.
>      */
>     bool multifd_clean_tls_termination;
> 
> And I think the more straight-forward implementation is to incorporate
> Maciej's premature_ok patches (in some form), otherwise that option will
> have to take effect on the QIOChannel which is a layering violation.

If we take Dan's comment into account:

https://lore.kernel.org/r/Z6I86e-hzJAlxk0r@redhat.com

It means whenever multifd recv thread invokes the iochannel API it will use
multifd_clean_tls_termination to decide QIO_CHANNEL_READ_RELAXED_EOF flag
to pass in.  I hope this is not layer violation, or I could miss something..

So if we're on the same page we need that knob, to make this series easier
we could make it two steps:

  - Step 1: introduce the parameter and QIO_CHANNEL_READ_RELAXED_EOF, set
    it default to false.

  - Step 2: Your other RFC series to implement gnutls_bye(), at last make
    it a compat property and switch default true.

Then Maciej only needs step 1, it looks to me.

-- 
Peter Xu


