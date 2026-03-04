Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7C6EB7ECD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 10:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxjm3-0008Ry-4L; Wed, 04 Mar 2026 05:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxjlT-0007nR-TL
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:47:39 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxjlL-0000aB-0t
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:47:32 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 624Al1Vp096571
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 4 Mar 2026 19:47:16 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=bMyRjRd58gGQ5A5m7HWLEb22uibqSIJqU5xP0iTfVA8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772621236; v=1;
 b=U2dHzF59U0vkuDLmT42UdrgmfPQ/GKyXE9Wa5QxMlmou32fBdQMLeGm3kRMZgPLe
 TmsMFTvq3y+vfllDfN1+DVOSynY4jM0X2JzSikHiAN6Y0S2HMx5IrXvEf/v3aBQU
 0Kz3m7fM7Iz0OkxzocmL5Gx9Rwmz/N7kcYMAouCgGlH89MCFQAgfzev6o1SgbQGD
 bpKrBTvg/gsTEs3Sz4sdfS/7ZIatUkGJTihr5Mafpyv3cDgk+NsK9ho1bPyO4Fpt
 r4LPFt4VsdasjnVweHVAsXVsNnn5kD37H7OQZYyngjyah6qtThpzAf90wdaozXRY
 rM25gpY1pgvU4APnnjdN+Q==
Message-ID: <8d6f53c2-417a-4e4e-a75e-e0038cfd7f9c@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 4 Mar 2026 19:47:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/6] audio: Add functions to initialize buffers
To: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>
References: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
 <20260304-coreaudio-v8-5-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
 <12848166.O9o76ZdvQC@weasel>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <12848166.O9o76ZdvQC@weasel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/03/04 17:36, Christian Schoenebeck wrote:
> On Wednesday, 4 March 2026 07:16:58 CET Akihiko Odaki wrote:
>> These functions can be used to re-initialize buffers when hardware
>> parameters change due to device hotplug, for example.
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
>> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
>> ---
>>   audio/audio_int.h       |  2 ++
>>   audio/audio-mixeng-be.c | 24 ++++++++++++++++++------
>>   2 files changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/audio/audio_int.h b/audio/audio_int.h
>> index 06f79ade6b0a..290cf373b49f 100644
>> --- a/audio/audio_int.h
>> +++ b/audio/audio_int.h
>> @@ -141,9 +141,11 @@ static inline void *advance(void *p, size_t incr)
>>   int wav_start_capture(AudioBackend *state, CaptureState *s, const char
>> *path, int freq, int bits, int nchannels);
>>
>> +void audio_generic_initialize_buffer_in(HWVoiceIn *hw);
>>   void audio_generic_run_buffer_in(HWVoiceIn *hw);
>>   void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
>>   void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size);
>> +void audio_generic_initialize_buffer_out(HWVoiceOut *hw);
>>   void audio_generic_run_buffer_out(HWVoiceOut *hw);
>>   size_t audio_generic_buffer_get_free(HWVoiceOut *hw);
>>   void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size);
>> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
>> index 370404505111..1419e7521503 100644
>> --- a/audio/audio-mixeng-be.c
>> +++ b/audio/audio-mixeng-be.c
>> @@ -1187,14 +1187,20 @@ void audio_run(AudioMixengBackend *s, const char
>> *msg) }
>>   }
>>
>> +void audio_generic_initialize_buffer_in(HWVoiceIn *hw)
>> +{
>> +    g_free(hw->buf_emul);
>> +    hw->size_emul = hw->samples * hw->info.bytes_per_frame;
>> +    hw->buf_emul = g_malloc(hw->size_emul);
>> +    hw->pos_emul = hw->pending_emul = 0;
>> +}
>> +
>>   void audio_generic_run_buffer_in(HWVoiceIn *hw)
>>   {
>>       AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(hw->s);
>>
>>       if (unlikely(!hw->buf_emul)) {
>> -        hw->size_emul = hw->samples * hw->info.bytes_per_frame;
>> -        hw->buf_emul = g_malloc(hw->size_emul);
>> -        hw->pos_emul = hw->pending_emul = 0;
>> +        audio_generic_initialize_buffer_in(hw);
>>       }
> 
> It would be cleaner having split this patch over 2 patches. One for pure
> refactoring (no behaviour change), and one that adds g_free(hw->buf_emul);

g_free() was added because the extracted function can be called with 
hw->buf_emul set. Extracting this into a function without adding 
g_free() makes the function dangerous with non-NULL hw->buf_emul. Adding 
g_free() without extracting it into a function doesn't make sense as it 
checks !hw->buf_emul immediate above.

Regards,
Akihiko Odaki

> 
>>       while (hw->pending_emul < hw->size_emul) {
>> @@ -1227,6 +1233,14 @@ void audio_generic_put_buffer_in(HWVoiceIn *hw, void
>> *buf, size_t size) hw->pending_emul -= size;
>>   }
>>
>> +void audio_generic_initialize_buffer_out(HWVoiceOut *hw)
>> +{
>> +    g_free(hw->buf_emul);
>> +    hw->size_emul = hw->samples * hw->info.bytes_per_frame;
>> +    hw->buf_emul = g_malloc(hw->size_emul);
>> +    hw->pos_emul = hw->pending_emul = 0;
>> +}
>> +
>>   size_t audio_generic_buffer_get_free(HWVoiceOut *hw)
>>   {
>>       if (hw->buf_emul) {
>> @@ -1260,9 +1274,7 @@ void audio_generic_run_buffer_out(HWVoiceOut *hw)
>>   void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)
>>   {
>>       if (unlikely(!hw->buf_emul)) {
>> -        hw->size_emul = hw->samples * hw->info.bytes_per_frame;
>> -        hw->buf_emul = g_malloc(hw->size_emul);
>> -        hw->pos_emul = hw->pending_emul = 0;
>> +        audio_generic_initialize_buffer_out(hw);
>>       }
>>
>>       *size = MIN(hw->size_emul - hw->pending_emul,
> 
> 
> 
> 


