Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143A2C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 16:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u55M4-0006pG-GB; Wed, 16 Apr 2025 12:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u55Li-0006li-85
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 12:10:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u55Lf-0001Kl-Ct
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 12:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744819847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fYDHgVOEZbzPWbIsqGmVlY/4xvKWC4TyXfFVJPNyyaM=;
 b=cI2n6BDlcsvAXJyIgBtOkJCf9drdcl5tBpTycTU0sb1KZ2lPrgy2dY1apFFAxYYu9X/sRg
 9GS/y3UoorMSmVBo4d10YXTTU+zoKkrsPPqLVj0kfMaGPYhx8DHjEBu5QWVitmV4sVa4Dm
 Lj82klSmlEf1k0BEt+jB8yp16ZFzDhU=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-jcE82XbhPMuySKCd45KV4w-1; Wed, 16 Apr 2025 12:10:43 -0400
X-MC-Unique: jcE82XbhPMuySKCd45KV4w-1
X-Mimecast-MFC-AGG-ID: jcE82XbhPMuySKCd45KV4w_1744819842
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-85df98f62d1so66035739f.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 09:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744819841; x=1745424641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fYDHgVOEZbzPWbIsqGmVlY/4xvKWC4TyXfFVJPNyyaM=;
 b=I+ZhSWEfLN7Ou2iWwadKLcWAMGMy3hmc4pcv5d8SBBWI2u9GhtOesWMbif3+BmTatr
 C4MoNwVO6ivfpNRCJ5GE3Q+6p2iqxRGIFi9j4bQY2OiggASVF59oL3CH5EpBnEFH1DlL
 leUal2BNODZM5KvYkve22xy3bMDa4Lp5aGbIhjEYEO9fa2HPwsLqJJ/rf7nnh5VZzxGt
 8uFAvTjMqW9ZTM8z0tXP3RXff/QSdcIRoCc7z4zEfyKuyR0OQQsUwk566nPaOmhn861y
 GW1wozuC0rkdYJxp5cfCGkbZupdNB5h9fdvgMyzbJYa0JQlmOITxcYJSj6lb2/cdlWYf
 r9yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt7Akcqsvj2acSbcH07OWi6qI6F8IuAmYMkhzNOo+Rz0GLYJOIEMM5KwdsUX5MD+nURbVzE/tmHF40@nongnu.org
X-Gm-Message-State: AOJu0YxdpZgrxSH6XuBd/vKInqtvlD3PY0oy3MyYa1i5ZsngPnc8KpuQ
 viW99r6fKOuzLGQF3qnhQOuH4/Qi77HiMgTy4lOSD27/F3KV5aT4QmYaASlKEkvUNoB6il1GPXm
 PIqGXTLIp8eKOc26/o6v9ddEUVuvNwjqbfbp1fQ8mvO61q7XNu7OL
X-Gm-Gg: ASbGncu5UmqFJVz9/7ZAYhEiJCJVWPEpxzn106o3WGO/KlhB5fmKZ7FIMB9zpIe10qm
 4LULYN8cMFu/rtS0kXaPVc6uVkSIKF5iffACpedasw6mfJ8WNv7Qd9AjHFP8tEc6OCXpPb1IEsI
 IcMWGC4detEba4SjyC3Bu20RypiMTMeg+CbCnUc1+PZu4f7pMBAI+Ox2aWhh4fPiEDD6qqIc5gY
 YvuGvVC7rVq82G7lW7BVixVBuvGIamWfx/iE+YHJAxL8kib+7zmvNZKyYuMADf7GKczYc2QUY74
 N+hfI7xiYxel8uQ=
X-Received: by 2002:a05:6602:2c0f:b0:85d:978a:c13b with SMTP id
 ca18e2360f4ac-861cc303650mr8309139f.0.1744819841547; 
 Wed, 16 Apr 2025 09:10:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjFLP+DSnmWdMWq6WFEMJi4vXto6KlyH0QV/xb3rkzJfZQhyDWdweoZxo8/22ivABJPMkyZg==
X-Received: by 2002:a05:6602:2c0f:b0:85d:978a:c13b with SMTP id
 ca18e2360f4ac-861cc303650mr8307739f.0.1744819841100; 
 Wed, 16 Apr 2025 09:10:41 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f505d3b6ecsm3607683173.63.2025.04.16.09.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 09:10:40 -0700 (PDT)
Date: Wed, 16 Apr 2025 10:10:38 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?= <c.koehne@beckhoff.com>
Subject: Re: [PATCH] vfio/igd: Check host PCI address when probing
Message-ID: <20250416101038.3f84f2b8.alex.williamson@redhat.com>
In-Reply-To: <f27926c8-3bae-45b9-bbc1-ea9d78bcbd10@gmail.com>
References: <20250325172239.27926-1-tomitamoeko@gmail.com>
 <20250409111801.4c97022f.alex.williamson@redhat.com>
 <046a2961-23b1-4ef2-8673-9b9deedbbbdf@redhat.com>
 <3e9743ab-bf81-4d92-8ea0-e01ac58a234b@gmail.com>
 <20250414160530.5d86aaf2.alex.williamson@redhat.com>
 <e529bf00-bd58-4151-9bce-dad74c88fa6d@gmail.com>
 <20250415130425.601e1902.alex.williamson@redhat.com>
 <f27926c8-3bae-45b9-bbc1-ea9d78bcbd10@gmail.com>
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

On Wed, 16 Apr 2025 23:45:08 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> On 4/16/25 03:04, Alex Williamson wrote:
> > On Wed, 16 Apr 2025 01:36:15 +0800
> > Tomita Moeko <tomitamoeko@gmail.com> wrote:  
> >>
> >> The generation register also exists on discrete GPUs. In the new xe
> >> driver [1], the Battlemage discrete GPU shares the same logic reading
> >> GMD_ID_DISPLAY register. The driver itself uses is_dgfx bit mapped to
> >> device id. In QEMU, we need to know whether the device is a supported
> >> IGD device first before applying the IGD-specific quirk, especially
> >> for legacy mode.
> >>
> >> The most feasible way is to check if kernel exposes VFIO_REGION_SUBTYPE_
> >> INTEL_IGD_OPREGION on that device I think, as only IGD has OpRegion.
> >>
> >> i915 driver [2] and Arrow Lake datasheet [3] shows that Intel has
> >> removed the BDSM register by making the DSM range part of BAR2 since
> >> Meteor Lake and onwards. QEMU only need to quirk on the register for
> >> IGD devices until Raptor Lake, meaning that the device list is fixed
> >> for now.
> >>
> >> By the way, for legacy mode, I think we should only support it until
> >> Gen 9, as Intel only provide VBIOS or CSM support until that generation,
> >> and seabios cannot handle 64 bit BDSM register. I'm also wondering if
> >> VGA really works on newer generations.  
> > 
> > If it's a VGA class device, it really should, but without CSM I could
> > see why you have doubts.  
> 
> Without CSM/VBIOS there is no pre-boot video, but when it booted to OS,
> driver is used for video rather than VGA. Though it claims itself as
> VGA class, it does not have VGA compatiblity. A770 even does not have
> IO BAR, definitely it cannot handle VGA decoding.

VGA ranges are implicit in a VGA class device, they're not backed by
BARs.  Lack of CSM support makes it more difficult to prove whether VGA
support is present since we can't easily initialize the device for a
legacy OS, but I don't think lack of CSM necessary proves the hardware
doesn't support VGA.  If we really cared, we could probably do some low
level experiments writing into the VGA frame buffer range to test if
it's present and behaves as expected relative to memory and IO enable
bits.

> 
> Similar behavior is also found on AMD GPUs. They still claim as VGA
> controller, but without CSM support.
> https://www.amd.com/en/resources/support-articles/faqs/GPU-N4XCSM.html
> 
> >> Maybe we can continue with current igd_gen, but implement a logic like:
> >>     if (!intel graphics)
> >>         return;
> >>     if (!has VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION)
> >>         return;
> >>     setup_opregion();  // make x-igd-opregion automatically enabled?
> >>     if (gen <= 9)
> >>         setup_legacy_mode();
> >>     if (gen >= 6 && gen <=9)
> >>         setup_32bit_bdsm():
> >>     else if (gen >= 9 && gen <= 12)
> >>         setup_64bit_bdsm();
> >>     // ...
> >>     // optional quirks like lpc bridge id
> >>
> >> A table can also be used to precisely track all the gen 6-12 devices.  
> > 
> > This seems reasonable to me.
> >   
> >> Attached a config space dump of Intel A770 discrete GPU for reference
> >>
> >> 03:00.0 VGA compatible controller: Intel Corporation DG2 [Arc A770] (rev 08) (prog-if 00 [VGA controller])
> >> 	Subsystem: Intel Corporation Device 1020
> >> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> >> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> >> 	Latency: 0, Cache Line Size: 64 bytes
> >> 	Interrupt: pin ? routed to IRQ 181
> >> 	IOMMU group: 19
> >> 	Region 0: Memory at 81000000 (64-bit, non-prefetchable) [size=16M]
> >> 	Region 2: Memory at 6000000000 (64-bit, prefetchable) [size=16G]
> >> 	Expansion ROM at 82000000 [disabled] [size=2M]
> >> 	Capabilities: [40] Vendor Specific Information: Len=0c <?>
> >> 	Capabilities: [70] Express (v2) Endpoint, IntMsgNum 0
> >> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> >> 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0W TEE-IO-
> >> 		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
> >> 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
> >> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> >> 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
> >> 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us  
> > 
> > Hmm, hardware bug?  Surely the A770 is not a Gen1, x1 device.
> > Something is going on with the interrupt pin above too.  At least it
> > claims FLReset+ above, does it work reliably though?  Seems like there
> > are various reports of Arc GPUs not working well with assignment due to
> > reset issues.  Thanks,
> > 
> > Alex  
> 
> Just did a quick search, link speed reporting is a known issue on Arc
> A-series GPU.
> https://www.intel.com/content/www/us/en/support/articles/000094587/graphics.html
> 
> The root port reports correct `LnkSta:	Speed 16GT/s, Width x16`

Interesting, suppose I just hadn't noticed before.
 
> I also tried the passthough it to VM and not meeting any reset issue.
> Probably it was fixed, intel often publishes VBIOS updates (they call
> it IFWI) with windows driver releases. 

Ok, I have an A380 that doesn't behave well with resets, I suppose
I should boot it on a bare metal Windows system to try to get any
available firmware updates.  Thanks,

Alex


