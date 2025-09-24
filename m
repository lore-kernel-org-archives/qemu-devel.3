Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5250FCAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 21:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Wov-0007FY-OS; Wed, 24 Sep 2025 17:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v1Wom-0007DG-G8
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 17:14:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v1Woc-0002jz-NN
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 17:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758748451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gwLCsvtUZYziFBTKiqCyBHJANT1AxUTigXSGiXGeRNY=;
 b=AT6twueR2gPb3DdRn0dQ3Ad2thOSHXeGApL1aoLUyij8wNHf+rs3zQHQoozVFWjSJ4wiXT
 kghkvzQ4l2I23bfPRQiOS83fhTIXqY0luITnv/pOSNwoZ2vv9W43SPizbrNvU13B39PAeV
 o+xGiONawr0T5RYWH4yNborYhJbBiRM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-8FNEUOcCMdG48whehHz20g-1; Wed, 24 Sep 2025 17:14:10 -0400
X-MC-Unique: 8FNEUOcCMdG48whehHz20g-1
X-Mimecast-MFC-AGG-ID: 8FNEUOcCMdG48whehHz20g_1758748450
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4b793b04fe0so6500781cf.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 14:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758748449; x=1759353249;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gwLCsvtUZYziFBTKiqCyBHJANT1AxUTigXSGiXGeRNY=;
 b=G84RukMN1dJxfmViq6J7jnvzJfNLwtqUtda1YPtLYPneeQw5zjq1a/NG0cEtVcFKaL
 4zgGiVMMleYwCtsWo4Bi8twOKcSAUnUrbGmpZLnv603EOHBuKVaG1tkAOn6UELhOJwpA
 JhyfasvFXIkNtDAShf2Xl6X/PzMobUMbMfjmj+MjAYNm9o6yqUa11YMy+BZh4iGxbOVo
 TAVRtDvj8e/cNIDHw8dynXI7+FQExfJTWFtyxfQZjgXBmak3Ejj3MEw4lbFoQcdawbLq
 YB6LaskAh8D2ksOi2FPtoBAQA2mnMcPgsi7VIG4+X1zLfLw/s2rM+E25TSxjS+gBG6y5
 LPcA==
X-Gm-Message-State: AOJu0YzPDVFcaUaP5rOA9R371+WzS1rhQ5BGfEvhs1BBNGWkNTTZpfPS
 1nDuXTsLH5PHF7ARQwwF8QY6SMqj82QhE01OAOOxsHv6sc3XThYDuDpE8MO9hrHrk7NrFcT5iOb
 jrFL9wrhqdeOP3PLVmqISxYJo9d40c9ntoCal1HaoChZuFanbvT3tioV7
X-Gm-Gg: ASbGncu9nSgi0Kr1J4UqAGEsq2rZngTm4w3dnVuQj6aa/QtAx+m6Epq3GVgAtECOHs6
 wsbFCwA4kgjxutxzSn21hNDH3Uv1E6i3jPWMreg9Mgjl3aeUePyk6kMHlzobPHG+RvX4+q0byVo
 9pExRAr5lc2rCoFXgI9WK1ChCQmeTOHNQhLKxB9GIA03nth6Z76K3cuOV3lZBGFJKdYBYsaydfn
 P7qVLrGZ4+usYZ5tuxGWjxXBhyBO1FByc1YU4/JqFKGn8n2ECbYeiHOiXh3Hz7w69xPbXkDsjEG
 Ta3OfXE/iOz2jbv5ubIvCne9bmIP0g1T
X-Received: by 2002:a05:622a:138e:b0:4d3:55f7:ddcd with SMTP id
 d75a77b69052e-4da4c39a525mr16996641cf.59.1758748449142; 
 Wed, 24 Sep 2025 14:14:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFisAfNeCfyg9AyHc+DxaVr/OGXTSDVs0ciDcqJtcNGkvBHlxSMSwQGkPIPFK+8sw8PdF1xfw==
X-Received: by 2002:a05:622a:138e:b0:4d3:55f7:ddcd with SMTP id
 d75a77b69052e-4da4c39a525mr16996221cf.59.1758748448476; 
 Wed, 24 Sep 2025 14:14:08 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4bda28926b6sm110061841cf.20.2025.09.24.14.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 14:14:07 -0700 (PDT)
Date: Wed, 24 Sep 2025 17:14:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v2 3/3] memory: Stop piggybacking on memory region owners
Message-ID: <aNRfHQoBgwBMjK04@x1.local>
References: <20250906-mr-v2-0-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
 <20250906-mr-v2-3-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
 <aMHxhTIw2EGRyD4-@x1.local>
 <fe1969e6-bc13-4438-816d-b352926c33a8@rsg.ci.i.u-tokyo.ac.jp>
 <aMNMjetBDJfBiThl@x1.local>
 <4108b4f2-accf-4080-af29-a3f464d862f9@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4108b4f2-accf-4080-af29-a3f464d862f9@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 18, 2025 at 09:04:19PM +0900, Akihiko Odaki wrote:
> (I'm ccing Manos Pitsidianakis as I mention Rust below.)
> 
> I couldn't reply this immediately as the topic is complicated and I wanted
> to double-check the situation, but I'm confident enough to do so now.

I apologize for my slow response, and thanks a lot for the long writeup.

Actually, even until now I still didn't get enough time to finish my own
investigation regarding to at least the hotplug issues I mentioned below,
but let me reply first on my current thoughts.

> 
> ------
> 
> First, I describe (2) and (3).
> 
> (2) is almost equivalent with (1). For example, xtensa-cpu leaks because of
> the following code:
> 
> memory_region_init_io(env->system_er, obj, NULL, env, "er",
>                       UINT64_C(0x100000000));
> address_space_init(env->address_space_er, env->system_er, "ER");
> 
> The difference from (1) is that we have an AddresSpace instead of a
> container MemoryRegion. You can reproduce the issue with the following
> command:
> meson test -C build qtest-xtensa/device-introspect-test

I didn't see any warning/error running it, with --enable-asan.  I
definitely missed something, please let me know if you have idea.

My gut feeling is CPU hotplugs logic should make sure proper eliminations
of all these objects, that should include the address space destructions.

To me, the address space may or may not even have an owner.  It's unlike
MR, that either will not be freed if owner==NULL, or must have an owner.
Hence address spaces are at least not as special as MRs, who constantly do
refcounts against owner before your this patch.

AFAIU, when arch would care about any form of memory leaks in the CPU
object / address spaces, the arch should follow the trend of the major
archs that support hotplugs. I had a vague memory that at least i386 should
support CPU hotplugs properly.

From that, I saw we do have cpu_address_space_init(), that i386 and arm
use. There, AddressSpace is not embeded in the CPU object, instead we have
these relevant fields in CPUState:

    struct CPUAddressSpace *cpu_ases;
    int cpu_ases_count;
    AddressSpace *as;

That looks like a more advanced way of allowing >1 address spaces for a
CPU, however one arch can still opt-in with 1 address space, setting
num_ases=1, and pass in asidx=0.  After all, all these are fields of
CPUState that all CPU objects share, including xtensa's.

Should xtensa (when starts to care about CPU hotplugs and relevant memleaks
like what we're discussing now) move to the generic way of managing address
spaces like what x86 and arm do (rather than relying on its)? Then maybe we
should always be able to properly destroy the address spaces?

How important is such leak in xtensa CPU's case?  E.g. does it support
CPU hotplugs?

Side note: when I was trying to test hotplugs with i386/q35, unfortunately
I didn't really see when the address space was destroyed, maybe there's a
bug somewhere; I put that info into appendix at the end.

Anyway, my confusion is if we should manage address spaces in the same way
across important archs, and if that would after all always involve proper
address space destructions.

OTOH, I also see things like tcg handling in cpu_address_space_init().  I'm
not sure if it means tcg_log_global_after_sync() / tcg_commit() might be
useful for xtensa tcg cpus too.  So there might be other reasons too that
xtensa cpus should move over to a generic CPU plug/unplug API, which will
cover the address spaces management?

Take my above as pure asks, not review comments.  After all, I don't know
the problem well, once more.

> 
> The code lacks address_space_destroy() so it is destined to leak anyway, but
> even if you add address_space_destroy() to instance_finalize(), it still
> leaks due to the exactly same reason with (1). "[PATCH 00/35] memory:
> QOM-ify AddressSpace" QOM-ifies AddressSpaces just like (container)
> MemoryRegions, which make the situation even more closer.
> 
> (3) is more complicated. The problem will occur when:
> - flatview_translate() is called.
> - The acquired memory region is owned by the parent.

It doesn't look like exactly the problem, or I definitely could have missed
something.  After all, flatview_translate() is protected by rcu, afaiu, not
refcounts, right?  Maybe you meant something like address_space_map()?

That'll definitely need to hold the MR longer after rcu_read_unlock(),
however then could you explain if it happens, why the paired unmap() won't
happen to properly release it?

> 
> I do not have a reproduction case for this, but it is hard to ensure that
> the situation never occurs because there are so many places where
> flatview_translate() is called; note that the function is called from
> several abstracting functions such as address_space_translate(),
> dma_memory_map(), pci_dma_map(), etc.
> 
> Your patch and my old one tried to solve (1) by checking if the owner is
> trying to create a reference to its MemoryRegions. However, this approach is
> not practical to cover all the memory leak hazards, especially (3). In
> theory, we can change memory_region_ref() to take the referrer as the
> argument and let it compare against the owner, but there are too many code
> paths where memory_region_ref() is called.
> 
> To avoid the complication, this patch avoids circular references by
> extending the code to unparent. Unparenting occurs far less frequently than
> memory_region_ref(); this patch eventually reduces the number of affected
> places to just 2; the qdev common code and virtio-gpu's hostmem/blob code.
> Changing the two is much easier than auditing all the DMA code that triggers
> flatview_translate().
> 
> ------
> 
> Next, I explain that patch 1 "qom: Do not finalize twice" is useful,
> independently with this patch.
> 
> The memory management code in qom/object.c has a number of assertions to
> prevent misuses. They ensures that implemented operations have well-defined
> semantics; memory leaks can happen with circular references and misuses
> trigger abortion, but they do not result in an undefined behavior at least.
> 
> However, there is one open hole in the code, which "qom: Do not finalize
> twice" closes: calling object_ref() and object_unref() during finalization
> results double-free. Defeinsively closing the hole ensures that an undefined
> behavior will not result in a hard-to-debug issue or a security
> vulnerability.
> 
> The ultimate way to prevent undefined behaviors is to use Rust; it relies on
> programmers to avoid undefined behaviors only in a relatively small number
> of unsafe wrappers, and when doing so, "safety" comments are placed.
> However, a corner case that results in undefined behaviors makes it hard to
> write unsafe wrappers.
> 
> To own an QOM object in safe Rust code, the Rust wrapper provides an unsafe
> function: Owned::from(), which wraps an object into
> Owned<T: ObjectType>. The caller must ensure that the object is not an
> embedded object like a memory region, which is described in the "safety"
> comment.
> 
> Once an object is wrapped into Owned<T: ObjectType>, you can freely create
> and drop references using safe object_ref() and object_unref().
> 
> But the open hole in QOM breaks the safety assumption if a child decides to
> take a reference to its parent during unparenting just like this patch does.
> Avoiding this requires to ensure no new Owned<T: ObjectType> is created by
> any child objects during unparenting and would require to add "safety"
> comments anywhere Owned<T: ObjectType> is created.
> 
> Instead, we can simply change qom/object.c not to attempt double-free at
> all, ensuring the safety in one place, which is what patch 1 does.

Please bare with me on my ignorance on Rust.  Do you mean it might be
important to Rust, and this could be proposed separately copying whoever is
active on Rust?

It sounds like a better way to justify the first patch landing before the
rest, if it is acceptable whoever is fluent with QEMU/Rust.

My stupid question is, why a ref() to self could happen in a finalize(),
and why it's legal at all, causing double finalize? It sounds against the
whole idea refcounting. But as I know zero on Rust, feel free to ignore my
question if you think that's a well known problem by all others.  Then I
also suggest you send patch 1 separately.

> 
> ------
> 
> Lastly, I explain this patch will not prevent to add functions that use
> object_new(TYPE_MEMORY_REGION).
> 
> The functions that call object_new(TYPE_MEMORY_REGION) can simply skip
> setting OBJECT(mr)->free and ensure object_unref(mr->owner) in the
> instance_finalize().

We could, but then MR object will behave totally differently when it's
allocated by object_new(), or when it's not.  Meanwhile, if we want to in
the future use more object_new(TYPE_MEMORY_REGION) we may also want to
reuse memory_region_do_init() on top of them, then that'll be a problem and
even if it's not a blocker it's hard to track all these design trivial
differences.

I confess I can only get your gut of your new design, however I personally
don't prefer reusing a free() function that does anything without memory
releases.  It is really error-prone to me for the long term.  That's also
the root cause of why it cannot be used mixture with object_new() because
that was the much-easy-to-understand way to properly set a object->free()..

Another thing is, after your new design, MRs (even fully embeded in a
Device object) will start to have real refcountings, concurrently from the
Device object.

And then, if we think about an Device object with N MR objects embeded, the
struct has N+1 refcounts... Totally confusing to me.  I think that's where
I mentioned I liked the piggypack solution, and I wished the MR refcount is
simply a link or bool rather than called to be a refcount.. basically I
wished we can ignore the MR refcount which is easier, taking MR part of the
owner always.  But I agree this opinion can be subjective.

Another thing I'm not 100% certain is, I believe your new design relies on
device_unparent() to happen first, during which auto-detached MRs start to
gain refcounts of the owner, and that will be released in MR's free().

Could it happen device_unparent() are not invoked on the owner?  E.g., can
something like this happen, that one creates a device, maintain it
internally, map anything, then when not needed unref() the device?

  dev = object_new(SOME_DEVICE_HAS_MRS);
  ... add dev's MRs as subregions ...
  ... after finish using the device ...
  ... remove dev's MRs from container MRs ...
  object_unref(dev);  <--- which finalize() and free() the device object

I really wish we don't go with this and find something clean, after
understanding better on the problems.  Reusing object->free() to unref()
another object but without freeing the memory at all, just sounds too
tricky for a long-term maintained project.

Thanks,
  
============= APPENDIX =============

The CPU hotplug test I did on i386, after some sequences of (guest OS runs
very new version of Linux, with some random mm patches on top of v6.17-rc4):

  - HMP: hotplug a cpu
  - guest OS: online the cpu
  - guest OS: offline the cpu
  - HMP: hotunplug the cpu
  - HMP: hotplug a cpu
  - HMP: hotunplug the cpu
  - ...

I was able to hit a KVM failure after above sequence (I won't hit it if I
keep online/offline steps in guest OS for each continuous plug/unplug):

2025-09-24T15:33:38.398617Z qemu-system-x86_64: kvm_init_vcpu: kvm_arch_init_vcpu failed (8): Invalid argument

There, it's KVM_SET_CPUID2 that failed.

When ASAN enabled, I'll see a splash:

Direct leak of 1248 byte(s) in 3 object(s) allocated from:                                                                               
    #0 0x7f966e0e68a3 in calloc (/lib64/libasan.so.8+0xe68a3) (BuildId: 10b8ccd49f75c21babf1d7abe51bb63589d8471f)                        
    #1 0x7f966d0b6f81 in g_malloc0 (/lib64/libglib-2.0.so.0+0x47f81) (BuildId: 3adead5a77684e5d72b61c7e0db58031a35baf58)                 
    #2 0x55da4a8c31d4 in cpu_address_space_init ../system/physmem.c:797                                                                  
    #3 0x55da4acbc340 in kvm_cpu_realizefn ../target/i386/kvm/kvm-cpu.c:102                                                              
    #4 0x55da4a0cc385 in accel_cpu_common_realize ../accel/accel-common.c:101                                                            
    #5 0x55da4a082f78 in cpu_exec_realizefn ../hw/core/cpu-common.c:232                                                                  
    #6 0x55da4adbc5a8 in x86_cpu_realizefn ../target/i386/cpu.c:9321                                                                     
    #7 0x55da4ada6e6e in max_x86_cpu_realize ../target/i386/cpu.c:6715                                                                   
    #8 0x55da4afeb556 in device_set_realized ../hw/core/qdev.c:494                                                                       
    #9 0x55da4afff2d2 in property_set_bool ../qom/object.c:2375                                                                          
    #10 0x55da4affa5e5 in object_property_set ../qom/object.c:1450                                                                       
    #11 0x55da4b0048e0 in object_property_set_qobject ../qom/qom-qobject.c:28
    #12 0x55da4affab6d in object_property_set_bool ../qom/object.c:1520
    #13 0x55da4afea405 in qdev_realize ../hw/core/qdev.c:276
    #14 0x55da4a8e2d5d in qdev_device_add_from_qdict ../system/qdev-monitor.c:714
    #15 0x55da4a8e2e69 in qdev_device_add ../system/qdev-monitor.c:732
    #16 0x55da4a8e43c0 in hmp_device_add ../system/qdev-monitor.c:993
    #17 0x55da4a9e4fee in handle_hmp_command_exec ../monitor/hmp.c:1106
    #18 0x55da4a9e548a in handle_hmp_command ../monitor/hmp.c:1158
    #19 0x55da4a9ddea0 in monitor_command_cb ../monitor/hmp.c:47
    #20 0x55da4b5236fd in readline_handle_byte ../util/readline.c:427
    #21 0x55da4a9e7060 in monitor_read ../monitor/hmp.c:1390
    #22 0x55da4b2f86f8 in qemu_chr_be_write_impl ../chardev/char.c:214
    #23 0x55da4b2f87a3 in qemu_chr_be_write ../chardev/char.c:226
    #24 0x55da4b2ec890 in tcp_chr_read ../chardev/char-socket.c:511
    #25 0x55da4b023d65 in qio_channel_fd_source_dispatch ../io/channel-watch.c:84
    #26 0x7f966d0af862 in g_main_context_dispatch_unlocked.lto_priv.0 (/lib64/libglib-2.0.so.0+0x40862) (BuildId: 3adead5a77684e5d72b61c)
    #27 0x7f966d0afae4 in g_main_context_dispatch (/lib64/libglib-2.0.so.0+0x40ae4) (BuildId: 3adead5a77684e5d72b61c7e0db58031a35baf58)
    #28 0x55da4b4f4c35 in glib_pollfds_poll ../util/main-loop.c:290
    #29 0x55da4b4f4dae in os_host_main_loop_wait ../util/main-loop.c:313

So indeed I at least didn't see a AccelState.cpu_common_unrealize()
provided (which I was trying to look for callers of the paired API called
cpu_address_space_destroy() but surprisingly I found it's not even used
anywhere..), when it is hot unplugged:

#4  0x0000560336361a8a in x86_cpu_unrealizefn
#5  0x000056033658fd37 in device_set_realized
#6  0x00005603365a32d3 in property_set_bool
#7  0x000056033659e5e6 in object_property_set
#8  0x00005603365a88e1 in object_property_set_qobject
#9  0x000056033659eb6e in object_property_set_bool
#10 0x000056033658e48a in qdev_unrealize
#11 0x00005603362b5ee6 in x86_cpu_unplug_cb
#12 0x00005603362facda in pc_machine_device_unplug_cb
#13 0x0000560335822c28 in hotplug_handler_unplug
#14 0x0000560335771af7 in cpu_hotplug_wr
#15 0x0000560335e45c46 in memory_region_write_accessor
#16 0x0000560335e462da in access_with_adjusted_size
#17 0x0000560335e4e74d in memory_region_dispatch_write

Cmdline I used for testing:

/usr/local/bin/qemu-system-x86_64 -M q35,kernel-irqchip=split -accel kvm -gdb tcp::1234 -m 6G,slots=4,maxmem=16G -name peter-vm,debug-threads=on -msg timestamp=on -nographic -cpu host -smp 8,maxcpus=32 -global migration.x-max-bandwidth=1M -global migration.x-events=on -global migration.x-postcopy-ram=on -global migration.x-postcopy-preempt=on -monitor telnet:localhost:6666,server,nowait -qmp unix:/tmp/peter.qmp1,server,nowait -device ioh3420,id=pcie.1,chassis=1 -netdev user,id=net0,hostfwd=tcp::5555-:22 -device virtio-net-pci,netdev=net0,bus=pcie.1 -device ioh3420,id=pcie.2,chassis=2 -drive file=/home/peterx/images/default.qcow2,id=drive0,if=none,aio=io_uring -device virtio-blk-pci,drive=drive0,bus=pcie.2 -device ioh3420,id=pcie.3,chassis=3 -device virtio-balloon,bus=pcie.3 -device ioh3420,id=pcie.4,chassis=4 -kernel /home/peterx/git/linux/arch/x86/boot/bzImage -append root=/dev/vda3 console=ttyS0 nokaslr hugepages=128

-- 
Peter Xu


