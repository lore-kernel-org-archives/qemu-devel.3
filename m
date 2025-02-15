Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D14C021A4
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 19:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjOIq-0008DL-TB; Sat, 15 Feb 2025 14:58:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjOIp-0008D8-1m
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 14:58:15 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjOIn-00048Y-EM
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 14:58:14 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21f78b1fb7dso53398295ad.3
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 11:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739649492; x=1740254292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ajIa/pqsGh/3kuhfQdp1d0UtC+NvMeGpoaUk5H8cnK8=;
 b=IOi5rZISp/mqCq9lHQYYivKEmYsIKGqRRSQ6g4avt1u0YDuCCFK0v6KD2POuxJv/ad
 MRK3zKEbdJsVlXgdltJdNS7xd7Amp02qptcmslF8nz3lti9LZsSIYmIdlxlgTmmmKqbB
 7YS6h+WJnUgyqSj6R3RBK8l4xAV5585SQ5GZUZfl3c+n+up/5kTpyNygNnXQNWcQ5+9E
 H+ewckqgJZs1b9Qb5k5HpRnmR1PgJhGgdJ0fbRIffCr1pAC5Wseot+RwrKTeOEOqTSo1
 sXDnIHQGs2dqwJ83fh8UusLNqS5XkOjrJxjt5CFuGljtzkqoh9EVaZ4CYjXQAKT6+wUc
 jt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739649492; x=1740254292;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ajIa/pqsGh/3kuhfQdp1d0UtC+NvMeGpoaUk5H8cnK8=;
 b=Rcl6z/6gprxOgQbvR1qbTr0757qe7aG5NL3TzCfZQ+e8B2NLktMl4cNzPhfdIJ/YfW
 06HpxusBf5mGwnYtKMITCliuHJAvP8Q/1R/K5flF/sfoWxmedFIHrAfWjG1Td6g72a7Q
 coPR94jHntctyXPpgRP4rICn0A4EE75ZuKgOjkChP6v+KZAHmlqigkn32dts153r6hTm
 gCnzwLc6iFYccUYACSHxDB/Ss+JlmtjNYuj27hQonwljqweKrtRGc/Wy8MGuXCJiYMRw
 r9rWvOrZpwpC/KQjrO/+FT1Uh247me2V4am3OctiqkR9/3zlWQdlsrH57nRmA0P16zW1
 6ilg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8wWp0qGf373+5jEVjiaLbbdsGwkxkdKJS2JSp9YYC1aY5FiQtTK2yQ4zdDhRQX9CVeX74T7LANBr3@nongnu.org
X-Gm-Message-State: AOJu0YwAxwMCLvFP8axv1kO61/7frn/dkHvNl+WsHHUKObgwb/S22DeU
 gSowVWY5XEwI2pGi27rVcE3AJytgjhmnvYkqdTwxLHz2yFxojjkvc2x4TD/ge80=
X-Gm-Gg: ASbGncsfSW0dlWCw5Bd535iaFOk1d0STWf+ETTcwq8JZhbrBk8qBVDdZ3CNltiUOvqN
 jyhYCDuI4dAWJU7HGan2toTEVDnqmwDCb+pPNLYq/SVoWvBovD+7SC8OcaOmpj3gFvF6TrsVSgU
 MeISdtCitpc2fRPFArqw2pdTfCg8VL+7HofK4s2ixKsjURnD2+f9mD+Ob6ZbnzvU9BNszsXAjnd
 18vYL+hoclD+cbLLHx7iP9KLb9x1Ubys/tvD5WEKucBJrTxGO1cqpqTTfSuiPcldlCLAPr4iRkZ
 PN5DEXVpDSI5Jfju6chG+fPKovr6J0oehvRCmn4bYJ+AzvMFntBO9Dc=
X-Google-Smtp-Source: AGHT+IE92HQS3d6Le5ZSNCl6nEcGOJNSbycb59iRKFab77WH7NV9eN4Ht0mk/4wqrM3aoiLsVvPsYg==
X-Received: by 2002:a17:903:2341:b0:221:1cf:da1 with SMTP id
 d9443c01a7336-2210405c71emr66634135ad.24.1739649491897; 
 Sat, 15 Feb 2025 11:58:11 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545c8d1sm47210865ad.113.2025.02.15.11.58.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2025 11:58:11 -0800 (PST)
Message-ID: <5e9d9e51-1950-45d5-9580-9f1072e3b1b4@linaro.org>
Date: Sat, 15 Feb 2025 11:58:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/sparc: Fix gdbstub incorrectly handling
 registers f32-f62
To: Mikael Szreder <git@miszr.win>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20250214070343.11501-1-git@miszr.win>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250214070343.11501-1-git@miszr.win>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 2/13/25 23:03, Mikael Szreder wrote:
> The gdbstub implementation for the Sparc architecture would
> incorrectly calculate the the floating point register offset.
> This resulted in, for example, registers f32 and f34 to point to
> the same value.
> 
> The issue was caused by the confusion between even register numbers
> and even register indexes. For example, the register index of f32 is 64
> and f34 is 65.
> 
> Fixes: 30038fd81808 ("target-sparc: Change fpr representation to doubles.")
> Signed-off-by: Mikael Szreder <git@miszr.win>
> ---
>   target/sparc/gdbstub.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
> index ec0036e9ef..134617fb23 100644
> --- a/target/sparc/gdbstub.c
> +++ b/target/sparc/gdbstub.c
> @@ -79,8 +79,13 @@ int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>           }
>       }
>       if (n < 80) {
> -        /* f32-f62 (double width, even numbers only) */
> -        return gdb_get_reg64(mem_buf, env->fpr[(n - 32) / 2].ll);
> +        /* f32-f62 (16 double width registers, even register numbers only)
> +         * n == 64: f32 : env->fpr[16]
> +         * n == 65: f34 : env->fpr[17]
> +         * etc...
> +         * n == 79: f62 : env->fpr[31]
> +         */
> +        return gdb_get_reg64(mem_buf, env->fpr[(n - 64) + 16].ll);
>       }
>       switch (n) {
>       case 80:
> @@ -173,8 +178,13 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>           }
>           return 4;
>       } else if (n < 80) {
> -        /* f32-f62 (double width, even numbers only) */
> -        env->fpr[(n - 32) / 2].ll = tmp;
> +        /* f32-f62 (16 double width registers, even register numbers only)
> +         * n == 64: f32 : env->fpr[16]
> +         * n == 65: f34 : env->fpr[17]
> +         * etc...
> +         * n == 79: f62 : env->fpr[31]
> +         */
> +        env->fpr[(n - 64) + 16].ll = tmp;
>       } else {
>           switch (n) {
>           case 80:

Queued, thanks.


r~

