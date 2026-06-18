Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D52CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 06:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa6SI-0002f4-Kv; Thu, 18 Jun 2026 02:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wa6SG-0002em-2D
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 02:42:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wa6SE-00025y-4r
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 02:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781764936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yPSRdRbEwDtEeL5mG7d55XUgjl18pCCrH+V35TE+kSA=;
 b=W+3pcU90zlmXi/eei8OgPbg5CXrIKf7nYgEe5eo9AR28Bs0w8LIVvw90OoAn9tu3l85i/l
 7qZbeZzUPeSGs6YGfZlJtOsf6anAIwed2VeG+jxSe/on42DUIrTQ88/dBtjFPhgKdoTgU6
 ADrqdxQhignLLGPIlC7sjYApyWZ0w7I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-HmDYQjVVO-iSMAIfsp_Neg-1; Thu, 18 Jun 2026 02:42:15 -0400
X-MC-Unique: HmDYQjVVO-iSMAIfsp_Neg-1
X-Mimecast-MFC-AGG-ID: HmDYQjVVO-iSMAIfsp_Neg_1781764934
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490ace40f13so1996085e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 23:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781764934; x=1782369734; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=yPSRdRbEwDtEeL5mG7d55XUgjl18pCCrH+V35TE+kSA=;
 b=Ua8nP2SSOCPf/8ykn+gVP6Lq/i4Tc8x8ZAzG99oUuDvEurGtNGE8ZN2tf2vdotimUW
 SLJN3tEWg3In8mTk0alCErL4cYB6bk1E837/0oGXPzZnvXMft9f4eqUOxb407Ml0SPvP
 Wc6LBG6CJk4jj7u1m6BRdjjrLOEHlz/TpiOpgPYnAl0FbJdy99/V0dkTIx3wG3MnqibS
 ZicFnJigWRYWAYOYqLj0t2i7VxMFnCumraFwVtwmMJv5n9WQmzfFAdvgO3J82KV+XBYg
 FBpA0cZELKPC2zOzoP4te7VS4eTi3Ymz2HZ1GCflzr/VOnweJDaI1V+48R+cpIRGoHXw
 pJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781764934; x=1782369734;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yPSRdRbEwDtEeL5mG7d55XUgjl18pCCrH+V35TE+kSA=;
 b=MBmk09tCWVl78XZ267PUraP18oft/MbYsnYIHFRfnFK0SE9DxaSgN1g5lU0iu3rIla
 P5r2je1313DU1adCx7Ug7sH+w3aA5U59Q1yfFYszd8vSjfeO4SbKwQ40cevogzuz6pTH
 1Potos6PnnxebbqQamf+XSSsNRCZagosN2/3v4M2e6oEgI7hOXaXA5HKXKieTqNXl991
 hcEEuwex1d/SZh5lNpDbyqJ7Kj9c0TfVK2peda6C3wG2kxRtkaYNOKXwuvJ3BAX/bzmZ
 eeIqXaj0vPL7vQkxI64Z6xZtvP/Ph3msyg8iHXZ3pss729QaCjvT9qYe61p4sTf9NW2L
 i9Aw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0IazcRgsC5L4ICDUqwWfy4+Jdzs6Z5UKFwUCJauLq5t5Xl5uRi7Kzt+7cr4CdDi6HrRF584YvRlah@nongnu.org
X-Gm-Message-State: AOJu0YzcfZSOthhcILRD7aO0nTDMVjXThCjBJE+v/8LjOMzl+w/4nCjF
 vUZ3ZpuIbmw8LyGjtcK7LB2QWcITP5ufzjG9mhWzaPplnogrZhOGDDZVPFBkPJkCed4LtehV4u7
 qNhO9QUXgUMARIyPDS29VupnFEz/i1IAA2W1cXid0j3Rc3ueCp5MYuO4k
X-Gm-Gg: Acq92OFfJJr0nbPvGHR+3hSJZ9+7oMcMB2lUZKP8eawAIDtcSj44FcZbuAgSLEZPedD
 joR8OEnUqfvOFg3L5fSvf7uNQARIWHJ094jlIQ2n86t//AXQK6BZnT6RpDvAvECv5aeRMdxG2UK
 i4o450X6N4A/GppIodu7DI4wpBrH07HZg1nx8DXc/sxIStsO6C3xGSZIAY6jQEeCDPtyL2irvJz
 iMht1V5weK0oGj1jcDXH6a9VGzBRaGsNAtCC89ElLAlMnvPLeFz+rhUpSb0F+JplVnFZ7hn1MJf
 qmvC1BO4rE2kqiZF03dVjzVD1oPz2UDBiHAQxplYjB7GBPq+2flNGTakCQTff3z8Y4A3EoMYSUj
 Q1hoo79W3gvNMmWG5BQWnx7Od+QuDwPuPpKlzGI5LXLqw1AIs7A==
X-Received: by 2002:a05:600c:4f53:b0:492:37b7:6090 with SMTP id
 5b1f17b1804b1-492381e4ae2mr38274105e9.5.1781764933711; 
 Wed, 17 Jun 2026 23:42:13 -0700 (PDT)
X-Received: by 2002:a05:600c:4f53:b0:492:37b7:6090 with SMTP id
 5b1f17b1804b1-492381e4ae2mr38273665e9.5.1781764933304; 
 Wed, 17 Jun 2026 23:42:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4619fb12edbsm23881628f8f.17.2026.06.17.23.42.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 23:42:12 -0700 (PDT)
Message-ID: <a59e1bd8-9505-416d-ae63-66c8f8a153f7@redhat.com>
Date: Thu, 18 Jun 2026 08:42:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] vfio/igd: Fix garbled screen on IGD passthrough
 with legacy VBIOS
To: Tomita Moeko <tomitamoeko@gmail.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, K S Maan <kirandeepmaan45@gmail.com>
References: <20260617100646.28326-1-tomitamoeko@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260617100646.28326-1-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/17/26 12:06, Tomita Moeko wrote:
> This series fixes the regression that on IGD passthrough with legacy
> BIOS boot and VBIOS, the screen is garbled during BIOS POST and GRUB
> (which uses standard VGA output routines), starting from QEMU 10.0.
> Though the kernel i915 driver still works, it reports an error about
> the initial GTT programmed by VBIOS is using invalid address.
> 
> i915 0000:00:02.0: [drm] *ERROR* Initial plane programming using invalid range, dma_addr=0x00000000db200000 ((null) [0x00000000baf00000-0x00000000beefffff])
> 
> With the help of AI disassembling the VBIOS image dumped from host, it
> is found that the VBIOS itself implements a routine like:
> 
>      uint32_t get_BDSM() {
>          static uint32_t saved = 0;
>          if (saved != 0) {
>              return saved;
>          }
>          return read_pci_config(BDSM_REG);
>      }
> 
> And the saved value is not cleared after initialization. Given that IGD
> devices don't have a real ROM BAR, the VBIOS image read by default from
> host is actually the VBIOS shadow RAM region, containing host-side
> modifications like the saved BDSM value above during POST. When the
> image is executed in guest, it still uses the saved host BDSM (HPA)
> instead of the value programmed by SeaBIOS in config space (GPA). This
> address mismatch leads to the garbled screen and i915 error.
> 
> The previous solution, c4c45e943e51 ("vfio/pci: Intel graphics legacy
> mode assignment"), adjusts GTT entry addresses to (addr - host BDSM +
> guest BDSM) to workaround that. But it is removed in 5aed8b0f0be2
> ("vfio/igd: Remove GTT write quirk in IO BAR 4") due to inconsistent
> values in MMIO BAR0 and IO BAR4. Considering it's unsafe to expose HPA
> to guest, a ROM quirk clearing the saved value in VBIOS image is
> introduced to fix the issue.
> 
> During debugging, it is also found that IGD VBIOS ROM doesn't always
> match the actual IGD device ID, due to the fact that IGD of the same
> CPU family has multiple device IDs but shares the same ROM image.
> However, SeaBIOS checks the device ID strictly and refuses to run if
> IDs does not match. Currently only the default path, reading ROM from
> kernel patches the device ID, but the romfile path doesn't. So the ROM
> ID patching logic is also refactored in this patch series to also handle
> the romfile path.
> 
> These changes are tested on Haswell platform with legacy BIOS boot, by
> K S Maan. Thanks to K S Maan for continuous help on locating and testing
> the issue!
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3093
> Reported-by: K S Maan <kirandeepmaan45@gmail.com>
> 
> Changelog:
> v3:
> * Refactor ROM checksum calculation and patching logic as Alex's comment
> * Fix boundary checks as comments in v2.
> Link: https://lore.kernel.org/all/20260608134559.23971-1-tomitamoeko@gmail.com/t
> 
> v2:
> * New patch 2/7 to fix regression with EFI option ROMs
> * Refine logic in ROM ID and checksum patching
> * Reorder patch 4 and 5 for cleaner bisection
> * Address comments from v1
> Link: https://lore.kernel.org/all/20260603173355.36121-1-tomitamoeko@gmail.com/t
> 
> Tomita Moeko (7):
>    hw/pci: Recalculate option ROM checksum before patching ID
>    hw/pci: Skip EFI option ROM in pci_patch_ids()
>    hw/pci: Introduce rom_need_patch_id flag in PCIDevice
>    hw/pci: Promote pci_patch_ids() to public pci_rom_patch_ids()
>    vfio/igd: Toggle rom_need_patch_id flag on IGD devices
>    vfio/pci: Use pci_rom_patch_ids() for IGD ROM ID patching
>    vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load time
> 
>   hw/pci/pci.c                |  57 ++++++++++------
>   hw/vfio/igd-stubs.c         |   5 ++
>   hw/vfio/igd.c               | 132 ++++++++++++++++++++++++++++++++++--
>   hw/vfio/pci-quirks.c        |   5 ++
>   hw/vfio/pci.c               |  33 ++-------
>   hw/vfio/pci.h               |   3 +
>   hw/vfio/trace-events        |   1 +
>   include/hw/pci/pci.h        |   3 +
>   include/hw/pci/pci_device.h |   1 +
>   9 files changed, 186 insertions(+), 54 deletions(-)
> 


This looks ready.

K S Maan,

Could we have your Tested-by: ?

Thanks,

C.


