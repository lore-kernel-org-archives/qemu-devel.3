Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F1DE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 20:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSMY5-00026S-9z; Mon, 30 Dec 2024 15:39:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSMY1-00025d-Rw
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 15:39:35 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSMY0-00017F-5e
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 15:39:33 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso62199735e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 12:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735591170; x=1736195970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kfwBVJkZrpzxnChm4ix/8hOAMoruX9yhJfSVNt10YgE=;
 b=NRn6+h/j3c0UjJ+5DrYXqgOFZhFH4cAJ7aHwC135hYJyFaduFCtFIifMRN72aDJMxe
 fXw7xKSezLUtxQS4eThfb0PnfuYT0wb4TIdZjfEthwNZphdsEaPwNe1FDaeBkmzg5sSp
 su5rKiWDG2294ppQUXM06aOWaJ86F75kihkOETUFY0j6Cy2WVrsSCoYEgiCai7EvhEbd
 jPsWRAwI6u8YluXHjG7D1uyng7XgNaRevWyvNn1P3R/zMi4hVnRftqLlLfCO2Y88ENOa
 Y7Yvqk7eZdOojBaGb+DEal9rWgIWoNmu7fKuPDdZ6qjPLb8wtJ+KO1zNmtYxFJGRGWH8
 j2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735591170; x=1736195970;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kfwBVJkZrpzxnChm4ix/8hOAMoruX9yhJfSVNt10YgE=;
 b=S5RQg5hcQUpwI5520kqyzTznoTAa4uPP6uKcavk7qiwtojPkXjSfdbavMj3wmxCRPy
 2zmvXHkfY/z6tIqiXB7GOr/ZFyWFGQiGnKZiQCS99cWHmg0+lSpl7OcFBzxII+Rk3EF5
 uCWvBqI+j8sNBa6dEA4iynfcXNP0zjBXoRUi6OXOGdeH7bVqiVrIv2mBWDwf3fUf+Yup
 v6NtPatzPdJeICWnggG85qBTULBETA8aEkfa8oP/+mLSp5Bn2HU/3PdLl0FSSqCnH8bC
 acvJJlK6OIfTLs93imJqgH6IOIEovda6rhp+KLFKpJZYaSiKuIA4TfvxzK+Jjv2hQUhx
 nLhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOwFJsz4ahDbEgJzgjkA3iOcerZn4RokTuoyDnnzTlwE8hw7ww39JvMw67vtHshCJeFg6dYO/9Km2x@nongnu.org
X-Gm-Message-State: AOJu0YxJPDfg9grn9OdauADc9EXftc6AiZluELpVDTaA2p9nPgo+k/Z2
 s1L8jevpZ4Aec16tJuefnmnuKLgtGaP5hCqn5hH29ajGRwuuoa27TlGssHr6cXbUBVFI8LXOnMM
 t
X-Gm-Gg: ASbGncsKvNffLiRWAhSif0axTr5aDPer6XbWFX9j2j2e+x7CR8EByoH7bF1zDz9o3fz
 dp70xliou5Ix87UchTuKpXsLe/0kL62fAJi46dP7KPLcxWPWTSd7dfx4D5aJFnN+GJXMyaSujL+
 NXJOYzoK964lS6gqNfND3btKeREHXA8ZzLQi4CepOf2E4jKIYMlIFpFYcPoDndU+V3wDjdzoYHg
 P+q3WUtEKprz6smbUWOucnytnjo5ywkrKDeWPeg/nrJR9wN5tTX4bdx6ykvBhwEGbtJRKnamjKi
 v6Mi7nEB20V/yYdHq0fDEEva
X-Google-Smtp-Source: AGHT+IF/aYthCqMk+AkKJ/HCAvgZpa52Upjg+FwWGnZHUnuJqJ3tBSJCJBKLP4Y5Ro2nWF/GoX8kwA==
X-Received: by 2002:a5d:5d09:0:b0:386:4570:ee3d with SMTP id
 ffacd0b85a97d-38a22a4c983mr28785637f8f.24.1735591170486; 
 Mon, 30 Dec 2024 12:39:30 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e2d2sm31447438f8f.71.2024.12.30.12.39.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2024 12:39:30 -0800 (PST)
Message-ID: <c778e5f6-8b9b-4a7b-a3cd-a7f8cced87bb@linaro.org>
Date: Mon, 30 Dec 2024 21:39:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] hppa CPU reset and speedup
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241230152519.86291-1-philmd@linaro.org>
 <32a4d72c-6cc2-4c33-876d-ddf66b71fab4@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <32a4d72c-6cc2-4c33-876d-ddf66b71fab4@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 30/12/24 21:24, Helge Deller wrote:
> Hi Philippe,
> 
> On 12/30/24 16:25, Philippe Mathieu-Daudé wrote:
>> Respin of:
>> https://lore.kernel.org/qemu-devel/20241229234154.32250-1- 
>> deller@kernel.org/
>> "Add CPU reset function and speed up runtime and translation."
>>
>> - Remove hppa_cpu_init()
> 
> Thanks for picking up my patches and integrating them properly
> with the reset code.
> But sadly your changes somehow break hppa 64-bit CPU support.
> I think it's to when the reset code is called.

Likely hppa_is_pa20() called *before* CPU reset...?

> 
> Easy reproducer (no other options/disc/network needed):
> ./qemu-system-hppa -smp cpus=4 -nographic -machine C3700

