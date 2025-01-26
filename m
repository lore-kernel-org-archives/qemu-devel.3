Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E14C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 04:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbtp4-0000O2-6R; Sat, 25 Jan 2025 23:00:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbtp2-0000MS-Fb
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 23:00:32 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbtoz-0001VR-JW
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 23:00:31 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ef6c56032eso4543358a91.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 20:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737864028; x=1738468828;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=McgbgCgV93+dm83QtiJSj8ab2FANHlW0yQFZsNeIDhQ=;
 b=mY60oNohDyg8oQ/ELinCTvghTCnTWsaicw9wYaCPA3fO/q2XfPyqEE/D825h7OpfXq
 FWFLGsICuIRigCt28gbmaPbf29fSveiwgtPn15ClYbtlQc1pFgK8jMd1B2qlQ+4rs5zc
 AGkMPMo59Xj1epGMEvsffiCIyLUppiarpibwgdaUDceQANaCA9Zfdpmiu3ksd9xL0e7O
 G1m1+u7mEongN1R7S9uT5+16ruBIZ+BfjqtUAIeSyObJS4X24vvZkXDbURDmytIiYivf
 pwAmO06NGStdOxj/EsAmmf6OE8XAVx6/9oBofjNldn6iEw1D1sjbQbWZV9XkTYpl6+qv
 rNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737864028; x=1738468828;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=McgbgCgV93+dm83QtiJSj8ab2FANHlW0yQFZsNeIDhQ=;
 b=xRAYnOQCbKQzpwOK40x0K6ye40dV+FkKmFNi4vHAhyM+Um/WD8qLUb3imS5IoBB2xE
 9YmGGBOZdjRTcgs+nQ6GZCXfH6pCkFLHgktl5olgYLGZZ9xspWJS4+nXb2mi8e56UMyx
 5QCDGNFkoSdpWIZ2O5oM4x3aVBlmQBidTqEu/hVCHX1J9II3xiTRufpKiEVUn1iKEiR0
 Abu/ZdcKLO7bPqxWA14AysBogJLsj093kDrpWd97K3B6+EcizwTNWJddG0Ef96BgFhd3
 C8HlxReq8v924Rv1WSQ/XYtVvNLzvnbmzCSgH6C6N5S/q+AMMBUW+zLy4wvT8ZmxNZE+
 OxBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYo8raxklmVINkVWf84/p4i9SY5N7HNYeUXT1ASQtqxIKMCdDSZ+3ChBo0q/NQ9CS7dlq1pyW0qaGt@nongnu.org
X-Gm-Message-State: AOJu0YxqRRvNnnfgvlEY/4+bPUJy/1OEDvbi4D/FagaAvOoYYt7LsQ73
 PbPYe/TcpGHnBNNSA6zk3/u8+G+wqMGdCIycoebY6d001c7Vzz90gSzW+yzfHa4=
X-Gm-Gg: ASbGncukl4kWTAnejA35ulh3cflbzTtOwoURCL6Z92o44XE/z3BPRlbvJ2peKU6g2xd
 29EBG913+8sLM0yhCAtZHRUkUBTWZUv8y3XdkmklN8RpYy5z+/rriJalmGuH9No0Db9EMMOX/Kh
 +VJ7EnU5wO+Fni4xRyZ7y3X6EGVJoWlhdtlli01iXnK2urC4JyRi8wjxiTGz7Pzwj6J8N2mbBKc
 5LVUks5sDd0GubDx1E6xngM7gvEPKxw5h6kJu7hoKJknxBmowq811EQ8qAICxHubUcKT+HeHbXA
 FxqXUY8LGuDid/E=
X-Google-Smtp-Source: AGHT+IHgJHoFnMZL9OUPzrWcZQJA+VIyLmE90xmFUyKqykMt1CA8keGgCGgamIriLsD40HR7dUouFw==
X-Received: by 2002:a17:90b:1f8e:b0:2ef:114d:7bf8 with SMTP id
 98e67ed59e1d1-2f782c4ff33mr46837064a91.6.1737864027464; 
 Sat, 25 Jan 2025 20:00:27 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffa44ca2sm4316307a91.3.2025.01.25.20.00.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 20:00:26 -0800 (PST)
Message-ID: <bb859df9-cb00-4ae7-a851-ac8d1d73b1cf@daynix.com>
Date: Sun, 26 Jan 2025 13:00:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/6] coreaudio: Remove unnecessary explicit casts
To: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-devel@nongnu.org
Cc: devel@daynix.com
References: <20250124-coreaudio-v7-0-9d9a4d91db37@daynix.com>
 <4562400.zP1BOZzIia@silver> <b9116fa5-aafd-4dc8-8b31-86b079f1ad9c@daynix.com>
 <2917255.Mg30ljiku8@silver>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <2917255.Mg30ljiku8@silver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1030.google.com
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

On 2025/01/25 19:41, Christian Schoenebeck wrote:
> On Saturday, January 25, 2025 6:58:30 AM CET Akihiko Odaki wrote:
>> On 2025/01/24 18:39, Christian Schoenebeck wrote:
>>> On Friday, January 24, 2025 6:12:04 AM CET Akihiko Odaki wrote:
>>>> coreaudio had unnecessary explicit casts and they had extra whitespaces
>>>> around them so remove them.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>    audio/coreaudio.m | 6 +++---
>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
>>>> index cadd729d50537850d81718b9284efed5877d9185..0b67347ad7e8c43a77af308a1a3a654dd7084083 100644
>>>> --- a/audio/coreaudio.m
>>>> +++ b/audio/coreaudio.m
>>>> @@ -309,7 +309,7 @@ static OSStatus audioDeviceIOProc(
>>>>        UInt32 frameCount, pending_frames;
>>>>        void *out = outOutputData->mBuffers[0].mData;
>>>>        HWVoiceOut *hw = hwptr;
>>>> -    coreaudioVoiceOut *core = (coreaudioVoiceOut *) hwptr;
>>>> +    coreaudioVoiceOut *core = hwptr;
>>>
>>> Well, hwptr is void*, so both versions are fine.
>>>
>>> struct name 'coreaudioVoiceOut' should start with upper case BTW.
>>>
>>>>        size_t len;
>>>>    
>>>>        if (coreaudio_buf_lock (core, "audioDeviceIOProc")) {
>>>> @@ -392,10 +392,10 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>>>>        }
>>>>    
>>>>        if (frameRange.mMinimum > core->frameSizeSetting) {
>>>> -        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
>>>> +        core->audioDevicePropertyBufferFrameSize = frameRange.mMinimum;
>>>>            dolog ("warning: Upsizing Buffer Frames to %f\n", frameRange.mMinimum);
>>>>        } else if (frameRange.mMaximum < core->frameSizeSetting) {
>>>> -        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
>>>> +        core->audioDevicePropertyBufferFrameSize = frameRange.mMaximum;
>>>>            dolog ("warning: Downsizing Buffer Frames to %f\n", frameRange.mMaximum);
>>>>        } else {
>>>>            core->audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
>>>
>>> Those casts are actually necessary, as AudioValueRange's members are Float64
>>> (a.k.a. double) types.
>>
>> Explicit casts are unnecessary. Implicit casts still happen at every
>> line changed with this patch.
> 
> Wooo, I wasn't aware that QEMU doesn't use -Wconversion. I am not used to
> that. To me it makes sense to warn especially for things like implicit casts
> from floating point to integer, as it would be the case here.

I tried '--extra-cflags=-Wconversion -Wno-sign-conversion -Wno-error'. 
It may be actually spotting real bugs, there are just too many warnings.

For this particular case, the implicit casts will never change the 
values because the actual values are integers.

AudioHardware.h says kAudioDevicePropertyBufferFrameSizeRange is "an 
AudioValueRange indicating the minimum and maximum values, inclusive, 
for kAudioDevicePropertyBufferFrameSize." 
kAudioDevicePropertyBufferFrameSize is UInt32 so the values should 
always be in the range of UInt32. The number of frames cannot be a 
fractional value after all. They have Float64 values probably because 
Apple were so lazy that they reused the AudioValueRange type that has 
Float64 members.

Regards,
Akihiko Odaki

