Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86441E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 20:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXnJu-0002zP-Sv; Tue, 14 Jan 2025 15:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXnJr-0002z3-6E
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 15:15:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXnJo-0006h3-86
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 15:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736885718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=co+aeVVEo9Z/SBAYg+SrgL79qJLVclP53vKTKSByJDY=;
 b=VFyilDwBJ2VuKqLfh66dzb49wKpv0ZaMxPa89hYlEva8ANW7lmkTKU/z6HkZor9DD6Lbab
 I8vPEfLE5f0gpHccuJyphaHy75qwETdC8yuFSRU+26FJfg7X3sa8BPSn5BogAZ20nF8he/
 40bI410bUcxekrNFQtr7n6k/l11RFgE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-BJ6t5R9zOAic7EX7DXnP1A-1; Tue, 14 Jan 2025 15:15:16 -0500
X-MC-Unique: BJ6t5R9zOAic7EX7DXnP1A-1
X-Mimecast-MFC-AGG-ID: BJ6t5R9zOAic7EX7DXnP1A
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d87d6c09baso85141406d6.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 12:15:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736885716; x=1737490516;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=co+aeVVEo9Z/SBAYg+SrgL79qJLVclP53vKTKSByJDY=;
 b=Uw4wOZSeoHI6acmM37Bw3LMyR9VUKa4IRvF5gLsT8gH02han6JOpk/41sryPqVS9Ds
 nEkemKmch/o7bLT2InBE4YDewVEoDtv19/yrRcEN1pIXRC62LnWc1jvEssb8npi2WscN
 5rzGXYw49JMsPO2hn4l7jQYl4hoX+k/5M7Z4eItjRJ5WDtrI/kim5Z2YqFkgf8ZTLwQZ
 KgAsEvSUeyXmfDTIvFQ/cIj0LwmvXSwhCjsS7kNxpipC7lHs52sYTl8nktiXCUUQ4HJW
 fOqU03O3tcSMovh1l3bXknONdNib3g1QQ8Zu71zYkgjvHFPSKX9VICLIT5V52avHcMRX
 cppQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrdCVByi0prNvNstDTRZe2ePjeac7i3LD3gw1QYMlT+c3RfI2VA9J1ghByvzjloMgmOWX7R6VGlGU+@nongnu.org
X-Gm-Message-State: AOJu0Yxsh1vAFzjle2PYwR3ZW0dOc/dw2rnaWlUV8Fagkjz71fgnASeB
 5b4edNTDYkjJO4aUpdz71J0mshfoyVMrDvqdRn0IP+MKtuXQlfhoXgzqp9L11ggs/neVPPo7C31
 y2naRGDoS3FmGzbSmbDFIQsABNalHPY5wE1YgcSBdpnJIrJelLWxB
X-Gm-Gg: ASbGncsD8Rehb9qrg0kJYepYj8K0/fh/qY+N8pxTkJzA4x7HUV4R30jdpt0ON4rCZ8p
 Dm8ulsQPI2bBqBIUIa8pOdweXxTCh7qYNleOGOiEBKYwL4LlQ0x4rOyfOi3p4XpDCPR0s/gUckM
 O+UhtqflfhDntd2TJNiTUHtNwogvP61kOuLqCaF4KkT+ocsLgz5xWwuBPmGyCN/P8dHEUwFhKUl
 hvqq+3RuJHhpyUo/x6C6X7HKptrYaprnvAA+xhYiATbFcQOfgWz6PwqEhbmOnLV0EqXXQkcPe93
 3ttBZ2daYvgbnTRDeA==
X-Received: by 2002:ad4:5be9:0:b0:6d4:3c10:5065 with SMTP id
 6a1803df08f44-6df9b2ad55amr428374536d6.32.1736885716177; 
 Tue, 14 Jan 2025 12:15:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8LWgbSh8/F4Eo50r9B3LJI6mQDsc87nDIMFHSHgaPBATIUAEttqenPh7+VVV6DlHiWK3d5Q==
X-Received: by 2002:ad4:5be9:0:b0:6d4:3c10:5065 with SMTP id
 6a1803df08f44-6df9b2ad55amr428374076d6.32.1736885715823; 
 Tue, 14 Jan 2025 12:15:15 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad880dffsm56003286d6.38.2025.01.14.12.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 12:15:15 -0800 (PST)
Date: Tue, 14 Jan 2025 15:15:12 -0500
From: Peter Xu <peterx@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC PATCH] tests/qtest/migration: Add cpu hotplug test
Message-ID: <Z4bF0FY_v8qKCGlb@x1n>
References: <20250113210833.1712-1-farosas@suse.de>
 <CAJSP0QWe+0_rjchH0hCszU-4r_PF+ZgZgWb+cgg6UZzZiYeTQA@mail.gmail.com>
 <8734hlh471.fsf@suse.de>
 <CAJSP0QUGfq0yPyzyjHy9D0=e2o_AVMvb1SaA69fm3oexYaH60g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJSP0QUGfq0yPyzyjHy9D0=e2o_AVMvb1SaA69fm3oexYaH60g@mail.gmail.com>
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

On Tue, Jan 14, 2025 at 02:28:46PM -0500, Stefan Hajnoczi wrote:
> On Tue, 14 Jan 2025 at 09:15, Fabiano Rosas <farosas@suse.de> wrote:
> >
> > Stefan Hajnoczi <stefanha@gmail.com> writes:
> >
> > > On Mon, 13 Jan 2025 at 16:09, Fabiano Rosas <farosas@suse.de> wrote:
> > >>
> > >> Bug #2594 is about a failure during migration after a cpu hotplug. Add
> > >> a test that covers that scenario. Start the source with -smp 2 and
> > >> destination with -smp 3, plug one extra cpu to match and migrate.
> > >>
> > >> The issue seems to be a mismatch in the number of virtqueues between
> > >> the source and destination due to the hotplug not changing the
> > >> num_queues:
> > >>
> > >>   get_pci_config_device: Bad config data: i=0x9a read: 4 device: 5
> > >>   cmask: ff wmask: 0 w1cmask:0
> > >>
> > >> Usage:
> > >> $ QTEST_QEMU_IMG=./qemu-img QTEST_QEMU_BINARY=./qemu-system-x86_64 \
> > >>   ./tests/qtest/migration-test -p /x86_64/migration/hotplug/cpu
> > >>
> > >> References: https://gitlab.com/qemu-project/qemu/-/issues/2594
> > >> References: https://issues.redhat.com/browse/RHEL-68302
> > >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > >> ---
> > >> As you can see there's no fix attached to this. I haven't reached that
> > >> part yet, suggestions welcome =). Posting the test case if anyone
> > >> wants to play with this.
> > >>
> > >> (if someone at RH is already working on this, that's fine. I'm just
> > >> trying to get some upstream bugs to move)
> > >
> > > The management tool should set num_queues on the destination to ensure
> > > migration compatibility.
> > >
> >
> > I'm not sure that's feasible. The default num-queues seem like an
> > implementation detail that the management application would not have a
> > way to query. Unless it starts the source with a fixed number that
> > already accounts for all hotplug/unplug operations during the VM
> > lifetime, which would be wasteful in terms of resources allocated
> > upfront.
> >
> > That would also make the destination run with a suboptimal (< #vcpus)
> > number of queues, although that's already the case in the source after
> > the hotplug. Do we have any definition on what should happen durgin
> > hotplug? If one plugs 100 vcpus, should num-queues remain as 2?
> 
> QEMU defaults num_queues to the number of present CPUs. A management
> tool that wants to ensure that all hotplugged CPUs will have their own
> virtqueues must set num_queues to max_cpus instead. This wastes
> resources upfront but in theory the guest can operate efficiently. I
> haven't checked the Linux guest drivers to see if they actually handle
> virtqueue allocation after hotplug. The Linux drivers vary in how they
> allocate virtqueue interrupts, so be sure to check several device
> types like virtio-net and virtio-blk as they may behave differently.
> 
> Or the management tool can explicitly set num_queues to the number of
> present CPUs and preserve that across live migration and CPU hotplug.
> In that case num_queues can be updated across guest cold boot in order
> to (eventually) achieve the optimal multi-queue configuration.
> 
> Other approaches might be possible too. The management tool has a
> choice of how to implement this and QEMU doesn't dictate a specific
> approach.

Thanks for the answer, Stefan.  I've left a comment in each of the issue
reports so that reporter can verify this works properly.

This also reminded me we could have specified a very large number of queues
in many cases - I remember it used to be 1024 somehow (perhaps also the max
vcpu number, but I'm not sure), which caused unwanted slowness on migration
loading side (aka, downtime portion) due to MMIO regions of each queue -
each of the queues may need a global address space update on the guest
physical address space.  I didn't verify this issue, but if it can be
reproduced and verified true, I wonder if the MMIO regions (or any relevant
resources that would be enabled with num_queues even though some of them
are not in use) can be plugged lazily, so that we can save quite some time
on loadvm of migration.

-- 
Peter Xu


