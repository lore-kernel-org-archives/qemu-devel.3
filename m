Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0D7C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 17:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u570g-0008P5-MZ; Wed, 16 Apr 2025 13:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u570a-0008O4-0f
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 13:57:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u570Y-0007mk-82
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 13:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744826228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eV8b9ckxRAmWZhMAqOpShTMnlLReAghHa7l5FvcRKr8=;
 b=CmKqY56iy5GIs3hLBoOI2WDfOYIukN7Z6n9X04DR1DOu6GHtFAOI0+Oq6gUwe8AWe0l/ys
 hyLGuGho2bk+iawdY6KyMNi327FC2fdYJJDRFbUZJBvadtw5swBkHeQsnaDpAgqfXCtPQc
 eU545DzZxF+12J3cncPr2FAXeaWccnw=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-fi7Mm1vPOWei8qhenzYZSw-1; Wed, 16 Apr 2025 13:57:06 -0400
X-MC-Unique: fi7Mm1vPOWei8qhenzYZSw-1
X-Mimecast-MFC-AGG-ID: fi7Mm1vPOWei8qhenzYZSw_1744826225
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-85b5ea50d28so82556039f.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 10:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744826225; x=1745431025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eV8b9ckxRAmWZhMAqOpShTMnlLReAghHa7l5FvcRKr8=;
 b=vD2S5qxVFGO6vIebWL0eW3ybnzj2nFEgDaHGbdsnZK71ZoP+52quTXi/d5/m4waQ9v
 IwveGaef/rBZwTkTfmta5Qo2lcFsux/PXNtHednvZwL0ZOulMIUnZatzoAp12lxNg+oa
 GnrNMGjQOqcLKwcnasP9fvbVU6LtA+Lj8uQp8P8/twZuiMhaRLtyog53mpQbWj6NL9LV
 RCaj05svdUDVoo3r1Lqi1BPouP+7oBgxc+Gp8DtKCu1CWJSX16z4UktrCPSDcRfY1G+r
 vsqXKegWN3aEu+Z8IgMhVwODDt4Jrq35yu9YM2hoNUCo8BfuYVDgqj+LSpNHB2hoehe7
 d3VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoVjOiDr58EkzQup5kfx0WqIoNYbGMgpcRrgEFM75zvWoiqhkVBt1hnG/Sw5jy2KWMME0WIcFYnu4s@nongnu.org
X-Gm-Message-State: AOJu0YwoBxqEdJL5MjCRwWJuIBM6hvmUjnMBpZXeug+MGOSfoYu6uyIS
 CHSJjD+6HhJTcD5QowdDfL3cFDkXUZWLpZ+C/ics6nG8N2RnCfI0ttiNLZEPb6Nt6WkxRGyifM3
 7sJ6InOxmuFjbePJ7th/KmVKzQJ2zz20F50SqqPOvuy9uV2Nawf7X
X-Gm-Gg: ASbGncsWao4MpYhaEGx4gPk5XgFjeda18J2aOLHLp2lYQSzi2749KahSLdxtnjRfuvQ
 RVQlbX4KW6Yo5CmPEoqa0rq9MKfLLSQPxRFQUtLBhhCbRGUnQuqnx6U2SuaXLQuMHB12xsbGvBD
 wDIeJcWMJ84F5oBdu2EigsH1GSnNoL5uoiWSyTtoArsqpxllVfGXz0IisPoZf8NAmINe2oR/V2s
 XAvv13LGNXTww5ysAk3DxvTtrbERbkPI96fyGiIHkriiuYCQmjdkF/cZiUuXe1sL0bZfDTpqcXH
 PbqzFg0W5eh+C6c=
X-Received: by 2002:a05:6e02:3987:b0:3d4:2b52:6e14 with SMTP id
 e9e14a558f8ab-3d81a3e2dc8mr2851885ab.7.1744826225462; 
 Wed, 16 Apr 2025 10:57:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7Fp5ZW04g70oE85NLJiqV2WgLAhVK+uQLj46SOimIc9I8M9+29KKE24Yf/IndEo4AHSNxfg==
X-Received: by 2002:a05:6e02:3987:b0:3d4:2b52:6e14 with SMTP id
 e9e14a558f8ab-3d81a3e2dc8mr2851815ab.7.1744826225106; 
 Wed, 16 Apr 2025 10:57:05 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d81997de4bsm1131295ab.40.2025.04.16.10.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 10:57:04 -0700 (PDT)
Date: Wed, 16 Apr 2025 11:57:02 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?= <c.koehne@beckhoff.com>
Subject: Re: [PATCH] vfio/igd: Check host PCI address when probing
Message-ID: <20250416115702.41b2dc4e.alex.williamson@redhat.com>
In-Reply-To: <0ec0fa57-1e99-4e21-b0c5-991806f4bd6d@gmail.com>
References: <20250325172239.27926-1-tomitamoeko@gmail.com>
 <20250409111801.4c97022f.alex.williamson@redhat.com>
 <046a2961-23b1-4ef2-8673-9b9deedbbbdf@redhat.com>
 <3e9743ab-bf81-4d92-8ea0-e01ac58a234b@gmail.com>
 <20250414160530.5d86aaf2.alex.williamson@redhat.com>
 <e529bf00-bd58-4151-9bce-dad74c88fa6d@gmail.com>
 <20250415130425.601e1902.alex.williamson@redhat.com>
 <f27926c8-3bae-45b9-bbc1-ea9d78bcbd10@gmail.com>
 <20250416101038.3f84f2b8.alex.williamson@redhat.com>
 <0ec0fa57-1e99-4e21-b0c5-991806f4bd6d@gmail.com>
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

On Thu, 17 Apr 2025 01:41:22 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> On 4/17/25 00:10, Alex Williamson wrote:
> > On Wed, 16 Apr 2025 23:45:08 +0800
> > Tomita Moeko <tomitamoeko@gmail.com> wrote:
> >   
> >> On 4/16/25 03:04, Alex Williamson wrote:  
> >>> On Wed, 16 Apr 2025 01:36:15 +0800
> >>> Tomita Moeko <tomitamoeko@gmail.com> wrote:    
> >>>>
> >>>> The generation register also exists on discrete GPUs. In the new xe
> >>>> driver [1], the Battlemage discrete GPU shares the same logic reading
> >>>> GMD_ID_DISPLAY register. The driver itself uses is_dgfx bit mapped to
> >>>> device id. In QEMU, we need to know whether the device is a supported
> >>>> IGD device first before applying the IGD-specific quirk, especially
> >>>> for legacy mode.
> >>>>
> >>>> The most feasible way is to check if kernel exposes VFIO_REGION_SUBTYPE_
> >>>> INTEL_IGD_OPREGION on that device I think, as only IGD has OpRegion.
> >>>>
> >>>> i915 driver [2] and Arrow Lake datasheet [3] shows that Intel has
> >>>> removed the BDSM register by making the DSM range part of BAR2 since
> >>>> Meteor Lake and onwards. QEMU only need to quirk on the register for
> >>>> IGD devices until Raptor Lake, meaning that the device list is fixed
> >>>> for now.
> >>>>
> >>>> By the way, for legacy mode, I think we should only support it until
> >>>> Gen 9, as Intel only provide VBIOS or CSM support until that generation,
> >>>> and seabios cannot handle 64 bit BDSM register. I'm also wondering if
> >>>> VGA really works on newer generations.    
> >>>
> >>> If it's a VGA class device, it really should, but without CSM I could
> >>> see why you have doubts.    
> >>
> >> Without CSM/VBIOS there is no pre-boot video, but when it booted to OS,
> >> driver is used for video rather than VGA. Though it claims itself as
> >> VGA class, it does not have VGA compatiblity. A770 even does not have
> >> IO BAR, definitely it cannot handle VGA decoding.  
> > 
> > VGA ranges are implicit in a VGA class device, they're not backed by
> > BARs.  Lack of CSM support makes it more difficult to prove whether VGA
> > support is present since we can't easily initialize the device for a
> > legacy OS, but I don't think lack of CSM necessary proves the hardware
> > doesn't support VGA.  If we really cared, we could probably do some low
> > level experiments writing into the VGA frame buffer range to test if
> > it's present and behaves as expected relative to memory and IO enable
> > bits.  
> 
> Sorry for my misunderstanding. The bridge control register in PCI bridge
> config space determines forwarding VGA IO/MMIO accesses to which device,
> BAR is not related in this process.
> 
> As device initialization (by legacy VBIOS) is required for booting
> legacy OS with seabios, limiting legacy mode to gen9 and older sounds
> resonable.
> 
> Trying VGA framebuffer would be difficult we have to disable EFI GOP and
> manually instruct the device to enter VGA mode without VBIOS routines.
> It's not a major problem here, let's skip it for now?

This is only a curiosity as far as I'm concerned, I agree with your
proposal that we can drop legacy mode where the bare metal system
doesn't even support CSM.  Thanks,

Alex


