Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE45CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usO69-0005T6-QF; Sat, 30 Aug 2025 12:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urkmI-0006Ak-Dm
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:07:30 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urkmA-0004GF-UV
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:07:30 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-248de53d12dso7642245ad.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 15:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756418841; x=1757023641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c7vY++mSU2EqQPLqYut58DFvA/idUVgIu8VvjYm5UYE=;
 b=kM8HwMBoa3O4hxTJMGyepsYEIwyv3rdJZvLA8la1FZQNZurvB05ISDH26Tv/faFYaw
 9D5NgQkD/v0gEPPA/WENuEKN8QlyRb2DmljjR5Lr/ZZN4Mnoehk9lEw+2ZdsOBtBk92d
 7XIPrCRJElV7yUi7wtCrdqs8F7QI3+3lsaECgPg2hL1GzUBH5iqjz21c3GpOBKsrj5hc
 3m7eJ+pIlzQiUcH0y41+1iMMJgXZRGYjVveDSBCfsPz8nhx7nfSiz0nVNOqUwjoh8XOM
 ooVsJ/XxRSQwZWFqUh+7ALVfDq1Z7s1A8COwbZglgzA58Vw5ISjZO3SvDRax/yRAbXRp
 u48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756418841; x=1757023641;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c7vY++mSU2EqQPLqYut58DFvA/idUVgIu8VvjYm5UYE=;
 b=G27CVxj0I2y/3bjPqEa4bwyM/NbJ8CCfh8FIvh37cQ8URkFH1jvcd09jYGq/QYVkxU
 0Yk/yzh71jUPwew527ZDl4iXzI/F7iBjpS+FBRyY6wYnC+tscl3h//9sxgrmS11YMIp0
 DknSOaw53dmlc8wCpteI9UD09PskSQ+DoqbSwgwf6MAH2GBkBlSukbdMob+arqKKcr9J
 AOBMY+6loueXjrkdHjGEmF9AKNJ9ZOF0KsaqVz1nL/i2ZO8t+FqAxVSapa/UH9HKk6nX
 mc1LjFYbY0SbW/1j2O4F+F6Ke4jBQmYKE0jKxI+yEAAVMigUrN6ZNqngj6vPnopHoH/G
 ZubQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoT1GfdWjFJcMMV4YD96tKwaa5khNj5iIJ1gNkmC1ZH656hg5qXeZSGPThdAzXac7C3oR6GKMevR+p@nongnu.org
X-Gm-Message-State: AOJu0Yxf8Oabp57wFiEwGm65GV+S7HQXtFwkadSFFK69X1+BEU3DVVlp
 9dWXfjtOYqvt74I6sNeS51mS6G5pmzUowL1kLQ/YMWVO/AlRHjGtrNWw7osaYySgFMo=
X-Gm-Gg: ASbGncs7yMG/HPKx6P4C6UoVIgPcQJLaukA5iKuWi839uRUAvM9hdOj28uvOTZa7lWC
 ZVa3EpB17DXTASnrbKRN/8HvSMpCZeWFZ5D+kuR82XWUkBZuhPyrbZ7hHtdjUECYd3B/HnY5JVb
 uGTMUWdJRBmUdhH5hsWnFSUV+4TIQV+e5UwoLgc7PpE6ThpxE8e9QYDu1cmbRvS8NN7wnQd53la
 1W/WEYYcDl6wsTaqAWI20r3mt8S3ZJlkyX+MAVSsbTJCAQ0yWQ2AvT8HuHpPK2+K0XC0zcHih0D
 JKa8JlLDpMozqaMgqIM6Z6UW0jiBSj9FRuyZI0Jhxg7BxXX66t0oZAJSKdAN/3NQgmI7lH2tDXh
 kkRYj+tuswz0llkqmrEagBUI+oJmWS/MzhObf
X-Google-Smtp-Source: AGHT+IEfJ3aWx8r9bNObYOWEYvp3Go8oWXHk3yZmd/N9ORSzR6faJh3dls2IQL/B+6QIxkl5Uru70Q==
X-Received: by 2002:a17:902:d4c8:b0:249:f33:116a with SMTP id
 d9443c01a7336-2490f331503mr2303125ad.17.1756418840638; 
 Thu, 28 Aug 2025 15:07:20 -0700 (PDT)
Received: from [192.168.0.195] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a2f0ac8sm456356b3a.45.2025.08.28.15.07.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 15:07:20 -0700 (PDT)
Message-ID: <96de96f5-b45f-48d2-929d-a76398c8dc02@linaro.org>
Date: Fri, 29 Aug 2025 08:07:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system: drop the -old-param option
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250828162700.3308812-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250828162700.3308812-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 8/29/25 02:27, Peter Maydell wrote:
> We deprecated the command line option -old-param for the 10.0
> release, which allows us to drop it in 10.2.  This option was used to
> boot Arm targets with a very old boot protocol using the
> 'param_struct' ABI.  We only ever needed this on a handful of board
> types which have all now been removed from QEMU.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   docs/about/deprecated.rst       | 13 ------
>   docs/about/removed-features.rst | 12 +++++
>   include/system/system.h         |  1 -
>   hw/arm/boot.c                   | 81 +--------------------------------
>   system/globals.c                |  1 -
>   system/vl.c                     |  4 --
>   qemu-options.hx                 |  7 ---
>   7 files changed, 13 insertions(+), 106 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

