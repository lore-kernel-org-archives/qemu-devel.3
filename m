Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6FDC28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdYm-0006wp-53; Fri, 07 Mar 2025 14:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdYL-0006nT-Qx
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:40:17 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdYK-0000NE-2H
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:40:13 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2241053582dso18052795ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741376410; x=1741981210; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MNYtVOxV7nL74+jS/Rks3IbYlfM8jUgeMq7y/tTZcBk=;
 b=Vxm3fCRyGD8o6PljBI01A/lHAo5G/Womfalu/AiW8Uy6s6FYOMm1QOh0aJFJpWQuWH
 0Nj/PxXs9M/0IQPPQnwGQKkJ4DPzVeSrVbT9V6WOKKXMrca9UCA+x3b3RTJVZuUdXeGj
 WuKZ5CbzWWJqQcM9tkBr5KhXn1vYMJivlRRehPBwp94ZRjuNepeF2TQ38Zr9id4JrnRn
 RfislNWEAHc46dIQO069o6timMpzFjomrH79csEsntIfooORibJk3oismpheW0Vvt4A6
 Cq3BpyXbDWNmW2xsKaFJkeyEFIcC9Lxs4YTtybXoTNe2koL9qkzarlnR45gNO8Nqkqrj
 KQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741376410; x=1741981210;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MNYtVOxV7nL74+jS/Rks3IbYlfM8jUgeMq7y/tTZcBk=;
 b=XHTF61EZi0RBBaFWyd2g+jWUHyiwuuVo9YL5jCY+Uf5kQuXGrommDecawqrXiyAbbh
 dsNgGHqrxe/BT9/S1FcVcL6mtgC1OovRozMBjxGDcYFGUBEFakXPUoToHX2cdHo6Ntcl
 4J4zMLGxNE6sq2+bK/RP+Pp2vcP6y3EVswDs+9kavuBmIllBpw5rETNkpc0Wv3VMpdfh
 8a7IPpcZzixKYmEsjdjbwPa6ukK+a7+EdeeU+++wQzXx45MP5+saJSze6EwtU63p/+Xj
 HUmu3rYGdbofeYZY5/QoMDgzL+akeh7UxmNu/JycBCIf+OJC4+U/alNo3E/IrnaLdrbv
 G1AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhjrKUtNADvR4nV8a+1xVGeDblmQ3N5Kpi5QmS0oKqvSA7FpEF97Vq7LdqFe/NkzlTewI8TSDDhMVK@nongnu.org
X-Gm-Message-State: AOJu0YxNM4rki7n9HIMnDSEdLXnBVj0/odQw4s6GfsbTvYGp4Ji9912f
 /H2CDwdj+vJ4MhvRA7urRHUqq3s5B+ypDxUvSDIe4OfpQ27xvZgjz2ZAHlqFonEUcRQH9bq7hGL
 A
X-Gm-Gg: ASbGncvFZ+OuieF7tIJIjpgOOn2TKqjimwoU8WvNh/jQIBcqv5EWosqBMQtXU6/YC1y
 nVRwaeyhOajb7roWh9vjrMT1hE3oixEThMGdWKsbiKJFNtjF4kU+lmVnoGzyWxjumeySUNgPc4K
 u/hO8E2GRPCAOhZB+d9moFwjSvF3/eKMXRTNydr1b2EmURCXE+Z6VFn9Ie2BFVi7gpLjM8vq1xp
 E1eQ6Uqe1jqDCyq3QVXcnRC88aOd+BAwklHZ/zUxtjJG/v2rjJiI4Gj9YtLz4omBNVkJ3Rez9qk
 ApYOlpCcYZeMQhBp2CWNGXsziEIXNypaezcAbxfZJxBx2y1aezxkD/H8hXzs2BG8eq0iWJWXA80
 bQgDzIVsJ
X-Google-Smtp-Source: AGHT+IEySQ1o9l1BcPwsGn6eAQPUUoUPRZroma80r0QpJJ2Nm9q837rUe80uBJHpA2K69LAwRtzxDg==
X-Received: by 2002:a05:6a00:17a7:b0:736:a638:7f9e with SMTP id
 d2e1a72fcca58-736aa9de258mr8394867b3a.8.1741376410398; 
 Fri, 07 Mar 2025 11:40:10 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73698514f6esm3751854b3a.142.2025.03.07.11.40.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:40:10 -0800 (PST)
Message-ID: <d9aad21f-ce9e-4b89-a584-03cadfa18bc9@linaro.org>
Date: Fri, 7 Mar 2025 11:40:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] hw/vfio: Compile some common objects once
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250307180337.14811-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/7/25 10:03, Philippe Mathieu-Daudé wrote:
> Some files don't rely on any target-specific knowledge
> and can be compiled once:
> 
>   - helpers.c
>   - container-base.c
>   - migration.c (removing unnecessary "exec/ram_addr.h")
>   - migration-multifd.c
>   - cpr.c
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/vfio/migration.c |  1 -
>   hw/vfio/meson.build | 13 ++++++++-----
>   2 files changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

