Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DACBC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 17:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYU6o-0006fV-JP; Thu, 16 Jan 2025 12:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYU6l-0006ep-Sv
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:56:43 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYU6j-0005ws-R7
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:56:43 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so46587315ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 09:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737050200; x=1737655000; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SxVBMO4QK5+wLS0LyhAYqV9htn2OkUJh24bvEfesID4=;
 b=lkwwpAMw8Fwx8tRmee8bO8Ct9pAb4vZwq2RgOhtPPvWfz8rykC9qHNu04jH6JTLV4P
 e68XcsAIG6TEgGhzRCa4Zn1aJLQd2kq/l6CC5nCZ3HLjHA5A0duL8mX95IX4jnOfGjOz
 o0QnFCd7/tRw5alR68qWIVpH0S9LPBP+ef292SCbNrUbAIiDcvwJVwTNBXzfo88KvZbJ
 uOHUfqAcxaoZpA2mKyRJCwtaI7gIxPF1auYhIVFtzD/m71GG9zVYaoAQlCmJYJFemtZ4
 6zxVXD6qyLqCUhwWPnWc2GjopjLpu9okmIWpIAazuXwfHIOuAWEhB/uxzLT+y1fL2VvO
 zY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737050200; x=1737655000;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SxVBMO4QK5+wLS0LyhAYqV9htn2OkUJh24bvEfesID4=;
 b=wJlhrcAmY2GioHDfm+kW+NoJMZVqf6EwiGkQ8GMSCF6fLsQAktRf9jmBqQLujs3kO4
 qxm2QltY71cZB4RoGl74XYRvvfYAAsZyHRe6WLIrPgsBYcwndM4rpuZO4+kx+NC9OFrl
 G28zJnfRXujyS9UNfan9W/451NnYkHW438wAI5aiTtU65ZQ97STyjwSrkE9O3LC7yodm
 0tI8O9VVA7HbLhk+zzlAu9M/6kB71M6DSgGmXBYYmRHnX5WZD5dJ69v48Y4jpg3G3ikl
 QMulDGM+yePLPa34JPHIiKHTUB/W6yHmHKYsTjrqy9rSGGmfvIMD1UrcR7quF6UT4Ja/
 CbVQ==
X-Gm-Message-State: AOJu0YzSvon3leom2EyfN78N/w+MrLGNfcZM8eyZQW4oM4Jbve4BR4af
 P62GtLi+AkKEyzbLfDvKjHsTtPkmgVYJ+YRrPCusmlpgSfDJ1r2kJgpVSWGJ+z8yBqSEoh2QfPU
 U
X-Gm-Gg: ASbGncvOUcnoQKdZMJkqQ/Tj+nIDMGkh6wAFLhAEzsaq76FjBK0IAga/81kf9VlFtuX
 pe5san58M7fQvQTbfAX+BcIaacO+aWQmdTCdPRZxFAgv++992CVgrkpFLjaMcswXSWaVD1seyFx
 Aa9bbGCqL/JqXo2K+0HnCmYWpfK76risnoxUxdbLFFvFTwFCEHbWdcrI9rt5PWa3flhRCoS4MDy
 WVlaBnz7mkMcgsGOHfkdAA0NpsxTwOW2l/5ZNpUrKIpeG/c+8I8BqKvX5MVMzSyG60rH+9IuyDl
 umGg57nsR5lMxY1sJRi3uFc=
X-Google-Smtp-Source: AGHT+IFq4sQFfytf4VtauTwH5rI8iQ6bfuhhqDP0o75l5mTrQfcAJEH1cdUQqE3L8nTUByBtJenUlQ==
X-Received: by 2002:a17:90b:3b8a:b0:2ef:9dbc:38d1 with SMTP id
 98e67ed59e1d1-2f728dbe3a1mr11596571a91.5.1737050200377; 
 Thu, 16 Jan 2025 09:56:40 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77619317fsm410514a91.22.2025.01.16.09.56.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 09:56:40 -0800 (PST)
Message-ID: <5940807a-ba0c-4ff9-a7b4-f62963774269@linaro.org>
Date: Thu, 16 Jan 2025 09:56:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 06/13] hw/arm/virt: Remove deprecated virt-2.8
 machine
To: qemu-devel@nongnu.org
References: <20250116145944.38028-1-philmd@linaro.org>
 <20250116145944.38028-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250116145944.38028-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 1/16/25 06:59, Philippe Mathieu-Daudé wrote:
> This machine has been supported for a period of more than 6 years.
> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") it can now be removed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/virt.c | 13 -------------
>   1 file changed, 13 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 06530a5dbf8..76d83cfdd3b 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3572,16 +3572,3 @@ static void virt_machine_2_9_options(MachineClass *mc)
>       compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len);
>   }
>   DEFINE_VIRT_MACHINE(2, 9)
> -
> -static void virt_machine_2_8_options(MachineClass *mc)
> -{
> -    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> -
> -    virt_machine_2_9_options(mc);
> -    compat_props_add(mc->compat_props, hw_compat_2_8, hw_compat_2_8_len);
> -    /* For 2.8 and earlier we falsely claimed in the DT that
> -     * our timers were edge-triggered, not level-triggered.
> -     */
> -    vmc->claim_edge_triggered_timers = true;
> -}
> -DEFINE_VIRT_MACHINE(2, 8)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

