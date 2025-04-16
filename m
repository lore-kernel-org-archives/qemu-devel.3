Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F204C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 15:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u54wy-0005vf-1P; Wed, 16 Apr 2025 11:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u54ww-0005vU-26
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 11:45:18 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u54wt-000542-DQ
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 11:45:17 -0400
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-736c1cf75e4so5104826b3a.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 08:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744818314; x=1745423114; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gf5r43mlmPCIRUE8uPdFi2Akx+24t1xwaMbCweuq5HY=;
 b=j7B399lvLxUJwTwe4OWcVxcI895wV+OHmopMuPXHcSwMmFZBDOA0GiY88o8sOBmoVr
 hEcGKzgP1tWRDhQwLePMirltfUfGTt6vinLWCmvnjm/HcT68a+jkw2cXN19MGDxTO9iQ
 xop4Ge1ttJSiUiRDnDroKhyjlpKibqQDRkReeMQ3kjbdVCXBHQUyQrawOwI6XoZ61aeU
 XM2oTHMZqVui++o2ZuzKvdTm2cMy59FDFwSxjK+wlUVpe2r2Kib2EelyqvV2xHaUYlpb
 UgLVTrYl/cKrNRxXVi2gEXJWss3xBS5MCBoEs9QUbIxACG/BktNdR/AyFxROLIHaVLnh
 N7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744818314; x=1745423114;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gf5r43mlmPCIRUE8uPdFi2Akx+24t1xwaMbCweuq5HY=;
 b=rFN0eYH/0/IYaW7b3gHa5mi3u8HXSneT86mAs6sY6gynm4j+rHSEoeNmgkZ69emNyQ
 Qv/W5j+unoTox5xy2zVEAF12Gg5ubiOraqD4fc67KGaYJFe6O1y6DvG/ydCJ0gK5J207
 EMbwjHpvKOcyXy0eOqs1za5Qt61UAmE77/BcsAD/nozz4jcT5Qb42eZsA8B4wRFRtOme
 kE+EAz3Nh0fEZwEF47uzSOwyY0W9jCzQ+pvu+NbGSAh5998aUSyYL40MZvCh76sRKPvh
 Tin2e/zHjhOzamI3iTLdEN4Anqqls21IMYP73PmaN7rooCpaQGO9WZpofHxTJWGbxf8e
 6wGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqtXEuujWvgfNdKP1kCj2Q4PNrMC1zbplsWMnPp0JVjhTRqAJAKejik4QpcoGd3SVwFlfAKvjOyOIB@nongnu.org
X-Gm-Message-State: AOJu0Yy4eXZph6y+YyjR+xuFoUdm1YgxYj9oyai7B07fude1zM2x7HLT
 Qo3bvGnL0UyqeNzFWfpTqLQ64LzAj0EPBikouTEuaYrrDmhnxHQ=
X-Gm-Gg: ASbGncsDONpNYCPuLJxNNqFdJg+FJ240uMsEXHUqFm/HoCXYMZR6RC9/j4cfiRQUbph
 mntNDWpSX3BdpJ1yTPEZsVgnRgrqju5fphB/un0KiZ98DLyLEMkPpm9rH6QVgje1SCMz1caDWcn
 6xmYc7VmjUJCZY37AfMk7enCmlizlIiUKvY4Qe/A8geBHqK4VTv1m4GO0LiW8kjeiEiyeElAl82
 SeAukyhxM0ZNE+kUjpwRt0WAVQrnDgrwJLSWwGXmeQK8bwfyrujCJARyVbZnvRvb1ltbqxsPGf5
 z0EGPJPZywTs352TyOTye0ZtHEUlyaerXOZprOyxmYwnc2o=
X-Google-Smtp-Source: AGHT+IHFU2RqeUDNXRlNZHyIvIVbuFuXyHTJLD06BXRmP70FIFurFxTQZD2PD5xAomaKWQh5sRTxkQ==
X-Received: by 2002:a05:6a00:1da6:b0:739:3f55:b23f with SMTP id
 d2e1a72fcca58-73c2671803fmr3355480b3a.14.1744818313657; 
 Wed, 16 Apr 2025 08:45:13 -0700 (PDT)
Received: from [192.168.0.113] ([139.227.89.108])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f8345sm10866510b3a.105.2025.04.16.08.45.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 08:45:13 -0700 (PDT)
Message-ID: <f27926c8-3bae-45b9-bbc1-ea9d78bcbd10@gmail.com>
Date: Wed, 16 Apr 2025 23:45:08 +0800
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
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20250415130425.601e1902.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x442.google.com
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

On 4/16/25 03:04, Alex Williamson wrote:
> On Wed, 16 Apr 2025 01:36:15 +0800
> Tomita Moeko <tomitamoeko@gmail.com> wrote:
>>
>> The generation register also exists on discrete GPUs. In the new xe
>> driver [1], the Battlemage discrete GPU shares the same logic reading
>> GMD_ID_DISPLAY register. The driver itself uses is_dgfx bit mapped to
>> device id. In QEMU, we need to know whether the device is a supported
>> IGD device first before applying the IGD-specific quirk, especially
>> for legacy mode.
>>
>> The most feasible way is to check if kernel exposes VFIO_REGION_SUBTYPE_
>> INTEL_IGD_OPREGION on that device I think, as only IGD has OpRegion.
>>
>> i915 driver [2] and Arrow Lake datasheet [3] shows that Intel has
>> removed the BDSM register by making the DSM range part of BAR2 since
>> Meteor Lake and onwards. QEMU only need to quirk on the register for
>> IGD devices until Raptor Lake, meaning that the device list is fixed
>> for now.
>>
>> By the way, for legacy mode, I think we should only support it until
>> Gen 9, as Intel only provide VBIOS or CSM support until that generation,
>> and seabios cannot handle 64 bit BDSM register. I'm also wondering if
>> VGA really works on newer generations.
> 
> If it's a VGA class device, it really should, but without CSM I could
> see why you have doubts.

Without CSM/VBIOS there is no pre-boot video, but when it booted to OS,
driver is used for video rather than VGA. Though it claims itself as
VGA class, it does not have VGA compatiblity. A770 even does not have
IO BAR, definitely it cannot handle VGA decoding.

Similar behavior is also found on AMD GPUs. They still claim as VGA
controller, but without CSM support.
https://www.amd.com/en/resources/support-articles/faqs/GPU-N4XCSM.html

>> Maybe we can continue with current igd_gen, but implement a logic like:
>>     if (!intel graphics)
>>         return;
>>     if (!has VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION)
>>         return;
>>     setup_opregion();  // make x-igd-opregion automatically enabled?
>>     if (gen <= 9)
>>         setup_legacy_mode();
>>     if (gen >= 6 && gen <=9)
>>         setup_32bit_bdsm():
>>     else if (gen >= 9 && gen <= 12)
>>         setup_64bit_bdsm();
>>     // ...
>>     // optional quirks like lpc bridge id
>>
>> A table can also be used to precisely track all the gen 6-12 devices.
> 
> This seems reasonable to me.
> 
>> Attached a config space dump of Intel A770 discrete GPU for reference
>>
>> 03:00.0 VGA compatible controller: Intel Corporation DG2 [Arc A770] (rev 08) (prog-if 00 [VGA controller])
>> 	Subsystem: Intel Corporation Device 1020
>> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>> 	Latency: 0, Cache Line Size: 64 bytes
>> 	Interrupt: pin ? routed to IRQ 181
>> 	IOMMU group: 19
>> 	Region 0: Memory at 81000000 (64-bit, non-prefetchable) [size=16M]
>> 	Region 2: Memory at 6000000000 (64-bit, prefetchable) [size=16G]
>> 	Expansion ROM at 82000000 [disabled] [size=2M]
>> 	Capabilities: [40] Vendor Specific Information: Len=0c <?>
>> 	Capabilities: [70] Express (v2) Endpoint, IntMsgNum 0
>> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
>> 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0W TEE-IO-
>> 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
>> 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
>> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
>> 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
>> 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
> 
> Hmm, hardware bug?  Surely the A770 is not a Gen1, x1 device.
> Something is going on with the interrupt pin above too.  At least it
> claims FLReset+ above, does it work reliably though?  Seems like there
> are various reports of Arc GPUs not working well with assignment due to
> reset issues.  Thanks,
> 
> Alex

Just did a quick search, link speed reporting is a known issue on Arc
A-series GPU.
https://www.intel.com/content/www/us/en/support/articles/000094587/graphics.html

The root port reports correct `LnkSta:	Speed 16GT/s, Width x16`

I also tried the passthough it to VM and not meeting any reset issue.
Probably it was fixed, intel often publishes VBIOS updates (they call
it IFWI) with windows driver releases. 

Thanks,
Moeko

> 
>> 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
>> 		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
>> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>> 		LnkSta:	Speed 2.5GT/s, Width x1
>> 			TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
>> 		DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
>> 			 10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt+ EETLPPrefix-
>> 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
>> 			 FRS- TPHComp- ExtTPHComp-
>> 			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
>> 			 AtomicOpsCtl: ReqEn-
>> 			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
>> 			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
>> 		LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink- Retimer- 2Retimers- DRS-
>> 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>> 			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
>> 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
>> 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
>> 			 Retimer- 2Retimers- CrosslinkRes: unsupported
>> 	Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable+ 64bit+
>> 		Address: 00000000fee008b8  Data: 0000
>> 		Masking: 00000000  Pending: 00000000
>> 	Capabilities: [d0] Power Management version 3
>> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
>> 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>> 	Capabilities: [100 v1] Alternative Routing-ID Interpretation (ARI)
>> 		ARICap:	MFVC- ACS-, Next Function: 0
>> 		ARICtl:	MFVC- ACS-, Function Group: 0
>> 	Capabilities: [420 v1] Physical Resizable BAR
>> 		BAR 2: current size: 16GB, supported: 256MB 512MB 1GB 2GB 4GB 8GB 16GB
>> 	Capabilities: [400 v1] Latency Tolerance Reporting
>> 		Max snoop latency: 15728640ns
>> 		Max no snoop latency: 15728640ns
>> 	Kernel driver in use: i915
>> 	Kernel modules: i915, xe
> 

