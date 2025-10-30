Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7E3CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 16:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEVhs-0008PX-Gh; Thu, 30 Oct 2025 12:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEVhl-000894-Gv
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:40:54 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEVhW-0003HS-9P
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:40:53 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b6d6c11f39aso229428666b.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 09:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761842433; x=1762447233; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n3YWjyTbC+xe6Y47LFs2TmrbnnZ6YGIRWY7Vp+OyHiQ=;
 b=ILmj72dSEuLSRiYUNax+Nb0qbE9zBzIwQFYk8Mi6RAJBNpx/JYKKmwrmFPl2THPYj9
 4Khe6lQ+VIYZBUDdsdWlvkbzfAyjQ7ZAeakaXF90oG2MkjfT5+YiH0GY1DLkdhPseeuo
 n8wtnICywpuT1yVmGeCl/jN+7mH2s5YcR5TUgKFc7pHMNrI8jqu9BDSfSKVid5P1GIXs
 cfy8hijJsU0VxgG0YSIkjoCjjitex8NXzpetgdnRquv4nu/Y9gll3mz0lWjEZae7KDAJ
 aIZpYD/3peGDTMVOnD2EqRBi+eb5C5r5P+i2uZjB0DHKd4Sh5tF2cXjzqBqEvuUyt9fS
 i8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761842433; x=1762447233;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n3YWjyTbC+xe6Y47LFs2TmrbnnZ6YGIRWY7Vp+OyHiQ=;
 b=GfdBNbG/GH6mH2QjKK1I2wryqaEX5UkDLlaBPYShdeO+JYjkz3O3A5autHSfA0q06G
 cmO+GwKfSRnEQ+6Q56GZwMPpulxuPIpyBvmxfFjxHWnG7juMqwy2eOPWdBI2QSX7ykQL
 CUunl7jd3VD6XLwsVSdN+7hLKDrTw5FCfeg9Cs7a/X6HiuZuAUZN2WtIHlBZLsc7kIE5
 Jw+5HEMK8q8APCkT5tXmT+7qaR+3l3A6ZVHWDY5oSR+oz5ev6+YuYjr9ThU2G9qbkOkE
 xLvkZoPx6yXa/6Pv+udsLvW7n2mlOAIcZnLIvV/M19sXHwDAvIXQun2GxoG2jQRqpvRD
 cjzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgUpF175AwsFy91o5pCJqfiTMusPBGsI30K0PMS5dAF30WzKTYDwDHNdJVTbyOtsFcTCbdskAdkD7W@nongnu.org
X-Gm-Message-State: AOJu0Yw6xmgvdNrpRjbytaDNTaYfGQMEzdglFo1lo2dMFs6LzhZmiBQe
 wVBHM+ux+iUyE21LsIDPRP2g1HLNlQIHZuKWsXKmAIYUO+sI2LN9o8u5xHfSkMr0HFA=
X-Gm-Gg: ASbGncvzM0UIt8TK3p8jOTmEYcovSYDVw0pcVbY1MBW0MspytudvwoMgVwKeNkBUOZC
 tx2wlp1ZFikuzEP03AjY315MGn6v/sEwWi01OWNVHYzFLww1cxOuEvDSZWs8CAG3rJFWrlBNg8v
 NEyHk4rR/bUoevtG+HjuXPftin1m4s7HoRnHqoOvO5r0FpBzdLeyUP78Xl6B3ofdP/G/NkGGjF2
 XD8ZhoJnIsUv6hbCiqyQolexn0/+cukGvKzozuq9+5YbLCUsw3GWwDKz9ZbJm9gPfr1rsSG3wE5
 Bd8PoWAHED3/t3DI9ozeZfOJV/hqpRxQvzbB+9dKoI7ShdiyYzCAVbDapNBZfOQ8KTV/9ubl043
 929Gsm/EHZcR80JP0BCj+6hWEwFo2HbWnc6po1XQ9MFpXsFHeFfPW9i4Kdz0fpVEruZxbfLI+4J
 +P9g4UP9U6ac5p0dmu2ydDviWVmtOzXn0PNdthg5VLVg==
X-Google-Smtp-Source: AGHT+IF83aVJAcc9Fc0RHqkJhZzsj1sH8crT0fm4JwaXtr9OmFhO8Y7Wjqz9YJg1ydfwP0oyt8QXuQ==
X-Received: by 2002:a17:907:7b8d:b0:b5c:753a:e022 with SMTP id
 a640c23a62f3a-b70701dc398mr12715666b.29.1761842432115; 
 Thu, 30 Oct 2025 09:40:32 -0700 (PDT)
Received: from [10.180.230.213] (183.105.204.77.rev.sfr.net. [77.204.105.183])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85308c8dsm1800518766b.0.2025.10.30.09.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 09:40:31 -0700 (PDT)
Message-ID: <108b6d8e-e34b-4574-ab91-e141dcf77af2@linaro.org>
Date: Thu, 30 Oct 2025 17:40:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 32/35] audio: move capture API to own header
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jan Kiszka <jan.kiszka@web.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
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
 <20251027151045.2863176-33-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027151045.2863176-33-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 27/10/25 16:10, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> For modularity/clarity reasons, move the capture API in a specific
> header.
> 
> The current audio/ header license is MIT.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   MAINTAINERS                  |  2 +-
>   audio/audio_int.h            |  1 +
>   include/qemu/audio-capture.h | 43 ++++++++++++++++++++++++++++++++++++
>   include/qemu/audio.h         | 30 -------------------------
>   ui/vnc.h                     |  2 +-
>   5 files changed, 46 insertions(+), 32 deletions(-)
>   create mode 100644 include/qemu/audio-capture.h

Good idea.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


