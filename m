Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E710D5C0C5
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 13:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9PHQ-0003Oc-4H; Fri, 08 Nov 2024 08:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t9PHO-0003OM-To
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 08:44:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t9PHL-00040F-Do
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 08:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731073435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dme+fvSu0MRQAoJZoBC3yNQnG3S9XM0beO6PezJF42M=;
 b=X4b+IjfxCgKPkWx+C35+RZQzVdHK5TtWXkewHpgKiq/DKkSCZpZOUbsO5OEws4jS1/MCZQ
 TdAOcbwPzn6CFMMjDgoCeP2Vt273MyON+eQJfzjTZDZ8u3pXA+dWh2jz3Hj1F1jK357Tnl
 LfeG3cBDpfFZ6bhYeo/dElDCPTggTrM=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-HRbN3GiTPZGjBSfUR5zWjg-1; Fri, 08 Nov 2024 08:43:51 -0500
X-MC-Unique: HRbN3GiTPZGjBSfUR5zWjg-1
X-Mimecast-MFC-AGG-ID: HRbN3GiTPZGjBSfUR5zWjg
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-718163ef43dso1558391a34.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 05:43:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731073430; x=1731678230;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dme+fvSu0MRQAoJZoBC3yNQnG3S9XM0beO6PezJF42M=;
 b=rtLs4aHKtQzATjcQXQsCvqJnMUHe7L50ONpmKlTnki6VknSwprixhLWAN4AKYwPlRZ
 j14DZgwRYzbgX+nnFNgKe887V7fnlJhZxof9zHRZJ2HNh3+p28Gm8xGcboYKJSktgUdk
 i3f3U1uDFN8yH+MoTcsRmVmQyxwwQkiVPi0cnMVypQ/WmIc4x7HCsPejJTbaPodUsLY+
 KYQf28hm1u9crMXw2FW147hiGgZyGXB8JfPGzH/XWWOYos6O1NZs5LQldknafsdif/eh
 amNg+rrDx0u9mwLt19zPDKXxjQy0LfUhoAWidefzL78LEboLIujHOcvQrEZ0lc2i7Q1l
 AuFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfFyme9USjArrMJw+4P8y0Brb5mqkg1swQV/hILEnJWPUXny64sNYcLS0Y3so8ccvldVh1U7/eKQdO@nongnu.org
X-Gm-Message-State: AOJu0YwCrcaCCiw0lGJhjn6ogsTwUR6hZNv41YLOssr0NTUbmc9v9NC9
 ypgxYqoGWVF/O8tpTZsPknB8lVVsedHNqrG2g3mN/bZdqD0/E9HDrRG5Lxi2h3bWfoP8U86wyeD
 f8ItQWeo6ycs+huWLgOYL42aKr9WZlDJfbf5kFMLZw543gKUz2QNC
X-Received: by 2002:a05:6830:d02:b0:718:ef7:ff7d with SMTP id
 46e09a7af769-71a1c1e0edemr3304422a34.1.1731073430532; 
 Fri, 08 Nov 2024 05:43:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtcs6IMfSH0pMzBSFJNKEBRwZW9bNv8lRidIJOVTQ9JmnIuoTNLPlr4thhDJIkG1ZjfFSbew==
X-Received: by 2002:a05:6830:d02:b0:718:ef7:ff7d with SMTP id
 46e09a7af769-71a1c1e0edemr3304356a34.1.1731073429983; 
 Fri, 08 Nov 2024 05:43:49 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ee4952724dsm661382eaf.21.2024.11.08.05.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 05:43:49 -0800 (PST)
Date: Fri, 8 Nov 2024 08:43:45 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
Message-ID: <Zy4VkScMEpYayGtM@x1n>
References: <1f1a2742-0429-47d5-958f-b37575c1e4ba@redhat.com>
 <c2ca740b-0178-463b-8262-b149841b8def@redhat.com>
 <bcc4cd7e-3532-475a-8989-211e80bf3eab@oracle.com>
 <09701693-436c-4e1a-8206-03eb26cacab5@redhat.com>
 <66c05a06-dbb7-49ec-b58e-ccd917d098ea@oracle.com>
 <053dd9b6-e4f7-41c8-abe9-ed02214f0639@redhat.com>
 <cce158c4-3bb1-4771-b2c5-f3ae8a2285d5@oracle.com>
 <5b192b5e-943c-4b2f-ab40-ef54ea578363@redhat.com>
 <00261b15-3eef-439a-8501-574e3bb50d95@oracle.com>
 <d00ab1a4-2b72-4202-b810-adeb53a16f01@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d00ab1a4-2b72-4202-b810-adeb53a16f01@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On Fri, Nov 08, 2024 at 12:31:45PM +0100, David Hildenbrand wrote:
> On 07.11.24 17:40, Steven Sistare wrote:
> > On 11/7/2024 11:26 AM, David Hildenbrand wrote:
> > > On 07.11.24 17:02, Steven Sistare wrote:
> > > > On 11/7/2024 8:23 AM, David Hildenbrand wrote:
> > > > > On 06.11.24 21:12, Steven Sistare wrote:
> > > > > > On 11/4/2024 4:36 PM, David Hildenbrand wrote:
> > > > > > > On 04.11.24 21:56, Steven Sistare wrote:
> > > > > > > > On 11/4/2024 3:15 PM, David Hildenbrand wrote:
> > > > > > > > > On 04.11.24 20:51, David Hildenbrand wrote:
> > > > > > > > > > On 04.11.24 18:38, Steven Sistare wrote:
> > > > > > > > > > > On 11/4/2024 5:39 AM, David Hildenbrand wrote:
> > > > > > > > > > > > On 01.11.24 14:47, Steve Sistare wrote:
> > > > > > > > > > > > > Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
> > > > > > > > > > > > > on the value of the anon-alloc machine property.  This option applies to
> > > > > > > > > > > > > memory allocated as a side effect of creating various devices. It does
> > > > > > > > > > > > > not apply to memory-backend-objects, whether explicitly specified on
> > > > > > > > > > > > > the command line, or implicitly created by the -m command line option.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > The memfd option is intended to support new migration modes, in which the
> > > > > > > > > > > > > memory region can be transferred in place to a new QEMU process, by sending
> > > > > > > > > > > > > the memfd file descriptor to the process.  Memory contents are preserved,
> > > > > > > > > > > > > and if the mode also transfers device descriptors, then pages that are
> > > > > > > > > > > > > locked in memory for DMA remain locked.  This behavior is a pre-requisite
> > > > > > > > > > > > > for supporting vfio, vdpa, and iommufd devices with the new modes.
> > > > > > > > > > > > 
> > > > > > > > > > > > A more portable, non-Linux specific variant of this will be using shm,
> > > > > > > > > > > > similar to backends/hostmem-shm.c.
> > > > > > > > > > > > 
> > > > > > > > > > > > Likely we should be using that instead of memfd, or try hiding the
> > > > > > > > > > > > details. See below.
> > > > > > > > > > > 
> > > > > > > > > > > For this series I would prefer to use memfd and hide the details.  It's a
> > > > > > > > > > > concise (and well tested) solution albeit linux only.  The code you supply
> > > > > > > > > > > for posix shm would be a good follow on patch to support other unices.
> > > > > > > > > > 
> > > > > > > > > > Unless there is reason to use memfd we should start with the more
> > > > > > > > > > generic POSIX variant that is available even on systems without memfd.
> > > > > > > > > > Factoring stuff out as I drafted does look quite compelling.
> > > > > > > > > > 
> > > > > > > > > > I can help with the rework, and send it out separately, so you can focus
> > > > > > > > > > on the "machine toggle" as part of this series.
> > > > > > > > > > 
> > > > > > > > > > Of course, if we find out we need the memfd internally instead under
> > > > > > > > > > Linux for whatever reason later, we can use that instead.
> > > > > > > > > > 
> > > > > > > > > > But IIUC, the main selling point for memfd are additional features
> > > > > > > > > > (hugetlb, memory sealing) that you aren't even using.
> > > > > > > > > 
> > > > > > > > > FWIW, I'm looking into some details, and one difference is that shmem_open() under Linux (glibc) seems to go to /dev/shmem and memfd/SYSV go to the internal tmpfs mount. There is not a big difference, but there can be some difference (e.g., sizing of the /dev/shm mount).
> > > > > > > > 
> > > > > > > > Sizing is a non-trivial difference.  One can by default allocate all memory using memfd_create.
> > > > > > > > To do so using shm_open requires configuration on the mount.  One step harder to use.
> > > > > > > 
> > > > > > > Yes.
> > > > > > > 
> > > > > > > > 
> > > > > > > > This is a real issue for memory-backend-ram, and becomes an issue for the internal RAM
> > > > > > > > if memory-backend-ram has hogged all the memory.
> > > > > > > > 
> > > > > > > > > Regarding memory-backend-ram,share=on, I assume we can use memfd if available, but then fallback to shm_open().
> > > > > > > > 
> > > > > > > > Yes, and if that is a good idea, then the same should be done for internal RAM
> > > > > > > > -- memfd if available and fallback to shm_open.
> > > > > > > 
> > > > > > > Yes.
> > > > > > > 
> > > > > > > > 
> > > > > > > > > I'm hoping we can find a way where it just all is rather intuitive, like
> > > > > > > > > 
> > > > > > > > > "default-ram-share=on": behave for internal RAM just like "memory-backend-ram,share=on"
> > > > > > > > > 
> > > > > > > > > "memory-backend-ram,share=on": use whatever mechanism we have to give us "anonymous" memory that can be shared using an fd with another process.
> > > > > > > > > 
> > > > > > > > > Thoughts?
> > > > > > > > 
> > > > > > > > Agreed, though I thought I had already landed at the intuitive specification in my patch.
> > > > > > > > The user must explicitly configure memory-backend-* to be usable with CPR, and anon-alloc
> > > > > > > > controls everything else.  Now we're just riffing on the details: memfd vs shm_open, spelling
> > > > > > > > of options and words to describe them.
> > > > > > > 
> > > > > > > Well, yes, and making it all a bit more consistent and the "machine option" behave just like "memory-backend-ram,share=on".
> > > > > > 
> > > > > > Hi David and Peter,
> > > > > > 
> > > > > > I have implemented and tested the following, for both qemu_memfd_create
> > > > > > and qemu_shm_alloc.  This is pseudo-code, with error conditions omitted
> > > > > > for simplicity.
> > > > > > 
> > > > > > Any comments before I submit a complete patch?
> > > > > > 
> > > > > > ----
> > > > > > qemu-options.hx:
> > > > > >         ``aux-ram-share=on|off``
> > > > > >             Allocate auxiliary guest RAM as an anonymous file that is
> > > > > >             shareable with an external process.  This option applies to
> > > > > >             memory allocated as a side effect of creating various devices.
> > > > > >             It does not apply to memory-backend-objects, whether explicitly
> > > > > >             specified on the command line, or implicitly created by the -m
> > > > > >             command line option.
> > > > > > 
> > > > > >             Some migration modes require aux-ram-share=on.
> > > > > > 
> > > > > > qapi/migration.json:
> > > > > >         @cpr-transfer:
> > > > > >              ...
> > > > > >              Memory-backend objects must have the share=on attribute, but
> > > > > >              memory-backend-epc is not supported.  The VM must be started
> > > > > >              with the '-machine aux-ram-share=on' option.
> > > > > > 
> > > > > > Define RAM_PRIVATE
> > > > > > 
> > > > > > Define qemu_shm_alloc(), from David's tmp patch
> > > > > > 
> > > > > > ram_backend_memory_alloc()
> > > > > >         ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
> > > > > >         memory_region_init_ram_flags_nomigrate(ram_flags)
> > > > > > 
> > > > > > qemu_ram_alloc_internal()
> > > > > >         ...
> > > > > >         if (!host && !(ram_flags & RAM_PRIVATE) && current_machine->aux_ram_share)
> > > > > >             new_block->flags |= RAM_SHARED;
> > > > > > 
> > > > > >         if (!host && (new_block->flags & RAM_SHARED)) {
> > > > > >             qemu_ram_alloc_shared(new_block);
> > > > > >         } else
> > > > > >             new_block->fd = -1;
> > > > > >             new_block->host = host;
> > > > > >         }
> > > > > >         ram_block_add(new_block);
> > > > > > 
> > > > > > qemu_ram_alloc_shared()
> > > > > >         if qemu_memfd_check()
> > > > > >             new_block->fd = qemu_memfd_create()
> > > > > >         else
> > > > > >             new_block->fd = qemu_shm_alloc()
> > > > > 
> > > > > Yes, that way "memory-backend-ram,share=on" will just mean "give me the best shared memory for RAM to be shared with other processes, I don't care about the details", and it will work on Linux kernels even before we had memfds.
> > > > > 
> > > > > memory-backend-ram should be available on all architectures, and under Windows. qemu_anon_ram_alloc() under Linux just does nothing special, not even bail out.
> > > > > 
> > > > > MAP_SHARED|MAP_ANON was always weird, because it meant "give me memory I can share only with subprocesses", but then, *there are not subprocesses for QEMU*. I recall there was a trick to obtain the fd under Linux for these regions using /proc/self/fd/, but it's very Linux specific ...
> > > > > 
> > > > > So nobody would *actually* use that shared memory and it was only a hack for RDMA. Now we can do better.
> > > > > 
> > > > > 
> > > > > We'll have to decide if we simply fallback to qemu_anon_ram_alloc() if no shared memory can be created (unavailable), like we do on Windows.
> > > > > 
> > > > > So maybe something like
> > > > > 
> > > > > qemu_ram_alloc_shared()
> > > > >        fd = -1;
> > > > > 
> > > > >        if (qemu_memfd_avilable()) {
> > > > >            fd = qemu_memfd_create();
> > > > >            if (fd < 0)
> > > > >                ... error
> > > > >        } else if (qemu_shm_available())
> > > > >            fd = qemu_shm_alloc();
> > > > >            if (fd < 0)
> > > > >                ... error
> > > > >        } else {
> > > > >            /*
> > > > >             * Old behavior: try fd-less shared memory. We might
> > > > >             * just end up with non-shared memory on Windows, but
> > > > >             * nobody can make sure of this shared memory either way
> > > > >             * ... should we just use non-shared memory? Or should
> > > > >             * we simply bail out? But then, if there is no shared
> > > > >             * memory nobody could possible use it.
> > > > >             */
> > > > >            qemu_anon_ram_alloc(share=true)
> > > > >        }
> > > > 
> > > > Good catch.  We need that fallback for backwards compatibility.  Even with
> > > > no use case for memory-backend-ram,share=on since the demise of rdma, users
> > > > may specify it on windows, for no particular reason, but it works, and should
> > > > continue to work after this series.  CPR would be blocked.
> > > 
> > > Yes, we should keep Windows working in the weird way it is working right now.
> > > 
> > >   > > More generally for backwards compatibility for share=on for no particular reason,
> > > > should we fallback if qemu_shm_alloc fails?  If /dev/shm is mounted with default
> > > > options and more than half of ram is requested, it will fail, whereas current qemu
> > > > succeeds using MAP_SHARED|MAP_ANON.
> > > 
> > > Only on Linux without memfd, of course. Maybe we should just warn when qemu_shm_alloc() fails (and comment that we continue for compat reasons only) and fallback to the stupid qemu_anon_ram_alloc(share=true). We could implement a fallback to shmget() but ... let's not go down that path.
> > > 
> > > But we should not fallback to qemu_shm_alloc()/MAP_SHARED|MAP_ANON if memfd is available and that allocating the memfd failed. Failing to allocate a memfd might highlight a bigger problem.
> > 
> > Agreed on all.
> > 
> > One more opinion from you please, if you will.
> > 
> > RAM_PRIVATE is only checked in qemu_ram_alloc_internal, and only needs to be
> > set in
> >     ram_backend_memory_alloc -> ... -> qemu_ram_alloc_internal
> > 
> > None of the other backends reach qemu_ram_alloc_internal.
> > 
> > To be future proof, do you prefer I also set MAP_PRIVATE in the other backends,
> > everywhere MAP_SHARED may be set, eg:
> 
> Hm, I think then we should set RAM_PRIVATE really everywhere where we'd want
> it and relied on !RAM_SHARED doing the right thing.
> 
> Alternatively, we make our life easier and do something like
> 
> /*
>  * This flag is only used while creating+allocating RAM, and
>  * prevents RAM_SHARED getting set for anonymous RAM automatically in
>  * some configurations.
>  *
>  * By default, not setting RAM_SHARED on anonymous RAM implies
>  * "private anonymous RAM"; however, in some configuration we want to
>  * have most of this RAM automatically be "sharable anonymous RAM",
>  * except for some cases that really want "private anonymous RAM".
>  *
>  * This anonymous RAM *must* be private. This flag only applies to
>  * "anonymous" RAM, not fd/file-backed/preallocated one.
>  */
> RAM_FORCE_ANON_PRIVATE	(1 << 13)
> 
> 
> BUT maybe an even better alternative now that we have the "aux-ram-share"
> parameter, could we use
> 
> /*
>  * Auxiliary RAM that was created automatically internally, instead of
>  * explicitly like using memory-backend-ram or some other device on the
>  * QEMU cmdline.
>  */
> RAM_AUX	(1 << 13)
> 
> 
> So it will be quite clear that "aux-ram-share" only applies to RAM_AUX
> RAMBlocks.
> 
> That actually looks quite compelling to me :)

Could anyone remind me why we can't simply set PRIVATE|SHARED all over the
place?

IMHO RAM_AUX is too hard for any new callers to know how to set.  It's much
easier when we already have SHARED, adding PRIVATE could be mostly natural,
then we can already avoid AUX due to checking !SHARED & !PRIVATE.

Basically, SHARED|PRIVATE then must come from an user request (QMP or
cmdline), otherwise the caller should always set none of them, implying
aux.

It still looks the best to me.

Thanks,

-- 
Peter Xu


