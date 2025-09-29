Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5FFCAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 23:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Mvw-0003rJ-SV; Mon, 29 Sep 2025 19:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3Mvu-0003ol-PM
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 19:05:26 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3Mvs-0007hV-I6
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 19:05:26 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-32eb45ab7a0so5913289a91.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 16:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759187122; x=1759791922; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QpidpxXj3OIxk9jGKqLchCwj9QBtutOgzvxa4+ikdk0=;
 b=C/zLEylQhHm0MTGd5Im6lzYBbaKvxqZrAcY/aMczjrR3KRQk0Ud4XidXG17RLSGisX
 +sT36lvZ8tm9kdGbML2GIr2zq/kD7Le9wh02pZ/ToTxawIjorZGaYCB9HM49OxI+aPQi
 spUSuDxxIJBP+SOeuCEoejhNbqOG0iyI9INBZVUv0joIEwXXWjLkK9ehb2nvTJpNkR/v
 zy+NEgvmDZMOntgaqzHewAolZgd+aSt9OfPlR4H7bg9d0F57A1ADI2wDBioR3qK8wx8N
 Tn+ZMtGFwrl/nKRqPgEi+01NBxvSfMObwjfQn5kumt8FxPZYPwdKjh33GRXcx3K9lbiI
 sCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759187122; x=1759791922;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QpidpxXj3OIxk9jGKqLchCwj9QBtutOgzvxa4+ikdk0=;
 b=nynufSPaaNv+2EOTIpTjJfu/aeDGnfrUcgB6lUDiLg9FuDxZ41ijm43ClRDE6X0dmF
 xT+EduVyL51+G2LzSKYEQrj7r2jj3wH36AkDTrJsO3CB0HlfjQty4KRDRzTc04Bb8azY
 qhoo7cOep6foC5hIxO/1+0HPrRZCAfY0afsmphEiDFdbuTdglcWtRe+sYO6YOwImVdm6
 xBSuUykcymS4TDexq0U72fVyeymQJIegyJa74f5yR6UEtYuCop+Cqv67spixwrHLfUCr
 1jcw42KU5Ws1NkXcCJ7EY8BhKetCxxnkMWJBP00/crG+t/4nNkUbYZek6j8zNWynGNvk
 8paQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD4bR/45XC7180CEAKCp9hRh6qEmryHMaFZkaZmMS0eCOzjA0GxVZ5oh5VfX3sLmqDUYYBt+Gu1V8A@nongnu.org
X-Gm-Message-State: AOJu0YxTIkUwje3zA/FzDCeBDCDQseMVGEWQ3X3fO2nKVlNrcsxDvGik
 a0EtmHVWeoG9kg9xYJLsHIu8LdoZmDyO/gToGDAuLfc1FeFfYRg3WDap9KJF2FZKMi8=
X-Gm-Gg: ASbGncuWrZwFzl+RyZBdsA2W+KcjjBrQcKmHju9ouxqTZegl73VsXi4n7qrcEjlxlLA
 VypXO+WRGSUfD7Rr+EVWBw6+Vbww+hdlOsyj2JkEroBHP5QGuAPN+3rEaM4BBfXBbTIGifkkLKK
 wNon0oLup+vl/0DoYL1eKU27aSsgsl8gjTkfAMi/kDOKpAhBQNd+oekbBj9xrI8bwdJfCskiwXa
 GD80ntBIY99QRxWCR5EE6gYL5n6Z9nvxRVSFz+JXAla+iNuKUoPLp4Eq62ZovtIW0+eiX5hW03K
 ibID0f/e4EUCsqjs8sheRt4liH2wEULtJfLl3yPSnuD9Rrq5PeuBq9BvfA8+MVLIugskcWuNHDV
 14iamd5zwI+/6wsftLDGD17EAobtiYIJNCI6XHTg5sBiUquXOcO1FtwtfhqA7SfeGHfCypHIBr6
 aBQxUV
X-Google-Smtp-Source: AGHT+IGq7n5yrZ+kWh/s4f9jtmPnV34eVVh2QQrsBFuE4N7tViy9uXl/jU1UG8ejWVw6L4XW5nQbDQ==
X-Received: by 2002:a17:90b:3b90:b0:330:3fb8:3885 with SMTP id
 98e67ed59e1d1-3342a2c2a9fmr17485183a91.18.1759187121770; 
 Mon, 29 Sep 2025 16:05:21 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3341be14601sm18205192a91.14.2025.09.29.16.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 16:05:21 -0700 (PDT)
Message-ID: <e7865901-ecb3-48e4-83b4-479c537af9c6@linaro.org>
Date: Mon, 29 Sep 2025 16:05:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] target/arm: Enable FEAT_RME_GPC2 for -cpu max with
 x-rme
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250926001134.295547-1-richard.henderson@linaro.org>
 <20250926001134.295547-11-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250926001134.295547-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

On 9/25/25 5:11 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/cpu64.c        | 3 ++-
>   docs/system/arm/emulation.rst | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


