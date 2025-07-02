Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A11C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWylg-0005T2-RJ; Wed, 02 Jul 2025 10:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWylI-0005GD-7f
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:48:36 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWylD-0008EZ-CQ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:48:35 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-40a8013d961so2280264b6e.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 07:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751467709; x=1752072509; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BspX5VTDt51GDPvJ9KkTMMhE7EclRby1bg8SbnA2MYo=;
 b=DmjYwxN2VUSePgaYtRl3nkGAZDr/j9vnHtNEuvNzM0HQMZSlmTvp6E9Dar358cqdUN
 9vGE0ENnwq1ckMFuAeScy50G6GggC0Ku0zNJH87Y498GJMSfVUGDvs23YGxIYstPZkQD
 UVvQqpv70xQqDqlC0GflwraX7UsMpRP6oy5uF7/h9mwRnpJT5FnrmKO1Xaf12+rr27og
 Vxqx9tu6SiRFi1zWxZu8ehs+JgBj4QnIc/D7gDr2Kgn8yiEkwMqvH9oV64M86YTVn1jR
 2dQ2uf0hMLF2fQvUVWfITKHzZ2LJj+xBfoEqB45m0UWCJN1a6i8MJGuP8EEyeJahcChg
 nZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751467709; x=1752072509;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BspX5VTDt51GDPvJ9KkTMMhE7EclRby1bg8SbnA2MYo=;
 b=l2bGvp3sBUgvzzLSIScRXsrx3fxSTqqfibDfbMhJcGIKQV1rN5WEUkljLkeWJFhd3d
 ogen3nAii1cVCbe0u+JtmrEboM/LznlSesr22VP6pfIo4Hu2RcdUJHcBanCiS2kDemJP
 2tn4Z54cqVRBKIsrh8jxUVon3D4SUNXm+ZgnzMfEqKLg3ZExO4uknfD8uY0yTZBR8Ocb
 Stvs++pnjZ2KttRuBUIjwn1lv7MdTG6AV3ZSxLPoZZvrxbrmOjC1qrIXPfRp9vd1FDWK
 wtzihH/usBwmrt08NWUriaHe1Ot3NKXgcGSwI58wyuQkgvEwvFPNeA0b4ydo6M10MjTp
 iLmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXQTeL5ofhVIu/Ko1AYcfVSdaL4djwvpw+MxdJQTYlpAQkmaQGJw/KPa+9/bj+fQAqo7xlug2/er0N@nongnu.org
X-Gm-Message-State: AOJu0Yy9P9Purfhu4Daj3cU2vyT6D4ouHAw/ZBa3kXgqlS6mgtOnU+Ce
 GmdIOIm6toWr+6fewawVJ63M6rqMEoIIUdXsAdNPLbilAS5GoqZDBngZJLo1PtOsyLA=
X-Gm-Gg: ASbGnctVLLi4w3lFkaqLuDKg1Lsr7MrRkeRj/e7YrcCp6rWWH5toiLMmSCNHmThiB4m
 xibbZ3YPfUxtyYiuL+7z/SHBuyK5uMqZ+N7hLItplxpkpS0j3Q9bW4o9fqH9GMmuuhidN6BSgrr
 2SvcoR0uoH1j39hZtWw0oMYN+StmI+WY9gE2gj72weCX5endlxe6/2BpaBbiCS0qIjV457/JklL
 Hq27OKvvUYds95x9gp8g+LCj2SleFXdpjX3B8oyDkswTy+WfFT4YjLeD1VlSznLj/jRST/fC2qm
 9rnR8a1e+/f2fjrZgpzkQgPMbSLz9CZMn1O27r9bhklMwmeY4ZaJbeF3s0CiRhD+DlhoEX9njsM
 c
X-Google-Smtp-Source: AGHT+IEd0/pFTlcWWNRWSoi6Ea/3ff2rJEIfXH+stve1lCZTeI/IqbBXWu0MycMZQvIQJVIYksTfiw==
X-Received: by 2002:a05:6808:1406:b0:401:e98b:ee41 with SMTP id
 5614622812f47-40b88e0f17fmr2622540b6e.21.1751467709591; 
 Wed, 02 Jul 2025 07:48:29 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b3241f829sm2569909b6e.35.2025.07.02.07.48.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 07:48:29 -0700 (PDT)
Message-ID: <89c4b55f-1da1-4d73-a6dc-0adb7cc68bd0@linaro.org>
Date: Wed, 2 Jul 2025 08:48:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] target/arm: Fix VLD4 helper load alignment checks
To: William Kosasih <kosasihwilliam4@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
 <20250702111954.128563-9-kosasihwilliam4@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250702111954.128563-9-kosasihwilliam4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 7/2/25 05:19, William Kosasih wrote:
> This patch adds alignment checks in the load operations in the VLD4
> instruction.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
> Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
> ---
>   target/arm/tcg/mve_helper.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

