Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B80CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmig-0005B7-6X; Wed, 03 Sep 2025 08:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmie-0005AC-MB
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:36:08 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmid-00053Y-3q
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:36:08 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b0472bd218bso46262266b.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 05:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756902965; x=1757507765; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=06OnCik2XTAAldejRb+2XMAMOLig5Ky+CtEcbrkEXbM=;
 b=u5+W8oqoFBgC56AyXgV8rrLmAbPKtg7BW9vMKk3a+Iyx/yBXD8BFbzMuFDNHZHRVkH
 u7AmuSEklJTL/Y7yr2mpdqAquTMrYJsrKYiwtQp2H9owGwnMgCH+4a+TPgQoLEKj5ku8
 PeDJ3rBF39hooTxN7zPbDrKxXprVHQjecCGWvnPejKgxnrQafEvpoQeiqhq+TDDztBI6
 7oL867/HFAN5BDWn0OQswobt+nFit8lrpsvAq5uEzs031p2DcjHOa0ns5nx2XICMAcDn
 0Obh6Ko36R5OoD85By2oMyGVl3GE/wiEb9Y7Gcsd5MZhnkfB5s8mKUUAS4YwL85vUzBJ
 wm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756902965; x=1757507765;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=06OnCik2XTAAldejRb+2XMAMOLig5Ky+CtEcbrkEXbM=;
 b=FuHDHKygiYcnK/pXnGD2VGVhNaGTWnUcw/ArJJSoKvihnPiX34C8jraAIXjKA34lJZ
 ArzEUueOxcon8QdI1qaYVURKI2rVgiJSk4soJBejpZsTdXyKQbT+u/iCeEz0MmQsLSFl
 jooQVFSzfm+vXZEnj3/vebmGBydt3mjEAFdAtXYAZjcga4+jCols32klRCNdgpLkh9E6
 r+z9ATtBOg5V+aP13nQaFK3TcSVczjKNJ+S0YhjFgPtBB+OwyhbSi5/Q4N+JwTn7T29W
 lqq9v5pU7eH4LsZdLTsEVPBYYzz9xNmAExYX6/Zmt5+4PwvwATQjtRT0keOuJ61H1Kko
 k30w==
X-Gm-Message-State: AOJu0YyI7W6Lvj4t4dotY4thmQ7tLqJWc1MukAMqsI/0IxsZ6Joe1BQE
 okVxeVHuZhaPI0OwarRazItRewUwnKLQzuT/+BU3CVtWrsHIlmPklxa3rc2scv79wKOSRVHrq1K
 cG3F9rCc=
X-Gm-Gg: ASbGncs4/ALObDoMfPUP+asNSp0yDC9HWT9lqDkm7vkOSjN/5iirJelnQc6Qxrl+wUF
 q6D5OTUnrmYzetgawtp0ruOUqhrvKom7Fav6GICfQov1V/56KCfnEd25DN/GJLRNc7IevdQQWl9
 gudZDIHp5aOjTSFTfwWnoRb8aCoV1sCKpV07gPbHH/dwOPQh1DVtzcuzUx4iVXQTOGwqnheTWmT
 +XBdk4wrEgIeIQ5IUP47d1f0bnXcjFbAShzm6uE89bYCN8Yy4Go+nCTSEY4br2MISTg/e8MW/DY
 q0BooaRB64ToS182WR3NiJq1xUeHZEv5TdmS1IYykLSEjjO8l2/cYiddXsIxvodooC/8qNY6Gx9
 Z/NwWGDC18qFDg8xEd1i5jhL91FKR9Ge6OVj5aPLcmhlYfeoVOO76B4aIDOSRc8T27wuqd937LQ
 DHN/jFXw==
X-Google-Smtp-Source: AGHT+IEEgSUCM7QkBU7sYpRXt9wzxAAc8Y76a97RJJQmPeMTgC4tjDecyCrdx1AJpxaszmSZJ8pcWQ==
X-Received: by 2002:a17:907:80c:b0:af9:a5f8:2f0c with SMTP id
 a640c23a62f3a-b01d8c9275bmr1448259466b.28.1756902965022; 
 Wed, 03 Sep 2025 05:36:05 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b046e6c630fsm101754866b.55.2025.09.03.05.36.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 05:36:04 -0700 (PDT)
Message-ID: <89dc6a0f-7b1f-4d95-93d2-1bbbe502a91c@linaro.org>
Date: Wed, 3 Sep 2025 14:36:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/24] target/arm/hvf: Hardcode Apple MIDR
To: qemu-devel@nongnu.org
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-15-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903100702.16726-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x633.google.com
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

On 9/3/25 12:06, Philippe Mathieu-Daudé wrote:
> From: Mohamed Mediouni<mohamed@unpredictable.fr>
> 
> Hardcode MIDR because Apple deliberately doesn't expose
> a divergent MIDR across systems.
> 
> Signed-off-by: Mohamed Mediouni<mohamed@unpredictable.fr>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

