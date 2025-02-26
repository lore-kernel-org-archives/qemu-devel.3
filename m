Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D6EC19F2E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 17:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnLBx-0005JK-RC; Wed, 26 Feb 2025 12:27:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tnLBf-0005Er-FQ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:27:14 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tnLBd-0000gW-RV
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:27:11 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22334203781so13449385ad.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 09:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740590828; x=1741195628; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oheCbn8/ydpwMts63XF7D7TEgS91E2+JqJfrHRyXgqA=;
 b=E8lLKKgHsOxkjnXHmkXuBQi8sRxeOdii/HeszFI0UMw/UCZV9dYNNd8aw7FWxvj4K4
 ZLOHVVdM39yeHHoJXqezaDqVvcfP3ydcOUSD4QOboU8m3JrpbYo40kMxAzVCLXf4R3P1
 TminC/doTbpkE1OuxJ0Ht3yPtp656alP7CzKpiY4h4jJdJgR8v2RZcTFtAMuM5eZE5GW
 72Flsu8hx2ESwpTaZGz7Am8po1KXNT91VnU+utD6KEfuCKIGjsEo+5PkwWHIHh0RTC75
 wjUlTNvikTsPHVreYJUkLDQQRvyxf3u3hc/HLJlBTc8xHx5UC3wZuYT+LNWkNL8T+/XH
 axEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740590828; x=1741195628;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oheCbn8/ydpwMts63XF7D7TEgS91E2+JqJfrHRyXgqA=;
 b=hwFQNT58B9CnGtaicWnJ0GWBZ7mP/UGmKA6NryL/XTd5ca/RMyevXUoPqedlBPhTFe
 Eb7nrVC9Ny3p3P3Au+KKoUF6BGoaYkXPENpGlveIRYscVZlPHvWItyxIydCvofyxPVwh
 DtxWoyQ7YTbE4Zfdkq8AB4xfeGV/iv4I09bwxnYAvBUbDelq1iupqsxj4fNFviewUoXr
 zBl03KFUybPYdFlx/UUCUx6+cN7qE6AHRxJCgczZowWihsB/5pdELzrVSJ83BK0/eNfq
 a1mwuYWiOKRd1M+NuO4K/7xfI3rjaOi0Ap6JYyVYBjB9/ojkhtimm1a16qoH4Y0KLQck
 SbNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZGYGP/k6sah/i+pytwgMurvGBMquEhUgKqd7H22WDI/XvSit8EBN8RUsR8avz/7FpPjKgIbhlROGF@nongnu.org
X-Gm-Message-State: AOJu0YzxBGl7JkEXQrevi/3nuEYpi+3swIgRCt9aCt8Y6ws49egECVr3
 2zDR1kaiEDZO9FX47TnoLhdp9Zq7VWlicCwzJgEBydnPdVWThWEsR+yss4JxdbgqLoLndI6YAkn
 O
X-Gm-Gg: ASbGnctvm3dAlsdZhG4k+Jqx3Ghop/WSZfK7EHGaS4scmdnjABLbfIH3Rjzd7Wpe35w
 1fZL/gJjPwAWiJEIKImZgS7Ko7L+kwFU58Zt3G6Fy5s1odw4BvJZlLNXazgYmTq4gfuX7NVQvZu
 j2eETzr4MpRQFv6hboN6b+qfHVBjr9K9m5rcT8gGe4mwmoW1t0NSCfDDPXtI/PpQPXNByJuCQHP
 Z0gv11+NnDsPQMcgaI82ZDBO7VljDr6DFprallFhl2oLLwNR3YYCvNcpbRyO2td946mDLkSZhdj
 AT/ByEprlXcyBjFGx+S1Jf+4SvvXQrrtW+vWOcVCUdKFOAsQ
X-Google-Smtp-Source: AGHT+IEcdNZ/hnJzPoEYV3GjkVjvrzmJi8J3EjvbrHlAQJ/InOi45UJ9+7chhVY+oaRoVMpTQ6736A==
X-Received: by 2002:a05:6a00:390d:b0:730:949d:2d52 with SMTP id
 d2e1a72fcca58-7349d1d21bdmr315313b3a.3.1740590828340; 
 Wed, 26 Feb 2025 09:27:08 -0800 (PST)
Received: from [10.254.143.227] ([172.56.201.232])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aeda7f7e9f7sm3527689a12.26.2025.02.26.09.27.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 09:27:07 -0800 (PST)
Message-ID: <ec793215-345d-4a28-84d7-4111cdf366be@linaro.org>
Date: Wed, 26 Feb 2025 09:27:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/25] tests/tcg: enable -fwrapv for test-i386-bmi
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
 <20250226140343.3907080-15-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250226140343.3907080-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 2/26/25 06:03, Alex Bennée wrote:
> We allow things like:
> 
>    tests/tcg/i386/test-i386-bmi2.c:124:35: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
>        assert(result == (mask & ~(-1 << 30)));
> 
> in the main code, so allow it for the test.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/tcg/i386/Makefile.target | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
> index bbe2c44b2a..f1df40411b 100644
> --- a/tests/tcg/i386/Makefile.target
> +++ b/tests/tcg/i386/Makefile.target
> @@ -22,7 +22,7 @@ run-test-i386-sse-exceptions: QEMU_OPTS += -cpu max
>   test-i386-pcmpistri: CFLAGS += -msse4.2
>   run-test-i386-pcmpistri: QEMU_OPTS += -cpu max
>   
> -test-i386-bmi2: CFLAGS=-O2
> +test-i386-bmi2: CFLAGS=-O2 -fwrapv
>   run-test-i386-bmi2: QEMU_OPTS += -cpu max
>   
>   test-i386-adcox: CFLAGS=-O2

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

