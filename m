Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C848CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtQ7-0002Je-RW; Fri, 15 May 2026 10:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtPt-00027u-Ev
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:21:34 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtPm-0007dF-P3
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:21:24 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-44ccbd3290aso7599818f8f.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854881; x=1779459681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MIVE0YiQz3dZCpftBe2YNh84NjXV4p6yrZsIH9BbPA4=;
 b=EEBMiUTEOEUW81uSdXUA2+s9TdQRpYUpsSTA8K7JxwRHV/bcUhZDGUzrxEA5hQPM0x
 hxTfl6bNx+FObo+vOGprtKgeqr5fSxh8V4Vc6HrV83dcz+lFU21AM6307S5xjd6MgUGw
 wkIZySHad4G6NYDSyrcfV/XqIp9mjdWnsjyXyniju2OplapLQV4M/1bl0VbrdUOIIWy3
 d1CVZDGlBkJtjfy08ennf2GRzf/e0Hw+JiezU2uz1c7YWjNDLYnRg6JrHAVZvAOqA5Di
 2A52O5jcu0Sv9M7EEm/xzRMQA9YoqyTsv2liUaXdoThlF9PQ5RPCmQOi912hsKKRUIrb
 kyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854881; x=1779459681;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MIVE0YiQz3dZCpftBe2YNh84NjXV4p6yrZsIH9BbPA4=;
 b=NHHe3grVV65t9oeD68/Bo8hVqymxGpk6QtbrvQT0cvk0rL8qUxgaZSRV87Xm6n1YZc
 qV0ZRdeMZBLzjqpwHqaTlNInCmvts1Mf5NNgKtvjNBQhrVg2T7WH0hNXtap4oeXG72DJ
 mhFCbA+T3mZLMzW4XJx4nbRV8sAvbcPzvMsb+5LtcF5Ba/Y1TwMubo87/Sxq9pS6ZUUU
 jueTTk+ZmV9c7x8zOJfiJXgBE0vzs6JzScc6ST7z6KszaR2oNNMK1dRZG9s5N7KHwQeF
 5MpHvKZ/9vjF3hNLphESQb1Dvc8GJA4r5KKiMpMX3wSskwiNGRuTv9vnfY1mjD13ZNG2
 v0XQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8edlq9EJ3jt5YcF1wGg6anEqsQ4GRBf6ksP7OfP1MChds8gptjQg0mLWkrSCfgWA7ZA+bTS3qzsX9Y@nongnu.org
X-Gm-Message-State: AOJu0YxKhQPJXYH/8bKYhooJzFfPEfU8j8ak+A3WU7JmBF54aH3XX1oh
 dLv9AvMprZML3npvanb4bkGG09bEmQXMLUDMhUcx160GwYzVaB7BvhtYCW7Mn9MtYmg=
X-Gm-Gg: Acq92OEiRz51rweMSQ5vpAgvDXbkjpuztkT6J5NYllEqT7WpCwLURjkwXKXOd3AoIbG
 TnqXHklkq99DjKl+e7XhNabmomHVmjxQSVqg4OmemiZ2RRzeGCKNGPfrumFCLGKV+PacGtqvVea
 0pTv9sT56U+9PPeflxbs9+DT1azEWYi33OAtxuM9LcN2VYAbXs0U5/7uOo4Jg4E3h/vfUdJWdfS
 97Z91jrcwpdx17T8h4ANjHuJ/oIXK/KXI+Vs4Bf6mWVXs+/quuLyZLaIdLPtIwhTqVl4xpS/uEo
 jhd64YDbaBnBucBmz+eWV5YqklP4kAMRu727Ysbl3VsFLZn9/6LoqDQl+wAi29tbyvq7feYNwN0
 3ZikF3wm7U62Pf7UNoIwcCqrEaijAS78RXaSIBd0MCXajkhVPWFnv3bQn3CRi7InAtLg5VTNZ1w
 gWMUDwcoi1jOzOVW3u36bOmkCL+48mBYaulDxiVogPlPtUlb9NRdFeQo8Pza4+HnoZKg==
X-Received: by 2002:a05:6000:2007:b0:43d:70de:1c70 with SMTP id
 ffacd0b85a97d-45e5c59f545mr5801670f8f.32.1778854880972; 
 Fri, 15 May 2026 07:21:20 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe222bsm12159127f8f.27.2026.05.15.07.21.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 07:21:20 -0700 (PDT)
Message-ID: <b00e4cf9-1108-4ba6-87b9-477f29640473@linaro.org>
Date: Fri, 15 May 2026 16:21:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/i386: Convert to translate_for_debug
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20260515125727.349675-1-peter.maydell@linaro.org>
 <20260515125727.349675-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260515125727.349675-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 15/5/26 14:57, Peter Maydell wrote:
> The get_phys_addr_attrs_debug method of SysemuCPUOps is used only by
> x86 and microblaze.  Convert x86 to the newer translate_for_debug
> method, as a step towards being able to remove
> get_phys_addr_attrs_debug.
> 
> The new API allows us to tell the caller the actual size of the
> mapping via lg_page_size, so we do that, although no caller will care
> since it's always at least TARGET_PAGE_BITS.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/i386/cpu.c           |  2 +-
>   target/i386/cpu.h           |  4 ++--
>   target/i386/helper.c        | 31 +++++++++++++++++--------------
>   target/i386/whpx/whpx-all.c |  2 +-
>   4 files changed, 21 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

