Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6573FCD343D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slUuJ-00088z-Kx; Tue, 03 Sep 2024 10:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slUuH-0007yD-JT
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:53:21 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slUuG-0006HR-2j
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:53:21 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7142a93ea9cso4347635b3a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 07:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725375199; x=1725979999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lMsprjbDFrqzMBMLLkPObTJcD1In7cDg2YgTR7/YT0U=;
 b=WfSOwnCvM32fDyACSAzsFHVYCszAqWyBGv44BoSNcOxP8E3qnHsnnkYjcywb9absII
 1VB6Qu7xi/BW/dwUxrHjWAjjSa6DDqPNC0RlKIZ0NnpubjoVpJ7y73XKOFeTR4iD/qi4
 oRni/CyP6a/L2Ho8d20uX4JQFC0hASDso2UYQId42j+2UdjaOK/wB7uuANs8knMbmMIW
 g0tofCXPaSltm8pUd9/kNSv1eky8P3IWeGisIhBJ1/eRRWP49CHfSYCP77xE98IPP5TM
 8s2UfxSJLJygdY2BJgXYBTwfyXNIrOp91CR2tenmQyEHNexwwaslKsTERSsGZ/XxW/ES
 i8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725375199; x=1725979999;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lMsprjbDFrqzMBMLLkPObTJcD1In7cDg2YgTR7/YT0U=;
 b=LQyz7wrk/yt0r6Z4hM6+hnoy3sxEauBNLTBpWrbmq2svGZLdqlqi8kSORQsodQvJ3P
 X1ZarY01Ko2ziePwlKRlhunjiUV9oxueYbqCpWS+RlVr30yZ00LE1uH7QQFarIip+nYQ
 s4FcdpCfEdmLgdbV42lmsZV9PCMHYikkj8cBad/yUyX3DzmFuGCuBG/jevztKZPvu5SV
 Gd5TU6p/eCwpDoN98JWTXys+5TG4CWLw4lrWaB1oNtbAfLQF/6qdLi/m7pPFnZozFQ+g
 PzuCXLNoefICeHD3VM0Hp4gPHvXXBvIloZxVY7l4juyl+RMdTiBoyvHLITBXV3I2UL9C
 y6wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3X+XYu2rIrNvsWHS3TU+0oI0gGGo23sHxPDAjwhvxjTbgzZDefG90qqRnQwc6EssHViPPJNM/BVqW@nongnu.org
X-Gm-Message-State: AOJu0Yz6G/iRwZ0tMvhjN0EHRsBECB49QkEEDVd5bN7VsdMJToTRI/Ie
 lInwr6Qd4126RD154kyet+GKJFlPTIi5HPb/BWqm5kWLuRDjyETeD78ByXLieSU=
X-Google-Smtp-Source: AGHT+IH7dMoSVUacW4lVzOPXWfu6aE1JyStmQcdEklvZdnL9+RuZDGoHZ1eoquEVSUYEPCBGllnVTg==
X-Received: by 2002:a05:6a21:3947:b0:1ce:dd2e:d875 with SMTP id
 adf61e73a8af0-1cedd2edc1bmr8514020637.37.1725375198555; 
 Tue, 03 Sep 2024 07:53:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-715e55a9a44sm8621416b3a.68.2024.09.03.07.53.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 07:53:18 -0700 (PDT)
Message-ID: <b766bc85-4da3-41ff-894b-03e2d2642a71@linaro.org>
Date: Tue, 3 Sep 2024 07:53:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] tcg/riscv: Implement vector min/max ops
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
 <20240830061607.1940-12-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240830061607.1940-12-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/29/24 23:16, LIU Zhiwei wrote:
> From: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
> 
> Signed-off-by: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei<zhiwei_liu@linux.alibaba.com>
> ---
>   tcg/riscv/tcg-target.c.inc | 29 +++++++++++++++++++++++++++++
>   tcg/riscv/tcg-target.h     |  2 +-
>   2 files changed, 30 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

