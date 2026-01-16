Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4916D47CD6
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 10:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghVm-00050p-OQ; Fri, 16 Jan 2026 05:57:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vghVk-00050O-UX
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:57:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vghVj-0002e9-8g
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768561017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CQP5crnfclmr8J0RsxViBXyZLT1KSdU9JcYePQ+0Bv4=;
 b=FPsK6w38DmJ1wMbRoxBjcHVD2v7pvEFoG2Iztd4X3CYJCEzL4oV3Eq4PsUoRGch/LcszVu
 q3yfn84ZO6ZKINyDHa/LqgNjQAPIi6i57cktin4qid4JhQgJuanPxVcIr2rQKAF6JFlReL
 Kni90boAJmBG7bJYNlTg7VwIovZpqSI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-U7kv6fpZPseStygGe9AsSA-1; Fri, 16 Jan 2026 05:56:55 -0500
X-MC-Unique: U7kv6fpZPseStygGe9AsSA-1
X-Mimecast-MFC-AGG-ID: U7kv6fpZPseStygGe9AsSA_1768561015
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430f4609e80so1112514f8f.3
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 02:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768561015; x=1769165815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=CQP5crnfclmr8J0RsxViBXyZLT1KSdU9JcYePQ+0Bv4=;
 b=QyKEYP8yk5zJIRHko5dd6tdWt+R44fIDLXGi6E6YG119EtrkkfvYYUtph3+f3WDRG0
 erpStyYx8YB2RuUJnqcFG9KPh6K2XFPLLcpaLZ4f9UdjirRrpDzd7GWlD5Qyj2eSaMy1
 XSMsZpcKJzaez3/g+6VIzGwpCgJ22ZspH90Pi3z1/IWEFjdOsecDIKOqpvzOnxKd2x9m
 k3IG8iiExwDYp7I1oCgZE2U6RzQnhWTYeYnPX+BngPJfiKBtwNqv78mftKA5BM3ej/a6
 4J/INk2prgn7YJJux9hYLzjU6O+xDTo3j6ZPcgAFQ/AkVjHaGSsvnywilOcQFYy9Jlk/
 aiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768561015; x=1769165815;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQP5crnfclmr8J0RsxViBXyZLT1KSdU9JcYePQ+0Bv4=;
 b=Eg0zURMoSf20o4qy59SBmio1Fkt2pyG16DUrqBdr9fpEqpL/3MHwP9OCvVGH/mJO5N
 gnuT4X00r8Ckpm9kodw+IPmpPtOZYAkkm/lqTkkDAoPulSvlWyzrFUifmzLMZrZ2P9Jc
 3s+b15RMNcItEc7qSgRgySYGF7VHvS78qBTYdAabVMoJVaLwpm+l1G3eZkkKSl14/1mU
 mYJYMuAQvt+fiys4L0Yrstz2Enwh7XunqJpWt7EzNUjmRDOKOGrzqGlWGzxw/f6i/fK7
 6tM/gTajDot8zwYY/7zZiGDR8KY6kQBFFZX5zqlL8uWGkCQBQoNnoejjogaROeBmCW9R
 o4pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwoWteRdJRUUWE/uEw34CfGuolmueKpSgrL2PtE4cK641JMQL7Ii9uRBYOGeQXWWulp+FnvqQyMZgE@nongnu.org
X-Gm-Message-State: AOJu0Yy2VF0TTTsCQOy7e6B9cG+hsV2Myj8NrXGM+SOSn76qbp/wg/TH
 JnP3SOQhjs6dzJc0ltIA3aWvyWh9q0nqn6TAcCMHEVaRlzBNyPTcClPKvIVT5yaVqTkV9t9ZrMq
 6BOVb3gmfRq3RHxVEp2r2MYIRuLjy5k2sh+hqisCxbIy9Sk7S8FsU72Fy
X-Gm-Gg: AY/fxX4GMipH7JPaVb08w2pGFQW2ACVNUjI4MviAGj8cFyTp5sFrMbw/8K1MNuCkCuR
 WRC3o77emdT+H+sDb/PHqoeyewRbIn2DVGvWKc8+Svpo41lyVxHAk/AAGdunUpSBa8m2unoIXzP
 pVRk2AcZJ5Kn05MClOmYYQ73rUzG+qKF7A5Cp2/Jne8YqFp1XfGTAgERpkPWXWtgj4uHzhcHb8J
 BdVF08TiTmlIFdkhBAw9IV/IJxIwO4IW00D4fxN8JjVGLuM0Dqf6FRKZdB7mGcE0/hSxT5vFcj3
 xrQMdzgR/T6bVOT1RaOSJgwoeBnyTt7fRFFyCRTeov2UgeRYw531pco2z4SezNSqv3NQZ4zRmZJ
 9SLSsVANL5f6anQKm7J2nu8eD8BQw+yBcLvdDV8Clmgf/nTIg
X-Received: by 2002:a05:6000:26d1:b0:431:2cb:d335 with SMTP id
 ffacd0b85a97d-4356a053852mr2614562f8f.34.1768561014552; 
 Fri, 16 Jan 2026 02:56:54 -0800 (PST)
X-Received: by 2002:a05:6000:26d1:b0:431:2cb:d335 with SMTP id
 ffacd0b85a97d-4356a053852mr2614515f8f.34.1768561014005; 
 Fri, 16 Jan 2026 02:56:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cf42sm4501961f8f.20.2026.01.16.02.56.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 02:56:53 -0800 (PST)
Message-ID: <f15b6372-7a34-4bc3-90d1-a412514d5bf8@redhat.com>
Date: Fri, 16 Jan 2026 11:56:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] vfio: Add DMABUF support for PCI BAR regions
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, alex@shazbot.org, cohuck@redhat.com,
 mst@redhat.com, nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhenzhong.duan@intel.com,
 vivek.kasireddy@intel.com, kjaju@nvidia.com
References: <20260116092950.15796-1-skolothumtho@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260116092950.15796-1-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/16/26 10:29, Shameer Kolothum wrote:
> Hi,
> 
> Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory for P2P
> use cases. This adds support for vfio devices to create a dmabuf for
> each mapped BAR region.
> 
> Changes from v2:
> https://lore.kernel.org/qemu-devel/20260113113754.1189-1-skolothumtho@nvidia.com/
>   
>   - Addressed feedback on v2 and picked up R-by/T-by tags. Thanks!.
>   - This has dependnecy on patches sent by Cédric[0][1]
> 
> The dmabuf support was sanity tested on an NVIDIA grace paltform.
> 
> Please take a look and let me know.
> 
> Thanks,
> Shameer
> [0] https://lore.kernel.org/qemu-devel/20260112155341.1209988-1-clg@redhat.com/
> [1] https://lore.kernel.org/qemu-devel/20260108185012.2568277-1-clg@redhat.com/
> 
> Nicolin Chen (1):
>    hw/vfio/region: Create dmabuf for PCI BAR per region
> 
> Shameer Kolothum (3):
>    linux-headers: Update to Linux v6.19-rc1
>    hw/net/virtio-net: Adapt hash handling to updated UAPI
>    hw/vfio: Add helper to retrieve device feature
> 
>   hw/net/virtio-net.c                           |  11 +-
>   hw/vfio/container.c                           |   2 +-
>   hw/vfio/device.c                              |   9 +
>   hw/vfio/listener.c                            |   4 +-
>   hw/vfio/region.c                              |  65 ++-
>   hw/vfio/trace-events                          |   1 +
>   include/hw/vfio/vfio-device.h                 |   3 +
>   include/standard-headers/drm/drm_fourcc.h     |  25 +-
>   include/standard-headers/linux/ethtool.h      |   5 +
>   .../linux/input-event-codes.h                 |  14 +-
>   include/standard-headers/linux/pci_regs.h     |  89 ++++
>   include/standard-headers/linux/virtio_net.h   |   3 +-
>   include/standard-headers/linux/virtio_pci.h   |   2 +-
>   linux-headers/asm-arm64/kvm.h                 |   2 +-
>   linux-headers/asm-arm64/unistd_64.h           |   1 +
>   linux-headers/asm-generic/unistd.h            |   4 +-
>   linux-headers/asm-loongarch/kvm.h             |   1 +
>   linux-headers/asm-loongarch/unistd.h          |   6 +
>   linux-headers/asm-loongarch/unistd_64.h       |   1 +
>   linux-headers/asm-mips/unistd_n32.h           |   1 +
>   linux-headers/asm-mips/unistd_n64.h           |   1 +
>   linux-headers/asm-mips/unistd_o32.h           |   1 +
>   linux-headers/asm-powerpc/unistd_32.h         |   1 +
>   linux-headers/asm-powerpc/unistd_64.h         |   1 +
>   linux-headers/asm-riscv/kvm.h                 |   3 +
>   linux-headers/asm-riscv/unistd_32.h           |   1 +
>   linux-headers/asm-riscv/unistd_64.h           |   1 +
>   linux-headers/asm-s390/bitsperlong.h          |   4 -
>   linux-headers/asm-s390/unistd.h               |   4 -
>   linux-headers/asm-s390/unistd_32.h            | 446 ------------------
>   linux-headers/asm-s390/unistd_64.h            |   9 +-
>   linux-headers/asm-x86/kvm.h                   |   1 +
>   linux-headers/asm-x86/unistd_32.h             |   1 +
>   linux-headers/asm-x86/unistd_64.h             |   1 +
>   linux-headers/asm-x86/unistd_x32.h            |   1 +
>   linux-headers/linux/iommufd.h                 |  10 +
>   linux-headers/linux/kvm.h                     |  11 +
>   linux-headers/linux/mshv.h                    | 116 ++++-
>   linux-headers/linux/psp-sev.h                 |  66 ++-
>   linux-headers/linux/vfio.h                    |  28 ++
>   40 files changed, 450 insertions(+), 506 deletions(-)
>   delete mode 100644 linux-headers/asm-s390/unistd_32.h
> 

Applied to vfio-next.

Thanks,

C.


