Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F128C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp141-0003jU-SV; Wed, 29 Jul 2026 05:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wp140-0003jE-82
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:59:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wp13x-0002xm-N8
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785319135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xJH3rf8o2pEe+QG945LI/VaztkRHENzVgrBaD1b+sDQ=;
 b=UBaNOT4VDs3oS1G4DJQ0ucHuLDDRuXXAXTauy6iembtux3yrBzl//NxNyaV0NdkOn3gYrp
 9CE8K2MjsUZkB+4mwzhkSQOmj6Yd8LPVlzBtcqHfAigxyvVS4GLH2WgFs35IEXBWZkqq7a
 oZ6kaMeCDq37Adtt59hGbjMZ2cdX71E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-pXdihciFNDi-mE6UvJYrBw-1; Wed, 29 Jul 2026 05:58:53 -0400
X-MC-Unique: pXdihciFNDi-mE6UvJYrBw-1
X-Mimecast-MFC-AGG-ID: pXdihciFNDi-mE6UvJYrBw_1785319133
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f810c8aebso468262f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 02:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785319132; x=1785923932; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xJH3rf8o2pEe+QG945LI/VaztkRHENzVgrBaD1b+sDQ=;
 b=MmZpeKQClGrJrIZ4/0K5TqTuWqX5Pyxo8RrwrtMY4Jl70V4KMCzb6i8kPn0v7otOcU
 C1Xxe1YLsCubvTGQ9GL7m1bfJMCugvfeDZhl1v06/awABmB5Ku0YVd2Nd2AuNiCa/D2M
 2NRdhDdPpTqhrw2q/yVKJAFF6k5iOSUYe5mTpteaMHFurAZv6hvwKk4nNehUSOwBVlR/
 x5+1TIWoPcDrjjLkWcbqJtA9IX6mwCWHIPhAHtYLI03OyyseGNmfUXcs+dUYA7/kFbTo
 fhV2SAuMjJAY0yiJZl57pJUR9swQsrunHT6TG5XmqxxHgBmzb7hZQJz6mudLo4gkwNPG
 2PPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785319132; x=1785923932;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xJH3rf8o2pEe+QG945LI/VaztkRHENzVgrBaD1b+sDQ=;
 b=qjkez6Jl6k2MRNo7pzvd5ai2vzeRxanH8tHyGNVHDWvZ4ylwKRCBRgsdexKhmkJLMr
 +4aNSzBGtm+4scZFZCv7CvY1Dwpr7PNKjhJzcPe3s7k314W6w06wHZZnK8E2wiLRFhWl
 DOLjxiCp3BVQNYPDyfE6Z4mwO0uY141z78Ye/8AEw41txhjinrEA9KIzL+6zlfnW5ImF
 dL/3+SzOTwdyeOj5O2tgsDzF6uHHFhjChOklFd/wrzbeq5H+taNE4rDHIInI4ad7PuQ5
 YZgqGiqRwLKh6NxKW7IKbnQ0HzuQWuUsp/M75UFrZsKbMNBQFN1hbIL5w+HxOx2/aqZ5
 ZQzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUzW90f8cVp6DINJhFOlht0NLwhtuSXfBWGLBY8SKnK65MngVyVMGwqKst4uNlaZquZjUmbOcib+kP@nongnu.org
X-Gm-Message-State: AOJu0Yz1LJuuNhdAfNikPleNtVWOqpzUbmStiLGu76P/Emy59T0pt8Hx
 BKzyoLMejJFq442uDku1RgS5R8E0eo9DKLjJYqJlRi4HseEyDa+XhGlCWQcivcoi1f7IE2z6fzR
 E8MSD4aSGUvxdiJYKiwBxPveIOTxOzAuB832wZmULb0v3AhV0ES5pUI2Z
X-Gm-Gg: AR+sD11atRwRme9bM6hcRl7n2DOTifpRgvicOMG2QW1p4xa0lZDRpbyjPTdD4ocw3gr
 2QAFxSU0vF1Rac18Fo+43MmR++Q72Ny+hnICJpB6Cu5QdrJ/1l5kMqVu2J72Bv2EySNYPnCQwC/
 7rgjvgRAR8GN3+NVVlmKSSgI95hGmm8LUv2il51CDBd6IlBLD22ZmXmz3ZFrPLFrxqBix8mgNLe
 tBIyhs9keNibQuLvBKztyY0b8J2uSxIjdIrA8oxdOkZ35TxkUnUWXBCuoeSLXdQ6Vpf1rRnVJ8x
 zJMH2zhkt1sG85eeWAC36xXfKxN+zam+/P8+VIEFmcVsltOmsgE1GCcfp80G6pSCA3pCywS3Q6c
 kmx+i4iA6snO+lsSudEXpnlayQgGAFL+rfCsnL2c=
X-Received: by 2002:a05:6000:381:b0:47e:f3d:2b3 with SMTP id
 ffacd0b85a97d-47fb1f14c91mr7389994f8f.39.1785319132476; 
 Wed, 29 Jul 2026 02:58:52 -0700 (PDT)
X-Received: by 2002:a05:6000:381:b0:47e:f3d:2b3 with SMTP id
 ffacd0b85a97d-47fb1f14c91mr7389945f8f.39.1785319131932; 
 Wed, 29 Jul 2026 02:58:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6acbfb3sm6476120f8f.14.2026.07.29.02.58.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 02:58:50 -0700 (PDT)
Message-ID: <ae43beb2-852b-4fb8-a7ea-f24052483837@redhat.com>
Date: Wed, 29 Jul 2026 11:58:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 01/13] vfio/igd: Clear saved BDSM in legacy VBIOS ROM at
 load time
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Tomita Moeko <tomitamoeko@gmail.com>, K S Maan
 <kirandeepmaan45@gmail.com>, qemu-stable@nongnu.org,
 Alex Williamson <alex@shazbot.org>, Mario Casquero <mcasquer@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260721170518.4160785-1-clg@redhat.com>
 <20260721170518.4160785-2-clg@redhat.com>
 <9e9a526d-e54e-402c-8f78-958e4ee514d5@tls.msk.ru>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <9e9a526d-e54e-402c-8f78-958e4ee514d5@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/24/26 10:33, Michael Tokarev wrote:
> On 7/21/26 20:05, Cédric Le Goater wrote:
>> From: Tomita Moeko <tomitamoeko@gmail.com>
>>
>> IGD does not come with a ROM BAR [1], the ROM BAR read by default from
>> kernel is actually the host VBIOS shadow RAM region that contains host
>> modifications on boot. With AI-assisted reverse engineering on VBIOS
>> binaries, it is observed that VBIOS saves BDSM register value on first
>> access and uses saved value if present.
>>
>> When the image is executed in guest, since there is already a saved HPA
>> in VBIOS, it keeps using that value instead of the GPA programmed by
>> SeaBIOS in BDSM register in PCI config space, causing VBIOS to program
>> GTT entries with wrong address, resulting in garbled output in BIOS
>> POST and the error below detected by i915 driver.
>>
>> i915 0000:00:02.0: [drm] *ERROR* Initial plane programming using invalid range, dma_addr=0x00000000db200000 ((null) [0x00000000baf00000-0x00000000beefffff])
>>
>> The previous solution, c4c45e943e51 ("vfio/pci: Intel graphics legacy
>> mode assignment"), adjusts GTT entry addresses to (addr - host BDSM +
>> guest BDSM) to workaround that. But it is removed in 5aed8b0f0be2
>> ("vfio/igd: Remove GTT write quirk in IO BAR 4") due to inconsistent
>> values in MMIO BAR0 and IO BAR4.
>>
>> Since it was a value latched into the VBIOS that breaks virtualization
>> (QEMU does not map the GTT at the same address in the VM), a ROM quirk
>> clearing the saved value in VBIOS image is introduced. It searches the
>> BDSM accessor routine by matching a 19-byte signature anchored on the
>> unique `mov $0x105e,%ax` instruction, then locates the offset of saved
>> BDSM and clears it. This makes the routine fall through to the PCI
>> config read on the first call inside the guest.
>>
>> [1] 3.5.15, 4th Generation Intel Core Processor Family Datasheet Vol. 2
>>      https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-desktop-vol-2-datasheet.pdf
>>
>> Fixes: 5aed8b0f0be2 ("vfio/igd: Remove GTT write quirk in IO BAR 4")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3093
>> Reported-by: K S Maan <kirandeepmaan45@gmail.com>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>> Reviewed-by: Alex Williamson <alex@shazbot.org>
>> Link: https://lore.kernel.org/qemu-devel/20260708103100.23127-1-tomitamoeko@gmail.com
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> 
>> ---
>>   hw/vfio/pci.h        |   3 ++
>>   hw/vfio/igd-stubs.c  |   5 ++
>>   hw/vfio/igd.c        | 115 +++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/pci-quirks.c |   5 ++
>>   hw/vfio/pci.c        |   2 +
>>   hw/vfio/trace-events |   1 +
>>   6 files changed, 131 insertions(+)
> 
> I'm picking this up for currently active stable qemu series.  Since this
> change touches several files, including new file since last release
> (hw/vfio/igd-stubs.c), I'm also picking a few other changes to the
> stable series, namely, for 11.0.x:
> 
> v11.0.0-2776-gc822ecd8066 vfio/pci: Initialize rom_read_failed in vfio_pci_load_rom()
>    this is a little bugfix by its own, so it's okay to pick up
> 
> v11.0.0-3-g55e25958aa1 hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD,
>    Add stubs for needed functions.  This changes quite a few things,
>    but not much.  I can adjust this change (Clear saved BDSM) for the
>    context before CONFIG_VFIO_IGD removal, but it feels like it would
>    be better to pick up CONFIG_VFIO_IGD removal too, to make the branches
>    more similar.
> 
> For 10.0.x, things are a bit more complex here.  In particular, 10.0.x
> lacks
> 
>   v10.0.0-290-ge218ccf0c94 vfio: Rename VFIODevice related services
>   v10.0.0-756-g2e27becf17b vfio: consistently handle return value for helpers
>   v10.2.0-2365-g988499515da "hw/display: Build stubs once"
> 
> and these are more troublesome to pick up, including "CONFIG_VFIO_IGD
> removal", so I'm picking up "Initialize rom_read_failed", and adjusting
> "Clear saved BDSM" for the lack of "CONFIG_VFIO_IGD removal" (it's
> stright-forward, with #ifdef CONFIG_VFIO_IGD instead of empty stub).
> 
> I'm not very comfortable with the different approach to 10.0.x and 11.0.x,
> maybe I should omit "CONFIG_VFIO_IGD removal" from 11.0.x too.
> 
> What do you think?

For the stable branches, I would take the fixes only :

  c822ecd80661 ("vfio/pci: Initialize rom_read_failed in vfio_pci_load_rom()")
  256229e8f9b9 ("vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load time")

and commit 55e25958aa1a ("hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD") is
not one.

I would skip 55e25958aa1a and adapt the BDSM patch with #ifdef CONFIG_VFIO_IGD
in 10.0.x and 11.0.x.

How's that ?

C.





