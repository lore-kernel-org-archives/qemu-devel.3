Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682ECC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 12:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbIul-0005B2-Tq; Fri, 24 Jan 2025 07:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tbIuk-0005At-PX
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 07:35:58 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tbIuj-0003OL-7x
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 07:35:58 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 07EC74E6030;
 Fri, 24 Jan 2025 13:35:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id ITOOEStN-kSh; Fri, 24 Jan 2025 13:35:54 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 143474E601A; Fri, 24 Jan 2025 13:35:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1221D74577C;
 Fri, 24 Jan 2025 13:35:54 +0100 (CET)
Date: Fri, 24 Jan 2025 13:35:54 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
cc: Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org, 
 devel@daynix.com
Subject: Re: [PATCH v6 3/5] coreaudio: Commit the result of init in the end
In-Reply-To: <278cfade-f073-3428-b340-ae888b92da65@eik.bme.hu>
Message-ID: <e5837d31-bd1e-1450-bdf2-0a1ff1773ff0@eik.bme.hu>
References: <20250124-coreaudio-v6-0-11fbcb6c47cf@daynix.com>
 <20250124-coreaudio-v6-3-11fbcb6c47cf@daynix.com>
 <278cfade-f073-3428-b340-ae888b92da65@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 24 Jan 2025, BALATON Zoltan wrote:
> On Fri, 24 Jan 2025, Akihiko Odaki wrote:
>> init_out_device may only commit some part of the result and leave the
>> state inconsistent when it encounters a fatal error or the device gets
>> unplugged during the operation, which is expressed by
>> kAudioHardwareBadObjectError or kAudioHardwareBadDeviceError. Commit the
>> result in the end of the function so that it commits the result iff it
>> sees no fatal error and the device remains plugged.
>> 
>> With this change, handle_voice_change can rely on core->outputDeviceID
>> to know whether the output device is initialized after calling
>> init_out_device.
>> 
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>> audio/coreaudio.m | 46 +++++++++++++++++++++++++---------------------
>> 1 file changed, 25 insertions(+), 21 deletions(-)
>> 
>> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
>> index 
>> c3ede586bbee1711d6a798175995b8db7dc89398..aff2b37b12aca723849645297c04f30ed365b8f8 
>> 100644
>> --- a/audio/coreaudio.m
>> +++ b/audio/coreaudio.m
>> @@ -357,7 +357,10 @@ static OSStatus out_device_ioproc(
>> static OSStatus init_out_device(CoreaudioVoiceOut *core)
>> {
>>     OSStatus status;
>> +    AudioDeviceID device_id;
>>     AudioValueRange framerange;
>> +    UInt32 device_frame_size;
>> +    AudioDeviceIOProcID ioprocid;
>>
>>     AudioStreamBasicDescription stream_basic_description = {
>>         .mBitsPerChannel = core->hw.info.bits,
>> @@ -370,20 +373,19 @@ static OSStatus init_out_device(CoreaudioVoiceOut 
>> *core)
>>         .mSampleRate = core->hw.info.freq
>>     };
>> 
>> -    status = coreaudio_get_voice_out(&core->device_id);
>> +    status = coreaudio_get_voice_out(&device_id);
>>     if (status != kAudioHardwareNoError) {
>>         coreaudio_playback_logerr (status,
>
> Still spaces in function calls here and in dolog() calls below.

Already fixed in next version, sorry for the noise.

Regards,
BALATON Zoltan

