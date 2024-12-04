Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80E7E7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 15:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIqzE-00010T-65; Wed, 04 Dec 2024 10:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIqzB-0000zz-F4
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 10:08:17 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIqz5-0005Ud-P8
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 10:08:15 -0500
Received: by mail-pg1-x544.google.com with SMTP id
 41be03b00d2f7-7fc1f1748a3so4662068a12.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 07:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733324889; x=1733929689; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2ob5k8JxD5+QU5SSnSYMorDymOR1MAoVcbbbwPmkW6Q=;
 b=bJUBM3SLslImznPFTxqSA5vxHRwlYOIuEOjf0NEj2eqCRClBu2IbRVdzegAXtxR+/5
 vvy1SEsNBBinZ7+m7OYRYPQpHmCcLCehSFH6s7ALCeHY20f2EoXdKqGQwG8YawUVufc9
 4pEA/pBvVYqpJ8HFckU4G6Tom4xE/+wU4AKOp+z0gAFSUtMzmz/ecAVrH0qMV9Hhl7mt
 GsZqC55QRabrWq0KA86syABz7TirVfucFxi2oOyQ0XATamKAXGrsU0qAVquBrU3cM2qN
 MDJEJLGYYdvEp82CPLJZP+BKBebIx37mADXfYazMnoN8BEQ4xn4osHgZQlsf0XUwTEDg
 qFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733324889; x=1733929689;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2ob5k8JxD5+QU5SSnSYMorDymOR1MAoVcbbbwPmkW6Q=;
 b=CwthT8rTmVTZxt+aqDU08jAD8N8yIYTdBkA6Spxqop15LNPks31flo0GI1q6ds03vq
 gTizO8PRmEmly7+92L33QWt4vK/6XTo5KMp43M/jlLsUTsRvqVaKpb38c36oQsgHdki4
 jSPHMR6BoXFWMF+k9rn2a89NJzxGCuR4E+IhY0LRdBLhiRuciVtpZWV/Q2lm8iRvvdSF
 KJTmGgAbcBCeLNUTumFht9adZAZdhSy6Pmu3p2dzDB/Oka3gG+CXLAU2tzNR+N99LYXT
 YjbIxtHhMxBIroMEaxzKh5yuxngEd0nsxSLO2lKASFM8Mx/XRtWdplHjMwVt5tf+eF6g
 suwg==
X-Gm-Message-State: AOJu0YxmImvZSWZGp42lEIv7nBRsru0HJkIVrSiEYa8PatzRvWg0siIa
 joTH8c3ehmo/EHhOZQfRQRMPzZ0rdZJe7zCE72cncZ9i2iQAaPU=
X-Gm-Gg: ASbGncthra3AMsv9oeOujzbSJZveyw9GTKq9BL+czppbo6UBeh97TQBKVwEejk6/UvZ
 7XL4UprsqaB+q6MFUE/IF7xItG4vj+dEfZCjY6pmhADUdQj6qJF1CoO6UDwYERMr8CzKa9dH7d5
 Ya4eFpfSboEOAYi2a+2DEZWDu055SaoPYA0FsxacxkV+kgAE4GYkaMukrlvg06PP6Xip9f3Ie2o
 O6bVPCgO08YRPYl1qmCHpSDJOLtRjBbvzCRG5TrGDSS1aaN/bIjIKg=
X-Google-Smtp-Source: AGHT+IG+9pbdr3XFHuWcUnIrsuc+RWLFmB0LavcSBow3H2iw0b391Jp5IrrbvQXBCCDwVuGJb5CbXg==
X-Received: by 2002:a05:6a20:729b:b0:1e0:d231:de71 with SMTP id
 adf61e73a8af0-1e1653f3da3mr8898483637.35.1733324888946; 
 Wed, 04 Dec 2024 07:08:08 -0800 (PST)
Received: from [192.168.0.163] ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fc9c2d5af1sm11554142a12.16.2024.12.04.07.08.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 07:08:08 -0800 (PST)
Message-ID: <84168744-f82b-494f-93a6-ca334e6cc98c@gmail.com>
Date: Wed, 4 Dec 2024 23:08:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] vfio/igd: Enable legacy mode on more devices
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
 <20241203131205.1391d69a.alex.williamson@redhat.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20241203131205.1391d69a.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pg1-x544.google.com
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

On 12/4/24 04:12, Alex Williamson wrote:
> On Tue,  3 Dec 2024 21:35:39 +0800
> Tomita Moeko <tomitamoeko@gmail.com> wrote:
> 
>> This patchset extends the support of legacy mode igd passthrough to
>> all Intel Gen 11 and 12 devices (including Ice Lake, Jasper Lake,
>> Rocket Lake, Alder Lake and Raptor Lake), and emulates GGC register
>> in MMIO BAR0 for better compatibiltiy (It is tested Windows and GOP
>> driver will read this MMIO register).
>>
>> It also replaces magic numbers with macros to improve readability,
>> and aligns behavior (BDSM registor mirroring and GGMS calculation for
>> gen7) with i915 driver to avoid possible issues.
>>
>> The x-igd-gms option removed in 971ca22f041b ("vfio/igd: don't set
>> stolen memory size to zero") is also added back so that data stolen
>> memory size can be specified for guest. It is tested that GMS may
>> related to framebuffer size, a small GMS value may cause display issues
>> like blackscreen. It can be changed by DVMT Pre-allocated option in
>> host BIOS, but not all BIOS comes with this option. Having it in QEMU
>> helps resolves such issues.
>>
>> This patchset was verified on Intel i9-12900K CPU(UHD 770, 8086:4680)
>> with custom OVMF firmware [1] and IntelGopDriver extracted from host
>> bios. IGD device works well in both Windows and Linux guests, and
>> scored 726 in 3DMark Time Spy Graphics on Windows guest.
>>
>> [1] https://github.com/tomitamoeko/edk2/commits/igd-pt-adl/
>>
>> Btw, IO BAR4 seems never be used by guest, and it the IO BAR itself
>> is not working on Gen11+ devices in my experiments. There is no hints
>> about that in old commit message and mailing list. It would be greatly
>> appreciated if someone shares the background.
> 
> The quirks related to BAR4 access are generally for the vBIOS, we
> wouldn't expect guest OS level drivers to use them.  IIRC this is
> handling moving the stolen memory from the HPA to the GPA when the
> vBIOS is writing the GTT.

Got it. I'm wondering why vBIOS still writes HPA instead of GPA when
it's in virtual machine, maybe the address is hardcoded?

> Maybe that brings up an interesting topic.  Traditionally "legacy mode"
> IGD assignment has been only for 440fx machines with SeaBIOS and last I
> was aware edk2 wasn't willing to accept the same hack for the BDSM as
> we had put into SeaBIOS, instead indicating that it should be
> implemented in the device ROM.  Your branch in [1] above seems to
> indicate edk2 does now have assigned IGD specific code.
>
> Are these patches developing full stack support of these new devices,
> from BIOS hand-off, through pre-boot environments, and through to guest
> OS drivers, or are we only concerned that the guest OS level driver
> lights up a display?

Yes these patches provide a complete legacy mode passthrough solution,
from EFI DXE phase to guest OS, but the EFI part requires specific
changes in edk2.

> If you're using q35 and OVMF then you must be operating in the realm of
> the mythical "Universal Pass-through" mode that I thought Intel had
> abandoned.  It seems like we need an update to docs/igd-assign.txt as
> it's likely very out of date based on recent improvements here and by
> Corvin.

Actually the only machine supports legacy mode is i440fx, windows driver
checks the vendor and device id of LPC bridge device at 00:1f.0, if it
doesn't match, display driver won't work [1]. On q35 machine, there is
already a emulated ICH9 LPC at 00.1f.0. Previous there was a try in
modifying the id, but it breaks functionality [2].

[1] https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/hw/pci/lpc.c#L519
[2] https://lore.kernel.org/all/1457080913-30018-1-git-send-email-kraxel@redhat.com/

I had a try "Univerisal Pass-through" mode as igd-assign.txt with my
UHD 770. On linux guest, it works just as a normal gpu, except there
is no display output before i915 driver loaded. Even the device's vbdf
is not 00:02.0, and i915 log shows the DSM is 0M, it works perfectly.
intel_gpu_top shows igpu is working when I am playing a youtube video.

I also tried setting primary gpu in bios to discrete gpu, which makes
the pci class code of igpu changed from 0x030000 (VGA compatible 
controller) to 0x308000 (Display controller), it can still output to
monitor connected to it on Linux guest. All with a simple
    -device vfio-pci,host=00:02.0,id=hostdev0

But for windows guest, I never had any luck. I attached a virtio-gpu to
it, with intel grahics drivers installed in guest. If igd is not at
00:02.0 or gop driver is not provided, windows BSOD immediately on boot

> Also, are you proposing the noted edk2 change upstream?  It seems like
> edk2 would need some sort of device version detection to know whether
> to use a 32 or 64-bit BDSM value.  Thanks,
> 
> Alex

I'm afraid the answer is no, these edk2 changes are not fully open
source as they were taken from inten directly [3], except the last
patch. (It seems intel uses a modified qemu as "etc/igd-dsm-base"
used in patch 5 doesn't exist in qemu, probably they are creating
a identical GPA->HPA mapping for igd?).

One of these intel edk2 patches is also included in a edk2 bug [4] and
markd as hack.

Besides these edk changes, GOP driver is also needed. Intel never
released them to public. Even acrn hypervisor developed by intel says
"Fetch the VBT and GOP drivers from the board manufacturer". The only
way for users to get it seems to be using tools like "UEFI BIOS
Updater" to extract driver from host bios image, or try the luck by
downloading the gop driver shared on internet.

After having the GOP driver, a virtual rom for igd device in qemu
can be created by
    EfiRom -f 0x8086 -i <device_id> -e IgdAssignmentDxe.efi \
    PlatformGOPPolicy.efi IntelGopDriver.efi
IgdAssignementDxe.efi and PlatformGOPPolicy.efi are built with the
edk2 changes.

I'm not sure whether this can be added to official document.

[3] https://eci.intel.com/docs/3.0/components/kvm-hypervisor.html#build-ovmf-fd-for-kvm
[4] https://bugzilla.tianocore.org/show_bug.cgi?id=935

>> Changelog:
>> v2:
>> * Droped "vfio/igd: fix GTT stolen memory size calculation for gen 7".
>> * Fixed conditions when calculating GGMS size.
>> * Added Gemini Lake and Comet Lake device ids.
>> * Splited mirroring register declaration macro into a new patch.
>> * Minor fixes.
>> Link: https://lore.kernel.org/qemu-devel/20241201160938.44355-1-tomitamoeko@gmail.com/
>>
>> Tomita Moeko (9):
>>   vfio/igd: remove unsupported device ids
>>   vfio/igd: align generation with i915 kernel driver
>>   vfio/igd: canonicalize memory size calculations
>>   vfio/igd: add Gemini Lake and Comet Lake device ids
>>   vfio/igd: add Alder/Raptor/Rocket/Ice/Jasper Lake device ids
>>   vfio/igd: add macro for declaring mirrored registers
>>   vfio/igd: emulate GGC register in mmio bar0
>>   vfio/igd: emulate BDSM in mmio bar0 for gen 6-10 devices
>>   vfio/igd: add x-igd-gms option back to set DSM region size for guest
>>
>>  hw/vfio/igd.c | 248 ++++++++++++++++++++++++++++++--------------------
>>  1 file changed, 151 insertions(+), 97 deletions(-)
>>
> 

