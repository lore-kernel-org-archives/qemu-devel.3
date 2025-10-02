Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9407DCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 20:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4PoU-00064E-3i; Thu, 02 Oct 2025 16:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PoK-00060e-6u
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:21:56 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Po8-000776-RL
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:21:55 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76e4fc419a9so1531551b3a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 13:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759436501; x=1760041301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eVCzjffKOf5Om+GdzRjOtmP/o2xK5bXPddosdt9IID8=;
 b=oMjfdDjfu3Didb0Zoe2SNV1ktFmyvtEyy4NfEtzLgK7TyWwASbP6TvGt/3Cc659rJh
 lxBfsv+jc+ODcQmygd8bDpb4ZF5DIoy35mma6QuTODX3xNhc8dNGilqcdEY6PIb4XvTy
 H5QPHX9LUmonHmq7VdiPHvPOCgyWhp82E+KvkWKk3YscEp8mbh79euRWsyRX4LBcb2Dp
 VR++GNNzBT0dEL6zMvp67ZFjaCVQqDW/d3gvDd6x4qYaqBQU5xIFiUMG+1p6YV4hkBSt
 uqih4GULDAaRlwzIwio9kwXvAFLa735onHpXOcAHY6cNojh485yYCVlR/KmkjhZkWCN1
 VJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759436501; x=1760041301;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eVCzjffKOf5Om+GdzRjOtmP/o2xK5bXPddosdt9IID8=;
 b=IqLHLzSIgSTht8fz8iWldw31GFaMzGZ1Q9d9RKpjOh9BkrNn6Sdjyt1DywNUpx5QWE
 fwcjkWERq4J4dpSFNDNje73yb29xKz9y6FXAzzpLtlEExMqmRPn/zVy0Xc/gYOXYJJci
 auYVMWouwcw9Nm+ZPP8vWO6yyHyA/KtMfgH8LHEIWNnF6YmJ95oOMvWUyarljrcBraN0
 D4g6UpWhKtplYEdF9k/aG/+CcgoZzkg+bWUXqdYY8SRJxc9M9xIaRW3oxg8/mNKeFwS9
 ppEn2zNgMIS9/f2nAZCssa29Z0NuyLYYOEty2DCEiQW2poK7vB5PyYRE/nGAPE1OfXa+
 oYDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvN3JJ5fwK4B09CAcfD/qi7fa1l4nTBXaN8tI3magRbpBAEkEi2vMCxq/usGFtsjVwPWfNhQbAGo7g@nongnu.org
X-Gm-Message-State: AOJu0YyA4zvdAaIH0qIF+d/JKt9gm69Rra5Q5+eOKWcxq/P65ohe86wP
 U9OL+oPiP7zcz1o1kFicftSo9VG+bk7htLbxf2OsF2iXqnSe/8jn0NvsUhl0jmRGyqA=
X-Gm-Gg: ASbGncte8dzi9IIpA2n+MK+PQo+nFDMbTITm2mIFAPaSbGo673TCyo4UNiTNHLfMBgf
 4PJ75VGgk4uv6Xi9b9pPs5uHqbky7N7qhRanzDjGFsps39lvJKrM+9FMibDbDudr2Q0arZPcVV3
 Y+7OPHSX2w1Kd3aJBf4rC+CRvalES7leA5awMWZN1RlRqjoB1Th8YXDW0CwUVc/xh5DqaTBVgBz
 VDbP5Rl7VlLBI+cg6cM1g/Oju3qFeHeNg1ldUcPo0n4mZJoOmfjJb47cem9xBhunnEnicjtqRzU
 Kf6Q5YP77AggbdzlFc6sAjSgwfgNK2Lk7JfozaPAKyDAqpnkJbwo6qj6WQUpXtTzupC4g6pgprT
 yMN57T6go9pQrAeVn1LMfviHjudoxxMxMUUgVCkS9PH6Ay5yvRN6RwhsjArfTXzA=
X-Google-Smtp-Source: AGHT+IGP/isLoAQiVfeKgwQW38+GTYLYlQP76GHGqwrcvX81B6fbNl3CovnxxIQcyrgvI27BKHs6jA==
X-Received: by 2002:a05:6a20:3d84:b0:252:fbd4:630c with SMTP id
 adf61e73a8af0-32b6213983amr1004174637.52.1759436500624; 
 Thu, 02 Oct 2025 13:21:40 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b01f99863sm2877261b3a.14.2025.10.02.13.21.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:21:40 -0700 (PDT)
Message-ID: <f29cebf7-42f1-419d-9bbe-46ad91adb57d@linaro.org>
Date: Thu, 2 Oct 2025 13:21:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 30/33] target/riscv: Move debug.h include away from
 cpu.h
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-31-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-31-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 12:33 AM, Anton Johansson wrote:
> All debug.h definitions except for RV_MAX_TRIGGERS are internal to
> target/riscv.  Move RV_MAX_TRIGGERS to cpu.h and include debug.h from
> all translation units which relied on the cpu.h include.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h         | 4 ++--
>   target/riscv/debug.h       | 2 --
>   target/riscv/cpu.c         | 3 +++
>   target/riscv/csr.c         | 3 +++
>   target/riscv/debug.c       | 1 +
>   target/riscv/tcg/tcg-cpu.c | 1 +
>   6 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index a53981a09b..70e0f3718c 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -177,14 +177,14 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
>   #define MAX_RISCV_PMPS (64)
>   #define OLD_MAX_RISCV_PMPS (16)
>   
> -#if !defined(CONFIG_USER_ONLY)
> +#if !defined(CONFIG_LINUX_USER)

Squashed from another change?

...

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


