Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB42D1118E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 18:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOJu7-0007a1-7p; Wed, 26 Nov 2025 13:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vOJu5-0007Z6-V7
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 13:06:09 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vOJu4-00049T-EL
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 13:06:09 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2958db8ae4fso419525ad.2
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 10:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764180367; x=1764785167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9EErJV4CJJrinxUzOhQC54LxEXZ1wuvSt3soUIRAAJY=;
 b=YYoGRevQwMAhLeKSUnr4XSBxR/oVPK4Gy0y84LsD14e2Lfefw57rSk9jLoM38l/3Yy
 r97hoZj6bsUOwbE1wgPfbFELUNntnfahzbbW4NY4qq2K9oKko34mzV6N/dRb1N1TTI5u
 yv3OFEl8Lha3uMXKHZjjVhrUI1ClGEuYk3hk892/VffDFk2DRMZfobdQRLCVBZPCwg1k
 fcHx2MaFeNPGXKaP3Gutf51hpk1KfMK6gdHLy2xbZEIM42G1bfsVRb6HPuWLt6Hm3FYP
 /1EkZbPuNegncq4w2pLn3xJXUD2EvpbjK2fuYtlg4Nsjj0uJBoCujwac6RqD79rwCE9S
 geoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764180367; x=1764785167;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9EErJV4CJJrinxUzOhQC54LxEXZ1wuvSt3soUIRAAJY=;
 b=MwpsIKipfJ5jBHYJ1M8lCI5plswhIHdryytuq9dOzzti6A21LTgbRaU7whJJfdALLm
 VA5tOsA7A5gRX4BcXLAnAwDNwEgtttW3rPa7gy8Rcm7DMqOaroEXdgWeKCmZaX0KrMMC
 nVvx9ephtV1KiZnLwmcXnMWEy21v+p+TEvfqoDfkp+cHL5UpKw0wqcY2ufiu2PTGK5az
 Vt7NLiWu3LujdUCQvfvMR69dtx9dF88h4/cgTruRjQgxWoyarAVztfRYStmzJ1b9nmv9
 EhaVGOdApx6QvDC+SaE4xUYDuUp5Ub+KEeqgErh9dcH/EfNHNsgiokr3ZNVuMu8IFM8d
 kVuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHiKsx+/guD4HXxMcQB1Uwk1L8VEVK/9EZQv4z7WiVDGArnNlijH2/i5KLaVZPoc9/A/V9wdOpob2Q@nongnu.org
X-Gm-Message-State: AOJu0YzyLAuOlsC5QQla12mUFR9+hXtG9Je+Hmgpxlm7ZRTHr8G67mL4
 IMCwjgbHUNHxBdCQlUQmLXOhg1NaPiMa7CqNW9gwDhXne4ypsucZI4JjatBg9XoETJMLsKYYC5y
 Qgh2y
X-Gm-Gg: ASbGncsWboTWWnw6sKrpElNUNF9VVqlwVxGw6/ySJ++H3TALsaFQhRivk91urIOWqXz
 jBcy/yiD9HWYwzcy/jZs2yAqw3aYciqLY76drGev6vpA2aP56z1WGjLwie+oMiYCGw5iEsnQplm
 uOaAqxDCE+IJfonjwVQZX1XYADX6odE1sl1J/IMVIeCYoQoTDYIhSvj4ta8nlma8XiOgetXlHs8
 9oLy1hzGpCAZyTN0f2W0wl7pxPm1FiqZqXx59JGqPbWuMUWK6sWUH5rf+eILkEznp3mMBtsx66P
 E3RnsoOWiQ7BK4luIt1nPoYjqPtPSkxqYqWB12Cq4LPyUmjXcIWODeFyIgKe3kCyygeUqBaIGzu
 13WyO9hO/zel8bQd2UC68WU/PdGzIsQaW8Ld5yZCq3wXiQ22pi0NSlWtvwSxxTOV+1rqcIjBxvo
 H+sDqD+jG7RkCG31x5EaQwlWIW7VpFjysdOKYgUPVXq9KO/XKd1g==
X-Google-Smtp-Source: AGHT+IHd87rG/DTu7d1eSEyL//+PnsKqBm/n1H6XuHjUVWxBtmnKhmxIC5fdVI3jvD2MU5yLvPYUdw==
X-Received: by 2002:a17:903:2451:b0:295:96bc:868c with SMTP id
 d9443c01a7336-29b6c3c23f6mr209456775ad.5.1764180367115; 
 Wed, 26 Nov 2025 10:06:07 -0800 (PST)
Received: from [192.168.0.4] (174-21-76-60.tukw.qwest.net. [174.21.76.60])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b2a10c7sm200106105ad.85.2025.11.26.10.06.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 10:06:06 -0800 (PST)
Message-ID: <143c340c-df9f-434a-82aa-c47691418c96@linaro.org>
Date: Wed, 26 Nov 2025 10:06:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v2 06/12] target/tricore: Use little-endian
 variant of cpu_ld/st_data*()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
References: <20251126075003.4826-1-philmd@linaro.org>
 <20251126075003.4826-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251126075003.4826-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 11/25/25 23:49, Philippe Mathieu-Daudé wrote:
> We only build the TriCore target using little endianness order,
> therefore the cpu_ld/st_data*() definitions expand to the little
> endian declarations. Use the explicit little-endian variants.
> 
> Mechanical change running:
> 
>    $ tgt=tricore; \
>      end=le; \
>      for op in data mmuidx_ra; do \
>        for ac in uw sw l q; do \
>          sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>        for ac in w l q; do \
>          sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>      done
> 
> Then adapting spaces style manually to pass checkpatch.pl.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/tricore/op_helper.c | 152 ++++++++++++++++++-------------------
>   1 file changed, 76 insertions(+), 76 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

