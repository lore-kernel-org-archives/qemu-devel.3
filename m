Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC07C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQAs-0007Ro-4u; Tue, 18 Feb 2025 11:10:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tkQAo-0007QH-Sw
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:10:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tkQAm-0006wG-7O
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739895010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Wdo9d1ANnBCo+/gLLTKI7BQXI6Su6vcINsTE9viuWw=;
 b=PHrY3om+91fsXhyzuKVVnIEUuiX0gUFxoUmN8Mt+olsZgONRzNdNLza2ObCn0Yu2xKB313
 3qKzjELHfdp5ToJXIaVIsWU4Y7RBe4jeXcq5pFSv7i4/Nt5QsRxsAW2jNo2/YDCAMuuQqg
 LYMRG06fL0NMKdUTO1b3lKO93JD5tJg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-eQz0Bu57NiqbfC3uq8zvRA-1; Tue, 18 Feb 2025 11:10:09 -0500
X-MC-Unique: eQz0Bu57NiqbfC3uq8zvRA-1
X-Mimecast-MFC-AGG-ID: eQz0Bu57NiqbfC3uq8zvRA_1739895008
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-471d66d2a89so76560391cf.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:10:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739895008; x=1740499808;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Wdo9d1ANnBCo+/gLLTKI7BQXI6Su6vcINsTE9viuWw=;
 b=guXYpiGJb52TdojXqgGIaMymDolt5Cng9lRlEPWyCMybnHNjunEIDmfQM7jc5qzuW8
 rw6dPpIfcT6pq05WsVB+17W8oEL868rPZ/Y+G3mpnCEb0RTTzgYeRpi1/vAHvZq0lSLK
 EqSG2LNXvxt7qyL1jle/FV4MThxJLqBAFghIzOf7YmePCAr+UqFJzwo8CEPYlAuduo2a
 hd6XDYZf2P1NY9B93xAvzoeEKAWXRvq/j4sr4YH3c3v60EDg8A9fs97NEgiLPxvz5gM0
 COFOQnnODDRbnpppREngLtfTo6TTzAhwd9usBiEq9Y0hTr5lIG24H9u1Hy/9fJ71mKJL
 cVIw==
X-Gm-Message-State: AOJu0YypzZ7TW4e9RGistjCNxvSvTAYyV1WvBgViUmjILAOsfk2wt0hH
 UpeTBh5QXgHAug4cWdLxbXvU3ol8lxkmZ3AYuwUCeUtgNBnCi0udZyUa0tMbpOsji1Kf8Bl7WrP
 J6Z6EUDTbITYzahxHsyQm4P2Cu0h92DcPOVexCMKkpMMcp7rTlfEm
X-Gm-Gg: ASbGncvfoIip9O+3xt5WuAUDqIDGKw9KeC1BzAMDLo5T9qtxdtcI+8v/WGMF1VhVWO4
 0AGRbR0+wNsx8NqhB6hFArnnQnkPDXrAOa59PcgvykyDioxDM7uUKcQ+Xw3WuniCzZT70JD+Yqr
 XaqLhBmKG/0m27A76NjUYTMXvvH4D9mcWGcP+qmxS2juMOgIWCsMNeQfNnMwq2ILLusCtok9+Xe
 TAsp08UbcrxtLwNJsPevtRhR3hcShch3qY5VSoYrxcBs4b1DukM1XLRE9Q=
X-Received: by 2002:a05:622a:282:b0:472:6ed:a7c5 with SMTP id
 d75a77b69052e-47206edab2bmr16624601cf.14.1739895008510; 
 Tue, 18 Feb 2025 08:10:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsNv8zpOoq4cJTvIfn5BRBYunzyX93i8HWFaYDOlWJ7Ht5fZs9VvdNly6wEAJQUYzX2edxxQ==
X-Received: by 2002:a05:622a:282:b0:472:6ed:a7c5 with SMTP id
 d75a77b69052e-47206edab2bmr16623821cf.14.1739895007785; 
 Tue, 18 Feb 2025 08:10:07 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-471f10a035esm23711951cf.75.2025.02.18.08.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 08:10:06 -0800 (PST)
Date: Tue, 18 Feb 2025 11:10:03 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] migration: ram block cpr blockers
Message-ID: <Z7Sw228UUsmGD3_t@x1.local>
References: <1737135971-132839-1-git-send-email-steven.sistare@oracle.com>
 <Z4qelNxnBcgO87go@x1n>
 <814d9205-8ba5-48a8-9940-6f16bbb097eb@oracle.com>
 <Z4ruhpH28-GnnTq7@x1n>
 <20674b54-3c88-4d2c-a590-3b0ddaff86f9@oracle.com>
 <Z5uwUNtYhQfJJlg3@x1.local>
 <f1f1c640-367d-4966-93f5-a98e3b764e28@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1f1c640-367d-4966-93f5-a98e3b764e28@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Feb 14, 2025 at 03:12:22PM -0500, Steven Sistare wrote:
> On 1/30/2025 12:01 PM, Peter Xu wrote:
> > On Wed, Jan 29, 2025 at 01:20:13PM -0500, Steven Sistare wrote:
> > > On 1/17/2025 6:57 PM, Peter Xu wrote:
> > > > On Fri, Jan 17, 2025 at 02:10:14PM -0500, Steven Sistare wrote:
> > > > > On 1/17/2025 1:16 PM, Peter Xu wrote:
> > > > > > On Fri, Jan 17, 2025 at 09:46:11AM -0800, Steve Sistare wrote:
> > > > > > > +/*
> > > > > > > + * Return true if ram contents would be lost during CPR.
> > > > > > > + * Return false for ram_device because it is remapped in new QEMU.  Do not
> > > > > > > + * exclude rom, even though it is readonly, because the rom file could change
> > > > > > > + * in new QEMU.  Return false for non-migratable blocks.  They are either
> > > > > > > + * re-created in new QEMU, or are handled specially, or are covered by a
> > > > > > > + * device-level CPR blocker.  Return false for an fd, because it is visible and
> > > > > > > + * can be remapped in new QEMU.
> > > > > > > + */
> > > > > > > +static bool ram_is_volatile(RAMBlock *rb)
> > > > > > > +{
> > > > > > > +    MemoryRegion *mr = rb->mr;
> > > > > > > +
> > > > > > > +    return mr &&
> > > > > > > +        memory_region_is_ram(mr) &&
> > > > > > > +        !memory_region_is_ram_device(mr) &&
> > > > > > > +        (!qemu_ram_is_shared(rb) || !qemu_ram_is_named_file(rb)) &&
> > > > > > > +        qemu_ram_is_migratable(rb) &&
> > > > > > > +        rb->fd < 0;
> > > > > > > +}
> > > > > > 
> > > > > > Blocking guest_memfd looks ok, but comparing to add one more block
> > > > > > notifier, can we check all ramblocks once in migrate_prepare(), and fail
> > > > > > that command directly if it fails the check?
> > > > > 
> > > > > In an upcoming patch, I will be adding an option analogous to only-migratable which
> > > > > prevents QEMU from starting if anything would block cpr-transfer.  That option
> > > > > will be checked when blockers are added, like for only-migratable. migrate_prepare
> > > > > is too late.
> > > > > 
> > > > > > OTOH, is there any simpler way to simplify the check conditions?  It'll be
> > > > > > at least nice to break these checks into smaller if conditions for
> > > > > > readability..
> > > > > 
> > > > > I thought the function header comments made it clear, but I could move each
> > > > > comment next to each condition:
> > > > > 
> > > > >       ...
> > > > >       /*
> > > > >        * Return false for an fd, because it is visible and can be remapped in
> > > > >        * new QEMU.
> > > > >        */
> > > > >       if (rb->fd >= 0) {
> > > > >           return false;
> > > > >       }
> > > > >       ...
> > > > > 
> > > > > > I wonder if we could stick with looping over all ramblocks, then make sure
> > > > > > each of them is on the cpr saved fd list.  It may need to make
> > > > > > cpr_save_fd() always register with the name of ramblock to do such lookup,
> > > > > > or maybe we could also cache the ramblock pointer in CprFd, then the lookup
> > > > > > will be a pointer match check.
> > > > > 
> > > > > Some ramblocks are not on the list, such as named files.  Plus looping in
> > > > > migrate_prepare is too late as noted above.
> > > > > 
> > > > > IMO what I have already implemented using blockers is clean and elegant.
> > > > 
> > > > OK if we need to fail it early at boot, then yes blockers are probably
> > > > better.
> > > > 
> > > > We'll need one more cmdline parameter. I've no objection, but I don't know
> > > > how to judge when it's ok to add, when it's better not.. I'll leave others
> > > > to comment on this.
> > > > 
> > > > But still, could we check it when ramblocks are created?  So in that way
> > > > whatever is forbidden is clear in its own path, I feel like that could be
> > > > clearer (like what you did with gmemfd).
> > > 
> > > When the ramblock is created, we don't yet know if it is migratable. A
> > > ramblock that is not migratable does not block cpr. Migratable is not known
> > > until vmstate_register_ram calls qemu_ram_set_migratable.  Hence that is
> > > where I evaluate conditions and install a blocker.
> > > 
> > > Because that is the only place where ram_block_add_cpr_blocker is called,
> > > the test qemu_ram_is_migratable() inside ram_block_add_cpr_blocker is
> > > redundant, and I should delete it.
> > 
> > Hmm.. sounds reasonable.
> > 
> > > 
> > > > For example, if I start to convert some of your requirements above, then
> > > > memory_region_is_ram_device() implies RAM_PREALLOC.  Actually, ram_device
> > > > is not the only RAM_PREALLOC user..  Say, would it also not work with all
> > > > memory_region_init_ram_ptr() users (even if they're not ram_device)?  An
> > > > example is, looks like virtio-gpu can create random ramblocks on the fly
> > > > with prealloced buffers.  I am not sure whether they can be pinned by VFIO
> > > > too.  You may know better.
> > > 
> > > That memory is not visible to the guest.  It is not part of system_memory,
> > > and is not marked migratable.
> > 
> > I _think_ that can still be visible at least for the virtio-gpu use case,
> > which hangs under VirtIOGPUBase.hostmem.  Relevant code for reference:
> > 
> > virtio_gpu_virgl_map_resource_blob:
> >      memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
> >      memory_region_add_subregion(&b->hostmem, offset, mr);
> >      memory_region_set_enabled(mr, true);

[1]

> > 
> > virtio_gpu_pci_base_realize:
> >          memory_region_init(&g->hostmem, OBJECT(g), "virtio-gpu-hostmem",
> >                             g->conf.hostmem);
> >          pci_register_bar(&vpci_dev->pci_dev, 4,
> >                           PCI_BASE_ADDRESS_SPACE_MEMORY |
> >                           PCI_BASE_ADDRESS_MEM_PREFETCH |
> >                           PCI_BASE_ADDRESS_MEM_TYPE_64,
> >                           &g->hostmem);

[2]

> > 
> > pci_update_mappings:
> >              memory_region_add_subregion_overlap(r->address_space,
> >                                                  r->addr, r->memory, 1);

[3]

> > 
> > but indeed I'm not sure how it work with migration so far, because it
> > doesn't have RAM_MIGRATABLE set. So at least cpr didn't make it more
> > special.  I assume this isn't something we must figure out as of now
> > then.. but if you do, please kindly share.
> 
> AFAICT this memory cannot be pinned, because it is not attached to the
> "system_memory" mr and the "address_space_memory" address space.  The
> listener than maps/pins is attached to address_space_memory.

I still think it's part of system_memory - every PCI bar that got mapped as
MMIO regions could be part of guest system memory, and IIUC could be
pinned.

Normally these MMIOs are IO regions so "pinning" may not make much
difference IIUC, but here looks like it's real RAM backing it when
emulated, even though they're "MMIO regions"..

Above code clips are paths that I think how they got attached to
system_memory.  It isn't more special than a generic PCI device's bars got
mapped to system_memory, though:

  - Firstly, at [1], the blob is part of VirtIOGPUBase.hostmem as subregion

  - Then, at [2], the VirtIOGPUBase.hostmem is registered as a pci bar, in
    this case, it's BAR4.

  - Then, it's the same as other pci device BARs where they can logically
    be mapped into guest physical address space and be part of system_memory.
    Above [3] was when the bar memory got added into PCIIORegion.address_space.

Then if to fill up the last missing piece: taking i440fx as example,
ultimately the pci bus memory address space will be attached to
system_memory here:

i440fx_pcihost_realize:
    /* setup pci memory mapping */
    pc_pci_as_mapping_init(s->system_memory, s->pci_address_space);

Again, not requesting to resolve this immediately: I have no idea how
migration works at all with random new ramblocks being added.. but I'd
still like to check we're on the same page on this specific case, though.

-- 
Peter Xu


