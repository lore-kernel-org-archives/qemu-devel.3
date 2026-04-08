Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C38110F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYc0-0004RV-Vq; Wed, 08 Apr 2026 15:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wAY9y-0000cP-Ta
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:01:54 -0400
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wAMwH-0007bP-5Q
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 03:03:03 -0400
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-128b9b7e3edso2882258c88.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 00:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775631778; x=1776236578; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ruazqCaCoj+XALGHoPdW8tAC9uychZwJljs32C4VAIE=;
 b=nuaZ49OhXKcQyb3yY3N2vThQQ0t5GaTEL6ERTS3Q4EeBK4xSyVN5kfiPUHMFZA466E
 sCJyUPBeAG/aDwJqc2vqH/Jy8UvZNT4Y9c7aS8r6FzhMa4MGtl71hU90DGVAuL8cjNfI
 ZxwA1Hj2rvK9m9Ur0aduld2GMPK/3ZxE6ET664+JDIkfMf6Syn3OR7BlbqeR+KzjLgS7
 aB0MSfgBgAXpwDH8Ji/Qs1qg/gb3DwL3asJ8MS6riQzvQGVIijnDYw+eOU7iO2mBX3qi
 JGG8E0ZO4HTpk26D1BZhPqigTrKZCVi3qD83ntQyxj+cdLY3ZaoqCufnxBmFNbV0h5k2
 Jmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775631778; x=1776236578;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ruazqCaCoj+XALGHoPdW8tAC9uychZwJljs32C4VAIE=;
 b=TXRvwFXNsVo+N8OXLQwQd1U1YhABayUbpjVQppOZqQHiBRr6Zou355v6zKP/hlVM63
 kkGMhSjHz91sKuaL9UNhn12oxTxo/b07KPxZtDmuzpyIo3ZC06nN1LOHS8tPb5HUxCTT
 FI41pEQdSglRJHM7KRdClLskJ+RnWzJbRileLX8boAIk7TzPirXIdFaVoZMhR2xkgoov
 ZG/rwYMqYHQr7N51ss8dEsnw1vESYd1RF1q8pyiVeSoEHNpwjhuYnola87M49J8NgF5y
 xQ3nCdiqeg0FjxnvbDi1CNNXJoRqpIYaa6R4tqn6ZcBRGrVHEImfiFj2bg/wQPkJ6wj1
 ANGg==
X-Gm-Message-State: AOJu0Ywj6VZ07w1+r2FC5XDPuJYM3D1dE3zwQtX4h1/RlIjxF9Nq6RZe
 RajKjnCN8cXXHXexRWGQXFMldXvF3m8zAYK+NTbJTc8x15qZH0ovMOJZ
X-Gm-Gg: AeBDieuxqlr/Pj0rAJRoHthdLYZwOYKL93oFXB2AfpYByyAfMef+rRJAu6OZe2YvPDF
 ga7xnplJroaVYsISUvDIExtg38mD8+6TxZbcPlxs3CQT7TdnaAksiawi10P+fSpVZXsM08/rZrP
 vrr7/AUGV1GuLm3cM510gLj0P3qtf/zaU0j+RRY3FJLZGuJ70C7O6q2uBDMNIT53MyNdYKun/iE
 /IrQeQEOYM+DV8vMJIld+W5VJsigLJJQK/sXGqroHZU3HhaEqhSllNLH5Fl3lIu63W0fhrLORCq
 Xz/DXbr8tq0FmvlGLnc12J4W8AoIL/zyzDFb+PdJdUsNCzYL3mtYnKpEnw1nqcHIK2bbkVbPQa6
 E3M75mJ4iWybzrck9H77qnjS2RUXRZhUh7ndW/uKewiePSFHGM8QmsYhXH6p74LK0uEwXa4jCt+
 oWUp4IsAQpgt6XP3zXX6wRIFxwGUVuOJxqh5rHcqKA2N3yxCffWvX96nP95vs1LdabLJZ22/PwS
 E0TL3RbJIc=
X-Received: by 2002:a05:7300:dc8e:b0:2cb:8d2f:e247 with SMTP id
 5a478bee46e88-2cbfa4c488bmr10817290eec.13.1775631777893; 
 Wed, 08 Apr 2026 00:02:57 -0700 (PDT)
Received: from localhost ([2601:645:8200:47:a1bd:9754:418f:9b37])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2cc0c6ec215sm17788943eec.4.2026.04.08.00.02.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 00:02:57 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Apr 2026 00:02:55 -0700
Message-Id: <DHNKXKNWFI3S.P78ERGSFU3RQ@gmail.com>
Cc: <qemu-devel@nongnu.org>, <alex@shazbot.org>, <clg@redhat.com>,
 <pbonzini@redhat.com>, <rbolshakov@ddn.com>, <phil@philjordan.eu>,
 <mst@redhat.com>, <john.levon@nutanix.com>, <thanos.makatos@nutanix.com>,
 <qemu-s390x@nongnu.org>
Subject: Re: [RFC PATCH 00/10] vfio: PCI device passthrough on Apple Silicon
 Macs
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: "Mohamed Mediouni" <mohamed@unpredictable.fr>, "Scott J. Goldman"
 <scottjgo@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260405072857.66484-1-scottjgo@gmail.com>
 <A7F5F3BA-1008-4F21-A103-3079DC511292@unpredictable.fr>
 <EE710653-F4AF-4C1B-A9B0-C9ADE7EB01F1@unpredictable.fr>
 <DHLLUP2OY18O.1HYC4V18K7IH1@gmail.com>
 <67BA415D-4D1A-4F68-9429-284309EE96C0@unpredictable.fr>
In-Reply-To: <67BA415D-4D1A-4F68-9429-284309EE96C0@unpredictable.fr>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1233;
 envelope-from=scottjgo@gmail.com; helo=mail-dl1-x1233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun Apr 5, 2026 at 5:16 PM PDT, Mohamed Mediouni wrote:
>
>
>> On 6. Apr 2026, at 01:20, Scott J. Goldman <scottjgo@gmail.com> wrote:
>>=20
>> On Sun Apr 5, 2026 at 1:14 AM PDT, Mohamed Mediouni wrote:
>>>=20
>>>=20
>>>> On 5. Apr 2026, at 10:01, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>>>>=20
>>>>>=20
>>>>> On 5. Apr 2026, at 09:28, Scott J. Goldman <scottjgo@gmail.com> wrote=
:
>>>>>=20
>>>>> This series adds VFIO PCI device passthrough support for Apple Silico=
n
>>>>> Macs running macOS, using a DriverKit extension (dext) as the host
>>>>> backend instead of the Linux VFIO kernel driver.
>>>>>=20
>>>>> I'm sending this as an RFC because I'd like feedback before investing
>>>>> further in upstreaming.  The code is functional.  I've tested it with
>>>>> an NVIDIA RTX 5090 in a Thunderbolt dock on an M4 MacBook Air.  GPU
>>>>> gaming works but is slow (~30 fps on high settings in Cyberpunk 2077
>>>>> [1]), likely due to the BAR access penalty described below.  AI
>>>>> inference workloads appear less affected.  Ollama with Qwen 3.5
>>>>> generates around 140 tok/sec on the same setup [2].
>>>>>=20
>>>>> How it works:
>>>>>=20
>>>>> On Linux, VFIO relies on kernel-managed IOMMU groups and /dev/vfio
>>>>> for device access and DMA mapping.  On macOS, there is no equivalent
>>>>> kernel interface.  Instead, a userspace DriverKit extension
>>>>> (VFIOUserPCIDriver) mediates access to the physical PCI device throug=
h
>>>>> IOKit's IOUserClient and PCIDriverKit APIs.
>>>>>=20
>>>>> The series keeps the existing VFIOPCIDevice model and reuses QEMU's
>>>>> passthrough infrastructure.  A few ioctl callsites are refactored int=
o
>>>>> io_ops callbacks, the build system is extended for Darwin, and the
>>>>> Apple-specific backend plugs in behind those abstractions.
>>>>>=20
>>>>> The guest sees two PCI devices: the passthrough device itself
>>>>> (vfio-apple-pci, which subclasses VFIOPCIDevice) and a companion
>>>>> DMA mapping device (apple-dma-pci).  On the QEMU side, an
>>>>> AppleVFIOContainer implements the IOMMU backend, and a C client
>>>>> library wraps the IOUserClient calls to the dext for config space,
>>>>> BAR MMIO, interrupts, reset, and DMA.
>>>>>=20
>>>>> DMA limitations:
>>>>>=20
>>>>> This is the biggest platform constraint.  Unlike a typical IOMMU
>>>>> mapping operation where the caller specifies the IOVA, the
>>>>> PCIDriverKit API (IODMACommand::PrepareForDMA) returns a
>>>>> system-assigned IOVA.  There is no way to request a specific address.
>>>>> This means the guest's requested DMA addresses cannot be used
>>>>> directly.  The guest kernel module must intercept DMA mapping calls
>>>>> and forward them through the companion device to get the actual
>>>>> hardware IOVA.
>>>>=20
>>>> Hello,
>>>>=20
>>>> Ugh this one is not great. By the way, Apple has a private PCIe passth=
rough
>>>> API used by Virtualization.framework but that's a different design.
>>=20
>> This is really interesting and I had not heard about this. Are you
>> able to elaborate on this one at all? Maybe this is something where an
>> internal API to manipulate the DART is available inside
>> Virtualization.framework?
>
> Hello,
>
> All of it needs using private entitlements currently.
>
> It's _VZPCIPassthroughDeviceConfiguration, a private class needing com.ap=
ple.private.virtualization to use.
>
> The VMM process itself then uses the com.apple.private.PCIPassthrough.acc=
ess entitlement. I'm not
> sure whether OS versions even have all the code currently though.
>

Appreciate the pointers here. It looks like, as you said, the framework
taps into a bunch of code that isn't shipped to us mere mortals. I can
see from some of the code in Virtualization.framework the general shape
of what they're doing, though.

It looks like they implement a virtio-iommu device that ultimately calls
into the host kernel with some internal APIs to do the DART mappings.=20

>>>> Would bounce buffering using something akin the confidential compute p=
ath and=20
>>>> a pre-defined chunk of host memory accessible from the device, and the=
n managing
>>>> the guest address map work? (see swiotlb).
>>=20
>> I tested this approach early on, but ran into a couple issues:
>>=20
>> 1. Not only does PrepareForDMA() limit the total size of the pool, but
>>   it also limits the size of individual allocations. IIRC it not very
>>   large at around 16MB.
> Sigh.
>
>> Thankfully, I found that the allocator seemed
>>   to just keep allocating continguously across multiple allocations, so
>>   maybe that's fine?
> That's good=E2=80=A6 but it sounds brittle=E2=80=A6
>
>> 2. Linux swiotlb default configuration is too small for GPU drivers. The
>>   max single mapping is 256KB and the total pool size is 64MB. The
>>   overall pool size is configurable but the max single mapping is
>>   derived from IO_TLB_SEGSIZE and IO_TLB_SIZE which are compile-time
>>   constants. During games, I have seen roughly ~900MB of active DMA
>>   mappings and mappings much larger than 256kb.
>
> Pre-defined mappings with restricted-dma-pool sound like a good idea ther=
e.
>>=20
>> I abandoned this approach because it seemed like the CPU penalty of
>> bouncing all the DMA buffers would be pretty severe and the swiotlb
>> allocator just didn't seem designed for this much memory pressure. I
>> also was hoping to avoid the requirement of recompiling the entire guest
>> kernel as a prerequisite for guests to use this passthrough feature. On
>> top of that, I wasn't sure if upstream would even be willing to take
>> changes to support this use case, since it's so far outside what the
>> existing swiotlb allocator would normally be doing.
>>=20
>> That said, you were saying that CoCo is fine with this restriction? Do
>> other devices just not have drivers that are doing so much allocation? I
>> didn't actually try changing the constants and recompiling the guest
>> kernel in swiotlb to make the pool big enough for it to really work at
>> all with the nvidia guest driver, I will have to see what happens.
>
> CoCo with bounce buffering works with NVIDIA GPUs. It had to be done beca=
use
> no trusted I/O path (and implementing that is a quagmire).
>
> A recent Intel post about it claiming production-readiness:
>
> https://community.intel.com/t5/Blogs/Tech-Innovation/Artificial-Intellige=
nce-AI/Confidential-AI-with-GPU-Acceleration-Bounce-Buffers-Offer-a/post/17=
40417

I dug in here and implemented the restricted-dma-pool solution. Still
needs some cleanups but it's working enough to test. To start with the
bad news:

1. As I mentioned previously, the mainline kernel has a max 256k limit
for any single swiotlb mapping. This has been debated a few times on
LKML, but the consensus has been generally that it should not be changed
or made configurable. You can see the threads:
  - https://lkml.org/lkml/2015/3/3/84
  - https://patchwork.kernel.org/project/linux-mips/patch/20210914151016.31=
74924-1-Roman_Skakun@epam.com/

2. NVIDIA drivers immediately make a contiguous 528384 byte allocation,
at least on my hardware (NVIDIA RTX 5090), which is required as part of
initializing the firmware on the card. This obviously fails immediately.
It happens on both the NVIDIA-provided "open" drivers[1] and the in-tree
`nouveau` [2], so it's more a hardware-specific issue than just a driver
problem. If you hack around that (allocate 3 smaller buffers and hope
they are contiguous), you'll see that both drivers assume coherent DMA
memory (moreso in the nvidia driver than nouveau, but it's a problem in
both). They map DMA buffers and then write data into the buffers
afterward. So you end up sending empty swiotlb buffers to the card and
it'll ultimately fail to initialize.

It's possible the press release was referring to using the closed NVIDIA
drivers, but those are now deprecated and don't support my newer GPU.

But, there is good news:

1. The IOVA range that seems to always come from PCIDriverKit is pretty
far outside the default qemu mapping from `-machine virt`, so the range
can be cleanly identity mapped in the VM without overlap. One of the
restrictions I noted earlier (16MB max contiguous mapping) was actually
just a bug in my code. A large contiguous mapping seems to work fine,
though the ~1.5GB limit is still real.

2. restricted-dma-pool DT attribute can be assigned per-device. So it
doesn't affect other drivers on the system, and potentially that means
you can have different pools for multiple devices (have not actually
tried this yet, but seems like it would work).

3. More normal devices can work. I purchased a thunderbolt nvme
enclosure and it works with the swiotlb bounce buffering with no kernel
modifications.

4. With a sufficient amount of hacks in the driver, the NVIDIA "open"
driver can be made to work, albeit with already slow gaming performance
reduced to about 30% (~10fps) vs paravirt dma mapping (~30fps). I wasn't
able to get CUDA working, but presumably that just needs more elbow
grease.

After sleeping on this a bit, I think my proposal would be:

- The `restricted-dma-pool` method can be the default. For most devices
  this will work seamlessly, though users may have to specify a size for
  the pool, since the optimal size will vary for each device.

- The apple-dma-pci thing can be downgraded from an actual device to an
  out-of-tree workaround. I have not yet tested it, but presumably it
  can use ivshmem or a virtual serial port to communicate the mappings.
  It's mostly a guest-side hack so it doesn't really need qemu
  involvement necessarily.=20

- I doubt Apple will actually approve this for distribution, but I can
  write a kext that uses the kernel API to manipulate the DART directly.
  I didn't realize this was an option before. This can act as kind of a
  companion for my dext and as follow-on to this patchset, I can teach
  the vIOMMU device to use it. Eventually if Apple exposes this as
  something you can use in a dext, then the functionality can be moved
  into the dext and all of these concerns become moot. Until then, it
  can be an optimization if you're willing to run without SIP.

If you think this is OK, I can prepare a new version of the patchset.

Thanks,
-sjg

[1] https://github.com/NVIDIA/open-gpu-kernel-modules/blob/main/src/nvidia/=
src/kernel/gpu/gsp/kernel_gsp.c#L5404
[2] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/nouveau/n=
vkm/subdev/gsp/rm/r535/gsp.c#L1827


