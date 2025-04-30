Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3911FC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 17:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAB8B-0005b9-J6; Wed, 30 Apr 2025 13:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAB88-0005TR-MS
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 13:21:57 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAB86-0005lv-Ve
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 13:21:56 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b1f7f239b31so868153a12.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 10:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746033713; x=1746638513; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RwqLPUzFqRBhMYQPrWvT2dMM1M5rcE5U7qOdvEw+Wew=;
 b=gMqamjffLlIwtyycqb4hRuksHZpxePdA9WDzfvisglH3MmbJQOefvFquXw7ZP1dG2F
 urZo0cdDejwHGyAo0wNtMyWvR8c+BJXOuZFc2cU73X2/XbX7qOCk412ujg7BaeJQONm1
 bGDoo14HezzBPCC23c1SPEs9XJsDBYCv8EWeH/mHpmUvTZMzhL3iM412FbHlSDwOZ2V3
 BVXaSFEAyV42U82uB0U9yrZo+y95v582mAdJb8Nu/QOW7iy021eKhHmpwZ3j3OzClGbg
 p58vJG9Trgos5uSwU8OnXW0KxGLvBpXqaFFHt6T9AKHuHyr5CIh5pCeceSp2mlS07AR1
 U7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746033713; x=1746638513;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RwqLPUzFqRBhMYQPrWvT2dMM1M5rcE5U7qOdvEw+Wew=;
 b=sPgUvvHjwz1UoeWM+V5l7C6rwwoJcHIjWQgEmXoKJN4AxM4mDsVmS7R1tXCHe1YATn
 9zXhfmgJzGWmRljGE0H/pwP3zE3RvhzLRthuDIQTb4J0C0NYdMWxSFMP/zA6RlMsBjRU
 jEW/2BXSS672iIuTEX3Rz86lsPGUBPZbv94yWePijgMsl8mZN2uKk2e9uVmmmjiNyjal
 ixgqPBrZyWK/ur+Hsf2dpTGhldOxTqtgxYTqJy9lYyUe0Df37cBElc4YvyMKPISn9mtM
 gVbtNjPjKshgUNgr1+lIUJ8kBi6apG6KmaF0LXV8TVoV5avtCI+AaeZoRsSXIwHxwue+
 kqFg==
X-Gm-Message-State: AOJu0YzfCeKirWCohjLlsAh1UHagIyAAnQ72sTXWI8f3zmz8d+aVUriz
 vK16OCW1B9uDBpsz38sLIZylc9ljcPP63UHP+kKwr44d6ONWBx2nMLpbvcryjkURzOh0Dv+WlHk
 Z
X-Gm-Gg: ASbGncu/xUNfiB3DphyFHV59qHRW59nt8/llUW0NbGFN+OFukZeNGPzhgHQ9tV4+8BA
 PCx62BNsoamyQ4zE8aLnzvnFUv0vaPE6abXQqsjDYPpkW26CDi97g75S7bQA/EYhkZmUIB21qQa
 NtyYDmhRkiOIp7PNiRqa6FNZdQuqoij3LgAhFaU7DXRTcl3B5qoO3Jrw4OOz03tbcpaxjyAOhrV
 heUFyQo0SNbZkFg9Ls8itN2+LFeoN6H6WvzL43i+nmBqMYBKQp9N0KTv66UtKvcycU+xhEJZOHD
 1BXU7lpScVygwVfSRqUycnsmu2FUVKWnrlo1Omrhlo2ZpjL7G+shlkhCSS5MHezet+QcKI2IQiq
 2C89r/0Q=
X-Google-Smtp-Source: AGHT+IE9YYTFBSscpvQD9UqddrHpR7Lwa7lFBAYsCIbcjx0/dqspOx2v4kDHNA+S1kKmEkuutFv28g==
X-Received: by 2002:a17:90b:1344:b0:2ff:556f:bf9 with SMTP id
 98e67ed59e1d1-30a3ed5ed69mr499874a91.4.1746033713169; 
 Wed, 30 Apr 2025 10:21:53 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34a3922fsm1893408a91.36.2025.04.30.10.21.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 10:21:52 -0700 (PDT)
Message-ID: <a48b8151-f6f5-4380-870a-f146eb15591b@linaro.org>
Date: Wed, 30 Apr 2025 10:21:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] target/arm: Remove TYPE_AARCH64_CPU
To: qemu-devel@nongnu.org
References: <20250429132200.605611-1-peter.maydell@linaro.org>
 <20250429132200.605611-8-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250429132200.605611-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 4/29/25 06:22, Peter Maydell wrote:
> The TYPE_AARCH64_CPU class is an abstract type that is the parent of
> all the AArch64 CPUs.  It now has no special behaviour of its own, so
> we can eliminate it and make the AArch64 CPUs directly inherit from
> TYPE_ARM_CPU.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/cpu-qom.h   |  5 -----
>   target/arm/cpu.h       |  4 ----
>   target/arm/internals.h |  1 -
>   target/arm/cpu64.c     | 49 +-----------------------------------------
>   target/arm/tcg/cpu64.c |  2 +-
>   5 files changed, 2 insertions(+), 59 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

