Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3206CA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 09:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuopc-0001d5-Fm; Sat, 06 Sep 2025 05:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uuopa-0001cM-F8; Sat, 06 Sep 2025 05:03:34 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uuopQ-0001T8-Ll; Sat, 06 Sep 2025 05:03:32 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5841756F36F;
 Sat, 06 Sep 2025 11:03:13 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id M1Z96xIIw63k; Sat,  6 Sep 2025 11:03:11 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0AFF356F318; Sat, 06 Sep 2025 11:03:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 072FC56F30D;
 Sat, 06 Sep 2025 11:03:11 +0200 (CEST)
Date: Sat, 6 Sep 2025 11:03:10 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org, 
 John Levon <john.levon@nutanix.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: Re: [PATCH 07/22] hw/pci-host/raven: Fix AddressSpace exposure timing
In-Reply-To: <20250906-use-v1-7-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <cd21698f-db77-eb75-6966-d559fdcab835@eik.bme.hu>
References: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
 <20250906-use-v1-7-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, 6 Sep 2025, Akihiko Odaki wrote:
> raven-pcihost is not hotpluggable but its instance can still be created
> and finalized when processing the device-list-properties QMP command.
> Exposing such a temporary instance to AddressSpace should be
> avoided because it leaks the instance.

This may suggest there's an issue with freeing address spaces that should 
be fixed there at one place if possible rather than adding a new rule to 
remember not to create address spaces in init methods. Should adress space 
be a child of the device too so it's freed with it? This series simplifies 
some devices removing the rule to remember to unparent memory regions but 
this now adds another rule to remember avoid creating address spaces in 
init so overall we're in the same situation and still have to work around 
issues. This trades one workaround for another so still cannot fix all 
issues with freeing all created objects.

> Expose instances to the AddressSpace at their realization time so that
> it won't happen for the temporary instances.

I had a series here: 
https://patchew.org/QEMU/cover.1751493467.git.balaton@eik.bme.hu/
that changes this for raven (among other clean ups) but I could not get 
that merged in the last devel cycle because of PPC being a bit 
unmaintained. I'd prefer that series to be taken first instead of this 
patch so I don't have to rebase that.

Regards,
BALATON Zoltan

> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> hw/pci-host/raven.c | 27 ++++++++++++++-------------
> 1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index f8c0be5d21c351305742a696a65f70f87b546b0c..82f245c91cf267cdc6a518765a8c31d06eac7228 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -233,6 +233,20 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>     MemoryRegion *address_space_mem = get_system_memory();
>     int i;
>
> +    address_space_init(&s->pci_io_as, &s->pci_io, "raven-io");
> +
> +    /* CPU address space */
> +    memory_region_add_subregion(address_space_mem, PCI_IO_BASE_ADDR,
> +                                &s->pci_io);
> +    memory_region_add_subregion_overlap(address_space_mem, PCI_IO_BASE_ADDR,
> +                                        &s->pci_io_non_contiguous, 1);
> +    memory_region_add_subregion(address_space_mem, 0xc0000000, &s->pci_memory);
> +    pci_root_bus_init(&s->pci_bus, sizeof(s->pci_bus), DEVICE(d), NULL,
> +                      &s->pci_memory, &s->pci_io, 0, TYPE_PCI_BUS);
> +
> +    address_space_init(&s->bm_as, &s->bm, "raven-bm");
> +    pci_setup_iommu(&s->pci_bus, &raven_iommu_ops, s);
> +
>     /*
>      * According to PReP specification section 6.1.6 "System Interrupt
>      * Assignments", all PCI interrupts are routed via IRQ 15
> @@ -276,14 +290,12 @@ static void raven_pcihost_initfn(Object *obj)
> {
>     PCIHostState *h = PCI_HOST_BRIDGE(obj);
>     PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(obj);
> -    MemoryRegion *address_space_mem = get_system_memory();
>     DeviceState *pci_dev;
>
>     memory_region_init(&s->pci_io, obj, "pci-io", 0x3f800000);
>     memory_region_init_io(&s->pci_io_non_contiguous, obj, &raven_io_ops, s,
>                           "pci-io-non-contiguous", 0x00800000);
>     memory_region_init(&s->pci_memory, obj, "pci-memory", 0x3f000000);
> -    address_space_init(&s->pci_io_as, &s->pci_io, "raven-io");
>
>     /*
>      * Raven's raven_io_ops use the address-space API to access pci-conf-idx
> @@ -292,15 +304,6 @@ static void raven_pcihost_initfn(Object *obj)
>      */
>     s->pci_io_non_contiguous.disable_reentrancy_guard = true;
>
> -    /* CPU address space */
> -    memory_region_add_subregion(address_space_mem, PCI_IO_BASE_ADDR,
> -                                &s->pci_io);
> -    memory_region_add_subregion_overlap(address_space_mem, PCI_IO_BASE_ADDR,
> -                                        &s->pci_io_non_contiguous, 1);
> -    memory_region_add_subregion(address_space_mem, 0xc0000000, &s->pci_memory);
> -    pci_root_bus_init(&s->pci_bus, sizeof(s->pci_bus), DEVICE(obj), NULL,
> -                      &s->pci_memory, &s->pci_io, 0, TYPE_PCI_BUS);
> -
>     /* Bus master address space */
>     memory_region_init(&s->bm, obj, "bm-raven", 4 * GiB);
>     memory_region_init_alias(&s->bm_pci_memory_alias, obj, "bm-pci-memory",
> @@ -310,8 +313,6 @@ static void raven_pcihost_initfn(Object *obj)
>                              get_system_memory(), 0, 0x80000000);
>     memory_region_add_subregion(&s->bm, 0         , &s->bm_pci_memory_alias);
>     memory_region_add_subregion(&s->bm, 0x80000000, &s->bm_ram_alias);
> -    address_space_init(&s->bm_as, &s->bm, "raven-bm");
> -    pci_setup_iommu(&s->pci_bus, &raven_iommu_ops, s);
>
>     h->bus = &s->pci_bus;
>
>
>

