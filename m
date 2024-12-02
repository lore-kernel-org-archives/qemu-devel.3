Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601C9D78337
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIA8R-0007KV-LU; Mon, 02 Dec 2024 12:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIA8P-0007KM-Gg
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:22:57 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIA8O-0007zQ-4E
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:22:57 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4668486df76so41251291cf.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160175; x=1733764975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XjmGJr9vlWlRm2kj07hGfIyl+xpnr1na3SZIGMs92pI=;
 b=ycbaI8wRByiARit9CzesaOnoVupV4l7G6JDLRF4uEu8q/uBU/fEjaifL0Odi7RuhP/
 IjLyUQ+RI0wJ8YijfueFSQeb2LyqYx26m6IpjpJVW7rjCF6HmOrrB+g+Y7goi0uKD76k
 cxeOoD9qysMoHV7VXf/KNqfyH++fj0iyylc3BAJAw+sEHHUzfS75YQm1yrBo4uL5gmJO
 heIxZ0mqZJW2e8V/uf1LCVm95TVzyqz+pFrumsP//qUqEaefailHLx0jd+5fmcGbDzm/
 tpACt5OwmyrIUCsqU+V9q6ISnhx7mTS2FQCiNdwwXQg6qDkPVdZ+gX15YbQ8YW+0YJ9k
 q68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160175; x=1733764975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XjmGJr9vlWlRm2kj07hGfIyl+xpnr1na3SZIGMs92pI=;
 b=vNPUxKMN1hejNhoutybpX7eUNrBpOCgT6+fwh5S2pBQEZrxDQYG3D/YXEs4J8CYueC
 3ExjeNAO+x3hxgUSVYjyA4Dy+fZzUgI0CS+ZxOEG3wZpMS45zMgzguOzYA0Mf6tJKKKx
 4PsSbaD9/QM5+pPXzCQ2tdghtHc3paTpJiKPdtEkx2sdtKGClqjisKgGnNpg0c4FrhOK
 Che5CPd6BuSziuNE5/51kbp00Ol32LIU+bnOLk7iJ5+ELLitSLSLUZiwIeFAvmYA7DoY
 rR7RHIOm1h8X79jnR5Ux26LgGlJ+E6DHjiKtEWr7rXzsLoluIJKff81Q5D4dfG42lke2
 uEQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJYLsNkhB258jvwfFR8vNHwDJwW5qdwZGhA8JquahB2Wevh1nzVyjcGO7CE9OA4SC8rw4vH89PpOwt@nongnu.org
X-Gm-Message-State: AOJu0YxVm7am3ly2vPvBVbZUsjt5TVrzXy/X+X94l5e5UBau4N2mANe9
 D5pUEeD3XYFG2GzKE6ObDntLASxNloIm4sAqzH5S9lHMxzlh1sowKcMl8v5Xw7YMHhxHVFBZLMw
 XnFc=
X-Gm-Gg: ASbGncsBbhnsDRo5d8G3FlCnjwcyM97a8AgCBFp/9hRlhf490HBkSe2xFQLnh6OW8ey
 eARFpr05UIBoipZD4XzoWlxqkhIPNkB+PyQJ87la3WL3tOKbsb/MR/2fQQOlC5RUF/Tze6rnN7y
 2u7HrvHXOjIbXt+O0y2GQvwG2PE9Zq1vQBrg7RezadOMbNx9C4vVjMrEP8SwcpWB0VWOTyHM5OK
 2JfyRRsUZWUk5o4JZVF9+QSIDQhwm7J3Z6Lp7Xgux5vxHQhGTlvATGeXFiYbIbP9ijLvG0=
X-Google-Smtp-Source: AGHT+IEmYnp4heEKA0HQJtgCVL3Aejwb8+evelDynZhAA6a/5ppJRtBmYtigJmP59nx2CDOhCjh2GA==
X-Received: by 2002:ad4:5aef:0:b0:6d4:3593:2def with SMTP id
 6a1803df08f44-6d864d0ad6emr448151496d6.5.1733160174980; 
 Mon, 02 Dec 2024 09:22:54 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d88e580913sm33299646d6.87.2024.12.02.09.22.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:22:54 -0800 (PST)
Message-ID: <ca449244-9833-49fd-89c8-73b944c7f8a7@linaro.org>
Date: Mon, 2 Dec 2024 11:22:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 30/54] target/m68k: In frem helper, initialize
 local float_status from env->fp_status
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-31-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-31-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/2/24 07:13, Peter Maydell wrote:
> In the frem helper, we have a local float_status because we want to
> execute the floatx80_div() with a custom rounding mode.  Instead of
> zero-initializing the local float_status and then having to set it up
> with the m68k standard behaviour (including the NaN propagation rule
> and copying the rounding precision from env->fp_status), initialize
> it as a complete copy of env->fp_status. This will avoid our having
> to add new code in this function for every new config knob we add
> to fp_status.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/m68k/fpu_helper.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

