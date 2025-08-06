Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95F1C87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 21:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujlgd-00043V-03; Wed, 06 Aug 2025 17:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ujlgZ-00042i-P2
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 17:28:37 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ujlgW-0002OY-Ad
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 17:28:35 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b4233f86067so240758a12.0
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 14:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754515710; x=1755120510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4Sze3anrApepby8gMh+bdCr5CLyj/UOA2PEP9tCjGH8=;
 b=nu2oXpRo+YyrZ3c0mARfVt8MGGfe/b8BGUCRN3t+zjKt1JhfBQmLzwYhxagXop3LG6
 Eb2CcJv7PX23ddR0bLLLVvEaxMM4ErVja3k2UpoZbzIboItNFwYD7Nfxqhbjx5gm0xlo
 kavx+iEgFDDQa4zGOuG+5+7Ug0N4F+KL4454o4UOvOeXEI99fUKtEHD50TN1kxbvkXmn
 idQrfR2A3/JJF0cafM2xWuH4j414DPlkkzWkycIyofMKpMqUf/T4j5oukkZMK5saCntv
 BXHJdQmr4gx9+Rs86lzXan0Op6V9d4g9JHjIH+H2cyFI8SJj8D1H3S04+pPoMgqeLANR
 hSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754515710; x=1755120510;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Sze3anrApepby8gMh+bdCr5CLyj/UOA2PEP9tCjGH8=;
 b=dpCUKIHdC2Jr1wiULy5bBzHXPiCnwLDxv1pdB/deWqkrSpFM7r35IR0ZkVSABzq02M
 kVn924v/B1gD63yj9NoaSTENgTx3G35BFS/F5wb5vVpp3Fi5atjezw2TRVoDqDhOmxQJ
 CXl4Yxcj4MjIVu+xvnRfK2hBwak9TVuNSflm3M3BY9INO3CubJ4nOZaIZkri/nAUdDCP
 G/KOFszekpfyj3JUdNglsBsVXLKn28e+1M7mezWjcqsyBMDaj+8ahALbjQvOPsQhEhGb
 bvOUxlcrDOUN6I2n+F4GoEX9frcN0GVt5zNvaSdupm4svti3qINin4pTPX6yAzfYomIb
 6nHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtatBZv57i2xHDs88D+Rwgh0kVmK+ox1wQXMT7vfHIbHqPsA40WDYucU851XflhLDelvtEJ/heUsML@nongnu.org
X-Gm-Message-State: AOJu0YyqmcIBh2U149DIvLYmBKcHO4g+QT45vFCHJq5OEjaMk3o8udrx
 0ZR2e7SSPGZTCUdRc+qDe6tdcrzdrjtTv8k0rIAgFLIxf94mD5byKeHE1FJfXDZfbiwZxWy4O0l
 NesGhwOg=
X-Gm-Gg: ASbGncvZtNgrnH/B0ry3dnlfySLfbicF1eIoqG7JG8HDSqx5X0EJDqxYABIDaBiFL/Z
 qC6a1MnSqWWu25f6OwYu3wOWV0wEG5cbfES0wgENLasVmIexy0ai2pCGXERAOncZJC5O/AJS61x
 B8NmbtC1+z873yPWbe9NmY/MSmDP0l3MELvYRRSYDQxrQ6hwAJxgky2HshCIPrqeltsMVOIwMIJ
 6X5Bl3wRCKwQ6monfPWvLbiMmZtYiAPxDd2yw057BTfSzLaAIU4hXH7GWCoRvNHjMNY2319LOhX
 QPjpqld8+0uYjOGRcYhm8mg+uBJaj1YFawzvixRIdlPL/iejTRZ+GSLL745xhEuBbgf3tlfWIFr
 oNuJResF8Lh5YqSPX1o/SLRceNy5jSiXrLvk=
X-Google-Smtp-Source: AGHT+IGct/pBi22g3jk9hpqdg27eDeT/wHhFxfN+mc1dIBAMRmGTN08xcaVl/bg9TxzrB/96hBIEJQ==
X-Received: by 2002:a17:903:faf:b0:234:986c:66cf with SMTP id
 d9443c01a7336-242b06b5977mr12114935ad.16.1754515710377; 
 Wed, 06 Aug 2025 14:28:30 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8975cf9sm168857355ad.110.2025.08.06.14.28.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 14:28:29 -0700 (PDT)
Message-ID: <d4fcf3a2-6789-4926-882e-1abac4c07843@linaro.org>
Date: Wed, 6 Aug 2025 14:28:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/11] hw/arm/smmuv3: Add initial support for Secure State
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/6/25 8:11 AM, Tao Tang wrote:
> Hi all,
> 
> This patch series introduces initial support for emulating the Arm SMMUv3
> Secure State.
>
> As Pierrick pointed out in a previous discussion [1], full Secure SMMUv3
> emulation is a notable missing piece in QEMU. While the FVP model has
> some support, its limited PCIe capabilities make it challenging for
> complex use cases. The ability to properly manage device DMA from a
> secure context is a critical prerequisite for enabling device assignment
> (passthrough) for confidential computing solutions like Arm CCA and
> related research such as virtCCA [2]. This series aims to build that
> foundational support in QEMU.
> 

Thanks for posting this series, it's definitely an important piece 
missing for emulating newer SMMU versions.

> This work is being proposed as an RFC. It introduces a significant amount
> of new logic, including the core concept of modeling parallel secure and
> non-secure contexts within a single SMMUv3 device. I am seeking feedback
> on the overall approach, the core refactoring, and the implementation
> details before proceeding further.
>
> The series begins by implementing the components of the secure programming
> interface, then progressively refactors the core SMMU logic to handle
> secure and non-secure contexts in parallel.
> 
> Secure Interface Implementation: The initial patches add the
> secure-side registers, implement their read/write logic, and enable
> the secure command and event queues. This includes the S_INIT
> mechanism and the new secure TLB invalidation commands.
> 
> Core Logic Refactoring: The next set of patches makes the core SMMU
> functions security-state aware. This involves plumbing an is_secure
> context flag through the main code paths and adding logic to route
> SMMU-originated memory accesses to the correct (Secure or Non-secure)
> address space.
> 
> Cache Isolation: With the core logic now aware of security states,
> the following patches refactor the configuration and translation
> lookup caches. The cache keys are modified to include the security
> context, ensuring that secure and non-secure entries for the same
> device or address are properly isolated and preventing aliasing.
> 
> Framework Integration: The final patch connects the SMMU's internal
> security context to the generic QEMU IOMMU framework by using the
> iommu_index to represent the architectural SEC_SID.
> 
> To validate this work, I performed the following tests:
> 
> Non-Secure Regression: To ensure that existing functionality remains
> intact, I ran a nested virtualization test. A TCG guest was created on
> the host, with iommu=smmuv3 and with an emulated PCIe NVMe device assigned.
> Command line of TCG VM is below:
> 
> qemu-system-aarch64 \
> -machine virt,virtualization=on,gic-version=3,iommu=smmuv3 \
> -cpu max -smp 1 -m 4080M \
> -accel tcg,thread=single,tb-size=512 \
> -kernel Image \
> -append 'nokaslr root=/dev/vda rw rootfstype=ext4 iommu.passthrough=on' \
> -device pcie-root-port,bus=pcie.0,id=rp0,addr=0x4.0,chassis=1,port=0x10 \
> -device pcie-root-port,bus=pcie.0,id=rp1,addr=0x5.0,chassis=2,port=0x11 \
> -drive if=none,file=u2204fs.img.qcow2,format=qcow2,id=hd0 \
> -device virtio-blk-device,drive=hd0 \
> -qmp unix:/tmp/qmp-sock12,server=on,wait=off \
> -netdev user,id=eth0,hostfwd=tcp::10022-:22,hostfwd=tcp::59922-:5922 \
> -device virtio-net-device,netdev=eth0 \
> -drive if=none,file=nvme.img,format=raw,id=nvme0 \
> -device nvme,drive=nvme0,serial=deadbeef \
> -d unimp,guest_errors -trace events=smmu-events.txt -D qemu.log -nographic
> 
> Inside this TCG VM, a KVM guest was launched, and the same NVMe device was
> re-assigned to it via VFIO.
> Command line of KVM VM inside TCG VM is below:
> 
> sudo qemu-system-aarch64  \
> -enable-kvm  -m 1024  -cpu host  -M virt \
> -machine virt,gic-version=3 \
> -cpu max -append "nokaslr" -smp 1 \
> -monitor stdio \
> -kernel 5.15.Image \
> -initrd rootfs.cpio.gz \
> -display vnc=:22,id=primary \
> -device vfio-pci,host=00:01.0
> 
> The KVM guest was able to perform I/O on the device
> correctly, confirming that the non-secure path is not broken.
> 
> Secure Register/Command Interface: I set up an OP-TEE + Hafnium
> environment. Hafnium's smmuv3_driver_init function was used to test
> the secure register I/O and command queue functionality (excluding
> translation). As Hafnium assumes larger queue and StreamID sizes than
> are practical without TTST support, I temporarily patched Hafnium to
> use smaller values, allowing its driver to initialize the emulated
> secure SMMU successfully.
>

Would that be possible to share your changes, and build instructions for 
this? While working on SMMU emulation, we finally left this on the side 
due to lack of a software stack being able to use secure SMMU, as we 
were not aware that Hafnium + op-tee could make use of it.

> Secure Translation Path: Since the TF-A SMMUv3 Test Engine does not
> support QEMU, and no secure device assignment feature exists yet, I
> created a custom platform device to test the secure translation flow.
> To trigger the translation logic, I initiated MMIO writes to this
> device from within Hafnium. The device's MMIO callback handler then
> performed DMA accesses via its IOMMU region, exercising the secure
> translation path. While SMMUv3 is typically used for PCIe on
> physical SoCs, the architecture allows its use with platform devices
> via a stream-id binding in the device tree. The test harness
> required some non-standard modifications to decouple the SMMU from
> its tight integration with PCIe. The code for this test device is
> available for review at [3]. README.md with detailed instructions is
> also provided.
>

I am not sure about the current policy in QEMU for test oriented 
devices, but it would be really useful to have something similar 
upstream (Note: it's out of the scope of this series).
One challenge working with SMMU emulation is that reproducing setups and 
triggering specific code paths is hard to achieve, due to the indirect 
use of SMMU feature (through DMA) and the complex software stack usually 
involved.
Having something upstream available to work on SMMU emulation, at least 
on device side, would be a great addition.

Eric, Peter, is this something that would be acceptable to merge?

> I've attempted to follow all of the guidance in the "Submitting a Patch"
> guide, but as this is my first series of this scale, I apologize if I
> missed anything and welcome all feedback.
>
> Thanks,
> Tang
> 
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2025-06/msg02940.html
> [2] https://arxiv.org/abs/2306.11011

I was not aware of it, thanks for sharing this excellent paper.

> [3] https://github.com/hnusdr/qemu
> 
> Tao Tang (11):
>    hw/arm/smmuv3: Introduce secure registers and commands
>    hw/arm/smmuv3: Implement read/write logic for secure registers
>    hw/arm/smmuv3: Implement S_INIT for secure initialization
>    hw/arm/smmuv3: Enable command processing for the Secure state
>    hw/arm/smmuv3: Support secure event queue and error handling
>    hw/arm/smmuv3: Plumb security state through core functions
>    hw/arm/smmuv3: Add separate address space for secure SMMU accesses
>    hw/arm/smmuv3: Enable secure-side stage 2 TLB invalidations
>    hw/arm/smmuv3: Make the configuration cache security-state aware
>    hw/arm/smmuv3: Differentiate secure TLB entries via keying
>    hw/arm/smmuv3: Use iommu_index to represent SEC_SID
> 
>   hw/arm/smmu-common.c         |  74 ++-
>   hw/arm/smmuv3-internal.h     | 128 +++++-
>   hw/arm/smmuv3.c              | 844 ++++++++++++++++++++++++++++++-----
>   hw/arm/trace-events          |   7 +-
>   hw/arm/virt.c                |   5 +
>   include/hw/arm/smmu-common.h |  23 +-
>   include/hw/arm/smmuv3.h      |  27 ++
>   7 files changed, 968 insertions(+), 140 deletions(-)
> 
> --
> 2.34.1
> 
> 

Regards,
Pierrick

