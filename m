Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0A9CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEDw4-0005hn-Rm; Wed, 29 Oct 2025 17:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEDw3-0005e4-7D
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:42:27 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEDvp-0005oN-QE
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:42:25 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47114a40161so3345805e9.3
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761774123; x=1762378923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QAAOCxQ3njC9sd38gRl2lcX4tyoH13t+XkOmzilp5O8=;
 b=Va5r2qcmCXfmpQsPB57lxY23RulNHd1mKi7HhdRQBp9Cc23Kz83ttVrHF2P+3ZFB/U
 5MhCWnUWiX+GHe44Wz4jTWSE5Wvw7/NySVmtCTl1nIre22Zb9wv6b0nejQJlA8/86ssE
 +CyP8UNRgJCUNZ0NgiJJiSBmQUFHjv1NntfBRI3WKIdfDlxCNA5sIaFpN4V63rgIGSGf
 BD/79lp5ZLt8xGhGSS6wpwOsPBoRK2DAWvsigMfmQ8Q/o9sRlJytTzG7acPDCt2f80M2
 KiBH8XQKBWLKcQx0gNrKDPkjV/q1jvMXJr6r0l6KtZOG0Hs4Gchqn1xVI03LJFhFrSuF
 cC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761774123; x=1762378923;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QAAOCxQ3njC9sd38gRl2lcX4tyoH13t+XkOmzilp5O8=;
 b=G4MtgM4lDls5GE2sRrcpGff30KFTE13exk/HKZNhAN6k6sUMNGf+LgB9Cp/MShENsm
 hUDynWfHDHB5fTTdwL4wGRrn5G4+clk5LK8DX0Xu5S/+5gBjlQCXSbPN3vCObGk7ht2q
 O1epXBQraZHzzJYiHbj5SXwnxmjtS4LYOBVBDP1Goo+DJgKxDxB1erXkqbiwXS7mr911
 /KsM5uHeV0v91SwIJ3ZYFvZ/rjbBJPAHbn4nFR5wLC6sozbLSGFSQaBNfR+yGcSZjFuy
 2MxF9Ffe2mR1HVrzjPji9WM9pzaWUNDiFkWjFBQuQ2rBREk7DQaaq0WTOe8tk15GMM1s
 b/eg==
X-Gm-Message-State: AOJu0YyfhibtUPlg3zjxJdE2/d0Nyo2huME0M10GylYUC8EKNNuuOp0K
 XVDRmtkRc0fh8Bkc4mX6jp9nkX0UFxKKI9L0Moz2LfaSaV8xnzLytzH38gFbWOYirxMc6ygNRlH
 B9+wOusI=
X-Gm-Gg: ASbGncsObJiSPFvGUCxaZJqyioCcBJE82UqvWmikI/QvQXIUocT+hGXQibP/f7qKcGw
 jmdGmFicBbWQkkbnSqIJdx4JGw7gAflwrafnocb39eWuytc40N/BOu0yT6v6uHcR2v3Rm+uw3Ss
 I+XFHvic84pGEiZcWcViffsoVAJcJWkUhr3JZKM1ogTBYQ2PnCvVL19tcpkg6eE35GhKDb2ELgr
 tyu23IRrwV9WMdJUdBimzZ2wAmvEW37lEkRRcB6lEPsE3vidNhOnOsj4PDGKZ8l+gL+exY+SCYz
 ZvomIYefWut6OFXAUtLDYLZ6l1F54M+LdLOqJblvraylf5Xa545adbUzBkqXK94+Vnij2AogfO6
 7gHZWtDTTXqgST8MgkggYw8YCT2SBt61SNR7L2JqEPlTr273NZKQmJtpL96uVC7WewnDFRF1V5d
 6Dki2UnPGEAzNwqK4ummyJztdgGoWzX8mSK4yJYLzRRUw=
X-Google-Smtp-Source: AGHT+IGnB4KRWCBDbIHVNsOMOSYmdoSFBuOFopMo/r5gQ8CYOJ7qC/h5Z0Tfdef5fEmjqZd0Aw4EyQ==
X-Received: by 2002:a05:600c:46ce:b0:471:15c1:45b9 with SMTP id
 5b1f17b1804b1-4771e3b84c0mr47555425e9.29.1761774122790; 
 Wed, 29 Oct 2025 14:42:02 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771832e857sm55417945e9.0.2025.10.29.14.42.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 14:42:02 -0700 (PDT)
Message-ID: <adbf6cd9-72b0-4ce9-93a6-4f83338ca8a3@linaro.org>
Date: Wed, 29 Oct 2025 22:42:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/35] audio: register and unregister vmstate with
 AudioState
Content-Language: en-US
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJ+F1C+qnkm=F1q0YSHZ9WbAMcz+-NJo5mzj1b-DcU24dNpRLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 29/10/25 20:00, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Oct 29, 2025 at 5:51 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 27/10/25 16:10, marcandre.lureau@redhat.com wrote:
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> Proper lifecycle management with QOM state.
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    audio/audio.c | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/audio/audio.c b/audio/audio.c
>>> index 4c3c3fd52f..853930bb48 100644
>>> --- a/audio/audio.c
>>> +++ b/audio/audio.c
>>> @@ -1614,6 +1614,8 @@ static void audio_vm_change_state_handler (void *opaque, bool running,
>>>        audio_reset_timer (s);
>>>    }
>>>
>>> +static const VMStateDescription vmstate_audio;
>>> +
>>>    static void audio_state_init(Object *obj)
>>>    {
>>>        AudioState *s = AUDIO_STATE(obj);
>>> @@ -1625,6 +1627,8 @@ static void audio_state_init(Object *obj)
>>>
>>>        s->vmse = qemu_add_vm_change_state_handler(audio_vm_change_state_handler, s);
>>>        assert(s->vmse != NULL);
>>> +
>>> +    vmstate_register_any(NULL, &vmstate_audio, s);
>>
>> Please avoid legacy APIs:
>>
>> /**
>>    * vmstate_register_any() - legacy function to register state
>>    * serialisation description and let the function choose the id
>>    *
>>    * New code shouldn't be using this function as QOM-ified devices have
>>    * dc->vmsd to store the serialisation description.
>>    *
>>    * Returns: 0 on success, -1 on failure
>>    */
>>
> 
> qdev/Device have vmsd, but not plain Object (or legacy code without object).

Hmm right. Cc'ing Peter & Fabiano.

