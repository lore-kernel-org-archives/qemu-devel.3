Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F96ECCFA13
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 14:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI5xW-0001FQ-8v; Sun, 09 Nov 2025 08:59:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vI5xU-0001E0-Cq
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 08:59:56 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vI5xT-0003TL-14
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 08:59:56 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-64180bd67b7so436700a12.0
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 05:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762696793; x=1763301593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KbZf15ulVr2z/2LBJX/OTwQjOtB/wWtGpsmY5cW60bg=;
 b=vSyehHyVKWd016K662mH8Qk1vYH47Ud+rlDRhJeWJYn3CyKxUkKUWT7737iJWrosTU
 QZxDvGoRMUhGHP5OHwU0Nd/VV+dyLyQbtz+vagdeRYzwZ8OZ1+IzuEHKi0zORrqRNXO4
 az3G2xVuhTyrEEF4/qik4MPYR1quwwDlxOiJoAazJHySdXbenHy2q75HKVWrsAe4CdRw
 6R8FO3zUw4aufEwT8UtRhMaWywoAc7vqrk2eHTTUFHBmIQJXextYkf5BhOpTlhzPvFzw
 t5ffEbrG+c1zOrx+PhY55gJWkHt89o15kro/qBNZ73tuHRz5WEtnJdAYNOv0+JFqbRqy
 PVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762696793; x=1763301593;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KbZf15ulVr2z/2LBJX/OTwQjOtB/wWtGpsmY5cW60bg=;
 b=Ej8tgGdFDptXZpzYksJBXFQG/XYte1KNVDZUaXGyDet9NHEOJ/13/eD75khxP1AQwS
 MJ19bXqf289mhDeTS7vofXNPwlJ2IykyraJq3aVJRGSUbNDohkM9Zwe00r2d4SgTuZTG
 9CkSxDZ7p/FkGLC7IKKhbL8ptYCS0/kVDlqhwIQI/f7ebtO+322+/UXUEvRp0IE0oJdw
 GAuq7S6ijEZzfyfci8tKKAjoLqgNOlFmvfkKT/6J6lroTc/83HUVhG8vqe5P9qBpI9CG
 9nBIqulYlVR7Ek5cSHMO/zeVSOz9LK63O6z811gH1U0ShF51PEyRpMOAnshzXwrzilQV
 xL3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn3+AFPubajQxnBQkd64dA/ge2NSkJElHL7GEpjD931pjIJ6Hhoy4Aq6o0bnmyy75lBGsqWqk4wpx4@nongnu.org
X-Gm-Message-State: AOJu0Ywb2WCOA6k1smRyqbYRSFXlzJApyKL9iuDmJYjL0cEkTHoG6wB9
 S0IuHcCwmk6i6a3VGVRw2jPrfzpuWAL7QPYgqjXxbEJt74b53u5+v/xxG7wq5muUOy4=
X-Gm-Gg: ASbGncv/E52wldoSfg0OSxw/Gc6gKC+YUbvOKAWpbHEzCkSwSwK8Mwxs97STy43+Za1
 WhSJ9IhQ0cncRKnVJB4zUv3BfQEDcfpmMfY1byiIlcuozAB5H63TT3eaeiLIVNpSDIRf5AFldIH
 wBkf68yP938ixgt8Dm7+VqnDbfvyCEm0KIjrHz1DETwHhWHc33O9clvNzEDiq5KKIFIqQcDcJL3
 KDv+Rm5gCQlhIQzFTaHiM+VOtXCAAri8cSU49HJgsCul4Kb6cDc86Nh9/QYwe+2z8iW4xhWE/cS
 q9MY0oPgDwxb6R0Nke1zoxGkIKRTZPSP5+1ZEJE9HjPsz+NOmpP+eq+qrUDTPCeB5/GY1q7/+dN
 g5+K7o5c0zkPAMyCCvu+dUZBACKfoUWnusUNfiPogs6Sdfe71f5lYeORqSKksc9orlvwxBNGp9d
 91pmHa3XpdpM2XxUHExk8cITBM/Gh0QXLdimOkj9TdE592OhxZXMbcEz4JlQ==
X-Google-Smtp-Source: AGHT+IHSLMpVr848boQgSP3JL72tmZPppf59LJSu/UqXV6VYWDsyQqZK8gy4knA2iC/PBqgJeSU9eg==
X-Received: by 2002:a05:6402:1475:b0:640:fb1f:e95c with SMTP id
 4fb4d7f45d1cf-6415e8220e3mr3969680a12.20.1762696793213; 
 Sun, 09 Nov 2025 05:59:53 -0800 (PST)
Received: from [192.168.2.7] (tmo-086-152.customers.d1-online.com.
 [80.187.86.152]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6411f862bd0sm9107874a12.26.2025.11.09.05.59.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Nov 2025 05:59:52 -0800 (PST)
Message-ID: <faddeb4c-2e8d-4c06-a4f3-b983ea373e4b@linaro.org>
Date: Sun, 9 Nov 2025 14:59:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] hw/intc/riscv_aclint: riscv_aclint_mtimer_get_ticks:
 get rid of void* argument
Content-Language: en-US
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
References: <20251107102340.471141-1-luc.michel@amd.com>
 <20251107102340.471141-8-luc.michel@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251107102340.471141-8-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

On 7/11/25 11:23, Luc Michel wrote:
> Now that the riscv_aclint_mtimer_get_ticks is only used internally,
> replace its void* argument with the proper RISCVAclintMTimerState type.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>   hw/intc/riscv_aclint.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


