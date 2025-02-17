Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CA2C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwIv-0001LE-SM; Mon, 17 Feb 2025 03:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwIQ-0001Ji-6A
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:16:07 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwIO-0000so-Ht
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:16:05 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-439714a799aso15154895e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739780163; x=1740384963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tpt3csQymDzpjZwPWVQpGAlJ20epg3gwDh7rDL6Eq0Q=;
 b=Uodqe/olZkYiRELypR58zSVKIPSy3aPULEsoXMkw9ANJh2t/mBpeigBltFNhjUkWqB
 7JIfRFUzBKOllHfnYU+UW8kcQ0Br5jU12Ap0V0fxnFt0N/u8TiibKVsIMc/rN1wrY3VS
 HF7G97ru/wlRz6pdqmkIRCCDvEU81D2fAW9jXYZNqap2Gli1lcSTgZMZXSfkkeKxN+Lk
 QwgU20TkL5pBNeE7kC3UhM+L05gXbp7qWopW05zVd74KnqDtQ9mRr1nWb3DoT5z0bdQt
 43EaeGcAyxfvDba+dFx9ajxb6Kv+Dj4TD0H0P1pgdTgkXw50wK7+Cfd3rk5qDCFaeTfs
 7UGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739780163; x=1740384963;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tpt3csQymDzpjZwPWVQpGAlJ20epg3gwDh7rDL6Eq0Q=;
 b=QrCHzXGc38eJlfnSNIwoFm2cGgNQejt5nP0205I2XK/G6+CZL5IPD0mW6SHcB4DHGY
 h/iFc8wirVocWW57NbVD5H1IGotUcTZUvN30M1NTvWGLFop+1j9IY69Oqd6MENz31aCa
 5nIQjDrQ0xxe3AWM/kJuHW6h3uGYpvS4V7Cz9M2xyUSCxQBaB/0AG6x1hvk6JWJFQ4m1
 jPN3EXGzMp4wba2lTjXLghwwH76ZH6eqht0D8KtzYTi/EQV/yGMg/BNTpXfTfGLs+v3G
 SauQPgHUp6Mgxk0W0L8HjClNHM84jWWZl/YtrWkLAUC5C/L147XV4OTN6N70OCf9ydXy
 m6mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxNZDMY0/lk5tQmXUOCUsmV1sHWU7ar4nEvQBNgwXt/HVe5+qZku2BHnjOMND2BTIlnF8YoNybPF3l@nongnu.org
X-Gm-Message-State: AOJu0YzFogVbmOZtPe3u+NHHccySeteUs9Jk3Hdq4tOMxIUkEHnS+kqe
 opCSq/Sr5WsCMsWPAuOpGg0q+N8QHGK8IhQvjsgEL5vwNonDVtyXDJ2G2HxBtDY=
X-Gm-Gg: ASbGncuDkeN5KyDlaUv6eVoLkOgGLzuH6IY61oz7obHw5snb+oPyX5CDbVKckn6eDTy
 7lONQxFA2P7mnX18aBYFkg4PI42lmc9m8Be5x61YEPm1we0Tqca+VsF2CPJpSIJD2Rq9kNpKLTF
 61R4IqWto1fSjk7KuKzADsZ4Zb/vNz45x0bYU93d5m89YLN67Y8Zyn5blCo/BB1llpE0JflI2bG
 cjcHO+ms4fekyuI40Y0/tg+8OJvNxws9o0DBbjNq0O0eY2z+wXP9hEKr++pvz3pE12GJo137qbW
 SFyR2AqoMNDE7i+EAra5FYxWuhhXLg==
X-Google-Smtp-Source: AGHT+IHm9yzz3oK/Cy3aySwW3EAoGqLUU3Gm12kccX9Yrk3QQkRVCgsqdjbq7rwsiBVyhbuA8jo2SQ==
X-Received: by 2002:a05:6000:1209:b0:38a:87cc:fb42 with SMTP id
 ffacd0b85a97d-38f33f2a33cmr7899756f8f.21.1739780162777; 
 Mon, 17 Feb 2025 00:16:02 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ccda0sm11582618f8f.27.2025.02.17.00.16.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 00:16:02 -0800 (PST)
Message-ID: <f46dc7ac-8604-4dd1-b462-6342a70e34b2@linaro.org>
Date: Mon, 17 Feb 2025 09:16:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 104/162] tcg: Merge INDEX_op_extract2_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-105-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-105-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 17/2/25 00:09, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h      |  5 +----
>   tcg/optimize.c             | 10 +++++-----
>   tcg/tcg-op.c               | 16 ++++++++--------
>   tcg/tcg.c                  |  6 ++----
>   docs/devel/tcg-ops.rst     |  4 ++--
>   target/i386/tcg/emit.c.inc | 12 +-----------
>   6 files changed, 19 insertions(+), 34 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


