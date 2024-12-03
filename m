Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EBBE64AAD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tITQw-0005h3-58; Tue, 03 Dec 2024 08:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tITQu-0005gY-Hv; Tue, 03 Dec 2024 08:59:20 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tITQs-0003rQ-4w; Tue, 03 Dec 2024 08:59:20 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7C9D65C5A62;
 Tue,  3 Dec 2024 13:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45B7C4CECF;
 Tue,  3 Dec 2024 13:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733234354;
 bh=ybwMmLDPih2y8EAfYC3azst4Q0MnjEVlliaSDkdXsSs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VwjlDOVH1n7GGba7TRDsopIvkZvmZhHN4moFJ8pONrGP65YgmBbrAlLMXLT1jRsuf
 5n2il0PqOsQw8KbrdZEOWXf9jVJkycCPzXiGa3NUvDtM3YKeCSXbWFxF9C0gK08VHD
 TCwXGR/3gd9GZcqBTTUv2RB0WayGtg92RbnvGBY0IfFM01PeTlY/DORc7SEnH8gY3Z
 KvZwIIT3c3Om1idwXQeRRxLga8wLtNdD2E7P8LMu8rYhNeWbMaq0wSILeNqrVvtFUH
 9PM8PFeY5/HUOP1BbV694KCSPA5p3GR4R+9Njum62JEPVQ8jUmWJCP5V6SyQN8AvT7
 s+vG4B/35zmIw==
Date: Tue, 3 Dec 2024 14:59:08 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon
 Zhao <shannon.zhaosl@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao
 Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/5] Change ghes driver to use HEST-based offsets
Message-ID: <20241203145908.06aee888@foz.lan>
In-Reply-To: <20241203130310.0bde48c0@imammedo.users.ipa.redhat.com>
References: <cover.1732281080.git.mchehab+huawei@kernel.org>
 <20241203130310.0bde48c0@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Em Tue, 3 Dec 2024 13:03:10 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Fri, 22 Nov 2024 14:14:10 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > This  series was part of the previous PR to add generic error injection
> > support on GHES. It depends on a cleanup patch series sent earlier
> > today:
> > 
> > 	https://lore.kernel.org/qemu-devel/cover.1732266152.git.mchehab+huawei@kernel.org/T/#t
> > 
> > It contains the changes of the math used to calculate offsets at HEST table 
> > and hardware_error firmware file. It prepares for the addition of GHES
> > error injection.
> > 
> > The first patch was previously at the cleanup series. It prepares
> > the logic to support multiple sources.
> > 
> > The second patch adds a new firmware file to store HEST address.
> > 
> > The third patch use the new firmware to calculate offsets using
> > HEST table.
> > 
> > Patches 4 and 5 add migration support. They assume that this
> > series will be merged for qemu 9.2 (maybe it is too late for that,
> > as QEMU is now on soft freeze). 
> > 
> > I tested migration using both virt-9.1 and virt-9.2 machines
> > on qemu 9.2.
> > 
> > I also tested migration with:
> >   
> 
> > 	qemu-9.1 -M virt-9.1 -cpu cortex-a57 => qemu-9.2 -M virt-9.1 -cpu cortex-a57
> > 	qemu-9.2 -M virt-9.1 -cpu cortex-a57 => qemu-9.1 -M virt-9.1 -cpu cortex-a57  
> was that with HEST enabled (it's 'ras' machine option),
> It would be better to provide full CLI used 

Yes. This is the full command line I'm using for virt-9.2 (urls sanitized):

~/qemu/build/qemu-system-aarch64 -m 4g,maxmem=8G,slots=8 -monitor stdio -no-reboot -bios ~/emulator/QEMU_EFI-silent.fd -kernel ~/kernel/arm64_build/arch/arm64/boot/Image.gz -device pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device virtio-net-pci,netdev=mynet,id=bob -drive if=none,file=~/emulator/debian.qcow2,format=qcow2,id=hd -object memory-backend-ram,size=4G,id=mem0 -netdev type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp tcp:localhost:4445,server=on,wait=off -M virt-9.2,nvdimm=on,gic-version=3,ras=on -cpu max -smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 -append 'earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4'

And this is for virt-9.1:

~/qemu/build/qemu-system-aarch64 -m 4g,maxmem=8G,slots=8 -monitor stdio -no-reboot -bios ~/emulator/QEMU_EFI-silent.fd -kernel ~/kernel/arm64_build/arch/arm64/boot/Image.gz -device pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device virtio-net-pci,netdev=mynet,id=bob -drive if=none,file=~/emulator/debian.qcow2,format=qcow2,id=hd -object memory-backend-ram,size=4G,id=mem0 -netdev type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp tcp:localhost:4445,server=on,wait=off -M virt-9.1,nvdimm=on,gic-version=3,ras=on -cpu max -smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 -append 'earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4'

I opted to use a shorter version just bolding the difference, as the above
are a lot harder to see the differences.


> 
> > 
> > ---
> > 
> > v2:
> >   - some whitespace and comment changes
> >   - patch 3/6 (acpi/ghes: rename the function which gets hw error offsets)
> >     was merged on the cleanup series.
> > 
> > Mauro Carvalho Chehab (5):
> >   acpi/ghes: Prepare to support multiple sources on ghes
> >   acpi/ghes: add a firmware file with HEST address
> >   acpi/ghes: Use HEST table offsets when preparing GHES records
> >   acpi/generic_event_device: Update GHES migration to cover hest addr
> >   acpi/generic_event_device: add logic to detect if HEST addr is
> >     available
> > 
> >  hw/acpi/generic_event_device.c |  30 +++++++
> >  hw/acpi/ghes.c                 | 156 +++++++++++++++++++++++++++++----
> >  hw/arm/virt-acpi-build.c       |  33 ++++++-
> >  hw/core/machine.c              |   2 +
> >  include/hw/acpi/ghes.h         |  23 +++--
> >  5 files changed, 216 insertions(+), 28 deletions(-)
> >   
> 



Thanks,
Mauro

