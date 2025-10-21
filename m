Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01342CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB96W-0000Ad-I7; Tue, 21 Oct 2025 05:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB96H-0000A2-KP
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:56:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB96F-0002cP-Qx
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:56:17 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4712c6d9495so5739635e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 02:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761040569; x=1761645369; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KAmkQCTaxAT6PBrWiUY065eC7MQ2e2AFbq60RELbvGc=;
 b=wsak/vYkBFWsbhIlRSIpR5hfQ9uUv0GY9qeeoqz4vYZOgkZUYKsScAsNDKeorcLry7
 lvDXIvTlOdEQdggvousEJABkMzNuhnyc7Yci6tmbDDEjD3VorRel27reQCojmFIWy72n
 lvH7qElOdFkaiHhXt50MQDul06yAgHWt/7BBbSXxO8pmLMgsDZeIjfGoOvqp7b5oj1G7
 MrkOhCmeoI5WVyBWYgfdKOdK4GPRgu5qWjIFpY0VZvXKaROk6fwH1T29lY+8cbswQ5qo
 HPgNNIVlRIwJi+fP+ocFo7ZlDLM5uN1iYDeVUEYq4R9ndbqJLcNsdttBErUMi4hb9SLM
 XH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761040569; x=1761645369;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KAmkQCTaxAT6PBrWiUY065eC7MQ2e2AFbq60RELbvGc=;
 b=YKm1QKqj3L+riddNX2+xwufaQ/5z6e50tK3G8b+r6TNCvtm/1UuNCV29//a4SZp8xJ
 tPPG5LYY8vvkV7cNZsZ7I0cMTYiosmQsbGok41349rSrQf6Db0Q11HJgfnyt0v9PxGBO
 0NDH7qYyf+4GYXyUCVC60Ry3mRof2ykJ5qtuXTTBmUeBzDnDGdQtVMltfJPGU1M6NyPN
 bOFPus/gRYwOmvuHO/n5lHJEhro0UppRpDhEA9cI3nAYWTOVSV+NSYX1wiwKAzKnPTMe
 7XCwi15c9i8jSdupwy5DRCHLliXLJ34UEtLYabvVhngFjLoXRTFqvOoIBptUxUkhYLuS
 NjzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmkZvX1AlSxnYGOJl8dzNZt1FPSk96DdGvS1sUz/acPclNJypHl/9ebPyTBsgB+47o/DsIK98cuf0l@nongnu.org
X-Gm-Message-State: AOJu0YzrjV31D6PeYj1+NNuQrps/czzXuZXVG8G+HG+lqDIdyhNZTHQw
 ZGoOKDO4OhNvfYGweuKQIfh7wYOSxg38d1k2d84VVizZgXIpMLm12is6C9G6elogBpw=
X-Gm-Gg: ASbGncsLElwAoHJkJvQR6e/th+GzhO8/idGk3r8qSA7+EF/E43T9WIfl2NX586NM0b1
 DqrpRWpUakbKLRBmIwa997sHxZDY2p+YWyo/33y9eUX1nLuzoJJqnTy+roqh+/qLhKGAdAO4bfO
 6dkhD/wkUftoWAiI2v7NbKGmFbvHDctx1Z8JL75/y+vlNJGwSZoWIWPe9+0HufyvNVm6b6uTKm1
 tGvVXe90czPgsiCiu/EVD5aT8pKbzpASZ8iXckNSQ7boae8HNiTLp8du8XoJyc6+/zyjT+lVxAO
 JYThD6xwzVanIwqxUa8ZfRzuirul26DtXDPE0rcussBPA+Kle38hSShD9m/Vc4Igs8urGTfb1/8
 1xQf9IAlEwvHXoMVh7l6YBwMuS0uspEy1RHkFrZxzXfyYaxMHojET9KcP2StJS6fdl5LexppCDO
 P5jJ6lBc9KWmnF2OtZW9Pk7JF6kVFT55a+ZZnuJgmqyjE=
X-Google-Smtp-Source: AGHT+IFO2AV/KG4SokWtVn8VuM90pD8ntgqXREF0c0cMI15D48ldhIW4ifBU+zcEZ7Pfsv/zbFI/wg==
X-Received: by 2002:a05:6000:1863:b0:3eb:2428:4a05 with SMTP id
 ffacd0b85a97d-42704d83d68mr11683748f8f.3.1761040569366; 
 Tue, 21 Oct 2025 02:56:09 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3acfsm19353635f8f.14.2025.10.21.02.56.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 02:56:08 -0700 (PDT)
Message-ID: <67a24748-c7be-4492-8ddf-f17a5918bb0e@linaro.org>
Date: Tue, 21 Oct 2025 11:56:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/43] audio: start making AudioState a QOM Object
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-17-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251021090317.425409-17-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 21/10/25 11:02, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> QOM brings some conveniences for introspection, type checking, reference
> counting, interfaces etc. This is only the first step to introduce QOM
> in audio/ (I have more in the pipeline)
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio.h     |  8 ++++++++
>   audio/audio_int.h |  2 ++
>   audio/audio.c     | 43 ++++++++++++++++++++++++++++++++-----------
>   3 files changed, 42 insertions(+), 11 deletions(-)
> 
> diff --git a/audio/audio.h b/audio/audio.h
> index eb5b5d662d..f56a8c8baf 100644
> --- a/audio/audio.h
> +++ b/audio/audio.h
> @@ -80,6 +80,11 @@ typedef struct SWVoiceOut SWVoiceOut;
>   typedef struct CaptureVoiceOut CaptureVoiceOut;
>   typedef struct SWVoiceIn SWVoiceIn;
>   
> +typedef struct AudioStateClass AudioStateClass;

This typedef isn't necessary, as done by OBJECT_DECLARE_TYPE below.

Otherwise (modulo the // comment in audio_state_info):
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +struct AudioStateClass {
> +    ObjectClass parent_class;
> +};
> +
>   typedef struct AudioState AudioState;
>   typedef struct QEMUSoundCard {
>       char *name;
> @@ -182,4 +187,7 @@ const char *audio_get_id(QEMUSoundCard *card);
>   #define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
>       DEFINE_PROP_AUDIODEV("audiodev", _s, _f)
>   
> +#define TYPE_AUDIO_STATE "audio-state"
> +OBJECT_DECLARE_TYPE(AudioState, AudioStateClass, AUDIO_STATE)


