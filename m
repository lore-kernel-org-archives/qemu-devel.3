Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D61CCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6riS-00040E-ER; Thu, 09 Oct 2025 10:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rhp-0003Om-P8
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:33:23 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rhk-00038V-PA
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:33:21 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e326e4e99so10790105e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760020388; x=1760625188; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wXsMIdvvb0DfWGwhIK7mVi32a4taePpSpmapThvDfYw=;
 b=V+2pmdXxMQl79jvZdfiDufRXbPD2ZaRF6BeCWFX+PRvcY36m4XOti99kQT6yAydMR+
 DxD4Z69UffA4u0uqRQ3UtHT0f4waBpjaz4Xe3pmhqPRAVXnloIeS1PcXy6V1+ZFnQ6Ug
 KTJ5AomkkDoOXN4akjNDbHR9YXZ2BnptPMXeBqLeH+p8gps1tzTymzE5qU2OV9rYaDv1
 dJcaCFrIm4uqw8yKgC2bs1m1KlYV5U8/w4V6A9z5oGtncAWk1cBTxyrVCW/2TJg/0BY9
 JmziGpPZ7cUe0fVuwn1mNMNRJf8P8mx2eZruizocC/si/7yorO/f13mdT20urY9CV2wq
 Ye1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760020388; x=1760625188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wXsMIdvvb0DfWGwhIK7mVi32a4taePpSpmapThvDfYw=;
 b=xHD3dKmk2qpT2dLZ9uXVbrQq28apmP8fjrOVUloqbfucgzZn+Fr3zMmxStmAoFVxp6
 1LavKFhMKEYN3T3Z4W6MXnoc94edc3KxJ+O5HDz6eNUGgXxqFqudENwU9GZvrnAOOFbT
 lnyaGde8LgPtMnR4NgiLJ76h9y/rpNEUb1+J4fidCRlw+zAxpvCWkwlIWj/VYXy4zbi8
 aAEP5OXPAfiluZOsqRp+tlHZ2xWbGPzabphmCF5xu/ykwMpufu1LuKmyRJtvdDeDhPmJ
 w1CyLtevvNateScpp4Z4aAbJ8AFegrHxo/ed9pwkYGVpzrnWnjedVfTomYNfAcaXnIux
 ekJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkBL1YjKXC73LbkS4jB7s6dzbEVY0n7Nxz6Rd+Vf2CiWiS0H62+K2wMKXaNByndNZNGldo6FUNsH/q@nongnu.org
X-Gm-Message-State: AOJu0YxjTpdXcX1fBaqzXSQnyZ03k2ndnD9ERYK5uqxulcTd6DCqXg6Q
 G/wdEbXvF4buKYOkP8vLGw4+ly+dqkGOV0gH6imWlqApFOEjMPvTu1JEXPkQzbbG9B2zHSUglkG
 xcCz6yLQZdA==
X-Gm-Gg: ASbGncsyjc1YOqJrSPpdp2jk35rWimypD+JgrNyL7PE/0S1xT84AZfTY9+MWKDtFahd
 c8Mks8298/2RUgbRwLVxVjlXtPxuOKFTUPH/5TTBIm5RDIaKp0He3PZ+zqmNYzOCup91eX1nraD
 vlrJVE6Dw/YRGH8za9XcmPB/arPuuGkyXwrUAmqgqByFaHInGyg0m7GxifB33KtS5lFDpSyur0G
 sK3mQzEeRkdGPTTheq6mJRcUiuF2zpDwLs7Jgwpd5pLBWxCHc2+uuvdykN9QTRi2jft5Ro4YBTv
 DnotAZzXe17gSCU1dBwKOjtU5yyMeHU5QBMmV/XKxpApDmm2AYSNC+q5U+sOim9D7l6ffkSVSDb
 sMFvdvVufUEy2bS6GR7YTVqh8IwV7PegaZaNcs1p0ceD+L+5LFBK4uhtyI1sABwueN3A3rXsa+1
 SD14kCf8Zt1Yp0MQeHeg==
X-Google-Smtp-Source: AGHT+IEzajbMwtWMj/xCAARLEevJqO6yPVJixkubzhsuH/zmLQNPYUNER6Mr96Az9D8vta7iImCLMA==
X-Received: by 2002:a05:600c:4ed4:b0:46d:1a9b:6d35 with SMTP id
 5b1f17b1804b1-46fa9ec7718mr63301735e9.14.1760020388302; 
 Thu, 09 Oct 2025 07:33:08 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab3e3520sm41033875e9.2.2025.10.09.07.33.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 07:33:07 -0700 (PDT)
Message-ID: <b1d23a95-7fff-4f02-8c92-62899dfc9849@linaro.org>
Date: Thu, 9 Oct 2025 16:33:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 62/73] target/arm: Enable FEAT_GCS with -cpu max
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
 <20251008215613.300150-63-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251008215613.300150-63-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 8/10/25 23:56, Richard Henderson wrote:
> Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/cpu64.c        | 1 +
>   docs/system/arm/emulation.rst | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


