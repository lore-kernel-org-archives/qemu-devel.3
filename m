Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEF4E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 22:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJggc-0007C4-KD; Fri, 06 Dec 2024 17:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJggb-0007Bq-He
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:20:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJggZ-0005YD-Fc
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733523630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bnVc1lHAtPCvGrDj8ozZjF8yOOFdHeXtRwuLKiWEyto=;
 b=OhdBWf/fvvaLSXqczReOkrj3gtoR4xNfszBrHjeOFsWMPDVpXJOplQuGW/tfeL/DRHjbQq
 CsJ2tB3VS57zvexLyythn3mDL8r9jVJX9WCs6SQHUpBy3/nSjGok4heDkzAxbeb9W8pyNe
 zpJgbvWQ/sPNzUTh/ld+fuPrmlMiCm4=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-oI5e-naSPyqyievpUSTN5g-1; Fri, 06 Dec 2024 17:20:29 -0500
X-MC-Unique: oI5e-naSPyqyievpUSTN5g-1
X-Mimecast-MFC-AGG-ID: oI5e-naSPyqyievpUSTN5g
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-8419946e077so422953939f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 14:20:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733523628; x=1734128428;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bnVc1lHAtPCvGrDj8ozZjF8yOOFdHeXtRwuLKiWEyto=;
 b=hwHnou6NVkMgGLCIWTsOmByZK4VG+T7iDm9gzV9CEeeXGk/w4c9bwjXJzN4/sKbAKW
 E30EtHbDXY9fi3EmzRnNrILWCWa/N3Fcjn8N1NsUKkiqr5Zgct82X0pAFk/ftd37Fjrs
 frO3zTOf1OSQUx+JEwEAqNKnfT78MHYk21IVqUBnC0qjome/gFF64/Fkrb1qXBe7/rfW
 OPYwYSdEMAlBz//MdbLoezakuFqNLLbuxAvoqmwM9MREOm+X+FCnsOpAZWVhC/He+1Ug
 lNso3/kJOtAzgvi/wi/69ozGPYJa7YY8cUpxHl1qCv/Ut9bN5c4kaWc3ozv+KCD1E2M2
 Arrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVrVYsK8XbIssE245TFGNFAaj3C3loSbzmd/4PxqHGDnZ09R73p9G1VAiacrD3TBURWwWfdXJr0Jo5@nongnu.org
X-Gm-Message-State: AOJu0YyMNcSBUXfOcWG6I8AtkmYvRAQyI2eteLh/Z5vq8lyJ7N3BLdjH
 fYfi+a1CrJV3yk/V3DfxK797l+y/f616glWa0n7Lo6XNa3xXmWwE9hONWQ1kmXnZwWKRRyF2R7X
 k3dEBmzpchWSWmLzuOmfjZqtQoPMGe73ZuKaDMM9zO7LMwtQZKy6+
X-Gm-Gg: ASbGncs3sSs9O+bwgp/vKF0829nPiuPRDAUz3frE/rXBdX9qW6p4aRE+oLY0yeZsEnZ
 aMcrEyvMgUDviPR/KpvNX5zdwhT9TpTkKM9e3cIRnM25BvWueJ6K/xgk+XAxHYJ83OCNxd9wLZ8
 NZkoBQJRcWrAkCBZgTo1Bjqc/u3dmDT2na+SQFOfQPzbOqC/guH2kYxSz2UVJnuA1BnXlKqT8Va
 qsZDl1NIBpoTD/yxNO5+tEHPrJVWhNLe57tDrW1AnRtl6/EgX6jrn2gw2V3T1AePzvZ7MW2mGKu
 3qXUn8ZNdTE=
X-Received: by 2002:a05:6602:6d01:b0:837:7f69:eac2 with SMTP id
 ca18e2360f4ac-8447e1dac49mr499812739f.1.1733523628481; 
 Fri, 06 Dec 2024 14:20:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7CBWwLIAujfWfL+lSZdE4bYpFzLXbnUn3yWPsZp2htxBXafraaK/ocCNdLUa3WHGn0epiIA==
X-Received: by 2002:a05:6602:6d01:b0:837:7f69:eac2 with SMTP id
 ca18e2360f4ac-8447e1dac49mr499811639f.1.1733523628203; 
 Fri, 06 Dec 2024 14:20:28 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861d73aasm1020656173.81.2024.12.06.14.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:20:27 -0800 (PST)
Date: Fri, 6 Dec 2024 17:20:25 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 00/24] =?utf-8?Q?Multifd_?= =?utf-8?B?8J+UgA==?=
 device state transfer support with VFIO consumer
Message-ID: <Z1N4qYOsEcfsC-H5@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <Z1CpIA7_o7s-NzJ_@x1n>
 <23398782-6d92-48ae-99f3-855b405f366f@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23398782-6d92-48ae-99f3-855b405f366f@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Fri, Dec 06, 2024 at 07:03:36PM +0100, Maciej S. Szmigiero wrote:
> On 4.12.2024 20:10, Peter Xu wrote:
> > On Sun, Nov 17, 2024 at 08:19:55PM +0100, Maciej S. Szmigiero wrote:
> > > Important note:
> > > 4 VF benchmarks were done with commit 5504a8126115
> > > ("KVM: Dynamic sized kvm memslots array") and its revert-dependencies
> > > reverted since this seems to improve performance in this VM config if the
> > > multifd transfer is enabled: the downtime performance with this commit
> > > present is 1141 ms enabled / 1730 ms disabled.
> > > 
> > > Smaller VF counts actually do seem to benefit from this commit, so it's
> > > likely that in the future adding some kind of a memslot pre-allocation
> > > bit stream message might make sense to avoid this downtime regression for
> > > 4 VF configs (and likely higher VF count too).
> > 
> > I'm confused why revert 5504a8126115 could be faster, and it affects as
> > much as 600ms.  Also how that effect differs can relevant to num of VFs.
> > 
> > Could you share more on this regression?  Because if that's problematic we
> > need to fix it, or upstream QEMU (after this series merged) will still not
> > work.
> > 
> 
> The number of memslots that the VM uses seems to differ depending on its
> VF count, each VF using 2 memslots:
> 2 VFs, used slots: 13
> 4 VFs, used slots: 17
> 5 VFs, used slots: 19

It's still pretty less.

> 
> So I suspect this performance difference is due to these higher counts
> of memslots possibly benefiting from being preallocated on the previous
> QEMU code (before commit 5504a8126115).
> 
> I can see that with this commit:
> > #define  KVM_MEMSLOTS_NR_ALLOC_DEFAULT                      16
> 
> So it would explain why the difference is visible on 4 VFs only (and
> possibly higher VF counts, just I don't have an ability to test migrating
> it) since with 4 VF configs we exceed KVM_MEMSLOTS_NR_ALLOC_DEFAULT.

I suppose it means kvm_slots_grow() is called once, but I don't understand
why it caused 500ms downtime!

Not to mention, that patchset should at least reduce downtime OTOH due to
the small num of slots, because some of the dirty sync / clear path would
need to walk the whole slot array (our lookup is pretty slow for now, but
probably no good reason to rework it yet if it's mostly 10-20).

In general, I would still expect that dynamic memslot work to speedup
(instead of slowing down) VFIO migrations.

There's something off here, or something I overlooked.  I suggest we figure
it out..  Even if we need to revert the kvm series on master, but I so far
doubt it.

Otherwise we should at least report the number with things on the master
branch, and we evaluate merging this series with that real number, because
fundamentally that's the numbers people will get when start using this
feature on master later.

-- 
Peter Xu


