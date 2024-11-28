Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A64DD70DE9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 17:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGihy-0000Ym-56; Thu, 28 Nov 2024 12:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGihr-0000NK-Lc
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:53:37 -0500
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGihq-00055e-Bi
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:53:35 -0500
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b6882c33acso38585585a.2
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 09:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732816413; x=1733421213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uwh9NRPBRxCOQxGG9l7X9o7ggn6fwIeLzSFnBN4DZis=;
 b=Cb07amiD5loYbxRExlk9kt4iIj32JAiEi/ThkdZ0Q3rytuT9ZgYm/p2WYzIZJoaWhk
 zZUqZ/uIgBtcfuPdtnYkGOilEck2WKQ8HYm59NTxw6+uwZhWBd9tKJAMjivFVIhY4o+1
 iaUNSRR4LEvBVOZRYmnB12CvhfuBa40L3jAzkFF/qzdE6mE0OQ9GX+QCMh4MD0xxeiuI
 7+Rtxi7hGauRJTqEh8qmkNSRXYa/XcQxTDBH/KP4ToKJtB68OyFPEQZ8xbXEGQPPIVSU
 kG9uL2/UPXPsM4AiQILYD19yeanAxish3IvewIY94h4DluNZlhJKMgSScKi5Xcrywtyw
 apTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732816413; x=1733421213;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uwh9NRPBRxCOQxGG9l7X9o7ggn6fwIeLzSFnBN4DZis=;
 b=H63qm8TLUkvnl4e+i73qwz2qhaeRJqAML3ev8jqqH5b4M8OhW36txT/QL6m1u/RaDX
 CDsotprm5YCwHml0FrC6Vrtq2IBkSIPYGLm4iBwmpra/MpYxNTyQHGBzl4mqzr7PcyPE
 i5/pnYSRWPjmNe23ApO2awFOSM2jYhiHDcWI8a5inPJIaZxOr4lWezvTbX+/dG0rfl5S
 jFZ99dZeEBPQeXbuPxjv85mKJU11ejffOpkho1kiudjLgYkmCbzxHF1akj9ypi3ePeS7
 XbPKDt4plKzYqZlYuqBJJfyntUZ+B10Tedgh0LSSvBHQ0XQbPMOtg/ooWMwTOJAO2ljP
 ZIQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx1tiMnRetQDKz2I/n4CXU6yr5zknalzPWRONSy7VjyaxJjvQWQadh3fhTQPQralqgzUl1/1jqzQJ3@nongnu.org
X-Gm-Message-State: AOJu0Yzq+MnvCxRXJWNH7+0S12P9T2H9HiIiHyD9oavNJ6I6AOgBlGFD
 dkI+s4XwK0YKcRCJUnz11ByPHnK58p8YZiqbcGd9HSMLzlhGS5H7662R7mcKveE=
X-Gm-Gg: ASbGnctib6WB/cXx64b1nLC+mjjwKQvaIszviNsDAnHHpr4O0hy+bDZteH2nrmmzdMT
 yAz74hoLWOFjFG3F3Ufy1QAKzPMO4xW+9J4vFhaDokNURqH6ycDMPX9FUpJHuJKfyg7q06n+WrR
 kBhKjBNS1/Mwnb1L4qeC1zvzwAIgssfn38s0s2p/xK7SxwLRWNfSjQn1ldT6o8spE2iKQYL77Yg
 x9ze6cqDQ9DGFHDVhztTkBagrOWtWYtic8KSaOjLKE/fVmo5n9GUCXXbL6dhkidSi0=
X-Google-Smtp-Source: AGHT+IG1lVMg+bFqD3y5XfTbrJwLLHsWdk88XmgX6OLlzftb/muuceOrcQvayfual+DNriwewKZuSA==
X-Received: by 2002:a05:620a:2b82:b0:7ae:6ba2:faba with SMTP id
 af79cd13be357-7b67c2cec89mr1035017885a.28.1732816413488; 
 Thu, 28 Nov 2024 09:53:33 -0800 (PST)
Received: from [172.20.3.167] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6849c5a6dsm74355885a.117.2024.11.28.09.53.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 09:53:32 -0800 (PST)
Message-ID: <f2f78c3e-1b44-4645-89f4-50cf013c1ed0@linaro.org>
Date: Thu, 28 Nov 2024 11:53:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 19/25] target/s390x: Set Float3NaNPropRule
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-20-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-20-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x731.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/28/24 04:43, Peter Maydell wrote:
> Set the Float3NaNPropRule explicitly for s390x, and remove the
> ifdef from pickNaNMulAdd().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/s390x/cpu.c             | 1 +
>   fpu/softfloat-specialize.c.inc | 2 --
>   2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

