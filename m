Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305C9C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4laH-0002ZK-Om; Tue, 15 Apr 2025 15:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u4laG-0002Yv-4y
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:04:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u4laD-0004Ua-1y
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744743871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EzXDgfmoEE16AzU6BesaT4Cb+OJzYViF3u0J7+24sZA=;
 b=IpndAK5Djot0GT3ZItMwKUWTy1fBFyivkPKeOmEJnFnt3q560VZcntvZM5erHmYlwQdjT7
 iKjFh/LKsm5Mn1gtYooLBAD/WepQzja4FTJIAOTPdCr9gGVSEvZdDUj1x/MPWp2TrCUpCR
 Zx6pdRmL6ZAccIMDzLhZjuSNDL3EOYM=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-SMsgjs6DNo-B1OFrIdNy0A-1; Tue, 15 Apr 2025 15:04:29 -0400
X-MC-Unique: SMsgjs6DNo-B1OFrIdNy0A-1
X-Mimecast-MFC-AGG-ID: SMsgjs6DNo-B1OFrIdNy0A_1744743869
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-85b5ea50d28so62575839f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744743869; x=1745348669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EzXDgfmoEE16AzU6BesaT4Cb+OJzYViF3u0J7+24sZA=;
 b=HnPIUEzMKjB6jSxiAQJS7lH8L1tjGgY7cNWhDuFaCDvESMx/M6gAf4e4ZPhhmf8rLI
 xIYLFS81FFw57xF/ZtCZAdoDoQV95fU4U+4PXeZlYuQT4PsjD1sfLofwFUO8cmi/YRQA
 oSs7KiyShgnxkCvhcFYPb3NNNjsArDTA6yt2YnaVq/0uTpEbapbhuuDOVy31im/L6fwC
 wcGfDp6Epa2kBIJECG9/26edilnNZMzMwZMAapyYef/AtcT68CqSrBb9cyclFla2f9pt
 hpTjx5rdxP4rv33IO5WsqLLTQks9pMsnGPKRNW4xpY/HPQSKU4vWjbdQHXGnvKeIkN04
 yMxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX8yDU8NB+W+oNtV/XkrYpinesUisercadeyqObh1QvxrfbvNIVwpCBtMVPQKZ8LNOf222UiEaqNfW@nongnu.org
X-Gm-Message-State: AOJu0Yzdn0uAwD4Z7+6NwMajzHOEyJW8Na1yDyjc4WXCtyJRDO1oqQmW
 6KFQvq7yilo49DfihknZsx1VxLWNZ6SbHCDO83Jp/AKraHq/tvaPiDT7ftGbUtYybEkl6vg9CW8
 jbO4foAY18DdNQx7uLbz+iRjJExFouZhpRtW0UN0DeM7h8ZJ5mNZO
X-Gm-Gg: ASbGncuJORrNyRMDgUVBPA8lnM30VD8Kx0r/aBJ9Jqds5PWnPFFlE5Lmq0AXm/AkI3M
 ehD9qwoovSOg0XdqJAi4gDKsGJGgM3FR04OZI87jCajk4hhxVDvw8QJcmEl0lmXCRk9od/+ctgs
 J0IibnsjefLGHISMqC17xc4kniPyWnq6kf4t1+5IaxMyTEytxBxUsmCfL9F41svujFLYVDA91yU
 GqxfqyJlheRLRV+HcgSFqJCHJlXMFWP9ZSDYMjEhpPdndG+3c6KTxV3Uhswv6c5LTIIlMB/6DId
 0vT9OmgeLpGKpko=
X-Received: by 2002:a05:6e02:1606:b0:3d3:dba6:794b with SMTP id
 e9e14a558f8ab-3d8123d2cd6mr1930045ab.0.1744743868970; 
 Tue, 15 Apr 2025 12:04:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE44NGPSSEq6itRpizEEVszZCIg16IT0R0uO5d2m8Mv7xnwX9y5sRLeJFUJl4Jl2jhveQpWYQ==
X-Received: by 2002:a05:6e02:1606:b0:3d3:dba6:794b with SMTP id
 e9e14a558f8ab-3d8123d2cd6mr1929845ab.0.1744743868467; 
 Tue, 15 Apr 2025 12:04:28 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d7dc5827e1sm34286795ab.46.2025.04.15.12.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:04:27 -0700 (PDT)
Date: Tue, 15 Apr 2025 13:04:25 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?= <c.koehne@beckhoff.com>
Subject: Re: [PATCH] vfio/igd: Check host PCI address when probing
Message-ID: <20250415130425.601e1902.alex.williamson@redhat.com>
In-Reply-To: <e529bf00-bd58-4151-9bce-dad74c88fa6d@gmail.com>
References: <20250325172239.27926-1-tomitamoeko@gmail.com>
 <20250409111801.4c97022f.alex.williamson@redhat.com>
 <046a2961-23b1-4ef2-8673-9b9deedbbbdf@redhat.com>
 <3e9743ab-bf81-4d92-8ea0-e01ac58a234b@gmail.com>
 <20250414160530.5d86aaf2.alex.williamson@redhat.com>
 <e529bf00-bd58-4151-9bce-dad74c88fa6d@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 16 Apr 2025 01:36:15 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:
> 
> The generation register also exists on discrete GPUs. In the new xe
> driver [1], the Battlemage discrete GPU shares the same logic reading
> GMD_ID_DISPLAY register. The driver itself uses is_dgfx bit mapped to
> device id. In QEMU, we need to know whether the device is a supported
> IGD device first before applying the IGD-specific quirk, especially
> for legacy mode.
> 
> The most feasible way is to check if kernel exposes VFIO_REGION_SUBTYPE_
> INTEL_IGD_OPREGION on that device I think, as only IGD has OpRegion.
> 
> i915 driver [2] and Arrow Lake datasheet [3] shows that Intel has
> removed the BDSM register by making the DSM range part of BAR2 since
> Meteor Lake and onwards. QEMU only need to quirk on the register for
> IGD devices until Raptor Lake, meaning that the device list is fixed
> for now.
> 
> By the way, for legacy mode, I think we should only support it until
> Gen 9, as Intel only provide VBIOS or CSM support until that generation,
> and seabios cannot handle 64 bit BDSM register. I'm also wondering if
> VGA really works on newer generations.

If it's a VGA class device, it really should, but without CSM I could
see why you have doubts.
 
> Maybe we can continue with current igd_gen, but implement a logic like:
>     if (!intel graphics)
>         return;
>     if (!has VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION)
>         return;
>     setup_opregion();  // make x-igd-opregion automatically enabled?
>     if (gen <= 9)
>         setup_legacy_mode();
>     if (gen >= 6 && gen <=9)
>         setup_32bit_bdsm():
>     else if (gen >= 9 && gen <= 12)
>         setup_64bit_bdsm();
>     // ...
>     // optional quirks like lpc bridge id
> 
> A table can also be used to precisely track all the gen 6-12 devices.

This seems reasonable to me.

> Attached a config space dump of Intel A770 discrete GPU for reference
> 
> 03:00.0 VGA compatible controller: Intel Corporation DG2 [Arc A770] (rev 08) (prog-if 00 [VGA controller])
> 	Subsystem: Intel Corporation Device 1020
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin ? routed to IRQ 181
> 	IOMMU group: 19
> 	Region 0: Memory at 81000000 (64-bit, non-prefetchable) [size=16M]
> 	Region 2: Memory at 6000000000 (64-bit, prefetchable) [size=16G]
> 	Expansion ROM at 82000000 [disabled] [size=2M]
> 	Capabilities: [40] Vendor Specific Information: Len=0c <?>
> 	Capabilities: [70] Express (v2) Endpoint, IntMsgNum 0
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0W TEE-IO-
> 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
> 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
> 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us

Hmm, hardware bug?  Surely the A770 is not a Gen1, x1 device.
Something is going on with the interrupt pin above too.  At least it
claims FLReset+ above, does it work reliably though?  Seems like there
are various reports of Arc GPUs not working well with assignment due to
reset issues.  Thanks,

Alex

> 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s, Width x1
> 			TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
> 		DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
> 			 10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt+ EETLPPrefix-
> 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
> 			 FRS- TPHComp- ExtTPHComp-
> 			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> 			 AtomicOpsCtl: ReqEn-
> 			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
> 			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
> 		LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink- Retimer- 2Retimers- DRS-
> 		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
> 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
> 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
> 			 Retimer- 2Retimers- CrosslinkRes: unsupported
> 	Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable+ 64bit+
> 		Address: 00000000fee008b8  Data: 0000
> 		Masking: 00000000  Pending: 00000000
> 	Capabilities: [d0] Power Management version 3
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [100 v1] Alternative Routing-ID Interpretation (ARI)
> 		ARICap:	MFVC- ACS-, Next Function: 0
> 		ARICtl:	MFVC- ACS-, Function Group: 0
> 	Capabilities: [420 v1] Physical Resizable BAR
> 		BAR 2: current size: 16GB, supported: 256MB 512MB 1GB 2GB 4GB 8GB 16GB
> 	Capabilities: [400 v1] Latency Tolerance Reporting
> 		Max snoop latency: 15728640ns
> 		Max no snoop latency: 15728640ns
> 	Kernel driver in use: i915
> 	Kernel modules: i915, xe


