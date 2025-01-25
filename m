Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E147C02182
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 06:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbZIc-0005eR-96; Sat, 25 Jan 2025 01:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbZIb-0005dM-CX
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 01:05:41 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tbZIY-0007Zg-6o
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 01:05:41 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2165cb60719so49939975ad.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 22:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737785136; x=1738389936;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n9D76mSGgYz5eLaoxRU2G+Pxl7+gKyYGi6i2F0pe1Uw=;
 b=cxXqQMBTKlHX6tGHl1WZ2z1327jXt1mtJt0vKj9+U2/1A2L5vcQH7k2FuL0c6/vpHa
 /qB5nI11h1hBPk8uULHxRrU8chegWEq6MqzqpeC/ISaeBQ57Z9+xRIDemgqzKEdJghaH
 Yrqc49kAzRlOPXCIY/039EFbbcGIviFhOCIo5+K8i49vT89+dphXWcAkim6QYCcFADCB
 C01t1ub0q9Vdp9lljKOBuTqwyrWrOxI222f4BpVUcPkY1rY3jlNWWnUlXWxKzKyd0Js2
 CgVuJlFUfppRlPg1VimB+F1gfSVPzlKaEP4NnFTlF2Pgv7ug2j2lmn2NcpgKiuBF4Gjf
 +eGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737785136; x=1738389936;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n9D76mSGgYz5eLaoxRU2G+Pxl7+gKyYGi6i2F0pe1Uw=;
 b=DeAivgyXIHtxdQOXngPJd5uc9wd3OTfSoZEO5IzWzOtbgNyAp+qfXmvCPdszj9y/xm
 1szhCMlhpMmGTXjqCgkKoI4yyA56nhwl7MwBM+J5dn3qaNHv7w2waxz2D8wlqbn+iGk9
 sSQjU35OAUJYu2Y7UACPPFDFDBmmJaMNd+wDjh1eVo38FMt77lXEO6F5TOc40+dLxq+6
 XCsWjWkkwXWR8Tou0hhCXfzjqb88KQJjIa82GPOvnxeXfHbCVHUEZL+3qT7r9UvGw4bv
 WcKr6XRTkix1eIcKWOku0a6UL4WcxevnW9K+Kv0Gu8XuBdUAz38zSl7y+ADvRuN86Cc3
 B6Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP91OnLGHYYSQ0g1VmfT3aZZzir7WrUJAgQ8NmTHbLuCo6RDpB28p5lZxuD9spnEKTiGlminsbgBOn@nongnu.org
X-Gm-Message-State: AOJu0Yzj5940Q+qcXyXj2iM7e8taMcHJQf9qte4ys+UkbE33vxWa8ytB
 BgUS8rOW2xZKRwzlIx0hB9aivg27VcYTqiBL8IMfZQ4717MThupzju/Cm9yWnOY=
X-Gm-Gg: ASbGncvsSUzcU5WzFVB9CCuWH4xo8GIjXnHoSh8SUf4xvVmjcZqK4miT9kSyZaXCg0M
 H5NO2KRg2pLl7biA5uH19jVg15sNHAsvRQQi1AoD6rUKvqW8TFGJOUQTeG5K1RZ8VINTvsLCkDp
 68rQqlCrTpd2tJ/GLEWDOb71DfJfTB75Bw0G5JEn8wY0yoKca3kL+5H+Es0xsbag1veBJY3nAvG
 Gvp+VvDiITrqgpC+PzhaKDjoQyt1Yxe/oe3B0lTK8Z/H3eV2R7SPVBP3dD3lWQPVkt6HY8YgoqN
 ZF5IIaWHTyVM6IglhQ==
X-Google-Smtp-Source: AGHT+IFoPwC+kVJsHY3JqTdc7A5QB+fZ8UnqrVI0ajChzf+Dar0x9GRVWe7tjEC/Jh/DcVS7wc0roA==
X-Received: by 2002:a05:6a21:32a1:b0:1e0:cf9a:87b1 with SMTP id
 adf61e73a8af0-1eb21470299mr44752405637.6.1737785136207; 
 Fri, 24 Jan 2025 22:05:36 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6b323esm3035944b3a.60.2025.01.24.22.05.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 22:05:35 -0800 (PST)
Message-ID: <bf7a6349-62ee-4736-b04c-57c5ce49bb2f@daynix.com>
Date: Sat, 25 Jan 2025 15:05:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/6] coreaudio: Improve naming
To: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-devel@nongnu.org
Cc: devel@daynix.com
References: <20250124-coreaudio-v7-0-9d9a4d91db37@daynix.com>
 <20250124-coreaudio-v7-3-9d9a4d91db37@daynix.com> <5972999.ShRvV13zmH@silver>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <5972999.ShRvV13zmH@silver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
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

On 2025/01/24 19:01, Christian Schoenebeck wrote:
> On Friday, January 24, 2025 6:12:06 AM CET Akihiko Odaki wrote:
>> coreaudio had names that are not conforming to QEMU codding style.
>> coreaudioVoiceOut also had some members that are prefixed with redundant
>> words like "output" or "audio".
>> Global names included "out" to tell they are specific to output devices,
>> but this rule was not completely enforced.
>> The frame size had three different names "frameSize", "bufferFrameSize",
>> and "frameCount".
>>
>> Replace identifiers to fix these problems.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   audio/coreaudio.m | 193 +++++++++++++++++++++++++++---------------------------
>>   1 file changed, 98 insertions(+), 95 deletions(-)
>>
>> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
>> index 04e8ac59f4572c1e5fb7dc4f04f5e21520507ab5..6f170a909983b2a5c6abd6fc04c6c3f32828c10c 100644
>> --- a/audio/coreaudio.m
>> +++ b/audio/coreaudio.m
>> @@ -33,37 +33,37 @@
>>   #define AUDIO_CAP "coreaudio"
>>   #include "audio_int.h"
>>   
>> -typedef struct coreaudioVoiceOut {
>> +typedef struct CoreaudioVoiceOut {
>>       HWVoiceOut hw;
>>       pthread_mutex_t buf_mutex;
>> -    AudioDeviceID outputDeviceID;
>> -    int frameSizeSetting;
>> -    uint32_t bufferCount;
>> -    UInt32 audioDevicePropertyBufferFrameSize;
>> +    AudioDeviceID device_id;
>> +    int frame_size_setting;
>> +    uint32_t buffer_count;
>> +    UInt32 device_frame_size;
> 
> Actually weird that there are two frame size variables here. AFAICS the
> device_frame_size member could be dropped and turned into a local variable.

They can have different values. frame_size_setting is the value the user 
configured. device_frame_size is the value that is the value supported 
by the device and closest to frame_size_setting.

device_frame_size cannot be turned into a local variable as it is 
referred by two functions, out_device_ioproc() and init_out_device().

> 
> Not really an issue for this patch, just saying.
> 
>>       AudioDeviceIOProcID ioprocid;
>>       bool enabled;
>> -} coreaudioVoiceOut;
>> +} CoreaudioVoiceOut;
> 
> Ah, there's the upper case change. :)
> 
>> -static const AudioObjectPropertyAddress voice_addr = {
>> +static const AudioObjectPropertyAddress voice_out_addr = {
>>       kAudioHardwarePropertyDefaultOutputDevice,
>>       kAudioObjectPropertyScopeGlobal,
>>       kAudioObjectPropertyElementMain
>>   };
>>   
>> -static OSStatus coreaudio_get_voice(AudioDeviceID *id)
>> +static OSStatus coreaudio_get_voice_out(AudioDeviceID *id)
>>   {
>>       UInt32 size = sizeof(*id);
>>   
>>       return AudioObjectGetPropertyData(kAudioObjectSystemObject,
>> -                                      &voice_addr,
>> +                                      &voice_out_addr,
>>                                         0,
>>                                         NULL,
>>                                         &size,
>>                                         id);
>>   }
>>   
>> -static OSStatus coreaudio_get_framesizerange(AudioDeviceID id,
>> -                                             AudioValueRange *framerange)
>> +static OSStatus coreaudio_get_out_framesizerange(AudioDeviceID id,
>> +                                                 AudioValueRange *framerange)
>>   {
>>       UInt32 size = sizeof(*framerange);
>>       AudioObjectPropertyAddress addr = {
>> @@ -80,7 +80,7 @@ static OSStatus coreaudio_get_framesizerange(AudioDeviceID id,
>>                                         framerange);
>>   }
>>   
>> -static OSStatus coreaudio_get_framesize(AudioDeviceID id, UInt32 *framesize)
>> +static OSStatus coreaudio_get_out_framesize(AudioDeviceID id, UInt32 *framesize)
>>   {
>>       UInt32 size = sizeof(*framesize);
>>       AudioObjectPropertyAddress addr = {
>> @@ -97,7 +97,7 @@ static OSStatus coreaudio_get_framesize(AudioDeviceID id, UInt32 *framesize)
>>                                         framesize);
>>   }
>>   
>> -static OSStatus coreaudio_set_framesize(AudioDeviceID id, UInt32 *framesize)
>> +static OSStatus coreaudio_set_out_framesize(AudioDeviceID id, UInt32 *framesize)
>>   {
>>       UInt32 size = sizeof(*framesize);
>>       AudioObjectPropertyAddress addr = {
>> @@ -114,8 +114,8 @@ static OSStatus coreaudio_set_framesize(AudioDeviceID id, UInt32 *framesize)
>>                                         framesize);
>>   }
>>   
>> -static OSStatus coreaudio_set_streamformat(AudioDeviceID id,
>> -                                           AudioStreamBasicDescription *d)
>> +static OSStatus coreaudio_set_out_streamformat(AudioDeviceID id,
>> +                                               AudioStreamBasicDescription *d)
>>   {
>>       UInt32 size = sizeof(*d);
>>       AudioObjectPropertyAddress addr = {
>> @@ -132,7 +132,7 @@ static OSStatus coreaudio_set_streamformat(AudioDeviceID id,
>>                                         d);
>>   }
>>   
>> -static OSStatus coreaudio_get_isrunning(AudioDeviceID id, UInt32 *result)
>> +static OSStatus coreaudio_get_out_isrunning(AudioDeviceID id, UInt32 *result)
>>   {
>>       UInt32 size = sizeof(*result);
>>       AudioObjectPropertyAddress addr = {
>> @@ -242,7 +242,8 @@ static void G_GNUC_PRINTF(3, 4) coreaudio_logerr2(
>>   #define coreaudio_playback_logerr(status, ...) \
>>       coreaudio_logerr2(status, "playback", __VA_ARGS__)
>>   
>> -static int coreaudio_buf_lock(coreaudioVoiceOut *core, const char *fn_name)
>> +static int coreaudio_voice_out_buf_lock(CoreaudioVoiceOut *core,
>> +                                        const char *fn_name)
>>   {
>>       int err;
>>   
>> @@ -255,7 +256,8 @@ static int coreaudio_buf_lock(coreaudioVoiceOut *core, const char *fn_name)
>>       return 0;
>>   }
>>   
>> -static int coreaudio_buf_unlock(coreaudioVoiceOut *core, const char *fn_name)
>> +static int coreaudio_voice_out_buf_unlock(CoreaudioVoiceOut *core,
>> +                                          const char *fn_name)
>>   {
>>       int err;
>>   
>> @@ -268,20 +270,20 @@ static int coreaudio_buf_unlock(coreaudioVoiceOut *core, const char *fn_name)
>>       return 0;
>>   }
>>   
>> -#define COREAUDIO_WRAPPER_FUNC(name, ret_type, args_decl, args) \
>> -    static ret_type glue(coreaudio_, name)args_decl             \
>> -    {                                                           \
>> -        coreaudioVoiceOut *core = (coreaudioVoiceOut *)hw;      \
>> -        ret_type ret;                                           \
>> -                                                                \
>> -        if (coreaudio_buf_lock(core, "coreaudio_" #name)) {         \
>> -            return 0;                                           \
>> -        }                                                       \
>> -                                                                \
>> -        ret = glue(audio_generic_, name)args;                   \
>> -                                                                \
>> -        coreaudio_buf_unlock(core, "coreaudio_" #name);             \
>> -        return ret;                                             \
>> +#define COREAUDIO_WRAPPER_FUNC(name, ret_type, args_decl, args)       \
>> +    static ret_type glue(coreaudio_, name)args_decl                   \
>> +    {                                                                 \
>> +        CoreaudioVoiceOut *core = (CoreaudioVoiceOut *)hw;            \
>> +        ret_type ret;                                                 \
>> +                                                                      \
>> +        if (coreaudio_voice_out_buf_lock(core, "coreaudio_" #name)) { \
>> +            return 0;                                                 \
>> +        }                                                             \
>> +                                                                      \
>> +        ret = glue(audio_generic_, name)args;                         \
>> +                                                                      \
>> +        coreaudio_voice_out_buf_unlock(core, "coreaudio_" #name);     \
>> +        return ret;                                                   \
> 
> That doesn't really belong into this patch, but OK.
> 
>>       }
>>   COREAUDIO_WRAPPER_FUNC(buffer_get_free, size_t, (HWVoiceOut *hw), (hw))
>>   COREAUDIO_WRAPPER_FUNC(get_buffer_out, void *, (HWVoiceOut *hw, size_t *size),
>> @@ -297,7 +299,7 @@ static ret_type glue(coreaudio_, name)args_decl             \
>>    * callback to feed audiooutput buffer. called without BQL.
>>    * allowed to lock "buf_mutex", but disallowed to have any other locks.
>>    */
>> -static OSStatus audioDeviceIOProc(
>> +static OSStatus out_device_ioproc(
>>       AudioDeviceID inDevice,
>>       const AudioTimeStamp *inNow,
>>       const AudioBufferList *inInputData,
>> @@ -306,33 +308,33 @@ static OSStatus audioDeviceIOProc(
>>       const AudioTimeStamp *inOutputTime,
>>       void *hwptr)
>>   {
>> -    UInt32 frameCount, pending_frames;
>> +    UInt32 frame_size, pending_frames;
>>       void *out = outOutputData->mBuffers[0].mData;
>>       HWVoiceOut *hw = hwptr;
>> -    coreaudioVoiceOut *core = hwptr;
>> +    CoreaudioVoiceOut *core = hwptr;
>>       size_t len;
>>   
>> -    if (coreaudio_buf_lock(core, "audioDeviceIOProc")) {
>> +    if (coreaudio_voice_out_buf_lock(core, "out_device_ioproc")) {
>>           inInputTime = 0;
>>           return 0;
>>       }
>>   
>> -    if (inDevice != core->outputDeviceID) {
>> -        coreaudio_buf_unlock(core, "audioDeviceIOProc(old device)");
>> +    if (inDevice != core->device_id) {
>> +        coreaudio_voice_out_buf_unlock(core, "out_device_ioproc(old device)");
>>           return 0;
>>       }
>>   
>> -    frameCount = core->audioDevicePropertyBufferFrameSize;
>> +    frame_size = core->device_frame_size;
>>       pending_frames = hw->pending_emul / hw->info.bytes_per_frame;
>>   
>>       /* if there are not enough samples, set signal and return */
>> -    if (pending_frames < frameCount) {
>> +    if (pending_frames < frame_size) {
>>           inInputTime = 0;
>> -        coreaudio_buf_unlock(core, "audioDeviceIOProc(empty)");
>> +        coreaudio_voice_out_buf_unlock(core, "out_device_ioproc(empty)");
>>           return 0;
>>       }
>>   
>> -    len = frameCount * hw->info.bytes_per_frame;
>> +    len = frame_size * hw->info.bytes_per_frame;
>>       while (len) {
>>           size_t write_len, start;
>>   
>> @@ -348,16 +350,16 @@ static OSStatus audioDeviceIOProc(
>>           out += write_len;
>>       }
>>   
>> -    coreaudio_buf_unlock(core, "audioDeviceIOProc");
>> +    coreaudio_voice_out_buf_unlock(core, "out_device_ioproc");
>>       return 0;
>>   }
>>   
>> -static OSStatus init_out_device(coreaudioVoiceOut *core)
>> +static OSStatus init_out_device(CoreaudioVoiceOut *core)
>>   {
>>       OSStatus status;
>> -    AudioValueRange frameRange;
>> +    AudioValueRange framerange;
>>   
>> -    AudioStreamBasicDescription streamBasicDescription = {
>> +    AudioStreamBasicDescription stream_basic_description = {
>>           .mBitsPerChannel = core->hw.info.bits,
>>           .mBytesPerFrame = core->hw.info.bytes_per_frame,
>>           .mBytesPerPacket = core->hw.info.bytes_per_frame,
>> @@ -368,20 +370,20 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>>           .mSampleRate = core->hw.info.freq
>>       };
>>   
>> -    status = coreaudio_get_voice(&core->outputDeviceID);
>> +    status = coreaudio_get_voice_out(&core->device_id);
> 
> As can be seen here, I still think "*out*_device_id" is useful for review
> purposes. Except of that:
> 
> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

If we want to clarify it is for the output, "core" should be renamed to 
"core_out" or something like that so that we can see all members that 
belongs to that struct is for the output.

But I also like that the current name is concise. It is like the "this" 
in C++; so I think keeping such a frequently-used local variable short 
makes sense.

Regards,
Akihiko Odaki

> 
> /Christian
> 
>>       if (status != kAudioHardwareNoError) {
>>           coreaudio_playback_logerr(status,
>>                                     "Could not get default output Device\n");
>>           return status;
>>       }
>> -    if (core->outputDeviceID == kAudioDeviceUnknown) {
>> +    if (core->device_id == kAudioDeviceUnknown) {
>>           dolog("Could not initialize playback - Unknown Audiodevice\n");
>>           return status;
>>       }
>>   
>>       /* get minimum and maximum buffer frame sizes */
>> -    status = coreaudio_get_framesizerange(core->outputDeviceID,
>> -                                          &frameRange);
>> +    status = coreaudio_get_out_framesizerange(core->device_id,
>> +                                              &framerange);
>>       if (status == kAudioHardwareBadObjectError) {
>>           return 0;
>>       }
>> @@ -391,32 +393,32 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>>           return status;
>>       }
>>   
>> -    if (frameRange.mMinimum > core->frameSizeSetting) {
>> -        core->audioDevicePropertyBufferFrameSize = frameRange.mMinimum;
>> -        dolog("warning: Upsizing Buffer Frames to %f\n", frameRange.mMinimum);
>> -    } else if (frameRange.mMaximum < core->frameSizeSetting) {
>> -        core->audioDevicePropertyBufferFrameSize = frameRange.mMaximum;
>> -        dolog("warning: Downsizing Buffer Frames to %f\n", frameRange.mMaximum);
>> +    if (framerange.mMinimum > core->frame_size_setting) {
>> +        core->device_frame_size = framerange.mMinimum;
>> +        dolog("warning: Upsizing Buffer Frames to %f\n", framerange.mMinimum);
>> +    } else if (framerange.mMaximum < core->frame_size_setting) {
>> +        core->device_frame_size = framerange.mMaximum;
>> +        dolog("warning: Downsizing Buffer Frames to %f\n", framerange.mMaximum);
>>       } else {
>> -        core->audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
>> +        core->device_frame_size = core->frame_size_setting;
>>       }
>>   
>>       /* set Buffer Frame Size */
>> -    status = coreaudio_set_framesize(core->outputDeviceID,
>> -                                     &core->audioDevicePropertyBufferFrameSize);
>> +    status = coreaudio_set_out_framesize(core->device_id,
>> +                                         &core->device_frame_size);
>>       if (status == kAudioHardwareBadObjectError) {
>>           return 0;
>>       }
>>       if (status != kAudioHardwareNoError) {
>>           coreaudio_playback_logerr(status,
>>                                     "Could not set device buffer frame size %" PRIu32 "\n",
>> -                                  (uint32_t)core->audioDevicePropertyBufferFrameSize);
>> +                                  (uint32_t)core->device_frame_size);
>>           return status;
>>       }
>>   
>>       /* get Buffer Frame Size */
>> -    status = coreaudio_get_framesize(core->outputDeviceID,
>> -                                     &core->audioDevicePropertyBufferFrameSize);
>> +    status = coreaudio_get_out_framesize(core->device_id,
>> +                                         &core->device_frame_size);
>>       if (status == kAudioHardwareBadObjectError) {
>>           return 0;
>>       }
>> @@ -425,19 +427,19 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>>                                     "Could not get device buffer frame size\n");
>>           return status;
>>       }
>> -    core->hw.samples = core->bufferCount * core->audioDevicePropertyBufferFrameSize;
>> +    core->hw.samples = core->buffer_count * core->device_frame_size;
>>   
>>       /* set Samplerate */
>> -    status = coreaudio_set_streamformat(core->outputDeviceID,
>> -                                        &streamBasicDescription);
>> +    status = coreaudio_set_out_streamformat(core->device_id,
>> +                                            &stream_basic_description);
>>       if (status == kAudioHardwareBadObjectError) {
>>           return 0;
>>       }
>>       if (status != kAudioHardwareNoError) {
>>           coreaudio_playback_logerr(status,
>>                                     "Could not set samplerate %lf\n",
>> -                                  streamBasicDescription.mSampleRate);
>> -        core->outputDeviceID = kAudioDeviceUnknown;
>> +                                  stream_basic_description.mSampleRate);
>> +        core->device_id = kAudioDeviceUnknown;
>>           return status;
>>       }
>>   
>> @@ -452,8 +454,8 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>>        * with the callers of AudioObjectGetPropertyData.
>>        */
>>       core->ioprocid = NULL;
>> -    status = AudioDeviceCreateIOProcID(core->outputDeviceID,
>> -                                       audioDeviceIOProc,
>> +    status = AudioDeviceCreateIOProcID(core->device_id,
>> +                                       out_device_ioproc,
>>                                          &core->hw,
>>                                          &core->ioprocid);
>>       if (status == kAudioHardwareBadDeviceError) {
>> @@ -461,20 +463,20 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>>       }
>>       if (status != kAudioHardwareNoError || core->ioprocid == NULL) {
>>           coreaudio_playback_logerr(status, "Could not set IOProc\n");
>> -        core->outputDeviceID = kAudioDeviceUnknown;
>> +        core->device_id = kAudioDeviceUnknown;
>>           return status;
>>       }
>>   
>>       return 0;
>>   }
>>   
>> -static void fini_out_device(coreaudioVoiceOut *core)
>> +static void fini_out_device(CoreaudioVoiceOut *core)
>>   {
>>       OSStatus status;
>>       UInt32 isrunning;
>>   
>>       /* stop playback */
>> -    status = coreaudio_get_isrunning(core->outputDeviceID, &isrunning);
>> +    status = coreaudio_get_out_isrunning(core->device_id, &isrunning);
>>       if (status != kAudioHardwareBadObjectError) {
>>           if (status != kAudioHardwareNoError) {
>>               coreaudio_logerr(status,
>> @@ -482,7 +484,7 @@ static void fini_out_device(coreaudioVoiceOut *core)
>>           }
>>   
>>           if (isrunning) {
>> -            status = AudioDeviceStop(core->outputDeviceID, core->ioprocid);
>> +            status = AudioDeviceStop(core->device_id, core->ioprocid);
>>               if (status != kAudioHardwareBadDeviceError && status != kAudioHardwareNoError) {
>>                   coreaudio_logerr(status, "Could not stop playback\n");
>>               }
>> @@ -490,20 +492,20 @@ static void fini_out_device(coreaudioVoiceOut *core)
>>       }
>>   
>>       /* remove callback */
>> -    status = AudioDeviceDestroyIOProcID(core->outputDeviceID,
>> +    status = AudioDeviceDestroyIOProcID(core->device_id,
>>                                           core->ioprocid);
>>       if (status != kAudioHardwareBadDeviceError && status != kAudioHardwareNoError) {
>>           coreaudio_logerr(status, "Could not remove IOProc\n");
>>       }
>> -    core->outputDeviceID = kAudioDeviceUnknown;
>> +    core->device_id = kAudioDeviceUnknown;
>>   }
>>   
>> -static void update_device_playback_state(coreaudioVoiceOut *core)
>> +static void update_out_device_playback_state(CoreaudioVoiceOut *core)
>>   {
>>       OSStatus status;
>>       UInt32 isrunning;
>>   
>> -    status = coreaudio_get_isrunning(core->outputDeviceID, &isrunning);
>> +    status = coreaudio_get_out_isrunning(core->device_id, &isrunning);
>>       if (status != kAudioHardwareNoError) {
>>           if (status != kAudioHardwareBadObjectError) {
>>               coreaudio_logerr(status,
>> @@ -516,7 +518,7 @@ static void update_device_playback_state(coreaudioVoiceOut *core)
>>       if (core->enabled) {
>>           /* start playback */
>>           if (!isrunning) {
>> -            status = AudioDeviceStart(core->outputDeviceID, core->ioprocid);
>> +            status = AudioDeviceStart(core->device_id, core->ioprocid);
>>               if (status != kAudioHardwareBadDeviceError && status != kAudioHardwareNoError) {
>>                   coreaudio_logerr(status, "Could not resume playback\n");
>>               }
>> @@ -524,7 +526,7 @@ static void update_device_playback_state(coreaudioVoiceOut *core)
>>       } else {
>>           /* stop playback */
>>           if (isrunning) {
>> -            status = AudioDeviceStop(core->outputDeviceID,
>> +            status = AudioDeviceStop(core->device_id,
>>                                        core->ioprocid);
>>               if (status != kAudioHardwareBadDeviceError && status != kAudioHardwareNoError) {
>>                   coreaudio_logerr(status, "Could not pause playback\n");
>> @@ -534,22 +536,22 @@ static void update_device_playback_state(coreaudioVoiceOut *core)
>>   }
>>   
>>   /* called without BQL. */
>> -static OSStatus handle_voice_change(
>> +static OSStatus handle_voice_out_change(
>>       AudioObjectID in_object_id,
>>       UInt32 in_number_addresses,
>>       const AudioObjectPropertyAddress *in_addresses,
>>       void *in_client_data)
>>   {
>> -    coreaudioVoiceOut *core = in_client_data;
>> +    CoreaudioVoiceOut *core = in_client_data;
>>   
>>       bql_lock();
>>   
>> -    if (core->outputDeviceID) {
>> +    if (core->device_id) {
>>           fini_out_device(core);
>>       }
>>   
>>       if (!init_out_device(core)) {
>> -        update_device_playback_state(core);
>> +        update_out_device_playback_state(core);
>>       }
>>   
>>       bql_unlock();
>> @@ -560,7 +562,7 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
>>                                 void *drv_opaque)
>>   {
>>       OSStatus status;
>> -    coreaudioVoiceOut *core = (coreaudioVoiceOut *)hw;
>> +    CoreaudioVoiceOut *core = (CoreaudioVoiceOut *)hw;
>>       int err;
>>       Audiodev *dev = drv_opaque;
>>       AudiodevCoreaudioPerDirectionOptions *cpdo = dev->u.coreaudio.out;
>> @@ -578,13 +580,14 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
>>       as->fmt = AUDIO_FORMAT_F32;
>>       audio_pcm_init_info(&hw->info, as);
>>   
>> -    core->frameSizeSetting = audio_buffer_frames(
>> +    core->frame_size_setting = audio_buffer_frames(
>>           qapi_AudiodevCoreaudioPerDirectionOptions_base(cpdo), as, 11610);
>>   
>> -    core->bufferCount = cpdo->has_buffer_count ? cpdo->buffer_count : 4;
>> +    core->buffer_count = cpdo->has_buffer_count ? cpdo->buffer_count : 4;
>>   
>>       status = AudioObjectAddPropertyListener(kAudioObjectSystemObject,
>> -                                            &voice_addr, handle_voice_change,
>> +                                            &voice_out_addr,
>> +                                            handle_voice_out_change,
>>                                               core);
>>       if (status != kAudioHardwareNoError) {
>>           coreaudio_playback_logerr(status,
>> @@ -594,8 +597,8 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
>>   
>>       if (init_out_device(core)) {
>>           status = AudioObjectRemovePropertyListener(kAudioObjectSystemObject,
>> -                                                   &voice_addr,
>> -                                                   handle_voice_change,
>> +                                                   &voice_out_addr,
>> +                                                   handle_voice_out_change,
>>                                                      core);
>>           if (status != kAudioHardwareNoError) {
>>               coreaudio_playback_logerr(status,
>> @@ -612,11 +615,11 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
>>   {
>>       OSStatus status;
>>       int err;
>> -    coreaudioVoiceOut *core = (coreaudioVoiceOut *)hw;
>> +    CoreaudioVoiceOut *core = (CoreaudioVoiceOut *)hw;
>>   
>>       status = AudioObjectRemovePropertyListener(kAudioObjectSystemObject,
>> -                                               &voice_addr,
>> -                                               handle_voice_change,
>> +                                               &voice_out_addr,
>> +                                               handle_voice_out_change,
>>                                                  core);
>>       if (status != kAudioHardwareNoError) {
>>           coreaudio_logerr(status, "Could not remove voice property change listener\n");
>> @@ -633,10 +636,10 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
>>   
>>   static void coreaudio_enable_out(HWVoiceOut *hw, bool enable)
>>   {
>> -    coreaudioVoiceOut *core = (coreaudioVoiceOut *)hw;
>> +    CoreaudioVoiceOut *core = (CoreaudioVoiceOut *)hw;
>>   
>>       core->enabled = enable;
>> -    update_device_playback_state(core);
>> +    update_out_device_playback_state(core);
>>   }
>>   
>>   static void *coreaudio_audio_init(Audiodev *dev, Error **errp)
>> @@ -670,7 +673,7 @@ static void coreaudio_audio_fini(void *opaque)
>>       .pcm_ops        = &coreaudio_pcm_ops,
>>       .max_voices_out = 1,
>>       .max_voices_in  = 0,
>> -    .voice_size_out = sizeof(coreaudioVoiceOut),
>> +    .voice_size_out = sizeof(CoreaudioVoiceOut),
>>       .voice_size_in  = 0
>>   };
>>   
>>
>>
> 
> 


