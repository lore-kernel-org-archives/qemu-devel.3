Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D53CA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmeI-0008Sm-Ur; Wed, 03 Sep 2025 08:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmdt-00085M-0C
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:31:18 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmdo-0002BA-Tx
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:31:12 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b0428b537e5so547623366b.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 05:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756902665; x=1757507465; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LWqZcPPxJh6+kkpPEpgUh1TFhaO4kspJtbqV1h4Eg0A=;
 b=MWzuotXGo2l8ItfY0xmk4F13b2frgQGHYXgSdXKTjH4JeqJNsRiZr/AT1HNHg7Rn6M
 wngsTUOgz7Wws0pP467MA7eqeFN1oOcoYbCVFHJO/xAcoyVpydJHQlJuA6V5n7LZS/Nc
 JlooWqhBnUvry4y3czX0aMyKszpypr3yS1hqVSILi2QETMUCKQxtMzejnuk1hMhr9FTT
 kX0JOUNAeG+JRNkeAiBKBqFG3DgrG07tVlJ9MpPbxjHGlcaW0GOQndmW0bcEzMduoPZr
 FymmatMJH4BgP511lGZc4RIhbN9yh5L4dGxoPm4klZheGg3ueUbwmOp1iU9dqp+d6oO7
 E4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756902665; x=1757507465;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LWqZcPPxJh6+kkpPEpgUh1TFhaO4kspJtbqV1h4Eg0A=;
 b=LY4YJ2Oj1mSTD233a9AYhZ2ilhikoIGBKF9PDIHCL83TcK50tCJOICBrajXGoUeqOz
 6ZxplaEuUmv2AW24+fH5OwgevkTh+awYAlTK8MphLiUwG/HW0GPqNkmw6TVCdHfDTkLD
 y/naFXNuwEJJj1Rj4C1SBIKmgdgM+UKJo7Siy3vPk8N2+GQEkmrTy8PCq61nWoVUD845
 yKkHK/XVchvV2M/DJKxRXily3CWF4akq74kyIKXezjBh3s4kcblmCxhYLEZcA7ytsqmV
 SGgYwUWbhyMsw0/stGwVE0w9WCYdnob8ZUWCWi6CIyY1Kk8LuuN1eo7T06NtDMJK0yER
 PsEw==
X-Gm-Message-State: AOJu0YzyBc6RRYTRHgXdeH5HsCR2RI1rMrWKzGqOnnBldYgnbjOrYi+d
 OmQ/+hEZ3YxfvTCS8HfvCX6AjX5OUDE/BNT6oK3MIUjSp350vFUSjJ9c+vu3C9SiCTPm1h83uir
 laBSpOb0=
X-Gm-Gg: ASbGncvs4bKPJwznu0sEQL5/bCyPemFXEUyv+PHOiqnzE83R0z3kwJe1yO1/tAM5odg
 64ngy9nEwbkHwOfXREWYKgTvaClrSHRnPme+TK2UPW7EHH6rElHawzHsBUkJiX8tNcfwPZNTF7P
 cBNE4ZlczeoIHU/sbL1zhtjZf20PUUpxg9cWgAYdxfa4Iu4gY/26PG7EcKSkycnKQfXb3+enuWv
 ICLrlq3pCTBxBnBX/AI3p4OKI7O56HSLApARYNC8k94lDshAz2xEyGicr/B2lMcaRL9uG7dmfEu
 AC8g+Qozh8TOdO6ZelfqwRWgbKvZddlhmasFE/7e4SGWydoMrxaXKZKaW19aKFdUyvtBXiLLWt0
 WDa8VWasEQd3YTggNFU877jPlxXUil6iio5VqSSkAGldgt3OdQoB2nekOTRVWu9gHWf7Q3x8=
X-Google-Smtp-Source: AGHT+IFs8HcuZxP2PVpcdweMi+cduSFO7MJOfV6gMW6PrAbp66gkRHHl40c9laNRqRoV0CQi1Psp0w==
X-Received: by 2002:a17:907:7fac:b0:afe:f9fc:89be with SMTP id
 a640c23a62f3a-b01d8a2fe32mr1562009666b.1.1756902665118; 
 Wed, 03 Sep 2025 05:31:05 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b04129eccbfsm962883666b.7.2025.09.03.05.31.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 05:31:04 -0700 (PDT)
Message-ID: <117c1e2f-b64b-4776-bf22-6e2a83713f76@linaro.org>
Date: Wed, 3 Sep 2025 14:31:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/24] accel/hvf: Rename hvf_vcpu_exec() ->
 hvf_arch_vcpu_exec()
To: qemu-devel@nongnu.org
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903100702.16726-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62d.google.com
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
> hvf_vcpu_exec() is implemented per target, rename it as
> hvf_arch_vcpu_exec(), following the per target pattern.
> 
> Since it calls hv_vcpu_run(), mention it must be called
> on the vCPU.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/hvf_int.h  | 4 +++-
>   accel/hvf/hvf-accel-ops.c | 2 +-
>   target/arm/hvf/hvf.c      | 2 +-
>   target/i386/hvf/hvf.c     | 2 +-
>   4 files changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

