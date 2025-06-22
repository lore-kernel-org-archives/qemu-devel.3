Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA40C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9nD-0000ut-Lp; Sat, 21 Jun 2025 21:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9nB-0000uU-Gm
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:46:45 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9nA-0004NO-3Z
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:46:45 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-747e41d5469so3174991b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750556803; x=1751161603; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i3AcVeavouZy/xtvabJOaNet5h/MsugBbtcJnXkg8fA=;
 b=xv3LRSYa+JHbMUXFk8P3zI2Y7ioVJ/WGA3xKTW+KEMG8gc0C/MDwILI1FxH6tt4+Dc
 6SoKFd7dbScNKbFJ59DMsnEuZwRPMulf1Hj0Pr/GJIB9dawQKQq1JyC01FXuJd7sv+tb
 +gr93PhsZYoDuXFNyuvuQlIdO5Yq15v7mW0FX1paiFhbA+N1IGxn/0TqQ/NRdpAdnjYt
 Rp/+XD4RwIQrvFwsvwVPfunitK/YlTYEsWeH9YBtiSPZ3uwgYrbocDPq5dOvfMF7vm2q
 uEzEgBquC4orSaSK+Yb35IcbX2xoBitPl4S+iQ/sLhS3CmdpZNLpe3/zxJiN8BGYFIff
 x5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750556803; x=1751161603;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i3AcVeavouZy/xtvabJOaNet5h/MsugBbtcJnXkg8fA=;
 b=TeCm0OAWhzDTzZ2zxrJP8IhQj16W7TWFEwIGX3G69CroQpoFWK1OdDmle6fI1TtA/H
 7etJwkkNhYfK/0iALiHjNow70eEgOJAQF9ALTP+zWIuKC6V24SmxG3dymZ/X45D+4RWd
 4CduRLL2dfRg+x7ZU0+PzLFJMI33Xzbcdnh4faubBn95NJVjFF8Np2bW3Jt24UU5uL1m
 bOjUVH6uOFMqaCA6Udm5xQ1dIKjRd5iNbMRcskR9fjpLLTfrV6EkaYsVeOEHB5L0AULH
 w+Q+e960kCW5gwLF9xq74EP/7feMK8QcWnu85z9mppkxy+odqcbxXCBdneZRnAflBbI3
 78Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv57SuKx40O55EB/9cJMWFavYq1l5zl/BvusziZRat3P+E8INDCmy9WwOsjBFiTQnLQE43ZGkgrZtR@nongnu.org
X-Gm-Message-State: AOJu0Yy4PJE/OoFC9kEp9hKZGdb8kYakHP6s8GnA/aqW8U0woQ1dmS09
 KUzukhAS/I0+R0jgAnv7TtVe/q+Lval4NVPSM27F2LeIA6EsEXwettgD6s/ZZ1bmJCsUg+hE9xF
 KGJzNi4c=
X-Gm-Gg: ASbGncufUZdTq9+asDIUw4pa+bxIUKW74vH++mLXc2iyZyWn6cG5NCzclPM6S/q7wen
 VF5twFNowM/+HHdKRPslFt8fKgSrNKGBY4JAJQtP1xBu7VCOzy9Om6IDvZw8A2jWJaSvffcILOh
 b7fQzGaDDE/Vp7XAFIBtbX3t4ZqQnrk9eYYeTEpnjSUuOl4eMJpeRmw0CBmNzWoJ99nYiXdG3PC
 QvdhiIBBjKdo9kEPQ7bNw3C5FUj1BWgb/VA67s8K/Fq8NcqEoxnhGflkj+DclX89ajO5oXHNpeT
 u4EQL5uRDiSXu+Cdgr5EhhggoQG+O2/zCEvrWnFVGp6OflwBqYEUJmvFhN84bR8XHnEeOsJBeqr
 X1sSi8y1yp6bwDwwqBqjvwvHqrojjvRhWznltsoQ=
X-Google-Smtp-Source: AGHT+IECnXGewTfRGbRuWMvriD3nYa3uaNvRrH82X4E7liSyfPZ1taEBmH88zOzIX37odG6K/X+DXA==
X-Received: by 2002:a05:6a00:1914:b0:747:ee09:1fd2 with SMTP id
 d2e1a72fcca58-7490d630890mr11714826b3a.12.1750556802702; 
 Sat, 21 Jun 2025 18:46:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ea32sm5274838b3a.60.2025.06.21.18.46.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 18:46:42 -0700 (PDT)
Message-ID: <8ee00533-a25f-4e2a-8706-bc3a8f562d69@linaro.org>
Date: Sat, 21 Jun 2025 18:46:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 26/48] accel/system: Document
 cpu_synchronize_state_post_init/reset()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-27-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-27-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/accel-ops.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
> index f40098c1c92..b1b9dce27d0 100644
> --- a/include/system/accel-ops.h
> +++ b/include/system/accel-ops.h
> @@ -43,6 +43,14 @@ struct AccelOpsClass {
>       void (*kick_vcpu_thread)(CPUState *cpu);
>       bool (*cpu_thread_is_idle)(CPUState *cpu);
>   
> +    /**
> +     * synchronize_post_reset:
> +     * synchronize_post_init:
> +     * @cpu: The vCPU to synchronize.
> +     *
> +     * Request to synchronize QEMU vCPU registers to the hardware accelerator
> +     * (QEMU is the reference).
> +     */
>       void (*synchronize_post_reset)(CPUState *cpu);
>       void (*synchronize_post_init)(CPUState *cpu);
>       /**

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

