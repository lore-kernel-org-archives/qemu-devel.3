Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF819CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 16:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utTeY-0006VS-AL; Tue, 02 Sep 2025 12:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utTeX-0006UY-28
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 12:14:37 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utTeS-0004Fr-WF
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 12:14:36 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3dad6252eacso373247f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 09:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756829671; x=1757434471; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eW+12qCrcPrN+OPJaqlK+6NfPmMuFq/pqvCxdNwJLVU=;
 b=Izu+uSfYw8o6CORaW4iyLXtrERaK6tfaAQJ0thS7tca+RpP+VNmYtK3XQFqc06urIP
 al7Ph0oTBr4EZz8MNAYv6o0uyqVwYNecr72Mq8ypRhPkJ/Evb7ooEXTtOh+7aWbEbECK
 nK5Z4CWoGPh1fLMVhkWQefkkz48M+YDEuyUgoeAEz5TMuh95IhWPSJRy4w99a7CSAYxa
 HqWtAEHPKOjQXec5BrBc/EMS+/q1GZMweopFEbEq/0dxX7HOctkbBZfna24ykVkNr6L6
 nyl0nheKfAt04YWlMEZeoc+wgK/PX5LMy0mx9JJMUMKwKNNiXreihnWUo4oXZfRO0wMG
 rcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756829671; x=1757434471;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eW+12qCrcPrN+OPJaqlK+6NfPmMuFq/pqvCxdNwJLVU=;
 b=S0gMrFq7fXMsZTx1z/VQ9yuINOdJam1rSreHMdAPKJOFWXa1I7TZ6ylR1CLh2ihM5W
 CotFKu8lDV6EymwvywHTzdVM25dPDtrAAIfzdmEzc7kPyVGYzGHSqD/hx6Jg9ggxTo6S
 ns6kxFNbikwfI1vPfFU8oEnpR0dB6wkF8PPtokQm5dBCb0RpT1baOboYrk4kI3HcU4+C
 Pvzw+UeHYOJaKUmLYOGXkE0Lu7NF9eJ+ZmZPtoQnQHGCJ4aecoq19S2rvp7sNHbGv3fm
 lfkphfmTpZbxTYyjFXedZYuYwuAon4Rs+GDWyQvokctkNkpWBvCbIMo/2hb7wuDplyDL
 +aGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlvXilm5+v5JNLixqcJBGiMhEf1CcenD4XsZPkzKfTHCckpZjgGEHzfYiC0WRXQnH5E3+Dph0U4L69@nongnu.org
X-Gm-Message-State: AOJu0YwT+J4E8opGjFLNRU7fc/2mBmOnABAeqgMCi0cD/slnhkVLIzJf
 14h0d0yCN1jUDZMl3dYaVTS8x0W9Onayclmvy77PltkU0OUwVa8CF0rsqXqtGibDxBs=
X-Gm-Gg: ASbGncuGLzPhowFo4X91s2LQ7Ii8bmQtS28oiV/j622I55GKyIIVYAPmopTQ+IREYa2
 BTaJj8af7wdSk2xefkGAHcX8QbCCrQ1Lc/6l1+prix1V7mwRKIZpNnlkIYikFjWsdOHmwLMS8te
 E3VbpZiLeZIGqAC7eMqfMZPHZZAMGl5sTg+faInX5IsrEptG0UE9L+9IjTeIDpDfluW3hiY9za4
 pWsJIgzs/KGcswu9IVreG4TsfgWaDY4kK4iFlGjCJ3eMNS4Bw5O6KzRdOLtFDNeskRZjDScnTDi
 ef0UQ0/X+z8LrVDp3Mx9FWCAbC1FGBgi2RP2wC2KK46GaJkncsmKxksFGne8NAldAnNfl3GQDkC
 v4h/s92q2yUQf7fh6/lxxzhkZDxdeFEztaRnSk0w4QKQ/mGOx98+2N9bMbzFIKqujmnJdogHUXW
 U+
X-Google-Smtp-Source: AGHT+IE9aTmlgWHQL6kNFIcJyg//et0ry36gmj7VV1QI6gCK5gVzqZ6TVuVazeLYfN4rdAGjfc+yEQ==
X-Received: by 2002:a05:6000:310f:b0:3cd:4277:d253 with SMTP id
 ffacd0b85a97d-3d1df34d733mr7879100f8f.57.1756829671029; 
 Tue, 02 Sep 2025 09:14:31 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e7fec07sm198599195e9.10.2025.09.02.09.14.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 09:14:27 -0700 (PDT)
Message-ID: <42310bdb-4fad-4df2-b7ad-3ff3f863e248@linaro.org>
Date: Tue, 2 Sep 2025 18:14:26 +0200
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
 <03a51e36-9a15-4b49-a310-c36a4d0af360@linaro.org>
 <2abbaeda-f9dc-4045-a9f7-b2b48451255f@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2abbaeda-f9dc-4045-a9f7-b2b48451255f@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/9/25 18:00, Cédric Le Goater wrote:
> On 9/2/25 17:55, Philippe Mathieu-Daudé wrote:
>> On 2/9/25 17:47, Cédric Le Goater wrote:
>>> On 9/2/25 17:45, Philippe Mathieu-Daudé wrote:
>>>> On 2/9/25 17:43, Philippe Mathieu-Daudé wrote:
>>>>> On 2/9/25 17:34, Jan Kiszka wrote:
>>>>>> On 02.09.25 17:06, Philippe Mathieu-Daudé wrote:
>>>>>>> On 1/9/25 07:56, Jan Kiszka wrote:
>>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>
>>>>>>>> The power-of-2 rule applies to the user data area, not the complete
>>>>>>>> block image. The latter can be concatenation of boot partition 
>>>>>>>> images
>>>>>>>> and the user data.
>>>>>>>>
>>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>>>> ---
>>>>>>>>    hw/sd/sd.c | 2 +-
>>>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>>>>>>> index 8c290595f0..16aee210b4 100644
>>>>>>>> --- a/hw/sd/sd.c
>>>>>>>> +++ b/hw/sd/sd.c
>>>>>>>> @@ -2789,7 +2789,7 @@ static void sd_realize(DeviceState *dev, 
>>>>>>>> Error
>>>>>>>> **errp)
>>>>>>>>                return;
>>>>>>>>            }
>>>>>>>>    -        blk_size = blk_getlength(sd->blk);
>>>>>>>> +        blk_size = blk_getlength(sd->blk) - sd->boot_part_size 
>>>>>>>> * 2;
>>>>>>>>            if (blk_size > 0 && !is_power_of_2(blk_size)) {
>>>>>>>>                int64_t blk_size_aligned = pow2ceil(blk_size);
>>>>>>>>                char *blk_size_str;
>>>>>>>
>>>>>>> This seems to break the tests/functional/arm/test_aspeed_rainier.py
>>>>>>> test due to mmc-p10bmc-20240617.qcow2 size:
>>>>>>>
>>>>>>> Command: /builds/qemu-project/qemu/build/qemu-system-arm -display 
>>>>>>> none -
>>>>>>> vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -
>>>>>>> machine rainier-bmc -chardev socket,id=console,fd=10 -serial
>>>>>>> chardev:console -drive file=/builds/qemu-project/qemu/functional- 
>>>>>>> cache/
>>>>>>> download/
>>>>>>> d523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b,if=sd,id=sd2,index=2 -net nic -net user -snapshot
>>>>>>> Output: qemu-system-arm: Invalid SD card size: 16 GiB
>>>>>>> SD card size has to be a power of 2, e.g. 16 GiB.
>>>>>>>
>>>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/11217561316
>>>>>>>
>>>>>>
>>>>>> Hmm, then the test was always wrong as well. I suspect the aspeed is
>>>>>> enabling boot partitions by default, and the image was created to 
>>>>>> pass
>>>>>> the wrong alignment check. Where / by whom is the image maintained?
>>>>>
>>>>> Cédric Le Goater (Cc'ed).
>>>>>
>>>>> The test comes from:
>>>>> https://lore.kernel.org/qemu-devel/4d1777d6-0195-4ecb- 
>>>>> a85f-09964268533d@kaod.org/
>>>>>
>>>>> Maybe also relevant to your suspicion:
>>>>> https://lore.kernel.org/qemu-devel/e401d119-402e-0edd- 
>>>>> c2bf-28950ba48ccb@kaod.org/

[*]

>>>>
>>>> Digging further:
>>>> https://lore.kernel.org/qemu- 
>>>> devel/9046a4327336d4425f1e7e7a973edef9e9948e80.camel@pengutronix.de/
>>>>
>>>
>>> yes commit c078298301a8 might have some impact there.
>>
>> With Jan patch, your script doesn't need anymore the
>>
>>    echo "Fixing size to keep qemu happy..."
>>
>> kludge.
> 
> which script ?

The one you pasted in [*]:

--
#!/bin/sh

URLBASE=https://jenkins.openbmc.org/view/latest/job/latest-master/label=docker-builder,target=witherspoon-tacoma/lastSuccessfulBuild/artifact/openbmc/build/tmp/deploy/images/witherspoon-tacoma/

IMAGESIZE=128
OUTFILE=mmc.img

FILES="u-boot.bin u-boot-spl.bin 
obmc-phosphor-image-witherspoon-tacoma.wic.xz"

for file in ${FILES}; do

	if test -f ${file}; then
		echo "${file}: Already downloaded"
	else
		echo "${file}: Downloading"
		wget -nv ${URLBASE}/${file}
	fi
done

echo

echo "Creating empty image..."
dd status=none if=/dev/zero of=${OUTFILE} bs=1M count=${IMAGESIZE}
echo "Adding SPL..."
dd status=none if=u-boot-spl.bin of=${OUTFILE} conv=notrunc
echo "Adding u-boot..."
dd status=none if=u-boot.bin of=${OUTFILE} conv=notrunc bs=1K seek=64
echo "Adding userdata..."
unxz -c obmc-phosphor-image-witherspoon-tacoma.wic.xz | dd 
status=progress of=${OUTFILE} conv=notrunc bs=1M seek=2
echo "Fixing size to keep qemu happy..."
truncate --size 16G ${OUTFILE}

echo "Done!"
echo
echo " qemu-system-arm -M tacoma-bmc -nographic -drive 
file=mmc.img,if=sd,index=2,format=raw"
---

