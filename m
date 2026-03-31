Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E90109B461
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 12:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7YXh-0005Vg-HP; Tue, 31 Mar 2026 08:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1w7YXg-0005VN-EZ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 08:50:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1w7YXe-0008PN-Cc
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 08:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774961397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6tnDgxrLTKmrEKiyz0J4KSv5I08JtjTZCxXS+SLijXM=;
 b=MT8isUObXj3HsoizxL3m4xeEyoovJarTXCwvMMsrbM6f5/l6p1EO9C0aUTvVxJXkT2O8Rw
 FC4JabvQ5yQSinGD2o/nNkftdXPemI7tmI7csNL0ooc/5SidXQbJjrMWHXsh/VGY2kdQy2
 pWtBdspXzJCO6WgovqvPcFDjf9OR6W4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-BG6kzgbDMqm-Ty3t5aV_rQ-1; Tue, 31 Mar 2026 08:49:54 -0400
X-MC-Unique: BG6kzgbDMqm-Ty3t5aV_rQ-1
X-Mimecast-MFC-AGG-ID: BG6kzgbDMqm-Ty3t5aV_rQ_1774961393
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836abfc742so49040105e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 05:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774961393; x=1775566193; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6tnDgxrLTKmrEKiyz0J4KSv5I08JtjTZCxXS+SLijXM=;
 b=VyeHqT5qQ7vAXlKF8cUgaCYhjqHuRDxlL2mezM0WqVGvW4iBPiuT7Gw+kVdVRCEplC
 tfhSJKZShAvMARIxw7oy/TuhFvCHVMGCgoqeX4DcKw8MwDoAJKjDGWWKWWIz69PcmMDf
 PS4EreiPts0dfUS6nUxFMkRW+tY27U6T7aisuMJybDRboeN1MH8mH1xp6CO3jgxwhdx/
 Mr3z12N8FkvUJxDNz6LqQaCiLScQDV+V86HZKrUsrJ0DTR1bunUx3njhhpRvFhSaNdLp
 4j/046rRCbVfmEEpybBUjfyIqXLAjtlgNB9XAHCPnh7WpxkiHzP/Ntbh3CakloAx8ryF
 eqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774961393; x=1775566193;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6tnDgxrLTKmrEKiyz0J4KSv5I08JtjTZCxXS+SLijXM=;
 b=gEBq9bgBuOqEPt7hze54tXQmD0/NKeJkwFZRTXPAC75M3ledMwlNA6oB65zkSPxyQd
 A7q5j4R07AmjYKUZj5s2J0RoiW30D82wSyH6WCNqC2W6g298yaKict/bkDLxDoSURT+R
 ka+U3/eFk8cyrgAmL7vy2o11g4Exg2C6NkaDQiO3c2EcJdLrhwGcTROELHYErCmfQyUY
 v3Vc0tut6/nc0ZFjgamMmuKpRVcBgadgbS38Bh3Pr7pR1vDdWmcckqnKn8rOQGWEOQSt
 x5qPn15dh8NqdU9ltzyn21jsUPsZgOECY+pOpwslay1m5ZxP3ZqTmfuykFjmpNDIY5ce
 MjyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj4+xCyHwcPs9X1mH37KgAYki+AiLjNgE2XbVucNHkzzbG1GKs7cXk4TRdhubIghQQTn+2ybkjbobe@nongnu.org
X-Gm-Message-State: AOJu0Yx9IDyCQQHkcjKH7s2y71roq7n1FWtY3JoKHPoQkTO0eyoQwV2H
 eo0zYB7ce1xR0t2dIfpQRtjMAkxSRMsAKK6TXZm8QNgG3Gar7+bLHBILD7hEQuozU0ugFrKW2vS
 ofuxuJ7LpLri7aFHVV9aZPWNCLauh6upl48VdyVAdPfRmqD/Vc4W+AByj
X-Gm-Gg: ATEYQzzuoPZRvirJ2S1eDXp3J5h1gWFBdyDDvXEVgnyc9Li1mrwO26SHuZqex6pa11K
 ksznhleoj1ethOuB1nzheOElIxznxSj5AJ2S8gFkTYPhqfx4P4xW2Ej+ntpcM3rt9aoEYpYfrsP
 uaP/sCBClioYBoOy8/2y78210feHm9h1rWhaaWsJ3Cw/PUctcXHVrJx9hY2j1388Uh14E0oOiU1
 muOlZ6nCProoDKXnxCYCN8L7bEBRm5JCknvM2Gag9Vp7Ge0dXZibtblwtNchytfWGk2qzkzwiRG
 9aD7EyTARpETs+sbj0+vbctUva3Mw7X0YY0V+4sjMd9Fpm/jeRUFfp5Vt/593B8FFUGj0noyC3F
 FgdW7YAvlK7i2
X-Received: by 2002:a05:600c:3b04:b0:485:3586:1e28 with SMTP id
 5b1f17b1804b1-48727edde7emr275188995e9.18.1774961392652; 
 Tue, 31 Mar 2026 05:49:52 -0700 (PDT)
X-Received: by 2002:a05:600c:3b04:b0:485:3586:1e28 with SMTP id
 5b1f17b1804b1-48727edde7emr275188595e9.18.1774961392091; 
 Tue, 31 Mar 2026 05:49:52 -0700 (PDT)
Received: from fedora ([193.179.61.20]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e9630ddsm32425965e9.13.2026.03.31.05.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 05:49:51 -0700 (PDT)
Date: Tue, 31 Mar 2026 14:49:48 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, 
 Alex Williamson <alex@shazbot.org>, Yishai Hadas <yishaih@nvidia.com>, 
 Fabiano Rosas <farosas@suse.de>, Pranav Tyagi <prtyagi@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH RFC 01/12] migration: Fix low possibility downtime
 violation
Message-ID: <acuQc3dVq5vfh3cl@fedora>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-2-peterx@redhat.com>
 <CAE8KmOyTq4wib3niowjXNfqh4TjwhcEDqUt99=mvuLs5vsSx9A@mail.gmail.com>
 <acaNfFWvNAEpFsFD@fedora>
 <CAE8KmOwwFmrNgb8MWO7yprPmtautrbrWzF5FYdJ4ODboQxhwUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE8KmOwwFmrNgb8MWO7yprPmtautrbrWzF5FYdJ4ODboQxhwUw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Prasad,

On 2026-03-30 17:22, Prasad Pandit wrote:
> Hello Juraj,
> 
> On Fri, 27 Mar 2026 at 20:05, Juraj Marcin <jmarcin@redhat.com> wrote:
> > > * What is the 'size' difference between < s->threshold_size  Vs  <=
> > > s->threshold_size?  Going through the source IIUC
> > > 1) 'pending_size' is measured in Bytes.
> > >      static void ram_state_pending_exact/_estimate()
> > >          remaining_size = rs->migration_dirty_pages *
> > > TARGET_PAGE_SIZE(=4096 bytes);
> > >          100 dirty pages * 4096bytes  => 409600 dirty bytes => 409600
> > > * 8 => 3,276,800 dirty bits
> > >
> > > 2) 's->threshold_size' is derived from bandwidth (100M bits/s) and
> > > downtime(=300 ms)
> > >         100,000,000 bits/s => 100,000 bits/ms
> > >         100,000 bits/ms * 300ms => 30,000,000 bits in 300 ms
> > >         30,000,000 bits / 8  =>  3,750,000 Bytes / 300 ms
> > >         s->threshold_size = 30,000,000 bits (= 3.75MBytes) can be
> > > transferred in 300ms downtime.
> > >
> > > * Are we comparing pending_size(=409600 bytes)  <=
> > > s->threshold_size(=30,000,000 bits)?
> >
> > While threshold_size is indeed derived from bandwidth, bandwidth is in
> > bytes:
> >
> >     current_bytes = migration_transferred_bytes();
> >     transferred = current_bytes - s->iteration_initial_bytes;
> >     time_spent = current_time - s->iteration_start_time;
> >     bandwidth = (double)transferred / time_spent;
> >
> > Conversion to bits only happens for the mbps statistic:
> >
> >     s->mbps = (((double) transferred * 8.0) /
> >                ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;
> >
> > >
> > > *  static void migration_update_counters()
> > >         transferred = current_bytes - s->iteration_initial_bytes;
> > >         bandwidth = (double)transferred / time_spent
> > >         if (switchover_bw) {
> > >             expected_bw_per_ms = (double)switchover_bw / 1000;
> > >         } else {
> > >             expected_bw_per_ms = bandwidth;
> > >         }
> > > => ^^^^^^^  Should we divide 'bandwidth' by 1000 here (for bw_per_ms) ?
> >
> > switchover_bw is expected to be in bytes/sec, however, time_spent is
> > already in msec, thus bandwidth is also bytes/msec, the existing code is
> > correct.
> 
> * I see, this is not readily clear though. This needs good
> improvement. Maybe we should add an explanation in comments OR include
> an example calculation OR define helper function(s) to convert
> bandwidth from Mb/s <-> Mb/ms and MBps <-> Mbps etc.
> 
> >     s->mbps = (((double) transferred * 8.0) /
> >                ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;
> 
> * If time_spent is in msec, continuing the above 100 mbps example, we
> got to 3,750,000 Bytes / 300 ms above. Now to get mbps
> 
>      s->mbps = (3,750,000 * 8.0)  / 300 (time_spent) bits/ms  =>
> 30,000,000 bits / 300ms
>      s->mbps = 30,000,000 bits * 1000ms (=1sec) / 300ms  =>  100,000,000 mbps.
> 
> *  (time_spent / 1000.0) / 1000.0 / 1000.0  is not very apparent.
> 
> > @Peter, not sure if it is necessary, but it could be usefull to mention
> > in MigrationParameters docs, that avail-switchover-bandwidth is in
> > bytes, not bits?
> 
> * I request that we use 'Mbps' notation for bandwidth at every user
> interface, be it --bandwidth <option> OR a definition in a
> configuration file OR documentation. Users should always specify and
> read bandwidth in 'Mbps'. Because that is the notation used
> everywhere. Asking users to specify 100,000,000 bps / 8 => 12,500,000
> Bytes/s  instead of 100Mbps does not seem right, is not user friendly.

QAPI schema defines the type of 'avail-switchover-bandwidth' and other
'*-bandwidth' properties as size, which allows users to use size suffix,
for example '100M'. QAPI parser then parses this value to
100 * 1000 * 1000 bytes.

Changing from bytes to bits is API breaking change, I don't think it is
justified.

> 
> > >
> > >       s->threshold_size = expected_bw_per_ms * migrate_downtime_limit();
> > >
> > > migration_iteration_run():
> > >    /* Should we switch to postcopy now? */
> > >    if (must_precopy <= s->threshold_size &&
> > >       can_switchover && qatomic_read(&s->start_postcopy)) {
> > >       if (postcopy_start(s, &local_err)) {
> > >           migrate_error_propagate(s, error_copy(local_err));
> > >           error_report_err(local_err);
> > >       }
> > >       return MIG_ITERATE_SKIP;
> > >    }
> > > * Here we should check pending_size <= s->threshold_size,  because
> > > must_precopy is zero(0) when postcopy is enabled. And we switch to
> > > postcopy mode even when pending_size > s->threshold_size.
> > >   I wonder if we really need both 'must_precopy' and 'can_postcopy'
> > > variables, they seem to complicate things.
> >
> > With devices that implement pending method, don't support postcopy, and
> > are not yet migrated, must_precopy would not be zero.
> 
> * If must_precopy is not zero(0), then pending_data would not be <
> threshold_size either, right? What is must_precopy data? IIUC, all
> device state is 'must_precopy' data, because we don't send Postcopy
> requests for device state data. And can_postcopy data is only RAM
> pages.
> 
> > Both, must_precopy and can_postcopy are required, that is what allows
> > postcopy to switchover early. pending_size is the overall total that
> > includes also postcopiable data, hence why it is only used to trigger
> > precopy completion.
> >
> > However, the majority of devices don't implement pending methods (yet)
> > and thus are not counted towards the estimate even if they don't support
> > postcopy and affect the downtime.
> >
> > Wondering if VMSD devices could implement some pending estimates based
> > on their defined fields, this would also improve not violating the
> > downtime requirements.
> 
> * Using 'pending_size <= threshold_size'  in one place and using
> 'must_precopy <= threshold_size' in another place is confusing and
> inconsistent.
> 
> * What is threshold_size really? Number of bits/bytes we _can_
> transfer within the given downtime, right? if downtime is 300ms, at
> 100 mbps, threshold_size is 30Mb (ie. 10Mb/100ms). For 500ms,
> threshold_size is 50Mb.

Yes, that is right.

> 
> * Then it is easy to understand that when pending_size is <=
> threshold_size, then we can easily pause the source VM and switch to
> Postcopy, becasue those pending_size bits/bytes can be transferred in
> the given downtime. And if pending_size is more, then we _can not_
> pause the source VM, because we can not transfer more pending data
> within the given downtime value.

Devices report two pending values, 'must_precopy' and 'can_postcopy'.
'must_precopy' is number of bytes that must be migrated in precopy (or
switchover) and cannot be postcopied. 'can_postcopy' is number of bytes
that can be migrated either in precopy or postcopy, those can be RAM
pages (with postcopy-ram enabled) or dirty bitmaps or any device that
would support postcopy.

If switching to postcopy is allowed, we only need to be able to transfer
'must_precopy' bytes in switchover. Rest of the pending data can be
migrated in postcopy ('can_postcopy' bytes). Thus, we only compare
'must_precopy' when deciding whether to switch to postcopy.

However, if postcopy isn't allowed, and we are deciding whether to stop
the source machine and complete the migration, we need to migrate
everything in switchover, including the data that could be postcopied.
Thus, we need to compare 'pending_size = must_precopy + can_postcopy' to
decide if we can complete the migration in the specified downtime.

> 
> 
> Thank you.
> ---
>   - Prasad
> 


