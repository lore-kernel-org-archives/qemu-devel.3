Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27386C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 17:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u56lY-00008b-Gh; Wed, 16 Apr 2025 13:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u56lQ-000079-An
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 13:41:33 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u56lO-0003Uk-41
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 13:41:32 -0400
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-227d6b530d8so71954005ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 10:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744825288; x=1745430088; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eAXy9IE0GpGf5uDjBYXxWYs/xjV7v/ays0557misaFY=;
 b=DlKL6cs3slApC1KnKlxzVekaquMNuw1C431QkUzMgWWaS9x+Pv89t2KPg2sSslKtW2
 oGrb2xs/ZqQrA6N5CgqaB8DEg2qODyh/Yb4GSIc49Bl4mo2xI7SC7d1CHgav7Zj5iIaG
 DqgEbGy2wB8/VKthWAGEw5del6giO62BlnSfQDOB2FjM8SrktCkx1+jbExl3NCzOH5yi
 PHm0rLLiqGbmjbtcRy1vVs6petzc2w9byrtMdGj8bDKegNkU/I5D3wJZUtvSeQw0c8Y1
 v+3YxmyJDebMVL2/USukxmUJ2dGV/ne10zr83/wd1TW9kkRK4nIY60EedyZezV4/nMLe
 BEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744825288; x=1745430088;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eAXy9IE0GpGf5uDjBYXxWYs/xjV7v/ays0557misaFY=;
 b=cKynkiPfbCBCC9ez7gE0tPPsKQeGSvVlCE2Wm5o+rbxcQymoM+1/zpNK7GWIVmGZSt
 3HZZigdM+rQvyfQ9Kenlr9SrG/oZzJw3zwAL+/A3XMAvuz6BKe/5iZe8bkM7h04I99GX
 zbS3a5uORVDUtdBNN83GkLA+av4hTmlo6Qix7qzdJfHdSNCpdY4QNooftW1WWh18TimW
 N0IU63UW8HQKnpV+SLhjqg0rH8mLVIL13VoxgrYe5ZlnLdmObVTl1Puyv2eXuqyyK11d
 9uwewXadkGpaj35t+6ZEyq0jIwNlUXD9nMrU1UbwSuk8C+SVHaZRsgZfSe/sAEyNbnLp
 AEPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+jqSXO91kCAsiaz8neAXVUYT9rXh9YdqIXBnwgVQcQBihSiKaghZhZHb6O3p+vEa9nmhvkr8+U9d/@nongnu.org
X-Gm-Message-State: AOJu0Yy6K9YdVaDqZi1CBSbpxT0yKI7EA7Duuw20vvoQs8tq+JWp6Ncj
 HDU9w+O9fGs/akLnjHzHlTylu1J2RcUbOkpEmYKqweluGYyyMp8=
X-Gm-Gg: ASbGncsyvczKCdDOwIbQYAyKnmweSwBmUWP8S+UpPP2psyj7+9L76aiszH2N3DT/PLH
 pHlVCa5v0IEdMVfbwGyWIzE+TuR5dazbGrpjV1w0TnEJLVTT/BPOmuSJn4UeZFVoNnYkLFZylHZ
 0kpI2EX/xVZ4d3jnN2iYWi0/sI0302Rgw4LvHb/XXxP1iZbXYe0lZonM/c2o2P9R/CN0XVkW1Dh
 6gQHJ8BHw2rcFksGgTOMT//Bgwb7h11aqjQthbHB+k2am4d2EyjUdpXTeoipbxuE/Zqct1RKVuz
 uz02S4D8ufniLwrW+e0rTzualsvrEooJG5ir++LCL33b2w==
X-Google-Smtp-Source: AGHT+IFR9VaPD4/nGGDvkpAW+wSagGSTlE9Rnskc05wlI3IqdfiyNXLIVuE8pUTB8zB3/x+MzNI2LA==
X-Received: by 2002:a17:902:e84b:b0:224:24d3:60f4 with SMTP id
 d9443c01a7336-22c358d8889mr43679335ad.15.1744825287417; 
 Wed, 16 Apr 2025 10:41:27 -0700 (PDT)
Received: from [192.168.0.113] ([139.227.17.39])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33f1ce0dsm17155025ad.71.2025.04.16.10.41.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 10:41:26 -0700 (PDT)
Message-ID: <0ec0fa57-1e99-4e21-b0c5-991806f4bd6d@gmail.com>
Date: Thu, 17 Apr 2025 01:41:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/igd: Check host PCI address when probing
To: Alex Williamson <alex.williamson@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>
References: <20250325172239.27926-1-tomitamoeko@gmail.com>
 <20250409111801.4c97022f.alex.williamson@redhat.com>
 <046a2961-23b1-4ef2-8673-9b9deedbbbdf@redhat.com>
 <3e9743ab-bf81-4d92-8ea0-e01ac58a234b@gmail.com>
 <20250414160530.5d86aaf2.alex.williamson@redhat.com>
 <e529bf00-bd58-4151-9bce-dad74c88fa6d@gmail.com>
 <20250415130425.601e1902.alex.williamson@redhat.com>
 <f27926c8-3bae-45b9-bbc1-ea9d78bcbd10@gmail.com>
 <20250416101038.3f84f2b8.alex.williamson@redhat.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20250416101038.3f84f2b8.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x641.google.com
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



On 4/17/25 00:10, Alex Williamson wrote:
> On Wed, 16 Apr 2025 23:45:08 +0800
> Tomita Moeko <tomitamoeko@gmail.com> wrote:
> 
>> On 4/16/25 03:04, Alex Williamson wrote:
>>> On Wed, 16 Apr 2025 01:36:15 +0800
>>> Tomita Moeko <tomitamoeko@gmail.com> wrote:  
>>>>
>>>> The generation register also exists on discrete GPUs. In the new xe
>>>> driver [1], the Battlemage discrete GPU shares the same logic reading
>>>> GMD_ID_DISPLAY register. The driver itself uses is_dgfx bit mapped to
>>>> device id. In QEMU, we need to know whether the device is a supported
>>>> IGD device first before applying the IGD-specific quirk, especially
>>>> for legacy mode.
>>>>
>>>> The most feasible way is to check if kernel exposes VFIO_REGION_SUBTYPE_
>>>> INTEL_IGD_OPREGION on that device I think, as only IGD has OpRegion.
>>>>
>>>> i915 driver [2] and Arrow Lake datasheet [3] shows that Intel has
>>>> removed the BDSM register by making the DSM range part of BAR2 since
>>>> Meteor Lake and onwards. QEMU only need to quirk on the register for
>>>> IGD devices until Raptor Lake, meaning that the device list is fixed
>>>> for now.
>>>>
>>>> By the way, for legacy mode, I think we should only support it until
>>>> Gen 9, as Intel only provide VBIOS or CSM support until that generation,
>>>> and seabios cannot handle 64 bit BDSM register. I'm also wondering if
>>>> VGA really works on newer generations.  
>>>
>>> If it's a VGA class device, it really should, but without CSM I could
>>> see why you have doubts.  
>>
>> Without CSM/VBIOS there is no pre-boot video, but when it booted to OS,
>> driver is used for video rather than VGA. Though it claims itself as
>> VGA class, it does not have VGA compatiblity. A770 even does not have
>> IO BAR, definitely it cannot handle VGA decoding.
> 
> VGA ranges are implicit in a VGA class device, they're not backed by
> BARs.  Lack of CSM support makes it more difficult to prove whether VGA
> support is present since we can't easily initialize the device for a
> legacy OS, but I don't think lack of CSM necessary proves the hardware
> doesn't support VGA.  If we really cared, we could probably do some low
> level experiments writing into the VGA frame buffer range to test if
> it's present and behaves as expected relative to memory and IO enable
> bits.

Sorry for my misunderstanding. The bridge control register in PCI bridge
config space determines forwarding VGA IO/MMIO accesses to which device,
BAR is not related in this process.

As device initialization (by legacy VBIOS) is required for booting
legacy OS with seabios, limiting legacy mode to gen9 and older sounds
resonable.

Trying VGA framebuffer would be difficult we have to disable EFI GOP and
manually instruct the device to enter VGA mode without VBIOS routines.
It's not a major problem here, let's skip it for now?

Thanks,
Moeko

>>
>> Similar behavior is also found on AMD GPUs. They still claim as VGA
>> controller, but without CSM support.
>> https://www.amd.com/en/resources/support-articles/faqs/GPU-N4XCSM.html
>>
>>>> Maybe we can continue with current igd_gen, but implement a logic like:
>>>>     if (!intel graphics)
>>>>         return;
>>>>     if (!has VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION)
>>>>         return;
>>>>     setup_opregion();  // make x-igd-opregion automatically enabled?
>>>>     if (gen <= 9)
>>>>         setup_legacy_mode();
>>>>     if (gen >= 6 && gen <=9)
>>>>         setup_32bit_bdsm():
>>>>     else if (gen >= 9 && gen <= 12)
>>>>         setup_64bit_bdsm();
>>>>     // ...
>>>>     // optional quirks like lpc bridge id
>>>>
>>>> A table can also be used to precisely track all the gen 6-12 devices.  
>>>
>>> This seems reasonable to me.
>>>   
>>>> Attached a config space dump of Intel A770 discrete GPU for reference
>>>>
>>>> 03:00.0 VGA compatible controller: Intel Corporation DG2 [Arc A770] (rev 08) (prog-if 00 [VGA controller])
>>>> 	Subsystem: Intel Corporation Device 1020
>>>> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>>>> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>> 	Latency: 0, Cache Line Size: 64 bytes
>>>> 	Interrupt: pin ? routed to IRQ 181
>>>> 	IOMMU group: 19
>>>> 	Region 0: Memory at 81000000 (64-bit, non-prefetchable) [size=16M]
>>>> 	Region 2: Memory at 6000000000 (64-bit, prefetchable) [size=16G]
>>>> 	Expansion ROM at 82000000 [disabled] [size=2M]
>>>> 	Capabilities: [40] Vendor Specific Information: Len=0c <?>
>>>> 	Capabilities: [70] Express (v2) Endpoint, IntMsgNum 0
>>>> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
>>>> 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0W TEE-IO-
>>>> 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
>>>> 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
>>>> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
>>>> 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
>>>> 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us  
>>>
>>> Hmm, hardware bug?  Surely the A770 is not a Gen1, x1 device.
>>> Something is going on with the interrupt pin above too.  At least it
>>> claims FLReset+ above, does it work reliably though?  Seems like there
>>> are various reports of Arc GPUs not working well with assignment due to
>>> reset issues.  Thanks,
>>>
>>> Alex  
>>
>> Just did a quick search, link speed reporting is a known issue on Arc
>> A-series GPU.
>> https://www.intel.com/content/www/us/en/support/articles/000094587/graphics.html
>>
>> The root port reports correct `LnkSta:	Speed 16GT/s, Width x16`
> 
> Interesting, suppose I just hadn't noticed before.
>  
>> I also tried the passthough it to VM and not meeting any reset issue.
>> Probably it was fixed, intel often publishes VBIOS updates (they call
>> it IFWI) with windows driver releases. 
> 
> Ok, I have an A380 that doesn't behave well with resets, I suppose
> I should boot it on a bare metal Windows system to try to get any
> available firmware updates.  Thanks,
> 
> Alex
> 

