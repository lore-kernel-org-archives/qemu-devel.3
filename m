Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA47CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 06:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uliPF-0006nv-Uz; Tue, 12 Aug 2025 02:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliP2-0006lr-Dz
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:22:33 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliOs-0006Si-Qw
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:22:30 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3b79bdc9a7dso3092300f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 23:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754979739; x=1755584539; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zgJ4ihiBFJJ/RUkAIuur83HdbWFTneYvFmw3XI+25wg=;
 b=Ztpa2KyA8nPfGTz2omreukYRWtaDRs6x+LZhGwuZ3KvLKkcvuRl/lAIv2e3N6QKkfw
 km6d3TFVgoE7VtDjkJwMsb+ZkDkf81vVhopES06RT2Y/TqCckFmnUP969qnuOgTCFYeZ
 +rvqK9AtXZ+JvPaxSxYdDssLpQ/U4BRugm4wpfbHV3vtoUhNtWz3QAw/XsMZPnOWja4e
 G37DjASrkihr+wSQk0a8RkpxB/gYjMyX3Idy+Db+4we+bGC8Mop81Xr9tnRyjWE7cQzP
 giIYZ+OUMRlh2ciz/NVXFVlV9feYmJvuTJxVpmN3b7jM8RQSh7darSlsy8HjNnV7+wWT
 onNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754979739; x=1755584539;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zgJ4ihiBFJJ/RUkAIuur83HdbWFTneYvFmw3XI+25wg=;
 b=lEpX0pgi8lpxrQHy+D2AlINEEoLBsGvnFzzAzPEEDGE6w+1LU74CMwXii1/RDW05hh
 QHKb0wl/NuTwowIitlrpH69Hy5veANO/KvnXkFV2WLpLZh7ycC6/8AsJ79wS6Qhq+XCR
 Fkfl6ee9jXWs//JMvbCHMTb+sDAcVQrYMlgsMz+t6jXGe808qSfGiNXt/iZsTaxa12zP
 f4s8MTrs5KN4cdxfgKMelVj4HkKO1uTbsLMO2ZgDwQrciZ9ShsvUeYYtvYeLlR6E+gmK
 8qz/DO8F/G1pstf+1A/JOV5joWILWclngA8fmIUnT57VaLKIog6BZqYqWu5yhZTufCnc
 xEEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSvpUSXPJTEdEw0caimPmCiLwnU7567mdH+wMScJlrDP4WmGK/ecr/KZ7TfvYKcT00S9zEsOq8d3oE@nongnu.org
X-Gm-Message-State: AOJu0Yz10bKBpLtXoGm8bP6wLZ7oT0UpTRH+KZuVaLwm2MCuhf+AhjAC
 gPlVe8jAFULFCgHXzP7LeL4msR4nxWgZcc3wQxbhYrWzVC9IpTrASTnbiw7hehau2xIVxSBDjPI
 vUAx0
X-Gm-Gg: ASbGncuDmt49HWhszA7LqAY8YvonS+OkifznZuQkbkxfpesLg96OfifWZxQks5CMJgl
 LWVguHGB0v7ZspnDKWeRgI8jfsImuATPXf9xqoS2Lmy0AXs7rcEdRKDtA9TWm+P8pLior3X2SMy
 m+Wk34wiz0+xbIa/ZSFN8v8j3vc4EaQuTpQBRktFrkX7Zk5AahUx5ngBJ5DP8Ut0ysJ6sg5RYRC
 HmrbE9oKuRdTK3aSjN60hznAR/4wy8rbF9+I42T4C2gft0cGbhg7basiL+oGyHw4c6EvPxrDxLu
 cTpVEt+3pp5iZRqXXWDwXmsvgATzyW3T+P9lMktc0gyJPHr/r83RAMC872NK3Xj2+fskgRqnZHz
 MoKo5N8o0SpykY47TfwRviZ9dZBkdSiJDwRVIOFD84k5HVSvi8u+lDZy8X3TP8egY5A==
X-Google-Smtp-Source: AGHT+IGCpdjaZe0R/0OMdk8TcA856KAO27rbRqcIxHO9wy/UeNIPBbVvd/amKaKoIL414PMw+9+kPg==
X-Received: by 2002:a05:6000:250a:b0:3b7:89a2:bb8c with SMTP id
 ffacd0b85a97d-3b900b4f158mr11036125f8f.16.1754979739295; 
 Mon, 11 Aug 2025 23:22:19 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b91330bfa3sm735994f8f.29.2025.08.11.23.22.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 23:22:18 -0700 (PDT)
Message-ID: <2ff0cc5a-aa20-46fa-adfa-eccd83f53326@linaro.org>
Date: Tue, 12 Aug 2025 08:22:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/85] include/hw/core/cpu: Introduce cpu_tlb_fast
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
 <20250802232953.413294-28-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250802232953.413294-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 3/8/25 01:28, Richard Henderson wrote:
> Encapsulate access to cpu->neg.tlb.f[] in a function.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h        |  7 +++++++
>   accel/tcg/cputlb.c           | 16 ++++++++--------
>   tcg/aarch64/tcg-target.c.inc |  2 +-
>   tcg/arm/tcg-target.c.inc     |  2 +-
>   4 files changed, 17 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


