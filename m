Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A834BC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg8q6-0002Lf-40; Thu, 06 Feb 2025 15:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg8q4-0002Ky-70
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:51:08 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg8q2-0004jP-2c
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:51:07 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2f44353649aso1990695a91.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738875063; x=1739479863; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z+2EVqLuOD3MZKjsDyNYv174/JIDa8ipGig0g6vCiVc=;
 b=jz6A8FnfHrWln8TYQ2oO9EnV6/v69v952OHHud+DH3nZ8I2BAHc3RLHv1BJqZcJ5aK
 21Bi5qDdvqzYetJXNhvIbebedokj/e2fQPu2k8i4SepNOeIubuWNY2noN5FGHkr54O4U
 xLZIIGy8DQHqoxBxcFkX2gRsongCUE8WO3TJfSUXzKnipo38HH1Y38XC7wqj9bOMn1ye
 Jsw8ueHcneP7gagXTE/dQXTa8+HcVC3M3KnZE6LU7b/oCWhgUDKU4rgU/Wa25U+qdwAA
 daM3VQlZtsb+tplt+YKN9oyvPb0yXSAU28Uy2Lr204bDd7QWicqd+caI/Rqg1WRGdZ3j
 W76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738875063; x=1739479863;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z+2EVqLuOD3MZKjsDyNYv174/JIDa8ipGig0g6vCiVc=;
 b=eps+hZnLMxWDuaJji5b7XxogLPSQr3id4+kd42EmEDBgg4CIGfTWOzBvCZkuEYGT93
 9nIIpJqEpb/mAJBWy8mMhV+gLDYsxfRmcxknVDqqvySN2BbstDfENyAF7FqHSJSHYAed
 SMpe9Uc8Or51QNbfUqX6pP3R9DAy6+Z9AM0Og9nqntyk0OKnwyEowVd2WDPqAwItmto8
 zexE4akgpaA8UMj/2HrcsxN0yDwP8KEcrAIHLR1yKaZBjLwtyLg60EJGz/zO8s61Wc8X
 cyoB6uuYEg1p+kvNSY1A0Ga1UA915TmzQXnNGBaY31zm1ivit1ATOyB5PwSZj8KCegCS
 MXuA==
X-Gm-Message-State: AOJu0YxdAfkEmE4OXxOKDS4ylhwbgWkoKXeEmubTi6/FLrXqOZpm6nic
 BpXf4BQss0JIU/eycxcEl+jlThz19E6rdKaFTLJNRsufWCBVgYbUFuKZta+BoqwdOYWYt+apktt
 p
X-Gm-Gg: ASbGncsY8/ulI93Ogd8a5Lz306lvU/m05ac9u+MiPigr6dji/gffKtYPeYygdtgg/If
 eXlmazrAmQxfTEtw4zyNZJrRLt8XXxHYHtioY3Rklk9q5AJqiAtbos8jSvN/VvQ4alGh5ItpaiZ
 n/2N5px6v1g7VqpYrRqNBbWlK8KU94p/3f6iTmpADN5xaUD8cvuIWujHruQwG3+KTWtTB7fw2YZ
 0jw2Au3IKK18Mwn/QP7yizTvTzM3/3L+o11LrMuZRGmkAbF9QRMaAtkRi95ZNO4XiLEXA6HbZAy
 le2knNc7IRoLLEUVdPmJHKdoXwbQEc8usaR50X1416zupYI0gpGi5x4=
X-Google-Smtp-Source: AGHT+IGU1nCBF1JzPQGuhnoYui+xkJiGkradSlN/HNtx5O7uOoIHPVq9yhIGJeTo4rLG1xTq60GxGQ==
X-Received: by 2002:a17:90b:3ec1:b0:2fa:20f4:d27f with SMTP id
 98e67ed59e1d1-2fa2450d1d0mr657750a91.32.1738875063299; 
 Thu, 06 Feb 2025 12:51:03 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653ac11sm17380845ad.59.2025.02.06.12.51.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 12:51:02 -0800 (PST)
Message-ID: <6d279ec9-4be7-4e97-851a-52e31b0a3d15@linaro.org>
Date: Thu, 6 Feb 2025 12:51:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] hw: Centralize handling of -machine dumpdtb option
To: qemu-devel@nongnu.org
References: <20250206151214.2947842-1-peter.maydell@linaro.org>
 <20250206151214.2947842-6-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250206151214.2947842-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 2/6/25 07:12, Peter Maydell wrote:
> Currently we handle the 'dumpdtb' machine sub-option ad-hoc in every
> board model that has an FDT.  It's up to the board code to make sure
> it calls qemu_fdt_dumpdtb() in the right place.
> 
> This means we're inconsistent and often just ignore the user's
> command line argument:
>   * if the board doesn't have an FDT at all
>   * if the board supports FDT, but there happens not to be one
>     present (usually because of a missing -fdt option)
> 
> This isn't very helpful because it gives the user no clue why their
> option was ignored.
> 
> However, in order to support the QMP/HMP dumpdtb commands we require
> now that every FDT machine stores a pointer to the FDT in
> MachineState::fdt.  This means we can handle -machine dumpdtb
> centrally by calling the qmp_dumpdtb() function, unifying its
> handling with the QMP/HMP commands.  All the board code calls to
> qemu_fdt_dumpdtb() can then be removed.
> 
> For this commit we retain the existing behaviour that if there
> is no FDT we silently ignore the -machine dumpdtb option.
> ---
>   include/system/device_tree.h |  2 --
>   hw/arm/boot.c                |  2 --
>   hw/core/machine.c            | 25 +++++++++++++++++++++++++
>   hw/loongarch/virt.c          |  1 -
>   hw/mips/boston.c             |  1 -
>   hw/openrisc/boot.c           |  1 -
>   hw/ppc/e500.c                |  1 -
>   hw/ppc/pegasos2.c            |  1 -
>   hw/ppc/pnv.c                 |  1 -
>   hw/ppc/spapr.c               |  1 -
>   hw/riscv/boot.c              |  2 --
>   system/device_tree.c         | 15 ---------------
>   12 files changed, 25 insertions(+), 28 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

