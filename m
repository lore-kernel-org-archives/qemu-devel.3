Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446C6E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 21:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXoqG-0001ZY-Ux; Tue, 14 Jan 2025 16:52:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXoqF-0001ZO-88
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 16:52:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXoqC-0003zd-O2
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 16:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736891570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XEUkriz2fMyqzHItUw2pNS9V6qacperf1Oc3JgwYGz0=;
 b=dUl7aH9XO44W9TYE7EBKa+GwV9BbTfk6n+MCBS07ZHVXcIZIYWfSzObEuAiaAK++oVHdKK
 hwm21etS6z3S/PJcPDV0npyQ08X29UAgwZHRwPjSShvFuU06xm1x5CTLxNBMUdvJI+0/Ot
 aJWYoOxuDNjjW3IGzAbWWCdG0WADMro=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-1TdOU71DPpCT7HUbf5k74w-1; Tue, 14 Jan 2025 16:52:49 -0500
X-MC-Unique: 1TdOU71DPpCT7HUbf5k74w-1
X-Mimecast-MFC-AGG-ID: 1TdOU71DPpCT7HUbf5k74w
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d8f6b89dcdso98581536d6.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 13:52:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736891569; x=1737496369;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XEUkriz2fMyqzHItUw2pNS9V6qacperf1Oc3JgwYGz0=;
 b=ZWIYKFLA1ZmqfSJa51DXCMFzCQcMceLEdBE1qlPEwBhCGMDEu15esSjTmHMbJ3Hdlu
 kFksvfnb283IuOPIfdx8cWErm20T+wY2GHoJFrmVvJvMAp2L7B8iCziTx6y2Jhy9qkSP
 qAYpDotzf0FaT+nnD8wcryz5tsu2yylzJQGQ37qE15GmAhV0c7u/8E+LGoXOGT7UjiZd
 EBrrtBmbyggQvU9wPdH6qsTNBiyq0OT0kkR9dNFC4N6NO+g5BtuwSxZ4OibFFqdIaCcB
 jWV96ifvVngZSI3HLsGuCplqL5BlAAmmJ/xrPW5T06vOUhShH5TDJXK43o1DZuy3I8iz
 ucwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS6NdSIN1bOp0uP5HdyXoU1FySautLhaw65lzLdxEF6Z6mZBLep+4JPFqSXAEgrIIYd7dWqX1Fle9C@nongnu.org
X-Gm-Message-State: AOJu0Yx2RilIlQp9qSN8mxlOhwDuVkEq0xjAx66avClJnrjUAbyl6WGh
 vfBU1b4yKv/NlZPQXRiTqKWUy/PP7w6jRdckSO5Yjm8q4z+5gb/jr9I+SjAzpkRhhLUghxL42Vf
 /MTqU6QiqnqqqSqKMxN6bZ0c4uNpSUIqPitFSnOSP6c14sXTtK1Pi
X-Gm-Gg: ASbGncuGzjL+tvl7Xpzh6d/KujuT6cGvBR7uRUHH4uaeSBvJ+SQJgLY/XPgRGshdjiW
 kIpQK/c0PqOySx285pyos+HBSKTZsrKIGNNxJkSbHQrTlkL+RnZyjjYK50SG/fYwC8cwiJIndVu
 lqD8lJVEZui+ctfI8Zik2hf3iqYQl1fSfut8AdMU9RpmLj0kZPjDX5a5CMFGzjlJA1MQ246TvVc
 jKiJz9X0vdIlWC2rUaZ64kQHkpTDzMEXOtbS3ab/WaY57rrSKE05DSwATqJIoFKlup3KPnda9+i
 pTEu5Rg6i3nAQ4q4+A==
X-Received: by 2002:a05:6214:2f8e:b0:6df:ba24:2af2 with SMTP id
 6a1803df08f44-6dfba242b5bmr284594506d6.25.1736891568761; 
 Tue, 14 Jan 2025 13:52:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEojH+i/cJ//IYug9ikjHnI4gnURNLtswq0an2hf6OrzO9HvwMPIzG1Ru8cUgpcgZto6XBCuA==
X-Received: by 2002:a05:6214:2f8e:b0:6df:ba24:2af2 with SMTP id
 6a1803df08f44-6dfba242b5bmr284594196d6.25.1736891568364; 
 Tue, 14 Jan 2025 13:52:48 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfadec2acbsm56952426d6.122.2025.01.14.13.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 13:52:47 -0800 (PST)
Date: Tue, 14 Jan 2025 16:52:45 -0500
From: Peter Xu <peterx@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC PATCH] tests/qtest/migration: Add cpu hotplug test
Message-ID: <Z4bcrc2sfCCO8LWR@x1n>
References: <20250113210833.1712-1-farosas@suse.de>
 <CAJSP0QWe+0_rjchH0hCszU-4r_PF+ZgZgWb+cgg6UZzZiYeTQA@mail.gmail.com>
 <8734hlh471.fsf@suse.de>
 <CAJSP0QUGfq0yPyzyjHy9D0=e2o_AVMvb1SaA69fm3oexYaH60g@mail.gmail.com>
 <Z4bF0FY_v8qKCGlb@x1n>
 <CAJSP0QXC+ZMECR0qkqns=ShWBBzabzf5B6eFUifM51eC9J6q8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJSP0QXC+ZMECR0qkqns=ShWBBzabzf5B6eFUifM51eC9J6q8A@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
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

On Tue, Jan 14, 2025 at 04:14:44PM -0500, Stefan Hajnoczi wrote:
> On Tue, 14 Jan 2025 at 15:15, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Jan 14, 2025 at 02:28:46PM -0500, Stefan Hajnoczi wrote:
> > > On Tue, 14 Jan 2025 at 09:15, Fabiano Rosas <farosas@suse.de> wrote:
> > > >
> > > > Stefan Hajnoczi <stefanha@gmail.com> writes:
> > > >
> > > > > On Mon, 13 Jan 2025 at 16:09, Fabiano Rosas <farosas@suse.de> wrote:
> > > > >>
> > > > >> Bug #2594 is about a failure during migration after a cpu hotplug. Add
> > > > >> a test that covers that scenario. Start the source with -smp 2 and
> > > > >> destination with -smp 3, plug one extra cpu to match and migrate.
> > > > >>
> > > > >> The issue seems to be a mismatch in the number of virtqueues between
> > > > >> the source and destination due to the hotplug not changing the
> > > > >> num_queues:
> > > > >>
> > > > >>   get_pci_config_device: Bad config data: i=0x9a read: 4 device: 5
> > > > >>   cmask: ff wmask: 0 w1cmask:0
> > > > >>
> > > > >> Usage:
> > > > >> $ QTEST_QEMU_IMG=./qemu-img QTEST_QEMU_BINARY=./qemu-system-x86_64 \
> > > > >>   ./tests/qtest/migration-test -p /x86_64/migration/hotplug/cpu
> > > > >>
> > > > >> References: https://gitlab.com/qemu-project/qemu/-/issues/2594
> > > > >> References: https://issues.redhat.com/browse/RHEL-68302
> > > > >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > > > >> ---
> > > > >> As you can see there's no fix attached to this. I haven't reached that
> > > > >> part yet, suggestions welcome =). Posting the test case if anyone
> > > > >> wants to play with this.
> > > > >>
> > > > >> (if someone at RH is already working on this, that's fine. I'm just
> > > > >> trying to get some upstream bugs to move)
> > > > >
> > > > > The management tool should set num_queues on the destination to ensure
> > > > > migration compatibility.
> > > > >
> > > >
> > > > I'm not sure that's feasible. The default num-queues seem like an
> > > > implementation detail that the management application would not have a
> > > > way to query. Unless it starts the source with a fixed number that
> > > > already accounts for all hotplug/unplug operations during the VM
> > > > lifetime, which would be wasteful in terms of resources allocated
> > > > upfront.
> > > >
> > > > That would also make the destination run with a suboptimal (< #vcpus)
> > > > number of queues, although that's already the case in the source after
> > > > the hotplug. Do we have any definition on what should happen durgin
> > > > hotplug? If one plugs 100 vcpus, should num-queues remain as 2?
> > >
> > > QEMU defaults num_queues to the number of present CPUs. A management
> > > tool that wants to ensure that all hotplugged CPUs will have their own
> > > virtqueues must set num_queues to max_cpus instead. This wastes
> > > resources upfront but in theory the guest can operate efficiently. I
> > > haven't checked the Linux guest drivers to see if they actually handle
> > > virtqueue allocation after hotplug. The Linux drivers vary in how they
> > > allocate virtqueue interrupts, so be sure to check several device
> > > types like virtio-net and virtio-blk as they may behave differently.
> > >
> > > Or the management tool can explicitly set num_queues to the number of
> > > present CPUs and preserve that across live migration and CPU hotplug.
> > > In that case num_queues can be updated across guest cold boot in order
> > > to (eventually) achieve the optimal multi-queue configuration.
> > >
> > > Other approaches might be possible too. The management tool has a
> > > choice of how to implement this and QEMU doesn't dictate a specific
> > > approach.
> >
> > Thanks for the answer, Stefan.  I've left a comment in each of the issue
> > reports so that reporter can verify this works properly.
> >
> > This also reminded me we could have specified a very large number of queues
> > in many cases - I remember it used to be 1024 somehow (perhaps also the max
> > vcpu number, but I'm not sure), which caused unwanted slowness on migration
> > loading side (aka, downtime portion) due to MMIO regions of each queue -
> > each of the queues may need a global address space update on the guest
> > physical address space.  I didn't verify this issue, but if it can be
> > reproduced and verified true, I wonder if the MMIO regions (or any relevant
> > resources that would be enabled with num_queues even though some of them
> > are not in use) can be plugged lazily, so that we can save quite some time
> > on loadvm of migration.
> 
> Greg Kurz's commit 9cf4fd872d14 ("virtio: Clarify MR transaction
> optimization") is about the scaling optimization where ioeventfd
> changes are batched into a single transaction. This made a big
> difference. Maybe something similar can be done in your case too?

Yes it could help.  I recall there used to be a more aggresive batching
proposal for the whole VM loading process that covers all device loads, but
that had some challenges elsewhere in some post_load()s.  It could indeed
be a good idea to batch in an intemediate level like per-device if possible.
I'll give it a shot when I hit that again anywhere.

-- 
Peter Xu


