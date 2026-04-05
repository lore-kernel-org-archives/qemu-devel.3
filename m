Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9645AE64013
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 12:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9Msd-0007JC-9P; Sun, 05 Apr 2026 08:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w9Kqj-00088v-IH; Sun, 05 Apr 2026 06:37:01 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w9Kqh-0001rp-7q; Sun, 05 Apr 2026 06:37:01 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8DCD85969F9;
 Sun, 05 Apr 2026 12:36:52 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id TU9sGq3toNMD; Sun,  5 Apr 2026 12:36:50 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 757485969F6; Sun, 05 Apr 2026 12:36:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 736F95968DE;
 Sun, 05 Apr 2026 12:36:50 +0200 (CEST)
Date: Sun, 5 Apr 2026 12:36:50 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: "Scott J. Goldman" <scottjgo@gmail.com>
cc: qemu-devel@nongnu.org, alex@shazbot.org, clg@redhat.com, 
 pbonzini@redhat.com, rbolshakov@ddn.com, phil@philjordan.eu, 
 mst@redhat.com, john.levon@nutanix.com, thanos.makatos@nutanix.com, 
 qemu-s390x@nongnu.org
Subject: Re: [RFC PATCH 00/10] vfio: PCI device passthrough on Apple Silicon
 Macs
In-Reply-To: <20260405072857.66484-1-scottjgo@gmail.com>
Message-ID: <f0a13985-e737-b06a-773d-cddb90444721@eik.bme.hu>
References: <20260405072857.66484-1-scottjgo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Sun, 5 Apr 2026, Scott J. Goldman wrote:
> This series adds VFIO PCI device passthrough support for Apple Silicon
> Macs running macOS, using a DriverKit extension (dext) as the host
> backend instead of the Linux VFIO kernel driver.
>
> I'm sending this as an RFC because I'd like feedback before investing
> further in upstreaming.  The code is functional.  I've tested it with
> an NVIDIA RTX 5090 in a Thunderbolt dock on an M4 MacBook Air.  GPU
> gaming works but is slow (~30 fps on high settings in Cyberpunk 2077
> [1]), likely due to the BAR access penalty described below.  AI
> inference workloads appear less affected.  Ollama with Qwen 3.5
> generates around 140 tok/sec on the same setup [2].
>
> How it works:
>
> On Linux, VFIO relies on kernel-managed IOMMU groups and /dev/vfio
> for device access and DMA mapping.  On macOS, there is no equivalent
> kernel interface.  Instead, a userspace DriverKit extension
> (VFIOUserPCIDriver) mediates access to the physical PCI device through
> IOKit's IOUserClient and PCIDriverKit APIs.
>
> The series keeps the existing VFIOPCIDevice model and reuses QEMU's
> passthrough infrastructure.  A few ioctl callsites are refactored into
> io_ops callbacks, the build system is extended for Darwin, and the
> Apple-specific backend plugs in behind those abstractions.
>
> The guest sees two PCI devices: the passthrough device itself
> (vfio-apple-pci, which subclasses VFIOPCIDevice) and a companion
> DMA mapping device (apple-dma-pci).  On the QEMU side, an
> AppleVFIOContainer implements the IOMMU backend, and a C client
> library wraps the IOUserClient calls to the dext for config space,
> BAR MMIO, interrupts, reset, and DMA.
>
> DMA limitations:
>
> This is the biggest platform constraint.  Unlike a typical IOMMU
> mapping operation where the caller specifies the IOVA, the
> PCIDriverKit API (IODMACommand::PrepareForDMA) returns a
> system-assigned IOVA.  There is no way to request a specific address.
> This means the guest's requested DMA addresses cannot be used
> directly.  The guest kernel module must intercept DMA mapping calls
> and forward them through the companion device to get the actual
> hardware IOVA.

I don't know this so what I say might not make sense but I think there is 
iommu emulation in QEMU so could that be used to do this in QEMU and avoid 
needing a kernel module for it in the guest?

Regards,
BALATON Zoltan

