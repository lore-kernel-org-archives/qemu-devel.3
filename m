Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478B7C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 11:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkiic-0003jP-Gy; Wed, 19 Feb 2025 06:58:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tkiib-0003j0-HL
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 06:58:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tkiiZ-0004oM-FR
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 06:58:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739966296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R3hn6cdDIp2AL64lthtby9qJtYZIRiLL+dqEaBXvYeY=;
 b=gIuY1thESFvQjZTKPuVvqMJaWREZHttsids0gD4KdUK4pgyzVKvajZRnfsV9EHStrXcH/D
 HipDuziXtuDv9qJHRNjdESLynQLDeY8+3pdyJ7gwBJkSITybMLh3oQiiww58fIkFG5HpWD
 c59GMStcYkuw22E/pgVjNMIyYG5jmiA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-Pw7FxYpyOeSe3pBCtr9oKA-1; Wed, 19 Feb 2025 06:58:13 -0500
X-MC-Unique: Pw7FxYpyOeSe3pBCtr9oKA-1
X-Mimecast-MFC-AGG-ID: Pw7FxYpyOeSe3pBCtr9oKA_1739966293
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43943bd1409so53261505e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 03:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739966293; x=1740571093;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R3hn6cdDIp2AL64lthtby9qJtYZIRiLL+dqEaBXvYeY=;
 b=g67BkboaBYOYiexLPOPw1KvxyPpNDgsb/1UzZv7PEceNo48V89atLV4gy27e53ZA6S
 jw8r3GIjz0HEjhhsz/Sbrr9hTM2/DK1hKRkyU3Tz/c5UKAaduGrnkuQlxgee7V8dxA7x
 wxEptIcUrGp9gTaPkdaLHej7YPn8GtfiZCPXF1teoETfLiYO8GSDfvI4Z/5ADSbcBvV1
 onDBPyXUcga/Vs4/tSXe7tr2CK5IG5yI1Q94E57Q1rqJ5uyfg7X7FQSx5dx+wo3YEOHA
 lkveK95izK6pcUTD4rzC7hmPcVfuDFfjcCbV+GwInTFOpc1hZ7/2qL20CKo0sgi+cfXj
 /kLw==
X-Gm-Message-State: AOJu0YzPTbIgrwion4e4OdjYW5Z93jL777sCfw8pKQz0vBElKn0AJKGP
 P0+Z9EO+5/w0wspsdXVZP/BbMWXC6+2LrXxnrwsTTly6CWu8CWXsikH1hoR+tPVeXv/JQN1laGN
 UzvpkgAW/9SECKeHdYAicfTVESeXe0Z6tTzlIaLRrDtqICQ7BI/7CnGNsvuBOZ7GfoPXM3qFzKD
 u68yfC5LwOoMH53qSxrEhNYxYAI7M=
X-Gm-Gg: ASbGncvWzqOSv61BMg5MQRvnXai8/ZgwiyQ5E3BMEKoqKAAwxWoC8Aez4z0nO89fOWG
 qSKvZ1ZWDY7TatrvbjO4gMykdurg6X7GTmdv5tpjoHSr7Et+SWdd6Qadx5dlQh1+t
X-Received: by 2002:a05:600c:4f95:b0:439:84f8:60d7 with SMTP id
 5b1f17b1804b1-43999d8b7b9mr34685595e9.10.1739966292579; 
 Wed, 19 Feb 2025 03:58:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYmdNV7Nmlt9DvvGLbIGfufKWXSb4y/TJbHPY8nKZ3bCOsk7n2qp8u+Ked+bIxaWvet4HenvsmGdPKpEK2xHA=
X-Received: by 2002:a05:600c:4f95:b0:439:84f8:60d7 with SMTP id
 5b1f17b1804b1-43999d8b7b9mr34685325e9.10.1739966292181; Wed, 19 Feb 2025
 03:58:12 -0800 (PST)
MIME-Version: 1.0
References: <20250215123119.814345-1-ppandit@redhat.com>
 <20250215123119.814345-3-ppandit@redhat.com>
 <87y0y4tf5q.fsf@suse.de>
 <CAE8KmOxYE=10+xjMjH5ZhbMmRJHgxJKHj2wH-nB-qiBSHEVh1w@mail.gmail.com>
 <878qq39vu3.fsf@suse.de>
In-Reply-To: <878qq39vu3.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 19 Feb 2025 17:27:54 +0530
X-Gm-Features: AWEUYZlHqgscSASfJieGRiK1fJKJOdnRijM5Elr-iz-qZWk-8ItUUuaEYi_to5g
Message-ID: <CAE8KmOyy=ybDaRFpFr0DTJWScyjCX+99PKHzLibv6zhtUpw8Ng@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] migration: enable multifd and postcopy together
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello Fabiano,

On Tue, 18 Feb 2025 at 19:52, Fabiano Rosas <farosas@suse.de> wrote:
> Do you concede that this code has a hidden assumption? Either that
> migrate_multifd() != migrate_postcopy_preempt() or that multifd channels
> must be set up before postcopy preempt channel? Because that is enough
> for us to have to do something about it. Either restructuring or a
> comment explaining.

* Not a hidden assumption, but it is an observation that 'main' and
'multifd' channels are established before 'postcopy' ones. And for new
migration to start, it is necessary that 'main' and 'multifd' channels
(when enabled) are established before migration starts.

> > * When does postcopy preempt channel creation race with the multifd
> > channel creation?
>
> For instance, postcopy_do_resume() has this comment:
>     /*
>      * If preempt is enabled, re-establish the preempt channel.  Note that
>      * we do it after resume prepare to make sure the main channel will be
>      * created before the preempt channel.  E.g. with weak network, the
>      * dest QEMU may get messed up with the preempt and main channels on
>      * the order of connection setup.  This guarantees the correct order.
>      */
> It looks like if the main channel can race, so do the multifd channels,
> no? In any case, I'm fine with just documenting any assumption for now.

* The first requirement for this race to occur is that two types of
channels are created together at the same time. Let's see:

   * Postcopy migration:  without multifd enabled
      - 'main' channel is created before the migration starts. And
'postcopy' channels are created towards the end of precopy migration,
when the Postcopy phase starts. So in this scenario the race does not
happen.

   * Postcopy resume: without multifd enabled
      - As described in the comment above, preempt channel is created
_after_ the 'main' channel to avoid the race condition.

   * Postcopy migration: with multifd enabled
      - 'main' and 'multifd' channels are created before migration
starts. And 'postcopy' channels are created towards the end of precopy
migration, when the Postcopy phase starts. No race occurs.

   * Postcopy resume: with multifd enabled
      - 'multifd' channels are shutdown before Postcopy starts, ie. no
'multifd' channels exist during Postcopy resume. So no race between
'postcopy' and 'multifd' channels.
      - And 'postcopy' channels are created after the 'main' channel
to avoid the race between them.
      - postcopy_do_resume() does not seem to create 'multifd' channels.

   * Multifd migration: without Postcopy enabled
      - 'main' and 'multifd' channels are created before the migration
starts. They both send 'magic value' bytes, so are easier to
differentiate. No race occurs.


> > * migration_needs_multiple_sockets() => return migrate_multifd() ||
> > migrate_postcopy_preempt();
> >
> Nope, this is just saying whether a single channel is expected, or more
> than one.

* If we read it as a question:
    - migration_needs_multiple_sockets() ? True => Yes, migration
needs multiple sockets.
    - migration_needs_multiple_sockets() ? False => No, migration does
not need multiple sockets.

Then it should return 'True' when both migrate_multifd() and
postcopy_preempt() are enabled.

>That's why I think it would be a good gate for this peeking
> code. Since postcopy preempt could be a peekable channel, it's
> misleading to put it all behind QIO_CHANNEL_FEATURE_READ_MSG_PEEK
> only. This is a time-bomb for the next person to refactor this code.

* Postcopy preempt could be a peekable channel ? Currently it does not
send magic value, does it?

> Right, but that's not what we have today. Changing this requires
> figuring out how to keep the stream compatible when channels now start
> sending extra stuff at the start. It's not trivial. There's also
> mapped-ram which is asynchronous and there might be something special to
> be done about the TLS handshake, I'm not sure.

* True, it's not trivial.

> Well, aside from preempt, they're *not* dependent on the order. That's
> the point of having to do all of this dance. In fact we might be better
> off if we could serialize the connections somehow.
>
> I havent't followed this series closely, could you point me to the
> discussion that led to the channels concept being introduced?

* Channels concept was not introduced in this series. It has been
there since the beginning, no?

> Yes. They *can* be used without multifd. The comment would explain that
> at that point in the code, these are the only types possible. So as to
> not mislead future readers that whenever tls/file, then multifd must be
> used.
....
> See? Multifd mutually exclusive with postcopy preempt. You carried that
> assumption (well done), but made it more subtle (not good), since
> if/else is by definition showing the relationship between the two while
> migration_has_main_and_multifd_channels() makes it hidden under the
> multifd check allowing the last return true to happen.
>
> If we're enabling multifd along with postcopy, we need to be aware that
> the relationship with preempt might not hold true anymore.

* Sorry, I did not get that. Enabling them together means that they
are _not_ exclusive, no? It is not Either 'multifd'  OR 'postcopy'
case, anymore.

>>Not sure if/how that works really. It is possible that currently
>> these (tls/file) channels are used only with migrate_multifd() enabled
>> and so are processed with multifd_recv_new_channel() function. The
>> current patch handles them the same way.
>
> That's the entire point I'm making when I ask to not omit the else
> clauses.

* ie. we set 'channel = CH_MAIN' in the final else clause as well? - Okay.

> Do you think this series can work without touching the channel discovery
> code? As I said earlier, I'm missing a bit of context, but to me it
> seems it cannot.

* The reason we need to touch the channel discovery part is: with
'multifd' and 'postcopy' both enabled, towards the end of migration,
when 'postcopy' connection comes in
     migration_ioc_process_incoming(...)
    {
        if (migrate_multifd() && !migrate_mapped_ram() &&
!migrate_postcopy_ram() &&
             qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
             ...
         } else {
             default_channel = !mis->from_src_file;
         }
        ...
        if (migrate_multifd()) {
            multifd_recv_new_channel(ioc, &local_err);
        } else {
           postcopy_preempt_new_channel(mis, f);
        }
    }

* The first 'if (migrate_multifd() ... !migrate_postcopy_ram()')
evaluates to false, in the else part 'default_channel' also evaluates
to false, because the 'main' channel is established. Now the new
incoming connection falls in the second migrate_multifd() block and
gets processed via - multifd_recv_new_channel(ioc, &local_err); call
and migration would not complete/finish.

* To identify the incoming postcopy connection, in the very first
version of this series, a magic value for the postcopy channel was
introduced and everything else remained the same.

* Would that be an acceptable solution for now?

> If instead of this refactoring you want to start working on a model for
> consistent channel advertisement, then that's fine. But we'll have to
> put this series on hold (which is also fine). It also looks like it
> could be considerably more work, although I haven't looked at it in
> detail. Granted, it's work that makes sense, instead of the heuristics
> we have today.

* IMHO, we need not put this series on hold, for now we could go ahead
with the postcopy magic value patch if that works. And the larger
overhaul of the channel discovery part could be done as a separate
series of its own.

Thank you.
---
  - Prasad


