Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43080D41D6B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 17:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTksX-0006ZZ-B8; Thu, 11 Dec 2025 12:55:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTksV-0006Ys-Kp
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 12:54:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTksT-0002pf-MW
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 12:54:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765475695;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OSfi5Q2D1Ez0ezrQYwKOOwbqGJVPaX20e4ez2ep3TCk=;
 b=TxuWafXzANlzcbqCnj871BE88IX/s8j6zuewnENHzlg0TF6ZaGh5PYGM46CkntxnfH9jPa
 hl6mjue4FOr9ZPsowo2CDGkPYvd733CzO8Yu7ByKaFW9aG9a8cbm1At0so7S0EY9sMJTvf
 U44a+p/aETojvPWR4iJ4Dat0qDOwne0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-QRS8fX4uMBSQZg-b7vcEhg-1; Thu, 11 Dec 2025 12:54:54 -0500
X-MC-Unique: QRS8fX4uMBSQZg-b7vcEhg-1
X-Mimecast-MFC-AGG-ID: QRS8fX4uMBSQZg-b7vcEhg_1765475694
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b51db8ebd9so106372685a.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 09:54:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765475694; x=1766080494;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OSfi5Q2D1Ez0ezrQYwKOOwbqGJVPaX20e4ez2ep3TCk=;
 b=PAAQuiMQYoJLVY3NlGjJ6OF+bGaHUI2/Sa/uLqVDodPnijgFqjV0bXPrSO/7YqlNCo
 ZWt1fj3mDkhKewh1ZJHdUChik7CjY+KcCCAWojXPX8rPQkS6qzF44aF03QzkPToBqb3x
 Co4n+5ZmK8rFeKQ10oBvKb89rKRDuT8c/b9rJ2kbeFjr16VdxZA/fIrBMdf4YGWBv54X
 chL/f1k7LH9a2grvf85sQnYHHPlQ2odJyBM3pQ2fL9gJmCuq8PBiiS7B0DgM4b/ORj5/
 0TnhdgKcl6IWYUMfR+3oSQnQM9Bj/k+jKv2It5LOc28NNGq+ic3Ifa2zz1DraA7hfS9g
 zQwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEe0DCQbFdWj41cbcKP/GlmyOjWybuRbulL0lZtMKY9BJnY1XlZxqahWpvwXDNWgbOj1mbFWJrTChP@nongnu.org
X-Gm-Message-State: AOJu0YzqfMzHKeRn6cYclYVBZYoTQE2y7Yi7Q06B+svpmz2fy7MU6W8v
 4yEzvF2tMzNuZlzMkXYzs5gNM8ZSgm8KjiaZNOAz5futqatKnNFW0K4iF6Swwl/K4LfsxYzUfKd
 XV46Di2864DnU94yf8V0PsQ2KYL+lLaT/xZH5qpew/Ar+QQ1a5kQo9XOs
X-Gm-Gg: AY/fxX7w7ABi6+zq71cNSyUJ6QVMnDEE5p+ju99h+7e+NFsFzPzA/5OE8uBu5oK365k
 CtUa0d8Sb/ONa02tWWaLaDYZEFcR7AawWesYph+KqhvKbQPNMVHkQlJ9BMfma7WBN8/77wSwV6s
 ZRDSDqgbj2ihbCLhDxI3E7mTvsgBr2CuYVAhGYVPxxwuyBOSP9ThSALfELCCOTBMhNYJNKKE2pv
 Y9tCcyGJWw00RrL5e2t8wpMOrdme7F0jy5mEOAaH/8/a0AcH8/bRAwtXGvWASdcHvziXK0LrlXZ
 +b3WlvBkiksf87wZdDCTo7QM6ydZHH+cxfYlmFsyhrfiq2huUGerrcrTUdWd3+noA5npKCFSzTE
 fqB22KCLe3m+E93S0W03JafBKzvO2Jz94GDBir8dNXeB/Hp6/D4N8gzFSxA==
X-Received: by 2002:a05:620a:cfc:b0:8b2:efe7:d82b with SMTP id
 af79cd13be357-8ba38c77fa0mr691202285a.30.1765475694002; 
 Thu, 11 Dec 2025 09:54:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqvjYfoHc2YGk8W6Q0S+7Izbcr6XIU/YaX/Haz/WiuWhDguSVusaCMTdcGFz9FeWKKoVhqFg==
X-Received: by 2002:a05:620a:cfc:b0:8b2:efe7:d82b with SMTP id
 af79cd13be357-8ba38c77fa0mr691199185a.30.1765475693585; 
 Thu, 11 Dec 2025 09:54:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8bab544b657sm269021785a.10.2025.12.11.09.54.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 09:54:53 -0800 (PST)
Message-ID: <e58763db-6005-418a-ba18-0acefb626929@redhat.com>
Date: Thu, 11 Dec 2025 18:54:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/16] hw/arm: Introduce Tegra241 CMDQV support for
 accelerated SMMUv3
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251210133737.78257-1-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 12/10/25 2:37 PM, Shameer Kolothum wrote:
> Hi,
>
> This RFC series adds initial support for NVIDIA Tegra241 CMDQV
> (Command Queue Virtualisation), an extension to ARM SMMUv3 that
> provides hardware accelerated virtual command queues (VCMDQs) for
> guests. CMDQV allows guests to issue SMMU invalidation commands
> directly to hardware without VM exits, significantly reducing TLBI
> overhead.
>
> Thanks to Nicolin for the initial patches and testing on which this RFC
> is based.
>
> This is based on v6[0] of the SMMUv3 accel series, which is still under
> review, though nearing convergence.  This is sent as an RFC, with the goal
> of gathering early feedback on the CMDQV design and its integration with
> the SMMUv3 acceleration path.
>
> Background:
>
> Tegra241 CMDQV extends SMMUv3 by allocating per-VM "virtual interfaces"
> (VINTFs), each hosting up to 128 VCMDQs.
>
> Each VINTF exposes two 64KB MMIO pages:
>  - Page0 – guest owned control and status registers (directly mapped
>            into the VM)
>  - Page1 – queue configuration registers (trapped/emulated by QEMU)
>
> Unlike the standard SMMU CMDQ, a guest owned Tegra241 VCMDQ does not
> support the full command set. Only a subset, primarily invalidation
> related commands, is accepted by the CMDQV hardware. For this reason,
> a distinct CMDQV device must be exposed to the guest, and the guest OS
> must include a Tegra241 CMDQV aware driver to take advantage of the
> hardware acceleration.
>
> VCMDQ support is integrated via the IOMMU_HW_QUEUE_ALLOC mechanism,
> allowing QEMU to attach guest configured VCMDQ buffers to the
> underlying CMDQV hardware through IOMMUFD. The Linux kernel already
> supports the full CMDQV virtualisation model via IOMMUFD[0].
>
> Summary of QEMU changes:
>
>  - Integrated into the existing SMMUv3 accel path via a
>    "tegra241-cmdqv" property.
>  - Support for allocating vIOMMU objects of type
>    IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV.
>  - Mapping and emulation of the CMDQV MMIO register layout.
>  - VCMDQ/VINTF read/write handling and queue allocation using IOMMUFD
>    APIs.
>  - Reset and initialisation hooks, including checks for at least one
>    cold-plugged device.
>  - CMDQV hardware reads guest queue memory using host physical addresses
>    provided through IOMMUFD, which requires that the VCMDQ buffer be
>    physically contiguous not only in guest PA space but also in host
>    PA space. When Tegra241 CMDQV is enabled, QEMU must therefore only
>    expose a CMDQV size that the host can reliably back with contiguous
>    physical memory. Because of this constraint, it is suggested to use
>    huge pages to back the guest RAM.
>  - ACPI DSDT node generation for CMDQV devices on the virt machine.
>
> These patches have been sanity tested on NVIDIA Grace platforms.
>
> ToDo / revisit:
>  - Prevent hot-unplug of the last device associated with vIOMMU as
>    this might allow associating a different host SMMU/CMDQV.
>  - Locking requirements around error event propagation.
>
> Feedback and testing are very welcome.
>
> Thanks,
> Shameer
> [0] https://lore.kernel.org/qemu-devel/20251120132213.56581-1-skolothumtho@nvidia.com/
> [1] https://lore.kernel.org/all/cover.1752126748.git.nicolinc@nvidia.com/

do you have a branch to share with all the bits?

Thanks

Eric
>
> Nicolin Chen (12):
>   backends/iommufd: Update iommufd_backend_get_device_info
>   backends/iommufd: Update iommufd_backend_alloc_viommu to allow user
>     ptr
>   backends/iommufd: Introduce iommufd_backend_alloc_hw_queue
>   backends/iommufd: Introduce iommufd_backend_viommu_mmap
>   hw/arm/tegra241-cmdqv: Add initial Tegra241 CMDQ-Virtualisation
>     support
>   hw/arm/tegra241-cmdqv: Map VINTF Page0 into guest
>   hw/arm/tegra241-cmdqv: Add read emulation support for registers
>   system/physmem: Add helper to check whether a guest PA maps to RAM
>   hw/arm/tegra241-cmdqv:: Add write emulation for registers
>   hw/arm/tegra241-cmdqv: Add reset handler
>   hw/arm/tegra241-cmdqv: Limit queue size based on backend page size
>   hw/arm/virt-acpi: Advertise Tegra241 CMDQV nodes in DSDT
>
> Shameer Kolothum (4):
>   hw/arm/tegra241-cmdqv: Allocate vEVENTQ object
>   hw/arm/tegra241-cmdqv: Read and propagate Tegra241 CMDQV errors
>   virt-acpi-build: Rename AcpiIortSMMUv3Dev to AcpiSMMUv3Dev
>   hw/arm/smmuv3: Add tegra241-cmdqv property for SMMUv3 device
>
>  backends/iommufd.c        |  65 ++++
>  backends/trace-events     |   2 +
>  hw/arm/Kconfig            |   5 +
>  hw/arm/meson.build        |   1 +
>  hw/arm/smmuv3-accel.c     |  16 +-
>  hw/arm/smmuv3.c           |  18 +
>  hw/arm/tegra241-cmdqv.c   | 759 ++++++++++++++++++++++++++++++++++++++
>  hw/arm/tegra241-cmdqv.h   | 337 +++++++++++++++++
>  hw/arm/trace-events       |   5 +
>  hw/arm/virt-acpi-build.c  | 110 +++++-
>  hw/vfio/iommufd.c         |   6 +-
>  include/exec/cpu-common.h |   2 +
>  include/hw/arm/smmuv3.h   |   3 +
>  include/hw/arm/virt.h     |   2 +
>  include/system/iommufd.h  |  16 +
>  system/physmem.c          |  12 +
>  16 files changed, 1332 insertions(+), 27 deletions(-)
>  create mode 100644 hw/arm/tegra241-cmdqv.c
>  create mode 100644 hw/arm/tegra241-cmdqv.h
>


