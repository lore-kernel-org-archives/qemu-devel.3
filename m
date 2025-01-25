Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34836C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 15:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbi3b-00034H-8R; Sat, 25 Jan 2025 10:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbi3Z-00032G-Kw
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:26:45 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbi3Y-000490-4t
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:26:45 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso69929725ad.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 07:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737818802; x=1738423602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KLGzS0I/Wwr3boQJJr7L7klmxJMq9xoEZPgdnTdfEoY=;
 b=Yu0SPk06r7eQDqI5K0Brb5+tYrOtZkcLB2oghk3UcvUYLCBwQIyny6OZYotptitaKz
 Tm8wGwAb9VeG6dlTzY8Bax1qAgl3mSjXVxHHGYiZ39vZ8HdxlhveCc7kLzjmIB0pjovE
 B8zgzfu4b/Fyb1kU0wtt5d16wDK6EnGpEK3mzhPiGI/iWR2MH+ULfH7FGaEqnlCDvIXs
 1jExJa3EUtsjesXI8Y12VDc6GemAW3scF0Lz36vQoppSRxtOJAT0W+0cXmuLFuuwGqU8
 ksUTpWIP5Ze+PvwQau3Kj0t1NrpaBN8BdvY4eU/m3zCxh/y6jD4jW/OlOeDHJsNbCnYo
 nQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737818802; x=1738423602;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KLGzS0I/Wwr3boQJJr7L7klmxJMq9xoEZPgdnTdfEoY=;
 b=tdpYkQdOH81MmrsB9Tev2pnPbfuwdmt1NjR+P6gYIdFHpTdlCF1vv6lRx8fJiKKFmQ
 bnyHjhbSlOda5d4FT/CAZyH5USvokWJQXPBinXGHnPgSjYVC3Q4HAtJFV+/hsAvA+DM0
 YBXN/vyMKCLB/Ash9Macx13arDf2bLuzKlqv9wGv7l4oGjsI/YLy06Jkpyz3Xaj2I2OX
 LIaVDQ8G0k5vGls4RH5i/9Ho7BwmNmuRTV4PMF4n4KSY3lIAa5LtuAeGnRKO++YcpOdz
 NEidqtR/BGh0IxDCS1NDoEhAvGyL80j191XVNXY7NoNMFl4ylCVxTKTMso4LrsttU8OO
 sCrg==
X-Gm-Message-State: AOJu0YxedIrbWez/X4xdI26Cn/p2C5WdbMv8NjVfjaW5bJQMNokbA8t5
 0ri9lQxUu3J2YyYq4RMp4Fmszsrx/0P69eLqvCvGWaFlEk9RKypvnTTyI6Rd5fHdNybBpGM/Io7
 5
X-Gm-Gg: ASbGncvI2NTyq+ZCK9SwOXRqu+eNbed9O1uTkrevCTm4ojFMt+uDc2N6mO4buYq8iE5
 vaC/H9nhfyBvZUF7YgCQWrERmib1ldJ4pCIiagKTXhHlwDBS+AnjI9fCFeSe6d9VtfKPF+DUOdQ
 6G40hHDwWcLUOM6gZqZZvymf1APcdhkENkw/Eo1saugo4ehHtcGbhDQ/JB+WFb+pgGxr9PFfQNk
 URifw74QToGvueqk816JiD+VEowajyOQtqH8elmx3KSNA0jyMdWpS9nquC9WdIleyFZhKd4Z33s
 VvG333fcjs3L2bma0Da18Q==
X-Google-Smtp-Source: AGHT+IHQFYl+92Eavl6nZX7UXOQcucBVHt8Th84Tt3DxunArHZ+YBAaB8jJfhFyvOsBXFggw6citjA==
X-Received: by 2002:a05:6a21:6da0:b0:1e1:a647:8a54 with SMTP id
 adf61e73a8af0-1eb214f072fmr54744549637.20.1737818802621; 
 Sat, 25 Jan 2025 07:26:42 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a78ee7bsm3925415b3a.170.2025.01.25.07.26.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 07:26:42 -0800 (PST)
Message-ID: <8a02015f-fb6e-4c51-9350-460849db7628@linaro.org>
Date: Sat, 25 Jan 2025 07:26:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/76] fpu: Rename float_flag_output_denormal to
 float_flag_output_denormal_flushed
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-21-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-21-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:27, Peter Maydell wrote:
> Our float_flag_output_denormal exception flag is set when
> the fpu code flushes an output denormal to zero. Rename
> it to float_flag_output_denormal_flushed:
>   * this keeps it parallel with the flag for flushing
>     input denormals, which we just renamed
>   * it makes it clearer that it doesn't mean "set when
>     the output is a denormal"
> 
> Commit created with
>   for f in `git grep -l float_flag_output_denormal`; do sed -i -e 's/float_flag_output_denormal/float_flag_output_denormal_flushed/' $f; done
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/fpu/softfloat-types.h | 3 ++-
>   fpu/softfloat.c               | 2 +-
>   target/arm/vfp_helper.c       | 2 +-
>   target/i386/tcg/fpu_helper.c  | 2 +-
>   target/m68k/fpu_helper.c      | 2 +-
>   target/mips/tcg/msa_helper.c  | 2 +-
>   target/rx/op_helper.c         | 2 +-
>   target/tricore/fpu_helper.c   | 6 +++---
>   fpu/softfloat-parts.c.inc     | 2 +-
>   9 files changed, 12 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

