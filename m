Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFEAE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 17:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVaFp-0000qR-Gv; Wed, 08 Jan 2025 12:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVaFn-0000pv-8v
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 12:54:03 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVaFl-0007DV-Op
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 12:54:03 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3862d6d5765so30278f8f.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 09:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736358840; x=1736963640; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/JoWildLOKY4dOs3qZZY4y2OUfdUzwC2XguzUxZRQjY=;
 b=D5zWfljJOaTBo9hC4kMQeERyIGvRlUE0MrTDZkZ9xcSDJAXa1uvirsOk7L7cx8Wvfn
 OiIjnkNUniadarV63azC0COjsWxXtBmcVg/XfwXtbOmdGsWVA5kXbWjuZQz3xFcSPiqz
 CzLHHuVnM/qmsM07j8RGpN/ZErIZSXXj+fvShS0AVHUEZ+zBNMkt76+T97T++Kb5oepO
 6RMxHZ6JmnnI8EasjDp0tFO3ozrrx+o8yEY7QcytgUyItCeB0slRw4ME4YX726KrlX4Y
 CpXzVXqXsEX8kaJAIwA6wfher9pGcruPTiueYR++gkJvGyjoyqDQAc7K0ESJ3O4qSuMh
 BzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736358840; x=1736963640;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/JoWildLOKY4dOs3qZZY4y2OUfdUzwC2XguzUxZRQjY=;
 b=oj4BTomU0fu7ovmc2NqakoRhkTxWVvwvMSTHaE8uakMaooNBC9UUyo0Se/o1xhlwUi
 061Hb27uRfC/1pxfXHvHMy+YDYkNTsVTtS0V5t6afGb69Je/K6y5aaDiT2JF4FrdMcnN
 m7mU91qCHz1hIsMCSMyyVHGQGqht6i/h0N6EWJOJwCoUZMx4YapLhAzditsUY3N5rpfz
 Et7pZ7RjWNIAQWaLEZU89TQ1Zx2cSXwd2PG9I8kVO3AIZYts2aQ8VPpj9LYd3Kc4wTVd
 xZ6VQKm4+sMmOG/V96zatUf+R1+wOLiiqBOmQIJ2+4xtyfrdg/nmZwsLlsD4FpJk2ZyF
 zxIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzU0LI6nLeD/D9kvE8FjIXZIGuj3iFXWZJSDHTfuT26rvJx4OJbEilBOZRHT+Uqr8HikUsPD9yUNUt@nongnu.org
X-Gm-Message-State: AOJu0YwdUBK7NtQ1FNCvnSCP+xMwt+V69/NpDoP83Ikyfz+WdnWl5Zue
 8wX8pebKEvAjPVi7L0LxxM5vCFQpo379ayS1qYhq7BhqiduMbOhNKKmJlYlpSX4=
X-Gm-Gg: ASbGncvxNuoXeWO2vOG6EeYNqAVhlFa7R4oAu6cHmHMhjeyBE5u+kSKUMQ0jt1QyRW+
 kYc9cm4QXUZjswlZjZmhhNcVRMQuKEFPP1s/QUueS1DTcjN+ZpWIMMq1jTGhE/n5RFJpXq6g/iz
 5MgBCBGES9Oi302nsnImZ0LBD7GCoOdKe7ovhy4efBHd0t7vRWluqL7y7YZjJ0NHCdP42U4DtOW
 vNJ+8Gg9MFL1hcbg1xO65NtSzP8UbuMChOvk06dJUNxhtwCShVzH46QYtt1GUVmfel0nAG9syBs
 jWKr1aDe187oNbYU0OxJwOlb
X-Google-Smtp-Source: AGHT+IHkHj62ECBNNbzPDOesUFUOJGQKEcNV+OTXzRwjvV770vHAVwhlNb5HvTPC6JGxrgjwc43a0g==
X-Received: by 2002:a05:6000:154a:b0:385:f6b9:e750 with SMTP id
 ffacd0b85a97d-38a872d2affmr3252879f8f.9.1736358839995; 
 Wed, 08 Jan 2025 09:53:59 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8330d4sm52824996f8f.29.2025.01.08.09.53.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 09:53:59 -0800 (PST)
Message-ID: <9fb636d2-3abd-4dd8-983b-b6fe65fb2f15@linaro.org>
Date: Wed, 8 Jan 2025 18:53:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 55/81] tcg: Merge INDEX_op_and_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-56-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-56-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   target/sh4/translate.c   |  4 ++--
>   tcg/optimize.c           | 40 ++++++++++++----------------------------
>   tcg/tcg-op.c             |  4 ++--
>   tcg/tcg.c                |  9 +++------
>   tcg/tci.c                |  5 ++---
>   tcg/tci/tcg-target.c.inc |  2 +-
>   7 files changed, 23 insertions(+), 44 deletions(-)


> @@ -1694,8 +1693,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
>       TempOptInfo *t2 = arg_info(op->args[2]);
>       int ofs = op->args[3];
>       int len = op->args[4];
> -    int width;
> -    TCGOpcode and_opc;
> +    int width = ctx->type == TCG_TYPE_I32 ? 32 : 64;

Some places (like in patch #10) you add assertions and here you remove.
Could leaving the switch case help if someone hypotecally implement for
128-bit hosts?

Anyhow,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       uint64_t z_mask, s_mask;
>   
>       if (ti_is_const(t1) && ti_is_const(t2)) {
> @@ -1704,24 +1702,11 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
>                                             ti_const_val(t2)));
>       }
>   
> -    switch (ctx->type) {
> -    case TCG_TYPE_I32:
> -        and_opc = INDEX_op_and_i32;
> -        width = 32;
> -        break;
> -    case TCG_TYPE_I64:
> -        and_opc = INDEX_op_and_i64;
> -        width = 64;
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }


