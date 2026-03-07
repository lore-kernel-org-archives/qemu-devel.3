Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419EEFC9ECA
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 04:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyj7K-0004M2-4h; Fri, 06 Mar 2026 23:18:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vyj7I-0004Ll-S7
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 23:18:16 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vyj7G-00014h-Vq
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 23:18:16 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6274Hu3w045857
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 7 Mar 2026 13:18:01 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=0HDQW9Ffmj3PIpJxS/VLoJ2xGIjaZqbDQSlcRnh1ZFs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772857081; v=1;
 b=HMqu+jZwuOoGl6Uqdl0RCTjVxr4BPmSlYtOafMrVazIsK4AGUQgWfkESlftJ9pyU
 rlsSKXxInA6+527Dh2BBqJthYeGufUc+gZGKMbOI3diAVDZSRO4Iq9mQCyHQmnF1
 Bc+Fh46QUz5/LSJ7Uk+xHOqXEGnWebzVe0bqPq4sxHRKdbAEUnnZcCVHbCMvhWsy
 YOU3sjWsASVkn7ZgpKfrPhrOMLvLj4wcNtOMjcTjvIO+Om6ilDeFoXb17ZgXBp3Z
 JZLTfo02S5xbKM6MdpPYCpPsHiplzbX7J8LRSnbmaBUB322LwfwJTHkgnojs6rTx
 DucafePZaip9HCRYBZ7+5Q==
Message-ID: <c5e012a9-c26e-462f-b4cc-28745477df5e@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 7 Mar 2026 13:17:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/6] audio: Add functions to initialize buffers
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: devel@daynix.com, Phil Dennis-Jordan <phil@philjordan.eu>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
 <12848166.O9o76ZdvQC@weasel>
 <8d6f53c2-417a-4e4e-a75e-e0038cfd7f9c@rsg.ci.i.u-tokyo.ac.jp>
 <3742853.R56niFO833@weasel>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <3742853.R56niFO833@weasel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679, SPF_HELO_NONE=0.001,
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

On 2026/03/04 20:17, Christian Schoenebeck wrote:
> On Wednesday, 4 March 2026 11:47:01 CET Akihiko Odaki wrote:
>> On 2026/03/04 17:36, Christian Schoenebeck wrote:
>>> On Wednesday, 4 March 2026 07:16:58 CET Akihiko Odaki wrote:
>>>> These functions can be used to re-initialize buffers when hardware
>>>> parameters change due to device hotplug, for example.
>>>>
>>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>> Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
>>>> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
>>>> ---
> [...]
>>>>
>>>> +void audio_generic_initialize_buffer_in(HWVoiceIn *hw)
>>>> +{
>>>> +    g_free(hw->buf_emul);
>>>> +    hw->size_emul = hw->samples * hw->info.bytes_per_frame;
>>>> +    hw->buf_emul = g_malloc(hw->size_emul);
>>>> +    hw->pos_emul = hw->pending_emul = 0;
>>>> +}
>>>> +
>>>>
>>>>    void audio_generic_run_buffer_in(HWVoiceIn *hw)
>>>>    {
>>>>    
>>>>        AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(hw->s);
>>>>        
>>>>        if (unlikely(!hw->buf_emul)) {
>>>>
>>>> -        hw->size_emul = hw->samples * hw->info.bytes_per_frame;
>>>> -        hw->buf_emul = g_malloc(hw->size_emul);
>>>> -        hw->pos_emul = hw->pending_emul = 0;
>>>> +        audio_generic_initialize_buffer_in(hw);
>>>>
>>>>        }
>>>
>>> It would be cleaner having split this patch over 2 patches. One for pure
>>> refactoring (no behaviour change), and one that adds g_free(hw->buf_emul);
>>
>> g_free() was added because the extracted function can be called with
>> hw->buf_emul set. Extracting this into a function without adding
>> g_free() makes the function dangerous with non-NULL hw->buf_emul. Adding
>> g_free() without extracting it into a function doesn't make sense as it
>> checks !hw->buf_emul immediate above.
> 
> You are adding the function. So at this point, nobody could have called the
> function by accident except you. And as you would have added g_malloc()
> immediately with the next patch, there would be no danger.
> 
> In general it does make sense splitting pure refactoring from behaviour
> changes. And by adding g_free() you are changing existing behaviour. That's
> not bike shedding, it's for the sake of being able to skip all those white
> noise changes when investigating if something breaks.

You will also certainly wonder why adding g_free() in that case.

> 
> And the potential danger argument contradicts itself, because if the function
> was called with an uninitialized structure then g_free() would crash. Without
> g_free() it was just a potential memory leak OTOH. Choose your poison.

In the state machine of AudioMixengBackend it is NULL or a valid 
pointer: it never has an invalid pointer.

Marc-André Lureau, I'd like to ask you for an opinion on these matters 
since you are recently working on this and I think you are eventually 
going to make a pull request for this series.

Regards,
Akihiko Odaki

