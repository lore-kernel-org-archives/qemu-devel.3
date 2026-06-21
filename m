Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87484CD98F0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 06:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbC2V-0002q6-1K; Sun, 21 Jun 2026 02:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wbC2Q-0002pb-OK
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 02:52:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wbC2N-000791-Ju
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 02:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782024729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ANkJ1TK/0YZ9kGJpLdneRykRFWLAjkPpaJ91Q5M62Hs=;
 b=BMZoW5X2Hv0XjT0rxh6rFgfQuIz6UGKnKtvt2OXpWjxoCTvhovSy+CDN2ub0PeakxsRt0E
 TwNpunvmRupB9VNZp1agnBdJHYo2OE3O37gy9NF3kHnL3jvozb2uvxHOh07CH3hDZAplhw
 /bZ7pfSci766Nygz3SQofoLsLH8JCIk=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-eGmb5VUqM4mjJ6yU7vcQBw-1; Sun, 21 Jun 2026 02:52:07 -0400
X-MC-Unique: eGmb5VUqM4mjJ6yU7vcQBw-1
X-Mimecast-MFC-AGG-ID: eGmb5VUqM4mjJ6yU7vcQBw_1782024727
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c17f62afdso1296981eec.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 23:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782024727; x=1782629527; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ANkJ1TK/0YZ9kGJpLdneRykRFWLAjkPpaJ91Q5M62Hs=;
 b=GX4/uBmPNTKAlaXJpY9n371W7zglkY/x+WVT2AzAdu3ehk1YnIyqZ2TbKoPQJd5dqr
 I+wBNg/3dh+6dc2XxI6gWII6ZLvGAUKDQFrCJKx9n19E3GDvn8XwDxImy/tsVQC4/WU4
 lPHX3h82HLHDTNzxhCabWoKRA2GlZjVxSCoWtp4uNmfjQTMK2H32LfW/4/1VG/piIXpC
 +qpzhV4K4hre5nbLOnIgSFd1J1Rz4SVAUkgWw8DkrhNylyRlHprqdNfLdKHhONMsfT3A
 Usp6yghTJhHUxEAgK5eCXAUi9ljjrxKZ1gpox79lndk87hL3v8xZdIsw+S7rCg4i49H4
 Q3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782024727; x=1782629527;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ANkJ1TK/0YZ9kGJpLdneRykRFWLAjkPpaJ91Q5M62Hs=;
 b=LQOjVz8xBulBYYGiddxRcH1AX1xyPSAKz/In9AwCZVOglqETNAJB3gaD2Ho3NstHE/
 27KfHhc2Fap5vS/iXRZh6SyuDlTwBvzq+/k3YLAKvxsw+Sq0Ubbw0vQyKbxLpGooC9Ik
 i3cHCL/kzS8zMDfQh/+PLp/D/PR39HMwAM9aH3wFoNmJHV3gft3jFD5HQBqWKj7gPKWm
 qgdK5UjiE7e2tZxiDA6kScqx+pmsT/d1rSwXY+CErUTAfJSA3rwRS+j7Y7QStzVWgw86
 Rr1nBl66Uci5URE0IqiaXv4bGBVDqBAIcgMCzFYWVomDIPdltVjwSARmcUX0YWQrCTZX
 dglA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoC2uryz4E3My5W4noDjm0/Wgfj7mAMeXz42OVRAzkIML3tigHLAnihI7kteuI83kAXXLx5K19aqaRj@nongnu.org
X-Gm-Message-State: AOJu0YzVxPOs6BJPu9X0vKTq9qI1/FhBDuMPqxKQgLbmlEpac3TGm3go
 LSVKoWsVA9b/5K6TZDYXTA6SAW75zEc46bFpnl6T3W2EukkIfvjoShStKedzQZClB8ZJvXFCcKq
 YL20oZ5eoG7I/KFFJCks/JcCOo71sBzgR9y4BXk8V4z1BYqoBDDHJM1Sf
X-Gm-Gg: AfdE7clo/ckCdg0TGGNUqv8OxZHyEUhZ8kvIyZx9KjSe0evQOaNCLAeCEP017bVNNAr
 Pv5ZotMXnKWyEW4w2w+Gv/JFF/lLNevTptmy/TO1JqsB09lPjEehVmVwgcoT830iPyedO9ZmlqR
 fhwXwqIsowfHkWoO3uq6rChKuN3+AEI3sfk+TSfvA6g/+7ORELpL6b1OcpQ1C+DNtZO61Io6/pq
 xpiEtstP+ewfXmhz6WY0UldU3z3J+lt1t0e067x98BU5xEfknVeAvSgAfksXGGWosCdqkI2b7Rx
 jAbgG6LRtUdY0GsYF973Se0qSLqyaBW3ej+bJMnsWJV5A/ae4TE+EqW3PBruik1ugiELRQycPWD
 Hh5E/6jIFpIbknhWYvuKHxE5zXoX8xECa8va5wufiOV81C1aKoHpp1Q==
X-Received: by 2002:a05:7300:6d23:b0:304:bd90:b88f with SMTP id
 5a478bee46e88-30c0798b7ddmr6028417eec.9.1782024726297; 
 Sat, 20 Jun 2026 23:52:06 -0700 (PDT)
X-Received: by 2002:a05:7300:6d23:b0:304:bd90:b88f with SMTP id
 5a478bee46e88-30c0798b7ddmr6028390eec.9.1782024725503; 
 Sat, 20 Jun 2026 23:52:05 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm5510739eec.15.2026.06.20.23.51.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jun 2026 23:52:04 -0700 (PDT)
Message-ID: <829e6103-7f82-4884-9892-86cfb7b743bb@redhat.com>
Date: Sun, 21 Jun 2026 16:51:55 +1000
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
 <3f58de99-74a2-4ccc-b800-d254bbd40931@redhat.com>
 <20260619004237-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260619004237-mutt-send-email-mst@kernel.org>
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

On 6/19/26 3:33 PM, Michael S. Tsirkin wrote:
> On Fri, Jun 19, 2026 at 10:44:17AM +1000, Gavin Shan wrote:
>> On 6/17/26 5:14 PM, Michael S. Tsirkin wrote:> This is a top post attempting to summarize some findings related to
>>> emulating DMA and MMIO existing in QEMU memory core
>>> using memcpy/memmove.
>>>
>>> Hopefully, this will help inform discussion about multiple
>>> changes currently proposed for QEMU.
>>>
>>> At a high level, and in a variety of configurations, QEMU gets
>>> DMA requests from a virtual device, or MMIO requests from
>>> a VCPU, and wants to execute them either on guest ram or
>>> passhtrough device memory.
>>>
>>> Down the road this almost always (virtio ring implementation seems to be
>>> a notable exception) translates to memcpy/memmove calls
>>> (glibc e.g. on x86 currently implements memcpy through memmove).
>>>
>>> However, memcpy's signature is:
>>>          void *memcpy(void *dest, const void *src, size_t n);
>>> note how neither src not more importantly dest are volatile.
>>> Thus it was never designed either for a concurrent access
>>> by another CPU, or for accessing devices.
>>> (Mis)using it for that gives good performance but has issues,
>>> some of which I am trying to enumerate below.
>>>
>>> In the below I say memcpy but same applies to memmove just as well.
>>>
>>
>> Firstly, thanks to Michael for the summary and helps to lead the discussions.
>>
>> I went through the listed questions and suggestions, but I'm not sure if
>> I understood every question and suggestion.
>>
>> Figured out that we probably
>> need to something as below. Please take a look when you get a chance to
>> check if there are any gaps.
>>
>> S1: New field MemoryRegion::cache_mode to indicate how it has been mapped
>>      for those directly accessible regions: cache_{normal, writecombine, no}
>>      corrresponding to pgprot_{normal, writecombine, noncached}.
>>
>>      S1.1 MemoryRegion::cache_mode is meaningful to those directly accessible
>>           regions like ram, ram device and rom device regions
>>      S1.2 MemoryRegion::cache_mode should be set when those directly accessible
>>           regions are created
>>      S1.3 Only cache_{normal, writecombine} regions can be directly accessible
> 
> What is "directly accessible" here? That all memory ops thinkable work?
> E.g. on power8 not all ops work on pgprot_writecombine, either (and glibc memcopy
> uses these).
> I am not 100% sure that's a sane userspace API. It's an internal kernel one.
> If we are mirroring kernel, we need to include pgprot_device - the CDX vfio
> driver uses it.
> 
> But if you want to know what memory instructions work from userspace, there is
> a lot of detail and pgprot_ macros do not cover all of them.
> 

A region is 'directly accessible' when memory_access_is_direct() returns true
for it. The accesses to the directly accessible regions are turned into memcpy()
and memmove() in flatview_{read, write}_continue_step(), or {ldm, stm}_p() in
address_space_{ldm, stm}_internal(). Currently, the mmapable VFIO PCI BARs are
exposed as ram device regions, which are indirectly accessible. One of our goals
is to make part of the mappable VFIO PCI BARs (not all of them) directly accessible,
so that the DMA bounce buffer is bypassed when the DMA target buffer resides in
the BAR (region).

Yes, I don't know if pgprot_xxx is adequate or not, but it's just the thought. We
probably need more information like the combination (host_arch, guest_arch, pgprot_xxx).
The idea is to have more information fed to MemoryRegion and our private accessing
functions, which are mentioned in S2 to replace the standard memcpy() and
memmove(), know which instructions are safe to use, if vector instructions can
be used, and whatever else.

I don't think we can do everything in one shot. Initially, we probably just provide
a sustainable design (or inrastructure) for long-term evolving. From there, we can
extend it to other architectures and cases step by step.

     #if defined(__x86_64__) || defined(__aarch64__)
     #define RAM_DEVICE_REGION_CAN_BE_DIRECTLY_ACCESSIBLE  1
     #define USE_OUR_OWN_MEMCPY_AND_MEMMOVE                1
     #else
     #define RAM_DEVICE_REGION_CAN_BE_DIRECTLY_ACCESSIBLE  0
     #define USE_OUR_OWN_MEMCPY_AND_MEMMOVE                0
     #endif

we also can put more constraints to S1.3 so that only cache_normal
MMIO region can be directly accessible.

     S1.3 Only cache_normal regions can be directly accessible. The question
          is the cache_normal MMIO region is tolerant to unaligned and vectored
          access on all architectures?

> 
>> S2: qemu_ram_{copy, move}() which are our private implementations of memcpy()
>>      and memmove(). They're going to replace memcpy/memove() in the memory
>>      region directly access paths like flatview_{read, write}_continue_step()
>>
>>      S2.1 Small fixed length (1/2/4/8 bytes) accesses shouldn't be either
>>           split or reordered
>>      S2.2 Arcitectural optimization based on the MemoryRegion::cache_mode,
>>           unaligned accesses and vector instructions may be allowed
> 
> hmm. meaning what exactly?
> 

glibc::{memcopy, memmove}() aren't reliable. There are several related bugs,
as you listed. For [1], where one-byte-store is translated to triple stores
to same location. it seems we have to bypass glibc::memcopy(), at least for
some cases? If so, we need our own (well-behaved) memcpy/memmove(), and
qemu_ram_{copy, move}() are our own implementations to replace memcpy/memmove()
in the direct access paths.

     [1] example of a bug caused by memcpy as result of DMA
         https://lore.kernel.org/qemu-devel/20260527091711.3901-1-liugang24219@sangfor.com.cn
     [2] an attempt to fix bugs caused by memcpy to device memory in response to
         MMIO. 4a2e242bbb "memory: Don't use memcpy for ram_device regions"
         https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg08129.html

>>
>> S3: Support VFIO_REGION_INFO_CAP_MMAP_CACHE_MODE where cache_{normal,
>>      writecombine, no} is provided for every mmapable region or all
>>      sparse mmaps on the region
> 
> seems like you are trying to drive the cache mode from userspace?
> but how will userspace know what to set?
> I'd expect, instead, to just have VFIO report how it is mapped.
> 

No, the capability should be reported by host's VFIO PCI driver. For my GH100
specific case, it's nvgrace_gpu_vfio_pci driver where this capability is reported.

  
>>
>>      S2.1 The capability is only meaningful when VFIO_REGION_INFO_FLAG_MMAP
>>           is absent
>>      S2.2 All sparse mmaps for one specific region should have unified cache
>>           mode
> 
> you can not trust userspace to do that.
> 

See above explanation. We don't trust userspace to do it. Instead, the host's
VFIO PCI driver needs to report it.

>>
>>>
>>> ------------------
>>>
>>> 1. On x86, memcpy is different from __builtin_memcpy if
>>> one uses old 1.0 force-headers from 2019. Thus, QEMU
>>> sometimes uses __builtin sometimes it does not, inconsitently.
>>> Likely no longer relevant and should be cleaned up.
>>>
>>
>> S2. old 1.0 force-headers won't be used with S2?
>>
>>>
>>> 2. variable length memcpy can translate 2,4,8 byte guest access
>>> into multiple byte accesses. doing this for mmio is
>>> guaranteed to break devices.
>>>
>>
>> S2.1. However, is it still a problem when the MMIO region is mapped with
>> pgprot_{normal, writecombine}?
> 
> MMIO as pgprot_{normal, writecombine} will break devices whatever
> userspace does.
> 

If we're going to introduce something similar to linux-kernel::readl/writel(),
and use them to access MMIO region, it should be fine then?


> 
>>>
>>> 3. (theoretical concern) also on x86, unaligned accesses are possible on guest and host,
>>> so converting an unaligned access to a series of aligned ones can
>>> in theory break devices.
>>>
>>
>> S1.3, the directly accessible regions have attribute cache_{normal, writecombine}
>> where unaligned access is allowed. The question is unaligned access on those
>> regions are always safe on all architectures?
> 
> Define "directly accessible regions". Or better, avoid even thinking
> in these terms.
> 

Please see my explanation above.

> 
>>> 4. also on x86, vector instructions for large (>16 byte) writes
>>> into pgprot_noncached memory are safe and faster than multiple 8 byte
>>> ones.
>>>
>>
>> S1.3, region with pgprot_noncached is indirectly accessible.
>>
>>> 5. also on x86 it so happens that if you write a fixed-size memcpy this
>>> gets optimized to a single store/load and it works for aligned and
>>> unaligned addresses on that architecture. How to ensure this keeps being
>>> correct is left as an excerise for the reader. But qemu already relies
>>> on this and did for years.
>>>
>>
>> Sorry, Not fully understood.
> 
> 
> what is unclear? on x86, and some others, glibc will see size 1,2,4 and
> maybe 8 of 64 and inline memcpy and it happens to do exactly a single
> load/store.  and code in bswap.h relies on this to mirror guest MMIO on
> the host. So assuming that is it least not regressing too much.
> 

Ok. So you're saying that __builtin_{memcpy, memmove}() aren't safe for MMIO
accesses? All the functions in bswap.h, based on __builtin_{memcpy, memmove}(),
are only safe to RAM accesses, but unsafe to MMIO accesses?

Currently, ram_device_mem_ops::memory_region_ram_device_write() runs into
stn_he_p() and then __builtin_memcpy(), which aren't safe to access to VFIO PCI
BARs. This path wasn't considered in the proposed design and something needs
to be considered in the revised design. For this, I'm going add the following
context to the design.

S1: A new set of functions added to include/qemu/io.h, similar to linux/
     include/asm/io.h::{read,write}{b, w, l q}() to access MMIO region

     S1.1 Those new fuctions will be used to access MMIO region
          S1.1.1 Directly access paths in address_space_{ldm, stm}_internal(),
                 to replace {ldm, stm}_p().
          S1.1.2 Directly access paths in flatview_{read, write}_continue_step()
                 to replace memcpy() and memmove().
          S1.1.3 Indirectly access paths where MemoryRegionOps is invoked, to
                 replace {ldn, stn}_he_p() or their RAM access variants if the
                 region is a MMIO region.

> 
> 
>> It's perhaps covered by S2 if we're talking
>> about address_space_{read,write}. If we're talking about address_space_{ldl, stl}(),
>> we perhaps need to replace __builtin_{memcpy, memmove}() with those private
>> functions introduced in S2.
> 
> Not sure what "covered" means.
> 

Ok, it's not important now since the paths invokved by those functions in bswap.h,
which target a MMIO region, aren't considered in the proposed design.

> 
>>
>>> 6. on non-x86 both unaligned accesses and vector instructions
>>> for accessing  UC memory are illegal.
>>>
>>
>> Assume UC is equivalent to pgprot_noncached. In that case, it's true on aarch64
>> at least. With S1.3 applied, this kind of region becomes indirectly accessible.
>>
>>> 7. standard vfio gives KVM VM_ALLOW_ANY_UNCACHED, so even on non x86
>>> guest can
>>> map the memory as as pgprot_noncached/ioremap or pgprot_writecombine/ioremap_uc.
>>> If it does the second then it can use unaligned or vector for access.
>>> This is why normal passthrough tends to work - it never traps to qemu at
>>> all.
>>>
>>>
>>> But for qemu, vfio uses  pgprot_noncached unconditionally so qemu
>>> can't use unaligned or vector instructions on non-x86.
>>>
>>
>> VM_ALLOW_ANY_UNCACHED is exclusively to arm64 since commit 8c47ce3e1d2c ("KVM:
>> arm64: Set io memory s2 pte as normalnc for vfio pci device). After that, all
>> VFIO PCI BARs have pgprot_writecombine attribute on arm64, thus unaligned or
>> vector accesses are safe on those BARs from guest POV instead of host.
> 
> But not e.g. on power8, sadly.
> 

Ok. With more constraints applied to S1.3 as I mentioned above, only cache_normal
regions can be directly accessible, I guess power8 will be happy with unaligned
and vector access?

     S1.3 Only cache_normal regions can be directly accessible. The question
          is the cache_normal MMIO region is tolerant to unaligned and vectored
          access on all architectures?

>> I maybe
>> wrong and Alex can correct me.
>>
>> S1.3 only cache_{normal, writecombine} regions can be directly accessible.
>> A region with pgprot_noncached attribute is indirectly accessible.
>>
>>>
>>> 8. But for nvgrace RAM, vfio has a driver that uses pgprot_writecombine/ioremap_uc.
>>> so qemu could safely use unaligned/vector instructioons even on non-x86.
>>>
>>
>> For my specific case related to GH100 card, Region-0/2 have pgprot_writecombine
>> while Region-4 has pgprot_normal attribute.
>>
>>    Region 0: Memory at 44080000000 (64-bit, prefetchable) [size=16M]
>>    Region 2: Memory at 44000000000 (64-bit, prefetchable) [size=2G]
>>    Region 4: Memory at 42000000000 (64-bit, prefetchable) [size=128G]
>>
>>
>>> 9. Except sadly, vfio currently does not tell qemu how it maps
>>> the memory, so qemu can not know what is safe on non-x86.
>>>
>>
>> S3. Host VFIO driver needs ABI changes to expose the cache mode.
>>
>>> 10. on x86 memcpy will sometimes do multiple overlapping stores when
>>> size is not a power of 2. for example, a 15 byte write is done with
>>> 2 8-byte stores. This is theoretically an issue
>>> if guest does something super clever with ordering,
>>> but does not seem to be in practice.
>>>
>>
>> S2. This should be avoided in qemu_ram_{copy, move}() which are going to replace
>> the standard memcpy() and memmove().
>>
>>
>>> 11. on non-x86 memcpy will do multiple overlapping stores even
>>> for single byte writes. E.g. it does it to avoid extra branches.
>>> This is causing issues in practice.
>>>
>>
>> S2, This should be avoided in qemu_ram_{copy, move}().
>>
>>
>>> 12. PCI writes are in order, last byte is written last.
>>> memmove especially writes last byte first sometimes.
>>> Violating that theoretically can break guests.
>>>
>>
>> S2, the reordering should be avoided in qemu_ram_{copy, move}(). However,
>> I would think this region becomes indirectly accessible with S1.3 applied?
>>
>>
>>> 13. but if we are copying between 2 addresses that are overlapping,
>>> the standard trick (used by memmove) is to compare dst and src and copy
>>> backwards if dst < src, so last byte is written first.
>>>
>>
>> Backwards copying happens on (dst > src) not on (dst < src). We potentially
>> convert this to a forwards copying by moving the data in the overlapped area
>> to somewhere else, and then take that as the src in the subsequent forwards
>> copying.
> 
> Not that simple. Issue is, the size of the overlap is not really limited.
> Maybe make last X bytes go through the buffer, the rest copy backwards and hope for the best?
> 

I guess it would work with luck. Alternative, it can be converted to two
forwards copying. The source buffer is split into two parts, the second
part of the source buffer is copied before the first part.

> 
>> I think it's unliekly to be a directly accessible region with S1.3 applied.
> 
> No, this does not have much to do with how the region is mapped.
> If guest or device write bytes 1 to X in order and you decide to
> write them X to 1, you have broken some drivers, unless you know
> exactly how the device and driver are supposed to work.
> 

Ideally, we should disallow data movement between two overlapped MMIO regions.
In APIs of linux kernel like readl/writel, one of the operand always resides
in RAM, the source/destination are never overlapped.

> 
>>
>>> -------------
>>>
>>>
>>>
>>> Some conclusions:
>>>
>>> A. on x86, we must avoid converting 2,4,8 byte accesses into byte accesses.
>>> At least for aligned, perferably for unaligned accesses too.
>>> Fixed width memcpy seems to work for this. Whether we should bother with
>>> __builtin to work around broken old fortify headers, I donnu.
>>> I do not have any answer how to check that compiler does this correctly.
>>> If anyone is motivated enough, adding a GCC builtin could be possible.
>>> Given qemu did this for years, I think we can leave solving this for
>>> another day.
>>>
>>
>> Covered by S2.1
>>
>>> B. Also on many architectures, memcpy is much faster for large transfers
>>> than iterating over 8 byte chunks in C.
>>> When we can get away with doing that (e.g. for emulated devices where
>>> we know the concurrency rules, writing into guest RAM), we should.
>>>
>>
>> S2.2, something related to performance optimization for the future
>>
>>> C. on non-x86, we currently must not memcpy into host devices
>>> since we do not know if it is pgprot_noncached. yes, performance will be
>>> bad for DMA into device RAM.
>>>
>>
>> S1.3. This specific region becomes indirectly accessible after S1.3 is applied.
>>
>>>
>>> D.  It goes without saying that casting an unaligned address to unint32_t
>>> (be it for qatomic_set or whatever) is undefined behaviour in C
>>> and so a bad idea on any architecture.
>>>
>>
>> S1.3. The directly accessible region always have cache_{normal, writecombine}
>> attribute.
>>
>>>
>>> E. also for non-x86, we really should teach vfio to tell qemu whether
>>> it maps device pgprot_noncached or pgprot_writecombine.
>>> we will then be able to do things like use vector ops
>>> (through memcpy or not) for >8 accesses.
>>>
>>
>> S3. pgprot_normal is also needed. In my case related to GH100 card, the PCI
>> BAR-4 is mapped with pgprot_normal.
>>
>> Yes, with those information fed to MemoryRegion::cache_mode in S1, it's
>> possible to optimize qemu_ram_{copy, move}() in S2.2 for the performance sake.
>>
>>
>>> F. Arbitrary device passthrough with drivers doing unalined accesses and
>>> when working cross architectures basically is a best effort thing.  It
>>> can't be 100% perfect for all devices.
>>>
>>
>> Yes. For the first step, we perhaps need to gurantee the directly accessible region
>> have pgprot_{normal, writecombine} in S1.3 if you agree.
> 
> I do not know what "directly accessible" is and I feel we should get
> out of the habit of thinking in these terms.
> VFIO likely DTRT mapping already, and userspace really has no
> business overriding it.
> 

Sorry that I didn't explain 'directly accessible', which has been explained at
the beginning of this reply.

> 
>>>
>>> --------------------
>>>
>>> Links:
>>>
>>>
>>> example of a fix for a bug caused by memcpy to overlapping addresses:
>>> 4a73aee881 - "softmmu: Use memmove in flatview_write_continue"
>>> https://lore.kernel.org/qemu-devel/20230131030155.18932-1-akihiko.odaki@daynix.com
>>>
>>>
>>> example of a bug caused by memcpy as result of DMA:
>>> https://lore.kernel.org/qemu-devel/20260527091711.3901-1-liugang24219@sangfor.com.cn
>>>
>>> an attempt to fix bugs caused by memcpy to device memory in response to
>>> MMIO:
>>> 4a2e242bbb "memory: Don't use memcpy for ram_device regions"
>>> https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg08129.html
>>>
>>

Thanks,
Gavin


