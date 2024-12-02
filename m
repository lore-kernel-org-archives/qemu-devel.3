Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1A6E69E82
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 18:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAtR-0008Lo-O4; Mon, 02 Dec 2024 13:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIAtQ-0008LT-E4
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 13:11:32 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIAtO-0004gD-8E
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 13:11:32 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-21568166415so17189335ad.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 10:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733163088; x=1733767888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I3ZdXvs0VzUrGWJT20O6Ep+wHnMXQP5EJfdF7Vv6R8U=;
 b=OHqArBYfDJtHXHIoXcIp57Jki5JxGFPe8fEB+Q9b130OFsNdPouU8ecDxBqolYwxoD
 xsdiYJ7hPEo0eM5mKtvT/nXNfZqUJ8CsBp3sdeRS8X1Kl2bxLbJsiKGEn7KrUD9KQasQ
 mXtCNTBCg/fqVgWC0LgE2uEJmYLcRUydm64fN8PaXwKNjezL/p6GitQnDqU5G9iHhJpL
 sCMvZqokYda77fIlpJMd85z950Av+BKAUX02bx4oAsnniAr1+PiWPPIFkZ7PPILxboVj
 cuYJopRWPel4thcog4Edxz+DAd3yoZor2OmjMwlGq8E4QhLV9qOCfY5g9xn98UVCP3py
 qtng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733163088; x=1733767888;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I3ZdXvs0VzUrGWJT20O6Ep+wHnMXQP5EJfdF7Vv6R8U=;
 b=opYZOg+rZnE8pAkhXS3tFCHlX77x+OjLM3fzE7IE1yvQ/2McHz+bZCtaOnmQsf9Xld
 mclDcw3Gqod2PIDWWSX6LM1EkT8UsDKuvZCHcYNBRKElOZOx9+IK8AU9aYsPm3Q25q5X
 iYNgtXMkXoszvlG468Y5fhdEOtBf89Q7uP9JOmlm46VbC3r6AwzloU6dq4vk7J6Dg6hK
 uXKZdYUBDMWImvBJBqTHMEyZPTN9VCK0UjQTT06yx/022Sp6QHe4BHF5+cwi05Nh+r56
 6SrdUM3ryuFcqbh1Mi47+l7pu1yXZebjCraUlxtPyBS70JyquOeuiZ6fJsay4tqDZjVc
 2HZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIqangL+kpB/ajFCQpKmw+SEDVBPFy2h7ngzkj20cjK5wFRMNn86FK7y+VwBo3Mh0sqqixyr1fW9s/@nongnu.org
X-Gm-Message-State: AOJu0Yz0eVIaXPvg63/aLKhNHTwGZ8kP0+sSRlazWBgEU5vFsw9mFgSq
 qfrW9UvpWAG3zdWx4sLfm1vH1vF4sftES2Nn7kYW9xr/vyRlook=
X-Gm-Gg: ASbGncs8PLeILA0SkVuLguhE30ZnxXAXxDhKS+OYeYqY+rLehc/oQLTCcTgnAaXQyGa
 DLx/bF/1OpZZNyrk4w1kw7cIMmS4iVyhXVQeTlHfnI+BO7Yp6cfpWzZiLst4rxafAnjGkMXon2j
 CYu2mcjM9Z0ZcpJFnnNpK3e/IhBbA9qQmEIcmEo6HZhiyysqsNGjmFVt9eSkQXhZVwJskouWSKR
 dlRugJp1JHSM6DnYu0/pA5iuwGm0fCrXQa/edBVj6cUrECFcvhRM+M=
X-Google-Smtp-Source: AGHT+IFplwnKBMnCzdA6Y5NQBNFbtIerDci/bI0Cjsd4X8VivPY6MPLV27Efv6LWAbNATs8iHJQ7Aw==
X-Received: by 2002:a17:903:2308:b0:215:5aba:7a8f with SMTP id
 d9443c01a7336-2155aba8f8amr172157555ad.46.1733163087620; 
 Mon, 02 Dec 2024 10:11:27 -0800 (PST)
Received: from [192.168.0.163] ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215a6fd6f57sm13373215ad.127.2024.12.02.10.11.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 10:11:27 -0800 (PST)
Message-ID: <5bd50f06-9c5d-4747-a793-43fad8400f50@gmail.com>
Date: Tue, 3 Dec 2024 02:11:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] vfio/igd: add x-igd-gms option back to set DSM region
 size for guest
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <C.Koehne@beckhoff.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "clg@redhat.com" <clg@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
 <20241201160938.44355-9-tomitamoeko@gmail.com>
 <352b53107d7d6666f7d307afebb81da744690e2f.camel@beckhoff.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <352b53107d7d6666f7d307afebb81da744690e2f.camel@beckhoff.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 12/2/24 17:48, Corvin Köhne wrote:
> On Mon, 2024-12-02 at 00:09 +0800, Tomita Moeko wrote:
>> ﻿CAUTION: External Email!!
>> DSM region is likely to store framebuffer in Windows, a small DSM
>> region may cause display issues (e.g. half of the screen is black).
>> By default, QEMU uses host's original value, which is determined by
>> DVMT Pre-Allocated option in Intel FSP of host bios. Some vendors
>> do not expose this config item to users. In such cases, x-igd-gms
>> option can be used to manually set the data stolen memory size for
>> guest.
>>
>> When DVMT Pre-Allocated option is available in host BIOS, user should
>> set DSM region size there instead of using x-igd-gms option.
>>
>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>> ---
>>  hw/vfio/igd.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>> index 3fd822241d..614223123b 100644
>> --- a/hw/vfio/igd.c
>> +++ b/hw/vfio/igd.c
>> @@ -712,6 +712,23 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>>  
>>      QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
>>  
>> +    /*
>> +     * Allow user to override dsm size using x-igd-gms option, in multiples of
>> +     * 32MiB. This option should only be used when the desired size cannot be
>> +     * set from DVMT Pre-Allocated option in host BIOS.
>> +     */
>> +    if (vdev->igd_gms) {
>> +        if (gen < 8 && vdev->igd_gms <= 0x10) {
>> +            gmch &= ~(IGD_GMCH_GEN6_GMS_MASK << IGD_GMCH_GEN6_GMS_SHIFT);
>> +            gmch |= vdev->igd_gms << IGD_GMCH_GEN6_GMS_SHIFT;
>> +        } else if (vdev->igd_gms <= 0x40) {
>> +            gmch &= ~(IGD_GMCH_GEN8_GMS_MASK << IGD_GMCH_GEN8_GMS_SHIFT);
>> +            gmch |= vdev->igd_gms << IGD_GMCH_GEN8_GMS_SHIFT;
>> +        } else {
>> +            error_report("Unsupported IGD GMS value 0x%x", vdev->igd_gms);
>> +        }
>> +    }
>> +
>>      ggms_size = igd_gtt_memory_size(gen, gmch);
>>      gms_size = igd_stolen_memory_size(gen, gmch);
>>  
> 
> As mentioned in my commit removing the x-igd-gms option, I've seen issues on Windows guest when
> setting a wrong gms value. I can try to recheck this.
> 

What's the windows GPU driver version you're using? I am using latest
32.0.101.6299. My DVMT Pre-allocated is 64M in BIOS. When using
default value, with a 4K display, strange behaviors were discovered
during my tests, like the lower half (actuall about 1/3) of the
screen is black, 3D mark only runs at 2560*1440 and the refresh rate
was limited to 30Hz.  Restarting guest won't fix this, but when I
forcefully set the GMS size in emulated GGC to 128M, these issue
disappears. That's why I suspect DSM may contain framebuffer.

Per my result, it seems windows guest is using the DSM as something
like dedicated VRAM, and GPU itself can handle guest physical address
internally.

The OVMF firmware I use is
https://github.com/tomitamoeko/edk2/commits/igd-pt-adl/
with GOP driver extracted from bios image from motherboard vendor.

I'm also wondering why the BAR4 quirks were implemented before, GTT
are not located in DSM, but in GGMS size below BDSM. This region is
inaccessible directly, reading it via /dev/mem immediately hangs the
system. The only way to access GTT is via MMIO BAR0.



