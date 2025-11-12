Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BC5CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 11:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ8zy-0002l1-07; Wed, 12 Nov 2025 06:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ8z2-0002HS-QT
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 06:25:56 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ8z0-0003UI-QZ
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 06:25:52 -0500
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-42b3669ca3dso353535f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 03:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762946749; x=1763551549; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mEizBFDht0ll0J0V1XRv57eHY2kSVW5JoM7uZh78NhI=;
 b=y6g/N7eQL8Jdb4h58RYA19ytlXEGL91VwQHcxERtZ1ydys5xF6W5EdRE7XPR0dn3or
 BsFQ4+6aJZVScp4/gtrS10VPVYC8MK8+AT1pv7wV9Rq2Owk84/HJAQFgS03yQvsDKhmw
 pDjIySKEKj8gv6PdROll8xRa0R+gFgkmu3rpTVZsaThbNIPfCmSoBW12STKTPEzn/St4
 KvdIYGNYPiq0ZVq32Co2OgabD3Ik+GSDH+rIAvdI0R5vXmYRy5pQwca7aJpsw0ZceQyH
 zpuMjCJ5wgvrrQ8vqCJ2K6HZ5A9WXRwu1xY9I9kNruYTWdUTJiNPiBDRuSvP129Xfqfk
 qQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762946749; x=1763551549;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mEizBFDht0ll0J0V1XRv57eHY2kSVW5JoM7uZh78NhI=;
 b=m2A94F47kgc1MCK+81+kgIzt4HUUqDCuKwPaCQiXxUL3/WmjeaiHfGoWrWydBNrjXF
 RXAJIx8/26yg2+XtVII6yi33lG2gg0oLLkjrXXfe3nyomSxOebv8YCl35h/E2aueZnzw
 Gf4+bZ7ywMMtUhKCS5h+HuSUGX8bB1osn698iz8zpURrT1AA/nggW8YfBIU+SmW75vZf
 PX2gXC5gtS61B36MFkkDhApVbNTFO3LNtQVZ5hrM7DX5klI9uJJjeuXeH9uDJtIqjY7z
 nGciEujy+LHbTQoI04B8+A63tGBnsthuTyuHQ24jzSc4GTIbqayoqfhg4uJd2CN2oCku
 Bthg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMHyk48r3aRO2G4yU2KErT29B6H0i2yrZmlnUO/ZO9TamH1ZlCkuaJbdIdy3N4E10M3JhNgZCLudLn@nongnu.org
X-Gm-Message-State: AOJu0YzoTxctu5K8JLUUIwUbfiN5ZQ4hxsLrx7lBPeEU3BlHPIMbq50T
 heZeHSNKwyZeLNoucfhW3av8uTZPj6dNaosBxY2hoLNMZhuQ8y8zBkSqhBXU+QNsiHs=
X-Gm-Gg: ASbGncuiNmHaoGWfLKAFzQJ7XZMAPUf3B61xYrt7YPdyokpPkj8MOcC06vxUTUEx3Bv
 PhEH0wyEyMqpn11W044gluyt6H4WaWZ6s1vX/dRFj18IgyTxt8mTycfryrMYIIHCr7cl3o8ze4f
 8DYXgmfPcU9zRbogx2XS/8c7sAYMV/t5YA54JIduiCqwSLkdl5TflhpJFvpp6S1zCBBJh2x+dzY
 Hy+oa66454ARtEYlP7DnRUuvo6bwF5jBHLQRK4yLoQyx491QTVyyKm1aiZxcxFNrRsyNA4OB6c+
 O4M1wamK4bHhP0/TE9Z2QmBc74Jf5SiUWF7KTWZAByjslkei8nPezDw4EHyRSqBjZn7SSJzk/3H
 lHQvfnWBL/6ZDzUT3pHqcou8hXSpqpooKwccndFsBC//ylDkx4b8E9Cc86hKTxzUA5cYfavJBtE
 xhiSfMyyOgRpkiNdJjEiXCBL46YKo417mQ9Wob6YEvD9A=
X-Google-Smtp-Source: AGHT+IFdVGBcAAUyF+eBY0O7x1fRuy8t93QfJF/q5Ci5DPi84pYxTrBvxpVmRp5KQjJdI4X3D8IHhw==
X-Received: by 2002:a05:6000:1849:b0:42b:4267:83d5 with SMTP id
 ffacd0b85a97d-42b4bb8f405mr1854322f8f.8.1762946748665; 
 Wed, 12 Nov 2025 03:25:48 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac675caecsm33616306f8f.30.2025.11.12.03.25.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 03:25:48 -0800 (PST)
Message-ID: <70da449a-e463-4475-b465-112aa7c22e60@linaro.org>
Date: Wed, 12 Nov 2025 12:25:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/15] hw/timer: Make PERIPHCLK divider configurable
Content-Language: en-US
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Kevin Wolf <kwolf@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20251111102836.212535-1-corvin.koehne@gmail.com>
 <20251111102836.212535-3-corvin.koehne@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251111102836.212535-3-corvin.koehne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

On 11/11/25 11:28, Corvin Köhne wrote:
> From: YannickV <Y.Vossen@beckhoff.com>
> 
> The A9 global timer and ARM MP timer use PERIPHCLK as
> their clock source. The frequency of PERIPHCLK is derived
> by dividing the main clock (CLK) by a configurable
> divider (must be at least 2). Previously, the PERIPHCLK
> divider was not configurable, which could lead to
> unexspected behavior if the application exspected a
> different PERIPHCLK rate.
> 
> The property periphclk-divider specifies by which value
> the main clock is divided to generate PERIPHCLK. This
> allows flexible configuration of the timer clocks to
> match application requirements.
> 
> Information can be found in the Zynq 7000 Soc Technical
> Reference Manual under Timers.
> https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM
> 
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
> ---
>   hw/timer/a9gtimer.c            | 19 ++++++++++++++++++-
>   hw/timer/arm_mptimer.c         | 19 ++++++++++++++++++-
>   include/hw/timer/a9gtimer.h    |  1 +
>   include/hw/timer/arm_mptimer.h |  2 ++
>   4 files changed, 39 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


