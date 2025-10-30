Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4453CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 16:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEVZ8-0003Nl-RD; Thu, 30 Oct 2025 12:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEVYs-0003Fi-BY
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:31:52 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEVYh-0002HG-IC
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:31:40 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b3b3a6f4dd4so242452966b.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 09:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761841885; x=1762446685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JgscATsSSMPRhIE7wz4646HaTTG/bQuticFNhSwlNrE=;
 b=FVirLy0BHNI5tFETiNN0sHu157Xr4aJXoZERNkspSvVlEBwrcBJ4tDGnxGse1jZ6HH
 FvXl4hTBBUO1f0OuqlhxMuQzFafDfI+PApVHOq4Tz8I5rsivzRhzmqzsEl8E8uaOnoIJ
 wsEmH7XNpmabokkTpZlyPQq6JfcCbPmJhfOOJXeaiFgBO9cke2p4rE6g2B2BeXLKh4tb
 MKQ9sI9KAkxBUi3jEObZypqSFrfaauMO4mfb0JWACmAeblODX7LFKjBzzAJdaTP+b7Mb
 OfOq41FFrk60RwSljH54d4My41YuDYobgSp/DvGdF6KcrVQmlqW8NjToo2J5RM6aKKiJ
 z3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761841885; x=1762446685;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JgscATsSSMPRhIE7wz4646HaTTG/bQuticFNhSwlNrE=;
 b=T888sRqbAubN0f18ePCr7zw/14zYAcT+uFCxr0HrMrXaXjEUFpkk5eWbjI0viXYIel
 bMD3Ua0vpFyuDJMb6I0Lvlfou154AgZn572gIW+HEytR1PLcHe2KOCETZDAs7fsAA5gG
 v3pjHcPPeCFxktEqtYa8SUpVi9+gFDBkowwuSedzi3jJHYqecH/gcc07hK+LAtsmSFmV
 07HIIyE7Px9ht67wrg4uq1VMMP4CjoUHgFFN6MI9I8SUIDtpekWIcV/Q3mJQtiz853AL
 y6+Aco0y5HyG16ADeDylWyXe2uBaQoehTfWZefm3fxbYRMQQRZw2CbSPnXcgyXT6rPsn
 3yoQ==
X-Gm-Message-State: AOJu0YwVcvdtOKuAi5413fNuvPr/KKImzYMz14clOBrL7qyXJEVjDPVg
 +xIz1mL6Z/YxIa4MWqHp43wmb5AJ0jNgHMMPIphyD3pgv9kZvgFaUYp9IaxlV3byRu8=
X-Gm-Gg: ASbGncuvUMbwZ2gPphXC6lyPAKhZyLdKskVC/OBL8P11Je6R5dSPXr5JtjYOcN065AV
 LampJnJbk+xuwI/7P8kLsEydMwZwV5EcngS4eKFtqGaWjZAVaNzw5LuGMorAIJ+8RbzvfsS0S9u
 W/kINABkaBsQVG1qi0aBfNNiPcaXxx6jFm4eX97Ax+0dwwS5RgNZXB3fX0dS7PBFoK8BaxPRuWV
 8SA+/uJE/zuLu+oLCxUwQGw8icZZg/0VLBIn1oVlJRNxNTD9Ld7JOFQkK+Nme5Ntpuvu5bmEf1d
 te57X38KRr0FGg6G5Z+xJCD1C7HOTLYDN4TRil1SBzPBEHiRvdFaiVBcc7eu7Tzpnu1j7PMk0BE
 Yj2bpJ5ElwUNPoJLZn7dKRS1ka2QqJqCBvb5FiV3ennpAc8V1ZPOpduMjHZTa1q4b1Tfg2k8a6f
 0dX4uawafNJf5/TgluRmLo9CExeuuhGdi1qNSFqlttaA==
X-Google-Smtp-Source: AGHT+IEaR40rPReIDElPoY/lykrSRr94vSFRr8kIjKRRLKYlHa3IYGcn1UCdkaHGEnqXb3oADxWolg==
X-Received: by 2002:a17:907:6d26:b0:b6d:5cc5:89d9 with SMTP id
 a640c23a62f3a-b7070631082mr6705066b.47.1761841884855; 
 Thu, 30 Oct 2025 09:31:24 -0700 (PDT)
Received: from [10.180.230.213] (183.105.204.77.rev.sfr.net. [77.204.105.183])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853f3851sm1791968366b.48.2025.10.30.09.31.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 09:31:24 -0700 (PDT)
Message-ID: <100e6967-9090-4531-871a-1118ef83dd65@linaro.org>
Date: Thu, 30 Oct 2025 17:31:21 +0100
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
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

But please consider an alternative. We really ought to remove this
legacy API.

Thanks,

Phil.

