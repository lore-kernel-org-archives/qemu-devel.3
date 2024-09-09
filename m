Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F83AECE589
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 22:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snmmh-00071g-3x; Mon, 09 Sep 2024 18:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmmf-0006vj-Jy
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:22:57 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmmc-0000Ys-Ss
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:22:57 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c3d209da98so507008a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 15:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725920572; x=1726525372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kXhmf0sJOO+szpAUdv4/KyunbfGxi+YgK3pdDbxI5AU=;
 b=Sip1UWLcy+mgU9YE3qSdaqIQvSXFeoHNQU9vmBlvTdVfPrA1ZJiNm1JXSgtZD9ZKWF
 MXXxnzP4hE62EETU96KZS4jNjHc0a85QizPbpT6hwKH9tZexrywhEILM591/Zu2GnR8q
 XJGQbRyY9GH2JTy77Ps/6OKNo+UHpgUsUsRuQq0kFpN1kHG2sRIAPQUUWjYnxlPM7N8T
 BDnfh84HjwwO2NW6Kc6i6k4y15iIfOatDja9qNkXFqEUEzABMGzZZacIA6q7NhOWhBSq
 QXHVe/pIyZbuyuV3pKYmVeCXS4FhJ8rmvYvOelifgFQZL6VeZqiNcly+IiTaKZUJOBI7
 8x1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725920572; x=1726525372;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kXhmf0sJOO+szpAUdv4/KyunbfGxi+YgK3pdDbxI5AU=;
 b=t6Gqc+S78LLXlmlCh0YAU4ht7EfT9zRNNTfaERqu9VYxIObDT8JTGynYAZphMzgdHo
 k9AexzLSgkqW6TBpY0hkSs/xkjwiyzqL6ZzgD3uX5xKcj2HgS8idBYDHViEmMz96KUh5
 TYVnOH+2qe9VQx/GU/yiJjp+2YRCfOudKOWO1ajavQ2vRXunQ0xvjbiCq/uBRaaD2+EC
 /wL20efRCBA952u1t7J9ili7zGZwwLUuhfye14aCy7rRL9u1SjjkaiQ+Yyfr1rF34lXx
 dXn2SGHuSi3ujrLGKs1/GmTqMvCCoMqmaZzKnIAJLdMY0dFSeLritFyLUOtNG1nQB2Uk
 e0ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh1y0zhuKrSBnat1Ri9qheV82oIoYoyAB5cS3F5gokLUsIH8uDyJulzJpgSxf1UQ1eIZ1vcVBHsx7g@nongnu.org
X-Gm-Message-State: AOJu0YzyjmFwXVOKZwlGnOLYhU8QMt+lyfXFQ33MLx9m7Izqf7KmHXCQ
 c9eC+rDy07UgrFQYtmJ9pFSsrZCqxAWqnxE1RfSD/+1YW66Cg7aD8Ki/kvOfQcSntik7279QHhg
 v
X-Google-Smtp-Source: AGHT+IGud8gpI2eCX9J1Rsdpz/rlGvXdOLjNP46ubyWa+v4+Z7e9U+rYNzHUyYWkyWOazY9wcuKnGQ==
X-Received: by 2002:a05:6402:5106:b0:5c2:6c75:4359 with SMTP id
 4fb4d7f45d1cf-5c4015e70b2mr1334477a12.9.1725920571782; 
 Mon, 09 Sep 2024 15:22:51 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd41d46sm3481348a12.12.2024.09.09.15.22.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 15:22:51 -0700 (PDT)
Message-ID: <3b62b084-9783-4c08-b7a2-6b7d91c5b5b8@linaro.org>
Date: Tue, 10 Sep 2024 00:22:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/29] target/arm: Convert EXT to decodetree
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20240909162240.647173-1-richard.henderson@linaro.org>
 <20240909162240.647173-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240909162240.647173-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

On 9/9/24 18:22, Richard Henderson wrote:

Pre-reviewed:
https://lore.kernel.org/qemu-devel/10eb7805-6de3-45ec-8d2a-f5af5f63545b@linaro.org/

> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 121 +++++++++++++--------------------
>   target/arm/tcg/a64.decode      |   5 ++
>   2 files changed, 53 insertions(+), 73 deletions(-)


