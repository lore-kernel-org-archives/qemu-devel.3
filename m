Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAA4D59F67
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 21:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8nSv-0008Kc-7E; Wed, 06 Nov 2024 16:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t8nSu-0008KC-5u
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 16:21:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t8nSr-0001sX-DO
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 16:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730928079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRt0BA0gbLylgmoO8iatNIFqEwAUjYKG1tl8J7wax3I=;
 b=cu1cWjI9UbTIJ8L93wq4gfHtbfdzGTb3AAHHwYeaICeHYg5U7TMi1SBQcIbA7Vcycm1d4k
 Ne7mHpwwWRgYE6zc2LMCsXFoBUF1+ydWXwq6xR8/U9/ASYt8FILdlSHxjlOq8cPsZrOXxS
 qoY1HKHAeFn0mrTFBvAd9a3FkoIWZU8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-zid2eb-MPHad9Xzcxngydw-1; Wed, 06 Nov 2024 16:21:17 -0500
X-MC-Unique: zid2eb-MPHad9Xzcxngydw-1
X-Mimecast-MFC-AGG-ID: zid2eb-MPHad9Xzcxngydw
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b15d3cd6dcso29750485a.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 13:21:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730928077; x=1731532877;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pRt0BA0gbLylgmoO8iatNIFqEwAUjYKG1tl8J7wax3I=;
 b=jctEVpYIaPIVyjGTHsHwo0e2I8iMxFrTJplfJPy0FTyCPZdfvx0cpNeihcsf/K0zqh
 OuGFcsl6PJHXQbswEy9WfH0WFxYRwDdETTs7w9L1Z8AiaZNX0079so/bIkzTq9MDzRnj
 b9PpvrioaM6txxJXvBuX9lrFkqYwm3mCNAVJIs6Sw2Czge2gNHW59qDDTOTgt0z5kj94
 pSHBRElBnR8lrCXoEkc1R54VxMOSSmu7nlAjey9Jb4ASEB2sbYS9XH/44vvO2lnMXTDf
 NnPELS6HWR9vB3bdmA/YOfyFjf9UXybLeUVeO4s8mmCGs1NlcpVcsGNN9Zdi93bfSp/u
 3FoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1PdVm7XgggUsReNHByKOuXbBf1XT4ei6yy9sAv2fHiejpbgvrX7VkCBkPWYNOGxamxrUCnQXKvN69@nongnu.org
X-Gm-Message-State: AOJu0Yw717pJCeh0eZ04wFlbDcJK0gi3TnNr+jTlXm+Fn8WY9f6E4SEK
 IMqKgKugjt9CbBeMt/iuNjSLJYDo7gA+qwVF+C60bYkYdHcEg5TQfe73WymmNpTCPfkOPQ7yQys
 BT5wk01rxAXF2vkfcef8iLR8vygOi2XZpQfYYH21Gu7HWzNGNhV4a
X-Received: by 2002:a05:620a:4443:b0:7b1:52a9:ae1a with SMTP id
 af79cd13be357-7b2fb94e3b8mr2921495785a.4.1730928076941; 
 Wed, 06 Nov 2024 13:21:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKywvdqwpQlnH199bNvqbOI2mNKvg52ubHNgRJeHHw6Ul+JIECTxERXZLrZOF5jDmYZL7QNg==
X-Received: by 2002:a05:620a:4443:b0:7b1:52a9:ae1a with SMTP id
 af79cd13be357-7b2fb94e3b8mr2921492485a.4.1730928076517; 
 Wed, 06 Nov 2024 13:21:16 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a813a7sm673871985a.100.2024.11.06.13.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 13:21:15 -0800 (PST)
Date: Wed, 6 Nov 2024 16:21:14 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
Message-ID: <Zyvdyra7_neyE8Vz@x1n>
References: <1730468875-249970-2-git-send-email-steven.sistare@oracle.com>
 <78fa25f1-03dc-400c-a604-998c53e4fbce@redhat.com>
 <45ea8a8a-928d-4703-b698-d5f910e6a224@oracle.com>
 <1f1a2742-0429-47d5-958f-b37575c1e4ba@redhat.com>
 <c2ca740b-0178-463b-8262-b149841b8def@redhat.com>
 <bcc4cd7e-3532-475a-8989-211e80bf3eab@oracle.com>
 <09701693-436c-4e1a-8206-03eb26cacab5@redhat.com>
 <66c05a06-dbb7-49ec-b58e-ccd917d098ea@oracle.com>
 <ZyvUg3CP30f3DZYY@x1n>
 <d78a806f-4c15-4a1c-a9a4-8fb9f215a2a6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d78a806f-4c15-4a1c-a9a4-8fb9f215a2a6@oracle.com>
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

On Wed, Nov 06, 2024 at 03:59:23PM -0500, Steven Sistare wrote:
> On 11/6/2024 3:41 PM, Peter Xu wrote:
> > On Wed, Nov 06, 2024 at 03:12:20PM -0500, Steven Sistare wrote:
> > > On 11/4/2024 4:36 PM, David Hildenbrand wrote:
> > > > On 04.11.24 21:56, Steven Sistare wrote:
> > > > > On 11/4/2024 3:15 PM, David Hildenbrand wrote:
> > > > > > On 04.11.24 20:51, David Hildenbrand wrote:
> > > > > > > On 04.11.24 18:38, Steven Sistare wrote:
> > > > > > > > On 11/4/2024 5:39 AM, David Hildenbrand wrote:
> > > > > > > > > On 01.11.24 14:47, Steve Sistare wrote:
> > > > > > > > > > Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
> > > > > > > > > > on the value of the anon-alloc machine property.  This option applies to
> > > > > > > > > > memory allocated as a side effect of creating various devices. It does
> > > > > > > > > > not apply to memory-backend-objects, whether explicitly specified on
> > > > > > > > > > the command line, or implicitly created by the -m command line option.
> > > > > > > > > > 
> > > > > > > > > > The memfd option is intended to support new migration modes, in which the
> > > > > > > > > > memory region can be transferred in place to a new QEMU process, by sending
> > > > > > > > > > the memfd file descriptor to the process.  Memory contents are preserved,
> > > > > > > > > > and if the mode also transfers device descriptors, then pages that are
> > > > > > > > > > locked in memory for DMA remain locked.  This behavior is a pre-requisite
> > > > > > > > > > for supporting vfio, vdpa, and iommufd devices with the new modes.
> > > > > > > > > 
> > > > > > > > > A more portable, non-Linux specific variant of this will be using shm,
> > > > > > > > > similar to backends/hostmem-shm.c.
> > > > > > > > > 
> > > > > > > > > Likely we should be using that instead of memfd, or try hiding the
> > > > > > > > > details. See below.
> > > > > > > > 
> > > > > > > > For this series I would prefer to use memfd and hide the details.  It's a
> > > > > > > > concise (and well tested) solution albeit linux only.  The code you supply
> > > > > > > > for posix shm would be a good follow on patch to support other unices.
> > > > > > > 
> > > > > > > Unless there is reason to use memfd we should start with the more
> > > > > > > generic POSIX variant that is available even on systems without memfd.
> > > > > > > Factoring stuff out as I drafted does look quite compelling.
> > > > > > > 
> > > > > > > I can help with the rework, and send it out separately, so you can focus
> > > > > > > on the "machine toggle" as part of this series.
> > > > > > > 
> > > > > > > Of course, if we find out we need the memfd internally instead under
> > > > > > > Linux for whatever reason later, we can use that instead.
> > > > > > > 
> > > > > > > But IIUC, the main selling point for memfd are additional features
> > > > > > > (hugetlb, memory sealing) that you aren't even using.
> > > > > > 
> > > > > > FWIW, I'm looking into some details, and one difference is that shmem_open() under Linux (glibc) seems to go to /dev/shmem and memfd/SYSV go to the internal tmpfs mount. There is not a big difference, but there can be some difference (e.g., sizing of the /dev/shm mount).
> > > > > 
> > > > > Sizing is a non-trivial difference.  One can by default allocate all memory using memfd_create.
> > > > > To do so using shm_open requires configuration on the mount.  One step harder to use.
> > > > 
> > > > Yes.
> > > > 
> > > > > 
> > > > > This is a real issue for memory-backend-ram, and becomes an issue for the internal RAM
> > > > > if memory-backend-ram has hogged all the memory.
> > > > > 
> > > > > > Regarding memory-backend-ram,share=on, I assume we can use memfd if available, but then fallback to shm_open().
> > > > > 
> > > > > Yes, and if that is a good idea, then the same should be done for internal RAM
> > > > > -- memfd if available and fallback to shm_open.
> > > > 
> > > > Yes.
> > > > 
> > > > > 
> > > > > > I'm hoping we can find a way where it just all is rather intuitive, like
> > > > > > 
> > > > > > "default-ram-share=on": behave for internal RAM just like "memory-backend-ram,share=on"
> > > > > > 
> > > > > > "memory-backend-ram,share=on": use whatever mechanism we have to give us "anonymous" memory that can be shared using an fd with another process.
> > > > > > 
> > > > > > Thoughts?
> > > > > 
> > > > > Agreed, though I thought I had already landed at the intuitive specification in my patch.
> > > > > The user must explicitly configure memory-backend-* to be usable with CPR, and anon-alloc
> > > > > controls everything else.  Now we're just riffing on the details: memfd vs shm_open, spelling
> > > > > of options and words to describe them.
> > > > 
> > > > Well, yes, and making it all a bit more consistent and the "machine option" behave just like "memory-backend-ram,share=on".
> > > 
> > > Hi David and Peter,
> > > 
> > > I have implemented and tested the following, for both qemu_memfd_create
> > > and qemu_shm_alloc.  This is pseudo-code, with error conditions omitted
> > > for simplicity.
> > 
> > I'm ok with either shm or memfd, as this feature only applies to Linux
> > anyway.  I'll leave that part to you and David to decide.
> > 
> > > 
> > > Any comments before I submit a complete patch?
> > > 
> > > ----
> > > qemu-options.hx:
> > >      ``aux-ram-share=on|off``
> > >          Allocate auxiliary guest RAM as an anonymous file that is
> > >          shareable with an external process.  This option applies to
> > >          memory allocated as a side effect of creating various devices.
> > >          It does not apply to memory-backend-objects, whether explicitly
> > >          specified on the command line, or implicitly created by the -m
> > >          command line option.
> > > 
> > >          Some migration modes require aux-ram-share=on.
> > > 
> > > qapi/migration.json:
> > >      @cpr-transfer:
> > >           ...
> > >           Memory-backend objects must have the share=on attribute, but
> > >           memory-backend-epc is not supported.  The VM must be started
> > >           with the '-machine aux-ram-share=on' option.
> > > 
> > > Define RAM_PRIVATE
> > > 
> > > Define qemu_shm_alloc(), from David's tmp patch
> > > 
> > > ram_backend_memory_alloc()
> > >      ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
> > >      memory_region_init_ram_flags_nomigrate(ram_flags)
> > 
> > Looks all good until here.
> > 
> > > 
> > > qemu_ram_alloc_internal()
> > >      ...
> > >      if (!host && !(ram_flags & RAM_PRIVATE) && current_machine->aux_ram_share)
> > 
> > Nitpick: could rely on flags-only, rather than testing "!host", AFAICT
> > that's equal to RAM_PREALLOC.
> 
> IMO testing host is clearer and more future proof, regardless of how flags
> are currently used.  If the caller passes host, then we should not allocate
> memory here, full stop.
> 
> > Meanwhile I slightly prefer we don't touch
> > anything if SHARED|PRIVATE is set.
> 
> OK, if SHARED is already set I will not set it again.
> 
> > All combined, it could be:
> > 
> >      if (!(ram_flags & (RAM_PREALLOC | RAM_PRIVATE | RAM_SHARED))) {
> >          // ramblock to be allocated, with no share/private request, aka,
> >          // aux memory chunk...
> >      }
> > 
> > >          new_block->flags |= RAM_SHARED;
> > > 
> > >      if (!host && (new_block->flags & RAM_SHARED)) {
> > >          qemu_ram_alloc_shared(new_block);
> > 
> > I'm not sure whether this needs its own helper.
> 
> Reserve judgement until you see the full patch.  The helper is a
> non-trivial subroutine and IMO it improves readability.  Also the
> cpr find/save hooks are confined to the subroutine.

I thought we can use the same code path to process "aux ramblock" and all
kinds of other RAM_SHARED ramblocks.  IIUC cpr find/save should apply there
too, but maybe I missed something.

> 
> > Should we fallback to
> > ram_block_add() below, just like a RAM_SHARED?
> 
> I thought we all discussed and agreed that the allocation should be performed
> above ram_block_add.  David's suggested patch does it here also.

I was not closely followed all the discussions happened.. so I could have
missed something indeed.

One thing I want to double check is cpr will still make things like below
work, right?

  -object memory-backend-ram,share=on [1]

IIUC with the old code this won't create fd, so to make cpr work (and also
what I was trying to say in the previous email..) is we could silently
start to create memfds for these, which means we need to first teach
qemu_anon_ram_alloc() on creating memfd for RAM_SHARED and cache these fds
(which should hopefully keep the same behavior as before).

Then for aux ramblocks like ROMs, as long as it sets RAM_SHARED properly in
qemu_ram_alloc_internal() (but only when aux-share-mem=on, for sure..),
then the rest code path in ram_block_add() should be the same as when user
specified share=on in [1].

Anyway, if both of you agreed on it, I am happy to wait and read the whole
patch.

Side note: I'll still use a few days for other things, but I'll get back to
read this whole series before next week.. btw, this series does not depend
on precreate phase now, am I right?

> 
> - Steve
> 
> > IIUC, we could start to create RAM_SHARED in qemu_anon_ram_alloc() and
> > always cache the fd (even if we don't do that before)?
> > 
> > >      } else
> > >          new_block->fd = -1;
> > >          new_block->host = host;
> > >      }
> > >      ram_block_add(new_block);
> > > 
> > > qemu_ram_alloc_shared()
> > >      if qemu_memfd_check()
> > >          new_block->fd = qemu_memfd_create()
> > >      else
> > >          new_block->fd = qemu_shm_alloc()
> > >      new_block->host = file_ram_alloc(new_block->fd)
> > > ----
> > > 
> > > - Steve
> > > 
> > 
> 

-- 
Peter Xu


