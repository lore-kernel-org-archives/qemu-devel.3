Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF2BCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEE74-0007qg-LJ; Wed, 29 Oct 2025 17:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE73-0007oQ-4e
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:53:49 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE6r-0007uN-MJ
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:53:48 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-475dc6029b6so3634115e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761774809; x=1762379609; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WES+Ny/Ud3VzQoIwxHp4O8mqJxD7akPdqbRdRNtliZ8=;
 b=O+FguzARQO3i2gKqFnqudW68wyar1c/LsEJxBkF4OTxu5pGlqum0jv2ZPpFS85Ikjl
 lacIw4WNLfi5/Ax6KKXScF/Vy8yzoLG17b+kZpnaaymXkDmLOuXZmgu6D/YPsX4dtz0s
 SHqF0gjxRZT8gge3QbfRVx1gmyesKRjE7JIDU33gsySkpXg/NjQI6GeATEXvS1ifxGrx
 1/0HI9Ds6B8jm39r2DkIIqQh5PjcMUuiVLrk6fQgiEcQxz9PODo0XBv068Z53VbHNZCc
 bXQQl58NMa2Us0WgBdP81T1unMDzpjRLwjDPhnNmv5EnokOL/+RqWUlnAMEmr6SPlY7y
 W1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761774809; x=1762379609;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WES+Ny/Ud3VzQoIwxHp4O8mqJxD7akPdqbRdRNtliZ8=;
 b=ZpoUySV303S6Teo/MMmTRV+VQ1ej5ruNrtJ5AiLIma8PqWGVu0YS7NbFKzj4nimy+Z
 n75gQNNsUHMpbvJsy8PUZL7Ybym+k1fx8q/cNykZ+j+ahn7ObSSnUaZsQiyFxJJxuRSn
 N2ZrpRqNnnhUULgf3BoXAak6UHM9XAiOl95KX7aWwldqk7ZdisybYXUzLO0puDCmV0Bt
 X8/lcUlqwRUcZvjmz0f1dEQqJAB0aLQdcjdsr75Ob3qBXjQkJwP6Kk4TDGsZk31+O9OE
 kSW0QwvfeB6Me8q1MVbOKFS5+ykdTs6tbhR52mNE4eR339zRyvLgUpmsNK7dUbw68xkn
 SSXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyoVl/R7LOSdSN+PDTRK/kAxiZG0lzeLs1W4JfvIOV/mnI/jiF/V30f1BvrkoYN24XEvX1qan/8S1p@nongnu.org
X-Gm-Message-State: AOJu0YzajJZEhybHlEEuZUpTlzVtPIee3DPZTo51MxbXhgIMYxmu3wgd
 5R8DOWMXuk+IAzqn7D/v9OdoB2BqAUwOANBCyREODebl43a69XhNgvgmczrs04TIJXGekxMQo0q
 aiRJj7X4=
X-Gm-Gg: ASbGncsNlksIjQKy4Sg5VTXRyq+yzxvlioI2jenRtCFJsgligJRwtl3qZtwK/uLKMgn
 r94UkT1R4z+OhyKYeWW6Hf1x4MbLkNJbAMuLM09rBKMyek1V9HylYkQ27rezSlLnSJat/t8m4hk
 KWlSuTb8nejJhx47EqI588ardBg/KOQ3i/C4WmLJcMPHFy1/P7nscoxprxziTeqpm+GLQ3zIWgz
 IdlbK2eag/x7sMlrONhzRzb19OgElgvR6pFswqLpltgE154C0EfO1TQhJX11jHSpS2Xc+Ouj8L9
 opHzeT3wdNP8/1shxVWXYeAuKeNuNj0xLIiY1Y2Y1S6D9JhIFy38hD4GmhS0Epxxvvfi7tTuBPX
 UfNKL1D6HN3Sy8snuW+3Hn1yScN7FezyptBJJqTxVXKFXQw63PFXDMaPuou8KMpzxdZkz08HHCW
 SWAAsyPlwbR8l2GUzP5420IY+nvT2wKbUay0TcGmwhtkk=
X-Google-Smtp-Source: AGHT+IGcR4bC/xf/lphkVM8QuDJxmg24Ru8600hRUtjOHSapqItFKzUwH9vxElpQuYEGo8n3sW+1hw==
X-Received: by 2002:a05:600c:5488:b0:477:10c4:b4e with SMTP id
 5b1f17b1804b1-4771e1f59demr38937505e9.41.1761774809144; 
 Wed, 29 Oct 2025 14:53:29 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47726396832sm5873175e9.1.2025.10.29.14.53.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 14:53:28 -0700 (PDT)
Message-ID: <6a095121-ed37-4d51-8115-f436d2d95028@linaro.org>
Date: Wed, 29 Oct 2025 22:53:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/35] audio: introduce AUD_set_volume_{in,out}_lr()
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
 <20251027151045.2863176-24-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027151045.2863176-24-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> There are 2 sets of functions since the introduction of multi-channel
> Volume structure: AUD_set_volume_{in,out} and audio_set_volume_{in,out}.
> 
> Use the AUD_ prefix for consistency with other audio.c functions. Rename
> the stereo function with "_lr" suffix.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio.h         | 21 ++++++++++++++++-----
>   audio/audio.c         | 16 ++--------------
>   hw/audio/ac97.c       |  4 ++--
>   hw/audio/asc.c        |  2 +-
>   hw/audio/hda-codec.c  |  4 ++--
>   hw/audio/lm4549.c     |  2 +-
>   hw/audio/via-ac97.c   |  2 +-
>   hw/audio/virtio-snd.c |  4 ++--
>   hw/audio/wm8750.c     | 12 ++++++------
>   hw/display/xlnx_dp.c  |  2 +-
>   hw/usb/dev-audio.c    |  4 ++--
>   11 files changed, 36 insertions(+), 37 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


