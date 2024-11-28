Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21A0D69108
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 13:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGeGw-0002ii-3l; Thu, 28 Nov 2024 08:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGeGv-0002iY-8a
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:09:29 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGeGt-0007xH-Ab
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:09:28 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3ea48624a2aso407696b6e.2
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 05:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732799365; x=1733404165; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CoAYwGdQfTMB67AD/o304evZvUiG9cVjmQS7+iXnYcs=;
 b=NrJUWtdEYlkg2PrkM28yKRWTp4BuTsCakguemh1b4v6NamxdnuTonBTb5tI2W8mH7Z
 NHCb/0kMkGsNhLeLyplghKTsxQDkLVilRo9jH0udjSaHZzTbU59BsDP/4AqCOS2/rqLV
 kp3l67PecFTJytGhzDByjMwe9WAwxQfK9lc+e14qHJmY2ppTofpjx5kZhNeMKH/cCHpf
 0qDpUXtWEErzG7KOFvUYW+m/KJ2vR4324bjkG/9lNRFmRZriQg866iAcIersvIYPWkfC
 DsmO1fWJsc+AJ2f0smvEZJd7QiWJBmbzCxS/lY9caneIJaGDXRaCRfXaKES8gahpz5Mk
 /6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732799365; x=1733404165;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CoAYwGdQfTMB67AD/o304evZvUiG9cVjmQS7+iXnYcs=;
 b=iAsfNwuR1OgvgpoBhJubgKAl1n5owEwsLSrSbVCnLJO69IoTDSggAwF4rli8j3F9rU
 QpKXWjVbPSouOOQJ6p79zqtNjfq9snt/ZCxkmWlRf0USdllctKlZmf1CyrHDa9o+9ftz
 sLyStQntYzsdd64p7Z0xPmHGkdFxB2ccMtVuStuvddqsYnOesSb2/WZn/8puYDp/vqNX
 0zeNgg3rDfZiepxsf+rXphzEySQN43aFcNGAg9FsTB0jZ9fPdy+Sui87nNyyYPL19NKV
 4QA/NV10WCqd+xw5P+4lk0ZLOjCwjGAkFevL4R1O74NyXzo2vElcX2Dl353rRBrqxwFZ
 dlHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/oZvJ9rDEZDPXtnGUK/wwx6WBoVCoKRCen902N+3MhLQcIf+fglyTtFdwsjebkQU7axx1/KG2ej7D@nongnu.org
X-Gm-Message-State: AOJu0Yx8t5LC1CQFgp1quj78GrzOq+A0mNO4Wkq00y1YMQuHiFPr3y/Y
 8Albg+9SsFROINR+n4ml8n5Ae2sVfKCj4d/8ESwlO++kVsLnu6G9LzBY4dc3Re0=
X-Gm-Gg: ASbGnctHCH3aNhrOA1+ZrMFkuaMrHe5q0I/nSFTHDzwj0fYaRTb6vV7FvprP/NtVtgF
 B3XjmKrdPjH/RxkwuyOO5VF986MsC6I7ccdJhjE5HZ8hXwz/IIaFqlXrlZTaKCODI5CtSuUdVVw
 KwgONZlV8w7tdlfPGa70cvaL4aR9Nk7qG7Ic4Af0PUighDCjRXqzkKYv7SE1xAoJ883btdsSC28
 +IOE4A63ET2G4e2mTR5U4kBvkltCJ6JCllTkuBaJJeLwBdHsK9ucfRgWHk7q0PDfktjLxPH/gWt
 ncDsQPcCHiwFHE892oAlisMIGxtX
X-Google-Smtp-Source: AGHT+IGFCH43szl157jMwZppst4rMoA7YnQvd4N4lZq61shnnVBC7AuoVQjiRUVvtJFIOlrNwRYF1Q==
X-Received: by 2002:a05:6808:148b:b0:3e7:b3d9:4109 with SMTP id
 5614622812f47-3ea6dc22e7cmr7139276b6e.22.1732799364827; 
 Thu, 28 Nov 2024 05:09:24 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea8621131bsm245873b6e.36.2024.11.28.05.09.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 05:09:24 -0800 (PST)
Message-ID: <edcfabc6-0c42-42fb-9980-303909f73e53@linaro.org>
Date: Thu, 28 Nov 2024 07:09:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 02/25] fpu: Check for default_nan_mode before
 calling pickNaNMulAdd
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 11/28/24 04:42, Peter Maydell wrote:
> If the target sets default_nan_mode then we're always going to return
> the default NaN, and pickNaNMulAdd() no longer has any side effects.
> For consistency with pickNaN(), check for default_nan_mode before
> calling pickNaNMulAdd().
> 
> When we convert pickNaNMulAdd() to allow runtime selection of the NaN
> propagation rule, this means we won't have to make the targets which
> use default_nan_mode also set a propagation rule.
> 
> Since RiscV always uses default_nan_mode, this allows us to remove
> its ifdef case from pickNaNMulAdd().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   fpu/softfloat-parts.c.inc      | 8 ++++++--
>   fpu/softfloat-specialize.c.inc | 9 +++++++--
>   2 files changed, 13 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

