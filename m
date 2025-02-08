Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9106DC02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 10:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgiDJ-0007kf-Jl; Sat, 08 Feb 2025 05:37:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tgiDE-0007h4-9E
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 05:37:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tgiDC-0003Xt-3b
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 05:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739011038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SLAyhO5EppmeNmk7FyuS9ihrjvhmQwqck9w5cySdTyY=;
 b=GE5fj4DHqK6C9KoMH1UKzqDOk2VEaLk232or2HVOY8lQVIkGnXaV759iP8UVKqCi6ztkOP
 m2L+qLqqDZYNUXQfcTNkDWNhA4SXzT2+ICR7nHHEvmrlUvjJeHpnvDgI7+9/5nPhAe4Yxw
 J49o6mr3fNSv/7ZW+HzDJAlvfSlR4xk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-QJwqN0XDPCWBKFnym4SR5A-1; Sat, 08 Feb 2025 05:37:15 -0500
X-MC-Unique: QJwqN0XDPCWBKFnym4SR5A-1
X-Mimecast-MFC-AGG-ID: QJwqN0XDPCWBKFnym4SR5A
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43935bcec0aso1538335e9.3
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 02:37:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739011034; x=1739615834;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SLAyhO5EppmeNmk7FyuS9ihrjvhmQwqck9w5cySdTyY=;
 b=Cmudc1RCe4jE5xLN2VirLPh7Rbl502YLcDCUIAYsvrXkjG0nPwHJ8/evKD/jn/KEo4
 3aX1vYZVlIYq5NqUcSDoyWSE25bzo4716ksF/IZdBQg+hRENoM44FgaljxF+ivaiTZX4
 jBgcoARVBfJkMhZoazHcL2DomjEyBdzO+0SHNI+cgg91+YWeZH9y8g/sYhnsdfJ4IUiu
 kguFyXIVlpf1XvUam1mzw28Cr0PTWP7AA7WfMzZFc56olVlS5aYifqq4so/kGu3hT3RL
 FtnZAFDOWvLoYvJyDb0o0s5kUC0SaTxQV2ELx+9ewk+F/cscoiBT1+3lhB4oiX+RC9i2
 Tocw==
X-Gm-Message-State: AOJu0Yz3GmwO6CLYVJ3jJycGw/FxmhLJ47DzuK59/5xEq3VgHkTF6mUq
 BD4cguuo1oLXaGyDgUErEIYvWHuwVRT+2T2+Eoa5Dh4G8dmoP8yEDmoFx4oQcC1IDqzM8BvnDvJ
 zBejcleo9bck3Z1hm7z/iMnZQMkHzACH2PaPOmsbMVdMf6svTK5N/iJsnGxRLCzCuBOOa8vxxZc
 8iQXwVXg6OIFv7UXgX9nklKg39EEA=
X-Gm-Gg: ASbGnctGrYBeqvKX1Z4DKYfFbDFqevaOiQtJ35sx9rTnrQt/gchdXzUrtvXUn3fhJki
 pesh40ZYfwLegwQjXaqkjRev8YZWC8lXqH9BOGjSGzswxWMAgPOXMKruw3ew4P/DF
X-Received: by 2002:a05:6000:1a8e:b0:385:fb34:d5a0 with SMTP id
 ffacd0b85a97d-38dc90f1b1emr5330669f8f.29.1739011033923; 
 Sat, 08 Feb 2025 02:37:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGh3Dlfh/BF9KKV4fvq5GJePKiywCtV+y6isrEEHuAHI/N8TArrVWaXJqsxbcMiYTvPHpek9VI21iGCx/zBR3I=
X-Received: by 2002:a05:6000:1a8e:b0:385:fb34:d5a0 with SMTP id
 ffacd0b85a97d-38dc90f1b1emr5330659f8f.29.1739011033584; Sat, 08 Feb 2025
 02:37:13 -0800 (PST)
MIME-Version: 1.0
References: <20250205122712.229151-1-ppandit@redhat.com>
 <20250205122712.229151-4-ppandit@redhat.com>
 <Z6VCxEKxn6-_okRx@x1.local>
 <CAE8KmOwJSYq2Ok38_sq29cr7JhbLLh1ZEncP13QpDdnYKOAheQ@mail.gmail.com>
 <Z6YqstgG2bSY45dM@x1.local>
In-Reply-To: <Z6YqstgG2bSY45dM@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Sat, 8 Feb 2025 16:06:56 +0530
X-Gm-Features: AWEUYZnbypiEa5C3LdKYpPDzaJ3ZuXYfh48WO5No9QnI5E16YQVKL2uGzcO_G44
Message-ID: <CAE8KmOwMTw-m0w+JbFBZ7mn-ZuSNfpk9xbq-_KbLXu7_kDhDVg@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] migration: enable multifd and postcopy together
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
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

Hello Peter,

On Fri, 7 Feb 2025 at 21:16, Peter Xu <peterx@redhat.com> wrote:
> This is not easy to follow neither with the current name, nor that you
> "assumed this is main channel" and test it.

* It is not my doing, nor is there any assumption, but that is how
current implementation works.
===
static bool migration_should_start_incoming(bool main_channel)
{
    /* Multifd doesn't start unless all channels are established */
    if (migrate_multifd()) {
        return migration_has_all_channels();
    }

    /* Preempt channel only starts when the main channel is created */
    if (migrate_postcopy_preempt()) {
        return main_channel;
    }

    /*
     * For all the rest types of migration, we should only reach here when
     * it's the main channel that's being created, and we should always
     * proceed with this channel.
     */
    assert(main_channel);
    return true;
}
===
* Above code returns 'true' for 'multifd' and 'main_channel' cases.
When migrate_postcopy_preempt() is true, main_channel is 'false', so
it returns false. All I have done is reused the
migration_should_start_incoming() function to simplify the 'if'
conditional at the top.

> I think you may want to split
> migration_has_all_channels() into migration_has_essential_channels() which
> only covers main and multifd cases.  Then you can check if (!has_esential)
> here.  You'd better also add a comment that all "essential channels" can be
> peeked.
>
> You may also want to bypass a few things, e.g. "postcopy paused stage" here
> rather than inside, because postcopy-recover only happens:
>
>   - First with a main channel, that is not peekable as no header when resume
>   - Then with preempt channel, that is also not peekable
>
> [a]
>
> You may also need to keep the mapped-ram check.  They also don't support
> peek.

* Instead of adding specific conditions and splitting functions, my
request is, let's work towards consistent channel behaviour that will
automatically simplify these conditions and channel handling. Maybe we
can do that in a subsequent series.

> >
> > > > +        } else if (mis->from_src_file
> > > > +            && (!strcmp(ioc->name, "migration-tls-incoming")
> > > > +                || !strcmp(ioc->name, "migration-file-incoming"))) {
> > > > +            channel = CH_MULTIFD;
> > >
> > > Confused here too.  Why do we need to check ioc name? Shouldn't multifd has
> > > the headers?
> >
> > * Because they are not 'multifd' channels, tls/file channels don't
> > send magic values, but are still handled by
>
> It might be because you have a bug where you removed mapped-ram check at
> [b] above.  I think we need to keep it.

* ie. Because I removed the mapped-ram check, so tls/file channels are
handled by multifd_recv_new_channel()? No, that's not the case.
Rather, that is how it works currently. I have not changed anything,
only made it more explicit to see that when it is tls/file channel,
handle it as a CH_MULTIFD type. Looking at the current code, one can
not see clearly how tls/file channels are handled.

> Why TLS channels don't send magic?

* Probably because they do TLS hand-shake while establishing a connection?

> > because if multifd page is getting late, that network
> > latency should affect 'postcopy' channel too, no? But still if it is
>
> I don't think so.  postcopy doesn't use any multifd channels.

* Yes, but it uses the same wire/network.

> > possible, do we want to call - multifd_ram_flush_and_sync() before
> > postcopy_start()? Will that help?  I'll check if/how it works.
>
> Note that all things flushed may or may not be enough, because IIUC the
> flush only makes sure all threads are synced.

* We are again using 'flush' and 'sync' interchangeably. What does -
flush only makes sure all threads are synced - mean really? Is it not
writing all socket data onto the wire/channel?

* Flush should write all socket data onto the network wire/channel.
The _order_ in which threads flush/write their socket data onto the
wire/channel is to synchronise them, maintaining/controlling that
_order_ is not flush.

> It may not make sure the order of things to happen in multifd threads and postcopy thread.  The
> latter is what we need - we need to make sure no page land in postcopy threads.

* Let's see:
   1) When migration is in Postcopy mode, ram_save_multifd_page() is
_not_ called on the source side. ie. no multifd data gets enqueued on
the multifd queue.
       1.1) multifd_queue_page() function also calls multifd_send() if
the queue is full, before enqueueing new pages.
   2) If a multifd page reaches the destination during Postcopy mode,
it must have been sent/written on the multifd channel before Postcopy
mode started, right?
   3) In this case, writing/flushing all multifd socket data onto the
wire/channel, before calling postcopy_start() function should help
IIUC.
       3.1) ie. calling multifd_send() before postcopy_start() should
help to clear the multifd queue, before Postcopy begins.
       3.2) Same can be done by - multifd_ram_flush_and_sync() ->
multifd_send() - sequence.

* If all multifd pages are sent/written/flushed onto the multifd
channels before postcopy_start() is called, then multifd pages should
not arrive at the destination after postcopy starts IIUC.  If that is
happening, we need a reproducer for such a case. Do we have such a
reproducer?

> That's why I was requesting to add an assert() in multifd recv thread to
> make sure we will never receive a page during postcopy.

* ie. Add  assert(!migrate_in_postcopy())  in multifd_recv_thread()
function?  Okay.


Thank you.
---
  - Prasad


