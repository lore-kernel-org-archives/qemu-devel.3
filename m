Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73686CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 16:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEVYM-00031e-N7; Thu, 30 Oct 2025 12:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEVYK-00030a-RT
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:31:08 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEVY5-0002Dd-FP
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:31:08 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-63c523864caso2569292a12.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 09:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761841844; x=1762446644; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DQEefFoXOGbbclOSElXowMt4zbsVDwOKRTZCZG0/hcQ=;
 b=pZ7vmbT6OL0VGlHMm0uI1vovHhBjWf9/wplkO+Fa8pookrP1Svc2fra/lNx90QUEjp
 qjhRmD4QgbK68JVa8b5ChEhF2D1Eum2NoFBNfLC2lDi9DgQeY1mdTKRtrEF8uejFGMsn
 ybBVkTOug7mpeAYYVMsDhG9n8VU6VJn/9IU8boVm74HsesWOyY+fmMhjEOOrW80OVKAO
 qpQFoeK8PpTnInQUefZ/o8/D6UaK63aqDaS+csE6Z2tx6C3lAtPA/86zu5eX5TmhOEyI
 FhExKNrQqiIxsu2miqMzpzHxZQSnQ0CiLowDdk7mrsIXrLPA/2WmQOFTBmS61NaDvW/Q
 i4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761841844; x=1762446644;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DQEefFoXOGbbclOSElXowMt4zbsVDwOKRTZCZG0/hcQ=;
 b=cz37ZJdbKFu8t0DuGTvvSXbQrlUhQQnaWRV4mRKUH6+xNJ/zK+K0yDMz7d2jDwOIJE
 7mGWgB3pMN+gBWJLyi6arF84zuhADhX/1E4EEugezxu/Md9DYPQgmwBv3zYtuY0B9z76
 6kclWGSBvXAf8k4QUP15HWFQYkyz47HDjSLkQjMXNkm8WUbON2A/zOEYd18/nRjd25DC
 GtR2Bxjt9hx/tOx+MWzB3GOgt4vTTt312SYtyAeRLKNQlo7BkMg8xOnAXNoYWdZBPWfw
 fDepTXP4Kc8wO26yqiaJEzqWSqjOIml5hXPEWjleWtnK7nrl0x1JQ9dJ13vk3eOPJTcN
 67Xw==
X-Gm-Message-State: AOJu0YxlS42m9iv3wRdQWDu5TwJ5UsvtsF2RSY/tgiG2Zr+HT22+yRUt
 cNfa9CfpEWha6/F5yZMHHKXqUgFhZu7Jp01Gf6S1d6xN5AdXQSNdiPI6BezQI/Cg64c=
X-Gm-Gg: ASbGncuTCU7j0hW3rh9C6vkz9LWreUq+aO64WyuyBaYdV+gdw00FofausvA/UcYDwgm
 UYywKnPhpLq22/ydDvnUC1CeRTMMFi2PtmgkxCsFxym0oBZsnYTWxy/9a03FDr/eQIhhxpPRGo7
 4AWvqBGrdV65qY9H4GSboS0GMVaZBzrse16t76OLbfHjK8+JPvOp+oeZnjLmn/kLWi0QpcbG/db
 coqTfhsOl2JdMucTRBAPwBsk/at5Bm9NFKu7I/wkFyYhQkapLFqPRdcGiPogr+nRHVrFUAeHSnm
 IEYGHmfY2Trw1EQvz/9k71ueDDyGaMdkUUtrWQBKXe2T0mUXRDUO/5MXghBmQz+aCF5HZODKC7D
 zy722+x9SytNxGFjvqQfDdGWbaFMe5nqyPq1G5x2NEM4+yq6N94xiTc+Vusxw0BzJiXsA2bYT0O
 +mpSGD9187nIReXI32jYof6jek94eUXqGUT0wEVuHmSQ==
X-Google-Smtp-Source: AGHT+IHnYrNZxUyWoONL46qOnJ/BGUoKXVfQ7thK/SUZQb9c4PzRPL9w091Lk5JnMfm++vOfoSJnzg==
X-Received: by 2002:a05:6402:5353:20b0:63e:19ec:c8e4 with SMTP id
 4fb4d7f45d1cf-64077025460mr44521a12.28.1761841844306; 
 Thu, 30 Oct 2025 09:30:44 -0700 (PDT)
Received: from [10.180.230.213] (183.105.204.77.rev.sfr.net. [77.204.105.183])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64068f74a56sm1888001a12.15.2025.10.30.09.30.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 09:30:43 -0700 (PDT)
Message-ID: <d0b66630-40ea-40a3-9da4-d817b9febc88@linaro.org>
Date: Thu, 30 Oct 2025 17:30:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/35] audio: register and unregister vmstate with
 AudioState
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Alexandre Ratchov <alex@caoua.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jan Kiszka <jan.kiszka@web.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Volker_R=C3=BCmelin?=
 <vr_qemu@t-online.de>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
 <20251027151045.2863176-20-marcandre.lureau@redhat.com>
 <ffab95ce-9b5d-43ea-93a7-611de6044ad8@linaro.org>
 <CAJ+F1C+qnkm=F1q0YSHZ9WbAMcz+-NJo5mzj1b-DcU24dNpRLQ@mail.gmail.com>
 <adbf6cd9-72b0-4ce9-93a6-4f83338ca8a3@linaro.org>
In-Reply-To: <adbf6cd9-72b0-4ce9-93a6-4f83338ca8a3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

On 29/10/25 22:42, Philippe Mathieu-Daudé wrote:
> On 29/10/25 20:00, Marc-André Lureau wrote:
>> Hi
>>
>> On Wed, Oct 29, 2025 at 5:51 PM Philippe Mathieu-Daudé
>> <philmd@linaro.org> wrote:
>>>
>>> On 27/10/25 16:10, marcandre.lureau@redhat.com wrote:
>>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>
>>>> Proper lifecycle management with QOM state.
>>>>
>>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>> ---
>>>>    audio/audio.c | 7 ++++++-
>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/audio/audio.c b/audio/audio.c
>>>> index 4c3c3fd52f..853930bb48 100644
>>>> --- a/audio/audio.c
>>>> +++ b/audio/audio.c
>>>> @@ -1614,6 +1614,8 @@ static void audio_vm_change_state_handler 
>>>> (void *opaque, bool running,
>>>>        audio_reset_timer (s);
>>>>    }
>>>>
>>>> +static const VMStateDescription vmstate_audio;
>>>> +
>>>>    static void audio_state_init(Object *obj)
>>>>    {
>>>>        AudioState *s = AUDIO_STATE(obj);
>>>> @@ -1625,6 +1627,8 @@ static void audio_state_init(Object *obj)
>>>>
>>>>        s->vmse = 
>>>> qemu_add_vm_change_state_handler(audio_vm_change_state_handler, s);
>>>>        assert(s->vmse != NULL);
>>>> +
>>>> +    vmstate_register_any(NULL, &vmstate_audio, s);
>>>
>>> Please avoid legacy APIs:
>>>
>>> /**
>>>    * vmstate_register_any() - legacy function to register state
>>>    * serialisation description and let the function choose the id
>>>    *
>>>    * New code shouldn't be using this function as QOM-ified devices have
>>>    * dc->vmsd to store the serialisation description.
>>>    *
>>>    * Returns: 0 on success, -1 on failure
>>>    */
>>>
>>
>> qdev/Device have vmsd, but not plain Object (or legacy code without 
>> object).
> 
> Hmm right. Cc'ing Peter & Fabiano.

Not blocking, so:

