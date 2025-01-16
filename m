Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D61FE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 05:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYIGS-0002b2-Ux; Thu, 16 Jan 2025 00:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYIGQ-0002ae-Df
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 00:17:54 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYIGO-0008L0-0J
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 00:17:54 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-216728b1836so7424195ad.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 21:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737004670; x=1737609470;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6WTYBja/ROQpINE1pruCF9q5giZUwVuf87b6XM7sOKs=;
 b=BK0p3ytntvkP2uW44xY+JFrcLJEIqBz4bCK0L9i0tGv/pntvBRBh3N81nmcFPZfpvr
 IXd4rPZyBmMIAQ0J5WjJo/LzuXPFKL+zdpCVmiD6p6VAzVnJp722N7CLDfICp+EIicwj
 35x1dZwgo1t9cDZiD44IhtDGZfgf4wYWs14z6jeh1m+MPNiV9w1bMtWd/y5Nymf0Yzh0
 y+dZSuUEhlAVVwlMWTHmWp/lYPptvoBog2SSYbauHnYtw7XaSqyLpa56FiKu/2evYZuu
 4GJVuJ1bhO29i3HM1bc3oyuWtJljGDuNAXpIYH2wBW36YLk5ORLM1X1pSERTrZMxieG6
 MNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737004670; x=1737609470;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6WTYBja/ROQpINE1pruCF9q5giZUwVuf87b6XM7sOKs=;
 b=J5JXAtjOMO01Ok6drcyKmJ02FeQZIeGUGDf/VtSPUxLYHhgwgioZ3Tz73BK7QS/NSY
 3osWbedov4Gt7bIPa9zNWroBLdbQSA+mzC/eFVDDL1G1uqAEBBIx/cLh0d6hVuDyvxqC
 bbAEvZ/XBNzUWkB4J5fng9lRpX0nPHfrR6kNQzTY9ZsPE/9t9axiER4p2c9Xe3Z2nZr3
 20JPPSOU9Kh+SEGTQW+9rauGTlqPSnYndltWqFqzih0ajZlt2IWgdfK0z9nE3QYRMtng
 c5bJhhBaPac1RLRVsVp6oMMoZSnbzVbPSDDdvCemCvj7rObPeGaj9yBUPRzgCqhKwx7/
 A86Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkPssGHwvcT+zO7TmU8IS0c/7df84hqsjSH0wMZ7pKq+p2kLe08SsWYdHWIM9UdtEIwGqHnOC8Uuao@nongnu.org
X-Gm-Message-State: AOJu0YwfAixEA4JhKhWyRw8qrduwRpxaQf3i3BT3PsU47DhfUt2nhWhW
 n/dlFbL0kXBZnpd8eTfYRmMbsCDY06bXb5llQKbULMUmX+LVRafg8d4QgQTVTVw=
X-Gm-Gg: ASbGncuWpTolGpUANeaJslHg3B1f+a16x0uSsdFuWGXbgcy59KZDL4I/KhxlXSI1FSt
 h7HgpnYS6tiOobfAdHVHi9iucaLHvvBgcMRyF+/8WmTvX0188yMo2rsgXuwlmiFOuc2n7jLKY35
 y0mLgGNwCkRne5/8K5qTiRt5euekj10iWUTNn+rVS6JKeUMwil3BSDNHRekRnhGIRq7r/AGb4op
 JiKxYsXfTPxsAw2DS9tOk+IsohppUhM4+T6V8xgq60jEXfeQfKdNmk5LlQZJQS0Qcw=
X-Google-Smtp-Source: AGHT+IFq1zuB61ZOAjgiUcjTUwUxr6itYvmDVifcCfgxgHrsDnryMMuv6XHVA1yxC9KgiFmoFSAFvw==
X-Received: by 2002:a05:6a00:1410:b0:725:db34:6a7d with SMTP id
 d2e1a72fcca58-72d21ff965emr48065684b3a.23.1737004669878; 
 Wed, 15 Jan 2025 21:17:49 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a31d5cafd25sm10639241a12.63.2025.01.15.21.17.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 21:17:49 -0800 (PST)
Message-ID: <7f183c25-2e70-4bc7-b3bb-0f488743f13e@daynix.com>
Date: Thu, 16 Jan 2025 14:17:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] coreaudio: Commit the result of init in the end
To: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: devel@daynix.com
References: <20250115-coreaudio-v3-0-bdb6bcb5bf9f@daynix.com>
 <2489919.FfEH3XSh6J@silver> <6383b75b-2dae-4777-a794-644d87b604fc@daynix.com>
 <7790509.UIITUpbOhM@silver>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <7790509.UIITUpbOhM@silver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/01/16 2:10, Christian Schoenebeck wrote:
> On Wednesday, January 15, 2025 4:37:28 PM CET Akihiko Odaki wrote:
>> On 2025/01/16 0:14, Christian Schoenebeck wrote:
>>> On Wednesday, January 15, 2025 1:06:55 PM CET Akihiko Odaki wrote:
>>>> init_out_device may only commit some part of the result and leave the
>>>> state inconsistent when it encounters an error. Commit the result in
>>>> the end of the function so that it commits the result iff it sees no
>>>
>>> Typo "if".
>>
>> I meant if and only if.
>>
>>>
>>>> error.
>>>>
>>>> With this change, handle_voice_change can rely on core->outputDeviceID
>>>> to know whether the output device is initialized after calling
>>>> init_out_device.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>    audio/coreaudio.m | 49 +++++++++++++++++++++++++++----------------------
>>>>    1 file changed, 27 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
>>>> index cadd729d5053..b9e1a952ed37 100644
>>>> --- a/audio/coreaudio.m
>>>> +++ b/audio/coreaudio.m
>>>> @@ -355,7 +355,10 @@ static OSStatus audioDeviceIOProc(
>>>>    static OSStatus init_out_device(coreaudioVoiceOut *core)
>>>>    {
>>>>        OSStatus status;
>>>> +    AudioDeviceID deviceID;
>>>
>>> I would probably preserve the name 'outputDeviceID' to make it more clear that
>>> it's for output.
>>
>> I omitted output because this function is for the output device; every
>> variable in this function is for output and prefixing them with output
>> makes the code verbose.
> 
> Disagree. When you review audio driver code there are many 'devices', so it is
> helpful to see the context straight away. Especially on large functions like
> this one.

It is not special to the device ID. Other variables like frameRange, 
audioDevicePropertyBufferFrameSize, and ioprocid are bound to this 
output device. In theory we could have similar corresponding variables 
for the input device so they should be prefixed with "output" if it 
matters. Prefixing only this variable is inconsistent.

> 
>>>
>>>>        AudioValueRange frameRange;
>>>> +    UInt32 audioDevicePropertyBufferFrameSize;
>>>> +    AudioDeviceIOProcID ioprocid;
>>>>    
>>>>        AudioStreamBasicDescription streamBasicDescription = {
>>>>            .mBitsPerChannel = core->hw.info.bits,
>>>> @@ -368,20 +371,19 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>>>>            .mSampleRate = core->hw.info.freq
>>>>        };
>>>>    
>>>> -    status = coreaudio_get_voice(&core->outputDeviceID);
>>>> +    status = coreaudio_get_voice(&deviceID);
>>>>        if (status != kAudioHardwareNoError) {
>>>>            coreaudio_playback_logerr (status,
>>>>                                       "Could not get default output Device\n");
>>>>            return status;
>>>>        }
>>>> -    if (core->outputDeviceID == kAudioDeviceUnknown) {
>>>> +    if (deviceID == kAudioDeviceUnknown) {
>>>>            dolog ("Could not initialize playback - Unknown Audiodevice\n");
>>>>            return status;
>>>>        }
>>>>    
>>>>        /* get minimum and maximum buffer frame sizes */
>>>> -    status = coreaudio_get_framesizerange(core->outputDeviceID,
>>>> -                                          &frameRange);
>>>> +    status = coreaudio_get_framesizerange(deviceID, &frameRange);
>>>>        if (status == kAudioHardwareBadObjectError) {
>>>>            return 0;
>>>>        }
>>>> @@ -392,31 +394,31 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>>>>        }
>>>>    
>>>>        if (frameRange.mMinimum > core->frameSizeSetting) {
>>>> -        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
>>>> +        audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
>>>>            dolog ("warning: Upsizing Buffer Frames to %f\n", frameRange.mMinimum);
>>>>        } else if (frameRange.mMaximum < core->frameSizeSetting) {
>>>> -        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
>>>> +        audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
>>>>            dolog ("warning: Downsizing Buffer Frames to %f\n", frameRange.mMaximum);
>>>>        } else {
>>>> -        core->audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
>>>> +        audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
>>>>        }
>>>>    
>>>>        /* set Buffer Frame Size */
>>>> -    status = coreaudio_set_framesize(core->outputDeviceID,
>>>> -                                     &core->audioDevicePropertyBufferFrameSize);
>>>> +    status = coreaudio_set_framesize(deviceID,
>>>> +                                     &audioDevicePropertyBufferFrameSize);
>>>>        if (status == kAudioHardwareBadObjectError) {
>>>>            return 0;
>>>>        }
>>>>        if (status != kAudioHardwareNoError) {
>>>>            coreaudio_playback_logerr (status,
>>>>                                        "Could not set device buffer frame size %" PRIu32 "\n",
>>>> -                                    (uint32_t)core->audioDevicePropertyBufferFrameSize);
>>>> +                                    (uint32_t)audioDevicePropertyBufferFrameSize);
>>>
>>> 'audioDevicePropertyBufferFrameSize' is declared as UInt32, so I guess the
>>> cast can be dropped.
>>
>> It had a cast even though core->audioDevicePropertyBufferFrameSize is
>> also UInt32. I suspect there are some cases where uint32_t and UInt32
>> are defined as different types and the compiler complains for "wrong"
>> print format.
> 
> This was introduced by cbc36cb05. While changing the format specifier made
> sense, the cast was unnecessary, but ... never mind.
> 
>>>
>>>>            return status;
>>>>        }
>>>>    
>>>>        /* get Buffer Frame Size */
>>>> -    status = coreaudio_get_framesize(core->outputDeviceID,
>>>> -                                     &core->audioDevicePropertyBufferFrameSize);
>>>> +    status = coreaudio_get_framesize(deviceID,
>>>> +                                     &audioDevicePropertyBufferFrameSize);
>>>>        if (status == kAudioHardwareBadObjectError) {
>>>>            return 0;
>>>>        }
>>>> @@ -425,11 +427,9 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>>>>                                        "Could not get device buffer frame size\n");
>>>>            return status;
>>>>        }
>>>> -    core->hw.samples = core->bufferCount * core->audioDevicePropertyBufferFrameSize;
>>>
>>> Are you sure this should be deferred to the end of the function?
>>
>> Yes. Setting core->hw.samples only makes sense after
>> AudioDeviceCreateIOProcID() succeeds, which starts generating samples
>> according to the set value.
> 
> OK, I just reviewed the pathes in this function that return zero, and realized
> that these were added by you (3ba6e3f6), however I don't see any comment on
> why you have treated them as returning as non-error cases there.

kAudioHardwareBadObjectError and kAudioHardwareBadDeviceError imply the 
device was unplugged. They are not fatal as eventually we will get 
another active device with the handle_voice_change callback.

Regards,
Akihiko Odaki

> 
> In general I highly recommend to be more verbose on your changes. For instance
> for this patch here it would have helped to see a comment which error path
> exactly you encountered. Because it makes it more easy for other people to
> understand what you are trying to fix exactly.
> 
> /Christian
> 
> 


