Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC03CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 11:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ8zv-0002hk-4v; Wed, 12 Nov 2025 06:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ8xd-0001xZ-L4
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 06:24:26 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ8xb-0002zB-UD
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 06:24:25 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-47778b23f64so4936275e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 03:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762946662; x=1763551462; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gzaiqqp+47SpXbLlFSUqvQI/SUrKPLoC47TXdBE2skc=;
 b=e2cz1+y2VQgs9ooN9rhPCjOVo+9mJ0R8Itdjl09/sUdtw4f5C5n6R9e3cR9air59HH
 HYd80MzOCK5Np9gsIV3ht8QSHTS/rTs/xVXtB1tbHZPNzET7+sKoJNmWB491VIToxlj7
 L2Rnr4S8ZbWrJSc7IE+mXU4EOpp4ttGO3PV/puGXAs0Y1ZiS06rgnOs0o1nEvhK2ARmg
 xDj5CO2l1/yx4z9Bwczrxv8nY8mzXVSIN9xnoNWv/3yCvZiYvHFYGUk8EBBGdg5vpv0U
 UwR8cLV8uWsEXi8Bs0vsuWl9GZ2fYGWdug3dT91uO1+0W9I3jrEFM8GrnTww9aqb9ttp
 gnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762946662; x=1763551462;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gzaiqqp+47SpXbLlFSUqvQI/SUrKPLoC47TXdBE2skc=;
 b=DOCxil/gGAklx5OCNbQNuJASB/YTAdx2pfWy6H+i/FRH0e/NigoQQq0VX05S+RQyqh
 adcWIoRsZn1BnBw8KB7JqHjxIPuxu/vDMaLIIAKAfupOoKqufszNgo900c+tUOxXbFHC
 z/W3zTdCvOKWN3E0JQIE4AKVgBNLEKA7PDsnK8tpEMBKeKa4KDW8VMGYuT7Yga3C4aof
 1gL4Pr00RiMuLkQlgS40/vRrY7ADWXGgkZmO1ejlbt5O9y1hmkCW3gijrvtE9iEi5oqc
 o+vR68WavHbyw/rT9S+MOu8Bb62IALBLJuiJID7zCxuAbBd0y3VpK8Pr8Ye4YQtddKir
 Cqqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVetsMsksJwKI0fIXDUhjtYHFla1RUZjvmYL9DLg2GUqUj3o0kvQuh9r1bU4mUy2Gw1KWn2hrEk9O7N@nongnu.org
X-Gm-Message-State: AOJu0YwRDQGi5SeYDLhNvg+oGteBKzxJC2Xk2WsXEtvz8TasbLhwTao8
 09cL+ocm4Ix6ZLJp/Jy0VruW9or83BxOwkx2K65BHCeeo1qWZUnQz4lYaJzu/xCHOVY=
X-Gm-Gg: ASbGncuPt+pPaCD35KczXJG0i2lg0ySL3+wPnorP/Ki2M/aw5AeUf5Ja3SiIwlIk1ab
 ine9Q+qOM4H9Hptk7Q2dFFuzsPt/Gjq7Y3gmgFMYjjQypP1BW9CSL7nHA5fCxlsPvyfefMLvBPm
 NBRn8dqsyKglHk7KAEB/N8vSr5QShfgaOq8b6A1r2YKQfZk3zZFRqVFGbku/5FaU5M/dZS1/1W/
 zwX8zCq0sMX3Gujp4CSAA4DuNcandO3UG7GN63ieNYbaD4v50g16jFYQJdTsG6Dblc8r28LM8pL
 qC2BQujDj/shq84OChoSbXKLR673Lc862gVvFn/n7v3iXfC2cu8n9U278g9KTxNrcaXtguiRf/i
 KcG2OXJZ3Kt1ZBid45Q1i+rM7T8nzgIC9Cb0PbmRbXH03pLlTYeflKCYgOCNlizfBc0q7qqweSf
 z6ta2xk39CxZgroYusxJhlZEBwz06KZejeTX+c37yEVVM=
X-Google-Smtp-Source: AGHT+IFEs8TpwK//5MV27hqAZaYFW75LLAYiBRYvecpXeKmHi3aTjRocS5Y3ooGzJvFUa6uno5swUQ==
X-Received: by 2002:a05:600c:3114:b0:477:1bb6:17e5 with SMTP id
 5b1f17b1804b1-477871c4b45mr23475695e9.30.1762946662186; 
 Wed, 12 Nov 2025 03:24:22 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477889bfda6sm11445395e9.1.2025.11.12.03.24.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 03:24:21 -0800 (PST)
Message-ID: <9bc047f0-1122-4381-ab5a-01878a10297e@linaro.org>
Date: Wed, 12 Nov 2025 12:24:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/15] hw/timer: Make frequency configurable
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
 <20251111102836.212535-2-corvin.koehne@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251111102836.212535-2-corvin.koehne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

Hi Yannick, Corvin.

On 11/11/25 11:28, Corvin Köhne wrote:
> From: YannickV <Y.Vossen@beckhoff.com>
> 
> The a9 global timer and arm mp timers rely on the PERIPHCLK as
> their clock source. The current implementation does not take
> that into account. That causes problems for applications assuming
> other frequencies than 1 GHz.

This change makes sense, but IMHO we should model the source as a
Clock object (see docs/devel/clocks.rst).

> We can now configure frequencies for the a9 global timer and
> arm mp timer. By allowing these values to be set according to
> the application's needs, we ensure that the timers behave
> consistently with the expected system configuration. The SoC
> configures the device correctly.
> 
> Information can be found in the Zynq 7000 SoC Technical
> Reference Manual under Timers.
> https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM
> 
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
> ---
>   hw/timer/a9gtimer.c            |  9 ++++++---
>   hw/timer/arm_mptimer.c         | 15 +++++++++++----
>   include/hw/timer/a9gtimer.h    |  1 +
>   include/hw/timer/arm_mptimer.h |  2 ++
>   4 files changed, 20 insertions(+), 7 deletions(-)


