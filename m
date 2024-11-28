Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325BFD6910B
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 13:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGeas-0002jT-5O; Thu, 28 Nov 2024 08:30:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGeap-0002dp-5V
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:30:03 -0500
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGean-0004nz-Kb
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:30:02 -0500
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-29692ad4b42so466683fac.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 05:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732800600; x=1733405400; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/bMoHKtp6xZV5ue9WuzY2PnbOAun0gIzj8xGddf3e10=;
 b=dP1NpxsSbUOGzUGB7JSy2pKDO++ij+0sEK+gHYNsLvq8XNPbm1VqoTfXNBKghq5h/O
 pNjkxxHeDlyHvpo5s4LwbaqKnXbv3tDO9OgCAceZ8VGJnozWLDjBBztewBOh/sbYeh5G
 McguiUkBgRlWSrNS15UnXa8zzydO0QRJw6OH5SbEcTW0xOJ92OJWR3sAIQJ37+5+19vl
 MZkF7RrdRRWFBokRunSKroGBUrhNBnoG0SOzUJrfZJqFML2bLzNWgRgXlQCF3ObKJAKH
 Zw6kYGmg/2rw3NNQLucpfIFD7hbMKWwXCWOBCqO+0jCN4vQ5zbGZMsu1Y2sUIQiY+WKK
 6LDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732800600; x=1733405400;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/bMoHKtp6xZV5ue9WuzY2PnbOAun0gIzj8xGddf3e10=;
 b=i2UjfnPR0Y20sBx8P4lWbcytug1S74TSyPHgc1uiXAVjIn+kVEdwpnMhm8ffdYCk3r
 xwinlIqP/INSdePFz/o6Zw9hrJ9Hvw6Ch/OUBimiN8EtjMtUt/E76Q3FXmFajD97Osba
 pfc9bUGoCEbMFC35v9qpz2Fz2ycn3+nrC74a8MXjOpW7l8Z9UeCiJTjsnLYAjyDgWgxd
 3zm1lijvwul/Sd83L+7qSg1v5X7dWBvikDprOqFqPQL8lxcCqs9VTfwnOKG8ETBcCGY/
 /YBigZz3AfMsRYLHuETwyAKrt4eZgjMX+1nyvLq32/HfRQspwapEsOFgkg5nopqJTrTr
 VK9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDx6X/ouG96Gy2yBLbnzsYXoWrBOZGETZVGPCg8fJkk5MTG07TnQ+Nx6o17zekJIuN3GKK7tz5tebS@nongnu.org
X-Gm-Message-State: AOJu0Yy47b/XfnN8WcoGWnya4U3rKu9Xcpxtg0wjue7w6OnYRLxHPus3
 YTNUF1+r9lcwNipSeg6rHZKXeTTrxRZbEutfIArWjVlUkmymLdrQcKIxZc8NITU=
X-Gm-Gg: ASbGncvB6gGykkhzTmXRLQPcDbVFEjwSEVSq0H+ZuwhefyVr5R0Lv53nahoqwfxJLj5
 t3Oc1iBAmojBNnZmu5w2uxSv3UtbN9Kz69MF/PbPEOaCMQut/8ipP5x9nrNwHz2p2qQ72JiM9Sw
 fAM9B5xWknytExUZtxDJszE5AvB6TZy+QptnMzPsoCA/m+oEZIiyPrMMFnGUAZc3uMwpen0pU0m
 WndpLL7MvssBWRpatKy8whnohncE3DnouwfVHN21beg3IBJiw3GBkKViOVR/1aPR2lSlLlbfUrQ
 iTbyfv5F9b1jRKKr+0IYpPsGxCJo
X-Google-Smtp-Source: AGHT+IHRifKaDVg26wKdT+qCQc3huApGjdb3OaWeY/Dm2qZpfMllSZuTqXPVhNKoUQ34wG4Gj6viQg==
X-Received: by 2002:a05:6870:ed99:b0:296:df1d:917f with SMTP id
 586e51a60fabf-29dc3aa169emr6501201fac.0.1732800600180; 
 Thu, 28 Nov 2024 05:30:00 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29de9bd87d9sm390158fac.50.2024.11.28.05.29.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 05:29:59 -0800 (PST)
Message-ID: <b3d2cdea-b328-4971-a319-8bb72c3a910d@linaro.org>
Date: Thu, 28 Nov 2024 07:29:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 08/25] target/mips: Set FloatInfZeroNaNRule
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-9-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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

On 11/28/24 04:42, Peter Maydell wrote:
> Set the FloatInfZeroNaNRule explicitly for the MIPS target,
> so we can remove the ifdef from pickNaNMulAdd().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/mips/fpu_helper.h       |  9 +++++++++
>   target/mips/msa.c              |  4 ++++
>   fpu/softfloat-specialize.c.inc | 16 +---------------
>   3 files changed, 14 insertions(+), 15 deletions(-)

Lovely.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

