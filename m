Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD84EF8FEE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 15:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxo13-00074N-Kl; Wed, 04 Mar 2026 10:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vxo0u-00073h-HT
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:19:54 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vxo0s-0004fm-SV
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:19:52 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-439c9eb5d36so667403f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 07:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772637589; x=1773242389; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KHdlh+QmHi8mH8dpdlQhPpgU7GMnD8K/URT6dopr9n4=;
 b=KncajCkhlD0NAHTPxpKFEJSN/yw9O1hCJc4G6oLGSfbaiBl7v6ungjXkrmEWRl3AVN
 cup8JFfN/uFOdVVXbtdu0KU4oZqyk9Rs5R+cYRw/PrFgINI1aeA3KR1mtxFcKrPqfdjf
 R8x+4r+aiZn89o/4GSHRsovXH7QsThJR2qTIOClSdWu7uuoeTRv6ci0IJszfXE7PHDg3
 Zt7zxJOigEUpRM9w9u972NwJSgApZKpan7om/3//7n4HUEDgU+/nHfH/MzF6xU4Env/P
 yfX5duhzZWrPc03pwLo1/WA4yCJj6lmMNbo9F0N0M6yr/ZP5uiH/VE4A6ecsx1UU3oH8
 c8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772637589; x=1773242389;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KHdlh+QmHi8mH8dpdlQhPpgU7GMnD8K/URT6dopr9n4=;
 b=Ewnwl97/JZQ+5ZGDT5g15TUhMrosvI9LaeN0Fcq2S9zlwH22DXRtw8EX1Owu1DiE5t
 n+gg+OstX8Pc6YWTsDKyFFF0id1g1HlMBFvgSSe6MLZ6tWYgS7xPGtwx9zb0m1CSHd7A
 T7BRMGT5lkjBpV6ynRrFHdC5PECL2rJpLaGASEUtVmbYdNVf0g+QM41MLGq/uumXlj49
 MvbFYEYjJuqGdyfBON0ycy0GjaVdxgOh4QZV+kwVrrEYjiv4QVQNl/V9Pax9kVjsiPAb
 6jECBohr/340VI8a3GrG9D1OxbYONNkSUPG8U8A/QIJ0Ojs8+HeYWSF/B2IoX1+tj0H+
 TowA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6nTXkHWbzJUsl36eUNubcV/Aj6ywYEF61ywlv6jh1oIbQS2bI1iTBpz8txtQYqek2GlvV3iFlMQ3C@nongnu.org
X-Gm-Message-State: AOJu0YwJ/HeyUXR7b5Z/GtSiCotUmfHYD2k4o6vMbPmjQds8GasS8Nxv
 h/myZ8rlboQi7NChD5g9+2FCifPlJL1Q4RkV55g+d0ClM1B4iRMHimujV2fkkfxptYs=
X-Gm-Gg: ATEYQzwfX6VCmYPuChs96PU/H/iw6qWy1JxxMSJB/vncu/qyvmNKDjlqqDa5s0n9XcA
 HHflFnkB7y7zlKup2nJdCr0tNST2TxxN90uCHNRnzhWFVOQwwZ5vOuiv4STMTwZMz9TR86q511r
 sAPhNVuuN9c7z4RfJE6hlE61e5iDtNMAbyAZVl9Vc3nAhvAJy8n+WZzOMy0AV5SHFRwQOSFkFQ0
 Iqd3oWmq47EYQXIJPp3vExQd5C0JHKSnQ87OPQQ6rzYtLCsErn41ffNvQ8lIbs0z+8qGVXAN8PZ
 0DcFfi5eNGnYhy40QKmZFyXG6AjeFgnT/wEUNWRoWEP/ZC4pGJHOcWuKx8KkNSGJb3dJG16OJjt
 iKhRPUOLWTGiBJB3brRYv/mSjkVAT3WOY7UyPHNgKjtaO/krJj7th/NPN9mFIKsMzFFLzlSe6wz
 9ZBZ9D5BDMCPO5PeSvKpgBZkSEYFo+ODDm1XS2q7TH9LHNSyXbhQv7HPbKN59yc9bAOw==
X-Received: by 2002:a05:600c:3b21:b0:480:6852:8d94 with SMTP id
 5b1f17b1804b1-485198955a9mr42876505e9.27.1772637588688; 
 Wed, 04 Mar 2026 07:19:48 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851ad0ad2fsm21352735e9.5.2026.03.04.07.19.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 07:19:48 -0800 (PST)
Message-ID: <b7d78917-9e28-4472-8418-86bbc26465ac@linaro.org>
Date: Wed, 4 Mar 2026 16:19:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] hw/arm/aspeed_ast27x0-{ssp, tsp}: Do not access
 SerialMM internals directly
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Troy Lee <leetroy@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>
References: <20260303222143.142741-1-shentey@gmail.com>
 <20260303222143.142741-3-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260303222143.142741-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/3/26 23:21, Bernhard Beschow wrote:
> SerialMM inherits from SysBusDevice and exposes the memory region by
> means of sysbus_mmio_get_region(). Use that in order to avoid accessing
> implementation details of SerialMM.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast27x0-ssp.c | 7 ++++---
>   hw/arm/aspeed_ast27x0-tsp.c | 7 ++++---
>   2 files changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

