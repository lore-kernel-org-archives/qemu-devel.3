Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2475EC5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuZSA-00027y-Ia; Thu, 13 Aug 2026 13:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wuZS4-00027h-D2
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 13:42:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wuZS1-0005Cw-SM
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 13:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786642964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gpcp2v8bcD9eF0hjS0diRLr8qW04a2KWYzi8Awelx8Y=;
 b=Kp3kHv4ktdTIg3n4vv1zX8olaz+98OAtD1qUEZp5sTqduremD9omkpWZl10j1Tpb5fgrT+
 U6p57aH2vub9kg5iF0w8VYizZ8XsaTxRXvWE1xOdj2q+y5OwSLcf9BGlTa3StySi1t/Cvz
 I2gI9TIYLxOsL0KLvZ6UnO2RaGcAU/A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-KvvKNcjcMOmTF6T0pRsjoA-1; Thu, 13 Aug 2026 13:42:42 -0400
X-MC-Unique: KvvKNcjcMOmTF6T0pRsjoA-1
X-Mimecast-MFC-AGG-ID: KvvKNcjcMOmTF6T0pRsjoA_1786642961
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f83450a8eso85522f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 10:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786642961; x=1787247761; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gpcp2v8bcD9eF0hjS0diRLr8qW04a2KWYzi8Awelx8Y=;
 b=YrNZfx+65dbum9qTw9vuRJIbxKsKunDE06AMbC8fVT7Q3f8RpDt4XMBfs6suww0BtF
 LjIREfb1XW9VUXOfj6bbfK+V9WQSxzIKSyoi+58TwjwJhNrAfdLtADj1uaXT68J2T83c
 6U9DxtG3u3D1HQP8xdyXkLlBZPRB1a5C2v5Fclns2EzuaG5DKisZlwtHEuiatBMz3td7
 HS0pLCmRJ5dyIGmFDjqnkL5DbHAfb6KCBWoxtvb8VN1/ePPUT5HX8jmLEqI+xOYKVunx
 xTNEFvzBvSIfR4hG0FQeyLbyvwX0zZFxezLUQAglraxWh5GjSRt4OsBxMUx4PyuUDRhc
 iNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786642961; x=1787247761;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gpcp2v8bcD9eF0hjS0diRLr8qW04a2KWYzi8Awelx8Y=;
 b=i7DKrBi+e8IvYm29mQ/TVOLly44BjS+cIxPROCVkaNBOzIoQQKcys8ptjUWWCTKawf
 Et2f4wq2g4bK2M03w0f+OBmZztaSrJDGOXP45yJYDWWrUxwFk1wrqFYrc+8VfOm7/7ph
 3BL37mYI4WkllyfuYQyf2sSE+2dQbQ0TFXjAB0ZWg//IN3CaAx7rKl8LQnskPDzKo7r5
 Zl9OIYK5rQ7ooeUCbXM9uBWhr0QHHjZYekkfTAco96DFXlfDV5BLh+k9XisevTCFBVWp
 LAeXqHONq6kotc0ogZEoj35o0rEjPM83Vq+IY7AZ2jirMFi3fJmfWXmWaDdUlop6EQFE
 Wjlg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoD7WoOgWJGmxk5lf0xOJPc2iBZhQkaKIEkfUi06MSLH1Eayh+OwKo0Iq2uShaJSYsARZcoZBESk9Em@nongnu.org
X-Gm-Message-State: AOJu0YyoJ5boTglJZ6pD1OQUaTE/zvTXj5xg2gXsNrqTs2mlgjY+Jk5V
 7Yo8CyFRM1r2o+mDJaZAGpnNmjMHXnuwLxlbdxjj4zXURI88QorQGBEnSb3MN4rKOQdUzFcmQ0V
 UNBLQuEi4albMMbjmD0Zo5bMYc0krMFnWTp9BU34t4+jvemoW7x52xz5a
X-Gm-Gg: AR+sD12XEXJJENsXTAdoJHfkjp2J1Z4iFLiYrNgScLOlkHvCuXzIVTJLON4n067PFVU
 i9uTkLqY4rTuQ2VSZ46jBTENw4zc8ps+eGLQvH3T+wauwn388hN4Sd06ClNECnhhV7wjIhaHyIT
 689GN66Yt57l0fzHFysKUMx/ujQj1IE9UnDScCDmKRY2U4AZQLnqSBmceFKVaj6ULu9tVnlDih1
 lPl0GqGwFpTesbxFR/GARTSrMgj8pUbwE36/M/cAvmwEqOMmNDqmuh/sO5L6L+kFRbmj7zNH7S2
 egkha+iq1hbUOjvYlK5PBsxqbinV08WCtFtxyponetSRQfjQ1PfsdAS8muIWI4+XIgIU4ixc/I0
 Xrd8bwqAeLmAcqUqNyvLcumJTQopeviqT2uaH
X-Received: by 2002:adf:f391:0:b0:47f:97e9:fe60 with SMTP id
 ffacd0b85a97d-48159fe3dafmr9825414f8f.15.1786642961294; 
 Thu, 13 Aug 2026 10:42:41 -0700 (PDT)
X-Received: by 2002:adf:f391:0:b0:47f:97e9:fe60 with SMTP id
 ffacd0b85a97d-48159fe3dafmr9825368f8f.15.1786642960820; 
 Thu, 13 Aug 2026 10:42:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1a91sm970007f8f.21.2026.08.13.10.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 10:42:40 -0700 (PDT)
Message-ID: <472deed3-ce79-4c4e-ad7c-d3a9c151f479@redhat.com>
Date: Thu, 13 Aug 2026 19:42:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] QEMU: CXL Type-2 device passthrough via vfio-pci
To: mhonap@nvidia.com, alex@shazbot.org, ankita@nvidia.com, jic23@kernel.org, 
 dave.jiang@intel.com, alejandro.lucero-palau@amd.com, smadhavan@nvidia.com,
 pierrick.bouvier@oss.qualcomm.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pbonzini@redhat.com, eric.auger@redhat.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org, cohuck@redhat.com
Cc: kjaju@nvidia.com, vsethi@nvidia.com, zhiw@nvidia.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260813130623.2499506-1-mhonap@nvidia.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260813130623.2499506-1-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Manish,

On 8/13/26 15:06, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> This series adds QEMU support for passing a CXL Type-2 device (an
> accelerator with host-managed device memory, e.g. a GPU) to a guest via
> vfio-pci. The guest drives its own virtual endpoint HDM decoder and QEMU
> maps the device memory at the guest physical address the guest commits,
> while the host owns the host physical placement.
> 
> It is a full rewrite of the RFC v1 series [1] on clean upstream master,
> reworked to address Jonathan's review.
> 
> Base: master (post pull-9p-20260725), commit 6333226c2a.
> 
> 
> Kernel dependency
> -----------------
> 
> Pairs with the kernel vfio-cxl series "vfio/cxl: CXL Type-2 device
> passthrough" [2].
> - The kernel exposes the device memory as an HPA-backed VFIO region, traps
>    the HDM decoder block and runs its lock-on-commit FSM, handles the CXL
>    DVSEC (including guest-triggered reset), and reports two things through
>    VFIO:
>    - A device flag (VFIO_DEVICE_FLAGS_CXL) and
>    - The component-register geometry (VFIO_REGION_INFO_CAP_CXL_COMP_REGS).
> 
> 
> Sample supported topology
> -------------------------
> 
> Guest disk, network, and system-RAM lines are omitted:
> 
>    -machine virt,accel=kvm,gic-version=3,hmat=on,cxl=on,ras=on, \
>             highmem-mmio-size=4T
>    -object iommufd,id=iommufd0
>    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1
>    -device cxl-rp,port=1,bus=cxl.1,id=rport0.1,chassis=4, \
>            pref64-reserve=2G,mem-reserve=1G
>    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=256G
>    -device arm-smmuv3,primary-bus=cxl.1,id=smmuv3.0,accel=on,ats=on, \
>            ril=on,ssidsize=8,oas=48
>    -device vfio-pci-nohotplug,host=<BDF>,bus=rport0.1,id=dev0, \
>            iommufd=iommufd0
>    -object acpi-generic-initiator,id=gi0,pci-dev=dev0,node=2
>    ... (one acpi-generic-initiator per guest NUMA node the HDM memory backs)
> 
> 
> Address model
> -------------
> 
> The kernel fixes device memory to a host physical range before the guest
> sees the device, and hardware presents a firmware-committed, locked
> endpoint HDM decoder whose registers hold that host physical base.
> 
> QEMU never exposes Host physical base. It virtualizes the decoder base registers
> in the trapped component-register read and returns the base of the device's
> CFMWS window, a guest physical address, so the guest only ever sees a GPA.
> 
> QEMU maps the RAM-device region (backed by the fixed HPA) at that CFMWS base.
> 
> The kernel never learns the GPA and the guest never learns the HPA.
> 
> Because the decoder is already committed at boot, no guest commit write
> triggers the mapping. QEMU maps once the guest enables memory decoding
> (the Command register Memory-Space bit) and re-checks on any decoder
> control write, so the region enters the guest address space and the IOAS
> while the device is live.
> 
> When the guest clears Memory-Space, QEMU withdraws the mapping, matching the
> kernel's revoke of the backing PTEs on the same write, so a guest access during
> the disabled interval cannot fault a zapped mapping and stop the VM; the enable
> path re-installs it.
> 
> This also helps to keep the guest-visible base as the CFMWS base by
> construction, and the host physical placement stays with the kernel.
> 
> The RFC added the pxb-cxl _DSM because OS may treat PCI configuration as
> reassignable and a BAR move would break the CXL.mem mapping. This change keeps
> it narrower than the RFC v1 _DSM: it applies only to the host bridge that
> carries the passed-through CXL device.
> 
> 
> Reset
> -----
> 
> There is no QEMU reset patch. A guest CXL reset is a DVSEC write that
> lands in vfio config space and is handled entirely by the host kernel,
> which stamps the outcome into DVSEC STATUS2. The kernel re-commits this
> firmware-fixed decoder across the reset, and the guest reaches its memory
> through the mapping QEMU already installed.
> 
> 
> Reviewer feedback addressed
> ---------------------------
> 
> The RFC [1] thread has the full discussion.
> 
> Jonathan Cameron
>    - The high-MMIO window and the cxl-fmws-base property are removed. The
>      guest-visible base is the CFMWS base by construction, so it equals the
>      decoder base and stays stable without a hack.
>    - The guest programs its virtual (GPA) decoder and QEMU maps the memory at
>      commit time.
>    - The host owns the HPA, resolved before the guest sees the device.
>    - The committed decoder is the fast path this series ships. The
>      guest-programmed uncommitted case is delivered by cxl-core resolving the
>      range at enumeration, not by a QEMU or vfio dynamic branch, so it is a
>      later cxl-core item this series does not depend on.
>    - FIRMWARE_COMMITTED is dropped; the cap is no longer exposed.
>    - The one-endpoint, non-interleaved, no-switch topology is enforced at
>      realize.
>    - PCI/BAR configuration and CXL.mem stay independent.
> 
> 
> Validation
> ----------
> 
> - Every patch passes scripts/checkpatch.pl --codespell --strict
>    (patch 1 carries the expected imported-from-Linux warning)
> - The series applies cleanly on the stated base.
> - Ran couple of rounds of masoncl/review-prompts on this series before posting.
> 
> 
> Pending items
> -------------
> 
> Future enhancements for the multi-decoder, interleaved devices and switched
> topologies.
> 
> Trapped CXL RAS registers are planned as a new VFIO region subtype that the same
> region-by-subtype detection already handles, not as a change to the
> component-register cap.
> 
> The bios-tables test refresh for the new _DSM is still to be added.

Before diving into CXL and doing a review of the QEMU patches, could you
provide a status update on the kernel vfio-cxl series [2] ?

The QEMU side is a consumer of the VFIO regions and capabilities the
kernel exposes, and patch 1 notes the capability ID is still provisional.
Knowing where the kernel series stands would help. That said, the UAPI
looks simple enough.

What has become of the CXL Type-2 device emulation effort from Zhi Wang?

   https://lore.kernel.org/qemu-devel/20241212130422.69380-1-zhiw@nvidia.com/

That series introduced a bare-minimum emulated CXL Type-2 device in
QEMU, so kernel and QEMU developers could test the CXL Type-2 stack
without real hardware. I liked the idea quite a lot.

CXL is still new and complex, and hardware is scarce. Having an
emulated device and passthrough support gives us a full environment to
flush out design issues across the stack (Linux kernel, QEMU, libvirt)
and in associated subsystems like IOMMU and ACPI, without needing
physical devices. It is also useful for education and for running CI
tests. Do you see both efforts as complementary, and is the emulation
work still active?

I will take a closer look at the series after some time off.

Thanks,


C.








