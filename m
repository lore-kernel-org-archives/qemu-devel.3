Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE00C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9TWK-0004ZK-GB; Wed, 23 Sep 2026 16:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x9TWE-0004Wn-4e
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:24:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x9TWB-000455-V4
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790195076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nP4wR9BCKnnhJDIRgOVmP8Y6gAbaA3Llad+MFqAIudI=;
 b=ISpmYKiCHFISMbTKWvYuQVVH+Ad89b25luga7myPlTr3Lwl844zW4CC34QK451UeGRmDj0
 wC+cTk4Yh7GsWtLAZSnaeqjedxnyzERY7fRq64hytm4FwJQEzdvAZFxbMO1UDbYx6WKpBs
 iqy0E7+Jr3QBkGh0+GH24hcJ9PkqQXk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-vuA34YlZNe-d9QE3rtXGQg-1; Wed, 23 Sep 2026 16:24:34 -0400
X-MC-Unique: vuA34YlZNe-d9QE3rtXGQg-1
X-Mimecast-MFC-AGG-ID: vuA34YlZNe-d9QE3rtXGQg_1790195074
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-936708f129aso206542685a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790195074; x=1790799874; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nP4wR9BCKnnhJDIRgOVmP8Y6gAbaA3Llad+MFqAIudI=;
 b=RT5dZLFUh/k0n+5pXbIU/GXc8ahgler1xF/LmuMH7wCHDy9UClmOkkP5ww/+4CFcvq
 LVQF1K/2kupeLhDUouRT/PXhJknamElpFzOtwOfY0901xClCzQEytrdbOvxHBpdtA7lU
 XsSLZagBjcFrMDOU3u43jOWSqgxRagtS4XvKhrvwTI4HNDAWKn49y1wcMy3l5tmQa6Q6
 m06BErRQ0bFkIL5pkhKLo0CKKt9PfDCw3ZZqsTURr7Lp/rkaCdWzlWDXW2/cinxXMqtY
 cKABl1K+FhhMRvucfqwP5tmTJ1dKgWsLEqHzkx689LmY194sxtqA5XTHf4u1ON3eyAvk
 MYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790195074; x=1790799874;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nP4wR9BCKnnhJDIRgOVmP8Y6gAbaA3Llad+MFqAIudI=;
 b=Qq45Bffe9dDwDmqHDMCKQWGrWpP4I28EyU7JxjcvMo5ADXRd6EQZbayKI/UtDwH17h
 Mr+Tb93fGzdzA9S7AVFPRht4ZN1v/gVohYOaYm+bf1cgTr3scmIhY9Gv2vdfzlBvTt89
 DjJ3P5fvxtNoEBF7IYQbNW9upVdE89PMPbxyuXrSX8zT8e9YwXW4iu8uWW0w+VCBDw/+
 enbBJTUFl8uQSyFKlehyVuKK8psyZeSJYOPnuK5Y3PD+JWMTU2FZQBysvnqGKbIpq/yd
 T6ykwodCKrHXJ2ECB2ZVqguW038c35G6P63ZW3e6Xc9MgOIq+zdaAYMSCS2Kv3NcAq7X
 xI8Q==
X-Gm-Message-State: AFuF++klBelCuupZSMwYTf5VAFpNanFJ6gaHKsIgTG9KTUitX+W2UwvL
 rBw9TpgeBqe+1NmXBedZu/VOjZJnp4Pyo6g6jZhU7ryD/+ICjhLX4RXL3aL1Oiu3r5pTar3rm5m
 XMWed7j145rgKI5FRe16yTmEI59sn58BJuIv8eDS+6+wkIUlCDEY1UztOONc8TsrlPyI=
X-Gm-Gg: AYBFou0BHUxq0vya4dbcj7U+W9GUOjbBT9JcZYUJR2YLDbNI4SB+z1uKO9zxvNaJAku
 zAWHKZbYCsE9TmB6vbZVIa0vNqx87ZfsNRYvnEsfYOr8TwZulWYKuBCz99VeJPO/es12YSCNYSz
 BtgMs12fn1Hsc5kQfQcdYJat0yUwBTm0Gtb9e4vNZKtBDVapM/jzcqT15nTk7SX8PE+dvgnKuX8
 TyLl8nupmH3xhQF2Cf6962aWjfIzDnZHgJbSELlySs1g6PCqqzNL0rf5FqCWrLhSicq5D0NaRP7
 DN/fWUY/7XWXeOstXepyddqgxoNDFMjqjq/nzv5qbBQmdLKj1VMqzi+h4wRNXrMZjJnaL+0=
X-Received: by 2002:a05:620a:440e:b0:93a:3f2a:557d with SMTP id
 af79cd13be357-93c346c87b5mr46146885a.17.1790195073773; 
 Wed, 23 Sep 2026 13:24:33 -0700 (PDT)
X-Received: by 2002:a05:620a:440e:b0:93a:3f2a:557d with SMTP id
 af79cd13be357-93c346c87b5mr46142285a.17.1790195073089; 
 Wed, 23 Sep 2026 13:24:33 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9141e2c3e47sm2290306d6.43.2026.09.23.13.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:24:32 -0700 (PDT)
Date: Wed, 23 Sep 2026 16:24:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Akash Kulhalli <akulhall@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 7/7] migration: Postpone the outgoing preempt channel for
 preempt_pre_7_2
Message-ID: <arQ1f6w_CKn1jUzg@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260916213558.587304-1-peterx@redhat.com>
 <20260916213558.587304-8-peterx@redhat.com>
 <87o6doami6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o6doami6.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Sep 22, 2026 at 08:34:41PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > This is the corresponding outgoing fix for the same problem mentioned in
> > the previous patch.
> >
> > The idea is simple: either migration to an old QEMU or when TLS is enabled,
> > we rely on correct ordering of channels to make it work: first main, then
> > multifd, finally preempt.
> >
> > This patch re-orders multifd and postcopy preempt channel on outgoing side,
> > but only for the old machine types where preempt_pre_7_2 set, to make it
> > follow the right orders to create the channels.
> >
> > Keep the resume path alone because the resume path never involve multifd
> > channels, even if multifd is enabled.  For that, fun fact: when multifd is
> > enabled with postcopy preempt, network interruption will break all multifd
> > channels, but they're never re-connected, until they got recycled at the
> > end of postcopy migration.
> 
> Is this a separate bug? Do we need to add some cleanup?

Not a bug?  The resume path only happens during postcopy phase, during
which multifd (even if enabled) is ignored.

> 
> > OTOH, multifd_recv_all_channels_created()
> > reports true even after postcopy network down, as multifd_recv_state->count
> > is never decremented.
> >
> 
> Seems normal to me. We're not even trying to reconnect multifd.

The clean way to do this is, whenever we recycled all the channels we reset
it.  Ideally they should have been recycled when switching to postcopy, but
that's non-issue, I agree.  It's just not that intuitive, IMHO.  But I can
definitely drop this paragraph if it caused confusions.

> 
> > Fixes: e27418861288 ("migration: enable multifd and postcopy together")
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.c | 32 +++++++++++++++++++++++---------
> >  1 file changed, 23 insertions(+), 9 deletions(-)
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 4cc4077a76..f8d664808f 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -3733,6 +3733,20 @@ static void *migration_thread(void *opaque)
> >          goto out;
> >      }
> >  
> > +    /*
> > +     * Only for old 7.1/7.2 machine types running on new binaries (that
> > +     * supports multifd+postcopy+preempt).  Makes sure to initiate the
> > +     * connect() after multifd channels because the old (broken) binaries
> > +     * assumes the order of channels, which we cannot fix anymore.
> > +     *
> > +     * multifd_send_setup() will make sure all multifd channels will be
> > +     * connected first, then initiate preempt channel here guarantees the
> > +     * ordering to those old binaries.
> > +     */
> 
> It's a bit confusing what's old binary, what's new binary here. Old/new

Yeah, I used "new binaries" to reference 10.1+ on the first line (while in
context of 7.1/7.2 machine types, they're "new"), but then used "old
(broken) binaries" on the 3rd line (while in context of after fixing
incoming side after previous patch, in which case not-fixed ones are
"old").

My bad, it's probably confusing whoever reads it.

I wrote a new comment:

    /*
     * Only for old 7.1/7.2 machine types (preempt mode supported since
     * 7.1).  Connect the preempt channel only after multifd channels,
     * because some QEMU versions (v10.1 to v11.1) will assume the order of
     * channels to be: (1) main, then (2) multifd channels, then (3)
     * preempt channel.  IOW, (3) must be after (2).
     *
     * multifd_send_setup() makes sure all multifd channels be connected
     * first, then initiate preempt channel here guarantees the ordering to
     * those QEMU binaries.
     */

> don't really apply I think as there are more than two cases when we look
> at the global picture. There's before 7.1, before 7.2, before the
> preempt_pre_7_2 flag, before the multifd+postcopy support, before this

Most things before multifd+postcopy work do not matter much, because as you
also mentioned these binaries can't enable both features, so it is not a
concern in term of channel misorders.

> series, etc. Specially since this code is exactly the same as the one
> under if (resume), but there we're talking about a different new/old.

Just to mention, we need that separate connection for resuming case below
in migration_start_outgoing(), because the resuming case doesn't start a
new migration_thread but reuse the old one.  It means that's the only place
we can reconnect the preempt channel in resume case.

> 
> Also, maybe we should avoid framing the assumption on the order of
> channels as "broken", that's how it always worked and is just a case of
> unimaginative assumptions, i.e. not knowing multifd would ever run along
> preempt. The real bug is that v10.1 added a "new" channel to the mix
> without working on compatibility.

Yes, I feel like we're on the same page.  I think it was used to how it
always worked before multifd+postcopy merged.  After it merged, it's not
how it worked, it should never worked, IIUC, hence "broken" after 10.1+.

> 
> In this series you're doing both: fixing the bug that v10.1 introduced
> and improving the code to not assume the order of channels.

Note that relying on order of channels are actually OK in 99.9% cases.. So
that's why I tend to make it a "fix", even if it smells like a feature.

Or say, I'll backport this whole series, when ready, to our zstream, as a
fix too.  This is the smallest change set I can come up with even if it
contains something looks like a feature..

> 
> > +    if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
> > +        postcopy_preempt_setup(s);
> > +    }
> 
> Don't you want to check for multifd as well and apply this fix only to
> the case that can actually trigger it? To avoid inadvertently changing
> the normal postcopy case.

It's my intention to move this for both cases when multifd is enabled or
not, because I think it's simpler and cleaner.

If I check multifd here, I'll need to move the migration_start_outgoing()
code below to check !multifd instead, it'll look like:

  migration_start_outgoing()
    ...
    if (resume || !multifd)
      connect_preempt();
    if (resume)
      ...

It looks uglier, so I chose this path forward.  It seems all safe.
    
> 
> > +
> >      bql_lock();
> >      qemu_savevm_state_header(s->to_dst_file);
> >      bql_unlock();
> > @@ -4013,16 +4027,16 @@ void migration_start_outgoing(MigrationState *s)
> >          open_return_path_on_source(s);
> >      }
> >  
> > -    /*
> > -     * This needs to be done before resuming a postcopy.  Note: for newer
> > -     * QEMUs we will delay the channel creation until postcopy_start(), to
> > -     * avoid disorder of channel creations.
> > -     */
> > -    if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
> > -        postcopy_preempt_setup(s);
> > -    }
> > -
> 
> Hm, this used to happen before qmp_migrate() returns. Now it's in the

I think qmp_migrate() should have returned already when creating preempt
channel, either on master or after applying this patch?

Only socket based URI can use preempt mode, so when reaching here (say, on
master branch), it should be part of socket_outgoing_migration(), async
operation of qio_channel_socket_connect_async().

> migration thread and after multifd channels connect, there's a big
> window there. We added a lot of code to ensure cleanup of multifd
> happens properly and without races with TLS thread creation, etc. Have
> you considered such issues?

Hmm, I'm not aware of the races with TLS thread issue.

/me asks for more hints..

> 
> >      if (resume) {
> > +        /*
> > +         * This needs to be done before resuming a postcopy.  Note: for newer
> > +         * QEMUs we will delay the channel creation until postcopy_start(), to
> > +         * avoid disorder of channel creations.
> > +         */
> > +        if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
> > +            postcopy_preempt_setup(s);
> > +        }
> > +
> >          /* Wakeup the main migration thread to do the recovery */
> >          migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP,
> >                            MIGRATION_STATUS_POSTCOPY_RECOVER);
> 

-- 
Peter Xu


