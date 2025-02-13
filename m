Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2DAC0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 15:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibPG-0003S2-KY; Thu, 13 Feb 2025 10:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tibPE-0003Re-AR
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:45:36 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tibPC-000382-LH
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:45:36 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38f22fe889aso753214f8f.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 07:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739461533; x=1740066333; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O6A4rffOhK7dBT4am3uKeiZAMq8YP3FT36Epy8DTn7M=;
 b=sKq6+/oCZTe4rmw0MrtLaoecDzXH7PehAXuG3eMmcmgSeDviGeDa2ivv1OM1Za7TUQ
 rxMhdt4W08w7ZRtfLmvLwiG5QatZeBtBNfSxKNj0rl4sNpLDihVVDx7B1haApwWEpHvZ
 DOV2kCrPrduFJzcbOjbYU9Op7Yc5u8/dauUH1B1kto4jeOyoId8bcR8ZzS65HcJiqTKd
 0O1nae4KyZJIN1shSwF4tQmu6mILL+ecNyPbxmK9/n42Q/orwNOX5fUT68m49hChpeWm
 U9eudPtX55dPB8H//3VYnmCQ4O0PYrEAL2veljYNijuj7wNvnASfLtAkjzJ9sqFfcOrU
 +SUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739461533; x=1740066333;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O6A4rffOhK7dBT4am3uKeiZAMq8YP3FT36Epy8DTn7M=;
 b=Kjs6GHJ/NdGfSOM5JTDHo0RNyIKNyV5jOvE1rxgyfp2uDTGxHZwuhjNgtDsMuc+pZj
 YJ8K5lraNG52dUFA7oR88W5FYpbrekQaHT3vIgjG+m4JFvBRg3xvqtkZ7bBhhhOlRssU
 hzk2SGIkdvg8QVbjl0btteUV1TG8qVjEukp90bZOq/Q0SiwjW+jt+2PS+n4doMF1A/zW
 b6LfzeoSn3Xnj+F9+HbImSuHsR4hEmqmUTGnxdsrbNxIpmpxNX+k8UHgXBrb/hZ1YePG
 qGRn2Zq8pQuKpMzIkvB/4woxWipUTTXzpmUv8LXq57nSl77zLlBcM8GDUl18JHdmki33
 HOUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo1dfYTXc5v5dG5v/z8KEI8N6++DXMe28/24r4WiM+3iTmUEfwDX9BPP+u/UYV52nuIDbqSSAQbA68@nongnu.org
X-Gm-Message-State: AOJu0Yy68B15Qarsb1fc7KFHXrh7T7Wj+RACNtSuvY1P2We6zLPs/BjE
 9HrwSYdTAAZOBgW5z8ghbxuK+eeFQhOIJyiihLWWj89OWDsRGktxD9BveRQPK2ywIB+MWRyV1mP
 730M=
X-Gm-Gg: ASbGncsIWS4It8yfLix/YqjxOXvl3nR3aPs4k7yLI5i7IokqO9B7y9iPxmfKLyOgazM
 2NHoYjZ0e+ryJpp8ioDM5J1smFHy+lm9u8CjIArYN4PcY3AXWrKrDBtMbBw7SRa6tgYyvr0L6RV
 4Oyw1MjRr7wEldplHig8khQFaxsJzgdpIuCZ6JA4SHtB0F/V81eSDreHRe+RFTTXOhHHSgOU0mn
 tdAJM0C83EsUrZMT/E6GSOQ9aOkqRjCCgkSEZCmgFlV9HbY6s90eOXvLBx26AePJgrmMum7jqu7
 xkYdMtkSdSWGYaFDxCcBk4qHkDaafvE3z0ttN+NmTVkuz93tsusijbFdjiY77tL5Vu0O74DDyQ=
 =
X-Google-Smtp-Source: AGHT+IEr29o2Ny0SME+c1jXB16H5y+64XnogWCPipoqBbCcnWOUPBZ7phYE0NUaR57dNbUd+V7WTag==
X-Received: by 2002:a05:6000:136b:b0:38d:d8fb:e91a with SMTP id
 ffacd0b85a97d-38f244edf28mr3437158f8f.27.1739461533039; 
 Thu, 13 Feb 2025 07:45:33 -0800 (PST)
Received: from [192.168.1.20] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25a0fa1esm2172849f8f.100.2025.02.13.07.45.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 07:45:32 -0800 (PST)
Message-ID: <59d1bd38-2b0f-413a-a6ff-28f8a055dad0@linaro.org>
Date: Thu, 13 Feb 2025 16:45:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] tcg: Introduce the 'z' constraint for a hardware zero
 register
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250212034617.1079324-1-richard.henderson@linaro.org>
 <20250212034617.1079324-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250212034617.1079324-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 12/2/25 04:46, Richard Henderson wrote:
> For loongarch, mips, riscv and sparc, a zero register is
> available all the time.  For aarch64, register index 31
> depends on context: sometimes it is the stack pointer,
> and sometimes it is the zero register.
> 
> Introduce a new general-purpose constraint which maps 0
> to TCG_REG_ZERO, if defined.  This differs from existing
> constant constraints in that const_arg[*] is recorded as
> false, indicating that the value is in a register.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h            |  3 ++-
>   tcg/aarch64/tcg-target.h     |  2 ++
>   tcg/loongarch64/tcg-target.h |  2 ++
>   tcg/mips/tcg-target.h        |  2 ++
>   tcg/riscv/tcg-target.h       |  2 ++
>   tcg/sparc64/tcg-target.h     |  3 ++-
>   tcg/tcg.c                    | 29 ++++++++++++++++++++++-------
>   docs/devel/tcg-ops.rst       |  4 +++-
>   8 files changed, 37 insertions(+), 10 deletions(-)


> diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
> index 6608a29376..75acb4bd32 100644
> --- a/docs/devel/tcg-ops.rst
> +++ b/docs/devel/tcg-ops.rst
> @@ -927,7 +927,9 @@ operation uses a constant input constraint which does not allow all
>   constants, it must also accept registers in order to have a fallback.
>   The constraint '``i``' is defined generically to accept any constant.
>   The constraint '``r``' is not defined generically, but is consistently
> -used by each backend to indicate all registers.
> +used by each backend to indicate all registers.  If ``TCG_REG_ZERO``
> +is defined by the backend, the constraint '``z``' is defined generically

and/to?

> +map 0 to the hardware zero register.
>   
>   The movi_i32 and movi_i64 operations must accept any constants.
>   

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


