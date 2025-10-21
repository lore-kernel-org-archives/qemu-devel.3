Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17DCCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB97W-0000fM-58; Tue, 21 Oct 2025 05:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB97U-0000fB-IK
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:57:32 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB97O-0002h9-CE
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:57:32 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so32598475e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 02:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761040644; x=1761645444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pIBZ4Jew2RVd88u9E5nlIctQWPrjD5txu7UPCEXUQxI=;
 b=PG8ehDn4JQQ7INZfA9ToF8yXWq/id3zHn6Dl4UiRIfUUDh5r3Q252cDJqE5U6Srws8
 szxntpFLIfS/lE9tWmxFQaUVlMjEZHqBiwLmnT1r0Ha4fEhPVhoeYWXY74ZMUqNPmcSF
 b28AFPqSiWHRA3nYmoRlJ3veE66+JXsZSm1QwBXr3yMgRNz982lYnenepgn2Gi7Z/lWz
 ddhoKTpdhH8j/U6tDP/liLKwkdm9HK08c3h9rSzGe71Wqm0tm6u1cMFsD2Vo9O5Zi33J
 CAiaVt+JzrslxMIfTOy5EHca+a6RAtC+LsWSVyde08gQ2I7o4gAZJqIICQLkQdG2kIzd
 mNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761040644; x=1761645444;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pIBZ4Jew2RVd88u9E5nlIctQWPrjD5txu7UPCEXUQxI=;
 b=rQ2+ITuL38Dq4/cGI7AUujTDhl3KvFx12PV4a2hpzVBRmHVWnduUccBgBqQkB0AYL+
 4ZzUHMa819BFltLbuMMHEp301MqgtigsS7o8PraHl32kwoQvCnp89z/I3rJSh89/IIsb
 FRFZzGds9fbgzSkcoRo8IV1GHlZf8PVtcp7JZFaD8vPhcP1FxNuGOLob0odltUaaoNXx
 V5uZftBR/UBZOrxnO9mXe9qieEvUql+yEBB5YyAOxKi8nJBBhleQc4mUzIGZrap5zZUw
 dA9xk23f5csB56Xusej5GGwsP1Qa2YqUgVJcegEyqth8wc4ZyjEqg+DJQqmWG80mfBNH
 isLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRx4AAFVEb1M1kSPwzWvYlA0P9LVlTwb0KFzk4iomLt2PezARlB9hYsX/I+yd5ygpT8ks7opY1uQmH@nongnu.org
X-Gm-Message-State: AOJu0YyLlONeqS47kIfWKzk0B2AyCYxrFdNeZqfekSiYwGzPY7xTC/3R
 WQ5MLtMaQ+HOORRYPgvIH2L6wjP8+WSdNtOxlaD70gzJiocJn9BgIR1RsvN8NnBeduk=
X-Gm-Gg: ASbGncsLPJKfW76xLPGtPG8tZP9MFKYvvjWzcTSzrBEZcE2SQ95lzg4c3iPoTIj9CPt
 sNNKIrIR2JEuTC8r8TUBhRnymIm7w3BJrF7z80tZ/FtC6UvmJjck6NgKsJc7+wV9MwOZRzl0YJj
 o6blWRCgXfzn1qIoImZmnTaDXSKJfbxs2LcNopHd7fuXQ+tCdG+v50YM5M7nMYcSIw3Z0XtKV1c
 JhV76j0OJ7A+sswIij8tUgjm67SzfgPBuFwpCPa/WXi9OXKOaswYB4UoqFu6OG5hdLnro5hCXXT
 FuGbAVrpp5AC00sO+/d7V7BAo1mw5mwEKkYLLzQ+RK/KTS0Aa4Cw8L8WQqOBu2E0dz4ooyJprjV
 6ck32bHiuZG3LbjRlv0+JTYpyuz1Zhw+l5kDOtnje1bD/5213GxEnpc0no234B2mWwQ/6/fD/dN
 QANLkgyFWyxH94jCFZWIJoc4XXl37JWSHyLvp9jM2hqWg=
X-Google-Smtp-Source: AGHT+IEvk3Xbn/NJbbO6ECWmU1dnpx1pet8i1My2UeFRaG4W6SQ782IuItKFNXa/T4hNfw1/WYwyPQ==
X-Received: by 2002:a05:600c:474b:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-47117877525mr121923495e9.15.1761040644361; 
 Tue, 21 Oct 2025 02:57:24 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4715520d747sm211447375e9.14.2025.10.21.02.57.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 02:57:23 -0700 (PDT)
Message-ID: <addd46f7-1e04-4ae4-a598-660a0007b8cd@linaro.org>
Date: Tue, 21 Oct 2025 11:57:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/43] audio: register backends in /audiodevs container
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-18-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251021090317.425409-18-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
> QOM tree now has /audiodevs objects.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio.c | 8 ++++++++
>   qom/object.c  | 1 +
>   2 files changed, 9 insertions(+)


> @@ -1742,6 +1747,9 @@ static AudioState *audio_init(Audiodev *dev, Error **errp)
>       struct audio_driver *driver;
>   
>       s = AUDIO_STATE(object_new(TYPE_AUDIO_STATE));
> +    if (!object_property_try_add_child(get_audiodevs_root(), dev->id, OBJECT(s), errp)) {

&error_fatal?

> +        goto out;
> +    }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


