Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84659C0218D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 10:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdo3y-0004o1-Uh; Fri, 31 Jan 2025 05:15:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tdo3w-0004nf-VW
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 05:15:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tdo3u-0001wN-56
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 05:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738318544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RAL8I5U5AJvCKe/I/9eCPwKxJIf/F1mhzK4orsq7tb4=;
 b=AZ6Awrno+k5FQ6D/pZJJdKDUL3g6AlCQ7OpljL3RIA229lApo0kD74SpXAhxbD/5WbwfnL
 ETiUBum8V1upPHZaXa1u5yb6OYXW2LJu4cJEFMtCR+bTgo8SMCqmLBaiwkgHwTmvUZmmfj
 70koFNi5KYa+ElkgthCI4cHn4jiUGDA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-IU7vdvmKPGme9lTASQBrjg-1; Fri, 31 Jan 2025 05:15:41 -0500
X-MC-Unique: IU7vdvmKPGme9lTASQBrjg-1
X-Mimecast-MFC-AGG-ID: IU7vdvmKPGme9lTASQBrjg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385d6ee042eso1077985f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 02:15:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738318540; x=1738923340;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RAL8I5U5AJvCKe/I/9eCPwKxJIf/F1mhzK4orsq7tb4=;
 b=v/oymzdXLS5tqzY1SU9s5UbUNr126pPZfOzECtmiBIXbhQfWwGug1IG7TmHZ79oVCM
 5nwjcQHAekzOnWJL24FGqVlVths+VWqd28tUR9610o+Ql6/xTNYNrQoqEqlp1gm+XCX3
 Kh1MWbPM0cfsjcYl2gzZLqwid7bZF2LOuAdkWOGZB5yxchjZODBtckKUx6ZWZxLQRjHP
 +yTv0t+EtuRvPxkGwaZ1TcamIEAcIrwvoGkpu6CloQOAimIWEvv3RoKpZSbj9fbinwvX
 BI3oLNcB3vK/mVZ85AVL7BgasMZ/p1vO/l2P45E8WUvighKiB1L5r7I1E5lnQ/XsKfGF
 MRkA==
X-Gm-Message-State: AOJu0Yz8eY+BgbhKQtJd3h2kH+MNDIx4trgbIXW0b5i0G23uLxQ7fSDs
 xxaqQfH7VzZYKN/JpvrUG8oElo2cOKe4ioZRZleUjPEDiglkx9BhFHIjFew34PDmk0N8TgFgja4
 8aVrPEyHaKMKEQ121VnvvOKu8+OiML3j7ZhxxWWhM8PQUtmtYotWj
X-Gm-Gg: ASbGncsAZfkbxhsSzFQC7QKPK7o/R6owt+rHHbkTEcpkP/Ja0dFvQtQEI0juzx9UhXI
 ZJ2CHpn2BaXgxi11VheVsjecOOfpZMrcg1/VOcclH9eKmJv2LdBKG05MrLNh/haO/aRU+eEFECo
 wuj0xJcXT+D8ZFAsqep2BHyZRNyxt5vPUyKXi9rxcII5ZWgTd60khGKb6/sMV7w77Vaat0Vh5+H
 p9wd2ECRuhCgivzASpX1zTMQiam6dqlU1YimTmGwv8V93GpdQraXSZ0O9HAncq+tbLdIEVgnRbF
 i0IqA0zprVj5KHuvzdaBa23NXZ9VDRQoSCrcGa/XpTI=
X-Received: by 2002:a05:6000:2a8:b0:385:efc7:932d with SMTP id
 ffacd0b85a97d-38c520af4demr9830129f8f.46.1738318540162; 
 Fri, 31 Jan 2025 02:15:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3KH5ChqAd7NjCnxUDXFfMx+E8v19mUePpTgNuQmWpQtFAZBnGFtwKGsCAlUdHzerti7L5Zg==
X-Received: by 2002:a05:6000:2a8:b0:385:efc7:932d with SMTP id
 ffacd0b85a97d-38c520af4demr9830103f8f.46.1738318539633; 
 Fri, 31 Jan 2025 02:15:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1d0bbfsm4333725f8f.98.2025.01.31.02.15.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 02:15:39 -0800 (PST)
Message-ID: <6cbfd37a-ce7d-4be0-ac7d-81cb7c805933@redhat.com>
Date: Fri, 31 Jan 2025 11:15:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] vfio/igd: handle x-igd-opregion in
 vfio_probe_igd_config_quirk()
To: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20250124191245.12464-1-tomitamoeko@gmail.com>
 <20250124191245.12464-6-tomitamoeko@gmail.com>
 <20250124141342.255a79d3.alex.williamson@redhat.com>
 <7cd85e39-88e6-497d-b0b0-41a0a0ece0fb@gmail.com>
 <377fd72e-6bff-45f4-a9db-413f3565fd75@gmail.com>
 <20250130134113.5d60442f.alex.williamson@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250130134113.5d60442f.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/30/25 21:41, Alex Williamson wrote:
> On Fri, 31 Jan 2025 02:33:03 +0800
> Tomita Moeko <tomitamoeko@gmail.com> wrote:
> 
>> On 1/25/25 15:42, Tomita Moeko wrote:
>>> On 1/25/25 05:13, Alex Williamson wrote:
>>>> On Sat, 25 Jan 2025 03:12:45 +0800
>>>> Tomita Moeko <tomitamoeko@gmail.com> wrote:
>>>>   
>>>>> Both enable opregion option (x-igd-opregion) and legacy mode require
>>>>> setting up OpRegion copy for IGD devices. Move x-igd-opregion handler
>>>>> in vfio_realize() to vfio_probe_igd_config_quirk() to elimate duplicate
>>>>> code. Finally we moved all the IGD-related code into igd.c.
>>>>>
>>>>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>>>>> ---
>>>>>   hw/vfio/igd.c        | 143 +++++++++++++++++++++++++++++++++----------
>>>>>   hw/vfio/pci-quirks.c |  50 ---------------
>>>>>   hw/vfio/pci.c        |  25 --------
>>>>>   hw/vfio/pci.h        |   4 --
>>>>>   4 files changed, 110 insertions(+), 112 deletions(-)
>>>>>
>>>>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>>>>> index 6e06dd774a..015beacf5f 100644
>>>>> --- a/hw/vfio/igd.c
>>>>> +++ b/hw/vfio/igd.c
>>>>> @@ -106,6 +106,7 @@ static int igd_gen(VFIOPCIDevice *vdev)
>>>>>       return -1;
>>>>>   }
>>>>>   
>>>>> +#define IGD_ASLS 0xfc /* ASL Storage Register */
>>>>>   #define IGD_GMCH 0x50 /* Graphics Control Register */
>>>>>   #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
>>>>>   #define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11 and later */
>>>>> @@ -138,6 +139,55 @@ static uint64_t igd_stolen_memory_size(int gen, uint32_t gmch)
>>>>>       return 0;
>>>>>   }
>>>>>   
>>>>> +/*
>>>>> + * The OpRegion includes the Video BIOS Table, which seems important for
>>>>> + * telling the driver what sort of outputs it has.  Without this, the device
>>>>> + * may work in the guest, but we may not get output.  This also requires BIOS
>>>>> + * support to reserve and populate a section of guest memory sufficient for
>>>>> + * the table and to write the base address of that memory to the ASLS register
>>>>> + * of the IGD device.
>>>>> + */
>>>>> +static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>>>>> +                                       struct vfio_region_info *info,
>>>>> +                                       Error **errp)
>>>>> +{
>>>>> +    int ret;
>>>>> +
>>>>> +    vdev->igd_opregion = g_malloc0(info->size);
>>>>> +    ret = pread(vdev->vbasedev.fd, vdev->igd_opregion,
>>>>> +                info->size, info->offset);
>>>>> +    if (ret != info->size) {
>>>>> +        error_setg(errp, "failed to read IGD OpRegion");
>>>>> +        g_free(vdev->igd_opregion);
>>>>> +        vdev->igd_opregion = NULL;
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>>> +    /*
>>>>> +     * Provide fw_cfg with a copy of the OpRegion which the VM firmware is to
>>>>> +     * allocate 32bit reserved memory for, copy these contents into, and write
>>>>> +     * the reserved memory base address to the device ASLS register at 0xFC.
>>>>> +     * Alignment of this reserved region seems flexible, but using a 4k page
>>>>> +     * alignment seems to work well.  This interface assumes a single IGD
>>>>> +     * device, which may be at VM address 00:02.0 in legacy mode or another
>>>>> +     * address in UPT mode.
>>>>> +     *
>>>>> +     * NB, there may be future use cases discovered where the VM should have
>>>>> +     * direct interaction with the host OpRegion, in which case the write to
>>>>> +     * the ASLS register would trigger MemoryRegion setup to enable that.
>>>>> +     */
>>>>> +    fw_cfg_add_file(fw_cfg_find(), "etc/igd-opregion",
>>>>> +                    vdev->igd_opregion, info->size);
>>>>> +
>>>>> +    trace_vfio_pci_igd_opregion_enabled(vdev->vbasedev.name);
>>>>> +
>>>>> +    pci_set_long(vdev->pdev.config + IGD_ASLS, 0);
>>>>> +    pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
>>>>> +    pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~0);
>>>>> +
>>>>> +    return true;
>>>>> +}
>>>>> +
>>>>>   /*
>>>>>    * The rather short list of registers that we copy from the host devices.
>>>>>    * The LPC/ISA bridge values are definitely needed to support the vBIOS, the
>>>>> @@ -339,29 +389,83 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>>>>       QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
>>>>>   }
>>>>>   
>>>>> +static bool vfio_igd_try_enable_opregion(VFIOPCIDevice *vdev, Error **errp)
>>>>> +{
>>>>> +    g_autofree struct vfio_region_info *opregion = NULL;
>>>>> +    int ret;
>>>>> +
>>>>> +    /*
>>>>> +     * Hotplugging is not supprted for both opregion access and legacy mode.
>>>>> +     * For legacy mode, we also need to mark the ROM failed.
>>>>> +     */
>>>>
>>>> The explanation was a little better in the removed comment.
>>>>   
>>>>> +    if (vdev->pdev.qdev.hotplugged) {
>>>>> +        vdev->rom_read_failed = true;
>>>>> +        error_setg(errp,
>>>>> +                   "IGD OpRegion is not supported on hotplugged device");
>>>>
>>>> As was the error log.
>>>>   
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>>> +    ret = vfio_get_dev_region_info(&vdev->vbasedev,
>>>>> +                    VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
>>>>> +                    VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
>>>>> +    if (ret) {
>>>>> +        error_setg_errno(errp, -ret,
>>>>> +                         "device does not supports IGD OpRegion feature");
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>>> +    if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>>> +    return true;
>>>>> +}
>>>>> +
>>>>>   bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>>>>> -                                 Error **errp G_GNUC_UNUSED)
>>>>> +                                 Error **errp)
>>>>>   {
>>>>>       g_autofree struct vfio_region_info *rom = NULL;
>>>>> -    g_autofree struct vfio_region_info *opregion = NULL;
>>>>>       g_autofree struct vfio_region_info *host = NULL;
>>>>>       g_autofree struct vfio_region_info *lpc = NULL;
>>>>> +    PCIBus *bus;
>>>>>       PCIDevice *lpc_bridge;
>>>>>       int ret, gen;
>>>>> +    bool legacy_mode, enable_opregion;
>>>>>       uint64_t gms_size;
>>>>>       uint64_t *bdsm_size;
>>>>>       uint32_t gmch;
>>>>>       Error *err = NULL;
>>>>>   
>>>>> +    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>>>>> +        !vfio_is_vga(vdev)) {
>>>>> +        return true;
>>>>> +    }
>>>>> +
>>>>>       /*
>>>>>        * This must be an Intel VGA device at address 00:02.0 for us to even
>>>>>        * consider enabling legacy mode.  The vBIOS has dependencies on the
>>>>>        * PCI bus address.
>>>>>        */
>>>>> -    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>>>>> -        !vfio_is_vga(vdev) ||
>>>>> -        &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
>>>>> -                                       0, PCI_DEVFN(0x2, 0))) {
>>>>> +    bus = pci_device_root_bus(&vdev->pdev);
>>>>> +    legacy_mode = (&vdev->pdev == pci_find_device(bus, 0, PCI_DEVFN(0x2, 0)));
>>>>> +    enable_opregion = (vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION);
>>>>> +
>>>>> +    if (!enable_opregion && !legacy_mode) {
>>>>> +        return true;
>>>>> +    }
>>>>> +
>>>>> +    if (!vfio_igd_try_enable_opregion(vdev, &err)) {
>>>>> +        if (enable_opregion) {
>>>>> +            error_propagate(errp, err);
>>>>> +            return false;
>>>>> +        } else if (legacy_mode) {
>>>>> +            error_append_hint(&err, "IGD legacy mode disabled\n");
>>>>> +            error_report_err(err);
>>>>> +            return true;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    if (!legacy_mode) {
>>>>>           return true;
>>>>>       }
>>>>>   
>>>>> @@ -404,30 +508,10 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>>>>>           return true;
>>>>>       }
>>>>>   
>>>>> -    /*
>>>>> -     * Ignore the hotplug corner case, mark the ROM failed, we can't
>>>>> -     * create the devices we need for legacy mode in the hotplug scenario.
>>>>> -     */
>>>>> -    if (vdev->pdev.qdev.hotplugged) {
>>>>> -        error_report("IGD device %s hotplugged, ROM disabled, "
>>>>> -                     "legacy mode disabled", vdev->vbasedev.name);
>>>>> -        vdev->rom_read_failed = true;
>>>>> -        return true;
>>>>> -    }
>>>>> -
>>>>>       /*
>>>>>        * Check whether we have all the vfio device specific regions to
>>>>>        * support legacy mode (added in Linux v4.6).  If not, bail.
>>>>>        */
>>>>> And we're disassociating opregion setup from this useful comment.
>>>>
>>>> What are we actually accomplishing here?  What specific code
>>>> duplication is eliminated?
>>>
>>> This patch is designed for moving the opregion quirk in vfio_realize()
>>> to igd.c, for better isolation of the igd-specific code. Legacy mode
>>> also need to initialize opregion as x-igd-opregion=on option. These
>>> code are almost the same, except legacy mode continues on error, while
>>> x-igd-opregion fails.
>>>
>>> I am going to clearify that in the commit message of v3.
>>>    
>>>> Why is it important to move all this code to igd.c?
>>
>> x-igd-opreqion quirk is currently located in pci-quirks.c, which is not
>> controlled by CONFIG_VFIO_IGD, moving it to igd.c prevents building
>> that unnecessary code in certain binaries, for example, non x86 builds.
>>
>>>> It's really difficult to untangle this refactor, I think it could be
>>>> done more iteratively, if it's really even beneficial.  Thanks,
>>>>
>>>> Alex
>>>
>>> Agreed. Actually I'd like to totally remove the "legacy mode" and "UPT
>>> mode" concept in future, my proposal is:
>>> * Emulate and initialize ASLS and BDSM register unconditionally. These
>>>    registers holds HPA, keeping the old value to guest is not a good
>>>    idea
>>> * Make the host bridge and LPC bridge ID quirks optional like OpRegion.
>>>    Recent Linux kernel and Windows driver seems not relying on it. This
>>>    enables IGD passthrough on Q35 machines, but probably without UEFI
>>>    GOP or VBIOS support, as it is observed they require specific LPC
>>>    bridge DID to work.
>>> * Remove the requirement of IGD device class being VGA controller, this
>>>    was previous discussed in my kernel change [1]
>>> * Update the document
>>>
>>> It would time consuming to implement all them, coding is not difficult,
>>> but I have to verify my change on diffrent platforms. And they are out
>>> of this patchset's scope I think. I personally perfers doing it in a
>>> future patchset.
>>>
>>> [1] https://lore.kernel.org/all/20250123163416.7653-1-tomitamoeko@gmail.com/
>>>
>>> Thanks,
>>> Moeko
>>
>> Please let me know if you have any thoughts or suggestions, in case
>> you missed the previous mail.
> 
> TBH, I'm surprised there's so much interest in direct assignment of
> igd.  I'd be curious in your motivation, if you can share it.
> 
> Regardless, it's nice to see it updated for newer hardware and I don't
> mind the goal of isolating the code so it can be disabled on other
> archs, so long as we can do so in small, logical steps that are easy to
> follow.
> 
> At this point, the idea of legacy vs UPT might only exist in QEMU.
> There are going to be some challenges to avoid breaking existing VM
> command lines if the host and LPC bridge quirks become optional.  There
> are a couple x-igd- options that we're free to break as they've always
> been experimental, but the implicit LPC bridge and host bridge quirks
> need to be considered carefully.  The fact that "legacy" mode has never
> previously worked on q35 could mean that we can tie those quirks to a
> new experimental option that's off by default and only enabled for
> 440fx machine types.
> 
> I'm glad you included the documentation update in your list, it's
> clearly out of date, as is some of my knowledge regarding guest driver
> requirements.  

Could we please have an update of docs/igd-assign.txt too ?

As some point, we should consolidate all VFIO documentation under
one section. That's another topic.

> I hope we can make some progress on uefi support as well,
> as that's essentially a requirement for newer guests.  If we can't get
> the code upstream into edk2, maybe we can at least document steps for
> others to create images.  Thanks,
>

So, I am bit lot here, forgive my ignorance.

I am seeing issues (a black screen and nothing else to report) with :

   00:02.0 VGA compatible controller: Intel Corporation AlderLake-S GT1 (rev 0c)

using uefi, seabios, pc or q35 does not change the result.


However, it works fine with a uefi q35 machine using :

   00:02.0 VGA compatible controller: Intel Corporation Alder Lake-N [UHD Graphics]

How can I dig into the first issue ?


Also, if we know that there are platform requirements for IGD assignment to work, we
should try to verify that they are met when the machine boots.


Thanks,

C.



