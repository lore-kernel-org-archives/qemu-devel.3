Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D0AECD980
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 15:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1W9-0000Ru-Ab; Thu, 05 Feb 2026 10:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo1W6-0000RL-Uy
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:43:38 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo1W3-0006E0-UE
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:43:38 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-480706554beso11295525e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 07:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770306214; x=1770911014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+WoeOm28m91v7yiwzsKJUC94/qSK6s8Cw29K4bwsQu4=;
 b=c6mcjtagE3slOvzGMn9V+asb2yvRt6sp/Qh8Cs8gcHlw5NiT9WW9BOLTbk/mwLc/Sl
 4KUZ5I96HLBWpLRsNsPkc+W5wS3UsoNTbJ7AI4C4svSCqltD+OBHCLiHPrAvULhFby1a
 O4WbyrKwfC0T9/roCcwYGMSdMwfV4TLbYGpBf4hS8rkPk4rruYxBlGkypkoFUM4l4SHI
 7cHJLev42Xsz5miW06uDZPLQQSgm6nn706IpjZv/NwTOnk2HKdLo8dmJ20oBAzcBusDt
 nX4dXZHlGOKAcnLxiQzEzLSI0VZ3TjegQ1fsqaQWULVQkXiNhcjv07c+loEAB/dpJk3d
 qMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770306214; x=1770911014;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+WoeOm28m91v7yiwzsKJUC94/qSK6s8Cw29K4bwsQu4=;
 b=GxVmz71Fh3AsyWIitnrcOOpN9e32ve6165KC+caQuJFuBDklzXIwcPg0xSVbUW+5zW
 i/3evWm7+sxwGgZVSjsOpeY+E5Z0RhJZiGm2Nzb61kLI4pXNeCblDU+salOsWaIovjHg
 4LXILucrrBBVs3vDcGD8+hFcn632Rr9ZjTYT2VgYbnd9DO1Wx7I/msAcqaWKOuEuMC+J
 neX0aHl+kfUjv4VMGu0gnA0+52N6Cg1BbKy+ZlfYssShuJTJuivNTqoAcr0sDfe1iiZj
 90jNE/K8yRT4CsGEo0mMVbA2g9eXqvwmMcSRPoEGrl52Tn7BrMqyRotzVtoays07HyJt
 P33A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW924Aj0eNBlzo9tkhYqRcYXZHWT67vbDYiq4bZbidQOrhXbo+ymHuo5EQETGHJ70sOVGs5DlGLRMQH@nongnu.org
X-Gm-Message-State: AOJu0YzjQ+VOLUCcz97nzV+lHPGOhDB4syaoYm4faPOzg8N/iZOVTGfH
 Etv78R/6Fs8syd4Z72Yyq3/z0P53TnoLkxhfhgEeMpa0def5LZ6JyCc4wUs65jWCN7U6ovecr/n
 fpdt/IX0=
X-Gm-Gg: AZuq6aI7VleAL063qckHUalV20rI5LXg34kRBvorhrQbqJfYxNmvZ5r4woXXpfhzHJd
 st8OMn7SokIxjTf7VfBw2Pjoa/MY6CRhw1/nejEP1Yj951jLPiM4+JezAbYtp5JyM4a3o0qDDmB
 GVVFZofoeujiXuF/c28CD65MzKuQarm0iS7ClW/HtKHqRdcUjWUcCxm6QaevrM9e52nPJ+CvUZF
 odhHwcKe2yWie0h9wO6cWdcBQha8A/kH40LS7eiUFxHU9wMQ77FtmCcv+/NWOG0bxxyhXineIqK
 4NKR/mqqE/LrHqzqMNiBb4tNW+hqVVypzNS9ugvgexZPo/v200XCGKYYaZwpZ+pQYRVWlDE5PQ6
 SLj4mC9+64YORRWM9rOJlEQ6vxrdwwcy9rPqO/pUHSOrCE62pMEFavxVTODdBt6EZ4c/YfTHbET
 MWqbcC4iT1BqSu1PdKi5LUoBsuV5mRGlQ7jnBjn2j6adVE50nPg79Kc2j/0TT4ne5h
X-Received: by 2002:a05:600c:5250:b0:47e:e20e:bbb2 with SMTP id
 5b1f17b1804b1-4830e92ca43mr100025615e9.7.1770306214359; 
 Thu, 05 Feb 2026 07:43:34 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d7a924sm97829815e9.10.2026.02.05.07.43.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 07:43:33 -0800 (PST)
Message-ID: <e8629c21-500c-4561-b1f5-f58fc7329dea@linaro.org>
Date: Thu, 5 Feb 2026 16:43:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] hw/or1k: Rename from openrisc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, shorne@gmail.com
References: <20260205030244.266447-1-richard.henderson@linaro.org>
 <20260205030244.266447-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260205030244.266447-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 5/2/26 04:02, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/{openrisc => or1k}/boot.c         | 0
>   hw/{openrisc => or1k}/cputimer.c     | 0
>   hw/{openrisc => or1k}/openrisc_sim.c | 0
>   hw/{openrisc => or1k}/virt.c         | 0
>   MAINTAINERS                          | 4 ++--
>   hw/Kconfig                           | 2 +-
>   hw/meson.build                       | 2 +-
>   hw/{openrisc => or1k}/Kconfig        | 0
>   hw/{openrisc => or1k}/meson.build    | 0
>   9 files changed, 4 insertions(+), 4 deletions(-)
>   rename hw/{openrisc => or1k}/boot.c (100%)
>   rename hw/{openrisc => or1k}/cputimer.c (100%)
>   rename hw/{openrisc => or1k}/openrisc_sim.c (100%)
>   rename hw/{openrisc => or1k}/virt.c (100%)
>   rename hw/{openrisc => or1k}/Kconfig (100%)
>   rename hw/{openrisc => or1k}/meson.build (100%)


> diff --git a/hw/openrisc/meson.build b/hw/or1k/meson.build
> similarity index 100%
> rename from hw/openrisc/meson.build
> rename to hw/or1k/meson.build

Can we s/openrisc_ss/or1k_ss/ in this file?

