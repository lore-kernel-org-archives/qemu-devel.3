Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B754DCEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKvMF-0007Pk-5v; Mon, 17 Nov 2025 04:17:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKvMA-00075Y-Rw
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:17:07 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKvM9-0002cj-9A
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:17:06 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42b387483bbso3365424f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 01:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763371023; x=1763975823; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p6ZSscRBOcogQcLuohWhBc8RpLxt3YQ/rHYTFydc5Q8=;
 b=t3FmdmLlSqdF/yCyWcokVWJNfZCDtEnADBPjyEUc3ADAaP2Evvf/diUsZHFlSR+quh
 JZ0q6eQP3JgiIqN7AVgyCiFfaaM3A9SQT5WZHujlB2YJ1U57RGjPFuLFhGjYFtdo+Y/u
 BfrGAZ5/L6lR6K/Z8G/eVwXFZ8xnEXOJF+eKTwGSSqkBhw7d7hDsYPZe9Jb93FGFca7Z
 ggN6kXXXRv8xSRkoQxAT+MGOtZyCge++oqKvctVSoKMTxFMDe4+WkcHway73p6KUl60b
 q6dkOVGopvpEVTlXqDEpGsOYcXQbOUQTUNgVuxQRWZOi/3B4XEYWoleDWiOlIxeLofHa
 xAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763371023; x=1763975823;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p6ZSscRBOcogQcLuohWhBc8RpLxt3YQ/rHYTFydc5Q8=;
 b=a4mIFMqQ03x7FYuQ0Q2M6lR5wmdynJY/Lg0RSPICC3oiAhar+bhVGRNv1ZUxH/u4Id
 MSLrqyEUNhrfPFtXcklp/RSSl5Bc9TNB/zObNXY7V8he4CyRTMPRM+xzMWoCRsSocR9U
 C775CDajCrnVpVxqwmgXiEgT9Ru5A1JrOzTbnhTXTnpGmmeukmdNsvoC9ZXC1I0mAlpe
 54Js/r187klJas1KMC0VAG2WYa+yz82ctG6zVLYO22CZkBisOyH2v0AgPRI7JYoT042b
 beraSAry9B/ByMSUMEQQ0aQQMEPKCcCwE/kVFgUA6FQr1thbjG41fbWAiq26oACcqrin
 80Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/ZOgWYuUy25DtqPoVKcy50sLmCUW4FTJp2bCBy7DOiJy+DRX2hL053nEbBaRZaU1McFJKjJRdnq2L@nongnu.org
X-Gm-Message-State: AOJu0YwP17xb7ysjHIo5ctmp/q4GOi0uwtAdHDgT1YIaL1W4IN8Yu4GH
 +IVRS7kzRyC7OpJzluLIvTZ0o5Pg97W0/+fLFwqiCZqLReQYeu5xP2cQhQbe0Gi2T3RhflAv1Nl
 /SsIcKEA=
X-Gm-Gg: ASbGnctgQnPDbFKOg1Vi57idDEYzp33SEGq2lOEybiV1hIoCO2Be7sqtXCsiBBdV8SR
 zpmmAX4BxF6vmp13cRch1IaDoMYj+rXi8VHAJDSJkwDE467aSHdy6OnLfLXKcSyAcfIj9U8Swmk
 doVvzFAFie8Vb0+HFnvIWtqe2E9Ze+iq8PbhYo6ZnQMD5jvfV4BeKZglJKkZHXR9qlZ8gSipcVj
 x1FM71HcxRO5lwPbfYt8ZoQuKt7RKw9Sd124wujOPK9yycRSmmk0kJSajrIYgjeXzn7qkS7rZzf
 JwnzXFnbsZmvsAGDet4NJxpw61YnWCDbcoFR3bG5VzKfIbKVYePLASglXDyLhQSe2D9L1MAMD0C
 PqO6Fmk2m7RLILM/QIZ17+sJmaVxA8WG3JwODSycjf46PlzukWJ0JGbI9X0NBS9dp4sda0zTO5k
 +jp9goiyf+0/EJsupct777Yv80iJiOJ3gRXyTN+NEZdmXAW5onzOVEszsXL1Y1
X-Google-Smtp-Source: AGHT+IFdSY20K+J4cbbFAMDmIuId6mDCADepCVeIvgmVCdl1GkRnMAnFiiXrKAnf1chjcmZ0rnbJ5Q==
X-Received: by 2002:a05:6000:2306:b0:42b:3ed2:c079 with SMTP id
 ffacd0b85a97d-42b59384adamr10800444f8f.48.1763371023209; 
 Mon, 17 Nov 2025 01:17:03 -0800 (PST)
Received: from [192.168.8.105] (66.red-37-158-132.dynamicip.rima-tde.net.
 [37.158.132.66]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7ae47sm24637054f8f.4.2025.11.17.01.17.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 01:17:02 -0800 (PST)
Message-ID: <988ba21c-10e6-4317-8d6a-2b559bcde785@linaro.org>
Date: Mon, 17 Nov 2025 10:16:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] scripts/clean-includes: Allow directories on command
 line
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>
References: <20251104160943.751997-1-peter.maydell@linaro.org>
 <20251104160943.751997-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251104160943.751997-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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

On 11/4/25 17:09, Peter Maydell wrote:
> Currently clean-includes supports two ways of specifying files to check:
>   * --all to run on everything
>   * specific files
> There's no way to say "check everything in target/arm".
> 
> Add support for handling directory names, by always running
> the arguments through git ls-files.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   scripts/clean-includes | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

