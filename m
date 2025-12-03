Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8CBD15DBC
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 17:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQqbv-0000gl-TO; Wed, 03 Dec 2025 12:25:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQqbt-0000fv-KI
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 12:25:49 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQqbs-0004rZ-1C
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 12:25:49 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47755de027eso153725e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 09:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764782746; x=1765387546; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SJp8qyM4OziX6PQNeQ2wtKZ9FQUPOaAd8RAJ0OhPvtE=;
 b=IY0ujjP1xAvuU8kW1U/zD53Gz9EwZkfwZ8REJQyq7rzO1p8aI/Ie2qmjWPjMeslYzV
 MbZoWH+QUlvYOd4gsN9Jm31RRHwHaRJJQHGT+dEaNSE2RUQE3gYNRS19Or6DI9mfSPKO
 vBQloGQOGk9rHPLbB+kMnAe+u4A+RdXMIz0nttLh8TtuSDErAwefiWzBziED0l1LPjAa
 4K0YHFmDfTGhuerg/5CgXAgOfoIlS/kaouNrr/Thj9dmBXrcgWiIaLIT7JU8bVTFm5CA
 2Iu82UJqgKBqTCiPIv6iaZX9H+qWAdwAteHJItJBdz1XGq+GDA6vM904VlmPoFZaZ7xa
 5cSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764782746; x=1765387546;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SJp8qyM4OziX6PQNeQ2wtKZ9FQUPOaAd8RAJ0OhPvtE=;
 b=jblgTbyJ/NEKwEndWa04ffuh0KgnM8fhdG/0i4KhP6akXx3YR2SvpPKQD1nwF2muSa
 HL5bvWrMT0gw3uwiwnuvt4PUFjHTZvLB+FJVlhiVxPvSksh+3x6H2x0zOVLYRkdgJfq+
 ysl8hHPwT4ORMgeHh7/zbEX9tXvSBBCWUb5b82AEU63tlnkYRI8U+48rAkRylo/f/Tb0
 5Y3f5lcIS3h3w1g5lUXKhHvbKhMYSHGqQE8oY9kh2WLNDmoh5huv0w6iRcFf4+6mIiNM
 zKDYcmDZiJzIDM5GPzLWs++SpRueiN8Hhwqtl9qcnQijLvqAWmyHCmaDsP44ii+kwA7/
 0a3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJIj7Fpy2s9A78Vs++ea1HA8ZdZFR2s/3e7S8pKmr47GOoErcooay56xJGjYklLwNpolbDTOWS8vqZ@nongnu.org
X-Gm-Message-State: AOJu0YyZZMkTWDfdOo0eNvuqgMMW7ZXCvc3tZgTAbnD3106fBaF4vbs8
 AALbOW20h1Gn16gTO0gvbLF9C3yAzmLbNgEgyEmhMEA8vzi06sXi6kYYfCe1QiESABs=
X-Gm-Gg: ASbGncsTmT74dN8clf1yVqMhtpzRKrj5uREdfmTR/VG/Zuh/OPH7X4Jj62gbsuWzMbZ
 a1QlC7IRIPB7IggoOZMazEnYe0vVrCiks2zzSqwpwsi/l3pdz+iMbG+2JgE5gY1Kos56jxsw0rQ
 VnCArb6Pvvu58R09XGhMg8Ot+0XBtmTM0Iv8pRetrEL9wS7RzraMTwCRU5XK8pan7xOcPgN+AM0
 NYcKksaDeaDZ3MfWbrrb3didTAS7DFJ5M+fdROgR2Za4CTLfsR+DHopuaiifw9/WENqcMo0HOFx
 7y5PI22MoTOZ9pMOoq/4TWIpW010GSvEvPNzaOCBCALVfteMmUrDiod7kxkOHrnvLQaA6Ze/G99
 y8sGm5bVHNnKrPpQEZBX9pGy0gd/fs6GmVBA9UU1XISmNZAgrwtaNcX+xCXqrGz7EGhoJoTptkp
 WKaHsWgGOARZ/c8ecdpQD0G3EHRHI+TdG4LEwafHCdPmlqRRyZ2IPcbg==
X-Google-Smtp-Source: AGHT+IFj5KxiaXDeXkUAu3AyqutX9TUX5xhGdR906z0pxUCnDANRt7A6mrjGxDiAIyKbSMKGWDFjKQ==
X-Received: by 2002:a05:600c:45ca:b0:46e:4a30:2b0f with SMTP id
 5b1f17b1804b1-4792af486d7mr34815025e9.29.1764782746372; 
 Wed, 03 Dec 2025 09:25:46 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792b152a68sm19693765e9.15.2025.12.03.09.25.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 09:25:45 -0800 (PST)
Message-ID: <f13071b1-5629-4383-b84e-02b9fde4db22@linaro.org>
Date: Wed, 3 Dec 2025 18:25:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] tcg: Remove duplicate test from
 plugin_gen_mem_callbacks
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251203161500.501084-1-richard.henderson@linaro.org>
 <20251203161500.501084-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251203161500.501084-4-richard.henderson@linaro.org>
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

On 3/12/25 17:14, Richard Henderson wrote:
> All callers have already tested tcg_ctx->plugin_insn.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op-ldst.c | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


