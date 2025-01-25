Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14A4C02182
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 05:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbZBt-0003aD-5j; Sat, 25 Jan 2025 00:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbZBm-0003Zy-Mt
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 00:58:40 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbZBk-0006hZ-No
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 00:58:38 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso49962895ad.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 21:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737784715; x=1738389515;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tiOy2Up1OghNNIIm7ZnI85sggsA6RBi30pZJ+3V1Txk=;
 b=b0qZ3o0pgTZsGXjXHoGKUvb6UwawbtkybwHfOGAg+Tr/RkGa/5MQqvCw/nil4h8Z1n
 R3HKx988/w7d52ZMSWpmxdFpmYMySmLISzVNAa6SWLGN3XrR8dOFuDjzWQjbizc5Be2s
 CsoZKRyyD3e3TX+BdUj6fURG0DeFQre/T4irt6WznCwDMsTzormBM1iekXtVqdBirykn
 Fjyjb02GgzL573RBFmfv1Mpsoqx47n7pUZocGpZdYxNxopEZUUGCnUCWoieGRpjJI7kY
 M1Hkf563JZlRfh8U339+SgDvmzmz8Ky/n04d7S6g3dYWHk/ojbw4OiB/lnKIzdYAvhuq
 s8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737784715; x=1738389515;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tiOy2Up1OghNNIIm7ZnI85sggsA6RBi30pZJ+3V1Txk=;
 b=e9InlTaIkiFeCahOIV1ZDZ0VswUBaDCRDOPWmSKxxeNPePJbRooVj42cUE5fQDyP1v
 mOd3GrpDDsqknNmwBT9WrheWa8tBSc8ZWYYgADFCHmKDoze0t+jxex1h9qgblQ90e0i0
 kdCEzBkSyIYEk9H+rXxWQt7y8uGF1I3FoUUQy9CxYOq1cLNeP/21nKYXUdOa0ey2tZpQ
 wt8LoAjB9ECbb1cENnrvkzuV2Of1REwQ/f2UBD2J9eVPJYVxk7w9TJ3PXOaYQttc02qo
 x48L/+xBY/4KkO1+LGHOfkHFYLshl/ycqvxc0gIp3/YveDPfcOiZnYJBmqkMLcgirW6N
 YGSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnDmRcdDlrpJCRmnWC/CGGRduY/3ojNJ+AqpPBXAoyFGcYJ6cwFI3OSsGBmLphr+ndFtafeQfuTH+k@nongnu.org
X-Gm-Message-State: AOJu0Yz8/XRhJcsz6YjwGCHOHdHTd5bz68sqCzhe2KcSOpsvOl4GL4W4
 eRuBGD2N0VxYhz/nrTqG5GQGdYRnIU6iywn7eicu1yTK+5q5cUsrgYuIEz2ng20=
X-Gm-Gg: ASbGncsXb26lcULbD5OllaDlMVYfl3ZFloGfPUPK0KKw4JRh9ht54GcLkHendWGBjyx
 ReWLrTw1LdrFGebACBn7cFgx21oHCAnbynEQslMLbKQWKjppVWQWVekRE5/PboXa59YBMQaTu6a
 5/ASr1UDbkferWBcrjvn4J/lhWncoyvnEzLsl5pi6ja9aPCMjVmP2fbmfQY13KVZY2XeTzQQYJL
 au93UIZdfBYsrGgW4uXqObwzXyEhyOM5B0CG56COcIc3TAkE7rqIbz8nqfwOftkGRXC1wWJgr0w
 aaXX5PJmbMdjMScYZA==
X-Google-Smtp-Source: AGHT+IGPWbV/t4lfsviAH5R+bZQTnbcK+RMetUU3QkgvxItedxlS2LwvHKXlJyZP4zbSFPqwtKSzrw==
X-Received: by 2002:a17:902:f544:b0:21a:5501:9d5 with SMTP id
 d9443c01a7336-21c355db07fmr564549485ad.44.1737784714604; 
 Fri, 24 Jan 2025 21:58:34 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3d9c5bfsm25929075ad.37.2025.01.24.21.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 21:58:34 -0800 (PST)
Message-ID: <b9116fa5-aafd-4dc8-8b31-86b079f1ad9c@daynix.com>
Date: Sat, 25 Jan 2025 14:58:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/6] coreaudio: Remove unnecessary explicit casts
To: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-devel@nongnu.org
Cc: devel@daynix.com
References: <20250124-coreaudio-v7-0-9d9a4d91db37@daynix.com>
 <20250124-coreaudio-v7-1-9d9a4d91db37@daynix.com> <4562400.zP1BOZzIia@silver>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <4562400.zP1BOZzIia@silver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2025/01/24 18:39, Christian Schoenebeck wrote:
> On Friday, January 24, 2025 6:12:04 AM CET Akihiko Odaki wrote:
>> coreaudio had unnecessary explicit casts and they had extra whitespaces
>> around them so remove them.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   audio/coreaudio.m | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
>> index cadd729d50537850d81718b9284efed5877d9185..0b67347ad7e8c43a77af308a1a3a654dd7084083 100644
>> --- a/audio/coreaudio.m
>> +++ b/audio/coreaudio.m
>> @@ -309,7 +309,7 @@ static OSStatus audioDeviceIOProc(
>>       UInt32 frameCount, pending_frames;
>>       void *out = outOutputData->mBuffers[0].mData;
>>       HWVoiceOut *hw = hwptr;
>> -    coreaudioVoiceOut *core = (coreaudioVoiceOut *) hwptr;
>> +    coreaudioVoiceOut *core = hwptr;
> 
> Well, hwptr is void*, so both versions are fine.
> 
> struct name 'coreaudioVoiceOut' should start with upper case BTW.
> 
>>       size_t len;
>>   
>>       if (coreaudio_buf_lock (core, "audioDeviceIOProc")) {
>> @@ -392,10 +392,10 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>>       }
>>   
>>       if (frameRange.mMinimum > core->frameSizeSetting) {
>> -        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
>> +        core->audioDevicePropertyBufferFrameSize = frameRange.mMinimum;
>>           dolog ("warning: Upsizing Buffer Frames to %f\n", frameRange.mMinimum);
>>       } else if (frameRange.mMaximum < core->frameSizeSetting) {
>> -        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
>> +        core->audioDevicePropertyBufferFrameSize = frameRange.mMaximum;
>>           dolog ("warning: Downsizing Buffer Frames to %f\n", frameRange.mMaximum);
>>       } else {
>>           core->audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
> 
> Those casts are actually necessary, as AudioValueRange's members are Float64
> (a.k.a. double) types.

Explicit casts are unnecessary. Implicit casts still happen at every 
line changed with this patch.

Regards,
Akihiko Odaki

