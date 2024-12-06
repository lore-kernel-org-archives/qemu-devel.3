Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D60E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 08:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJTnx-000856-4x; Fri, 06 Dec 2024 03:35:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJTnp-00083E-0L
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:35:09 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJTnn-0000RR-Et
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:35:08 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43497839b80so11797015e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 00:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733474105; x=1734078905; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sbEGoxRaiX7JPEjTqysHojsMZpJv727XRzSofmqRROQ=;
 b=UgEg3CXZXyZ8TopxqLzpGB+1pyZpaffoctVBlNwjhTyMOccTmIxBizqXrTeIGagJco
 59R1DSiuYZE0myyTZycEc1UZe4e3YMBqALT9Nz8GsBx7FzJXOv/kATfCvMPOv2+7Jd5g
 EK13W/mywPd/CWQ9Zd6vwc45cFoVc38I/W8w3jpFrYgYF27fOH8xiJJKmli9VHufkVRR
 wtRrcO3c33GeW95A3Qz82E1MZnswCHFU/B7z6/FXnVLppKN7lvaBHv5mtsJW4/WYSzeV
 BoAb/5EXvMScX+Hd/RUMRfRYuqo8oAdtbqDaUoaufBFXOMgWjbhxmjBvibeeX+dwuGfe
 cFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733474105; x=1734078905;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sbEGoxRaiX7JPEjTqysHojsMZpJv727XRzSofmqRROQ=;
 b=imG2AuO48vWU/5skdYU3VuWSOa59Z/tcNOVt/zGauF+i8FWMr1JiY67CuI8tT8EHdI
 G5lhSFYBlXA7m4Tj+Ey2hyyXkct9kag/SpG9dTFzf4zXM74zs/7nPdY9lxJpF10qPxZm
 l2lFqBAL14hdNNJ0EPC1yVuFb1yduJzU3ZqSkx9n962ORGUdAQacOQLWYuD6uC1+uJsM
 S14Pf814V1UArQNPTJjYd4d1EX6jiQHqCOThieAhB0QpzDoTpqFx+0dqGr0k6wcT+4bW
 Jt4rsQHe5TR6UBBblG0kKj7p/PI4vofU/ZqOmjABtNY588bfLNmGNBnEdVtg2FII/rom
 UjZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt7xKC7QJlCO7F2TaLZ+z678I2+6i+Edme5ttYUCupSEWYmk457ex/TELPwSIsRUgTO3BRwwPU2fYg@nongnu.org
X-Gm-Message-State: AOJu0Yx2LwxVRTirkxfhdXmufSCbT0nx4/L1C8POGr9/oufggx5g1jpH
 2DgG3jRewIk12OJfGJdUNmbU0/Kvqzpk0EBdhEoq3ltljsGx5zcoL6a2ImhAfNs=
X-Gm-Gg: ASbGncvXKMUpZt8meprQ/O6R0bFkcnccO2b+7ch5zdXg7eUc+K8k0Qqfst6jinA1vY1
 co5Fvz8+rc4IwBuTgayRXX79UMZ0TNeUW3QNTbcnNxfyj+t/Y/WBR3YRLPfrdYrR/q0RUH9y2Qr
 M6DGY2r/5FiMu4+PfJ9U0muUDrw7UjQqWVa0Ft620aZNCbrh6Zr4N8i9mY48Ly27Cp04UDarBoZ
 abaP3GGzA+p3QO1svhx1rNMZfc3hf/VkhWrUK/RtRhvHi5vPKqmMX21eepLFWZErVe8jJO0dHtT
 Ru7xpHKoNsUCDSAOzA==
X-Google-Smtp-Source: AGHT+IHBPUYihEP+FTcXGXzfbpenBsWdbraW9FjBPkJC5lFTlGRvwjA5iZ2GnDaMNHxngygMm5poJg==
X-Received: by 2002:a5d:64ab:0:b0:386:2a3b:8aa with SMTP id
 ffacd0b85a97d-3862b3d08d7mr1490004f8f.37.1733474105396; 
 Fri, 06 Dec 2024 00:35:05 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861ecf4164sm4095330f8f.9.2024.12.06.00.35.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 00:35:04 -0800 (PST)
Message-ID: <8c158a63-8a50-48a7-8a7f-6dfcb0a9d4ab@linaro.org>
Date: Fri, 6 Dec 2024 09:35:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] target/arm: Introduce fpst alias for helper.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241206031224.78525-1-richard.henderson@linaro.org>
 <20241206031224.78525-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241206031224.78525-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 6/12/24 04:12, Richard Henderson wrote:
> This allows us to declare that the helper requires
> a float_status pointer and not a generic void pointer.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.h | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


