Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67142C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPm4-0001Vm-9I; Tue, 03 Jun 2025 07:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMPm1-0001VW-Uv
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:25:42 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMPly-0005N5-UE
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:25:41 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-450cd6b511cso33295155e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748949937; x=1749554737; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t6C5r8Rv/uiuRYIuj82sXfFDfh68iS/t54sxC6mo0xg=;
 b=EfMCuLVLmFhVQm7m8lWTeQfzIJMJ84Pme+YmBR/bpiKwHagAAsbw5I996xhW3E0ewa
 A2+OTwMzL7Nri8L/DBubf03BO16hB9V7IyUQIl9q1Rv8QXppZZo/shk8XZv+T1LHMz5v
 VgjH/HpnxIbotokCWOdxvqBXOLHokIiZnlhU5yIElGJkLhO1cAVSMT0VFayvcFistthI
 bsDUmjQ8PrAg3uXzYTOpyuYo9jwwLNt+QIeNFDljK68GhlCccqJJxwkTzyzMuEoz0TE9
 1TJsylWY1A6nQ1gogR4dSPVeoGR9lgg/DaPdgzIugfLnP4i22EKfT48uoLlksyce76kV
 zfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748949937; x=1749554737;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t6C5r8Rv/uiuRYIuj82sXfFDfh68iS/t54sxC6mo0xg=;
 b=R1u3nt6RlZ5Uv6Oddp/KHSBj8ijg0f5mLZtaamkKxIelPXGB5fVVwH3Vj2HGpSfYBC
 /JpQrirKucRnMHXN5xI3uMspc4/7anI2bbjOnwzYLheIzQFX8GKBZCS7k1QadO6DB76/
 CSHjjgvIYPFFXSHa5wsFHFVA3saRcBt5W3CydFEq0PRu8fKwp77oTMKM8iSEWWgrOkPB
 NwFIyK2YYlOAGVjAYI55GnCS1ID/1y6dq+iAKl6zGMDUNW+qCENiiClbUtNN6UVUtDO3
 zpAxoKWDbNxavPT5bxTiYfrULkBH35a/sajOSuTDhPDvIQ9iPsGjP9IQ9bm7SUSwq1wb
 gGCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWo+koiCoWaP+f4hNUMXEwHcx168KaUfJPP9aRyTNLWRSvYl8q8c1/W6gy3JS1OH5qVeXr/7suGEeN@nongnu.org
X-Gm-Message-State: AOJu0YwyTxHFFjcMU5/iXzp2j0MEubG/k4+J6St9YRR8cfFw2r7Pzigb
 4lOJ8du+TyVxKuyfWjzWpl8LoxnqP0/Cs7roSPzWIhWbF75WhmGQnp45BDLJfpIkyc4=
X-Gm-Gg: ASbGncuvkVogHQxG/XgtQt+UT2zf25CPiYZ4dNxY9BpXk7mXTtNbMFfrCku/CH4yyL+
 sD8sIulIcEkRzb4Jv1J8Oc+q6TAx+MbxMm/+CFu7IO3fNZwT6ZTjn0KPPcHy+Do59G+ESccx3Ov
 H472eUC5V8IcifzeIjs/KX2ueJRv2f6GKB0MPSqDGgpGCc5Y/bmh6s/vZVBzz+8nmdRSIC/3Fbo
 odwmJZqI7pIjC3C5YU4HzGQl+U/DA5b2PtiXKTQChMRAlce58vcbNn9E8bK96Zn/7jrv582reW/
 di3XQgU+PBnwAc37y5bX1TKGOXVe+1AwLOiuTy+MmFsfilMtDVL7U0cDHTkbx6c5fD1IPWVMt1F
 +8lHuPLT9B4R6+4YqpexHehHw
X-Google-Smtp-Source: AGHT+IGz958TiPD5GcQBnyYBh5FpQ3Hn65EThhxQvSs8rp84Riaps5IjYG2592u94IG7MJobEm7rkQ==
X-Received: by 2002:a05:600c:8509:b0:442:f4a3:b5f2 with SMTP id
 5b1f17b1804b1-450d64bdce8mr137542925e9.6.1748949936765; 
 Tue, 03 Jun 2025 04:25:36 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb8990sm161774315e9.32.2025.06.03.04.25.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 04:25:36 -0700 (PDT)
Message-ID: <13146e21-cf6e-489a-8d54-d6d2c02ca2f0@linaro.org>
Date: Tue, 3 Jun 2025 13:25:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 36/58] pc-bios: Move device tree files in their own subdir
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
References: <20250425152843.69638-1-philmd@linaro.org>
 <20250425152843.69638-37-philmd@linaro.org>
 <621F23F2-05FC-4C8C-8AA8-F61DED04B306@gmail.com>
 <83dcb220-dd06-fb7f-1960-432fb2696b60@eik.bme.hu>
 <0648af18-2e50-4eaa-96fb-b0e64eb706d9@linaro.org>
 <5e0bb98c-98cd-c9e6-4a74-d3d33dbe773d@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5e0bb98c-98cd-c9e6-4a74-d3d33dbe773d@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 2/6/25 13:56, BALATON Zoltan wrote:
> On Mon, 2 Jun 2025, Philippe Mathieu-Daudé wrote:
>> On 30/5/25 02:54, BALATON Zoltan wrote:
>>> On Thu, 29 May 2025, Bernhard Beschow wrote:
>>>> Am 25. April 2025 15:28:20 UTC schrieb "Philippe Mathieu-Daudé" 
>>>> <philmd@linaro.org>:
>>>>> From: BALATON Zoltan <balaton@eik.bme.hu>
>>>>>
>>>>> We have several device tree files already and may have more in the
>>>>> future so add a new dtb subdirectory and move device tree files there
>>>>> so they are not mixed with ROM binaries.
>>>>>
>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> Message-ID: 
>>>>> <57f179bd3904c1f2ca062ca4d4ff9592bb4f4daa.1745402140.git.balaton@eik.bme.hu>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>> MAINTAINERS                                |   2 +-
>>>>> system/datadir.c                           |   4 +++-
>>>>> pc-bios/{ => dtb}/bamboo.dtb               | Bin
>>>>> pc-bios/{ => dtb}/bamboo.dts               |   0
>>>>> pc-bios/{ => dtb}/canyonlands.dtb          | Bin
>>>>> pc-bios/{ => dtb}/canyonlands.dts          |   0
>>>>> pc-bios/dtb/meson.build                    |  23 +++++++++++++++++++++
>>>>> pc-bios/{ => dtb}/petalogix-ml605.dtb      | Bin
>>>>> pc-bios/{ => dtb}/petalogix-ml605.dts      |   0
>>>>> pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb | Bin
>>>>> pc-bios/{ => dtb}/petalogix-s3adsp1800.dts |   0
>>>>> pc-bios/meson.build                        |  23 +--------------------
>>>>> qemu.nsi                                   |   2 +-
>>>>> 13 files changed, 29 insertions(+), 25 deletions(-)
>>>>> rename pc-bios/{ => dtb}/bamboo.dtb (100%)
>>>>> rename pc-bios/{ => dtb}/bamboo.dts (100%)
>>>>> rename pc-bios/{ => dtb}/canyonlands.dtb (100%)
>>>>> rename pc-bios/{ => dtb}/canyonlands.dts (100%)
>>>>> create mode 100644 pc-bios/dtb/meson.build
>>>>> rename pc-bios/{ => dtb}/petalogix-ml605.dtb (100%)
>>>>> rename pc-bios/{ => dtb}/petalogix-ml605.dts (100%)
>>>>> rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb (100%)
>>>>> rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dts (100%)
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index 661a47db5ac..d82d962f1a4 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -1581,7 +1581,7 @@ F: hw/pci-host/ppc440_pcix.c
>>>>> F: hw/display/sm501*
>>>>> F: hw/ide/sii3112.c
>>>>> F: hw/rtc/m41t80.c
>>>>> -F: pc-bios/canyonlands.dt[sb]
>>>>> +F: pc-bios/dtb/canyonlands.dt[sb]
>>>>> F: pc-bios/u-boot-sam460ex-20100605.bin
>>>>> F: roms/u-boot-sam460ex
>>>>> F: docs/system/ppc/amigang.rst
>>>>> diff --git a/system/datadir.c b/system/datadir.c
>>>>> index e450b84ce91..f96f8fc2646 100644
>>>>> --- a/system/datadir.c
>>>>> +++ b/system/datadir.c
>>>>> @@ -44,9 +44,11 @@ char *qemu_find_file(QemuFileType type, const 
>>>>> char *name)
>>>>>
>>>>>     switch (type) {
>>>>>     case QEMU_FILE_TYPE_BIOS:
>>>>> -    case QEMU_FILE_TYPE_DTB:
>>>>>         subdir = "";
>>>>>         break;
>>>>> +    case QEMU_FILE_TYPE_DTB:
>>>>> +        subdir = "dtb/";
>>>>> +        break;
>>>>>     case QEMU_FILE_TYPE_KEYMAP:
>>>>>         subdir = "keymaps/";
>>>>>         break;
>>>>> diff --git a/pc-bios/bamboo.dtb b/pc-bios/dtb/bamboo.dtb
>>>>> similarity index 100%
>>>>> rename from pc-bios/bamboo.dtb
>>>>> rename to pc-bios/dtb/bamboo.dtb
>>>>> diff --git a/pc-bios/bamboo.dts b/pc-bios/dtb/bamboo.dts
>>>>> similarity index 100%
>>>>> rename from pc-bios/bamboo.dts
>>>>> rename to pc-bios/dtb/bamboo.dts
>>>>> diff --git a/pc-bios/canyonlands.dtb b/pc-bios/dtb/canyonlands.dtb
>>>>> similarity index 100%
>>>>> rename from pc-bios/canyonlands.dtb
>>>>> rename to pc-bios/dtb/canyonlands.dtb
>>>>> diff --git a/pc-bios/canyonlands.dts b/pc-bios/dtb/canyonlands.dts
>>>>> similarity index 100%
>>>>> rename from pc-bios/canyonlands.dts
>>>>> rename to pc-bios/dtb/canyonlands.dts
>>>>> diff --git a/pc-bios/dtb/meson.build b/pc-bios/dtb/meson.build
>>>>> new file mode 100644
>>>>> index 00000000000..7a71835bca7
>>>>> --- /dev/null
>>>>> +++ b/pc-bios/dtb/meson.build
>>>>> @@ -0,0 +1,23 @@
>>>>> +dtbs = [
>>>>> +  'bamboo.dtb',
>>>>> +  'canyonlands.dtb',
>>>>> +  'petalogix-ml605.dtb',
>>>>> +  'petalogix-s3adsp1800.dtb',
>>>>
>>>> Was it intended that the suffix changed from .dts to .dtb? This 
>>>> change isn't motivated in the commit message and usually source 
>>>> files rather than generated artifacts are listed in build files.
>>>
>>> I think I either found similar python code somewhere and followed 
>>> that because meson and python is not something I understand well. Or 
>>> changed it because we always need the list of dtbs to install but 
>>> only need the dts when compiling so this way we don't need another 
>>> list or replacing suffix twice.
>>
>> Should we revert?
> 
> Why? It works just lists the build targets instead of source files to 
> avoid converting between the two twice. So what it does was not 
> contested only the way it was implemented had a nit. I don't think this 
> is worth changing because of that.

Well, it is a hidden change that wasn't noticed during review.

