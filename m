Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13CDD7831C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIATf-000142-G6; Mon, 02 Dec 2024 12:44:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIATb-00013l-RG
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:44:52 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIATZ-0005Mw-Pa
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:44:51 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-215348d1977so35283165ad.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733161488; x=1733766288; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AgW7vOpPH+YH1w07+M0Vlec1fjUSEXmlHTO/LZveGEE=;
 b=hmkA4vuzjGkQmDH/HhXLl25aWTkuwz7l4vrileXfIcIwqFe5+0Xmiq47bstz9ASBpi
 Fp64Gs8ocoKXON6vVz2Zya8Uf8DN1UlFr9IkobaQlKte7AJUG4B/VUxjPGRsvi7Cy8h0
 qmJ5Mruiws7TJnCMzjVpO93jurJfewgvbMkKrqMMfCw9IZQeKx7YsmdHC0YCuzk7VUb+
 wNMqhqqCNsDWyEpaOQSo00GD208mkcOadI5sOdEFsT+Nnnhhoao69cTksN73diWSHcDS
 pViSChbXvOmIG3DU0E0Z4PYaPzKrdHl9+/AQamboYC3jM9toDHDSeeD0QxrLrBZqvBpy
 1B+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733161488; x=1733766288;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AgW7vOpPH+YH1w07+M0Vlec1fjUSEXmlHTO/LZveGEE=;
 b=u1K289gsOP+nJXJueerSmGw4PfKHuvryJWQ/sNwibjeKjAelgZ2KIxi2IRzuXq2ZtV
 0HDz82mpQzsBRUmQx/Mtgt0Mub4xh4A7LriqNkKM2kQfhyHY/D4Z6MCEi5hLx/agNPek
 3/OxVsVOZ7jv6n3XpqYob6cIFBpSZvvl34A0hrQNV37Ry5wKbCYOn5CzNr6QHLLYY6u4
 DZSL5WmybyyxZiAhEglJJSvPPe/8I1+iCkKi9v0Kc6Ec2xwwQ1ZBzvafo7l7IhymQdB+
 qaG2kLQ+yRh41pSciOFLbDFG4MYB4uVD1Zi/2iaU16+cQS6ZG4dmyP2eNlbYjxAoI/1V
 QvpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQlPeMIDPgafINFfLsV7yD4kgDvOjF4cwpHHWHxHp7ZKYBZQKC88QQdi6uuGrZf6B5cZpBZ3bfIQSE@nongnu.org
X-Gm-Message-State: AOJu0YywHSLtKtEFINz2apc3VPLutl0TfUWoWYY/entcL17na/WAcyqN
 6ThltChkw9YNI5QYOHoij8Fxycnfe/cYD+79W2ZfKcCUun2+FLw=
X-Gm-Gg: ASbGncuPs/dkff3wj1rAbD9x85W+4xfzMPpXhTMZv2XErkvcwwkLD5uHC38J+cWvbCq
 LdwVNzh8O0BGsuvXmuAxZ/zzA+CjfIhuawczx9VD+oOeRLQmlgV26F/h2ov4gDabX93X49EO/cd
 piigFe1vYr+HCiRAeidIYV7uPKV7fmamRQILWOnuJu1R76YHV8hgUZXj/hcLqy6oBl3YM28lp6Q
 aqEBrVxxAGg11wg3i/YOx/jOSjkHqUROESKfRaDZSORSz0fo+p6cKE=
X-Google-Smtp-Source: AGHT+IFT9+EMGmMGzjafiNerYzmwvx7CxHhYmjrNs4YDTE/fraB2vbgYDx0/OBxX6fWon8fbghF2rw==
X-Received: by 2002:a17:902:ce8b:b0:215:9d58:6f35 with SMTP id
 d9443c01a7336-2159d5870d7mr60554325ad.1.1733161488082; 
 Mon, 02 Dec 2024 09:44:48 -0800 (PST)
Received: from [192.168.0.163] ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2154e33e47dsm53813895ad.158.2024.12.02.09.44.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:44:47 -0800 (PST)
Message-ID: <a5397791-2ad4-4c4b-98e4-17a19f5b5c1a@gmail.com>
Date: Tue, 3 Dec 2024 01:44:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] vfio/igd: emulate GGC register in mmio bar0
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <C.Koehne@beckhoff.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "clg@redhat.com" <clg@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
 <20241201160938.44355-7-tomitamoeko@gmail.com>
 <d4fe2b7a0618a59f945f7c47d50b414138ece218.camel@beckhoff.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <d4fe2b7a0618a59f945f7c47d50b414138ece218.camel@beckhoff.com>
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

On 12/2/24 17:39, Corvin Köhne wrote:
> On Mon, 2024-12-02 at 00:09 +0800, Tomita Moeko wrote:
>> ﻿CAUTION: External Email!!
>> The GGC register at 0x50 of pci config space is a mirror of the same
>> register at 0x108040 of mmio bar0 [1]. i915 driver also reads that
>> register from mmio bar0 instead of config space. As GGC is programmed
>> and emulated by qemu, the mmio address should also be emulated, in the
>> same way of BDSM register.
>>
>> A macro is defined to simplify the declaration of MemoryRegionOps for
>> a register mirrored to pcie config space.
>>
>> [1] 4.1.28, 12th Generation Intel Core Processors Datasheet Volume 2
>>     https://www.intel.com/content/www/us/en/content-details/655259
>>
>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>> ---
>>  hw/vfio/igd.c | 67 ++++++++++++++++++++++++++++++++-------------------
>>  1 file changed, 42 insertions(+), 25 deletions(-)
>>
>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>> index a86faf2fa9..07700dce30 100644
>> --- a/hw/vfio/igd.c
>> +++ b/hw/vfio/igd.c
>> @@ -415,16 +415,9 @@ static const MemoryRegionOps vfio_igd_index_quirk = {
>>      .endianness = DEVICE_LITTLE_ENDIAN,
>>  };
>>  
>> -#define IGD_BDSM_MMIO_OFFSET 0x1080C0
>> -
>> -static uint64_t vfio_igd_quirk_bdsm_read(void *opaque,
>> -                                          hwaddr addr, unsigned size)
>> +static uint64_t vfio_igd_pci_config_read(VFIOPCIDevice *vdev, uint64_t offset,
>> +                                         unsigned size)
>>  {
>> -    VFIOPCIDevice *vdev = opaque;
>> -    uint64_t offset;
>> -
>> -    offset = IGD_BDSM_GEN11 + addr;
>> -
>>      switch (size) {
>>      case 1:
>>          return pci_get_byte(vdev->pdev.config + offset);
>> @@ -442,14 +435,12 @@ static uint64_t vfio_igd_quirk_bdsm_read(void *opaque,
>>      return 0;
>>  }
>>  
>> -static void vfio_igd_quirk_bdsm_write(void *opaque, hwaddr addr,
>> -                                       uint64_t data, unsigned size)
>> -{
>> -    VFIOPCIDevice *vdev = opaque;
>> -    uint64_t offset;
>> -
>> -    offset = IGD_BDSM_GEN11 + addr;
>> +#define IGD_GGC_MMIO_OFFSET     0x108040
>> +#define IGD_BDSM_MMIO_OFFSET    0x1080C0
>>  
> 
> While already moving this down, I would move it even more down in front of vfio_probe_igd_bar0_quirk
> to the place where it's actually used.

Will move it right above vfio_probe_igd_bar0_quirk()

>> +static void vfio_igd_pci_config_write(VFIOPCIDevice *vdev, uint64_t offset,
>> +                                      uint64_t data, unsigned size)
>> +{
>>      switch (size) {
>>      case 1:
>>          pci_set_byte(vdev->pdev.config + offset, data);
>> @@ -464,17 +455,35 @@ static void vfio_igd_quirk_bdsm_write(void *opaque, hwaddr addr,
>>          pci_set_quad(vdev->pdev.config + offset, data);
>>          break;
>>      default:
>> -        hw_error("igd: unsupported read size, %u bytes", size);
>> +        hw_error("igd: unsupported write size, %u bytes", size);
> 
> It would make sense to log the faulting address too.

Good catch

>>          break;
>>      }
>>  }
>>  
>> -static const MemoryRegionOps vfio_igd_bdsm_quirk = {
>> -    .read = vfio_igd_quirk_bdsm_read,
>> -    .write = vfio_igd_quirk_bdsm_write,
>> -    .endianness = DEVICE_LITTLE_ENDIAN,
>> +#define VFIO_IGD_QUIRK_MIRROR_REG(reg, name)                            \
>> +static uint64_t vfio_igd_quirk_read_##name(void *opaque,                \
>> +                                           hwaddr addr, unsigned size)  \
>> +{                                                                       \
>> +    VFIOPCIDevice *vdev = opaque;                                       \
>> +    return vfio_igd_pci_config_read(vdev, reg + addr, size);            \
>> +}                                                                       \
>> +                                                                        \
>> +static void vfio_igd_quirk_write_##name(void *opaque, hwaddr addr,      \
>> +                                        uint64_t data, unsigned size)   \
>> +{                                                                       \
>> +    VFIOPCIDevice *vdev = opaque;                                       \
>> +    vfio_igd_pci_config_write(vdev, reg + addr, data, size);            \
>> +}                                                                       \
>> +                                                                        \
>> +static const MemoryRegionOps vfio_igd_quirk_mirror_##name = {           \
>> +    .read = vfio_igd_quirk_read_##name,                                 \
>> +    .write = vfio_igd_quirk_write_##name,                               \
>> +    .endianness = DEVICE_LITTLE_ENDIAN,                                 \
>>  };
>>  
>> +VFIO_IGD_QUIRK_MIRROR_REG(IGD_GMCH, ggc)
>> +VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm)
>> +
>>  void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>  {
>>      VFIOQuirk *quirk;
>> @@ -501,13 +510,21 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>          return;
>>      }
>>  
>> -    quirk = vfio_quirk_alloc(1);
>> +    quirk = vfio_quirk_alloc(2);
>>      quirk->data = vdev;
>>  
>> -    memory_region_init_io(&quirk->mem[0], OBJECT(vdev), &vfio_igd_bdsm_quirk,
>> -                          vdev, "vfio-igd-bdsm-quirk", 8);
>> +    memory_region_init_io(&quirk->mem[0], OBJECT(vdev),
>> +                          &vfio_igd_quirk_mirror_ggc, vdev,
>> +                          "vfio-igd-ggc-quirk", 2);
>> +    memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
>> +                                        IGD_GGC_MMIO_OFFSET, &quirk->mem[0],
>> +                                        1);
>> +
>> +    memory_region_init_io(&quirk->mem[1], OBJECT(vdev),
>> +                          &vfio_igd_quirk_mirror_bdsm, vdev,
>> +                          "vfio-igd-bdsm-quirk", 8);
>>      memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
>> -                                        IGD_BDSM_MMIO_OFFSET, &quirk->mem[0],
>> +                                        IGD_BDSM_MMIO_OFFSET, &quirk->mem[1],
>>                                          1);
>>  
>>      QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
> 
> I slightly prefer splitting this patch into two. The first one adding a new macro for mirroring
> register and the second one adding the GGC mirror. However, that's just my personal preference.
> 

Will split them in v2.


