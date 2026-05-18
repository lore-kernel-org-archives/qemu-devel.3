Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02EFCD4F49
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 14:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOz1Z-00011V-9d; Mon, 18 May 2026 10:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wOz1X-00011F-Ft
 for qemu-devel@nongnu.org; Mon, 18 May 2026 10:32:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wOz1V-0006qp-1g
 for qemu-devel@nongnu.org; Mon, 18 May 2026 10:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779114767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P9XbZXIBDepwxGETTfVnR1shJ1x1rE3gsut92l3uTL4=;
 b=e2uEKiTL6esv522c0xjBu0d5FBMhrY8EWI1uZsIBSyjXkZvny/IfnxF/dOV3WoeqSR9OQL
 J1HVU8f1WD7vx+ZMxBxiUMcCpdoh2G0dxrhZINvHDJxHvhzCiTsguOHsz3+wuWA9Aew6Cd
 w05U07xhipOnlf4DB3hmqG1fv+PKtGY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-rkauQAJXPKalQkC2N7-vJg-1; Mon, 18 May 2026 10:32:44 -0400
X-MC-Unique: rkauQAJXPKalQkC2N7-vJg-1
X-Mimecast-MFC-AGG-ID: rkauQAJXPKalQkC2N7-vJg_1779114762
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-447f2ce5556so2250190f8f.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 07:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779114762; x=1779719562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P9XbZXIBDepwxGETTfVnR1shJ1x1rE3gsut92l3uTL4=;
 b=Ok8f/nqzyGeoJdQ8AcTTqbaGTNMF+N/yi2t6W6EyxBar6U5oEg5o6SqST+3/sAMYPK
 0dX+pg7Gab8Qcsmy+5YVvy3hEEknLTvFIFayZd6BX9RP5VxM7YeVrdFTgk1s/dYKEjD0
 8rMG00EL7osvZ8+5/GCSaY6OomPuImm+vcaKoxox1MCZSsWwprmcL4KYkhxCL0qDVE+o
 pyoW91hG2sdU8VR2C8qmpGvFmx9psFn9lkhljp+/OtUchStvfz7pehmras9RJ7rw/52g
 6xe5clAoKsDUR4rSIXuIIa2tJoeKq3fhPQjZoF6kmx9g6sixWXnnArl16RMjUsd/Xts8
 P9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779114762; x=1779719562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P9XbZXIBDepwxGETTfVnR1shJ1x1rE3gsut92l3uTL4=;
 b=q4EkEuZx8IZb4M1RPLR2NZujIfQ8r56fbXHvt63NduDueDqZjHy1Rw8azgH4Ki0SYr
 EiBHnzVBQPoGLPC8NoScqBtMw2XPmmu2mWakqcUzyE+hAiEa29P4pPjIXnxnnbxZmzHS
 zqhUZpm7/Igpccou3dFZTlO6oraIvbAN3gUKk8Uc5PnPEfgAefainsAiT3xpwU4D8i9p
 dq2MebVWdxV+D3CZX2WCwyWNinwoOSpKpAO3HsZZy6YwIVvUli8YbHalnnqIefHAxbOM
 eX7el7N2o6tSUl8lWwPLpST/A9qSqxi/ZvyjT+t1H0Er72NL8tsaa3qDQIQM5gpXqkRp
 X1JQ==
X-Gm-Message-State: AOJu0Yxo+yFqAAJPQ80F2Lxv/WpGSFaRs4KoTU9ZAk7rKr/CNsgQF4RG
 j18YaZFckg6QSu1ZzRcrXjLoKC15d+m69sGIqJ/EwIgPm5UccS1F3kimia2fu8s+fd8S1uI0l9p
 jk6IyCuFJ82l2CC4Lo3tF9aQtPK/SN7vmn6cZAFXb5koU6iB6AemP6yjO
X-Gm-Gg: Acq92OEbsTvSgHHa+8xfQ04DDQFLDN7DPTs/gFqlG8q51IKxbKKO2qe57xh8BiCyu6f
 /xG4eO2t6SNuVxM600muUqcGwEX9+Vo+cKMYysFi3IhcbVU3MEoPP46gOyFoUh1Lg86Lk/pFte/
 Fl2fRjQAvYCwvkzXJA+n/wtrNLtqanKUN35BMHlrDJ0mXutpBWIVjg+E42oZ+paoFZtxBULnl7y
 dZmKL9wUc4jVwssc2iPnBL2NBQBKRbd0J+7R02U3lgDGJ+/7hWZlKl2D0acBnzSkxbg6Jm44zO4
 gUbuR7Hz9sMd4kvd5MBsgfRASvmXQDiMk+Agxp6lPTWjJkDeS5JHhFTyX7Q1NbDSQ+SKbwtBnsp
 VbWleCA==
X-Received: by 2002:a05:6000:25c7:b0:452:79c0:f7f1 with SMTP id
 ffacd0b85a97d-45e5c349e9amr24709797f8f.0.1779114762029; 
 Mon, 18 May 2026 07:32:42 -0700 (PDT)
X-Received: by 2002:a05:6000:25c7:b0:452:79c0:f7f1 with SMTP id
 ffacd0b85a97d-45e5c349e9amr24709733f8f.0.1779114761469; 
 Mon, 18 May 2026 07:32:41 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45e7c22d8b7sm8692577f8f.6.2026.05.18.07.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 07:32:40 -0700 (PDT)
Date: Mon, 18 May 2026 16:32:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
Cc: <qemu-devel@nongnu.org>, <david@redhat.com>, <gourry@gourry.net>,
 <jonathan.cameron@huawei.com>, <apopple@nvidia.com>,
 <dan.j.williams@intel.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>,
 David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH v7 1/1] numa: add 'memmap-type' option for memory type
 configuration
Message-ID: <20260518163239.2fd73491@imammedo>
In-Reply-To: <4a3de73b-03bd-446e-8cbd-dedd5323e295@amd.com>
References: <20260306082735.1106690-1-FangSheng.Huang@amd.com>
 <20260306082735.1106690-2-FangSheng.Huang@amd.com>
 <20260514150559.3148f9dc@imammedo>
 <d26cfb4b-d70e-415c-8747-904d94f8ccb2@amd.com>
 <20260515150453.409e0e3e@imammedo>
 <4a3de73b-03bd-446e-8cbd-dedd5323e295@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 18 May 2026 18:43:10 +0800
"Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com> wrote:

> Hi Igor,
> 
> Thanks again for the careful read.
> 
> On 5/15/2026 9:04 PM, Igor Mammedov wrote:
> > On Fri, 15 May 2026 15:53:07 +0800
> > "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com> wrote:
> >   
> >> On 5/14/2026 9:05 PM, Igor Mammedov wrote: 
> >>
> >> Hi Igor,
> >>
> >> Thanks for taking the time to review this -- and for the candor in
> >> the bashing chapter.  Before going into the bigger picture, let me
> >> re-establish one factual point that v7 didn't carry forward from
> >> the v6 cover letter.  
> > 
> > feel free to bash my review as well, I hope that we end up with
> > clear picture what and why we are doing.
> >   
> Let me take your points in order: first the bigger-picture context
> you asked for (which I'll also put in v8's commit message), then
> the dax/kmem compatibility state, the prior thread on this CLI
> shape, and where this could go longer-term.
> 
> > 
> > bigger picture should be somewhere in commit message so later on
> > a reader could understand why we are doing it at all/this way.
> >   
> > lets continue with questions wrt impl.
> >   
> Agreed, v8 will carry a condensed version of the bigger picture
> in the commit message body.  Setting the architectural context
> out in full here first -- the rest of the reply depends on it.
> 
> (1) The architectural context: HBM is system memory in this class
> of systems
> 
> This patch targets coherent CPU+accelerator shared-address-space
> systems, where the accelerator's high-bandwidth memory is no
> longer a device-private framebuffer behind a PCIe BAR.  It lives
> in the host physical address space -- visible to the CPU as
> system memory (not as device MMIO) and shared coherently with
> the accelerator over the platform fabric.  Both sides must keep
> consistent views of those pages or the coherent contract breaks.
> 
> >> The use case is GPU/accelerator HBM exposed to the OS as SPM.  On
> >> bare metal, the platform firmware:
> >>
> >>     - emits E820 type 0xEFFFFFFF (SOFT_RESERVED) for the HBM region;
> >>     - emits ACPI SRAT memory affinity entries that bind HBM to a
> >>       dedicated proximity domain (NUMA node);
> >>     - tags the accelerator's PCI device with _PXM matching that node.
> >>
> >> That gives the device driver a stable lookup chain at runtime:
> >>
> >>       dev -> pci_dev_to_node(dev) -> SRAT walk -> HBM GPA range  
> > 
> > it looks kind of convoluted, isn't it.
> > PCI devices were supposed to be self describing/discoverable.
> > Preferably without above mentioned firmware 'hooks'.
> > Above example could be just early impl. issues, rather than by
> > design issue.
> >   
> >> NUMA node here is not incidental -- it is the OS-exposed
> >> intermediary ID that the device driver uses to find its own HBM.
> >> This is the in-tree path used by accelerator drivers today.  
> > 
> > I'm assuming GPU is exposed as some composite PCI/CXL device.
> > and use-case is its pass-through to guest.
> > 
> > Perhaps we can't do anything about it now.
> > But shouldn't device driver discover its own memory (HBM and what not)
> > without external parties that magically gain knowledge about parts of
> > device that driver supposedly driving the device has not a clue about?
> > How doesn bios know about SPM when device's driver with knowledge of
> > device internals knows nothing about?
> >     
> To be blunt about it: in this architecture, "the device alone
> knows where its own memory is" doesn't apply.  The accelerator
> package knows it has HBM and how much, but the GPA it's mapped to
> is set by platform firmware during boot fabric training, in
> coordination with the CPU host bridge and the fabric coherency
> hardware.  Firmware "knows the GPA" because firmware authored
> that binding, not because some external party magically learned
> the device's internals; every party including the driver has to
> conform to it.


Without magic/hardcodding, firmware is likely to discover HBM memory
as CXL device and adds E820/SRAT entries for it. That ideally how it
should be modeled in QEMU as well. (not ad-hoc -numa foo options)

I won't push towards the feature being part of GPU pass-through,
or being HBM being a CXL device (which it probably should be).
but read on ...
 
> That makes the OS-level requirement twofold: the memory has to be
> visible in the system memory map (so the CPU side can address it)
> and reserved exclusively for the accelerator's driver (so the
> general allocator doesn't hand HBM pages to random workloads).
> The SP marking therefore has to reach the CPU memory subsystem,
> not just the driver.  EFI_MEMORY_SP / E820 SOFT_RESERVED + SRAT
> memory-affinity is the mechanism that fits this: a system-level,
> firmware-produced topology that the CPU memory subsystem honors
> and that the accelerator's driver consumes to discover and
> manage its HBM range.  Any path that emits only an ACPI namespace
> node, without E820 SOFT_RESERVED, leaves the CPU memory subsystem
> without that signal and the contract breaks; any path that does
> also emit E820 SOFT_RESERVED restores it.
> 
> >> The "-numa node + memmap-type=spm + E820 SOFT_RESERVED" combo in
> >> v7 is a direct 1:1 model of this BM topology.  The E820 retyping
> >> in the patch is exactly what makes the guest-visible E820 match
> >> what BM firmware emits for the same kind of region.
> >>
> >> On the DIMM / device-memory alternative:  
> > 
> > wrt modeling GPU pass-through, my 1st attempt would be
> > to make -device gpu-foo take everything need to compose the device
> > (like in real hw) and be done with it (and PCI/CXL machinery would
> > take care of mapping/exposing memory to guest).
> > Why we aren't doing it?
> > 
> > barring that, and assuming we have to pass SPM as a separate memory
> > (why and why it should be exposed in E820 and at boot time only?)
> > I'd try -device foo-memory approach.
> >   
> So this isn't HBM-as-VRAM, the device-private framebuffer model
> from discrete GPUs.  It's HBM as a system memory tier under
> driver-owned allocation policy, and -numa node + memmap-type=spm
> is the direct expression of that, not a workaround layered on top.
> 
> (2) v7 is naturally compatible with stock upstream Linux dax/kmem
> 
> v7 emits E820 SOFT_RESERVED via existing machine-init, into the
> same fw_cfg blob the firmware and the guest kernel already
> consume.  The upstream kernel already understands this signal --
> dax/kmem is one such consumer in tree, picking the region up via
> the IORES_DESC_SOFT_RESERVED hook in drivers/dax/hmem/device.c.
> The accelerator's own driver discovers its HBM range from the
> same E820 + SRAT entries via dev_to_node + SRAT walk.  Neither
> side needs new code for v7.
> 
> For a memory-device-derived spm-memory device to reach the same
> dax/kmem path, it would have to inject E820 SOFT_RESERVED from
> its realize() -- which is new plumbing inside the device_memory
> subsystem.

It shouldn't be done at realize time.

Ultimately we publish E820 table at machine_done time,
and it's right time to iterate over present memory devices
and add relevant entries if necessary.
SRAT is produced even later
(effectively at runtime on 1st access to acpi tables blob),
so it can pickup memory devices at that time as well.

> That also bears on two of your other points:
> > And no need for messing with firmware (SeaBIOS: RamSizeOver4G
> > patch) nor EDK2.  
> 
> That holds only for the path where the driver doesn't go through
> E820 SOFT_RESERVED at all -- but that path needs the in-tree
> accelerator driver rewritten to walk ACPI namespace instead of
> SRAT, plus a kernel-side patch to wire ACPI memory device
> descriptors into dax/kmem.  For the e820+SRAT fallback path you
> describe as Step 3, the firmware-side requirement is identical to
> v7.
> 
> > figure out why device driver has to fetch memory map
> > and proximity from static tables as opposed to getting it dynamically
> > from _PXM -> maped-memory range. (at the time PCI devices enum runs, 
>  > all ACPI
> > info incl. run time one is fully accessible to in-kernel users)
> > i.e. try to make driver work with runtime proximity  
> 
> The current amdgpu lookup is already a runtime, PXM-keyed dynamic
> lookup -- dev_to_node(pdev) evaluates _PXM on the PCI device,
> then a SRAT memory-affinity walk matches by proximity_domain.
> PXM is the matching key; SRAT is the storage venue.  What you're
> suggesting is moving the (PXM -> range) mapping from a system-
> level table to a per-device ACPI node.  Both are populated by
> firmware at boot and queried by the driver at probe; the
> difference is which kernel subsystem reads the result.  The
> system-table choice is what keeps the CPU memory subsystem in the
> loop, per (1).
> 
> (3) The current CLI shape reflects prior maintainer alignment
> 
> The memmap-type=[normal,spm,reserved] form itself came from
> Gregory's suggestion on the v4 thread in January, where you also
> noted that AMD hardware "such memory has 1:1 mapping" -- which
> is exactly the use case this patch targets.  v6 adopted that
> naming, and v7 carries Acked-by: David and Reviewed-by: Gregory.
> 
> On the firmware side, OVMF SOFT_RESERVED handling is merged
> upstream (edk2 commit 4e90b65e7b); the SeaBIOS-side conversation
> with Gerd and Paul is converging on a small downstream knob.
> 
> So the current shape isn't a unilateral pick -- it's the form
> the review converged on, with explicit tags from David and
> Gregory and consistent firmware-side adoption.
> 
> > 
> > wrt my suggestion using memory-device.
> > It's true that the device memory region has started as hotpluggable memory.
> > But that's impl. detail, nothing fundamentally prevents us from
> > describing mix of present at boot time memory devices within it in e820/SRAT.
> >   
> > Answer to why DIMMs aren't in e820 was for us to avoid dealing with
> > linux kernel putting that memory into zone_normal instead of zone_movable.
> > On real hardware, one is likely to see all present at boot dimms, in e820
> > and SRAT.
> > For already existing memory devices, I'd like us continue dodging e820,
> > so we wouldn't break existing deployments. however for a new memory device
> > we don't have such limitations.
> > 
> > What I'd try is:
> >   1: inherit spm-memory device from memory-device
> >         (all memory mapping and APCI memory device descriptors, can be made
> >          to pick it along with DIMM devices)
> >   2: figure out why device driver has to fetch memory map
> >     and proximity from static tables as opposed to getting it dynamically
> >     from _PXM -> maped-memory range. (at the time PCI devices enum runs, all ACPI
> >     info incl. run time one is fully accessible to in-kernel users)
> >     i.e. try to make driver work with runtime proximity
> >   3. if #2 is impossible, we can try to expose SPM memory devices in e820,
> >       and partition SRAT to match actual device_memory region layout.
> > 
> >     
> (4) On the longer-term direction

that's exactly what I'm concerned about

> An spm-memory device built on memory-device infrastructure -- one
> that emits the same E820 SOFT_RESERVED + SRAT memory-affinity
> entries v7 produces today -- is a reasonable direction for a
> separate RFC in QEMU 11.2 / 12.x.  Such an RFC would close
> exactly the gap David noted earlier, that boot memory isn't
> currently modeled as a memory device on the QEMU side.
> 
> One thing that has to stay in any such direction: the SRAT
> memory-affinity emission -- without it the CPU memory subsystem
> loses visibility into HBM and the contract from (1) breaks.
> Happy to take part in that RFC when someone kicks it off, but
> it's better treated as its own work than as a gate on v7.

If we merge v7 approach, we are bound to support it for years
and if we later on we add device based variant, it will increase
support burden even more and complicate configuration, which
in turn will propagate up the stack.

Hence, I'd like possible options on the table explored 1st
before we commit to a particular approach. 

I wouldn't object much is it were a fix that we had to rush in,
but this is not the case (are we in hurry to rush this in?).

My hunch is that memory device based approach will end-up with
more straightforward and cleaner code, not to mention proper
backend/frontend modeling.

(also related to long term: ideally existing -numa 'some memory' interface,
should go away and be replaced by memory devices.
Adding more similar '-numa' options, doesn't help that case and only
increases out technical debt).


> Best regards,
> FangSheng Huang (Jerry)
> >   
> 


