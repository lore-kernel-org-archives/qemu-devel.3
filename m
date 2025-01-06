Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1282DE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 21:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUugi-0001n0-Ex; Mon, 06 Jan 2025 16:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUugf-0001md-4G
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:31:01 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUugd-000448-7C
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:31:00 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385e06af753so7448980f8f.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 13:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736199057; x=1736803857; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dXS31NX5cgSGxQM4C7hvRn6k3RiKwe6hPWkNFluMZA0=;
 b=jUjBMwS5hKOYXYleOx0v2leVtp1oY/i7HP2+Ly1Dp0/UhIE7cG8ugnsrCrL3NDjxk+
 5AI03V64yC6Co5o+Dzu9fgreIMCmCWJQY/uh68I5IkmG/fXE0ptR4PTO9vLmJuU6HGuA
 lzxsCc+v5s+td6aPlT1BU14PjulZ50QYzPWuI6IyRH0Kl45vbFZBgnq3s+65B7jzaZj1
 iiU8jfqsH/SGAGKKHp+sVv3ETv3IlsM6Ikyap/xNLRSK6rxBV7rNxQK+Agf9KNYqgvvk
 BqsRjVb+PozOPa0+RsPO6YO7rV9Lxq2Oq4NR2dDn8QNajOSJEoGOEGdnJnZvQeJ4FUE4
 2DmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736199057; x=1736803857;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dXS31NX5cgSGxQM4C7hvRn6k3RiKwe6hPWkNFluMZA0=;
 b=SdG42nvJ6hhl5d2MiYK4GRW4SVt7kvNWik2ne57vM8WZV5rNpcVvpHvVeHecq7bZ0Q
 Bw4+ySiu9n3my1xucFVW0NUznKH51vZ1vOdTl2CCNY2CebrzNp47w4PaJWSKr/3i9eX8
 yOP5taLUB0Ika3e+t6Fd5DEAddQgG7WDX4OKur0y/H/l0WXOt7eTv5hoDZYr087dyoSl
 bSz/IL8f3Itt3ybSj4fQedr79KQET+pT9PwnCpCkA8aammY41IWsii4CPsxUFS4SZYzx
 Xfj4hJ1IxgkEoWK7Y8FELAF6TnxJjCoE6RxL/ke81fbnLjBAYPXqnGrs6uM0J/0mHkF7
 bnUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1GL9gC5BS6d0oilsmmDO0ZylUqjzRX/jCmkbnzeeV2dxtXhWovBk6jLNPscWVEcXbl2/+NuPD1KbK@nongnu.org
X-Gm-Message-State: AOJu0Yw6gphsVOZFnIUQ59/tgURp+oSfJw/DdveeJCCYQOpTyuO6hGh0
 qRjbROwdViybyFTegZKFIuOihrIpk9GhSCLFbR99cADaczgbwu/vMGbESjNTAw8=
X-Gm-Gg: ASbGncvcwyrj4nNczspf9HnFUvRgkpm/WOXL5Nf8NsHk7uoryuPJIeEn0SYc+4oj9+l
 a4xCYuWu0Yewd805JToRR9FRlfbWZ/N+IkmwW/eOTkHggohmr2Bt73wVx0fFATCAVXya5cz46Ga
 qzKXrNJu79ziCZMCILygV1sKMBbc4qPTtmfOKc4LbWv715wAHJqYS4dIDlPbsCqHkLN29LQZzCB
 bS1bPGJH96Z8PDZvkJel5iFhpYCKgbF9g2Kwvl6zEK3H4+RLiwIe/oiBQFW6EWJHK59LqZ+2NT9
 vzPsShgjP7MxtrUa7fqdeHK7
X-Google-Smtp-Source: AGHT+IEYlbI09otqimSkw/sSdMj6J8i/6FTHV6wZ/iyK2o0IE18jaFMYwJOHUNhgBFvzgJyiBb4DNw==
X-Received: by 2002:a5d:6d84:0:b0:385:efc7:9348 with SMTP id
 ffacd0b85a97d-38a221e17famr53662535f8f.1.1736199057248; 
 Mon, 06 Jan 2025 13:30:57 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a636asm50057906f8f.88.2025.01.06.13.30.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 13:30:56 -0800 (PST)
Message-ID: <e9523907-1795-4884-863a-8b2c6cf13eca@linaro.org>
Date: Mon, 6 Jan 2025 22:30:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/73] tcg: Add tcg_op_deposit_valid
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-12-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 2/1/25 19:05, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h |  1 +
>   tcg/tcg.c         | 22 ++++++++++++++++++++++
>   2 files changed, 23 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


