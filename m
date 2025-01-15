Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE39C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 15:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY5Sd-0004Pj-Fp; Wed, 15 Jan 2025 10:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tY5Sa-0004Ox-VD
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:37:36 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tY5SX-0000uQ-0e
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:37:35 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso120035075ad.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 07:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736955451; x=1737560251;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8qhSagfIDrG1QBWAYhP92zKNdjRxULwb+RYGI2N8Hgc=;
 b=o5Rd2tDRFbmvrrZs9TrKDRIoXMWU3wwTJN2X2S59n+gKK4hhH4XvI7ClnFfgavcaZP
 aKH3zJA87s/m1zD2nUq8DQNrTxDnIz71r/mXJI3Avt5SNP/i4hAM1cFbWWuGhsgCaNyW
 ogTbEREQDAPJBytU+2inZ3Vi0GDXaphO/Wge0myVwZ3u4sL4thXUvLn3nk0AJMaGGCZ7
 5VMdUXxqk1Gym9EPucDhqnb8ZTwwocPyxma7WCmSv+8QZlQJFZDJHPvO03YWtbOULKFZ
 OrlU9NoJ8SaBxTh4m0864zhLU/qR25lQPKKgG2PlRqiDVS1s3tEWeVZWPsKRPj3IoKc2
 5K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736955451; x=1737560251;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8qhSagfIDrG1QBWAYhP92zKNdjRxULwb+RYGI2N8Hgc=;
 b=AK/odx7FFRHflR9Ub8De9lH8SpWg2aNrjLqKkofIYfBHXF/ro/WQy2Jx0X86Sch9ax
 44IdC97EHat5ZfioWCVAjUDRLv9zg8FJsjtM7tBHKcjjL/W4fxaXDZJtqW8M+2+jIuwv
 icQE4QSsIoQkFHXVL7UiVt0kuPaaiUYvw2Ss92TMH8niq882QQQq6XuF84dDv4UjHmMd
 1ItuR3qN2WtGRNQtb7o/ohrbNUzhPXLJKlGYMC9T14l+wWGnum4y7y6ITf60MGrhc+vV
 rU5YakXMeMBiLwLb0pDkgoG4XWgy+YJjeUd6l744VUPC+VUcmwNPXd6BwfPTt/3T9vi4
 I6xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6XACChYJU1R22aQGxn+svQm1xuNrHPLw4mlxo9/N/J4rrM1LlSjiEHjggqFTRcWro9EboLiHUIlGp@nongnu.org
X-Gm-Message-State: AOJu0Yz3y+BgZPfuus6yCPfZbIFalpY8fXfDVCk0qiUR5V24Q02dOM8Q
 zpJ46uKqTWR/bGiz1LCmcvasIioj2cgzYVggSVUqGI6jMJhPOVsGOpTpWzXAZjU=
X-Gm-Gg: ASbGnctbNVPSaD8TH2C1SfIjPPtkUHipr2cDmlRWTvxELNGQ+pE8QYxTV3eVmo8U69f
 FaIMNYOFIe5qtRzN87iTyVygV7yGIGp5KiS6WfQmH96iob5HPy6A3KQclg7qTKik1xGcwdZpMW3
 +n/BH+nwQsWHD52X7vUfAtWfpTqClf3hV+mVj5ehZIr6cQcW0zLAbETZrigU+3gi5JnqvkRiUzv
 gRUabo+HSHTfFqZuQELmDCiUvBwjrVEUkiuku/2S+V1DlEbuQ5xNAXi0K4gyKDB0datC0+UjfHf
 Q0bjNuOdOdimARZPe0X4/G7oFK+Dm2Y34BY=
X-Google-Smtp-Source: AGHT+IGoIIicyEgbl3hxpQSm32vhEbgOEMAI2qaLkQc/DYdiUYWUdPf0PgFw27pPp6t8m0AuMmBufw==
X-Received: by 2002:a05:6a00:846:b0:725:df1a:285 with SMTP id
 d2e1a72fcca58-72d21f476b9mr38969261b3a.12.1736955451260; 
 Wed, 15 Jan 2025 07:37:31 -0800 (PST)
Received: from ?IPV6:2400:4050:b783:b00:4952:3c52:120a:27e9?
 ([2400:4050:b783:b00:4952:3c52:120a:27e9])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d40681c05sm9505482b3a.141.2025.01.15.07.37.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 07:37:30 -0800 (PST)
Message-ID: <6383b75b-2dae-4777-a794-644d87b604fc@daynix.com>
Date: Thu, 16 Jan 2025 00:37:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] coreaudio: Commit the result of init in the end
To: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: devel@daynix.com
References: <20250115-coreaudio-v3-0-bdb6bcb5bf9f@daynix.com>
 <20250115-coreaudio-v3-1-bdb6bcb5bf9f@daynix.com> <2489919.FfEH3XSh6J@silver>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <2489919.FfEH3XSh6J@silver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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

On 2025/01/16 0:14, Christian Schoenebeck wrote:
> On Wednesday, January 15, 2025 1:06:55 PM CET Akihiko Odaki wrote:
>> init_out_device may only commit some part of the result and leave the
>> state inconsistent when it encounters an error. Commit the result in
>> the end of the function so that it commits the result iff it sees no
> 
> Typo "if".

I meant if and only if.

> 
>> error.
>>
>> With this change, handle_voice_change can rely on core->outputDeviceID
>> to know whether the output device is initialized after calling
>> init_out_device.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   audio/coreaudio.m | 49 +++++++++++++++++++++++++++----------------------
>>   1 file changed, 27 insertions(+), 22 deletions(-)
>>
>> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
>> index cadd729d5053..b9e1a952ed37 100644
>> --- a/audio/coreaudio.m
>> +++ b/audio/coreaudio.m
>> @@ -355,7 +355,10 @@ static OSStatus audioDeviceIOProc(
>>   static OSStatus init_out_device(coreaudioVoiceOut *core)
>>   {
>>       OSStatus status;
>> +    AudioDeviceID deviceID;
> 
> I would probably preserve the name 'outputDeviceID' to make it more clear that
> it's for output.

I omitted output because this function is for the output device; every 
variable in this function is for output and prefixing them with output 
makes the code verbose.

> 
>>       AudioValueRange frameRange;
>> +    UInt32 audioDevicePropertyBufferFrameSize;
>> +    AudioDeviceIOProcID ioprocid;
>>   
>>       AudioStreamBasicDescription streamBasicDescription = {
>>           .mBitsPerChannel = core->hw.info.bits,
>> @@ -368,20 +371,19 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>>           .mSampleRate = core->hw.info.freq
>>       };
>>   
>> -    status = coreaudio_get_voice(&core->outputDeviceID);
>> +    status = coreaudio_get_voice(&deviceID);
>>       if (status != kAudioHardwareNoError) {
>>           coreaudio_playback_logerr (status,
>>                                      "Could not get default output Device\n");
>>           return status;
>>       }
>> -    if (core->outputDeviceID == kAudioDeviceUnknown) {
>> +    if (deviceID == kAudioDeviceUnknown) {
>>           dolog ("Could not initialize playback - Unknown Audiodevice\n");
>>           return status;
>>       }
>>   
>>       /* get minimum and maximum buffer frame sizes */
>> -    status = coreaudio_get_framesizerange(core->outputDeviceID,
>> -                                          &frameRange);
>> +    status = coreaudio_get_framesizerange(deviceID, &frameRange);
>>       if (status == kAudioHardwareBadObjectError) {
>>           return 0;
>>       }
>> @@ -392,31 +394,31 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>>       }
>>   
>>       if (frameRange.mMinimum > core->frameSizeSetting) {
>> -        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
>> +        audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
>>           dolog ("warning: Upsizing Buffer Frames to %f\n", frameRange.mMinimum);
>>       } else if (frameRange.mMaximum < core->frameSizeSetting) {
>> -        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
>> +        audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
>>           dolog ("warning: Downsizing Buffer Frames to %f\n", frameRange.mMaximum);
>>       } else {
>> -        core->audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
>> +        audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
>>       }
>>   
>>       /* set Buffer Frame Size */
>> -    status = coreaudio_set_framesize(core->outputDeviceID,
>> -                                     &core->audioDevicePropertyBufferFrameSize);
>> +    status = coreaudio_set_framesize(deviceID,
>> +                                     &audioDevicePropertyBufferFrameSize);
>>       if (status == kAudioHardwareBadObjectError) {
>>           return 0;
>>       }
>>       if (status != kAudioHardwareNoError) {
>>           coreaudio_playback_logerr (status,
>>                                       "Could not set device buffer frame size %" PRIu32 "\n",
>> -                                    (uint32_t)core->audioDevicePropertyBufferFrameSize);
>> +                                    (uint32_t)audioDevicePropertyBufferFrameSize);
> 
> 'audioDevicePropertyBufferFrameSize' is declared as UInt32, so I guess the
> cast can be dropped.

It had a cast even though core->audioDevicePropertyBufferFrameSize is 
also UInt32. I suspect there are some cases where uint32_t and UInt32 
are defined as different types and the compiler complains for "wrong" 
print format.

> 
>>           return status;
>>       }
>>   
>>       /* get Buffer Frame Size */
>> -    status = coreaudio_get_framesize(core->outputDeviceID,
>> -                                     &core->audioDevicePropertyBufferFrameSize);
>> +    status = coreaudio_get_framesize(deviceID,
>> +                                     &audioDevicePropertyBufferFrameSize);
>>       if (status == kAudioHardwareBadObjectError) {
>>           return 0;
>>       }
>> @@ -425,11 +427,9 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>>                                       "Could not get device buffer frame size\n");
>>           return status;
>>       }
>> -    core->hw.samples = core->bufferCount * core->audioDevicePropertyBufferFrameSize;
> 
> Are you sure this should be deferred to the end of the function?

Yes. Setting core->hw.samples only makes sense after 
AudioDeviceCreateIOProcID() succeeds, which starts generating samples 
according to the set value.

> 
>>   
>>       /* set Samplerate */
>> -    status = coreaudio_set_streamformat(core->outputDeviceID,
>> -                                        &streamBasicDescription);
>> +    status = coreaudio_set_streamformat(deviceID, &streamBasicDescription);
>>       if (status == kAudioHardwareBadObjectError) {
>>           return 0;
>>       }
>> @@ -437,7 +437,6 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>>           coreaudio_playback_logerr (status,
>>                                      "Could not set samplerate %lf\n",
>>                                      streamBasicDescription.mSampleRate);
>> -        core->outputDeviceID = kAudioDeviceUnknown;
>>           return status;
>>       }
>>   
>> @@ -451,20 +450,24 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>>        * Therefore, the specified callback must be designed to avoid a deadlock
>>        * with the callers of AudioObjectGetPropertyData.
>>        */
>> -    core->ioprocid = NULL;
>> -    status = AudioDeviceCreateIOProcID(core->outputDeviceID,
>> +    ioprocid = NULL;
>> +    status = AudioDeviceCreateIOProcID(deviceID,
>>                                          audioDeviceIOProc,
>>                                          &core->hw,
>> -                                       &core->ioprocid);
>> +                                       &ioprocid);
>>       if (status == kAudioHardwareBadDeviceError) {
>>           return 0;
>>       }
>> -    if (status != kAudioHardwareNoError || core->ioprocid == NULL) {
>> +    if (status != kAudioHardwareNoError || ioprocid == NULL) {
>>           coreaudio_playback_logerr (status, "Could not set IOProc\n");
>> -        core->outputDeviceID = kAudioDeviceUnknown;
>>           return status;
>>       }
>>   
>> +    core->outputDeviceID = deviceID;
>> +    core->audioDevicePropertyBufferFrameSize = audioDevicePropertyBufferFrameSize;
>> +    core->hw.samples = core->bufferCount * core->audioDevicePropertyBufferFrameSize;
>> +    core->ioprocid = ioprocid;
>> +
>>       return 0;
>>   }
>>   
>> @@ -548,7 +551,9 @@ static OSStatus handle_voice_change(
>>           fini_out_device(core);
>>       }
>>   
>> -    if (!init_out_device(core)) {
>> +    init_out_device(core);
>> +
>> +    if (core->outputDeviceID) {
>>           update_device_playback_state(core);
>>       }
>>   
>>
>>
> 
> 


