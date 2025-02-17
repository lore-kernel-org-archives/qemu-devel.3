Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22BCC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6mw-0007tE-Pe; Mon, 17 Feb 2025 14:28:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6mv-0007sg-8b
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:28:17 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6mt-0007mD-Mc
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:28:17 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22100006bc8so42869295ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820494; x=1740425294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5+wvz9eIhmxe+jQeL/OzbSXvA9u67j5Kr7/WcCU1OCg=;
 b=wfYoeRkMvF0yQ7Gv2QqiaWHeaarxCD+HNR3XFmaNGByMElbmyBUBiI6lWHIyuD24cR
 N/Ur4LK+ZuAMFgv6YUSSpyjVxAJL4qmxYC/igXNo3y4tOsQplp8Qy29P1g3v+zW1iXI0
 Ghl13xJEaNOLaCyRBarjd7loNCYT1AWc5ulOLIwhlc8z0Vkr78kTIWxT/1S4wvCZW7k5
 5Ic90uStdomH4xORr7TnFCF6+wpNNKNuilbE/x9194YGAuY6KAnNYI3srhsFZqsMUMvC
 YzoKaa7lAu0amMTl+vs5QfKrw5Ph/BuSk8BaB2Qvcwn6gHhglHy1C9bpa8eFcveiFEvV
 ewLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820494; x=1740425294;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5+wvz9eIhmxe+jQeL/OzbSXvA9u67j5Kr7/WcCU1OCg=;
 b=O1BJRYjxdIln+bCPKFGq67mcnnhGN24zZvL0m2K5JLqoMT+pTwW+j2GiYixekrIeSJ
 xIdb2Yg7f3Z0g7c1Upp52Kt2sclTE7dITMd8AwnvU8kVtVGHrjmfpvt5QUTnTeWMA5KZ
 KwROTkxqM9y2xXODCTQ7YpnDLWyu6pGmO/6WoprZjOipXwHZQciB69XClJ6LEfDY4g49
 CLuAmeQ78IHK/sWnxqEIHFzl3A73m48DqJ4fsxhKO+ZlCd5pdKyy6pag1756FuPWeNtB
 0yJ3x2ybczd1Y9LpF83WfAQYWaWsaEwYEYDxa63G//sAPl2CFn/lWCGol07IIMCV7hW2
 qSNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsLK58NJgjP2hspN1pESfFr6+t5XJjUakFqd9Jbfu6ehM2U3NQS84tTSyl0zu7rsTK9Xl9GCBlff1W@nongnu.org
X-Gm-Message-State: AOJu0YyVfcxSkQ4UeX8g5UoI5/4cf1hsBpeQkEMytX6HtZcE7HpMMXwz
 nqtLmUXg1x7t0wuLi2OuCRw+vcrn0/FgXhgZXpxijjJzMkbAMdqjt1BRlAER0xw=
X-Gm-Gg: ASbGncs9LUAtusASqeujyWblEFFaMawboQ2j3FmJkqgnGd4Pks1sWHMDhpTdD+lAjbg
 uuJSSlyV6sfljYrUhLCoUIjEwEuB1MHbuL+KZ+T15UUmFeNxv6kIEcbgWgmajEw/5JETZjhhK1f
 vFJ82Zmn45KHcNdlgZzpWo5CDRsuluQErJsXpyMQ35UVmsDICcBeWQeFoHbntucscqOwp5+5NB8
 QRU96KaFvccD8hQ/V8Q/Ek0sTezCXW0UNCZ5AzM5B3wD40Ukso4CqEX07JtCRZAdchJ5nbfbtMN
 Xws09AGUMs5pNggZ3Bq5+jMmUQ5bJgMlHJHF1RKvYyo//AcRazDsEIw=
X-Google-Smtp-Source: AGHT+IGp6QZWkzYUQtfQYSyRuCtNk+vI/+ffrlQCqOQLqu7K3NxxHhD5WBOqfy9ESHELmTrhBt0V/A==
X-Received: by 2002:a05:6a20:e347:b0:1ee:c631:6057 with SMTP id
 adf61e73a8af0-1eec63162femr584426637.34.1739820494152; 
 Mon, 17 Feb 2025 11:28:14 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73251356d78sm7011812b3a.100.2025.02.17.11.28.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 11:28:13 -0800 (PST)
Message-ID: <de518cfa-dfc6-49ed-9ad2-8372082ddf4a@linaro.org>
Date: Mon, 17 Feb 2025 11:28:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] fpu: Build only once
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <20250217125055.160887-11-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250217125055.160887-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 2/17/25 04:50, Peter Maydell wrote:
> Now we have removed all the target-specifics from the softfloat code,
> we can switch to building it once for the whole system rather than
> once per target.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   fpu/softfloat.c | 3 ---
>   fpu/meson.build | 2 +-
>   2 files changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

