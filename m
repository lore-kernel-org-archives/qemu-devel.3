Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA99E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 23:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOPbN-0007kN-Ow; Thu, 19 Dec 2024 18:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOPbL-0007hj-1W
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 18:06:39 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOPbJ-0008DN-17
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 18:06:38 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-725dbdf380aso1106151b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 15:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734649595; x=1735254395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wW1a6AMswnbVt151CHaRyLS9ZewIzh7XkVSUrhTzFaA=;
 b=dLWPEQKSx8Uy0M62+1IK/nk2LodWubng0ghb/Me6ozdVtqzX5rBH8jzL5qv9yhN+z/
 tKCIZWNrbCdmMK8zoqUxp9MSd/Ewu38/8NlMJZhUqxSaSlTTQvIA2UFeXKJWzGd3bs20
 C5MpvZG5/G9n+BJkjMGo40VIThr5Y0/2BlNYxUHMauv5kvQvSNRgHkx9qTWDoHI1Lx/C
 BYSIPoEnwMJPSsCkfKzMKEjcsWKPKTwvWIDhC2flGVgaSLbkJLni0Ou3ZnzTGtZgb6PH
 F3CHIR4JapAveRcG0XW1wvOfOrZR8Lckh9UpkyNN3ZRHckvPtT/VwTP0/+gKMfjsnHTq
 sdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734649595; x=1735254395;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wW1a6AMswnbVt151CHaRyLS9ZewIzh7XkVSUrhTzFaA=;
 b=J+VXuNK/Lzts3bUg+SgRk4rt6+B+Bjvqau90ocGPFmhqXST67gm2B6OTS0d3X07VS7
 Bwt1CkNYNWxnBpVkUZRNN4vuzV9WrrKe3DoN/PF3raCu1kFRg1t5zksW3+J+imeSgKTx
 zkvYE9LbQSbA5Z8C5qOtLTWBXwgj/SKppsXxbnOdGWyoLyea8zMw4JgS60qkfrGjiAO0
 vqYIt4DZmYu14Jo45cPpi50QnxRhU7GekUVvW9P5Q8VPLUJ0s6w4q0UK/RtFnuW9qhDl
 30E8q8af7dWY8Nz/qbJtsMrE14kYvtfWy2pBH722pSelrEWM3flji0Pd2DMpvN25qR3b
 90cw==
X-Gm-Message-State: AOJu0YxXmIOx8STDdQ8+4VtWw8YeShhiRJ1GxX8s25VJidWJzQ7gqIfI
 fY8QQca+9WC0Lfbu9U+9GJyfsD2WcAmBpMD5cw5qcn3yuRUCRtkrReOXLs0b2CCiZVdm+9IeMcq
 y
X-Gm-Gg: ASbGncsdPjkD2qFZz1Ikf9l0aA5j7fW02QrH7/bUa3CRQn1/yFXWPFiBMsF7noJrMCK
 NONwDdwhsMLSx+PA1AXZvT2cMBto/4Z09skWVT3E1wt1VfiTSPizzZvtn2crwGyShZrGZg7Pe4Q
 0KXSSLz2pM6zgYlVDzmDcnSw+VlpsCxo1+L6m4HElaoMQlHRPt7iF0PbfbvHQWV0s0x1r2H4Q6Z
 yJzp/AkPIPmsZrlanSkrA0nSjV/BzTW4oatfmBngxQSp8rrQR17yaWulGeYOUYd3pqTMHo=
X-Google-Smtp-Source: AGHT+IFXK35Amrds0PfFmTQGkTdItM6+UpRA54y+BPYxOZCf/WWFNml/vknvdwOKt1VNUV8WZDE6hA==
X-Received: by 2002:a05:6a00:414a:b0:725:96b1:d217 with SMTP id
 d2e1a72fcca58-72abdd7e0e5mr716655b3a.9.1734649595311; 
 Thu, 19 Dec 2024 15:06:35 -0800 (PST)
Received: from [192.168.0.4] ([71.212.144.252])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842aba73267sm1724540a12.13.2024.12.19.15.06.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 15:06:34 -0800 (PST)
Message-ID: <5552879a-bb83-45c0-873c-b9f6b635099c@linaro.org>
Date: Thu, 19 Dec 2024 15:06:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] target/arm: add new property to select pauth-qarma5
To: qemu-devel@nongnu.org
References: <20241219183211.3493974-1-pierrick.bouvier@linaro.org>
 <20241219183211.3493974-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241219183211.3493974-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 12/19/24 10:32, Pierrick Bouvier wrote:
> Before changing default pauth algorithm, we need to make sure current
> default one (QARMA5) can still be selected.
> 
> $ qemu-system-aarch64 -cpu max,pauth-qarma5=on ...
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   docs/system/arm/cpu-features.rst |  5 ++++-
>   target/arm/cpu.h                 |  1 +
>   target/arm/arm-qmp-cmds.c        |  2 +-
>   target/arm/cpu64.c               | 20 ++++++++++++++------
>   tests/qtest/arm-cpu-features.c   | 15 +++++++++++----
>   5 files changed, 31 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

