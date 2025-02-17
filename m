Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F79C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwTH-0001yc-1C; Mon, 17 Feb 2025 03:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwSz-0001Yd-GC
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:27:01 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwSw-00022q-D9
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:27:00 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4396a24118dso25415665e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739780816; x=1740385616; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZhqxF36txq/dKuG1luC+4iO2nnrMyn82+9mJlzp0i2E=;
 b=OLW5VPMc6hr4qCssFWHmK/LY7vqpFC6T6no46Vj22RSic3njbiPngLIOxezYord9kp
 0KXwDFQVIOzN5bICnEII5wB6C85syN2A5dST31Thk+IAUqkvaHpqIoVrg45/GGUvqcSR
 dVFfkGSF6f5ZjANom4HpUMSo46oaaJ5ea65VXdXvbSShOLuGv6GzVHxoiZJEd6qwvfq3
 Mn+/r3H4XEiwNiABGUCBu8UzpUqxJ5bkQv0Mx09IX+qzqPbvRY3GB+bfK/8pqSdTKa7H
 lyFkfkJnogFjTxzxuJoniUAjIoXrFJyGMls/JkYDT+1FvEY7p77B6c57MqROMHVoVMWh
 HMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739780816; x=1740385616;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZhqxF36txq/dKuG1luC+4iO2nnrMyn82+9mJlzp0i2E=;
 b=FCTSvknaFbOKp9yn65MwxJkEzTL/DhS02eQ+CQP/LcAOGIx5LF6+gzv1I5i5g67OhV
 enY8rqIOKpDzwgdlanQhoUtIGmezTKAEOIhF5F6VEN1mMUvdINS/ChXnRe96FKaEQkPN
 S/+ZCc7oEZsYa5J8yk22jYJX0Sb8G4yrigoHDujPQabTM+Qn6OOfJfHuXubUaK0rSzAR
 GxE9nLyiQ3L56ViBSIQqzhj/UoqCD6Ds2STm8ATSjj40XIXLPPBJ8UUJrOlD/aPeI3T8
 2jLOYB3sqokPvlhl0MWKHsqtF3t1xsBcTcfik7YNlTuIk6c0fRfjgGZDwiIG8e/ff5CE
 /Uqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcVBuLc91jVsI+1xxZ86pVNXD5K01E4lAU3stjcL+C9C2+NJipQJw8OSvUc8W6zQiDnEky/Y5RZBBF@nongnu.org
X-Gm-Message-State: AOJu0Yyt/shBnNRI9tQW5C6X9yhtxyKQgluaUUjIyvl0MnNn/thBVfZ/
 O840hhOl7gpE+qD9U9TTcUCOy04svYc5roLbVBBgrajH0zYD+wDMSkHY7Fh0/RM=
X-Gm-Gg: ASbGncvmv8LWJcaIh88lwgDgafHr+Xu+8VWRRTZLZXJTJeEw0MyJsIeoiCZjlailjCl
 0hG9OeoBEXC8Dr6DHbFY4Na+Wu0shtb0xn/EL04IyIxtZ+yA5dL6KZjqUFeFrFO8Pji11htTyM0
 lH5PpD91RgsxK2uTuIzDQBKOhh/7yta0lD3HogVArcPLd8p9nC93I5snB5XyC+R1o/kdTnS03yo
 4h1xR+Np3KmOccy45uDI2Sod7k9QBaQP7koB6VYMLEOfi7pCU91N5etwkGsy3Nr96anGHrLZNqM
 zAPzk23ap2xDj4H3g3AxrQNXeUoH9Q==
X-Google-Smtp-Source: AGHT+IEZqu3uihyeMued0xAFDk7b6m2MvsZuhv8Dr8Nj/gxr2VL+lfbl46pI5d0g6DJf78muF9isyQ==
X-Received: by 2002:a05:600c:3b1c:b0:439:64eb:67cf with SMTP id
 5b1f17b1804b1-4396e6c18d4mr79058795e9.13.1739780816067; 
 Mon, 17 Feb 2025 00:26:56 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1b8471sm146710375e9.37.2025.02.17.00.26.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 00:26:55 -0800 (PST)
Message-ID: <0da5a268-f054-4642-92b2-4d1a1dd92f77@linaro.org>
Date: Mon, 17 Feb 2025 09:26:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 162/162] tcg: Remove tcg_out_op
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-163-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-163-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 17/2/25 00:10, Richard Henderson wrote:
> All integer opcodes are now converted to TCGOutOp.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                        | 12 +++---------
>   tcg/aarch64/tcg-target.c.inc     |  7 -------
>   tcg/arm/tcg-target.c.inc         |  7 -------
>   tcg/i386/tcg-target.c.inc        |  7 -------
>   tcg/loongarch64/tcg-target.c.inc |  7 -------
>   tcg/mips/tcg-target.c.inc        |  7 -------
>   tcg/ppc/tcg-target.c.inc         |  7 -------
>   tcg/riscv/tcg-target.c.inc       |  7 -------
>   tcg/s390x/tcg-target.c.inc       |  7 -------
>   tcg/sparc64/tcg-target.c.inc     |  7 -------
>   tcg/tci/tcg-target.c.inc         |  7 -------
>   11 files changed, 3 insertions(+), 79 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


