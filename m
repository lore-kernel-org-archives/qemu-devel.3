Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8532ACF45CF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 21:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfP8r-0001JM-2i; Mon, 12 Jan 2026 16:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vfP8o-0001GZ-UM
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 16:07:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vfP8l-0004Rw-Rx
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 16:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768252074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vpDvfWHeyU6NfGlmUTlQCTI1C3EXv6NmtHy+56F7Tio=;
 b=ivFtfhesrKaKsu3MarrOigyAS+WP14wDk3a1J2oPqHaQJ2gci06MUxwRwAZAmeKzLlfZ7t
 SigC2VMTusLtaeb/i8ORdKd639dVq3E0oTKIgdcsCSOHnEhtRVyxWtT0bP+R0bN2qXs6ZI
 spJki+/3Qkt8H5DiAJqmNLDJq8Magg0=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-nABm97i9M7SCuLbxSeCnZg-1; Mon, 12 Jan 2026 16:07:51 -0500
X-MC-Unique: nABm97i9M7SCuLbxSeCnZg-1
X-Mimecast-MFC-AGG-ID: nABm97i9M7SCuLbxSeCnZg_1768252071
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5635063cc48so4610422e0c.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 13:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768252071; x=1768856871; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vpDvfWHeyU6NfGlmUTlQCTI1C3EXv6NmtHy+56F7Tio=;
 b=P0ZExRX1IhGuiWFcb/Rr8Ba30LVxWHUPpblXlO++gju1AkiXlh+RHan9vPZtwKSrKQ
 uZa6cLO6qK1lIod4LQxsN52DxaPRg9egxL1gJH/nc/oEwlO8esDLxDI3u9fX0qFBnt48
 eoRNcVA8ABemIids71PC/vPiNc1KMDBZt8DIBuryu+AvJp9kLSH3s+fl+1cTqo4Lt61S
 QT5AW+7toxPHBGlwBdHrSzYCoOZWnmnFF8lW4T2Y2TGy8r0Xv2S7G2fF4mMiO9Gdor5d
 aaGFD+aukbV9nciwRHrii9upJ/QaRiC+qhecpO0jvjtU6hEbvecr2/d88pzbD2HlEu1C
 XbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768252071; x=1768856871;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vpDvfWHeyU6NfGlmUTlQCTI1C3EXv6NmtHy+56F7Tio=;
 b=kLNEtW1dEXpU+HTMMaM3ODoo21KuwD6lZU2xYjcbZ+aij7IIuJLkNrMK5gqURyx8NJ
 peYr5NO0zUUaaMILZZ4WCVp3jCiKJZZZ8aFC+Azfc03GgQd/z9vShg7DeoegWdOqJQVZ
 nNw/cCKDHEVuDBtBhPgQSATDpY47ejbwpCrg+JVE8SfdjtdUSKf2XDdrj9R/ZKeoO3fU
 Lg//5JoVP4QjGd1SSC1m30ZprZtWk7KmgptllzOG3N+25obzWhE6i39/EZbJ20LaH84N
 TLg0ikXdFOQ7lLJJnXmv/ZqLLmzLXqoc0o2P9hPRYL+rAhzkJzygUImT9aJhqMI3R94x
 WKQQ==
X-Gm-Message-State: AOJu0YzH5oQrbcnxhrFlKZKx+/a1jE82ccTqLrg0ELOx5UvoOdO15Pxv
 V+mETmFnt2jQ7OqYg4njDnVf8C1p5vDuHQbnaJhwB7MmxqmMI34EV27pAUN+bvzdXONqjoG8/eH
 JcTu4oIRz+7NQ+kGfSk5TOR7SiVDfM7WZI3q+kKwYMo3z6Kz0MinAhyQc
X-Gm-Gg: AY/fxX7liYsIYnfHhYCcTNVctFYf64I4e9+w4CtYz7R8tNYww38IzuUXKiunNsGGHG+
 wAtOCG3rQs2TjY3ShaluIQKay7UG4y8A0j72neCMNOtv/gkEoOWg2GgM/fcnvk/v/MLPrhModFo
 S4Uk/uiKfeCI4Sl+jSjjrutILNufDLMwc+XguybpozYHyTCKZDFhhNO6Ylx3nj6sFtW3Paz9/Tp
 uaqz3vQgucdP1XR1xOz0otZPoPKXqIROTdeIdf50EVtJnmUR8oYJXVKe/SyYC9fkRESA8oojRmV
 sc8bY+xpWOVUVkGmFMnraFYkuib/JqHVogY84J2LxmA11aNiSgTpQEgWfl0pUdGyhOfRaLFXAlO
 ia3o=
X-Received: by 2002:a05:6122:322b:b0:55f:c41f:e841 with SMTP id
 71dfb90a1353d-56347ff78a4mr8056860e0c.19.1768252070562; 
 Mon, 12 Jan 2026 13:07:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXdVEbMH4HEkZVsthNagF4Xgi6v1Pep8qLeRYOL3GgtqXMqglfp6trSpdLbiqzmZu4R1qLEw==
X-Received: by 2002:a05:6122:322b:b0:55f:c41f:e841 with SMTP id
 71dfb90a1353d-56347ff78a4mr8056839e0c.19.1768252070050; 
 Mon, 12 Jan 2026 13:07:50 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5633a20a183sm17858363e0c.9.2026.01.12.13.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 13:07:49 -0800 (PST)
Date: Mon, 12 Jan 2026 16:07:39 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 08/13] migration: Thread-ify precopy vmstate load process
Message-ID: <aWVim4LDYb4gMQLk@x1.local>
References: <20251022192612.2737648-1-peterx@redhat.com>
 <20251022192612.2737648-9-peterx@redhat.com>
 <87y0m7df46.fsf@suse.de> <aWUYVvFVbhXCdVod@x1.local>
 <871pju1wlv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871pju1wlv.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 12, 2026 at 04:04:12PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Jan 08, 2026 at 05:27:37PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > Migration module was there for 10+ years.  Initially, it was in most cases
> >> > based on coroutines.  As more features were added into the framework, like
> >> > postcopy, multifd, etc.. it became a mixture of threads and coroutines.
> >> >
> >> > I'm guessing coroutines just can't fix all issues that migration want to
> >> > resolve.
> >> >
> >> > After all these years, migration is now heavily based on a threaded model.
> >> >
> >> > Now there's still a major part of migration framework that is still not
> >> > thread-based, which is precopy load.  We do load in a separate thread in
> >> > postcopy since the 1st day postcopy was introduced, however that requires a
> >> > separate state transition from precopy loading all devices first, which
> >> > still happens in the main thread of a coroutine.
> >> >
> >> > This patch tries to move the migration incoming side to be run inside a
> >> > separate thread (mig/dst/main) just like the src (mig/src/main).  The
> >> > entrance to be migration_incoming_thread().
> >> >
> >> > Quite a few things are needed to make it fly..  One note here is we need to
> >> > change all these things in one patch to not break anything.  The other way
> >> > to do this is add code to make all paths (that this patch touched) be ready
> >> > for either coroutine or thread.  That may cause confusions in another way.
> >> > So reviewers, please take my sincere apology on the hardness of reviewing
> >> > this patch: it covers a few modules at the same time, and with some risky
> >> > changes.
> >> >
> >> > BQL Analysis
> >> > ============
> >> >
> >> > Firstly, when moving it over to the thread, it means the thread cannot take
> >> > BQL during the whole process of loading anymore, because otherwise it can
> >> > block main thread from using the BQL for all kinds of other concurrent
> >> > tasks (for example, processing QMP / HMP commands).
> >> >
> >> > Here the first question to ask is: what needs BQL during precopy load, and
> >> > what doesn't?
> >> >
> >> 
> >> I just noticed that the BQL held at process_incoming_migration_co is
> >> also responsible for stopping qmp_migrate_set_capabilities from being
> >> dispatched.
> >
> > I don't know if it is by design, or even if it will be guaranteed to work..
> >
> 
> Regardless, we shouldn't rely on the BQL for this. The BQL should be
> left as last resort for things that interact across subsystems. If
> someone is issuing a migration command during a migration, the migration
> code is exquisitely positioned to handle that itself.

Yes I agree.

> 
> > Consider the migration incoming rocoutine runs into qemu_get_byte(), and
> > then proactively yield the migration coroutine (qemu_coroutine_yield())
> > when the incoming port is blocked on read..
> >
> > AFAIU, a proper fix for that (note, this will currently break tests) is:
> >
> > bool migration_is_running(void)
> >  {
> > -    MigrationState *s = current_migration;
> > +    MigrationStatus state;
> >  
> > -    if (!s) {
> > -        return false;
> > +    if (runstate_check(RUN_STATE_INMIGRATE)) {
> > +        MigrationIncomingState *mis = migration_incoming_get_current();
> > +
> > +        if (!mis) {
> > +            return false;
> > +        }
> > +
> > +        state = mis->state;
> > +    } else {
> > +        MigrationState *s = migrate_get_current();
> > +
> > +        if (!s) {
> > +            return false;
> > +        }
> > +
> > +        state = s->state;
> >      }
> >  
> > -    switch (s->state) {
> > +    switch (state) {
> >      case MIGRATION_STATUS_ACTIVE:
> >      case MIGRATION_STATUS_POSTCOPY_DEVICE:
> >      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> >
> 
> LGTM
> 
> >> 
> >> Any point during incoming migration when BQL is unlocked we have a
> >> window where a capability could be changed. Same for parameters, for
> >> that matter.
> >> 
> >> To make matters worse, the -incoming cmdline will trigger
> >> qmp_migrate_incoming->...->migration_transport_compatible early on, but
> >> until the channels finally connect and process_incoming_migration_co
> >> starts it's possible to just change a capability in an incompatible way
> >> and the transport will never be validated again.
> >
> > Right.  Above should fix it, but I believe it also means after "-incoming
> > tcp:xxx" (or anything not "defer") we should forbid changing migration caps
> > or params on destination.
> >
> 
> Parameters are never forbidden, right? And we cannot forbid them with
> is_running because some parameters are allowed to be changed while
> running.

Right, my above statement was definitely inaccurate.

After merging caps and params we only have params.  We should only allow
some params to be changed anytime.  Most of the params (including caps)
should not allow changing during migration live on either src/dst.

> 
> I feel we should have a more fine grained way of saying "this option
> cannot be set at this moment", instead of just using the state as a
> proxy. States can change, while the fact that from a certain point on,
> certain options should not be touched anymore doesn't change.

IIUC that's what migration_is_running() about?

It's a matter of if such finer granularity is necessary for us. Let's
assume the simple scheme is:

  (a) Some params are allowed to be modified anytime, examples,
      downtime-limit, max-bandwidth, max-postcopy-bandwidth, etc.

  (b) All the rest params and all capabilities are not allowed to be modified
      when migration_is_running() returns true (my fixed version above)

The whitelisted (a) should really be the smallest set of params, and
justified one by one or it should fall into (b).

My hope is the simple scheme should work for us already.  After merging
caps, it's only about some params that can be set anytime, rest params can
only be set when migration is not running.

> 
> Maybe a little infra like bdrv_op_is_blocked, i.e, a list of blocked
> operations. It could be set in qmp_migrate and checked in
> qmp_set_parameters/caps.

Any example you can think of, that above simple scheme won't work for us?

> 
> > As discussed above, that'll at least break our qtests.  But frankly
> > speaking I think that's the right thing to do..  I hope libvirt always
> > works with "defer" and never update any caps/params after QMP
> > migrate_incoming.
> >
> > So I wonder if I should continue with above patch, and then fix our qtests.
> > Your work from the other "merge caps+params" might also work here,
> > actually, if we make sure everything will be set alone with the QMP
> > migrate_incoming single command.
> >
> 
> For incoming, yes. And this is maybe a point in favor of adding the
> 'config'.
> 
> For outgoing, there's still the point I mentioned above about how to
> restrict _some_ options to be allowed at runtime and others not.
> 
> > Let me know your initial thoughts, then I'll see what I can do..
> >
> 
> We should fix the bug, I think your patch is good for that.
> 
> Although this kind of overlaps with some things we've been discussing
> with Prasad. I'd be super happy if the code magically stopped using
> QAPI's MigrationStatus for internal tracking of migration state and
> blocking of commands and so on.
> 
> Whatever comes first =)

I didn't follow as closely on the discussion there.  I don't know if
changing MigrationStatus is a good idea..  we should have some really good
reason to make libvirt and all mgmt need a change.. but maybe I misread the
discussion.  I can wait until I read something solid if Prasad is going to
propose something.

> 
> ---
> Side note, did we ever discuss something like this?
> 
> struct MigrationState {
>    <state>
>    union {
>      <outgoing>
>      <incoming>
>    }
> }
> 
> there's so much stuff in these structs...

Yeah..  When merging state, we'll also need to be careful on overlapped
fields, e.g. expecting a COMPLETED state (from a completed incoming
migration) when starting a new outgoing migration.

We can likely leave this for later.

-- 
Peter Xu


