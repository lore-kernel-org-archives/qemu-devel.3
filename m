Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A8DC2BD05
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 20:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKlH8-00068L-VU; Fri, 21 Jun 2024 16:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sKlH8-000684-0m
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 16:54:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sKlH5-0001FZ-Ni
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 16:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719003262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bVs8kyK16p1JMwZhivhXt1oJRIiEznkdBpX41/Mk+9c=;
 b=dato+07YZNeF2AlHGFD4bxfg4n/+QDI6YgGFct0nAner/bvJfQtlfkMFuXsrkgwmAQZDrJ
 Ewn0nqBtgTV/t+TVyyISRXLXxVrDWsOJIBEwBQMyH+/JCBjmSsGAs/+HsD7sgyKvtN+baC
 +9hcoVjtnNvwKM4Ajkxc70RofE0Ie6g=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-JaktZ5xAN1GKFlKahwsCsg-1; Fri, 21 Jun 2024 16:54:20 -0400
X-MC-Unique: JaktZ5xAN1GKFlKahwsCsg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6b52c538d04so721836d6.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 13:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719003260; x=1719608060;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVs8kyK16p1JMwZhivhXt1oJRIiEznkdBpX41/Mk+9c=;
 b=b/P8SAp1LsKtiTUMDAsIGetokL/yd259h5O0tSpT9rUDyVis2Q7zgCXVQWDvIZ/134
 KE5uuZK+0XlTzhglRkC0FiMG6FHYtIZigga61/+LkHG0hsnziLnqyC6KBd2GXae96/JE
 aP4zzjrsdyOHElN4iYeKeRtaO74LWC/VKR5XNyYS3ltM4Qu+Lh2nLOWGKJUVBiBLjCxq
 n2NBk9mDUZJUi+/RTITphlLT55dMaJyQTeYa59spNvc87vgVSWYmisFKoJhvDPTmuqI7
 Kf2MdGK7ijvZrKdLJ+JpTnWBRIfRCLsDDhoEZErpSVJ3Dh+Rn4tra1COj6gYluyN5/0g
 48uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRaMNGeXmGYpsNWn8Dk+hnO5pBTETlcFCWVQxMczi1MI4GE8ompos8VUMFECTO9tQkVrdDd/fENakYJff9pGbBbLwVPM0=
X-Gm-Message-State: AOJu0Yxw9l92IilYOe5TSwX8GEcvj0qvK7Cc2du3o/pl+fKgen+yUEZp
 zhX+HNKbb6pLOFHCJqgYWQ9SzWfmjLGQ7k4AYMeC+Kdi+ssi59l/PtUfEzGC+5yZSwZQSjNwE/9
 lvxd/bdoMIeEV2E1Oq3lnt/rUWdQ72csaUUoqj+11EPHf1flyohIQ
X-Received: by 2002:a05:622a:199b:b0:441:2106:8c7 with SMTP id
 d75a77b69052e-444a79a9ef6mr100757741cf.1.1719003259913; 
 Fri, 21 Jun 2024 13:54:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF9sIyoK+vay3HzHS4bb7mhkkU4daSn9B+CQtakO/WSHhCDFJc8GOZc8E6Mssw+EtSuEq0qA==
X-Received: by 2002:a05:622a:199b:b0:441:2106:8c7 with SMTP id
 d75a77b69052e-444a79a9ef6mr100757501cf.1.1719003259312; 
 Fri, 21 Jun 2024 13:54:19 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-444c2c42242sm14476551cf.63.2024.06.21.13.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 13:54:19 -0700 (PDT)
Date: Fri, 21 Jun 2024 16:54:16 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 0/7] migration/multifd: Introduce storage slots
Message-ID: <ZnXoeOIbga7mu4BY@x1n>
References: <20240620212111.29319-1-farosas@suse.de>
 <f6f84518-530e-4332-8881-41a6219b8d4d@maciej.szmigiero.name>
 <87v822ibh8.fsf@suse.de>
 <dfe0384e-a765-4bfb-81c8-529329d76052@maciej.szmigiero.name>
 <ZnWinGjeZGRGVOF-@x1n>
 <2d245ec8-0b0d-4596-a3a7-8bbbfd9c3d41@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d245ec8-0b0d-4596-a3a7-8bbbfd9c3d41@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 21, 2024 at 07:40:01PM +0200, Maciej S. Szmigiero wrote:
> On 21.06.2024 17:56, Peter Xu wrote:
> > On Fri, Jun 21, 2024 at 05:31:54PM +0200, Maciej S. Szmigiero wrote:
> > > On 21.06.2024 17:04, Fabiano Rosas wrote:
> > > > "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
> > > > 
> > > > > Hi Fabiano,
> > > > > 
> > > > > On 20.06.2024 23:21, Fabiano Rosas wrote:
> > > > > > Hi folks,
> > > > > > 
> > > > > > First of all, apologies for the roughness of the series. I'm off for
> > > > > > the next couple of weeks and wanted to put something together early
> > > > > > for your consideration.
> > > > > > 
> > > > > > This series is a refactoring (based on an earlier, off-list
> > > > > > attempt[0]), aimed to remove the usage of the MultiFDPages_t type in
> > > > > > the multifd core. If we're going to add support for more data types to
> > > > > > multifd, we first need to clean that up.
> > > > > > 
> > > > > > This time around this work was prompted by Maciej's series[1]. I see
> > > > > > you're having to add a bunch of is_device_state checks to work around
> > > > > > the rigidity of the code.
> > > > > > 
> > > > > > Aside from the VFIO work, there is also the intent (coming back from
> > > > > > Juan's ideas) to make multifd the default code path for migration,
> > > > > > which will have to include the vmstate migration and anything else we
> > > > > > put on the stream via QEMUFile.
> > > > > > 
> > > > > > I have long since been bothered by having 'pages' sprinkled all over
> > > > > > the code, so I might be coming at this with a bit of a narrow focus,
> > > > > > but I believe in order to support more types of payloads in multifd,
> > > > > > we need to first allow the scheduling at multifd_send_pages() to be
> > > > > > independent of MultiFDPages_t. So here it is. Let me know what you
> > > > > > think.
> > > > > 
> > > > > Thanks for the patch set, I quickly glanced at these patches and they
> > > > > definitely make sense to me.
> > > > > 
> > > (..)
> > > > > > (as I said, I'll be off for a couple of weeks, so feel free to
> > > > > > incorporate any of this code if it's useful. Or to ignore it
> > > > > > completely).
> > > > > 
> > > > > I guess you are targeting QEMU 9.2 rather than 9.1 since 9.1 has
> > > > > feature freeze in about a month, correct?
> > > > > 
> > > > 
> > > > For general code improvements like this I'm not thinking about QEMU
> > > > releases at all. But this series is not super complex, so I could
> > > > imagine we merging it in time for 9.1 if we reach an agreement.
> > > > 
> > > > Are you thinking your series might miss the target? Or have concerns
> > > > over the stability of the refactoring? We can within reason merge code
> > > > based on the current framework and improve things on top, we already did
> > > > something similar when merging zero-page support. I don't have an issue
> > > > with that.
> > > 
> > > The reason that I asked whether you are targeting 9.1 is because my
> > > patch set is definitely targeting that release.
> > > 
> > > At the same time my patch set will need to be rebased/refactored on top
> > > of this patch set if it is supposed to be merged for 9.1 too.
> > > 
> > > If this patch set gets merged quickly that's not really a problem.
> > > 
> > > On the other hand, if another iteration(s) is/are needed AND you are
> > > not available in the coming weeks to work on them then there's a
> > > question whether we will make the required deadline.
> > 
> > I think it's a bit rush to merge the vfio series in this release.  I'm not
> > sure it has enough time to be properly reviewed, reposted, retested, etc.
> > 
> > I've already started looking at it, and so far I think I have doubt not
> > only on agreement with Fabiano on the device_state thing which I prefer to
> > avoid, but also I'm thinking of any possible way to at least make the
> > worker threads generic too: a direct impact could be vDPA in the near
> > future if anyone cared, while I don't want modules to create threads
> > randomly during migration.
> > 
> > Meanwhile I'm also thinking whether that "the thread needs to dump all
> > data, and during iteration we can't do that" is the good reason to not
> > support that during iterations.
> > 
> > I didn't yet reply because I don't think I think all things through, but
> > I'll get there.
> > 
> > So I'm not saying that the design is problematic, but IMHO it's just not
> > mature enough to assume it will land in 9.1, considering it's still a large
> > one, and the first non-rfc version just posted two days ago.
> 
> 
> The RFC version was posted more than 2 months ago.
> 
> It has received some review comments from multiple people,
> all of which were addressed in this patch set version.

I thought it was mostly me who reviewed it, am I right?  Or do you have
other thread that has such discussion happening, and the design review has
properly done and reached an agreement?

IMHO that is also not how RFC works.

It doesn't work like "if RFC didn't got NACKed, a maintainer should merge
v1 when someone posts it".  Instead RFC should only mean these at least to
me: "(1) please review this from high level, things can drastically change;
(2) please don't merge this, because it is not for merging but for getting
comments."

Beyond, it doesn't imply anything for what happens after the RFC series.

> 
> I have not received any further comments during these 2 months, so I thought
> the overall design is considered okay - if anything, there might be minor
> code comments/issues but these can easily be improved/fixed in the 5 weeks
> remaining to the soft code freeze for 9.1.

The latest email in that thread (assuming this one is what you're referring
to) is:

https://lore.kernel.org/qemu-devel/f67fcc88-aaf6-43f7-9287-90cbd7495ba1@nvidia.com/#t

I didn't hear anything from Avihai yet, neither did I think we reached an
complete agreement on the whole design.

> 
> 
> If anything, I think that the VM live phase (non-downtime) transfers
> functionality should be deferred until 9.2 because:
> * It wasn't a part of the RFC so even if implemented today would get much
> less testing overall,

IMO it really depends on what was proposed.  Anyone who send patches should
definitely test whatever the patchset provides.  If that patchset includes
the iteration changes then that needs to be tested by the submitter.

> 
> * It's orthogonal to the switchover time device state transfer functionality
> introduced by this patch set and could be added on top of that without
> changing the wire protocol for switchover time device state transfers,

AFAICT it will affect the wire protocol?  If the dest QEMU contains your
patcheset to be the old version of QEMU, then the threads will only be
created at the switchover phase, and it won't be ready to take whatever
data sent from a new QEMU which may allow migrating VFIO iteration data,
who may expect these VFIO data to be passed over via multifd channels
even before the switchover.

It can only be compatible at least when the threads are created before
iteration starts on dest side, and I didn't yet check the packet headers
and other stuffs.

I think that can be a sweet spot where maybe you can land this series
sooner, but it also gets ready for anyone who wants to further extend that
to iteration phase easily.  Not sure whether it'll be easily feasible by
just moving the thread creations earlier.

> 
> * It doesn't impact the switchover downtime so in this case 9.1 would
> already contain all what's necessary to improve it.

Yes it won't, but IMHO that's not an issue.

Since Fabiano is going on a short break soon, I think I'll be the only one
review it.  I'll try my best, but still I can't guarantee it will be able
to land in 9.1, and this is not the only thing I'll need to do next week..

I appreciated a lot you worked out VFIO on top of multifd, because IMHO
that's really the right direction.  However even with that, I don't think
the whole design is yet fully settled, not to mention the details. And that
implies it may miss 9.1.

Thanks,

-- 
Peter Xu


