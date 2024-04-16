Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28C1C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 18:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwnfw-0000aj-JG; Tue, 16 Apr 2024 14:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwnfu-0000a4-Eq
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 14:36:58 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwnfr-0001T5-1y
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 14:36:57 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5c66b093b86so41590a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 11:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713292613; x=1713897413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=os9cbyyMg1LmxJudAsFKVUnFkMyljMdWyhDNxSSNTyY=;
 b=Bl1TrKE2MXsIhgN8tV4vyun6T6MsWjnERwaMx7HVOEaL2XvVbleWP8NHG9bhz9XdXm
 LT9Icy1ZsxhbWccO6ZrirXioeYLXxwuZf2mBxP+7obDgpAl9HzzcQLuVM5xstr5GAB7T
 upMHQ55dpW9c80btzBn2mkUFmxzqvIQAphIPsahh4Q/Xd/1ZVMm72qESVK8KI5wjYJyy
 uqwW9uESoXdNvfjTh+Y3EMsqhoPwZ6vZnwNcQl3lRk/MIgvilFJWN+D/wjUSZiCY1UW3
 dJzOYnXSHvvU0gVSwaBfFqk45UgwFrvCbmf4Go2CJPau++ftpeMnb687iKx5luNQRmIg
 8RKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713292613; x=1713897413;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=os9cbyyMg1LmxJudAsFKVUnFkMyljMdWyhDNxSSNTyY=;
 b=Xl5gx0SkEmH1Dwnkn+E4YRGiHfkWcYkFaFocnrXzuKgZEdTkwq23hXwuMx0MM2Wupk
 FXNWoAuW9jzvSJ7HTs4qT+klgwuIIg4DcHGFLnHhabIQalms9ApkcomdPVFXbtiWrVMI
 6sleZb9Wa0G92iaH7W1fSEJJrqyhoyhz66Cp1QFRbl7y3nEXLmO+/2n/CVaP12ke96HH
 FcQJGyAczx83gsG0HmhCxmsGQXEcHOeBFiS4tulcbEO6By8vtjqbkgd5qISgWHsw9qo5
 tP7efOtGeXit7qSKbEchfsbH0sEF5r7rIYSxRURQUicLGKXDtIt45dJVo3n+TVWIdNvr
 p1MA==
X-Gm-Message-State: AOJu0YwrQ/30GcYgGoruhFUL4J0XvoM84kD/3Pk/AOu4UAe5ZHs1hHlB
 NaWMItzA8c90gJ2l4/8L8NCHlDUIExAJitwdM+uemY6Kbb8i58mUI0+9hj3cqUU=
X-Google-Smtp-Source: AGHT+IF0UAx9Dxg7M7d/lFDNkKer8bl55LIfwcXLj1R20965MaWSwhHbVMDh292+rnDBHDhJzcXwOw==
X-Received: by 2002:a05:6a20:2d13:b0:1a8:4266:f88b with SMTP id
 g19-20020a056a202d1300b001a84266f88bmr4660061pzl.28.1713292612890; 
 Tue, 16 Apr 2024 11:36:52 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 bn23-20020a056a00325700b006eac4d7b2e1sm9326764pfb.113.2024.04.16.11.36.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 11:36:52 -0700 (PDT)
Message-ID: <87bafba4-7a65-42e9-acf2-d05962ce7186@linaro.org>
Date: Tue, 16 Apr 2024 11:36:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] target/ppc: Move multiply fixed-point insns (64-bit
 operands) to decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240416063927.99428-1-rathc@linux.ibm.com>
 <20240416063927.99428-6-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240416063927.99428-6-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 4/15/24 23:39, Chinmay Rath wrote:
> +static bool trans_MADDHDU(DisasContext *ctx, arg_MADDHDU *a)
...
> +    tcg_gen_movi_i64(t1, 0);

Drop the movi.

> +    tcg_gen_add2_i64(t1, cpu_gpr[a->vrt], lo, hi, cpu_gpr[a->rc], t1);

Use tcg_constant_i64(0).

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

