Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7EAC021B3
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 10:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tm9gT-0007uU-R6; Sun, 23 Feb 2025 05:58:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tm9gS-0007uI-Ik; Sun, 23 Feb 2025 05:58:04 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tm9gR-0000Jr-25; Sun, 23 Feb 2025 05:58:04 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ab78e6edb99so491126666b.2; 
 Sun, 23 Feb 2025 02:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740308281; x=1740913081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jUrrlO6cs7dFVIDoZGPLGnJ38fqkdMfTZsaedCR0h1I=;
 b=llODNdsJx7KCKip4rHgAam+konCmOF4uJgVQ+iKTlRriAEaabcwEwnRS6+GlpqA+yd
 IfmJsZkw3mLwVvGWm38I3pF3ppRF3Vy9XiUYUTWOWK632CrEQ/raNp41mk5g/YGVkHwK
 LXvp3OmNC8AOh8FfpvN+M8f0eTYpMUpl658I0CPaWaZsTAdWa5haiwFC/f2WVopFfu50
 yc1e81O/zwC09hrhgiD+fBR+1fNSt/1QsjhYWEfr7ehZukQBgrTox2ZA0EcnjGVhoBNS
 VWQfSxhawYRvpxDx1ltTvifUKiDy0X/kCSrZ1aYtFMUmdNr4YvlIrqSYCpLq0uBRxVlD
 rnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740308281; x=1740913081;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jUrrlO6cs7dFVIDoZGPLGnJ38fqkdMfTZsaedCR0h1I=;
 b=WE07xRQj13pEKLU/UiM7xw5XAuM/fBoEfatvdBT91zjleL40gAyn07lxskW7+8XzCb
 hQeR47HneMFNZ0kZXTok2od/wurBulqAvlW2/VbDhZsLJpRprZ0xOOb+ZbVr3fzGTyip
 I1O9rs9X/Xg1NaMR9vlPWG1laoZPQ/Ijl87C7vqSWjb5qQTD2JmKU1yZOmEedyLCykHD
 3Cj0h4czyq334rsbCrDvl7JGYUDdG69eX8U3Rr+rP92TpH0IFumt4McdKIRJHOupGEEg
 fuEIspZM41DHN8/IEGsAMpDJTZOqNIzvFCCnmfKyAxwllm//DvB6EbEGVoTDuD1Ey7OM
 QhtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0oSVLrJkshPWYTTSsBb6trao0ZD2mMKNJXrnNNP+7gQT4ntmotkOUvtEZLkmQUXqJ1MMXBWGc0w==@nongnu.org
X-Gm-Message-State: AOJu0YzlVHjeCB79RR0UuVr7yiQp3PCxvpeQiazS0q2OyTSlW6p5VXqS
 cZ8xnz0O/LcDwtE+X+J9VScULZ1mm69zie2sHgY5gb5z/K/2fLa8
X-Gm-Gg: ASbGncvh5YjSSlcKKuLrAgr+gNZFPwtQPJqAx6armCZRrOOKvvwhVZpFzlIHpq2QGuq
 +uVSEMxDXIjI2eI9CPHF+iZOmBixgxD3i9SglVb7R7aPdH0voKnpI5wgjzXTaDKkpo3wT0dACEj
 h7Vvo5H/woVZk61jN2+96W1c7QCQzJAuEzojDTNfVq+o8DQw/RjQoWC5w4PmLcKkgV1l/dk5f/w
 scbTsNBeAW453rsPZF/hfCzwnWYD9EXJqD+GpJvR0xbLnhIGntkMp/qCs94ENU/W23ojDDT0epg
 T7eOqGNNx9lw0UQgWSQve40oISKLKEO7HTkotEHPTT9QwzJOrIYUd9dbeXmhMmd54tMVIqPAAy8
 =
X-Google-Smtp-Source: AGHT+IHUtfxLD9Wgru+q8psA2Pr9fwNGuB1jIl8cO73vktO6rlvjntfzNEz4fuxKUg4Zib2FLSEybg==
X-Received: by 2002:a17:907:da6:b0:ab2:db7b:5db3 with SMTP id
 a640c23a62f3a-abc09e4727amr926971066b.54.1740308280452; 
 Sun, 23 Feb 2025 02:58:00 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-011-167-038.77.11.pool.telefonica.de.
 [77.11.167.38]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb9b187203sm1346795966b.61.2025.02.23.02.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Feb 2025 02:58:00 -0800 (PST)
Date: Sun, 23 Feb 2025 10:57:58 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 18/18] hw/rtc: Add Ricoh RS5C372 RTC emulation
In-Reply-To: <6E5A0BEB-F0AC-4791-8CB6-B9AF74CBF307@gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-19-shentey@gmail.com>
 <CAFEAcA_gxGWivT7byZh9gYc2QHfsTqbJ8vtxPDToOxLMdMvwQg@mail.gmail.com>
 <F8650CD9-AA03-4462-A74E-7A068820F1A2@gmail.com>
 <a8855d03-d207-4a0d-a16f-24e4436a3b66@linaro.org>
 <6E5A0BEB-F0AC-4791-8CB6-B9AF74CBF307@gmail.com>
Message-ID: <132D5659-EE9A-464A-B82C-28EB826678EF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



Am 10=2E Februar 2025 22:48:24 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>
>
>Am 10=2E Februar 2025 14:26:00 UTC schrieb "Philippe Mathieu-Daud=C3=A9" =
<philmd@linaro=2Eorg>:
>>On 6/2/25 22:58, Bernhard Beschow wrote:
>>>=20
>>>=20
>>> Am 6=2E Februar 2025 17:32:31 UTC schrieb Peter Maydell <peter=2Emayde=
ll@linaro=2Eorg>:
>>>> On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail=2Ecom> w=
rote:
>>>>>=20
>>>>> The implementation just allows Linux to determine date and time=2E
>>>>>=20
>>>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>>>> ---
>>>>>   MAINTAINERS         |   1 +
>>>>>   hw/rtc/rs5c372=2Ec    | 227 ++++++++++++++++++++++++++++++++++++++=
++++++
>>>>>   hw/rtc/Kconfig      |   5 +
>>>>>   hw/rtc/meson=2Ebuild  |   1 +
>>>>>   hw/rtc/trace-events |   4 +
>>>>>   5 files changed, 238 insertions(+)
>>>>>   create mode 100644 hw/rtc/rs5c372=2Ec
>>>>=20
>>>> Should there be a patch after this one that adds this device
>>>> to your board ?
>>>=20
>>> As per Kconfig the board selects I2C_DEVICES and this device is "defau=
lt y if I2C_DEVICES"=2E I've deliberately not hardcoded this device to the =
board to make it emulate a plain i=2EMX 8M Plus SoC (see also board documen=
tation)=2E
>>
>>Then maybe add a test to be sure it is not bitroting?
>
>Good idea=2E I haven't written a test in QEMU yet but I could certainly d=
raw some inspiration from ds1338-test=2Ec=2E This may take an iteration lon=
ger but won't be forgotten=2E

There will be a test similar to ds1338-test=2Ec in v3=2E

>
>Best regards,
>Bernhard

