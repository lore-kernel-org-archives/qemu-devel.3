Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44230CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 21:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo7mL-000232-0F; Mon, 18 Aug 2025 17:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1uo7mI-00022F-IO
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 17:52:30 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1uo7mG-0005DH-9V
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 17:52:30 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-459fc675d11so9745e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 14:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1755553946; x=1756158746; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cUkUL7ndwYSmfBPBckuK6NW98Sa0K+ErxgWmPsjtu7w=;
 b=kD25N6chwfAehAl9+5FL0gbVICV6wNKeHB64gfFBeveAyBCG4GsqTexxSQGunvFBlR
 Shlu4eyTRsdpdcMygJj2qxJVMxnX0CItypGnxZOQnshR1+7o6aI0tTonjvLjXgLz5A1E
 aWkPojhKo89jV2kewQLUE4e680jJFw+US13aKgazXK6dvcMjeWukBJIn/Oj9wdAQ8Wh7
 vaEsOkTkX37Hrr0ufzYTacfcS8VLqQBefK/JHYUUkGK51OTYmP+UZRXZowpnm4a1G+IF
 YGIFIl4+zmi2KEwN5Ai9D56DKbK7q3TuLPN873UkQuPsb6k/AV3/FZaNpU7cpFxkCJ4D
 GQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755553946; x=1756158746;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cUkUL7ndwYSmfBPBckuK6NW98Sa0K+ErxgWmPsjtu7w=;
 b=H+IX2nJdr3GqXuGai+FJUepUdLlNnMxgygDUm3YyL81NPaBBtLuqFuYoY7DjterSO8
 MBXF+c8B+GdEq3e/cE4l8UxTOYha5gYZWz69MTgLRRaVSKCSb38LosEwW+KQyQrluj9V
 MfsQmvzVHgRep8hDnk49dshU2vsu460fxzkodoJ0zy7GHf9KXlwlWsS5Tpp3wkRSdeBM
 8nkuP3CqtLBvkid19d950wdeK1/z01QB534MKlmejKP917CQg36zjnZYhRrCdEsatrL+
 YmVozodxeJGAF8BBMmYv+vIgq4QGSeF+Y9J7u3INGGAnaMUhTtj2wCYBOhCDCyLbD37V
 xzyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMwTgIudIRUTrHMKGy0dIKeYfbiH2pIoSLfMJaXGHpKWGOkm6K2RP+25osttZpJ0RR4/IPAHC1BY4t@nongnu.org
X-Gm-Message-State: AOJu0Yzu1mBy6GQH6j9wvogtU0csyZycO+FIxzxhJhtUP7BI50Nnew7U
 pcmJ4vYazgAwM3M9El2MKJ0tKCWwwNFy0OORzJL8lUVCAA1oi3j6tkJ/6m86nAsLnA==
X-Gm-Gg: ASbGnctn64B2qGD+73h3esxO0Faw+H5PDP2RHFR1QdNUudXGO+nGco/nschhQu//SRl
 D7szYICppyoIV5/jhCVxCcFWdqjLQynafd1ZeDCSJkHTAhsh6rm9oyflHnhDic1eb+dJYme1d8l
 GOOowN9bOqznA3iZyaJ/SPgl0yjvF7YbAg13XWHtcpohGKM++JXAI8IhOTw5Vt+qwY3acL4oTaj
 6JcUC/FzM+EvKi5ZjfnSmJjwY3DhGNiZ+hCm9L+ztasezErzSCyo3O4lkVJcNtzv2TDSdafk/ni
 Yg9TeEWbSDENvSE9X0kg05pz9tZTtO6ZAkE8KKMDSWmEj5ukyclR2AJfFMCVUhFnQYuj7tvTKPd
 VIxTOxwoKOZzuUNGDOztm7Ow1xRwToNl9FUWMzvR10ie9EZpHsjJtTcHxuLKwQdd0isKK9mDQ
X-Google-Smtp-Source: AGHT+IHKxUZHc0pS/KcBAx1n5L/nSoyGxjjHmprulp3VhZLbV1kYZsvoRFWiccEelhAOT0F1X7+w7w==
X-Received: by 2002:a05:600c:4e09:b0:453:672b:5b64 with SMTP id
 5b1f17b1804b1-45b43a733e2mr220825e9.2.1755553946126; 
 Mon, 18 Aug 2025 14:52:26 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com.
 [146.148.121.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b42a983f7sm15313125e9.24.2025.08.18.14.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 14:52:25 -0700 (PDT)
Date: Mon, 18 Aug 2025 21:52:22 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>
Subject: Re: [RFC 00/11] hw/arm/smmuv3: Add initial support for Secure State
Message-ID: <aKOglmBP9HBSdZCx@google.com>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=smostafa@google.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 06, 2025 at 11:11:23PM +0800, Tao Tang wrote:
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

I gave the patches a quick test and they seem to have broken my
nested setup, I will look more into it and let you know what I find.

Thanks,
Mostafa

> 
> Secure Register/Command Interface: I set up an OP-TEE + Hafnium
> environment. Hafnium's smmuv3_driver_init function was used to test
> the secure register I/O and command queue functionality (excluding
> translation). As Hafnium assumes larger queue and StreamID sizes than
> are practical without TTST support, I temporarily patched Hafnium to
> use smaller values, allowing its driver to initialize the emulated
> secure SMMU successfully.
> 
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
> I've attempted to follow all of the guidance in the "Submitting a Patch"
> guide, but as this is my first series of this scale, I apologize if I
> missed anything and welcome all feedback.
> 
> Thanks,
> Tang
> 
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2025-06/msg02940.html
> [2] https://arxiv.org/abs/2306.11011
> [3] https://github.com/hnusdr/qemu
> 
> Tao Tang (11):
>   hw/arm/smmuv3: Introduce secure registers and commands
>   hw/arm/smmuv3: Implement read/write logic for secure registers
>   hw/arm/smmuv3: Implement S_INIT for secure initialization
>   hw/arm/smmuv3: Enable command processing for the Secure state
>   hw/arm/smmuv3: Support secure event queue and error handling
>   hw/arm/smmuv3: Plumb security state through core functions
>   hw/arm/smmuv3: Add separate address space for secure SMMU accesses
>   hw/arm/smmuv3: Enable secure-side stage 2 TLB invalidations
>   hw/arm/smmuv3: Make the configuration cache security-state aware
>   hw/arm/smmuv3: Differentiate secure TLB entries via keying
>   hw/arm/smmuv3: Use iommu_index to represent SEC_SID
> 
>  hw/arm/smmu-common.c         |  74 ++-
>  hw/arm/smmuv3-internal.h     | 128 +++++-
>  hw/arm/smmuv3.c              | 844 ++++++++++++++++++++++++++++++-----
>  hw/arm/trace-events          |   7 +-
>  hw/arm/virt.c                |   5 +
>  include/hw/arm/smmu-common.h |  23 +-
>  include/hw/arm/smmuv3.h      |  27 ++
>  7 files changed, 968 insertions(+), 140 deletions(-)
> 
> --
> 2.34.1
> 
> 

