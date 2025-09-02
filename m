Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C099CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 15:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utTMh-0000bS-NV; Tue, 02 Sep 2025 11:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utTMX-0000U1-WC
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 11:56:04 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utTMU-0000u4-LQ
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 11:56:00 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45b8b8d45b3so22173885e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 08:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756828556; x=1757433356; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aumluLao06HPHxsnlJEB0MGe8/kLO8/7Fr6H7vMw33g=;
 b=bX3quFErH11WoS4pPlFbeRkSkG49J4sD/Y3GJ+9oQNI/2ALuVWgJB7sgwMpnU3HVHs
 wfEBbv5RPYmQ/XqcEuJSVMsbPp+hfH7D2ZNFjO9oDXrxGXwCyKgjP93MFThB5t3MnNe5
 xSBHQbtwS0CsxGrFnv+z7BR8QnZ6gr0D82r3xFjecRU77VvU/c3TMs2bFMbeYL6Ic3rD
 pH5kiOxWSKNGEUxLIsBvurnF8FTzEJZsk4bWwL+2AFItqqBpDDIxW/o8wM+sWz8UpDUy
 9khZXkGtOnagK49fyPpPXH4BHB59lEuU9xHT9yWJoMB10yyLlDHoulGQ0i7BGj/SXKoF
 SHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756828556; x=1757433356;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aumluLao06HPHxsnlJEB0MGe8/kLO8/7Fr6H7vMw33g=;
 b=kpfiz+wIJxQ2Z2H8eErSQ32h6tnZTPdmQGVapr6B1M19ankSIKiKpt1mQNsSIc98aH
 ujuOlEBmOTu4WC8tQad+MexG4CFrukcwKiBacbBAt9HPo/RSR7jLQ7Gc9Z2ju+OKwqjs
 pPasahPI1gOSkoFMivNBy9/hN+7H7CpIjw0E6ZtoDPRRlRX78/du3SntepgIlQ5zr85S
 wLMhJrOd8u1i5cmqRakOqGjR6S4L0DBlz7U+/YMYNZBRKmmzPb/Zp+Tlp2o8NoPrOejl
 gAVQ7k20ce2RxDruYAkk4OXzBBnPAyga/zhw6le5W2NwysvmMdU2Kn/zk5ZnvLERmMgZ
 S2dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmGY1eo5+iZMCwFjrlLtfxBdy6zqP+NneH/plBaBGbGOo+Mg6ophxEUbOod4Sn5OoedzTNynq4AViF@nongnu.org
X-Gm-Message-State: AOJu0YyfKG5YNL0HsGOiTVLfXeZAuj+BYx6MD59Rn3Q2kA+Ssq82/l0J
 +EeSBGiMKdEejFFZVLtHXCOyU3MQuBSZNkatT7OYFhGAdsVYCOtk2eBIxRenbct3eukFSG3QbbK
 dXvcs
X-Gm-Gg: ASbGncshtafVTXKnZhJpQ7WnqHLWTSjMEALgN+b+bSRHziJ90tZLzVAMW7cZllneT7U
 VzFRDpQtOl4IMN/NP5NlQKzGpzEsnaQ5irZ01l/l+C/Fd4n+OmyhYNzV4Qc1OPzpw4OQgSfqFxi
 JROVBXDjLR1wdxiGZFIjktR2ptA1f6E062DW8DG4oH254/ftHucd6rKE+KSw62Rj8EA1crM92rV
 zwJ1+bklx7bLR++1nPKwR6zWiuY6PCUrHTwRe+7juqHBeubu/5AUjUVfgTjjcSZi+XKd+qaCvOB
 oK56BjzISZAFB2eiWnzInSRWs4m/GX38nbmmvpA6KQRhFgfzXxK2zQZzvH5eV+sQ9setBCAJpIg
 2mnw/DFuoI+pLgrguiF1q77VotUvEh2yV+UtJloPk49YN63fzh2CcToIaURA3vJj9bQ==
X-Google-Smtp-Source: AGHT+IGkAmncDVsYxLGE3caeldUHww7Fzi+IwKSus3u6ubppUV1lns6p42z3CdAwWfvTcH96XFVAdQ==
X-Received: by 2002:a5d:5846:0:b0:3cf:3f1:accb with SMTP id
 ffacd0b85a97d-3d1df72f5bamr8972952f8f.61.1756828556158; 
 Tue, 02 Sep 2025 08:55:56 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3da13041bcasm3890768f8f.35.2025.09.02.08.55.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 08:55:55 -0700 (PDT)
Message-ID: <03a51e36-9a15-4b49-a310-c36a4d0af360@linaro.org>
Date: Tue, 2 Sep 2025 17:55:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hw/sd/sdcard: Fix size check for backing block
 image
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?SmFuIEzDvGJiZSI=?= <jlu@pengutronix.de>,
 Joel Stanley <joel@jms.id.au>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>
References: <cover.1756706188.git.jan.kiszka@siemens.com>
 <86217712232abd5152e7dfa98111f57b9b78d83b.1756706188.git.jan.kiszka@siemens.com>
 <6289fe04-82be-4a34-9fed-b0cc08e3b8f0@linaro.org>
 <a9fdf524-0ca1-45db-be39-7bfccc468f0f@siemens.com>
 <11808e86-cee0-48bf-8fbd-de13a9a25ed0@linaro.org>
 <4c039b3c-dc2c-4478-b1bb-90b925e56245@linaro.org>
 <c8e1a073-7702-4bad-b7f1-2b4f51da47f4@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c8e1a073-7702-4bad-b7f1-2b4f51da47f4@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 2/9/25 17:47, Cédric Le Goater wrote:
> On 9/2/25 17:45, Philippe Mathieu-Daudé wrote:
>> On 2/9/25 17:43, Philippe Mathieu-Daudé wrote:
>>> On 2/9/25 17:34, Jan Kiszka wrote:
>>>> On 02.09.25 17:06, Philippe Mathieu-Daudé wrote:
>>>>> On 1/9/25 07:56, Jan Kiszka wrote:
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> The power-of-2 rule applies to the user data area, not the complete
>>>>>> block image. The latter can be concatenation of boot partition images
>>>>>> and the user data.
>>>>>>
>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> ---
>>>>>>    hw/sd/sd.c | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>>>>> index 8c290595f0..16aee210b4 100644
>>>>>> --- a/hw/sd/sd.c
>>>>>> +++ b/hw/sd/sd.c
>>>>>> @@ -2789,7 +2789,7 @@ static void sd_realize(DeviceState *dev, Error
>>>>>> **errp)
>>>>>>                return;
>>>>>>            }
>>>>>>    -        blk_size = blk_getlength(sd->blk);
>>>>>> +        blk_size = blk_getlength(sd->blk) - sd->boot_part_size * 2;
>>>>>>            if (blk_size > 0 && !is_power_of_2(blk_size)) {
>>>>>>                int64_t blk_size_aligned = pow2ceil(blk_size);
>>>>>>                char *blk_size_str;
>>>>>
>>>>> This seems to break the tests/functional/arm/test_aspeed_rainier.py
>>>>> test due to mmc-p10bmc-20240617.qcow2 size:
>>>>>
>>>>> Command: /builds/qemu-project/qemu/build/qemu-system-arm -display 
>>>>> none -
>>>>> vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -
>>>>> machine rainier-bmc -chardev socket,id=console,fd=10 -serial
>>>>> chardev:console -drive file=/builds/qemu-project/qemu/functional- 
>>>>> cache/
>>>>> download/
>>>>> d523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b,if=sd,id=sd2,index=2 -net nic -net user -snapshot
>>>>> Output: qemu-system-arm: Invalid SD card size: 16 GiB
>>>>> SD card size has to be a power of 2, e.g. 16 GiB.
>>>>>
>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/11217561316
>>>>>
>>>>
>>>> Hmm, then the test was always wrong as well. I suspect the aspeed is
>>>> enabling boot partitions by default, and the image was created to pass
>>>> the wrong alignment check. Where / by whom is the image maintained?
>>>
>>> Cédric Le Goater (Cc'ed).
>>>
>>> The test comes from:
>>> https://lore.kernel.org/qemu-devel/4d1777d6-0195-4ecb- 
>>> a85f-09964268533d@kaod.org/
>>>
>>> Maybe also relevant to your suspicion:
>>> https://lore.kernel.org/qemu-devel/e401d119-402e-0edd- 
>>> c2bf-28950ba48ccb@kaod.org/
>>
>> Digging further:
>> https://lore.kernel.org/qemu- 
>> devel/9046a4327336d4425f1e7e7a973edef9e9948e80.camel@pengutronix.de/
>>
> 
> yes commit c078298301a8 might have some impact there.

With Jan patch, your script doesn't need anymore the

   echo "Fixing size to keep qemu happy..."

kludge.


