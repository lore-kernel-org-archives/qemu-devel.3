Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF88CF34D1
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 22:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swUjG-0007Cz-87; Thu, 03 Oct 2024 18:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swUjE-0007CJ-RY
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 18:55:24 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swUjD-0001Kr-4o
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 18:55:24 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7e6d04f74faso1288051a12.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 15:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727996121; x=1728600921; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VnbUAsU+WG3Bp7qGP9BF6yiaTvYKZtPf9fxosv0Vg3k=;
 b=ckG3rBHHgT1uIXf8D+Icm70mzpITYerSu71iAFCmBE1cqmEiUUQw4nMLAVC3KA1pYq
 kII6Xjxj3d7EnlxwXMrC9GDhSgYW3uebflCkM9zZhpXLWQDVDYIbmOoE7MJEKnEFLlVf
 XNoV+JjoF2I9hDbpcd2KIPnAMgj4NE5+p3KtfZCuXc86GFguwr3Vk2WK5lfcPmgUULZ+
 Nmu8WLaDx6gbdw1sQJEaYDG9LvXzFeBXKWXI++5Gy4o1/mAhAMgTefGTIvuTriH6qJSx
 L5Gkg0/Dxkrmrc45NqyL63QZclaNn1gM8HbTVrvqbHaJw7k2NwrF64ypY9uTmrTsXDcu
 1WAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727996121; x=1728600921;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VnbUAsU+WG3Bp7qGP9BF6yiaTvYKZtPf9fxosv0Vg3k=;
 b=Tjo1S231fa9reqVaQjZ5urk/aWlhi3iHOGnbTvA99LGoxG83p1bz/Suazm4Eo/OCad
 K3GpAnDIMihoUQnHo1SfzSxrRd9J5JHaKg0h81FsEoXIpCbkVDZG5kGXk6oRbD5/A+OZ
 NhCUZjsJHnhpND9pu2XW9jhUQSZSY/h1na3i2Me/qnyJ4WF1HB0k9Rptr2AxzKJkzwMA
 EWzXOe/WfSxUjibI6Wh/YvKVd9/iijzp1NvERdh6YOmskk+S7Ol5YNCC5DW5h60JwIAx
 ovTg8HIa20+xu1N2zwFG80XO5atqqm0du6YK9rKFZGD6jV9vDhpD8qOVdRVQcjXg7F44
 NbMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvK2s5EaIW0GaPVn9J7rXK8djdjo3R6McZCoUFzHkj4iQi0n8aiDcBwRMblASObtvQZbVzRmBZw7sm@nongnu.org
X-Gm-Message-State: AOJu0YwktIKzLrFJ+Z8R/nuTe3tbLxdv7UiT+DsKzT+1CfE9KSE2D3Ut
 sXtLx1cVzQnI3+IFoRMAqMUJPWguYZLCVob1Iow5dov5+1y/uEkjHPdHsOwgoCI=
X-Google-Smtp-Source: AGHT+IFTcnWvU034twqLxnf6w2q6RAFZt9EyX+dtzNVT76p8lzPYkY5YtEgeYHUwoION1PjUfmNO0g==
X-Received: by 2002:a05:6a21:3289:b0:1cf:4da0:de0b with SMTP id
 adf61e73a8af0-1d6d3a7fbf0mr6911315637.10.1727996121629; 
 Thu, 03 Oct 2024 15:55:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9dbcf0d77sm1373607a12.4.2024.10.03.15.55.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 15:55:21 -0700 (PDT)
Message-ID: <f6421035-2c72-4dac-b590-266cc404f7ac@linaro.org>
Date: Thu, 3 Oct 2024 15:55:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] target/mips: Convert mips16e decr_and_load/store()
 macros to functions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Anton Johansson <anjo@rev.ng>
References: <20240930091101.40591-1-philmd@linaro.org>
 <20240930091101.40591-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240930091101.40591-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 9/30/24 02:10, Philippe Mathieu-Daudé wrote:
> Functions are easier to rework than macros. Besides,
> there is no gain here in inlining these.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/mips16e_translate.c.inc | 101 +++++++++++++-----------
>   1 file changed, 53 insertions(+), 48 deletions(-)
> 
> diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
> index 5cffe0e412..31bc14f9ca 100644
> --- a/target/mips/tcg/mips16e_translate.c.inc
> +++ b/target/mips/tcg/mips16e_translate.c.inc
> @@ -122,11 +122,23 @@ enum {
>   
>   static int xlat(int r)
>   {
> -  static int map[] = { 16, 17, 2, 3, 4, 5, 6, 7 };
> +  static const int map[] = { 16, 17, 2, 3, 4, 5, 6, 7 };
>   
>     return map[r];
>   }
>   
> +static void decr_and_store(DisasContext *ctx, unsigned regidx, TCGv t0)
> +{
> +    TCGv t1 = tcg_temp_new();
> +    TCGv t2 = tcg_temp_new();
> +
> +    tcg_gen_movi_tl(t2, -4);
> +    gen_op_addr_add(ctx, t0, t0, t2);

Code movement, so:
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

However, for cleanup, pass tcg_constant_tl(-4) instead of moving -4 into t2.


r~

