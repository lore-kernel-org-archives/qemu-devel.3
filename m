Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0612E9D826
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 00:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9Xrh-0007sJ-Ox; Sun, 05 Apr 2026 20:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9XrT-0007rl-RX
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:30:40 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9XrS-0002tp-Da
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:30:39 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2adff872068so14879575ad.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 17:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775435435; x=1776040235; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FTLzul9+JzKXp64NTCCD216vLKYEKf21IbFKIZi3/rc=;
 b=Xu1q7wOtImmWplczosPoqS9GrsK9zic1k6W684OAcWubV/gOrb5k5en4WMfSgz2Pp9
 QJjXhUH7+Pn4Oey/lcpEeb+jxTLug7uYcMpxANsUNUVLLTZaksG3C2rrYSj1BcAoYsoU
 lSo1kUg2xr4r7J0ppoIRFNC2YqXjJN5CtFAhXCTzJ5PAboV8I/HK7snOgsDpSpAcgW5j
 y5EVvmSCI+G/wNE0LQvhf366Q5H6Pt4Sg/Bl407QQHc/608mJcnMSueZmpEzxbzNDvhW
 IMgGlS3y0/pyFm4L4CaM2hEolt8RZ2lYUS2gQleV6rgPKAjnoNSV2gu77XXs0FSe2hA/
 yiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775435435; x=1776040235;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FTLzul9+JzKXp64NTCCD216vLKYEKf21IbFKIZi3/rc=;
 b=szEazlMpFNd8fj5PX30UnPhFC9QV1Um/MFEJZ+FTOOs9TBnMHoU036U6n9B2RKyk/R
 Qhd4lIuwsIowBdOzpw35A3ehDe1OTaKnL8nctYUPW1+rMGAWd4T3qwU/kQStUGovVHHh
 +zIUcag/bv0B0UVB5chEwigCLOASuI8XLXVdH1n+pK1WBJ3boerthSyP2yiDHjOoLo4N
 Ow1tcuGd/dSqi02i9PDyl5da5PzEjkAdJfovSlGAW5vUDDGJj0HEtYU6v8FTvAUV93HI
 k7hDsK6hzue3fWn2iDEC+Q7mQDnIq8/SYTH3f4UNUuKV+akbrpqtqkQOSX+fXv5wWFAl
 opzw==
X-Gm-Message-State: AOJu0YwQsc1V/4BIr0Iq+eg9y3wE4mjNbt2GbEIFMA/p8xZY2xGZVYBC
 oKNRf4F9P2lMXqkSM0YI4jz/XHeE0Tvnqv04s8MqpidN1u3tQjdRr+xVIBddEX/6R3j5xYMw9Ze
 Hw+Oj
X-Gm-Gg: AeBDiesboSp1pKnQiIOAQcslJenMMqcuKsJNlfgsWOrrOTjfjTngyix8lB+Hcchs7x9
 Z85AA8EvPOgIgjcUicVtEmLKSk0WmrW1tFE3juD3gEn4DIQNlPTO/h92DSZSJbZ/+jHpKFhVWrZ
 WbW0nCygPNh50QdYjdEcr9MnbDVx+nLiaDLDFNYSAowCvHtFj1DIION08l8tdK9gkZShXQnC/Ug
 wBdWWv0SUJRmKJRhK2HAXRCHeIHPpNqeGwGYNdiCvUggrKiN7Tij9ufN8YkSwANJ0Cszl2sW0ts
 xgPl9Ra5LQGAmGnFrG2rV0UWRHMH4VwLe9RssTA5p0cDt2UtTLeQe1xgHL085QmGDPQod+kdt/M
 LiFBDVu7kGOvqK54NIUVlY6LXA/MOGVMywBUJ9lUfyHoEdeaGpsKZWoxiS1ts/GacKKe/4FAgcK
 yWlx6hVYkJXibSdDNIaxWq0DqXCjfuPPCQoulvIeFYd8+KwU3uqUSZM2yCv8z+hK9gQzA=
X-Received: by 2002:a17:903:1b63:b0:2b2:497e:3f60 with SMTP id
 d9443c01a7336-2b2818de005mr110613835ad.33.1775435435334; 
 Sun, 05 Apr 2026 17:30:35 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749a28edsm153260135ad.58.2026.04.05.17.30.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 17:30:34 -0700 (PDT)
Message-ID: <58b5111a-0d0b-4983-99be-b4b3fc86fffc@linaro.org>
Date: Mon, 6 Apr 2026 10:30:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 25/35] target/arm: redefine event stream fields
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-26-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-26-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 3/21/26 00:05, Alex Bennée wrote:
> The event stream control bits are the same for both CNTHCTL and
> CNTKCTL so rather than duplicating the definitions rename them to be
> useful in both cases.
> 
> We will need these in a later commit when we start implementing event
> streams.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   target/arm/internals.h | 11 +++++++----
>   target/arm/helper.c    |  8 ++++----
>   2 files changed, 11 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

