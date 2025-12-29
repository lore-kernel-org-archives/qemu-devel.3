Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8C6D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 03:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va3nB-0004sL-NP; Sun, 28 Dec 2025 22:19:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3nA-0004sC-Dw
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:19:32 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3n7-0003o8-E1
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:19:31 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2a09a3bd9c5so77442485ad.3
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 19:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766978368; x=1767583168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k04jnO0XM3Hgvfy1tw4jFnx0ywoPtCdkCE4lQbbOrZs=;
 b=gWBQJUCmtyW6siXsGY7ck6sOyUx7qu7zxTd+4x/2eYlFjkP2SZ/l9H2C38toS6U0+D
 Ih8x6cRFQYn+QYDOP/3clvC5B1TsEf1+57LSUbvhFKxzuU9PGe62JyUglJt7nMlBdFig
 cBm812PlYBruL/wVonrN9CPqsQQTzYHR4CfeQvgWy8JeGL753mRJnw3m03qkYylTcQnl
 XI0/OvjBf2PXy0do2/SaebrGRnXCLgU399NVinnlJcTQnIq+nu37mhQpbS2MWtf6navt
 3WhidOcfPch2CIwsiq4NAnvfTliwOJH1wmhT27rPsUK5ir+N5PYYk11GFumGahrhTJfB
 m9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766978368; x=1767583168;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k04jnO0XM3Hgvfy1tw4jFnx0ywoPtCdkCE4lQbbOrZs=;
 b=psdj6puu7Id2Wje371532iLENCDRieJmGKBmzdBNlA4TkaRpqx1u49SIR3i80vR1fb
 WEvR/W3HZSQ/7o0Cy0iEwgeW1VYwOFxesbNkUao7dlqXcisVkMERk5mH3J8jPE68DN0u
 AlE5jWXjA8yfr5n+TVE9c9+NLItQzq1ecCKqQBU3PaR8ps3nF4D3IcNvYd+hCmlh/Sfj
 b+MnOtHRDideShxhFdwHzLHQlhMkZokvA25U5siUHiSy4UJzqPDhlCM03MOspkiO4wnN
 3NxndG/0zpeI+wfiuYlNuo1V0BYEvTyG2DWM93eazFY3cfI4YuPOxtErxJzFB8S+zMAP
 7vsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6FBq/Q5FBvxdREwsXMbspKZpoLlQfFPrAoX5f82uRgL/kz3gAQvLI4cTQGs6PmiYJjETpVzRl8JPL@nongnu.org
X-Gm-Message-State: AOJu0YxVTV+CFhFvFtirZD+eMyx7WYFV8YfrM3ck7E7aY/HopVtrzeUX
 fD/HaforPzLD0sFlV9nYVR57ZNGLyXDeztfoosHWmtlnW6EdldeBsAFs4/p9Fq09TTrGw4qGq7m
 nfkxjS/4=
X-Gm-Gg: AY/fxX7XWwMs7Qfv+/F7qc+BfFvGIy6bQNM3/+hQwy7wqG9aXC15j3WeJTSJKTEyMfJ
 J7Pub+XqQN1MVyFW1hd3uMhcvmwo04Ft3DGKPtcPS/O9KUiQeeQKV26JYcVk6imxgSdmq6p8XTp
 3/k9xsABDXRgACwCAfcbwOd+QNvHGTzSWlnzdIz/yfiLpaJWDguG3iu1NoOHBcUZNHpeR/2FRal
 Q9/fIzrZGmBbHhUWPktFbR3RJZ07TCu8Vf9hWyKWQKq/flZd2omnlI+79W+O1AnSNQ3dkIZfjhf
 /oI+WixTER+ELxnWNYd5erG7rM0ep/h3ywIj+H2REEIHjeP/N9VKfoQG9G+iXDgrPhODI/OUmH5
 /3KeMMotxOsNxLR122WSUA9Raaww2YYX8HnBT5oJK8Gr05nwAu7mMgLOBgo1zW//1PExiawK6g0
 DvPJI53mlenTJbNMXnYezOh/c7HNt4dh9x5VD/+9vPJMgvrtZjELOGz253eDYx/miyghwCX+TgY
 SXvIHwz
X-Google-Smtp-Source: AGHT+IGObBKurpZSlKoh9s2tWsNM5MwE2VvUzyBcLYhKoYotydkPQIbHOtUfNaPRJEJ8fvWfWtZ2pA==
X-Received: by 2002:a17:902:e552:b0:2a0:e956:8ae8 with SMTP id
 d9443c01a7336-2a2f22295a2mr294484515ad.14.1766978367483; 
 Sun, 28 Dec 2025 19:19:27 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c6a803sm254522525ad.6.2025.12.28.19.19.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 19:19:27 -0800 (PST)
Message-ID: <5570d1e6-3de9-4617-9c81-4e101335dd5a@linaro.org>
Date: Mon, 29 Dec 2025 14:18:11 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] target/alpha: Use explicit little-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>
References: <20251224160040.88612-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224160040.88612-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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

On 12/25/25 03:00, Philippe Mathieu-Daudé wrote:
> Alpha is little-endian. Use the explicit 'little'
> endianness instead of the 'native' one.

Technically, Alpha can be run in big-endian mode, but we don't bother.
This was only ever used for the Cray T3[DE] machines.  :-)


r~

> 
> Replace legacy ld/st_phys() calls. Forbid further
> uses of legacy APIs.
> 
> tag: https://gitlab.com/philmd/qemu/-/tags/endian_alpha-v1
> CI: https://gitlab.com/philmd/qemu/-/pipelines/2231223066
> 
> Philippe Mathieu-Daudé (6):
>    hw/alpha: Use explicit little-endian LD/ST API
>    target/alpha: Use explicit little-endian LD/ST API
>    target/alpha: Inline cpu_ldl_code() call in do_unaligned_access()
>    target/alpha: Inline translator_ldl()
>    configs/targets: Forbid Alpha to use legacy native endianness APIs
>    target/alpha: Replace legacy ld_phys() -> address_space_ld()
> 
>   configs/targets/alpha-linux-user.mak |  2 ++
>   configs/targets/alpha-softmmu.mak    |  2 ++
>   hw/alpha/dp264.c                     | 11 +++++------
>   hw/alpha/typhoon.c                   |  4 ++--
>   target/alpha/helper.c                | 28 +++++++++++++++++-----------
>   target/alpha/mem_helper.c            |  4 +++-
>   target/alpha/translate.c             |  4 ++--
>   7 files changed, 33 insertions(+), 22 deletions(-)
> 


