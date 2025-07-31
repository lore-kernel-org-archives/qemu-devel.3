Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29A2C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 20:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhZuF-0002TC-J4; Thu, 31 Jul 2025 16:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhYUv-0007W7-Pz
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 14:59:28 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhYUt-0000DE-PO
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 14:59:25 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-23fe2be6061so10404485ad.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 11:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753988362; x=1754593162; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WmOFoc78CJNiNKrPfOa45SLjxmlBQ7gJfXqtYFrLU0g=;
 b=fmU/BgN0kX0cSGmdwc19sOZm0Sroi7n/6rqk5b4yrJYv5OvBj+klmVxdpGZHetevmE
 rIfgIXrZlPvRBPGPRoboACYRjli7cVbH58E5cpi1AMyeWI6afr1cxRTa2DqiuxRNIFnW
 OQbl3TwS1GZ9blCjr0I+l/S25CWtl+TN/Sr2vfzl85rZ9gRxUD5MJU5F2+IkHIC0h5QZ
 BcqzOMn84wDMcsRCF9ufB+h2VA2E+weiP6TWFoPNIC11+28cS7jhsOfnj2SUMSsSO2ur
 ntBCgqxYO3m0GxVvnib5JbCmKkGzHDJsBEfOprzcJhsz0roBbH5KJXhf+kup2LEKwkNu
 YIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753988362; x=1754593162;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WmOFoc78CJNiNKrPfOa45SLjxmlBQ7gJfXqtYFrLU0g=;
 b=lpU++8lHNdEUECRHm3gtq65HkV9HvNmYMaIbqZot8jkLlxNn4JOOTajp9N9gC0xfLg
 ayBBaiuE7s5VVVKRG5KpcwiOD1UEbFuL+qoWOK7p72MGmc1Ikmsim2fsETTjuLQREiMd
 Rp85LXVGVMEa5XaVVWaWKG1VMXIkFZ2jTH+ezf3jQrJKMh9f/VvyekwnLbZZwwEJtEOT
 TI92b6aRaORM/Efp4p/IIeDBz0R4HeT8OPCWqv9BEVd4HL1N9djgFcDIJhsBse9t8Hc6
 zmu0IDYzHK0sWc9HvEz9SszgWf9aZcLA1btxz/+cJfGehRrYH/soi/YuvlDTkhjMd/vo
 4RGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLAdHX+79lYVw95S/Vy9P0yeuePyQEfncGfzpqWqgwPauggCMcMSE1p/HqRwQiN5BTe8BH7vUFJngF@nongnu.org
X-Gm-Message-State: AOJu0Yy1/MNOxJL2nn2hYWe1VJMTyHupVbLwTO9oLiaFxZIVADSBooSt
 1Y5Oi8z4o9Ua5NyNCJ6kAiGeyWksjfx3o8s6qFBp+/xg2rEwuGNkQaMq5PZu/VK3d80=
X-Gm-Gg: ASbGncsg7a7oaiy/iGAlQXPqA4S/uhYOXUanARld4XK0bgnoipFUD7nPiDT5WTwtweY
 x5hiXHvBEaDA03+lPJt6VAtC8Uup6cszSrjZqrODUZ/8gehaHA+lR+ZgzZvFSgHWBvWHGpMJf4c
 Xh0v+eYUr7UxON7Lqnv3N+v/q1WvDJDsaYPoL7IOrl114ikCxmf+jCaPVq7qWOi5nOZzX8UK9fv
 DA1XLlvQSl8WD22hGdyraiWvxhBOYQe4Wu1xoEe8wD70wquhPVxuFdLmUIhXEjiQHqN+Ve+8HYh
 76UgE5F7NPSYYX/n/HV5Jp88YUJvRqcN8WSAB7Dw+/0eQJ6YtGERz5p1DJ7155NwJli+V5aKLpR
 6890nxWAgFmy9JxAoO1XG+OQN2PX+mw3grc8=
X-Google-Smtp-Source: AGHT+IHI33S6TSWC1ANzbKh8+HwIdk59pD7IGFGt2KMAQAhYwgMhPrzYF2S3WVBopSZmsd6E25hNjw==
X-Received: by 2002:a17:903:32d2:b0:23e:3911:433e with SMTP id
 d9443c01a7336-24200a3bcfamr46667355ad.5.1753988362071; 
 Thu, 31 Jul 2025 11:59:22 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef67a3sm24277995ad.15.2025.07.31.11.59.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 11:59:21 -0700 (PDT)
Message-ID: <08ca2379-60a1-4f57-aeda-a28dc3fcb09d@linaro.org>
Date: Thu, 31 Jul 2025 11:59:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 46/82] target/arm: Implement FEAT_CHK
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-47-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-47-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> This feature contains only the CHKFEAT instruction.  It has
> no ID enable, being back-allocated into the hint nop space.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 14 ++++++++++++++
>   docs/system/arm/emulation.rst  |  1 +
>   target/arm/tcg/a64.decode      |  1 +
>   3 files changed, 16 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


