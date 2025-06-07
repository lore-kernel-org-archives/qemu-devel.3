Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006F3C61CE7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 13:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNtWG-0004mX-EK; Sat, 07 Jun 2025 09:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uNtWE-0004m3-1U
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 09:23:31 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uNtW7-0002jI-Ps
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 09:23:25 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so23597625e9.0
 for <qemu-devel@nongnu.org>; Sat, 07 Jun 2025 06:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749302599; x=1749907399; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pkh/mRBpiYbkdSfaa/a1BFmBgMGreCbSF864kkZOS3o=;
 b=j0W+169Ob/h5AOc8ih/KfCk9MLYgEkchFE7gnv29uUb5q3LfiTsz7uH/YNm2uhEpnq
 diQpjcFQb5Ca4urRTNJNI29km4ZpVTpGf/f3DjXiA9pSSR8+tStXKjnth9YFBYL4zqqM
 Zj6892fBx/+M8loPsf7Md3cbtt4kDaeeR/FYSExb398tIjnzddBqesNZESZ54y09W1+V
 4b3UYmLKOICUEDqrZ5Jm4PDvppSPQCXEaIGnPo+joJ9YadNEcy9jHg17QjJhc+2JaqDo
 ZNOboCOIUSMZUB5UMibdXZ0R9qqZq1ej35cCy9MsVwUJ9YCUfJLVgMIefDnKAnNbRBGs
 RTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749302599; x=1749907399;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pkh/mRBpiYbkdSfaa/a1BFmBgMGreCbSF864kkZOS3o=;
 b=kUUnGE+bE8UXUdnFPJ1jZpp6HLK7fKtYthqg9Oprcw4QvlEbxAjDCBE7ihdD5X+QSA
 LLQAP4CFIB4W/cX/KjaSs9IEo93bXS3lkZy4cGYa2xD/k8xjVPHmVNKG2KhBgBGAOS2v
 vAHNElwppaVPwndyoXmRRgYRl+/G/hV2iLIsJlWD1dNIyu7vvzaC/VI0Sz4lcQ2K6isK
 VQO7R8KKIwjqUrJVxOKAHOmYZdS+601SnckVzbkbyWM/at8/wXupslwGnB803KPGHlOW
 GAZkrMYUB0rep06Hw5xjKpBjxlAVZi3X5bHjImF+Vllbs8kOtsREjA/5iZm8vN6jbPZn
 4tcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN1qO+VCH8U/NVSEn4vULYqxUSuT2IZCMZNR0JKFvVmlZD4NOWPs7m5pZ4gzR8Xr2kM6xryVet7Fl9@nongnu.org
X-Gm-Message-State: AOJu0YxU66yxbqkL95DgHRVcoLLOjAZclcwrGiBVg2ojqd+dxFhyxKwq
 i/9pgj2iGd+RsTXny8Z673NOO8O6SyYfSCKuv8/5eEEiHsyr65oRmE+KzMiPhWkujzM=
X-Gm-Gg: ASbGnctkFOSg6EqxWehlpw83jyTBIxBGk4382EMy1rIpkbBiSTLJHME3HB4gEiPiRVY
 p4Dm+eE0kyPx9hxV0lo+Sq8mdOexp5u3z90dBDYycKpn7w92AJPCgG63vFYrtrYEnyz/N+g5Qd2
 C6vQsacbThS5QAw4NNKe2sm9uIaK0OXLSO/iAAMJ885jZ4G71JE3cuwg4DNDGg9N0a5VGk0cJDG
 Qxn6FcyjnURa/0biP9FvjOKMEAXjEgQQ2pbFIhV+K7YICTup51ROsmimFm53GFnfo+k6wLIWhjF
 GyvD1x4UBK/o5w7G8bTVCvXVykuFZTuyI9pUKZqJ9Zw5BrKQguHLyQ3ZAikx8YfVLeQ/2Ycx3pd
 8rSyU/8UrrZQ82Pl5WhGWIWD3WsPeO/0G7DGaswnHIwdjfMG5pQ==
X-Google-Smtp-Source: AGHT+IGOsm4w4IfJE8lFjMhdA43LCvjYzq996FyRbcuDkF0SBXXSN4Y5Q2Wj5Fc4NgV9GnS39yXhxA==
X-Received: by 2002:a05:600c:c4a3:b0:43c:f513:9591 with SMTP id
 5b1f17b1804b1-45201394601mr64747245e9.14.1749302599441; 
 Sat, 07 Jun 2025 06:23:19 -0700 (PDT)
Received: from [10.10.12.33] (cust-west-lon-46-193-226-34.cust.wifirst.net.
 [46.193.226.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452730c6a33sm53533855e9.28.2025.06.07.06.23.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Jun 2025 06:23:19 -0700 (PDT)
Message-ID: <c9a8d923-0faf-46a4-962b-5a0f4289008f@linaro.org>
Date: Sat, 7 Jun 2025 14:23:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/19] system/cpus: Only kick running vCPUs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
 <20250606164418.98655-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250606164418.98655-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

On 6/6/25 17:44, Philippe Mathieu-Daudé wrote:
> As an optimization, avoid kicking stopped vCPUs.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   system/cpus.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/system/cpus.c b/system/cpus.c
> index d16b0dff989..4835e5ced48 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -494,6 +494,11 @@ void cpus_kick_thread(CPUState *cpu)
>   void qemu_cpu_kick(CPUState *cpu)
>   {
>       qemu_cond_broadcast(cpu->halt_cond);
> +
> +    if (!cpu_can_run(cpu)) {
> +        return;
> +    }
> +

This would appear to be a race condition.  The evaluation of cpu_can_run should be done 
within the context of 'cpu', not here, and not *after* we've already woken 'cpu' via the 
broadcast.


r~



