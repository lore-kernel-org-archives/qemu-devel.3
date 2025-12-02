Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BCCD12669
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 19:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQVrC-0005na-W9; Tue, 02 Dec 2025 14:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQVrB-0005n5-A7
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 14:16:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQVr7-0002AG-G3
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 14:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764702966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H+ZuuVuL8zVw4CW42ao0rKTjPxH/lHTvdE8ytSQ7LgE=;
 b=YxHW7BYF/1mtVoawpisXo0XFKReyw5oiRmacZQPUa09WRzA6h5iLP/aXz8txfnMNASb7Zl
 GuazrncG1Ym35Tnp2Be535UjceNbSAJHgmrJeAbCQmNyy4Kh7xle3c+L/KCSF/ha52PEZo
 0jOqj4b4nP9+6UJKeGq+HCcPj7VOpac=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-COYcfQGAMLCcL87tAiKTbQ-1; Tue, 02 Dec 2025 14:16:05 -0500
X-MC-Unique: COYcfQGAMLCcL87tAiKTbQ-1
X-Mimecast-MFC-AGG-ID: COYcfQGAMLCcL87tAiKTbQ_1764702965
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8804b991976so124323216d6.2
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 11:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764702964; x=1765307764; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H+ZuuVuL8zVw4CW42ao0rKTjPxH/lHTvdE8ytSQ7LgE=;
 b=DVRnRhy1dU7pB0tr29OR1yffuY/NnZ0HpnIagdHlcFp5QYcfBCDgyETuNgWijNl9UQ
 x7pfFjcIGJUWNvNN6ldyqq2WpKoByhgvgyMzOxDHn/mFVlGs/O61JMiwU76TOW88UzBP
 GJ2zdbToR+NrTQAWlruMlJ24i3IVmiebFDzLAEspNmtWPgtyWReF2nM58VhEBABpZ2on
 n7NkBXKCVPNkAEaE0extzEFQAzclX5CKmKck+ClUvf4in48PbbtHpZ4sP5ffgZeUZESz
 U9JOydF7PBoU9+rH6sIBtRIBjUaJ7FSo2bUUKzv8MEng7h4/oGaRFyMw5BoQBoIm90pa
 yRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764702964; x=1765307764;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H+ZuuVuL8zVw4CW42ao0rKTjPxH/lHTvdE8ytSQ7LgE=;
 b=ukDKMF6k7eYHA1aY9EiFCyZR6veeqfcnsGS82ILWkWjz6Cp/a8R4Y0ezRCdyIFus+e
 mcLM/9dSbtQSz2azXnVQ9v1Xa0r4mK6KJQhukGVd0vZFm2zdYYY8DJqzle8R3JxLEatJ
 CzfEg4qdf9bnD1/NJt7JhC5X0Rgcxnua4bxostr4uhV8srBhoE2rMzftc0p5ftgjcgag
 pD5iES0gmvhRsb87a+rjgKlECb0LIwp+QnZtFct8yopDRrTUi0FDbmPWGH9rn+DVjoZ3
 Ewzcebb4Nmld3V25KE2g5vfKUny9g/geOPyoRkPWASyZ/bOvmeg7+GmF3r9CijOU70/f
 momA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVseXJIwQyZlIeigj/o2xkcr1ogxXfiy+00l1Et88y+cpXW9djGpUWaTafqHpOlsu5o2vrziLTumFW@nongnu.org
X-Gm-Message-State: AOJu0YyqMUn8GWdQE7mmhdpBoPKqV/H2I6+CqilZ9bamJdUfLeM0Ia3f
 FtIJSV0qOlEoMYCrMUwmjknyGPmln1RtLa3QCEvKFg1tYS1AQ2HsVO9kvot9WOCv4yNsrs11drZ
 9AMIL0H5xyIhyvGW3vu/gnZngLbYMJhPSzHoDVlOswwT/exGsW0gaRPWy
X-Gm-Gg: ASbGncvrH69mhYgmBcJqUq1H4PyHbYGsKoH+x1CpydNSwuJjg6Z4U7a5BmTGFZymAix
 x2zQxM3NycsqRcQYzIqgla5Bjj4T+FB+wdUxXPv2ZeJNrSi498/8ZY3uKtGrjXCCoxwdSIKUwhd
 N7Fhuj55fYuSUMk7e2Iqw9Zydu+qig2kXq2iW6Dx+62GW5VpHIAYpi7oKZAqYlH1IOJgoRU+0XC
 lNX6BfCKxoi5keQi5IFdc0yBdHdZJV0XqH/dTLIKV9p5mNIF96aMRt1NFF1mb0xjbmWNHP7SLhF
 AYUGWvoForYgaI89FxHO0dCB37/f/3dbmgsmpiTqF/En5lpKbccZM4EQEKfkM0eRKQ804F2DnRp
 /NBY=
X-Received: by 2002:a05:6214:1d09:b0:77a:29ba:1b67 with SMTP id
 6a1803df08f44-8847c497a98mr655195566d6.13.1764702964470; 
 Tue, 02 Dec 2025 11:16:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFs0kJsD6jTYBjIxYB7LM5H2R5sXgakRGmwUawybMl3kc0D79F61c28DaSKlIehOmiFbjWd0A==
X-Received: by 2002:a05:6214:1d09:b0:77a:29ba:1b67 with SMTP id
 6a1803df08f44-8847c497a98mr655194806d6.13.1764702963758; 
 Tue, 02 Dec 2025 11:16:03 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88652b6d7d5sm109830756d6.49.2025.12.02.11.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 11:16:03 -0800 (PST)
Date: Tue, 2 Dec 2025 14:16:02 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, farosas@suse.de,
 John Snow <jsnow@redhat.com>
Subject: Re: Migration and the Job abstraction
Message-ID: <aS868g7nzTCF30K1@x1.local>
References: <20251115083500.2753895-1-armbru@redhat.com>
 <aRtHWbWcTh3OF2wY@x1.local> <87a50jlr8f.fsf@pond.sub.org>
 <aRyuZbS7iALvx-BT@x1.local> <87cy5ecvoc.fsf@pond.sub.org>
 <aR4vdRcORY4em3yB@x1.local> <878qg1uhbd.fsf_-_@pond.sub.org>
 <aR8GsDYMwWDT4oeN@redhat.com> <aSTgphDaC1nFMRcW@x1.local>
 <87cy4xt45s.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cy4xt45s.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Dec 02, 2025 at 02:16:31PM +0100, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Nov 20, 2025 at 01:16:48PM +0100, Kevin Wolf wrote:
> >> Am 20.11.2025 um 11:30 hat Markus Armbruster geschrieben:
> >> > Peter Xu <peterx@redhat.com> writes:
> >> > > On Wed, Nov 19, 2025 at 08:45:39AM +0100, Markus Armbruster wrote:
> >> > >> [*] If the job abstraction had been available in time, migration would
> >> > >> totally be a job.  There's no *design* reason for it being not a job.
> >> > >> Plenty of implementation and backward compatibility reasons, though.
> >> > >
> >> > > There might be something common between Jobs that block uses and a
> >> > > migration process.  If so, we can provide CommonJob and make MigrationJob
> >> > > and BlockJobs dependent on it.
> >> 
> >> Conceptually, live migration and the mirror block job are _really_
> >> similar. You have a bulk copy phase and you keep copying data that has
> >> changed to bring both sides in sync. When both sides are close enough,
> >> you stop new changes from coming in, copy the small remainder and finish
> >> the thing.
> >> 
> >> The main difference is that mirror copies disk content whereas live
> >> migration mostly copies RAM. But that's irrelevant conceptually.
> >
> > True at least until here..
> >
> >> 
> >> So it makes a lot of sense to me that the same user-visible state
> >> machine should be applicable to both.
> >
> > MigrationStatus should have quite some more states that block mirror may
> > not use.  They're added over time.
> >
> >> 
> >> (I'm not saying that we have to do this, just that I expect it to be
> >> possible.)
> >> 
> >> > > Possible challenges of adopting Jobs in migration flow
> >> > > ======================================================
> >> > >
> >> > > - Many Jobs defined property doesn't directly suite migration
> >> > >
> >> > >   - JobStatus is not directly suitable for migration purposes.  There're
> >> > >     some of the JobStatus that I can't think of any use
> >> > >     (e.g. JOB_STATUS_WAITING, JOB_STATUS_PENDING, which is fine, because we
> >> > >     can simply not use it), but there're other status that migration needs
> >> > >     but isn't availble. Introducing them seems to be an overkill instead to
> >> > >     block layer's use case.
> >> 
> >> Which other status does live migration have that the user cares about?
> >> 
> >> Does it have to be a status on the Job level or could it be some kind of
> >> substatus that could be represented by job-specific information in
> >> query-jobs? (Which doesn't exist yet, but I think we have been talking
> >> about it multiple times before.)
> >
> > Yes, sub-status might work, but I'm not sure how well even if so.  We can
> > evaluate this when we have more solid idea on switching the code over.
> >
> > Meanwhile, the need of sub-status may be a hint at least to me that
> > migration shouldn't move over.
> 
> Not to me.
> 
> Like the existing jobs, migration would be a specialization of Job.
> 
> Digression: in OO, we use subtypes for specialization.  QAPI doesn't
> really support subtyping.  Instead, we commonly make do with the
> old-fashioned way: unions.  For jobs, we haven't had to.  On output
> (query-job, events), there has been no need for job-specific data.  On
> input, we simply use job-specific commands to create the jobs.
> 
> Having a specialization refine a common state machine feels natural to
> me.

Sure, this isn't a blocker indeed.  So if we want we can fit into the
picture.

> 
> > IIUC, the major functionality that the Jobs layer provides is about either
> > Jobs status change, or verbs that can invoke hooks.  If migration cannot
> > leverage Jobs interface to either (1) reduce its own code, or (2) getting
> > improvements, then we don't need to move to Jobs interface either.  IMHO if
> > we can settle the two questions (1,2) above, then we can help decide
> > whether this is worth exploring.
> 
> Yes, these are the right questions, but we should consider external
> interface in addition to implementation.
> 
> Example for reduced interface complexity: generic job-cancel superseding
> migrate_cancel.

Yes, this should be listed as one of the benefits.  We could have more
e.g., transaction support mentioned below, even if I'm not yet familiar
with it; meanwhile I'll have some other comments that may make this less
beneficial, more below.

So at least we have two advantages here (comparing to... the rest, which
might be disadvantages or challenges..).

> 
> Example for improved interface: migration gaining a progress meter from
> generic query-jobs.

This may or may not be a benefit in case of migration..  I almost keep
getting complains from people on libvirt migrating stuck at 99% (where
libvirt implemented the meter for migration), only because the meter
doesn't make much sense for most of migrations, aka, precopy.. which is
unfortunate..

> 
> > [1]
> >
> > I apologize if above was a wrong statement, because that was only based on
> > my quick glimpse over job.c.  Please correct me if so.
> 
> These are the right questions whether you got all the details right or
> not!
> 
> > Maybe there is some QEMU feature that may depend on Jobs so that if
> > migration moved over then migration can also benefit from the feature?
> 
> Transactions?  Like ...
> 
> >> > The Job abstraction defines possible states and state transitions.  Each
> >> > job finds its own path from the initial state @created to the final
> >> > state @concluded.  If a state doesn't make sense for a certain type of
> >> > job, it simply doesn't go there.
> >> 
> >> Note that most states are really managed by the common Job abstraction.
> >> The job itself only goes potentially from RUNNING to READY, and then
> >> implicitly to WAITING/ABORTING when it returns from .run().
> >> 
> >> Everything else only exists so that management tools can orchestrate
> >> jobs in the right way and can query errors before the job disappears.
> >> I'm not sure if WAITING is really useless for migration.
> 
> ... this:
> 
> >>                                                          In theory, you
> >> could have a job transaction of some mirror jobs for the disks and live
> >> migration for the device state, and of course you want both to finish
> >> and switch over at the same time. I'm also not completely sure if it
> >> will actually be used in practice, but the Job infrastructure gives you
> >> the option for free.
> 
> Like Kevin, I can't tell whether anybody wants this.  It does feel
> nifty, doesn't it?

Yep.  Is transaction about auto-rewind when some job fails (hence,
apply-all or apply-none)?

One thing I should mention here is I am aware that not all the transaction
(where migration is relevant) always only involves QMP commands.

One example is when kubenetes is taking into the picture and if we need
e.g. block snapshots over kubenetes storage (where block drives are almost
always RAW rather than QCOW2), then in the future then we may not always be
able to benefit from a QEMU-only / QMP-only transaction system.

The other thing is, IMHO such transaction system would be more helpful when
we start to adopt new features, so we write less code in mgmt.  If we have
all the codes ready for libvirt on error handling anyway for migration for
all these years... moving it over may add extra work instead..

And if combining the two ideas of above, when there's possible transaction
that may take operation outside QEMU, then IIUC libvirt will always need to
manage its own unwind operation.

It looks like the 2nd benefit might be less appealing.  But maybe I have
some loopholes on the understanding.

> 
> >> PENDING and the associated job-finalize already exists in live migration
> >> in the form of pause-before-switchover/pre-switchover status and
> >> migrate-continue. So I don't think you can argue you have no use for it.
> >
> > Yes, if we want, we can map some migration status into some of those.
> >
> >> 
> >> > So, job states migration doesn't want are only a problem if there is no
> >> > path from start to finish that doesn't go through unwanted states.
> >> > 
> >> > There may also be states migration wants that aren't job states.  We
> >> > could make them job states.  Or we map multiple migration states to a
> >> > single job state, i.e. have the job state *abstract* from migration
> >> > state details.
> >> > 
> >> > >   - Similarly to JobVerb.  E.g. JOB_VERB_CHANGE doesn't seem to apply to
> >> > >     any concept to migration, but it misses quite some others
> >> > >     (e.g. JOB_VERB_SET_DOWNTIME, JOB_VERB_POSTCOPY_START, and more).
> >> 
> >> How is SET_DOWNTIME or POSTCOPY_START not just a form of CHANGE?
> >
> > I don't know, hence I listed it. :) If it fits, it's great.
> >
> > However if so, I wonder why JOB_VERB_SET_SPEED isn't part of CHANGE
> > already.  If we go further, RESUME/DISMISS/... can all be seen as CHANGE.
> 
> Jobs use separate commands to trigger state machine state transitions:
> job-resume, job-dismiss, ...
> 
> For other configuration bits that can be changed while the job runs, all
> we have is block-job-set-speed and block-job-change.  Perhaps these
> should both be superseded by a generic reconfiguration interface.
> 
> Migration's configuration interface has grown over many, many years, and
> it shows.  This isn't criticism!  It's what happens when something is so
> useful that it gets extended again and again.  We've talked about making
> that interface simpler and more regular.  Extending the job interface
> for migration should do that.

Yep, this isn't a blocker either, just like the job status.  But we already
now touched fundamentally the core of jobs on status / verbs..

It's just that IMHO the more work we need in Jobs to fit migration, the
more points we need to add on top of "disadvantages" when we compare it
against the advantages.

Thanks,

> 
> >> > JobVerb is used internally to restrict certain job commands to certain
> >> > job states.  For instance, command job-dismiss is rejected unless job is
> >> > in state @concluded.
> >> > 
> >> > This governs the generic job-FOO commands.  It also covers the legacy
> >> > block-job-FOO commands, because these wrap around the same C core as the
> >> > job-FOO commands.
> >> > 
> >> > We could have commands specific to a certain job type (say migration
> >> > jobs) that bypass the JobVerb infrastructure, and do their own thing to
> >> > restrict themselves to certain states.  Probably stupid if the states
> >> > that matter are job states.  Probably necessary if they aren't (say a
> >> > more fine-grained migration state).
> >> 
> >> I suspect we would have to look at specific examples to figure out how
> >> to represent them best. In general, I think a generic job-change (to be
> >> added as a more generic version of block-job-change) and job-specific
> >> data in query-jobs can cover a lot.
> >> 
> >> You may want to have job-specific QMP events outside of the Job
> >> mechanism, or we could have a generic one to notify the user that
> >> something in the queryable state has changed.
> 
> [...]
> 
> > IMHO if we want to move on with this idea, it'll be great if someone can
> > help answer what major benefits migration can get to move over, as I asked
> > above [1].  We'll likely need to pay quite some for it (including Libvirt
> > adopting the new interface), so I want to double check what we get.
> 
> Fair!
> 
> > Thanks,
> 

-- 
Peter Xu


