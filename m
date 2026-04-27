Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBAEFF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHISd-0008Bl-1D; Mon, 27 Apr 2026 05:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHISQ-0008AO-Ry
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:40:51 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHISP-0002ez-Bp
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:40:50 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so124869055e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 02:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777282847; x=1777887647; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OI/XUUmJ1k9bCiqYw7ZrMT82uZdii8WejCNlRJKGRqc=;
 b=xCx0WNjpYydS+6Iqx+KLOHmnSEPJjMxCoM/kF+UaQO1bmSPvG5ALAicYZciinpo+Ty
 4qaHJMDMAnhs7+no99m0owIWU8m3GQpGLKvTyAHZgVmYBCP2cRSDF9Tq82bf6TiL7ZAH
 hutyWAHRw4rmHofnGf9T2Pc9z3qgabDo8YzuovTRlJxqObpj5DkAez3AvGIqBK1t74U5
 4Axgm49n/v4C3deXhUeU1FG05ne/05GXAgAT26NP4XsHCun9H3H4zOOTOIiknwEWIS45
 1Vtg5yEuTSnI8twWL+NTL84dM2wEvc+UkOf/IU7umWnOJmnODZ0cmKS2lRWUmEn6jCAK
 ci5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777282847; x=1777887647;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OI/XUUmJ1k9bCiqYw7ZrMT82uZdii8WejCNlRJKGRqc=;
 b=gV6rUoo/Ni7vrW4YYcTJkXIHWJQsEI3SdQ2LAUE3Nf2GH5F3x3/DJV+Ox9EWD8nZWI
 zUaQnopAIMd2W/Q/cFUY75Rp2tgtf3daZX9vZOULE1sLk6NIotRAf6yIRK7vPxg3dY0a
 QCvCMwsUVxgq1b+wTbudgPQq+4yDMj/Bed0/qD/rs4LSw8Z+iZBXmiAWGvd0ALjkFVMy
 83sztE8HUcllBEVzDK1xpjBRIVbRALZjpZsrsR918M0mg7bfdm3tQ/1HZFHpU+HYgewR
 Gwz2WghmLfIvV9bJoUfsmMKCymGgmqeoYVKjx41C8tts21IyV+RaV2gfqgobvQ7mzQuM
 Av4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ934jB449tc8W/SfKO+YSoPs1oeQXTRS8z2CMous/9m8xk20DxaUtYihprJzJcTiqLYWySF95B2oI4i@nongnu.org
X-Gm-Message-State: AOJu0YxKdLmOczHp3YHhAK8wD38nj5HZ7AQBavT7iiNzmxokaycoqe98
 Ydf9qsOktS1LL/+512WkAkX+BB00DNPrELEEFCox+jHDiXVKlxApKWSaeBtK8Moyb/o=
X-Gm-Gg: AeBDiettvdakAb7fUQZa9v0e8KHAqaZjJ3T+ZWsoUemGNIhYDjr4jdzLFFDXLc6/FAq
 LJXDRXe4IO0zSg8Jsz9Et2yXUDFymAho7a8RbKSatGWMmmw7U+fEJQvP9WD/M3oTFFC4LQ9KBEE
 +BufeiwcTAZLKQve+piBbHBn5n0kCx58O3KL9GKWc189Okj7cI6VvP4neWbcYzOG1JR1hOUTa7M
 7cxO0fLxSZjMkKZB/SQxVOgo8j/PW9FnkCdRBhrJ/NlEbWBrqs8gEZUF3NJfhiR2ZysmOJjELS7
 6O2ePcDQOPexNYygVqu0jTQ3BRKRKy8uaEKhmC+jZEUSrbs10yKxhswjUldLC6uPhSbexkV/jh5
 3fM41Yqsrviyoq1MYlh+kKTXgDo3fvDNzPFjLMT72CQ9/p2iIdEY6HQLk12hm50QTzniWmEaikt
 686bf1h4UTh+OxedVcnWdAtMh2qXx8bWLG/UuEf1T32jQLhkqY3txHwPk73nMjOgD3lhZWkDRzP
 4e9
X-Received: by 2002:a05:600c:c10a:b0:483:2c98:4368 with SMTP id
 5b1f17b1804b1-488fb771613mr456821255e9.18.1777282847172; 
 Mon, 27 Apr 2026 02:40:47 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc18bccfsm704168415e9.8.2026.04.27.02.40.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 02:40:46 -0700 (PDT)
Message-ID: <8a4865a1-3641-434e-bd65-6b58f5d336f6@linaro.org>
Date: Mon, 27 Apr 2026 11:40:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/84] fpu: Drop parts_addsub
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/4/26 15:38, Richard Henderson wrote:
> Use parts{64,128}_addsub at each call site.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 22 +++++++---------------
>   1 file changed, 7 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

