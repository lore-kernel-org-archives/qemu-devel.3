Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8B5C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 20:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttBhb-0000yo-Io; Fri, 14 Mar 2025 16:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ttBhT-0000xp-GG
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 16:32:11 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ttBhP-0004y6-Fd
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 16:32:11 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-300fefb8e06so233734a91.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 13:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741984325; x=1742589125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xvg8eE+psTk5Kp3OJ7j6eBVrakMVWJZwO9z4xGkAHP8=;
 b=iQOJ4a188IaVcOuF026kOuB87tBu9yCRWEvpPaBdXiHga66HFluX+0J4zltxN1rSyU
 r4HdOw9+KYi68pN1b9ejTJj6tasUjX0BMu23rmqgNDhvim3JqARdmuIrppYkEFzCONGr
 oB+Sa4ZCqNUyXN3D3vBLf3m1lexfCEaiwrZbDQ//v32CwDV18aUSRE5TNaplvsF5EBCw
 Q8WPEGENDxLLCsWFBtxnXbhEwY+9AMhITyY1R7ho1yEN2I+MvkFK3X4bOoPcvXvREZB7
 33wNO7TOAGya5YmTCV4wlTp5VCYwtpPx5Yaap6lydQsWyOATuF+PbGwCad/54KQ6+rHY
 DN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741984325; x=1742589125;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xvg8eE+psTk5Kp3OJ7j6eBVrakMVWJZwO9z4xGkAHP8=;
 b=mhGRRJVsPf2hsnZtQLZW070WaklAjs2nnUfEycnFDrCsefjka3CSjxx0fxh4TqRz5y
 iydrx2/Q4Js8gtEQIT01QCt/EtMxlGaONFi0gGdtsrLX3azg1/AzQRSybymCdYoA8qzB
 9BHTiSQQplApsgfSD1QJ5P1OChVn/C2khxgyX8BZoZhi3SpyhJsbnyYywWBGQYC4Y5Rn
 woK7pOVoNUUjcblRvCviZEZ8eftNS/gqNzGqX8mVB9qxjdyvYmtJ0il+jvg8zd91Ltf/
 BjFYVcMnyhCPrql16x63XDcBKBr9IiE5gv2sLtL7xuGv6mT+FxADVTY++04i4Ukha94M
 VTsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHjycqxO3nEdD7HSEYve5ACGwneYO6x06d7hdxITv40dxu9hEUJsaT5B5c1QxAGdK8QEUo9BFlM/SW@nongnu.org
X-Gm-Message-State: AOJu0YybugL1yonyXrgFQuIlWhTgjuxRoetYSNEtaUPXOUpbYmCvxzou
 3CezpesV8/JIbfI1x6qXwU+2aty4Wnsir75lpJ4NNU9ll4SDcv0SDzGPFoualQc=
X-Gm-Gg: ASbGncsdfC81arfb4tsogBtSye5TtPhecTDXXfk6Wx543ytnLL86u0MAKG28qyNLtya
 QOlnjBsa2xZuO83OQMbzacztk9h98N9dplIolL8XtV/hnfryow/2BskBIM8YDFBznNedkFsxJcg
 EmtFvqW++BcNx4uoMej+OZZdK93/nag58Yy6mSR9Tavb5sqlO+svbR69E9yos41R/flz8lLJIV/
 Vwy9oimJNR42zb2C+y/1X9WEs3cw/SS9Q58EW4J058fq77hOXX1xTzzuAE2yAOYkoqmuj5RoX6r
 BFrh0JyR4reMQSKWc5XB5dHcxUJKgslFO8e5Qplx/MUqIcXMDHDjzRpykds+NdyRzHFHbSXhyK0
 nZvmtIsMF
X-Google-Smtp-Source: AGHT+IEq5ESIUy91CBmy5tlf/H1JMH6mwIMNneI+Mi76A1Goa4CtGX7GGw0KLcaQNuF/xBEeOGJDrA==
X-Received: by 2002:a17:90b:2f4c:b0:2ff:4bac:6fa2 with SMTP id
 98e67ed59e1d1-30151cfeea7mr5261288a91.16.1741984325266; 
 Fri, 14 Mar 2025 13:32:05 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30153385044sm1501717a91.0.2025.03.14.13.32.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 13:32:04 -0700 (PDT)
Message-ID: <0bc6c77d-d091-43d1-aff1-df836ea827e0@linaro.org>
Date: Fri, 14 Mar 2025 13:32:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] host/include/loongarch64: Fix inline assembly
 compatibility with Clang
To: Yao Zi <ziyao@disroot.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250314033150.53268-3-ziyao@disroot.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250314033150.53268-3-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 3/13/25 20:31, Yao Zi wrote:
> Clang on LoongArch only accepts fp register names in the dollar-prefixed
> form, while GCC allows omitting the dollar. Change registers in ASM
> clobbers to the dollar-prefixed form to make user emulators buildable
> with Clang on loongarch64. No functional change invovled.
> 
> Signed-off-by: Yao Zi<ziyao@disroot.org>
> ---
>   host/include/loongarch64/host/atomic128-ldst.h.inc        | 4 ++--
>   host/include/loongarch64/host/bufferiszero.c.inc          | 6 ++++--
>   host/include/loongarch64/host/load-extract-al16-al8.h.inc | 2 +-
>   3 files changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

