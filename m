Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDACE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 14:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVWkC-0002kb-RT; Wed, 08 Jan 2025 09:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tVWk4-0002fF-4z
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:09:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tVWk2-0003mf-DI
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736345341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dJLKh6BStmfyk9qgrlfwMFE0auc5dkCCY+gzY914BFc=;
 b=blD8aPDqlDivlWXqoN9nLI4i/zeUjGZ+9AQ6oAe3SwPFwwCOj6n4GN/lnHs++FnZRGLjHu
 mjQaMohE3S6tWsqqo0PRLfXqSBXR/hxNVedDrq+q9yEMjsHbDCEJX6YDnTnugTKrAvpoFM
 H6GjsSRtCK+vRbIxTMYh3uuc+fsUHAA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-KL1w7rrrP6-XWNk8VgLGHw-1; Wed, 08 Jan 2025 09:09:00 -0500
X-MC-Unique: KL1w7rrrP6-XWNk8VgLGHw-1
X-Mimecast-MFC-AGG-ID: KL1w7rrrP6-XWNk8VgLGHw
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa68952272bso471416866b.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 06:09:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736345339; x=1736950139;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJLKh6BStmfyk9qgrlfwMFE0auc5dkCCY+gzY914BFc=;
 b=R9gzPqHownrnGcNTBo5Ww1NWxBAtF0caXBoHtIuTssO0aCEP1ptHgmTR0VR09k2Xac
 QZcgAjar/mGl3D4kCYdo5b/DhSkc55UGfhWkR0l8XAWIE2NxDqQMStFVy1IAURXFU1WU
 UUfiTSmiJwEi+AWiOLVx4oeLr6xsiXmSgEdiuHiKfHd+zLi1jvGrteTsbVC4gAo17NXL
 dSDg19OD5agOdDdAZCF0DBwJglUrrqt0xSR8lbK4Wg2m3nMIGKQb+8vJN5oRBO/A4C5e
 OeVugArLQGM6xui86PiUZOOmU2MTeD8vBBtPpaxtc2nvG137Kc7KKfYi1LPT6pVmSuAC
 vPzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpHrJDF7kRxxsEk0RbV/Olx9Vuwk/8WaTzwfDmMCSBHQ4tNAl01dlyKGJC1MU7YiKl6XV+Yy2l0lGM@nongnu.org
X-Gm-Message-State: AOJu0YyOi+bduJi72Pj34PIyISTzuKiLq2pGhRNzAycocklzmpRdvHl5
 fOEQjJZjccw2f3OrBEIiz1AmPKweZkpxUVGFiUsU3IJEQZ3dU+xHuyQPDO7lQFnrjc7EPORG9ja
 2CFw7ve7qLxm8FjRklxncLpRDz5pB8GY7OiaaRuYXDMcg3F58M2dz
X-Gm-Gg: ASbGnctHrTuCNThxPnFZZFftwdZViyikCZr++N+inCnSMQIRzJxNYJkN/VBtXIeVLLo
 lAXmaF5rBroxiAk8gGRAl/C3PuZTUCLTcRhVDpvjTxUKrl13XY/P8/H528hRF4pn+xS/onLtHct
 O+GresnktZBvKQlUj5l+Ff5jmNjjtV03FRurk/HTnvPO2825I4BvZdffxbGkmvBWebFwhHm4EH6
 BtW4t31tYwSSjeGapqOEzVe74LWnho54Q7yHbwDc4nLGzZJpio=
X-Received: by 2002:a17:907:980f:b0:aa6:993a:259f with SMTP id
 a640c23a62f3a-ab2abcac230mr229670366b.40.1736345336492; 
 Wed, 08 Jan 2025 06:08:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN+WbRRNoZRdA5FBfQVXSR9QvqCiLHYU+MNzhRtSgx/NqiSCYhSXhTtYCX+Xjl8+0y4X3RNA==
X-Received: by 2002:a17:907:980f:b0:aa6:993a:259f with SMTP id
 a640c23a62f3a-ab2abcac230mr229666366b.40.1736345336022; 
 Wed, 08 Jan 2025 06:08:56 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0f015ad6sm2481125066b.166.2025.01.08.06.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 06:08:55 -0800 (PST)
Date: Wed, 8 Jan 2025 09:08:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/5] Change ghes driver to use HEST-based offsets
Message-ID: <20250108090815-mutt-send-email-mst@kernel.org>
References: <cover.1733327276.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1733327276.git.mchehab+huawei@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Dec 04, 2024 at 04:57:54PM +0100, Mauro Carvalho Chehab wrote:
> This  series was part of the previous PR to add generic error injection
> support on GHES. It depends on a cleanup patch series sent earlier
> today:
> 
>     https://lore.kernel.org/qemu-devel/cover.1733297707.git.mchehab+huawei@kernel.org/T/#t
> 
> It contains the changes of the math used to calculate offsets at HEST table 
> and hardware_error firmware file. It prepares for the addition of GHES
> error injection.
> 
> The first patch was previously at the cleanup series. It prepares
> the logic to support multiple sources.
> 
> The second patch adds a new firmware file to store HEST address.
> 
> The third patch use the new firmware to calculate offsets using
> HEST table.
> 
> Patches 4 and 5 add migration support. They assume that this
> series will be merged for qemu 9.2 (maybe it is too late for that,
> as QEMU is now on soft freeze). 
> 
> I tested migration using both virt-9.1 and virt-9.2 machines
> on qemu 9.2.

So this needs a rebase to the next release. Thanks!


> I also tested migration with:
> 
> 	qemu-9.1 -M virt-9.1 -cpu cortex-a57 => qemu-9.2 -M virt-9.1 -cpu cortex-a57
> 	qemu-9.2 -M virt-9.1 -cpu cortex-a57 => qemu-9.1 -M virt-9.1 -cpu cortex-a57 
> 
> The full qemu command when test backward-compatibility when running virt-9.1 is:
> 
> 
> ~/qemu/build/qemu-system-aarch64 \
> -m 4g,maxmem=8G,slots=8 -monitor stdio -no-reboot -bios ~/emulator/QEMU_EFI-silent.fd -kernel~/kernel/arm64_build/arch/arm64/boot/Image.gz -device pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device virtio-net-pci,netdev=mynet,id=bob -drive if=none,file=~/emulator/debian.qcow2,format=qcow2,id=hd -object memory-backend-ram,size=4G,id=mem0 -netdev type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp tcp:localhost:4445,server=on,wait=off -M virt-9.1,nvdimm=on,gic-version=3,ras=on -cpu max -smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 -append 'earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4'
> 
> (I actually call it from two different directories, one with qemu-9.1 and the other one with qemu-9.2.
> 
> For tests on qemu-9.2 with virt-9.2, I used a similar command:
> 
> ~/qemu/build/qemu-system-aarch64 -m 4g,maxmem=8G,slots=8 -monitor stdio -no-reboot -bios ~/emulator/QEMU_EFI-silent.fd -kernel ~/kernel/arm64_build/arch/arm64/boot/Image.gz -device pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device virtio-net-pci,netdev=mynet,id=bob -drive if=none,file=~/emulator/debian.qcow2,format=qcow2,id=hd -object memory-backend-ram,size=4G,id=mem0 -netdev type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp tcp:localhost:4445,server=on,wait=off -M virt-9.2,nvdimm=on,gic-version=3,ras=on -cpu max -smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 -append 'earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4'
> 
> ---
> 
> v3: did some minor cleanups at the code, as suggested by Jonathan Cameron.
> 
> v2:
>   - some whitespace and comment changes
>   - patch 3/6 (acpi/ghes: rename the function which gets hw error offsets)
>     was merged on the cleanup series.
> 
> Mauro Carvalho Chehab (5):
>   acpi/ghes: Prepare to support multiple sources on ghes
>   acpi/ghes: add a firmware file with HEST address
>   acpi/ghes: Use HEST table offsets when preparing GHES records
>   acpi/generic_event_device: Update GHES migration to cover hest addr
>   acpi/generic_event_device: add logic to detect if HEST addr is
>     available
> 
>  hw/acpi/generic_event_device.c |  30 +++++++
>  hw/acpi/ghes.c                 | 160 +++++++++++++++++++++++++++++----
>  hw/arm/virt-acpi-build.c       |  33 ++++++-
>  hw/core/machine.c              |   2 +
>  include/hw/acpi/ghes.h         |  23 +++--
>  5 files changed, 220 insertions(+), 28 deletions(-)
> 
> -- 
> 2.47.1
> 


