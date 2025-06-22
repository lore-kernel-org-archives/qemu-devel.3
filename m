Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08874C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9IH-0007Xu-JZ; Sat, 21 Jun 2025 21:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9IF-0007Xa-Jv
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:14:47 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9IE-0005ke-7J
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:14:47 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-313910f392dso2148485a91.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750554884; x=1751159684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LPy1CuudXkWZ1gfuWayltbrv6xYaOI5Mt6tW5gxml3M=;
 b=B/rEQfQnMqTcMzKcYpevCzw4Kui7wA5SL4BftR/Rk8JxkITlsHTBYc4D4ck1sVIp1X
 r+zfQJB+uobQUTsCf2n5SExkNDTKoQaykjOf4NbIpkNNcNHPZrSNM8MKZPI+mriooscx
 K3FQ9NiZVZbWDrSnIC9MG0YZGCi5JlL4LAe6GSKCofBYTZ2Vw9vsGx0ZTnxD0PBk5KLV
 QJ8aF7osA0VImaDfQvz7VZ9fPlJCLCSxG3q2hnBRkvf9WTbORjY1qXWRyNMiISGTaOxh
 nj+CXv+Iyd1qxw/y8Oj4lYv+NyHGwfWdxWlhzJc1do2qYgbKKdNC5D2TeKLv0i9qDWwb
 v37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750554884; x=1751159684;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LPy1CuudXkWZ1gfuWayltbrv6xYaOI5Mt6tW5gxml3M=;
 b=BA2PeXKEtxq34/tR6Qz/q+tra6zDJ5hUOoF2EXEAHUWucEZjf9hYjPZEdhMfwIHL0a
 zH/isEblMXVWXzPci7jhqNHDtCHUdyMPgPGqwP3/cX5254OQeTZv494YJfiYkrlK5XR0
 woCHEM0JR1q9ynyHdfjZXvg4cSeonSBYDnErNsAD1Xh0TAfc2jsCZWZGPCczTIjPqw91
 1b1XG0+5ZP1l9WjKtAUDf3uN9NnEI3rzQUvn4LzR1m6mQrv6NHizFr9OKbZjJwmw9BpX
 zNq5gwyEAfX3svWk1QmpfBIJFq3ZT0wTQemNgD/e+3DbEL5rDaRttO3dmR5GNlXX4Qmj
 lfKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuiq8hjc09eNiIax3S5fP+a54pgvqwgqA6jmOGNB/BftWmx8WxXjq91PeUEj3ZAag1nhR8n2QQzyXy@nongnu.org
X-Gm-Message-State: AOJu0YwfMpq5QjtYj6MJ+7tfUFkM82vFMS6ZiYBK/QrlO2o6gLSd5T3u
 1vRFbVLLrmLflc6kivk2n+9HOtm+x0qhfZOqdMVmVT13wntlnh9My7wfmnkDNfS19tLHKoWBA/U
 Z5sX+g+8=
X-Gm-Gg: ASbGnctQtbrsFH56cqBpt4bOCRfGc8bFExQN9R2f+8HBta9TzFLxrgBDTWL/X5ZfXUw
 yhnJKn+Iotsk8QLHI2ypVaZXDdFiCnc9xQxTs1if/DfFWUsVb8POstMrIsJeMWtBhwHRltwRYHl
 E0qRfn6zFE050aMOLNHRrfxZrwVeXK1TjaOUV9QfokfFq480RQeTgHa9apkbsk58e3pppuBifwN
 ZphewL3PH9BR2ZVLwVG+NVzxhKwOnTDnLttwcP+qO3JAdK2leA/A1ApgS5Ms+naYuElnEjWYu0o
 +psx78zwmxGjoC+cuTBOp6Ubd9sqffSTzBgVfoAOrp7Xh/jXnal4FSKdcYIkEInBZw0WfzDOzvG
 isLmgLWmQ2p0tzT2XVNhZt/GvJTgZ
X-Google-Smtp-Source: AGHT+IFvjmKlujxQKvl2gmkelMT8eeZFsufYBSveTu/Nl8CqaLLLRdS3asNiL29r7c1jm1E12pENZQ==
X-Received: by 2002:a17:90b:5243:b0:312:2bb:aa89 with SMTP id
 98e67ed59e1d1-3159d8c7ce3mr11587447a91.20.1750554884518; 
 Sat, 21 Jun 2025 18:14:44 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3158a331983sm7187018a91.47.2025.06.21.18.14.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 18:14:44 -0700 (PDT)
Message-ID: <5f894acb-aeba-4a66-9475-cd6a847a484f@linaro.org>
Date: Sat, 21 Jun 2025 18:14:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 05/48] accel/kvm: Reduce kvm_create_vcpu()
 declaration scope
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 6/20/25 10:12, Philippe Mathieu-Daudé wrote:
> kvm_create_vcpu() is only used within the same file unit.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/kvm.h | 8 --------
>   accel/kvm/kvm-all.c  | 8 +++++++-
>   2 files changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

