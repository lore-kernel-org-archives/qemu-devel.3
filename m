Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A217C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9U4-0002sl-OH; Sat, 21 Jun 2025 21:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9U3-0002sb-N9
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:26:59 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9U1-0008Hq-TN
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:26:59 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-234b9dfb842so26996445ad.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750555616; x=1751160416; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0u959FN2ozbtHzDo+A6pFoAM8x46eW+ME735S0KpaYI=;
 b=rCLP1+r/zo9ZD9PLOQArju0fEkChNUSylqlnw29XUkhaN/KUK3lhqmh9I27Uv+ORrA
 bg1W1GNzNJz9antXr53AiFMZJ5hHPfxy8sZPVwhBIXLDVJih32DBdxu60Y2d8e93kzZd
 1R88mqqPSCkWdmOW6qmlTihE8BF3P57H9pEaw1RZSJggrk/X+0Z2KKubuLcZuSOB7c4A
 zkpTdlL3SBipISn5UR8g8b5jm1JFHMbNbeXcRTdjeRPOJtWPZGhtXehF29+kIaYAbpJV
 4BVsHzWCcAVpkjzA0e7R9/9o8BmiaLhToE+7tVm/2k2aJaTUTyPxaPufbsIQsA06+E7Z
 4Ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750555616; x=1751160416;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0u959FN2ozbtHzDo+A6pFoAM8x46eW+ME735S0KpaYI=;
 b=M6nfZmAjd89mZe82JYErS/ebec5Q+8rjTPLhGdkmhAHjNI2biW/nSRAAn6tFpYK+H8
 qwo9hZ6XvNwjm4RXrvkJDC5xmFZ3yNRPXVjR1nBKDw8s9ZdkY7xyKq0RGnXynJSXoKIB
 yMM/HwJpflICaxsU1kzUUb6kWIZZlHu2Szj4JvnjMIogcvevKcHrHT0NiyxWZKfDiQhB
 rAagNzyblsca1OBqLaZrbQ2CXwiYjt7jh110atN1BqHOBdCF5/RWHjcMAxIW9n360MJE
 lHKJFOiaXekCquqfE8aosLpG5q4F2YyZQxZ0b4CvvygmnJqX2cFtM8Jnz5B7b8SCUuaT
 x5/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3o4B6/iv/5Ag5+G68YvUioIe0R0WiIAdLw3JlZfej+Ocj1MOTdoL09ZTIfqLxXD+a/ynVSqxszvMd@nongnu.org
X-Gm-Message-State: AOJu0YxvKbIkQgPYHrB6wQIyakICzbkZ47m4IlgQXya9pob+hEzW+SW3
 nGAXcf7JeKpvXcR6EAUdUM/OEEpWf1tDZ8kf4Z885CiDkOxRxpWMUWCpApLDRyFncKE=
X-Gm-Gg: ASbGncvtqeqHmy3QowJrV5rzUOAV7WR52PCDE5mTPo5o6LEMZlAuyRtN3KMiUuYbWmG
 KR9uWUK31FCNVGLKSvmUyzQOtizFFSJgTX6+Jfp/8aILZvgozfTYTPfPGMiiUrvs6HmfJpW6bJ/
 j+6WCD9zN2TRXTV1vo6VXneYGi6JvAky4YTRX569GjTVeUASyqgPn7eiZRvSyWmHsqdi/5+AU0l
 Gtzge4u7NJBHl5KgKuPGSHtB+AmvBpAUc599D1IuUHnqCMgBrC4Y8w2xR9cfL4bTja6edzkS0xC
 59F1iPLDPQLbRMHsNVys653Gw833rnfEUd/epnY3txqT7xqguEo3lnS/w4ohK0P08CPYA311id2
 6tORlTrK7psX0pgNc5YBA/brWqZRp
X-Google-Smtp-Source: AGHT+IHi+gvieGulLb+RLOS9hiq5Emz3XgyWVLfL84Wc8+uBQIuMfmx2WYFUQz/vqrWobAPdyWNfOw==
X-Received: by 2002:a17:903:2bcb:b0:236:9dd9:b75d with SMTP id
 d9443c01a7336-237d9afa649mr108518905ad.40.1750555616286; 
 Sat, 21 Jun 2025 18:26:56 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d83ea243sm50965015ad.72.2025.06.21.18.26.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 18:26:55 -0700 (PDT)
Message-ID: <c597c5b0-d028-4fa9-8e79-757c5a2980fb@linaro.org>
Date: Sat, 21 Jun 2025 18:26:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 15/48] accel/system: Add 'info accel' on human
 monitor
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-16-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-16-philmd@linaro.org>
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> 'info accel' dispatches to theAccelOpsClass::get_stats()
> and get_vcpu_stats() handlers.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/qemu/accel.h       |  1 +
>   include/system/accel-ops.h |  2 ++
>   accel/accel-system.c       | 28 ++++++++++++++++++++++++++++
>   hmp-commands-info.hx       | 12 ++++++++++++
>   4 files changed, 43 insertions(+)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

