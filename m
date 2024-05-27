Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1FBC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 09:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBX6S-0001nR-KF; Mon, 27 May 2024 05:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBX6R-0001ms-6E
 for qemu-devel@nongnu.org; Mon, 27 May 2024 05:57:15 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBX6P-0000bu-Hr
 for qemu-devel@nongnu.org; Mon, 27 May 2024 05:57:14 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3550134ef25so3288670f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 02:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716803832; x=1717408632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PFtt2bKZ6/DT9ANXXYNtjj9q8dLUfprQ0zoGjZv5Zcg=;
 b=CxPiqo/3o/EQu/BjLOtT74v9XyYaROrx/EYBfkCOzhHP+0J3kX88iNPdoOITZk8mWN
 6ABHJpRH4cSS5QjfJaUCvGhEiXRRZYHvDHKA5nkcaOIDW6BMvNdjJdzJJB57XKIjY1L8
 o9gSxa44JQHJOB4qhT4JRLWbN0rcoWsZ3CyIQVFF9b86AKgPkP7m2nOwaWEfeXBnjq0g
 t8WMiT4i3QdvScMAVGA22hx8Kdp1hmk1XkCLd1j5mU5P24ebEoh30RVidoIalIfNAxLP
 ekw5lyXOWlJObjlACyimqt8WROYJMiYhB1xMqrZg/y7Yk+IsooN/MLrv1T0DNraoslnh
 xaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716803832; x=1717408632;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PFtt2bKZ6/DT9ANXXYNtjj9q8dLUfprQ0zoGjZv5Zcg=;
 b=jwHWxse+FLFMKp6m8k0BpYEtHIe4CmHhpXzvJ5vFZAA+wCDeuF6c9S8w6O92UqGRS4
 4biC0OYKBXDFJ8Pjjyh8JMkseOzBnbpmEfGt8042i0XvhSlCUo68OvGoUS+BGUNFPE7C
 nhlP0ND1dY5kdIWu0+VEgqvamFoB1Sx0ROy1COeFw6a6KIdk+ZAf8yFb50qHJ8+1rO3+
 2DLdE6nnvu2PSvEndd21FT+KVT+cnQHu9ufO2jjJ7zw6SNO5Upmx0bIbfkoUL+VhXJrc
 q2xwjHn1w2Vhrr5AG+9l9xwkwm7Vg2+LJoJfI+ITwv3rCoZDYvwvtbTFCzzlwV609Ret
 McTA==
X-Gm-Message-State: AOJu0YxRtHrwSifth22wEMf09JDIlNxqdcHjslfB5bVBXLcfNumbfV1F
 ltyqgmgFx6cJ2NdghGdt8dKxLfZuJBOOAeSqmxaBCinQOjzpHRP2G6yUvErjXeg=
X-Google-Smtp-Source: AGHT+IEYyPrKU5IkULvcn/hNGNW8joaXOHJtH5SLMTvdOroMQCl00J17VH0M/qN4axtUjdG7U0UxPw==
X-Received: by 2002:adf:e907:0:b0:34c:719e:6786 with SMTP id
 ffacd0b85a97d-35526c19185mr5885066f8f.4.1716803831861; 
 Mon, 27 May 2024 02:57:11 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-358a33e6f03sm3391916f8f.36.2024.05.27.02.57.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 02:57:11 -0700 (PDT)
Message-ID: <a972e12b-398b-4843-a7d5-1fc66fd03bce@linaro.org>
Date: Mon, 27 May 2024 11:57:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] lockable: Do not cast function pointers
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Michael Tokarev
 <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240524-xkb-v4-0-2de564e5c859@daynix.com>
 <20240524-xkb-v4-2-2de564e5c859@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240524-xkb-v4-2-2de564e5c859@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 24/5/24 07:35, Akihiko Odaki wrote:
> -fsanitize=undefined complains if function pointers are casted. It
> also prevents enabling teh strict mode of CFI which is currently
> disabled with -fsanitize-cfi-icall-generalize-pointers.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2345
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/qemu/lockable.h | 23 +++++++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


