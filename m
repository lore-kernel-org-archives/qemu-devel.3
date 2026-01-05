Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704EBC2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcYB8-00008q-Ef; Sun, 04 Jan 2026 19:10:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYB4-00008Z-A6
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:10:30 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYAx-0006gv-SG
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:10:27 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-29f0f875bc5so201134725ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767571822; x=1768176622; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MOxvCj8dWcgKswOOYgwU7/lUdSz8YeFOjTIda9rjdjw=;
 b=sGK98E3bFfpcVe17XOa2rOwhzTHEfCdHX0G2utC1lSZ0VN/XnK4YLZr0vrt3w3y6kA
 8fXHZIAlVnMptDxTVVx29CSLFU1lyy2Nbm5Iv2/4TZOoXJPPUEqQxDufDSFYUK/Qokz7
 jLKDYyXwRwqcXZJUdVbnAhcUWVMdqpg680Q4zfpAGRkeEo5+iXjFjBBMluVdWvaiFtSx
 HEmxuVzxKaQOdXNQPji6NJCibyi7bKB6n4AsI2Rn0odt0IbKfni2vFJh9AaZwYg+6ca/
 PoCEH1FucXpaq3bLwvQxnoMhZ57GlSvjmi84EjlEYedTV7AgxvBPIVSLqJBWgTnG+RDi
 x6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767571822; x=1768176622;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MOxvCj8dWcgKswOOYgwU7/lUdSz8YeFOjTIda9rjdjw=;
 b=BW9GJLtCGx7Hw/URkk0mlceGbBZQZGyV3x8dfou0bNy9WLXx70er430CSpLC4FEdOb
 R2om6k+pWOP3OhAxG2fALEYLr1VFuJH4S73s/jLEq14wy05gStZsndgsxSoaTBcVdhDp
 vQuck7D+O3iJqSahquat/DZYd+Cs1Fw6GYdJF8sWjFVgJekFJRxYm01JioiVP23KAh8O
 9oiC8Y4e5pHaWlhmcssFidwl+svsUb8JsNJBoOPDbxnfq9zkBH5d3hIf+m/UdAaPDTWl
 mM0CiVpxpU3t504IUtsUpBD1yr/6RcVFRCDwctZEXl4xuDIRB2L9y0Gh5N8Ao98Yl9sK
 lYyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzuMSduoCJz2T4HyoSzeEY7kK7idguPkYJe2IpLNqGOObqJx0CxyNZHhHT+St6OePAa0unyt8LXHmk@nongnu.org
X-Gm-Message-State: AOJu0YzXhYeUZokuksjrkmraFtB9gmkCMachxen2FyCGFMbAtNasB6hz
 UbN01ANr7yHSClqwnLC2+Vw0j7nqAUMfliWBYlDxmupg/pkswbOcVxFfNS5IQsHYTZg=
X-Gm-Gg: AY/fxX4i/yd1lrPV8S+gZn+UCc5xfc6JUy29d9VYQp9NZWpb08dNhwzdyjJKZFNohNT
 aj9bmU9arL4shw3fVau8sKGLbr+O3MT+Ewwmv9g+v2MIGWo6ET6hKO63R/i4/9qLxAA5EeXtjDU
 JQuiEbL3Nvic35STD7Z/A8dMwVnfMU+LNJttNVd3yiZYKL3M0tW2XVZHxwao7mtSmRA+jhTNidH
 9SGSTIGIR2UEQEfY6GB5gUo/Vv3ke++wBLcYcyj2zXov4fSdLtcwjhGgcxpJ2Xm5m1Yv8kZkanl
 6QJ6/DoKFHG6pYrgkdCPb5UR7T7E2IS+iuIdZGCADGqcMGvDl9YBiiHs3vjVUCTDBZVKENlaHMN
 RHk9tbSCK/+M6l31xUrpqy/P81c/I+AFvRK0DG2j5tiAvwPTGLASt64WQ0lRI5Hq5YPpBJg1GNA
 gJk3YRlnm6sC4fSYiv1Z8FTZ2GcOXCkA==
X-Google-Smtp-Source: AGHT+IGoXQf4EUZzY7TA0ydQi6zEFuhwK+QlfKa4V6XorUuL00f0LrY+UU0oXOfoti1TxW8NXt7uDg==
X-Received: by 2002:a17:903:32d1:b0:293:e12:1bec with SMTP id
 d9443c01a7336-2a2f2229207mr489673875ad.20.1767571821966; 
 Sun, 04 Jan 2026 16:10:21 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d4d88asm424756505ad.48.2026.01.04.16.10.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:10:21 -0800 (PST)
Message-ID: <4d8c706e-b861-43be-ad28-5d34dfbd85ff@linaro.org>
Date: Mon, 5 Jan 2026 11:10:14 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/intc: Mark OpenRISC-specific peripheral as
 big-endian
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jia Liu <proljc@gmail.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stafford Horne <shorne@gmail.com>
References: <20251224161804.90064-1-philmd@linaro.org>
 <20251224161804.90064-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224161804.90064-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 12/25/25 03:18, Philippe Mathieu-Daudé wrote:
> The Open Multi-Processor Interrupt Controller (ompic) is only
> used by the OpenRISC target, which is only built as big-endian.
> Therefore the DEVICE_NATIVE_ENDIAN definition expand to
> DEVICE_BIG_ENDIAN (besides, the DEVICE_LITTLE_ENDIAN case isn't
> tested). Simplify directly using DEVICE_BIG_ENDIAN.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/intc/ompic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

