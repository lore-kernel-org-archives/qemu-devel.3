Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CD2CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tkI-0008Qo-Ft; Thu, 09 Oct 2025 12:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tkF-0008QV-W2
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:44:00 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tkC-00044m-Fe
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:43:58 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b5507d3ccd8so958082a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760028232; x=1760633032; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pNb1eA9/HgxhpcljMC3kbrYLlBknGVR2EVLJ6Hliz7E=;
 b=q9iS0zg/aQYRk6/UUFXnXmGjn91BzbScJv0geJg/A2U6K6I2+wTj9AK8psNusK4iTs
 zm8/xsj3LAA2kWu1Ko9JsyRmCzPypvr7pozCmUs7LRVUAZNGMymAk8QFnzpGAHhocFs4
 hWBf7wQhFuuQitvp127+5Xdglcy9Ri6SMUd3UzKZK4nE0QtMquD4wD9OjrUESYSJlt5n
 SEkYC4UuDv+t+PQ7g8n2WD0wnuqqCzxtoB7nC1g5iXo6TLnbrGw5q+oGJntxTMxUtseB
 n6HiPFbXtZgZhImZbSyUJSeYGw6pFHsEX4G69rgGAWOBUkv62lTgUYDr71vwfysR+wZs
 9Wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760028232; x=1760633032;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pNb1eA9/HgxhpcljMC3kbrYLlBknGVR2EVLJ6Hliz7E=;
 b=C+P3mUmA211gehN3DWb4EUsKEW+4iy56qWtANOZ7TMpclqDyqdi8r/aX1hZK6bfCMu
 RG9a0fdsgx52k+ZBCoQ9wmh6BjfQeOjAtWgbgfZSvqrmompiYRgdzdnm5m9Fq5eGjGGW
 g7etTVYsSMtSCFkrl7EwWjjd+nAhGNKDGMiUfHIjE7ze5kZkmjum+Wg59bDFq44YdWKM
 ROuEbhfvHAWREC8oZcDgEbBwwyNA1Av0Ybd7kZRpMcSx5+92YxVH6SutAzcrk3tatuVy
 Y5a0wc6KJs7Zq4VK6AB4mv0B8ED2k9m7byvVctiG2H+q/0X1iTsXGY91cgGAkxWYzcrX
 d9Cg==
X-Gm-Message-State: AOJu0YwsfuroZcEtZ3NBckHQYE3MkqnzLNETlfEo1U+jxGzAvWvf99AE
 ILztASN59kJyJUQa1GVQlj9gJh4ocLo04l/iz5dhw9G0xOW3TlQlK8ee1XgZZMQO71CPI5GZQqN
 cycifpi4=
X-Gm-Gg: ASbGncsaL5/otsmkVtz+FPwJcYLS7qkmuDtis+/Zu9oCXjhW7iZNzH3qObQGfnm3c8u
 FuBzEYymsScl2Hb0U8cHxywh7KwfFIL0zN0PVx/Ymj6FV3/Z4jBbxR5ZlH25O2C6ZWMAUzRrMVv
 prVWBbc6sbbJOilqX8wehKvA9wFVWtwueyinEfVcE5FZj3PQfvpQtaZN/KFdv2FSOVyQll8KdQ0
 5V/s9L6P3ve0DTDTPg799+i7gzo6dom5ZKOtiToQ/z9rj9fW2htkoDclDhrHwf85ow+kYt72Spc
 piAdD5wqFzbXYRJFy7kHh8/nPfGz1dgyURdN3wqp0uXjfKFXgXocEaYFAGQAXryt+PpOrrVoBfc
 nieJznJyxkZzn/usfQOfM9yKT4UYcDrG+CWsxsj4Zy+WumExfGoXubMCe+x2X4kO/
X-Google-Smtp-Source: AGHT+IFJzDM3zyw+NUJ1/WHJFer2vSGaHHebASq8EASGu9xxG8gfLWKzQKOocs3VKGFUJaLuS1/Izg==
X-Received: by 2002:a05:6a20:42a3:b0:32e:ffbc:9d89 with SMTP id
 adf61e73a8af0-32effbc9e2cmr495775637.39.1760028232285; 
 Thu, 09 Oct 2025 09:43:52 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b678df276b0sm139306a12.23.2025.10.09.09.43.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 09:43:51 -0700 (PDT)
Message-ID: <d2bb74d0-7e4f-45a2-8b94-d1f7a67cc8f9@linaro.org>
Date: Thu, 9 Oct 2025 09:43:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] target/openrisc: Explode MO_TExx -> MO_TE | MO_xx
To: qemu-devel@nongnu.org
References: <20251009081903.13426-1-philmd@linaro.org>
 <20251009081903.13426-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009081903.13426-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 10/9/25 01:18, Philippe Mathieu-Daudé wrote:
> Extract the implicit MO_TE definition in order to replace
> it in the next commit.
> 
> Mechanical change using:
> 
>    $ for n in UW UL UQ UO SW SL SQ; do \
>        sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
>             $(git grep -l MO_TE$n target/openrisc); \
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/openrisc/translate.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Why bother splitting, instead of just changing to MO_BEUL, etc?


r~


