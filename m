Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8783D0E3F3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 20:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t444C-0000ne-1f; Thu, 24 Oct 2024 16:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4448-0000mt-Ao
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 16:04:16 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4446-0002W2-IL
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 16:04:15 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-207115e3056so11020225ad.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 13:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729800253; x=1730405053; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M8CVWV5WMwNuWfH+MyVrQqyAEZ/XBW52hhqZADqu3CY=;
 b=jje+Otuejw3WyDdVjS9IMtT/ud9Gl5sZLaI+ZBt9nMdN9Z0Ptnz41AAvqxXexLx72V
 BCPaleQEcjTGNCPMe5/s0TanASpifFmHnQccN8XD9mavx2JPWL1lYUyZaRqRmbCmnW+A
 m/K/2d5Vf8rl5B+rel/m6o1vAnNzxYivuTcS018w5k/vlQeyktyjoa7uloAzLZCJF8H6
 MVNrkSjsa5I0XWynnWVSjiMuaQHg/jbS8mvwyq337WKhVUUzQbGSfOZwIxmZKwA2IsOJ
 cOEne1ZqRiVC7lVbJlDUobZOkSNjOpcYU3zfHR6ngBy0doAzjXn4IPHZ6cxehEjv6zsD
 9Qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729800253; x=1730405053;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M8CVWV5WMwNuWfH+MyVrQqyAEZ/XBW52hhqZADqu3CY=;
 b=H8XmwCRdoOXAKL0iC/eAEbLkX//LUVoud6XviEdbQaQGteLx/Z5HFGnrSOf5+fywM4
 r+BMTAYzWo2DC3VEasQVvWP+PmtfZD+TaLhGyFOGwETAx928pGFcj3n6ANx0sXhS1G09
 x062Aech7Lx2ZZkjdArUpPFTIVcDEwYXmBfdhOGIYwnNnEBubA90svq+Lzs/lgcDicuY
 GYcvW4209LJA7chmn3jg2iLMuHSKq3mnVZc87wEStg85BO3z+eYZzbuTxYBEZ52bY3g4
 GoYAINwn1bzIqQxkaM/Dq2hwRW9922KYLe3yO6VXL50fq6fLC1TgiIKnklgCJI3cgtDq
 5sdA==
X-Gm-Message-State: AOJu0YyBjWh+E8hXwtT4kMKQaRKOG29Wp4fX809Ksl3oapqPejWcFSVy
 qlpixmsUH/Re3jGP0bVk6E14qJXd8X9rYpNnQEo8s/LBSuC86tbyh9cww5wJ5WlOeDEIuwyJh53
 i
X-Google-Smtp-Source: AGHT+IEkloBI+75K9SDbz3mcXQyui5LLaGD92vEGjm4kjiU6SGLPpWkH3dA00MxKSxjwCkOPiYDHCw==
X-Received: by 2002:a17:902:ea0e:b0:20c:9bf9:1d97 with SMTP id
 d9443c01a7336-20fb9b41d28mr34011635ad.60.1729800252630; 
 Thu, 24 Oct 2024 13:04:12 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeaafbed0sm8891677a12.10.2024.10.24.13.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2024 13:04:12 -0700 (PDT)
Message-ID: <5d99392c-1b3c-4086-9ce9-463ed7f4162e@linaro.org>
Date: Thu, 24 Oct 2024 17:04:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/mips: Introduce disas_mt_available()
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20241024195447.44600-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241024195447.44600-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x633.google.com
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

On 24/10/24 16:54, Philippe Mathieu-Daudé wrote:
> Similarly to commit 17c2c320f3c ("Introduce ase_mt_available helper"),
> introduce the disas_mt_available() one which takes a DisasContext
> argument to determine whether Multi-Threading is available by
> checking the MT bit of the CP0_Config3 register.
> 
> Remove the then unused ASE_MT definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/mips-defs.h     |   1 -
>   target/mips/tcg/translate.h |   5 ++
>   target/mips/tcg/translate.c | 136 ++++++++++++++++++------------------
>   target/mips/cpu-defs.c.inc  |   4 +-
>   4 files changed, 75 insertions(+), 71 deletions(-)


> diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
> index 5d196e69ac4..b613726ea42 100644
> --- a/target/mips/tcg/translate.h
> +++ b/target/mips/tcg/translate.h
> @@ -228,6 +228,11 @@ bool decode_ext_octeon(DisasContext *ctx, uint32_t insn);
>   #endif
>   bool decode_ext_vr54xx(DisasContext *ctx, uint32_t insn);
>   
> +static inline bool disas_mt_available(DisasContext *ctx)
> +{
> +    return ctx->CP0_Config3 & (1 << CP0C3_MT);
> +}

BTW I considered inlining it in translate.c but the MT code will
eventually be converted to decodetree so better keep this helper
in the translate.h header.


