Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DD5CA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 15:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utTCe-0002Hv-NW; Tue, 02 Sep 2025 11:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utTCW-0002GH-UD
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 11:45:41 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utTCS-0007Il-Nq
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 11:45:39 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45b8b25296fso17458555e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756827931; x=1757432731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NPq4s1JeZK7RKse6LCL6VyNhppMu34Ld0R+zYTIxKZc=;
 b=FuF4ZBeeSX4r/9tC7toHEznyyHueyq73xRCGSDt4lJMfmeWYbIPy9vJ+lXrJn+wBqE
 4PkUU6yDFOHxdFz+NOS+noJ3QsITFbP51gny3oFruoA297vJEtu8sRZ1dAeabTfmA++8
 6uKTWIus7D2VlQWJNhXyFBYOutqaZusdKRHk+Vs6/gndkHDn1/MdSKh1UkM+8pU1go9X
 IIdu4yVok5vjfZ5qgHyGEV/PGcWvP5Uuc7DdNkpnJTyVgbEk6Aasv9Ut9Qv7Dpl9Nif9
 2U+ylCabGsvv0+DugnNHEupx8c4OYuz5W5Co++cNofdqwRWbr3gKvkbNBphn3w29sNr4
 Rnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756827931; x=1757432731;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NPq4s1JeZK7RKse6LCL6VyNhppMu34Ld0R+zYTIxKZc=;
 b=TyHjnpINTslcZVJ8037zzBdx98gIubWDc6qaAEa3qhoDRFs4mfPRUMX//fO44AyG/p
 brIABCUJmFiyR1ZphhR0sPCL8VjQxxaSTDUDka3fHExMbVJPqCXK/1yEMtsu1swM3Vcd
 9sMUi447+lLNv65EXoTV9W0cLASPXSASs2thTPP1bF8oZR1IqUdskHIOVYs9EZ5yABfc
 IKsdb1h1FRR+YGXHJibrPILH8SkYboAF8+47btPCfibZnKiuOCROVHRLp++2CTI2xyNq
 8kkvUF2iLsGEOEI+nGCF2TPCNnupoi6qpiO8amM7wUXUQScpSmamW2k1Ff9ieUpU1lGy
 rN/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8yLn3XhVTEWOwMgcC6k7e+dB3xRyoI68YBXzTbupCB+LEgaVk88MSbxUJKCLrW4IrTAGQXAR3Plhj@nongnu.org
X-Gm-Message-State: AOJu0YwRHly0u0FcxuCvPaqP2uc90oUwX2yrS3ghxkIt4zc8e9CLT9jp
 LO7EcG6YjEHpfHdWxt1v9Y8y5mQDeZpg5glrqlDNmo2HVkQbg8vzc711BGKFwa49MRo=
X-Gm-Gg: ASbGncsELO4t1gCnMZ980EkGqG4tmDRhvXTpEw8FkncLgNOAvbdZDjE8zAWdEPpVOjj
 VsIjIEv5rzCbPd4iDEt1ft4Ey6EjdmU+hHecf5SXkZSoECg7F5lnhSm5HlBvMKsMHvoc8w3fc7C
 yr14GXhihUrDRGZ2c8XO8XjYFhNC8igEnJfbF9e9ZUCzoso0t0dlvIpzGHUy35/DWogAxeETmbS
 0P/8aUGrj5uL+xt7WbkDhD5JvP21PyapN1SsJc8QFq8WyItUxtG2cMevwK2nKoKrAhQ7IqCzEEG
 r2do+Ahx2Ba4uNVCVXNh9Ik1KDwhywBBA6G8TwD+natyJnFJBMB6EvuL2F+oegD1dr4Cm9p1QyO
 RYQ8Ppj1/Qgj+BO0huri0pmex58XkbjOEGep/2mgXu6j9lh6hX4TzOx4NUQm2MpuRzMF0vZZLf1
 jT
X-Google-Smtp-Source: AGHT+IFkkEhbew3x0u3l1jzxfPP6K774etlOytw7cEdczK3LtSG43KwenN2pjQ2UTtvsY5bBPG8KzQ==
X-Received: by 2002:a05:600c:a46:b0:458:be62:dcd3 with SMTP id
 5b1f17b1804b1-45b8558a78cmr113495305e9.17.1756827931202; 
 Tue, 02 Sep 2025 08:45:31 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7df3ff72sm127685575e9.1.2025.09.02.08.45.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 08:45:30 -0700 (PDT)
Message-ID: <4c039b3c-dc2c-4478-b1bb-90b925e56245@linaro.org>
Date: Tue, 2 Sep 2025 17:45:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hw/sd/sdcard: Fix size check for backing block
 image
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?B?SmFuIEzDvGJiZSI=?= <jlu@pengutronix.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>
References: <cover.1756706188.git.jan.kiszka@siemens.com>
 <86217712232abd5152e7dfa98111f57b9b78d83b.1756706188.git.jan.kiszka@siemens.com>
 <6289fe04-82be-4a34-9fed-b0cc08e3b8f0@linaro.org>
 <a9fdf524-0ca1-45db-be39-7bfccc468f0f@siemens.com>
 <11808e86-cee0-48bf-8fbd-de13a9a25ed0@linaro.org>
Content-Language: en-US
In-Reply-To: <11808e86-cee0-48bf-8fbd-de13a9a25ed0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 2/9/25 17:43, Philippe Mathieu-Daudé wrote:
> On 2/9/25 17:34, Jan Kiszka wrote:
>> On 02.09.25 17:06, Philippe Mathieu-Daudé wrote:
>>> On 1/9/25 07:56, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> The power-of-2 rule applies to the user data area, not the complete
>>>> block image. The latter can be concatenation of boot partition images
>>>> and the user data.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>    hw/sd/sd.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>>> index 8c290595f0..16aee210b4 100644
>>>> --- a/hw/sd/sd.c
>>>> +++ b/hw/sd/sd.c
>>>> @@ -2789,7 +2789,7 @@ static void sd_realize(DeviceState *dev, Error
>>>> **errp)
>>>>                return;
>>>>            }
>>>>    -        blk_size = blk_getlength(sd->blk);
>>>> +        blk_size = blk_getlength(sd->blk) - sd->boot_part_size * 2;
>>>>            if (blk_size > 0 && !is_power_of_2(blk_size)) {
>>>>                int64_t blk_size_aligned = pow2ceil(blk_size);
>>>>                char *blk_size_str;
>>>
>>> This seems to break the tests/functional/arm/test_aspeed_rainier.py
>>> test due to mmc-p10bmc-20240617.qcow2 size:
>>>
>>> Command: /builds/qemu-project/qemu/build/qemu-system-arm -display none -
>>> vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -
>>> machine rainier-bmc -chardev socket,id=console,fd=10 -serial
>>> chardev:console -drive file=/builds/qemu-project/qemu/functional-cache/
>>> download/
>>> d523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b,if=sd,id=sd2,index=2 -net nic -net user -snapshot
>>> Output: qemu-system-arm: Invalid SD card size: 16 GiB
>>> SD card size has to be a power of 2, e.g. 16 GiB.
>>>
>>> https://gitlab.com/qemu-project/qemu/-/jobs/11217561316
>>>
>>
>> Hmm, then the test was always wrong as well. I suspect the aspeed is
>> enabling boot partitions by default, and the image was created to pass
>> the wrong alignment check. Where / by whom is the image maintained?
> 
> Cédric Le Goater (Cc'ed).
> 
> The test comes from:
> https://lore.kernel.org/qemu-devel/4d1777d6-0195-4ecb- 
> a85f-09964268533d@kaod.org/
> 
> Maybe also relevant to your suspicion:
> https://lore.kernel.org/qemu-devel/e401d119-402e-0edd- 
> c2bf-28950ba48ccb@kaod.org/

Digging further:
https://lore.kernel.org/qemu-devel/9046a4327336d4425f1e7e7a973edef9e9948e80.camel@pengutronix.de/


