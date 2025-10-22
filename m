Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2518CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 07:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBT0l-0004YB-CE; Wed, 22 Oct 2025 03:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBT0j-0004Y2-UW
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 03:11:54 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBT0i-0001jk-73
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 03:11:53 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46fcf9f63b6so35961445e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 00:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761117110; x=1761721910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uYIFUMbo/1cQ0WnVA94vGLc1yKwKjgs79jUCOMF/Pas=;
 b=vCwyC4UKy60XJFiMumPEVJkr1g6c+n8u3TNiINQG75SpPUReGF7nsokSL7yESrlbih
 o5dJLy7zVbYvl97kHSrv58DbPYg6gjNXiR5IUzHHXywdc6Tui7VsEb3/is8YQQGESM6A
 pXOXtxX7SV+K9yTQiNGQb8NZTUTZlZMeBVVlpJ41QrdRFN8hWGpoIpItCCpnHsw4RbCp
 OtiTxTQujYfND+6+3Qp2arRkBK6rhsj7iLX3xg3D6X/Q+T4apyMQOyczAaw1KLYFcw0o
 W0zuxUK+AE0vMi5ypfVy4bipZ+kBgi7lGikRYMJvgkf8VTxg6YcVe2jWkAxP3RB8vYa2
 Zj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761117110; x=1761721910;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uYIFUMbo/1cQ0WnVA94vGLc1yKwKjgs79jUCOMF/Pas=;
 b=LzWe4iI6ZJQIFX9WVWFh3QRQHms594jXAzjNs0a6i9aSv89l77JavekA0JiZT5BmSm
 89/vRfXDjPYwl0Ei1uJNEUUrqMxYBsICNKH6dikXoF/rjcjgMdH2j7ReL63Jc8cVPUgV
 gNNJKP8OqgMk6vejTg8K56u8Q3uf2MyjWrJC2Nc+Y8bv3LA0VxEETfcow7kpDrEI4dcy
 5LQy6Ma8v3ZAjxcpkYGVapa0cxSh2rhC9y7UhSu9vyZ/1dT+YDmDvsL8+L/WCdSHN2Xg
 x9kj7VvTkkL7T38+6hrSw+OZIigCvXu0HLXR6cvcSomDDvA6J/NgRbQB/bXPvg+FTENL
 O1rA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXqyjrWnsKaq7ST7a/s6s3z2GxX3nG5oNyaWfNXfpHA96c0yvC2lwTi++uquXCA9Sdw66ovHGZlQ5U@nongnu.org
X-Gm-Message-State: AOJu0YyVUMMSPQoFUkeTk6Rode7q/Mm77wR3qRYK7T+dZQylqlLy2Sf1
 v9Q/D6dPptCBCOOZs2XsyrzOMNNBI0WHerUOQZL5OdzWRX5BYYWvQL22MK027kYG/co=
X-Gm-Gg: ASbGnctlziSe9vxa9LArjjyu/6CBHrdZrCvFCcEG2L+la3Web3DqvpZvkg7j1zFTi7K
 Y2ibFre6Gb0Ym1F7tjWWAgVBFVmUoLM2ac2fyEvLw9DF+Xd1BrQe1XIiM+ups9lFSJs+yuHmV8G
 bVbdtvsXjJo3/FEOUWgKu3/yM/Ca8/9YkvQbfPG1I5pimt8m8P8XiAnTZ2l5yqHcyj011Ew6dTs
 TsUoQpijmpal2MCzGGlFs8gp8QHp3GeoKHKkdVseCfZ1i0oMVS+XxgBFPpX5OYrXAe/NfvuSrkm
 OCWfAws97yw47DRkEQKkzM5snITuYcfeXZsDB/278hlD5aQ9sfcVmLzESHzReChaNUVaoY7d5nK
 W7SBkSoqNxrEjq1000pqM13BzhE9lS4+ss88bgKSS1PJ2EkXKaZznPRkuvq8QBNjzfdG2Jo8I3h
 aUCgzzmfnyectnNb/riJUbBWdeD22F8vs/ekvrsKD7DBNOdIyHZ49Orw==
X-Google-Smtp-Source: AGHT+IEzVgQS6nDuuz81wgOXmgCKgpt65YoI2hQTf1U55r0Ziu+wbea79QmhLw1DkCbAR0A4r2fkog==
X-Received: by 2002:a05:600c:3e0f:b0:471:803:6a26 with SMTP id
 5b1f17b1804b1-4711791d945mr153385265e9.37.1761117110167; 
 Wed, 22 Oct 2025 00:11:50 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c42d9524sm28407145e9.18.2025.10.22.00.11.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 00:11:49 -0700 (PDT)
Message-ID: <b14061db-3050-4a44-a351-46ae2ed0c30c@linaro.org>
Date: Wed, 22 Oct 2025 09:11:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/42] audio: remove AUDIO_HOST_ENDIANNESS
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
 <20251022065640.1172785-30-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251022065640.1172785-30-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 22/10/25 08:56, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio.h      | 6 ------
>   audio/audio.c      | 6 +++---
>   audio/spiceaudio.c | 4 ++--
>   hw/audio/adlib.c   | 2 +-
>   hw/audio/asc.c     | 2 +-
>   hw/audio/cs4231a.c | 2 +-
>   hw/audio/gus.c     | 2 +-
>   7 files changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/audio/audio.h b/audio/audio.h
> index 3be0c4f24f..0af911fd9a 100644
> --- a/audio/audio.h
> +++ b/audio/audio.h
> @@ -31,12 +31,6 @@
>   
>   typedef void (*audio_callback_fn) (void *opaque, int avail);
>   
> -#if HOST_BIG_ENDIAN
> -#define AUDIO_HOST_ENDIANNESS 1
> -#else
> -#define AUDIO_HOST_ENDIANNESS 0
> -#endif
> -
>   typedef struct audsettings {
>       int freq;
>       int nchannels;
> diff --git a/audio/audio.c b/audio/audio.c
> index 0f3093ad59..284ea13289 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -274,7 +274,7 @@ static int audio_pcm_info_eq (struct audio_pcm_info *info, struct audsettings *a
>           && info->is_signed == is_signed
>           && info->is_float == is_float
>           && info->bits == bits
> -        && info->swap_endianness == (as->endianness != AUDIO_HOST_ENDIANNESS);
> +        && info->swap_endianness == (as->endianness != HOST_BIG_ENDIAN);
>   }
>   
>   void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as)
> @@ -320,7 +320,7 @@ void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as)
>       info->nchannels = as->nchannels;
>       info->bytes_per_frame = as->nchannels * mul;
>       info->bytes_per_second = info->freq * info->bytes_per_frame;
> -    info->swap_endianness = (as->endianness != AUDIO_HOST_ENDIANNESS);
> +    info->swap_endianness = (as->endianness != HOST_BIG_ENDIAN);
>   }
>   
>   void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len)
> @@ -2179,7 +2179,7 @@ audsettings audiodev_to_audsettings(AudiodevPerDirectionOptions *pdo)
>           .freq = pdo->frequency,
>           .nchannels = pdo->channels,
>           .fmt = pdo->format,
> -        .endianness = AUDIO_HOST_ENDIANNESS,
> +        .endianness = HOST_BIG_ENDIAN,
>       };
>   }

Nice. Even better would be to use QAPI EndianMode.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


