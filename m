Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AA3CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 10:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKwSf-0006My-Ug; Mon, 17 Nov 2025 05:27:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vKwSe-0006Lw-7w
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 05:27:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vKwSc-0004jR-Bs
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 05:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763375269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L9ErL18fk6W7j1mcpxF/OQFy0f4gUVl3x5CGCYlj+vM=;
 b=ifZwViw6D25XnFv2Swv2K43qe4vBqxo0OWGBHkOKNQnOjV7pKwtAixCg5MdRzmuBBLjmT9
 w20Rht0dkt4jWvWaDGv331Y9VsIbvR+LoYduGMvZ06lFc2IZebOi/zIq5J6wjocXq5R9+d
 feyfwF+V69lYhCE28dGxt0iC8iS3d18=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-Q8DSMQ7rMLKMDYvPup1iSw-1; Mon, 17 Nov 2025 05:27:47 -0500
X-MC-Unique: Q8DSMQ7rMLKMDYvPup1iSw-1
X-Mimecast-MFC-AGG-ID: Q8DSMQ7rMLKMDYvPup1iSw_1763375266
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477a11d9f89so2642775e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 02:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763375266; x=1763980066; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L9ErL18fk6W7j1mcpxF/OQFy0f4gUVl3x5CGCYlj+vM=;
 b=gATRz8cvVBRpytwG8m+NrZYWUAeO0oanHCyJleZ0hFy+Kv0IAITQvhEc/nzDWKCN2i
 /tBKIryJnFzBfJvaMe6fLnBeR7/EtQbZfowYEgTuZElhjsLKQXoVyKiGfThdUNw6JpTE
 S31UgcUBqtLBpK4MHr8fvZfGa/GXVFfwMobibg/Jb5p87PcfurCl1YwogdzeChm1Q8ZN
 NUefygxl/+HLXudOEZl99AcefGlM4MeMupk1Iqa2qpdTFNVXavqJlMrkBwLO5/HatGMk
 ya26u7Z/O3vckxVAc7zZ/evOljPlaXGQPD7fytzVWo6Lg/p01xdj0OtcdpJxNSkq/bWq
 +N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763375266; x=1763980066;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L9ErL18fk6W7j1mcpxF/OQFy0f4gUVl3x5CGCYlj+vM=;
 b=MIxVQbfs45Tp4+Mj2QhN8k6ZRPXvaGx36bw2EdW1itPpHupEKZXRD0IUhqAmMhgy81
 Wh6uzHEanfyoueLDencT9SdA1z0GbsiEK9EWRN5I6kJZpiCuZ9srvWO4Hi5SxNOEf1bj
 LnCzlGvL1i56cXb7Cx3sjPzw+2MCCG2XlnZ2loqwKvzR7w0gqp2fXHqSuzmVBsDOP+xQ
 QULE6INFkXUlkTmKvAoIRtqcpExgK1BikYEraEiWZmBPwGU2L3C27PT5FiAYvfn9hLyI
 jmFhgJqUKoeULGZt2SpmJGz1VhbSlCX/9L/CObe3BOue/beJgsrjOUDVBHIKLtCaC8dL
 enPA==
X-Gm-Message-State: AOJu0YyE7kkvo16OUkf5j+DTaMwQtvASUSgBGVNo3HO7ytpU0+YRNxB3
 ysBmxycP97Ik+aZFHH/MDWaxqTe/4JfwlMXjv5CIabLXDAtbrwVRWPdzm0rCIrDWqzi9JnBAgKV
 H+nUgTGpEwwdhxYVzYuU4SASIilHwmiXQezGkZlQz4ys1wl4hBMA7Utt9OgZw7IeR8W+EMD7sbj
 QzZYOe9OucMcMvsPWNrwFc4BCH7KvD/yQqXg==
X-Gm-Gg: ASbGncuY00TVG7T6xPpKuhTiKrPCZTkJmnwX4XCMhlUP5T8Wpk4Xuw6ySxi+NnQGIB6
 O7lH3m4MxgL5Ypyjbdis24zVWF2fvs2tpqhzcIHkrHOff3m0s1Y1bViyR1HGVKy7OG35dzgSB70
 yRjLY2QQU4b/H+UU+QQ8MagI8ktHLjIZOlK/IMZohKXywMIvSO0xgdGuBlD2/8Wju/S/EcnfTia
 2EdLTumJJ61w1nXu2zBaieCG4jiwPwmBBjYZoLDwgZnh/9iGNZo6+FKQ/1OnH9gITHwyPFvge8W
 p1NPMzZt7GuyZEdDcqg3y9c4mv7Jcoip8862dOSr2xD2Zgdx99HTTMDWEng7JrywHv7gkrIvEWp
 aVuBDa9GNavKfdCJNICU=
X-Received: by 2002:a05:600c:b86:b0:46e:506b:20c5 with SMTP id
 5b1f17b1804b1-4778feaa63bmr101071695e9.26.1763375265523; 
 Mon, 17 Nov 2025 02:27:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBNs27ZdRItxWP/OlGRWm3OWWl6W4nqTkjpe2bz0CWJezDI5PPLdj8/ELZUYRCWYwq+jF3fQ==
X-Received: by 2002:a05:600c:b86:b0:46e:506b:20c5 with SMTP id
 5b1f17b1804b1-4778feaa63bmr101071505e9.26.1763375264835; 
 Mon, 17 Nov 2025 02:27:44 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779527235esm160269305e9.8.2025.11.17.02.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 02:27:44 -0800 (PST)
Date: Mon, 17 Nov 2025 05:27:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: Re: [PULL 00/14] virtio,pci,pc: fixes for 10.2
Message-ID: <20251117052608-mutt-send-email-mst@kernel.org>
References: <cover.1762698873.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762698873.git.mst@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Nov 09, 2025 at 09:35:09AM -0500, Michael S. Tsirkin wrote:
> The following changes since commit 917ac07f9aef579b9538a81d45f45850aba42906:
> 
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-11-05 16:07:18 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to 97f24a0496be9e0a7216fea1fa0d54c1db9066e2:
> 
>   vhost-user.rst: clarify when FDs can be sent (2025-11-09 08:25:53 -0500)
> 
> ----------------------------------------------------------------
> virtio,pci,pc: fixes for 10.2
> 
> small fixes all over the place.
> UDP tunnel and TSEG tweaks are kind of borderline,
> but I feel not making the change now will just add
> to compatibility headaches down the road.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------


Is there any issue with this pull request?
Just making sure these fixes have not been lost.



> Albert Esteve (1):
>       vhost-user: fix shared object lookup handler logic
> 
> Alejandro Jimenez (1):
>       MAINTAINERS: Update entry for AMD-Vi Emulation
> 
> Alyssa Ross (1):
>       vhost-user.rst: clarify when FDs can be sent
> 
> Eric Auger (1):
>       hw/pci-host/gpex-acpi: Fix _DSM function 0 support return value
> 
> Gerd Hoffmann (1):
>       q35: increase default tseg size
> 
> German Maglione (1):
>       vhost-user: make vhost_set_vring_file() synchronous
> 
> Paolo Abeni (1):
>       virtio-net: Advertise UDP tunnel GSO support by default
> 
> Sairaj Kodilkar (2):
>       amd_iommu: Fix handling of devices on buses != 0
>       amd_iommu: Support 64-bit address for IOTLB lookup
> 
> Shameer Kolothum (2):
>       tests/qtest/bios-tables-test: Prepare for _DSM change in the DSDT table
>       tests/qtest/bios-tables-test: Update DSDT blobs after GPEX _DSM change
> 
> Zhenzhong Duan (3):
>       intel_iommu: Handle PASID cache invalidation
>       intel_iommu: Reset pasid cache when system level reset
>       intel_iommu: Fix DMA failure when guest switches IOMMU domain
> 
>  hw/i386/amd_iommu.h                              |   6 +-
>  hw/i386/intel_iommu_internal.h                   |  17 +++
>  include/hw/i386/intel_iommu.h                    |   6 +
>  hw/core/machine.c                                |   4 +
>  hw/i386/amd_iommu.c                              | 179 +++++++++++++---------
>  hw/i386/intel_iommu.c                            | 181 +++++++++++++++++++++--
>  hw/i386/pc.c                                     |   4 +-
>  hw/net/virtio-net.c                              |   8 +-
>  hw/pci-host/gpex-acpi.c                          |   2 +-
>  hw/pci-host/q35.c                                |   2 +-
>  hw/virtio/vhost-user.c                           |  64 ++++----
>  MAINTAINERS                                      |   6 +-
>  docs/interop/vhost-user.rst                      |   7 +
>  hw/i386/trace-events                             |   4 +
>  tests/data/acpi/aarch64/virt/DSDT                | Bin 5337 -> 5337 bytes
>  tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt   | Bin 5423 -> 5423 bytes
>  tests/data/acpi/aarch64/virt/DSDT.acpipcihp      | Bin 6246 -> 6246 bytes
>  tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex | Bin 5391 -> 5391 bytes
>  tests/data/acpi/aarch64/virt/DSDT.memhp          | Bin 6698 -> 6698 bytes
>  tests/data/acpi/aarch64/virt/DSDT.pxb            | Bin 7812 -> 7812 bytes
>  tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev     | Bin 10274 -> 10274 bytes
>  tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy  | Bin 10274 -> 10274 bytes
>  tests/data/acpi/aarch64/virt/DSDT.topology       | Bin 5539 -> 5539 bytes
>  tests/data/acpi/aarch64/virt/DSDT.viot           | Bin 5354 -> 5354 bytes
>  tests/data/acpi/loongarch64/virt/DSDT            | Bin 4603 -> 4603 bytes
>  tests/data/acpi/loongarch64/virt/DSDT.memhp      | Bin 5824 -> 5824 bytes
>  tests/data/acpi/loongarch64/virt/DSDT.numamem    | Bin 4609 -> 4609 bytes
>  tests/data/acpi/loongarch64/virt/DSDT.topology   | Bin 4905 -> 4905 bytes
>  tests/data/acpi/riscv64/virt/DSDT                | Bin 3538 -> 3538 bytes
>  tests/data/acpi/x86/microvm/DSDT.pcie            | Bin 2985 -> 2985 bytes
>  30 files changed, 371 insertions(+), 119 deletions(-)
> 


