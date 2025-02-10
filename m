Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44FCC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thX86-0007Oy-8x; Mon, 10 Feb 2025 11:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thX82-0007OZ-VC
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:59:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thX7z-0000aZ-G5
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739206761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=itN26Kc40dx9BaGMdIVqRrw3j4psHzo6wQpQCo0jOrU=;
 b=S/ut7QWL7+SxzsOGBr83w3CVOSFMM4zQIKLkSGJIPM0guMFFqh9Xk7R4sv64Gs4qN6fqlv
 MVeBzloRRgf605wDsFtO1UjrPwtBE8uo3gtrPbsfTMQC4wqSCfOvynjAnptHDkcNInRaGU
 6xDXginn+XQNUlSjcLjVO55xEHJPMFI=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-hSLye_1MM3iwMCsr4M7V2Q-1; Mon, 10 Feb 2025 11:59:20 -0500
X-MC-Unique: hSLye_1MM3iwMCsr4M7V2Q-1
X-Mimecast-MFC-AGG-ID: hSLye_1MM3iwMCsr4M7V2Q
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5fc7ad27b87so1233709eaf.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:59:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739206759; x=1739811559;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=itN26Kc40dx9BaGMdIVqRrw3j4psHzo6wQpQCo0jOrU=;
 b=AmYAT10a/eYdD6PBUF7MPr6Zku/xoZNQss5KpZuHvpI/NrYnpfdXyZo/kSBiIN6DtK
 gGQ80rdm6muetehdYfIId4/K7G8yyNjkDukO0Xz4dZe+ZY8W7VlFMm2mWhIi7Wmghjt+
 3XQiM8EBwnPN5aYYXXXdWEhWS2qM4T5USzQKTFj+UjLiU2Un9GFkUMFZcY0x89jO32Qa
 T69VMl+HMnV1NnOmCqujXCHM512pb1jX7fSxUe35/H1hgggF5CEiLP6x0+2XrDYSnzsX
 kLNDoaX8uuR6IEPO1vYx1j/4tjkkKvTpb31MCQ5CF+z/InRDYBFajccytsIPKBk+Elnh
 +x8Q==
X-Gm-Message-State: AOJu0YwTW0mjq69thUKFsVUZV5FY1Tbop85zVOqm0/PzGkvpsengAUdL
 NGiPlIWB2zIioPE8Mw5glAQdTKvjiu+D+BEzJY22HhLWrKfBeIriyvNFuDhkW2LDNzx8NuVk9O6
 JZwDHbVwGO7f6lP2eItVIFTgD48UckA9wsBBChxP+LKaAlpbNMbOg
X-Gm-Gg: ASbGnctEd1w0W1W3X9EQoANTsAOH1uvYA5/ytkq1SYvAjcDtRTdinOzuMWjdFqVd3eo
 THgxaMi7xZh3tyyO0E54gyH82JOMaty11Wxoaiw/+W7knRno+Bpz914T0rdWlcDlikSicpq+14R
 a5FeHJdhW+Q263zzHu+2snemQUT2jKJbJI1U2WdcEHkuf6Jb+ICblLsIhzel71DAROtUXANI00O
 0sDk8DRvN2E6l7OjwW4A1evXzG1ZGpKmWfu/Vd/rIMArgDgJ6btGDpkW+s=
X-Received: by 2002:a05:6870:56ac:b0:29e:4b60:d992 with SMTP id
 586e51a60fabf-2b8b6f9b37fmr15489fac.13.1739206759559; 
 Mon, 10 Feb 2025 08:59:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMJyWd4LmxN6JBtXZQULDXyRaYqnJtcSSik9BjsTOjTpwFOCJWmUs71jixRzRiyS0PxiJ0ZQ==
X-Received: by 2002:a05:6870:56ac:b0:29e:4b60:d992 with SMTP id
 586e51a60fabf-2b8b6f9b37fmr15466fac.13.1739206759174; 
 Mon, 10 Feb 2025 08:59:19 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b825ea9c20sm2586964fac.19.2025.02.10.08.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:59:18 -0800 (PST)
Date: Mon, 10 Feb 2025 11:59:14 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v5 3/5] migration: enable multifd and postcopy together
Message-ID: <Z6owYoktb5nk2yRw@x1.local>
References: <20250205122712.229151-1-ppandit@redhat.com>
 <20250205122712.229151-4-ppandit@redhat.com>
 <Z6VCxEKxn6-_okRx@x1.local>
 <CAE8KmOwJSYq2Ok38_sq29cr7JhbLLh1ZEncP13QpDdnYKOAheQ@mail.gmail.com>
 <Z6YqstgG2bSY45dM@x1.local>
 <CAE8KmOwMTw-m0w+JbFBZ7mn-ZuSNfpk9xbq-_KbLXu7_kDhDVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOwMTw-m0w+JbFBZ7mn-ZuSNfpk9xbq-_KbLXu7_kDhDVg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Feb 08, 2025 at 04:06:56PM +0530, Prasad Pandit wrote:
> Hello Peter,
> 
> On Fri, 7 Feb 2025 at 21:16, Peter Xu <peterx@redhat.com> wrote:
> > This is not easy to follow neither with the current name, nor that you
> > "assumed this is main channel" and test it.
> 
> * It is not my doing, nor is there any assumption, but that is how
> current implementation works.
> ===
> static bool migration_should_start_incoming(bool main_channel)
> {
>     /* Multifd doesn't start unless all channels are established */
>     if (migrate_multifd()) {
>         return migration_has_all_channels();
>     }
> 
>     /* Preempt channel only starts when the main channel is created */
>     if (migrate_postcopy_preempt()) {
>         return main_channel;
>     }
> 
>     /*
>      * For all the rest types of migration, we should only reach here when
>      * it's the main channel that's being created, and we should always
>      * proceed with this channel.
>      */
>     assert(main_channel);
>     return true;
> }
> ===
> * Above code returns 'true' for 'multifd' and 'main_channel' cases.
> When migrate_postcopy_preempt() is true, main_channel is 'false', so
> it returns false. All I have done is reused the
> migration_should_start_incoming() function to simplify the 'if'
> conditional at the top.

Yes, and I suggest a rename or introduce a new helper, per previous reply.

> 
> > I think you may want to split
> > migration_has_all_channels() into migration_has_essential_channels() which
> > only covers main and multifd cases.  Then you can check if (!has_esential)
> > here.  You'd better also add a comment that all "essential channels" can be
> > peeked.
> >
> > You may also want to bypass a few things, e.g. "postcopy paused stage" here
> > rather than inside, because postcopy-recover only happens:
> >
> >   - First with a main channel, that is not peekable as no header when resume
> >   - Then with preempt channel, that is also not peekable
> >
> > [a]
> >
> > You may also need to keep the mapped-ram check.  They also don't support
> > peek.
> 
> * Instead of adding specific conditions and splitting functions, my
> request is, let's work towards consistent channel behaviour that will
> automatically simplify these conditions and channel handling. Maybe we
> can do that in a subsequent series.

I didn't follow, sorry - do you mean this patch is correct on dropping the
mapped-ram check? I don't yet understand how it can work if without.

> 
> > >
> > > > > +        } else if (mis->from_src_file
> > > > > +            && (!strcmp(ioc->name, "migration-tls-incoming")
> > > > > +                || !strcmp(ioc->name, "migration-file-incoming"))) {
> > > > > +            channel = CH_MULTIFD;
> > > >
> > > > Confused here too.  Why do we need to check ioc name? Shouldn't multifd has
> > > > the headers?
> > >
> > > * Because they are not 'multifd' channels, tls/file channels don't
> > > send magic values, but are still handled by
> >
> > It might be because you have a bug where you removed mapped-ram check at
> > [b] above.  I think we need to keep it.
> 
> * ie. Because I removed the mapped-ram check, so tls/file channels are
> handled by multifd_recv_new_channel()? No, that's not the case.
> Rather, that is how it works currently. I have not changed anything,
> only made it more explicit to see that when it is tls/file channel,
> handle it as a CH_MULTIFD type. Looking at the current code, one can
> not see clearly how tls/file channels are handled.
> 
> > Why TLS channels don't send magic?
> 
> * Probably because they do TLS hand-shake while establishing a connection?

I meant tls channels should have these magics too.  Do you mean they're
not?

> 
> > > because if multifd page is getting late, that network
> > > latency should affect 'postcopy' channel too, no? But still if it is
> >
> > I don't think so.  postcopy doesn't use any multifd channels.
> 
> * Yes, but it uses the same wire/network.
> 
> > > possible, do we want to call - multifd_ram_flush_and_sync() before
> > > postcopy_start()? Will that help?  I'll check if/how it works.
> >
> > Note that all things flushed may or may not be enough, because IIUC the
> > flush only makes sure all threads are synced.
> 
> * We are again using 'flush' and 'sync' interchangeably. What does -
> flush only makes sure all threads are synced - mean really? Is it not
> writing all socket data onto the wire/channel?
> 
> * Flush should write all socket data onto the network wire/channel.
> The _order_ in which threads flush/write their socket data onto the
> wire/channel is to synchronise them, maintaining/controlling that
> _order_ is not flush.
> 
> > It may not make sure the order of things to happen in multifd threads and postcopy thread.  The
> > latter is what we need - we need to make sure no page land in postcopy threads.
> 
> * Let's see:
>    1) When migration is in Postcopy mode, ram_save_multifd_page() is
> _not_ called on the source side. ie. no multifd data gets enqueued on
> the multifd queue.
>        1.1) multifd_queue_page() function also calls multifd_send() if
> the queue is full, before enqueueing new pages.
>    2) If a multifd page reaches the destination during Postcopy mode,
> it must have been sent/written on the multifd channel before Postcopy
> mode started, right?

Yes.

>    3) In this case, writing/flushing all multifd socket data onto the
> wire/channel, before calling postcopy_start() function should help
> IIUC.
>        3.1) ie. calling multifd_send() before postcopy_start() should
> help to clear the multifd queue, before Postcopy begins.
>        3.2) Same can be done by - multifd_ram_flush_and_sync() ->
> multifd_send() - sequence.

No I don't think so.

Flushing sending side makes sure send buffer is empty.  It doesn't
guarantee recv buffer is empty on the other side.

> 
> * If all multifd pages are sent/written/flushed onto the multifd
> channels before postcopy_start() is called, then multifd pages should
> not arrive at the destination after postcopy starts IIUC.  If that is
> happening, we need a reproducer for such a case. Do we have such a
> reproducer?

With or without a reproducer, we need to at least justify it in theory.  If
it doesn't even work in theory, it's a problem.

> 
> > That's why I was requesting to add an assert() in multifd recv thread to
> > make sure we will never receive a page during postcopy.
> 
> * ie. Add  assert(!migrate_in_postcopy())  in multifd_recv_thread()
> function?  Okay.

Yes, probably before multifd_recv_state->ops->recv().

Thanks,

-- 
Peter Xu


