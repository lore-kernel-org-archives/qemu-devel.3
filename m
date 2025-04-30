Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AABC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAiW-0000MF-AP; Wed, 30 Apr 2025 12:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAAiT-0000Kv-TU
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:55:26 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAAiS-0002p2-Dp
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:55:25 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2279915e06eso827805ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746032123; x=1746636923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BMqg7s3mBo12Qj4deqVdc1rC108tBOqq0oSTf8Gc7ag=;
 b=geOy4zlRzsuRZBx1/KLig+Fb7r3OaMD3csWhZR7lo/EcB72mhSxHKOu1GbZ5OM9m4n
 W8T5SQL0h0nsovWa9M5zJdiSfpvfQ+ybexT2AIOVjQtQO3qZm6s2qMaAiXGKyFwYyHus
 6sS3riuklLru22YvTaPDtuiKfyq+KD4t8l2MjN6+XWN9qoTloESG3Y1FHziKobZyGOCy
 qiLToOy+iKBI31komlECpQwYXvgPjUKQnLPNQrBOXiDGg7dryMBOMyzrclQtGKqYDZtG
 Bl4jqNb2MWjor8FQlucc2eA8haQvZdv9FGtTzZg1gA4ZSmmxC8XZGDA6kCecn/MfILZf
 dxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746032123; x=1746636923;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BMqg7s3mBo12Qj4deqVdc1rC108tBOqq0oSTf8Gc7ag=;
 b=GFUokuxf4jZOyNtn5XOgO1c8AshQ+pDMZtDVuPxZtUvDKpaenCmndaSXwVFdU525JP
 BERkBBeCusZyf0voQFaOa/4wWmeymMm58Xcgafk7A0bsAIimnZvOK6Cq8cVFixlE+Jwk
 8eiXSzcQm2xN7Lib2xk+HFE6VwOvZD2j4sefjiulPugTDUaM0UKgaL2iBFk9PjEtKDlK
 AJrhQOcFDQxo+VDeZpKyNQChoHBTe/mMuCQkBBUDTlcgcwSHgF+Y3PocSX2wzp268REI
 NpIIIPrMIz2DA44YvBR3EC6tmTXho8DkzCjZ6rYi8UMl2CJmJTIstExD/7frczBQy02W
 Sl1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2WWyLt+KUKrnRoWpVAlc77h8r/y0cIzpV1wS48lqY2QdKpEFTp8aYy749JXO3NbzzV5/xtshs9/Nm@nongnu.org
X-Gm-Message-State: AOJu0YwGivT+h37zx/aSGE0wVByRbtAECrqqZv6xN37+owZcVOghPu3E
 0kZVuAnWYlrOJIbPUO3mX5H4j+QaQndynq84rc0g0mjPhHdalSVM2JylDksIqd4=
X-Gm-Gg: ASbGnctiG5qB0pW8IeEQQVk8un/l3TwZoI0rLljORitkfhPNXpkvbrpiaqJKKfV8hNE
 edViQ7fIqKcMHin14zisbgyf9AkB2Tq1ar6RS0XGHuUHSyAr8aOoWzFII21rsYqpvqd8F5C8awP
 BpAinF7Wh+B7UmIStD9yGzqtLkUnR0mzcr0TAJvU4auhwxjyM0KwE04Ek9WFhdhHKeEhftbMY2a
 y9btl3sTumW/ADFXjeKAXHQtN5W/jYulqK6orO9M+MDaQqNpzDb9rmNjX4yixdNG2orwgSfl5Ta
 ReAUhgQxSj4XgHoTz+WLhii3Qj7Zcmd6Rsqv/DX5gANozBWbAAY0Ew==
X-Google-Smtp-Source: AGHT+IEONCEWkcZlhZtr/UvxaQOpOwckJ0A2b9XTlYLhReHLNTQYe8edr3NJm1l5cN9XkZUGLHp9OA==
X-Received: by 2002:a17:903:22cb:b0:224:76f:9e59 with SMTP id
 d9443c01a7336-22df577e490mr55647965ad.10.1746032123133; 
 Wed, 30 Apr 2025 09:55:23 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db50ea421sm124793045ad.109.2025.04.30.09.55.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 09:55:22 -0700 (PDT)
Message-ID: <1c73275c-ef74-493a-8f81-1fde0909f6b6@linaro.org>
Date: Wed, 30 Apr 2025 09:55:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] accel/tcg: Pass TCGTBCPUState to tb_lookup
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250430164854.2233995-1-richard.henderson@linaro.org>
 <20250430164854.2233995-12-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250430164854.2233995-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 4/30/25 9:48 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cpu-exec.c | 28 +++++++++++++---------------
>   1 file changed, 13 insertions(+), 15 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


