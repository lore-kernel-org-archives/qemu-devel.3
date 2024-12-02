Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A4DD7833E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAXm-00027B-KP; Mon, 02 Dec 2024 12:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIAXi-00026l-4T
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:49:07 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIAXg-0006QO-23
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:49:05 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-215a7e487bfso8746345ad.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733161742; x=1733766542; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Silq42UH4To1Gt4GvCl6hpAR7/8HqGqcwmi/AXFy6go=;
 b=H0rl4o2d3felHvcRqruvc6loHenoHiYD8qEDSIA0B4hqpaRmp96FPrKvlYSgq3SXXl
 LzGx+ox3PdpkOc+E/IVIKyMUa4Cuc1H51JJv9QlMRPFF1scZ7M5bzOG6Vnox0EsRxdKR
 d8Mvdh5Edic5fWs0munUQsSrqjD06Sii66f6e32UWqk+yugx5Um0KNS2aFeKtXEqnFb2
 V9XykhqWPl1qa152YUULdKJd1NcV/7UBOUK7f8D+AGRjtfoQs9gf4tQXNKs5ThudTSMl
 LiPbwIurDtTTGFE+tA63cPN8b/bsxNxdVS0+DlFNRzB7t6YqiGD7fzVocA3KHZI8uba4
 M8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733161742; x=1733766542;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Silq42UH4To1Gt4GvCl6hpAR7/8HqGqcwmi/AXFy6go=;
 b=sCCeVJwlz6LzKGmELSpc+EY4AF5PvPmUfApcYvKdPnZ0GIy4XKNoGETN4SNbo7oiiH
 rXDphmSsHRbv4+KmVZSpjscfnlihFFYAZTccGm901O4PGSTaLURWXyYFsE7UyLRDsnwo
 2Ma4OFc+VQ2omhqs2t0bshSyQJgDj8BoTSd6ABpGBz/vQhkMDKWDyLOOV8yCjNKWB0c4
 No0fPxSpnIugXzcF5it8mN3H6FDLAFqq9szkyGXcY0CCu2OW3SIyGwOYSThZkW5FUdn1
 //KjJd1sf5Bqzud4GNwKrKalkR8ySAhrw9zC1cnnAIM29awvaKbiptur0RLJd1D06x96
 cvJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhcFB7rIu8/jtchzLuXWx+d8RdhE3nCVLPcmglDJ57tdd5fSEAmwzanGwgSce02jQLk3KrhkdmQZKF@nongnu.org
X-Gm-Message-State: AOJu0YxxcBFolJnPejioykhl60vaW/oR4p+/vPzjP0NY0G9bE6t30ZZl
 HimHAvOpeh1gero8p7QnsOy7b5XypbA47lutOApfiWoFecTv1wypEoeo3gjXhA==
X-Gm-Gg: ASbGnctUh+TtLXETqEiHxwXCrMnnux2u3HmhVGgdBuxaONnNG6AlDW+McPS37i5/Req
 z/9MTKZdxp0860aFKsmjJnDqYIsC+fDGEpiqIpNtuAVNy6cgD951UY5Ki/emNad8EHcrHISKYR9
 bzwrsHQ4Y7Lmz+wPU4A4xLLbZbG7SQ8CHy/6nqlE0Q9s0gYbyO3DlqrXGB51a9kBmUYHewfkXrE
 lOXSMRzhH9JxtX1uHK7tpzc94Y126RQAmjVynjA70ct+XTLxz6cFxc=
X-Google-Smtp-Source: AGHT+IHRXjEKWOokm9Kfn0x5JQqbadfNUJo8W7n0ice/EkRWNQdmwd+TVmrRldgFUgNr81CxtYKjaw==
X-Received: by 2002:a17:902:ecc8:b0:215:2ecf:92ac with SMTP id
 d9443c01a7336-2152ecf9650mr251278405ad.30.1733161742180; 
 Mon, 02 Dec 2024 09:49:02 -0800 (PST)
Received: from [192.168.0.163] ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215219058b1sm80412285ad.74.2024.12.02.09.49.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:49:01 -0800 (PST)
Message-ID: <ca66e322-2dd3-4bee-9821-c38b3f3b36d0@gmail.com>
Date: Tue, 3 Dec 2024 01:48:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] vfio/igd: emulate BDSM in mmio bar0 for gen 6-10
 devices
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <C.Koehne@beckhoff.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "clg@redhat.com" <clg@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
 <20241201160938.44355-8-tomitamoeko@gmail.com>
 <483493629a375a9e35308527ffe0d8887b413111.camel@beckhoff.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <483493629a375a9e35308527ffe0d8887b413111.camel@beckhoff.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x642.google.com
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



On 12/2/24 17:44, Corvin Köhne wrote:
> On Mon, 2024-12-02 at 00:09 +0800, Tomita Moeko wrote:
>> ﻿CAUTION: External Email!!
>> A recent commit in i915 driver [1] claims the BDSM register at 0x1080c0
>> of mmio bar0 has been there since gen 6. Mirror this register to the 32
>> bit BDSM register at 0x5c in pci config space for gen6-10 devices.
>>
>> [1]
>> https://nospamproxywebp.beckhoff.com/enQsig/link?id=BAgAAAAi96BdMcJV7rkAAABy4L3Y-n1H4M5Erk3toZdMOmhFmc4HUpjw_YG-G4-GcwmVdS8wC_pUyKH6p7x9_O-6Hprvyv9mbbWh_j2w5E6zLArS3crC1154aEYTRFcrIBLPMIoEAv9iTERXE2XB0E260O3pkmmo1UJOMUhb_fI5OUT3-68jnkq4QwTNgbnwmbVRnL2AyAM1pjuZqoqP6GP9y5e6OgocW-BJp0QtHO3eP9NbqTufifAAMfKlU7ekAZLWfPzejtqwaw2
>>  
>>
>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>> ---
>>  hw/vfio/igd.c | 26 ++++++++++++++++++--------
>>  1 file changed, 18 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>> index 07700dce30..3fd822241d 100644
>> --- a/hw/vfio/igd.c
>> +++ b/hw/vfio/igd.c
>> @@ -482,7 +482,8 @@ static const MemoryRegionOps vfio_igd_quirk_mirror_##name = {           \
>>  };
>>  
>>  VFIO_IGD_QUIRK_MIRROR_REG(IGD_GMCH, ggc)
>> -VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm)
>> +VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM, bdsm)
>> +VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm64)
>>  
>>  void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>  {
>> @@ -506,7 +507,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>       * into MMIO space and read from MMIO space by the Windows driver.
>>       */
>>      gen = igd_gen(vdev);
>> -    if (gen < 11) {
>> +    if (gen < 6) {
> 
> This also causes the GGC register to be mirrored for gen 6 and later. Is this intended? If so, you
> should mention it in the commit message as well.

Yes, I linked the i915 patch in commit message.

>>          return;
>>      }
>>  
>> @@ -520,12 +521,21 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>                                          IGD_GGC_MMIO_OFFSET, &quirk->mem[0],
>>                                          1);
>>  
>> -    memory_region_init_io(&quirk->mem[1], OBJECT(vdev),
>> -                          &vfio_igd_quirk_mirror_bdsm, vdev,
>> -                          "vfio-igd-bdsm-quirk", 8);
>> -    memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
>> -                                        IGD_BDSM_MMIO_OFFSET, &quirk->mem[1],
>> -                                        1);
>> +    if (gen < 11) {
>> +        memory_region_init_io(&quirk->mem[1], OBJECT(vdev),
>> +                              &vfio_igd_quirk_mirror_bdsm, vdev,
>> +                              "vfio-igd-bdsm-quirk", 4);
>> +        memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
>> +                                            IGD_BDSM_MMIO_OFFSET,
>> +                                            &quirk->mem[1], 1);
>> +    } else {
>> +        memory_region_init_io(&quirk->mem[1], OBJECT(vdev),
>> +                              &vfio_igd_quirk_mirror_bdsm64, vdev,
>> +                              "vfio-igd-bdsm-quirk", 8);
>> +        memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
>> +                                            IGD_BDSM_MMIO_OFFSET,
>> +                                            &quirk->mem[1], 1);
>> +    }
>>  
>>      QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
>>  }
> 


