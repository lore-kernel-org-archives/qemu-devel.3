Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E212BE9D80D
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 18:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9S1f-0003vZ-Gz; Sun, 05 Apr 2026 14:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9S1X-0003uF-T3
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 14:16:40 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9S1W-0004TY-2w
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 14:16:39 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-2ce7d6fd2c5so193818eec.0
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 11:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775412996; x=1776017796; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3m1Z4UTUM6w2aqa7uxC+K1wnAqGBXUYvLkMEl2uyZKo=;
 b=XLEl8Phs8eevmKPZh+RBc5+7eq8b9N2BFAEI2v6gwPQsk81nT1TfcO5DLcrkQDpYEM
 aRqALBq4azYVfi1G5Ily8scqYNH8KrinsNgaRQYTmX/tCwgPRGkyd2CLNCmBi/6W00qx
 p+/l9DOioV4zAs5LTieT/1EZjq2eIvRpvI3FDoH0yrXjQlXrllTNgJaP1xZSlJAtpYm1
 9L7mOuvlf7wdmbOB9vy4gsMvC2gqnBr2A6cKEkUDW1rXj6QOC/l8J8nsn+0T/vNXoVw6
 0+Qdb8V0EHNHhb/awCDkkU6wTZnNxsyA8uHWXIgoxLJBPZg1TZ0GWMefo8UgrBOJA3+c
 fswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775412996; x=1776017796;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3m1Z4UTUM6w2aqa7uxC+K1wnAqGBXUYvLkMEl2uyZKo=;
 b=SUN+Z76fCq9nUPDP7QLVo8jKhE77IT9SfPk+92zdOo+MrzeP6sWABDMV4ZSv+OHvCD
 GQ0U5/DsHLo4uamqXDPLJwFQnqD6+hMznGELy1PIWdJcKoskIyUKhQkqPaIeWMAOoD8e
 PL3w+8AhzHVghO5x0tT3fdN6V5OR1adss10BjeR1IDKy663RQqGQ+JWrrXNp0yF65JcR
 kd1vx8S0pFvLMAK0UxPHz0E6xBdJuftfyM3ypa/vAAHvHDdBMilrQ/aUcXTQKrohtN4l
 AV4ZEgfskrxZ8DuewccuptgEBKr3DRNBC/V0LWvvePUfZC/t3SYZwVl8XEG10a0gN+Fz
 FTYg==
X-Gm-Message-State: AOJu0YyKl/01xQCSgLCC555Fr2nIiHiGKeTw8Yuu3apMfutn+qzRBFGB
 XRoviQIyyVy4YRy5JsT3Spvfyc8HZWiy0HVZi7DnQKd2jRbR2pOTFyyP
X-Gm-Gg: AeBDietJpaMTsm8ARpyEHuvNSAoa7SKeILkRaKY7D7mVI+y5STozeRD+Eqz1BZqn82X
 Zqm9yZVbVas77Io3Wxkn3KFwKDlZ+oVxcJ58z64gX/xOJbTxuYp5YauWQfMuYOl098RyCJB1Za7
 LZJaNPVEAeigi0FVMw4sffcS2Ls6+mQEGJPTe/v2ernyGXaXrxGTKJpZ2Y3taD+fw0ya9Ai3L2I
 QB+H9akIWYTdIpWxDlMm2Lk41igRIcfs/wACrZRzsJkQhb6Uw5yIX16As2VnGjBwdxclZy2ybPU
 xP+PWafp1Jjic9I4qibSq15X+DdGrBc8a8oJ14Fo9LcZfRligrt3B51iFHt//AwqWAARTI0Fhlr
 mXLQmpB5Vq0rXiltqLZ1w+VkQ5rC8+UpM9Fq6p5ykJg89jxftZ02Cwd+0CtIdPlWAe9zCtkYkxh
 v63E1gIg9upSLNrjCcNQ6EytSMszL5nDecwRDKl0ZYmSlMjqpxpb+3knqwub4FNnXpwoogQHtBF
 BbfXGxwdyU=
X-Received: by 2002:a05:693c:2b14:b0:2a4:701a:b9ba with SMTP id
 5a478bee46e88-2cbfbe7c7damr3348809eec.14.1775412996343; 
 Sun, 05 Apr 2026 11:16:36 -0700 (PDT)
Received: from localhost ([2601:645:8200:47:d85c:429c:5cc7:1e52])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca760b0518sm11397906eec.0.2026.04.05.11.16.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 11:16:35 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Apr 2026 11:16:34 -0700
Message-Id: <DHLFDPXWKQ28.2VAETSR1R1DWE@gmail.com>
Subject: Re: [RFC PATCH 00/10] vfio: PCI device passthrough on Apple Silicon
 Macs
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Scott J. Goldman"
 <scottjgo@gmail.com>
Cc: <qemu-devel@nongnu.org>, <alex@shazbot.org>, <clg@redhat.com>,
 <pbonzini@redhat.com>, <rbolshakov@ddn.com>, <phil@philjordan.eu>,
 <mst@redhat.com>, <john.levon@nutanix.com>, <thanos.makatos@nutanix.com>,
 <qemu-s390x@nongnu.org>
X-Mailer: aerc 0.21.0
References: <20260405072857.66484-1-scottjgo@gmail.com>
 <f0a13985-e737-b06a-773d-cddb90444721@eik.bme.hu>
In-Reply-To: <f0a13985-e737-b06a-773d-cddb90444721@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=scottjgo@gmail.com; helo=mail-dy1-x1336.google.com
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

On Sun Apr 5, 2026 at 3:36 AM PDT, BALATON Zoltan wrote:
> On Sun, 5 Apr 2026, Scott J. Goldman wrote:
>> This series adds VFIO PCI device passthrough support for Apple Silicon
>> Macs running macOS, using a DriverKit extension (dext) as the host
>> backend instead of the Linux VFIO kernel driver.
>>
>> I'm sending this as an RFC because I'd like feedback before investing
>> further in upstreaming.  The code is functional.  I've tested it with
>> an NVIDIA RTX 5090 in a Thunderbolt dock on an M4 MacBook Air.  GPU
>> gaming works but is slow (~30 fps on high settings in Cyberpunk 2077
>> [1]), likely due to the BAR access penalty described below.  AI
>> inference workloads appear less affected.  Ollama with Qwen 3.5
>> generates around 140 tok/sec on the same setup [2].
>>
>> How it works:
>>
>> On Linux, VFIO relies on kernel-managed IOMMU groups and /dev/vfio
>> for device access and DMA mapping.  On macOS, there is no equivalent
>> kernel interface.  Instead, a userspace DriverKit extension
>> (VFIOUserPCIDriver) mediates access to the physical PCI device through
>> IOKit's IOUserClient and PCIDriverKit APIs.
>>
>> The series keeps the existing VFIOPCIDevice model and reuses QEMU's
>> passthrough infrastructure.  A few ioctl callsites are refactored into
>> io_ops callbacks, the build system is extended for Darwin, and the
>> Apple-specific backend plugs in behind those abstractions.
>>
>> The guest sees two PCI devices: the passthrough device itself
>> (vfio-apple-pci, which subclasses VFIOPCIDevice) and a companion
>> DMA mapping device (apple-dma-pci).  On the QEMU side, an
>> AppleVFIOContainer implements the IOMMU backend, and a C client
>> library wraps the IOUserClient calls to the dext for config space,
>> BAR MMIO, interrupts, reset, and DMA.
>>
>> DMA limitations:
>>
>> This is the biggest platform constraint.  Unlike a typical IOMMU
>> mapping operation where the caller specifies the IOVA, the
>> PCIDriverKit API (IODMACommand::PrepareForDMA) returns a
>> system-assigned IOVA.  There is no way to request a specific address.
>> This means the guest's requested DMA addresses cannot be used
>> directly.  The guest kernel module must intercept DMA mapping calls
>> and forward them through the companion device to get the actual
>> hardware IOVA.
>
> I don't know this so what I say might not make sense but I think there is=
=20
> iommu emulation in QEMU so could that be used to do this in QEMU and avoi=
d=20
> needing a kernel module for it in the guest?
>
> Regards,
> BALATON Zoltan

I think the challenge is that this is a passthrough device doing
DMA directly on the physical PCIe bus.  The device's DMA
transactions go through the real hardware IOMMU (DART), not
through QEMU.

If the guest programs the device with IOVA 0x1000 (assigned by
a virtual IOMMU), the device will issue a DMA read for 0x1000 on
the physical bus.  But DART only knows about the IOVAs that
PrepareForDMA assigned, so the transaction would fault.

My understanding is that on other platforms, this is handled in
a simpler way because the host IOMMU can be programmed directly:

1. Guest boots with 2 GB of RAM.  QEMU maps guest physical
   address (GPA) 0x10000000-0x90000000 to host physical memory
   at, say, 0x110000000-0x190000000.
2. QEMU programs the host IOMMU so the device's view of
   0x10000000-0x90000000 translates to the real host addresses.
3. Guest programs the PCI device to DMA to GPA 0x20000000.
4. The device issues the transaction, the IOMMU translates it
   to 0x120000000, and it hits the right physical memory.

On macOS, step 2 is missing.  The DriverKit APIs don't provide
a way to program arbitrary IOVA-to-HPA translations into DART.
You can only hand a buffer to PrepareForDMA and get back whatever
IOVA the system assigns.

On top of that, the platform limits the total amount of DMA-mapped
memory to roughly 1.5 GB across ~64k mappings, so you can't even
map all of a 2 GB guest's RAM.  I believe this limit comes from
the host device tree and isn't modifiable by users, though it
could potentially be changed by Apple in firmware.

A vIOMMU could reduce the amount of memory that needs to be
mapped (only what the guest actually uses for DMA, not all of
guest RAM), but fundamentally you still need something akin to
step 2 to make the device's physical DMA transactions land at
the right addresses, and we don't have that on this platform.


