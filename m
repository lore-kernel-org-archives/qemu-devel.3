Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA945CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vENzc-00058s-Uy; Thu, 30 Oct 2025 04:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vENzX-00058e-LZ
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:26:43 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vENzS-0004VD-La
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:26:43 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so7516115e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 01:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761812791; x=1762417591; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sBx/2wQ1E4IGpMTvUHRewgL+2wi9Cqaj1fBsDLTuqPI=;
 b=ikjAetKJ+ntPeiFWJ0OZ9kCGPtgxH8GiBwaH4rPA1Is5OYUg0U+YR9Rl7axJXc4eNs
 R4BQOYlLqF1ig8OLVjMho7B5NmZr8moLOKSQ4kP7iUjFvJaagFb8SX1cZtuoRX4J8Gr4
 CJNenNd6tHuj5UaRmm5n+e02kQutWjBg/R0SlloE9CKMMmGPwt95i/9nKpN4E7p7OFr6
 R4TGeFPlvy3i1EoEP/nVuYLqJP+4vBHDSX51EqInfhwhkyGFATmytVjNotFAXxXPpl1U
 Fb+EzlGzxzA7GdgBFFXZh5Zdcz/E+wTmOt0dmFZ8+SWGrvzs2dhN2JixBqJI+lWWuQsL
 wHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761812791; x=1762417591;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sBx/2wQ1E4IGpMTvUHRewgL+2wi9Cqaj1fBsDLTuqPI=;
 b=m3LMmHvFqf5/5Jw0AucSFE7751/8ktWUSPZEAvVUrTmjep6tXjiXNjCCGN1/mUvyMv
 /PojM9JBSG2cf0IuTNGCUW7z10meUCkDY2Q8lenfsIgnwMXD68p5UBLAjho0iJrrUI0O
 Fz8c/3bXv2RLTsHlSZhIDR04RAU84bgD4Zn2vebeWmZ1EYgFz67fMBzUgDES5gzC7SBI
 INIuS/W9x6B3M7pI3/Qmr3dGgvo0Mh8O4kjAcpDP0y3qesS6OzwTAesqxRC3MZ2R6axr
 KHOHQsokB7WbpxJ9y9BbQizM/zXUVXoGqc6A3a+VIr+XizHsjzGMvRXGCPSjVml0PyaG
 jwwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeY6e6tkpj8U6HYTdEiXgVVbRtpQPqpbs8LrpsO4Iqo0qVaIRaDkl7J+DuBjZRHzmY/kJ4c5CF1xeR@nongnu.org
X-Gm-Message-State: AOJu0YwqBXQD/1ue2gMqr+lcs8WmuTwlFhKRAm4FxH8pU2+TnMoRHV/4
 qpK5BaAq8pdRjTfb4jl3riNTqXaCUAe22F0hpfiCUSSa8hXJ1m0qoMkcRt7I6pNjKQY=
X-Gm-Gg: ASbGncvv9w3tKh0C8zx1j/iEBAFki2bNJNKOGfipo69e8fftZsJo50NZ4MnFi4rplZR
 g6UiR9gOli2beYucodgiZqULxVbZ8rcuJLk7e8xf9tkr4kTyXQQuA9T53jjbW+UZPb3h4JFzNG+
 YnHU2To9sUL3AdLXcIEgft9gYFUHyKv/GjtUfcuCz0wF29gtsgyC726k3zJ3SbKFQIHgxHL1130
 pVO1ohufq64FrB5uAWHEH9w4zFQTkUh9OfwqxVZ56dZWPBHtj9N2RdbZPYy8X8R2dx+qq/zajYS
 X2k2LTM/9yT+GegSPi+YCdWKXcOeMS8JWH7QmUNyOTmXNkkdx4jGpO1fGqrFZq00OT4FaY09Ga+
 QDK21Qz570pwX4/EiXl/LU1PC00HSrLM/IPKFX7TAhmeQYRAImFCJT1zrF7QocrpFjUYdl6xTN6
 B/NVXWkl+jT3tzGTfsHZdyCcFssAdLpTEdS8bOSKzUEJY=
X-Google-Smtp-Source: AGHT+IHYqXItX7fv37r1gmpR8wTsS9zsBS/I3FnoZy8wzp+Qs/etY5PEqAT58/2tvMCoksUO2G9PfQ==
X-Received: by 2002:a05:600c:a09:b0:477:25b9:3917 with SMTP id
 5b1f17b1804b1-47726871b86mr19380525e9.39.1761812791591; 
 Thu, 30 Oct 2025 01:26:31 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47728999a4bsm25962685e9.2.2025.10.30.01.26.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 01:26:31 -0700 (PDT)
Message-ID: <7b19d088-1c75-4212-80db-b2c59a0da211@linaro.org>
Date: Thu, 30 Oct 2025 09:26:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/core/loader: Fixup whitespace for get_image_size()
Content-Language: en-US
To: alistair23@gmail.com, alistair.francis@wdc.com, vishalc@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20251030015306.2279148-1-alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251030015306.2279148-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 30/10/25 02:53, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   hw/core/loader.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


