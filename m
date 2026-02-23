Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754ABEC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZyA-0007SI-9r; Mon, 23 Feb 2026 12:43:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vuZy6-0007Ry-To
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:43:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vuZy4-0000Rj-4Z
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771868612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hl5LrGk+eaTkdaBfGuO+Ynh50CLnvvLoVQyYBMXazW8=;
 b=EuKvVX5aOAV36Mva3J+JHW8J2GffJYT4eutjF8Xvzsm9CchdsQYITaagK14NBZor+yvLM0
 VNOeWvJKlR1iUefsniM9ynstIZzhWX3vKGIdpbzPfixaU3hucqPmsItEH9VL4uJJlZef6W
 q2brAmnIA5pW1ePdhSvaU4aSFUP8wXc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-tfnGkysCOjq9POJONxvJVw-1; Mon,
 23 Feb 2026 12:43:29 -0500
X-MC-Unique: tfnGkysCOjq9POJONxvJVw-1
X-Mimecast-MFC-AGG-ID: tfnGkysCOjq9POJONxvJVw_1771868608
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AB5D18001FB; Mon, 23 Feb 2026 17:43:28 +0000 (UTC)
Received: from [10.45.224.205] (unknown [10.45.224.205])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 99E491800286; Mon, 23 Feb 2026 17:43:25 +0000 (UTC)
Message-ID: <5a129a35-d38c-43bb-a5dd-fd15a51c11c8@redhat.com>
Date: Mon, 23 Feb 2026 18:43:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci: Avoid adding PCI devices to the "unattached" QOM
 tree node
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20260217065512.245237-1-thuth@redhat.com>
 <20260219160641.6f63c27d@imammedo> <20260219161822.55e83382@imammedo>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260219161822.55e83382@imammedo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 19/02/2026 16.18, Igor Mammedov wrote:
> On Thu, 19 Feb 2026 16:06:41 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
>> On Tue, 17 Feb 2026 07:55:12 +0100
>> Thomas Huth <thuth@redhat.com> wrote:
>>
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> PCI devices that are added via pci_create_simple_multifunction(),
>>> pci_create_simple() or pci_init_nic_in_slot() currently show up
>>> under "/machine/unattached" in the QOM tree. This is somewhat ugly,
>>> the parent should rather be the PCI bus node instead, so let's add
>>> the proper relation here.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   hw/pci/pci.c | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>>
>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>> index 90d6d71efdc..2f4d2be50fd 100644
>>> --- a/hw/pci/pci.c
>>> +++ b/hw/pci/pci.c
>>> @@ -2071,6 +2071,15 @@ const pci_class_desc *get_class_desc(int class)
>>>       return desc;
>>>   }
>>>   
>>> +static void pci_dev_property_add_child(PCIBus *bus, const char *name,
>>> +                                       PCIDevice *dev)
>>> +{
>>> +    g_autofree char *childname = g_strdup_printf("%s[%d.%d]", name,
>>> +                                                 PCI_SLOT(dev->devfn),
>>> +                                                 PCI_FUNC(dev->devfn));
>>> +    object_property_add_child(OBJECT(bus), childname, OBJECT(dev));
>>> +}
>>> +
>>>   void pci_init_nic_devices(PCIBus *bus, const char *default_model)
>>>   {
>>>       qemu_create_nic_bus_devices(&bus->qbus, TYPE_PCI_DEVICE, default_model,
>>> @@ -2114,6 +2123,7 @@ bool pci_init_nic_in_slot(PCIBus *rootbus, const char *model,
>>>   
>>>       pci_dev = pci_new(devfn, model);
>> there are a few more places that have similar pattern, should we fix them to?

You mean the various spots in the device models that call pci_new() or 
pci_new_multifunction(), followed by a pci_realize_and_unref() without 
adding the child property in between? ... yes, I think most of those likely 
need fixing, too.

I wonder whether I should rather drop this patch and add some logic to 
pci_realize_and_unref() instead to fix it there, so all spots would benefit 
from that change automatically? WDYT?

>>>       qdev_set_nic_properties(&pci_dev->qdev, nd);
>>> +    pci_dev_property_add_child(bus, model, pci_dev);
>>
>>>       pci_realize_and_unref(pci_dev, bus, &error_fatal);
>> this one also takes bus as an argument, and then goes down to
>>   qdev_realize_and_unref->qdev_realize->qdev_set_parent_bus->bus_add_child
>> that eventually creates a link to device.
>>
>> wouldn't pci_dev_property_add_child() create a duplicate entry
>> as a child with different name component there?

No, it's two different concepts in QEMU: QOM vs. qdev !

The thing that you found is qdev, and that's already looking fine (when you 
use "info qtree" on the HMP prompt, you can see that e.g. the VGA device 
should already show up as child of the "pci.0" bus for the i440fx machine).

My patch is about QOM, where e.g. the VGA node shows up in 
/machine/unattached instead of /machine/i440fx/pci.0

>> another question, should we 'fix' qdev_set_parent_bus->bus_add_child
>> to add a child instead of a link? That would do what patch intends
>> but consistently for all devices with parent bus.

I've got another patch on the list that does fiddle with qdev_realize (right 
after calling qdev_set_parent_bus):

  https://lore.kernel.org/qemu-devel/20260217164049.543975-1-thuth@redhat.com/

But I think we still want something here for PCI devices so that we can take 
advantage of the dev->devfn for creating the location on the bus in the 
square brackets.

> and then this rises a question if the bus should be a parent or
> the owner of the bus is the parent?
With my patch, the qom-tree looks like this:

QEMU 10.2.50 monitor - type 'help' for more information
(qemu) info qom-tree
/machine (pc-i440fx-11.0-machine)
   /fw_cfg (fw_cfg_io)
     /\x2from@etc\x2facpi\x2frsdp[0] (memory-region)
     /\x2from@etc\x2facpi\x2ftables[0] (memory-region)
     /\x2from@etc\x2ftable-loader[0] (memory-region)
     /fwcfg.dma[0] (memory-region)
     /fwcfg[0] (memory-region)
   /i440fx (i440FX-pcihost)
     /ioapic (ioapic)
       /ioapic[0] (memory-region)
       /unnamed-gpio-in[0] (irq)
       /unnamed-gpio-in[10] (irq)
       /unnamed-gpio-in[11] (irq)
       /unnamed-gpio-in[12] (irq)
       /unnamed-gpio-in[13] (irq)
       /unnamed-gpio-in[14] (irq)
       /unnamed-gpio-in[15] (irq)
       /unnamed-gpio-in[16] (irq)
       /unnamed-gpio-in[17] (irq)
       /unnamed-gpio-in[18] (irq)
       /unnamed-gpio-in[19] (irq)
       /unnamed-gpio-in[1] (irq)
       /unnamed-gpio-in[20] (irq)
       /unnamed-gpio-in[21] (irq)
       /unnamed-gpio-in[22] (irq)
       /unnamed-gpio-in[23] (irq)
       /unnamed-gpio-in[2] (irq)
       /unnamed-gpio-in[3] (irq)
       /unnamed-gpio-in[4] (irq)
       /unnamed-gpio-in[5] (irq)
       /unnamed-gpio-in[6] (irq)
       /unnamed-gpio-in[7] (irq)
       /unnamed-gpio-in[8] (irq)
       /unnamed-gpio-in[9] (irq)
     /pci-conf-data[0] (memory-region)
     /pci-conf-idx[0] (memory-region)
     /pci.0 (PCI)
       /VGA[31.7] (VGA)
         /bochs dispi interface[0] (memory-region)
         /bus master container[0] (memory-region)
         /bus master[0] (memory-region)
         /edid[0] (memory-region)
         /qemu extended regs[0] (memory-region)
         /vbe[0] (memory-region)
         /vga ioports remapped[0] (memory-region)
         /vga-lowmem[0] (memory-region)
         /vga.mmio[0] (memory-region)
         /vga.rom[0] (memory-region)
         /vga.vram[0] (memory-region)
         /vga[0] (memory-region)
         /vga[1] (memory-region)
         /vga[2] (memory-region)
         /vga[3] (memory-region)
         /vga[4] (memory-region)
       /i440FX[0.0] (i440FX)
         /bus master container[0] (memory-region)
         /bus master[0] (memory-region)
         /pam-pci[0] (memory-region)
         /pam-pci[10] (memory-region)
         /pam-pci[11] (memory-region)
         /pam-pci[12] (memory-region)
         /pam-pci[13] (memory-region)
         /pam-pci[14] (memory-region)
         /pam-pci[15] (memory-region)
         /pam-pci[16] (memory-region)
         /pam-pci[17] (memory-region)
         /pam-pci[18] (memory-region)
         /pam-pci[19] (memory-region)
         /pam-pci[1] (memory-region)
         /pam-pci[20] (memory-region)
         /pam-pci[21] (memory-region)
         /pam-pci[22] (memory-region)
         /pam-pci[23] (memory-region)
         /pam-pci[24] (memory-region)
         /pam-pci[25] (memory-region)
         /pam-pci[2] (memory-region)
         /pam-pci[3] (memory-region)
         /pam-pci[4] (memory-region)
         /pam-pci[5] (memory-region)
         /pam-pci[6] (memory-region)
         /pam-pci[7] (memory-region)
         /pam-pci[8] (memory-region)
         /pam-pci[9] (memory-region)
         /pam-ram[0] (memory-region)
         /pam-ram[10] (memory-region)
         /pam-ram[11] (memory-region)
         /pam-ram[12] (memory-region)
         /pam-ram[1] (memory-region)
         /pam-ram[2] (memory-region)
         /pam-ram[3] (memory-region)
         /pam-ram[4] (memory-region)
         /pam-ram[5] (memory-region)
         /pam-ram[6] (memory-region)
         /pam-ram[7] (memory-region)
         /pam-ram[8] (memory-region)
         /pam-ram[9] (memory-region)
         /pam-rom[0] (memory-region)
         /pam-rom[10] (memory-region)
         /pam-rom[11] (memory-region)
         /pam-rom[12] (memory-region)
         /pam-rom[1] (memory-region)
         /pam-rom[2] (memory-region)
         /pam-rom[3] (memory-region)
         /pam-rom[4] (memory-region)
         /pam-rom[5] (memory-region)
         /pam-rom[6] (memory-region)
         /pam-rom[7] (memory-region)
         /pam-rom[8] (memory-region)
         /pam-rom[9] (memory-region)
         /smram-low[0] (memory-region)
         /smram-region[0] (memory-region)
         /smram[0] (memory-region)
   /peripheral (container)
   /peripheral-anon (container)
   /unattached (container)
     /device[0] (qemu64-x86_64-cpu)
       /lapic (apic)
         /apic-msi[0] (memory-region)
       /memory[0] (memory-region)
       /memory[1] (memory-region)
       /smram[0] (memory-region)
     /device[10] (isa-parallel)
       /parallel[0] (memory-region)
     /device[11] (isa-fdc)
       /fdc[0] (memory-region)
       /fdc[1] (memory-region)
       /floppy-bus.0 (floppy-bus)
     /device[12] (floppy)
     /device[13] (i8042)
       /i8042-cmd[0] (memory-region)
       /i8042-data[0] (memory-region)
       /ps2-kbd-input-irq[0] (irq)
       /ps2-mouse-input-irq[0] (irq)
       /ps2kbd (ps2-kbd)
       /ps2mouse (ps2-mouse)
     /device[14] (vmport)
       /vmport[0] (memory-region)
     /device[15] (vmmouse)
     /device[16] (port92)
       /port92[0] (memory-region)
     /device[17] (e1000)
       /bus master container[0] (memory-region)
       /bus master[0] (memory-region)
       /e1000-io[0] (memory-region)
       /e1000-mmio[0] (memory-region)
       /e1000.rom[0] (memory-region)
     /device[18] (smbus-eeprom)
     /device[19] (smbus-eeprom)
     /device[1] (kvmvapic)
       /kvmvapic[0] (memory-region)
     /device[20] (smbus-eeprom)
     /device[21] (smbus-eeprom)
     /device[22] (smbus-eeprom)
     /device[23] (smbus-eeprom)
     /device[24] (smbus-eeprom)
     /device[25] (smbus-eeprom)
     /device[2] (PIIX3)
       /bus master container[0] (memory-region)
       /bus master[0] (memory-region)
       /dma[0] (i8257)
         /dma-chan[0] (memory-region)
         /dma-cont[0] (memory-region)
         /dma-page[0] (memory-region)
         /dma-page[1] (memory-region)
       /dma[1] (i8257)
         /dma-chan[0] (memory-region)
         /dma-cont[0] (memory-region)
         /dma-page[0] (memory-region)
         /dma-page[1] (memory-region)
       /ide (piix3-ide)
         /bmdma[0] (memory-region)
         /bmdma[1] (memory-region)
         /bus master container[0] (memory-region)
         /bus master[0] (memory-region)
         /ide.0 (IDE)
         /ide.1 (IDE)
         /piix-bmdma-container[0] (memory-region)
         /piix-bmdma[0] (memory-region)
         /piix-bmdma[1] (memory-region)
       /isa.0 (ISA)
       /piix-reset-control[0] (memory-region)
       /pm (PIIX4_PM)
         /acpi-cnt[0] (memory-region)
         /acpi-cpu-hotplug[0] (memory-region)
         /acpi-evt[0] (memory-region)
         /acpi-gpe0[0] (memory-region)
         /acpi-pci-hotplug[0] (memory-region)
         /acpi-tmr[0] (memory-region)
         /apm-io[0] (memory-region)
         /bus master container[0] (memory-region)
         /bus master[0] (memory-region)
         /i2c (i2c-bus)
         /piix4-pm[0] (memory-region)
         /pm-smbus[0] (memory-region)
       /rtc (mc146818rtc)
         /rtc-index[0] (memory-region)
         /rtc[0] (memory-region)
     /device[3] (ide-cd)
     /device[4] (isa-i8259)
       /elcr[0] (memory-region)
       /pic[0] (memory-region)
       /unnamed-gpio-in[0] (irq)
       /unnamed-gpio-in[1] (irq)
       /unnamed-gpio-in[2] (irq)
       /unnamed-gpio-in[3] (irq)
       /unnamed-gpio-in[4] (irq)
       /unnamed-gpio-in[5] (irq)
       /unnamed-gpio-in[6] (irq)
       /unnamed-gpio-in[7] (irq)
     /device[5] (isa-i8259)
       /elcr[0] (memory-region)
       /pic[0] (memory-region)
       /unnamed-gpio-in[0] (irq)
       /unnamed-gpio-in[1] (irq)
       /unnamed-gpio-in[2] (irq)
       /unnamed-gpio-in[3] (irq)
       /unnamed-gpio-in[4] (irq)
       /unnamed-gpio-in[5] (irq)
       /unnamed-gpio-in[6] (irq)
       /unnamed-gpio-in[7] (irq)
     /device[6] (hpet)
       /hpet[0] (memory-region)
       /unnamed-gpio-in[0] (irq)
       /unnamed-gpio-in[1] (irq)
     /device[7] (isa-pit)
       /pit[0] (memory-region)
       /unnamed-gpio-in[0] (irq)
     /device[8] (isa-pcspk)
       /pcspk[0] (memory-region)
     /device[9] (isa-serial)
       /serial (serial)
       /serial[0] (memory-region)
     /ide[0] (memory-region)
     /ide[1] (memory-region)
     /ide[2] (memory-region)
     /ide[3] (memory-region)
     /io[0] (memory-region)
     /ioport80[0] (memory-region)
     /ioportF0[0] (memory-region)
     /isa-bios[0] (memory-region)
     /non-qdev-gpio[0] (irq)
     /non-qdev-gpio[10] (irq)
     /non-qdev-gpio[11] (irq)
     /non-qdev-gpio[12] (irq)
     /non-qdev-gpio[13] (irq)
     /non-qdev-gpio[14] (irq)
     /non-qdev-gpio[15] (irq)
     /non-qdev-gpio[16] (irq)
     /non-qdev-gpio[17] (irq)
     /non-qdev-gpio[18] (irq)
     /non-qdev-gpio[19] (irq)
     /non-qdev-gpio[1] (irq)
     /non-qdev-gpio[20] (irq)
     /non-qdev-gpio[21] (irq)
     /non-qdev-gpio[22] (irq)
     /non-qdev-gpio[23] (irq)
     /non-qdev-gpio[24] (irq)
     /non-qdev-gpio[25] (irq)
     /non-qdev-gpio[26] (irq)
     /non-qdev-gpio[27] (irq)
     /non-qdev-gpio[2] (irq)
     /non-qdev-gpio[3] (irq)
     /non-qdev-gpio[4] (irq)
     /non-qdev-gpio[5] (irq)
     /non-qdev-gpio[6] (irq)
     /non-qdev-gpio[7] (irq)
     /non-qdev-gpio[8] (irq)
     /non-qdev-gpio[9] (irq)
     /pc.bios[0] (memory-region)
     /pc.rom[0] (memory-region)
     /pci[0] (memory-region)
     /ram-below-4g[0] (memory-region)
     /sysbus (System)
     /system[0] (memory-region)

You can see that e.g. the VGA node now shows up under /machine/i440fx/pci.0 
... and that sounds like the right location to me. So I don't think that the 
owner of the bus should be the parent here.

  Thomas


