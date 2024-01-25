Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB37C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 17:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT36e-00067o-Ru; Thu, 25 Jan 2024 12:01:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rT362-0005eS-17
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 12:01:00 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rT360-0002lE-DP
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 12:00:57 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e9101b5f9so77239135e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 09:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706202055; x=1706806855; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=90HIsPExo6FOAVIK0WBSNf+SFTMvucV3Ru03DeI0hjQ=;
 b=YyYdxY+pZ2ZG8JUvLhfM27dTJ7GLvX4S7qzCs0EYQQy8eQK8Vd134OidIDluVvRjBd
 Qv0xZEVuaYNUXJkzfyWF/50wp0AaJXXXmpKtzej7KKWkY8iQCjjlPVUTHnW42mDPtshT
 QchbNOcJnhSDx6ON1/jIUDz2MHrpd+q3uABfQb516sJbg9PIHNK+xJ0ElgIErDc5fPy2
 3nek1s8gj/gMGB2YUrtzNYaPICCIsQElGG5wirUfC1eQpIDqWCwQAVtkOukEHh5CVxfj
 iDHMgPXGc50MnmbFnIqb4aL0GLg5CUO4JmSh231llOHiLO1OeB7b17Wm/TtPJLo6W4S4
 ySWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706202055; x=1706806855;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=90HIsPExo6FOAVIK0WBSNf+SFTMvucV3Ru03DeI0hjQ=;
 b=Lr+g3kpi3gsB2yzNtOg70zjitXjJbcApJQVJTEsan2x6UcSkkFqsMw3k97DJbO/eOx
 6thf8FEWcDG68D1IlZZopX9pCyKgQQJr2f9BAz0VCtRLK+MHDhjTg9eZqq8PJ/JszazG
 k77qhoQpOJLoi02eRPV7pCEKqU+alpia/GWgEPLoHK8o5iFhXsyVEzZcLHBMzet8OHH4
 xeTNperKd7ankJnYe7h5XTPlbLTIg5oWJn8yBalmyUMooqIHNl0q/bEJrn4wFbTRKDs4
 z7Ki8nBWwXSgjYC1/ZoJNgfbSDwH+fq2xxkr5Bv0+6TXIQiM6aSwQCqx/h2AEopFxg+c
 b76g==
X-Gm-Message-State: AOJu0YzHwGH2yDsJrLtz5x6J073M07AAdEjnBbL/EdUIY727l2szN7RJ
 pLTWilPdLchn3SafpytHBrzvKX46jzpYeHM9VhazMjfWCzQRcyJTrP7QijVsShs=
X-Google-Smtp-Source: AGHT+IH70l5kxSM2XN5Vf54eKQoNo4EQWfCa+6k0qEyHPDtJpcP2tAQXt+U+7z+TD2TCsnYdNELYjA==
X-Received: by 2002:a05:600c:5188:b0:40e:59c9:e603 with SMTP id
 fa8-20020a05600c518800b0040e59c9e603mr22071wmb.135.1706202054749; 
 Thu, 25 Jan 2024 09:00:54 -0800 (PST)
Received: from [192.168.69.100] (lec62-h02-176-184-19-125.dsl.sta.abo.bbox.fr.
 [176.184.19.125]) by smtp.gmail.com with ESMTPSA id
 l8-20020a5d5608000000b003392bcd6c48sm12913879wrv.79.2024.01.25.09.00.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jan 2024 09:00:54 -0800 (PST)
Message-ID: <eb1dd88c-95f7-4818-ab8e-34088758561b@linaro.org>
Date: Thu, 25 Jan 2024 18:00:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] riscv: Clean up includes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
 <20240125163408.1595135-10-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240125163408.1595135-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 25/1/24 17:34, Peter Maydell wrote:
> This commit was created with scripts/clean-includes:
>   ./scripts/clean-includes --git riscv target/riscv/*.[ch]
> 
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
> 
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>    it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>    Drop these, too.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/riscv/vector_internals.h | 1 -
>   target/riscv/vector_internals.c | 1 +
>   2 files changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


