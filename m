Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5B3D4337C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 16:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t95RL-0008K0-Md; Thu, 07 Nov 2024 11:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t95RJ-0008CI-Os
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:32:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t95RD-0004aP-Nn
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730997170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m6lPAQttqT0gsCdCEh7D1I6TC1VEiAic1qbw3MoYoFI=;
 b=F7LMpseZmTc9LOSrV/Mc1XrFWcceDi1PPccGvB1Ge3Np0kf0mo+XjaRY+7V4xIC4ZQmKZv
 DeoWnlqSX2FllHFTXEiIjxWoadtPlxNrGVDowhoTfv8/lWRTO1YGvmURHDUt4BLOorj4es
 V276bypk4ngGpdj9K4nX6BhEG0iOd2U=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-ZK7iXei2Ny-KRV9JNR4_bA-1; Thu, 07 Nov 2024 11:32:49 -0500
X-MC-Unique: ZK7iXei2Ny-KRV9JNR4_bA-1
X-Mimecast-MFC-AGG-ID: ZK7iXei2Ny-KRV9JNR4_bA
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d3672225b1so14715686d6.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 08:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730997168; x=1731601968;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m6lPAQttqT0gsCdCEh7D1I6TC1VEiAic1qbw3MoYoFI=;
 b=R35/nqkNFYNiJ29ORupNGfr1uTEla004VMxzmZtv3q6Vw/iaQUvTr6Y5vxsZFtsVgz
 6WvFeB2bGDwrF52xerQndC1qvpV/aRlT7YBGEQdyhTLFAhQ7wRQFydvxUDKnCRpmStIc
 mriAHsyhwqqD61EwCahHK3ZgcfpHSiozAMHQt3hOxDm6Y2OzUpVB6ssitZAsUmioJBX0
 WQ9UboQaPFNbclsqnd1c7i3h5kZlyhHUEAqbRSexsWCEtrowoxseT6EOmrdFQieTxuYs
 6OfJNXiBwekBGZE28jltN3GarSzjhpFrNg3IHglettW0U9Xt5ZevM/DssismhvSRHCyq
 JMYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbg1X+nbvX2XZisFAYReZBz9hq4jOGtjRt1yxLvshyuO/sELn/nvGxKRkbldiNy8EUXwPSqJePk3au@nongnu.org
X-Gm-Message-State: AOJu0YyBkhqs+dSisO563IKQpcLC1EEcUJKm/j9sXWcMXEZCVKyRiuoE
 NFXknfyJGgAzMTK/hNsT1oKEhMgjkVVqpEhkC+7UWEF7Z/nD+N2+/QrrbeZRMtGP4bkWKyxbYnz
 3r6c4rV1L9Iy10YPlLJvfJbiAxESKus1AfU8QtVFLzNusmqkN2siJ
X-Received: by 2002:a05:6214:2f84:b0:6cc:2cd6:24 with SMTP id
 6a1803df08f44-6d35c199932mr307107796d6.36.1730997167129; 
 Thu, 07 Nov 2024 08:32:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9Jq7BPNSS/JrL5gYkP6Mk9bnDOAQBCb6JzeKa9Ph9NJQ9FjAVj0eg7xpY63v3Q1nT97BiNQ==
X-Received: by 2002:a05:6214:2f84:b0:6cc:2cd6:24 with SMTP id
 6a1803df08f44-6d35c199932mr307105766d6.36.1730997165218; 
 Thu, 07 Nov 2024 08:32:45 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d39643b384sm9198016d6.91.2024.11.07.08.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 08:32:44 -0800 (PST)
Date: Thu, 7 Nov 2024 11:32:42 -0500
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
Message-ID: <ZyzrqnqoK81QfT_c@x1n>
References: <45ea8a8a-928d-4703-b698-d5f910e6a224@oracle.com>
 <1f1a2742-0429-47d5-958f-b37575c1e4ba@redhat.com>
 <c2ca740b-0178-463b-8262-b149841b8def@redhat.com>
 <bcc4cd7e-3532-475a-8989-211e80bf3eab@oracle.com>
 <09701693-436c-4e1a-8206-03eb26cacab5@redhat.com>
 <66c05a06-dbb7-49ec-b58e-ccd917d098ea@oracle.com>
 <ZyvUg3CP30f3DZYY@x1n>
 <d78a806f-4c15-4a1c-a9a4-8fb9f215a2a6@oracle.com>
 <7fb32744-0512-46e2-b58d-2990f742b897@redhat.com>
 <bb324f6d-8c8b-4f92-9c0f-12278e3c926c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb324f6d-8c8b-4f92-9c0f-12278e3c926c@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 07, 2024 at 09:04:02AM -0500, Steven Sistare wrote:
> On 11/7/2024 8:05 AM, David Hildenbrand wrote:
> > On 06.11.24 21:59, Steven Sistare wrote:
> > > On 11/6/2024 3:41 PM, Peter Xu wrote:
> > > > On Wed, Nov 06, 2024 at 03:12:20PM -0500, Steven Sistare wrote:
> > > > > On 11/4/2024 4:36 PM, David Hildenbrand wrote:
> > > > > > On 04.11.24 21:56, Steven Sistare wrote:
> > > > > > > On 11/4/2024 3:15 PM, David Hildenbrand wrote:
> > > > > > > > On 04.11.24 20:51, David Hildenbrand wrote:
> > > > > > > > > On 04.11.24 18:38, Steven Sistare wrote:
> > > > > > > > > > On 11/4/2024 5:39 AM, David Hildenbrand wrote:
> > > > > > > > > > > On 01.11.24 14:47, Steve Sistare wrote:
> > > > > > > > > > > > Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
> > > > > > > > > > > > on the value of the anon-alloc machine property.  This option applies to
> > > > > > > > > > > > memory allocated as a side effect of creating various devices. It does
> > > > > > > > > > > > not apply to memory-backend-objects, whether explicitly specified on
> > > > > > > > > > > > the command line, or implicitly created by the -m command line option.
> > > > > > > > > > > > 
> > > > > > > > > > > > The memfd option is intended to support new migration modes, in which the
> > > > > > > > > > > > memory region can be transferred in place to a new QEMU process, by sending
> > > > > > > > > > > > the memfd file descriptor to the process.  Memory contents are preserved,
> > > > > > > > > > > > and if the mode also transfers device descriptors, then pages that are
> > > > > > > > > > > > locked in memory for DMA remain locked.  This behavior is a pre-requisite
> > > > > > > > > > > > for supporting vfio, vdpa, and iommufd devices with the new modes.
> > > > > > > > > > > 
> > > > > > > > > > > A more portable, non-Linux specific variant of this will be using shm,
> > > > > > > > > > > similar to backends/hostmem-shm.c.
> > > > > > > > > > > 
> > > > > > > > > > > Likely we should be using that instead of memfd, or try hiding the
> > > > > > > > > > > details. See below.
> > > > > > > > > > 
> > > > > > > > > > For this series I would prefer to use memfd and hide the details.  It's a
> > > > > > > > > > concise (and well tested) solution albeit linux only.  The code you supply
> > > > > > > > > > for posix shm would be a good follow on patch to support other unices.
> > > > > > > > > 
> > > > > > > > > Unless there is reason to use memfd we should start with the more
> > > > > > > > > generic POSIX variant that is available even on systems without memfd.
> > > > > > > > > Factoring stuff out as I drafted does look quite compelling.
> > > > > > > > > 
> > > > > > > > > I can help with the rework, and send it out separately, so you can focus
> > > > > > > > > on the "machine toggle" as part of this series.
> > > > > > > > > 
> > > > > > > > > Of course, if we find out we need the memfd internally instead under
> > > > > > > > > Linux for whatever reason later, we can use that instead.
> > > > > > > > > 
> > > > > > > > > But IIUC, the main selling point for memfd are additional features
> > > > > > > > > (hugetlb, memory sealing) that you aren't even using.
> > > > > > > > 
> > > > > > > > FWIW, I'm looking into some details, and one difference is that shmem_open() under Linux (glibc) seems to go to /dev/shmem and memfd/SYSV go to the internal tmpfs mount. There is not a big difference, but there can be some difference (e.g., sizing of the /dev/shm mount).
> > > > > > > 
> > > > > > > Sizing is a non-trivial difference.  One can by default allocate all memory using memfd_create.
> > > > > > > To do so using shm_open requires configuration on the mount.  One step harder to use.
> > > > > > 
> > > > > > Yes.
> > > > > > 
> > > > > > > 
> > > > > > > This is a real issue for memory-backend-ram, and becomes an issue for the internal RAM
> > > > > > > if memory-backend-ram has hogged all the memory.
> > > > > > > 
> > > > > > > > Regarding memory-backend-ram,share=on, I assume we can use memfd if available, but then fallback to shm_open().
> > > > > > > 
> > > > > > > Yes, and if that is a good idea, then the same should be done for internal RAM
> > > > > > > -- memfd if available and fallback to shm_open.
> > > > > > 
> > > > > > Yes.
> > > > > > 
> > > > > > > 
> > > > > > > > I'm hoping we can find a way where it just all is rather intuitive, like
> > > > > > > > 
> > > > > > > > "default-ram-share=on": behave for internal RAM just like "memory-backend-ram,share=on"
> > > > > > > > 
> > > > > > > > "memory-backend-ram,share=on": use whatever mechanism we have to give us "anonymous" memory that can be shared using an fd with another process.
> > > > > > > > 
> > > > > > > > Thoughts?
> > > > > > > 
> > > > > > > Agreed, though I thought I had already landed at the intuitive specification in my patch.
> > > > > > > The user must explicitly configure memory-backend-* to be usable with CPR, and anon-alloc
> > > > > > > controls everything else.  Now we're just riffing on the details: memfd vs shm_open, spelling
> > > > > > > of options and words to describe them.
> > > > > > 
> > > > > > Well, yes, and making it all a bit more consistent and the "machine option" behave just like "memory-backend-ram,share=on".
> > > > > 
> > > > > Hi David and Peter,
> > > > > 
> > > > > I have implemented and tested the following, for both qemu_memfd_create
> > > > > and qemu_shm_alloc.  This is pseudo-code, with error conditions omitted
> > > > > for simplicity.
> > > > 
> > > > I'm ok with either shm or memfd, as this feature only applies to Linux
> > > > anyway.  I'll leave that part to you and David to decide.
> > > > 
> > > > > 
> > > > > Any comments before I submit a complete patch?
> > > > > 
> > > > > ----
> > > > > qemu-options.hx:
> > > > >       ``aux-ram-share=on|off``
> > > > >           Allocate auxiliary guest RAM as an anonymous file that is
> > > > >           shareable with an external process.  This option applies to
> > > > >           memory allocated as a side effect of creating various devices.
> > > > >           It does not apply to memory-backend-objects, whether explicitly
> > > > >           specified on the command line, or implicitly created by the -m
> > > > >           command line option.
> > > > > 
> > > > >           Some migration modes require aux-ram-share=on.
> > > > > 
> > > > > qapi/migration.json:
> > > > >       @cpr-transfer:
> > > > >            ...
> > > > >            Memory-backend objects must have the share=on attribute, but
> > > > >            memory-backend-epc is not supported.  The VM must be started
> > > > >            with the '-machine aux-ram-share=on' option.
> > > > > 
> > > > > Define RAM_PRIVATE
> > > > > 
> > > > > Define qemu_shm_alloc(), from David's tmp patch
> > > > > 
> > > > > ram_backend_memory_alloc()
> > > > >       ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
> > > > >       memory_region_init_ram_flags_nomigrate(ram_flags)
> > > > 
> > > > Looks all good until here.
> > > > 
> > > > > 
> > > > > qemu_ram_alloc_internal()
> > > > >       ...
> > > > >       if (!host && !(ram_flags & RAM_PRIVATE) && current_machine->aux_ram_share)
> > > > 
> > > > Nitpick: could rely on flags-only, rather than testing "!host", AFAICT
> > > > that's equal to RAM_PREALLOC.
> > > 
> > > IMO testing host is clearer and more future proof, regardless of how flags
> > > are currently used.  If the caller passes host, then we should not allocate
> > > memory here, full stop.
> > > 
> > > > Meanwhile I slightly prefer we don't touch
> > > > anything if SHARED|PRIVATE is set.
> > > 
> > > OK, if SHARED is already set I will not set it again.
> > 
> > We only have to make sure that stuff like qemu_ram_is_shared() will continue working as expected.
> > 
> > What I think we should do:
> > 
> > We should probably assert that nobody passes in SHARED|PRIVATE. And we can use PRIVATE only as a parameter to the function, but never actually set it on the ramblock.
> > 
> > If someone passes in PRIVATE, we don't include it in block->flags. (RMA_SHARED remains cleared)
> > 
> > If someone passes in SHARED, we do set it in block->flags.
> > If someone passes PRIVATE|SHARED, we assert.
> > 
> > If someone passes in nothing: we set block->flags to SHARED with aux_ram_share=on. Otherwise, we do nothing (RAM_SHARED remains cleared)
> > 
> > If that's also what you had in mind, great.
> 
> Yes, my patch does that, but it also sets RAM_PRIVATE on the ramblock.
> I will undo the latter.

David: why do we need to drop PRIVATE in ramblock flags?  I thought it was
pretty harmless.  I suppose things like qemu_ram_is_shared() will even keep
working as before?

It looks ok to remove it too, but it adds logics that doesn't seem
necessary to me, so just to double check if I missed something..

> 
> Do you plan to submit the part of your "tmp" patch that refactors
> shm_backend_memory_alloc and defines qemu_shm_alloc?  If you want,
> I could include it in my series, with your Signed-off-by.
> 
> Do you have any comments on my proposed name aux-ram-share, or my proposed text
> for qemu-options.hx and migration.json?  Speaking now would prevent more version
> churn later.
> 
> - Steve
> 
> 

-- 
Peter Xu


