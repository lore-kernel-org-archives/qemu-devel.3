Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C68C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 13:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUnI1-0007l5-3v; Fri, 19 Jul 2024 09:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUnHz-0007jz-0b
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 09:04:47 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUnHx-0000hM-H3
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 09:04:46 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-367963ea053so798050f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 06:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721394283; x=1721999083; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5VD3dGcqFmyXvHy0rEUbGoNvnEXenK4+enbudCfSgsQ=;
 b=L+bql7oezhkQaqHB7AmXYeYoPiYDpFccP+xpCOr2q6T3z7frlST23tlK61U7epBNfB
 fJqFQUY3SxGitUO5M+HX95j+vUI2NnHKBS4VjaF/2LMjfAKiQhAw+Z31Fa39gxK1Byjp
 seyr4iwiePtVXRttcLm4gnPA/q8pH2DFdnCR87Nb6vy9bAwKF6FcU//Y5oHyO6fWvCZk
 EWAChmawbu/15eCl3f6+qmpL+SB34e4tVxLcdFLcZu4UXhA8rCUOQzKxxt2UYrUYba1N
 ObMb5tkHhqbHPDX+uxXn7+BnWsxgYdCQmyjGq7A/IP4+LNlHHhg6nxmLm9xNrJxyEJNo
 mhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721394283; x=1721999083;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5VD3dGcqFmyXvHy0rEUbGoNvnEXenK4+enbudCfSgsQ=;
 b=hUrNYaEmsO+OisfgxxINEnZvFuVEEz/rCYi1O5JktuHF+NAkaOiSm98HZRHl7eeD8L
 XI3ZcwMx6kJMIPeqeYhJXktopkBgCEpWE8Xo1k4vBtiCYG9criohDzCvYvBw2bKzLhJd
 ETGcxrzErbI1d28toFU8Skc3AhCOkiKuOpTajGioVUasnENnbvAq7+zbZ8ef4C5w1ql3
 N+tos4lCN/dmg589cstc2qhZoDWnAG7v2DDLDX0a6C+Ft0jzgoiYhf6nfnoI7ijXqvGd
 nCqQeI8rZWealLG4ow18+1zNYnkoX88OCx71/7ZLdT7gW+ddOwK6PUkolXtMM0UKNwL5
 8Fqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwH5X2oBEgPZglc/5WCy74yEPtu4jdzE074Pp60l80j+5q5lNvnvHk3rCVmVlWEDk5KKRkhD5OHhki6zRq0aytklyVUyM=
X-Gm-Message-State: AOJu0YwTJJL7fNi7YCe7fxaNRsKt7S5U9OI2i6YRxLN9Jw9son02Eou8
 cQCDK0dQtEfFLqFu/XI+9QtG/ic439++80pqWEk4/LjnG/aZGTJajpSNr2wEDO4=
X-Google-Smtp-Source: AGHT+IFHV4xyHbG2WVWePfPq4WAmpegYbdvWCJUnRFGHy5t3xyT7js6ZpsBCUIH6pIyRLu5EmNoI5g==
X-Received: by 2002:adf:f149:0:b0:367:9020:51ef with SMTP id
 ffacd0b85a97d-3683176ed2bmr5787612f8f.64.1721394282680; 
 Fri, 19 Jul 2024 06:04:42 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368786848basm1590808f8f.15.2024.07.19.06.04.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 06:04:41 -0700 (PDT)
Message-ID: <7c2c14e9-d6eb-4a8d-bb87-57ec289756d4@linaro.org>
Date: Fri, 19 Jul 2024 15:04:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/19] Reconstruct loongson ipi driver
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Bibo Mao <maobibo@loongson.cn>,
 QEMU devel <qemu-devel@nongnu.org>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>
References: <20240718133312.10324-1-philmd@linaro.org>
 <c7e11721-812f-4ca5-9115-1ae060b4ff25@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c7e11721-812f-4ca5-9115-1ae060b4ff25@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 19/7/24 14:56, Jiaxun Yang wrote:
> 
> 
> 在2024年7月18日七月 下午9:32，Philippe Mathieu-Daudé写道：
>> Since v4:
>> - Fix build failure due to rebase (Song)
>> - Loongarch -> LoongArch (Song)
>> - Added Song's tags
>>
>> Since v3:
>> - Use DEFINE_TYPES() macro (unreviewed patch #1)
>> - Update MAINTAINERS
>> - Added Bibo's tags
> 
> For the whole series:
> 
> Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Yeah!

> Thanks! Tested on MIPS loongson3-virt with 2, 4 CPUs, all working fine.
> 
> I'll get this covered by CI later.

Thanks,

I'm queuing this series.

