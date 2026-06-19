Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6229FCD98F0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 00:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waNLZ-0001Ul-Pz; Thu, 18 Jun 2026 20:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1waNLX-0001UI-Mj
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 20:44:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1waNLV-0008AB-Es
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 20:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781829871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sl1UNpj+ejCFgKeCe6e8ZAxYZdC9B1NasXIXjmmKJxs=;
 b=QyTmU8WX8xWKlEZ+gnCeiQjNNTPwYUAEMO2XTJ59B9Tp1TLfgC/BaRkiFEFWaF9E0+psie
 xmLHbsuOOM9WP+Ve++GB/uiB8e7byRhWZ+Pn55xfL6RUBmLKSfqHWD+91MizUocGHWrsqo
 UxdEbc+qgG3k6bQdUYRCdj4ps/2QHzs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-NwgtSXPCN4CmiVfB_QGrMQ-1; Thu, 18 Jun 2026 20:44:30 -0400
X-MC-Unique: NwgtSXPCN4CmiVfB_QGrMQ-1
X-Mimecast-MFC-AGG-ID: NwgtSXPCN4CmiVfB_QGrMQ_1781829869
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36bba9b849dso1521049a91.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 17:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781829869; x=1782434669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sl1UNpj+ejCFgKeCe6e8ZAxYZdC9B1NasXIXjmmKJxs=;
 b=RIAlz1Jp7NTIqbOQpT1NW+XtPs5QglFu74Sbd555xrgCWf6brPJL71L6aVMbjyecUL
 koiO86VkUuDkK0AxhgnrTzlhlzeHxMY2d405tEm+41fLgFJ15r7X4RPtapy2ZmuuIV4/
 L8SCb0r0pEqNho5e89rkcHVFOjmy2CyotHXLhPePF0BHFjdZsNNUkB70lvG4MyTc2oxb
 /lL0mFWH0LGPZ28Xm+7OWg8IM8l8aDNnnj35NAzg8w45Z7KpRk2LwoMHq3K1UK1coNbf
 BPl5IXGXwrdGTIjDrkQBvybB5DvW4lxiGv47eifcjRWvm3belAApR7d7HOCH02ZEFt7n
 ssIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781829869; x=1782434669;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sl1UNpj+ejCFgKeCe6e8ZAxYZdC9B1NasXIXjmmKJxs=;
 b=QJKZZOHiM5jSuJLi9xLTVZ8irfPbxsJEaXkSBxSXBpMFzA2SpgsZx7ZK9PbjGNGDVY
 meCJu9ZB4kXnhlWKyS6CYWPp48yme4ydlylfXrwMpJd1CXDywNVHgFD3Tq/Jk7Sxx7nJ
 B+joWD5FRVFJDQH7NuIrShTdQ2ekpUNLtXoKX0SDOT6YZd13NhZUZS/yJnaYiMQ71x9m
 4YQzL8odQPHYcMLglbg+ROEfuwMEvFWouC4f8eVAmmgeC93SxcTZzVQWa5oAxnMA5DdK
 xkuidzVledhwEVtpAtKBendnI6+Cxc8RjQT/PBjK/Y1Qra9nuedRbdALcCCwXTavvD2i
 FQpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sxJYuSpVUdTy5xPPGfH5sM4TD/8dTASxScQ3KQco+em7+cgy/75Os0mQn9wqP4YNh5GOj6Q/9VVy3@nongnu.org
X-Gm-Message-State: AOJu0YzXBcy+c/KM9fjNAFQSNA9xs6rFQWbaPEDdB3LEroEkTjNhcwKv
 6Ih5mGTiQuY+WHH4f6T80w5dbgUkVmViD6to08j48IUaKWDKIajbYl0ECyTVXaANrTcB8xbmFUL
 Ri1XItkH60WMt3psYZzKPP6x2vxlhniXIEw400tERzj3FOyABioe+7VD9
X-Gm-Gg: AfdE7cn6boC0x0no79zTRxMRWlrBuES1olKdBe93emUFg+1DkeWndyGpFuwN/Owyo6O
 91qUdGaEmj7HmnMRArQzz//KV7YT82FieX9uzGQwO94+J2LxTtegW5Hl1lQQGFYfx+JIj0jhVor
 OE7JVz0T0ahv1FZ6G/TmaC/DjiXzi3qq7+jvPu7xjranWIixuaXTn7B4ALAK0DIypos7tTMNywW
 pPakBFZx1TtdRfH73ePRO+WK08sgF+GOeVrUb33Bj9ZKWgEEY4nP1+6V0oCVrRD9VYVx1Q4tC6w
 t+nrz3epUwATL8Z1oL13AOUseCVJxl3LrbmGANlwI3zCAw6ZaFaTEiBui0II6m0a3HcbznKvvf3
 ZIaxf5WFRBGvwzR8S2/JReQWX3y9jXR6MRMtcn717EnjlWDMVdyPUJQ==
X-Received: by 2002:a17:90b:5886:b0:369:e4d4:79c6 with SMTP id
 98e67ed59e1d1-37d160e0b15mr1596136a91.20.1781829868770; 
 Thu, 18 Jun 2026 17:44:28 -0700 (PDT)
X-Received: by 2002:a17:90b:5886:b0:369:e4d4:79c6 with SMTP id
 98e67ed59e1d1-37d160e0b15mr1596102a91.20.1781829868223; 
 Thu, 18 Jun 2026 17:44:28 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37d158d97a5sm914661a91.16.2026.06.18.17.44.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 17:44:27 -0700 (PDT)
Message-ID: <3f58de99-74a2-4ccc-b800-d254bbd40931@redhat.com>
Date: Fri, 19 Jun 2026 10:44:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: list of memory/memcpy access issues
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 alex@shazbot.org, richard.henderson@linaro.org, peter.maydell@linaro.org,
 berrange@redhat.com, philmd@oss.qualcomm.com, philmd@mailo.com,
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn,
 shan.gavin@gmail.com
References: <20260617022330-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260617022330-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/17/26 5:14 PM, Michael S. Tsirkin wrote:> This is a top post attempting to summarize some findings related to
> emulating DMA and MMIO existing in QEMU memory core
> using memcpy/memmove.
> 
> Hopefully, this will help inform discussion about multiple
> changes currently proposed for QEMU.
> 
> At a high level, and in a variety of configurations, QEMU gets
> DMA requests from a virtual device, or MMIO requests from
> a VCPU, and wants to execute them either on guest ram or
> passhtrough device memory.
> 
> Down the road this almost always (virtio ring implementation seems to be
> a notable exception) translates to memcpy/memmove calls
> (glibc e.g. on x86 currently implements memcpy through memmove).
> 
> However, memcpy's signature is:
>         void *memcpy(void *dest, const void *src, size_t n);
> note how neither src not more importantly dest are volatile.
> Thus it was never designed either for a concurrent access
> by another CPU, or for accessing devices.
> (Mis)using it for that gives good performance but has issues,
> some of which I am trying to enumerate below.
> 
> In the below I say memcpy but same applies to memmove just as well.
> 

Firstly, thanks to Michael for the summary and helps to lead the discussions.

I went through the listed questions and suggestions, but I'm not sure if
I understood every question and suggestion. Figured out that we probably
need to something as below. Please take a look when you get a chance to
check if there are any gaps.

S1: New field MemoryRegion::cache_mode to indicate how it has been mapped
     for those directly accessible regions: cache_{normal, writecombine, no}
     corrresponding to pgprot_{normal, writecombine, noncached}.

     S1.1 MemoryRegion::cache_mode is meaningful to those directly accessible
          regions like ram, ram device and rom device regions
     S1.2 MemoryRegion::cache_mode should be set when those directly accessible
          regions are created
     S1.3 Only cache_{normal, writecombine} regions can be directly accessible

S2: qemu_ram_{copy, move}() which are our private implementations of memcpy()
     and memmove(). They're going to replace memcpy/memove() in the memory
     region directly access paths like flatview_{read, write}_continue_step()

     S2.1 Small fixed length (1/2/4/8 bytes) accesses shouldn't be either
          split or reordered
     S2.2 Arcitectural optimization based on the MemoryRegion::cache_mode,
          unaligned accesses and vector instructions may be allowed

S3: Support VFIO_REGION_INFO_CAP_MMAP_CACHE_MODE where cache_{normal,
     writecombine, no} is provided for every mmapable region or all
     sparse mmaps on the region

     S2.1 The capability is only meaningful when VFIO_REGION_INFO_FLAG_MMAP
          is absent
     S2.2 All sparse mmaps for one specific region should have unified cache
          mode

> 
> ------------------
> 
> 1. On x86, memcpy is different from __builtin_memcpy if
> one uses old 1.0 force-headers from 2019. Thus, QEMU
> sometimes uses __builtin sometimes it does not, inconsitently.
> Likely no longer relevant and should be cleaned up.
> 

S2. old 1.0 force-headers won't be used with S2?

> 
> 2. variable length memcpy can translate 2,4,8 byte guest access
> into multiple byte accesses. doing this for mmio is
> guaranteed to break devices.
> 

S2.1. However, is it still a problem when the MMIO region is mapped with
pgprot_{normal, writecombine}?

> 
> 3. (theoretical concern) also on x86, unaligned accesses are possible on guest and host,
> so converting an unaligned access to a series of aligned ones can
> in theory break devices.
> 

S1.3, the directly accessible regions have attribute cache_{normal, writecombine}
where unaligned access is allowed. The question is unaligned access on those
regions are always safe on all architectures?

> 4. also on x86, vector instructions for large (>16 byte) writes
> into pgprot_noncached memory are safe and faster than multiple 8 byte
> ones.
> 

S1.3, region with pgprot_noncached is indirectly accessible.

> 5. also on x86 it so happens that if you write a fixed-size memcpy this
> gets optimized to a single store/load and it works for aligned and
> unaligned addresses on that architecture. How to ensure this keeps being
> correct is left as an excerise for the reader. But qemu already relies
> on this and did for years.
> 

Sorry, Not fully understood. It's perhaps covered by S2 if we're talking
about address_space_{read,write}. If we're talking about address_space_{ldl, stl}(),
we perhaps need to replace __builtin_{memcpy, memmove}() with those private
functions introduced in S2.


> 6. on non-x86 both unaligned accesses and vector instructions
> for accessing  UC memory are illegal.
> 

Assume UC is equivalent to pgprot_noncached. In that case, it's true on aarch64
at least. With S1.3 applied, this kind of region becomes indirectly accessible.

> 7. standard vfio gives KVM VM_ALLOW_ANY_UNCACHED, so even on non x86
> guest can
> map the memory as as pgprot_noncached/ioremap or pgprot_writecombine/ioremap_uc.
> If it does the second then it can use unaligned or vector for access.
> This is why normal passthrough tends to work - it never traps to qemu at
> all.
> 
> 
> But for qemu, vfio uses  pgprot_noncached unconditionally so qemu
> can't use unaligned or vector instructions on non-x86.
> 

VM_ALLOW_ANY_UNCACHED is exclusively to arm64 since commit 8c47ce3e1d2c ("KVM:
arm64: Set io memory s2 pte as normalnc for vfio pci device). After that, all
VFIO PCI BARs have pgprot_writecombine attribute on arm64, thus unaligned or
vector accesses are safe on those BARs from guest POV instead of host. I maybe
wrong and Alex can correct me.

S1.3 only cache_{normal, writecombine} regions can be directly accessible.
A region with pgprot_noncached attribute is indirectly accessible.

> 
> 8. But for nvgrace RAM, vfio has a driver that uses pgprot_writecombine/ioremap_uc.
> so qemu could safely use unaligned/vector instructioons even on non-x86.
> 

For my specific case related to GH100 card, Region-0/2 have pgprot_writecombine
while Region-4 has pgprot_normal attribute.

   Region 0: Memory at 44080000000 (64-bit, prefetchable) [size=16M]
   Region 2: Memory at 44000000000 (64-bit, prefetchable) [size=2G]
   Region 4: Memory at 42000000000 (64-bit, prefetchable) [size=128G]


> 9. Except sadly, vfio currently does not tell qemu how it maps
> the memory, so qemu can not know what is safe on non-x86.
> 

S3. Host VFIO driver needs ABI changes to expose the cache mode.

> 10. on x86 memcpy will sometimes do multiple overlapping stores when
> size is not a power of 2. for example, a 15 byte write is done with
> 2 8-byte stores. This is theoretically an issue
> if guest does something super clever with ordering,
> but does not seem to be in practice.
> 

S2. This should be avoided in qemu_ram_{copy, move}() which are going to replace
the standard memcpy() and memmove().


> 11. on non-x86 memcpy will do multiple overlapping stores even
> for single byte writes. E.g. it does it to avoid extra branches.
> This is causing issues in practice.
> 

S2, This should be avoided in qemu_ram_{copy, move}().


> 12. PCI writes are in order, last byte is written last.
> memmove especially writes last byte first sometimes.
> Violating that theoretically can break guests.
> 

S2, the reordering should be avoided in qemu_ram_{copy, move}(). However,
I would think this region becomes indirectly accessible with S1.3 applied?


> 13. but if we are copying between 2 addresses that are overlapping,
> the standard trick (used by memmove) is to compare dst and src and copy
> backwards if dst < src, so last byte is written first.
> 

Backwards copying happens on (dst > src) not on (dst < src). We potentially
convert this to a forwards copying by moving the data in the overlapped area
to somewhere else, and then take that as the src in the subsequent forwards
copying.

I think it's unliekly to be a directly accessible region with S1.3 applied.


> -------------
> 
> 
> 
> Some conclusions:
> 
> A. on x86, we must avoid converting 2,4,8 byte accesses into byte accesses.
> At least for aligned, perferably for unaligned accesses too.
> Fixed width memcpy seems to work for this. Whether we should bother with
> __builtin to work around broken old fortify headers, I donnu.
> I do not have any answer how to check that compiler does this correctly.
> If anyone is motivated enough, adding a GCC builtin could be possible.
> Given qemu did this for years, I think we can leave solving this for
> another day.
> 

Covered by S2.1

> B. Also on many architectures, memcpy is much faster for large transfers
> than iterating over 8 byte chunks in C.
> When we can get away with doing that (e.g. for emulated devices where
> we know the concurrency rules, writing into guest RAM), we should.
> 

S2.2, something related to performance optimization for the future

> C. on non-x86, we currently must not memcpy into host devices
> since we do not know if it is pgprot_noncached. yes, performance will be
> bad for DMA into device RAM.
> 

S1.3. This specific region becomes indirectly accessible after S1.3 is applied.

> 
> D.  It goes without saying that casting an unaligned address to unint32_t
> (be it for qatomic_set or whatever) is undefined behaviour in C
> and so a bad idea on any architecture.
> 

S1.3. The directly accessible region always have cache_{normal, writecombine}
attribute.

> 
> E. also for non-x86, we really should teach vfio to tell qemu whether
> it maps device pgprot_noncached or pgprot_writecombine.
> we will then be able to do things like use vector ops
> (through memcpy or not) for >8 accesses.
> 

S3. pgprot_normal is also needed. In my case related to GH100 card, the PCI
BAR-4 is mapped with pgprot_normal.

Yes, with those information fed to MemoryRegion::cache_mode in S1, it's
possible to optimize qemu_ram_{copy, move}() in S2.2 for the performance sake.


> F. Arbitrary device passthrough with drivers doing unalined accesses and
> when working cross architectures basically is a best effort thing.  It
> can't be 100% perfect for all devices.
> 

Yes. For the first step, we perhaps need to gurantee the directly accessible region
have pgprot_{normal, writecombine} in S1.3 if you agree.

> 
> --------------------
> 
> Links:
> 
> 
> example of a fix for a bug caused by memcpy to overlapping addresses:
> 4a73aee881 - "softmmu: Use memmove in flatview_write_continue"
> https://lore.kernel.org/qemu-devel/20230131030155.18932-1-akihiko.odaki@daynix.com
> 
> 
> example of a bug caused by memcpy as result of DMA:
> https://lore.kernel.org/qemu-devel/20260527091711.3901-1-liugang24219@sangfor.com.cn
> 
> an attempt to fix bugs caused by memcpy to device memory in response to
> MMIO:
> 4a2e242bbb "memory: Don't use memcpy for ram_device regions"
> https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg08129.html
> 

Thanks,
Gavin


