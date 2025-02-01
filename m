Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938FEC0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 07:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1te8FO-0008Fm-5v; Sat, 01 Feb 2025 02:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1te8FM-0008FL-Nu
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 02:48:56 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1te8FK-00040I-0L
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 02:48:56 -0500
Received: by mail-pj1-x1043.google.com with SMTP id
 98e67ed59e1d1-2ee74291415so3646779a91.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 23:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738396126; x=1739000926; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HrGOcRsfdMIoRUgK3F9sL9tVsXzzmKKXZO4eM6qifpQ=;
 b=GXPE0JdgZX6NG8O3zW78YeP2NXKkTCyBcHmfzOvCu9laZSOaFNfxXV8KFyHo01LLKn
 YsCPYTRiYB9pI5Ok0ydWPA19VvyXOLi5xpoIUrk8VmfZZDuacx4+23Cn+40eHgMtu6Ku
 rC0fnIFoSJRhRVHiT1GjuD1ctMyqpfVso30jxSA5TVN1hApvvm7yx2DAL0NNSyD4dOxh
 5qHUQgoakhJZ0n43vY4Svf1B6oJ90Aq22n6KEx60tOgeH0ddCStwjj8eXQY0p103Dp42
 u4frPFnpYaveYwNkTrS7KeqbylvQ5qIc36ThSD8+5lnvsisaVo0nJ84Urf4K0iwSGqYb
 tybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738396126; x=1739000926;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HrGOcRsfdMIoRUgK3F9sL9tVsXzzmKKXZO4eM6qifpQ=;
 b=OGFi49+QgsLS5K7fhcBC8czmG4QFamDH2GizHOEhqNOP1Vn9I/CpkWPkrQa++/I+0v
 LEzBrtira12YkGd/X+af+L0jMIaFR3iJ6dkbb1aV9XkKrvNrS8O9zouG9LLJoYu5hSnW
 g0MlV0xk5qigaD2kv110UtoVZfhEC1n/ijqeMaNHd3oTfnrIh4mbKwY2sYe6SLgbyDPQ
 GphkQuqs42V+YQF0sIDTvJ3pvYYLWBQtjqBAMN/o2QOzgzC1o/yOBRAxKKgU9wShzUOR
 +KI9ahy78MtfXyhkb1dZ2UhD+P6IGgyW7WBWX3bViDyrqPZqS6m/lty7LN9M5Oc6q6G/
 p16Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaNZvDTQ2gRoVi+mjnJzoUucE83KWqKq0p6+1mRgkhh3ThMm01R/YZ7B1GUqkhknWkgW2GjgO+f3m9@nongnu.org
X-Gm-Message-State: AOJu0YxWwznaYQY/GHWTP4YpBSFTFNIt9qjgq8NiHeP+wq1ehrSQkIWq
 fHXjKQ0Pe9IXR9ftGMBoJOkR/loKjvzkJv1xfNXnnrQNpzEZROM=
X-Gm-Gg: ASbGncvVj66O3vGyFtLeiOrVFyPh2sLlLqD4nllO7UrGTYwg+3Pch24Wa9M5hUXv3XC
 3wlmr8BVbpjHqxc6+WYDkKows7thBcbTxjjMWcn3UqKtXkfz4vG7mIUiDjrzlgJhymrc4mHEQ6+
 ncGHuWq+7W6xyuBdq8S5vuVTOcJ5itfpy/sOL4oz0yjC57ZSJdkjGI+TkaPuedbIQaKLZDrjOIG
 2bKPyZgqlo3ST9Y7AsKH4HR78QmdhufsklTaAZJyodxNzy4EB+6yb5sotmbf/e/KOMCeVpZxFJw
 eui3dLFl9Ue4vi8ybEXa4Q==
X-Google-Smtp-Source: AGHT+IGec2Mx+kmikXGaIoDBzqyIwatRKxKyXixp1VGDlh4eWO6QsHiiXEIJ3TYc9zU/onhf1vW5Pg==
X-Received: by 2002:a17:90b:2f0e:b0:2ee:f687:6ad5 with SMTP id
 98e67ed59e1d1-2f83abab725mr22493244a91.2.1738396125988; 
 Fri, 31 Jan 2025 23:48:45 -0800 (PST)
Received: from [192.168.0.163] ([116.232.67.252])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de32ea495sm40704945ad.126.2025.01.31.23.48.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 23:48:45 -0800 (PST)
Message-ID: <d4564d60-1bba-4ee5-9059-77b9e943c143@gmail.com>
Date: Sat, 1 Feb 2025 15:48:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] vfio/igd: handle x-igd-opregion in
 vfio_probe_igd_config_quirk()
To: Alex Williamson <alex.williamson@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250124191245.12464-1-tomitamoeko@gmail.com>
 <20250124191245.12464-6-tomitamoeko@gmail.com>
 <20250124141342.255a79d3.alex.williamson@redhat.com>
 <7cd85e39-88e6-497d-b0b0-41a0a0ece0fb@gmail.com>
 <377fd72e-6bff-45f4-a9db-413f3565fd75@gmail.com>
 <20250130134113.5d60442f.alex.williamson@redhat.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20250130134113.5d60442f.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj1-x1043.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 1/31/25 04:41, Alex Williamson wrote:
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
>>>>>  hw/vfio/igd.c        | 143 +++++++++++++++++++++++++++++++++----------
>>>>>  hw/vfio/pci-quirks.c |  50 ---------------
>>>>>  hw/vfio/pci.c        |  25 --------
>>>>>  hw/vfio/pci.h        |   4 --
>>>>>  4 files changed, 110 insertions(+), 112 deletions(-)
>>>>>
>>>>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>>>>> index 6e06dd774a..015beacf5f 100644
>>>>> --- a/hw/vfio/igd.c
>>>>> +++ b/hw/vfio/igd.c
>>>>> @@ -106,6 +106,7 @@ static int igd_gen(VFIOPCIDevice *vdev)
>>>>>      return -1;
>>>>>  }
>>>>>  
>>>>> +#define IGD_ASLS 0xfc /* ASL Storage Register */
>>>>>  #define IGD_GMCH 0x50 /* Graphics Control Register */
>>>>>  #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
>>>>>  #define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11 and later */
>>>>> @@ -138,6 +139,55 @@ static uint64_t igd_stolen_memory_size(int gen, uint32_t gmch)
>>>>>      return 0;
>>>>>  }
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
>>>>>  /*
>>>>>   * The rather short list of registers that we copy from the host devices.
>>>>>   * The LPC/ISA bridge values are definitely needed to support the vBIOS, the
>>>>> @@ -339,29 +389,83 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>>>>      QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
>>>>>  }
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
>>>>>  bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>>>>> -                                 Error **errp G_GNUC_UNUSED)
>>>>> +                                 Error **errp)
>>>>>  {
>>>>>      g_autofree struct vfio_region_info *rom = NULL;
>>>>> -    g_autofree struct vfio_region_info *opregion = NULL;
>>>>>      g_autofree struct vfio_region_info *host = NULL;
>>>>>      g_autofree struct vfio_region_info *lpc = NULL;
>>>>> +    PCIBus *bus;
>>>>>      PCIDevice *lpc_bridge;
>>>>>      int ret, gen;
>>>>> +    bool legacy_mode, enable_opregion;
>>>>>      uint64_t gms_size;
>>>>>      uint64_t *bdsm_size;
>>>>>      uint32_t gmch;
>>>>>      Error *err = NULL;
>>>>>  
>>>>> +    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>>>>> +        !vfio_is_vga(vdev)) {
>>>>> +        return true;
>>>>> +    }
>>>>> +
>>>>>      /*
>>>>>       * This must be an Intel VGA device at address 00:02.0 for us to even
>>>>>       * consider enabling legacy mode.  The vBIOS has dependencies on the
>>>>>       * PCI bus address.
>>>>>       */
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
>>>>>          return true;
>>>>>      }
>>>>>  
>>>>> @@ -404,30 +508,10 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>>>>>          return true;
>>>>>      }
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
>>>>>      /*
>>>>>       * Check whether we have all the vfio device specific regions to
>>>>>       * support legacy mode (added in Linux v4.6).  If not, bail.
>>>>>       */
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
>>>   registers holds HPA, keeping the old value to guest is not a good
>>>   idea
>>> * Make the host bridge and LPC bridge ID quirks optional like OpRegion.
>>>   Recent Linux kernel and Windows driver seems not relying on it. This
>>>   enables IGD passthrough on Q35 machines, but probably without UEFI
>>>   GOP or VBIOS support, as it is observed they require specific LPC
>>>   bridge DID to work.
>>> * Remove the requirement of IGD device class being VGA controller, this
>>>   was previous discussed in my kernel change [1]
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

I was setting up a windows guest on the linux box in my university lab
since some software used in the university only supports Windows :(.
As the linux box only runs background services like nfs share, and I
only ssh to it for coding. I'd like to passthrough the GPU to guset so
it can have baremetal-like GUI experience. During setup, I found there
were limitations and conflicting tutorials, which makes me curious
about how it actually works.

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

Currently legacy mode requires creating a dummy LPC bridge at 00:1f.0,
but on q35, there is already an ICH9 LPC there. In my trials, LPC is
not a must for linux guests and windows guests with recent driver.
Only UEFI GOP requires it. Making it as another x-igd- option will
give more flexibility I believe.

"Legacy" mode implicitly means enabling the options below I think
* x-igd-opregion=on
* dummy lpc bridge, as well as host bridge ids
* x-vga=on, not a must, but code tries to enable VGA access

Remoing legacy mode while keeping the current behavior is challenging,
as legacy mode is implicitly enabled by addr=0x2 and doesn't fail if
any condition is not met. It seems we cannot replace legacy mode in
a completely clean mannar, my proposal for the default values are:

| config          | x-igd-opregion | lpc quirk |
|-----------------|----------------|-----------|
| i440fx,addr=0x2 | yes            | yes       |
| i440fx,others   | no             | no        |
| q35             | no             | no        |

However, it doesn't handle the cases legacy mode fails halfway :(,
any suggestions would be greatly appreciated.

> I'm glad you included the documentation update in your list, it's
> clearly out of date, as is some of my knowledge regarding guest driver
> requirements.  I hope we can make some progress on uefi support as well,
> as that's essentially a requirement for newer guests.  If we can't get
> the code upstream into edk2, maybe we can at least document steps for
> others to create images.  Thanks,

Sure. I will include it in the documentation update.

> Alex
> 


