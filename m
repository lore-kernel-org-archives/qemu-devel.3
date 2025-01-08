Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F78E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdBG-0002tf-9v; Wed, 08 Jan 2025 16:01:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdBD-0002sq-O0
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:01:32 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdBC-00085e-C1
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:01:31 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso180776f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736370089; x=1736974889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ehfq1ffV8wUj/TGvS0nA3MzfJWjNX6FtUOdpJIjzIEM=;
 b=gZ2DbJWqwZJSSR+CqhHHxuFX3xOTt9IVi4FZ9MFknvskcKp0cDOP2u4Ma+RzKzX8NH
 Ow8ZhS2TmUDdvQrX7yd8932n/NpkUy1Y5tJhKx+p2zm8J84XOth6borKCC9sxHcQaIxF
 ga+Qjy93Of6PaSd/ABpW+0Q7ZPL6Sf3a8kcN2cKGGLG9frH0zqSKArad5Jsx8pVYorEa
 PkXl4O+NKyHaZR/lBag8xSjbEsrDom57Xts7T3sPVZD0aqyaeiYYyga69q+6fNz2nmbW
 0NJS6t+1mGoQVEsAFkTbGKdypSu+Zhy4VxUqCeCj10zNiUiaEBSXBGUuCmitXbrlQHM0
 yvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736370089; x=1736974889;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ehfq1ffV8wUj/TGvS0nA3MzfJWjNX6FtUOdpJIjzIEM=;
 b=VuSlYB3DZFQhXM6oxqjMYNOenuCjzX+61Ffz7lu/kSo/6BkAhULbwJqx6/QZON8pOA
 ZB1V7irFVf+4iem79Tlo3cqoUr32M9zdosKT/zwC+19ON6SsPCmOn8LbVCb1hg6YCJuW
 tFbj9h0TrOmvEgMqaZ1yJO4dyN9/V52jXbRv9ok+A/nFjUvRoEuoec3NajaoSFTQmFdv
 LA+UUUAH0Jt9Nu/fUWu3jM5UCJsMyyFJSjH+vSaoNQLWhIz/vMA1qpqSKpN3tFjn7pMx
 07VLaBOYaNCEliHYBSgtGWg5JfESWm8OpkONU0nWf7oETv+moWlBDtuXb5RBaQxTkTI9
 uMyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuKb3LOYAGGB0Y15z+wZOnbeGQrZiAltQwBDna8Lov+dXcAnKoRk6XRPJ8SYpe0GZhLG1ynjdnwR4L@nongnu.org
X-Gm-Message-State: AOJu0YyRnLB2KNIuy7osf72PDF7XOPGBSKnRhAAsBeZy9ks9Z/MgiksD
 r0mnGGxZmLeCJNeCZbFuJ2ItyzyILc2mpmpcIBQ6RCZo+Va5p8qsw0SCXRIoDuE=
X-Gm-Gg: ASbGnctlPRpPdazJTiZa+OYm6RriWhk3glnerMeM77fDTTJEU0OeaLewC2y+T4y4I9c
 5RqgEcdlhcx9LtQKALkLP8qPseyYcFrWasvO8DuijdrhFoCiYvj6ubdsVQjVIOW4DjJk3Opxjul
 0kSk1+KlXXz1hr8eE3EmDLAMl7L/Qn++/pMmGrvQ83RvBbh7wl2RRZDYll7qkrFX2ePCFMngmP6
 IZ/f5JY6pG9JF5D8K5NinVnJSuyf3DevApCcgQ6tQzAuVZoNOD/sIsoZY1cwm+RbUAaOjSnSzD+
 5ktfzAKqi1xQ/Nv6P/4baXtk
X-Google-Smtp-Source: AGHT+IHQxfElAxqBggGchBEVVGwqYa1ua6RUz87QGVJgrMR+5DAaE9sxIlyhRoeuotp63Z3KUbOI7w==
X-Received: by 2002:a05:6000:1447:b0:385:fb34:d5a0 with SMTP id
 ffacd0b85a97d-38a8731f4fcmr3815236f8f.29.1736370088802; 
 Wed, 08 Jan 2025 13:01:28 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2ddc88esm32386355e9.18.2025.01.08.13.01.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 13:01:27 -0800 (PST)
Message-ID: <8236c3b0-c294-4694-9611-9b6b32bef011@linaro.org>
Date: Wed, 8 Jan 2025 22:01:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 71/81] tcg: Merge INDEX_op_nand_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-72-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-72-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 7/1/25 09:01, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    | 3 +--
>   tcg/optimize.c           | 6 ++++--
>   tcg/tcg-op.c             | 8 ++++----
>   tcg/tcg.c                | 6 ++----
>   tcg/tci.c                | 5 ++---
>   tcg/tci/tcg-target.c.inc | 2 +-
>   6 files changed, 14 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


